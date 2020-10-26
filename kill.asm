
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 45 08             	mov    0x8(%ebp),%eax
   e:	8b 55 0c             	mov    0xc(%ebp),%edx
  int i;

  if(argc < 2){
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	7e 2f                	jle    45 <main+0x45>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 23 02 00 00       	call   250 <atoi>
  2d:	89 04 24             	mov    %eax,(%esp)
  30:	e8 c3 02 00 00       	call   2f8 <kill>
  for(i=1; i<argc; i++)
  35:	39 f3                	cmp    %esi,%ebx
  37:	75 e7                	jne    20 <main+0x20>
  exit(0);
  39:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  40:	e8 83 02 00 00       	call   2c8 <exit>
    printf(2, "usage: kill pid...\n");
  45:	c7 44 24 04 a8 07 00 	movl   $0x7a8,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  54:	e8 d7 03 00 00       	call   430 <printf>
    exit(0);
  59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  60:	e8 63 02 00 00       	call   2c8 <exit>
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  79:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	41                   	inc    %ecx
  81:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  85:	42                   	inc    %edx
  86:	84 db                	test   %bl,%bl
  88:	88 5a ff             	mov    %bl,-0x1(%edx)
  8b:	75 f3                	jne    80 <strcpy+0x10>
    return os;
}
  8d:	5b                   	pop    %ebx
  8e:	5d                   	pop    %ebp
  8f:	c3                   	ret    

00000090 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  90:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
  91:	31 d2                	xor    %edx,%edx
{
  93:	89 e5                	mov    %esp,%ebp
  95:	56                   	push   %esi
  96:	8b 45 08             	mov    0x8(%ebp),%eax
  99:	53                   	push   %ebx
  9a:	8b 75 0c             	mov    0xc(%ebp),%esi
  9d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
  a0:	eb 12                	jmp    b4 <strncpy+0x24>
  a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  af:	42                   	inc    %edx
  b0:	84 c9                	test   %cl,%cl
  b2:	74 08                	je     bc <strncpy+0x2c>
  b4:	89 d9                	mov    %ebx,%ecx
  b6:	29 d1                	sub    %edx,%ecx
  b8:	85 c9                	test   %ecx,%ecx
  ba:	7f ec                	jg     a8 <strncpy+0x18>
    return os;
}
  bc:	5b                   	pop    %ebx
  bd:	5e                   	pop    %esi
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q) {
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c6:	53                   	push   %ebx
  c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
  ca:	0f b6 01             	movzbl (%ecx),%eax
  cd:	0f b6 13             	movzbl (%ebx),%edx
  d0:	84 c0                	test   %al,%al
  d2:	75 18                	jne    ec <strcmp+0x2c>
  d4:	eb 22                	jmp    f8 <strcmp+0x38>
  d6:	8d 76 00             	lea    0x0(%esi),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
  e0:	41                   	inc    %ecx
    while (*p && *p == *q)
  e1:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
  e4:	43                   	inc    %ebx
  e5:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
  e8:	84 c0                	test   %al,%al
  ea:	74 0c                	je     f8 <strcmp+0x38>
  ec:	38 d0                	cmp    %dl,%al
  ee:	74 f0                	je     e0 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
  f0:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
  f1:	29 d0                	sub    %edx,%eax
}
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 76 00             	lea    0x0(%esi),%esi
  f8:	5b                   	pop    %ebx
  f9:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
  fb:	29 d0                	sub    %edx,%eax
}
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <strlen>:

uint
strlen(const char *s) {
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	42                   	inc    %edx
 111:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 115:	89 d0                	mov    %edx,%eax
 117:	75 f7                	jne    110 <strlen+0x10>
    return n;
}
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    
 11b:	90                   	nop
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void *
memset(void *dst, int c, uint n) {
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 142:	5f                   	pop    %edi
 143:	89 d0                	mov    %edx,%eax
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char *
strchr(const char *s, char c) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1b                	je     17c <strchr+0x2c>
        if (*s == c)
 161:	38 d1                	cmp    %dl,%cl
 163:	75 0f                	jne    174 <strchr+0x24>
 165:	eb 17                	jmp    17e <strchr+0x2e>
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0a                	je     17e <strchr+0x2e>
    for (; *s; s++)
 174:	40                   	inc    %eax
 175:	0f b6 10             	movzbl (%eax),%edx
 178:	84 d2                	test   %dl,%dl
 17a:	75 f4                	jne    170 <strchr+0x20>
            return (char *) s;
    return 0;
 17c:	31 c0                	xor    %eax,%eax
}
 17e:	5d                   	pop    %ebp
 17f:	c3                   	ret    

