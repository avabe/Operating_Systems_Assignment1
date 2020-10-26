
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        return -1;
    return 0;
}

int
main(void) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
    static char buf[100];
    int fd;

    // Ensure that three file descriptors are open.
    while ((fd = open("console", O_RDWR)) >= 0) {
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (fd >= 3) {
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f 87 00 00 00    	jg     a0 <main+0xa0>
    while ((fd = open("console", O_RDWR)) >= 0) {
      19:	ba 02 00 00 00       	mov    $0x2,%edx
      1e:	89 54 24 04          	mov    %edx,0x4(%esp)
      22:	c7 04 24 98 15 00 00 	movl   $0x1598,(%esp)
      29:	e8 1a 10 00 00       	call   1048 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 2b                	jmp    5f <main+0x5f>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
    }

    // Read and run input commands.
    while (getcmd(buf, sizeof(buf)) >= 0) {
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ') {
      38:	80 3d e2 1b 00 00 20 	cmpb   $0x20,0x1be2
      3f:	0f 84 85 00 00 00    	je     ca <main+0xca>

int
fork1(void) {
    int pid;

    pid = fork();
      45:	e8 b6 0f 00 00       	call   1000 <fork>
    if (pid == -1)
      4a:	83 f8 ff             	cmp    $0xffffffff,%eax
      4d:	74 45                	je     94 <main+0x94>
        if (fork1() == 0) {
      4f:	85 c0                	test   %eax,%eax
      51:	74 63                	je     b6 <main+0xb6>
        wait(0);
      53:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      5a:	e8 b1 0f 00 00       	call   1010 <wait>
    while (getcmd(buf, sizeof(buf)) >= 0) {
      5f:	b8 64 00 00 00       	mov    $0x64,%eax
      64:	89 44 24 04          	mov    %eax,0x4(%esp)
      68:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
      6f:	e8 ac 00 00 00       	call   120 <getcmd>
      74:	85 c0                	test   %eax,%eax
      76:	78 32                	js     aa <main+0xaa>
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ') {
      78:	80 3d e0 1b 00 00 63 	cmpb   $0x63,0x1be0
      7f:	75 c4                	jne    45 <main+0x45>
      81:	80 3d e1 1b 00 00 64 	cmpb   $0x64,0x1be1
      88:	74 ae                	je     38 <main+0x38>
    pid = fork();
      8a:	e8 71 0f 00 00       	call   1000 <fork>
    if (pid == -1)
      8f:	83 f8 ff             	cmp    $0xffffffff,%eax
      92:	75 bb                	jne    4f <main+0x4f>
        panic("fork");
      94:	c7 04 24 21 15 00 00 	movl   $0x1521,(%esp)
      9b:	e8 e0 00 00 00       	call   180 <panic>
            close(fd);
      a0:	89 04 24             	mov    %eax,(%esp)
      a3:	e8 88 0f 00 00       	call   1030 <close>
            break;
      a8:	eb b5                	jmp    5f <main+0x5f>
    exit(0);
      aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      b1:	e8 52 0f 00 00       	call   1008 <exit>
            runcmd(parsecmd(buf));
      b6:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
      bd:	e8 6e 0c 00 00       	call   d30 <parsecmd>
      c2:	89 04 24             	mov    %eax,(%esp)
      c5:	e8 e6 00 00 00       	call   1b0 <runcmd>
            buf[strlen(buf) - 1] = 0;  // chop \n
      ca:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
      d1:	e8 6a 0d 00 00       	call   e40 <strlen>
            if (chdir(buf + 3) < 0)
      d6:	c7 04 24 e3 1b 00 00 	movl   $0x1be3,(%esp)
            buf[strlen(buf) - 1] = 0;  // chop \n
      dd:	c6 80 df 1b 00 00 00 	movb   $0x0,0x1bdf(%eax)
            if (chdir(buf + 3) < 0)
      e4:	e8 8f 0f 00 00       	call   1078 <chdir>
      e9:	85 c0                	test   %eax,%eax
      eb:	0f 89 6e ff ff ff    	jns    5f <main+0x5f>
                printf(2, "cannot cd %s\n", buf + 3);
      f1:	c7 44 24 08 e3 1b 00 	movl   $0x1be3,0x8(%esp)
      f8:	00 
      f9:	c7 44 24 04 a0 15 00 	movl   $0x15a0,0x4(%esp)
     100:	00 
     101:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     108:	e8 63 10 00 00       	call   1170 <printf>
     10d:	e9 4d ff ff ff       	jmp    5f <main+0x5f>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <getcmd>:
getcmd(char *buf, int nbuf) {
     120:	55                   	push   %ebp
    printf(2, "$ ");
     121:	b8 e8 14 00 00       	mov    $0x14e8,%eax
getcmd(char *buf, int nbuf) {
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 18             	sub    $0x18,%esp
     12b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     12e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     131:	89 75 fc             	mov    %esi,-0x4(%ebp)
     134:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     137:	89 44 24 04          	mov    %eax,0x4(%esp)
     13b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     142:	e8 29 10 00 00       	call   1170 <printf>
    memset(buf, 0, nbuf);
     147:	31 d2                	xor    %edx,%edx
     149:	89 74 24 08          	mov    %esi,0x8(%esp)
     14d:	89 54 24 04          	mov    %edx,0x4(%esp)
     151:	89 1c 24             	mov    %ebx,(%esp)
     154:	e8 17 0d 00 00       	call   e70 <memset>
    gets(buf, nbuf);
     159:	89 74 24 04          	mov    %esi,0x4(%esp)
     15d:	89 1c 24             	mov    %ebx,(%esp)
     160:	e8 5b 0d 00 00       	call   ec0 <gets>
    if (buf[0] == 0) // EOF
     165:	31 c0                	xor    %eax,%eax
}
     167:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if (buf[0] == 0) // EOF
     16a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     16d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if (buf[0] == 0) // EOF
     170:	0f 94 c0             	sete   %al
}
     173:	89 ec                	mov    %ebp,%esp
    if (buf[0] == 0) // EOF
     175:	f7 d8                	neg    %eax
}
     177:	5d                   	pop    %ebp
     178:	c3                   	ret    
     179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <panic>:
panic(char *s) {
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     186:	8b 45 08             	mov    0x8(%ebp),%eax
     189:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     190:	89 44 24 08          	mov    %eax,0x8(%esp)
     194:	b8 94 15 00 00       	mov    $0x1594,%eax
     199:	89 44 24 04          	mov    %eax,0x4(%esp)
     19d:	e8 ce 0f 00 00       	call   1170 <printf>
    exit(0);
     1a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1a9:	e8 5a 0e 00 00       	call   1008 <exit>
     1ae:	66 90                	xchg   %ax,%ax

000001b0 <runcmd>:
runcmd(struct cmd *cmd) {
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	57                   	push   %edi
     1b4:	56                   	push   %esi
     1b5:	53                   	push   %ebx
     1b6:	81 ec fc 00 00 00    	sub    $0xfc,%esp
     1bc:	8b 7d 08             	mov    0x8(%ebp),%edi
    if (cmd == 0)
     1bf:	85 ff                	test   %edi,%edi
     1c1:	74 5d                	je     220 <runcmd+0x70>
    switch (cmd->type) {
     1c3:	83 3f 05             	cmpl   $0x5,(%edi)
     1c6:	0f 87 56 02 00 00    	ja     422 <runcmd+0x272>
     1cc:	8b 07                	mov    (%edi),%eax
     1ce:	ff 24 85 b0 15 00 00 	jmp    *0x15b0(,%eax,4)
            close(rcmd->fd);
     1d5:	8b 47 14             	mov    0x14(%edi),%eax
     1d8:	89 04 24             	mov    %eax,(%esp)
     1db:	e8 50 0e 00 00       	call   1030 <close>
            if (open(rcmd->file, rcmd->mode) < 0) {
     1e0:	8b 47 10             	mov    0x10(%edi),%eax
     1e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     1e7:	8b 47 08             	mov    0x8(%edi),%eax
     1ea:	89 04 24             	mov    %eax,(%esp)
     1ed:	e8 56 0e 00 00       	call   1048 <open>
     1f2:	85 c0                	test   %eax,%eax
     1f4:	79 48                	jns    23e <runcmd+0x8e>
                printf(2, "open %s failed\n", rcmd->file);
     1f6:	8b 47 08             	mov    0x8(%edi),%eax
     1f9:	c7 44 24 04 11 15 00 	movl   $0x1511,0x4(%esp)
     200:	00 
     201:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     208:	89 44 24 08          	mov    %eax,0x8(%esp)
     20c:	e8 5f 0f 00 00       	call   1170 <printf>
     211:	eb 0d                	jmp    220 <runcmd+0x70>
     213:	90                   	nop
     214:	90                   	nop
     215:	90                   	nop
     216:	90                   	nop
     217:	90                   	nop
     218:	90                   	nop
     219:	90                   	nop
     21a:	90                   	nop
     21b:	90                   	nop
     21c:	90                   	nop
     21d:	90                   	nop
     21e:	90                   	nop
     21f:	90                   	nop
                exit(0);
     220:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     227:	e8 dc 0d 00 00       	call   1008 <exit>
    pid = fork();
     22c:	e8 cf 0d 00 00       	call   1000 <fork>
    if (pid == -1)
     231:	83 f8 ff             	cmp    $0xffffffff,%eax
     234:	0f 84 f4 01 00 00    	je     42e <runcmd+0x27e>
            if (fork1() == 0)
     23a:	85 c0                	test   %eax,%eax
     23c:	75 e2                	jne    220 <runcmd+0x70>
                runcmd(bcmd->cmd);
     23e:	8b 47 04             	mov    0x4(%edi),%eax
     241:	89 04 24             	mov    %eax,(%esp)
     244:	e8 67 ff ff ff       	call   1b0 <runcmd>
            if (ecmd->argv[0] == 0)
     249:	83 7f 04 00          	cmpl   $0x0,0x4(%edi)
     24d:	74 d1                	je     220 <runcmd+0x70>
            memset(helper, 0, 100);
     24f:	8d 45 84             	lea    -0x7c(%ebp),%eax
     252:	c7 44 24 08 64 00 00 	movl   $0x64,0x8(%esp)
     259:	00 
            memset(bufi, 0, 100);
     25a:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
            memset(helper, 0, 100);
     260:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     267:	00 
     268:	89 04 24             	mov    %eax,(%esp)
     26b:	e8 00 0c 00 00       	call   e70 <memset>
            memset(bufi, 0, 100);
     270:	c7 44 24 08 64 00 00 	movl   $0x64,0x8(%esp)
     277:	00 
     278:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     27f:	00 
     280:	89 1c 24             	mov    %ebx,(%esp)
     283:	e8 e8 0b 00 00       	call   e70 <memset>
            if ((fd = open("/path", O_RDWR)) < 0) {
     288:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     28f:	00 
     290:	c7 04 24 f2 14 00 00 	movl   $0x14f2,(%esp)
     297:	e8 ac 0d 00 00       	call   1048 <open>
     29c:	85 c0                	test   %eax,%eax
     29e:	89 c6                	mov    %eax,%esi
     2a0:	0f 88 d8 01 00 00    	js     47e <runcmd+0x2ce>
                read(fd, bufi, 100);
     2a6:	c7 44 24 08 64 00 00 	movl   $0x64,0x8(%esp)
     2ad:	00 
     2ae:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2b2:	89 04 24             	mov    %eax,(%esp)
     2b5:	e8 66 0d 00 00       	call   1020 <read>
            close(fd);
     2ba:	89 34 24             	mov    %esi,(%esp)
     2bd:	e8 6e 0d 00 00       	call   1030 <close>
            exec(ecmd->argv[0], ecmd->argv);
     2c2:	8d 47 04             	lea    0x4(%edi),%eax
     2c5:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c9:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
     2cf:	8b 47 04             	mov    0x4(%edi),%eax
     2d2:	89 04 24             	mov    %eax,(%esp)
     2d5:	e8 66 0d 00 00       	call   1040 <exec>
                char *next = strchr(buf, ':');
     2da:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
     2e1:	00 
     2e2:	89 1c 24             	mov    %ebx,(%esp)
     2e5:	e8 a6 0b 00 00       	call   e90 <strchr>
                curr_size = strlen(buf) - strlen(next);
     2ea:	89 1c 24             	mov    %ebx,(%esp)
                char *next = strchr(buf, ':');
     2ed:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
                curr_size = strlen(buf) - strlen(next);
     2f3:	e8 48 0b 00 00       	call   e40 <strlen>
     2f8:	8b 8d 14 ff ff ff    	mov    -0xec(%ebp),%ecx
     2fe:	89 0c 24             	mov    %ecx,(%esp)
     301:	89 c6                	mov    %eax,%esi
     303:	e8 38 0b 00 00       	call   e40 <strlen>
                if (curr_size < 0)
     308:	29 c6                	sub    %eax,%esi
     30a:	78 5f                	js     36b <runcmd+0x1bb>
                memset(helper, 0, 100);
     30c:	8d 45 84             	lea    -0x7c(%ebp),%eax
     30f:	c7 44 24 08 64 00 00 	movl   $0x64,0x8(%esp)
     316:	00 
     317:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     31e:	00 
     31f:	89 04 24             	mov    %eax,(%esp)
     322:	e8 49 0b 00 00       	call   e70 <memset>
                strcpy(helper, buf);
     327:	8d 45 84             	lea    -0x7c(%ebp),%eax
     32a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
                buf += curr_size + 1;
     32e:	8d 5c 33 01          	lea    0x1(%ebx,%esi,1),%ebx
                strcpy(helper, buf);
     332:	89 04 24             	mov    %eax,(%esp)
     335:	e8 76 0a 00 00       	call   db0 <strcpy>
                strcpy(helper + curr_size, ecmd->argv[0]);
     33a:	8b 47 04             	mov    0x4(%edi),%eax
     33d:	89 44 24 04          	mov    %eax,0x4(%esp)
     341:	8d 45 84             	lea    -0x7c(%ebp),%eax
     344:	01 f0                	add    %esi,%eax
     346:	89 04 24             	mov    %eax,(%esp)
     349:	e8 62 0a 00 00       	call   db0 <strcpy>
                exec(helper, ecmd->argv);
     34e:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
     354:	89 44 24 04          	mov    %eax,0x4(%esp)
     358:	8d 45 84             	lea    -0x7c(%ebp),%eax
     35b:	89 04 24             	mov    %eax,(%esp)
     35e:	e8 dd 0c 00 00       	call   1040 <exec>
            while (buf) {
     363:	85 db                	test   %ebx,%ebx
     365:	0f 85 6f ff ff ff    	jne    2da <runcmd+0x12a>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     36b:	8b 47 04             	mov    0x4(%edi),%eax
     36e:	c7 44 24 04 01 15 00 	movl   $0x1501,0x4(%esp)
     375:	00 
     376:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     37d:	89 44 24 08          	mov    %eax,0x8(%esp)
     381:	e8 ea 0d 00 00       	call   1170 <printf>
            break;
     386:	e9 95 fe ff ff       	jmp    220 <runcmd+0x70>
            if (pipe(p) < 0)
     38b:	8d 45 84             	lea    -0x7c(%ebp),%eax
     38e:	89 04 24             	mov    %eax,(%esp)
     391:	e8 82 0c 00 00       	call   1018 <pipe>
     396:	85 c0                	test   %eax,%eax
     398:	0f 88 d4 00 00 00    	js     472 <runcmd+0x2c2>
    pid = fork();
     39e:	e8 5d 0c 00 00       	call   1000 <fork>
    if (pid == -1)
     3a3:	83 f8 ff             	cmp    $0xffffffff,%eax
     3a6:	0f 84 82 00 00 00    	je     42e <runcmd+0x27e>
            if (fork1() == 0) {
     3ac:	85 c0                	test   %eax,%eax
     3ae:	66 90                	xchg   %ax,%ax
     3b0:	0f 84 03 01 00 00    	je     4b9 <runcmd+0x309>
    pid = fork();
     3b6:	e8 45 0c 00 00       	call   1000 <fork>
    if (pid == -1)
     3bb:	83 f8 ff             	cmp    $0xffffffff,%eax
     3be:	66 90                	xchg   %ax,%ax
     3c0:	74 6c                	je     42e <runcmd+0x27e>
            if (fork1() == 0) {
     3c2:	85 c0                	test   %eax,%eax
     3c4:	74 74                	je     43a <runcmd+0x28a>
            close(p[0]);
     3c6:	8b 45 84             	mov    -0x7c(%ebp),%eax
     3c9:	89 04 24             	mov    %eax,(%esp)
     3cc:	e8 5f 0c 00 00       	call   1030 <close>
            close(p[1]);
     3d1:	8b 45 88             	mov    -0x78(%ebp),%eax
     3d4:	89 04 24             	mov    %eax,(%esp)
     3d7:	e8 54 0c 00 00       	call   1030 <close>
            wait(0);
     3dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3e3:	e8 28 0c 00 00       	call   1010 <wait>
            wait(0);
     3e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3ef:	e8 1c 0c 00 00       	call   1010 <wait>
            break;
     3f4:	e9 27 fe ff ff       	jmp    220 <runcmd+0x70>
    pid = fork();
     3f9:	e8 02 0c 00 00       	call   1000 <fork>
    if (pid == -1)
     3fe:	83 f8 ff             	cmp    $0xffffffff,%eax
     401:	74 2b                	je     42e <runcmd+0x27e>
            if (fork1() == 0)
     403:	85 c0                	test   %eax,%eax
     405:	0f 84 33 fe ff ff    	je     23e <runcmd+0x8e>
            wait(0);
     40b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     412:	e8 f9 0b 00 00       	call   1010 <wait>
            runcmd(lcmd->right);
     417:	8b 47 08             	mov    0x8(%edi),%eax
     41a:	89 04 24             	mov    %eax,(%esp)
     41d:	e8 8e fd ff ff       	call   1b0 <runcmd>
            panic("runcmd");
     422:	c7 04 24 eb 14 00 00 	movl   $0x14eb,(%esp)
     429:	e8 52 fd ff ff       	call   180 <panic>
        panic("fork");
     42e:	c7 04 24 21 15 00 00 	movl   $0x1521,(%esp)
     435:	e8 46 fd ff ff       	call   180 <panic>
                close(0);
     43a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     441:	e8 ea 0b 00 00       	call   1030 <close>
                dup(p[0]);
     446:	8b 45 84             	mov    -0x7c(%ebp),%eax
     449:	89 04 24             	mov    %eax,(%esp)
     44c:	e8 2f 0c 00 00       	call   1080 <dup>
                close(p[0]);
     451:	8b 45 84             	mov    -0x7c(%ebp),%eax
     454:	89 04 24             	mov    %eax,(%esp)
     457:	e8 d4 0b 00 00       	call   1030 <close>
                close(p[1]);
     45c:	8b 45 88             	mov    -0x78(%ebp),%eax
     45f:	89 04 24             	mov    %eax,(%esp)
     462:	e8 c9 0b 00 00       	call   1030 <close>
                runcmd(pcmd->right);
     467:	8b 47 08             	mov    0x8(%edi),%eax
     46a:	89 04 24             	mov    %eax,(%esp)
     46d:	e8 3e fd ff ff       	call   1b0 <runcmd>
                panic("pipe");
     472:	c7 04 24 26 15 00 00 	movl   $0x1526,(%esp)
     479:	e8 02 fd ff ff       	call   180 <panic>
                fd = open("/path", O_CREATE | O_RDWR);
     47e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     485:	00 
     486:	c7 04 24 f2 14 00 00 	movl   $0x14f2,(%esp)
     48d:	e8 b6 0b 00 00       	call   1048 <open>
                write(fd, "/:/bin/:", strlen("/:/bin/:"));
     492:	c7 04 24 f8 14 00 00 	movl   $0x14f8,(%esp)
                fd = open("/path", O_CREATE | O_RDWR);
     499:	89 c6                	mov    %eax,%esi
                write(fd, "/:/bin/:", strlen("/:/bin/:"));
     49b:	e8 a0 09 00 00       	call   e40 <strlen>
     4a0:	c7 44 24 04 f8 14 00 	movl   $0x14f8,0x4(%esp)
     4a7:	00 
     4a8:	89 34 24             	mov    %esi,(%esp)
     4ab:	89 44 24 08          	mov    %eax,0x8(%esp)
     4af:	e8 74 0b 00 00       	call   1028 <write>
     4b4:	e9 01 fe ff ff       	jmp    2ba <runcmd+0x10a>
                close(1);
     4b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4c0:	e8 6b 0b 00 00       	call   1030 <close>
                dup(p[1]);
     4c5:	8b 45 88             	mov    -0x78(%ebp),%eax
     4c8:	89 04 24             	mov    %eax,(%esp)
     4cb:	e8 b0 0b 00 00       	call   1080 <dup>
                close(p[0]);
     4d0:	8b 45 84             	mov    -0x7c(%ebp),%eax
     4d3:	89 04 24             	mov    %eax,(%esp)
     4d6:	e8 55 0b 00 00       	call   1030 <close>
                close(p[1]);
     4db:	8b 45 88             	mov    -0x78(%ebp),%eax
     4de:	89 04 24             	mov    %eax,(%esp)
     4e1:	e8 4a 0b 00 00       	call   1030 <close>
                runcmd(pcmd->left);
     4e6:	8b 47 04             	mov    0x4(%edi),%eax
     4e9:	89 04 24             	mov    %eax,(%esp)
     4ec:	e8 bf fc ff ff       	call   1b0 <runcmd>
     4f1:	eb 0d                	jmp    500 <fork1>
     4f3:	90                   	nop
     4f4:	90                   	nop
     4f5:	90                   	nop
     4f6:	90                   	nop
     4f7:	90                   	nop
     4f8:	90                   	nop
     4f9:	90                   	nop
     4fa:	90                   	nop
     4fb:	90                   	nop
     4fc:	90                   	nop
     4fd:	90                   	nop
     4fe:	90                   	nop
     4ff:	90                   	nop

00000500 <fork1>:
fork1(void) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     506:	e8 f5 0a 00 00       	call   1000 <fork>
    if (pid == -1)
     50b:	83 f8 ff             	cmp    $0xffffffff,%eax
     50e:	74 02                	je     512 <fork1+0x12>
    return pid;
}
     510:	c9                   	leave  
     511:	c3                   	ret    
        panic("fork");
     512:	c7 04 24 21 15 00 00 	movl   $0x1521,(%esp)
     519:	e8 62 fc ff ff       	call   180 <panic>
     51e:	66 90                	xchg   %ax,%ax

00000520 <execcmd>:

//PAGEBREAK!
// Constructors

struct cmd *
execcmd(void) {
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	53                   	push   %ebx
     524:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     527:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     52e:	e8 cd 0e 00 00       	call   1400 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     533:	31 d2                	xor    %edx,%edx
     535:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     539:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     53b:	b8 54 00 00 00       	mov    $0x54,%eax
     540:	89 1c 24             	mov    %ebx,(%esp)
     543:	89 44 24 08          	mov    %eax,0x8(%esp)
     547:	e8 24 09 00 00       	call   e70 <memset>
    cmd->type = EXEC;
    return (struct cmd *) cmd;
}
     54c:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     54e:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     554:	83 c4 14             	add    $0x14,%esp
     557:	5b                   	pop    %ebx
     558:	5d                   	pop    %ebp
     559:	c3                   	ret    
     55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000560 <redircmd>:

struct cmd *
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd) {
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	53                   	push   %ebx
     564:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     567:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     56e:	e8 8d 0e 00 00       	call   1400 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     573:	31 d2                	xor    %edx,%edx
     575:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     579:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     57b:	b8 18 00 00 00       	mov    $0x18,%eax
     580:	89 1c 24             	mov    %ebx,(%esp)
     583:	89 44 24 08          	mov    %eax,0x8(%esp)
     587:	e8 e4 08 00 00       	call   e70 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     58c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     58f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     595:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     598:	8b 45 0c             	mov    0xc(%ebp),%eax
     59b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     59e:	8b 45 10             	mov    0x10(%ebp),%eax
     5a1:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     5a4:	8b 45 14             	mov    0x14(%ebp),%eax
     5a7:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     5aa:	8b 45 18             	mov    0x18(%ebp),%eax
     5ad:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd *) cmd;
}
     5b0:	83 c4 14             	add    $0x14,%esp
     5b3:	89 d8                	mov    %ebx,%eax
     5b5:	5b                   	pop    %ebx
     5b6:	5d                   	pop    %ebp
     5b7:	c3                   	ret    
     5b8:	90                   	nop
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005c0 <pipecmd>:

struct cmd *
pipecmd(struct cmd *left, struct cmd *right) {
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	53                   	push   %ebx
     5c4:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     5c7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     5ce:	e8 2d 0e 00 00       	call   1400 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     5d3:	31 d2                	xor    %edx,%edx
     5d5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     5d9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     5db:	b8 0c 00 00 00       	mov    $0xc,%eax
     5e0:	89 1c 24             	mov    %ebx,(%esp)
     5e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     5e7:	e8 84 08 00 00       	call   e70 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     5ec:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     5ef:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     5f5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     5f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     5fb:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd *) cmd;
}
     5fe:	83 c4 14             	add    $0x14,%esp
     601:	89 d8                	mov    %ebx,%eax
     603:	5b                   	pop    %ebx
     604:	5d                   	pop    %ebp
     605:	c3                   	ret    
     606:	8d 76 00             	lea    0x0(%esi),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <listcmd>:

struct cmd *
listcmd(struct cmd *left, struct cmd *right) {
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	53                   	push   %ebx
     614:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     617:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     61e:	e8 dd 0d 00 00       	call   1400 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     623:	31 d2                	xor    %edx,%edx
     625:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     629:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     62b:	b8 0c 00 00 00       	mov    $0xc,%eax
     630:	89 1c 24             	mov    %ebx,(%esp)
     633:	89 44 24 08          	mov    %eax,0x8(%esp)
     637:	e8 34 08 00 00       	call   e70 <memset>
    cmd->type = LIST;
    cmd->left = left;
     63c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     63f:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     645:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     648:	8b 45 0c             	mov    0xc(%ebp),%eax
     64b:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd *) cmd;
}
     64e:	83 c4 14             	add    $0x14,%esp
     651:	89 d8                	mov    %ebx,%eax
     653:	5b                   	pop    %ebx
     654:	5d                   	pop    %ebp
     655:	c3                   	ret    
     656:	8d 76 00             	lea    0x0(%esi),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <backcmd>:

struct cmd *
backcmd(struct cmd *subcmd) {
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	53                   	push   %ebx
     664:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     667:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     66e:	e8 8d 0d 00 00       	call   1400 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     673:	31 d2                	xor    %edx,%edx
     675:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     679:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     67b:	b8 08 00 00 00       	mov    $0x8,%eax
     680:	89 1c 24             	mov    %ebx,(%esp)
     683:	89 44 24 08          	mov    %eax,0x8(%esp)
     687:	e8 e4 07 00 00       	call   e70 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     68c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     68f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     695:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd *) cmd;
}
     698:	83 c4 14             	add    $0x14,%esp
     69b:	89 d8                	mov    %ebx,%eax
     69d:	5b                   	pop    %ebx
     69e:	5d                   	pop    %ebp
     69f:	c3                   	ret    

000006a0 <gettoken>:

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq) {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
     6a6:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     6a9:	8b 45 08             	mov    0x8(%ebp),%eax
gettoken(char **ps, char *es, char **q, char **eq) {
     6ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     6af:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     6b2:	8b 30                	mov    (%eax),%esi
    while (s < es && strchr(whitespace, *s))
     6b4:	39 de                	cmp    %ebx,%esi
     6b6:	72 0d                	jb     6c5 <gettoken+0x25>
     6b8:	eb 22                	jmp    6dc <gettoken+0x3c>
     6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     6c0:	46                   	inc    %esi
    while (s < es && strchr(whitespace, *s))
     6c1:	39 f3                	cmp    %esi,%ebx
     6c3:	74 17                	je     6dc <gettoken+0x3c>
     6c5:	0f be 06             	movsbl (%esi),%eax
     6c8:	c7 04 24 c8 1b 00 00 	movl   $0x1bc8,(%esp)
     6cf:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d3:	e8 b8 07 00 00       	call   e90 <strchr>
     6d8:	85 c0                	test   %eax,%eax
     6da:	75 e4                	jne    6c0 <gettoken+0x20>
    if (q)
     6dc:	85 ff                	test   %edi,%edi
     6de:	74 02                	je     6e2 <gettoken+0x42>
        *q = s;
     6e0:	89 37                	mov    %esi,(%edi)
    ret = *s;
     6e2:	0f be 06             	movsbl (%esi),%eax
    switch (*s) {
     6e5:	3c 29                	cmp    $0x29,%al
     6e7:	7f 57                	jg     740 <gettoken+0xa0>
     6e9:	3c 28                	cmp    $0x28,%al
     6eb:	0f 8d cb 00 00 00    	jge    7bc <gettoken+0x11c>
     6f1:	31 ff                	xor    %edi,%edi
     6f3:	84 c0                	test   %al,%al
     6f5:	0f 85 cd 00 00 00    	jne    7c8 <gettoken+0x128>
            ret = 'a';
            while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if (eq)
     6fb:	8b 55 14             	mov    0x14(%ebp),%edx
     6fe:	85 d2                	test   %edx,%edx
     700:	74 05                	je     707 <gettoken+0x67>
        *eq = s;
     702:	8b 45 14             	mov    0x14(%ebp),%eax
     705:	89 30                	mov    %esi,(%eax)

    while (s < es && strchr(whitespace, *s))
     707:	39 de                	cmp    %ebx,%esi
     709:	72 0a                	jb     715 <gettoken+0x75>
     70b:	eb 1f                	jmp    72c <gettoken+0x8c>
     70d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     710:	46                   	inc    %esi
    while (s < es && strchr(whitespace, *s))
     711:	39 f3                	cmp    %esi,%ebx
     713:	74 17                	je     72c <gettoken+0x8c>
     715:	0f be 06             	movsbl (%esi),%eax
     718:	c7 04 24 c8 1b 00 00 	movl   $0x1bc8,(%esp)
     71f:	89 44 24 04          	mov    %eax,0x4(%esp)
     723:	e8 68 07 00 00       	call   e90 <strchr>
     728:	85 c0                	test   %eax,%eax
     72a:	75 e4                	jne    710 <gettoken+0x70>
    *ps = s;
     72c:	8b 45 08             	mov    0x8(%ebp),%eax
     72f:	89 30                	mov    %esi,(%eax)
    return ret;
}
     731:	83 c4 1c             	add    $0x1c,%esp
     734:	89 f8                	mov    %edi,%eax
     736:	5b                   	pop    %ebx
     737:	5e                   	pop    %esi
     738:	5f                   	pop    %edi
     739:	5d                   	pop    %ebp
     73a:	c3                   	ret    
     73b:	90                   	nop
     73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch (*s) {
     740:	3c 3e                	cmp    $0x3e,%al
     742:	75 1c                	jne    760 <gettoken+0xc0>
            if (*s == '>') {
     744:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     748:	8d 46 01             	lea    0x1(%esi),%eax
            if (*s == '>') {
     74b:	0f 84 94 00 00 00    	je     7e5 <gettoken+0x145>
            s++;
     751:	89 c6                	mov    %eax,%esi
     753:	bf 3e 00 00 00       	mov    $0x3e,%edi
     758:	eb a1                	jmp    6fb <gettoken+0x5b>
     75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch (*s) {
     760:	7f 56                	jg     7b8 <gettoken+0x118>
     762:	88 c1                	mov    %al,%cl
     764:	80 e9 3b             	sub    $0x3b,%cl
     767:	80 f9 01             	cmp    $0x1,%cl
     76a:	76 50                	jbe    7bc <gettoken+0x11c>
            while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     76c:	39 f3                	cmp    %esi,%ebx
     76e:	77 27                	ja     797 <gettoken+0xf7>
     770:	eb 5e                	jmp    7d0 <gettoken+0x130>
     772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     778:	0f be 06             	movsbl (%esi),%eax
     77b:	c7 04 24 c0 1b 00 00 	movl   $0x1bc0,(%esp)
     782:	89 44 24 04          	mov    %eax,0x4(%esp)
     786:	e8 05 07 00 00       	call   e90 <strchr>
     78b:	85 c0                	test   %eax,%eax
     78d:	75 1c                	jne    7ab <gettoken+0x10b>
                s++;
     78f:	46                   	inc    %esi
            while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     790:	39 f3                	cmp    %esi,%ebx
     792:	74 3c                	je     7d0 <gettoken+0x130>
     794:	0f be 06             	movsbl (%esi),%eax
     797:	89 44 24 04          	mov    %eax,0x4(%esp)
     79b:	c7 04 24 c8 1b 00 00 	movl   $0x1bc8,(%esp)
     7a2:	e8 e9 06 00 00       	call   e90 <strchr>
     7a7:	85 c0                	test   %eax,%eax
     7a9:	74 cd                	je     778 <gettoken+0xd8>
            ret = 'a';
     7ab:	bf 61 00 00 00       	mov    $0x61,%edi
     7b0:	e9 46 ff ff ff       	jmp    6fb <gettoken+0x5b>
     7b5:	8d 76 00             	lea    0x0(%esi),%esi
    switch (*s) {
     7b8:	3c 7c                	cmp    $0x7c,%al
     7ba:	75 b0                	jne    76c <gettoken+0xcc>
    ret = *s;
     7bc:	0f be f8             	movsbl %al,%edi
            s++;
     7bf:	46                   	inc    %esi
            break;
     7c0:	e9 36 ff ff ff       	jmp    6fb <gettoken+0x5b>
     7c5:	8d 76 00             	lea    0x0(%esi),%esi
    switch (*s) {
     7c8:	3c 26                	cmp    $0x26,%al
     7ca:	75 a0                	jne    76c <gettoken+0xcc>
     7cc:	eb ee                	jmp    7bc <gettoken+0x11c>
     7ce:	66 90                	xchg   %ax,%ax
    if (eq)
     7d0:	8b 45 14             	mov    0x14(%ebp),%eax
     7d3:	bf 61 00 00 00       	mov    $0x61,%edi
     7d8:	85 c0                	test   %eax,%eax
     7da:	0f 85 22 ff ff ff    	jne    702 <gettoken+0x62>
     7e0:	e9 47 ff ff ff       	jmp    72c <gettoken+0x8c>
                s++;
     7e5:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     7e8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     7ed:	e9 09 ff ff ff       	jmp    6fb <gettoken+0x5b>
     7f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <peek>:

int
peek(char **ps, char *es, char *toks) {
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 1c             	sub    $0x1c,%esp
     809:	8b 7d 08             	mov    0x8(%ebp),%edi
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     80f:	8b 1f                	mov    (%edi),%ebx
    while (s < es && strchr(whitespace, *s))
     811:	39 f3                	cmp    %esi,%ebx
     813:	72 10                	jb     825 <peek+0x25>
     815:	eb 25                	jmp    83c <peek+0x3c>
     817:	89 f6                	mov    %esi,%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     820:	43                   	inc    %ebx
    while (s < es && strchr(whitespace, *s))
     821:	39 de                	cmp    %ebx,%esi
     823:	74 17                	je     83c <peek+0x3c>
     825:	0f be 03             	movsbl (%ebx),%eax
     828:	c7 04 24 c8 1b 00 00 	movl   $0x1bc8,(%esp)
     82f:	89 44 24 04          	mov    %eax,0x4(%esp)
     833:	e8 58 06 00 00       	call   e90 <strchr>
     838:	85 c0                	test   %eax,%eax
     83a:	75 e4                	jne    820 <peek+0x20>
    *ps = s;
     83c:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     83e:	31 c0                	xor    %eax,%eax
     840:	0f be 13             	movsbl (%ebx),%edx
     843:	84 d2                	test   %dl,%dl
     845:	74 17                	je     85e <peek+0x5e>
     847:	8b 45 10             	mov    0x10(%ebp),%eax
     84a:	89 54 24 04          	mov    %edx,0x4(%esp)
     84e:	89 04 24             	mov    %eax,(%esp)
     851:	e8 3a 06 00 00       	call   e90 <strchr>
     856:	85 c0                	test   %eax,%eax
     858:	0f 95 c0             	setne  %al
     85b:	0f b6 c0             	movzbl %al,%eax
}
     85e:	83 c4 1c             	add    $0x1c,%esp
     861:	5b                   	pop    %ebx
     862:	5e                   	pop    %esi
     863:	5f                   	pop    %edi
     864:	5d                   	pop    %ebp
     865:	c3                   	ret    
     866:	8d 76 00             	lea    0x0(%esi),%esi
     869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000870 <parseredirs>:
    }
    return cmd;
}

struct cmd *
parseredirs(struct cmd *cmd, char **ps, char *es) {
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 3c             	sub    $0x3c,%esp
     879:	8b 75 0c             	mov    0xc(%ebp),%esi
     87c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     87f:	90                   	nop
    int tok;
    char *q, *eq;

    while (peek(ps, es, "<>")) {
     880:	b8 48 15 00 00       	mov    $0x1548,%eax
     885:	89 44 24 08          	mov    %eax,0x8(%esp)
     889:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     88d:	89 34 24             	mov    %esi,(%esp)
     890:	e8 6b ff ff ff       	call   800 <peek>
     895:	85 c0                	test   %eax,%eax
     897:	0f 84 93 00 00 00    	je     930 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     89d:	31 c0                	xor    %eax,%eax
     89f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     8a3:	31 c0                	xor    %eax,%eax
     8a5:	89 44 24 08          	mov    %eax,0x8(%esp)
     8a9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     8ad:	89 34 24             	mov    %esi,(%esp)
     8b0:	e8 eb fd ff ff       	call   6a0 <gettoken>
        if (gettoken(ps, es, &q, &eq) != 'a')
     8b5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     8b9:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     8bc:	89 c7                	mov    %eax,%edi
        if (gettoken(ps, es, &q, &eq) != 'a')
     8be:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
     8c5:	8d 45 e0             	lea    -0x20(%ebp),%eax
     8c8:	89 44 24 08          	mov    %eax,0x8(%esp)
     8cc:	e8 cf fd ff ff       	call   6a0 <gettoken>
     8d1:	83 f8 61             	cmp    $0x61,%eax
     8d4:	75 65                	jne    93b <parseredirs+0xcb>
            panic("missing file for redirection");
        switch (tok) {
     8d6:	83 ff 3c             	cmp    $0x3c,%edi
     8d9:	74 45                	je     920 <parseredirs+0xb0>
     8db:	83 ff 3e             	cmp    $0x3e,%edi
     8de:	66 90                	xchg   %ax,%ax
     8e0:	74 05                	je     8e7 <parseredirs+0x77>
     8e2:	83 ff 2b             	cmp    $0x2b,%edi
     8e5:	75 99                	jne    880 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
     8e7:	ba 01 00 00 00       	mov    $0x1,%edx
     8ec:	b9 01 02 00 00       	mov    $0x201,%ecx
     8f1:	89 54 24 10          	mov    %edx,0x10(%esp)
     8f5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     8f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8fc:	89 44 24 08          	mov    %eax,0x8(%esp)
     900:	8b 45 e0             	mov    -0x20(%ebp),%eax
     903:	89 44 24 04          	mov    %eax,0x4(%esp)
     907:	8b 45 08             	mov    0x8(%ebp),%eax
     90a:	89 04 24             	mov    %eax,(%esp)
     90d:	e8 4e fc ff ff       	call   560 <redircmd>
     912:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     915:	e9 66 ff ff ff       	jmp    880 <parseredirs+0x10>
     91a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     920:	31 ff                	xor    %edi,%edi
     922:	31 c0                	xor    %eax,%eax
     924:	89 7c 24 10          	mov    %edi,0x10(%esp)
     928:	89 44 24 0c          	mov    %eax,0xc(%esp)
     92c:	eb cb                	jmp    8f9 <parseredirs+0x89>
     92e:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     930:	8b 45 08             	mov    0x8(%ebp),%eax
     933:	83 c4 3c             	add    $0x3c,%esp
     936:	5b                   	pop    %ebx
     937:	5e                   	pop    %esi
     938:	5f                   	pop    %edi
     939:	5d                   	pop    %ebp
     93a:	c3                   	ret    
            panic("missing file for redirection");
     93b:	c7 04 24 2b 15 00 00 	movl   $0x152b,(%esp)
     942:	e8 39 f8 ff ff       	call   180 <panic>
     947:	89 f6                	mov    %esi,%esi
     949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000950 <parseexec>:
    cmd = parseredirs(cmd, ps, es);
    return cmd;
}

struct cmd *
parseexec(char **ps, char *es) {
     950:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if (peek(ps, es, "("))
     951:	ba 4b 15 00 00       	mov    $0x154b,%edx
parseexec(char **ps, char *es) {
     956:	89 e5                	mov    %esp,%ebp
     958:	57                   	push   %edi
     959:	56                   	push   %esi
     95a:	53                   	push   %ebx
     95b:	83 ec 3c             	sub    $0x3c,%esp
     95e:	8b 75 08             	mov    0x8(%ebp),%esi
     961:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if (peek(ps, es, "("))
     964:	89 54 24 08          	mov    %edx,0x8(%esp)
     968:	89 34 24             	mov    %esi,(%esp)
     96b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     96f:	e8 8c fe ff ff       	call   800 <peek>
     974:	85 c0                	test   %eax,%eax
     976:	0f 85 9c 00 00 00    	jne    a18 <parseexec+0xc8>
     97c:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     97e:	e8 9d fb ff ff       	call   520 <execcmd>
    cmd = (struct execcmd *) ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     983:	89 7c 24 08          	mov    %edi,0x8(%esp)
     987:	89 74 24 04          	mov    %esi,0x4(%esp)
     98b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     98e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     991:	e8 da fe ff ff       	call   870 <parseredirs>
     996:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     999:	eb 1b                	jmp    9b6 <parseexec+0x66>
     99b:	90                   	nop
     99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if (argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     9a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     9a3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     9a7:	89 74 24 04          	mov    %esi,0x4(%esp)
     9ab:	89 04 24             	mov    %eax,(%esp)
     9ae:	e8 bd fe ff ff       	call   870 <parseredirs>
     9b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (!peek(ps, es, "|)&;")) {
     9b6:	b8 62 15 00 00       	mov    $0x1562,%eax
     9bb:	89 44 24 08          	mov    %eax,0x8(%esp)
     9bf:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9c3:	89 34 24             	mov    %esi,(%esp)
     9c6:	e8 35 fe ff ff       	call   800 <peek>
     9cb:	85 c0                	test   %eax,%eax
     9cd:	75 69                	jne    a38 <parseexec+0xe8>
        if ((tok = gettoken(ps, es, &q, &eq)) == 0)
     9cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     9d2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     9d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9d9:	89 44 24 08          	mov    %eax,0x8(%esp)
     9dd:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9e1:	89 34 24             	mov    %esi,(%esp)
     9e4:	e8 b7 fc ff ff       	call   6a0 <gettoken>
     9e9:	85 c0                	test   %eax,%eax
     9eb:	74 4b                	je     a38 <parseexec+0xe8>
        if (tok != 'a')
     9ed:	83 f8 61             	cmp    $0x61,%eax
     9f0:	75 65                	jne    a57 <parseexec+0x107>
        cmd->argv[argc] = q;
     9f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9f5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9f8:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     9fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ff:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     a03:	43                   	inc    %ebx
        if (argc >= MAXARGS)
     a04:	83 fb 0a             	cmp    $0xa,%ebx
     a07:	75 97                	jne    9a0 <parseexec+0x50>
            panic("too many args");
     a09:	c7 04 24 54 15 00 00 	movl   $0x1554,(%esp)
     a10:	e8 6b f7 ff ff       	call   180 <panic>
     a15:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     a18:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a1c:	89 34 24             	mov    %esi,(%esp)
     a1f:	e8 9c 01 00 00       	call   bc0 <parseblock>
     a24:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     a27:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a2a:	83 c4 3c             	add    $0x3c,%esp
     a2d:	5b                   	pop    %ebx
     a2e:	5e                   	pop    %esi
     a2f:	5f                   	pop    %edi
     a30:	5d                   	pop    %ebp
     a31:	c3                   	ret    
     a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a38:	8b 45 d0             	mov    -0x30(%ebp),%eax
     a3b:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     a3e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     a45:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     a4c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a4f:	83 c4 3c             	add    $0x3c,%esp
     a52:	5b                   	pop    %ebx
     a53:	5e                   	pop    %esi
     a54:	5f                   	pop    %edi
     a55:	5d                   	pop    %ebp
     a56:	c3                   	ret    
            panic("syntax");
     a57:	c7 04 24 4d 15 00 00 	movl   $0x154d,(%esp)
     a5e:	e8 1d f7 ff ff       	call   180 <panic>
     a63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a70 <parsepipe>:
parsepipe(char **ps, char *es) {
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	83 ec 28             	sub    $0x28,%esp
     a76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     a79:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a7c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     a7f:	8b 75 0c             	mov    0xc(%ebp),%esi
     a82:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     a85:	89 1c 24             	mov    %ebx,(%esp)
     a88:	89 74 24 04          	mov    %esi,0x4(%esp)
     a8c:	e8 bf fe ff ff       	call   950 <parseexec>
    if (peek(ps, es, "|")) {
     a91:	b9 67 15 00 00       	mov    $0x1567,%ecx
     a96:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     a9a:	89 74 24 04          	mov    %esi,0x4(%esp)
     a9e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     aa1:	89 c7                	mov    %eax,%edi
    if (peek(ps, es, "|")) {
     aa3:	e8 58 fd ff ff       	call   800 <peek>
     aa8:	85 c0                	test   %eax,%eax
     aaa:	75 14                	jne    ac0 <parsepipe+0x50>
}
     aac:	89 f8                	mov    %edi,%eax
     aae:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ab1:	8b 75 f8             	mov    -0x8(%ebp),%esi
     ab4:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ab7:	89 ec                	mov    %ebp,%esp
     ab9:	5d                   	pop    %ebp
     aba:	c3                   	ret    
     abb:	90                   	nop
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     ac0:	31 d2                	xor    %edx,%edx
     ac2:	31 c0                	xor    %eax,%eax
     ac4:	89 54 24 08          	mov    %edx,0x8(%esp)
     ac8:	89 74 24 04          	mov    %esi,0x4(%esp)
     acc:	89 1c 24             	mov    %ebx,(%esp)
     acf:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ad3:	e8 c8 fb ff ff       	call   6a0 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     ad8:	89 74 24 04          	mov    %esi,0x4(%esp)
     adc:	89 1c 24             	mov    %ebx,(%esp)
     adf:	e8 8c ff ff ff       	call   a70 <parsepipe>
}
     ae4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     ae7:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     aea:	8b 75 f8             	mov    -0x8(%ebp),%esi
     aed:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     af0:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     af3:	89 ec                	mov    %ebp,%esp
     af5:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     af6:	e9 c5 fa ff ff       	jmp    5c0 <pipecmd>
     afb:	90                   	nop
     afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b00 <parseline>:
parseline(char **ps, char *es) {
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	57                   	push   %edi
     b04:	56                   	push   %esi
     b05:	53                   	push   %ebx
     b06:	83 ec 1c             	sub    $0x1c,%esp
     b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     b0f:	89 1c 24             	mov    %ebx,(%esp)
     b12:	89 74 24 04          	mov    %esi,0x4(%esp)
     b16:	e8 55 ff ff ff       	call   a70 <parsepipe>
     b1b:	89 c7                	mov    %eax,%edi
    while (peek(ps, es, "&")) {
     b1d:	eb 23                	jmp    b42 <parseline+0x42>
     b1f:	90                   	nop
        gettoken(ps, es, 0, 0);
     b20:	31 c0                	xor    %eax,%eax
     b22:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b26:	31 c0                	xor    %eax,%eax
     b28:	89 44 24 08          	mov    %eax,0x8(%esp)
     b2c:	89 74 24 04          	mov    %esi,0x4(%esp)
     b30:	89 1c 24             	mov    %ebx,(%esp)
     b33:	e8 68 fb ff ff       	call   6a0 <gettoken>
        cmd = backcmd(cmd);
     b38:	89 3c 24             	mov    %edi,(%esp)
     b3b:	e8 20 fb ff ff       	call   660 <backcmd>
     b40:	89 c7                	mov    %eax,%edi
    while (peek(ps, es, "&")) {
     b42:	b8 69 15 00 00       	mov    $0x1569,%eax
     b47:	89 44 24 08          	mov    %eax,0x8(%esp)
     b4b:	89 74 24 04          	mov    %esi,0x4(%esp)
     b4f:	89 1c 24             	mov    %ebx,(%esp)
     b52:	e8 a9 fc ff ff       	call   800 <peek>
     b57:	85 c0                	test   %eax,%eax
     b59:	75 c5                	jne    b20 <parseline+0x20>
    if (peek(ps, es, ";")) {
     b5b:	b9 65 15 00 00       	mov    $0x1565,%ecx
     b60:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     b64:	89 74 24 04          	mov    %esi,0x4(%esp)
     b68:	89 1c 24             	mov    %ebx,(%esp)
     b6b:	e8 90 fc ff ff       	call   800 <peek>
     b70:	85 c0                	test   %eax,%eax
     b72:	75 0c                	jne    b80 <parseline+0x80>
}
     b74:	83 c4 1c             	add    $0x1c,%esp
     b77:	89 f8                	mov    %edi,%eax
     b79:	5b                   	pop    %ebx
     b7a:	5e                   	pop    %esi
     b7b:	5f                   	pop    %edi
     b7c:	5d                   	pop    %ebp
     b7d:	c3                   	ret    
     b7e:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     b80:	31 d2                	xor    %edx,%edx
     b82:	31 c0                	xor    %eax,%eax
     b84:	89 54 24 08          	mov    %edx,0x8(%esp)
     b88:	89 74 24 04          	mov    %esi,0x4(%esp)
     b8c:	89 1c 24             	mov    %ebx,(%esp)
     b8f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b93:	e8 08 fb ff ff       	call   6a0 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     b98:	89 74 24 04          	mov    %esi,0x4(%esp)
     b9c:	89 1c 24             	mov    %ebx,(%esp)
     b9f:	e8 5c ff ff ff       	call   b00 <parseline>
     ba4:	89 7d 08             	mov    %edi,0x8(%ebp)
     ba7:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     baa:	83 c4 1c             	add    $0x1c,%esp
     bad:	5b                   	pop    %ebx
     bae:	5e                   	pop    %esi
     baf:	5f                   	pop    %edi
     bb0:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     bb1:	e9 5a fa ff ff       	jmp    610 <listcmd>
     bb6:	8d 76 00             	lea    0x0(%esi),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bc0 <parseblock>:
parseblock(char **ps, char *es) {
     bc0:	55                   	push   %ebp
    if (!peek(ps, es, "("))
     bc1:	b8 4b 15 00 00       	mov    $0x154b,%eax
parseblock(char **ps, char *es) {
     bc6:	89 e5                	mov    %esp,%ebp
     bc8:	83 ec 28             	sub    $0x28,%esp
     bcb:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     bce:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bd1:	89 75 f8             	mov    %esi,-0x8(%ebp)
     bd4:	8b 75 0c             	mov    0xc(%ebp),%esi
    if (!peek(ps, es, "("))
     bd7:	89 44 24 08          	mov    %eax,0x8(%esp)
parseblock(char **ps, char *es) {
     bdb:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if (!peek(ps, es, "("))
     bde:	89 1c 24             	mov    %ebx,(%esp)
     be1:	89 74 24 04          	mov    %esi,0x4(%esp)
     be5:	e8 16 fc ff ff       	call   800 <peek>
     bea:	85 c0                	test   %eax,%eax
     bec:	74 74                	je     c62 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     bee:	31 c9                	xor    %ecx,%ecx
     bf0:	31 ff                	xor    %edi,%edi
     bf2:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     bf6:	89 7c 24 08          	mov    %edi,0x8(%esp)
     bfa:	89 74 24 04          	mov    %esi,0x4(%esp)
     bfe:	89 1c 24             	mov    %ebx,(%esp)
     c01:	e8 9a fa ff ff       	call   6a0 <gettoken>
    cmd = parseline(ps, es);
     c06:	89 74 24 04          	mov    %esi,0x4(%esp)
     c0a:	89 1c 24             	mov    %ebx,(%esp)
     c0d:	e8 ee fe ff ff       	call   b00 <parseline>
    if (!peek(ps, es, ")"))
     c12:	89 74 24 04          	mov    %esi,0x4(%esp)
     c16:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     c19:	89 c7                	mov    %eax,%edi
    if (!peek(ps, es, ")"))
     c1b:	b8 87 15 00 00       	mov    $0x1587,%eax
     c20:	89 44 24 08          	mov    %eax,0x8(%esp)
     c24:	e8 d7 fb ff ff       	call   800 <peek>
     c29:	85 c0                	test   %eax,%eax
     c2b:	74 41                	je     c6e <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     c2d:	31 d2                	xor    %edx,%edx
     c2f:	31 c0                	xor    %eax,%eax
     c31:	89 54 24 08          	mov    %edx,0x8(%esp)
     c35:	89 74 24 04          	mov    %esi,0x4(%esp)
     c39:	89 1c 24             	mov    %ebx,(%esp)
     c3c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c40:	e8 5b fa ff ff       	call   6a0 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     c45:	89 74 24 08          	mov    %esi,0x8(%esp)
     c49:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     c4d:	89 3c 24             	mov    %edi,(%esp)
     c50:	e8 1b fc ff ff       	call   870 <parseredirs>
}
     c55:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c58:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c5b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c5e:	89 ec                	mov    %ebp,%esp
     c60:	5d                   	pop    %ebp
     c61:	c3                   	ret    
        panic("parseblock");
     c62:	c7 04 24 6b 15 00 00 	movl   $0x156b,(%esp)
     c69:	e8 12 f5 ff ff       	call   180 <panic>
        panic("syntax - missing )");
     c6e:	c7 04 24 76 15 00 00 	movl   $0x1576,(%esp)
     c75:	e8 06 f5 ff ff       	call   180 <panic>
     c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c80 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd *
nulterminate(struct cmd *cmd) {
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	53                   	push   %ebx
     c84:	83 ec 14             	sub    $0x14,%esp
     c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if (cmd == 0)
     c8a:	85 db                	test   %ebx,%ebx
     c8c:	74 1d                	je     cab <nulterminate+0x2b>
        return 0;

    switch (cmd->type) {
     c8e:	83 3b 05             	cmpl   $0x5,(%ebx)
     c91:	77 18                	ja     cab <nulterminate+0x2b>
     c93:	8b 03                	mov    (%ebx),%eax
     c95:	ff 24 85 c8 15 00 00 	jmp    *0x15c8(,%eax,4)
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd *) cmd;
            nulterminate(bcmd->cmd);
     ca0:	8b 43 04             	mov    0x4(%ebx),%eax
     ca3:	89 04 24             	mov    %eax,(%esp)
     ca6:	e8 d5 ff ff ff       	call   c80 <nulterminate>
            break;
    }
    return cmd;
}
     cab:	83 c4 14             	add    $0x14,%esp
     cae:	89 d8                	mov    %ebx,%eax
     cb0:	5b                   	pop    %ebx
     cb1:	5d                   	pop    %ebp
     cb2:	c3                   	ret    
     cb3:	90                   	nop
     cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     cb8:	8b 43 04             	mov    0x4(%ebx),%eax
     cbb:	89 04 24             	mov    %eax,(%esp)
     cbe:	e8 bd ff ff ff       	call   c80 <nulterminate>
            nulterminate(lcmd->right);
     cc3:	8b 43 08             	mov    0x8(%ebx),%eax
     cc6:	89 04 24             	mov    %eax,(%esp)
     cc9:	e8 b2 ff ff ff       	call   c80 <nulterminate>
}
     cce:	83 c4 14             	add    $0x14,%esp
     cd1:	89 d8                	mov    %ebx,%eax
     cd3:	5b                   	pop    %ebx
     cd4:	5d                   	pop    %ebp
     cd5:	c3                   	ret    
     cd6:	8d 76 00             	lea    0x0(%esi),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for (i = 0; ecmd->argv[i]; i++)
     ce0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     ce3:	8d 43 08             	lea    0x8(%ebx),%eax
     ce6:	85 c9                	test   %ecx,%ecx
     ce8:	74 c1                	je     cab <nulterminate+0x2b>
     cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     cf0:	8b 50 24             	mov    0x24(%eax),%edx
     cf3:	83 c0 04             	add    $0x4,%eax
     cf6:	c6 02 00             	movb   $0x0,(%edx)
            for (i = 0; ecmd->argv[i]; i++)
     cf9:	8b 50 fc             	mov    -0x4(%eax),%edx
     cfc:	85 d2                	test   %edx,%edx
     cfe:	75 f0                	jne    cf0 <nulterminate+0x70>
}
     d00:	83 c4 14             	add    $0x14,%esp
     d03:	89 d8                	mov    %ebx,%eax
     d05:	5b                   	pop    %ebx
     d06:	5d                   	pop    %ebp
     d07:	c3                   	ret    
     d08:	90                   	nop
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     d10:	8b 43 04             	mov    0x4(%ebx),%eax
     d13:	89 04 24             	mov    %eax,(%esp)
     d16:	e8 65 ff ff ff       	call   c80 <nulterminate>
            *rcmd->efile = 0;
     d1b:	8b 43 0c             	mov    0xc(%ebx),%eax
     d1e:	c6 00 00             	movb   $0x0,(%eax)
}
     d21:	83 c4 14             	add    $0x14,%esp
     d24:	89 d8                	mov    %ebx,%eax
     d26:	5b                   	pop    %ebx
     d27:	5d                   	pop    %ebp
     d28:	c3                   	ret    
     d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d30 <parsecmd>:
parsecmd(char *s) {
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	56                   	push   %esi
     d34:	53                   	push   %ebx
     d35:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     d38:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d3b:	89 1c 24             	mov    %ebx,(%esp)
     d3e:	e8 fd 00 00 00       	call   e40 <strlen>
     d43:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     d45:	8d 45 08             	lea    0x8(%ebp),%eax
     d48:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     d4c:	89 04 24             	mov    %eax,(%esp)
     d4f:	e8 ac fd ff ff       	call   b00 <parseline>
    peek(&s, es, "");
     d54:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     d58:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     d5a:	b8 10 15 00 00       	mov    $0x1510,%eax
     d5f:	89 44 24 08          	mov    %eax,0x8(%esp)
     d63:	8d 45 08             	lea    0x8(%ebp),%eax
     d66:	89 04 24             	mov    %eax,(%esp)
     d69:	e8 92 fa ff ff       	call   800 <peek>
    if (s != es) {
     d6e:	8b 45 08             	mov    0x8(%ebp),%eax
     d71:	39 d8                	cmp    %ebx,%eax
     d73:	75 11                	jne    d86 <parsecmd+0x56>
    nulterminate(cmd);
     d75:	89 34 24             	mov    %esi,(%esp)
     d78:	e8 03 ff ff ff       	call   c80 <nulterminate>
}
     d7d:	83 c4 10             	add    $0x10,%esp
     d80:	89 f0                	mov    %esi,%eax
     d82:	5b                   	pop    %ebx
     d83:	5e                   	pop    %esi
     d84:	5d                   	pop    %ebp
     d85:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
     d86:	89 44 24 08          	mov    %eax,0x8(%esp)
     d8a:	c7 44 24 04 89 15 00 	movl   $0x1589,0x4(%esp)
     d91:	00 
     d92:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     d99:	e8 d2 03 00 00       	call   1170 <printf>
        panic("syntax");
     d9e:	c7 04 24 4d 15 00 00 	movl   $0x154d,(%esp)
     da5:	e8 d6 f3 ff ff       	call   180 <panic>
     daa:	66 90                	xchg   %ax,%ax
     dac:	66 90                	xchg   %ax,%ax
     dae:	66 90                	xchg   %ax,%ax

00000db0 <strcpy>:
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char *
strcpy(char *s, const char *t) {
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     db9:	53                   	push   %ebx
    char *os;

    os = s;
    while ((*s++ = *t++) != 0);
     dba:	89 c2                	mov    %eax,%edx
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dc0:	41                   	inc    %ecx
     dc1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     dc5:	42                   	inc    %edx
     dc6:	84 db                	test   %bl,%bl
     dc8:	88 5a ff             	mov    %bl,-0x1(%edx)
     dcb:	75 f3                	jne    dc0 <strcpy+0x10>
    return os;
}
     dcd:	5b                   	pop    %ebx
     dce:	5d                   	pop    %ebp
     dcf:	c3                   	ret    

00000dd0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
     dd0:	55                   	push   %ebp
    char *os;

    os = s;
    while((n--) > 0 && ((*s++ = *t++) != 0));
     dd1:	31 d2                	xor    %edx,%edx
{
     dd3:	89 e5                	mov    %esp,%ebp
     dd5:	56                   	push   %esi
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
     dd9:	53                   	push   %ebx
     dda:	8b 75 0c             	mov    0xc(%ebp),%esi
     ddd:	8b 5d 10             	mov    0x10(%ebp),%ebx
    while((n--) > 0 && ((*s++ = *t++) != 0));
     de0:	eb 12                	jmp    df4 <strncpy+0x24>
     de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     de8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     def:	42                   	inc    %edx
     df0:	84 c9                	test   %cl,%cl
     df2:	74 08                	je     dfc <strncpy+0x2c>
     df4:	89 d9                	mov    %ebx,%ecx
     df6:	29 d1                	sub    %edx,%ecx
     df8:	85 c9                	test   %ecx,%ecx
     dfa:	7f ec                	jg     de8 <strncpy+0x18>
    return os;
}
     dfc:	5b                   	pop    %ebx
     dfd:	5e                   	pop    %esi
     dfe:	5d                   	pop    %ebp
     dff:	c3                   	ret    

00000e00 <strcmp>:

int
strcmp(const char *p, const char *q) {
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e06:	53                   	push   %ebx
     e07:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p && *p == *q)
     e0a:	0f b6 01             	movzbl (%ecx),%eax
     e0d:	0f b6 13             	movzbl (%ebx),%edx
     e10:	84 c0                	test   %al,%al
     e12:	75 18                	jne    e2c <strcmp+0x2c>
     e14:	eb 22                	jmp    e38 <strcmp+0x38>
     e16:	8d 76 00             	lea    0x0(%esi),%esi
     e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p++, q++;
     e20:	41                   	inc    %ecx
    while (*p && *p == *q)
     e21:	0f b6 01             	movzbl (%ecx),%eax
        p++, q++;
     e24:	43                   	inc    %ebx
     e25:	0f b6 13             	movzbl (%ebx),%edx
    while (*p && *p == *q)
     e28:	84 c0                	test   %al,%al
     e2a:	74 0c                	je     e38 <strcmp+0x38>
     e2c:	38 d0                	cmp    %dl,%al
     e2e:	74 f0                	je     e20 <strcmp+0x20>
    return (uchar) *p - (uchar) *q;
}
     e30:	5b                   	pop    %ebx
    return (uchar) *p - (uchar) *q;
     e31:	29 d0                	sub    %edx,%eax
}
     e33:	5d                   	pop    %ebp
     e34:	c3                   	ret    
     e35:	8d 76 00             	lea    0x0(%esi),%esi
     e38:	5b                   	pop    %ebx
     e39:	31 c0                	xor    %eax,%eax
    return (uchar) *p - (uchar) *q;
     e3b:	29 d0                	sub    %edx,%eax
}
     e3d:	5d                   	pop    %ebp
     e3e:	c3                   	ret    
     e3f:	90                   	nop

00000e40 <strlen>:

uint
strlen(const char *s) {
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int n;

    for (n = 0; s[n]; n++);
     e46:	80 39 00             	cmpb   $0x0,(%ecx)
     e49:	74 15                	je     e60 <strlen+0x20>
     e4b:	31 d2                	xor    %edx,%edx
     e4d:	8d 76 00             	lea    0x0(%esi),%esi
     e50:	42                   	inc    %edx
     e51:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     e55:	89 d0                	mov    %edx,%eax
     e57:	75 f7                	jne    e50 <strlen+0x10>
    return n;
}
     e59:	5d                   	pop    %ebp
     e5a:	c3                   	ret    
     e5b:	90                   	nop
     e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (n = 0; s[n]; n++);
     e60:	31 c0                	xor    %eax,%eax
}
     e62:	5d                   	pop    %ebp
     e63:	c3                   	ret    
     e64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e70 <memset>:

void *
memset(void *dst, int c, uint n) {
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	8b 55 08             	mov    0x8(%ebp),%edx
     e76:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7d:	89 d7                	mov    %edx,%edi
     e7f:	fc                   	cld    
     e80:	f3 aa                	rep stos %al,%es:(%edi)
    stosb(dst, c, n);
    return dst;
}
     e82:	5f                   	pop    %edi
     e83:	89 d0                	mov    %edx,%eax
     e85:	5d                   	pop    %ebp
     e86:	c3                   	ret    
     e87:	89 f6                	mov    %esi,%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e90 <strchr>:

char *
strchr(const char *s, char c) {
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    for (; *s; s++)
     e9a:	0f b6 10             	movzbl (%eax),%edx
     e9d:	84 d2                	test   %dl,%dl
     e9f:	74 1b                	je     ebc <strchr+0x2c>
        if (*s == c)
     ea1:	38 d1                	cmp    %dl,%cl
     ea3:	75 0f                	jne    eb4 <strchr+0x24>
     ea5:	eb 17                	jmp    ebe <strchr+0x2e>
     ea7:	89 f6                	mov    %esi,%esi
     ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     eb0:	38 ca                	cmp    %cl,%dl
     eb2:	74 0a                	je     ebe <strchr+0x2e>
    for (; *s; s++)
     eb4:	40                   	inc    %eax
     eb5:	0f b6 10             	movzbl (%eax),%edx
     eb8:	84 d2                	test   %dl,%dl
     eba:	75 f4                	jne    eb0 <strchr+0x20>
            return (char *) s;
    return 0;
     ebc:	31 c0                	xor    %eax,%eax
}
     ebe:	5d                   	pop    %ebp
     ebf:	c3                   	ret    

00000ec0 <gets>:

char *
gets(char *buf, int max) {
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	57                   	push   %edi
     ec4:	56                   	push   %esi
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     ec5:	31 f6                	xor    %esi,%esi
gets(char *buf, int max) {
     ec7:	53                   	push   %ebx
     ec8:	83 ec 3c             	sub    $0x3c,%esp
     ecb:	8b 5d 08             	mov    0x8(%ebp),%ebx
        cc = read(0, &c, 1);
     ece:	8d 7d e7             	lea    -0x19(%ebp),%edi
    for (i = 0; i + 1 < max;) {
     ed1:	eb 32                	jmp    f05 <gets+0x45>
     ed3:	90                   	nop
     ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cc = read(0, &c, 1);
     ed8:	ba 01 00 00 00       	mov    $0x1,%edx
     edd:	89 54 24 08          	mov    %edx,0x8(%esp)
     ee1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ee5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eec:	e8 2f 01 00 00       	call   1020 <read>
        if (cc < 1)
     ef1:	85 c0                	test   %eax,%eax
     ef3:	7e 19                	jle    f0e <gets+0x4e>
            break;
        buf[i++] = c;
     ef5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ef9:	43                   	inc    %ebx
     efa:	88 43 ff             	mov    %al,-0x1(%ebx)
        if (c == '\n' || c == '\r')
     efd:	3c 0a                	cmp    $0xa,%al
     eff:	74 1f                	je     f20 <gets+0x60>
     f01:	3c 0d                	cmp    $0xd,%al
     f03:	74 1b                	je     f20 <gets+0x60>
    for (i = 0; i + 1 < max;) {
     f05:	46                   	inc    %esi
     f06:	3b 75 0c             	cmp    0xc(%ebp),%esi
     f09:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     f0c:	7c ca                	jl     ed8 <gets+0x18>
            break;
    }
    buf[i] = '\0';
     f0e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f11:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
}
     f14:	8b 45 08             	mov    0x8(%ebp),%eax
     f17:	83 c4 3c             	add    $0x3c,%esp
     f1a:	5b                   	pop    %ebx
     f1b:	5e                   	pop    %esi
     f1c:	5f                   	pop    %edi
     f1d:	5d                   	pop    %ebp
     f1e:	c3                   	ret    
     f1f:	90                   	nop
     f20:	8b 45 08             	mov    0x8(%ebp),%eax
     f23:	01 c6                	add    %eax,%esi
     f25:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     f28:	eb e4                	jmp    f0e <gets+0x4e>
     f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f30 <stat>:

int
stat(const char *n, struct stat *st) {
     f30:	55                   	push   %ebp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     f31:	31 c0                	xor    %eax,%eax
stat(const char *n, struct stat *st) {
     f33:	89 e5                	mov    %esp,%ebp
     f35:	83 ec 18             	sub    $0x18,%esp
    fd = open(n, O_RDONLY);
     f38:	89 44 24 04          	mov    %eax,0x4(%esp)
     f3c:	8b 45 08             	mov    0x8(%ebp),%eax
stat(const char *n, struct stat *st) {
     f3f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     f42:	89 75 fc             	mov    %esi,-0x4(%ebp)
    fd = open(n, O_RDONLY);
     f45:	89 04 24             	mov    %eax,(%esp)
     f48:	e8 fb 00 00 00       	call   1048 <open>
    if (fd < 0)
     f4d:	85 c0                	test   %eax,%eax
     f4f:	78 2f                	js     f80 <stat+0x50>
     f51:	89 c3                	mov    %eax,%ebx
        return -1;
    r = fstat(fd, st);
     f53:	8b 45 0c             	mov    0xc(%ebp),%eax
     f56:	89 1c 24             	mov    %ebx,(%esp)
     f59:	89 44 24 04          	mov    %eax,0x4(%esp)
     f5d:	e8 fe 00 00 00       	call   1060 <fstat>
    close(fd);
     f62:	89 1c 24             	mov    %ebx,(%esp)
    r = fstat(fd, st);
     f65:	89 c6                	mov    %eax,%esi
    close(fd);
     f67:	e8 c4 00 00 00       	call   1030 <close>
    return r;
}
     f6c:	89 f0                	mov    %esi,%eax
     f6e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     f71:	8b 75 fc             	mov    -0x4(%ebp),%esi
     f74:	89 ec                	mov    %ebp,%esp
     f76:	5d                   	pop    %ebp
     f77:	c3                   	ret    
     f78:	90                   	nop
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
     f80:	be ff ff ff ff       	mov    $0xffffffff,%esi
     f85:	eb e5                	jmp    f6c <stat+0x3c>
     f87:	89 f6                	mov    %esi,%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f90 <atoi>:

int
atoi(const char *s) {
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f96:	53                   	push   %ebx
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     f97:	0f be 11             	movsbl (%ecx),%edx
     f9a:	88 d0                	mov    %dl,%al
     f9c:	2c 30                	sub    $0x30,%al
     f9e:	3c 09                	cmp    $0x9,%al
    n = 0;
     fa0:	b8 00 00 00 00       	mov    $0x0,%eax
    while ('0' <= *s && *s <= '9')
     fa5:	77 1e                	ja     fc5 <atoi+0x35>
     fa7:	89 f6                	mov    %esi,%esi
     fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        n = n * 10 + *s++ - '0';
     fb0:	41                   	inc    %ecx
     fb1:	8d 04 80             	lea    (%eax,%eax,4),%eax
     fb4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    while ('0' <= *s && *s <= '9')
     fb8:	0f be 11             	movsbl (%ecx),%edx
     fbb:	88 d3                	mov    %dl,%bl
     fbd:	80 eb 30             	sub    $0x30,%bl
     fc0:	80 fb 09             	cmp    $0x9,%bl
     fc3:	76 eb                	jbe    fb0 <atoi+0x20>
    return n;
}
     fc5:	5b                   	pop    %ebx
     fc6:	5d                   	pop    %ebp
     fc7:	c3                   	ret    
     fc8:	90                   	nop
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fd0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n) {
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	56                   	push   %esi
     fd4:	8b 45 08             	mov    0x8(%ebp),%eax
     fd7:	53                   	push   %ebx
     fd8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     fdb:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    while (n-- > 0)
     fde:	85 db                	test   %ebx,%ebx
     fe0:	7e 1a                	jle    ffc <memmove+0x2c>
     fe2:	31 d2                	xor    %edx,%edx
     fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        *dst++ = *src++;
     ff0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     ff4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     ff7:	42                   	inc    %edx
    while (n-- > 0)
     ff8:	39 d3                	cmp    %edx,%ebx
     ffa:	75 f4                	jne    ff0 <memmove+0x20>
    return vdst;
}
     ffc:	5b                   	pop    %ebx
     ffd:	5e                   	pop    %esi
     ffe:	5d                   	pop    %ebp
     fff:	c3                   	ret    

00001000 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1000:	b8 01 00 00 00       	mov    $0x1,%eax
    1005:	cd 40                	int    $0x40
    1007:	c3                   	ret    

00001008 <exit>:
SYSCALL(exit)
    1008:	b8 02 00 00 00       	mov    $0x2,%eax
    100d:	cd 40                	int    $0x40
    100f:	c3                   	ret    

00001010 <wait>:
SYSCALL(wait)
    1010:	b8 03 00 00 00       	mov    $0x3,%eax
    1015:	cd 40                	int    $0x40
    1017:	c3                   	ret    

00001018 <pipe>:
SYSCALL(pipe)
    1018:	b8 04 00 00 00       	mov    $0x4,%eax
    101d:	cd 40                	int    $0x40
    101f:	c3                   	ret    

00001020 <read>:
SYSCALL(read)
    1020:	b8 05 00 00 00       	mov    $0x5,%eax
    1025:	cd 40                	int    $0x40
    1027:	c3                   	ret    

00001028 <write>:
SYSCALL(write)
    1028:	b8 10 00 00 00       	mov    $0x10,%eax
    102d:	cd 40                	int    $0x40
    102f:	c3                   	ret    

00001030 <close>:
SYSCALL(close)
    1030:	b8 15 00 00 00       	mov    $0x15,%eax
    1035:	cd 40                	int    $0x40
    1037:	c3                   	ret    

00001038 <kill>:
SYSCALL(kill)
    1038:	b8 06 00 00 00       	mov    $0x6,%eax
    103d:	cd 40                	int    $0x40
    103f:	c3                   	ret    

00001040 <exec>:
SYSCALL(exec)
    1040:	b8 07 00 00 00       	mov    $0x7,%eax
    1045:	cd 40                	int    $0x40
    1047:	c3                   	ret    

00001048 <open>:
SYSCALL(open)
    1048:	b8 0f 00 00 00       	mov    $0xf,%eax
    104d:	cd 40                	int    $0x40
    104f:	c3                   	ret    

00001050 <mknod>:
SYSCALL(mknod)
    1050:	b8 11 00 00 00       	mov    $0x11,%eax
    1055:	cd 40                	int    $0x40
    1057:	c3                   	ret    

00001058 <unlink>:
SYSCALL(unlink)
    1058:	b8 12 00 00 00       	mov    $0x12,%eax
    105d:	cd 40                	int    $0x40
    105f:	c3                   	ret    

00001060 <fstat>:
SYSCALL(fstat)
    1060:	b8 08 00 00 00       	mov    $0x8,%eax
    1065:	cd 40                	int    $0x40
    1067:	c3                   	ret    

00001068 <link>:
SYSCALL(link)
    1068:	b8 13 00 00 00       	mov    $0x13,%eax
    106d:	cd 40                	int    $0x40
    106f:	c3                   	ret    

00001070 <mkdir>:
SYSCALL(mkdir)
    1070:	b8 14 00 00 00       	mov    $0x14,%eax
    1075:	cd 40                	int    $0x40
    1077:	c3                   	ret    

00001078 <chdir>:
SYSCALL(chdir)
    1078:	b8 09 00 00 00       	mov    $0x9,%eax
    107d:	cd 40                	int    $0x40
    107f:	c3                   	ret    

00001080 <dup>:
SYSCALL(dup)
    1080:	b8 0a 00 00 00       	mov    $0xa,%eax
    1085:	cd 40                	int    $0x40
    1087:	c3                   	ret    

00001088 <getpid>:
SYSCALL(getpid)
    1088:	b8 0b 00 00 00       	mov    $0xb,%eax
    108d:	cd 40                	int    $0x40
    108f:	c3                   	ret    

00001090 <sbrk>:
SYSCALL(sbrk)
    1090:	b8 0c 00 00 00       	mov    $0xc,%eax
    1095:	cd 40                	int    $0x40
    1097:	c3                   	ret    

00001098 <sleep>:
SYSCALL(sleep)
    1098:	b8 0d 00 00 00       	mov    $0xd,%eax
    109d:	cd 40                	int    $0x40
    109f:	c3                   	ret    

000010a0 <uptime>:
SYSCALL(uptime)
    10a0:	b8 0e 00 00 00       	mov    $0xe,%eax
    10a5:	cd 40                	int    $0x40
    10a7:	c3                   	ret    

000010a8 <detach>:
SYSCALL(detach)
    10a8:	b8 16 00 00 00       	mov    $0x16,%eax
    10ad:	cd 40                	int    $0x40
    10af:	c3                   	ret    

000010b0 <priority>:
SYSCALL(priority)
    10b0:	b8 17 00 00 00       	mov    $0x17,%eax
    10b5:	cd 40                	int    $0x40
    10b7:	c3                   	ret    

000010b8 <policy>:
SYSCALL(policy)
    10b8:	b8 18 00 00 00       	mov    $0x18,%eax
    10bd:	cd 40                	int    $0x40
    10bf:	c3                   	ret    

000010c0 <wait_stat>:
SYSCALL(wait_stat)
    10c0:	b8 19 00 00 00       	mov    $0x19,%eax
    10c5:	cd 40                	int    $0x40
    10c7:	c3                   	ret    
    10c8:	66 90                	xchg   %ax,%ax
    10ca:	66 90                	xchg   %ax,%ax
    10cc:	66 90                	xchg   %ax,%ax
    10ce:	66 90                	xchg   %ax,%ax

000010d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	57                   	push   %edi
    10d4:	56                   	push   %esi
    10d5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    10d6:	89 d3                	mov    %edx,%ebx
    10d8:	c1 eb 1f             	shr    $0x1f,%ebx
{
    10db:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    10de:	84 db                	test   %bl,%bl
{
    10e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    10e3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    10e5:	74 79                	je     1160 <printint+0x90>
    10e7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    10eb:	74 73                	je     1160 <printint+0x90>
    neg = 1;
    x = -xx;
    10ed:	f7 d8                	neg    %eax
    neg = 1;
    10ef:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    10f6:	31 f6                	xor    %esi,%esi
    10f8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    10fb:	eb 05                	jmp    1102 <printint+0x32>
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1100:	89 fe                	mov    %edi,%esi
    1102:	31 d2                	xor    %edx,%edx
    1104:	f7 f1                	div    %ecx
    1106:	8d 7e 01             	lea    0x1(%esi),%edi
    1109:	0f b6 92 e8 15 00 00 	movzbl 0x15e8(%edx),%edx
  }while((x /= base) != 0);
    1110:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1112:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1115:	75 e9                	jne    1100 <printint+0x30>
  if(neg)
    1117:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    111a:	85 d2                	test   %edx,%edx
    111c:	74 08                	je     1126 <printint+0x56>
    buf[i++] = '-';
    111e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1123:	8d 7e 02             	lea    0x2(%esi),%edi
    1126:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    112a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    112d:	8d 76 00             	lea    0x0(%esi),%esi
    1130:	0f b6 06             	movzbl (%esi),%eax
    1133:	4e                   	dec    %esi
  write(fd, &c, 1);
    1134:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1138:	89 3c 24             	mov    %edi,(%esp)
    113b:	88 45 d7             	mov    %al,-0x29(%ebp)
    113e:	b8 01 00 00 00       	mov    $0x1,%eax
    1143:	89 44 24 08          	mov    %eax,0x8(%esp)
    1147:	e8 dc fe ff ff       	call   1028 <write>

  while(--i >= 0)
    114c:	39 de                	cmp    %ebx,%esi
    114e:	75 e0                	jne    1130 <printint+0x60>
    putc(fd, buf[i]);
}
    1150:	83 c4 4c             	add    $0x4c,%esp
    1153:	5b                   	pop    %ebx
    1154:	5e                   	pop    %esi
    1155:	5f                   	pop    %edi
    1156:	5d                   	pop    %ebp
    1157:	c3                   	ret    
    1158:	90                   	nop
    1159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1160:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1167:	eb 8d                	jmp    10f6 <printint+0x26>
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001170 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	57                   	push   %edi
    1174:	56                   	push   %esi
    1175:	53                   	push   %ebx
    1176:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1179:	8b 75 0c             	mov    0xc(%ebp),%esi
    117c:	0f b6 1e             	movzbl (%esi),%ebx
    117f:	84 db                	test   %bl,%bl
    1181:	0f 84 d1 00 00 00    	je     1258 <printf+0xe8>
  state = 0;
    1187:	31 ff                	xor    %edi,%edi
    1189:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    118a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    118d:	89 fa                	mov    %edi,%edx
    118f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    1192:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1195:	eb 41                	jmp    11d8 <printf+0x68>
    1197:	89 f6                	mov    %esi,%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    11a0:	83 f8 25             	cmp    $0x25,%eax
    11a3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    11a6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    11ab:	74 1e                	je     11cb <printf+0x5b>
  write(fd, &c, 1);
    11ad:	b8 01 00 00 00       	mov    $0x1,%eax
    11b2:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    11b9:	89 44 24 04          	mov    %eax,0x4(%esp)
    11bd:	89 3c 24             	mov    %edi,(%esp)
    11c0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    11c3:	e8 60 fe ff ff       	call   1028 <write>
    11c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    11cb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    11cc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    11d0:	84 db                	test   %bl,%bl
    11d2:	0f 84 80 00 00 00    	je     1258 <printf+0xe8>
    if(state == 0){
    11d8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    11da:	0f be cb             	movsbl %bl,%ecx
    11dd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    11e0:	74 be                	je     11a0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    11e2:	83 fa 25             	cmp    $0x25,%edx
    11e5:	75 e4                	jne    11cb <printf+0x5b>
      if(c == 'd'){
    11e7:	83 f8 64             	cmp    $0x64,%eax
    11ea:	0f 84 f0 00 00 00    	je     12e0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    11f0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    11f6:	83 f9 70             	cmp    $0x70,%ecx
    11f9:	74 65                	je     1260 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    11fb:	83 f8 73             	cmp    $0x73,%eax
    11fe:	0f 84 8c 00 00 00    	je     1290 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1204:	83 f8 63             	cmp    $0x63,%eax
    1207:	0f 84 13 01 00 00    	je     1320 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    120d:	83 f8 25             	cmp    $0x25,%eax
    1210:	0f 84 e2 00 00 00    	je     12f8 <printf+0x188>
  write(fd, &c, 1);
    1216:	b8 01 00 00 00       	mov    $0x1,%eax
    121b:	46                   	inc    %esi
    121c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1220:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1223:	89 44 24 04          	mov    %eax,0x4(%esp)
    1227:	89 3c 24             	mov    %edi,(%esp)
    122a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    122e:	e8 f5 fd ff ff       	call   1028 <write>
    1233:	ba 01 00 00 00       	mov    $0x1,%edx
    1238:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    123b:	89 54 24 08          	mov    %edx,0x8(%esp)
    123f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1243:	89 3c 24             	mov    %edi,(%esp)
    1246:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1249:	e8 da fd ff ff       	call   1028 <write>
  for(i = 0; fmt[i]; i++){
    124e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1252:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    1254:	84 db                	test   %bl,%bl
    1256:	75 80                	jne    11d8 <printf+0x68>
    }
  }
}
    1258:	83 c4 3c             	add    $0x3c,%esp
    125b:	5b                   	pop    %ebx
    125c:	5e                   	pop    %esi
    125d:	5f                   	pop    %edi
    125e:	5d                   	pop    %ebp
    125f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    1260:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1267:	b9 10 00 00 00       	mov    $0x10,%ecx
    126c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    126f:	89 f8                	mov    %edi,%eax
    1271:	8b 13                	mov    (%ebx),%edx
    1273:	e8 58 fe ff ff       	call   10d0 <printint>
        ap++;
    1278:	89 d8                	mov    %ebx,%eax
      state = 0;
    127a:	31 d2                	xor    %edx,%edx
        ap++;
    127c:	83 c0 04             	add    $0x4,%eax
    127f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1282:	e9 44 ff ff ff       	jmp    11cb <printf+0x5b>
    1287:	89 f6                	mov    %esi,%esi
    1289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    1290:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1293:	8b 10                	mov    (%eax),%edx
        ap++;
    1295:	83 c0 04             	add    $0x4,%eax
    1298:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    129b:	85 d2                	test   %edx,%edx
    129d:	0f 84 aa 00 00 00    	je     134d <printf+0x1dd>
        while(*s != 0){
    12a3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    12a6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    12a8:	84 c0                	test   %al,%al
    12aa:	74 27                	je     12d3 <printf+0x163>
    12ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12b0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    12b3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    12b8:	43                   	inc    %ebx
  write(fd, &c, 1);
    12b9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12bd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    12c0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12c4:	89 3c 24             	mov    %edi,(%esp)
    12c7:	e8 5c fd ff ff       	call   1028 <write>
        while(*s != 0){
    12cc:	0f b6 03             	movzbl (%ebx),%eax
    12cf:	84 c0                	test   %al,%al
    12d1:	75 dd                	jne    12b0 <printf+0x140>
      state = 0;
    12d3:	31 d2                	xor    %edx,%edx
    12d5:	e9 f1 fe ff ff       	jmp    11cb <printf+0x5b>
    12da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    12e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12e7:	b9 0a 00 00 00       	mov    $0xa,%ecx
    12ec:	e9 7b ff ff ff       	jmp    126c <printf+0xfc>
    12f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    12f8:	b9 01 00 00 00       	mov    $0x1,%ecx
    12fd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1300:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1304:	89 44 24 04          	mov    %eax,0x4(%esp)
    1308:	89 3c 24             	mov    %edi,(%esp)
    130b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    130e:	e8 15 fd ff ff       	call   1028 <write>
      state = 0;
    1313:	31 d2                	xor    %edx,%edx
    1315:	e9 b1 fe ff ff       	jmp    11cb <printf+0x5b>
    131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1320:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1323:	8b 03                	mov    (%ebx),%eax
        ap++;
    1325:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1328:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    132b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    132e:	b8 01 00 00 00       	mov    $0x1,%eax
    1333:	89 44 24 08          	mov    %eax,0x8(%esp)
    1337:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    133a:	89 44 24 04          	mov    %eax,0x4(%esp)
    133e:	e8 e5 fc ff ff       	call   1028 <write>
      state = 0;
    1343:	31 d2                	xor    %edx,%edx
        ap++;
    1345:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1348:	e9 7e fe ff ff       	jmp    11cb <printf+0x5b>
          s = "(null)";
    134d:	bb e0 15 00 00       	mov    $0x15e0,%ebx
        while(*s != 0){
    1352:	b0 28                	mov    $0x28,%al
    1354:	e9 57 ff ff ff       	jmp    12b0 <printf+0x140>
    1359:	66 90                	xchg   %ax,%ax
    135b:	66 90                	xchg   %ax,%ax
    135d:	66 90                	xchg   %ax,%ax
    135f:	90                   	nop

00001360 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1360:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1361:	a1 44 1c 00 00       	mov    0x1c44,%eax
{
    1366:	89 e5                	mov    %esp,%ebp
    1368:	57                   	push   %edi
    1369:	56                   	push   %esi
    136a:	53                   	push   %ebx
    136b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    136e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1371:	eb 0d                	jmp    1380 <free+0x20>
    1373:	90                   	nop
    1374:	90                   	nop
    1375:	90                   	nop
    1376:	90                   	nop
    1377:	90                   	nop
    1378:	90                   	nop
    1379:	90                   	nop
    137a:	90                   	nop
    137b:	90                   	nop
    137c:	90                   	nop
    137d:	90                   	nop
    137e:	90                   	nop
    137f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1380:	39 c8                	cmp    %ecx,%eax
    1382:	8b 10                	mov    (%eax),%edx
    1384:	73 32                	jae    13b8 <free+0x58>
    1386:	39 d1                	cmp    %edx,%ecx
    1388:	72 04                	jb     138e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    138a:	39 d0                	cmp    %edx,%eax
    138c:	72 32                	jb     13c0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    138e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1391:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1394:	39 fa                	cmp    %edi,%edx
    1396:	74 30                	je     13c8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1398:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    139b:	8b 50 04             	mov    0x4(%eax),%edx
    139e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13a1:	39 f1                	cmp    %esi,%ecx
    13a3:	74 3c                	je     13e1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    13a5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    13a7:	5b                   	pop    %ebx
  freep = p;
    13a8:	a3 44 1c 00 00       	mov    %eax,0x1c44
}
    13ad:	5e                   	pop    %esi
    13ae:	5f                   	pop    %edi
    13af:	5d                   	pop    %ebp
    13b0:	c3                   	ret    
    13b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13b8:	39 d0                	cmp    %edx,%eax
    13ba:	72 04                	jb     13c0 <free+0x60>
    13bc:	39 d1                	cmp    %edx,%ecx
    13be:	72 ce                	jb     138e <free+0x2e>
{
    13c0:	89 d0                	mov    %edx,%eax
    13c2:	eb bc                	jmp    1380 <free+0x20>
    13c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    13c8:	8b 7a 04             	mov    0x4(%edx),%edi
    13cb:	01 fe                	add    %edi,%esi
    13cd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    13d0:	8b 10                	mov    (%eax),%edx
    13d2:	8b 12                	mov    (%edx),%edx
    13d4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    13d7:	8b 50 04             	mov    0x4(%eax),%edx
    13da:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13dd:	39 f1                	cmp    %esi,%ecx
    13df:	75 c4                	jne    13a5 <free+0x45>
    p->s.size += bp->s.size;
    13e1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    13e4:	a3 44 1c 00 00       	mov    %eax,0x1c44
    p->s.size += bp->s.size;
    13e9:	01 ca                	add    %ecx,%edx
    13eb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    13ee:	8b 53 f8             	mov    -0x8(%ebx),%edx
    13f1:	89 10                	mov    %edx,(%eax)
}
    13f3:	5b                   	pop    %ebx
    13f4:	5e                   	pop    %esi
    13f5:	5f                   	pop    %edi
    13f6:	5d                   	pop    %ebp
    13f7:	c3                   	ret    
    13f8:	90                   	nop
    13f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001400 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	57                   	push   %edi
    1404:	56                   	push   %esi
    1405:	53                   	push   %ebx
    1406:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1409:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    140c:	8b 15 44 1c 00 00    	mov    0x1c44,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1412:	8d 78 07             	lea    0x7(%eax),%edi
    1415:	c1 ef 03             	shr    $0x3,%edi
    1418:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1419:	85 d2                	test   %edx,%edx
    141b:	0f 84 8f 00 00 00    	je     14b0 <malloc+0xb0>
    1421:	8b 02                	mov    (%edx),%eax
    1423:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1426:	39 cf                	cmp    %ecx,%edi
    1428:	76 66                	jbe    1490 <malloc+0x90>
    142a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1430:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1435:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1438:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    143f:	eb 10                	jmp    1451 <malloc+0x51>
    1441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1448:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    144a:	8b 48 04             	mov    0x4(%eax),%ecx
    144d:	39 f9                	cmp    %edi,%ecx
    144f:	73 3f                	jae    1490 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1451:	39 05 44 1c 00 00    	cmp    %eax,0x1c44
    1457:	89 c2                	mov    %eax,%edx
    1459:	75 ed                	jne    1448 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    145b:	89 34 24             	mov    %esi,(%esp)
    145e:	e8 2d fc ff ff       	call   1090 <sbrk>
  if(p == (char*)-1)
    1463:	83 f8 ff             	cmp    $0xffffffff,%eax
    1466:	74 18                	je     1480 <malloc+0x80>
  hp->s.size = nu;
    1468:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    146b:	83 c0 08             	add    $0x8,%eax
    146e:	89 04 24             	mov    %eax,(%esp)
    1471:	e8 ea fe ff ff       	call   1360 <free>
  return freep;
    1476:	8b 15 44 1c 00 00    	mov    0x1c44,%edx
      if((p = morecore(nunits)) == 0)
    147c:	85 d2                	test   %edx,%edx
    147e:	75 c8                	jne    1448 <malloc+0x48>
        return 0;
  }
}
    1480:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    1483:	31 c0                	xor    %eax,%eax
}
    1485:	5b                   	pop    %ebx
    1486:	5e                   	pop    %esi
    1487:	5f                   	pop    %edi
    1488:	5d                   	pop    %ebp
    1489:	c3                   	ret    
    148a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1490:	39 cf                	cmp    %ecx,%edi
    1492:	74 4c                	je     14e0 <malloc+0xe0>
        p->s.size -= nunits;
    1494:	29 f9                	sub    %edi,%ecx
    1496:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1499:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    149c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    149f:	89 15 44 1c 00 00    	mov    %edx,0x1c44
}
    14a5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    14a8:	83 c0 08             	add    $0x8,%eax
}
    14ab:	5b                   	pop    %ebx
    14ac:	5e                   	pop    %esi
    14ad:	5f                   	pop    %edi
    14ae:	5d                   	pop    %ebp
    14af:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    14b0:	b8 48 1c 00 00       	mov    $0x1c48,%eax
    14b5:	ba 48 1c 00 00       	mov    $0x1c48,%edx
    base.s.size = 0;
    14ba:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    14bc:	a3 44 1c 00 00       	mov    %eax,0x1c44
    base.s.size = 0;
    14c1:	b8 48 1c 00 00       	mov    $0x1c48,%eax
    base.s.ptr = freep = prevp = &base;
    14c6:	89 15 48 1c 00 00    	mov    %edx,0x1c48
    base.s.size = 0;
    14cc:	89 0d 4c 1c 00 00    	mov    %ecx,0x1c4c
    14d2:	e9 53 ff ff ff       	jmp    142a <malloc+0x2a>
    14d7:	89 f6                	mov    %esi,%esi
    14d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    14e0:	8b 08                	mov    (%eax),%ecx
    14e2:	89 0a                	mov    %ecx,(%edx)
    14e4:	eb b9                	jmp    149f <malloc+0x9f>
