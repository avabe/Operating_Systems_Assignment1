struct stat;
struct rtcdate;
struct perf;

// system calls
int fork(void);
void exit(int) __attribute__((noreturn));
int wait(int*);
int detach(int);    ///added detach function
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
void priority(int);
void policy(int);
int wait_stat(int*,struct perf*);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
char* strncpy(char*, const char*, int);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);