00000180 <gets>:

char *
gets(char *buf, int max) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 185:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 187:	53                   	push   %ebx
 188:	83 ec 3c             	sub    $0x3c,%esp
 18b:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 18e:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 191:	eb 32                	jmp    1c5 <gets+0x45>
 193:	90                   	nop
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 198:	ba 01 00 00 00       	mov    $0x1,%edx
 19d:	89 54 24 08          	mov    %edx,0x8(%esp)
 1a1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ac:	e8 2f 01 00 00       	call   2e0 <read>
        if (cc < 1)
 1b1:	85 c0                	test   %eax,%eax
 1b3:	7e 19                	jle    1ce <gets+0x4e>
            break;
        buf[i++] = c;
 1b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b9:	43                   	inc    %ebx
 1ba:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 1bd:	3c 0a                	cmp    $0xa,%al
 1bf:	74 1f                	je     1e0 <gets+0x60>
 1c1:	3c 0d                	cmp    $0xd,%al
 1c3:	74 1b                	je     1e0 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 1c5:	46                   	inc    %esi
 1c6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1c9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1cc:	7c ca                	jl     198 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 1ce:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1d1:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	83 c4 3c             	add    $0x3c,%esp
 1da:	5b                   	pop    %ebx
 1db:	5e                   	pop    %esi
 1dc:	5f                   	pop    %edi
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    
 1df:	90                   	nop
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	01 c6                	add    %eax,%esi
 1e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1e8:	eb e4                	jmp    1ce <gets+0x4e>
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <stat>:

int
stat(const char *n, struct stat *st) {
 1f0:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 1f1:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 1f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 1ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 202:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 205:	89 04 24             	mov    %eax,(%esp)
 208:	e8 fb 00 00 00       	call   308 <open>
    if (fd < 0)
 20d:	85 c0                	test   %eax,%eax
 20f:	78 2f                	js     240 <stat+0x50>
 211:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	89 1c 24             	mov    %ebx,(%esp)
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	e8 fe 00 00 00       	call   320 <fstat>
    close(fd);
 222:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 225:	89 c6                	mov    %eax,%esi
    close(fd);
 227:	e8 c4 00 00 00       	call   2f0 <close>
    return r;
}
 22c:	89 f0                	mov    %esi,%eax
 22e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 231:	8b 75 fc             	mov    -0x4(%ebp),%esi
 234:	89 ec                	mov    %ebp,%esp
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
 238:	90                   	nop
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb e5                	jmp    22c <stat+0x3c>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <atoi>:

int
atoi(const char *s) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 08             	mov    0x8(%ebp),%ecx
 256:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 257:	0f be 11             	movsbl (%ecx),%edx
 25a:	88 d0                	mov    %dl,%al
 25c:	2c 30                	sub    $0x30,%al
 25e:	3c 09                	cmp    $0x9,%al
    n = 0;
 260:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 265:	77 1e                	ja     285 <atoi+0x35>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 270:	41                   	inc    %ecx
 271:	8d 04 80             	lea    (%eax,%eax,4),%eax
 274:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 278:	0f be 11             	movsbl (%ecx),%edx
 27b:	88 d3                	mov    %dl,%bl
 27d:	80 eb 30             	sub    $0x30,%bl
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
    return n;
}
 285:	5b                   	pop    %ebx
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	53                   	push   %ebx
 298:	8b 5d 10             	mov    0x10(%ebp),%ebx
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 1a                	jle    2bc <memmove+0x2c>
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 2b0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2b7:	42                   	inc    %edx
    while (n-- > 0)
 2b8:	39 d3                	cmp    %edx,%ebx
 2ba:	75 f4                	jne    2b0 <memmove+0x20>
    return vdst;
}
 2bc:	5b                   	pop    %ebx
 2bd:	5e                   	pop    %esi
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret    

