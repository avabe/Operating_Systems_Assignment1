
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 78                	jle    8c <main+0x8c>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 03                	mov    (%ebx),%eax
  28:	89 04 24             	mov    %eax,(%esp)
  2b:	e8 28 04 00 00       	call   458 <open>
  30:	85 c0                	test   %eax,%eax
  32:	78 32                	js     66 <main+0x66>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
  34:	8b 13                	mov    (%ebx),%edx
  for(i = 1; i < argc; i++){
  36:	46                   	inc    %esi
  37:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	e8 66 00 00 00       	call   b0 <wc>
    close(fd);
  4a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 ea 03 00 00       	call   440 <close>
  for(i = 1; i < argc; i++){
  56:	39 f7                	cmp    %esi,%edi
  58:	75 c6                	jne    20 <main+0x20>
  }
  exit(0);
  5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  61:	e8 b2 03 00 00       	call   418 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  66:	8b 03                	mov    (%ebx),%eax
  68:	c7 44 24 04 1b 09 00 	movl   $0x91b,0x4(%esp)
  6f:	00 
  70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  77:	89 44 24 08          	mov    %eax,0x8(%esp)
  7b:	e8 00 05 00 00       	call   580 <printf>
      exit(0);
  80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  87:	e8 8c 03 00 00       	call   418 <exit>
    wc(0, "");
  8c:	c7 44 24 04 0d 09 00 	movl   $0x90d,0x4(%esp)
  93:	00 
  94:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9b:	e8 10 00 00 00       	call   b0 <wc>
    exit(0);
  a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a7:	e8 6c 03 00 00       	call   418 <exit>
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <wc>:
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  l = w = c = 0;
  b6:	31 db                	xor    %ebx,%ebx
{
  b8:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  c2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  c9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	ba 00 02 00 00       	mov    $0x200,%edx
  d8:	b9 40 0c 00 00       	mov    $0xc40,%ecx
  dd:	89 54 24 08          	mov    %edx,0x8(%esp)
  e1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  e5:	89 04 24             	mov    %eax,(%esp)
  e8:	e8 43 03 00 00       	call   430 <read>
  ed:	83 f8 00             	cmp    $0x0,%eax
  f0:	89 c6                	mov    %eax,%esi
  f2:	7e 6c                	jle    160 <wc+0xb0>
    for(i=0; i<n; i++){
  f4:	31 ff                	xor    %edi,%edi
  f6:	eb 14                	jmp    10c <wc+0x5c>
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
 100:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
 107:	47                   	inc    %edi
 108:	39 fe                	cmp    %edi,%esi
 10a:	74 44                	je     150 <wc+0xa0>
      if(buf[i] == '\n')
 10c:	0f be 87 40 0c 00 00 	movsbl 0xc40(%edi),%eax
        l++;
 113:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
 115:	c7 04 24 f8 08 00 00 	movl   $0x8f8,(%esp)
        l++;
 11c:	3c 0a                	cmp    $0xa,%al
 11e:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 121:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 125:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 127:	e8 74 01 00 00       	call   2a0 <strchr>
 12c:	85 c0                	test   %eax,%eax
 12e:	75 d0                	jne    100 <wc+0x50>
      else if(!inword){
 130:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 133:	85 c0                	test   %eax,%eax
 135:	75 d0                	jne    107 <wc+0x57>
    for(i=0; i<n; i++){
 137:	47                   	inc    %edi
        w++;
 138:	ff 45 dc             	incl   -0x24(%ebp)
    for(i=0; i<n; i++){
 13b:	39 fe                	cmp    %edi,%esi
        inword = 1;
 13d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 144:	75 c6                	jne    10c <wc+0x5c>
 146:	8d 76 00             	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 150:	01 75 e0             	add    %esi,-0x20(%ebp)
 153:	e9 78 ff ff ff       	jmp    d0 <wc+0x20>
 158:	90                   	nop
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(n < 0){
 160:	75 36                	jne    198 <wc+0xe8>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 162:	8b 45 0c             	mov    0xc(%ebp),%eax
 165:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	89 44 24 14          	mov    %eax,0x14(%esp)
 174:	8b 45 e0             	mov    -0x20(%ebp),%eax
 177:	89 44 24 10          	mov    %eax,0x10(%esp)
 17b:	8b 45 dc             	mov    -0x24(%ebp),%eax
 17e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 182:	b8 0e 09 00 00       	mov    $0x90e,%eax
 187:	89 44 24 04          	mov    %eax,0x4(%esp)
 18b:	e8 f0 03 00 00       	call   580 <printf>
}
 190:	83 c4 3c             	add    $0x3c,%esp
 193:	5b                   	pop    %ebx
 194:	5e                   	pop    %esi
 195:	5f                   	pop    %edi
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
    printf(1, "wc: read error\n");
 198:	c7 44 24 04 fe 08 00 	movl   $0x8fe,0x4(%esp)
 19f:	00 
 1a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a7:	e8 d4 03 00 00       	call   580 <printf>
    exit(0);
 1ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b3:	e8 60 02 00 00       	call   418 <exit>
 1b8:	66 90                	xchg   %ax,%ax
 1ba:	66 90                	xchg   %ax,%ax
 1bc:	66 90                	xchg   %ax,%ax
 1be:	66 90                	xchg   %ax,%ax

000001c0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c9:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	41                   	inc    %ecx
 1d1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1d5:	42                   	inc    %edx
 1d6:	84 db                	test   %bl,%bl
 1d8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1db:	75 f3                	jne    1d0 <strcpy+0x10>
    return os;
}
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
 1e0:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
 1e1:	31 d2                	xor    %edx,%edx
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	56                   	push   %esi
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	53                   	push   %ebx
 1ea:	8b 75 0c             	mov    0xc(%ebp),%esi
 1ed:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
 1f0:	eb 12                	jmp    204 <strncpy+0x24>
 1f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1ff:	42                   	inc    %edx
 200:	84 c9                	test   %cl,%cl
 202:	74 08                	je     20c <strncpy+0x2c>
 204:	89 d9                	mov    %ebx,%ecx
 206:	29 d1                	sub    %edx,%ecx
 208:	85 c9                	test   %ecx,%ecx
 20a:	7f ec                	jg     1f8 <strncpy+0x18>
    return os;
}
 20c:	5b                   	pop    %ebx
 20d:	5e                   	pop    %esi
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    

00000210 <strcmp>:

int
strcmp(const char *p, const char *q) {
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
 216:	53                   	push   %ebx
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
 21a:	0f b6 01             	movzbl (%ecx),%eax
 21d:	0f b6 13             	movzbl (%ebx),%edx
 220:	84 c0                	test   %al,%al
 222:	75 18                	jne    23c <strcmp+0x2c>
 224:	eb 22                	jmp    248 <strcmp+0x38>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
 230:	41                   	inc    %ecx
    while (*p && *p == *q)
 231:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
 234:	43                   	inc    %ebx
 235:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
 238:	84 c0                	test   %al,%al
 23a:	74 0c                	je     248 <strcmp+0x38>
 23c:	38 d0                	cmp    %dl,%al
 23e:	74 f0                	je     230 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
 240:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
 241:	29 d0                	sub    %edx,%eax
}
 243:	5d                   	pop    %ebp
 244:	c3                   	ret    
 245:	8d 76 00             	lea    0x0(%esi),%esi
 248:	5b                   	pop    %ebx
 249:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
 24b:	29 d0                	sub    %edx,%eax
}
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <strlen>:

uint
strlen(const char *s) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 256:	80 39 00             	cmpb   $0x0,(%ecx)
 259:	74 15                	je     270 <strlen+0x20>
 25b:	31 d2                	xor    %edx,%edx
 25d:	8d 76 00             	lea    0x0(%esi),%esi
 260:	42                   	inc    %edx
 261:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 265:	89 d0                	mov    %edx,%eax
 267:	75 f7                	jne    260 <strlen+0x10>
    return n;
}
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	90                   	nop
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 270:	31 c0                	xor    %eax,%eax
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 27a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000280 <memset>:

void *
memset(void *dst, int c, uint n) {
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 55 08             	mov    0x8(%ebp),%edx
 286:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 287:	8b 4d 10             	mov    0x10(%ebp),%ecx
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	89 d7                	mov    %edx,%edi
 28f:	fc                   	cld    
 290:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 292:	5f                   	pop    %edi
 293:	89 d0                	mov    %edx,%eax
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <strchr>:

char *
strchr(const char *s, char c) {
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 2aa:	0f b6 10             	movzbl (%eax),%edx
 2ad:	84 d2                	test   %dl,%dl
 2af:	74 1b                	je     2cc <strchr+0x2c>
        if (*s == c)
 2b1:	38 d1                	cmp    %dl,%cl
 2b3:	75 0f                	jne    2c4 <strchr+0x24>
 2b5:	eb 17                	jmp    2ce <strchr+0x2e>
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 2c0:	38 ca                	cmp    %cl,%dl
 2c2:	74 0a                	je     2ce <strchr+0x2e>
    for (; *s; s++)
 2c4:	40                   	inc    %eax
 2c5:	0f b6 10             	movzbl (%eax),%edx
 2c8:	84 d2                	test   %dl,%dl
 2ca:	75 f4                	jne    2c0 <strchr+0x20>
            return (char *) s;
    return 0;
 2cc:	31 c0                	xor    %eax,%eax
}
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    

000002d0 <gets>:

char *
gets(char *buf, int max) {
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 2d5:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 2d7:	53                   	push   %ebx
 2d8:	83 ec 3c             	sub    $0x3c,%esp
 2db:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 2de:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 2e1:	eb 32                	jmp    315 <gets+0x45>
 2e3:	90                   	nop
 2e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 2e8:	ba 01 00 00 00       	mov    $0x1,%edx
 2ed:	89 54 24 08          	mov    %edx,0x8(%esp)
 2f1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2fc:	e8 2f 01 00 00       	call   430 <read>
        if (cc < 1)
 301:	85 c0                	test   %eax,%eax
 303:	7e 19                	jle    31e <gets+0x4e>
            break;
        buf[i++] = c;
 305:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 309:	43                   	inc    %ebx
 30a:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 30d:	3c 0a                	cmp    $0xa,%al
 30f:	74 1f                	je     330 <gets+0x60>
 311:	3c 0d                	cmp    $0xd,%al
 313:	74 1b                	je     330 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 315:	46                   	inc    %esi
 316:	3b 75 0c             	cmp    0xc(%ebp),%esi
 319:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 31c:	7c ca                	jl     2e8 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 31e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 321:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	83 c4 3c             	add    $0x3c,%esp
 32a:	5b                   	pop    %ebx
 32b:	5e                   	pop    %esi
 32c:	5f                   	pop    %edi
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
 32f:	90                   	nop
 330:	8b 45 08             	mov    0x8(%ebp),%eax
 333:	01 c6                	add    %eax,%esi
 335:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 338:	eb e4                	jmp    31e <gets+0x4e>
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <stat>:

int
stat(const char *n, struct stat *st) {
 340:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 341:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 343:	89 e5                	mov    %esp,%ebp
 345:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 348:	89 44 24 04          	mov    %eax,0x4(%esp)
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 34f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 352:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 355:	89 04 24             	mov    %eax,(%esp)
 358:	e8 fb 00 00 00       	call   458 <open>
    if (fd < 0)
 35d:	85 c0                	test   %eax,%eax
 35f:	78 2f                	js     390 <stat+0x50>
 361:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 363:	8b 45 0c             	mov    0xc(%ebp),%eax
 366:	89 1c 24             	mov    %ebx,(%esp)
 369:	89 44 24 04          	mov    %eax,0x4(%esp)
 36d:	e8 fe 00 00 00       	call   470 <fstat>
    close(fd);
 372:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 375:	89 c6                	mov    %eax,%esi
    close(fd);
 377:	e8 c4 00 00 00       	call   440 <close>
    return r;
}
 37c:	89 f0                	mov    %esi,%eax
 37e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 381:	8b 75 fc             	mov    -0x4(%ebp),%esi
 384:	89 ec                	mov    %ebp,%esp
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 390:	be ff ff ff ff       	mov    $0xffffffff,%esi
 395:	eb e5                	jmp    37c <stat+0x3c>
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <atoi>:

int
atoi(const char *s) {
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 3a7:	0f be 11             	movsbl (%ecx),%edx
 3aa:	88 d0                	mov    %dl,%al
 3ac:	2c 30                	sub    $0x30,%al
 3ae:	3c 09                	cmp    $0x9,%al
    n = 0;
 3b0:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 3b5:	77 1e                	ja     3d5 <atoi+0x35>
 3b7:	89 f6                	mov    %esi,%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 3c0:	41                   	inc    %ecx
 3c1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3c4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 3c8:	0f be 11             	movsbl (%ecx),%edx
 3cb:	88 d3                	mov    %dl,%bl
 3cd:	80 eb 30             	sub    $0x30,%bl
 3d0:	80 fb 09             	cmp    $0x9,%bl
 3d3:	76 eb                	jbe    3c0 <atoi+0x20>
    return n;
}
 3d5:	5b                   	pop    %ebx
 3d6:	5d                   	pop    %ebp
 3d7:	c3                   	ret    
 3d8:	90                   	nop
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	53                   	push   %ebx
 3e8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3eb:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 3ee:	85 db                	test   %ebx,%ebx
 3f0:	7e 1a                	jle    40c <memmove+0x2c>
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 400:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 404:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 407:	42                   	inc    %edx
    while (n-- > 0)
 408:	39 d3                	cmp    %edx,%ebx
 40a:	75 f4                	jne    400 <memmove+0x20>
    return vdst;
}
 40c:	5b                   	pop    %ebx
 40d:	5e                   	pop    %esi
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 410:	b8 01 00 00 00       	mov    $0x1,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <exit>:
SYSCALL(exit)
 418:	b8 02 00 00 00       	mov    $0x2,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait>:
SYSCALL(wait)
 420:	b8 03 00 00 00       	mov    $0x3,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <pipe>:
SYSCALL(pipe)
 428:	b8 04 00 00 00       	mov    $0x4,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <read>:
SYSCALL(read)
 430:	b8 05 00 00 00       	mov    $0x5,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <write>:
SYSCALL(write)
 438:	b8 10 00 00 00       	mov    $0x10,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <close>:
SYSCALL(close)
 440:	b8 15 00 00 00       	mov    $0x15,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <kill>:
SYSCALL(kill)
 448:	b8 06 00 00 00       	mov    $0x6,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <exec>:
SYSCALL(exec)
 450:	b8 07 00 00 00       	mov    $0x7,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <open>:
SYSCALL(open)
 458:	b8 0f 00 00 00       	mov    $0xf,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mknod>:
SYSCALL(mknod)
 460:	b8 11 00 00 00       	mov    $0x11,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <unlink>:
SYSCALL(unlink)
 468:	b8 12 00 00 00       	mov    $0x12,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <fstat>:
SYSCALL(fstat)
 470:	b8 08 00 00 00       	mov    $0x8,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <link>:
SYSCALL(link)
 478:	b8 13 00 00 00       	mov    $0x13,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <mkdir>:
SYSCALL(mkdir)
 480:	b8 14 00 00 00       	mov    $0x14,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <chdir>:
SYSCALL(chdir)
 488:	b8 09 00 00 00       	mov    $0x9,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <dup>:
SYSCALL(dup)
 490:	b8 0a 00 00 00       	mov    $0xa,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <getpid>:
SYSCALL(getpid)
 498:	b8 0b 00 00 00       	mov    $0xb,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <sbrk>:
SYSCALL(sbrk)
 4a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <sleep>:
SYSCALL(sleep)
 4a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <uptime>:
SYSCALL(uptime)
 4b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <detach>:
SYSCALL(detach)
 4b8:	b8 16 00 00 00       	mov    $0x16,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <priority>:
SYSCALL(priority)
 4c0:	b8 17 00 00 00       	mov    $0x17,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <policy>:
SYSCALL(policy)
 4c8:	b8 18 00 00 00       	mov    $0x18,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <wait_stat>:
SYSCALL(wait_stat)
 4d0:	b8 19 00 00 00       	mov    $0x19,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    
 4d8:	66 90                	xchg   %ax,%ax
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e6:	89 d3                	mov    %edx,%ebx
 4e8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 4eb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 4ee:	84 db                	test   %bl,%bl
{
 4f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4f3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 4f5:	74 79                	je     570 <printint+0x90>
 4f7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4fb:	74 73                	je     570 <printint+0x90>
    neg = 1;
    x = -xx;
 4fd:	f7 d8                	neg    %eax
    neg = 1;
 4ff:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 506:	31 f6                	xor    %esi,%esi
 508:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 50b:	eb 05                	jmp    512 <printint+0x32>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 510:	89 fe                	mov    %edi,%esi
 512:	31 d2                	xor    %edx,%edx
 514:	f7 f1                	div    %ecx
 516:	8d 7e 01             	lea    0x1(%esi),%edi
 519:	0f b6 92 38 09 00 00 	movzbl 0x938(%edx),%edx
  }while((x /= base) != 0);
 520:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 522:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 525:	75 e9                	jne    510 <printint+0x30>
  if(neg)
 527:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 52a:	85 d2                	test   %edx,%edx
 52c:	74 08                	je     536 <printint+0x56>
    buf[i++] = '-';
 52e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 533:	8d 7e 02             	lea    0x2(%esi),%edi
 536:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 53a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 53d:	8d 76 00             	lea    0x0(%esi),%esi
 540:	0f b6 06             	movzbl (%esi),%eax
 543:	4e                   	dec    %esi
  write(fd, &c, 1);
 544:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 548:	89 3c 24             	mov    %edi,(%esp)
 54b:	88 45 d7             	mov    %al,-0x29(%ebp)
 54e:	b8 01 00 00 00       	mov    $0x1,%eax
 553:	89 44 24 08          	mov    %eax,0x8(%esp)
 557:	e8 dc fe ff ff       	call   438 <write>

  while(--i >= 0)
 55c:	39 de                	cmp    %ebx,%esi
 55e:	75 e0                	jne    540 <printint+0x60>
    putc(fd, buf[i]);
}
 560:	83 c4 4c             	add    $0x4c,%esp
 563:	5b                   	pop    %ebx
 564:	5e                   	pop    %esi
 565:	5f                   	pop    %edi
 566:	5d                   	pop    %ebp
 567:	c3                   	ret    
 568:	90                   	nop
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 570:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 577:	eb 8d                	jmp    506 <printint+0x26>
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 589:	8b 75 0c             	mov    0xc(%ebp),%esi
 58c:	0f b6 1e             	movzbl (%esi),%ebx
 58f:	84 db                	test   %bl,%bl
 591:	0f 84 d1 00 00 00    	je     668 <printf+0xe8>
  state = 0;
 597:	31 ff                	xor    %edi,%edi
 599:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 59a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 59d:	89 fa                	mov    %edi,%edx
 59f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 5a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a5:	eb 41                	jmp    5e8 <printf+0x68>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b0:	83 f8 25             	cmp    $0x25,%eax
 5b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 5b6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5bb:	74 1e                	je     5db <printf+0x5b>
  write(fd, &c, 1);
 5bd:	b8 01 00 00 00       	mov    $0x1,%eax
 5c2:	89 44 24 08          	mov    %eax,0x8(%esp)
 5c6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 3c 24             	mov    %edi,(%esp)
 5d0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5d3:	e8 60 fe ff ff       	call   438 <write>
 5d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5db:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 5dc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5e0:	84 db                	test   %bl,%bl
 5e2:	0f 84 80 00 00 00    	je     668 <printf+0xe8>
    if(state == 0){
 5e8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 5ea:	0f be cb             	movsbl %bl,%ecx
 5ed:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5f0:	74 be                	je     5b0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f2:	83 fa 25             	cmp    $0x25,%edx
 5f5:	75 e4                	jne    5db <printf+0x5b>
      if(c == 'd'){
 5f7:	83 f8 64             	cmp    $0x64,%eax
 5fa:	0f 84 f0 00 00 00    	je     6f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 600:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 606:	83 f9 70             	cmp    $0x70,%ecx
 609:	74 65                	je     670 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 60b:	83 f8 73             	cmp    $0x73,%eax
 60e:	0f 84 8c 00 00 00    	je     6a0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 614:	83 f8 63             	cmp    $0x63,%eax
 617:	0f 84 13 01 00 00    	je     730 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 61d:	83 f8 25             	cmp    $0x25,%eax
 620:	0f 84 e2 00 00 00    	je     708 <printf+0x188>
  write(fd, &c, 1);
 626:	b8 01 00 00 00       	mov    $0x1,%eax
 62b:	46                   	inc    %esi
 62c:	89 44 24 08          	mov    %eax,0x8(%esp)
 630:	8d 45 e7             	lea    -0x19(%ebp),%eax
 633:	89 44 24 04          	mov    %eax,0x4(%esp)
 637:	89 3c 24             	mov    %edi,(%esp)
 63a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 63e:	e8 f5 fd ff ff       	call   438 <write>
 643:	ba 01 00 00 00       	mov    $0x1,%edx
 648:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 64b:	89 54 24 08          	mov    %edx,0x8(%esp)
 64f:	89 44 24 04          	mov    %eax,0x4(%esp)
 653:	89 3c 24             	mov    %edi,(%esp)
 656:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 659:	e8 da fd ff ff       	call   438 <write>
  for(i = 0; fmt[i]; i++){
 65e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 662:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 664:	84 db                	test   %bl,%bl
 666:	75 80                	jne    5e8 <printf+0x68>
    }
  }
}
 668:	83 c4 3c             	add    $0x3c,%esp
 66b:	5b                   	pop    %ebx
 66c:	5e                   	pop    %esi
 66d:	5f                   	pop    %edi
 66e:	5d                   	pop    %ebp
 66f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 670:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 677:	b9 10 00 00 00       	mov    $0x10,%ecx
 67c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 67f:	89 f8                	mov    %edi,%eax
 681:	8b 13                	mov    (%ebx),%edx
 683:	e8 58 fe ff ff       	call   4e0 <printint>
        ap++;
 688:	89 d8                	mov    %ebx,%eax
      state = 0;
 68a:	31 d2                	xor    %edx,%edx
        ap++;
 68c:	83 c0 04             	add    $0x4,%eax
 68f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 692:	e9 44 ff ff ff       	jmp    5db <printf+0x5b>
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 6a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6a3:	8b 10                	mov    (%eax),%edx
        ap++;
 6a5:	83 c0 04             	add    $0x4,%eax
 6a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6ab:	85 d2                	test   %edx,%edx
 6ad:	0f 84 aa 00 00 00    	je     75d <printf+0x1dd>
        while(*s != 0){
 6b3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 6b6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 6b8:	84 c0                	test   %al,%al
 6ba:	74 27                	je     6e3 <printf+0x163>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6c3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6c8:	43                   	inc    %ebx
  write(fd, &c, 1);
 6c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6cd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d4:	89 3c 24             	mov    %edi,(%esp)
 6d7:	e8 5c fd ff ff       	call   438 <write>
        while(*s != 0){
 6dc:	0f b6 03             	movzbl (%ebx),%eax
 6df:	84 c0                	test   %al,%al
 6e1:	75 dd                	jne    6c0 <printf+0x140>
      state = 0;
 6e3:	31 d2                	xor    %edx,%edx
 6e5:	e9 f1 fe ff ff       	jmp    5db <printf+0x5b>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6fc:	e9 7b ff ff ff       	jmp    67c <printf+0xfc>
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 708:	b9 01 00 00 00       	mov    $0x1,%ecx
 70d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 710:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 714:	89 44 24 04          	mov    %eax,0x4(%esp)
 718:	89 3c 24             	mov    %edi,(%esp)
 71b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 71e:	e8 15 fd ff ff       	call   438 <write>
      state = 0;
 723:	31 d2                	xor    %edx,%edx
 725:	e9 b1 fe ff ff       	jmp    5db <printf+0x5b>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 730:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 733:	8b 03                	mov    (%ebx),%eax
        ap++;
 735:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 738:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 73b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 73e:	b8 01 00 00 00       	mov    $0x1,%eax
 743:	89 44 24 08          	mov    %eax,0x8(%esp)
 747:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 74a:	89 44 24 04          	mov    %eax,0x4(%esp)
 74e:	e8 e5 fc ff ff       	call   438 <write>
      state = 0;
 753:	31 d2                	xor    %edx,%edx
        ap++;
 755:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 758:	e9 7e fe ff ff       	jmp    5db <printf+0x5b>
          s = "(null)";
 75d:	bb 2f 09 00 00       	mov    $0x92f,%ebx
        while(*s != 0){
 762:	b0 28                	mov    $0x28,%al
 764:	e9 57 ff ff ff       	jmp    6c0 <printf+0x140>
 769:	66 90                	xchg   %ax,%ax
 76b:	66 90                	xchg   %ax,%ax
 76d:	66 90                	xchg   %ax,%ax
 76f:	90                   	nop

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	a1 20 0c 00 00       	mov    0xc20,%eax
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 77e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 781:	eb 0d                	jmp    790 <free+0x20>
 783:	90                   	nop
 784:	90                   	nop
 785:	90                   	nop
 786:	90                   	nop
 787:	90                   	nop
 788:	90                   	nop
 789:	90                   	nop
 78a:	90                   	nop
 78b:	90                   	nop
 78c:	90                   	nop
 78d:	90                   	nop
 78e:	90                   	nop
 78f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 790:	39 c8                	cmp    %ecx,%eax
 792:	8b 10                	mov    (%eax),%edx
 794:	73 32                	jae    7c8 <free+0x58>
 796:	39 d1                	cmp    %edx,%ecx
 798:	72 04                	jb     79e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79a:	39 d0                	cmp    %edx,%eax
 79c:	72 32                	jb     7d0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 79e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7a1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7a4:	39 fa                	cmp    %edi,%edx
 7a6:	74 30                	je     7d8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7a8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ab:	8b 50 04             	mov    0x4(%eax),%edx
 7ae:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b1:	39 f1                	cmp    %esi,%ecx
 7b3:	74 3c                	je     7f1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7b5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7b7:	5b                   	pop    %ebx
  freep = p;
 7b8:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 7bd:	5e                   	pop    %esi
 7be:	5f                   	pop    %edi
 7bf:	5d                   	pop    %ebp
 7c0:	c3                   	ret    
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c8:	39 d0                	cmp    %edx,%eax
 7ca:	72 04                	jb     7d0 <free+0x60>
 7cc:	39 d1                	cmp    %edx,%ecx
 7ce:	72 ce                	jb     79e <free+0x2e>
{
 7d0:	89 d0                	mov    %edx,%eax
 7d2:	eb bc                	jmp    790 <free+0x20>
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7d8:	8b 7a 04             	mov    0x4(%edx),%edi
 7db:	01 fe                	add    %edi,%esi
 7dd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e0:	8b 10                	mov    (%eax),%edx
 7e2:	8b 12                	mov    (%edx),%edx
 7e4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7e7:	8b 50 04             	mov    0x4(%eax),%edx
 7ea:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7ed:	39 f1                	cmp    %esi,%ecx
 7ef:	75 c4                	jne    7b5 <free+0x45>
    p->s.size += bp->s.size;
 7f1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 7f4:	a3 20 0c 00 00       	mov    %eax,0xc20
    p->s.size += bp->s.size;
 7f9:	01 ca                	add    %ecx,%edx
 7fb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fe:	8b 53 f8             	mov    -0x8(%ebx),%edx
 801:	89 10                	mov    %edx,(%eax)
}
 803:	5b                   	pop    %ebx
 804:	5e                   	pop    %esi
 805:	5f                   	pop    %edi
 806:	5d                   	pop    %ebp
 807:	c3                   	ret    
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 15 20 0c 00 00    	mov    0xc20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 78 07             	lea    0x7(%eax),%edi
 825:	c1 ef 03             	shr    $0x3,%edi
 828:	47                   	inc    %edi
  if((prevp = freep) == 0){
 829:	85 d2                	test   %edx,%edx
 82b:	0f 84 8f 00 00 00    	je     8c0 <malloc+0xb0>
 831:	8b 02                	mov    (%edx),%eax
 833:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 836:	39 cf                	cmp    %ecx,%edi
 838:	76 66                	jbe    8a0 <malloc+0x90>
 83a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 840:	bb 00 10 00 00       	mov    $0x1000,%ebx
 845:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 848:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 84f:	eb 10                	jmp    861 <malloc+0x51>
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 85a:	8b 48 04             	mov    0x4(%eax),%ecx
 85d:	39 f9                	cmp    %edi,%ecx
 85f:	73 3f                	jae    8a0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 05 20 0c 00 00    	cmp    %eax,0xc20
 867:	89 c2                	mov    %eax,%edx
 869:	75 ed                	jne    858 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 86b:	89 34 24             	mov    %esi,(%esp)
 86e:	e8 2d fc ff ff       	call   4a0 <sbrk>
  if(p == (char*)-1)
 873:	83 f8 ff             	cmp    $0xffffffff,%eax
 876:	74 18                	je     890 <malloc+0x80>
  hp->s.size = nu;
 878:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 87b:	83 c0 08             	add    $0x8,%eax
 87e:	89 04 24             	mov    %eax,(%esp)
 881:	e8 ea fe ff ff       	call   770 <free>
  return freep;
 886:	8b 15 20 0c 00 00    	mov    0xc20,%edx
      if((p = morecore(nunits)) == 0)
 88c:	85 d2                	test   %edx,%edx
 88e:	75 c8                	jne    858 <malloc+0x48>
        return 0;
  }
}
 890:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 893:	31 c0                	xor    %eax,%eax
}
 895:	5b                   	pop    %ebx
 896:	5e                   	pop    %esi
 897:	5f                   	pop    %edi
 898:	5d                   	pop    %ebp
 899:	c3                   	ret    
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8a0:	39 cf                	cmp    %ecx,%edi
 8a2:	74 4c                	je     8f0 <malloc+0xe0>
        p->s.size -= nunits;
 8a4:	29 f9                	sub    %edi,%ecx
 8a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8ac:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8af:	89 15 20 0c 00 00    	mov    %edx,0xc20
}
 8b5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 8b8:	83 c0 08             	add    $0x8,%eax
}
 8bb:	5b                   	pop    %ebx
 8bc:	5e                   	pop    %esi
 8bd:	5f                   	pop    %edi
 8be:	5d                   	pop    %ebp
 8bf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 8c0:	b8 24 0c 00 00       	mov    $0xc24,%eax
 8c5:	ba 24 0c 00 00       	mov    $0xc24,%edx
    base.s.size = 0;
 8ca:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 8cc:	a3 20 0c 00 00       	mov    %eax,0xc20
    base.s.size = 0;
 8d1:	b8 24 0c 00 00       	mov    $0xc24,%eax
    base.s.ptr = freep = prevp = &base;
 8d6:	89 15 24 0c 00 00    	mov    %edx,0xc24
    base.s.size = 0;
 8dc:	89 0d 28 0c 00 00    	mov    %ecx,0xc28
 8e2:	e9 53 ff ff ff       	jmp    83a <malloc+0x2a>
 8e7:	89 f6                	mov    %esi,%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb b9                	jmp    8af <malloc+0x9f>
