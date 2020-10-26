
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
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
  14:	7e 27                	jle    3d <main+0x3d>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 d3 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  2d:	39 f3                	cmp    %esi,%ebx
  2f:	75 ef                	jne    20 <main+0x20>
  exit(0);
  31:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  38:	e8 9b 05 00 00       	call   5d8 <exit>
    ls(".");
  3d:	c7 04 24 00 0b 00 00 	movl   $0xb00,(%esp)
  44:	e8 b7 00 00 00       	call   100 <ls>
    exit(0);
  49:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  50:	e8 83 05 00 00       	call   5d8 <exit>
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	83 ec 10             	sub    $0x10,%esp
  68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  6b:	89 1c 24             	mov    %ebx,(%esp)
  6e:	e8 9d 03 00 00       	call   410 <strlen>
  73:	01 d8                	add    %ebx,%eax
  75:	73 0e                	jae    85 <fmtname+0x25>
  77:	eb 11                	jmp    8a <fmtname+0x2a>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  80:	48                   	dec    %eax
  81:	39 c3                	cmp    %eax,%ebx
  83:	77 05                	ja     8a <fmtname+0x2a>
  85:	80 38 2f             	cmpb   $0x2f,(%eax)
  88:	75 f6                	jne    80 <fmtname+0x20>
  p++;
  8a:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  8d:	89 1c 24             	mov    %ebx,(%esp)
  90:	e8 7b 03 00 00       	call   410 <strlen>
  95:	83 f8 0d             	cmp    $0xd,%eax
  98:	77 54                	ja     ee <fmtname+0x8e>
  memmove(buf, p, strlen(p));
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 6e 03 00 00       	call   410 <strlen>
  a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  a6:	c7 04 24 38 0e 00 00 	movl   $0xe38,(%esp)
  ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  b1:	e8 ea 04 00 00       	call   5a0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 52 03 00 00       	call   410 <strlen>
  be:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c1:	bb 38 0e 00 00       	mov    $0xe38,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  c6:	89 c6                	mov    %eax,%esi
  c8:	e8 43 03 00 00       	call   410 <strlen>
  cd:	ba 0e 00 00 00       	mov    $0xe,%edx
  d2:	29 f2                	sub    %esi,%edx
  d4:	89 54 24 08          	mov    %edx,0x8(%esp)
  d8:	ba 20 00 00 00       	mov    $0x20,%edx
  dd:	89 54 24 04          	mov    %edx,0x4(%esp)
  e1:	05 38 0e 00 00       	add    $0xe38,%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 52 03 00 00       	call   440 <memset>
}
  ee:	83 c4 10             	add    $0x10,%esp
  f1:	89 d8                	mov    %ebx,%eax
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:
{
 100:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	81 ec 88 02 00 00    	sub    $0x288,%esp
 10b:	89 7d fc             	mov    %edi,-0x4(%ebp)
 10e:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 111:	89 44 24 04          	mov    %eax,0x4(%esp)
{
 115:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 118:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((fd = open(path, 0)) < 0){
 11b:	89 3c 24             	mov    %edi,(%esp)
 11e:	e8 f5 04 00 00       	call   618 <open>
 123:	85 c0                	test   %eax,%eax
 125:	78 49                	js     170 <ls+0x70>
  if(fstat(fd, &st) < 0){
 127:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12d:	89 c3                	mov    %eax,%ebx
 12f:	89 74 24 04          	mov    %esi,0x4(%esp)
 133:	89 04 24             	mov    %eax,(%esp)
 136:	e8 f5 04 00 00       	call   630 <fstat>
 13b:	85 c0                	test   %eax,%eax
 13d:	0f 88 dd 00 00 00    	js     220 <ls+0x120>
  switch(st.type){
 143:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 14a:	83 f8 01             	cmp    $0x1,%eax
 14d:	0f 84 9d 00 00 00    	je     1f0 <ls+0xf0>
 153:	83 f8 02             	cmp    $0x2,%eax
 156:	74 48                	je     1a0 <ls+0xa0>
  close(fd);
 158:	89 1c 24             	mov    %ebx,(%esp)
 15b:	e8 a0 04 00 00       	call   600 <close>
}
 160:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 163:	8b 75 f8             	mov    -0x8(%ebp),%esi
 166:	8b 7d fc             	mov    -0x4(%ebp),%edi
 169:	89 ec                	mov    %ebp,%esp
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 170:	89 7c 24 08          	mov    %edi,0x8(%esp)
 174:	bf b8 0a 00 00       	mov    $0xab8,%edi
 179:	89 7c 24 04          	mov    %edi,0x4(%esp)
 17d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 184:	e8 b7 05 00 00       	call   740 <printf>
}
 189:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 18c:	8b 75 f8             	mov    -0x8(%ebp),%esi
 18f:	8b 7d fc             	mov    -0x4(%ebp),%edi
 192:	89 ec                	mov    %ebp,%esp
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    
 196:	8d 76 00             	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 1a0:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 1a6:	89 3c 24             	mov    %edi,(%esp)
 1a9:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 1af:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 1b5:	e8 a6 fe ff ff       	call   60 <fmtname>
 1ba:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1c0:	b9 e0 0a 00 00       	mov    $0xae0,%ecx
 1c5:	89 74 24 10          	mov    %esi,0x10(%esp)
 1c9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1d4:	89 54 24 14          	mov    %edx,0x14(%esp)
 1d8:	ba 02 00 00 00       	mov    $0x2,%edx
 1dd:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1e1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e5:	e8 56 05 00 00       	call   740 <printf>
    break;
 1ea:	e9 69 ff ff ff       	jmp    158 <ls+0x58>
 1ef:	90                   	nop
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1f0:	89 3c 24             	mov    %edi,(%esp)
 1f3:	e8 18 02 00 00       	call   410 <strlen>
 1f8:	83 c0 10             	add    $0x10,%eax
 1fb:	3d 00 02 00 00       	cmp    $0x200,%eax
 200:	76 4e                	jbe    250 <ls+0x150>
      printf(1, "ls: path too long\n");
 202:	b8 ed 0a 00 00       	mov    $0xaed,%eax
 207:	89 44 24 04          	mov    %eax,0x4(%esp)
 20b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 212:	e8 29 05 00 00       	call   740 <printf>
      break;
 217:	e9 3c ff ff ff       	jmp    158 <ls+0x58>
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot stat %s\n", path);
 220:	be cc 0a 00 00       	mov    $0xacc,%esi
 225:	89 7c 24 08          	mov    %edi,0x8(%esp)
 229:	89 74 24 04          	mov    %esi,0x4(%esp)
 22d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 234:	e8 07 05 00 00       	call   740 <printf>
    close(fd);
 239:	89 1c 24             	mov    %ebx,(%esp)
 23c:	e8 bf 03 00 00       	call   600 <close>
}
 241:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 244:	8b 75 f8             	mov    -0x8(%ebp),%esi
 247:	8b 7d fc             	mov    -0x4(%ebp),%edi
 24a:	89 ec                	mov    %ebp,%esp
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    
 24e:	66 90                	xchg   %ax,%ax
    strcpy(buf, path);
 250:	89 7c 24 04          	mov    %edi,0x4(%esp)
 254:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 25a:	89 3c 24             	mov    %edi,(%esp)
 25d:	e8 1e 01 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 262:	89 3c 24             	mov    %edi,(%esp)
 265:	e8 a6 01 00 00       	call   410 <strlen>
 26a:	01 f8                	add    %edi,%eax
    *p++ = '/';
 26c:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 26f:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 275:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 27b:	c6 00 2f             	movb   $0x2f,(%eax)
 27e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 280:	b8 10 00 00 00       	mov    $0x10,%eax
 285:	89 44 24 08          	mov    %eax,0x8(%esp)
 289:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 28f:	89 44 24 04          	mov    %eax,0x4(%esp)
 293:	89 1c 24             	mov    %ebx,(%esp)
 296:	e8 55 03 00 00       	call   5f0 <read>
 29b:	83 f8 10             	cmp    $0x10,%eax
 29e:	0f 85 b4 fe ff ff    	jne    158 <ls+0x58>
      if(de.inum == 0)
 2a4:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 2ab:	00 
 2ac:	74 d2                	je     280 <ls+0x180>
      memmove(p, de.name, DIRSIZ);
 2ae:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b7:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 2bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c1:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 2c7:	89 04 24             	mov    %eax,(%esp)
 2ca:	e8 d1 02 00 00       	call   5a0 <memmove>
      p[DIRSIZ] = 0;
 2cf:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 2d5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2d9:	89 74 24 04          	mov    %esi,0x4(%esp)
 2dd:	89 3c 24             	mov    %edi,(%esp)
 2e0:	e8 1b 02 00 00       	call   500 <stat>
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 6f                	js     358 <ls+0x258>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2e9:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2ef:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2f5:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2fc:	89 3c 24             	mov    %edi,(%esp)
 2ff:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 305:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 30b:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 311:	e8 4a fd ff ff       	call   60 <fmtname>
 316:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 31c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 322:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 329:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 32d:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 333:	89 54 24 10          	mov    %edx,0x10(%esp)
 337:	ba e0 0a 00 00       	mov    $0xae0,%edx
 33c:	89 44 24 08          	mov    %eax,0x8(%esp)
 340:	89 54 24 04          	mov    %edx,0x4(%esp)
 344:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 348:	e8 f3 03 00 00       	call   740 <printf>
 34d:	e9 2e ff ff ff       	jmp    280 <ls+0x180>
 352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 358:	b9 cc 0a 00 00       	mov    $0xacc,%ecx
 35d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 361:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 365:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 36c:	e8 cf 03 00 00       	call   740 <printf>
        continue;
 371:	e9 0a ff ff ff       	jmp    280 <ls+0x180>
 376:	66 90                	xchg   %ax,%ax
 378:	66 90                	xchg   %ax,%ax
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 389:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
 38a:	89 c2                	mov    %eax,%edx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	41                   	inc    %ecx
 391:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 395:	42                   	inc    %edx
 396:	84 db                	test   %bl,%bl
 398:	88 5a ff             	mov    %bl,-0x1(%edx)
 39b:	75 f3                	jne    390 <strcpy+0x10>
    return os;
}
 39d:	5b                   	pop    %ebx
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
 3a0:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
 3a1:	31 d2                	xor    %edx,%edx
{
 3a3:	89 e5                	mov    %esp,%ebp
 3a5:	56                   	push   %esi
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	53                   	push   %ebx
 3aa:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ad:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
 3b0:	eb 12                	jmp    3c4 <strncpy+0x24>
 3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	42                   	inc    %edx
 3c0:	84 c9                	test   %cl,%cl
 3c2:	74 08                	je     3cc <strncpy+0x2c>
 3c4:	89 d9                	mov    %ebx,%ecx
 3c6:	29 d1                	sub    %edx,%ecx
 3c8:	85 c9                	test   %ecx,%ecx
 3ca:	7f ec                	jg     3b8 <strncpy+0x18>
    return os;
}
 3cc:	5b                   	pop    %ebx
 3cd:	5e                   	pop    %esi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <strcmp>:

int
strcmp(const char *p, const char *q) {
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3d6:	53                   	push   %ebx
 3d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
 3da:	0f b6 01             	movzbl (%ecx),%eax
 3dd:	0f b6 13             	movzbl (%ebx),%edx
 3e0:	84 c0                	test   %al,%al
 3e2:	75 18                	jne    3fc <strcmp+0x2c>
 3e4:	eb 22                	jmp    408 <strcmp+0x38>
 3e6:	8d 76 00             	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
 3f0:	41                   	inc    %ecx
    while (*p && *p == *q)
 3f1:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
 3f4:	43                   	inc    %ebx
 3f5:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
 3f8:	84 c0                	test   %al,%al
 3fa:	74 0c                	je     408 <strcmp+0x38>
 3fc:	38 d0                	cmp    %dl,%al
 3fe:	74 f0                	je     3f0 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
 400:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
 401:	29 d0                	sub    %edx,%eax
}
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
 405:	8d 76 00             	lea    0x0(%esi),%esi
 408:	5b                   	pop    %ebx
 409:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
 40b:	29 d0                	sub    %edx,%eax
}
 40d:	5d                   	pop    %ebp
 40e:	c3                   	ret    
 40f:	90                   	nop