000002c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <exit>:
SYSCALL(exit)
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <wait>:
SYSCALL(wait)
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <pipe>:
SYSCALL(pipe)
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <read>:
SYSCALL(read)
 2e0:	b8 05 00 00 00       	mov    $0x5,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <write>:
SYSCALL(write)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <close>:
SYSCALL(close)
 2f0:	b8 15 00 00 00       	mov    $0x15,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <kill>:
SYSCALL(kill)
 2f8:	b8 06 00 00 00       	mov    $0x6,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <exec>:
SYSCALL(exec)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <open>:
SYSCALL(open)
 308:	b8 0f 00 00 00       	mov    $0xf,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mknod>:
SYSCALL(mknod)
 310:	b8 11 00 00 00       	mov    $0x11,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <unlink>:
SYSCALL(unlink)
 318:	b8 12 00 00 00       	mov    $0x12,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <fstat>:
SYSCALL(fstat)
 320:	b8 08 00 00 00       	mov    $0x8,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <link>:
SYSCALL(link)
 328:	b8 13 00 00 00       	mov    $0x13,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mkdir>:
SYSCALL(mkdir)
 330:	b8 14 00 00 00       	mov    $0x14,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <chdir>:
SYSCALL(chdir)
 338:	b8 09 00 00 00       	mov    $0x9,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <dup>:
SYSCALL(dup)
 340:	b8 0a 00 00 00       	mov    $0xa,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <getpid>:
SYSCALL(getpid)
 348:	b8 0b 00 00 00       	mov    $0xb,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sbrk>:
SYSCALL(sbrk)
 350:	b8 0c 00 00 00       	mov    $0xc,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sleep>:
SYSCALL(sleep)
 358:	b8 0d 00 00 00       	mov    $0xd,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <uptime>:
SYSCALL(uptime)
 360:	b8 0e 00 00 00       	mov    $0xe,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <detach>:
SYSCALL(detach)
 368:	b8 16 00 00 00       	mov    $0x16,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <priority>:
SYSCALL(priority)
 370:	b8 17 00 00 00       	mov    $0x17,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <policy>:
SYSCALL(policy)
 378:	b8 18 00 00 00       	mov    $0x18,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <wait_stat>:
