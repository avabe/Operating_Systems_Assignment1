#pragma once

typedef unsigned int      uint;
typedef unsigned short  ushort;
typedef unsigned char    uchar;
typedef uint             pde_t;
typedef int            boolean;


#define null 0

#ifndef __cplusplus

#define false 0
#define true 1

#endif

// struct for wait_stat system call
struct perf {
    int ctime;
    int ttime;
    int stime;
    int retime;
    int rutime;
};