//
//  Model.m
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "Model.h"

#import <CoreData/CoreData.h>

@implementation Model

+ (NSManagedObject*)createManagedObjectForEntity:(NSEntityDescription*)entity
                                  fromDictionary:(NSDictionary*)dict
                                         withKey:(NSString*)key
                              relationReferences:(NSMutableDictionary*)relationReferences
                                       inContext:(NSManagedObjectContext*)context
{
    NSManagedObject* object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    NSString *objectID = [[[object objectID] URIRepresentation] absoluteString];
    
    [entity.propertiesByName enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, id property, BOOL *stop) {
        NSString *err;
        // Attribute
        if ([property isKindOfClass:[NSAttributeDescription class]]) {
            NSAttributeDescription *attribute = property;
            if ([attribute.name isEqualToString:@"key"] && key) {
                [object setValue:key forKey:@"key"];
            } else if (dict[attribute.name]) {
                [object setValue:dict[attribute.name] forKey:attribute.name];
            } else if (!attribute.isOptional) {
                err = @"Required attribute is missing from dictionary";
            }
        }
        // Relationship
        else if ([property isKindOfClass:[NSRelationshipDescription class]]) {
            NSRelationshipDescription *relationship = property;
            
            if (!dict[relationship.name] && !relationship.isOptional) {
                err = @"Missing required relationship";
            } else if (dict[relationship.name]) {
                // To-many
                if (relationship.isToMany) {
                    NSMutableSet *relations;
                    if (relationship.isOrdered)
                        relations = (NSMutableSet*)[object mutableOrderedSetValueForKey:relationship.name];
                    else
                        relations = [object mutableSetValueForKey:relationship.name];
                    
                    NSArray *createdRelations = [Model createManagedObjectsForEntity:relationship.destinationEntity
                                                                      fromCollection:dict[relationship.name]
                                                                  relationReferences:relationReferences
                                                                           inContext:context];

                    [createdRelations enumerateObjectsUsingBlock:^(id relation, NSUInteger idx, BOOL *stop) {
                        // Reference
                        if ([relation isKindOfClass:[NSString class]]) {
                            if (!relationReferences[objectID])
                                relationReferences[objectID] = [NSMutableDictionary dictionary];
                            if (!relationReferences[objectID][relationship.name])
                                relationReferences[objectID][relationship.name] = [NSMutableArray arrayWithObject:relation];
                            else
                                [relationReferences[objectID][relationship.name] addObject:relation];
                        }
                        // Object
                        else if ([relation isKindOfClass:[NSManagedObject class]]) {
                            [relations addObject:relation];
                        } else {
                            LogWarning(@"Got something which isnt a key reference or managed object");
                        }
                    }];
                }
                // To-One
                else {
                    // Reference
                    if ([dict[relationship.name] isKindOfClass:[NSString class]]) {
                        if (!relationReferences[objectID])
                            relationReferences[objectID] = [NSMutableDictionary dictionary];
                        relationReferences[objectID][relationship.name] = dict[relationship.name];
                    }
                    // Object dictionary
                    else if ([dict[relationship.name] isKindOfClass:[NSDictionary class]]) {
                        NSManagedObject *relatedObject = [Model createManagedObjectForEntity:relationship.destinationEntity fromDictionary:dict[relationship.name] withKey:nil relationReferences:relationReferences inContext:context];
                        [object setValue:relatedObject forKey:relationship.name];
                    }
                }
            }
            
        }
        // Not implemented
        else {
            
        }
        
        //if (err) LogWarning(@"(Property=%@) %@", propertyName, err);
    }];
    
    return object;
}