SYSCALL(wait_stat)
 380:	b8 19 00 00 00       	mov    $0x19,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    
 388:	66 90                	xchg   %ax,%ax
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 396:	89 d3                	mov    %edx,%ebx
 398:	c1 eb 1f             	shr    $0x1f,%ebx
{
 39b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 39e:	84 db                	test   %bl,%bl
{
 3a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3a3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3a5:	74 79                	je     420 <printint+0x90>
 3a7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3ab:	74 73                	je     420 <printint+0x90>
    neg = 1;
    x = -xx;
 3ad:	f7 d8                	neg    %eax
    neg = 1;
 3af:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3b6:	31 f6                	xor    %esi,%esi
 3b8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3bb:	eb 05                	jmp    3c2 <printint+0x32>
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	89 fe                	mov    %edi,%esi
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	f7 f1                	div    %ecx
 3c6:	8d 7e 01             	lea    0x1(%esi),%edi
 3c9:	0f b6 92 c4 07 00 00 	movzbl 0x7c4(%edx),%edx
  }while((x /= base) != 0);
 3d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3d5:	75 e9                	jne    3c0 <printint+0x30>
  if(neg)
 3d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3da:	85 d2                	test   %edx,%edx
 3dc:	74 08                	je     3e6 <printint+0x56>
    buf[i++] = '-';
 3de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3e3:	8d 7e 02             	lea    0x2(%esi),%edi
 3e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	0f b6 06             	movzbl (%esi),%eax
 3f3:	4e                   	dec    %esi
  write(fd, &c, 1);
 3f4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3f8:	89 3c 24             	mov    %edi,(%esp)
 3fb:	88 45 d7             	mov    %al,-0x29(%ebp)
 3fe:	b8 01 00 00 00       	mov    $0x1,%eax
 403:	89 44 24 08          	mov    %eax,0x8(%esp)
 407:	e8 dc fe ff ff       	call   2e8 <write>

  while(--i >= 0)
 40c:	39 de                	cmp    %ebx,%esi
 40e:	75 e0                	jne    3f0 <printint+0x60>
    putc(fd, buf[i]);
}
 410:	83 c4 4c             	add    $0x4c,%esp
 413:	5b                   	pop    %ebx
 414:	5e                   	pop    %esi
 415:	5f                   	pop    %edi
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
 418:	90                   	nop
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 420:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 427:	eb 8d                	jmp    3b6 <printint+0x26>
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
 43c:	0f b6 1e             	movzbl (%esi),%ebx
 43f:	84 db                	test   %bl,%bl
 441:	0f 84 d1 00 00 00    	je     518 <printf+0xe8>
  state = 0;
 447:	31 ff                	xor    %edi,%edi
 449:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 44a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 44d:	89 fa                	mov    %edi,%edx
 44f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 452:	89 45 d0             	mov    %eax,-0x30(%ebp)
 455:	eb 41                	jmp    498 <printf+0x68>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 460:	83 f8 25             	cmp    $0x25,%eax
 463:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 466:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 46b:	74 1e                	je     48b <printf+0x5b>
  write(fd, &c, 1);
 46d:	b8 01 00 00 00       	mov    $0x1,%eax
 472:	89 44 24 08          	mov    %eax,0x8(%esp)
 476:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 479:	89 44 24 04          	mov    %eax,0x4(%esp)
 47d:	89 3c 24             	mov    %edi,(%esp)
 480:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 483:	e8 60 fe ff ff       	call   2e8 <write>
 488:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 48b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 48c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 490:	84 db                	test   %bl,%bl
 492:	0f 84 80 00 00 00    	je     518 <printf+0xe8>
    if(state == 0){
 498:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 49a:	0f be cb             	movsbl %bl,%ecx
 49d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4a0:	74 be                	je     460 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4a2:	83 fa 25             	cmp    $0x25,%edx
 4a5:	75 e4                	jne    48b <printf+0x5b>
      if(c == 'd'){
 4a7:	83 f8 64             	cmp    $0x64,%eax
 4aa:	0f 84 f0 00 00 00    	je     5a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4b6:	83 f9 70             	cmp    $0x70,%ecx
 4b9:	74 65                	je     520 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4bb:	83 f8 73             	cmp    $0x73,%eax
 4be:	0f 84 8c 00 00 00    	je     550 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c4:	83 f8 63             	cmp    $0x63,%eax
 4c7:	0f 84 13 01 00 00    	je     5e0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4cd:	83 f8 25             	cmp    $0x25,%eax
 4d0:	0f 84 e2 00 00 00    	je     5b8 <printf+0x188>
  write(fd, &c, 1);
 4d6:	b8 01 00 00 00       	mov    $0x1,%eax
 4db:	46                   	inc    %esi
 4dc:	89 44 24 08          	mov    %eax,0x8(%esp)
 4e0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e7:	89 3c 24             	mov    %edi,(%esp)
 4ea:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ee:	e8 f5 fd ff ff       	call   2e8 <write>
 4f3:	ba 01 00 00 00       	mov    $0x1,%edx
 4f8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4fb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 503:	89 3c 24             	mov    %edi,(%esp)
 506:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 509:	e8 da fd ff ff       	call   2e8 <write>
  for(i = 0; fmt[i]; i++){
 50e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 512:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 514:	84 db                	test   %bl,%bl
 516:	75 80                	jne    498 <printf+0x68>
    }
  }
}
 518:	83 c4 3c             	add    $0x3c,%esp
 51b:	5b                   	pop    %ebx
 51c:	5e                   	pop    %esi
 51d:	5f                   	pop    %edi
 51e:	5d                   	pop    %ebp
 51f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 520:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 527:	b9 10 00 00 00       	mov    $0x10,%ecx
 52c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 52f:	89 f8                	mov    %edi,%eax
 531:	8b 13                	mov    (%ebx),%edx
 533:	e8 58 fe ff ff       	call   390 <printint>
        ap++;
 538:	89 d8                	mov    %ebx,%eax
      state = 0;
 53a:	31 d2                	xor    %edx,%edx
        ap++;
 53c:	83 c0 04             	add    $0x4,%eax
 53f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 542:	e9 44 ff ff ff       	jmp    48b <printf+0x5b>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 550:	8b 45 d0             	mov    -0x30(%ebp),%eax
 553:	8b 10                	mov    (%eax),%edx
        ap++;
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 55b:	85 d2                	test   %edx,%edx
 55d:	0f 84 aa 00 00 00    	je     60d <printf+0x1dd>
        while(*s != 0){
 563:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 566:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 568:	84 c0                	test   %al,%al
 56a:	74 27                	je     593 <printf+0x163>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 573:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 578:	43                   	inc    %ebx
  write(fd, &c, 1);
 579:	89 44 24 08          	mov    %eax,0x8(%esp)
 57d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 580:	89 44 24 04          	mov    %eax,0x4(%esp)
 584:	89 3c 24             	mov    %edi,(%esp)
 587:	e8 5c fd ff ff       	call   2e8 <write>
        while(*s != 0){
 58c:	0f b6 03             	movzbl (%ebx),%eax
 58f:	84 c0                	test   %al,%al
 591:	75 dd                	jne    570 <printf+0x140>
      state = 0;
 593:	31 d2                	xor    %edx,%edx
 595:	e9 f1 fe ff ff       	jmp    48b <printf+0x5b>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5ac:	e9 7b ff ff ff       	jmp    52c <printf+0xfc>
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5b8:	b9 01 00 00 00       	mov    $0x1,%ecx
 5bd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5c0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5c4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c8:	89 3c 24             	mov    %edi,(%esp)
 5cb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5ce:	e8 15 fd ff ff       	call   2e8 <write>
      state = 0;
 5d3:	31 d2                	xor    %edx,%edx
 5d5:	e9 b1 fe ff ff       	jmp    48b <printf+0x5b>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5e3:	8b 03                	mov    (%ebx),%eax
        ap++;
 5e5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5e8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 5eb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5ee:	b8 01 00 00 00       	mov    $0x1,%eax
 5f3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5f7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	e8 e5 fc ff ff       	call   2e8 <write>
      state = 0;
 603:	31 d2                	xor    %edx,%edx
        ap++;
 605:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 608:	e9 7e fe ff ff       	jmp    48b <printf+0x5b>
          s = "(null)";
 60d:	bb bc 07 00 00       	mov    $0x7bc,%ebx
        while(*s != 0){
 612:	b0 28                	mov    $0x28,%al
 614:	e9 57 ff ff ff       	jmp    570 <printf+0x140>
 619:	66 90                	xchg   %ax,%ax
 61b:	66 90                	xchg   %ax,%ax
 61d:	66 90                	xchg   %ax,%ax
 61f:	90                   	nop

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 7c 0a 00 00       	mov    0xa7c,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 631:	eb 0d                	jmp    640 <free+0x20>
 633:	90                   	nop
 634:	90                   	nop
 635:	90                   	nop
 636:	90                   	nop
 637:	90                   	nop
 638:	90                   	nop
 639:	90                   	nop
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 640:	39 c8                	cmp    %ecx,%eax
 642:	8b 10                	mov    (%eax),%edx
 644:	73 32                	jae    678 <free+0x58>
 646:	39 d1                	cmp    %edx,%ecx
 648:	72 04                	jb     64e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64a:	39 d0                	cmp    %edx,%eax
 64c:	72 32                	jb     680 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 64e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 651:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 654:	39 fa                	cmp    %edi,%edx
 656:	74 30                	je     688 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 658:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 65b:	8b 50 04             	mov    0x4(%eax),%edx
 65e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 661:	39 f1                	cmp    %esi,%ecx
 663:	74 3c                	je     6a1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 665:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 667:	5b                   	pop    %ebx
  freep = p;
 668:	a3 7c 0a 00 00       	mov    %eax,0xa7c
}
 66d:	5e                   	pop    %esi
 66e:	5f                   	pop    %edi
 66f:	5d                   	pop    %ebp
 670:	c3                   	ret    
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 d0                	cmp    %edx,%eax
 67a:	72 04                	jb     680 <free+0x60>
 67c:	39 d1                	cmp    %edx,%ecx
 67e:	72 ce                	jb     64e <free+0x2e>
{
 680:	89 d0                	mov    %edx,%eax
 682:	eb bc                	jmp    640 <free+0x20>
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 688:	8b 7a 04             	mov    0x4(%edx),%edi
 68b:	01 fe                	add    %edi,%esi
 68d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 690:	8b 10                	mov    (%eax),%edx
 692:	8b 12                	mov    (%edx),%edx
 694:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 697:	8b 50 04             	mov    0x4(%eax),%edx
 69a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69d:	39 f1                	cmp    %esi,%ecx
 69f:	75 c4                	jne    665 <free+0x45>
    p->s.size += bp->s.size;
 6a1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 6a4:	a3 7c 0a 00 00       	mov    %eax,0xa7c
    p->s.size += bp->s.size;
 6a9:	01 ca                	add    %ecx,%edx
 6ab:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ae:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b1:	89 10                	mov    %edx,(%eax)
}
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
 6b8:	90                   	nop
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 7c 0a 00 00    	mov    0xa7c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6d9:	85 d2                	test   %edx,%edx
 6db:	0f 84 8f 00 00 00    	je     770 <malloc+0xb0>
 6e1:	8b 02                	mov    (%edx),%eax
 6e3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e6:	39 cf                	cmp    %ecx,%edi
 6e8:	76 66                	jbe    750 <malloc+0x90>
 6ea:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6f0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6f8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6ff:	eb 10                	jmp    711 <malloc+0x51>
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 708:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 70a:	8b 48 04             	mov    0x4(%eax),%ecx
 70d:	39 f9                	cmp    %edi,%ecx
 70f:	73 3f                	jae    750 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	39 05 7c 0a 00 00    	cmp    %eax,0xa7c
 717:	89 c2                	mov    %eax,%edx
 719:	75 ed                	jne    708 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 71b:	89 34 24             	mov    %esi,(%esp)
 71e:	e8 2d fc ff ff       	call   350 <sbrk>
  if(p == (char*)-1)
 723:	83 f8 ff             	cmp    $0xffffffff,%eax
 726:	74 18                	je     740 <malloc+0x80>
  hp->s.size = nu;
 728:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 72b:	83 c0 08             	add    $0x8,%eax
 72e:	89 04 24             	mov    %eax,(%esp)
 731:	e8 ea fe ff ff       	call   620 <free>
  return freep;
 736:	8b 15 7c 0a 00 00    	mov    0xa7c,%edx
      if((p = morecore(nunits)) == 0)
 73c:	85 d2                	test   %edx,%edx
 73e:	75 c8                	jne    708 <malloc+0x48>
        return 0;
  }
}
 740:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 743:	31 c0                	xor    %eax,%eax
}
 745:	5b                   	pop    %ebx
 746:	5e                   	pop    %esi
 747:	5f                   	pop    %edi
 748:	5d                   	pop    %ebp
 749:	c3                   	ret    
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 750:	39 cf                	cmp    %ecx,%edi
 752:	74 4c                	je     7a0 <malloc+0xe0>
        p->s.size -= nunits;
 754:	29 f9                	sub    %edi,%ecx
 756:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 759:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 75c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 75f:	89 15 7c 0a 00 00    	mov    %edx,0xa7c
}
 765:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 768:	83 c0 08             	add    $0x8,%eax
}
 76b:	5b                   	pop    %ebx
 76c:	5e                   	pop    %esi
 76d:	5f                   	pop    %edi
 76e:	5d                   	pop    %ebp
 76f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 770:	b8 80 0a 00 00       	mov    $0xa80,%eax
 775:	ba 80 0a 00 00       	mov    $0xa80,%edx
    base.s.size = 0;
 77a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 77c:	a3 7c 0a 00 00       	mov    %eax,0xa7c
    base.s.size = 0;
 781:	b8 80 0a 00 00       	mov    $0xa80,%eax
    base.s.ptr = freep = prevp = &base;
 786:	89 15 80 0a 00 00    	mov    %edx,0xa80
    base.s.size = 0;
 78c:	89 0d 84 0a 00 00    	mov    %ecx,0xa84
 792:	e9 53 ff ff ff       	jmp    6ea <malloc+0x2a>
 797:	89 f6                	mov    %esi,%esi
 799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 08                	mov    (%eax),%ecx
 7a2:	89 0a                	mov    %ecx,(%edx)
 7a4:	eb b9                	jmp    75f <malloc+0x9f>
