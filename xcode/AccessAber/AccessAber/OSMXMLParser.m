//
//  OSMXMLParser.m
//  OSMRenderTest
//
//  Created by James on 12/03/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "OSMXMLParser.h"

@interface OSMXMLParser ()
@property (nonatomic, readonly) NSXMLParser* parser;
@property (nonatomic, readonly) OSMElement* currentElement;
@property (nonatomic, readonly) NSNumberFormatter* numberFormatter;
@end

@implementation OSMXMLParser {
    NSXMLParser* _xmlParser;
    NSNumberFormatter* _numberFormatter;
    // State
    OSMNode* currentNode;
    OSMWay* currentWay;
    OSMRelation* currentRelation;
    NSMutableDictionary* tags;
    NSMutableArray* nodes;
    
    NSMutableDictionary* relationMemberRefs;
}

- (instancetype)initWithOSMFile:(NSURL*)path forModel:(OSMModel*)model {
    if ((self = [self init])) {
        if (!path) {
            NSLog(@"FATAL: OSMXMLParser given a nil path to parse");
            return nil;
        }
        _filePath = path;
        _model = model;
    }
    return self;
}

- (NSXMLParser *)parser {
    if (!_xmlParser) {
        _xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.filePath];
        _xmlParser.delegate = self;
    }
    return _xmlParser;
}

- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return _numberFormatter;
}

- (OSMElement *)currentElement {
    return currentNode ? currentNode :
    currentWay ? currentWay :
    currentRelation ? currentRelation :
    nil;
}

- (void)parse {
    NSDate *startTime = [NSDate date];
    [self.parser parse];
    NSDate *endTime = [NSDate date];
    NSTimeInterval timeTaken = [endTime timeIntervalSinceDate:startTime];
    NSLog(@"OSM Parsing took %f", timeTaken);
}


#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    relationMemberRefs = [NSMutableDictionary dictionary];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [relationMemberRefs enumerateKeysAndObjectsUsingBlock:^(OSMIdentifier *relationId, NSSet *memberIds, BOOL *stop) {
        OSMRelation *relation = self.model.relations[relationId];
        if (relation) {
            for (OSMIdentifier *memberId in memberIds) {
                OSMElement *element = [self.model elementWithId:memberId];
                if (element)
                    [relation addMember:element];
                //else
                    //LogWarning(@"Unresolved member ID %@ for relation ID %@", memberId, relationId);
            }
        }
    }];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // Node
    if ([elementName isEqualToString:@"node"]) {
        currentNode = [[OSMNode alloc] initWithId:[self.numberFormatter numberFromString:attributeDict[@"id"]]];
        currentNode.coordinate = CLLocationCoordinate2DMake([attributeDict[@"lat"] doubleValue], [attributeDict[@"lon"] doubleValue]);
    }
    // Way
    else if ([elementName isEqualToString:@"way"]) {
        currentWay = [[OSMWay alloc] initWithId:[self.numberFormatter numberFromString:attributeDict[@"id"]]];
    }
    // Tag
    else if ([elementName isEqualToString:@"tag"]) {
        if (!tags) tags = [NSMutableDictionary dictionary];
        // If the tag value is "no" dont include it.
        // The app treats missing tag keys as meaning a no
        if ( ! [[attributeDict[@"v"] lowercaseString] isEqualToString:@"no"])
            tags[[attributeDict[@"k"] lowercaseString]] = attributeDict[@"v"];
    }
    // Relation
    else if ([elementName isEqualToString:@"relation"]) {
        currentRelation = [[OSMRelation alloc] initWithId:[self.numberFormatter numberFromString:attributeDict[@"id"]]];
        relationMemberRefs[currentRelation.osmid] = [NSMutableSet set];
    }
    
    // Node reference (ways)
    else if ([elementName isEqualToString:@"nd"]) {
        if (!nodes) nodes = [NSMutableArray array];
        [nodes addObject:self.model.nodes[[self.numberFormatter numberFromString:attributeDict[@"ref"]]]];
    }
    // Member (relations)
    else if ([elementName isEqualToString:@"member"]) {
        if (currentRelation) {
            OSMIdentifier* ref = [self.numberFormatter numberFromString:attributeDict[@"ref"]];
            [relationMemberRefs[currentRelation.osmid] addObject:ref];
//            OSMElement* memberElement = [self.model elementWithId:ref];
//            if (memberElement)
//                [currentRelation addMember:memberElement];
//            //else
//            //    NSLog(@"Element %@ not found for relation %@", ref, currentRelation.osmid);
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // Add any tags to OSMElement
    if ([elementName isEqualToString:@"node"] ||
        [elementName isEqualToString:@"way"] ||
        [elementName isEqualToString:@"relation"]) {
        if (tags) {
            self.currentElement.tags = tags;
            tags = nil;
        }
    }
    // OSMNode
    if ([elementName isEqualToString:@"node"]) {
        [self.model addNode:currentNode];
        currentNode = nil;
    }
    // OSMWay
    else if ([elementName isEqualToString:@"way"]) {
        if (nodes) {
            [currentWay setNodes:nodes];
            nodes = nil;
        }
        [self.model addWay:currentWay];
        currentWay = nil;
    }
    // OSMRelation
    else if ([elementName isEqualToString:@"relation"]) {
        [self.model addRelation:currentRelation];
        currentRelation = nil;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(parseError);
}


@end