+ (NSArray*)createManagedObjectsForEntity:(NSEntityDescription*)entity
                           fromCollection:(id)collection
                       relationReferences:(NSMutableDictionary*)relationReferences
                                inContext:(NSManagedObjectContext*)context
{
    NSMutableArray *createdObjects = [NSMutableArray array];
    // Array
    if ([collection isKindOfClass:[NSArray class]]) {
        [(NSArray*)collection enumerateObjectsUsingBlock:^(id element, NSUInteger idx, BOOL *stop) {
            NSString *err;
            // Object dict
            if ([element isKindOfClass:[NSDictionary class]]) {
                NSManagedObject* object = [Model createManagedObjectForEntity:entity
                                                               fromDictionary:element
                                                                      withKey:nil
                                                           relationReferences:relationReferences
                                                                    inContext:context];
                if (object)
                    [createdObjects addObject:object];
                else
                    err = @"Failed to create object";
            }
            // Reference
            else if ([element isKindOfClass:[NSString class]]) {
                [createdObjects addObject:element];
            }
            if (err) LogWarning(@"(Index %d) %@", idx, err);
        }];
    }
    // Dictionary
    else if ([collection isKindOfClass:[NSDictionary class]]) {
        [(NSDictionary*)collection enumerateKeysAndObjectsUsingBlock:^(NSString* key, id element, BOOL *stop) {
            NSString *err;
            if ([element isKindOfClass:[NSDictionary class]]) {
                NSManagedObject* object = [Model createManagedObjectForEntity:entity
                                                               fromDictionary:element
                                                                      withKey:key
                                                           relationReferences:relationReferences
                                                                    inContext:context];
                [createdObjects addObject:object];
            } else if ([element isKindOfClass:[NSString class]]) {
                [createdObjects addObject:key];
            } else {
                err = @"Value is not a dictionary or string";
            }
            if (err) LogWarning(@"(Key %@) %@", key, err);
        }];
    } else {
        LogWarning(@"Collection object is not an array or dictionary");
    }
    return createdObjects;
}

+ (NSMutableArray*)createManagedObjectsFromRootDictionary:(NSDictionary*)rootDict inContext:(NSManagedObjectContext*)context {
    NSMutableArray *createdObjects = [NSMutableArray array];
    NSMutableDictionary *relationshipReferences = [NSMutableDictionary dictionary];
    
    for (NSString* entityName in rootDict) {
        NSString *err;
        NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
        if (!entity) {
            err = @"Entity name does not exist";
        } else {
            [createdObjects addObjectsFromArray: [Model createManagedObjectsForEntity:entity
                                  fromCollection:rootDict[entityName]
                              relationReferences:relationshipReferences
                                       inContext:context]];
        }
        
        if (err)
            LogWarning(@"(entityName=%@) %@", entityName, err);
    }
    
    // Resolve referenced related objects
    [relationshipReferences enumerateKeysAndObjectsUsingBlock:^(NSString* sourceObjectID, NSDictionary* relationships, BOOL *stop) {
        NSString *err;
        NSManagedObject *sourceObject = [context objectWithID:[context.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:sourceObjectID]]];
        if (!sourceObjectID) {
            err = [NSString stringWithFormat:@"Could not retrieve source object with URI %@", sourceObjectID];
        } else {
            [relationships enumerateKeysAndObjectsUsingBlock:^(NSString* relationshipName, id obj, BOOL *stop) {
                NSRelationshipDescription *relationship = sourceObject.entity.relationshipsByName[relationshipName];
                // To-many
                if (relationship.isToMany && [obj isKindOfClass:[NSArray class]]) {
                    NSMutableSet* relations;
                    if (relationship.isOrdered)
                        relations = (NSMutableSet*)[sourceObject mutableOrderedSetValueForKey:relationshipName];
                    else
                        relations = [sourceObject mutableSetValueForKey:relationshipName];
                    
                    [(NSArray*)obj enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
                        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:relationship.destinationEntity.name];
                        request.predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
                        NSArray* results = [context executeFetchRequest:request error:nil];
                        if (results.count == 1) {
                            [relations addObject:results[0]];
                        }
                    }];
                }
                // To-one
                else if (!relationship.isToMany && [obj isKindOfClass:[NSString class]]) {
                    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:relationship.destinationEntity.name];
                    request.predicate = [NSPredicate predicateWithFormat:@"key == %@", obj];
                    NSArray* results = [context executeFetchRequest:request error:nil];
                    if (results.count == 1)
                        [sourceObject setValue:results[0] forKey:relationshipName];
                }
                else {
                    LogWarning(@"Relationship cardinality / dictionary value format mismatch");
                }
            }];
        }
    }];
    

    
    return createdObjects;
}

@end
