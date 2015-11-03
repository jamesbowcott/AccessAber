#import "OSMModel.h"

@interface OSMXMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, readonly) NSURL* filePath;
@property (nonatomic, weak, readonly) OSMModel* model;

- (instancetype)initWithOSMFile:(NSURL*)path forModel:(OSMModel*)model;
- (void)parse;


@end
