#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define Log(level, fmt, ...)\
        NSLog((@"%s:%d %@: " fmt), __PRETTY_FUNCTION__, __LINE__, level, ##__VA_ARGS__)
#else
#   define Log(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#endif

#define LogFatal(fmt, ...) Log(@"FATAL", fmt, ##__VA_ARGS__)
#define LogWarning(fmt, ...) Log(@"WARNING", fmt, ##__VA_ARGS__)
#define LogError(fmt, ...) Log(@"ERROR", fmt, ##__VA_ARGS__)


#define LogDebug(fmt, ...) Log(@"DEBUG", fmt, ##__VA_ARGS__)