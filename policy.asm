
_policy:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"


int
main(int argc, char *argv[]){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp

    if(argc < 2 || argc>3 ) {
   a:	8b 45 08             	mov    0x8(%ebp),%eax
   d:	83 e8 02             	sub    $0x2,%eax
  10:	83 f8 01             	cmp    $0x1,%eax
  13:	76 20                	jbe    35 <main+0x35>
        printf(2, "Illegal argument number!\n");
  15:	c7 44 24 04 08 08 00 	movl   $0x808,0x4(%esp)
  1c:	00 
  1d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  24:	e8 67 04 00 00       	call   490 <printf>
        exit(-1);
  29:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  30:	e8 f3 02 00 00       	call   328 <exit>
    }

    char *ar = argv[1];
  35:	8b 45 0c             	mov    0xc(%ebp),%eax
  38:	8b 58 04             	mov    0x4(%eax),%ebx

    if(strcmp(ar, "1") == 0){
  3b:	c7 44 24 04 22 08 00 	movl   $0x822,0x4(%esp)
  42:	00 
  43:	89 1c 24             	mov    %ebx,(%esp)
  46:	e8 d5 00 00 00       	call   120 <strcmp>
  4b:	85 c0                	test   %eax,%eax
  4d:	74 2c                	je     7b <main+0x7b>
        policy(1);
    } else if(strcmp(ar, "2") == 0){
  4f:	c7 44 24 04 24 08 00 	movl   $0x824,0x4(%esp)
  56:	00 
  57:	89 1c 24             	mov    %ebx,(%esp)
  5a:	e8 c1 00 00 00       	call   120 <strcmp>
  5f:	85 c0                	test   %eax,%eax
  61:	75 26                	jne    89 <main+0x89>
        policy(2);
  63:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6a:	e8 69 03 00 00       	call   3d8 <policy>
        printf(2, "Illegal policy number\n");
        exit(-1);
    }


    exit(0);
  6f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  76:	e8 ad 02 00 00       	call   328 <exit>
        policy(1);
  7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  82:	e8 51 03 00 00       	call   3d8 <policy>
  87:	eb e6                	jmp    6f <main+0x6f>
    } else if(strcmp(ar, "3") == 0){
  89:	c7 44 24 04 26 08 00 	movl   $0x826,0x4(%esp)
  90:	00 
  91:	89 1c 24             	mov    %ebx,(%esp)
  94:	e8 87 00 00 00       	call   120 <strcmp>
  99:	85 c0                	test   %eax,%eax
  9b:	75 0e                	jne    ab <main+0xab>
        policy(3);
  9d:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  a4:	e8 2f 03 00 00       	call   3d8 <policy>
  a9:	eb c4                	jmp    6f <main+0x6f>
        printf(2, "Illegal policy number\n");
  ab:	c7 44 24 04 28 08 00 	movl   $0x828,0x4(%esp)
  b2:	00 
  b3:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  ba:	e8 d1 03 00 00       	call   490 <printf>
        exit(-1);
  bf:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  c6:	e8 5d 02 00 00       	call   328 <exit>
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  d9:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
  da:	89 c2                	mov    %eax,%edx
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e0:	41                   	inc    %ecx
  e1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  e5:	42                   	inc    %edx
  e6:	84 db                	test   %bl,%bl
  e8:	88 5a ff             	mov    %bl,-0x1(%edx)
  eb:	75 f3                	jne    e0 <strcpy+0x10>
    return os;
}
  ed:	5b                   	pop    %ebx
  ee:	5d                   	pop    %ebp
  ef:	c3                   	ret    

