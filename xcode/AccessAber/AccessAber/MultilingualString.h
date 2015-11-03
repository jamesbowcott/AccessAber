#import "_MultilingualString.h"

@interface MultilingualString : _MultilingualString {}

@property (nonatomic, readonly) NSString *defaultString;

+ (instancetype)stringWithDictionary:(NSDictionary*)dictionary;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
