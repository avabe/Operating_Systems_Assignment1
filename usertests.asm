
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
  printf(1, "usertests starting\n");
       1:	b8 66 55 00 00       	mov    $0x5566,%eax
{
       6:	89 e5                	mov    %esp,%ebp
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
       e:	89 44 24 04          	mov    %eax,0x4(%esp)
      12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      19:	e8 e2 41 00 00       	call   4200 <printf>

  if(open("usertests.ran", 0) >= 0){
      1e:	31 d2                	xor    %edx,%edx
      20:	89 54 24 04          	mov    %edx,0x4(%esp)
      24:	c7 04 24 7a 55 00 00 	movl   $0x557a,(%esp)
      2b:	e8 a8 40 00 00       	call   40d8 <open>
      30:	85 c0                	test   %eax,%eax
      32:	78 20                	js     54 <main+0x54>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      34:	c7 44 24 04 e4 5c 00 	movl   $0x5ce4,0x4(%esp)
      3b:	00 
      3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      43:	e8 b8 41 00 00       	call   4200 <printf>
    exit(0);
      48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      4f:	e8 44 40 00 00       	call   4098 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      54:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
      5b:	00 
      5c:	c7 04 24 7a 55 00 00 	movl   $0x557a,(%esp)
      63:	e8 70 40 00 00       	call   40d8 <open>
      68:	89 04 24             	mov    %eax,(%esp)
      6b:	e8 50 40 00 00       	call   40c0 <close>

  argptest();
      70:	e8 1b 3d 00 00       	call   3d90 <argptest>
  createdelete();
      75:	e8 e6 12 00 00       	call   1360 <createdelete>
  linkunlink();
      7a:	e8 81 1d 00 00       	call   1e00 <linkunlink>
      7f:	90                   	nop
  concreate();
      80:	e8 0b 1a 00 00       	call   1a90 <concreate>
  fourfiles();
      85:	e8 66 10 00 00       	call   10f0 <fourfiles>
  sharedfd();
      8a:	e8 51 0e 00 00       	call   ee0 <sharedfd>
      8f:	90                   	nop

  bigargtest();
      90:	e8 4b 39 00 00       	call   39e0 <bigargtest>
  bigwrite();
      95:	e8 66 28 00 00       	call   2900 <bigwrite>
  bigargtest();
      9a:	e8 41 39 00 00       	call   39e0 <bigargtest>
      9f:	90                   	nop
  bsstest();
      a0:	e8 bb 38 00 00       	call   3960 <bsstest>
  sbrktest();
      a5:	e8 c6 33 00 00       	call   3470 <sbrktest>
  validatetest();
      aa:	e8 f1 37 00 00       	call   38a0 <validatetest>
      af:	90                   	nop

  opentest();
      b0:	e8 1b 03 00 00       	call   3d0 <opentest>
  writetest();
      b5:	e8 b6 03 00 00       	call   470 <writetest>
  writetest1();
      ba:	e8 91 05 00 00       	call   650 <writetest1>
      bf:	90                   	nop
  createtest();
      c0:	e8 5b 07 00 00       	call   820 <createtest>

  openiputtest();
      c5:	e8 16 02 00 00       	call   2e0 <openiputtest>
  exitiputtest();
      ca:	e8 31 01 00 00       	call   200 <exitiputtest>
      cf:	90                   	nop
  iputtest();
      d0:	e8 6b 00 00 00       	call   140 <iputtest>

  mem();
      d5:	e8 16 0d 00 00       	call   df0 <mem>
  pipe1();
      da:	e8 11 09 00 00       	call   9f0 <pipe1>
      df:	90                   	nop
  preempt();
      e0:	e8 fb 0a 00 00       	call   be0 <preempt>
  exitwait();
      e5:	e8 66 0c 00 00       	call   d50 <exitwait>

  rmdot();
      ea:	e8 f1 2c 00 00       	call   2de0 <rmdot>
      ef:	90                   	nop
  fourteen();
      f0:	e8 5b 2b 00 00       	call   2c50 <fourteen>
  bigfile();
      f5:	e8 16 29 00 00       	call   2a10 <bigfile>
  subdir();
      fa:	e8 71 1f 00 00       	call   2070 <subdir>
      ff:	90                   	nop
  linktest();
     100:	e8 eb 16 00 00       	call   17f0 <linktest>
  unlinkread();
     105:	e8 d6 14 00 00       	call   15e0 <unlinkread>
  dirfile();
     10a:	e8 a1 2e 00 00       	call   2fb0 <dirfile>
     10f:	90                   	nop
  iref();
     110:	e8 1b 31 00 00       	call   3230 <iref>
  forktest();
     115:	e8 56 32 00 00       	call   3370 <forktest>
  bigdir(); // slow
     11a:	e8 f1 1d 00 00       	call   1f10 <bigdir>
     11f:	90                   	nop

  uio();
     120:	e8 cb 3b 00 00       	call   3cf0 <uio>

  exectest();
     125:	e8 66 08 00 00       	call   990 <exectest>

  exit(0);
     12a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     131:	e8 62 3f 00 00       	call   4098 <exit>
     136:	66 90                	xchg   %ax,%ax
     138:	66 90                	xchg   %ax,%ax
     13a:	66 90                	xchg   %ax,%ax
     13c:	66 90                	xchg   %ax,%ax
     13e:	66 90                	xchg   %ax,%ax

00000140 <iputtest>:
{
     140:	55                   	push   %ebp
  printf(stdout, "iput test\n");
     141:	ba 0c 46 00 00       	mov    $0x460c,%edx
{
     146:	89 e5                	mov    %esp,%ebp
     148:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
     14b:	a1 48 66 00 00       	mov    0x6648,%eax
     150:	89 54 24 04          	mov    %edx,0x4(%esp)
     154:	89 04 24             	mov    %eax,(%esp)
     157:	e8 a4 40 00 00       	call   4200 <printf>
  if(mkdir("iputdir") < 0){
     15c:	c7 04 24 9f 45 00 00 	movl   $0x459f,(%esp)
     163:	e8 98 3f 00 00       	call   4100 <mkdir>
     168:	85 c0                	test   %eax,%eax
     16a:	78 48                	js     1b4 <iputtest+0x74>
  if(chdir("iputdir") < 0){
     16c:	c7 04 24 9f 45 00 00 	movl   $0x459f,(%esp)
     173:	e8 90 3f 00 00       	call   4108 <chdir>
     178:	85 c0                	test   %eax,%eax
     17a:	78 6d                	js     1e9 <iputtest+0xa9>
  if(unlink("../iputdir") < 0){
     17c:	c7 04 24 9c 45 00 00 	movl   $0x459c,(%esp)
     183:	e8 60 3f 00 00       	call   40e8 <unlink>
     188:	85 c0                	test   %eax,%eax
     18a:	78 53                	js     1df <iputtest+0x9f>
  if(chdir("/") < 0){
     18c:	c7 04 24 c1 45 00 00 	movl   $0x45c1,(%esp)
     193:	e8 70 3f 00 00       	call   4108 <chdir>
     198:	85 c0                	test   %eax,%eax
     19a:	78 39                	js     1d5 <iputtest+0x95>
  printf(stdout, "iput test ok\n");
     19c:	b8 44 46 00 00       	mov    $0x4644,%eax
     1a1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1a5:	a1 48 66 00 00       	mov    0x6648,%eax
     1aa:	89 04 24             	mov    %eax,(%esp)
     1ad:	e8 4e 40 00 00       	call   4200 <printf>
}
     1b2:	c9                   	leave  
     1b3:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1b4:	c7 44 24 04 78 45 00 	movl   $0x4578,0x4(%esp)
     1bb:	00 
    printf(stdout, "chdir iputdir failed\n");
     1bc:	a1 48 66 00 00       	mov    0x6648,%eax
     1c1:	89 04 24             	mov    %eax,(%esp)
     1c4:	e8 37 40 00 00       	call   4200 <printf>
    exit(0);
     1c9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1d0:	e8 c3 3e 00 00       	call   4098 <exit>
    printf(stdout, "chdir / failed\n");
     1d5:	c7 44 24 04 c3 45 00 	movl   $0x45c3,0x4(%esp)
     1dc:	00 
     1dd:	eb dd                	jmp    1bc <iputtest+0x7c>
    printf(stdout, "unlink ../iputdir failed\n");
     1df:	c7 44 24 04 a7 45 00 	movl   $0x45a7,0x4(%esp)
     1e6:	00 
     1e7:	eb d3                	jmp    1bc <iputtest+0x7c>
    printf(stdout, "chdir iputdir failed\n");
     1e9:	c7 44 24 04 86 45 00 	movl   $0x4586,0x4(%esp)
     1f0:	00 
     1f1:	eb c9                	jmp    1bc <iputtest+0x7c>
     1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
  printf(stdout, "exitiput test\n");
     201:	b9 d3 45 00 00       	mov    $0x45d3,%ecx
{
     206:	89 e5                	mov    %esp,%ebp
     208:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exitiput test\n");
     20b:	a1 48 66 00 00       	mov    0x6648,%eax
     210:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     214:	89 04 24             	mov    %eax,(%esp)
     217:	e8 e4 3f 00 00       	call   4200 <printf>
  pid = fork();
     21c:	e8 6f 3e 00 00       	call   4090 <fork>
  if(pid < 0){
     221:	85 c0                	test   %eax,%eax
     223:	0f 88 91 00 00 00    	js     2ba <exitiputtest+0xba>
  if(pid == 0){
     229:	75 45                	jne    270 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     22b:	c7 04 24 9f 45 00 00 	movl   $0x459f,(%esp)
     232:	e8 c9 3e 00 00       	call   4100 <mkdir>
     237:	85 c0                	test   %eax,%eax
     239:	0f 88 8f 00 00 00    	js     2ce <exitiputtest+0xce>
    if(chdir("iputdir") < 0){
     23f:	c7 04 24 9f 45 00 00 	movl   $0x459f,(%esp)
     246:	e8 bd 3e 00 00       	call   4108 <chdir>
     24b:	85 c0                	test   %eax,%eax
     24d:	78 75                	js     2c4 <exitiputtest+0xc4>
    if(unlink("../iputdir") < 0){
     24f:	c7 04 24 9c 45 00 00 	movl   $0x459c,(%esp)
     256:	e8 8d 3e 00 00       	call   40e8 <unlink>
     25b:	85 c0                	test   %eax,%eax
     25d:	78 39                	js     298 <exitiputtest+0x98>
      exit(0);
     25f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     266:	e8 2d 3e 00 00       	call   4098 <exit>
     26b:	90                   	nop
     26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait(null);
     270:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     277:	e8 24 3e 00 00       	call   40a0 <wait>
  printf(stdout, "exitiput test ok\n");
     27c:	b8 f6 45 00 00       	mov    $0x45f6,%eax
     281:	89 44 24 04          	mov    %eax,0x4(%esp)
     285:	a1 48 66 00 00       	mov    0x6648,%eax
     28a:	89 04 24             	mov    %eax,(%esp)
     28d:	e8 6e 3f 00 00       	call   4200 <printf>
}
     292:	c9                   	leave  
     293:	c3                   	ret    
     294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	ba a7 45 00 00       	mov    $0x45a7,%edx
     29d:	89 54 24 04          	mov    %edx,0x4(%esp)
      printf(stdout, "mkdir failed\n");
     2a1:	a1 48 66 00 00       	mov    0x6648,%eax
     2a6:	89 04 24             	mov    %eax,(%esp)
     2a9:	e8 52 3f 00 00       	call   4200 <printf>
      exit(0);
     2ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2b5:	e8 de 3d 00 00       	call   4098 <exit>
    printf(stdout, "fork failed\n");
     2ba:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
     2c1:	00 
     2c2:	eb dd                	jmp    2a1 <exitiputtest+0xa1>
      printf(stdout, "child chdir failed\n");
     2c4:	c7 44 24 04 e2 45 00 	movl   $0x45e2,0x4(%esp)
     2cb:	00 
     2cc:	eb d3                	jmp    2a1 <exitiputtest+0xa1>
      printf(stdout, "mkdir failed\n");
     2ce:	c7 44 24 04 78 45 00 	movl   $0x4578,0x4(%esp)
     2d5:	00 
     2d6:	eb c9                	jmp    2a1 <exitiputtest+0xa1>
     2d8:	90                   	nop
     2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <openiputtest>:
{
     2e0:	55                   	push   %ebp
  printf(stdout, "openiput test\n");
     2e1:	b8 08 46 00 00       	mov    $0x4608,%eax
{
     2e6:	89 e5                	mov    %esp,%ebp
     2e8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "openiput test\n");
     2eb:	89 44 24 04          	mov    %eax,0x4(%esp)
     2ef:	a1 48 66 00 00       	mov    0x6648,%eax
     2f4:	89 04 24             	mov    %eax,(%esp)
     2f7:	e8 04 3f 00 00       	call   4200 <printf>
  if(mkdir("oidir") < 0){
     2fc:	c7 04 24 17 46 00 00 	movl   $0x4617,(%esp)
     303:	e8 f8 3d 00 00       	call   4100 <mkdir>
     308:	85 c0                	test   %eax,%eax
     30a:	0f 88 9a 00 00 00    	js     3aa <openiputtest+0xca>
  pid = fork();
     310:	e8 7b 3d 00 00       	call   4090 <fork>
  if(pid < 0){
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 83 00 00 00    	js     3a0 <openiputtest+0xc0>
     31d:	8d 76 00             	lea    0x0(%esi),%esi
  if(pid == 0){
     320:	75 3e                	jne    360 <openiputtest+0x80>
    int fd = open("oidir", O_RDWR);
     322:	b9 02 00 00 00       	mov    $0x2,%ecx
     327:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     32b:	c7 04 24 17 46 00 00 	movl   $0x4617,(%esp)
     332:	e8 a1 3d 00 00       	call   40d8 <open>
    if(fd >= 0){
     337:	85 c0                	test   %eax,%eax
     339:	78 16                	js     351 <openiputtest+0x71>
      printf(stdout, "open directory for write succeeded\n");
     33b:	ba 9c 55 00 00       	mov    $0x559c,%edx
     340:	89 54 24 04          	mov    %edx,0x4(%esp)
    printf(stdout, "fork failed\n");
     344:	a1 48 66 00 00       	mov    0x6648,%eax
     349:	89 04 24             	mov    %eax,(%esp)
     34c:	e8 af 3e 00 00       	call   4200 <printf>
    exit(0);
     351:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     358:	e8 3b 3d 00 00       	call   4098 <exit>
     35d:	8d 76 00             	lea    0x0(%esi),%esi
  sleep(1);
     360:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     367:	e8 bc 3d 00 00       	call   4128 <sleep>
  if(unlink("oidir") != 0){
     36c:	c7 04 24 17 46 00 00 	movl   $0x4617,(%esp)
     373:	e8 70 3d 00 00       	call   40e8 <unlink>
     378:	85 c0                	test   %eax,%eax
     37a:	75 38                	jne    3b4 <openiputtest+0xd4>
  wait(null);
     37c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     383:	e8 18 3d 00 00       	call   40a0 <wait>
  printf(stdout, "openiput test ok\n");
     388:	b8 40 46 00 00       	mov    $0x4640,%eax
     38d:	89 44 24 04          	mov    %eax,0x4(%esp)
     391:	a1 48 66 00 00       	mov    0x6648,%eax
     396:	89 04 24             	mov    %eax,(%esp)
     399:	e8 62 3e 00 00       	call   4200 <printf>
}
     39e:	c9                   	leave  
     39f:	c3                   	ret    
    printf(stdout, "fork failed\n");
     3a0:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
     3a7:	00 
     3a8:	eb 9a                	jmp    344 <openiputtest+0x64>
    printf(stdout, "mkdir oidir failed\n");
     3aa:	c7 44 24 04 1d 46 00 	movl   $0x461d,0x4(%esp)
     3b1:	00 
     3b2:	eb 90                	jmp    344 <openiputtest+0x64>
    printf(stdout, "unlink failed\n");
     3b4:	c7 44 24 04 31 46 00 	movl   $0x4631,0x4(%esp)
     3bb:	00 
     3bc:	e9 83 ff ff ff       	jmp    344 <openiputtest+0x64>
     3c1:	eb 0d                	jmp    3d0 <opentest>
     3c3:	90                   	nop
     3c4:	90                   	nop
     3c5:	90                   	nop
     3c6:	90                   	nop
     3c7:	90                   	nop
     3c8:	90                   	nop
     3c9:	90                   	nop
     3ca:	90                   	nop
     3cb:	90                   	nop
     3cc:	90                   	nop
     3cd:	90                   	nop
     3ce:	90                   	nop
     3cf:	90                   	nop

000003d0 <opentest>:
{
     3d0:	55                   	push   %ebp
  printf(stdout, "open test\n");
     3d1:	b9 52 46 00 00       	mov    $0x4652,%ecx
{
     3d6:	89 e5                	mov    %esp,%ebp
     3d8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "open test\n");
     3db:	a1 48 66 00 00       	mov    0x6648,%eax
     3e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     3e4:	89 04 24             	mov    %eax,(%esp)
     3e7:	e8 14 3e 00 00       	call   4200 <printf>
  fd = open("echo", 0);
     3ec:	31 c0                	xor    %eax,%eax
     3ee:	89 44 24 04          	mov    %eax,0x4(%esp)
     3f2:	c7 04 24 5d 46 00 00 	movl   $0x465d,(%esp)
     3f9:	e8 da 3c 00 00       	call   40d8 <open>
  if(fd < 0){
     3fe:	85 c0                	test   %eax,%eax
     400:	78 36                	js     438 <opentest+0x68>
  close(fd);
     402:	89 04 24             	mov    %eax,(%esp)
     405:	e8 b6 3c 00 00       	call   40c0 <close>
  fd = open("doesnotexist", 0);
     40a:	31 d2                	xor    %edx,%edx
     40c:	89 54 24 04          	mov    %edx,0x4(%esp)
     410:	c7 04 24 75 46 00 00 	movl   $0x4675,(%esp)
     417:	e8 bc 3c 00 00       	call   40d8 <open>
  if(fd >= 0){
     41c:	85 c0                	test   %eax,%eax
     41e:	79 39                	jns    459 <opentest+0x89>
  printf(stdout, "open test ok\n");
     420:	b8 a0 46 00 00       	mov    $0x46a0,%eax
     425:	89 44 24 04          	mov    %eax,0x4(%esp)
     429:	a1 48 66 00 00       	mov    0x6648,%eax
     42e:	89 04 24             	mov    %eax,(%esp)
     431:	e8 ca 3d 00 00       	call   4200 <printf>
}
     436:	c9                   	leave  
     437:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     438:	c7 44 24 04 62 46 00 	movl   $0x4662,0x4(%esp)
     43f:	00 
    printf(stdout, "open doesnotexist succeeded!\n");
     440:	a1 48 66 00 00       	mov    0x6648,%eax
     445:	89 04 24             	mov    %eax,(%esp)
     448:	e8 b3 3d 00 00       	call   4200 <printf>
    exit(0);
     44d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     454:	e8 3f 3c 00 00       	call   4098 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     459:	c7 44 24 04 82 46 00 	movl   $0x4682,0x4(%esp)
     460:	00 
     461:	eb dd                	jmp    440 <opentest+0x70>
     463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <writetest>:
{
     470:	55                   	push   %ebp
  printf(stdout, "small file test\n");
     471:	b8 ae 46 00 00       	mov    $0x46ae,%eax
{
     476:	89 e5                	mov    %esp,%ebp
     478:	56                   	push   %esi
     479:	53                   	push   %ebx
     47a:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "small file test\n");
     47d:	89 44 24 04          	mov    %eax,0x4(%esp)
     481:	a1 48 66 00 00       	mov    0x6648,%eax
     486:	89 04 24             	mov    %eax,(%esp)
     489:	e8 72 3d 00 00       	call   4200 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     48e:	b8 02 02 00 00       	mov    $0x202,%eax
     493:	89 44 24 04          	mov    %eax,0x4(%esp)
     497:	c7 04 24 bf 46 00 00 	movl   $0x46bf,(%esp)
     49e:	e8 35 3c 00 00       	call   40d8 <open>
  if(fd >= 0){
     4a3:	85 c0                	test   %eax,%eax
     4a5:	0f 88 9b 01 00 00    	js     646 <writetest+0x1d6>
     4ab:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     4ad:	b8 c5 46 00 00       	mov    $0x46c5,%eax
     4b2:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b6:	a1 48 66 00 00       	mov    0x6648,%eax
  for(i = 0; i < 100; i++){
     4bb:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4bd:	89 04 24             	mov    %eax,(%esp)
     4c0:	e8 3b 3d 00 00       	call   4200 <printf>
     4c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d0:	b9 0a 00 00 00       	mov    $0xa,%ecx
     4d5:	b8 fc 46 00 00       	mov    $0x46fc,%eax
     4da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     4de:	89 44 24 04          	mov    %eax,0x4(%esp)
     4e2:	89 34 24             	mov    %esi,(%esp)
     4e5:	e8 ce 3b 00 00       	call   40b8 <write>
     4ea:	83 f8 0a             	cmp    $0xa,%eax
     4ed:	0f 85 e9 00 00 00    	jne    5dc <writetest+0x16c>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4f3:	b8 0a 00 00 00       	mov    $0xa,%eax
     4f8:	89 44 24 08          	mov    %eax,0x8(%esp)
     4fc:	b8 07 47 00 00       	mov    $0x4707,%eax
     501:	89 44 24 04          	mov    %eax,0x4(%esp)
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 ab 3b 00 00       	call   40b8 <write>
     50d:	83 f8 0a             	cmp    $0xa,%eax
     510:	0f 85 ec 00 00 00    	jne    602 <writetest+0x192>
  for(i = 0; i < 100; i++){
     516:	43                   	inc    %ebx
     517:	83 fb 64             	cmp    $0x64,%ebx
     51a:	75 b4                	jne    4d0 <writetest+0x60>
  printf(stdout, "writes ok\n");
     51c:	b8 12 47 00 00       	mov    $0x4712,%eax
     521:	89 44 24 04          	mov    %eax,0x4(%esp)
     525:	a1 48 66 00 00       	mov    0x6648,%eax
     52a:	89 04 24             	mov    %eax,(%esp)
     52d:	e8 ce 3c 00 00       	call   4200 <printf>
  close(fd);
     532:	89 34 24             	mov    %esi,(%esp)
     535:	e8 86 3b 00 00       	call   40c0 <close>
  fd = open("small", O_RDONLY);
     53a:	31 c0                	xor    %eax,%eax
     53c:	89 44 24 04          	mov    %eax,0x4(%esp)
     540:	c7 04 24 bf 46 00 00 	movl   $0x46bf,(%esp)
     547:	e8 8c 3b 00 00       	call   40d8 <open>
  if(fd >= 0){
     54c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     54e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     550:	0f 88 bb 00 00 00    	js     611 <writetest+0x1a1>
    printf(stdout, "open small succeeded ok\n");
     556:	a1 48 66 00 00       	mov    0x6648,%eax
     55b:	b9 1d 47 00 00       	mov    $0x471d,%ecx
  i = read(fd, buf, 2000);
     560:	be d0 07 00 00       	mov    $0x7d0,%esi
    printf(stdout, "open small succeeded ok\n");
     565:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     569:	89 04 24             	mov    %eax,(%esp)
     56c:	e8 8f 3c 00 00       	call   4200 <printf>
  i = read(fd, buf, 2000);
     571:	b8 20 8e 00 00       	mov    $0x8e20,%eax
     576:	89 74 24 08          	mov    %esi,0x8(%esp)
     57a:	89 44 24 04          	mov    %eax,0x4(%esp)
     57e:	89 1c 24             	mov    %ebx,(%esp)
     581:	e8 2a 3b 00 00       	call   40b0 <read>
  if(i == 2000){
     586:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     58b:	0f 85 a1 00 00 00    	jne    632 <writetest+0x1c2>
    printf(stdout, "read succeeded ok\n");
     591:	a1 48 66 00 00       	mov    0x6648,%eax
     596:	ba 51 47 00 00       	mov    $0x4751,%edx
     59b:	89 54 24 04          	mov    %edx,0x4(%esp)
     59f:	89 04 24             	mov    %eax,(%esp)
     5a2:	e8 59 3c 00 00       	call   4200 <printf>
  close(fd);
     5a7:	89 1c 24             	mov    %ebx,(%esp)
     5aa:	e8 11 3b 00 00       	call   40c0 <close>
  if(unlink("small") < 0){
     5af:	c7 04 24 bf 46 00 00 	movl   $0x46bf,(%esp)
     5b6:	e8 2d 3b 00 00       	call   40e8 <unlink>
     5bb:	85 c0                	test   %eax,%eax
     5bd:	78 7d                	js     63c <writetest+0x1cc>
  printf(stdout, "small file test ok\n");
     5bf:	b8 79 47 00 00       	mov    $0x4779,%eax
     5c4:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c8:	a1 48 66 00 00       	mov    0x6648,%eax
     5cd:	89 04 24             	mov    %eax,(%esp)
     5d0:	e8 2b 3c 00 00       	call   4200 <printf>
}
     5d5:	83 c4 10             	add    $0x10,%esp
     5d8:	5b                   	pop    %ebx
     5d9:	5e                   	pop    %esi
     5da:	5d                   	pop    %ebp
     5db:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5dc:	ba c0 55 00 00       	mov    $0x55c0,%edx
     5e1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     5e5:	89 54 24 04          	mov    %edx,0x4(%esp)
      printf(stdout, "error: write bb %d new file failed\n", i);
     5e9:	a1 48 66 00 00       	mov    0x6648,%eax
     5ee:	89 04 24             	mov    %eax,(%esp)
     5f1:	e8 0a 3c 00 00       	call   4200 <printf>
      exit(0);
     5f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5fd:	e8 96 3a 00 00       	call   4098 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     602:	b8 e4 55 00 00       	mov    $0x55e4,%eax
     607:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     60b:	89 44 24 04          	mov    %eax,0x4(%esp)
     60f:	eb d8                	jmp    5e9 <writetest+0x179>
    printf(stdout, "error: open small failed!\n");
     611:	c7 44 24 04 36 47 00 	movl   $0x4736,0x4(%esp)
     618:	00 
     619:	a1 48 66 00 00       	mov    0x6648,%eax
     61e:	89 04 24             	mov    %eax,(%esp)
     621:	e8 da 3b 00 00       	call   4200 <printf>
    exit(0);
     626:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     62d:	e8 66 3a 00 00       	call   4098 <exit>
    printf(stdout, "read failed\n");
     632:	c7 44 24 04 7d 4a 00 	movl   $0x4a7d,0x4(%esp)
     639:	00 
     63a:	eb dd                	jmp    619 <writetest+0x1a9>
    printf(stdout, "unlink small failed\n");
     63c:	c7 44 24 04 64 47 00 	movl   $0x4764,0x4(%esp)
     643:	00 
     644:	eb d3                	jmp    619 <writetest+0x1a9>
    printf(stdout, "error: creat small failed!\n");
     646:	c7 44 24 04 e0 46 00 	movl   $0x46e0,0x4(%esp)
     64d:	00 
     64e:	eb c9                	jmp    619 <writetest+0x1a9>

00000650 <writetest1>:
{
     650:	55                   	push   %ebp
  printf(stdout, "big files test\n");
     651:	ba 8d 47 00 00       	mov    $0x478d,%edx
{
     656:	89 e5                	mov    %esp,%ebp
     658:	56                   	push   %esi
     659:	53                   	push   %ebx
     65a:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "big files test\n");
     65d:	a1 48 66 00 00       	mov    0x6648,%eax
     662:	89 54 24 04          	mov    %edx,0x4(%esp)
     666:	89 04 24             	mov    %eax,(%esp)
     669:	e8 92 3b 00 00       	call   4200 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     66e:	b9 02 02 00 00       	mov    $0x202,%ecx
     673:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     677:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
     67e:	e8 55 3a 00 00       	call   40d8 <open>
  if(fd < 0){
     683:	85 c0                	test   %eax,%eax
     685:	0f 88 73 01 00 00    	js     7fe <writetest1+0x1ae>
     68b:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     68d:	31 db                	xor    %ebx,%ebx
     68f:	90                   	nop
    if(write(fd, buf, 512) != 512){
     690:	b8 00 02 00 00       	mov    $0x200,%eax
     695:	89 44 24 08          	mov    %eax,0x8(%esp)
     699:	b8 20 8e 00 00       	mov    $0x8e20,%eax
     69e:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a2:	89 34 24             	mov    %esi,(%esp)
    ((int*)buf)[0] = i;
     6a5:	89 1d 20 8e 00 00    	mov    %ebx,0x8e20
    if(write(fd, buf, 512) != 512){
     6ab:	e8 08 3a 00 00       	call   40b8 <write>
     6b0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6b5:	0f 85 b1 00 00 00    	jne    76c <writetest1+0x11c>
  for(i = 0; i < MAXFILE; i++){
     6bb:	43                   	inc    %ebx
     6bc:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6c2:	75 cc                	jne    690 <writetest1+0x40>
  close(fd);
     6c4:	89 34 24             	mov    %esi,(%esp)
     6c7:	e8 f4 39 00 00       	call   40c0 <close>
  fd = open("big", O_RDONLY);
     6cc:	31 c0                	xor    %eax,%eax
     6ce:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d2:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
     6d9:	e8 fa 39 00 00       	call   40d8 <open>
  if(fd < 0){
     6de:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     6e0:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6e2:	0f 88 f5 00 00 00    	js     7dd <writetest1+0x18d>
  n = 0;
     6e8:	31 db                	xor    %ebx,%ebx
     6ea:	eb 1d                	jmp    709 <writetest1+0xb9>
     6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(i != 512){
     6f0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f5:	0f 85 c1 00 00 00    	jne    7bc <writetest1+0x16c>
    if(((int*)buf)[0] != n){
     6fb:	a1 20 8e 00 00       	mov    0x8e20,%eax
     700:	39 d8                	cmp    %ebx,%eax
     702:	0f 85 8a 00 00 00    	jne    792 <writetest1+0x142>
    n++;
     708:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     709:	b8 00 02 00 00       	mov    $0x200,%eax
     70e:	89 44 24 08          	mov    %eax,0x8(%esp)
     712:	b8 20 8e 00 00       	mov    $0x8e20,%eax
     717:	89 44 24 04          	mov    %eax,0x4(%esp)
     71b:	89 34 24             	mov    %esi,(%esp)
     71e:	e8 8d 39 00 00       	call   40b0 <read>
    if(i == 0){
     723:	85 c0                	test   %eax,%eax
     725:	75 c9                	jne    6f0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     727:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     72d:	0f 84 98 00 00 00    	je     7cb <writetest1+0x17b>
  close(fd);
     733:	89 34 24             	mov    %esi,(%esp)
     736:	e8 85 39 00 00       	call   40c0 <close>
  if(unlink("big") < 0){
     73b:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
     742:	e8 a1 39 00 00       	call   40e8 <unlink>
     747:	85 c0                	test   %eax,%eax
     749:	0f 88 b9 00 00 00    	js     808 <writetest1+0x1b8>
  printf(stdout, "big files ok\n");
     74f:	b8 2e 48 00 00       	mov    $0x482e,%eax
     754:	89 44 24 04          	mov    %eax,0x4(%esp)
     758:	a1 48 66 00 00       	mov    0x6648,%eax
     75d:	89 04 24             	mov    %eax,(%esp)
     760:	e8 9b 3a 00 00       	call   4200 <printf>
}
     765:	83 c4 10             	add    $0x10,%esp
     768:	5b                   	pop    %ebx
     769:	5e                   	pop    %esi
     76a:	5d                   	pop    %ebp
     76b:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     76c:	b8 b7 47 00 00       	mov    $0x47b7,%eax
     771:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     775:	89 44 24 04          	mov    %eax,0x4(%esp)
        printf(stdout, "read only %d blocks from big", n);
     779:	a1 48 66 00 00       	mov    0x6648,%eax
     77e:	89 04 24             	mov    %eax,(%esp)
     781:	e8 7a 3a 00 00       	call   4200 <printf>
        exit(0);
     786:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     78d:	e8 06 39 00 00       	call   4098 <exit>
      printf(stdout, "read content of block %d is %d\n",
     792:	89 44 24 0c          	mov    %eax,0xc(%esp)
     796:	a1 48 66 00 00       	mov    0x6648,%eax
     79b:	ba 08 56 00 00       	mov    $0x5608,%edx
     7a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     7a4:	89 54 24 04          	mov    %edx,0x4(%esp)
     7a8:	89 04 24             	mov    %eax,(%esp)
     7ab:	e8 50 3a 00 00       	call   4200 <printf>
      exit(0);
     7b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     7b7:	e8 dc 38 00 00       	call   4098 <exit>
      printf(stdout, "read failed %d\n", i);
     7bc:	b9 0b 48 00 00       	mov    $0x480b,%ecx
     7c1:	89 44 24 08          	mov    %eax,0x8(%esp)
     7c5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     7c9:	eb ae                	jmp    779 <writetest1+0x129>
        printf(stdout, "read only %d blocks from big", n);
     7cb:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     7d2:	00 
     7d3:	c7 44 24 04 ee 47 00 	movl   $0x47ee,0x4(%esp)
     7da:	00 
     7db:	eb 9c                	jmp    779 <writetest1+0x129>
    printf(stdout, "error: open big failed!\n");
     7dd:	c7 44 24 04 d5 47 00 	movl   $0x47d5,0x4(%esp)
     7e4:	00 
     7e5:	a1 48 66 00 00       	mov    0x6648,%eax
     7ea:	89 04 24             	mov    %eax,(%esp)
     7ed:	e8 0e 3a 00 00       	call   4200 <printf>
    exit(0);
     7f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     7f9:	e8 9a 38 00 00       	call   4098 <exit>
    printf(stdout, "error: creat big failed!\n");
     7fe:	c7 44 24 04 9d 47 00 	movl   $0x479d,0x4(%esp)
     805:	00 
     806:	eb dd                	jmp    7e5 <writetest1+0x195>
    printf(stdout, "unlink big failed\n");
     808:	c7 44 24 04 1b 48 00 	movl   $0x481b,0x4(%esp)
     80f:	00 
     810:	eb d3                	jmp    7e5 <writetest1+0x195>
     812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <createtest>:
{
     820:	55                   	push   %ebp
  printf(stdout, "many creates, followed by unlink test\n");
     821:	b8 28 56 00 00       	mov    $0x5628,%eax
{
     826:	89 e5                	mov    %esp,%ebp
     828:	53                   	push   %ebx
  name[2] = '\0';
     829:	b3 30                	mov    $0x30,%bl
{
     82b:	83 ec 14             	sub    $0x14,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     82e:	89 44 24 04          	mov    %eax,0x4(%esp)
     832:	a1 48 66 00 00       	mov    0x6648,%eax
     837:	89 04 24             	mov    %eax,(%esp)
     83a:	e8 c1 39 00 00       	call   4200 <printf>
  name[0] = 'a';
     83f:	b0 61                	mov    $0x61,%al
     841:	a2 20 ae 00 00       	mov    %al,0xae20
  name[2] = '\0';
     846:	31 c0                	xor    %eax,%eax
     848:	a2 22 ae 00 00       	mov    %al,0xae22
     84d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     850:	b8 02 02 00 00       	mov    $0x202,%eax
     855:	89 44 24 04          	mov    %eax,0x4(%esp)
     859:	c7 04 24 20 ae 00 00 	movl   $0xae20,(%esp)
    name[1] = '0' + i;
     860:	88 1d 21 ae 00 00    	mov    %bl,0xae21
     866:	fe c3                	inc    %bl
    fd = open(name, O_CREATE|O_RDWR);
     868:	e8 6b 38 00 00       	call   40d8 <open>
    close(fd);
     86d:	89 04 24             	mov    %eax,(%esp)
     870:	e8 4b 38 00 00       	call   40c0 <close>
  for(i = 0; i < 52; i++){
     875:	80 fb 64             	cmp    $0x64,%bl
     878:	75 d6                	jne    850 <createtest+0x30>
  name[0] = 'a';
     87a:	b2 61                	mov    $0x61,%dl
  name[2] = '\0';
     87c:	31 c9                	xor    %ecx,%ecx
  name[0] = 'a';
     87e:	88 15 20 ae 00 00    	mov    %dl,0xae20
  name[2] = '\0';
     884:	b3 30                	mov    $0x30,%bl
     886:	88 0d 22 ae 00 00    	mov    %cl,0xae22
     88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    name[1] = '0' + i;
     890:	88 1d 21 ae 00 00    	mov    %bl,0xae21
     896:	fe c3                	inc    %bl
    unlink(name);
     898:	c7 04 24 20 ae 00 00 	movl   $0xae20,(%esp)
     89f:	e8 44 38 00 00       	call   40e8 <unlink>
  for(i = 0; i < 52; i++){
     8a4:	80 fb 64             	cmp    $0x64,%bl
     8a7:	75 e7                	jne    890 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8a9:	b8 50 56 00 00       	mov    $0x5650,%eax
     8ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     8b2:	a1 48 66 00 00       	mov    0x6648,%eax
     8b7:	89 04 24             	mov    %eax,(%esp)
     8ba:	e8 41 39 00 00       	call   4200 <printf>
}
     8bf:	83 c4 14             	add    $0x14,%esp
     8c2:	5b                   	pop    %ebx
     8c3:	5d                   	pop    %ebp
     8c4:	c3                   	ret    
     8c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008d0 <dirtest>:
{
     8d0:	55                   	push   %ebp
  printf(stdout, "mkdir test\n");
     8d1:	ba 3c 48 00 00       	mov    $0x483c,%edx
{
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     8db:	a1 48 66 00 00       	mov    0x6648,%eax
     8e0:	89 54 24 04          	mov    %edx,0x4(%esp)
     8e4:	89 04 24             	mov    %eax,(%esp)
     8e7:	e8 14 39 00 00       	call   4200 <printf>
  if(mkdir("dir0") < 0){
     8ec:	c7 04 24 48 48 00 00 	movl   $0x4848,(%esp)
     8f3:	e8 08 38 00 00       	call   4100 <mkdir>
     8f8:	85 c0                	test   %eax,%eax
     8fa:	78 48                	js     944 <dirtest+0x74>
  if(chdir("dir0") < 0){
     8fc:	c7 04 24 48 48 00 00 	movl   $0x4848,(%esp)
     903:	e8 00 38 00 00       	call   4108 <chdir>
     908:	85 c0                	test   %eax,%eax
     90a:	78 6d                	js     979 <dirtest+0xa9>
  if(chdir("..") < 0){
     90c:	c7 04 24 ed 4d 00 00 	movl   $0x4ded,(%esp)
     913:	e8 f0 37 00 00       	call   4108 <chdir>
     918:	85 c0                	test   %eax,%eax
     91a:	78 53                	js     96f <dirtest+0x9f>
  if(unlink("dir0") < 0){
     91c:	c7 04 24 48 48 00 00 	movl   $0x4848,(%esp)
     923:	e8 c0 37 00 00       	call   40e8 <unlink>
     928:	85 c0                	test   %eax,%eax
     92a:	78 39                	js     965 <dirtest+0x95>
  printf(stdout, "mkdir test ok\n");
     92c:	b8 85 48 00 00       	mov    $0x4885,%eax
     931:	89 44 24 04          	mov    %eax,0x4(%esp)
     935:	a1 48 66 00 00       	mov    0x6648,%eax
     93a:	89 04 24             	mov    %eax,(%esp)
     93d:	e8 be 38 00 00       	call   4200 <printf>
}
     942:	c9                   	leave  
     943:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     944:	c7 44 24 04 78 45 00 	movl   $0x4578,0x4(%esp)
     94b:	00 
    printf(stdout, "chdir dir0 failed\n");
     94c:	a1 48 66 00 00       	mov    0x6648,%eax
     951:	89 04 24             	mov    %eax,(%esp)
     954:	e8 a7 38 00 00       	call   4200 <printf>
    exit(0);
     959:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     960:	e8 33 37 00 00       	call   4098 <exit>
    printf(stdout, "unlink dir0 failed\n");
     965:	c7 44 24 04 71 48 00 	movl   $0x4871,0x4(%esp)
     96c:	00 
     96d:	eb dd                	jmp    94c <dirtest+0x7c>
    printf(stdout, "chdir .. failed\n");
     96f:	c7 44 24 04 60 48 00 	movl   $0x4860,0x4(%esp)
     976:	00 
     977:	eb d3                	jmp    94c <dirtest+0x7c>
    printf(stdout, "chdir dir0 failed\n");
     979:	c7 44 24 04 4d 48 00 	movl   $0x484d,0x4(%esp)
     980:	00 
     981:	eb c9                	jmp    94c <dirtest+0x7c>
     983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <exectest>:
{
     990:	55                   	push   %ebp
  printf(stdout, "exec test\n");
     991:	b8 94 48 00 00       	mov    $0x4894,%eax
{
     996:	89 e5                	mov    %esp,%ebp
     998:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     99b:	89 44 24 04          	mov    %eax,0x4(%esp)
     99f:	a1 48 66 00 00       	mov    0x6648,%eax
     9a4:	89 04 24             	mov    %eax,(%esp)
     9a7:	e8 54 38 00 00       	call   4200 <printf>
  if(exec("echo", echoargv) < 0){
     9ac:	ba 4c 66 00 00       	mov    $0x664c,%edx
     9b1:	89 54 24 04          	mov    %edx,0x4(%esp)
     9b5:	c7 04 24 5d 46 00 00 	movl   $0x465d,(%esp)
     9bc:	e8 0f 37 00 00       	call   40d0 <exec>
     9c1:	85 c0                	test   %eax,%eax
     9c3:	78 02                	js     9c7 <exectest+0x37>
}
     9c5:	c9                   	leave  
     9c6:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     9c7:	a1 48 66 00 00       	mov    0x6648,%eax
     9cc:	c7 44 24 04 9f 48 00 	movl   $0x489f,0x4(%esp)
     9d3:	00 
     9d4:	89 04 24             	mov    %eax,(%esp)
     9d7:	e8 24 38 00 00       	call   4200 <printf>
    exit(0);
     9dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     9e3:	e8 b0 36 00 00       	call   4098 <exit>
     9e8:	90                   	nop
     9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <pipe1>:
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	57                   	push   %edi
     9f4:	56                   	push   %esi
     9f5:	53                   	push   %ebx
     9f6:	83 ec 3c             	sub    $0x3c,%esp
  if(pipe(fds) != 0){
     9f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9fc:	89 04 24             	mov    %eax,(%esp)
     9ff:	e8 a4 36 00 00       	call   40a8 <pipe>
     a04:	85 c0                	test   %eax,%eax
     a06:	0f 85 6a 01 00 00    	jne    b76 <pipe1+0x186>
     a0c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  pid = fork();
     a0f:	e8 7c 36 00 00       	call   4090 <fork>
  if(pid == 0){
     a14:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     a17:	83 f8 00             	cmp    $0x0,%eax
     a1a:	0f 84 94 00 00 00    	je     ab4 <pipe1+0xc4>
     a20:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  } else if(pid > 0){
     a23:	0f 8e 6d 01 00 00    	jle    b96 <pipe1+0x1a6>
    close(fds[1]);
     a29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    cc = 1;
     a2c:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a31:	89 04 24             	mov    %eax,(%esp)
     a34:	e8 87 36 00 00       	call   40c0 <close>
     a39:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    total = 0;
     a3c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a43:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a46:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     a49:	ba 20 8e 00 00       	mov    $0x8e20,%edx
     a4e:	89 54 24 04          	mov    %edx,0x4(%esp)
     a52:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a56:	89 04 24             	mov    %eax,(%esp)
     a59:	e8 52 36 00 00       	call   40b0 <read>
     a5e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     a61:	85 c0                	test   %eax,%eax
     a63:	0f 8e b3 00 00 00    	jle    b1c <pipe1+0x12c>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a69:	89 d3                	mov    %edx,%ebx
     a6b:	8d 34 10             	lea    (%eax,%edx,1),%esi
     a6e:	f7 db                	neg    %ebx
     a70:	38 94 1a 20 8e 00 00 	cmp    %dl,0x8e20(%edx,%ebx,1)
     a77:	8d 4a 01             	lea    0x1(%edx),%ecx
     a7a:	75 1b                	jne    a97 <pipe1+0xa7>
      for(i = 0; i < n; i++){
     a7c:	39 ce                	cmp    %ecx,%esi
     a7e:	89 ca                	mov    %ecx,%edx
     a80:	75 ee                	jne    a70 <pipe1+0x80>
      cc = cc * 2;
     a82:	01 ff                	add    %edi,%edi
      total += n;
     a84:	01 45 d0             	add    %eax,-0x30(%ebp)
     a87:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a8d:	b8 00 20 00 00       	mov    $0x2000,%eax
     a92:	0f 4f f8             	cmovg  %eax,%edi
     a95:	eb ac                	jmp    a43 <pipe1+0x53>
          printf(1, "pipe1 oops 2\n");
     a97:	b9 ce 48 00 00       	mov    $0x48ce,%ecx
     a9c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     aa0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     aa7:	e8 54 37 00 00       	call   4200 <printf>
}
     aac:	83 c4 3c             	add    $0x3c,%esp
     aaf:	5b                   	pop    %ebx
     ab0:	5e                   	pop    %esi
     ab1:	5f                   	pop    %edi
     ab2:	5d                   	pop    %ebp
     ab3:	c3                   	ret    
    close(fds[0]);
     ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ab7:	31 db                	xor    %ebx,%ebx
     ab9:	89 04 24             	mov    %eax,(%esp)
     abc:	e8 ff 35 00 00       	call   40c0 <close>
{
     ac1:	88 da                	mov    %bl,%dl
      for(i = 0; i < 1033; i++)
     ac3:	31 c0                	xor    %eax,%eax
     ac5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        buf[i] = seq++;
     ad0:	88 90 20 8e 00 00    	mov    %dl,0x8e20(%eax)
      for(i = 0; i < 1033; i++)
     ad6:	40                   	inc    %eax
     ad7:	fe c2                	inc    %dl
     ad9:	3d 09 04 00 00       	cmp    $0x409,%eax
     ade:	75 f0                	jne    ad0 <pipe1+0xe0>
      if(write(fds[1], buf, 1033) != 1033){
     ae0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ae3:	be 09 04 00 00       	mov    $0x409,%esi
     ae8:	bf 20 8e 00 00       	mov    $0x8e20,%edi
     aed:	89 74 24 08          	mov    %esi,0x8(%esp)
     af1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     af5:	89 04 24             	mov    %eax,(%esp)
     af8:	e8 bb 35 00 00       	call   40b8 <write>
     afd:	3d 09 04 00 00       	cmp    $0x409,%eax
     b02:	0f 85 ae 00 00 00    	jne    bb6 <pipe1+0x1c6>
     b08:	80 c3 09             	add    $0x9,%bl
    for(n = 0; n < 5; n++){
     b0b:	80 fb 2d             	cmp    $0x2d,%bl
     b0e:	75 b1                	jne    ac1 <pipe1+0xd1>
      exit(0);
     b10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b17:	e8 7c 35 00 00       	call   4098 <exit>
    if(total != 5 * 1033){
     b1c:	81 7d d0 2d 14 00 00 	cmpl   $0x142d,-0x30(%ebp)
     b23:	75 34                	jne    b59 <pipe1+0x169>
    close(fds[0]);
     b25:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b28:	89 04 24             	mov    %eax,(%esp)
     b2b:	e8 90 35 00 00       	call   40c0 <close>
    wait(null);
     b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b37:	e8 64 35 00 00       	call   40a0 <wait>
  printf(1, "pipe1 ok\n");
     b3c:	b8 f3 48 00 00       	mov    $0x48f3,%eax
     b41:	89 44 24 04          	mov    %eax,0x4(%esp)
     b45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b4c:	e8 af 36 00 00       	call   4200 <printf>
}
     b51:	83 c4 3c             	add    $0x3c,%esp
     b54:	5b                   	pop    %ebx
     b55:	5e                   	pop    %esi
     b56:	5f                   	pop    %edi
     b57:	5d                   	pop    %ebp
     b58:	c3                   	ret    
      printf(1, "pipe1 oops 3 total %d\n", total);
     b59:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b5c:	c7 44 24 04 dc 48 00 	movl   $0x48dc,0x4(%esp)
     b63:	00 
     b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b6b:	89 44 24 08          	mov    %eax,0x8(%esp)
     b6f:	e8 8c 36 00 00       	call   4200 <printf>
     b74:	eb 9a                	jmp    b10 <pipe1+0x120>
    printf(1, "pipe() failed\n");
     b76:	c7 44 24 04 b1 48 00 	movl   $0x48b1,0x4(%esp)
     b7d:	00 
     b7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b85:	e8 76 36 00 00       	call   4200 <printf>
    exit(0);
     b8a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b91:	e8 02 35 00 00       	call   4098 <exit>
    printf(1, "fork() failed\n");
     b96:	c7 44 24 04 fd 48 00 	movl   $0x48fd,0x4(%esp)
     b9d:	00 
     b9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ba5:	e8 56 36 00 00       	call   4200 <printf>
    exit(0);
     baa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bb1:	e8 e2 34 00 00       	call   4098 <exit>
        printf(1, "pipe1 oops 1\n");
     bb6:	c7 44 24 04 c0 48 00 	movl   $0x48c0,0x4(%esp)
     bbd:	00 
     bbe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bc5:	e8 36 36 00 00       	call   4200 <printf>
        exit(0);
     bca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bd1:	e8 c2 34 00 00       	call   4098 <exit>
     bd6:	8d 76 00             	lea    0x0(%esi),%esi
     bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000be0 <preempt>:
{
     be0:	55                   	push   %ebp
  printf(1, "preempt: ");
     be1:	b8 0c 49 00 00       	mov    $0x490c,%eax
{
     be6:	89 e5                	mov    %esp,%ebp
     be8:	57                   	push   %edi
     be9:	56                   	push   %esi
     bea:	53                   	push   %ebx
     beb:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "preempt: ");
     bee:	89 44 24 04          	mov    %eax,0x4(%esp)
     bf2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bf9:	e8 02 36 00 00       	call   4200 <printf>
  pid1 = fork();
     bfe:	e8 8d 34 00 00       	call   4090 <fork>
  if(pid1 == 0)
     c03:	85 c0                	test   %eax,%eax
     c05:	75 02                	jne    c09 <preempt+0x29>
     c07:	eb fe                	jmp    c07 <preempt+0x27>
     c09:	89 c7                	mov    %eax,%edi
     c0b:	90                   	nop
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pid2 = fork();
     c10:	e8 7b 34 00 00       	call   4090 <fork>
  if(pid2 == 0)
     c15:	85 c0                	test   %eax,%eax
  pid2 = fork();
     c17:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     c19:	75 02                	jne    c1d <preempt+0x3d>
     c1b:	eb fe                	jmp    c1b <preempt+0x3b>
  pipe(pfds);
     c1d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c20:	89 04 24             	mov    %eax,(%esp)
     c23:	e8 80 34 00 00       	call   40a8 <pipe>
  pid3 = fork();
     c28:	e8 63 34 00 00       	call   4090 <fork>
  if(pid3 == 0){
     c2d:	85 c0                	test   %eax,%eax
  pid3 = fork();
     c2f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c31:	75 4a                	jne    c7d <preempt+0x9d>
    close(pfds[0]);
     c33:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c36:	89 04 24             	mov    %eax,(%esp)
     c39:	e8 82 34 00 00       	call   40c0 <close>
    if(write(pfds[1], "x", 1) != 1)
     c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c41:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c48:	00 
     c49:	c7 44 24 04 d1 4e 00 	movl   $0x4ed1,0x4(%esp)
     c50:	00 
     c51:	89 04 24             	mov    %eax,(%esp)
     c54:	e8 5f 34 00 00       	call   40b8 <write>
     c59:	48                   	dec    %eax
     c5a:	74 14                	je     c70 <preempt+0x90>
      printf(1, "preempt write error");
     c5c:	c7 44 24 04 16 49 00 	movl   $0x4916,0x4(%esp)
     c63:	00 
     c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c6b:	e8 90 35 00 00       	call   4200 <printf>
    close(pfds[1]);
     c70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c73:	89 04 24             	mov    %eax,(%esp)
     c76:	e8 45 34 00 00       	call   40c0 <close>
     c7b:	eb fe                	jmp    c7b <preempt+0x9b>
  close(pfds[1]);
     c7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c80:	89 04 24             	mov    %eax,(%esp)
     c83:	e8 38 34 00 00       	call   40c0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c88:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c8b:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     c92:	00 
     c93:	c7 44 24 04 20 8e 00 	movl   $0x8e20,0x4(%esp)
     c9a:	00 
     c9b:	89 04 24             	mov    %eax,(%esp)
     c9e:	e8 0d 34 00 00       	call   40b0 <read>
     ca3:	48                   	dec    %eax
     ca4:	74 1c                	je     cc2 <preempt+0xe2>
    printf(1, "preempt read error");
     ca6:	c7 44 24 04 2a 49 00 	movl   $0x492a,0x4(%esp)
     cad:	00 
     cae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cb5:	e8 46 35 00 00       	call   4200 <printf>
}
     cba:	83 c4 2c             	add    $0x2c,%esp
     cbd:	5b                   	pop    %ebx
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	5d                   	pop    %ebp
     cc1:	c3                   	ret    
  close(pfds[0]);
     cc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cc5:	89 04 24             	mov    %eax,(%esp)
     cc8:	e8 f3 33 00 00       	call   40c0 <close>
  printf(1, "kill... ");
     ccd:	c7 44 24 04 3d 49 00 	movl   $0x493d,0x4(%esp)
     cd4:	00 
     cd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cdc:	e8 1f 35 00 00       	call   4200 <printf>
  kill(pid1);
     ce1:	89 3c 24             	mov    %edi,(%esp)
     ce4:	e8 df 33 00 00       	call   40c8 <kill>
  kill(pid2);
     ce9:	89 34 24             	mov    %esi,(%esp)
     cec:	e8 d7 33 00 00       	call   40c8 <kill>
  kill(pid3);
     cf1:	89 1c 24             	mov    %ebx,(%esp)
     cf4:	e8 cf 33 00 00       	call   40c8 <kill>
  printf(1, "wait... ");
     cf9:	c7 44 24 04 46 49 00 	movl   $0x4946,0x4(%esp)
     d00:	00 
     d01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d08:	e8 f3 34 00 00       	call   4200 <printf>
  wait(null);
     d0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d14:	e8 87 33 00 00       	call   40a0 <wait>
  wait(null);
     d19:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d20:	e8 7b 33 00 00       	call   40a0 <wait>
  wait(null);
     d25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d2c:	e8 6f 33 00 00       	call   40a0 <wait>
  printf(1, "preempt ok\n");
     d31:	c7 44 24 04 4f 49 00 	movl   $0x494f,0x4(%esp)
     d38:	00 
     d39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d40:	e8 bb 34 00 00       	call   4200 <printf>
     d45:	e9 70 ff ff ff       	jmp    cba <preempt+0xda>
     d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d50 <exitwait>:
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	56                   	push   %esi
     d54:	be 64 00 00 00       	mov    $0x64,%esi
     d59:	53                   	push   %ebx
     d5a:	83 ec 10             	sub    $0x10,%esp
     d5d:	eb 16                	jmp    d75 <exitwait+0x25>
     d5f:	90                   	nop
      if(wait(null) != pid){
     d60:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    if(pid){
     d67:	74 73                	je     ddc <exitwait+0x8c>
      if(wait(null) != pid){
     d69:	e8 32 33 00 00       	call   40a0 <wait>
     d6e:	39 d8                	cmp    %ebx,%eax
     d70:	75 2e                	jne    da0 <exitwait+0x50>
  for(i = 0; i < 100; i++){
     d72:	4e                   	dec    %esi
     d73:	74 4b                	je     dc0 <exitwait+0x70>
    pid = fork();
     d75:	e8 16 33 00 00       	call   4090 <fork>
    if(pid < 0){
     d7a:	85 c0                	test   %eax,%eax
    pid = fork();
     d7c:	89 c3                	mov    %eax,%ebx
     d7e:	66 90                	xchg   %ax,%ax
    if(pid < 0){
     d80:	79 de                	jns    d60 <exitwait+0x10>
      printf(1, "fork failed\n");
     d82:	b9 b9 54 00 00       	mov    $0x54b9,%ecx
     d87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     d8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d92:	e8 69 34 00 00       	call   4200 <printf>
}
     d97:	83 c4 10             	add    $0x10,%esp
     d9a:	5b                   	pop    %ebx
     d9b:	5e                   	pop    %esi
     d9c:	5d                   	pop    %ebp
     d9d:	c3                   	ret    
     d9e:	66 90                	xchg   %ax,%ax
        printf(1, "wait wrong pid\n");
     da0:	ba 5b 49 00 00       	mov    $0x495b,%edx
     da5:	89 54 24 04          	mov    %edx,0x4(%esp)
     da9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     db0:	e8 4b 34 00 00       	call   4200 <printf>
}
     db5:	83 c4 10             	add    $0x10,%esp
     db8:	5b                   	pop    %ebx
     db9:	5e                   	pop    %esi
     dba:	5d                   	pop    %ebp
     dbb:	c3                   	ret    
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "exitwait ok\n");
     dc0:	b8 6b 49 00 00       	mov    $0x496b,%eax
     dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
     dc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dd0:	e8 2b 34 00 00       	call   4200 <printf>
}
     dd5:	83 c4 10             	add    $0x10,%esp
     dd8:	5b                   	pop    %ebx
     dd9:	5e                   	pop    %esi
     dda:	5d                   	pop    %ebp
     ddb:	c3                   	ret    
      exit(0);
     ddc:	e8 b7 32 00 00       	call   4098 <exit>
     de1:	eb 0d                	jmp    df0 <mem>
     de3:	90                   	nop
     de4:	90                   	nop
     de5:	90                   	nop
     de6:	90                   	nop
     de7:	90                   	nop
     de8:	90                   	nop
     de9:	90                   	nop
     dea:	90                   	nop
     deb:	90                   	nop
     dec:	90                   	nop
     ded:	90                   	nop
     dee:	90                   	nop
     def:	90                   	nop

00000df0 <mem>:
{
     df0:	55                   	push   %ebp
  printf(1, "mem test\n");
     df1:	b9 78 49 00 00       	mov    $0x4978,%ecx
{
     df6:	89 e5                	mov    %esp,%ebp
     df8:	57                   	push   %edi
     df9:	56                   	push   %esi
     dfa:	53                   	push   %ebx
     dfb:	31 db                	xor    %ebx,%ebx
     dfd:	83 ec 1c             	sub    $0x1c,%esp
  printf(1, "mem test\n");
     e00:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     e04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e0b:	e8 f0 33 00 00       	call   4200 <printf>
  ppid = getpid();
     e10:	e8 03 33 00 00       	call   4118 <getpid>
     e15:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     e17:	e8 74 32 00 00       	call   4090 <fork>
     e1c:	85 c0                	test   %eax,%eax
     e1e:	74 0c                	je     e2c <mem+0x3c>
     e20:	e9 9b 00 00 00       	jmp    ec0 <mem+0xd0>
     e25:	8d 76 00             	lea    0x0(%esi),%esi
      *(char**)m2 = m1;
     e28:	89 18                	mov    %ebx,(%eax)
     e2a:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     e2c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     e33:	e8 58 36 00 00       	call   4490 <malloc>
     e38:	85 c0                	test   %eax,%eax
     e3a:	75 ec                	jne    e28 <mem+0x38>
    while(m1){
     e3c:	85 db                	test   %ebx,%ebx
     e3e:	74 10                	je     e50 <mem+0x60>
      m2 = *(char**)m1;
     e40:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     e42:	89 1c 24             	mov    %ebx,(%esp)
     e45:	e8 a6 35 00 00       	call   43f0 <free>
     e4a:	89 fb                	mov    %edi,%ebx
    while(m1){
     e4c:	85 db                	test   %ebx,%ebx
     e4e:	75 f0                	jne    e40 <mem+0x50>
    m1 = malloc(1024*20);
     e50:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     e57:	e8 34 36 00 00       	call   4490 <malloc>
    if(m1 == 0){
     e5c:	85 c0                	test   %eax,%eax
     e5e:	74 30                	je     e90 <mem+0xa0>
    free(m1);
     e60:	89 04 24             	mov    %eax,(%esp)
     e63:	e8 88 35 00 00       	call   43f0 <free>
    printf(1, "mem ok\n");
     e68:	b8 9c 49 00 00       	mov    $0x499c,%eax
     e6d:	89 44 24 04          	mov    %eax,0x4(%esp)
     e71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e78:	e8 83 33 00 00       	call   4200 <printf>
    exit(0);
     e7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e84:	e8 0f 32 00 00       	call   4098 <exit>
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e90:	ba 82 49 00 00       	mov    $0x4982,%edx
     e95:	89 54 24 04          	mov    %edx,0x4(%esp)
     e99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ea0:	e8 5b 33 00 00       	call   4200 <printf>
      kill(ppid);
     ea5:	89 34 24             	mov    %esi,(%esp)
     ea8:	e8 1b 32 00 00       	call   40c8 <kill>
      exit(0);
     ead:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eb4:	e8 df 31 00 00       	call   4098 <exit>
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait(null);
     ec0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ec7:	e8 d4 31 00 00       	call   40a0 <wait>
}
     ecc:	83 c4 1c             	add    $0x1c,%esp
     ecf:	5b                   	pop    %ebx
     ed0:	5e                   	pop    %esi
     ed1:	5f                   	pop    %edi
     ed2:	5d                   	pop    %ebp
     ed3:	c3                   	ret    
     ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ee0 <sharedfd>:
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	57                   	push   %edi
     ee4:	56                   	push   %esi
  fd = open("sharedfd", O_CREATE|O_RDWR);
     ee5:	be 02 02 00 00       	mov    $0x202,%esi
{
     eea:	53                   	push   %ebx
  printf(1, "sharedfd test\n");
     eeb:	bb a4 49 00 00       	mov    $0x49a4,%ebx
{
     ef0:	83 ec 3c             	sub    $0x3c,%esp
  printf(1, "sharedfd test\n");
     ef3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     ef7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     efe:	e8 fd 32 00 00       	call   4200 <printf>
  unlink("sharedfd");
     f03:	c7 04 24 b3 49 00 00 	movl   $0x49b3,(%esp)
     f0a:	e8 d9 31 00 00       	call   40e8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     f0f:	89 74 24 04          	mov    %esi,0x4(%esp)
     f13:	c7 04 24 b3 49 00 00 	movl   $0x49b3,(%esp)
     f1a:	e8 b9 31 00 00       	call   40d8 <open>
  if(fd < 0){
     f1f:	85 c0                	test   %eax,%eax
     f21:	0f 88 59 01 00 00    	js     1080 <sharedfd+0x1a0>
     f27:	89 c6                	mov    %eax,%esi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f29:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     f2e:	e8 5d 31 00 00       	call   4090 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f33:	8d 7d de             	lea    -0x22(%ebp),%edi
     f36:	ba 0a 00 00 00       	mov    $0xa,%edx
     f3b:	89 54 24 08          	mov    %edx,0x8(%esp)
     f3f:	89 3c 24             	mov    %edi,(%esp)
     f42:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     f45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f48:	19 c0                	sbb    %eax,%eax
     f4a:	83 e0 f3             	and    $0xfffffff3,%eax
     f4d:	83 c0 70             	add    $0x70,%eax
     f50:	89 44 24 04          	mov    %eax,0x4(%esp)
     f54:	e8 a7 2f 00 00       	call   3f00 <memset>
     f59:	eb 08                	jmp    f63 <sharedfd+0x83>
     f5b:	90                   	nop
     f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     f60:	4b                   	dec    %ebx
     f61:	74 2f                	je     f92 <sharedfd+0xb2>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f63:	b8 0a 00 00 00       	mov    $0xa,%eax
     f68:	89 44 24 08          	mov    %eax,0x8(%esp)
     f6c:	89 7c 24 04          	mov    %edi,0x4(%esp)
     f70:	89 34 24             	mov    %esi,(%esp)
     f73:	e8 40 31 00 00       	call   40b8 <write>
     f78:	83 f8 0a             	cmp    $0xa,%eax
     f7b:	74 e3                	je     f60 <sharedfd+0x80>
      printf(1, "fstests: write sharedfd failed\n");
     f7d:	b8 a4 56 00 00       	mov    $0x56a4,%eax
     f82:	89 44 24 04          	mov    %eax,0x4(%esp)
     f86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f8d:	e8 6e 32 00 00       	call   4200 <printf>
  if(pid == 0)
     f92:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    exit(0);
     f95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid == 0)
     f9c:	85 c0                	test   %eax,%eax
     f9e:	0f 84 39 01 00 00    	je     10dd <sharedfd+0x1fd>
    wait(null);
     fa4:	e8 f7 30 00 00       	call   40a0 <wait>
  fd = open("sharedfd", 0);
     fa9:	31 db                	xor    %ebx,%ebx
  close(fd);
     fab:	89 34 24             	mov    %esi,(%esp)
     fae:	e8 0d 31 00 00       	call   40c0 <close>
  fd = open("sharedfd", 0);
     fb3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     fb7:	c7 04 24 b3 49 00 00 	movl   $0x49b3,(%esp)
     fbe:	e8 15 31 00 00       	call   40d8 <open>
  if(fd < 0){
     fc3:	85 c0                	test   %eax,%eax
  fd = open("sharedfd", 0);
     fc5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     fc8:	0f 88 cf 00 00 00    	js     109d <sharedfd+0x1bd>
  nc = np = 0;
     fce:	31 db                	xor    %ebx,%ebx
     fd0:	31 c9                	xor    %ecx,%ecx
     fd2:	8d 75 e8             	lea    -0x18(%ebp),%esi
     fd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fe0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     fe3:	ba 0a 00 00 00       	mov    $0xa,%edx
     fe8:	89 54 24 08          	mov    %edx,0x8(%esp)
     fec:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ff0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
     ff3:	89 04 24             	mov    %eax,(%esp)
     ff6:	e8 b5 30 00 00       	call   40b0 <read>
     ffb:	85 c0                	test   %eax,%eax
     ffd:	7e 31                	jle    1030 <sharedfd+0x150>
     fff:	89 f8                	mov    %edi,%eax
    1001:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1004:	eb 1a                	jmp    1020 <sharedfd+0x140>
    1006:	8d 76 00             	lea    0x0(%esi),%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        np++;
    1010:	80 fa 70             	cmp    $0x70,%dl
    1013:	0f 94 c2             	sete   %dl
    1016:	0f b6 d2             	movzbl %dl,%edx
    1019:	01 d3                	add    %edx,%ebx
    101b:	40                   	inc    %eax
    for(i = 0; i < sizeof(buf); i++){
    101c:	39 f0                	cmp    %esi,%eax
    101e:	74 c0                	je     fe0 <sharedfd+0x100>
      if(buf[i] == 'c')
    1020:	0f b6 10             	movzbl (%eax),%edx
    1023:	80 fa 63             	cmp    $0x63,%dl
    1026:	75 e8                	jne    1010 <sharedfd+0x130>
        nc++;
    1028:	41                   	inc    %ecx
    1029:	eb f0                	jmp    101b <sharedfd+0x13b>
    102b:	90                   	nop
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1030:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1033:	89 04 24             	mov    %eax,(%esp)
    1036:	e8 85 30 00 00       	call   40c0 <close>
  unlink("sharedfd");
    103b:	c7 04 24 b3 49 00 00 	movl   $0x49b3,(%esp)
    1042:	e8 a1 30 00 00       	call   40e8 <unlink>
  if(nc == 10000 && np == 10000){
    1047:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    104a:	81 f9 10 27 00 00    	cmp    $0x2710,%ecx
    1050:	75 68                	jne    10ba <sharedfd+0x1da>
    1052:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    1058:	75 60                	jne    10ba <sharedfd+0x1da>
    printf(1, "sharedfd ok\n");
    105a:	b8 bc 49 00 00       	mov    $0x49bc,%eax
    105f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1063:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    106a:	e8 91 31 00 00       	call   4200 <printf>
}
    106f:	83 c4 3c             	add    $0x3c,%esp
    1072:	5b                   	pop    %ebx
    1073:	5e                   	pop    %esi
    1074:	5f                   	pop    %edi
    1075:	5d                   	pop    %ebp
    1076:	c3                   	ret    
    1077:	89 f6                	mov    %esi,%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    1080:	b9 78 56 00 00       	mov    $0x5678,%ecx
    1085:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1089:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1090:	e8 6b 31 00 00       	call   4200 <printf>
}
    1095:	83 c4 3c             	add    $0x3c,%esp
    1098:	5b                   	pop    %ebx
    1099:	5e                   	pop    %esi
    109a:	5f                   	pop    %edi
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
    109d:	b9 c4 56 00 00       	mov    $0x56c4,%ecx
    10a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    10a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ad:	e8 4e 31 00 00       	call   4200 <printf>
}
    10b2:	83 c4 3c             	add    $0x3c,%esp
    10b5:	5b                   	pop    %ebx
    10b6:	5e                   	pop    %esi
    10b7:	5f                   	pop    %edi
    10b8:	5d                   	pop    %ebp
    10b9:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
    10ba:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    10be:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    10c2:	c7 44 24 04 c9 49 00 	movl   $0x49c9,0x4(%esp)
    10c9:	00 
    10ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d1:	e8 2a 31 00 00       	call   4200 <printf>
    exit(0);
    10d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10dd:	e8 b6 2f 00 00       	call   4098 <exit>
    10e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <fourfiles>:
{
    10f0:	55                   	push   %ebp
  printf(1, "fourfiles test\n");
    10f1:	b8 e4 49 00 00       	mov    $0x49e4,%eax
{
    10f6:	89 e5                	mov    %esp,%ebp
    10f8:	57                   	push   %edi
    10f9:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    10fa:	be de 49 00 00       	mov    $0x49de,%esi
{
    10ff:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1100:	31 db                	xor    %ebx,%ebx
{
    1102:	83 ec 3c             	sub    $0x3c,%esp
  printf(1, "fourfiles test\n");
    1105:	89 44 24 04          	mov    %eax,0x4(%esp)
    1109:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char *names[] = { "f0", "f1", "f2", "f3" };
    1110:	c7 45 d8 de 49 00 00 	movl   $0x49de,-0x28(%ebp)
    1117:	c7 45 dc 27 4b 00 00 	movl   $0x4b27,-0x24(%ebp)
    111e:	c7 45 e0 2b 4b 00 00 	movl   $0x4b2b,-0x20(%ebp)
    1125:	c7 45 e4 e1 49 00 00 	movl   $0x49e1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    112c:	e8 cf 30 00 00       	call   4200 <printf>
    unlink(fname);
    1131:	89 34 24             	mov    %esi,(%esp)
    1134:	e8 af 2f 00 00       	call   40e8 <unlink>
    pid = fork();
    1139:	e8 52 2f 00 00       	call   4090 <fork>
    if(pid < 0){
    113e:	85 c0                	test   %eax,%eax
    1140:	0f 88 a8 01 00 00    	js     12ee <fourfiles+0x1fe>
    if(pid == 0){
    1146:	0f 84 f5 00 00 00    	je     1241 <fourfiles+0x151>
  for(pi = 0; pi < 4; pi++){
    114c:	43                   	inc    %ebx
    114d:	83 fb 04             	cmp    $0x4,%ebx
    1150:	74 06                	je     1158 <fourfiles+0x68>
    1152:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1156:	eb d9                	jmp    1131 <fourfiles+0x41>
    wait(null);
    1158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 2; i++){
    115f:	31 ff                	xor    %edi,%edi
    wait(null);
    1161:	e8 3a 2f 00 00       	call   40a0 <wait>
    1166:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    116d:	e8 2e 2f 00 00       	call   40a0 <wait>
    1172:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1179:	e8 22 2f 00 00       	call   40a0 <wait>
    117e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1185:	e8 16 2f 00 00       	call   40a0 <wait>
    118a:	c7 45 d0 de 49 00 00 	movl   $0x49de,-0x30(%ebp)
    fd = open(fname, 0);
    1191:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1194:	31 f6                	xor    %esi,%esi
    1196:	89 74 24 04          	mov    %esi,0x4(%esp)
    119a:	89 04 24             	mov    %eax,(%esp)
    119d:	e8 36 2f 00 00       	call   40d8 <open>
    total = 0;
    11a2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    fd = open(fname, 0);
    11a9:	89 c3                	mov    %eax,%ebx
    11ab:	90                   	nop
    11ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11b0:	ba 00 20 00 00       	mov    $0x2000,%edx
    11b5:	b9 20 8e 00 00       	mov    $0x8e20,%ecx
    11ba:	89 54 24 08          	mov    %edx,0x8(%esp)
    11be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    11c2:	89 1c 24             	mov    %ebx,(%esp)
    11c5:	e8 e6 2e 00 00       	call   40b0 <read>
    11ca:	85 c0                	test   %eax,%eax
    11cc:	7e 23                	jle    11f1 <fourfiles+0x101>
      for(j = 0; j < n; j++){
    11ce:	31 d2                	xor    %edx,%edx
        if(buf[j] != '0'+i){
    11d0:	0f be b2 20 8e 00 00 	movsbl 0x8e20(%edx),%esi
    11d7:	83 ff 01             	cmp    $0x1,%edi
    11da:	19 c9                	sbb    %ecx,%ecx
    11dc:	83 c1 31             	add    $0x31,%ecx
    11df:	39 ce                	cmp    %ecx,%esi
    11e1:	0f 85 c6 00 00 00    	jne    12ad <fourfiles+0x1bd>
      for(j = 0; j < n; j++){
    11e7:	42                   	inc    %edx
    11e8:	39 d0                	cmp    %edx,%eax
    11ea:	75 e4                	jne    11d0 <fourfiles+0xe0>
      total += n;
    11ec:	01 45 d4             	add    %eax,-0x2c(%ebp)
    11ef:	eb bf                	jmp    11b0 <fourfiles+0xc0>
    close(fd);
    11f1:	89 1c 24             	mov    %ebx,(%esp)
    11f4:	e8 c7 2e 00 00       	call   40c0 <close>
    if(total != 12*500){
    11f9:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    1200:	0f 85 08 01 00 00    	jne    130e <fourfiles+0x21e>
    unlink(fname);
    1206:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1209:	89 04 24             	mov    %eax,(%esp)
    120c:	e8 d7 2e 00 00       	call   40e8 <unlink>
  for(i = 0; i < 2; i++){
    1211:	4f                   	dec    %edi
    1212:	75 1d                	jne    1231 <fourfiles+0x141>
  printf(1, "fourfiles ok\n");
    1214:	b8 22 4a 00 00       	mov    $0x4a22,%eax
    1219:	89 44 24 04          	mov    %eax,0x4(%esp)
    121d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1224:	e8 d7 2f 00 00       	call   4200 <printf>
}
    1229:	83 c4 3c             	add    $0x3c,%esp
    122c:	5b                   	pop    %ebx
    122d:	5e                   	pop    %esi
    122e:	5f                   	pop    %edi
    122f:	5d                   	pop    %ebp
    1230:	c3                   	ret    
    1231:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1234:	bf 01 00 00 00       	mov    $0x1,%edi
    1239:	89 45 d0             	mov    %eax,-0x30(%ebp)
    123c:	e9 50 ff ff ff       	jmp    1191 <fourfiles+0xa1>
      fd = open(fname, O_CREATE | O_RDWR);
    1241:	b8 02 02 00 00       	mov    $0x202,%eax
    1246:	89 34 24             	mov    %esi,(%esp)
    1249:	89 44 24 04          	mov    %eax,0x4(%esp)
    124d:	e8 86 2e 00 00       	call   40d8 <open>
      if(fd < 0){
    1252:	85 c0                	test   %eax,%eax
      fd = open(fname, O_CREATE | O_RDWR);
    1254:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1256:	78 76                	js     12ce <fourfiles+0x1de>
      memset(buf, '0'+pi, 512);
    1258:	b8 00 02 00 00       	mov    $0x200,%eax
    125d:	83 c3 30             	add    $0x30,%ebx
    1260:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1264:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1269:	89 44 24 08          	mov    %eax,0x8(%esp)
    126d:	c7 04 24 20 8e 00 00 	movl   $0x8e20,(%esp)
    1274:	e8 87 2c 00 00       	call   3f00 <memset>
        if((n = write(fd, buf, 500)) != 500){
    1279:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    127e:	bf f4 01 00 00       	mov    $0x1f4,%edi
    1283:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1287:	89 44 24 04          	mov    %eax,0x4(%esp)
    128b:	89 34 24             	mov    %esi,(%esp)
    128e:	e8 25 2e 00 00       	call   40b8 <write>
    1293:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1298:	0f 85 97 00 00 00    	jne    1335 <fourfiles+0x245>
      for(i = 0; i < 12; i++){
    129e:	4b                   	dec    %ebx
    129f:	75 d8                	jne    1279 <fourfiles+0x189>
          exit(0);
    12a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12a8:	e8 eb 2d 00 00       	call   4098 <exit>
          printf(1, "wrong char\n");
    12ad:	bb 05 4a 00 00       	mov    $0x4a05,%ebx
    12b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    12b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12bd:	e8 3e 2f 00 00       	call   4200 <printf>
          exit(0);
    12c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12c9:	e8 ca 2d 00 00       	call   4098 <exit>
        printf(1, "create failed\n");
    12ce:	c7 44 24 04 7f 4c 00 	movl   $0x4c7f,0x4(%esp)
    12d5:	00 
    12d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12dd:	e8 1e 2f 00 00       	call   4200 <printf>
        exit(0);
    12e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12e9:	e8 aa 2d 00 00       	call   4098 <exit>
      printf(1, "fork failed\n");
    12ee:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
    12f5:	00 
    12f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fd:	e8 fe 2e 00 00       	call   4200 <printf>
      exit(0);
    1302:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1309:	e8 8a 2d 00 00       	call   4098 <exit>
      printf(1, "wrong length %d\n", total);
    130e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1311:	c7 44 24 04 11 4a 00 	movl   $0x4a11,0x4(%esp)
    1318:	00 
    1319:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1320:	89 44 24 08          	mov    %eax,0x8(%esp)
    1324:	e8 d7 2e 00 00       	call   4200 <printf>
      exit(0);
    1329:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1330:	e8 63 2d 00 00       	call   4098 <exit>
          printf(1, "write failed %d\n", n);
    1335:	89 44 24 08          	mov    %eax,0x8(%esp)
    1339:	c7 44 24 04 f4 49 00 	movl   $0x49f4,0x4(%esp)
    1340:	00 
    1341:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1348:	e8 b3 2e 00 00       	call   4200 <printf>
          exit(0);
    134d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1354:	e8 3f 2d 00 00       	call   4098 <exit>
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001360 <createdelete>:
{
    1360:	55                   	push   %ebp
  printf(1, "createdelete test\n");
    1361:	b8 30 4a 00 00       	mov    $0x4a30,%eax
{
    1366:	89 e5                	mov    %esp,%ebp
    1368:	57                   	push   %edi
    1369:	56                   	push   %esi
    136a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    136b:	31 db                	xor    %ebx,%ebx
{
    136d:	83 ec 4c             	sub    $0x4c,%esp
  printf(1, "createdelete test\n");
    1370:	89 44 24 04          	mov    %eax,0x4(%esp)
    1374:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137b:	e8 80 2e 00 00       	call   4200 <printf>
    pid = fork();
    1380:	e8 0b 2d 00 00       	call   4090 <fork>
    if(pid < 0){
    1385:	85 c0                	test   %eax,%eax
    1387:	0f 88 00 02 00 00    	js     158d <createdelete+0x22d>
    138d:	8d 76 00             	lea    0x0(%esi),%esi
    if(pid == 0){
    1390:	0f 84 2a 01 00 00    	je     14c0 <createdelete+0x160>
  for(pi = 0; pi < 4; pi++){
    1396:	43                   	inc    %ebx
    1397:	83 fb 04             	cmp    $0x4,%ebx
    139a:	75 e4                	jne    1380 <createdelete+0x20>
    wait(null);
    139c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  name[0] = name[1] = name[2] = 0;
    13a3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    wait(null);
    13a8:	e8 f3 2c 00 00       	call   40a0 <wait>
    13ad:	8d 75 c8             	lea    -0x38(%ebp),%esi
    13b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13b7:	e8 e4 2c 00 00       	call   40a0 <wait>
    13bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13c3:	e8 d8 2c 00 00       	call   40a0 <wait>
    13c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13cf:	e8 cc 2c 00 00       	call   40a0 <wait>
  name[0] = name[1] = name[2] = 0;
    13d4:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13d8:	c6 45 c7 30          	movb   $0x30,-0x39(%ebp)
  for(i = 0; i < N; i++){
    13dc:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    13e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    13f0:	8b 45 c0             	mov    -0x40(%ebp),%eax
      name[2] = '\0';
    13f3:	b3 70                	mov    $0x70,%bl
    13f5:	83 f8 09             	cmp    $0x9,%eax
    13f8:	0f 9f c2             	setg   %dl
    13fb:	85 c0                	test   %eax,%eax
    13fd:	0f 94 c0             	sete   %al
    1400:	08 c2                	or     %al,%dl
    1402:	88 55 c6             	mov    %dl,-0x3a(%ebp)
      name[1] = '0' + i;
    1405:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    1409:	31 c9                	xor    %ecx,%ecx
    140b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    140f:	89 34 24             	mov    %esi,(%esp)
      name[0] = 'p' + pi;
    1412:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1415:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1418:	e8 bb 2c 00 00       	call   40d8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    141d:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1421:	0f 84 81 00 00 00    	je     14a8 <createdelete+0x148>
    1427:	85 c0                	test   %eax,%eax
    1429:	0f 88 19 01 00 00    	js     1548 <createdelete+0x1e8>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    142f:	83 ff 08             	cmp    $0x8,%edi
    1432:	0f 86 7d 01 00 00    	jbe    15b5 <createdelete+0x255>
        close(fd);
    1438:	89 04 24             	mov    %eax,(%esp)
    143b:	e8 80 2c 00 00       	call   40c0 <close>
    1440:	fe c3                	inc    %bl
    for(pi = 0; pi < 4; pi++){
    1442:	80 fb 74             	cmp    $0x74,%bl
    1445:	75 be                	jne    1405 <createdelete+0xa5>
  for(i = 0; i < N; i++){
    1447:	ff 45 c0             	incl   -0x40(%ebp)
    144a:	47                   	inc    %edi
    144b:	fe 45 c7             	incb   -0x39(%ebp)
    144e:	8b 55 c0             	mov    -0x40(%ebp),%edx
    1451:	83 fa 14             	cmp    $0x14,%edx
    1454:	75 9a                	jne    13f0 <createdelete+0x90>
    1456:	b3 70                	mov    $0x70,%bl
    1458:	90                   	nop
    1459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1460:	88 d8                	mov    %bl,%al
    1462:	bf 04 00 00 00       	mov    $0x4,%edi
    1467:	2c 40                	sub    $0x40,%al
    1469:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[1] = '0' + i;
    146c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    1470:	89 34 24             	mov    %esi,(%esp)
      name[0] = 'p' + i;
    1473:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1476:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1479:	e8 6a 2c 00 00       	call   40e8 <unlink>
    for(pi = 0; pi < 4; pi++){
    147e:	4f                   	dec    %edi
    147f:	75 eb                	jne    146c <createdelete+0x10c>
    1481:	fe c3                	inc    %bl
  for(i = 0; i < N; i++){
    1483:	80 fb 84             	cmp    $0x84,%bl
    1486:	75 d8                	jne    1460 <createdelete+0x100>
  printf(1, "createdelete ok\n");
    1488:	b8 43 4a 00 00       	mov    $0x4a43,%eax
    148d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1491:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1498:	e8 63 2d 00 00       	call   4200 <printf>
}
    149d:	83 c4 4c             	add    $0x4c,%esp
    14a0:	5b                   	pop    %ebx
    14a1:	5e                   	pop    %esi
    14a2:	5f                   	pop    %edi
    14a3:	5d                   	pop    %ebp
    14a4:	c3                   	ret    
    14a5:	8d 76 00             	lea    0x0(%esi),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    14a8:	83 ff 08             	cmp    $0x8,%edi
    14ab:	0f 86 fc 00 00 00    	jbe    15ad <createdelete+0x24d>
      if(fd >= 0)
    14b1:	85 c0                	test   %eax,%eax
    14b3:	78 8b                	js     1440 <createdelete+0xe0>
    14b5:	e9 7e ff ff ff       	jmp    1438 <createdelete+0xd8>
    14ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    14c0:	80 c3 70             	add    $0x70,%bl
      name[2] = '\0';
    14c3:	31 ff                	xor    %edi,%edi
      name[0] = 'p' + pi;
    14c5:	88 5d c8             	mov    %bl,-0x38(%ebp)
    14c8:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[2] = '\0';
    14cb:	b3 30                	mov    $0x30,%bl
    14cd:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    14d1:	eb 11                	jmp    14e4 <createdelete+0x184>
    14d3:	90                   	nop
    14d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    14d8:	83 ff 13             	cmp    $0x13,%edi
    14db:	0f 84 80 00 00 00    	je     1561 <createdelete+0x201>
    14e1:	47                   	inc    %edi
    14e2:	fe c3                	inc    %bl
        fd = open(name, O_CREATE | O_RDWR);
    14e4:	b8 02 02 00 00       	mov    $0x202,%eax
    14e9:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ed:	89 34 24             	mov    %esi,(%esp)
        name[1] = '0' + i;
    14f0:	88 5d c9             	mov    %bl,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    14f3:	e8 e0 2b 00 00       	call   40d8 <open>
        if(fd < 0){
    14f8:	85 c0                	test   %eax,%eax
    14fa:	78 71                	js     156d <createdelete+0x20d>
        close(fd);
    14fc:	89 04 24             	mov    %eax,(%esp)
    14ff:	e8 bc 2b 00 00       	call   40c0 <close>
        if(i > 0 && (i % 2 ) == 0){
    1504:	85 ff                	test   %edi,%edi
    1506:	74 d9                	je     14e1 <createdelete+0x181>
    1508:	f7 c7 01 00 00 00    	test   $0x1,%edi
    150e:	75 c8                	jne    14d8 <createdelete+0x178>
          name[1] = '0' + (i / 2);
    1510:	89 f8                	mov    %edi,%eax
    1512:	d1 f8                	sar    %eax
    1514:	04 30                	add    $0x30,%al
          if(unlink(name) < 0){
    1516:	89 34 24             	mov    %esi,(%esp)
          name[1] = '0' + (i / 2);
    1519:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    151c:	e8 c7 2b 00 00       	call   40e8 <unlink>
    1521:	85 c0                	test   %eax,%eax
    1523:	79 b3                	jns    14d8 <createdelete+0x178>
            printf(1, "unlink failed\n");
    1525:	c7 44 24 04 31 46 00 	movl   $0x4631,0x4(%esp)
    152c:	00 
    152d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1534:	e8 c7 2c 00 00       	call   4200 <printf>
            exit(0);
    1539:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1540:	e8 53 2b 00 00       	call   4098 <exit>
    1545:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "oops createdelete %s didn't exist\n", name);
    1548:	ba f0 56 00 00       	mov    $0x56f0,%edx
    154d:	89 74 24 08          	mov    %esi,0x8(%esp)
    1551:	89 54 24 04          	mov    %edx,0x4(%esp)
    1555:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    155c:	e8 9f 2c 00 00       	call   4200 <printf>
        exit(0);
    1561:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1568:	e8 2b 2b 00 00       	call   4098 <exit>
          printf(1, "create failed\n");
    156d:	c7 44 24 04 7f 4c 00 	movl   $0x4c7f,0x4(%esp)
    1574:	00 
    1575:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    157c:	e8 7f 2c 00 00       	call   4200 <printf>
          exit(0);
    1581:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1588:	e8 0b 2b 00 00       	call   4098 <exit>
      printf(1, "fork failed\n");
    158d:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
    1594:	00 
    1595:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159c:	e8 5f 2c 00 00       	call   4200 <printf>
      exit(0);
    15a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15a8:	e8 eb 2a 00 00       	call   4098 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    15ad:	85 c0                	test   %eax,%eax
    15af:	0f 88 8b fe ff ff    	js     1440 <createdelete+0xe0>
        printf(1, "oops createdelete %s did exist\n", name);
    15b5:	89 74 24 08          	mov    %esi,0x8(%esp)
    15b9:	c7 44 24 04 14 57 00 	movl   $0x5714,0x4(%esp)
    15c0:	00 
    15c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c8:	e8 33 2c 00 00       	call   4200 <printf>
        exit(0);
    15cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15d4:	e8 bf 2a 00 00       	call   4098 <exit>
    15d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015e0 <unlinkread>:
{
    15e0:	55                   	push   %ebp
  printf(1, "unlinkread test\n");
    15e1:	b9 54 4a 00 00       	mov    $0x4a54,%ecx
{
    15e6:	89 e5                	mov    %esp,%ebp
    15e8:	56                   	push   %esi
    15e9:	53                   	push   %ebx
  fd = open("unlinkread", O_CREATE | O_RDWR);
    15ea:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    15ef:	83 ec 10             	sub    $0x10,%esp
  printf(1, "unlinkread test\n");
    15f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    15f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fd:	e8 fe 2b 00 00       	call   4200 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1602:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1606:	c7 04 24 65 4a 00 00 	movl   $0x4a65,(%esp)
    160d:	e8 c6 2a 00 00       	call   40d8 <open>
  if(fd < 0){
    1612:	85 c0                	test   %eax,%eax
    1614:	0f 88 0f 01 00 00    	js     1729 <unlinkread+0x149>
    161a:	89 c3                	mov    %eax,%ebx
  write(fd, "hello", 5);
    161c:	b8 05 00 00 00       	mov    $0x5,%eax
    1621:	89 44 24 08          	mov    %eax,0x8(%esp)
    1625:	b8 8a 4a 00 00       	mov    $0x4a8a,%eax
    162a:	89 1c 24             	mov    %ebx,(%esp)
    162d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1631:	e8 82 2a 00 00       	call   40b8 <write>
  close(fd);
    1636:	89 1c 24             	mov    %ebx,(%esp)
    1639:	e8 82 2a 00 00       	call   40c0 <close>
  fd = open("unlinkread", O_RDWR);
    163e:	ba 02 00 00 00       	mov    $0x2,%edx
    1643:	89 54 24 04          	mov    %edx,0x4(%esp)
    1647:	c7 04 24 65 4a 00 00 	movl   $0x4a65,(%esp)
    164e:	e8 85 2a 00 00       	call   40d8 <open>
  if(fd < 0){
    1653:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    1655:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1657:	0f 88 6c 01 00 00    	js     17c9 <unlinkread+0x1e9>
  if(unlink("unlinkread") != 0){
    165d:	c7 04 24 65 4a 00 00 	movl   $0x4a65,(%esp)
    1664:	e8 7f 2a 00 00       	call   40e8 <unlink>
    1669:	85 c0                	test   %eax,%eax
    166b:	0f 85 38 01 00 00    	jne    17a9 <unlinkread+0x1c9>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1671:	be 02 02 00 00       	mov    $0x202,%esi
    1676:	89 74 24 04          	mov    %esi,0x4(%esp)
    167a:	c7 04 24 65 4a 00 00 	movl   $0x4a65,(%esp)
    1681:	e8 52 2a 00 00       	call   40d8 <open>
    1686:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1688:	b8 03 00 00 00       	mov    $0x3,%eax
    168d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1691:	b8 c2 4a 00 00       	mov    $0x4ac2,%eax
    1696:	89 44 24 04          	mov    %eax,0x4(%esp)
    169a:	89 34 24             	mov    %esi,(%esp)
    169d:	e8 16 2a 00 00       	call   40b8 <write>
  close(fd1);
    16a2:	89 34 24             	mov    %esi,(%esp)
    16a5:	e8 16 2a 00 00       	call   40c0 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    16aa:	b8 00 20 00 00       	mov    $0x2000,%eax
    16af:	89 44 24 08          	mov    %eax,0x8(%esp)
    16b3:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    16b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16bc:	89 1c 24             	mov    %ebx,(%esp)
    16bf:	e8 ec 29 00 00       	call   40b0 <read>
    16c4:	83 f8 05             	cmp    $0x5,%eax
    16c7:	0f 85 bc 00 00 00    	jne    1789 <unlinkread+0x1a9>
  if(buf[0] != 'h'){
    16cd:	80 3d 20 8e 00 00 68 	cmpb   $0x68,0x8e20
    16d4:	0f 85 8f 00 00 00    	jne    1769 <unlinkread+0x189>
  if(write(fd, buf, 10) != 10){
    16da:	ba 0a 00 00 00       	mov    $0xa,%edx
    16df:	b9 20 8e 00 00       	mov    $0x8e20,%ecx
    16e4:	89 54 24 08          	mov    %edx,0x8(%esp)
    16e8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    16ec:	89 1c 24             	mov    %ebx,(%esp)
    16ef:	e8 c4 29 00 00       	call   40b8 <write>
    16f4:	83 f8 0a             	cmp    $0xa,%eax
    16f7:	75 50                	jne    1749 <unlinkread+0x169>
  close(fd);
    16f9:	89 1c 24             	mov    %ebx,(%esp)
    16fc:	e8 bf 29 00 00       	call   40c0 <close>
  unlink("unlinkread");
    1701:	c7 04 24 65 4a 00 00 	movl   $0x4a65,(%esp)
    1708:	e8 db 29 00 00       	call   40e8 <unlink>
  printf(1, "unlinkread ok\n");
    170d:	b8 0d 4b 00 00       	mov    $0x4b0d,%eax
    1712:	89 44 24 04          	mov    %eax,0x4(%esp)
    1716:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    171d:	e8 de 2a 00 00       	call   4200 <printf>
}
    1722:	83 c4 10             	add    $0x10,%esp
    1725:	5b                   	pop    %ebx
    1726:	5e                   	pop    %esi
    1727:	5d                   	pop    %ebp
    1728:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1729:	c7 44 24 04 70 4a 00 	movl   $0x4a70,0x4(%esp)
    1730:	00 
    1731:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1738:	e8 c3 2a 00 00       	call   4200 <printf>
    exit(0);
    173d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1744:	e8 4f 29 00 00       	call   4098 <exit>
    printf(1, "unlinkread write failed\n");
    1749:	c7 44 24 04 f4 4a 00 	movl   $0x4af4,0x4(%esp)
    1750:	00 
    1751:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1758:	e8 a3 2a 00 00       	call   4200 <printf>
    exit(0);
    175d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1764:	e8 2f 29 00 00       	call   4098 <exit>
    printf(1, "unlinkread wrong data\n");
    1769:	c7 44 24 04 dd 4a 00 	movl   $0x4add,0x4(%esp)
    1770:	00 
    1771:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1778:	e8 83 2a 00 00       	call   4200 <printf>
    exit(0);
    177d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1784:	e8 0f 29 00 00       	call   4098 <exit>
    printf(1, "unlinkread read failed");
    1789:	c7 44 24 04 c6 4a 00 	movl   $0x4ac6,0x4(%esp)
    1790:	00 
    1791:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1798:	e8 63 2a 00 00       	call   4200 <printf>
    exit(0);
    179d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17a4:	e8 ef 28 00 00       	call   4098 <exit>
    printf(1, "unlink unlinkread failed\n");
    17a9:	c7 44 24 04 a8 4a 00 	movl   $0x4aa8,0x4(%esp)
    17b0:	00 
    17b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17b8:	e8 43 2a 00 00       	call   4200 <printf>
    exit(0);
    17bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17c4:	e8 cf 28 00 00       	call   4098 <exit>
    printf(1, "open unlinkread failed\n");
    17c9:	c7 44 24 04 90 4a 00 	movl   $0x4a90,0x4(%esp)
    17d0:	00 
    17d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17d8:	e8 23 2a 00 00       	call   4200 <printf>
    exit(0);
    17dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17e4:	e8 af 28 00 00       	call   4098 <exit>
    17e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000017f0 <linktest>:
{
    17f0:	55                   	push   %ebp
  printf(1, "linktest\n");
    17f1:	b9 1c 4b 00 00       	mov    $0x4b1c,%ecx
{
    17f6:	89 e5                	mov    %esp,%ebp
    17f8:	53                   	push   %ebx
  fd = open("lf1", O_CREATE|O_RDWR);
    17f9:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    17fe:	83 ec 14             	sub    $0x14,%esp
  printf(1, "linktest\n");
    1801:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1805:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    180c:	e8 ef 29 00 00       	call   4200 <printf>
  unlink("lf1");
    1811:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    1818:	e8 cb 28 00 00       	call   40e8 <unlink>
  unlink("lf2");
    181d:	c7 04 24 2a 4b 00 00 	movl   $0x4b2a,(%esp)
    1824:	e8 bf 28 00 00       	call   40e8 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    1829:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    182d:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    1834:	e8 9f 28 00 00       	call   40d8 <open>
  if(fd < 0){
    1839:	85 c0                	test   %eax,%eax
    183b:	0f 88 2d 01 00 00    	js     196e <linktest+0x17e>
    1841:	89 c3                	mov    %eax,%ebx
  if(write(fd, "hello", 5) != 5){
    1843:	ba 8a 4a 00 00       	mov    $0x4a8a,%edx
    1848:	b8 05 00 00 00       	mov    $0x5,%eax
    184d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1851:	89 54 24 04          	mov    %edx,0x4(%esp)
    1855:	89 1c 24             	mov    %ebx,(%esp)
    1858:	e8 5b 28 00 00       	call   40b8 <write>
    185d:	83 f8 05             	cmp    $0x5,%eax
    1860:	0f 85 08 02 00 00    	jne    1a6e <linktest+0x27e>
  close(fd);
    1866:	89 1c 24             	mov    %ebx,(%esp)
    1869:	e8 52 28 00 00       	call   40c0 <close>
  if(link("lf1", "lf2") < 0){
    186e:	b8 2a 4b 00 00       	mov    $0x4b2a,%eax
    1873:	89 44 24 04          	mov    %eax,0x4(%esp)
    1877:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    187e:	e8 75 28 00 00       	call   40f8 <link>
    1883:	85 c0                	test   %eax,%eax
    1885:	0f 88 c3 01 00 00    	js     1a4e <linktest+0x25e>
  unlink("lf1");
    188b:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    1892:	e8 51 28 00 00       	call   40e8 <unlink>
  if(open("lf1", 0) >= 0){
    1897:	31 c0                	xor    %eax,%eax
    1899:	89 44 24 04          	mov    %eax,0x4(%esp)
    189d:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    18a4:	e8 2f 28 00 00       	call   40d8 <open>
    18a9:	85 c0                	test   %eax,%eax
    18ab:	0f 89 7d 01 00 00    	jns    1a2e <linktest+0x23e>
  fd = open("lf2", 0);
    18b1:	31 c0                	xor    %eax,%eax
    18b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    18b7:	c7 04 24 2a 4b 00 00 	movl   $0x4b2a,(%esp)
    18be:	e8 15 28 00 00       	call   40d8 <open>
  if(fd < 0){
    18c3:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    18c5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    18c7:	0f 88 41 01 00 00    	js     1a0e <linktest+0x21e>
  if(read(fd, buf, sizeof(buf)) != 5){
    18cd:	b8 00 20 00 00       	mov    $0x2000,%eax
    18d2:	89 44 24 08          	mov    %eax,0x8(%esp)
    18d6:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    18db:	89 44 24 04          	mov    %eax,0x4(%esp)
    18df:	89 1c 24             	mov    %ebx,(%esp)
    18e2:	e8 c9 27 00 00       	call   40b0 <read>
    18e7:	83 f8 05             	cmp    $0x5,%eax
    18ea:	0f 85 fe 00 00 00    	jne    19ee <linktest+0x1fe>
  close(fd);
    18f0:	89 1c 24             	mov    %ebx,(%esp)
  if(link("lf2", "lf2") >= 0){
    18f3:	bb 2a 4b 00 00       	mov    $0x4b2a,%ebx
  close(fd);
    18f8:	e8 c3 27 00 00       	call   40c0 <close>
  if(link("lf2", "lf2") >= 0){
    18fd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1901:	c7 04 24 2a 4b 00 00 	movl   $0x4b2a,(%esp)
    1908:	e8 eb 27 00 00       	call   40f8 <link>
    190d:	85 c0                	test   %eax,%eax
    190f:	0f 89 b9 00 00 00    	jns    19ce <linktest+0x1de>
  unlink("lf2");
    1915:	c7 04 24 2a 4b 00 00 	movl   $0x4b2a,(%esp)
    191c:	e8 c7 27 00 00       	call   40e8 <unlink>
  if(link("lf2", "lf1") >= 0){
    1921:	b9 26 4b 00 00       	mov    $0x4b26,%ecx
    1926:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    192a:	c7 04 24 2a 4b 00 00 	movl   $0x4b2a,(%esp)
    1931:	e8 c2 27 00 00       	call   40f8 <link>
    1936:	85 c0                	test   %eax,%eax
    1938:	79 74                	jns    19ae <linktest+0x1be>
  if(link(".", "lf1") >= 0){
    193a:	ba 26 4b 00 00       	mov    $0x4b26,%edx
    193f:	89 54 24 04          	mov    %edx,0x4(%esp)
    1943:	c7 04 24 ee 4d 00 00 	movl   $0x4dee,(%esp)
    194a:	e8 a9 27 00 00       	call   40f8 <link>
    194f:	85 c0                	test   %eax,%eax
    1951:	79 3b                	jns    198e <linktest+0x19e>
  printf(1, "linktest ok\n");
    1953:	b8 c4 4b 00 00       	mov    $0x4bc4,%eax
    1958:	89 44 24 04          	mov    %eax,0x4(%esp)
    195c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1963:	e8 98 28 00 00       	call   4200 <printf>
}
    1968:	83 c4 14             	add    $0x14,%esp
    196b:	5b                   	pop    %ebx
    196c:	5d                   	pop    %ebp
    196d:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    196e:	c7 44 24 04 2e 4b 00 	movl   $0x4b2e,0x4(%esp)
    1975:	00 
    1976:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197d:	e8 7e 28 00 00       	call   4200 <printf>
    exit(0);
    1982:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1989:	e8 0a 27 00 00       	call   4098 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    198e:	c7 44 24 04 a8 4b 00 	movl   $0x4ba8,0x4(%esp)
    1995:	00 
    1996:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    199d:	e8 5e 28 00 00       	call   4200 <printf>
    exit(0);
    19a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19a9:	e8 ea 26 00 00       	call   4098 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    19ae:	c7 44 24 04 5c 57 00 	movl   $0x575c,0x4(%esp)
    19b5:	00 
    19b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19bd:	e8 3e 28 00 00       	call   4200 <printf>
    exit(0);
    19c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19c9:	e8 ca 26 00 00       	call   4098 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    19ce:	c7 44 24 04 8a 4b 00 	movl   $0x4b8a,0x4(%esp)
    19d5:	00 
    19d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19dd:	e8 1e 28 00 00       	call   4200 <printf>
    exit(0);
    19e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19e9:	e8 aa 26 00 00       	call   4098 <exit>
    printf(1, "read lf2 failed\n");
    19ee:	c7 44 24 04 79 4b 00 	movl   $0x4b79,0x4(%esp)
    19f5:	00 
    19f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19fd:	e8 fe 27 00 00       	call   4200 <printf>
    exit(0);
    1a02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a09:	e8 8a 26 00 00       	call   4098 <exit>
    printf(1, "open lf2 failed\n");
    1a0e:	c7 44 24 04 68 4b 00 	movl   $0x4b68,0x4(%esp)
    1a15:	00 
    1a16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a1d:	e8 de 27 00 00       	call   4200 <printf>
    exit(0);
    1a22:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a29:	e8 6a 26 00 00       	call   4098 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1a2e:	c7 44 24 04 34 57 00 	movl   $0x5734,0x4(%esp)
    1a35:	00 
    1a36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a3d:	e8 be 27 00 00       	call   4200 <printf>
    exit(0);
    1a42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a49:	e8 4a 26 00 00       	call   4098 <exit>
    printf(1, "link lf1 lf2 failed\n");
    1a4e:	c7 44 24 04 53 4b 00 	movl   $0x4b53,0x4(%esp)
    1a55:	00 
    1a56:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a5d:	e8 9e 27 00 00       	call   4200 <printf>
    exit(0);
    1a62:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a69:	e8 2a 26 00 00       	call   4098 <exit>
    printf(1, "write lf1 failed\n");
    1a6e:	c7 44 24 04 41 4b 00 	movl   $0x4b41,0x4(%esp)
    1a75:	00 
    1a76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a7d:	e8 7e 27 00 00       	call   4200 <printf>
    exit(0);
    1a82:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a89:	e8 0a 26 00 00       	call   4098 <exit>
    1a8e:	66 90                	xchg   %ax,%ax

00001a90 <concreate>:
{
    1a90:	55                   	push   %ebp
    1a91:	89 e5                	mov    %esp,%ebp
    1a93:	57                   	push   %edi
  printf(1, "concreate test\n");
    1a94:	bf d1 4b 00 00       	mov    $0x4bd1,%edi
{
    1a99:	56                   	push   %esi
    1a9a:	53                   	push   %ebx
  file[2] = '\0';
    1a9b:	b3 30                	mov    $0x30,%bl
{
    1a9d:	83 ec 6c             	sub    $0x6c,%esp
  printf(1, "concreate test\n");
    1aa0:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1aa4:	8d 75 ad             	lea    -0x53(%ebp),%esi
  for(i = 0; i < 40; i++){
    1aa7:	31 ff                	xor    %edi,%edi
  printf(1, "concreate test\n");
    1aa9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab0:	e8 4b 27 00 00       	call   4200 <printf>
  file[0] = 'C';
    1ab5:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1ab9:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1abd:	eb 4f                	jmp    1b0e <concreate+0x7e>
    1abf:	90                   	nop
    if(pid && (i % 3) == 1){
    1ac0:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1ac5:	89 f9                	mov    %edi,%ecx
    1ac7:	f7 e7                	mul    %edi
    1ac9:	d1 ea                	shr    %edx
    1acb:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1ace:	29 c1                	sub    %eax,%ecx
    1ad0:	89 c8                	mov    %ecx,%eax
    1ad2:	48                   	dec    %eax
    1ad3:	0f 84 bf 00 00 00    	je     1b98 <concreate+0x108>
      fd = open(file, O_CREATE | O_RDWR);
    1ad9:	b8 02 02 00 00       	mov    $0x202,%eax
    1ade:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ae2:	89 34 24             	mov    %esi,(%esp)
    1ae5:	e8 ee 25 00 00       	call   40d8 <open>
      if(fd < 0){
    1aea:	85 c0                	test   %eax,%eax
    1aec:	78 61                	js     1b4f <concreate+0xbf>
      close(fd);
    1aee:	89 04 24             	mov    %eax,(%esp)
    1af1:	e8 ca 25 00 00       	call   40c0 <close>
      wait(null);
    1af6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 40; i++){
    1afd:	47                   	inc    %edi
    1afe:	fe c3                	inc    %bl
      wait(null);
    1b00:	e8 9b 25 00 00       	call   40a0 <wait>
  for(i = 0; i < 40; i++){
    1b05:	83 ff 28             	cmp    $0x28,%edi
    1b08:	0f 84 a2 00 00 00    	je     1bb0 <concreate+0x120>
    unlink(file);
    1b0e:	89 34 24             	mov    %esi,(%esp)
    file[1] = '0' + i;
    1b11:	88 5d ae             	mov    %bl,-0x52(%ebp)
    unlink(file);
    1b14:	e8 cf 25 00 00       	call   40e8 <unlink>
    pid = fork();
    1b19:	e8 72 25 00 00       	call   4090 <fork>
    if(pid && (i % 3) == 1){
    1b1e:	85 c0                	test   %eax,%eax
    1b20:	75 9e                	jne    1ac0 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1b22:	89 f8                	mov    %edi,%eax
    1b24:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    1b29:	f7 e2                	mul    %edx
    1b2b:	c1 ea 02             	shr    $0x2,%edx
    1b2e:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1b31:	29 c7                	sub    %eax,%edi
    1b33:	4f                   	dec    %edi
    1b34:	74 42                	je     1b78 <concreate+0xe8>
      fd = open(file, O_CREATE | O_RDWR);
    1b36:	ba 02 02 00 00       	mov    $0x202,%edx
    1b3b:	89 54 24 04          	mov    %edx,0x4(%esp)
    1b3f:	89 34 24             	mov    %esi,(%esp)
    1b42:	e8 91 25 00 00       	call   40d8 <open>
      if(fd < 0){
    1b47:	85 c0                	test   %eax,%eax
    1b49:	0f 89 96 02 00 00    	jns    1de5 <concreate+0x355>
        printf(1, "concreate create %s failed\n", file);
    1b4f:	89 74 24 08          	mov    %esi,0x8(%esp)
    1b53:	be e4 4b 00 00       	mov    $0x4be4,%esi
    1b58:	89 74 24 04          	mov    %esi,0x4(%esp)
    1b5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b63:	e8 98 26 00 00       	call   4200 <printf>
        exit(0);
    1b68:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b6f:	e8 24 25 00 00       	call   4098 <exit>
    1b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1b78:	89 74 24 04          	mov    %esi,0x4(%esp)
    1b7c:	c7 04 24 e1 4b 00 00 	movl   $0x4be1,(%esp)
    1b83:	e8 70 25 00 00       	call   40f8 <link>
        exit(0);
    1b88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b8f:	e8 04 25 00 00       	call   4098 <exit>
    1b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1b98:	89 74 24 04          	mov    %esi,0x4(%esp)
    1b9c:	c7 04 24 e1 4b 00 00 	movl   $0x4be1,(%esp)
    1ba3:	e8 50 25 00 00       	call   40f8 <link>
    1ba8:	e9 49 ff ff ff       	jmp    1af6 <concreate+0x66>
    1bad:	8d 76 00             	lea    0x0(%esi),%esi
  memset(fa, 0, sizeof(fa));
    1bb0:	ba 28 00 00 00       	mov    $0x28,%edx
    1bb5:	31 c9                	xor    %ecx,%ecx
    1bb7:	8d 45 c0             	lea    -0x40(%ebp),%eax
  fd = open(".", 0);
    1bba:	31 db                	xor    %ebx,%ebx
  memset(fa, 0, sizeof(fa));
    1bbc:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bc0:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1bc3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1bc7:	89 04 24             	mov    %eax,(%esp)
    1bca:	e8 31 23 00 00       	call   3f00 <memset>
  fd = open(".", 0);
    1bcf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1bd3:	c7 04 24 ee 4d 00 00 	movl   $0x4dee,(%esp)
    1bda:	e8 f9 24 00 00       	call   40d8 <open>
  n = 0;
    1bdf:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  fd = open(".", 0);
    1be6:	89 c3                	mov    %eax,%ebx
    1be8:	90                   	nop
    1be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1bf0:	b8 10 00 00 00       	mov    $0x10,%eax
    1bf5:	89 44 24 08          	mov    %eax,0x8(%esp)
    1bf9:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1bfd:	89 1c 24             	mov    %ebx,(%esp)
    1c00:	e8 ab 24 00 00       	call   40b0 <read>
    1c05:	85 c0                	test   %eax,%eax
    1c07:	7e 3f                	jle    1c48 <concreate+0x1b8>
    if(de.inum == 0)
    1c09:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1c0e:	74 e0                	je     1bf0 <concreate+0x160>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1c10:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1c14:	75 da                	jne    1bf0 <concreate+0x160>
    1c16:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1c1a:	75 d4                	jne    1bf0 <concreate+0x160>
      i = de.name[1] - '0';
    1c1c:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1c20:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1c23:	83 f8 27             	cmp    $0x27,%eax
    1c26:	0f 87 99 01 00 00    	ja     1dc5 <concreate+0x335>
      if(fa[i]){
    1c2c:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1c31:	0f 85 67 01 00 00    	jne    1d9e <concreate+0x30e>
      fa[i] = 1;
    1c37:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1c3c:	ff 45 a4             	incl   -0x5c(%ebp)
    1c3f:	eb af                	jmp    1bf0 <concreate+0x160>
    1c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1c48:	89 1c 24             	mov    %ebx,(%esp)
    1c4b:	e8 70 24 00 00       	call   40c0 <close>
  if(n != 40){
    1c50:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1c54:	0f 85 24 01 00 00    	jne    1d7e <concreate+0x2ee>
    1c5a:	b3 30                	mov    $0x30,%bl
  for(i = 0; i < 40; i++){
    1c5c:	31 ff                	xor    %edi,%edi
    1c5e:	eb 4d                	jmp    1cad <concreate+0x21d>
       ((i % 3) == 1 && pid != 0)){
    1c60:	85 c9                	test   %ecx,%ecx
    1c62:	74 03                	je     1c67 <concreate+0x1d7>
    1c64:	4a                   	dec    %edx
    1c65:	74 6e                	je     1cd5 <concreate+0x245>
      unlink(file);
    1c67:	89 34 24             	mov    %esi,(%esp)
    1c6a:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
    1c6d:	e8 76 24 00 00       	call   40e8 <unlink>
      unlink(file);
    1c72:	89 34 24             	mov    %esi,(%esp)
    1c75:	e8 6e 24 00 00       	call   40e8 <unlink>
      unlink(file);
    1c7a:	89 34 24             	mov    %esi,(%esp)
    1c7d:	e8 66 24 00 00       	call   40e8 <unlink>
      unlink(file);
    1c82:	89 34 24             	mov    %esi,(%esp)
    1c85:	e8 5e 24 00 00       	call   40e8 <unlink>
    1c8a:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    if(pid == 0)
    1c8d:	85 c9                	test   %ecx,%ecx
    1c8f:	0f 84 f3 fe ff ff    	je     1b88 <concreate+0xf8>
      wait(null);
    1c95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 40; i++){
    1c9c:	47                   	inc    %edi
    1c9d:	fe c3                	inc    %bl
      wait(null);
    1c9f:	e8 fc 23 00 00       	call   40a0 <wait>
  for(i = 0; i < 40; i++){
    1ca4:	83 ff 28             	cmp    $0x28,%edi
    1ca7:	0f 84 93 00 00 00    	je     1d40 <concreate+0x2b0>
    file[1] = '0' + i;
    1cad:	88 5d ae             	mov    %bl,-0x52(%ebp)
    pid = fork();
    1cb0:	e8 db 23 00 00       	call   4090 <fork>
    if(pid < 0){
    1cb5:	85 c0                	test   %eax,%eax
    pid = fork();
    1cb7:	89 c1                	mov    %eax,%ecx
    if(pid < 0){
    1cb9:	0f 88 9e 00 00 00    	js     1d5d <concreate+0x2cd>
    if(((i % 3) == 0 && pid == 0) ||
    1cbf:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1cc4:	f7 e7                	mul    %edi
    1cc6:	d1 ea                	shr    %edx
    1cc8:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1ccb:	89 fa                	mov    %edi,%edx
    1ccd:	29 c2                	sub    %eax,%edx
    1ccf:	89 d0                	mov    %edx,%eax
    1cd1:	09 c8                	or     %ecx,%eax
    1cd3:	75 8b                	jne    1c60 <concreate+0x1d0>
      close(open(file, 0));
    1cd5:	31 c0                	xor    %eax,%eax
    1cd7:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cdb:	89 34 24             	mov    %esi,(%esp)
    1cde:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
    1ce1:	e8 f2 23 00 00       	call   40d8 <open>
    1ce6:	89 04 24             	mov    %eax,(%esp)
    1ce9:	e8 d2 23 00 00       	call   40c0 <close>
      close(open(file, 0));
    1cee:	31 c0                	xor    %eax,%eax
    1cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cf4:	89 34 24             	mov    %esi,(%esp)
    1cf7:	e8 dc 23 00 00       	call   40d8 <open>
    1cfc:	89 04 24             	mov    %eax,(%esp)
    1cff:	e8 bc 23 00 00       	call   40c0 <close>
      close(open(file, 0));
    1d04:	31 c0                	xor    %eax,%eax
    1d06:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d0a:	89 34 24             	mov    %esi,(%esp)
    1d0d:	e8 c6 23 00 00       	call   40d8 <open>
    1d12:	89 04 24             	mov    %eax,(%esp)
    1d15:	e8 a6 23 00 00       	call   40c0 <close>
      close(open(file, 0));
    1d1a:	31 c0                	xor    %eax,%eax
    1d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d20:	89 34 24             	mov    %esi,(%esp)
    1d23:	e8 b0 23 00 00       	call   40d8 <open>
    1d28:	89 04 24             	mov    %eax,(%esp)
    1d2b:	e8 90 23 00 00       	call   40c0 <close>
    1d30:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    1d33:	e9 55 ff ff ff       	jmp    1c8d <concreate+0x1fd>
    1d38:	90                   	nop
    1d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "concreate ok\n");
    1d40:	b9 36 4c 00 00       	mov    $0x4c36,%ecx
    1d45:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1d49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d50:	e8 ab 24 00 00       	call   4200 <printf>
}
    1d55:	83 c4 6c             	add    $0x6c,%esp
    1d58:	5b                   	pop    %ebx
    1d59:	5e                   	pop    %esi
    1d5a:	5f                   	pop    %edi
    1d5b:	5d                   	pop    %ebp
    1d5c:	c3                   	ret    
      printf(1, "fork failed\n");
    1d5d:	b8 b9 54 00 00       	mov    $0x54b9,%eax
    1d62:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d6d:	e8 8e 24 00 00       	call   4200 <printf>
      exit(0);
    1d72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d79:	e8 1a 23 00 00       	call   4098 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1d7e:	c7 44 24 04 80 57 00 	movl   $0x5780,0x4(%esp)
    1d85:	00 
    1d86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d8d:	e8 6e 24 00 00       	call   4200 <printf>
    exit(0);
    1d92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d99:	e8 fa 22 00 00       	call   4098 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1d9e:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1da1:	89 44 24 08          	mov    %eax,0x8(%esp)
    1da5:	c7 44 24 04 19 4c 00 	movl   $0x4c19,0x4(%esp)
    1dac:	00 
    1dad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1db4:	e8 47 24 00 00       	call   4200 <printf>
        exit(0);
    1db9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1dc0:	e8 d3 22 00 00       	call   4098 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1dc5:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1dc8:	89 44 24 08          	mov    %eax,0x8(%esp)
    1dcc:	c7 44 24 04 00 4c 00 	movl   $0x4c00,0x4(%esp)
    1dd3:	00 
    1dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ddb:	e8 20 24 00 00       	call   4200 <printf>
    1de0:	e9 a3 fd ff ff       	jmp    1b88 <concreate+0xf8>
      close(fd);
    1de5:	89 04 24             	mov    %eax,(%esp)
    1de8:	e8 d3 22 00 00       	call   40c0 <close>
    1ded:	8d 76 00             	lea    0x0(%esi),%esi
    1df0:	e9 93 fd ff ff       	jmp    1b88 <concreate+0xf8>
    1df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001e00 <linkunlink>:
{
    1e00:	55                   	push   %ebp
  printf(1, "linkunlink test\n");
    1e01:	b8 44 4c 00 00       	mov    $0x4c44,%eax
{
    1e06:	89 e5                	mov    %esp,%ebp
    1e08:	57                   	push   %edi
    1e09:	56                   	push   %esi
    1e0a:	53                   	push   %ebx
    1e0b:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "linkunlink test\n");
    1e0e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e19:	e8 e2 23 00 00       	call   4200 <printf>
  unlink("x");
    1e1e:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    1e25:	e8 be 22 00 00       	call   40e8 <unlink>
  pid = fork();
    1e2a:	e8 61 22 00 00       	call   4090 <fork>
  if(pid < 0){
    1e2f:	85 c0                	test   %eax,%eax
  pid = fork();
    1e31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1e34:	0f 88 b0 00 00 00    	js     1eea <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1e3a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1e3e:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1e43:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1e48:	19 ff                	sbb    %edi,%edi
    1e4a:	83 e7 60             	and    $0x60,%edi
    1e4d:	47                   	inc    %edi
    1e4e:	eb 12                	jmp    1e62 <linkunlink+0x62>
    } else if((x % 3) == 1){
    1e50:	4a                   	dec    %edx
    1e51:	74 7d                	je     1ed0 <linkunlink+0xd0>
      unlink("x");
    1e53:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    1e5a:	e8 89 22 00 00       	call   40e8 <unlink>
  for(i = 0; i < 100; i++){
    1e5f:	4b                   	dec    %ebx
    1e60:	74 3b                	je     1e9d <linkunlink+0x9d>
    x = x * 1103515245 + 12345;
    1e62:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1e68:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1e6e:	89 f8                	mov    %edi,%eax
    1e70:	f7 e6                	mul    %esi
    1e72:	d1 ea                	shr    %edx
    1e74:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1e77:	89 fa                	mov    %edi,%edx
    1e79:	29 c2                	sub    %eax,%edx
    1e7b:	75 d3                	jne    1e50 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1e7d:	b8 02 02 00 00       	mov    $0x202,%eax
    1e82:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e86:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    1e8d:	e8 46 22 00 00       	call   40d8 <open>
    1e92:	89 04 24             	mov    %eax,(%esp)
    1e95:	e8 26 22 00 00       	call   40c0 <close>
  for(i = 0; i < 100; i++){
    1e9a:	4b                   	dec    %ebx
    1e9b:	75 c5                	jne    1e62 <linkunlink+0x62>
  if(pid)
    1e9d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    wait(null);
    1ea0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid)
    1ea7:	85 d2                	test   %edx,%edx
    1ea9:	74 5f                	je     1f0a <linkunlink+0x10a>
    wait(null);
    1eab:	e8 f0 21 00 00       	call   40a0 <wait>
  printf(1, "linkunlink ok\n");
    1eb0:	b8 59 4c 00 00       	mov    $0x4c59,%eax
    1eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
    1eb9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ec0:	e8 3b 23 00 00       	call   4200 <printf>
}
    1ec5:	83 c4 2c             	add    $0x2c,%esp
    1ec8:	5b                   	pop    %ebx
    1ec9:	5e                   	pop    %esi
    1eca:	5f                   	pop    %edi
    1ecb:	5d                   	pop    %ebp
    1ecc:	c3                   	ret    
    1ecd:	8d 76 00             	lea    0x0(%esi),%esi
      link("cat", "x");
    1ed0:	b9 d1 4e 00 00       	mov    $0x4ed1,%ecx
    1ed5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1ed9:	c7 04 24 55 4c 00 00 	movl   $0x4c55,(%esp)
    1ee0:	e8 13 22 00 00       	call   40f8 <link>
    1ee5:	e9 75 ff ff ff       	jmp    1e5f <linkunlink+0x5f>
    printf(1, "fork failed\n");
    1eea:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
    1ef1:	00 
    1ef2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ef9:	e8 02 23 00 00       	call   4200 <printf>
    exit(0);
    1efe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1f05:	e8 8e 21 00 00       	call   4098 <exit>
    exit(0);
    1f0a:	e8 89 21 00 00       	call   4098 <exit>
    1f0f:	90                   	nop

00001f10 <bigdir>:
{
    1f10:	55                   	push   %ebp
    1f11:	89 e5                	mov    %esp,%ebp
    1f13:	57                   	push   %edi
    1f14:	56                   	push   %esi
  fd = open("bd", O_CREATE);
    1f15:	be 00 02 00 00       	mov    $0x200,%esi
{
    1f1a:	53                   	push   %ebx
  printf(1, "bigdir test\n");
    1f1b:	bb 68 4c 00 00       	mov    $0x4c68,%ebx
{
    1f20:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "bigdir test\n");
    1f23:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1f27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f2e:	e8 cd 22 00 00       	call   4200 <printf>
  unlink("bd");
    1f33:	c7 04 24 75 4c 00 00 	movl   $0x4c75,(%esp)
    1f3a:	e8 a9 21 00 00       	call   40e8 <unlink>
  fd = open("bd", O_CREATE);
    1f3f:	89 74 24 04          	mov    %esi,0x4(%esp)
    1f43:	c7 04 24 75 4c 00 00 	movl   $0x4c75,(%esp)
    1f4a:	e8 89 21 00 00       	call   40d8 <open>
  if(fd < 0){
    1f4f:	85 c0                	test   %eax,%eax
    1f51:	0f 88 f9 00 00 00    	js     2050 <bigdir+0x140>
  close(fd);
    1f57:	89 04 24             	mov    %eax,(%esp)
  for(i = 0; i < 500; i++){
    1f5a:	31 f6                	xor    %esi,%esi
  close(fd);
    1f5c:	e8 5f 21 00 00       	call   40c0 <close>
    1f61:	8d 7d de             	lea    -0x22(%ebp),%edi
    1f64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1f6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    name[1] = '0' + (i / 64);
    1f70:	89 f0                	mov    %esi,%eax
    1f72:	c1 f8 06             	sar    $0x6,%eax
    1f75:	04 30                	add    $0x30,%al
    1f77:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1f7a:	89 f0                	mov    %esi,%eax
    1f7c:	83 e0 3f             	and    $0x3f,%eax
    1f7f:	04 30                	add    $0x30,%al
    if(link("bd", name) != 0){
    1f81:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1f85:	c7 04 24 75 4c 00 00 	movl   $0x4c75,(%esp)
    name[0] = 'x';
    1f8c:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[2] = '0' + (i % 64);
    1f90:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1f93:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(link("bd", name) != 0){
    1f97:	e8 5c 21 00 00       	call   40f8 <link>
    1f9c:	85 c0                	test   %eax,%eax
    1f9e:	89 c3                	mov    %eax,%ebx
    1fa0:	75 6c                	jne    200e <bigdir+0xfe>
  for(i = 0; i < 500; i++){
    1fa2:	46                   	inc    %esi
    1fa3:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1fa9:	75 c5                	jne    1f70 <bigdir+0x60>
  unlink("bd");
    1fab:	c7 04 24 75 4c 00 00 	movl   $0x4c75,(%esp)
    1fb2:	e8 31 21 00 00       	call   40e8 <unlink>
    1fb7:	89 f6                	mov    %esi,%esi
    1fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    name[1] = '0' + (i / 64);
    1fc0:	89 d8                	mov    %ebx,%eax
    1fc2:	c1 f8 06             	sar    $0x6,%eax
    1fc5:	04 30                	add    $0x30,%al
    1fc7:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1fca:	89 d8                	mov    %ebx,%eax
    1fcc:	83 e0 3f             	and    $0x3f,%eax
    1fcf:	04 30                	add    $0x30,%al
    if(unlink(name) != 0){
    1fd1:	89 3c 24             	mov    %edi,(%esp)
    name[0] = 'x';
    1fd4:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[2] = '0' + (i % 64);
    1fd8:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1fdb:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(unlink(name) != 0){
    1fdf:	e8 04 21 00 00       	call   40e8 <unlink>
    1fe4:	85 c0                	test   %eax,%eax
    1fe6:	75 47                	jne    202f <bigdir+0x11f>
  for(i = 0; i < 500; i++){
    1fe8:	43                   	inc    %ebx
    1fe9:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1fef:	75 cf                	jne    1fc0 <bigdir+0xb0>
  printf(1, "bigdir ok\n");
    1ff1:	b8 b7 4c 00 00       	mov    $0x4cb7,%eax
    1ff6:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ffa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2001:	e8 fa 21 00 00       	call   4200 <printf>
}
    2006:	83 c4 2c             	add    $0x2c,%esp
    2009:	5b                   	pop    %ebx
    200a:	5e                   	pop    %esi
    200b:	5f                   	pop    %edi
    200c:	5d                   	pop    %ebp
    200d:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    200e:	b9 8e 4c 00 00       	mov    $0x4c8e,%ecx
    2013:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2017:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    201e:	e8 dd 21 00 00       	call   4200 <printf>
      exit(0);
    2023:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    202a:	e8 69 20 00 00       	call   4098 <exit>
      printf(1, "bigdir unlink failed");
    202f:	ba a2 4c 00 00       	mov    $0x4ca2,%edx
    2034:	89 54 24 04          	mov    %edx,0x4(%esp)
    2038:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    203f:	e8 bc 21 00 00       	call   4200 <printf>
      exit(0);
    2044:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    204b:	e8 48 20 00 00       	call   4098 <exit>
    printf(1, "bigdir create failed\n");
    2050:	c7 44 24 04 78 4c 00 	movl   $0x4c78,0x4(%esp)
    2057:	00 
    2058:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    205f:	e8 9c 21 00 00       	call   4200 <printf>
    exit(0);
    2064:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    206b:	e8 28 20 00 00       	call   4098 <exit>

00002070 <subdir>:
{
    2070:	55                   	push   %ebp
  printf(1, "subdir test\n");
    2071:	b8 c2 4c 00 00       	mov    $0x4cc2,%eax
{
    2076:	89 e5                	mov    %esp,%ebp
    2078:	53                   	push   %ebx
    2079:	83 ec 14             	sub    $0x14,%esp
  printf(1, "subdir test\n");
    207c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2080:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2087:	e8 74 21 00 00       	call   4200 <printf>
  unlink("ff");
    208c:	c7 04 24 4b 4d 00 00 	movl   $0x4d4b,(%esp)
    2093:	e8 50 20 00 00       	call   40e8 <unlink>
  if(mkdir("dd") != 0){
    2098:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    209f:	e8 5c 20 00 00       	call   4100 <mkdir>
    20a4:	85 c0                	test   %eax,%eax
    20a6:	0f 85 ad 06 00 00    	jne    2759 <subdir+0x6e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    20ac:	b8 02 02 00 00       	mov    $0x202,%eax
    20b1:	89 44 24 04          	mov    %eax,0x4(%esp)
    20b5:	c7 04 24 21 4d 00 00 	movl   $0x4d21,(%esp)
    20bc:	e8 17 20 00 00       	call   40d8 <open>
  if(fd < 0){
    20c1:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    20c3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    20c5:	0f 88 6e 06 00 00    	js     2739 <subdir+0x6c9>
  write(fd, "ff", 2);
    20cb:	b8 02 00 00 00       	mov    $0x2,%eax
    20d0:	89 44 24 08          	mov    %eax,0x8(%esp)
    20d4:	b8 4b 4d 00 00       	mov    $0x4d4b,%eax
    20d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    20dd:	89 1c 24             	mov    %ebx,(%esp)
    20e0:	e8 d3 1f 00 00       	call   40b8 <write>
  close(fd);
    20e5:	89 1c 24             	mov    %ebx,(%esp)
    20e8:	e8 d3 1f 00 00       	call   40c0 <close>
  if(unlink("dd") >= 0){
    20ed:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    20f4:	e8 ef 1f 00 00       	call   40e8 <unlink>
    20f9:	85 c0                	test   %eax,%eax
    20fb:	0f 89 18 06 00 00    	jns    2719 <subdir+0x6a9>
  if(mkdir("/dd/dd") != 0){
    2101:	c7 04 24 fc 4c 00 00 	movl   $0x4cfc,(%esp)
    2108:	e8 f3 1f 00 00       	call   4100 <mkdir>
    210d:	85 c0                	test   %eax,%eax
    210f:	0f 85 e4 05 00 00    	jne    26f9 <subdir+0x689>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2115:	b9 02 02 00 00       	mov    $0x202,%ecx
    211a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    211e:	c7 04 24 1e 4d 00 00 	movl   $0x4d1e,(%esp)
    2125:	e8 ae 1f 00 00       	call   40d8 <open>
  if(fd < 0){
    212a:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    212c:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    212e:	0f 88 65 04 00 00    	js     2599 <subdir+0x529>
  write(fd, "FF", 2);
    2134:	b8 02 00 00 00       	mov    $0x2,%eax
    2139:	89 44 24 08          	mov    %eax,0x8(%esp)
    213d:	b8 3f 4d 00 00       	mov    $0x4d3f,%eax
    2142:	89 1c 24             	mov    %ebx,(%esp)
    2145:	89 44 24 04          	mov    %eax,0x4(%esp)
    2149:	e8 6a 1f 00 00       	call   40b8 <write>
  close(fd);
    214e:	89 1c 24             	mov    %ebx,(%esp)
    2151:	e8 6a 1f 00 00       	call   40c0 <close>
  fd = open("dd/dd/../ff", 0);
    2156:	31 d2                	xor    %edx,%edx
    2158:	89 54 24 04          	mov    %edx,0x4(%esp)
    215c:	c7 04 24 42 4d 00 00 	movl   $0x4d42,(%esp)
    2163:	e8 70 1f 00 00       	call   40d8 <open>
  if(fd < 0){
    2168:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    216a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    216c:	0f 88 07 04 00 00    	js     2579 <subdir+0x509>
  cc = read(fd, buf, sizeof(buf));
    2172:	b8 00 20 00 00       	mov    $0x2000,%eax
    2177:	89 44 24 08          	mov    %eax,0x8(%esp)
    217b:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    2180:	89 44 24 04          	mov    %eax,0x4(%esp)
    2184:	89 1c 24             	mov    %ebx,(%esp)
    2187:	e8 24 1f 00 00       	call   40b0 <read>
  if(cc != 2 || buf[0] != 'f'){
    218c:	83 f8 02             	cmp    $0x2,%eax
    218f:	0f 85 04 03 00 00    	jne    2499 <subdir+0x429>
    2195:	80 3d 20 8e 00 00 66 	cmpb   $0x66,0x8e20
    219c:	0f 85 f7 02 00 00    	jne    2499 <subdir+0x429>
  close(fd);
    21a2:	89 1c 24             	mov    %ebx,(%esp)
    21a5:	e8 16 1f 00 00       	call   40c0 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    21aa:	b8 82 4d 00 00       	mov    $0x4d82,%eax
    21af:	89 44 24 04          	mov    %eax,0x4(%esp)
    21b3:	c7 04 24 1e 4d 00 00 	movl   $0x4d1e,(%esp)
    21ba:	e8 39 1f 00 00       	call   40f8 <link>
    21bf:	85 c0                	test   %eax,%eax
    21c1:	0f 85 12 04 00 00    	jne    25d9 <subdir+0x569>
  if(unlink("dd/dd/ff") != 0){
    21c7:	c7 04 24 1e 4d 00 00 	movl   $0x4d1e,(%esp)
    21ce:	e8 15 1f 00 00       	call   40e8 <unlink>
    21d3:	85 c0                	test   %eax,%eax
    21d5:	0f 85 fe 02 00 00    	jne    24d9 <subdir+0x469>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    21db:	31 c0                	xor    %eax,%eax
    21dd:	89 44 24 04          	mov    %eax,0x4(%esp)
    21e1:	c7 04 24 1e 4d 00 00 	movl   $0x4d1e,(%esp)
    21e8:	e8 eb 1e 00 00       	call   40d8 <open>
    21ed:	85 c0                	test   %eax,%eax
    21ef:	0f 89 e4 04 00 00    	jns    26d9 <subdir+0x669>
  if(chdir("dd") != 0){
    21f5:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    21fc:	e8 07 1f 00 00       	call   4108 <chdir>
    2201:	85 c0                	test   %eax,%eax
    2203:	0f 85 b0 04 00 00    	jne    26b9 <subdir+0x649>
  if(chdir("dd/../../dd") != 0){
    2209:	c7 04 24 b6 4d 00 00 	movl   $0x4db6,(%esp)
    2210:	e8 f3 1e 00 00       	call   4108 <chdir>
    2215:	85 c0                	test   %eax,%eax
    2217:	0f 85 9c 02 00 00    	jne    24b9 <subdir+0x449>
  if(chdir("dd/../../../dd") != 0){
    221d:	c7 04 24 dc 4d 00 00 	movl   $0x4ddc,(%esp)
    2224:	e8 df 1e 00 00       	call   4108 <chdir>
    2229:	85 c0                	test   %eax,%eax
    222b:	0f 85 88 02 00 00    	jne    24b9 <subdir+0x449>
  if(chdir("./..") != 0){
    2231:	c7 04 24 eb 4d 00 00 	movl   $0x4deb,(%esp)
    2238:	e8 cb 1e 00 00       	call   4108 <chdir>
    223d:	85 c0                	test   %eax,%eax
    223f:	0f 85 74 03 00 00    	jne    25b9 <subdir+0x549>
  fd = open("dd/dd/ffff", 0);
    2245:	31 db                	xor    %ebx,%ebx
    2247:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    224b:	c7 04 24 82 4d 00 00 	movl   $0x4d82,(%esp)
    2252:	e8 81 1e 00 00       	call   40d8 <open>
  if(fd < 0){
    2257:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    2259:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    225b:	0f 88 78 06 00 00    	js     28d9 <subdir+0x869>
  if(read(fd, buf, sizeof(buf)) != 2){
    2261:	ba 00 20 00 00       	mov    $0x2000,%edx
    2266:	b9 20 8e 00 00       	mov    $0x8e20,%ecx
    226b:	89 54 24 08          	mov    %edx,0x8(%esp)
    226f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2273:	89 04 24             	mov    %eax,(%esp)
    2276:	e8 35 1e 00 00       	call   40b0 <read>
    227b:	83 f8 02             	cmp    $0x2,%eax
    227e:	0f 85 35 06 00 00    	jne    28b9 <subdir+0x849>
  close(fd);
    2284:	89 1c 24             	mov    %ebx,(%esp)
    2287:	e8 34 1e 00 00       	call   40c0 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    228c:	31 c0                	xor    %eax,%eax
    228e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2292:	c7 04 24 1e 4d 00 00 	movl   $0x4d1e,(%esp)
    2299:	e8 3a 1e 00 00       	call   40d8 <open>
    229e:	85 c0                	test   %eax,%eax
    22a0:	0f 89 73 02 00 00    	jns    2519 <subdir+0x4a9>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    22a6:	b8 02 02 00 00       	mov    $0x202,%eax
    22ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    22af:	c7 04 24 36 4e 00 00 	movl   $0x4e36,(%esp)
    22b6:	e8 1d 1e 00 00       	call   40d8 <open>
    22bb:	85 c0                	test   %eax,%eax
    22bd:	0f 89 36 02 00 00    	jns    24f9 <subdir+0x489>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    22c3:	b8 02 02 00 00       	mov    $0x202,%eax
    22c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    22cc:	c7 04 24 5b 4e 00 00 	movl   $0x4e5b,(%esp)
    22d3:	e8 00 1e 00 00       	call   40d8 <open>
    22d8:	85 c0                	test   %eax,%eax
    22da:	0f 89 b9 03 00 00    	jns    2699 <subdir+0x629>
  if(open("dd", O_CREATE) >= 0){
    22e0:	b8 00 02 00 00       	mov    $0x200,%eax
    22e5:	89 44 24 04          	mov    %eax,0x4(%esp)
    22e9:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    22f0:	e8 e3 1d 00 00       	call   40d8 <open>
    22f5:	85 c0                	test   %eax,%eax
    22f7:	0f 89 7c 03 00 00    	jns    2679 <subdir+0x609>
  if(open("dd", O_RDWR) >= 0){
    22fd:	b8 02 00 00 00       	mov    $0x2,%eax
    2302:	89 44 24 04          	mov    %eax,0x4(%esp)
    2306:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    230d:	e8 c6 1d 00 00       	call   40d8 <open>
    2312:	85 c0                	test   %eax,%eax
    2314:	0f 89 3f 03 00 00    	jns    2659 <subdir+0x5e9>
  if(open("dd", O_WRONLY) >= 0){
    231a:	b8 01 00 00 00       	mov    $0x1,%eax
    231f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2323:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    232a:	e8 a9 1d 00 00       	call   40d8 <open>
    232f:	85 c0                	test   %eax,%eax
    2331:	0f 89 02 03 00 00    	jns    2639 <subdir+0x5c9>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2337:	bb ca 4e 00 00       	mov    $0x4eca,%ebx
    233c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2340:	c7 04 24 36 4e 00 00 	movl   $0x4e36,(%esp)
    2347:	e8 ac 1d 00 00       	call   40f8 <link>
    234c:	85 c0                	test   %eax,%eax
    234e:	0f 84 c5 02 00 00    	je     2619 <subdir+0x5a9>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2354:	b9 ca 4e 00 00       	mov    $0x4eca,%ecx
    2359:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    235d:	c7 04 24 5b 4e 00 00 	movl   $0x4e5b,(%esp)
    2364:	e8 8f 1d 00 00       	call   40f8 <link>
    2369:	85 c0                	test   %eax,%eax
    236b:	0f 84 88 02 00 00    	je     25f9 <subdir+0x589>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2371:	ba 82 4d 00 00       	mov    $0x4d82,%edx
    2376:	89 54 24 04          	mov    %edx,0x4(%esp)
    237a:	c7 04 24 21 4d 00 00 	movl   $0x4d21,(%esp)
    2381:	e8 72 1d 00 00       	call   40f8 <link>
    2386:	85 c0                	test   %eax,%eax
    2388:	0f 84 cb 01 00 00    	je     2559 <subdir+0x4e9>
  if(mkdir("dd/ff/ff") == 0){
    238e:	c7 04 24 36 4e 00 00 	movl   $0x4e36,(%esp)
    2395:	e8 66 1d 00 00       	call   4100 <mkdir>
    239a:	85 c0                	test   %eax,%eax
    239c:	0f 84 97 01 00 00    	je     2539 <subdir+0x4c9>
  if(mkdir("dd/xx/ff") == 0){
    23a2:	c7 04 24 5b 4e 00 00 	movl   $0x4e5b,(%esp)
    23a9:	e8 52 1d 00 00       	call   4100 <mkdir>
    23ae:	85 c0                	test   %eax,%eax
    23b0:	0f 84 e3 04 00 00    	je     2899 <subdir+0x829>
  if(mkdir("dd/dd/ffff") == 0){
    23b6:	c7 04 24 82 4d 00 00 	movl   $0x4d82,(%esp)
    23bd:	e8 3e 1d 00 00       	call   4100 <mkdir>
    23c2:	85 c0                	test   %eax,%eax
    23c4:	0f 84 af 04 00 00    	je     2879 <subdir+0x809>
  if(unlink("dd/xx/ff") == 0){
    23ca:	c7 04 24 5b 4e 00 00 	movl   $0x4e5b,(%esp)
    23d1:	e8 12 1d 00 00       	call   40e8 <unlink>
    23d6:	85 c0                	test   %eax,%eax
    23d8:	0f 84 7b 04 00 00    	je     2859 <subdir+0x7e9>
  if(unlink("dd/ff/ff") == 0){
    23de:	c7 04 24 36 4e 00 00 	movl   $0x4e36,(%esp)
    23e5:	e8 fe 1c 00 00       	call   40e8 <unlink>
    23ea:	85 c0                	test   %eax,%eax
    23ec:	0f 84 47 04 00 00    	je     2839 <subdir+0x7c9>
  if(chdir("dd/ff") == 0){
    23f2:	c7 04 24 21 4d 00 00 	movl   $0x4d21,(%esp)
    23f9:	e8 0a 1d 00 00       	call   4108 <chdir>
    23fe:	85 c0                	test   %eax,%eax
    2400:	0f 84 13 04 00 00    	je     2819 <subdir+0x7a9>
  if(chdir("dd/xx") == 0){
    2406:	c7 04 24 cd 4e 00 00 	movl   $0x4ecd,(%esp)
    240d:	e8 f6 1c 00 00       	call   4108 <chdir>
    2412:	85 c0                	test   %eax,%eax
    2414:	0f 84 df 03 00 00    	je     27f9 <subdir+0x789>
  if(unlink("dd/dd/ffff") != 0){
    241a:	c7 04 24 82 4d 00 00 	movl   $0x4d82,(%esp)
    2421:	e8 c2 1c 00 00       	call   40e8 <unlink>
    2426:	85 c0                	test   %eax,%eax
    2428:	0f 85 ab 00 00 00    	jne    24d9 <subdir+0x469>
  if(unlink("dd/ff") != 0){
    242e:	c7 04 24 21 4d 00 00 	movl   $0x4d21,(%esp)
    2435:	e8 ae 1c 00 00       	call   40e8 <unlink>
    243a:	85 c0                	test   %eax,%eax
    243c:	0f 85 97 03 00 00    	jne    27d9 <subdir+0x769>
  if(unlink("dd") == 0){
    2442:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    2449:	e8 9a 1c 00 00       	call   40e8 <unlink>
    244e:	85 c0                	test   %eax,%eax
    2450:	0f 84 63 03 00 00    	je     27b9 <subdir+0x749>
  if(unlink("dd/dd") < 0){
    2456:	c7 04 24 fd 4c 00 00 	movl   $0x4cfd,(%esp)
    245d:	e8 86 1c 00 00       	call   40e8 <unlink>
    2462:	85 c0                	test   %eax,%eax
    2464:	0f 88 2f 03 00 00    	js     2799 <subdir+0x729>
  if(unlink("dd") < 0){
    246a:	c7 04 24 e8 4d 00 00 	movl   $0x4de8,(%esp)
    2471:	e8 72 1c 00 00       	call   40e8 <unlink>
    2476:	85 c0                	test   %eax,%eax
    2478:	0f 88 fb 02 00 00    	js     2779 <subdir+0x709>
  printf(1, "subdir ok\n");
    247e:	b8 ca 4f 00 00       	mov    $0x4fca,%eax
    2483:	89 44 24 04          	mov    %eax,0x4(%esp)
    2487:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    248e:	e8 6d 1d 00 00       	call   4200 <printf>
}
    2493:	83 c4 14             	add    $0x14,%esp
    2496:	5b                   	pop    %ebx
    2497:	5d                   	pop    %ebp
    2498:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2499:	c7 44 24 04 67 4d 00 	movl   $0x4d67,0x4(%esp)
    24a0:	00 
    24a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24a8:	e8 53 1d 00 00       	call   4200 <printf>
    exit(0);
    24ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24b4:	e8 df 1b 00 00       	call   4098 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    24b9:	c7 44 24 04 c2 4d 00 	movl   $0x4dc2,0x4(%esp)
    24c0:	00 
    24c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24c8:	e8 33 1d 00 00       	call   4200 <printf>
    exit(0);
    24cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24d4:	e8 bf 1b 00 00       	call   4098 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    24d9:	c7 44 24 04 8d 4d 00 	movl   $0x4d8d,0x4(%esp)
    24e0:	00 
    24e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24e8:	e8 13 1d 00 00       	call   4200 <printf>
    exit(0);
    24ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24f4:	e8 9f 1b 00 00       	call   4098 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    24f9:	c7 44 24 04 3f 4e 00 	movl   $0x4e3f,0x4(%esp)
    2500:	00 
    2501:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2508:	e8 f3 1c 00 00       	call   4200 <printf>
    exit(0);
    250d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2514:	e8 7f 1b 00 00       	call   4098 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2519:	c7 44 24 04 24 58 00 	movl   $0x5824,0x4(%esp)
    2520:	00 
    2521:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2528:	e8 d3 1c 00 00       	call   4200 <printf>
    exit(0);
    252d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2534:	e8 5f 1b 00 00       	call   4098 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2539:	c7 44 24 04 d3 4e 00 	movl   $0x4ed3,0x4(%esp)
    2540:	00 
    2541:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2548:	e8 b3 1c 00 00       	call   4200 <printf>
    exit(0);
    254d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2554:	e8 3f 1b 00 00       	call   4098 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2559:	c7 44 24 04 94 58 00 	movl   $0x5894,0x4(%esp)
    2560:	00 
    2561:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2568:	e8 93 1c 00 00       	call   4200 <printf>
    exit(0);
    256d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2574:	e8 1f 1b 00 00       	call   4098 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2579:	c7 44 24 04 4e 4d 00 	movl   $0x4d4e,0x4(%esp)
    2580:	00 
    2581:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2588:	e8 73 1c 00 00       	call   4200 <printf>
    exit(0);
    258d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2594:	e8 ff 1a 00 00       	call   4098 <exit>
    printf(1, "create dd/dd/ff failed\n");
    2599:	c7 44 24 04 27 4d 00 	movl   $0x4d27,0x4(%esp)
    25a0:	00 
    25a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25a8:	e8 53 1c 00 00       	call   4200 <printf>
    exit(0);
    25ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25b4:	e8 df 1a 00 00       	call   4098 <exit>
    printf(1, "chdir ./.. failed\n");
    25b9:	c7 44 24 04 f0 4d 00 	movl   $0x4df0,0x4(%esp)
    25c0:	00 
    25c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25c8:	e8 33 1c 00 00       	call   4200 <printf>
    exit(0);
    25cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25d4:	e8 bf 1a 00 00       	call   4098 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    25d9:	c7 44 24 04 dc 57 00 	movl   $0x57dc,0x4(%esp)
    25e0:	00 
    25e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25e8:	e8 13 1c 00 00       	call   4200 <printf>
    exit(0);
    25ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25f4:	e8 9f 1a 00 00       	call   4098 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    25f9:	c7 44 24 04 70 58 00 	movl   $0x5870,0x4(%esp)
    2600:	00 
    2601:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2608:	e8 f3 1b 00 00       	call   4200 <printf>
    exit(0);
    260d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2614:	e8 7f 1a 00 00       	call   4098 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2619:	c7 44 24 04 4c 58 00 	movl   $0x584c,0x4(%esp)
    2620:	00 
    2621:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2628:	e8 d3 1b 00 00       	call   4200 <printf>
    exit(0);
    262d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2634:	e8 5f 1a 00 00       	call   4098 <exit>
    printf(1, "open dd wronly succeeded!\n");
    2639:	c7 44 24 04 af 4e 00 	movl   $0x4eaf,0x4(%esp)
    2640:	00 
    2641:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2648:	e8 b3 1b 00 00       	call   4200 <printf>
    exit(0);
    264d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2654:	e8 3f 1a 00 00       	call   4098 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2659:	c7 44 24 04 96 4e 00 	movl   $0x4e96,0x4(%esp)
    2660:	00 
    2661:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2668:	e8 93 1b 00 00       	call   4200 <printf>
    exit(0);
    266d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2674:	e8 1f 1a 00 00       	call   4098 <exit>
    printf(1, "create dd succeeded!\n");
    2679:	c7 44 24 04 80 4e 00 	movl   $0x4e80,0x4(%esp)
    2680:	00 
    2681:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2688:	e8 73 1b 00 00       	call   4200 <printf>
    exit(0);
    268d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2694:	e8 ff 19 00 00       	call   4098 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2699:	c7 44 24 04 64 4e 00 	movl   $0x4e64,0x4(%esp)
    26a0:	00 
    26a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26a8:	e8 53 1b 00 00       	call   4200 <printf>
    exit(0);
    26ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26b4:	e8 df 19 00 00       	call   4098 <exit>
    printf(1, "chdir dd failed\n");
    26b9:	c7 44 24 04 a5 4d 00 	movl   $0x4da5,0x4(%esp)
    26c0:	00 
    26c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26c8:	e8 33 1b 00 00       	call   4200 <printf>
    exit(0);
    26cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26d4:	e8 bf 19 00 00       	call   4098 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    26d9:	c7 44 24 04 00 58 00 	movl   $0x5800,0x4(%esp)
    26e0:	00 
    26e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26e8:	e8 13 1b 00 00       	call   4200 <printf>
    exit(0);
    26ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26f4:	e8 9f 19 00 00       	call   4098 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    26f9:	c7 44 24 04 03 4d 00 	movl   $0x4d03,0x4(%esp)
    2700:	00 
    2701:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2708:	e8 f3 1a 00 00       	call   4200 <printf>
    exit(0);
    270d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2714:	e8 7f 19 00 00       	call   4098 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2719:	c7 44 24 04 b4 57 00 	movl   $0x57b4,0x4(%esp)
    2720:	00 
    2721:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2728:	e8 d3 1a 00 00       	call   4200 <printf>
    exit(0);
    272d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2734:	e8 5f 19 00 00       	call   4098 <exit>
    printf(1, "create dd/ff failed\n");
    2739:	c7 44 24 04 e7 4c 00 	movl   $0x4ce7,0x4(%esp)
    2740:	00 
    2741:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2748:	e8 b3 1a 00 00       	call   4200 <printf>
    exit(0);
    274d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2754:	e8 3f 19 00 00       	call   4098 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2759:	c7 44 24 04 cf 4c 00 	movl   $0x4ccf,0x4(%esp)
    2760:	00 
    2761:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2768:	e8 93 1a 00 00       	call   4200 <printf>
    exit(0);
    276d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2774:	e8 1f 19 00 00       	call   4098 <exit>
    printf(1, "unlink dd failed\n");
    2779:	c7 44 24 04 b8 4f 00 	movl   $0x4fb8,0x4(%esp)
    2780:	00 
    2781:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2788:	e8 73 1a 00 00       	call   4200 <printf>
    exit(0);
    278d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2794:	e8 ff 18 00 00       	call   4098 <exit>
    printf(1, "unlink dd/dd failed\n");
    2799:	c7 44 24 04 a3 4f 00 	movl   $0x4fa3,0x4(%esp)
    27a0:	00 
    27a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27a8:	e8 53 1a 00 00       	call   4200 <printf>
    exit(0);
    27ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27b4:	e8 df 18 00 00       	call   4098 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    27b9:	c7 44 24 04 b8 58 00 	movl   $0x58b8,0x4(%esp)
    27c0:	00 
    27c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27c8:	e8 33 1a 00 00       	call   4200 <printf>
    exit(0);
    27cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27d4:	e8 bf 18 00 00       	call   4098 <exit>
    printf(1, "unlink dd/ff failed\n");
    27d9:	c7 44 24 04 8e 4f 00 	movl   $0x4f8e,0x4(%esp)
    27e0:	00 
    27e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27e8:	e8 13 1a 00 00       	call   4200 <printf>
    exit(0);
    27ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27f4:	e8 9f 18 00 00       	call   4098 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    27f9:	c7 44 24 04 76 4f 00 	movl   $0x4f76,0x4(%esp)
    2800:	00 
    2801:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2808:	e8 f3 19 00 00       	call   4200 <printf>
    exit(0);
    280d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2814:	e8 7f 18 00 00       	call   4098 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    2819:	c7 44 24 04 5e 4f 00 	movl   $0x4f5e,0x4(%esp)
    2820:	00 
    2821:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2828:	e8 d3 19 00 00       	call   4200 <printf>
    exit(0);
    282d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2834:	e8 5f 18 00 00       	call   4098 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2839:	c7 44 24 04 42 4f 00 	movl   $0x4f42,0x4(%esp)
    2840:	00 
    2841:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2848:	e8 b3 19 00 00       	call   4200 <printf>
    exit(0);
    284d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2854:	e8 3f 18 00 00       	call   4098 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2859:	c7 44 24 04 26 4f 00 	movl   $0x4f26,0x4(%esp)
    2860:	00 
    2861:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2868:	e8 93 19 00 00       	call   4200 <printf>
    exit(0);
    286d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2874:	e8 1f 18 00 00       	call   4098 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2879:	c7 44 24 04 09 4f 00 	movl   $0x4f09,0x4(%esp)
    2880:	00 
    2881:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2888:	e8 73 19 00 00       	call   4200 <printf>
    exit(0);
    288d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2894:	e8 ff 17 00 00       	call   4098 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2899:	c7 44 24 04 ee 4e 00 	movl   $0x4eee,0x4(%esp)
    28a0:	00 
    28a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28a8:	e8 53 19 00 00       	call   4200 <printf>
    exit(0);
    28ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28b4:	e8 df 17 00 00       	call   4098 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    28b9:	c7 44 24 04 1b 4e 00 	movl   $0x4e1b,0x4(%esp)
    28c0:	00 
    28c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28c8:	e8 33 19 00 00       	call   4200 <printf>
    exit(0);
    28cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28d4:	e8 bf 17 00 00       	call   4098 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    28d9:	c7 44 24 04 03 4e 00 	movl   $0x4e03,0x4(%esp)
    28e0:	00 
    28e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28e8:	e8 13 19 00 00       	call   4200 <printf>
    exit(0);
    28ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28f4:	e8 9f 17 00 00       	call   4098 <exit>
    28f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002900 <bigwrite>:
{
    2900:	55                   	push   %ebp
  printf(1, "bigwrite test\n");
    2901:	b8 d5 4f 00 00       	mov    $0x4fd5,%eax
{
    2906:	89 e5                	mov    %esp,%ebp
    2908:	56                   	push   %esi
    2909:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    290a:	bb f3 01 00 00       	mov    $0x1f3,%ebx
{
    290f:	83 ec 10             	sub    $0x10,%esp
  printf(1, "bigwrite test\n");
    2912:	89 44 24 04          	mov    %eax,0x4(%esp)
    2916:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    291d:	e8 de 18 00 00       	call   4200 <printf>
  unlink("bigwrite");
    2922:	c7 04 24 e4 4f 00 00 	movl   $0x4fe4,(%esp)
    2929:	e8 ba 17 00 00       	call   40e8 <unlink>
    292e:	66 90                	xchg   %ax,%ax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2930:	b8 02 02 00 00       	mov    $0x202,%eax
    2935:	89 44 24 04          	mov    %eax,0x4(%esp)
    2939:	c7 04 24 e4 4f 00 00 	movl   $0x4fe4,(%esp)
    2940:	e8 93 17 00 00       	call   40d8 <open>
    if(fd < 0){
    2945:	85 c0                	test   %eax,%eax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2947:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2949:	0f 88 99 00 00 00    	js     29e8 <bigwrite+0xe8>
      int cc = write(fd, buf, sz);
    294f:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    2954:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2958:	89 44 24 04          	mov    %eax,0x4(%esp)
    295c:	89 34 24             	mov    %esi,(%esp)
    295f:	e8 54 17 00 00       	call   40b8 <write>
      if(cc != sz){
    2964:	39 d8                	cmp    %ebx,%eax
    2966:	75 57                	jne    29bf <bigwrite+0xbf>
      int cc = write(fd, buf, sz);
    2968:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    296d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2971:	89 44 24 04          	mov    %eax,0x4(%esp)
    2975:	89 34 24             	mov    %esi,(%esp)
    2978:	e8 3b 17 00 00       	call   40b8 <write>
      if(cc != sz){
    297d:	39 d8                	cmp    %ebx,%eax
    297f:	75 3e                	jne    29bf <bigwrite+0xbf>
    close(fd);
    2981:	89 34 24             	mov    %esi,(%esp)
  for(sz = 499; sz < 12*512; sz += 471){
    2984:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    298a:	e8 31 17 00 00       	call   40c0 <close>
    unlink("bigwrite");
    298f:	c7 04 24 e4 4f 00 00 	movl   $0x4fe4,(%esp)
    2996:	e8 4d 17 00 00       	call   40e8 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    299b:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    29a1:	75 8d                	jne    2930 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    29a3:	b8 17 50 00 00       	mov    $0x5017,%eax
    29a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    29ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29b3:	e8 48 18 00 00       	call   4200 <printf>
}
    29b8:	83 c4 10             	add    $0x10,%esp
    29bb:	5b                   	pop    %ebx
    29bc:	5e                   	pop    %esi
    29bd:	5d                   	pop    %ebp
    29be:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    29bf:	ba 05 50 00 00       	mov    $0x5005,%edx
    29c4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    29c8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    29cc:	89 54 24 04          	mov    %edx,0x4(%esp)
    29d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29d7:	e8 24 18 00 00       	call   4200 <printf>
        exit(0);
    29dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    29e3:	e8 b0 16 00 00       	call   4098 <exit>
      printf(1, "cannot create bigwrite\n");
    29e8:	b9 ed 4f 00 00       	mov    $0x4fed,%ecx
    29ed:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    29f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29f8:	e8 03 18 00 00       	call   4200 <printf>
      exit(0);
    29fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a04:	e8 8f 16 00 00       	call   4098 <exit>
    2a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002a10 <bigfile>:
{
    2a10:	55                   	push   %ebp
  printf(1, "bigfile test\n");
    2a11:	b9 24 50 00 00       	mov    $0x5024,%ecx
{
    2a16:	89 e5                	mov    %esp,%ebp
    2a18:	57                   	push   %edi
    2a19:	56                   	push   %esi
    2a1a:	53                   	push   %ebx
  fd = open("bigfile", O_CREATE | O_RDWR);
    2a1b:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    2a20:	83 ec 1c             	sub    $0x1c,%esp
  printf(1, "bigfile test\n");
    2a23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2a27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a2e:	e8 cd 17 00 00       	call   4200 <printf>
  unlink("bigfile");
    2a33:	c7 04 24 40 50 00 00 	movl   $0x5040,(%esp)
    2a3a:	e8 a9 16 00 00       	call   40e8 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2a3f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2a43:	c7 04 24 40 50 00 00 	movl   $0x5040,(%esp)
    2a4a:	e8 89 16 00 00       	call   40d8 <open>
  if(fd < 0){
    2a4f:	85 c0                	test   %eax,%eax
    2a51:	0f 88 aa 01 00 00    	js     2c01 <bigfile+0x1f1>
    2a57:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    2a59:	31 db                	xor    %ebx,%ebx
    2a5b:	90                   	nop
    2a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2a60:	b8 58 02 00 00       	mov    $0x258,%eax
    2a65:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a69:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2a6d:	c7 04 24 20 8e 00 00 	movl   $0x8e20,(%esp)
    2a74:	e8 87 14 00 00       	call   3f00 <memset>
    if(write(fd, buf, 600) != 600){
    2a79:	b8 58 02 00 00       	mov    $0x258,%eax
    2a7e:	ba 20 8e 00 00       	mov    $0x8e20,%edx
    2a83:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a87:	89 54 24 04          	mov    %edx,0x4(%esp)
    2a8b:	89 34 24             	mov    %esi,(%esp)
    2a8e:	e8 25 16 00 00       	call   40b8 <write>
    2a93:	3d 58 02 00 00       	cmp    $0x258,%eax
    2a98:	0f 85 22 01 00 00    	jne    2bc0 <bigfile+0x1b0>
  for(i = 0; i < 20; i++){
    2a9e:	43                   	inc    %ebx
    2a9f:	83 fb 14             	cmp    $0x14,%ebx
    2aa2:	75 bc                	jne    2a60 <bigfile+0x50>
  close(fd);
    2aa4:	89 34 24             	mov    %esi,(%esp)
    2aa7:	e8 14 16 00 00       	call   40c0 <close>
  fd = open("bigfile", 0);
    2aac:	31 c0                	xor    %eax,%eax
    2aae:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ab2:	c7 04 24 40 50 00 00 	movl   $0x5040,(%esp)
    2ab9:	e8 1a 16 00 00       	call   40d8 <open>
  if(fd < 0){
    2abe:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2ac0:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2ac2:	0f 88 19 01 00 00    	js     2be1 <bigfile+0x1d1>
  total = 0;
    2ac8:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    2aca:	31 ff                	xor    %edi,%edi
    2acc:	eb 2e                	jmp    2afc <bigfile+0xec>
    2ace:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2ad0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2ad5:	0f 85 a3 00 00 00    	jne    2b7e <bigfile+0x16e>
    if(buf[0] != i/2 || buf[299] != i/2){
    2adb:	0f be 05 20 8e 00 00 	movsbl 0x8e20,%eax
    2ae2:	89 fa                	mov    %edi,%edx
    2ae4:	d1 fa                	sar    %edx
    2ae6:	39 d0                	cmp    %edx,%eax
    2ae8:	75 73                	jne    2b5d <bigfile+0x14d>
    2aea:	0f be 15 4b 8f 00 00 	movsbl 0x8f4b,%edx
    2af1:	39 d0                	cmp    %edx,%eax
    2af3:	75 68                	jne    2b5d <bigfile+0x14d>
    total += cc;
    2af5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    2afb:	47                   	inc    %edi
    cc = read(fd, buf, 300);
    2afc:	b8 2c 01 00 00       	mov    $0x12c,%eax
    2b01:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b05:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    2b0a:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b0e:	89 34 24             	mov    %esi,(%esp)
    2b11:	e8 9a 15 00 00       	call   40b0 <read>
    if(cc < 0){
    2b16:	85 c0                	test   %eax,%eax
    2b18:	0f 88 81 00 00 00    	js     2b9f <bigfile+0x18f>
    if(cc == 0)
    2b1e:	75 b0                	jne    2ad0 <bigfile+0xc0>
  close(fd);
    2b20:	89 34 24             	mov    %esi,(%esp)
    2b23:	e8 98 15 00 00       	call   40c0 <close>
  if(total != 20*600){
    2b28:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    2b2e:	0f 85 ed 00 00 00    	jne    2c21 <bigfile+0x211>
  unlink("bigfile");
    2b34:	c7 04 24 40 50 00 00 	movl   $0x5040,(%esp)
    2b3b:	e8 a8 15 00 00       	call   40e8 <unlink>
  printf(1, "bigfile test ok\n");
    2b40:	b8 cf 50 00 00       	mov    $0x50cf,%eax
    2b45:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b50:	e8 ab 16 00 00       	call   4200 <printf>
}
    2b55:	83 c4 1c             	add    $0x1c,%esp
    2b58:	5b                   	pop    %ebx
    2b59:	5e                   	pop    %esi
    2b5a:	5f                   	pop    %edi
    2b5b:	5d                   	pop    %ebp
    2b5c:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2b5d:	ba 9c 50 00 00       	mov    $0x509c,%edx
    2b62:	89 54 24 04          	mov    %edx,0x4(%esp)
    2b66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b6d:	e8 8e 16 00 00       	call   4200 <printf>
      exit(0);
    2b72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b79:	e8 1a 15 00 00       	call   4098 <exit>
      printf(1, "short read bigfile\n");
    2b7e:	b9 88 50 00 00       	mov    $0x5088,%ecx
    2b83:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2b87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b8e:	e8 6d 16 00 00       	call   4200 <printf>
      exit(0);
    2b93:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b9a:	e8 f9 14 00 00       	call   4098 <exit>
      printf(1, "read bigfile failed\n");
    2b9f:	bb 73 50 00 00       	mov    $0x5073,%ebx
    2ba4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2ba8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2baf:	e8 4c 16 00 00       	call   4200 <printf>
      exit(0);
    2bb4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bbb:	e8 d8 14 00 00       	call   4098 <exit>
      printf(1, "write bigfile failed\n");
    2bc0:	b8 48 50 00 00       	mov    $0x5048,%eax
    2bc5:	89 44 24 04          	mov    %eax,0x4(%esp)
    2bc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bd0:	e8 2b 16 00 00       	call   4200 <printf>
      exit(0);
    2bd5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bdc:	e8 b7 14 00 00       	call   4098 <exit>
    printf(1, "cannot open bigfile\n");
    2be1:	c7 44 24 04 5e 50 00 	movl   $0x505e,0x4(%esp)
    2be8:	00 
    2be9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bf0:	e8 0b 16 00 00       	call   4200 <printf>
    exit(0);
    2bf5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bfc:	e8 97 14 00 00       	call   4098 <exit>
    printf(1, "cannot create bigfile");
    2c01:	c7 44 24 04 32 50 00 	movl   $0x5032,0x4(%esp)
    2c08:	00 
    2c09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c10:	e8 eb 15 00 00       	call   4200 <printf>
    exit(0);
    2c15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c1c:	e8 77 14 00 00       	call   4098 <exit>
    printf(1, "read bigfile wrong total\n");
    2c21:	c7 44 24 04 b5 50 00 	movl   $0x50b5,0x4(%esp)
    2c28:	00 
    2c29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c30:	e8 cb 15 00 00       	call   4200 <printf>
    exit(0);
    2c35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c3c:	e8 57 14 00 00       	call   4098 <exit>
    2c41:	eb 0d                	jmp    2c50 <fourteen>
    2c43:	90                   	nop
    2c44:	90                   	nop
    2c45:	90                   	nop
    2c46:	90                   	nop
    2c47:	90                   	nop
    2c48:	90                   	nop
    2c49:	90                   	nop
    2c4a:	90                   	nop
    2c4b:	90                   	nop
    2c4c:	90                   	nop
    2c4d:	90                   	nop
    2c4e:	90                   	nop
    2c4f:	90                   	nop

00002c50 <fourteen>:
{
    2c50:	55                   	push   %ebp
  printf(1, "fourteen test\n");
    2c51:	b8 e0 50 00 00       	mov    $0x50e0,%eax
{
    2c56:	89 e5                	mov    %esp,%ebp
    2c58:	83 ec 18             	sub    $0x18,%esp
  printf(1, "fourteen test\n");
    2c5b:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c66:	e8 95 15 00 00       	call   4200 <printf>
  if(mkdir("12345678901234") != 0){
    2c6b:	c7 04 24 1b 51 00 00 	movl   $0x511b,(%esp)
    2c72:	e8 89 14 00 00       	call   4100 <mkdir>
    2c77:	85 c0                	test   %eax,%eax
    2c79:	0f 85 92 00 00 00    	jne    2d11 <fourteen+0xc1>
  if(mkdir("12345678901234/123456789012345") != 0){
    2c7f:	c7 04 24 d8 58 00 00 	movl   $0x58d8,(%esp)
    2c86:	e8 75 14 00 00       	call   4100 <mkdir>
    2c8b:	85 c0                	test   %eax,%eax
    2c8d:	0f 85 1e 01 00 00    	jne    2db1 <fourteen+0x161>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2c93:	b9 00 02 00 00       	mov    $0x200,%ecx
    2c98:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2c9c:	c7 04 24 28 59 00 00 	movl   $0x5928,(%esp)
    2ca3:	e8 30 14 00 00       	call   40d8 <open>
  if(fd < 0){
    2ca8:	85 c0                	test   %eax,%eax
    2caa:	0f 88 e1 00 00 00    	js     2d91 <fourteen+0x141>
  close(fd);
    2cb0:	89 04 24             	mov    %eax,(%esp)
    2cb3:	e8 08 14 00 00       	call   40c0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2cb8:	31 d2                	xor    %edx,%edx
    2cba:	89 54 24 04          	mov    %edx,0x4(%esp)
    2cbe:	c7 04 24 98 59 00 00 	movl   $0x5998,(%esp)
    2cc5:	e8 0e 14 00 00       	call   40d8 <open>
  if(fd < 0){
    2cca:	85 c0                	test   %eax,%eax
    2ccc:	0f 88 9f 00 00 00    	js     2d71 <fourteen+0x121>
  close(fd);
    2cd2:	89 04 24             	mov    %eax,(%esp)
    2cd5:	e8 e6 13 00 00       	call   40c0 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2cda:	c7 04 24 0c 51 00 00 	movl   $0x510c,(%esp)
    2ce1:	e8 1a 14 00 00       	call   4100 <mkdir>
    2ce6:	85 c0                	test   %eax,%eax
    2ce8:	74 67                	je     2d51 <fourteen+0x101>
  if(mkdir("123456789012345/12345678901234") == 0){
    2cea:	c7 04 24 34 5a 00 00 	movl   $0x5a34,(%esp)
    2cf1:	e8 0a 14 00 00       	call   4100 <mkdir>
    2cf6:	85 c0                	test   %eax,%eax
    2cf8:	74 37                	je     2d31 <fourteen+0xe1>
  printf(1, "fourteen ok\n");
    2cfa:	b8 2a 51 00 00       	mov    $0x512a,%eax
    2cff:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d03:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d0a:	e8 f1 14 00 00       	call   4200 <printf>
}
    2d0f:	c9                   	leave  
    2d10:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2d11:	c7 44 24 04 ef 50 00 	movl   $0x50ef,0x4(%esp)
    2d18:	00 
    2d19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d20:	e8 db 14 00 00       	call   4200 <printf>
    exit(0);
    2d25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d2c:	e8 67 13 00 00       	call   4098 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2d31:	c7 44 24 04 54 5a 00 	movl   $0x5a54,0x4(%esp)
    2d38:	00 
    2d39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d40:	e8 bb 14 00 00       	call   4200 <printf>
    exit(0);
    2d45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d4c:	e8 47 13 00 00       	call   4098 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2d51:	c7 44 24 04 04 5a 00 	movl   $0x5a04,0x4(%esp)
    2d58:	00 
    2d59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d60:	e8 9b 14 00 00       	call   4200 <printf>
    exit(0);
    2d65:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d6c:	e8 27 13 00 00       	call   4098 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2d71:	c7 44 24 04 c8 59 00 	movl   $0x59c8,0x4(%esp)
    2d78:	00 
    2d79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d80:	e8 7b 14 00 00       	call   4200 <printf>
    exit(0);
    2d85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d8c:	e8 07 13 00 00       	call   4098 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2d91:	c7 44 24 04 58 59 00 	movl   $0x5958,0x4(%esp)
    2d98:	00 
    2d99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2da0:	e8 5b 14 00 00       	call   4200 <printf>
    exit(0);
    2da5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2dac:	e8 e7 12 00 00       	call   4098 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2db1:	c7 44 24 04 f8 58 00 	movl   $0x58f8,0x4(%esp)
    2db8:	00 
    2db9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dc0:	e8 3b 14 00 00       	call   4200 <printf>
    exit(0);
    2dc5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2dcc:	e8 c7 12 00 00       	call   4098 <exit>
    2dd1:	eb 0d                	jmp    2de0 <rmdot>
    2dd3:	90                   	nop
    2dd4:	90                   	nop
    2dd5:	90                   	nop
    2dd6:	90                   	nop
    2dd7:	90                   	nop
    2dd8:	90                   	nop
    2dd9:	90                   	nop
    2dda:	90                   	nop
    2ddb:	90                   	nop
    2ddc:	90                   	nop
    2ddd:	90                   	nop
    2dde:	90                   	nop
    2ddf:	90                   	nop

00002de0 <rmdot>:
{
    2de0:	55                   	push   %ebp
  printf(1, "rmdot test\n");
    2de1:	ba 37 51 00 00       	mov    $0x5137,%edx
{
    2de6:	89 e5                	mov    %esp,%ebp
    2de8:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    2deb:	89 54 24 04          	mov    %edx,0x4(%esp)
    2def:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2df6:	e8 05 14 00 00       	call   4200 <printf>
  if(mkdir("dots") != 0){
    2dfb:	c7 04 24 43 51 00 00 	movl   $0x5143,(%esp)
    2e02:	e8 f9 12 00 00       	call   4100 <mkdir>
    2e07:	85 c0                	test   %eax,%eax
    2e09:	0f 85 9b 00 00 00    	jne    2eaa <rmdot+0xca>
  if(chdir("dots") != 0){
    2e0f:	c7 04 24 43 51 00 00 	movl   $0x5143,(%esp)
    2e16:	e8 ed 12 00 00       	call   4108 <chdir>
    2e1b:	85 c0                	test   %eax,%eax
    2e1d:	0f 85 67 01 00 00    	jne    2f8a <rmdot+0x1aa>
  if(unlink(".") == 0){
    2e23:	c7 04 24 ee 4d 00 00 	movl   $0x4dee,(%esp)
    2e2a:	e8 b9 12 00 00       	call   40e8 <unlink>
    2e2f:	85 c0                	test   %eax,%eax
    2e31:	0f 84 33 01 00 00    	je     2f6a <rmdot+0x18a>
  if(unlink("..") == 0){
    2e37:	c7 04 24 ed 4d 00 00 	movl   $0x4ded,(%esp)
    2e3e:	e8 a5 12 00 00       	call   40e8 <unlink>
    2e43:	85 c0                	test   %eax,%eax
    2e45:	0f 84 ff 00 00 00    	je     2f4a <rmdot+0x16a>
  if(chdir("/") != 0){
    2e4b:	c7 04 24 c1 45 00 00 	movl   $0x45c1,(%esp)
    2e52:	e8 b1 12 00 00       	call   4108 <chdir>
    2e57:	85 c0                	test   %eax,%eax
    2e59:	0f 85 cb 00 00 00    	jne    2f2a <rmdot+0x14a>
  if(unlink("dots/.") == 0){
    2e5f:	c7 04 24 8b 51 00 00 	movl   $0x518b,(%esp)
    2e66:	e8 7d 12 00 00       	call   40e8 <unlink>
    2e6b:	85 c0                	test   %eax,%eax
    2e6d:	0f 84 97 00 00 00    	je     2f0a <rmdot+0x12a>
  if(unlink("dots/..") == 0){
    2e73:	c7 04 24 a9 51 00 00 	movl   $0x51a9,(%esp)
    2e7a:	e8 69 12 00 00       	call   40e8 <unlink>
    2e7f:	85 c0                	test   %eax,%eax
    2e81:	74 67                	je     2eea <rmdot+0x10a>
  if(unlink("dots") != 0){
    2e83:	c7 04 24 43 51 00 00 	movl   $0x5143,(%esp)
    2e8a:	e8 59 12 00 00       	call   40e8 <unlink>
    2e8f:	85 c0                	test   %eax,%eax
    2e91:	75 37                	jne    2eca <rmdot+0xea>
  printf(1, "rmdot ok\n");
    2e93:	b8 de 51 00 00       	mov    $0x51de,%eax
    2e98:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ea3:	e8 58 13 00 00       	call   4200 <printf>
}
    2ea8:	c9                   	leave  
    2ea9:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    2eaa:	c7 44 24 04 48 51 00 	movl   $0x5148,0x4(%esp)
    2eb1:	00 
    2eb2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eb9:	e8 42 13 00 00       	call   4200 <printf>
    exit(0);
    2ebe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ec5:	e8 ce 11 00 00       	call   4098 <exit>
    printf(1, "unlink dots failed!\n");
    2eca:	c7 44 24 04 c9 51 00 	movl   $0x51c9,0x4(%esp)
    2ed1:	00 
    2ed2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ed9:	e8 22 13 00 00       	call   4200 <printf>
    exit(0);
    2ede:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ee5:	e8 ae 11 00 00       	call   4098 <exit>
    printf(1, "unlink dots/.. worked!\n");
    2eea:	c7 44 24 04 b1 51 00 	movl   $0x51b1,0x4(%esp)
    2ef1:	00 
    2ef2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ef9:	e8 02 13 00 00       	call   4200 <printf>
    exit(0);
    2efe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f05:	e8 8e 11 00 00       	call   4098 <exit>
    printf(1, "unlink dots/. worked!\n");
    2f0a:	c7 44 24 04 92 51 00 	movl   $0x5192,0x4(%esp)
    2f11:	00 
    2f12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f19:	e8 e2 12 00 00       	call   4200 <printf>
    exit(0);
    2f1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f25:	e8 6e 11 00 00       	call   4098 <exit>
    printf(1, "chdir / failed\n");
    2f2a:	c7 44 24 04 c3 45 00 	movl   $0x45c3,0x4(%esp)
    2f31:	00 
    2f32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f39:	e8 c2 12 00 00       	call   4200 <printf>
    exit(0);
    2f3e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f45:	e8 4e 11 00 00       	call   4098 <exit>
    printf(1, "rm .. worked!\n");
    2f4a:	c7 44 24 04 7c 51 00 	movl   $0x517c,0x4(%esp)
    2f51:	00 
    2f52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f59:	e8 a2 12 00 00       	call   4200 <printf>
    exit(0);
    2f5e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f65:	e8 2e 11 00 00       	call   4098 <exit>
    printf(1, "rm . worked!\n");
    2f6a:	c7 44 24 04 6e 51 00 	movl   $0x516e,0x4(%esp)
    2f71:	00 
    2f72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f79:	e8 82 12 00 00       	call   4200 <printf>
    exit(0);
    2f7e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f85:	e8 0e 11 00 00       	call   4098 <exit>
    printf(1, "chdir dots failed\n");
    2f8a:	c7 44 24 04 5b 51 00 	movl   $0x515b,0x4(%esp)
    2f91:	00 
    2f92:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f99:	e8 62 12 00 00       	call   4200 <printf>
    exit(0);
    2f9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fa5:	e8 ee 10 00 00       	call   4098 <exit>
    2faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002fb0 <dirfile>:
{
    2fb0:	55                   	push   %ebp
  printf(1, "dir vs file\n");
    2fb1:	b8 e8 51 00 00       	mov    $0x51e8,%eax
{
    2fb6:	89 e5                	mov    %esp,%ebp
    2fb8:	53                   	push   %ebx
    2fb9:	83 ec 14             	sub    $0x14,%esp
  printf(1, "dir vs file\n");
    2fbc:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fc0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fc7:	e8 34 12 00 00       	call   4200 <printf>
  fd = open("dirfile", O_CREATE);
    2fcc:	ba 00 02 00 00       	mov    $0x200,%edx
    2fd1:	89 54 24 04          	mov    %edx,0x4(%esp)
    2fd5:	c7 04 24 f5 51 00 00 	movl   $0x51f5,(%esp)
    2fdc:	e8 f7 10 00 00       	call   40d8 <open>
  if(fd < 0){
    2fe1:	85 c0                	test   %eax,%eax
    2fe3:	0f 88 62 01 00 00    	js     314b <dirfile+0x19b>
  close(fd);
    2fe9:	89 04 24             	mov    %eax,(%esp)
    2fec:	e8 cf 10 00 00       	call   40c0 <close>
  if(chdir("dirfile") == 0){
    2ff1:	c7 04 24 f5 51 00 00 	movl   $0x51f5,(%esp)
    2ff8:	e8 0b 11 00 00       	call   4108 <chdir>
    2ffd:	85 c0                	test   %eax,%eax
    2fff:	0f 84 26 01 00 00    	je     312b <dirfile+0x17b>
  fd = open("dirfile/xx", 0);
    3005:	31 c0                	xor    %eax,%eax
    3007:	89 44 24 04          	mov    %eax,0x4(%esp)
    300b:	c7 04 24 2e 52 00 00 	movl   $0x522e,(%esp)
    3012:	e8 c1 10 00 00       	call   40d8 <open>
  if(fd >= 0){
    3017:	85 c0                	test   %eax,%eax
    3019:	0f 89 ec 00 00 00    	jns    310b <dirfile+0x15b>
  fd = open("dirfile/xx", O_CREATE);
    301f:	b8 00 02 00 00       	mov    $0x200,%eax
    3024:	89 44 24 04          	mov    %eax,0x4(%esp)
    3028:	c7 04 24 2e 52 00 00 	movl   $0x522e,(%esp)
    302f:	e8 a4 10 00 00       	call   40d8 <open>
  if(fd >= 0){
    3034:	85 c0                	test   %eax,%eax
    3036:	0f 89 cf 00 00 00    	jns    310b <dirfile+0x15b>
  if(mkdir("dirfile/xx") == 0){
    303c:	c7 04 24 2e 52 00 00 	movl   $0x522e,(%esp)
    3043:	e8 b8 10 00 00       	call   4100 <mkdir>
    3048:	85 c0                	test   %eax,%eax
    304a:	0f 84 bb 01 00 00    	je     320b <dirfile+0x25b>
  if(unlink("dirfile/xx") == 0){
    3050:	c7 04 24 2e 52 00 00 	movl   $0x522e,(%esp)
    3057:	e8 8c 10 00 00       	call   40e8 <unlink>
    305c:	85 c0                	test   %eax,%eax
    305e:	0f 84 87 01 00 00    	je     31eb <dirfile+0x23b>
  if(link("README", "dirfile/xx") == 0){
    3064:	b8 2e 52 00 00       	mov    $0x522e,%eax
    3069:	89 44 24 04          	mov    %eax,0x4(%esp)
    306d:	c7 04 24 92 52 00 00 	movl   $0x5292,(%esp)
    3074:	e8 7f 10 00 00       	call   40f8 <link>
    3079:	85 c0                	test   %eax,%eax
    307b:	0f 84 4a 01 00 00    	je     31cb <dirfile+0x21b>
  if(unlink("dirfile") != 0){
    3081:	c7 04 24 f5 51 00 00 	movl   $0x51f5,(%esp)
    3088:	e8 5b 10 00 00       	call   40e8 <unlink>
    308d:	85 c0                	test   %eax,%eax
    308f:	0f 85 16 01 00 00    	jne    31ab <dirfile+0x1fb>
  fd = open(".", O_RDWR);
    3095:	b8 02 00 00 00       	mov    $0x2,%eax
    309a:	89 44 24 04          	mov    %eax,0x4(%esp)
    309e:	c7 04 24 ee 4d 00 00 	movl   $0x4dee,(%esp)
    30a5:	e8 2e 10 00 00       	call   40d8 <open>
  if(fd >= 0){
    30aa:	85 c0                	test   %eax,%eax
    30ac:	0f 89 d9 00 00 00    	jns    318b <dirfile+0x1db>
  fd = open(".", 0);
    30b2:	31 d2                	xor    %edx,%edx
    30b4:	89 54 24 04          	mov    %edx,0x4(%esp)
    30b8:	c7 04 24 ee 4d 00 00 	movl   $0x4dee,(%esp)
    30bf:	e8 14 10 00 00       	call   40d8 <open>
  if(write(fd, "x", 1) > 0){
    30c4:	b9 01 00 00 00       	mov    $0x1,%ecx
    30c9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  fd = open(".", 0);
    30cd:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    30cf:	b8 d1 4e 00 00       	mov    $0x4ed1,%eax
    30d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    30d8:	89 1c 24             	mov    %ebx,(%esp)
    30db:	e8 d8 0f 00 00       	call   40b8 <write>
    30e0:	85 c0                	test   %eax,%eax
    30e2:	0f 8f 83 00 00 00    	jg     316b <dirfile+0x1bb>
  close(fd);
    30e8:	89 1c 24             	mov    %ebx,(%esp)
    30eb:	e8 d0 0f 00 00       	call   40c0 <close>
  printf(1, "dir vs file OK\n");
    30f0:	b8 c5 52 00 00       	mov    $0x52c5,%eax
    30f5:	89 44 24 04          	mov    %eax,0x4(%esp)
    30f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3100:	e8 fb 10 00 00       	call   4200 <printf>
}
    3105:	83 c4 14             	add    $0x14,%esp
    3108:	5b                   	pop    %ebx
    3109:	5d                   	pop    %ebp
    310a:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    310b:	c7 44 24 04 39 52 00 	movl   $0x5239,0x4(%esp)
    3112:	00 
    3113:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    311a:	e8 e1 10 00 00       	call   4200 <printf>
    exit(0);
    311f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3126:	e8 6d 0f 00 00       	call   4098 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    312b:	c7 44 24 04 14 52 00 	movl   $0x5214,0x4(%esp)
    3132:	00 
    3133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    313a:	e8 c1 10 00 00       	call   4200 <printf>
    exit(0);
    313f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3146:	e8 4d 0f 00 00       	call   4098 <exit>
    printf(1, "create dirfile failed\n");
    314b:	c7 44 24 04 fd 51 00 	movl   $0x51fd,0x4(%esp)
    3152:	00 
    3153:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    315a:	e8 a1 10 00 00       	call   4200 <printf>
    exit(0);
    315f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3166:	e8 2d 0f 00 00       	call   4098 <exit>
    printf(1, "write . succeeded!\n");
    316b:	c7 44 24 04 b1 52 00 	movl   $0x52b1,0x4(%esp)
    3172:	00 
    3173:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    317a:	e8 81 10 00 00       	call   4200 <printf>
    exit(0);
    317f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3186:	e8 0d 0f 00 00       	call   4098 <exit>
    printf(1, "open . for writing succeeded!\n");
    318b:	c7 44 24 04 a8 5a 00 	movl   $0x5aa8,0x4(%esp)
    3192:	00 
    3193:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    319a:	e8 61 10 00 00       	call   4200 <printf>
    exit(0);
    319f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31a6:	e8 ed 0e 00 00       	call   4098 <exit>
    printf(1, "unlink dirfile failed!\n");
    31ab:	c7 44 24 04 99 52 00 	movl   $0x5299,0x4(%esp)
    31b2:	00 
    31b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31ba:	e8 41 10 00 00       	call   4200 <printf>
    exit(0);
    31bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31c6:	e8 cd 0e 00 00       	call   4098 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    31cb:	c7 44 24 04 88 5a 00 	movl   $0x5a88,0x4(%esp)
    31d2:	00 
    31d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31da:	e8 21 10 00 00       	call   4200 <printf>
    exit(0);
    31df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31e6:	e8 ad 0e 00 00       	call   4098 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    31eb:	c7 44 24 04 74 52 00 	movl   $0x5274,0x4(%esp)
    31f2:	00 
    31f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31fa:	e8 01 10 00 00       	call   4200 <printf>
    exit(0);
    31ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3206:	e8 8d 0e 00 00       	call   4098 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    320b:	c7 44 24 04 57 52 00 	movl   $0x5257,0x4(%esp)
    3212:	00 
    3213:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    321a:	e8 e1 0f 00 00       	call   4200 <printf>
    exit(0);
    321f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3226:	e8 6d 0e 00 00       	call   4098 <exit>
    322b:	90                   	nop
    322c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003230 <iref>:
{
    3230:	55                   	push   %ebp
  printf(1, "empty file name\n");
    3231:	b8 d5 52 00 00       	mov    $0x52d5,%eax
{
    3236:	89 e5                	mov    %esp,%ebp
    3238:	53                   	push   %ebx
  printf(1, "empty file name\n");
    3239:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    323e:	83 ec 14             	sub    $0x14,%esp
  printf(1, "empty file name\n");
    3241:	89 44 24 04          	mov    %eax,0x4(%esp)
    3245:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    324c:	e8 af 0f 00 00       	call   4200 <printf>
    3251:	eb 0d                	jmp    3260 <iref+0x30>
    3253:	90                   	nop
    3254:	90                   	nop
    3255:	90                   	nop
    3256:	90                   	nop
    3257:	90                   	nop
    3258:	90                   	nop
    3259:	90                   	nop
    325a:	90                   	nop
    325b:	90                   	nop
    325c:	90                   	nop
    325d:	90                   	nop
    325e:	90                   	nop
    325f:	90                   	nop
    if(mkdir("irefd") != 0){
    3260:	c7 04 24 e6 52 00 00 	movl   $0x52e6,(%esp)
    3267:	e8 94 0e 00 00       	call   4100 <mkdir>
    326c:	85 c0                	test   %eax,%eax
    326e:	0f 85 b1 00 00 00    	jne    3325 <iref+0xf5>
    if(chdir("irefd") != 0){
    3274:	c7 04 24 e6 52 00 00 	movl   $0x52e6,(%esp)
    327b:	e8 88 0e 00 00       	call   4108 <chdir>
    3280:	85 c0                	test   %eax,%eax
    3282:	0f 85 be 00 00 00    	jne    3346 <iref+0x116>
    mkdir("");
    3288:	c7 04 24 9b 49 00 00 	movl   $0x499b,(%esp)
    328f:	e8 6c 0e 00 00       	call   4100 <mkdir>
    link("README", "");
    3294:	b9 9b 49 00 00       	mov    $0x499b,%ecx
    3299:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    329d:	c7 04 24 92 52 00 00 	movl   $0x5292,(%esp)
    32a4:	e8 4f 0e 00 00       	call   40f8 <link>
    fd = open("", O_CREATE);
    32a9:	b8 00 02 00 00       	mov    $0x200,%eax
    32ae:	89 44 24 04          	mov    %eax,0x4(%esp)
    32b2:	c7 04 24 9b 49 00 00 	movl   $0x499b,(%esp)
    32b9:	e8 1a 0e 00 00       	call   40d8 <open>
    if(fd >= 0)
    32be:	85 c0                	test   %eax,%eax
    32c0:	78 08                	js     32ca <iref+0x9a>
      close(fd);
    32c2:	89 04 24             	mov    %eax,(%esp)
    32c5:	e8 f6 0d 00 00       	call   40c0 <close>
    fd = open("xx", O_CREATE);
    32ca:	ba 00 02 00 00       	mov    $0x200,%edx
    32cf:	89 54 24 04          	mov    %edx,0x4(%esp)
    32d3:	c7 04 24 d0 4e 00 00 	movl   $0x4ed0,(%esp)
    32da:	e8 f9 0d 00 00       	call   40d8 <open>
    if(fd >= 0)
    32df:	85 c0                	test   %eax,%eax
    32e1:	78 08                	js     32eb <iref+0xbb>
      close(fd);
    32e3:	89 04 24             	mov    %eax,(%esp)
    32e6:	e8 d5 0d 00 00       	call   40c0 <close>
    unlink("xx");
    32eb:	c7 04 24 d0 4e 00 00 	movl   $0x4ed0,(%esp)
    32f2:	e8 f1 0d 00 00       	call   40e8 <unlink>
  for(i = 0; i < 50 + 1; i++){
    32f7:	4b                   	dec    %ebx
    32f8:	0f 85 62 ff ff ff    	jne    3260 <iref+0x30>
  chdir("/");
    32fe:	c7 04 24 c1 45 00 00 	movl   $0x45c1,(%esp)
    3305:	e8 fe 0d 00 00       	call   4108 <chdir>
  printf(1, "empty file name OK\n");
    330a:	b8 14 53 00 00       	mov    $0x5314,%eax
    330f:	89 44 24 04          	mov    %eax,0x4(%esp)
    3313:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    331a:	e8 e1 0e 00 00       	call   4200 <printf>
}
    331f:	83 c4 14             	add    $0x14,%esp
    3322:	5b                   	pop    %ebx
    3323:	5d                   	pop    %ebp
    3324:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    3325:	b8 ec 52 00 00       	mov    $0x52ec,%eax
    332a:	89 44 24 04          	mov    %eax,0x4(%esp)
    332e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3335:	e8 c6 0e 00 00       	call   4200 <printf>
      exit(0);
    333a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3341:	e8 52 0d 00 00       	call   4098 <exit>
      printf(1, "chdir irefd failed\n");
    3346:	b8 00 53 00 00       	mov    $0x5300,%eax
    334b:	89 44 24 04          	mov    %eax,0x4(%esp)
    334f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3356:	e8 a5 0e 00 00       	call   4200 <printf>
      exit(0);
    335b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3362:	e8 31 0d 00 00       	call   4098 <exit>
    3367:	89 f6                	mov    %esi,%esi
    3369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003370 <forktest>:
{
    3370:	55                   	push   %ebp
    3371:	89 e5                	mov    %esp,%ebp
    3373:	53                   	push   %ebx
  printf(1, "fork test\n");
    3374:	bb 28 53 00 00       	mov    $0x5328,%ebx
{
    3379:	83 ec 14             	sub    $0x14,%esp
  printf(1, "fork test\n");
    337c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(n=0; n<1000; n++){
    3380:	31 db                	xor    %ebx,%ebx
  printf(1, "fork test\n");
    3382:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3389:	e8 72 0e 00 00       	call   4200 <printf>
    338e:	eb 12                	jmp    33a2 <forktest+0x32>
    if(pid == 0)
    3390:	0f 84 a0 00 00 00    	je     3436 <forktest+0xc6>
  for(n=0; n<1000; n++){
    3396:	43                   	inc    %ebx
    3397:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    339d:	8d 76 00             	lea    0x0(%esi),%esi
    33a0:	74 5e                	je     3400 <forktest+0x90>
    pid = fork();
    33a2:	e8 e9 0c 00 00       	call   4090 <fork>
    if(pid < 0)
    33a7:	85 c0                	test   %eax,%eax
    33a9:	79 e5                	jns    3390 <forktest+0x20>
  for(; n > 0; n--){
    33ab:	85 db                	test   %ebx,%ebx
    33ad:	8d 76 00             	lea    0x0(%esi),%esi
    33b0:	74 21                	je     33d3 <forktest+0x63>
    33b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait(null) < 0){
    33c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33c7:	e8 d4 0c 00 00       	call   40a0 <wait>
    33cc:	85 c0                	test   %eax,%eax
    33ce:	78 51                	js     3421 <forktest+0xb1>
  for(; n > 0; n--){
    33d0:	4b                   	dec    %ebx
    33d1:	75 ed                	jne    33c0 <forktest+0x50>
  if(wait(null) != -1){
    33d3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33da:	e8 c1 0c 00 00       	call   40a0 <wait>
    33df:	40                   	inc    %eax
    33e0:	75 60                	jne    3442 <forktest+0xd2>
  printf(1, "fork test OK\n");
    33e2:	ba 5a 53 00 00       	mov    $0x535a,%edx
    33e7:	89 54 24 04          	mov    %edx,0x4(%esp)
    33eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33f2:	e8 09 0e 00 00       	call   4200 <printf>
}
    33f7:	83 c4 14             	add    $0x14,%esp
    33fa:	5b                   	pop    %ebx
    33fb:	5d                   	pop    %ebp
    33fc:	c3                   	ret    
    33fd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "fork claimed to work 1000 times!\n");
    3400:	b8 c8 5a 00 00       	mov    $0x5ac8,%eax
    3405:	89 44 24 04          	mov    %eax,0x4(%esp)
    3409:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3410:	e8 eb 0d 00 00       	call   4200 <printf>
    exit(0);
    3415:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    341c:	e8 77 0c 00 00       	call   4098 <exit>
      printf(1, "wait stopped early\n");
    3421:	b9 33 53 00 00       	mov    $0x5333,%ecx
    3426:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    342a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3431:	e8 ca 0d 00 00       	call   4200 <printf>
      exit(0);
    3436:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    343d:	e8 56 0c 00 00       	call   4098 <exit>
    printf(1, "wait got too many\n");
    3442:	c7 44 24 04 47 53 00 	movl   $0x5347,0x4(%esp)
    3449:	00 
    344a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3451:	e8 aa 0d 00 00       	call   4200 <printf>
    exit(0);
    3456:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    345d:	e8 36 0c 00 00       	call   4098 <exit>
    3462:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003470 <sbrktest>:
{
    3470:	55                   	push   %ebp
  printf(stdout, "sbrk test\n");
    3471:	b8 68 53 00 00       	mov    $0x5368,%eax
{
    3476:	89 e5                	mov    %esp,%ebp
    3478:	57                   	push   %edi
  for(i = 0; i < 5000; i++){
    3479:	31 ff                	xor    %edi,%edi
{
    347b:	56                   	push   %esi
    347c:	53                   	push   %ebx
    347d:	83 ec 7c             	sub    $0x7c,%esp
  printf(stdout, "sbrk test\n");
    3480:	89 44 24 04          	mov    %eax,0x4(%esp)
    3484:	a1 48 66 00 00       	mov    0x6648,%eax
    3489:	89 04 24             	mov    %eax,(%esp)
    348c:	e8 6f 0d 00 00       	call   4200 <printf>
  oldbrk = sbrk(0);
    3491:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3498:	e8 83 0c 00 00       	call   4120 <sbrk>
  a = sbrk(0);
    349d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    34a4:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    34a6:	e8 75 0c 00 00       	call   4120 <sbrk>
    34ab:	89 c6                	mov    %eax,%esi
    34ad:	eb 03                	jmp    34b2 <sbrktest+0x42>
    34af:	90                   	nop
    a = b + 1;
    34b0:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    34b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    34b9:	e8 62 0c 00 00       	call   4120 <sbrk>
    if(b != a){
    34be:	39 f0                	cmp    %esi,%eax
    34c0:	0f 85 6d 02 00 00    	jne    3733 <sbrktest+0x2c3>
  for(i = 0; i < 5000; i++){
    34c6:	47                   	inc    %edi
    34c7:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    *b = 1;
    34cd:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    34d0:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    34d3:	75 db                	jne    34b0 <sbrktest+0x40>
  pid = fork();
    34d5:	e8 b6 0b 00 00       	call   4090 <fork>
  if(pid < 0){
    34da:	85 c0                	test   %eax,%eax
  pid = fork();
    34dc:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    34de:	0f 88 94 03 00 00    	js     3878 <sbrktest+0x408>
  c = sbrk(1);
    34e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  if(c != a + 1){
    34eb:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    34ee:	e8 2d 0c 00 00       	call   4120 <sbrk>
  c = sbrk(1);
    34f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    34fa:	e8 21 0c 00 00       	call   4120 <sbrk>
  if(c != a + 1){
    34ff:	39 f0                	cmp    %esi,%eax
    3501:	0f 85 64 03 00 00    	jne    386b <sbrktest+0x3fb>
  if(pid == 0)
    3507:	85 ff                	test   %edi,%edi
    exit(0);
    3509:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid == 0)
    3510:	0f 84 9e 02 00 00    	je     37b4 <sbrktest+0x344>
  wait(null);
    3516:	e8 85 0b 00 00       	call   40a0 <wait>
  a = sbrk(0);
    351b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3522:	e8 f9 0b 00 00       	call   4120 <sbrk>
    3527:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    3529:	b8 00 00 40 06       	mov    $0x6400000,%eax
    352e:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    3530:	89 04 24             	mov    %eax,(%esp)
    3533:	e8 e8 0b 00 00       	call   4120 <sbrk>
  if (p != a) {
    3538:	39 c6                	cmp    %eax,%esi
    353a:	0f 85 ff 02 00 00    	jne    383f <sbrktest+0x3cf>
  *lastaddr = 99;
    3540:	b0 63                	mov    $0x63,%al
    3542:	a2 ff ff 3f 06       	mov    %al,0x63fffff
  a = sbrk(0);
    3547:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    354e:	e8 cd 0b 00 00       	call   4120 <sbrk>
  c = sbrk(-4096);
    3553:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    355a:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    355c:	e8 bf 0b 00 00       	call   4120 <sbrk>
  if(c == (char*)0xffffffff){
    3561:	40                   	inc    %eax
    3562:	0f 84 f6 02 00 00    	je     385e <sbrktest+0x3ee>
  c = sbrk(0);
    3568:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    356f:	e8 ac 0b 00 00       	call   4120 <sbrk>
  if(c != a - 4096){
    3574:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    357a:	39 d0                	cmp    %edx,%eax
    357c:	0f 85 ca 02 00 00    	jne    384c <sbrktest+0x3dc>
  a = sbrk(0);
    3582:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3589:	e8 92 0b 00 00       	call   4120 <sbrk>
  c = sbrk(4096);
    358e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    3595:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    3597:	e8 84 0b 00 00       	call   4120 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    359c:	39 c6                	cmp    %eax,%esi
  c = sbrk(4096);
    359e:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    35a0:	0f 85 87 02 00 00    	jne    382d <sbrktest+0x3bd>
    35a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35ad:	e8 6e 0b 00 00       	call   4120 <sbrk>
    35b2:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    35b8:	39 d0                	cmp    %edx,%eax
    35ba:	0f 85 6d 02 00 00    	jne    382d <sbrktest+0x3bd>
  if(*lastaddr == 99){
    35c0:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    35c7:	0f 84 53 02 00 00    	je     3820 <sbrktest+0x3b0>
  a = sbrk(0);
    35cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35d4:	e8 47 0b 00 00       	call   4120 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    35d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    35e0:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    35e2:	e8 39 0b 00 00       	call   4120 <sbrk>
    35e7:	89 d9                	mov    %ebx,%ecx
    35e9:	29 c1                	sub    %eax,%ecx
    35eb:	89 0c 24             	mov    %ecx,(%esp)
    35ee:	e8 2d 0b 00 00       	call   4120 <sbrk>
  if(c != a){
    35f3:	39 c6                	cmp    %eax,%esi
    35f5:	0f 85 fc 01 00 00    	jne    37f7 <sbrktest+0x387>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    35fb:	be 00 00 00 80       	mov    $0x80000000,%esi
    ppid = getpid();
    3600:	e8 13 0b 00 00       	call   4118 <getpid>
    3605:	89 c7                	mov    %eax,%edi
    pid = fork();
    3607:	e8 84 0a 00 00       	call   4090 <fork>
    if(pid < 0){
    360c:	85 c0                	test   %eax,%eax
    360e:	0f 88 d9 01 00 00    	js     37ed <sbrktest+0x37d>
    if(pid == 0){
    3614:	0f 84 9f 01 00 00    	je     37b9 <sbrktest+0x349>
    wait(null);
    361a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3621:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    wait(null);
    3627:	e8 74 0a 00 00       	call   40a0 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    362c:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    3632:	75 cc                	jne    3600 <sbrktest+0x190>
  if(pipe(fds) != 0){
    3634:	8d 45 b8             	lea    -0x48(%ebp),%eax
    3637:	89 04 24             	mov    %eax,(%esp)
    363a:	e8 69 0a 00 00       	call   40a8 <pipe>
    363f:	85 c0                	test   %eax,%eax
    3641:	0f 85 52 01 00 00    	jne    3799 <sbrktest+0x329>
    3647:	8d 7d c0             	lea    -0x40(%ebp),%edi
    364a:	89 fe                	mov    %edi,%esi
    364c:	eb 29                	jmp    3677 <sbrktest+0x207>
    if(pids[i] != -1)
    364e:	40                   	inc    %eax
    364f:	90                   	nop
    3650:	74 1b                	je     366d <sbrktest+0x1fd>
      read(fds[0], &scratch, 1);
    3652:	8d 45 b7             	lea    -0x49(%ebp),%eax
    3655:	ba 01 00 00 00       	mov    $0x1,%edx
    365a:	89 44 24 04          	mov    %eax,0x4(%esp)
    365e:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3661:	89 54 24 08          	mov    %edx,0x8(%esp)
    3665:	89 04 24             	mov    %eax,(%esp)
    3668:	e8 43 0a 00 00       	call   40b0 <read>
    366d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3670:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3673:	39 c6                	cmp    %eax,%esi
    3675:	74 57                	je     36ce <sbrktest+0x25e>
    if((pids[i] = fork()) == 0){
    3677:	e8 14 0a 00 00       	call   4090 <fork>
    367c:	85 c0                	test   %eax,%eax
    367e:	89 06                	mov    %eax,(%esi)
    3680:	75 cc                	jne    364e <sbrktest+0x1de>
      sbrk(BIG - (uint)sbrk(0));
    3682:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      write(fds[1], "x", 1);
    3689:	bb d1 4e 00 00       	mov    $0x4ed1,%ebx
      sbrk(BIG - (uint)sbrk(0));
    368e:	e8 8d 0a 00 00       	call   4120 <sbrk>
    3693:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3698:	29 c2                	sub    %eax,%edx
    369a:	89 14 24             	mov    %edx,(%esp)
    369d:	e8 7e 0a 00 00       	call   4120 <sbrk>
      write(fds[1], "x", 1);
    36a2:	8b 45 bc             	mov    -0x44(%ebp),%eax
    36a5:	b9 01 00 00 00       	mov    $0x1,%ecx
    36aa:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    36ae:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    36b2:	89 04 24             	mov    %eax,(%esp)
    36b5:	e8 fe 09 00 00       	call   40b8 <write>
    36ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for(;;) sleep(1000);
    36c0:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    36c7:	e8 5c 0a 00 00       	call   4128 <sleep>
    36cc:	eb f2                	jmp    36c0 <sbrktest+0x250>
  c = sbrk(4096);
    36ce:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    36d5:	e8 46 0a 00 00       	call   4120 <sbrk>
    36da:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    if(pids[i] == -1)
    36dd:	8b 07                	mov    (%edi),%eax
    36df:	83 f8 ff             	cmp    $0xffffffff,%eax
    36e2:	74 14                	je     36f8 <sbrktest+0x288>
    kill(pids[i]);
    36e4:	89 04 24             	mov    %eax,(%esp)
    36e7:	e8 dc 09 00 00       	call   40c8 <kill>
    wait(null);
    36ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36f3:	e8 a8 09 00 00       	call   40a0 <wait>
    36f8:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    36fb:	39 fe                	cmp    %edi,%esi
    36fd:	75 de                	jne    36dd <sbrktest+0x26d>
  if(c == (char*)0xffffffff){
    36ff:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    3703:	74 73                	je     3778 <sbrktest+0x308>
  if(sbrk(0) > oldbrk)
    3705:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    370c:	e8 0f 0a 00 00       	call   4120 <sbrk>
    3711:	39 d8                	cmp    %ebx,%eax
    3713:	77 4b                	ja     3760 <sbrktest+0x2f0>
  printf(stdout, "sbrk test OK\n");
    3715:	b8 10 54 00 00       	mov    $0x5410,%eax
    371a:	89 44 24 04          	mov    %eax,0x4(%esp)
    371e:	a1 48 66 00 00       	mov    0x6648,%eax
    3723:	89 04 24             	mov    %eax,(%esp)
    3726:	e8 d5 0a 00 00       	call   4200 <printf>
}
    372b:	83 c4 7c             	add    $0x7c,%esp
    372e:	5b                   	pop    %ebx
    372f:	5e                   	pop    %esi
    3730:	5f                   	pop    %edi
    3731:	5d                   	pop    %ebp
    3732:	c3                   	ret    
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3733:	89 44 24 10          	mov    %eax,0x10(%esp)
    3737:	a1 48 66 00 00       	mov    0x6648,%eax
    373c:	89 74 24 0c          	mov    %esi,0xc(%esp)
    3740:	89 7c 24 08          	mov    %edi,0x8(%esp)
    3744:	c7 44 24 04 73 53 00 	movl   $0x5373,0x4(%esp)
    374b:	00 
    374c:	89 04 24             	mov    %eax,(%esp)
    374f:	e8 ac 0a 00 00       	call   4200 <printf>
      exit(0);
    3754:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    375b:	e8 38 09 00 00       	call   4098 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    3760:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3767:	e8 b4 09 00 00       	call   4120 <sbrk>
    376c:	29 c3                	sub    %eax,%ebx
    376e:	89 1c 24             	mov    %ebx,(%esp)
    3771:	e8 aa 09 00 00       	call   4120 <sbrk>
    3776:	eb 9d                	jmp    3715 <sbrktest+0x2a5>
    printf(stdout, "failed sbrk leaked memory\n");
    3778:	c7 44 24 04 f5 53 00 	movl   $0x53f5,0x4(%esp)
    377f:	00 
    printf(stdout, "sbrk test failed post-fork\n");
    3780:	a1 48 66 00 00       	mov    0x6648,%eax
    3785:	89 04 24             	mov    %eax,(%esp)
    3788:	e8 73 0a 00 00       	call   4200 <printf>
    exit(0);
    378d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3794:	e8 ff 08 00 00       	call   4098 <exit>
    printf(1, "pipe() failed\n");
    3799:	c7 44 24 04 b1 48 00 	movl   $0x48b1,0x4(%esp)
    37a0:	00 
    37a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    37a8:	e8 53 0a 00 00       	call   4200 <printf>
    exit(0);
    37ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37b4:	e8 df 08 00 00       	call   4098 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    37b9:	0f be 06             	movsbl (%esi),%eax
    37bc:	89 74 24 08          	mov    %esi,0x8(%esp)
    37c0:	c7 44 24 04 dc 53 00 	movl   $0x53dc,0x4(%esp)
    37c7:	00 
    37c8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    37cc:	a1 48 66 00 00       	mov    0x6648,%eax
    37d1:	89 04 24             	mov    %eax,(%esp)
    37d4:	e8 27 0a 00 00       	call   4200 <printf>
      kill(ppid);
    37d9:	89 3c 24             	mov    %edi,(%esp)
    37dc:	e8 e7 08 00 00       	call   40c8 <kill>
      exit(0);
    37e1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37e8:	e8 ab 08 00 00       	call   4098 <exit>
      printf(stdout, "fork failed\n");
    37ed:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
    37f4:	00 
    37f5:	eb 89                	jmp    3780 <sbrktest+0x310>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    37f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
    37fb:	89 74 24 08          	mov    %esi,0x8(%esp)
    37ff:	c7 44 24 04 bc 5b 00 	movl   $0x5bbc,0x4(%esp)
    3806:	00 
    3807:	a1 48 66 00 00       	mov    0x6648,%eax
    380c:	89 04 24             	mov    %eax,(%esp)
    380f:	e8 ec 09 00 00       	call   4200 <printf>
    exit(0);
    3814:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    381b:	e8 78 08 00 00       	call   4098 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3820:	c7 44 24 04 8c 5b 00 	movl   $0x5b8c,0x4(%esp)
    3827:	00 
    3828:	e9 53 ff ff ff       	jmp    3780 <sbrktest+0x310>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    382d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
    3831:	89 74 24 08          	mov    %esi,0x8(%esp)
    3835:	c7 44 24 04 64 5b 00 	movl   $0x5b64,0x4(%esp)
    383c:	00 
    383d:	eb c8                	jmp    3807 <sbrktest+0x397>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    383f:	c7 44 24 04 ec 5a 00 	movl   $0x5aec,0x4(%esp)
    3846:	00 
    3847:	e9 34 ff ff ff       	jmp    3780 <sbrktest+0x310>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    384c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3850:	89 74 24 08          	mov    %esi,0x8(%esp)
    3854:	c7 44 24 04 2c 5b 00 	movl   $0x5b2c,0x4(%esp)
    385b:	00 
    385c:	eb a9                	jmp    3807 <sbrktest+0x397>
    printf(stdout, "sbrk could not deallocate\n");
    385e:	c7 44 24 04 c1 53 00 	movl   $0x53c1,0x4(%esp)
    3865:	00 
    3866:	e9 15 ff ff ff       	jmp    3780 <sbrktest+0x310>
    printf(stdout, "sbrk test failed post-fork\n");
    386b:	c7 44 24 04 a5 53 00 	movl   $0x53a5,0x4(%esp)
    3872:	00 
    3873:	e9 08 ff ff ff       	jmp    3780 <sbrktest+0x310>
    printf(stdout, "sbrk test fork failed\n");
    3878:	c7 44 24 04 8e 53 00 	movl   $0x538e,0x4(%esp)
    387f:	00 
    3880:	e9 fb fe ff ff       	jmp    3780 <sbrktest+0x310>
    3885:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003890 <validateint>:
{
    3890:	55                   	push   %ebp
    3891:	89 e5                	mov    %esp,%ebp
}
    3893:	5d                   	pop    %ebp
    3894:	c3                   	ret    
    3895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000038a0 <validatetest>:
{
    38a0:	55                   	push   %ebp
  printf(stdout, "validate test\n");
    38a1:	b9 1e 54 00 00       	mov    $0x541e,%ecx
{
    38a6:	89 e5                	mov    %esp,%ebp
    38a8:	56                   	push   %esi
    38a9:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    38aa:	31 db                	xor    %ebx,%ebx
{
    38ac:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "validate test\n");
    38af:	a1 48 66 00 00       	mov    0x6648,%eax
    38b4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    38b8:	89 04 24             	mov    %eax,(%esp)
    38bb:	e8 40 09 00 00       	call   4200 <printf>
    if((pid = fork()) == 0){
    38c0:	e8 cb 07 00 00       	call   4090 <fork>
      exit(0);
    38c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    if((pid = fork()) == 0){
    38cc:	85 c0                	test   %eax,%eax
    38ce:	89 c6                	mov    %eax,%esi
    38d0:	0f 84 80 00 00 00    	je     3956 <validatetest+0xb6>
    sleep(0);
    38d6:	e8 4d 08 00 00       	call   4128 <sleep>
    sleep(0);
    38db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38e2:	e8 41 08 00 00       	call   4128 <sleep>
    kill(pid);
    38e7:	89 34 24             	mov    %esi,(%esp)
    38ea:	e8 d9 07 00 00       	call   40c8 <kill>
    wait(null);
    38ef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38f6:	e8 a5 07 00 00       	call   40a0 <wait>
    if(link("nosuchfile", (char*)p) != -1){
    38fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    38ff:	c7 04 24 2d 54 00 00 	movl   $0x542d,(%esp)
    3906:	e8 ed 07 00 00       	call   40f8 <link>
    390b:	40                   	inc    %eax
    390c:	75 2b                	jne    3939 <validatetest+0x99>
  for(p = 0; p <= (uint)hi; p += 4096){
    390e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3914:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    391a:	75 a4                	jne    38c0 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    391c:	b8 51 54 00 00       	mov    $0x5451,%eax
    3921:	89 44 24 04          	mov    %eax,0x4(%esp)
    3925:	a1 48 66 00 00       	mov    0x6648,%eax
    392a:	89 04 24             	mov    %eax,(%esp)
    392d:	e8 ce 08 00 00       	call   4200 <printf>
}
    3932:	83 c4 10             	add    $0x10,%esp
    3935:	5b                   	pop    %ebx
    3936:	5e                   	pop    %esi
    3937:	5d                   	pop    %ebp
    3938:	c3                   	ret    
      printf(stdout, "link should not succeed\n");
    3939:	a1 48 66 00 00       	mov    0x6648,%eax
    393e:	ba 38 54 00 00       	mov    $0x5438,%edx
    3943:	89 54 24 04          	mov    %edx,0x4(%esp)
    3947:	89 04 24             	mov    %eax,(%esp)
    394a:	e8 b1 08 00 00       	call   4200 <printf>
      exit(0);
    394f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3956:	e8 3d 07 00 00       	call   4098 <exit>
    395b:	90                   	nop
    395c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003960 <bsstest>:
{
    3960:	55                   	push   %ebp
  printf(stdout, "bss test\n");
    3961:	b9 5e 54 00 00       	mov    $0x545e,%ecx
{
    3966:	89 e5                	mov    %esp,%ebp
    3968:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "bss test\n");
    396b:	a1 48 66 00 00       	mov    0x6648,%eax
    3970:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    3974:	89 04 24             	mov    %eax,(%esp)
    3977:	e8 84 08 00 00       	call   4200 <printf>
    if(uninit[i] != '\0'){
    397c:	80 3d 00 67 00 00 00 	cmpb   $0x0,0x6700
    3983:	75 34                	jne    39b9 <bsstest+0x59>
  for(i = 0; i < sizeof(uninit); i++){
    3985:	b8 01 00 00 00       	mov    $0x1,%eax
    398a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(uninit[i] != '\0'){
    3990:	80 b8 00 67 00 00 00 	cmpb   $0x0,0x6700(%eax)
    3997:	75 20                	jne    39b9 <bsstest+0x59>
  for(i = 0; i < sizeof(uninit); i++){
    3999:	40                   	inc    %eax
    399a:	3d 10 27 00 00       	cmp    $0x2710,%eax
    399f:	75 ef                	jne    3990 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    39a1:	b8 79 54 00 00       	mov    $0x5479,%eax
    39a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    39aa:	a1 48 66 00 00       	mov    0x6648,%eax
    39af:	89 04 24             	mov    %eax,(%esp)
    39b2:	e8 49 08 00 00       	call   4200 <printf>
}
    39b7:	c9                   	leave  
    39b8:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    39b9:	a1 48 66 00 00       	mov    0x6648,%eax
    39be:	ba 68 54 00 00       	mov    $0x5468,%edx
    39c3:	89 54 24 04          	mov    %edx,0x4(%esp)
    39c7:	89 04 24             	mov    %eax,(%esp)
    39ca:	e8 31 08 00 00       	call   4200 <printf>
      exit(0);
    39cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    39d6:	e8 bd 06 00 00       	call   4098 <exit>
    39db:	90                   	nop
    39dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000039e0 <bigargtest>:
{
    39e0:	55                   	push   %ebp
    39e1:	89 e5                	mov    %esp,%ebp
    39e3:	83 ec 18             	sub    $0x18,%esp
  unlink("bigarg-ok");
    39e6:	c7 04 24 86 54 00 00 	movl   $0x5486,(%esp)
    39ed:	e8 f6 06 00 00       	call   40e8 <unlink>
  pid = fork();
    39f2:	e8 99 06 00 00       	call   4090 <fork>
  if(pid == 0){
    39f7:	85 c0                	test   %eax,%eax
    39f9:	74 47                	je     3a42 <bigargtest+0x62>
    39fb:	90                   	nop
    39fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(pid < 0){
    3a00:	0f 88 eb 00 00 00    	js     3af1 <bigargtest+0x111>
  wait(null);
    3a06:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3a0d:	e8 8e 06 00 00       	call   40a0 <wait>
  fd = open("bigarg-ok", 0);
    3a12:	31 c0                	xor    %eax,%eax
    3a14:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a18:	c7 04 24 86 54 00 00 	movl   $0x5486,(%esp)
    3a1f:	e8 b4 06 00 00       	call   40d8 <open>
  if(fd < 0){
    3a24:	85 c0                	test   %eax,%eax
    3a26:	0f 88 a4 00 00 00    	js     3ad0 <bigargtest+0xf0>
  close(fd);
    3a2c:	89 04 24             	mov    %eax,(%esp)
    3a2f:	e8 8c 06 00 00       	call   40c0 <close>
  unlink("bigarg-ok");
    3a34:	c7 04 24 86 54 00 00 	movl   $0x5486,(%esp)
    3a3b:	e8 a8 06 00 00       	call   40e8 <unlink>
}
    3a40:	c9                   	leave  
    3a41:	c3                   	ret    
    3a42:	b8 60 66 00 00       	mov    $0x6660,%eax
    3a47:	89 f6                	mov    %esi,%esi
    3a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3a50:	c7 00 e0 5b 00 00    	movl   $0x5be0,(%eax)
    3a56:	83 c0 04             	add    $0x4,%eax
    for(i = 0; i < MAXARG-1; i++)
    3a59:	3d dc 66 00 00       	cmp    $0x66dc,%eax
    3a5e:	75 f0                	jne    3a50 <bigargtest+0x70>
    printf(stdout, "bigarg test\n");
    3a60:	a1 48 66 00 00       	mov    0x6648,%eax
    3a65:	c7 44 24 04 90 54 00 	movl   $0x5490,0x4(%esp)
    3a6c:	00 
    args[MAXARG-1] = 0;
    3a6d:	c7 05 dc 66 00 00 00 	movl   $0x0,0x66dc
    3a74:	00 00 00 
    printf(stdout, "bigarg test\n");
    3a77:	89 04 24             	mov    %eax,(%esp)
    3a7a:	e8 81 07 00 00       	call   4200 <printf>
    exec("echo", args);
    3a7f:	c7 44 24 04 60 66 00 	movl   $0x6660,0x4(%esp)
    3a86:	00 
    3a87:	c7 04 24 5d 46 00 00 	movl   $0x465d,(%esp)
    3a8e:	e8 3d 06 00 00       	call   40d0 <exec>
    printf(stdout, "bigarg test ok\n");
    3a93:	a1 48 66 00 00       	mov    0x6648,%eax
    3a98:	c7 44 24 04 9d 54 00 	movl   $0x549d,0x4(%esp)
    3a9f:	00 
    3aa0:	89 04 24             	mov    %eax,(%esp)
    3aa3:	e8 58 07 00 00       	call   4200 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3aa8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3aaf:	00 
    3ab0:	c7 04 24 86 54 00 00 	movl   $0x5486,(%esp)
    3ab7:	e8 1c 06 00 00       	call   40d8 <open>
    close(fd);
    3abc:	89 04 24             	mov    %eax,(%esp)
    3abf:	e8 fc 05 00 00       	call   40c0 <close>
    exit(0);
    3ac4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3acb:	e8 c8 05 00 00       	call   4098 <exit>
    printf(stdout, "bigarg test failed!\n");
    3ad0:	c7 44 24 04 c6 54 00 	movl   $0x54c6,0x4(%esp)
    3ad7:	00 
    3ad8:	a1 48 66 00 00       	mov    0x6648,%eax
    3add:	89 04 24             	mov    %eax,(%esp)
    3ae0:	e8 1b 07 00 00       	call   4200 <printf>
    exit(0);
    3ae5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3aec:	e8 a7 05 00 00       	call   4098 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3af1:	c7 44 24 04 ad 54 00 	movl   $0x54ad,0x4(%esp)
    3af8:	00 
    3af9:	eb dd                	jmp    3ad8 <bigargtest+0xf8>
    3afb:	90                   	nop
    3afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003b00 <fsfull>:
{
    3b00:	55                   	push   %ebp
  printf(1, "fsfull test\n");
    3b01:	b8 db 54 00 00       	mov    $0x54db,%eax
{
    3b06:	89 e5                	mov    %esp,%ebp
    3b08:	57                   	push   %edi
    3b09:	56                   	push   %esi
    3b0a:	53                   	push   %ebx
  for(nfiles = 0; ; nfiles++){
    3b0b:	31 db                	xor    %ebx,%ebx
{
    3b0d:	83 ec 5c             	sub    $0x5c,%esp
  printf(1, "fsfull test\n");
    3b10:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b1b:	e8 e0 06 00 00       	call   4200 <printf>
    name[1] = '0' + nfiles / 1000;
    3b20:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3b25:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    name[1] = '0' + nfiles / 1000;
    3b2a:	f7 e3                	mul    %ebx
    printf(1, "writing %s\n", name);
    3b2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    name[0] = 'f';
    3b33:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3b37:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3b3b:	c1 ea 06             	shr    $0x6,%edx
    3b3e:	88 d0                	mov    %dl,%al
    name[2] = '0' + (nfiles % 1000) / 100;
    3b40:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    3b46:	04 30                	add    $0x30,%al
    3b48:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3b4b:	89 d8                	mov    %ebx,%eax
    3b4d:	29 d0                	sub    %edx,%eax
    3b4f:	89 c2                	mov    %eax,%edx
    3b51:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3b56:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    3b58:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3b5d:	c1 ea 05             	shr    $0x5,%edx
    3b60:	80 c2 30             	add    $0x30,%dl
    3b63:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3b66:	f7 e3                	mul    %ebx
    3b68:	c1 ea 05             	shr    $0x5,%edx
    3b6b:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3b6e:	89 da                	mov    %ebx,%edx
    3b70:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3b73:	c1 e0 02             	shl    $0x2,%eax
    3b76:	29 c2                	sub    %eax,%edx
    3b78:	89 d0                	mov    %edx,%eax
    3b7a:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3b7c:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3b7e:	c1 ea 03             	shr    $0x3,%edx
    3b81:	80 c2 30             	add    $0x30,%dl
    3b84:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3b87:	f7 e1                	mul    %ecx
    3b89:	89 d9                	mov    %ebx,%ecx
    3b8b:	c1 ea 03             	shr    $0x3,%edx
    3b8e:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3b91:	01 c0                	add    %eax,%eax
    3b93:	29 c1                	sub    %eax,%ecx
    3b95:	89 c8                	mov    %ecx,%eax
    3b97:	04 30                	add    $0x30,%al
    3b99:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3b9c:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3b9f:	89 44 24 08          	mov    %eax,0x8(%esp)
    3ba3:	b8 e8 54 00 00       	mov    $0x54e8,%eax
    3ba8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bac:	e8 4f 06 00 00       	call   4200 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3bb1:	b8 02 02 00 00       	mov    $0x202,%eax
    3bb6:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bba:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3bbd:	89 04 24             	mov    %eax,(%esp)
    3bc0:	e8 13 05 00 00       	call   40d8 <open>
    if(fd < 0){
    3bc5:	85 c0                	test   %eax,%eax
    int fd = open(name, O_CREATE|O_RDWR);
    3bc7:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3bc9:	78 55                	js     3c20 <fsfull+0x120>
    int total = 0;
    3bcb:	31 f6                	xor    %esi,%esi
    3bcd:	eb 03                	jmp    3bd2 <fsfull+0xd2>
    3bcf:	90                   	nop
      total += cc;
    3bd0:	01 c6                	add    %eax,%esi
      int cc = write(fd, buf, 512);
    3bd2:	b9 00 02 00 00       	mov    $0x200,%ecx
    3bd7:	b8 20 8e 00 00       	mov    $0x8e20,%eax
    3bdc:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    3be0:	89 44 24 04          	mov    %eax,0x4(%esp)
    3be4:	89 3c 24             	mov    %edi,(%esp)
    3be7:	e8 cc 04 00 00       	call   40b8 <write>
      if(cc < 512)
    3bec:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3bf1:	7f dd                	jg     3bd0 <fsfull+0xd0>
    printf(1, "wrote %d bytes\n", total);
    3bf3:	ba 04 55 00 00       	mov    $0x5504,%edx
    3bf8:	89 54 24 04          	mov    %edx,0x4(%esp)
    3bfc:	89 74 24 08          	mov    %esi,0x8(%esp)
    3c00:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c07:	e8 f4 05 00 00       	call   4200 <printf>
    close(fd);
    3c0c:	89 3c 24             	mov    %edi,(%esp)
    3c0f:	e8 ac 04 00 00       	call   40c0 <close>
    if(total == 0)
    3c14:	85 f6                	test   %esi,%esi
    3c16:	74 24                	je     3c3c <fsfull+0x13c>
  for(nfiles = 0; ; nfiles++){
    3c18:	43                   	inc    %ebx
    3c19:	e9 02 ff ff ff       	jmp    3b20 <fsfull+0x20>
    3c1e:	66 90                	xchg   %ax,%ax
      printf(1, "open %s failed\n", name);
    3c20:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3c23:	89 44 24 08          	mov    %eax,0x8(%esp)
    3c27:	b8 f4 54 00 00       	mov    $0x54f4,%eax
    3c2c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c37:	e8 c4 05 00 00       	call   4200 <printf>
    name[1] = '0' + nfiles / 1000;
    3c3c:	be d3 4d 62 10       	mov    $0x10624dd3,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    3c41:	bf 1f 85 eb 51       	mov    $0x51eb851f,%edi
    3c46:	8d 76 00             	lea    0x0(%esi),%esi
    3c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    name[1] = '0' + nfiles / 1000;
    3c50:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3c52:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    name[1] = '0' + nfiles / 1000;
    3c57:	f7 e6                	mul    %esi
    name[0] = 'f';
    3c59:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3c5d:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3c61:	c1 ea 06             	shr    $0x6,%edx
    3c64:	88 d0                	mov    %dl,%al
    name[2] = '0' + (nfiles % 1000) / 100;
    3c66:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    3c6c:	04 30                	add    $0x30,%al
    3c6e:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3c71:	89 d8                	mov    %ebx,%eax
    3c73:	29 d0                	sub    %edx,%eax
    3c75:	f7 e7                	mul    %edi
    name[3] = '0' + (nfiles % 100) / 10;
    3c77:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3c79:	c1 ea 05             	shr    $0x5,%edx
    3c7c:	80 c2 30             	add    $0x30,%dl
    3c7f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3c82:	f7 e7                	mul    %edi
    3c84:	c1 ea 05             	shr    $0x5,%edx
    3c87:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3c8a:	89 da                	mov    %ebx,%edx
    3c8c:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3c8f:	c1 e0 02             	shl    $0x2,%eax
    3c92:	29 c2                	sub    %eax,%edx
    3c94:	89 d0                	mov    %edx,%eax
    3c96:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3c98:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3c9a:	c1 ea 03             	shr    $0x3,%edx
    3c9d:	80 c2 30             	add    $0x30,%dl
    3ca0:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3ca3:	f7 e1                	mul    %ecx
    3ca5:	89 d9                	mov    %ebx,%ecx
    nfiles--;
    3ca7:	4b                   	dec    %ebx
    name[4] = '0' + (nfiles % 10);
    3ca8:	c1 ea 03             	shr    $0x3,%edx
    3cab:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3cae:	01 c0                	add    %eax,%eax
    3cb0:	29 c1                	sub    %eax,%ecx
    3cb2:	89 c8                	mov    %ecx,%eax
    3cb4:	04 30                	add    $0x30,%al
    3cb6:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3cb9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3cbc:	89 04 24             	mov    %eax,(%esp)
    3cbf:	e8 24 04 00 00       	call   40e8 <unlink>
  while(nfiles >= 0){
    3cc4:	83 fb ff             	cmp    $0xffffffff,%ebx
    3cc7:	75 87                	jne    3c50 <fsfull+0x150>
  printf(1, "fsfull test finished\n");
    3cc9:	b8 14 55 00 00       	mov    $0x5514,%eax
    3cce:	89 44 24 04          	mov    %eax,0x4(%esp)
    3cd2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3cd9:	e8 22 05 00 00       	call   4200 <printf>
}
    3cde:	83 c4 5c             	add    $0x5c,%esp
    3ce1:	5b                   	pop    %ebx
    3ce2:	5e                   	pop    %esi
    3ce3:	5f                   	pop    %edi
    3ce4:	5d                   	pop    %ebp
    3ce5:	c3                   	ret    
    3ce6:	8d 76 00             	lea    0x0(%esi),%esi
    3ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003cf0 <uio>:
{
    3cf0:	55                   	push   %ebp
  printf(1, "uio test\n");
    3cf1:	ba 2a 55 00 00       	mov    $0x552a,%edx
{
    3cf6:	89 e5                	mov    %esp,%ebp
    3cf8:	83 ec 18             	sub    $0x18,%esp
  printf(1, "uio test\n");
    3cfb:	89 54 24 04          	mov    %edx,0x4(%esp)
    3cff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d06:	e8 f5 04 00 00       	call   4200 <printf>
  pid = fork();
    3d0b:	e8 80 03 00 00       	call   4090 <fork>
  if(pid == 0){
    3d10:	85 c0                	test   %eax,%eax
    3d12:	74 25                	je     3d39 <uio+0x49>
  } else if(pid < 0){
    3d14:	78 53                	js     3d69 <uio+0x79>
  wait(null);
    3d16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d1d:	e8 7e 03 00 00       	call   40a0 <wait>
  printf(1, "uio test done\n");
    3d22:	b8 34 55 00 00       	mov    $0x5534,%eax
    3d27:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d32:	e8 c9 04 00 00       	call   4200 <printf>
}
    3d37:	c9                   	leave  
    3d38:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3d39:	b0 09                	mov    $0x9,%al
    3d3b:	ba 70 00 00 00       	mov    $0x70,%edx
    3d40:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3d41:	b8 71 00 00 00       	mov    $0x71,%eax
    3d46:	89 c2                	mov    %eax,%edx
    3d48:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3d49:	c7 44 24 04 c0 5c 00 	movl   $0x5cc0,0x4(%esp)
    3d50:	00 
    3d51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d58:	e8 a3 04 00 00       	call   4200 <printf>
    exit(0);
    3d5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d64:	e8 2f 03 00 00       	call   4098 <exit>
    printf (1, "fork failed\n");
    3d69:	c7 44 24 04 b9 54 00 	movl   $0x54b9,0x4(%esp)
    3d70:	00 
    3d71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d78:	e8 83 04 00 00       	call   4200 <printf>
    exit(0);
    3d7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d84:	e8 0f 03 00 00       	call   4098 <exit>
    3d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003d90 <argptest>:
{
    3d90:	55                   	push   %ebp
    3d91:	89 e5                	mov    %esp,%ebp
    3d93:	53                   	push   %ebx
  fd = open("init", O_RDONLY);
    3d94:	31 db                	xor    %ebx,%ebx
{
    3d96:	83 ec 14             	sub    $0x14,%esp
  fd = open("init", O_RDONLY);
    3d99:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    3d9d:	c7 04 24 43 55 00 00 	movl   $0x5543,(%esp)
    3da4:	e8 2f 03 00 00       	call   40d8 <open>
  if (fd < 0) {
    3da9:	85 c0                	test   %eax,%eax
    3dab:	78 47                	js     3df4 <argptest+0x64>
  read(fd, sbrk(0) - 1, -1);
    3dad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3db4:	89 c3                	mov    %eax,%ebx
    3db6:	e8 65 03 00 00       	call   4120 <sbrk>
    3dbb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    3dc0:	89 54 24 08          	mov    %edx,0x8(%esp)
    3dc4:	89 1c 24             	mov    %ebx,(%esp)
    3dc7:	48                   	dec    %eax
    3dc8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3dcc:	e8 df 02 00 00       	call   40b0 <read>
  close(fd);
    3dd1:	89 1c 24             	mov    %ebx,(%esp)
    3dd4:	e8 e7 02 00 00       	call   40c0 <close>
  printf(1, "arg test passed\n");
    3dd9:	b9 55 55 00 00       	mov    $0x5555,%ecx
    3dde:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    3de2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3de9:	e8 12 04 00 00       	call   4200 <printf>
}
    3dee:	83 c4 14             	add    $0x14,%esp
    3df1:	5b                   	pop    %ebx
    3df2:	5d                   	pop    %ebp
    3df3:	c3                   	ret    
    printf(2, "open failed\n");
    3df4:	c7 44 24 04 48 55 00 	movl   $0x5548,0x4(%esp)
    3dfb:	00 
    3dfc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    3e03:	e8 f8 03 00 00       	call   4200 <printf>
    exit(0);
    3e08:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e0f:	e8 84 02 00 00       	call   4098 <exit>
    3e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003e20 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3e20:	69 05 44 66 00 00 0d 	imul   $0x19660d,0x6644,%eax
    3e27:	66 19 00 
{
    3e2a:	55                   	push   %ebp
    3e2b:	89 e5                	mov    %esp,%ebp
}
    3e2d:	5d                   	pop    %ebp
  randstate = randstate * 1664525 + 1013904223;
    3e2e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3e33:	a3 44 66 00 00       	mov    %eax,0x6644
}
    3e38:	c3                   	ret    
    3e39:	66 90                	xchg   %ax,%ax
    3e3b:	66 90                	xchg   %ax,%ax
    3e3d:	66 90                	xchg   %ax,%ax
    3e3f:	90                   	nop

00003e40 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
    3e40:	55                   	push   %ebp
    3e41:	89 e5                	mov    %esp,%ebp
    3e43:	8b 45 08             	mov    0x8(%ebp),%eax
    3e46:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    3e49:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
    3e4a:	89 c2                	mov    %eax,%edx
    3e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e50:	41                   	inc    %ecx
    3e51:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3e55:	42                   	inc    %edx
    3e56:	84 db                	test   %bl,%bl
    3e58:	88 5a ff             	mov    %bl,-0x1(%edx)
    3e5b:	75 f3                	jne    3e50 <strcpy+0x10>
    return os;
}
    3e5d:	5b                   	pop    %ebx
    3e5e:	5d                   	pop    %ebp
    3e5f:	c3                   	ret    

00003e60 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    3e60:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
    3e61:	31 d2                	xor    %edx,%edx
{
    3e63:	89 e5                	mov    %esp,%ebp
    3e65:	56                   	push   %esi
    3e66:	8b 45 08             	mov    0x8(%ebp),%eax
    3e69:	53                   	push   %ebx
    3e6a:	8b 75 0c             	mov    0xc(%ebp),%esi
    3e6d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
    3e70:	eb 12                	jmp    3e84 <strncpy+0x24>
    3e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3e78:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    3e7c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3e7f:	42                   	inc    %edx
    3e80:	84 c9                	test   %cl,%cl
    3e82:	74 08                	je     3e8c <strncpy+0x2c>
    3e84:	89 d9                	mov    %ebx,%ecx
    3e86:	29 d1                	sub    %edx,%ecx
    3e88:	85 c9                	test   %ecx,%ecx
    3e8a:	7f ec                	jg     3e78 <strncpy+0x18>
    return os;
}
    3e8c:	5b                   	pop    %ebx
    3e8d:	5e                   	pop    %esi
    3e8e:	5d                   	pop    %ebp
    3e8f:	c3                   	ret    

00003e90 <strcmp>:

int
strcmp(const char *p, const char *q) {
    3e90:	55                   	push   %ebp
    3e91:	89 e5                	mov    %esp,%ebp
    3e93:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3e96:	53                   	push   %ebx
    3e97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
    3e9a:	0f b6 01             	movzbl (%ecx),%eax
    3e9d:	0f b6 13             	movzbl (%ebx),%edx
    3ea0:	84 c0                	test   %al,%al
    3ea2:	75 18                	jne    3ebc <strcmp+0x2c>
    3ea4:	eb 22                	jmp    3ec8 <strcmp+0x38>
    3ea6:	8d 76 00             	lea    0x0(%esi),%esi
    3ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
    3eb0:	41                   	inc    %ecx
    while (*p && *p == *q)
    3eb1:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
    3eb4:	43                   	inc    %ebx
    3eb5:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
    3eb8:	84 c0                	test   %al,%al
    3eba:	74 0c                	je     3ec8 <strcmp+0x38>
    3ebc:	38 d0                	cmp    %dl,%al
    3ebe:	74 f0                	je     3eb0 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
    3ec0:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
    3ec1:	29 d0                	sub    %edx,%eax
}
    3ec3:	5d                   	pop    %ebp
    3ec4:	c3                   	ret    
    3ec5:	8d 76 00             	lea    0x0(%esi),%esi
    3ec8:	5b                   	pop    %ebx
    3ec9:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
    3ecb:	29 d0                	sub    %edx,%eax
}
    3ecd:	5d                   	pop    %ebp
    3ece:	c3                   	ret    
    3ecf:	90                   	nop

00003ed0 <strlen>:

uint
strlen(const char *s) {
    3ed0:	55                   	push   %ebp
    3ed1:	89 e5                	mov    %esp,%ebp
    3ed3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
    3ed6:	80 39 00             	cmpb   $0x0,(%ecx)
    3ed9:	74 15                	je     3ef0 <strlen+0x20>
    3edb:	31 d2                	xor    %edx,%edx
    3edd:	8d 76 00             	lea    0x0(%esi),%esi
    3ee0:	42                   	inc    %edx
    3ee1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3ee5:	89 d0                	mov    %edx,%eax
    3ee7:	75 f7                	jne    3ee0 <strlen+0x10>
    return n;
}
    3ee9:	5d                   	pop    %ebp
    3eea:	c3                   	ret    
    3eeb:	90                   	nop
    3eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
    3ef0:	31 c0                	xor    %eax,%eax
}
    3ef2:	5d                   	pop    %ebp
    3ef3:	c3                   	ret    
    3ef4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3efa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003f00 <memset>:

void *
memset(void *dst, int c, uint n) {
    3f00:	55                   	push   %ebp
    3f01:	89 e5                	mov    %esp,%ebp
    3f03:	8b 55 08             	mov    0x8(%ebp),%edx
    3f06:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3f07:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f0d:	89 d7                	mov    %edx,%edi
    3f0f:	fc                   	cld    
    3f10:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
    3f12:	5f                   	pop    %edi
    3f13:	89 d0                	mov    %edx,%eax
    3f15:	5d                   	pop    %ebp
    3f16:	c3                   	ret    
    3f17:	89 f6                	mov    %esi,%esi
    3f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003f20 <strchr>:

char *
strchr(const char *s, char c) {
    3f20:	55                   	push   %ebp
    3f21:	89 e5                	mov    %esp,%ebp
    3f23:	8b 45 08             	mov    0x8(%ebp),%eax
    3f26:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
    3f2a:	0f b6 10             	movzbl (%eax),%edx
    3f2d:	84 d2                	test   %dl,%dl
    3f2f:	74 1b                	je     3f4c <strchr+0x2c>
        if (*s == c)
    3f31:	38 d1                	cmp    %dl,%cl
    3f33:	75 0f                	jne    3f44 <strchr+0x24>
    3f35:	eb 17                	jmp    3f4e <strchr+0x2e>
    3f37:	89 f6                	mov    %esi,%esi
    3f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3f40:	38 ca                	cmp    %cl,%dl
    3f42:	74 0a                	je     3f4e <strchr+0x2e>
    for (; *s; s++)
    3f44:	40                   	inc    %eax
    3f45:	0f b6 10             	movzbl (%eax),%edx
    3f48:	84 d2                	test   %dl,%dl
    3f4a:	75 f4                	jne    3f40 <strchr+0x20>
            return (char *) s;
    return 0;
    3f4c:	31 c0                	xor    %eax,%eax
}
    3f4e:	5d                   	pop    %ebp
    3f4f:	c3                   	ret    

00003f50 <gets>:

char *
gets(char *buf, int max) {
    3f50:	55                   	push   %ebp
    3f51:	89 e5                	mov    %esp,%ebp
    3f53:	57                   	push   %edi
    3f54:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
    3f55:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
    3f57:	53                   	push   %ebx
    3f58:	83 ec 3c             	sub    $0x3c,%esp
    3f5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
    3f5e:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
    3f61:	eb 32                	jmp    3f95 <gets+0x45>
    3f63:	90                   	nop
    3f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
    3f68:	ba 01 00 00 00       	mov    $0x1,%edx
    3f6d:	89 54 24 08          	mov    %edx,0x8(%esp)
    3f71:	89 7c 24 04          	mov    %edi,0x4(%esp)
    3f75:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f7c:	e8 2f 01 00 00       	call   40b0 <read>
        if (cc < 1)
    3f81:	85 c0                	test   %eax,%eax
    3f83:	7e 19                	jle    3f9e <gets+0x4e>
            break;
        buf[i++] = c;
    3f85:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3f89:	43                   	inc    %ebx
    3f8a:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
    3f8d:	3c 0a                	cmp    $0xa,%al
    3f8f:	74 1f                	je     3fb0 <gets+0x60>
    3f91:	3c 0d                	cmp    $0xd,%al
    3f93:	74 1b                	je     3fb0 <gets+0x60>
    for (i = 0; i + 1 < max;) {
    3f95:	46                   	inc    %esi
    3f96:	3b 75 0c             	cmp    0xc(%ebp),%esi
    3f99:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3f9c:	7c ca                	jl     3f68 <gets+0x18>
            break;
    }
    buf[i] = '\0';
    3f9e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3fa1:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
    3fa4:	8b 45 08             	mov    0x8(%ebp),%eax
    3fa7:	83 c4 3c             	add    $0x3c,%esp
    3faa:	5b                   	pop    %ebx
    3fab:	5e                   	pop    %esi
    3fac:	5f                   	pop    %edi
    3fad:	5d                   	pop    %ebp
    3fae:	c3                   	ret    
    3faf:	90                   	nop
    3fb0:	8b 45 08             	mov    0x8(%ebp),%eax
    3fb3:	01 c6                	add    %eax,%esi
    3fb5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3fb8:	eb e4                	jmp    3f9e <gets+0x4e>
    3fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003fc0 <stat>:

int
stat(const char *n, struct stat *st) {
    3fc0:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    3fc1:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
    3fc3:	89 e5                	mov    %esp,%ebp
    3fc5:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
    3fc8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3fcc:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
    3fcf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    3fd2:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
    3fd5:	89 04 24             	mov    %eax,(%esp)
    3fd8:	e8 fb 00 00 00       	call   40d8 <open>
    if (fd < 0)
    3fdd:	85 c0                	test   %eax,%eax
    3fdf:	78 2f                	js     4010 <stat+0x50>
    3fe1:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
    3fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fe6:	89 1c 24             	mov    %ebx,(%esp)
    3fe9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3fed:	e8 fe 00 00 00       	call   40f0 <fstat>
    close(fd);
    3ff2:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
    3ff5:	89 c6                	mov    %eax,%esi
    close(fd);
    3ff7:	e8 c4 00 00 00       	call   40c0 <close>
    return r;
}
    3ffc:	89 f0                	mov    %esi,%eax
    3ffe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    4001:	8b 75 fc             	mov    -0x4(%ebp),%esi
    4004:	89 ec                	mov    %ebp,%esp
    4006:	5d                   	pop    %ebp
    4007:	c3                   	ret    
    4008:	90                   	nop
    4009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
    4010:	be ff ff ff ff       	mov    $0xffffffff,%esi
    4015:	eb e5                	jmp    3ffc <stat+0x3c>
    4017:	89 f6                	mov    %esi,%esi
    4019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004020 <atoi>:

int
atoi(const char *s) {
    4020:	55                   	push   %ebp
    4021:	89 e5                	mov    %esp,%ebp
    4023:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4026:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    4027:	0f be 11             	movsbl (%ecx),%edx
    402a:	88 d0                	mov    %dl,%al
    402c:	2c 30                	sub    $0x30,%al
    402e:	3c 09                	cmp    $0x9,%al
    n = 0;
    4030:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
    4035:	77 1e                	ja     4055 <atoi+0x35>
    4037:	89 f6                	mov    %esi,%esi
    4039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
    4040:	41                   	inc    %ecx
    4041:	8d 04 80             	lea    (%eax,%eax,4),%eax
    4044:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
    4048:	0f be 11             	movsbl (%ecx),%edx
    404b:	88 d3                	mov    %dl,%bl
    404d:	80 eb 30             	sub    $0x30,%bl
    4050:	80 fb 09             	cmp    $0x9,%bl
    4053:	76 eb                	jbe    4040 <atoi+0x20>
    return n;
}
    4055:	5b                   	pop    %ebx
    4056:	5d                   	pop    %ebp
    4057:	c3                   	ret    
    4058:	90                   	nop
    4059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004060 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
    4060:	55                   	push   %ebp
    4061:	89 e5                	mov    %esp,%ebp
    4063:	56                   	push   %esi
    4064:	8b 45 08             	mov    0x8(%ebp),%eax
    4067:	53                   	push   %ebx
    4068:	8b 5d 10             	mov    0x10(%ebp),%ebx
    406b:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
    406e:	85 db                	test   %ebx,%ebx
    4070:	7e 1a                	jle    408c <memmove+0x2c>
    4072:	31 d2                	xor    %edx,%edx
    4074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    407a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
    4080:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    4084:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    4087:	42                   	inc    %edx
    while (n-- > 0)
    4088:	39 d3                	cmp    %edx,%ebx
    408a:	75 f4                	jne    4080 <memmove+0x20>
    return vdst;
}
    408c:	5b                   	pop    %ebx
    408d:	5e                   	pop    %esi
    408e:	5d                   	pop    %ebp
    408f:	c3                   	ret    

00004090 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4090:	b8 01 00 00 00       	mov    $0x1,%eax
    4095:	cd 40                	int    $0x40
    4097:	c3                   	ret    

00004098 <exit>:
SYSCALL(exit)
    4098:	b8 02 00 00 00       	mov    $0x2,%eax
    409d:	cd 40                	int    $0x40
    409f:	c3                   	ret    

000040a0 <wait>:
SYSCALL(wait)
    40a0:	b8 03 00 00 00       	mov    $0x3,%eax
    40a5:	cd 40                	int    $0x40
    40a7:	c3                   	ret    

000040a8 <pipe>:
SYSCALL(pipe)
    40a8:	b8 04 00 00 00       	mov    $0x4,%eax
    40ad:	cd 40                	int    $0x40
    40af:	c3                   	ret    

000040b0 <read>:
SYSCALL(read)
    40b0:	b8 05 00 00 00       	mov    $0x5,%eax
    40b5:	cd 40                	int    $0x40
    40b7:	c3                   	ret    

000040b8 <write>:
SYSCALL(write)
    40b8:	b8 10 00 00 00       	mov    $0x10,%eax
    40bd:	cd 40                	int    $0x40
    40bf:	c3                   	ret    

000040c0 <close>:
SYSCALL(close)
    40c0:	b8 15 00 00 00       	mov    $0x15,%eax
    40c5:	cd 40                	int    $0x40
    40c7:	c3                   	ret    

000040c8 <kill>:
SYSCALL(kill)
    40c8:	b8 06 00 00 00       	mov    $0x6,%eax
    40cd:	cd 40                	int    $0x40
    40cf:	c3                   	ret    

000040d0 <exec>:
SYSCALL(exec)
    40d0:	b8 07 00 00 00       	mov    $0x7,%eax
    40d5:	cd 40                	int    $0x40
    40d7:	c3                   	ret    

000040d8 <open>:
SYSCALL(open)
    40d8:	b8 0f 00 00 00       	mov    $0xf,%eax
    40dd:	cd 40                	int    $0x40
    40df:	c3                   	ret    

000040e0 <mknod>:
SYSCALL(mknod)
    40e0:	b8 11 00 00 00       	mov    $0x11,%eax
    40e5:	cd 40                	int    $0x40
    40e7:	c3                   	ret    

000040e8 <unlink>:
SYSCALL(unlink)
    40e8:	b8 12 00 00 00       	mov    $0x12,%eax
    40ed:	cd 40                	int    $0x40
    40ef:	c3                   	ret    

000040f0 <fstat>:
SYSCALL(fstat)
    40f0:	b8 08 00 00 00       	mov    $0x8,%eax
    40f5:	cd 40                	int    $0x40
    40f7:	c3                   	ret    

000040f8 <link>:
SYSCALL(link)
    40f8:	b8 13 00 00 00       	mov    $0x13,%eax
    40fd:	cd 40                	int    $0x40
    40ff:	c3                   	ret    

00004100 <mkdir>:
SYSCALL(mkdir)
    4100:	b8 14 00 00 00       	mov    $0x14,%eax
    4105:	cd 40                	int    $0x40
    4107:	c3                   	ret    

00004108 <chdir>:
SYSCALL(chdir)
    4108:	b8 09 00 00 00       	mov    $0x9,%eax
    410d:	cd 40                	int    $0x40
    410f:	c3                   	ret    

00004110 <dup>:
SYSCALL(dup)
    4110:	b8 0a 00 00 00       	mov    $0xa,%eax
    4115:	cd 40                	int    $0x40
    4117:	c3                   	ret    

00004118 <getpid>:
SYSCALL(getpid)
    4118:	b8 0b 00 00 00       	mov    $0xb,%eax
    411d:	cd 40                	int    $0x40
    411f:	c3                   	ret    

00004120 <sbrk>:
SYSCALL(sbrk)
    4120:	b8 0c 00 00 00       	mov    $0xc,%eax
    4125:	cd 40                	int    $0x40
    4127:	c3                   	ret    

00004128 <sleep>:
SYSCALL(sleep)
    4128:	b8 0d 00 00 00       	mov    $0xd,%eax
    412d:	cd 40                	int    $0x40
    412f:	c3                   	ret    

00004130 <uptime>:
SYSCALL(uptime)
    4130:	b8 0e 00 00 00       	mov    $0xe,%eax
    4135:	cd 40                	int    $0x40
    4137:	c3                   	ret    

00004138 <detach>:
SYSCALL(detach)
    4138:	b8 16 00 00 00       	mov    $0x16,%eax
    413d:	cd 40                	int    $0x40
    413f:	c3                   	ret    

00004140 <priority>:
SYSCALL(priority)
    4140:	b8 17 00 00 00       	mov    $0x17,%eax
    4145:	cd 40                	int    $0x40
    4147:	c3                   	ret    

00004148 <policy>:
SYSCALL(policy)
    4148:	b8 18 00 00 00       	mov    $0x18,%eax
    414d:	cd 40                	int    $0x40
    414f:	c3                   	ret    

00004150 <wait_stat>:
SYSCALL(wait_stat)
    4150:	b8 19 00 00 00       	mov    $0x19,%eax
    4155:	cd 40                	int    $0x40
    4157:	c3                   	ret    
    4158:	66 90                	xchg   %ax,%ax
    415a:	66 90                	xchg   %ax,%ax
    415c:	66 90                	xchg   %ax,%ax
    415e:	66 90                	xchg   %ax,%ax

00004160 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    4160:	55                   	push   %ebp
    4161:	89 e5                	mov    %esp,%ebp
    4163:	57                   	push   %edi
    4164:	56                   	push   %esi
    4165:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4166:	89 d3                	mov    %edx,%ebx
    4168:	c1 eb 1f             	shr    $0x1f,%ebx
{
    416b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    416e:	84 db                	test   %bl,%bl
{
    4170:	89 45 c0             	mov    %eax,-0x40(%ebp)
    4173:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    4175:	74 79                	je     41f0 <printint+0x90>
    4177:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    417b:	74 73                	je     41f0 <printint+0x90>
    neg = 1;
    x = -xx;
    417d:	f7 d8                	neg    %eax
    neg = 1;
    417f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    4186:	31 f6                	xor    %esi,%esi
    4188:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    418b:	eb 05                	jmp    4192 <printint+0x32>
    418d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    4190:	89 fe                	mov    %edi,%esi
    4192:	31 d2                	xor    %edx,%edx
    4194:	f7 f1                	div    %ecx
    4196:	8d 7e 01             	lea    0x1(%esi),%edi
    4199:	0f b6 92 18 5d 00 00 	movzbl 0x5d18(%edx),%edx
  }while((x /= base) != 0);
    41a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    41a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    41a5:	75 e9                	jne    4190 <printint+0x30>
  if(neg)
    41a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    41aa:	85 d2                	test   %edx,%edx
    41ac:	74 08                	je     41b6 <printint+0x56>
    buf[i++] = '-';
    41ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    41b3:	8d 7e 02             	lea    0x2(%esi),%edi
    41b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    41ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
    41bd:	8d 76 00             	lea    0x0(%esi),%esi
    41c0:	0f b6 06             	movzbl (%esi),%eax
    41c3:	4e                   	dec    %esi
  write(fd, &c, 1);
    41c4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    41c8:	89 3c 24             	mov    %edi,(%esp)
    41cb:	88 45 d7             	mov    %al,-0x29(%ebp)
    41ce:	b8 01 00 00 00       	mov    $0x1,%eax
    41d3:	89 44 24 08          	mov    %eax,0x8(%esp)
    41d7:	e8 dc fe ff ff       	call   40b8 <write>

  while(--i >= 0)
    41dc:	39 de                	cmp    %ebx,%esi
    41de:	75 e0                	jne    41c0 <printint+0x60>
    putc(fd, buf[i]);
}
    41e0:	83 c4 4c             	add    $0x4c,%esp
    41e3:	5b                   	pop    %ebx
    41e4:	5e                   	pop    %esi
    41e5:	5f                   	pop    %edi
    41e6:	5d                   	pop    %ebp
    41e7:	c3                   	ret    
    41e8:	90                   	nop
    41e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    41f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    41f7:	eb 8d                	jmp    4186 <printint+0x26>
    41f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004200 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    4200:	55                   	push   %ebp
    4201:	89 e5                	mov    %esp,%ebp
    4203:	57                   	push   %edi
    4204:	56                   	push   %esi
    4205:	53                   	push   %ebx
    4206:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4209:	8b 75 0c             	mov    0xc(%ebp),%esi
    420c:	0f b6 1e             	movzbl (%esi),%ebx
    420f:	84 db                	test   %bl,%bl
    4211:	0f 84 d1 00 00 00    	je     42e8 <printf+0xe8>
  state = 0;
    4217:	31 ff                	xor    %edi,%edi
    4219:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    421a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    421d:	89 fa                	mov    %edi,%edx
    421f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    4222:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4225:	eb 41                	jmp    4268 <printf+0x68>
    4227:	89 f6                	mov    %esi,%esi
    4229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    4230:	83 f8 25             	cmp    $0x25,%eax
    4233:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    4236:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    423b:	74 1e                	je     425b <printf+0x5b>
  write(fd, &c, 1);
    423d:	b8 01 00 00 00       	mov    $0x1,%eax
    4242:	89 44 24 08          	mov    %eax,0x8(%esp)
    4246:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    4249:	89 44 24 04          	mov    %eax,0x4(%esp)
    424d:	89 3c 24             	mov    %edi,(%esp)
    4250:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    4253:	e8 60 fe ff ff       	call   40b8 <write>
    4258:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    425b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    425c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    4260:	84 db                	test   %bl,%bl
    4262:	0f 84 80 00 00 00    	je     42e8 <printf+0xe8>
    if(state == 0){
    4268:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    426a:	0f be cb             	movsbl %bl,%ecx
    426d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    4270:	74 be                	je     4230 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    4272:	83 fa 25             	cmp    $0x25,%edx
    4275:	75 e4                	jne    425b <printf+0x5b>
      if(c == 'd'){
    4277:	83 f8 64             	cmp    $0x64,%eax
    427a:	0f 84 f0 00 00 00    	je     4370 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    4280:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    4286:	83 f9 70             	cmp    $0x70,%ecx
    4289:	74 65                	je     42f0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    428b:	83 f8 73             	cmp    $0x73,%eax
    428e:	0f 84 8c 00 00 00    	je     4320 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4294:	83 f8 63             	cmp    $0x63,%eax
    4297:	0f 84 13 01 00 00    	je     43b0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    429d:	83 f8 25             	cmp    $0x25,%eax
    42a0:	0f 84 e2 00 00 00    	je     4388 <printf+0x188>
  write(fd, &c, 1);
    42a6:	b8 01 00 00 00       	mov    $0x1,%eax
    42ab:	46                   	inc    %esi
    42ac:	89 44 24 08          	mov    %eax,0x8(%esp)
    42b0:	8d 45 e7             	lea    -0x19(%ebp),%eax
    42b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    42b7:	89 3c 24             	mov    %edi,(%esp)
    42ba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    42be:	e8 f5 fd ff ff       	call   40b8 <write>
    42c3:	ba 01 00 00 00       	mov    $0x1,%edx
    42c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    42cb:	89 54 24 08          	mov    %edx,0x8(%esp)
    42cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    42d3:	89 3c 24             	mov    %edi,(%esp)
    42d6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    42d9:	e8 da fd ff ff       	call   40b8 <write>
  for(i = 0; fmt[i]; i++){
    42de:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    42e2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    42e4:	84 db                	test   %bl,%bl
    42e6:	75 80                	jne    4268 <printf+0x68>
    }
  }
}
    42e8:	83 c4 3c             	add    $0x3c,%esp
    42eb:	5b                   	pop    %ebx
    42ec:	5e                   	pop    %esi
    42ed:	5f                   	pop    %edi
    42ee:	5d                   	pop    %ebp
    42ef:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    42f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    42f7:	b9 10 00 00 00       	mov    $0x10,%ecx
    42fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    42ff:	89 f8                	mov    %edi,%eax
    4301:	8b 13                	mov    (%ebx),%edx
    4303:	e8 58 fe ff ff       	call   4160 <printint>
        ap++;
    4308:	89 d8                	mov    %ebx,%eax
      state = 0;
    430a:	31 d2                	xor    %edx,%edx
        ap++;
    430c:	83 c0 04             	add    $0x4,%eax
    430f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4312:	e9 44 ff ff ff       	jmp    425b <printf+0x5b>
    4317:	89 f6                	mov    %esi,%esi
    4319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    4320:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4323:	8b 10                	mov    (%eax),%edx
        ap++;
    4325:	83 c0 04             	add    $0x4,%eax
    4328:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    432b:	85 d2                	test   %edx,%edx
    432d:	0f 84 aa 00 00 00    	je     43dd <printf+0x1dd>
        while(*s != 0){
    4333:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    4336:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    4338:	84 c0                	test   %al,%al
    433a:	74 27                	je     4363 <printf+0x163>
    433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4340:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    4343:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    4348:	43                   	inc    %ebx
  write(fd, &c, 1);
    4349:	89 44 24 08          	mov    %eax,0x8(%esp)
    434d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    4350:	89 44 24 04          	mov    %eax,0x4(%esp)
    4354:	89 3c 24             	mov    %edi,(%esp)
    4357:	e8 5c fd ff ff       	call   40b8 <write>
        while(*s != 0){
    435c:	0f b6 03             	movzbl (%ebx),%eax
    435f:	84 c0                	test   %al,%al
    4361:	75 dd                	jne    4340 <printf+0x140>
      state = 0;
    4363:	31 d2                	xor    %edx,%edx
    4365:	e9 f1 fe ff ff       	jmp    425b <printf+0x5b>
    436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    4370:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4377:	b9 0a 00 00 00       	mov    $0xa,%ecx
    437c:	e9 7b ff ff ff       	jmp    42fc <printf+0xfc>
    4381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    4388:	b9 01 00 00 00       	mov    $0x1,%ecx
    438d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    4390:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    4394:	89 44 24 04          	mov    %eax,0x4(%esp)
    4398:	89 3c 24             	mov    %edi,(%esp)
    439b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    439e:	e8 15 fd ff ff       	call   40b8 <write>
      state = 0;
    43a3:	31 d2                	xor    %edx,%edx
    43a5:	e9 b1 fe ff ff       	jmp    425b <printf+0x5b>
    43aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    43b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    43b3:	8b 03                	mov    (%ebx),%eax
        ap++;
    43b5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    43b8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    43bb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    43be:	b8 01 00 00 00       	mov    $0x1,%eax
    43c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    43c7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    43ca:	89 44 24 04          	mov    %eax,0x4(%esp)
    43ce:	e8 e5 fc ff ff       	call   40b8 <write>
      state = 0;
    43d3:	31 d2                	xor    %edx,%edx
        ap++;
    43d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    43d8:	e9 7e fe ff ff       	jmp    425b <printf+0x5b>
          s = "(null)";
    43dd:	bb 10 5d 00 00       	mov    $0x5d10,%ebx
        while(*s != 0){
    43e2:	b0 28                	mov    $0x28,%al
    43e4:	e9 57 ff ff ff       	jmp    4340 <printf+0x140>
    43e9:	66 90                	xchg   %ax,%ax
    43eb:	66 90                	xchg   %ax,%ax
    43ed:	66 90                	xchg   %ax,%ax
    43ef:	90                   	nop

000043f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    43f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    43f1:	a1 e0 66 00 00       	mov    0x66e0,%eax
{
    43f6:	89 e5                	mov    %esp,%ebp
    43f8:	57                   	push   %edi
    43f9:	56                   	push   %esi
    43fa:	53                   	push   %ebx
    43fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    43fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    4401:	eb 0d                	jmp    4410 <free+0x20>
    4403:	90                   	nop
    4404:	90                   	nop
    4405:	90                   	nop
    4406:	90                   	nop
    4407:	90                   	nop
    4408:	90                   	nop
    4409:	90                   	nop
    440a:	90                   	nop
    440b:	90                   	nop
    440c:	90                   	nop
    440d:	90                   	nop
    440e:	90                   	nop
    440f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4410:	39 c8                	cmp    %ecx,%eax
    4412:	8b 10                	mov    (%eax),%edx
    4414:	73 32                	jae    4448 <free+0x58>
    4416:	39 d1                	cmp    %edx,%ecx
    4418:	72 04                	jb     441e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    441a:	39 d0                	cmp    %edx,%eax
    441c:	72 32                	jb     4450 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    441e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    4421:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    4424:	39 fa                	cmp    %edi,%edx
    4426:	74 30                	je     4458 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    4428:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    442b:	8b 50 04             	mov    0x4(%eax),%edx
    442e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4431:	39 f1                	cmp    %esi,%ecx
    4433:	74 3c                	je     4471 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    4435:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    4437:	5b                   	pop    %ebx
  freep = p;
    4438:	a3 e0 66 00 00       	mov    %eax,0x66e0
}
    443d:	5e                   	pop    %esi
    443e:	5f                   	pop    %edi
    443f:	5d                   	pop    %ebp
    4440:	c3                   	ret    
    4441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4448:	39 d0                	cmp    %edx,%eax
    444a:	72 04                	jb     4450 <free+0x60>
    444c:	39 d1                	cmp    %edx,%ecx
    444e:	72 ce                	jb     441e <free+0x2e>
{
    4450:	89 d0                	mov    %edx,%eax
    4452:	eb bc                	jmp    4410 <free+0x20>
    4454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    4458:	8b 7a 04             	mov    0x4(%edx),%edi
    445b:	01 fe                	add    %edi,%esi
    445d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4460:	8b 10                	mov    (%eax),%edx
    4462:	8b 12                	mov    (%edx),%edx
    4464:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    4467:	8b 50 04             	mov    0x4(%eax),%edx
    446a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    446d:	39 f1                	cmp    %esi,%ecx
    446f:	75 c4                	jne    4435 <free+0x45>
    p->s.size += bp->s.size;
    4471:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    4474:	a3 e0 66 00 00       	mov    %eax,0x66e0
    p->s.size += bp->s.size;
    4479:	01 ca                	add    %ecx,%edx
    447b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    447e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4481:	89 10                	mov    %edx,(%eax)
}
    4483:	5b                   	pop    %ebx
    4484:	5e                   	pop    %esi
    4485:	5f                   	pop    %edi
    4486:	5d                   	pop    %ebp
    4487:	c3                   	ret    
    4488:	90                   	nop
    4489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004490 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4490:	55                   	push   %ebp
    4491:	89 e5                	mov    %esp,%ebp
    4493:	57                   	push   %edi
    4494:	56                   	push   %esi
    4495:	53                   	push   %ebx
    4496:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4499:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    449c:	8b 15 e0 66 00 00    	mov    0x66e0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    44a2:	8d 78 07             	lea    0x7(%eax),%edi
    44a5:	c1 ef 03             	shr    $0x3,%edi
    44a8:	47                   	inc    %edi
  if((prevp = freep) == 0){
    44a9:	85 d2                	test   %edx,%edx
    44ab:	0f 84 8f 00 00 00    	je     4540 <malloc+0xb0>
    44b1:	8b 02                	mov    (%edx),%eax
    44b3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    44b6:	39 cf                	cmp    %ecx,%edi
    44b8:	76 66                	jbe    4520 <malloc+0x90>
    44ba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    44c0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    44c5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    44c8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    44cf:	eb 10                	jmp    44e1 <malloc+0x51>
    44d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    44d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    44da:	8b 48 04             	mov    0x4(%eax),%ecx
    44dd:	39 f9                	cmp    %edi,%ecx
    44df:	73 3f                	jae    4520 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    44e1:	39 05 e0 66 00 00    	cmp    %eax,0x66e0
    44e7:	89 c2                	mov    %eax,%edx
    44e9:	75 ed                	jne    44d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    44eb:	89 34 24             	mov    %esi,(%esp)
    44ee:	e8 2d fc ff ff       	call   4120 <sbrk>
  if(p == (char*)-1)
    44f3:	83 f8 ff             	cmp    $0xffffffff,%eax
    44f6:	74 18                	je     4510 <malloc+0x80>
  hp->s.size = nu;
    44f8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    44fb:	83 c0 08             	add    $0x8,%eax
    44fe:	89 04 24             	mov    %eax,(%esp)
    4501:	e8 ea fe ff ff       	call   43f0 <free>
  return freep;
    4506:	8b 15 e0 66 00 00    	mov    0x66e0,%edx
      if((p = morecore(nunits)) == 0)
    450c:	85 d2                	test   %edx,%edx
    450e:	75 c8                	jne    44d8 <malloc+0x48>
        return 0;
  }
}
    4510:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    4513:	31 c0                	xor    %eax,%eax
}
    4515:	5b                   	pop    %ebx
    4516:	5e                   	pop    %esi
    4517:	5f                   	pop    %edi
    4518:	5d                   	pop    %ebp
    4519:	c3                   	ret    
    451a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    4520:	39 cf                	cmp    %ecx,%edi
    4522:	74 4c                	je     4570 <malloc+0xe0>
        p->s.size -= nunits;
    4524:	29 f9                	sub    %edi,%ecx
    4526:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    4529:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    452c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    452f:	89 15 e0 66 00 00    	mov    %edx,0x66e0
}
    4535:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    4538:	83 c0 08             	add    $0x8,%eax
}
    453b:	5b                   	pop    %ebx
    453c:	5e                   	pop    %esi
    453d:	5f                   	pop    %edi
    453e:	5d                   	pop    %ebp
    453f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    4540:	b8 e4 66 00 00       	mov    $0x66e4,%eax
    4545:	ba e4 66 00 00       	mov    $0x66e4,%edx
    base.s.size = 0;
    454a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    454c:	a3 e0 66 00 00       	mov    %eax,0x66e0
    base.s.size = 0;
    4551:	b8 e4 66 00 00       	mov    $0x66e4,%eax
    base.s.ptr = freep = prevp = &base;
    4556:	89 15 e4 66 00 00    	mov    %edx,0x66e4
    base.s.size = 0;
    455c:	89 0d e8 66 00 00    	mov    %ecx,0x66e8
    4562:	e9 53 ff ff ff       	jmp    44ba <malloc+0x2a>
    4567:	89 f6                	mov    %esi,%esi
    4569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    4570:	8b 08                	mov    (%eax),%ecx
    4572:	89 0a                	mov    %ecx,(%edx)
    4574:	eb b9                	jmp    452f <malloc+0x9f>
