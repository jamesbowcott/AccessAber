@class OSMRelation;

typedef NSNumber OSMIdentifier;

@interface OSMElement : NSObject

@property (nonatomic, readonly) OSMIdentifier *osmid;
@property (nonatomic) NSMutableDictionary *tags;
@property (nonatomic) NSDictionary *allTags;
@property (nonatomic, readonly) NSSet *parents;

- (instancetype)initWithId:(OSMIdentifier*)osmid;
- (instancetype)initWithId:(OSMIdentifier*)osmid tags:(NSDictionary*)tags;

- (void)addParent:(OSMRelation*)relation;
- (void)removeParent:(OSMRelation*)relation;

@end
