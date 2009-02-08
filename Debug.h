#ifndef DEBUG_H
#define DEBUG_H

#ifdef __DEBUG__
#    define DLog(...) NSLog(__VA_ARGS__);
#else
#    define DLog(...) /* log disabled */
#endif
#define ALog(...) NSLog(__VA_ARGS__)

#endif
