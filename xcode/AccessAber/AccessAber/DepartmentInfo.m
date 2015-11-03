#import "DepartmentInfo.h"
#import "MultilingualString.h"

@interface DepartmentInfo ()

// Private interface goes here.

@end

MultilingualString *urlRoot;

@implementation DepartmentInfo {
    NSDictionary* propertyNameStrings;
}



- (Static *)parent {
    return self.department;
}

- (NSString *)nameForPropertyNamed:(NSString *)propertyName {
    if (!propertyNameStrings)
        propertyNameStrings = @{@"url":@"Website", @"phone":@"Phone", @"email":@"Email"};
    
    if (propertyNameStrings[propertyName])
        return propertyNameStrings[propertyName];
    else
        return propertyName;
}

//- (NSString*)url {
//    if (!urlRoot)
//        urlRoot = [MultilingualString stringWithDictionary:@{@"base":@"http://www.aber.ac.uk/en/", @"cy":@"http://www.aber.ac.uk/cy/"}];
//    
//    return [[NSURL URLWithString:[self primitiveUrl] relativeToURL:[NSURL URLWithString:urlRoot]] absoluteString];
//}

@end
