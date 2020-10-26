
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
  int fd, i;
  char path[] = "stressfs0";
   1:	b8 73 74 72 65       	mov    $0x65727473,%eax
{
   6:	89 e5                	mov    %esp,%ebp
   8:	57                   	push   %edi
   9:	56                   	push   %esi
   a:	53                   	push   %ebx
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
   b:	31 db                	xor    %ebx,%ebx
{
   d:	83 e4 f0             	and    $0xfffffff0,%esp
  10:	81 ec 30 02 00 00    	sub    $0x230,%esp
  char path[] = "stressfs0";
  16:	89 44 24 26          	mov    %eax,0x26(%esp)
  1a:	b8 73 73 66 73       	mov    $0x73667373,%eax
  1f:	89 44 24 2a          	mov    %eax,0x2a(%esp)
  printf(1, "stressfs starting\n");
  23:	b8 88 08 00 00       	mov    $0x888,%eax
  28:	89 44 24 04          	mov    %eax,0x4(%esp)
  memset(data, 'a', sizeof(data));
  2c:	8d 74 24 30          	lea    0x30(%esp),%esi
  printf(1, "stressfs starting\n");
  30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char path[] = "stressfs0";
  37:	66 c7 44 24 2e 30 00 	movw   $0x30,0x2e(%esp)
  printf(1, "stressfs starting\n");
  3e:	e8 cd 04 00 00       	call   510 <printf>
  memset(data, 'a', sizeof(data));
  43:	ba 00 02 00 00       	mov    $0x200,%edx
  48:	b9 61 00 00 00       	mov    $0x61,%ecx
  4d:	89 54 24 08          	mov    %edx,0x8(%esp)
  51:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  55:	89 34 24             	mov    %esi,(%esp)
  58:	e8 b3 01 00 00       	call   210 <memset>
    if(fork() > 0)
  5d:	e8 3e 03 00 00       	call   3a0 <fork>
  62:	85 c0                	test   %eax,%eax
  64:	0f 8f de 00 00 00    	jg     148 <main+0x148>
  for(i = 0; i < 4; i++)
  6a:	43                   	inc    %ebx
  6b:	83 fb 04             	cmp    $0x4,%ebx
  6e:	66 90                	xchg   %ax,%ax
  70:	75 eb                	jne    5d <main+0x5d>
  72:	b0 04                	mov    $0x4,%al
  74:	88 44 24 1f          	mov    %al,0x1f(%esp)
      break;

  printf(1, "write %d\n", i);
  78:	b8 9b 08 00 00       	mov    $0x89b,%eax
  7d:	89 5c 24 08          	mov    %ebx,0x8(%esp)

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  81:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  86:	89 44 24 04          	mov    %eax,0x4(%esp)
  8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  91:	e8 7a 04 00 00       	call   510 <printf>
  path[8] += i;
  96:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  9b:	00 44 24 2e          	add    %al,0x2e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  9f:	b8 02 02 00 00       	mov    $0x202,%eax
  a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  a8:	8d 44 24 26          	lea    0x26(%esp),%eax
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 34 03 00 00       	call   3e8 <open>
  b4:	89 c7                	mov    %eax,%edi
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  c0:	b8 00 02 00 00       	mov    $0x200,%eax
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	89 74 24 04          	mov    %esi,0x4(%esp)
  cd:	89 3c 24             	mov    %edi,(%esp)
  d0:	e8 f3 02 00 00       	call   3c8 <write>
  for(i = 0; i < 20; i++)
  d5:	4b                   	dec    %ebx
  d6:	75 e8                	jne    c0 <main+0xc0>
  close(fd);
  d8:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  db:	bb 14 00 00 00       	mov    $0x14,%ebx
  close(fd);
  e0:	e8 eb 02 00 00       	call   3d0 <close>
  printf(1, "read\n");
  e5:	ba a5 08 00 00       	mov    $0x8a5,%edx
  ea:	89 54 24 04          	mov    %edx,0x4(%esp)
  ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f5:	e8 16 04 00 00       	call   510 <printf>
  fd = open(path, O_RDONLY);
  fa:	31 c9                	xor    %ecx,%ecx
  fc:	8d 44 24 26          	lea    0x26(%esp),%eax
 100:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 104:	89 04 24             	mov    %eax,(%esp)
 107:	e8 dc 02 00 00       	call   3e8 <open>
 10c:	89 c7                	mov    %eax,%edi
 10e:	66 90                	xchg   %ax,%ax
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 110:	b8 00 02 00 00       	mov    $0x200,%eax
 115:	89 44 24 08          	mov    %eax,0x8(%esp)
 119:	89 74 24 04          	mov    %esi,0x4(%esp)
 11d:	89 3c 24             	mov    %edi,(%esp)
 120:	e8 9b 02 00 00       	call   3c0 <read>
  for (i = 0; i < 20; i++)
 125:	4b                   	dec    %ebx
 126:	75 e8                	jne    110 <main+0x110>
  close(fd);
 128:	89 3c 24             	mov    %edi,(%esp)
 12b:	e8 a0 02 00 00       	call   3d0 <close>

  wait(0);
 130:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 137:	e8 74 02 00 00       	call   3b0 <wait>

  exit(0);
 13c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 143:	e8 60 02 00 00       	call   3a8 <exit>
 148:	88 d8                	mov    %bl,%al
 14a:	e9 25 ff ff ff       	jmp    74 <main+0x74>
 14f:	90                   	nop

00000150 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 159:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
 15a:	89 c2                	mov    %eax,%edx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	41                   	inc    %ecx
 161:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 165:	42                   	inc    %edx
 166:	84 db                	test   %bl,%bl
 168:	88 5a ff             	mov    %bl,-0x1(%edx)
 16b:	75 f3                	jne    160 <strcpy+0x10>
    return os;
}
 16d:	5b                   	pop    %ebx
 16e:	5d                   	pop    %ebp
 16f:	c3                   	ret    

00000170 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
 170:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
 171:	31 d2                	xor    %edx,%edx
{
 173:	89 e5                	mov    %esp,%ebp
 175:	56                   	push   %esi
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	53                   	push   %ebx
 17a:	8b 75 0c             	mov    0xc(%ebp),%esi
 17d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
 180:	eb 12                	jmp    194 <strncpy+0x24>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 188:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 18c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 18f:	42                   	inc    %edx
 190:	84 c9                	test   %cl,%cl
 192:	74 08                	je     19c <strncpy+0x2c>
 194:	89 d9                	mov    %ebx,%ecx
 196:	29 d1                	sub    %edx,%ecx
 198:	85 c9                	test   %ecx,%ecx
 19a:	7f ec                	jg     188 <strncpy+0x18>
    return os;
}
 19c:	5b                   	pop    %ebx
 19d:	5e                   	pop    %esi
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q) {
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a6:	53                   	push   %ebx
 1a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
 1aa:	0f b6 01             	movzbl (%ecx),%eax
 1ad:	0f b6 13             	movzbl (%ebx),%edx
 1b0:	84 c0                	test   %al,%al
 1b2:	75 18                	jne    1cc <strcmp+0x2c>
 1b4:	eb 22                	jmp    1d8 <strcmp+0x38>
 1b6:	8d 76 00             	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
 1c0:	41                   	inc    %ecx
    while (*p && *p == *q)
 1c1:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
 1c4:	43                   	inc    %ebx
 1c5:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
 1c8:	84 c0                	test   %al,%al
 1ca:	74 0c                	je     1d8 <strcmp+0x38>
 1cc:	38 d0                	cmp    %dl,%al
 1ce:	74 f0                	je     1c0 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
 1d0:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
 1d1:	29 d0                	sub    %edx,%eax
}
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	8d 76 00             	lea    0x0(%esi),%esi
 1d8:	5b                   	pop    %ebx
 1d9:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
 1db:	29 d0                	sub    %edx,%eax
}
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    
 1df:	90                   	nop