00000410 <strlen>:

uint
strlen(const char *s) {
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
 416:	80 39 00             	cmpb   $0x0,(%ecx)
 419:	74 15                	je     430 <strlen+0x20>
 41b:	31 d2                	xor    %edx,%edx
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	42                   	inc    %edx
 421:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 425:	89 d0                	mov    %edx,%eax
 427:	75 f7                	jne    420 <strlen+0x10>
    return n;
}
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret    
 42b:	90                   	nop
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
 430:	31 c0                	xor    %eax,%eax
}
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 43a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000440 <memset>:

void *
memset(void *dst, int c, uint n) {
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 55 08             	mov    0x8(%ebp),%edx
 446:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 447:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44a:	8b 45 0c             	mov    0xc(%ebp),%eax
 44d:	89 d7                	mov    %edx,%edi
 44f:	fc                   	cld    
 450:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
 452:	5f                   	pop    %edi
 453:	89 d0                	mov    %edx,%eax
 455:	5d                   	pop    %ebp
 456:	c3                   	ret    
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <strchr>:

char *
strchr(const char *s, char c) {
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 45 08             	mov    0x8(%ebp),%eax
 466:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
 46a:	0f b6 10             	movzbl (%eax),%edx
 46d:	84 d2                	test   %dl,%dl
 46f:	74 1b                	je     48c <strchr+0x2c>
        if (*s == c)
 471:	38 d1                	cmp    %dl,%cl
 473:	75 0f                	jne    484 <strchr+0x24>
 475:	eb 17                	jmp    48e <strchr+0x2e>
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 480:	38 ca                	cmp    %cl,%dl
 482:	74 0a                	je     48e <strchr+0x2e>
    for (; *s; s++)
 484:	40                   	inc    %eax
 485:	0f b6 10             	movzbl (%eax),%edx
 488:	84 d2                	test   %dl,%dl
 48a:	75 f4                	jne    480 <strchr+0x20>
            return (char *) s;
    return 0;
 48c:	31 c0                	xor    %eax,%eax
}
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    

00000490 <gets>:

char *
gets(char *buf, int max) {
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 495:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
 497:	53                   	push   %ebx
 498:	83 ec 3c             	sub    $0x3c,%esp
 49b:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
 49e:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
 4a1:	eb 32                	jmp    4d5 <gets+0x45>
 4a3:	90                   	nop
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
 4a8:	ba 01 00 00 00       	mov    $0x1,%edx
 4ad:	89 54 24 08          	mov    %edx,0x8(%esp)
 4b1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4bc:	e8 2f 01 00 00       	call   5f0 <read>
        if (cc < 1)
 4c1:	85 c0                	test   %eax,%eax
 4c3:	7e 19                	jle    4de <gets+0x4e>
            break;
        buf[i++] = c;
 4c5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4c9:	43                   	inc    %ebx
 4ca:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
 4cd:	3c 0a                	cmp    $0xa,%al
 4cf:	74 1f                	je     4f0 <gets+0x60>
 4d1:	3c 0d                	cmp    $0xd,%al
 4d3:	74 1b                	je     4f0 <gets+0x60>
    for (i = 0; i + 1 < max;) {
 4d5:	46                   	inc    %esi
 4d6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4d9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4dc:	7c ca                	jl     4a8 <gets+0x18>
            break;
    }
    buf[i] = '\0';
 4de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e1:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	83 c4 3c             	add    $0x3c,%esp
 4ea:	5b                   	pop    %ebx
 4eb:	5e                   	pop    %esi
 4ec:	5f                   	pop    %edi
 4ed:	5d                   	pop    %ebp
 4ee:	c3                   	ret    
 4ef:	90                   	nop
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	01 c6                	add    %eax,%esi
 4f5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4f8:	eb e4                	jmp    4de <gets+0x4e>
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000500 <stat>:

int
stat(const char *n, struct stat *st) {
 500:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 501:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
 503:	89 e5                	mov    %esp,%ebp
 505:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
 508:	89 44 24 04          	mov    %eax,0x4(%esp)
 50c:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
 50f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 512:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
 515:	89 04 24             	mov    %eax,(%esp)
 518:	e8 fb 00 00 00       	call   618 <open>
    if (fd < 0)
 51d:	85 c0                	test   %eax,%eax
 51f:	78 2f                	js     550 <stat+0x50>
 521:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
 523:	8b 45 0c             	mov    0xc(%ebp),%eax
 526:	89 1c 24             	mov    %ebx,(%esp)
 529:	89 44 24 04          	mov    %eax,0x4(%esp)
 52d:	e8 fe 00 00 00       	call   630 <fstat>
    close(fd);
 532:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
 535:	89 c6                	mov    %eax,%esi
    close(fd);
 537:	e8 c4 00 00 00       	call   600 <close>
    return r;
}
 53c:	89 f0                	mov    %esi,%eax
 53e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 541:	8b 75 fc             	mov    -0x4(%ebp),%esi
 544:	89 ec                	mov    %ebp,%esp
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 550:	be ff ff ff ff       	mov    $0xffffffff,%esi
 555:	eb e5                	jmp    53c <stat+0x3c>
 557:	89 f6                	mov    %esi,%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <atoi>:

int
atoi(const char *s) {
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	8b 4d 08             	mov    0x8(%ebp),%ecx
 566:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 567:	0f be 11             	movsbl (%ecx),%edx
 56a:	88 d0                	mov    %dl,%al
 56c:	2c 30                	sub    $0x30,%al
 56e:	3c 09                	cmp    $0x9,%al
    n = 0;
 570:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
 575:	77 1e                	ja     595 <atoi+0x35>
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
 580:	41                   	inc    %ecx
 581:	8d 04 80             	lea    (%eax,%eax,4),%eax
 584:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
 588:	0f be 11             	movsbl (%ecx),%edx
 58b:	88 d3                	mov    %dl,%bl
 58d:	80 eb 30             	sub    $0x30,%bl
 590:	80 fb 09             	cmp    $0x9,%bl
 593:	76 eb                	jbe    580 <atoi+0x20>
    return n;
}
 595:	5b                   	pop    %ebx
 596:	5d                   	pop    %ebp
 597:	c3                   	ret    
 598:	90                   	nop
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005a0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	56                   	push   %esi
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	53                   	push   %ebx
 5a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5ab:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
 5ae:	85 db                	test   %ebx,%ebx
 5b0:	7e 1a                	jle    5cc <memmove+0x2c>
 5b2:	31 d2                	xor    %edx,%edx
 5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
 5c0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5c7:	42                   	inc    %edx
    while (n-- > 0)
 5c8:	39 d3                	cmp    %edx,%ebx
 5ca:	75 f4                	jne    5c0 <memmove+0x20>
    return vdst;
}
 5cc:	5b                   	pop    %ebx
 5cd:	5e                   	pop    %esi
 5ce:	5d                   	pop    %ebp
 5cf:	c3                   	ret    

000005d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5d0:	b8 01 00 00 00       	mov    $0x1,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <exit>:
SYSCALL(exit)
 5d8:	b8 02 00 00 00       	mov    $0x2,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <wait>:
SYSCALL(wait)
 5e0:	b8 03 00 00 00       	mov    $0x3,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <pipe>:
SYSCALL(pipe)
 5e8:	b8 04 00 00 00       	mov    $0x4,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <read>:
SYSCALL(read)
 5f0:	b8 05 00 00 00       	mov    $0x5,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <write>:
SYSCALL(write)
 5f8:	b8 10 00 00 00       	mov    $0x10,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <close>:
SYSCALL(close)
 600:	b8 15 00 00 00       	mov    $0x15,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <kill>:
SYSCALL(kill)
 608:	b8 06 00 00 00       	mov    $0x6,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <exec>:
SYSCALL(exec)
 610:	b8 07 00 00 00       	mov    $0x7,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <open>:
SYSCALL(open)
 618:	b8 0f 00 00 00       	mov    $0xf,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <mknod>:
SYSCALL(mknod)
 620:	b8 11 00 00 00       	mov    $0x11,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <unlink>:
SYSCALL(unlink)
 628:	b8 12 00 00 00       	mov    $0x12,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <fstat>:
SYSCALL(fstat)
 630:	b8 08 00 00 00       	mov    $0x8,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <link>:
SYSCALL(link)
 638:	b8 13 00 00 00       	mov    $0x13,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <mkdir>:
SYSCALL(mkdir)
 640:	b8 14 00 00 00       	mov    $0x14,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <chdir>:
SYSCALL(chdir)
 648:	b8 09 00 00 00       	mov    $0x9,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <dup>:
SYSCALL(dup)
 650:	b8 0a 00 00 00       	mov    $0xa,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <getpid>:
SYSCALL(getpid)
 658:	b8 0b 00 00 00       	mov    $0xb,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <sbrk>:
SYSCALL(sbrk)
 660:	b8 0c 00 00 00       	mov    $0xc,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <sleep>:
SYSCALL(sleep)
 668:	b8 0d 00 00 00       	mov    $0xd,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <uptime>:
SYSCALL(uptime)
 670:	b8 0e 00 00 00       	mov    $0xe,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <detach>:
SYSCALL(detach)
 678:	b8 16 00 00 00       	mov    $0x16,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <priority>:
SYSCALL(priority)
 680:	b8 17 00 00 00       	mov    $0x17,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    

00000688 <policy>:
SYSCALL(policy)
 688:	b8 18 00 00 00       	mov    $0x18,%eax
 68d:	cd 40                	int    $0x40
 68f:	c3                   	ret    

00000690 <wait_stat>:
SYSCALL(wait_stat)
 690:	b8 19 00 00 00       	mov    $0x19,%eax
 695:	cd 40                	int    $0x40
 697:	c3                   	ret    
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6a6:	89 d3                	mov    %edx,%ebx
 6a8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 6ab:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 6ae:	84 db                	test   %bl,%bl
{
 6b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6b3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 6b5:	74 79                	je     730 <printint+0x90>
 6b7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6bb:	74 73                	je     730 <printint+0x90>
    neg = 1;
    x = -xx;
 6bd:	f7 d8                	neg    %eax
    neg = 1;
 6bf:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 6c6:	31 f6                	xor    %esi,%esi
 6c8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6cb:	eb 05                	jmp    6d2 <printint+0x32>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6d0:	89 fe                	mov    %edi,%esi
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	f7 f1                	div    %ecx
 6d6:	8d 7e 01             	lea    0x1(%esi),%edi
 6d9:	0f b6 92 0c 0b 00 00 	movzbl 0xb0c(%edx),%edx
  }while((x /= base) != 0);
 6e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 6e2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 6e5:	75 e9                	jne    6d0 <printint+0x30>
  if(neg)
 6e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 6ea:	85 d2                	test   %edx,%edx
 6ec:	74 08                	je     6f6 <printint+0x56>
    buf[i++] = '-';
 6ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 6f3:	8d 7e 02             	lea    0x2(%esi),%edi
 6f6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 6fa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
 700:	0f b6 06             	movzbl (%esi),%eax
 703:	4e                   	dec    %esi
  write(fd, &c, 1);
 704:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 708:	89 3c 24             	mov    %edi,(%esp)
 70b:	88 45 d7             	mov    %al,-0x29(%ebp)
 70e:	b8 01 00 00 00       	mov    $0x1,%eax
 713:	89 44 24 08          	mov    %eax,0x8(%esp)
 717:	e8 dc fe ff ff       	call   5f8 <write>

  while(--i >= 0)
 71c:	39 de                	cmp    %ebx,%esi
 71e:	75 e0                	jne    700 <printint+0x60>
    putc(fd, buf[i]);
}
 720:	83 c4 4c             	add    $0x4c,%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	90                   	nop
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 730:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 737:	eb 8d                	jmp    6c6 <printint+0x26>
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 75 0c             	mov    0xc(%ebp),%esi
 74c:	0f b6 1e             	movzbl (%esi),%ebx
 74f:	84 db                	test   %bl,%bl
 751:	0f 84 d1 00 00 00    	je     828 <printf+0xe8>
  state = 0;
 757:	31 ff                	xor    %edi,%edi
 759:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 75a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 75d:	89 fa                	mov    %edi,%edx
 75f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 762:	89 45 d0             	mov    %eax,-0x30(%ebp)
 765:	eb 41                	jmp    7a8 <printf+0x68>
 767:	89 f6                	mov    %esi,%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 770:	83 f8 25             	cmp    $0x25,%eax
 773:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 776:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 77b:	74 1e                	je     79b <printf+0x5b>
  write(fd, &c, 1);
 77d:	b8 01 00 00 00       	mov    $0x1,%eax
 782:	89 44 24 08          	mov    %eax,0x8(%esp)
 786:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 789:	89 44 24 04          	mov    %eax,0x4(%esp)
 78d:	89 3c 24             	mov    %edi,(%esp)
 790:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 793:	e8 60 fe ff ff       	call   5f8 <write>
 798:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 79b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 79c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 7a0:	84 db                	test   %bl,%bl
 7a2:	0f 84 80 00 00 00    	je     828 <printf+0xe8>
    if(state == 0){
 7a8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 7aa:	0f be cb             	movsbl %bl,%ecx
 7ad:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7b0:	74 be                	je     770 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7b2:	83 fa 25             	cmp    $0x25,%edx
 7b5:	75 e4                	jne    79b <printf+0x5b>
      if(c == 'd'){
 7b7:	83 f8 64             	cmp    $0x64,%eax
 7ba:	0f 84 f0 00 00 00    	je     8b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7c0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7c6:	83 f9 70             	cmp    $0x70,%ecx
 7c9:	74 65                	je     830 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7cb:	83 f8 73             	cmp    $0x73,%eax
 7ce:	0f 84 8c 00 00 00    	je     860 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7d4:	83 f8 63             	cmp    $0x63,%eax
 7d7:	0f 84 13 01 00 00    	je     8f0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7dd:	83 f8 25             	cmp    $0x25,%eax
 7e0:	0f 84 e2 00 00 00    	je     8c8 <printf+0x188>
  write(fd, &c, 1);
 7e6:	b8 01 00 00 00       	mov    $0x1,%eax
 7eb:	46                   	inc    %esi
 7ec:	89 44 24 08          	mov    %eax,0x8(%esp)
 7f0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f7:	89 3c 24             	mov    %edi,(%esp)
 7fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7fe:	e8 f5 fd ff ff       	call   5f8 <write>
 803:	ba 01 00 00 00       	mov    $0x1,%edx
 808:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 80b:	89 54 24 08          	mov    %edx,0x8(%esp)
 80f:	89 44 24 04          	mov    %eax,0x4(%esp)
 813:	89 3c 24             	mov    %edi,(%esp)
 816:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 819:	e8 da fd ff ff       	call   5f8 <write>
  for(i = 0; fmt[i]; i++){
 81e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 822:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 824:	84 db                	test   %bl,%bl
 826:	75 80                	jne    7a8 <printf+0x68>
    }
  }
}
 828:	83 c4 3c             	add    $0x3c,%esp
 82b:	5b                   	pop    %ebx
 82c:	5e                   	pop    %esi
 82d:	5f                   	pop    %edi
 82e:	5d                   	pop    %ebp
 82f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 830:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 837:	b9 10 00 00 00       	mov    $0x10,%ecx
 83c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 83f:	89 f8                	mov    %edi,%eax
 841:	8b 13                	mov    (%ebx),%edx
 843:	e8 58 fe ff ff       	call   6a0 <printint>
        ap++;
 848:	89 d8                	mov    %ebx,%eax
      state = 0;
 84a:	31 d2                	xor    %edx,%edx
        ap++;
 84c:	83 c0 04             	add    $0x4,%eax
 84f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 852:	e9 44 ff ff ff       	jmp    79b <printf+0x5b>
 857:	89 f6                	mov    %esi,%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 860:	8b 45 d0             	mov    -0x30(%ebp),%eax
 863:	8b 10                	mov    (%eax),%edx
        ap++;
 865:	83 c0 04             	add    $0x4,%eax
 868:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 86b:	85 d2                	test   %edx,%edx
 86d:	0f 84 aa 00 00 00    	je     91d <printf+0x1dd>
        while(*s != 0){
 873:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 876:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 878:	84 c0                	test   %al,%al
 87a:	74 27                	je     8a3 <printf+0x163>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 883:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 888:	43                   	inc    %ebx
  write(fd, &c, 1);
 889:	89 44 24 08          	mov    %eax,0x8(%esp)
 88d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 890:	89 44 24 04          	mov    %eax,0x4(%esp)
 894:	89 3c 24             	mov    %edi,(%esp)
 897:	e8 5c fd ff ff       	call   5f8 <write>
        while(*s != 0){
 89c:	0f b6 03             	movzbl (%ebx),%eax
 89f:	84 c0                	test   %al,%al
 8a1:	75 dd                	jne    880 <printf+0x140>
      state = 0;
 8a3:	31 d2                	xor    %edx,%edx
 8a5:	e9 f1 fe ff ff       	jmp    79b <printf+0x5b>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 8b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8bc:	e9 7b ff ff ff       	jmp    83c <printf+0xfc>
 8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8c8:	b9 01 00 00 00       	mov    $0x1,%ecx
 8cd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8d0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 8d8:	89 3c 24             	mov    %edi,(%esp)
 8db:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8de:	e8 15 fd ff ff       	call   5f8 <write>
      state = 0;
 8e3:	31 d2                	xor    %edx,%edx
 8e5:	e9 b1 fe ff ff       	jmp    79b <printf+0x5b>
 8ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 8f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8f3:	8b 03                	mov    (%ebx),%eax
        ap++;
 8f5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 8f8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 8fb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 8fe:	b8 01 00 00 00       	mov    $0x1,%eax
 903:	89 44 24 08          	mov    %eax,0x8(%esp)
 907:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 90a:	89 44 24 04          	mov    %eax,0x4(%esp)
 90e:	e8 e5 fc ff ff       	call   5f8 <write>
      state = 0;
 913:	31 d2                	xor    %edx,%edx
        ap++;
 915:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 918:	e9 7e fe ff ff       	jmp    79b <printf+0x5b>
          s = "(null)";
 91d:	bb 02 0b 00 00       	mov    $0xb02,%ebx
        while(*s != 0){
 922:	b0 28                	mov    $0x28,%al
 924:	e9 57 ff ff ff       	jmp    880 <printf+0x140>
 929:	66 90                	xchg   %ax,%ax
 92b:	66 90                	xchg   %ax,%ax
 92d:	66 90                	xchg   %ax,%ax
 92f:	90                   	nop

00000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	a1 48 0e 00 00       	mov    0xe48,%eax
{
 936:	89 e5                	mov    %esp,%ebp
 938:	57                   	push   %edi
 939:	56                   	push   %esi
 93a:	53                   	push   %ebx
 93b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 93e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 941:	eb 0d                	jmp    950 <free+0x20>
 943:	90                   	nop
 944:	90                   	nop
 945:	90                   	nop
 946:	90                   	nop
 947:	90                   	nop
 948:	90                   	nop
 949:	90                   	nop
 94a:	90                   	nop
 94b:	90                   	nop
 94c:	90                   	nop
 94d:	90                   	nop
 94e:	90                   	nop
 94f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 950:	39 c8                	cmp    %ecx,%eax
 952:	8b 10                	mov    (%eax),%edx
 954:	73 32                	jae    988 <free+0x58>
 956:	39 d1                	cmp    %edx,%ecx
 958:	72 04                	jb     95e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95a:	39 d0                	cmp    %edx,%eax
 95c:	72 32                	jb     990 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 95e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 961:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 964:	39 fa                	cmp    %edi,%edx
 966:	74 30                	je     998 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 968:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 96b:	8b 50 04             	mov    0x4(%eax),%edx
 96e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 971:	39 f1                	cmp    %esi,%ecx
 973:	74 3c                	je     9b1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 975:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 977:	5b                   	pop    %ebx
  freep = p;
 978:	a3 48 0e 00 00       	mov    %eax,0xe48
}
 97d:	5e                   	pop    %esi
 97e:	5f                   	pop    %edi
 97f:	5d                   	pop    %ebp
 980:	c3                   	ret    
 981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 988:	39 d0                	cmp    %edx,%eax
 98a:	72 04                	jb     990 <free+0x60>
 98c:	39 d1                	cmp    %edx,%ecx
 98e:	72 ce                	jb     95e <free+0x2e>
{
 990:	89 d0                	mov    %edx,%eax
 992:	eb bc                	jmp    950 <free+0x20>
 994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 998:	8b 7a 04             	mov    0x4(%edx),%edi
 99b:	01 fe                	add    %edi,%esi
 99d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a0:	8b 10                	mov    (%eax),%edx
 9a2:	8b 12                	mov    (%edx),%edx
 9a4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9a7:	8b 50 04             	mov    0x4(%eax),%edx
 9aa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9ad:	39 f1                	cmp    %esi,%ecx
 9af:	75 c4                	jne    975 <free+0x45>
    p->s.size += bp->s.size;
 9b1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 9b4:	a3 48 0e 00 00       	mov    %eax,0xe48
    p->s.size += bp->s.size;
 9b9:	01 ca                	add    %ecx,%edx
 9bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9be:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9c1:	89 10                	mov    %edx,(%eax)
}
 9c3:	5b                   	pop    %ebx
 9c4:	5e                   	pop    %esi
 9c5:	5f                   	pop    %edi
 9c6:	5d                   	pop    %ebp
 9c7:	c3                   	ret    
 9c8:	90                   	nop
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	57                   	push   %edi
 9d4:	56                   	push   %esi
 9d5:	53                   	push   %ebx
 9d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9dc:	8b 15 48 0e 00 00    	mov    0xe48,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e2:	8d 78 07             	lea    0x7(%eax),%edi
 9e5:	c1 ef 03             	shr    $0x3,%edi
 9e8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9e9:	85 d2                	test   %edx,%edx
 9eb:	0f 84 8f 00 00 00    	je     a80 <malloc+0xb0>
 9f1:	8b 02                	mov    (%edx),%eax
 9f3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9f6:	39 cf                	cmp    %ecx,%edi
 9f8:	76 66                	jbe    a60 <malloc+0x90>
 9fa:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a00:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a05:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a08:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a0f:	eb 10                	jmp    a21 <malloc+0x51>
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a1a:	8b 48 04             	mov    0x4(%eax),%ecx
 a1d:	39 f9                	cmp    %edi,%ecx
 a1f:	73 3f                	jae    a60 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a21:	39 05 48 0e 00 00    	cmp    %eax,0xe48
 a27:	89 c2                	mov    %eax,%edx
 a29:	75 ed                	jne    a18 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a2b:	89 34 24             	mov    %esi,(%esp)
 a2e:	e8 2d fc ff ff       	call   660 <sbrk>
  if(p == (char*)-1)
 a33:	83 f8 ff             	cmp    $0xffffffff,%eax
 a36:	74 18                	je     a50 <malloc+0x80>
  hp->s.size = nu;
 a38:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a3b:	83 c0 08             	add    $0x8,%eax
 a3e:	89 04 24             	mov    %eax,(%esp)
 a41:	e8 ea fe ff ff       	call   930 <free>
  return freep;
 a46:	8b 15 48 0e 00 00    	mov    0xe48,%edx
      if((p = morecore(nunits)) == 0)
 a4c:	85 d2                	test   %edx,%edx
 a4e:	75 c8                	jne    a18 <malloc+0x48>
        return 0;
  }
}
 a50:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 a53:	31 c0                	xor    %eax,%eax
}
 a55:	5b                   	pop    %ebx
 a56:	5e                   	pop    %esi
 a57:	5f                   	pop    %edi
 a58:	5d                   	pop    %ebp
 a59:	c3                   	ret    
 a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a60:	39 cf                	cmp    %ecx,%edi
 a62:	74 4c                	je     ab0 <malloc+0xe0>
        p->s.size -= nunits;
 a64:	29 f9                	sub    %edi,%ecx
 a66:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a69:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a6c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a6f:	89 15 48 0e 00 00    	mov    %edx,0xe48
}
 a75:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a78:	83 c0 08             	add    $0x8,%eax
}
 a7b:	5b                   	pop    %ebx
 a7c:	5e                   	pop    %esi
 a7d:	5f                   	pop    %edi
 a7e:	5d                   	pop    %ebp
 a7f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 a80:	b8 4c 0e 00 00       	mov    $0xe4c,%eax
 a85:	ba 4c 0e 00 00       	mov    $0xe4c,%edx
    base.s.size = 0;
 a8a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 a8c:	a3 48 0e 00 00       	mov    %eax,0xe48
    base.s.size = 0;
 a91:	b8 4c 0e 00 00       	mov    $0xe4c,%eax
    base.s.ptr = freep = prevp = &base;
 a96:	89 15 4c 0e 00 00    	mov    %edx,0xe4c
    base.s.size = 0;
 a9c:	89 0d 50 0e 00 00    	mov    %ecx,0xe50
 aa2:	e9 53 ff ff ff       	jmp    9fa <malloc+0x2a>
 aa7:	89 f6                	mov    %esi,%esi
 aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 ab0:	8b 08                	mov    (%eax),%ecx
 ab2:	89 0a                	mov    %ecx,(%edx)
 ab4:	eb b9                	jmp    a6f <malloc+0x9f>
