/**
 * 根据当前状态（Debug or Release）来控制是否允许NSLog输出到控制台
 * Debug 允许输出
 * Release 拒绝输出
 */

#ifndef examination_MyLog_h
#define examination_MyLog_h

#ifdef DEBUG
#define MyLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define MyLog(format, ...)
#endif

#endif