000000f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  f0:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
  f1:	31 d2                	xor    %edx,%edx
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	56                   	push   %esi
  f6:	8b 45 08             	mov    0x8(%ebp),%eax
  f9:	53                   	push   %ebx
  fa:	8b 75 0c             	mov    0xc(%ebp),%esi
  fd:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
 100:	eb 12                	jmp    114 <strncpy+0x24>
 102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 108:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 10c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 10f:	42                   	inc    %edx
 110:	84 c9                	test   %cl,%cl
 112:	74 08                	je     11c <strncpy+0x2c>
 114:	89 d9                	mov    %ebx,%ecx
 116:	29 d1                	sub    %edx,%ecx
 118:	85 c9                	test   %ecx,%ecx
 11a:	7f ec                	jg     108 <strncpy+0x18>
    return os;
}
 11c:	5b                   	pop    %ebx
 11d:	5e                   	pop    %esi
 11e:	5d                   	pop    %ebp
 11f:	c3                   	ret    

00000120 <strcmp>:

int
strcmp(const char *p, const char *q) {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
 126:	53                   	push   %ebx
 127:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
 12a:	0f b6 01             	movzbl (%ecx),%eax
 12d:	0f b6 13             	movzbl (%ebx),%edx
 130:	84 c0                	test   %al,%al
 132:	75 18                	jne    14c <strcmp+0x2c>
 134:	eb 22                	jmp    158 <strcmp+0x38>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
 140:	41                   	inc    %ecx
    while (*p && *p == *q)
 141:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
 144:	43                   	inc    %ebx
 145:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
 148:	84 c0                	test   %al,%al
 14a:	74 0c                	je     158 <strcmp+0x38>
 14c:	38 d0                	cmp    %dl,%al
 14e:	74 f0                	je     140 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
 150:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
 151:	29 d0                	sub    %edx,%eax
}
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi
 158:	5b                   	pop    %ebx
 159:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
 15b:	29 d0                	sub    %edx,%eax
}
 15d:	5d                   	pop    %ebp
 15e:	c3                   	ret    
 15f:	90                   	nop

00000160 <strlen>:

uint
strlen(const char *s) {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 166:	80 39 00             	cmpb   $0x0,(%ecx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 d2                	xor    %edx,%edx
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	42                   	inc    %edx
 171:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 175:	89 d0                	mov    %edx,%eax
 177:	75 f7                	jne    170 <strlen+0x10>
    return n;
}
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 180:	31 c0                	xor    %eax,%eax
}
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 18a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000190 <memset>:

