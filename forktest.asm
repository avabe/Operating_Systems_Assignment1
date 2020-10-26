
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  forktest();
   9:	e8 42 00 00 00       	call   50 <forktest>
  exit(0);
   e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  15:	e8 de 03 00 00       	call   3f8 <exit>
  1a:	66 90                	xchg   %ax,%ax
  1c:	66 90                	xchg   %ax,%ax
  1e:	66 90                	xchg   %ax,%ax

00000020 <printf>:
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
  27:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  2a:	89 1c 24             	mov    %ebx,(%esp)
  2d:	e8 fe 01 00 00       	call   230 <strlen>
  32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	8b 45 08             	mov    0x8(%ebp),%eax
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 d3 03 00 00       	call   418 <write>
}
  45:	83 c4 14             	add    $0x14,%esp
  48:	5b                   	pop    %ebx
  49:	5d                   	pop    %ebp
  4a:	c3                   	ret    
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000050 <forktest>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  write(fd, s, strlen(s));
  54:	bb b8 04 00 00       	mov    $0x4b8,%ebx
{
  59:	83 ec 14             	sub    $0x14,%esp
  write(fd, s, strlen(s));
  5c:	c7 04 24 b8 04 00 00 	movl   $0x4b8,(%esp)
  63:	e8 c8 01 00 00       	call   230 <strlen>
  68:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(n=0; n<N; n++){
  6c:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
  6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  75:	89 44 24 08          	mov    %eax,0x8(%esp)
  79:	e8 9a 03 00 00       	call   418 <write>
  7e:	eb 12                	jmp    92 <forktest+0x42>
    if(pid == 0)
  80:	0f 84 d8 00 00 00    	je     15e <forktest+0x10e>
  for(n=0; n<N; n++){
  86:	43                   	inc    %ebx
  87:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	74 76                	je     108 <forktest+0xb8>
    pid = fork();
  92:	e8 59 03 00 00       	call   3f0 <fork>
    if(pid < 0)
  97:	85 c0                	test   %eax,%eax
  99:	79 e5                	jns    80 <forktest+0x30>
  for(; n > 0; n--){
  9b:	85 db                	test   %ebx,%ebx
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	74 21                	je     c3 <forktest+0x73>
  a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait(0) < 0){
  b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b7:	e8 44 03 00 00       	call   400 <wait>
  bc:	85 c0                	test   %eax,%eax
  be:	78 79                	js     139 <forktest+0xe9>
  for(; n > 0; n--){
  c0:	4b                   	dec    %ebx
  c1:	75 ed                	jne    b0 <forktest+0x60>
  if(wait(0) != -1){
  c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ca:	e8 31 03 00 00       	call   400 <wait>
  cf:	40                   	inc    %eax
  d0:	0f 85 94 00 00 00    	jne    16a <forktest+0x11a>
  write(fd, s, strlen(s));
  d6:	c7 04 24 ea 04 00 00 	movl   $0x4ea,(%esp)
  dd:	e8 4e 01 00 00       	call   230 <strlen>
  e2:	ba ea 04 00 00       	mov    $0x4ea,%edx
  e7:	89 54 24 04          	mov    %edx,0x4(%esp)
  eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f2:	89 44 24 08          	mov    %eax,0x8(%esp)
  f6:	e8 1d 03 00 00       	call   418 <write>
}
  fb:	83 c4 14             	add    $0x14,%esp
  fe:	5b                   	pop    %ebx
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    
 101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, s, strlen(s));
 108:	c7 04 24 f8 04 00 00 	movl   $0x4f8,(%esp)
 10f:	e8 1c 01 00 00       	call   230 <strlen>
 114:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 11b:	89 44 24 08          	mov    %eax,0x8(%esp)
 11f:	b8 f8 04 00 00       	mov    $0x4f8,%eax
 124:	89 44 24 04          	mov    %eax,0x4(%esp)
 128:	e8 eb 02 00 00       	call   418 <write>
    exit(0);
 12d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 134:	e8 bf 02 00 00       	call   3f8 <exit>
  write(fd, s, strlen(s));
 139:	c7 04 24 c3 04 00 00 	movl   $0x4c3,(%esp)
 140:	e8 eb 00 00 00       	call   230 <strlen>
 145:	b9 c3 04 00 00       	mov    $0x4c3,%ecx
 14a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 14e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 155:	89 44 24 08          	mov    %eax,0x8(%esp)
 159:	e8 ba 02 00 00       	call   418 <write>
      exit(0);
 15e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 165:	e8 8e 02 00 00       	call   3f8 <exit>
  write(fd, s, strlen(s));
 16a:	c7 04 24 d7 04 00 00 	movl   $0x4d7,(%esp)
 171:	e8 ba 00 00 00       	call   230 <strlen>
 176:	c7 44 24 04 d7 04 00 	movl   $0x4d7,0x4(%esp)
 17d:	00 
 17e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 185:	89 44 24 08          	mov    %eax,0x8(%esp)
 189:	e8 8a 02 00 00       	call   418 <write>
    exit(0);
 18e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 195:	e8 5e 02 00 00       	call   3f8 <exit>
 19a:	66 90                	xchg   %ax,%ax
 19c:	66 90                	xchg   %ax,%ax
 19e:	66 90                	xchg   %ax,%ax

000001a0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1a9:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
 1aa:	89 c2                	mov    %eax,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b0:	41                   	inc    %ecx
 1b1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1b5:	42                   	inc    %edx
 1b6:	84 db                	test   %bl,%bl
 1b8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1bb:	75 f3                	jne    1b0 <strcpy+0x10>
    return os;
}
 1bd:	5b                   	pop    %ebx
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
 1c0:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
 1c1:	31 d2                	xor    %edx,%edx
{
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	56                   	push   %esi
 1c6:	8b 45 08             	mov    0x8(%ebp),%eax
 1c9:	53                   	push   %ebx
 1ca:	8b 75 0c             	mov    0xc(%ebp),%esi
 1cd:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
 1d0:	eb 12                	jmp    1e4 <strncpy+0x24>
 1d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1df:	42                   	inc    %edx
 1e0:	84 c9                	test   %cl,%cl
 1e2:	74 08                	je     1ec <strncpy+0x2c>
 1e4:	89 d9                	mov    %ebx,%ecx
 1e6:	29 d1                	sub    %edx,%ecx
 1e8:	85 c9                	test   %ecx,%ecx
 1ea:	7f ec                	jg     1d8 <strncpy+0x18>
    return os;
}
 1ec:	5b                   	pop    %ebx
 1ed:	5e                   	pop    %esi
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret    

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q) {
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
 1f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
 1fa:	0f b6 01             	movzbl (%ecx),%eax
 1fd:	0f b6 13             	movzbl (%ebx),%edx
 200:	84 c0                	test   %al,%al
 202:	75 18                	jne    21c <strcmp+0x2c>
 204:	eb 22                	jmp    228 <strcmp+0x38>
 206:	8d 76 00             	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
 210:	41                   	inc    %ecx
    while (*p && *p == *q)
 211:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
 214:	43                   	inc    %ebx
 215:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
 218:	84 c0                	test   %al,%al
 21a:	74 0c                	je     228 <strcmp+0x38>
 21c:	38 d0                	cmp    %dl,%al
 21e:	74 f0                	je     210 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
 220:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
 221:	29 d0                	sub    %edx,%eax
}
 223:	5d                   	pop    %ebp
 224:	c3                   	ret    
 225:	8d 76 00             	lea    0x0(%esi),%esi
 228:	5b                   	pop    %ebx
 229:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
 22b:	29 d0                	sub    %edx,%eax
}
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop

00000230 <strlen>:

uint
strlen(const char *s) {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 236:	80 39 00             	cmpb   $0x0,(%ecx)
 239:	74 15                	je     250 <strlen+0x20>
 23b:	31 d2                	xor    %edx,%edx
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	42                   	inc    %edx
 241:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 245:	89 d0                	mov    %edx,%eax
 247:	75 f7                	jne    240 <strlen+0x10>
    return n;
}
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	90                   	nop
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 250:	31 c0                	xor    %eax,%eax
}
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <memset>:

void *
memset(void *dst, int c, uint n) {
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 267:	8b 4d 10             	mov    0x10(%ebp),%ecx
 26a:	8b 45 0c             	mov    0xc(%ebp),%eax
 26d:	89 d7                	mov    %edx,%edi
 26f:	fc                   	cld    
 270:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 272:	5f                   	pop    %edi
 273:	89 d0                	mov    %edx,%eax
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <strchr>:

char *
strchr(const char *s, char c) {
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 28a:	0f b6 10             	movzbl (%eax),%edx
 28d:	84 d2                	test   %dl,%dl
 28f:	74 1b                	je     2ac <strchr+0x2c>
        if (*s == c)
 291:	38 d1                	cmp    %dl,%cl
 293:	75 0f                	jne    2a4 <strchr+0x24>
 295:	eb 17                	jmp    2ae <strchr+0x2e>
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 2a0:	38 ca                	cmp    %cl,%dl
 2a2:	74 0a                	je     2ae <strchr+0x2e>
    for (; *s; s++)
 2a4:	40                   	inc    %eax
 2a5:	0f b6 10             	movzbl (%eax),%edx
 2a8:	84 d2                	test   %dl,%dl
 2aa:	75 f4                	jne    2a0 <strchr+0x20>
            return (char *) s;
    return 0;
 2ac:	31 c0                	xor    %eax,%eax
}
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret    

000002b0 <gets>:

char *
gets(char *buf, int max) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 2b5:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 2b7:	53                   	push   %ebx
 2b8:	83 ec 3c             	sub    $0x3c,%esp
 2bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 2be:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 2c1:	eb 32                	jmp    2f5 <gets+0x45>
 2c3:	90                   	nop
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 2c8:	ba 01 00 00 00       	mov    $0x1,%edx
 2cd:	89 54 24 08          	mov    %edx,0x8(%esp)
 2d1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2dc:	e8 2f 01 00 00       	call   410 <read>
        if (cc < 1)
 2e1:	85 c0                	test   %eax,%eax
 2e3:	7e 19                	jle    2fe <gets+0x4e>
            break;
        buf[i++] = c;
 2e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2e9:	43                   	inc    %ebx
 2ea:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 2ed:	3c 0a                	cmp    $0xa,%al
 2ef:	74 1f                	je     310 <gets+0x60>
 2f1:	3c 0d                	cmp    $0xd,%al
 2f3:	74 1b                	je     310 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 2f5:	46                   	inc    %esi
 2f6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2f9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2fc:	7c ca                	jl     2c8 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 2fe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 301:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	83 c4 3c             	add    $0x3c,%esp
 30a:	5b                   	pop    %ebx
 30b:	5e                   	pop    %esi
 30c:	5f                   	pop    %edi
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	01 c6                	add    %eax,%esi
 315:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 318:	eb e4                	jmp    2fe <gets+0x4e>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000320 <stat>:

int
stat(const char *n, struct stat *st) {
 320:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 321:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 323:	89 e5                	mov    %esp,%ebp
 325:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 328:	89 44 24 04          	mov    %eax,0x4(%esp)
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 32f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 332:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 335:	89 04 24             	mov    %eax,(%esp)
 338:	e8 fb 00 00 00       	call   438 <open>
    if (fd < 0)
 33d:	85 c0                	test   %eax,%eax
 33f:	78 2f                	js     370 <stat+0x50>
 341:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 343:	8b 45 0c             	mov    0xc(%ebp),%eax
 346:	89 1c 24             	mov    %ebx,(%esp)
 349:	89 44 24 04          	mov    %eax,0x4(%esp)
 34d:	e8 fe 00 00 00       	call   450 <fstat>
    close(fd);
 352:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 355:	89 c6                	mov    %eax,%esi
    close(fd);
 357:	e8 c4 00 00 00       	call   420 <close>
    return r;
}
 35c:	89 f0                	mov    %esi,%eax
 35e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 361:	8b 75 fc             	mov    -0x4(%ebp),%esi
 364:	89 ec                	mov    %ebp,%esp
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 370:	be ff ff ff ff       	mov    $0xffffffff,%esi
 375:	eb e5                	jmp    35c <stat+0x3c>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <atoi>:

int
atoi(const char *s) {
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
 386:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 387:	0f be 11             	movsbl (%ecx),%edx
 38a:	88 d0                	mov    %dl,%al
 38c:	2c 30                	sub    $0x30,%al
 38e:	3c 09                	cmp    $0x9,%al
    n = 0;
 390:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 395:	77 1e                	ja     3b5 <atoi+0x35>
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 3a0:	41                   	inc    %ecx
 3a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 3a8:	0f be 11             	movsbl (%ecx),%edx
 3ab:	88 d3                	mov    %dl,%bl
 3ad:	80 eb 30             	sub    $0x30,%bl
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
    return n;
}
 3b5:	5b                   	pop    %ebx
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	8b 45 08             	mov    0x8(%ebp),%eax
 3c7:	53                   	push   %ebx
 3c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3cb:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 3ce:	85 db                	test   %ebx,%ebx
 3d0:	7e 1a                	jle    3ec <memmove+0x2c>
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 3e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3e7:	42                   	inc    %edx
    while (n-- > 0)
 3e8:	39 d3                	cmp    %edx,%ebx
 3ea:	75 f4                	jne    3e0 <memmove+0x20>
    return vdst;
}
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    