000001e0 <strlen>:

uint
strlen(const char *s) {
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 1e6:	80 39 00             	cmpb   $0x0,(%ecx)
 1e9:	74 15                	je     200 <strlen+0x20>
 1eb:	31 d2                	xor    %edx,%edx
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	42                   	inc    %edx
 1f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	75 f7                	jne    1f0 <strlen+0x10>
    return n;
}
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 200:	31 c0                	xor    %eax,%eax
}
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <memset>:

void *
memset(void *dst, int c, uint n) {
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld    
 220:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 222:	5f                   	pop    %edi
 223:	89 d0                	mov    %edx,%eax
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <strchr>:

char *
strchr(const char *s, char c) {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	74 1b                	je     25c <strchr+0x2c>
        if (*s == c)
 241:	38 d1                	cmp    %dl,%cl
 243:	75 0f                	jne    254 <strchr+0x24>
 245:	eb 17                	jmp    25e <strchr+0x2e>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 250:	38 ca                	cmp    %cl,%dl
 252:	74 0a                	je     25e <strchr+0x2e>
    for (; *s; s++)
 254:	40                   	inc    %eax
 255:	0f b6 10             	movzbl (%eax),%edx
 258:	84 d2                	test   %dl,%dl
 25a:	75 f4                	jne    250 <strchr+0x20>
            return (char *) s;
    return 0;
 25c:	31 c0                	xor    %eax,%eax
}
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <gets>:

char *
gets(char *buf, int max) {
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 265:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 267:	53                   	push   %ebx
 268:	83 ec 3c             	sub    $0x3c,%esp
 26b:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 26e:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 271:	eb 32                	jmp    2a5 <gets+0x45>
 273:	90                   	nop
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 278:	ba 01 00 00 00       	mov    $0x1,%edx
 27d:	89 54 24 08          	mov    %edx,0x8(%esp)
 281:	89 7c 24 04          	mov    %edi,0x4(%esp)
 285:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 28c:	e8 2f 01 00 00       	call   3c0 <read>
        if (cc < 1)
 291:	85 c0                	test   %eax,%eax
 293:	7e 19                	jle    2ae <gets+0x4e>
            break;
        buf[i++] = c;
 295:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 299:	43                   	inc    %ebx
 29a:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 29d:	3c 0a                	cmp    $0xa,%al
 29f:	74 1f                	je     2c0 <gets+0x60>
 2a1:	3c 0d                	cmp    $0xd,%al
 2a3:	74 1b                	je     2c0 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 2a5:	46                   	inc    %esi
 2a6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2a9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2ac:	7c ca                	jl     278 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 2ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 2b1:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	83 c4 3c             	add    $0x3c,%esp
 2ba:	5b                   	pop    %ebx
 2bb:	5e                   	pop    %esi
 2bc:	5f                   	pop    %edi
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret    
 2bf:	90                   	nop
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	01 c6                	add    %eax,%esi
 2c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2c8:	eb e4                	jmp    2ae <gets+0x4e>
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <stat>:

int
stat(const char *n, struct stat *st) {
 2d0:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 2d1:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 2d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2dc:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 2df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 2e5:	89 04 24             	mov    %eax,(%esp)
 2e8:	e8 fb 00 00 00       	call   3e8 <open>
    if (fd < 0)
 2ed:	85 c0                	test   %eax,%eax
 2ef:	78 2f                	js     320 <stat+0x50>
 2f1:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 2f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f6:	89 1c 24             	mov    %ebx,(%esp)
 2f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fd:	e8 fe 00 00 00       	call   400 <fstat>
    close(fd);
 302:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 305:	89 c6                	mov    %eax,%esi
    close(fd);
 307:	e8 c4 00 00 00       	call   3d0 <close>
    return r;
}
 30c:	89 f0                	mov    %esi,%eax
 30e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 311:	8b 75 fc             	mov    -0x4(%ebp),%esi
 314:	89 ec                	mov    %ebp,%esp
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    
 318:	90                   	nop
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 320:	be ff ff ff ff       	mov    $0xffffffff,%esi
 325:	eb e5                	jmp    30c <stat+0x3c>
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <atoi>:

int
atoi(const char *s) {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
 336:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 337:	0f be 11             	movsbl (%ecx),%edx
 33a:	88 d0                	mov    %dl,%al
 33c:	2c 30                	sub    $0x30,%al
 33e:	3c 09                	cmp    $0x9,%al
    n = 0;
 340:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 345:	77 1e                	ja     365 <atoi+0x35>
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 350:	41                   	inc    %ecx
 351:	8d 04 80             	lea    (%eax,%eax,4),%eax
 354:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 358:	0f be 11             	movsbl (%ecx),%edx
 35b:	88 d3                	mov    %dl,%bl
 35d:	80 eb 30             	sub    $0x30,%bl
 360:	80 fb 09             	cmp    $0x9,%bl
 363:	76 eb                	jbe    350 <atoi+0x20>
    return n;
}
 365:	5b                   	pop    %ebx
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000370 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	53                   	push   %ebx
 378:	8b 5d 10             	mov    0x10(%ebp),%ebx
 37b:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 37e:	85 db                	test   %ebx,%ebx
 380:	7e 1a                	jle    39c <memmove+0x2c>
 382:	31 d2                	xor    %edx,%edx
 384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 38a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 390:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 394:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 397:	42                   	inc    %edx
    while (n-- > 0)
 398:	39 d3                	cmp    %edx,%ebx
 39a:	75 f4                	jne    390 <memmove+0x20>
    return vdst;
}
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a0:	b8 01 00 00 00       	mov    $0x1,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <exit>:
SYSCALL(exit)
 3a8:	b8 02 00 00 00       	mov    $0x2,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <wait>:
SYSCALL(wait)
 3b0:	b8 03 00 00 00       	mov    $0x3,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <pipe>:
SYSCALL(pipe)
 3b8:	b8 04 00 00 00       	mov    $0x4,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <read>:
SYSCALL(read)
 3c0:	b8 05 00 00 00       	mov    $0x5,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <write>:
SYSCALL(write)
 3c8:	b8 10 00 00 00       	mov    $0x10,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <close>:
SYSCALL(close)
 3d0:	b8 15 00 00 00       	mov    $0x15,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <kill>:
SYSCALL(kill)
 3d8:	b8 06 00 00 00       	mov    $0x6,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <exec>:
SYSCALL(exec)
 3e0:	b8 07 00 00 00       	mov    $0x7,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <open>:
SYSCALL(open)
 3e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <mknod>:
SYSCALL(mknod)
 3f0:	b8 11 00 00 00       	mov    $0x11,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <unlink>:
SYSCALL(unlink)
 3f8:	b8 12 00 00 00       	mov    $0x12,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <fstat>:
SYSCALL(fstat)
 400:	b8 08 00 00 00       	mov    $0x8,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <link>:
SYSCALL(link)
 408:	b8 13 00 00 00       	mov    $0x13,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <mkdir>:
SYSCALL(mkdir)
 410:	b8 14 00 00 00       	mov    $0x14,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <chdir>:
SYSCALL(chdir)
 418:	b8 09 00 00 00       	mov    $0x9,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <dup>:
SYSCALL(dup)
 420:	b8 0a 00 00 00       	mov    $0xa,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <getpid>:
SYSCALL(getpid)
 428:	b8 0b 00 00 00       	mov    $0xb,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <sbrk>:
SYSCALL(sbrk)
 430:	b8 0c 00 00 00       	mov    $0xc,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <sleep>:
SYSCALL(sleep)
 438:	b8 0d 00 00 00       	mov    $0xd,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <uptime>:
SYSCALL(uptime)
 440:	b8 0e 00 00 00       	mov    $0xe,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <detach>:
SYSCALL(detach)
 448:	b8 16 00 00 00       	mov    $0x16,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <priority>:
SYSCALL(priority)
 450:	b8 17 00 00 00       	mov    $0x17,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <policy>:
SYSCALL(policy)
 458:	b8 18 00 00 00       	mov    $0x18,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <wait_stat>:
SYSCALL(wait_stat)
 460:	b8 19 00 00 00       	mov    $0x19,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    
 468:	66 90                	xchg   %ax,%ax
 46a:	66 90                	xchg   %ax,%ax
 46c:	66 90                	xchg   %ax,%ax
 46e:	66 90                	xchg   %ax,%ax

00000470 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 476:	89 d3                	mov    %edx,%ebx
 478:	c1 eb 1f             	shr    $0x1f,%ebx
{
 47b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 47e:	84 db                	test   %bl,%bl
{
 480:	89 45 c0             	mov    %eax,-0x40(%ebp)
 483:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 485:	74 79                	je     500 <printint+0x90>
 487:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 48b:	74 73                	je     500 <printint+0x90>
    neg = 1;
    x = -xx;
 48d:	f7 d8                	neg    %eax
    neg = 1;
 48f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 496:	31 f6                	xor    %esi,%esi
 498:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 49b:	eb 05                	jmp    4a2 <printint+0x32>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4a0:	89 fe                	mov    %edi,%esi
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	f7 f1                	div    %ecx
 4a6:	8d 7e 01             	lea    0x1(%esi),%edi
 4a9:	0f b6 92 b4 08 00 00 	movzbl 0x8b4(%edx),%edx
  }while((x /= base) != 0);
 4b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 4b5:	75 e9                	jne    4a0 <printint+0x30>
  if(neg)
 4b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 4ba:	85 d2                	test   %edx,%edx
 4bc:	74 08                	je     4c6 <printint+0x56>
    buf[i++] = '-';
 4be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4c3:	8d 7e 02             	lea    0x2(%esi),%edi
 4c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
 4d0:	0f b6 06             	movzbl (%esi),%eax
 4d3:	4e                   	dec    %esi
  write(fd, &c, 1);
 4d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4d8:	89 3c 24             	mov    %edi,(%esp)
 4db:	88 45 d7             	mov    %al,-0x29(%ebp)
 4de:	b8 01 00 00 00       	mov    $0x1,%eax
 4e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4e7:	e8 dc fe ff ff       	call   3c8 <write>

  while(--i >= 0)
 4ec:	39 de                	cmp    %ebx,%esi
 4ee:	75 e0                	jne    4d0 <printint+0x60>
    putc(fd, buf[i]);
}
 4f0:	83 c4 4c             	add    $0x4c,%esp
 4f3:	5b                   	pop    %ebx
 4f4:	5e                   	pop    %esi
 4f5:	5f                   	pop    %edi
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
 4f8:	90                   	nop
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 500:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 507:	eb 8d                	jmp    496 <printint+0x26>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 519:	8b 75 0c             	mov    0xc(%ebp),%esi
 51c:	0f b6 1e             	movzbl (%esi),%ebx
 51f:	84 db                	test   %bl,%bl
 521:	0f 84 d1 00 00 00    	je     5f8 <printf+0xe8>
  state = 0;
 527:	31 ff                	xor    %edi,%edi
 529:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 52a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 52d:	89 fa                	mov    %edi,%edx
 52f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 532:	89 45 d0             	mov    %eax,-0x30(%ebp)
 535:	eb 41                	jmp    578 <printf+0x68>
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 540:	83 f8 25             	cmp    $0x25,%eax
 543:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 546:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 54b:	74 1e                	je     56b <printf+0x5b>
  write(fd, &c, 1);
 54d:	b8 01 00 00 00       	mov    $0x1,%eax
 552:	89 44 24 08          	mov    %eax,0x8(%esp)
 556:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 559:	89 44 24 04          	mov    %eax,0x4(%esp)
 55d:	89 3c 24             	mov    %edi,(%esp)
 560:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 563:	e8 60 fe ff ff       	call   3c8 <write>
 568:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 56b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 56c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 570:	84 db                	test   %bl,%bl
 572:	0f 84 80 00 00 00    	je     5f8 <printf+0xe8>
    if(state == 0){
 578:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 57a:	0f be cb             	movsbl %bl,%ecx
 57d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 580:	74 be                	je     540 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 582:	83 fa 25             	cmp    $0x25,%edx
 585:	75 e4                	jne    56b <printf+0x5b>
      if(c == 'd'){
 587:	83 f8 64             	cmp    $0x64,%eax
 58a:	0f 84 f0 00 00 00    	je     680 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 590:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 596:	83 f9 70             	cmp    $0x70,%ecx
 599:	74 65                	je     600 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 59b:	83 f8 73             	cmp    $0x73,%eax
 59e:	0f 84 8c 00 00 00    	je     630 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a4:	83 f8 63             	cmp    $0x63,%eax
 5a7:	0f 84 13 01 00 00    	je     6c0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5ad:	83 f8 25             	cmp    $0x25,%eax
 5b0:	0f 84 e2 00 00 00    	je     698 <printf+0x188>
  write(fd, &c, 1);
 5b6:	b8 01 00 00 00       	mov    $0x1,%eax
 5bb:	46                   	inc    %esi
 5bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 5c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c7:	89 3c 24             	mov    %edi,(%esp)
 5ca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ce:	e8 f5 fd ff ff       	call   3c8 <write>
 5d3:	ba 01 00 00 00       	mov    $0x1,%edx
 5d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5db:	89 54 24 08          	mov    %edx,0x8(%esp)
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	89 3c 24             	mov    %edi,(%esp)
 5e6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5e9:	e8 da fd ff ff       	call   3c8 <write>
  for(i = 0; fmt[i]; i++){
 5ee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5f2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5f4:	84 db                	test   %bl,%bl
 5f6:	75 80                	jne    578 <printf+0x68>
    }
  }
}
 5f8:	83 c4 3c             	add    $0x3c,%esp
 5fb:	5b                   	pop    %ebx
 5fc:	5e                   	pop    %esi
 5fd:	5f                   	pop    %edi
 5fe:	5d                   	pop    %ebp
 5ff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 600:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 607:	b9 10 00 00 00       	mov    $0x10,%ecx
 60c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60f:	89 f8                	mov    %edi,%eax
 611:	8b 13                	mov    (%ebx),%edx
 613:	e8 58 fe ff ff       	call   470 <printint>
        ap++;
 618:	89 d8                	mov    %ebx,%eax
      state = 0;
 61a:	31 d2                	xor    %edx,%edx
        ap++;
 61c:	83 c0 04             	add    $0x4,%eax
 61f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 622:	e9 44 ff ff ff       	jmp    56b <printf+0x5b>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 630:	8b 45 d0             	mov    -0x30(%ebp),%eax
 633:	8b 10                	mov    (%eax),%edx
        ap++;
 635:	83 c0 04             	add    $0x4,%eax
 638:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 63b:	85 d2                	test   %edx,%edx
 63d:	0f 84 aa 00 00 00    	je     6ed <printf+0x1dd>
        while(*s != 0){
 643:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 646:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 648:	84 c0                	test   %al,%al
 64a:	74 27                	je     673 <printf+0x163>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 650:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 653:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 658:	43                   	inc    %ebx
  write(fd, &c, 1);
 659:	89 44 24 08          	mov    %eax,0x8(%esp)
 65d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 660:	89 44 24 04          	mov    %eax,0x4(%esp)
 664:	89 3c 24             	mov    %edi,(%esp)
 667:	e8 5c fd ff ff       	call   3c8 <write>
        while(*s != 0){
 66c:	0f b6 03             	movzbl (%ebx),%eax
 66f:	84 c0                	test   %al,%al
 671:	75 dd                	jne    650 <printf+0x140>
      state = 0;
 673:	31 d2                	xor    %edx,%edx
 675:	e9 f1 fe ff ff       	jmp    56b <printf+0x5b>
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 680:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 687:	b9 0a 00 00 00       	mov    $0xa,%ecx
 68c:	e9 7b ff ff ff       	jmp    60c <printf+0xfc>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 698:	b9 01 00 00 00       	mov    $0x1,%ecx
 69d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6a0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a8:	89 3c 24             	mov    %edi,(%esp)
 6ab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6ae:	e8 15 fd ff ff       	call   3c8 <write>
      state = 0;
 6b3:	31 d2                	xor    %edx,%edx
 6b5:	e9 b1 fe ff ff       	jmp    56b <printf+0x5b>
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 6c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6c3:	8b 03                	mov    (%ebx),%eax
        ap++;
 6c5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6c8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 6cb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6ce:	b8 01 00 00 00       	mov    $0x1,%eax
 6d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6d7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6da:	89 44 24 04          	mov    %eax,0x4(%esp)
 6de:	e8 e5 fc ff ff       	call   3c8 <write>
      state = 0;
 6e3:	31 d2                	xor    %edx,%edx
        ap++;
 6e5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6e8:	e9 7e fe ff ff       	jmp    56b <printf+0x5b>
          s = "(null)";
 6ed:	bb ab 08 00 00       	mov    $0x8ab,%ebx
        while(*s != 0){
 6f2:	b0 28                	mov    $0x28,%al
 6f4:	e9 57 ff ff ff       	jmp    650 <printf+0x140>
 6f9:	66 90                	xchg   %ax,%ax
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 6c 0b 00 00       	mov    0xb6c,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 711:	eb 0d                	jmp    720 <free+0x20>
 713:	90                   	nop
 714:	90                   	nop
 715:	90                   	nop
 716:	90                   	nop
 717:	90                   	nop
 718:	90                   	nop
 719:	90                   	nop
 71a:	90                   	nop
 71b:	90                   	nop
 71c:	90                   	nop
 71d:	90                   	nop
 71e:	90                   	nop
 71f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 720:	39 c8                	cmp    %ecx,%eax
 722:	8b 10                	mov    (%eax),%edx
 724:	73 32                	jae    758 <free+0x58>
 726:	39 d1                	cmp    %edx,%ecx
 728:	72 04                	jb     72e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72a:	39 d0                	cmp    %edx,%eax
 72c:	72 32                	jb     760 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 72e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 731:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 734:	39 fa                	cmp    %edi,%edx
 736:	74 30                	je     768 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 738:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 73b:	8b 50 04             	mov    0x4(%eax),%edx
 73e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 741:	39 f1                	cmp    %esi,%ecx
 743:	74 3c                	je     781 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 745:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 747:	5b                   	pop    %ebx
  freep = p;
 748:	a3 6c 0b 00 00       	mov    %eax,0xb6c
}
 74d:	5e                   	pop    %esi
 74e:	5f                   	pop    %edi
 74f:	5d                   	pop    %ebp
 750:	c3                   	ret    
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 d0                	cmp    %edx,%eax
 75a:	72 04                	jb     760 <free+0x60>
 75c:	39 d1                	cmp    %edx,%ecx
 75e:	72 ce                	jb     72e <free+0x2e>
{
 760:	89 d0                	mov    %edx,%eax
 762:	eb bc                	jmp    720 <free+0x20>
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 768:	8b 7a 04             	mov    0x4(%edx),%edi
 76b:	01 fe                	add    %edi,%esi
 76d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 770:	8b 10                	mov    (%eax),%edx
 772:	8b 12                	mov    (%edx),%edx
 774:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 777:	8b 50 04             	mov    0x4(%eax),%edx
 77a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 77d:	39 f1                	cmp    %esi,%ecx
 77f:	75 c4                	jne    745 <free+0x45>
    p->s.size += bp->s.size;
 781:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 784:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    p->s.size += bp->s.size;
 789:	01 ca                	add    %ecx,%edx
 78b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 78e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 791:	89 10                	mov    %edx,(%eax)
}
 793:	5b                   	pop    %ebx
 794:	5e                   	pop    %esi
 795:	5f                   	pop    %edi
 796:	5d                   	pop    %ebp
 797:	c3                   	ret    
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 15 6c 0b 00 00    	mov    0xb6c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8d 78 07             	lea    0x7(%eax),%edi
 7b5:	c1 ef 03             	shr    $0x3,%edi
 7b8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7b9:	85 d2                	test   %edx,%edx
 7bb:	0f 84 8f 00 00 00    	je     850 <malloc+0xb0>
 7c1:	8b 02                	mov    (%edx),%eax
 7c3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7c6:	39 cf                	cmp    %ecx,%edi
 7c8:	76 66                	jbe    830 <malloc+0x90>
 7ca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7d0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7d5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7d8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7df:	eb 10                	jmp    7f1 <malloc+0x51>
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ea:	8b 48 04             	mov    0x4(%eax),%ecx
 7ed:	39 f9                	cmp    %edi,%ecx
 7ef:	73 3f                	jae    830 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f1:	39 05 6c 0b 00 00    	cmp    %eax,0xb6c
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	75 ed                	jne    7e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7fb:	89 34 24             	mov    %esi,(%esp)
 7fe:	e8 2d fc ff ff       	call   430 <sbrk>
  if(p == (char*)-1)
 803:	83 f8 ff             	cmp    $0xffffffff,%eax
 806:	74 18                	je     820 <malloc+0x80>
  hp->s.size = nu;
 808:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 80b:	83 c0 08             	add    $0x8,%eax
 80e:	89 04 24             	mov    %eax,(%esp)
 811:	e8 ea fe ff ff       	call   700 <free>
  return freep;
 816:	8b 15 6c 0b 00 00    	mov    0xb6c,%edx
      if((p = morecore(nunits)) == 0)
 81c:	85 d2                	test   %edx,%edx
 81e:	75 c8                	jne    7e8 <malloc+0x48>
        return 0;
  }
}
 820:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 823:	31 c0                	xor    %eax,%eax
}
 825:	5b                   	pop    %ebx
 826:	5e                   	pop    %esi
 827:	5f                   	pop    %edi
 828:	5d                   	pop    %ebp
 829:	c3                   	ret    
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 830:	39 cf                	cmp    %ecx,%edi
 832:	74 4c                	je     880 <malloc+0xe0>
        p->s.size -= nunits;
 834:	29 f9                	sub    %edi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 83f:	89 15 6c 0b 00 00    	mov    %edx,0xb6c
}
 845:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 848:	83 c0 08             	add    $0x8,%eax
}
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 850:	b8 70 0b 00 00       	mov    $0xb70,%eax
 855:	ba 70 0b 00 00       	mov    $0xb70,%edx
    base.s.size = 0;
 85a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 85c:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    base.s.size = 0;
 861:	b8 70 0b 00 00       	mov    $0xb70,%eax
    base.s.ptr = freep = prevp = &base;
 866:	89 15 70 0b 00 00    	mov    %edx,0xb70
    base.s.size = 0;
 86c:	89 0d 74 0b 00 00    	mov    %ecx,0xb74
 872:	e9 53 ff ff ff       	jmp    7ca <malloc+0x2a>
 877:	89 f6                	mov    %esi,%esi
 879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b9                	jmp    83f <malloc+0x9f>