void *
memset(void *dst, int c, uint n) {
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 55 08             	mov    0x8(%ebp),%edx
 196:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 197:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld    
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 1a2:	5f                   	pop    %edi
 1a3:	89 d0                	mov    %edx,%eax
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <strchr>:

char *
strchr(const char *s, char c) {
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	74 1b                	je     1dc <strchr+0x2c>
        if (*s == c)
 1c1:	38 d1                	cmp    %dl,%cl
 1c3:	75 0f                	jne    1d4 <strchr+0x24>
 1c5:	eb 17                	jmp    1de <strchr+0x2e>
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1d0:	38 ca                	cmp    %cl,%dl
 1d2:	74 0a                	je     1de <strchr+0x2e>
    for (; *s; s++)
 1d4:	40                   	inc    %eax
 1d5:	0f b6 10             	movzbl (%eax),%edx
 1d8:	84 d2                	test   %dl,%dl
 1da:	75 f4                	jne    1d0 <strchr+0x20>
            return (char *) s;
    return 0;
 1dc:	31 c0                	xor    %eax,%eax
}
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <gets>:

char *
gets(char *buf, int max) {
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 1e5:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 1e7:	53                   	push   %ebx
 1e8:	83 ec 3c             	sub    $0x3c,%esp
 1eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 1ee:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 1f1:	eb 32                	jmp    225 <gets+0x45>
 1f3:	90                   	nop
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 1f8:	ba 01 00 00 00       	mov    $0x1,%edx
 1fd:	89 54 24 08          	mov    %edx,0x8(%esp)
 201:	89 7c 24 04          	mov    %edi,0x4(%esp)
 205:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 20c:	e8 2f 01 00 00       	call   340 <read>
        if (cc < 1)
 211:	85 c0                	test   %eax,%eax
 213:	7e 19                	jle    22e <gets+0x4e>
            break;
        buf[i++] = c;
 215:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 219:	43                   	inc    %ebx
 21a:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 21d:	3c 0a                	cmp    $0xa,%al
 21f:	74 1f                	je     240 <gets+0x60>
 221:	3c 0d                	cmp    $0xd,%al
 223:	74 1b                	je     240 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 225:	46                   	inc    %esi
 226:	3b 75 0c             	cmp    0xc(%ebp),%esi
 229:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 22c:	7c ca                	jl     1f8 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 22e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 231:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	83 c4 3c             	add    $0x3c,%esp
 23a:	5b                   	pop    %ebx
 23b:	5e                   	pop    %esi
 23c:	5f                   	pop    %edi
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    
 23f:	90                   	nop
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	01 c6                	add    %eax,%esi
 245:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 248:	eb e4                	jmp    22e <gets+0x4e>
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <stat>:

int
stat(const char *n, struct stat *st) {
 250:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 251:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 253:	89 e5                	mov    %esp,%ebp
 255:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 258:	89 44 24 04          	mov    %eax,0x4(%esp)
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 25f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 262:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 265:	89 04 24             	mov    %eax,(%esp)
 268:	e8 fb 00 00 00       	call   368 <open>
    if (fd < 0)
 26d:	85 c0                	test   %eax,%eax
 26f:	78 2f                	js     2a0 <stat+0x50>
 271:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 273:	8b 45 0c             	mov    0xc(%ebp),%eax
 276:	89 1c 24             	mov    %ebx,(%esp)
 279:	89 44 24 04          	mov    %eax,0x4(%esp)
 27d:	e8 fe 00 00 00       	call   380 <fstat>
    close(fd);
 282:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 285:	89 c6                	mov    %eax,%esi
    close(fd);
 287:	e8 c4 00 00 00       	call   350 <close>
    return r;
}
 28c:	89 f0                	mov    %esi,%eax
 28e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 291:	8b 75 fc             	mov    -0x4(%ebp),%esi
 294:	89 ec                	mov    %ebp,%esp
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2a5:	eb e5                	jmp    28c <stat+0x3c>
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <atoi>:

int
atoi(const char *s) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b6:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 2b7:	0f be 11             	movsbl (%ecx),%edx
 2ba:	88 d0                	mov    %dl,%al
 2bc:	2c 30                	sub    $0x30,%al
 2be:	3c 09                	cmp    $0x9,%al
    n = 0;
 2c0:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 2c5:	77 1e                	ja     2e5 <atoi+0x35>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 2d0:	41                   	inc    %ecx
 2d1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2d4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 2d8:	0f be 11             	movsbl (%ecx),%edx
 2db:	88 d3                	mov    %dl,%bl
 2dd:	80 eb 30             	sub    $0x30,%bl
 2e0:	80 fb 09             	cmp    $0x9,%bl
 2e3:	76 eb                	jbe    2d0 <atoi+0x20>
    return n;
}
 2e5:	5b                   	pop    %ebx
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	53                   	push   %ebx
 2f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2fb:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 2fe:	85 db                	test   %ebx,%ebx
 300:	7e 1a                	jle    31c <memmove+0x2c>
 302:	31 d2                	xor    %edx,%edx
 304:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 30a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 310:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 314:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 317:	42                   	inc    %edx
    while (n-- > 0)
 318:	39 d3                	cmp    %edx,%ebx
 31a:	75 f4                	jne    310 <memmove+0x20>
    return vdst;
}
 31c:	5b                   	pop    %ebx
 31d:	5e                   	pop    %esi
 31e:	5d                   	pop    %ebp
 31f:	c3                   	ret    

00000320 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 320:	b8 01 00 00 00       	mov    $0x1,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <exit>:
SYSCALL(exit)
 328:	b8 02 00 00 00       	mov    $0x2,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <wait>:
SYSCALL(wait)
 330:	b8 03 00 00 00       	mov    $0x3,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <pipe>:
SYSCALL(pipe)
 338:	b8 04 00 00 00       	mov    $0x4,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <read>:
SYSCALL(read)
 340:	b8 05 00 00 00       	mov    $0x5,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <write>:
SYSCALL(write)
 348:	b8 10 00 00 00       	mov    $0x10,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <close>:
SYSCALL(close)
 350:	b8 15 00 00 00       	mov    $0x15,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <kill>:
SYSCALL(kill)
 358:	b8 06 00 00 00       	mov    $0x6,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <exec>:
SYSCALL(exec)
 360:	b8 07 00 00 00       	mov    $0x7,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <open>:
SYSCALL(open)
 368:	b8 0f 00 00 00       	mov    $0xf,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <mknod>:
SYSCALL(mknod)
 370:	b8 11 00 00 00       	mov    $0x11,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <unlink>:
SYSCALL(unlink)
 378:	b8 12 00 00 00       	mov    $0x12,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <fstat>:
SYSCALL(fstat)
 380:	b8 08 00 00 00       	mov    $0x8,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <link>:
SYSCALL(link)
 388:	b8 13 00 00 00       	mov    $0x13,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <mkdir>:
SYSCALL(mkdir)
 390:	b8 14 00 00 00       	mov    $0x14,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <chdir>:
SYSCALL(chdir)
 398:	b8 09 00 00 00       	mov    $0x9,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <dup>:
SYSCALL(dup)
 3a0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <getpid>:
SYSCALL(getpid)
 3a8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <sbrk>:
SYSCALL(sbrk)
 3b0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <sleep>:
SYSCALL(sleep)
 3b8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <uptime>:
SYSCALL(uptime)
 3c0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <detach>:
SYSCALL(detach)
 3c8:	b8 16 00 00 00       	mov    $0x16,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <priority>:
SYSCALL(priority)
 3d0:	b8 17 00 00 00       	mov    $0x17,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <policy>:
SYSCALL(policy)
 3d8:	b8 18 00 00 00       	mov    $0x18,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <wait_stat>:
SYSCALL(wait_stat)
 3e0:	b8 19 00 00 00       	mov    $0x19,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    
 3e8:	66 90                	xchg   %ax,%ax
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f6:	89 d3                	mov    %edx,%ebx
 3f8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 3fb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 3fe:	84 db                	test   %bl,%bl
{
 400:	89 45 c0             	mov    %eax,-0x40(%ebp)
 403:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 405:	74 79                	je     480 <printint+0x90>
 407:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 40b:	74 73                	je     480 <printint+0x90>
    neg = 1;
    x = -xx;
 40d:	f7 d8                	neg    %eax
    neg = 1;
 40f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 416:	31 f6                	xor    %esi,%esi
 418:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 41b:	eb 05                	jmp    422 <printint+0x32>
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 fe                	mov    %edi,%esi
 422:	31 d2                	xor    %edx,%edx
 424:	f7 f1                	div    %ecx
 426:	8d 7e 01             	lea    0x1(%esi),%edi
 429:	0f b6 92 48 08 00 00 	movzbl 0x848(%edx),%edx
  }while((x /= base) != 0);
 430:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 432:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 435:	75 e9                	jne    420 <printint+0x30>
  if(neg)
 437:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 43a:	85 d2                	test   %edx,%edx
 43c:	74 08                	je     446 <printint+0x56>
    buf[i++] = '-';
 43e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 443:	8d 7e 02             	lea    0x2(%esi),%edi
 446:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 44a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 44d:	8d 76 00             	lea    0x0(%esi),%esi
 450:	0f b6 06             	movzbl (%esi),%eax
 453:	4e                   	dec    %esi
  write(fd, &c, 1);
 454:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 458:	89 3c 24             	mov    %edi,(%esp)
 45b:	88 45 d7             	mov    %al,-0x29(%ebp)
 45e:	b8 01 00 00 00       	mov    $0x1,%eax
 463:	89 44 24 08          	mov    %eax,0x8(%esp)
 467:	e8 dc fe ff ff       	call   348 <write>

  while(--i >= 0)
 46c:	39 de                	cmp    %ebx,%esi
 46e:	75 e0                	jne    450 <printint+0x60>
    putc(fd, buf[i]);
}
 470:	83 c4 4c             	add    $0x4c,%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 480:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 487:	eb 8d                	jmp    416 <printint+0x26>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 75 0c             	mov    0xc(%ebp),%esi
 49c:	0f b6 1e             	movzbl (%esi),%ebx
 49f:	84 db                	test   %bl,%bl
 4a1:	0f 84 d1 00 00 00    	je     578 <printf+0xe8>
  state = 0;
 4a7:	31 ff                	xor    %edi,%edi
 4a9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 4aa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 4ad:	89 fa                	mov    %edi,%edx
 4af:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 4b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b5:	eb 41                	jmp    4f8 <printf+0x68>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 4c6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4cb:	74 1e                	je     4eb <printf+0x5b>
  write(fd, &c, 1);
 4cd:	b8 01 00 00 00       	mov    $0x1,%eax
 4d2:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	89 3c 24             	mov    %edi,(%esp)
 4e0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4e3:	e8 60 fe ff ff       	call   348 <write>
 4e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4eb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 4ec:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4f0:	84 db                	test   %bl,%bl
 4f2:	0f 84 80 00 00 00    	je     578 <printf+0xe8>
    if(state == 0){
 4f8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 4fa:	0f be cb             	movsbl %bl,%ecx
 4fd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 500:	74 be                	je     4c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 502:	83 fa 25             	cmp    $0x25,%edx
 505:	75 e4                	jne    4eb <printf+0x5b>
      if(c == 'd'){
 507:	83 f8 64             	cmp    $0x64,%eax
 50a:	0f 84 f0 00 00 00    	je     600 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 510:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 516:	83 f9 70             	cmp    $0x70,%ecx
 519:	74 65                	je     580 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 51b:	83 f8 73             	cmp    $0x73,%eax
 51e:	0f 84 8c 00 00 00    	je     5b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 524:	83 f8 63             	cmp    $0x63,%eax
 527:	0f 84 13 01 00 00    	je     640 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 52d:	83 f8 25             	cmp    $0x25,%eax
 530:	0f 84 e2 00 00 00    	je     618 <printf+0x188>
  write(fd, &c, 1);
 536:	b8 01 00 00 00       	mov    $0x1,%eax
 53b:	46                   	inc    %esi
 53c:	89 44 24 08          	mov    %eax,0x8(%esp)
 540:	8d 45 e7             	lea    -0x19(%ebp),%eax
 543:	89 44 24 04          	mov    %eax,0x4(%esp)
 547:	89 3c 24             	mov    %edi,(%esp)
 54a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 54e:	e8 f5 fd ff ff       	call   348 <write>
 553:	ba 01 00 00 00       	mov    $0x1,%edx
 558:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 55b:	89 54 24 08          	mov    %edx,0x8(%esp)
 55f:	89 44 24 04          	mov    %eax,0x4(%esp)
 563:	89 3c 24             	mov    %edi,(%esp)
 566:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 569:	e8 da fd ff ff       	call   348 <write>
  for(i = 0; fmt[i]; i++){
 56e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 572:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 574:	84 db                	test   %bl,%bl
 576:	75 80                	jne    4f8 <printf+0x68>
    }
  }
}
 578:	83 c4 3c             	add    $0x3c,%esp
 57b:	5b                   	pop    %ebx
 57c:	5e                   	pop    %esi
 57d:	5f                   	pop    %edi
 57e:	5d                   	pop    %ebp
 57f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 580:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 587:	b9 10 00 00 00       	mov    $0x10,%ecx
 58c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 58f:	89 f8                	mov    %edi,%eax
 591:	8b 13                	mov    (%ebx),%edx
 593:	e8 58 fe ff ff       	call   3f0 <printint>
        ap++;
 598:	89 d8                	mov    %ebx,%eax
      state = 0;
 59a:	31 d2                	xor    %edx,%edx
        ap++;
 59c:	83 c0 04             	add    $0x4,%eax
 59f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a2:	e9 44 ff ff ff       	jmp    4eb <printf+0x5b>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 10                	mov    (%eax),%edx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 d2                	test   %edx,%edx
 5bd:	0f 84 aa 00 00 00    	je     66d <printf+0x1dd>
        while(*s != 0){
 5c3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 5c6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 5c8:	84 c0                	test   %al,%al
 5ca:	74 27                	je     5f3 <printf+0x163>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5d8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5d9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5dd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e4:	89 3c 24             	mov    %edi,(%esp)
 5e7:	e8 5c fd ff ff       	call   348 <write>
        while(*s != 0){
 5ec:	0f b6 03             	movzbl (%ebx),%eax
 5ef:	84 c0                	test   %al,%al
 5f1:	75 dd                	jne    5d0 <printf+0x140>
      state = 0;
 5f3:	31 d2                	xor    %edx,%edx
 5f5:	e9 f1 fe ff ff       	jmp    4eb <printf+0x5b>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 607:	b9 0a 00 00 00       	mov    $0xa,%ecx
 60c:	e9 7b ff ff ff       	jmp    58c <printf+0xfc>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 618:	b9 01 00 00 00       	mov    $0x1,%ecx
 61d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 620:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	89 3c 24             	mov    %edi,(%esp)
 62b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 62e:	e8 15 fd ff ff       	call   348 <write>
      state = 0;
 633:	31 d2                	xor    %edx,%edx
 635:	e9 b1 fe ff ff       	jmp    4eb <printf+0x5b>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 643:	8b 03                	mov    (%ebx),%eax
        ap++;
 645:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 648:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 64b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 64e:	b8 01 00 00 00       	mov    $0x1,%eax
 653:	89 44 24 08          	mov    %eax,0x8(%esp)
 657:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 65a:	89 44 24 04          	mov    %eax,0x4(%esp)
 65e:	e8 e5 fc ff ff       	call   348 <write>
      state = 0;
 663:	31 d2                	xor    %edx,%edx
        ap++;
 665:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 668:	e9 7e fe ff ff       	jmp    4eb <printf+0x5b>
          s = "(null)";
 66d:	bb 3f 08 00 00       	mov    $0x83f,%ebx
        while(*s != 0){
 672:	b0 28                	mov    $0x28,%al
 674:	e9 57 ff ff ff       	jmp    5d0 <printf+0x140>
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 fc 0a 00 00       	mov    0xafc,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 691:	eb 0d                	jmp    6a0 <free+0x20>
 693:	90                   	nop
 694:	90                   	nop
 695:	90                   	nop
 696:	90                   	nop
 697:	90                   	nop
 698:	90                   	nop
 699:	90                   	nop
 69a:	90                   	nop
 69b:	90                   	nop
 69c:	90                   	nop
 69d:	90                   	nop
 69e:	90                   	nop
 69f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a0:	39 c8                	cmp    %ecx,%eax
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	73 32                	jae    6d8 <free+0x58>
 6a6:	39 d1                	cmp    %edx,%ecx
 6a8:	72 04                	jb     6ae <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6aa:	39 d0                	cmp    %edx,%eax
 6ac:	72 32                	jb     6e0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6b4:	39 fa                	cmp    %edi,%edx
 6b6:	74 30                	je     6e8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bb:	8b 50 04             	mov    0x4(%eax),%edx
 6be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c1:	39 f1                	cmp    %esi,%ecx
 6c3:	74 3c                	je     701 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6c5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6c7:	5b                   	pop    %ebx
  freep = p;
 6c8:	a3 fc 0a 00 00       	mov    %eax,0xafc
}
 6cd:	5e                   	pop    %esi
 6ce:	5f                   	pop    %edi
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	39 d0                	cmp    %edx,%eax
 6da:	72 04                	jb     6e0 <free+0x60>
 6dc:	39 d1                	cmp    %edx,%ecx
 6de:	72 ce                	jb     6ae <free+0x2e>
{
 6e0:	89 d0                	mov    %edx,%eax
 6e2:	eb bc                	jmp    6a0 <free+0x20>
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e8:	8b 7a 04             	mov    0x4(%edx),%edi
 6eb:	01 fe                	add    %edi,%esi
 6ed:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f0:	8b 10                	mov    (%eax),%edx
 6f2:	8b 12                	mov    (%edx),%edx
 6f4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f7:	8b 50 04             	mov    0x4(%eax),%edx
 6fa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6fd:	39 f1                	cmp    %esi,%ecx
 6ff:	75 c4                	jne    6c5 <free+0x45>
    p->s.size += bp->s.size;
 701:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 704:	a3 fc 0a 00 00       	mov    %eax,0xafc
    p->s.size += bp->s.size;
 709:	01 ca                	add    %ecx,%edx
 70b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 711:	89 10                	mov    %edx,(%eax)
}
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 fc 0a 00 00    	mov    0xafc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	47                   	inc    %edi
  if((prevp = freep) == 0){
 739:	85 d2                	test   %edx,%edx
 73b:	0f 84 8f 00 00 00    	je     7d0 <malloc+0xb0>
 741:	8b 02                	mov    (%edx),%eax
 743:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 746:	39 cf                	cmp    %ecx,%edi
 748:	76 66                	jbe    7b0 <malloc+0x90>
 74a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 750:	bb 00 10 00 00       	mov    $0x1000,%ebx
 755:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 758:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75f:	eb 10                	jmp    771 <malloc+0x51>
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 76a:	8b 48 04             	mov    0x4(%eax),%ecx
 76d:	39 f9                	cmp    %edi,%ecx
 76f:	73 3f                	jae    7b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	39 05 fc 0a 00 00    	cmp    %eax,0xafc
 777:	89 c2                	mov    %eax,%edx
 779:	75 ed                	jne    768 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 77b:	89 34 24             	mov    %esi,(%esp)
 77e:	e8 2d fc ff ff       	call   3b0 <sbrk>
  if(p == (char*)-1)
 783:	83 f8 ff             	cmp    $0xffffffff,%eax
 786:	74 18                	je     7a0 <malloc+0x80>
  hp->s.size = nu;
 788:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 78b:	83 c0 08             	add    $0x8,%eax
 78e:	89 04 24             	mov    %eax,(%esp)
 791:	e8 ea fe ff ff       	call   680 <free>
  return freep;
 796:	8b 15 fc 0a 00 00    	mov    0xafc,%edx
      if((p = morecore(nunits)) == 0)
 79c:	85 d2                	test   %edx,%edx
 79e:	75 c8                	jne    768 <malloc+0x48>
        return 0;
  }
}
 7a0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7a3:	31 c0                	xor    %eax,%eax
}
 7a5:	5b                   	pop    %ebx
 7a6:	5e                   	pop    %esi
 7a7:	5f                   	pop    %edi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret    
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 4c                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7bf:	89 15 fc 0a 00 00    	mov    %edx,0xafc
}
 7c5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
}
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7d0:	b8 00 0b 00 00       	mov    $0xb00,%eax
 7d5:	ba 00 0b 00 00       	mov    $0xb00,%edx
    base.s.size = 0;
 7da:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 7dc:	a3 fc 0a 00 00       	mov    %eax,0xafc
    base.s.size = 0;
 7e1:	b8 00 0b 00 00       	mov    $0xb00,%eax
    base.s.ptr = freep = prevp = &base;
 7e6:	89 15 00 0b 00 00    	mov    %edx,0xb00
    base.s.size = 0;
 7ec:	89 0d 04 0b 00 00    	mov    %ecx,0xb04
 7f2:	e9 53 ff ff ff       	jmp    74a <malloc+0x2a>
 7f7:	89 f6                	mov    %esi,%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b9                	jmp    7bf <malloc+0x9f>