000003f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f0:	b8 01 00 00 00       	mov    $0x1,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <exit>:
SYSCALL(exit)
 3f8:	b8 02 00 00 00       	mov    $0x2,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <wait>:
SYSCALL(wait)
 400:	b8 03 00 00 00       	mov    $0x3,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <pipe>:
SYSCALL(pipe)
 408:	b8 04 00 00 00       	mov    $0x4,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <read>:
SYSCALL(read)
 410:	b8 05 00 00 00       	mov    $0x5,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <write>:
SYSCALL(write)
 418:	b8 10 00 00 00       	mov    $0x10,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <close>:
SYSCALL(close)
 420:	b8 15 00 00 00       	mov    $0x15,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <kill>:
SYSCALL(kill)
 428:	b8 06 00 00 00       	mov    $0x6,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <exec>:
SYSCALL(exec)
 430:	b8 07 00 00 00       	mov    $0x7,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <open>:
SYSCALL(open)
 438:	b8 0f 00 00 00       	mov    $0xf,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <mknod>:
SYSCALL(mknod)
 440:	b8 11 00 00 00       	mov    $0x11,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <unlink>:
SYSCALL(unlink)
 448:	b8 12 00 00 00       	mov    $0x12,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <fstat>:
SYSCALL(fstat)
 450:	b8 08 00 00 00       	mov    $0x8,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <link>:
SYSCALL(link)
 458:	b8 13 00 00 00       	mov    $0x13,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mkdir>:
SYSCALL(mkdir)
 460:	b8 14 00 00 00       	mov    $0x14,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <chdir>:
SYSCALL(chdir)
 468:	b8 09 00 00 00       	mov    $0x9,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <dup>:
SYSCALL(dup)
 470:	b8 0a 00 00 00       	mov    $0xa,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <getpid>:
SYSCALL(getpid)
 478:	b8 0b 00 00 00       	mov    $0xb,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <sbrk>:
SYSCALL(sbrk)
 480:	b8 0c 00 00 00       	mov    $0xc,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <sleep>:
SYSCALL(sleep)
 488:	b8 0d 00 00 00       	mov    $0xd,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <uptime>:
SYSCALL(uptime)
 490:	b8 0e 00 00 00       	mov    $0xe,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <detach>:
SYSCALL(detach)
 498:	b8 16 00 00 00       	mov    $0x16,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <priority>:
SYSCALL(priority)
 4a0:	b8 17 00 00 00       	mov    $0x17,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <policy>:
SYSCALL(policy)
 4a8:	b8 18 00 00 00       	mov    $0x18,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <wait_stat>:
SYSCALL(wait_stat)
 4b0:	b8 19 00 00 00       	mov    $0x19,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    
