#import "OSMModel.h"

@interface OSMBuilding : NSObject
@property (nonatomic) OSMRelation *relation;
@property (nonatomic) OSMWay *outdoorWay;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) bool hasIndoor;

@property (nonatomic, readonly) NSInteger minLevel;
@property (nonatomic, readonly) NSInteger maxLevel;

- (instancetype)initWithWay:(OSMWay*)way;
- (instancetype)initWithRelation:(OSMRelation*)relation outdoorWay:(OSMWay*)outdoorWay;

- (bool)hasLevel:(NSInteger)level;
- (OSMRelation*)relationForLevel:(NSInteger)level;
- (NSOrderedSet*)indoorWaysForLevel:(NSInteger)level;
- (NSSet*)buildingWaysForLevel:(NSInteger)level;

- (NSString*)nameForLevel:(NSInteger)level;

@end
