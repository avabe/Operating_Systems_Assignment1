
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3

  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 20 d6 10 80       	mov    $0x8010d620,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 2f 10 80       	mov    $0x80102f60,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100041:	ba e0 89 10 80       	mov    $0x801089e0,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 1d 11 80       	mov    $0x80111d1c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
8010005c:	e8 1f 5b 00 00       	call   80105b80 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 1d 11 80       	mov    $0x80111d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 1d 11 80       	mov    $0x80111d1c,%edx
8010006b:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 d6 10 80       	mov    $0x8010d654,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 1d 11 80    	mov    %ecx,0x80111d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 e7 89 10 80       	mov    $0x801089e7,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 b0 59 00 00       	call   80105a50 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 1d 11 80       	mov    0x80111d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 1d 11 80       	cmp    $0x80111d1c,%eax
    bcache.head.next = b;
801000b5:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	83 c4 14             	add    $0x14,%esp
801000c0:	5b                   	pop    %ebx
801000c1:	5d                   	pop    %ebp
801000c2:	c3                   	ret    
801000c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&bcache.lock);
801000d9:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 e5 5b 00 00       	call   80105cd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 1d 11 80    	mov    0x80111d70,%ebx
801000f1:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	ff 43 4c             	incl   0x4c(%ebx)
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 1d 11 80    	mov    0x80111d6c,%ebx
80100126:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100161:	e8 0a 5c 00 00       	call   80105d70 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 1f 59 00 00       	call   80105a90 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 62 20 00 00       	call   801021e0 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 ee 89 10 80 	movl   $0x801089ee,(%esp)
8010018f:	e8 dc 01 00 00       	call   80100370 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 7b 59 00 00       	call   80105b30 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 17 20 00 00       	jmp    801021e0 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 ff 89 10 80 	movl   $0x801089ff,(%esp)
801001d0:	e8 9b 01 00 00       	call   80100370 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 3a 59 00 00       	call   80105b30 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ee 58 00 00       	call   80105af0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 c2 5a 00 00       	call   80105cd0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	ff 4b 4c             	decl   0x4c(%ebx)
80100211:	75 2f                	jne    80100242 <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100213:	8b 43 54             	mov    0x54(%ebx),%eax
80100216:	8b 53 50             	mov    0x50(%ebx),%edx
80100219:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021c:	8b 43 50             	mov    0x50(%ebx),%eax
8010021f:	8b 53 54             	mov    0x54(%ebx),%edx
80100222:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100225:	a1 70 1d 11 80       	mov    0x80111d70,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 70 1d 11 80       	mov    0x80111d70,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 20 d6 10 80 	movl   $0x8010d620,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 1c 5b 00 00       	jmp    80105d70 <release>
    panic("brelse");
80100254:	c7 04 24 06 8a 10 80 	movl   $0x80108a06,(%esp)
8010025b:	e8 10 01 00 00       	call   80100370 <panic>

80100260 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 2c             	sub    $0x2c,%esp
80100269:	8b 7d 08             	mov    0x8(%ebp),%edi
8010026c:	8b 75 10             	mov    0x10(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010026f:	89 3c 24             	mov    %edi,(%esp)
80100272:	e8 39 15 00 00       	call   801017b0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100277:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010027e:	e8 4d 5a 00 00       	call   80105cd0 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 00 20 11 80    	mov    0x80112000,%edx
8010029b:	39 15 04 20 11 80    	cmp    %edx,0x80112004
801002a1:	74 28                	je     801002cb <consoleread+0x6b>
801002a3:	eb 5b                	jmp    80100300 <consoleread+0xa0>
801002a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a8:	b8 20 c5 10 80       	mov    $0x8010c520,%eax
801002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b1:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
801002b8:	e8 63 44 00 00       	call   80104720 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 20 11 80    	mov    0x80112000,%edx
801002c3:	3b 15 04 20 11 80    	cmp    0x80112004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 90 36 00 00       	call   80103960 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002de:	e8 8d 5a 00 00       	call   80105d70 <release>
        ilock(ip);
801002e3:	89 3c 24             	mov    %edi,(%esp)
801002e6:	e8 e5 13 00 00       	call   801016d0 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002eb:	83 c4 2c             	add    $0x2c,%esp
        return -1;
801002ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002f3:	5b                   	pop    %ebx
801002f4:	5e                   	pop    %esi
801002f5:	5f                   	pop    %edi
801002f6:	5d                   	pop    %ebp
801002f7:	c3                   	ret    
801002f8:	90                   	nop
801002f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100300:	8d 42 01             	lea    0x1(%edx),%eax
80100303:	a3 00 20 11 80       	mov    %eax,0x80112000
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 80 1f 11 80 	movsbl -0x7feee080(%eax),%eax
    if(c == C('D')){  // EOF
80100314:	83 f8 04             	cmp    $0x4,%eax
80100317:	74 39                	je     80100352 <consoleread+0xf2>
    *dst++ = c;
80100319:	46                   	inc    %esi
    --n;
8010031a:	4b                   	dec    %ebx
    if(c == '\n')
8010031b:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
8010031e:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100321:	74 42                	je     80100365 <consoleread+0x105>
  while(n > 0){
80100323:	85 db                	test   %ebx,%ebx
80100325:	0f 85 6a ff ff ff    	jne    80100295 <consoleread+0x35>
8010032b:	8b 75 10             	mov    0x10(%ebp),%esi
8010032e:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100330:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010033a:	e8 31 5a 00 00       	call   80105d70 <release>
  ilock(ip);
8010033f:	89 3c 24             	mov    %edi,(%esp)
80100342:	e8 89 13 00 00       	call   801016d0 <ilock>
80100347:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010034a:	83 c4 2c             	add    $0x2c,%esp
8010034d:	5b                   	pop    %ebx
8010034e:	5e                   	pop    %esi
8010034f:	5f                   	pop    %edi
80100350:	5d                   	pop    %ebp
80100351:	c3                   	ret    
80100352:	8b 75 10             	mov    0x10(%ebp),%esi
80100355:	89 f0                	mov    %esi,%eax
80100357:	29 d8                	sub    %ebx,%eax
      if(n < target){
80100359:	39 f3                	cmp    %esi,%ebx
8010035b:	73 d3                	jae    80100330 <consoleread+0xd0>
        input.r--;
8010035d:	89 15 00 20 11 80    	mov    %edx,0x80112000
80100363:	eb cb                	jmp    80100330 <consoleread+0xd0>
80100365:	8b 75 10             	mov    0x10(%ebp),%esi
80100368:	89 f0                	mov    %esi,%eax
8010036a:	29 d8                	sub    %ebx,%eax
8010036c:	eb c2                	jmp    80100330 <consoleread+0xd0>
8010036e:	66 90                	xchg   %ax,%ax

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cons.locking = 0;
80100379:	31 d2                	xor    %edx,%edx
8010037b:	89 15 54 c5 10 80    	mov    %edx,0x8010c554
  getcallerpcs(&s, pcs);
80100381:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100384:	e8 87 24 00 00       	call   80102810 <lapicid>
80100389:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010038c:	c7 04 24 0d 8a 10 80 	movl   $0x80108a0d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 1d 91 10 80 	movl   $0x8010911d,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 de 57 00 00       	call   80105ba0 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 21 8a 10 80 	movl   $0x80108a21,(%esp)
801003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003e0:	e8 6b 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003e9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ee:	a3 58 c5 10 80       	mov    %eax,0x8010c558
801003f3:	eb fe                	jmp    801003f3 <panic+0x83>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
  if(panicked){
80100400:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
80100406:	85 d2                	test   %edx,%edx
80100408:	74 06                	je     80100410 <consputc+0x10>
8010040a:	fa                   	cli    
8010040b:	eb fe                	jmp    8010040b <consputc+0xb>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 2c             	sub    $0x2c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 9f 00 00 00    	je     801004c5 <consputc+0xc5>
    uartputc(c);
80100426:	89 04 24             	mov    %eax,(%esp)
80100429:	e8 92 71 00 00       	call   801075c0 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042e:	be d4 03 00 00       	mov    $0x3d4,%esi
80100433:	b0 0e                	mov    $0xe,%al
80100435:	89 f2                	mov    %esi,%edx
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043d:	89 ca                	mov    %ecx,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100440:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100443:	89 f2                	mov    %esi,%edx
80100445:	c1 e0 08             	shl    $0x8,%eax
80100448:	89 c7                	mov    %eax,%edi
8010044a:	b0 0f                	mov    $0xf,%al
8010044c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044d:	89 ca                	mov    %ecx,%edx
8010044f:	ec                   	in     (%dx),%al
80100450:	0f b6 c8             	movzbl %al,%ecx
  pos |= inb(CRTPORT+1);
80100453:	09 f9                	or     %edi,%ecx
  if(c == '\n')
80100455:	83 fb 0a             	cmp    $0xa,%ebx
80100458:	0f 84 ff 00 00 00    	je     8010055d <consputc+0x15d>
  else if(c == BACKSPACE){
8010045e:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100464:	0f 84 e5 00 00 00    	je     8010054f <consputc+0x14f>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010046a:	0f b6 c3             	movzbl %bl,%eax
8010046d:	0d 00 07 00 00       	or     $0x700,%eax
80100472:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100479:	80 
8010047a:	41                   	inc    %ecx
  if(pos < 0 || pos > 25*80)
8010047b:	81 f9 d0 07 00 00    	cmp    $0x7d0,%ecx
80100481:	0f 8f bc 00 00 00    	jg     80100543 <consputc+0x143>
  if((pos/80) >= 24){  // Scroll up.
80100487:	81 f9 7f 07 00 00    	cmp    $0x77f,%ecx
8010048d:	7f 5f                	jg     801004ee <consputc+0xee>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100494:	b0 0e                	mov    $0xe,%al
80100496:	89 f2                	mov    %esi,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  outb(CRTPORT+1, pos>>8);
8010049e:	89 c8                	mov    %ecx,%eax
801004a0:	c1 f8 08             	sar    $0x8,%eax
801004a3:	89 da                	mov    %ebx,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	b0 0f                	mov    $0xf,%al
801004a8:	89 f2                	mov    %esi,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	88 c8                	mov    %cl,%al
801004ad:	89 da                	mov    %ebx,%edx
801004af:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b0:	b8 20 07 00 00       	mov    $0x720,%eax
801004b5:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
801004bc:	80 
}
801004bd:	83 c4 2c             	add    $0x2c,%esp
801004c0:	5b                   	pop    %ebx
801004c1:	5e                   	pop    %esi
801004c2:	5f                   	pop    %edi
801004c3:	5d                   	pop    %ebp
801004c4:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004c5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004cc:	e8 ef 70 00 00       	call   801075c0 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 e3 70 00 00       	call   801075c0 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 d7 70 00 00       	call   801075c0 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 73 59 00 00       	call   80105e80 <memmove>
    pos -= 80;
8010050d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100510:	b8 80 07 00 00       	mov    $0x780,%eax
80100515:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010051c:	00 
    pos -= 80;
8010051d:	83 e9 50             	sub    $0x50,%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100520:	29 c8                	sub    %ecx,%eax
80100522:	01 c0                	add    %eax,%eax
80100524:	89 44 24 08          	mov    %eax,0x8(%esp)
80100528:	8d 04 09             	lea    (%ecx,%ecx,1),%eax
8010052b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100530:	89 04 24             	mov    %eax,(%esp)
80100533:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100536:	e8 85 58 00 00       	call   80105dc0 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 25 8a 10 80 	movl   $0x80108a25,(%esp)
8010054a:	e8 21 fe ff ff       	call   80100370 <panic>
    if(pos > 0) --pos;
8010054f:	85 c9                	test   %ecx,%ecx
80100551:	0f 84 38 ff ff ff    	je     8010048f <consputc+0x8f>
80100557:	49                   	dec    %ecx
80100558:	e9 1e ff ff ff       	jmp    8010047b <consputc+0x7b>
    pos += 80 - pos%80;
8010055d:	89 c8                	mov    %ecx,%eax
8010055f:	bb 50 00 00 00       	mov    $0x50,%ebx
80100564:	99                   	cltd   
80100565:	f7 fb                	idiv   %ebx
80100567:	29 d3                	sub    %edx,%ebx
80100569:	01 d9                	add    %ebx,%ecx
8010056b:	e9 0b ff ff ff       	jmp    8010047b <consputc+0x7b>

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	89 d3                	mov    %edx,%ebx
80100578:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
{
8010057d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100580:	74 04                	je     80100586 <printint+0x16>
80100582:	85 c0                	test   %eax,%eax
80100584:	78 62                	js     801005e8 <printint+0x78>
    x = xx;
80100586:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010058d:	31 c9                	xor    %ecx,%ecx
8010058f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100592:	eb 06                	jmp    8010059a <printint+0x2a>
80100594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100598:	89 f9                	mov    %edi,%ecx
8010059a:	31 d2                	xor    %edx,%edx
8010059c:	f7 f3                	div    %ebx
8010059e:	8d 79 01             	lea    0x1(%ecx),%edi
801005a1:	0f b6 92 50 8a 10 80 	movzbl -0x7fef75b0(%edx),%edx
  }while((x /= base) != 0);
801005a8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005aa:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005ad:	75 e9                	jne    80100598 <printint+0x28>
  if(sign)
801005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005b2:	85 c0                	test   %eax,%eax
801005b4:	74 08                	je     801005be <printint+0x4e>
    buf[i++] = '-';
801005b6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005bb:	8d 79 02             	lea    0x2(%ecx),%edi
801005be:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 03             	movsbl (%ebx),%eax
801005d3:	4b                   	dec    %ebx
801005d4:	e8 27 fe ff ff       	call   80100400 <consputc>
  while(--i >= 0)
801005d9:	39 f3                	cmp    %esi,%ebx
801005db:	75 f3                	jne    801005d0 <printint+0x60>
}
801005dd:	83 c4 2c             	add    $0x2c,%esp
801005e0:	5b                   	pop    %ebx
801005e1:	5e                   	pop    %esi
801005e2:	5f                   	pop    %edi
801005e3:	5d                   	pop    %ebp
801005e4:	c3                   	ret    
801005e5:	8d 76 00             	lea    0x0(%esi),%esi
    x = -xx;
801005e8:	f7 d8                	neg    %eax
801005ea:	eb a1                	jmp    8010058d <printint+0x1d>
801005ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 a9 11 00 00       	call   801017b0 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010060e:	e8 bd 56 00 00       	call   80105cd0 <acquire>
  for(i = 0; i < n; i++)
80100613:	85 f6                	test   %esi,%esi
80100615:	7e 16                	jle    8010062d <consolewrite+0x3d>
80100617:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010061a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	47                   	inc    %edi
80100624:	e8 d7 fd ff ff       	call   80100400 <consputc>
  for(i = 0; i < n; i++)
80100629:	39 fb                	cmp    %edi,%ebx
8010062b:	75 f3                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062d:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100634:	e8 37 57 00 00       	call   80105d70 <release>
  ilock(ip);
80100639:	8b 45 08             	mov    0x8(%ebp),%eax
8010063c:	89 04 24             	mov    %eax,(%esp)
8010063f:	e8 8c 10 00 00       	call   801016d0 <ilock>

  return n;
}
80100644:	83 c4 1c             	add    $0x1c,%esp
80100647:	89 f0                	mov    %esi,%eax
80100649:	5b                   	pop    %ebx
8010064a:	5e                   	pop    %esi
8010064b:	5f                   	pop    %edi
8010064c:	5d                   	pop    %ebp
8010064d:	c3                   	ret    
8010064e:	66 90                	xchg   %ax,%ax

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100659:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100663:	0f 85 47 01 00 00    	jne    801007b0 <cprintf+0x160>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100671:	0f 84 4a 01 00 00    	je     801007c1 <cprintf+0x171>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100677:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
8010067a:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010067d:	31 db                	xor    %ebx,%ebx
8010067f:	89 cf                	mov    %ecx,%edi
80100681:	85 c0                	test   %eax,%eax
80100683:	75 59                	jne    801006de <cprintf+0x8e>
80100685:	eb 79                	jmp    80100700 <cprintf+0xb0>
80100687:	89 f6                	mov    %esi,%esi
80100689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100690:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100693:	85 d2                	test   %edx,%edx
80100695:	74 69                	je     80100700 <cprintf+0xb0>
80100697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010069a:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010069d:	83 fa 70             	cmp    $0x70,%edx
801006a0:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801006a3:	0f 84 81 00 00 00    	je     8010072a <cprintf+0xda>
801006a9:	7f 75                	jg     80100720 <cprintf+0xd0>
801006ab:	83 fa 25             	cmp    $0x25,%edx
801006ae:	0f 84 e4 00 00 00    	je     80100798 <cprintf+0x148>
801006b4:	83 fa 64             	cmp    $0x64,%edx
801006b7:	0f 85 8b 00 00 00    	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006bd:	8d 47 04             	lea    0x4(%edi),%eax
801006c0:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006c8:	8b 07                	mov    (%edi),%eax
801006ca:	ba 0a 00 00 00       	mov    $0xa,%edx
801006cf:	e8 9c fe ff ff       	call   80100570 <printint>
801006d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 06             	movzbl (%esi),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 22                	je     80100700 <cprintf+0xb0>
801006de:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801006e1:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006e4:	83 f8 25             	cmp    $0x25,%eax
801006e7:	8d 34 11             	lea    (%ecx,%edx,1),%esi
801006ea:	74 a4                	je     80100690 <cprintf+0x40>
801006ec:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006ef:	e8 0c fd ff ff       	call   80100400 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f4:	0f b6 06             	movzbl (%esi),%eax
      continue;
801006f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fa:	85 c0                	test   %eax,%eax
      continue;
801006fc:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	75 de                	jne    801006de <cprintf+0x8e>
  if(locking)
80100700:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100703:	85 c0                	test   %eax,%eax
80100705:	74 0c                	je     80100713 <cprintf+0xc3>
    release(&cons.lock);
80100707:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010070e:	e8 5d 56 00 00       	call   80105d70 <release>
}
80100713:	83 c4 2c             	add    $0x2c,%esp
80100716:	5b                   	pop    %ebx
80100717:	5e                   	pop    %esi
80100718:	5f                   	pop    %edi
80100719:	5d                   	pop    %ebp
8010071a:	c3                   	ret    
8010071b:	90                   	nop
8010071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 43                	je     80100768 <cprintf+0x118>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010072a:	8d 47 04             	lea    0x4(%edi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100732:	8b 07                	mov    (%edi),%eax
80100734:	ba 10 00 00 00       	mov    $0x10,%edx
80100739:	e8 32 fe ff ff       	call   80100570 <printint>
8010073e:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100741:	eb 94                	jmp    801006d7 <cprintf+0x87>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100750:	e8 ab fc ff ff       	call   80100400 <consputc>
      consputc(c);
80100755:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 a1 fc ff ff       	call   80100400 <consputc>
      break;
8010075f:	e9 73 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100768:	8d 47 04             	lea    0x4(%edi),%eax
8010076b:	8b 3f                	mov    (%edi),%edi
8010076d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100770:	85 ff                	test   %edi,%edi
80100772:	75 12                	jne    80100786 <cprintf+0x136>
        s = "(null)";
80100774:	bf 38 8a 10 80       	mov    $0x80108a38,%edi
      for(; *s; s++)
80100779:	b8 28 00 00 00       	mov    $0x28,%eax
8010077e:	66 90                	xchg   %ax,%ax
        consputc(*s);
80100780:	e8 7b fc ff ff       	call   80100400 <consputc>
      for(; *s; s++)
80100785:	47                   	inc    %edi
80100786:	0f be 07             	movsbl (%edi),%eax
80100789:	84 c0                	test   %al,%al
8010078b:	75 f3                	jne    80100780 <cprintf+0x130>
      if((s = (char*)*argp++) == 0)
8010078d:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100790:	e9 42 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100795:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100798:	b8 25 00 00 00       	mov    $0x25,%eax
8010079d:	e8 5e fc ff ff       	call   80100400 <consputc>
      break;
801007a2:	e9 30 ff ff ff       	jmp    801006d7 <cprintf+0x87>
801007a7:	89 f6                	mov    %esi,%esi
801007a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&cons.lock);
801007b0:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801007b7:	e8 14 55 00 00       	call   80105cd0 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 3f 8a 10 80 	movl   $0x80108a3f,(%esp)
801007c8:	e8 a3 fb ff ff       	call   80100370 <panic>
801007cd:	8d 76 00             	lea    0x0(%esi),%esi

801007d0 <consoleintr>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	56                   	push   %esi
  int c, doprocdump = 0;
801007d4:	31 f6                	xor    %esi,%esi
{
801007d6:	53                   	push   %ebx
801007d7:	83 ec 20             	sub    $0x20,%esp
  acquire(&cons.lock);
801007da:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
{
801007e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007e4:	e8 e7 54 00 00       	call   80105cd0 <acquire>
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((c = getc()) >= 0){
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c2                	mov    %eax,%edx
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 fa 10             	cmp    $0x10,%edx
801007fb:	0f 84 e7 00 00 00    	je     801008e8 <consoleintr+0x118>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 fa 15             	cmp    $0x15,%edx
80100806:	0f 84 ec 00 00 00    	je     801008f8 <consoleintr+0x128>
8010080c:	83 fa 7f             	cmp    $0x7f,%edx
8010080f:	90                   	nop
80100810:	75 53                	jne    80100865 <consoleintr+0x95>
      if(input.e != input.w){
80100812:	a1 08 20 11 80       	mov    0x80112008,%eax
80100817:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100825:	b8 00 01 00 00       	mov    $0x100,%eax
8010082a:	e8 d1 fb ff ff       	call   80100400 <consputc>
  while((c = getc()) >= 0){
8010082f:	ff d3                	call   *%ebx
80100831:	85 c0                	test   %eax,%eax
80100833:	89 c2                	mov    %eax,%edx
80100835:	79 c1                	jns    801007f8 <consoleintr+0x28>
80100837:	89 f6                	mov    %esi,%esi
80100839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&cons.lock);
80100840:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100847:	e8 24 55 00 00       	call   80105d70 <release>
  if(doprocdump) {
8010084c:	85 f6                	test   %esi,%esi
8010084e:	0f 85 f4 00 00 00    	jne    80100948 <consoleintr+0x178>
}
80100854:	83 c4 20             	add    $0x20,%esp
80100857:	5b                   	pop    %ebx
80100858:	5e                   	pop    %esi
80100859:	5d                   	pop    %ebp
8010085a:	c3                   	ret    
8010085b:	90                   	nop
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100860:	83 fa 08             	cmp    $0x8,%edx
80100863:	74 ad                	je     80100812 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 d2                	test   %edx,%edx
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 08 20 11 80       	mov    0x80112008,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 00 20 11 80    	sub    0x80112000,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 08 20 11 80    	mov    %ecx,0x80112008
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 80 1f 11 80    	mov    %dl,-0x7feee080(%eax)
        consputc(c);
8010089a:	89 d0                	mov    %edx,%eax
8010089c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010089f:	e8 5c fb ff ff       	call   80100400 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008a7:	83 fa 0a             	cmp    $0xa,%edx
801008aa:	0f 84 b9 00 00 00    	je     80100969 <consoleintr+0x199>
801008b0:	83 fa 04             	cmp    $0x4,%edx
801008b3:	0f 84 b0 00 00 00    	je     80100969 <consoleintr+0x199>
801008b9:	a1 00 20 11 80       	mov    0x80112000,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 08 20 11 80    	cmp    %eax,0x80112008
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
          input.w = input.e;
801008d4:	a3 04 20 11 80       	mov    %eax,0x80112004
          wakeup(&input.r);
801008d9:	e8 22 42 00 00       	call   80104b00 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 08 20 11 80       	mov    0x80112008,%eax
801008fd:	39 05 04 20 11 80    	cmp    %eax,0x80112004
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 08 20 11 80       	mov    0x80112008,%eax
80100924:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba 80 1f 11 80 0a 	cmpb   $0xa,-0x7feee080(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 fd 42 00 00       	jmp    80104c50 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 80 1f 11 80 0a 	movb   $0xa,-0x7feee080(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 08 20 11 80       	mov    0x80112008,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 48 8a 10 80       	mov    $0x80108a48,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 e5 51 00 00       	call   80105b80 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010099b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
801009a0:	ba f0 05 10 80       	mov    $0x801005f0,%edx
  cons.locking = 1;
801009a5:	a3 54 c5 10 80       	mov    %eax,0x8010c554

  ioapicenable(IRQ_KBD, 0);
801009aa:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
801009ac:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  ioapicenable(IRQ_KBD, 0);
801009b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	89 15 cc 29 11 80    	mov    %edx,0x801129cc
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d c8 29 11 80    	mov    %ecx,0x801129c8
  ioapicenable(IRQ_KBD, 0);
801009c8:	e8 b3 19 00 00       	call   80102380 <ioapicenable>
}
801009cd:	c9                   	leave  
801009ce:	c3                   	ret    
801009cf:	90                   	nop

801009d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	57                   	push   %edi
801009d4:	56                   	push   %esi
801009d5:	53                   	push   %ebx
801009d6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009dc:	e8 7f 2f 00 00       	call   80103960 <myproc>
801009e1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009e7:	e8 84 22 00 00       	call   80102c70 <begin_op>

  if((ip = namei(path)) == 0){
801009ec:	8b 45 08             	mov    0x8(%ebp),%eax
801009ef:	89 04 24             	mov    %eax,(%esp)
801009f2:	e8 b9 15 00 00       	call   80101fb0 <namei>
801009f7:	85 c0                	test   %eax,%eax
801009f9:	74 38                	je     80100a33 <exec+0x63>
    end_op();
    //cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009fb:	89 04 24             	mov    %eax,(%esp)
801009fe:	89 c7                	mov    %eax,%edi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a00:	31 db                	xor    %ebx,%ebx
  ilock(ip);
80100a02:	e8 c9 0c 00 00       	call   801016d0 <ilock>
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a07:	b9 34 00 00 00       	mov    $0x34,%ecx
80100a0c:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a12:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100a16:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a1e:	89 3c 24             	mov    %edi,(%esp)
80100a21:	e8 8a 0f 00 00       	call   801019b0 <readi>
80100a26:	83 f8 34             	cmp    $0x34,%eax
80100a29:	74 25                	je     80100a50 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a2b:	89 3c 24             	mov    %edi,(%esp)
80100a2e:	e8 2d 0f 00 00       	call   80101960 <iunlockput>
    end_op();
80100a33:	e8 a8 22 00 00       	call   80102ce0 <end_op>
  }
  return -1;
80100a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a3d:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a43:	5b                   	pop    %ebx
80100a44:	5e                   	pop    %esi
80100a45:	5f                   	pop    %edi
80100a46:	5d                   	pop    %ebp
80100a47:	c3                   	ret    
80100a48:	90                   	nop
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a50:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a57:	45 4c 46 
80100a5a:	75 cf                	jne    80100a2b <exec+0x5b>
  if((pgdir = setupkvm()) == 0)
80100a5c:	e8 bf 7c 00 00       	call   80108720 <setupkvm>
80100a61:	85 c0                	test   %eax,%eax
80100a63:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a69:	74 c0                	je     80100a2b <exec+0x5b>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a6b:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  sz = 0;
80100a71:	31 f6                	xor    %esi,%esi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a7a:	00 
80100a7b:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100a81:	0f 84 98 02 00 00    	je     80100d1f <exec+0x34f>
80100a87:	31 db                	xor    %ebx,%ebx
80100a89:	e9 8c 00 00 00       	jmp    80100b1a <exec+0x14a>
80100a8e:	66 90                	xchg   %ax,%ax
    if(ph.type != ELF_PROG_LOAD)
80100a90:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a97:	75 75                	jne    80100b0e <exec+0x13e>
    if(ph.memsz < ph.filesz)
80100a99:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a9f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aa5:	0f 82 a4 00 00 00    	jb     80100b4f <exec+0x17f>
80100aab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab1:	0f 82 98 00 00 00    	jb     80100b4f <exec+0x17f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ab7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abb:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ac1:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ac5:	89 04 24             	mov    %eax,(%esp)
80100ac8:	e8 73 7a 00 00       	call   80108540 <allocuvm>
80100acd:	85 c0                	test   %eax,%eax
80100acf:	89 c6                	mov    %eax,%esi
80100ad1:	74 7c                	je     80100b4f <exec+0x17f>
    if(ph.vaddr % PGSIZE != 0)
80100ad3:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ad9:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ade:	75 6f                	jne    80100b4f <exec+0x17f>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ae0:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aea:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100af0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100af4:	89 54 24 10          	mov    %edx,0x10(%esp)
80100af8:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100afe:	89 04 24             	mov    %eax,(%esp)
80100b01:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b05:	e8 76 79 00 00       	call   80108480 <loaduvm>
80100b0a:	85 c0                	test   %eax,%eax
80100b0c:	78 41                	js     80100b4f <exec+0x17f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0e:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b15:	43                   	inc    %ebx
80100b16:	39 d8                	cmp    %ebx,%eax
80100b18:	7e 48                	jle    80100b62 <exec+0x192>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b1a:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100b20:	b8 20 00 00 00       	mov    $0x20,%eax
80100b25:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b29:	89 d8                	mov    %ebx,%eax
80100b2b:	c1 e0 05             	shl    $0x5,%eax
80100b2e:	89 3c 24             	mov    %edi,(%esp)
80100b31:	01 d0                	add    %edx,%eax
80100b33:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b37:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b41:	e8 6a 0e 00 00       	call   801019b0 <readi>
80100b46:	83 f8 20             	cmp    $0x20,%eax
80100b49:	0f 84 41 ff ff ff    	je     80100a90 <exec+0xc0>
    freevm(pgdir);
80100b4f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b55:	89 04 24             	mov    %eax,(%esp)
80100b58:	e8 43 7b 00 00       	call   801086a0 <freevm>
80100b5d:	e9 c9 fe ff ff       	jmp    80100a2b <exec+0x5b>
80100b62:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b68:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b6e:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100b74:	89 3c 24             	mov    %edi,(%esp)
80100b77:	e8 e4 0d 00 00       	call   80101960 <iunlockput>
  end_op();
80100b7c:	e8 5f 21 00 00       	call   80102ce0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b81:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b87:	89 74 24 04          	mov    %esi,0x4(%esp)
80100b8b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b8f:	89 04 24             	mov    %eax,(%esp)
80100b92:	e8 a9 79 00 00       	call   80108540 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 18                	jne    80100bb5 <exec+0x1e5>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 f5 7a 00 00       	call   801086a0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 88 fe ff ff       	jmp    80100a3d <exec+0x6d>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bb5:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100bbb:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bc1:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  for(argc = 0; argv[argc]; argc++) {
80100bc7:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bc9:	89 04 24             	mov    %eax,(%esp)
80100bcc:	e8 ef 7b 00 00       	call   801087c0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bd4:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bda:	8b 00                	mov    (%eax),%eax
80100bdc:	85 c0                	test   %eax,%eax
80100bde:	74 73                	je     80100c53 <exec+0x283>
80100be0:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100be6:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100bec:	eb 07                	jmp    80100bf5 <exec+0x225>
80100bee:	66 90                	xchg   %ax,%ax
    if(argc >= MAXARG)
80100bf0:	83 ff 20             	cmp    $0x20,%edi
80100bf3:	74 a8                	je     80100b9d <exec+0x1cd>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf5:	89 04 24             	mov    %eax,(%esp)
80100bf8:	e8 e3 53 00 00       	call   80105fe0 <strlen>
80100bfd:	f7 d0                	not    %eax
80100bff:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c01:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c04:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c07:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c0a:	89 04 24             	mov    %eax,(%esp)
80100c0d:	e8 ce 53 00 00       	call   80105fe0 <strlen>
80100c12:	40                   	inc    %eax
80100c13:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c17:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c1a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c1d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c21:	89 34 24             	mov    %esi,(%esp)
80100c24:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c28:	e8 03 7d 00 00       	call   80108930 <copyout>
80100c2d:	85 c0                	test   %eax,%eax
80100c2f:	0f 88 68 ff ff ff    	js     80100b9d <exec+0x1cd>
  for(argc = 0; argv[argc]; argc++) {
80100c35:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c38:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c3e:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c45:	47                   	inc    %edi
80100c46:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c49:	85 c0                	test   %eax,%eax
80100c4b:	75 a3                	jne    80100bf0 <exec+0x220>
80100c4d:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[3+argc] = 0;
80100c53:	31 c0                	xor    %eax,%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c55:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  ustack[3+argc] = 0;
80100c5a:	89 84 bd 64 ff ff ff 	mov    %eax,-0x9c(%ebp,%edi,4)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c61:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c68:	89 8d 58 ff ff ff    	mov    %ecx,-0xa8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c6e:	89 d9                	mov    %ebx,%ecx
80100c70:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100c72:	83 c0 0c             	add    $0xc,%eax
80100c75:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c77:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c7b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c81:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c85:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[1] = argc;
80100c89:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c8f:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c92:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c98:	e8 93 7c 00 00       	call   80108930 <copyout>
80100c9d:	85 c0                	test   %eax,%eax
80100c9f:	0f 88 f8 fe ff ff    	js     80100b9d <exec+0x1cd>
  for(last=s=path; *s; s++)
80100ca5:	8b 45 08             	mov    0x8(%ebp),%eax
80100ca8:	0f b6 00             	movzbl (%eax),%eax
80100cab:	84 c0                	test   %al,%al
80100cad:	74 15                	je     80100cc4 <exec+0x2f4>
80100caf:	8b 55 08             	mov    0x8(%ebp),%edx
80100cb2:	89 d1                	mov    %edx,%ecx
80100cb4:	41                   	inc    %ecx
80100cb5:	3c 2f                	cmp    $0x2f,%al
80100cb7:	0f b6 01             	movzbl (%ecx),%eax
80100cba:	0f 44 d1             	cmove  %ecx,%edx
80100cbd:	84 c0                	test   %al,%al
80100cbf:	75 f3                	jne    80100cb4 <exec+0x2e4>
80100cc1:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cc4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cca:	8b 45 08             	mov    0x8(%ebp),%eax
80100ccd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cd4:	00 
80100cd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cd9:	89 f8                	mov    %edi,%eax
80100cdb:	83 c0 6c             	add    $0x6c,%eax
80100cde:	89 04 24             	mov    %eax,(%esp)
80100ce1:	e8 ba 52 00 00       	call   80105fa0 <safestrcpy>
  curproc->pgdir = pgdir;
80100ce6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100cec:	89 f9                	mov    %edi,%ecx
80100cee:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100cf1:	89 31                	mov    %esi,(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100cf3:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->pgdir = pgdir;
80100cf6:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100cf9:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100cff:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d02:	8b 41 18             	mov    0x18(%ecx),%eax
80100d05:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d08:	89 0c 24             	mov    %ecx,(%esp)
80100d0b:	e8 e0 75 00 00       	call   801082f0 <switchuvm>
  freevm(oldpgdir);
80100d10:	89 3c 24             	mov    %edi,(%esp)
80100d13:	e8 88 79 00 00       	call   801086a0 <freevm>
  return 0;
80100d18:	31 c0                	xor    %eax,%eax
80100d1a:	e9 1e fd ff ff       	jmp    80100a3d <exec+0x6d>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d1f:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100d24:	e9 4b fe ff ff       	jmp    80100b74 <exec+0x1a4>
80100d29:	66 90                	xchg   %ax,%ax
80100d2b:	66 90                	xchg   %ax,%ax
80100d2d:	66 90                	xchg   %ax,%ax
80100d2f:	90                   	nop

80100d30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d30:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100d31:	b8 61 8a 10 80       	mov    $0x80108a61,%eax
{
80100d36:	89 e5                	mov    %esp,%ebp
80100d38:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d3f:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d46:	e8 35 4e 00 00       	call   80105b80 <initlock>
}
80100d4b:	c9                   	leave  
80100d4c:	c3                   	ret    
80100d4d:	8d 76 00             	lea    0x0(%esi),%esi

80100d50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d54:	bb 54 20 11 80       	mov    $0x80112054,%ebx
{
80100d59:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d5c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d63:	e8 68 4f 00 00       	call   80105cd0 <acquire>
80100d68:	eb 11                	jmp    80100d7b <filealloc+0x2b>
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d70:	83 c3 18             	add    $0x18,%ebx
80100d73:	81 fb b4 29 11 80    	cmp    $0x801129b4,%ebx
80100d79:	73 25                	jae    80100da0 <filealloc+0x50>
    if(f->ref == 0){
80100d7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d7e:	85 c0                	test   %eax,%eax
80100d80:	75 ee                	jne    80100d70 <filealloc+0x20>
      f->ref = 1;
80100d82:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d89:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d90:	e8 db 4f 00 00       	call   80105d70 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d95:	83 c4 14             	add    $0x14,%esp
80100d98:	89 d8                	mov    %ebx,%eax
80100d9a:	5b                   	pop    %ebx
80100d9b:	5d                   	pop    %ebp
80100d9c:	c3                   	ret    
80100d9d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100da0:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  return 0;
80100da7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100da9:	e8 c2 4f 00 00       	call   80105d70 <release>
}
80100dae:	83 c4 14             	add    $0x14,%esp
80100db1:	89 d8                	mov    %ebx,%eax
80100db3:	5b                   	pop    %ebx
80100db4:	5d                   	pop    %ebp
80100db5:	c3                   	ret    
80100db6:	8d 76 00             	lea    0x0(%esi),%esi
80100db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100dc0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
80100dc4:	83 ec 14             	sub    $0x14,%esp
80100dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dca:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100dd1:	e8 fa 4e 00 00       	call   80105cd0 <acquire>
  if(f->ref < 1)
80100dd6:	8b 43 04             	mov    0x4(%ebx),%eax
80100dd9:	85 c0                	test   %eax,%eax
80100ddb:	7e 18                	jle    80100df5 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100ddd:	40                   	inc    %eax
80100dde:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100de1:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100de8:	e8 83 4f 00 00       	call   80105d70 <release>
  return f;
}
80100ded:	83 c4 14             	add    $0x14,%esp
80100df0:	89 d8                	mov    %ebx,%eax
80100df2:	5b                   	pop    %ebx
80100df3:	5d                   	pop    %ebp
80100df4:	c3                   	ret    
    panic("filedup");
80100df5:	c7 04 24 68 8a 10 80 	movl   $0x80108a68,(%esp)
80100dfc:	e8 6f f5 ff ff       	call   80100370 <panic>
80100e01:	eb 0d                	jmp    80100e10 <fileclose>
80100e03:	90                   	nop
80100e04:	90                   	nop
80100e05:	90                   	nop
80100e06:	90                   	nop
80100e07:	90                   	nop
80100e08:	90                   	nop
80100e09:	90                   	nop
80100e0a:	90                   	nop
80100e0b:	90                   	nop
80100e0c:	90                   	nop
80100e0d:	90                   	nop
80100e0e:	90                   	nop
80100e0f:	90                   	nop

80100e10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 38             	sub    $0x38,%esp
80100e16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e1c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
{
80100e23:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e26:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e29:	e8 a2 4e 00 00       	call   80105cd0 <acquire>
  if(f->ref < 1)
80100e2e:	8b 43 04             	mov    0x4(%ebx),%eax
80100e31:	85 c0                	test   %eax,%eax
80100e33:	0f 8e a0 00 00 00    	jle    80100ed9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100e39:	48                   	dec    %eax
80100e3a:	85 c0                	test   %eax,%eax
80100e3c:	89 43 04             	mov    %eax,0x4(%ebx)
80100e3f:	74 1f                	je     80100e60 <fileclose+0x50>
    release(&ftable.lock);
80100e41:	c7 45 08 20 20 11 80 	movl   $0x80112020,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e48:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e4b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e4e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e51:	89 ec                	mov    %ebp,%esp
80100e53:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e54:	e9 17 4f 00 00       	jmp    80105d70 <release>
80100e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e60:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e64:	8b 3b                	mov    (%ebx),%edi
80100e66:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e69:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e6f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e72:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100e75:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  ff = *f;
80100e7c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e7f:	e8 ec 4e 00 00       	call   80105d70 <release>
  if(ff.type == FD_PIPE)
80100e84:	83 ff 01             	cmp    $0x1,%edi
80100e87:	74 17                	je     80100ea0 <fileclose+0x90>
  else if(ff.type == FD_INODE){
80100e89:	83 ff 02             	cmp    $0x2,%edi
80100e8c:	74 2a                	je     80100eb8 <fileclose+0xa8>
}
80100e8e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e91:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e94:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e97:	89 ec                	mov    %ebp,%esp
80100e99:	5d                   	pop    %ebp
80100e9a:	c3                   	ret    
80100e9b:	90                   	nop
80100e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80100ea0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ea4:	89 34 24             	mov    %esi,(%esp)
80100ea7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100eab:	e8 f0 25 00 00       	call   801034a0 <pipeclose>
80100eb0:	eb dc                	jmp    80100e8e <fileclose+0x7e>
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100eb8:	e8 b3 1d 00 00       	call   80102c70 <begin_op>
    iput(ff.ip);
80100ebd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ec0:	89 04 24             	mov    %eax,(%esp)
80100ec3:	e8 38 09 00 00       	call   80101800 <iput>
}
80100ec8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100ecb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ece:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ed1:	89 ec                	mov    %ebp,%esp
80100ed3:	5d                   	pop    %ebp
    end_op();
80100ed4:	e9 07 1e 00 00       	jmp    80102ce0 <end_op>
    panic("fileclose");
80100ed9:	c7 04 24 70 8a 10 80 	movl   $0x80108a70,(%esp)
80100ee0:	e8 8b f4 ff ff       	call   80100370 <panic>
80100ee5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ef0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 14             	sub    $0x14,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	8b 43 10             	mov    0x10(%ebx),%eax
80100f02:	89 04 24             	mov    %eax,(%esp)
80100f05:	e8 c6 07 00 00       	call   801016d0 <ilock>
    stati(f->ip, st);
80100f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
80100f14:	89 04 24             	mov    %eax,(%esp)
80100f17:	e8 64 0a 00 00       	call   80101980 <stati>
    iunlock(f->ip);
80100f1c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f1f:	89 04 24             	mov    %eax,(%esp)
80100f22:	e8 89 08 00 00       	call   801017b0 <iunlock>
    return 0;
80100f27:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f29:	83 c4 14             	add    $0x14,%esp
80100f2c:	5b                   	pop    %ebx
80100f2d:	5d                   	pop    %ebp
80100f2e:	c3                   	ret    
80100f2f:	90                   	nop
  return -1;
80100f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f35:	eb f2                	jmp    80100f29 <filestat+0x39>
80100f37:	89 f6                	mov    %esi,%esi
80100f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	83 ec 38             	sub    $0x38,%esp
80100f46:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f4f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f52:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f55:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f58:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f5c:	74 72                	je     80100fd0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f5e:	8b 03                	mov    (%ebx),%eax
80100f60:	83 f8 01             	cmp    $0x1,%eax
80100f63:	74 53                	je     80100fb8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f65:	83 f8 02             	cmp    $0x2,%eax
80100f68:	75 6d                	jne    80100fd7 <fileread+0x97>
    ilock(f->ip);
80100f6a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f6d:	89 04 24             	mov    %eax,(%esp)
80100f70:	e8 5b 07 00 00       	call   801016d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f75:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f79:	8b 43 14             	mov    0x14(%ebx),%eax
80100f7c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f80:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f84:	8b 43 10             	mov    0x10(%ebx),%eax
80100f87:	89 04 24             	mov    %eax,(%esp)
80100f8a:	e8 21 0a 00 00       	call   801019b0 <readi>
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	7e 03                	jle    80100f96 <fileread+0x56>
      f->off += r;
80100f93:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f96:	8b 53 10             	mov    0x10(%ebx),%edx
80100f99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100f9c:	89 14 24             	mov    %edx,(%esp)
80100f9f:	e8 0c 08 00 00       	call   801017b0 <iunlock>
    return r;
80100fa4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100fa7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100faa:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fad:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fb0:	89 ec                	mov    %ebp,%esp
80100fb2:	5d                   	pop    %ebp
80100fb3:	c3                   	ret    
80100fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80100fb8:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80100fbb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fbe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fc1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
80100fc4:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc7:	89 ec                	mov    %ebp,%esp
80100fc9:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fca:	e9 81 26 00 00       	jmp    80103650 <piperead>
80100fcf:	90                   	nop
    return -1;
80100fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fd5:	eb d0                	jmp    80100fa7 <fileread+0x67>
  panic("fileread");
80100fd7:	c7 04 24 7a 8a 10 80 	movl   $0x80108a7a,(%esp)
80100fde:	e8 8d f3 ff ff       	call   80100370 <panic>
80100fe3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 2c             	sub    $0x2c,%esp
80100ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ffc:	8b 7d 08             	mov    0x8(%ebp),%edi
80100fff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101002:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101005:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 ae 00 00 00    	je     801010c0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 07                	mov    (%edi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d8 00 00 00    	jne    801010fe <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 f6                	xor    %esi,%esi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 31                	jg     80101060 <filewrite+0x70>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101038:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010103b:	01 47 14             	add    %eax,0x14(%edi)
8010103e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101041:	89 0c 24             	mov    %ecx,(%esp)
80101044:	e8 67 07 00 00       	call   801017b0 <iunlock>
      end_op();
80101049:	e8 92 1c 00 00       	call   80102ce0 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101051:	39 c3                	cmp    %eax,%ebx
80101053:	0f 85 99 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
80101059:	01 de                	add    %ebx,%esi
    while(i < n){
8010105b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010105e:	7e 70                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101060:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101063:	b8 00 06 00 00       	mov    $0x600,%eax
80101068:	29 f3                	sub    %esi,%ebx
8010106a:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101070:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101073:	e8 f8 1b 00 00       	call   80102c70 <begin_op>
      ilock(f->ip);
80101078:	8b 47 10             	mov    0x10(%edi),%eax
8010107b:	89 04 24             	mov    %eax,(%esp)
8010107e:	e8 4d 06 00 00       	call   801016d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101083:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80101087:	8b 47 14             	mov    0x14(%edi),%eax
8010108a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010108e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101091:	01 f0                	add    %esi,%eax
80101093:	89 44 24 04          	mov    %eax,0x4(%esp)
80101097:	8b 47 10             	mov    0x10(%edi),%eax
8010109a:	89 04 24             	mov    %eax,(%esp)
8010109d:	e8 2e 0a 00 00       	call   80101ad0 <writei>
801010a2:	85 c0                	test   %eax,%eax
801010a4:	7f 92                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
801010a6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010ac:	89 0c 24             	mov    %ecx,(%esp)
801010af:	e8 fc 06 00 00       	call   801017b0 <iunlock>
      end_op();
801010b4:	e8 27 1c 00 00       	call   80102ce0 <end_op>
      if(r < 0)
801010b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010bc:	85 c0                	test   %eax,%eax
801010be:	74 91                	je     80101051 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010c0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010c3:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
801010c8:	5b                   	pop    %ebx
801010c9:	89 f0                	mov    %esi,%eax
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
801010cf:	90                   	nop
    return i == n ? n : -1;
801010d0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801010d3:	75 eb                	jne    801010c0 <filewrite+0xd0>
}
801010d5:	83 c4 2c             	add    $0x2c,%esp
801010d8:	89 f0                	mov    %esi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 47 0c             	mov    0xc(%edi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	83 c4 2c             	add    $0x2c,%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 4e 24 00 00       	jmp    80103540 <pipewrite>
        panic("short filewrite");
801010f2:	c7 04 24 83 8a 10 80 	movl   $0x80108a83,(%esp)
801010f9:	e8 72 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
801010fe:	c7 04 24 89 8a 10 80 	movl   $0x80108a89,(%esp)
80101105:	e8 66 f2 ff ff       	call   80100370 <panic>
8010110a:	66 90                	xchg   %ax,%ax
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 35 20 2a 11 80    	mov    0x80112a20,%esi
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 f6                	test   %esi,%esi
80101124:	0f 84 7e 00 00 00    	je     801011a8 <balloc+0x98>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	8b 1d 38 2a 11 80    	mov    0x80112a38,%ebx
8010113a:	89 f0                	mov    %esi,%eax
8010113c:	c1 f8 0c             	sar    $0xc,%eax
8010113f:	01 d8                	add    %ebx,%eax
80101141:	89 44 24 04          	mov    %eax,0x4(%esp)
80101145:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101148:	89 04 24             	mov    %eax,(%esp)
8010114b:	e8 80 ef ff ff       	call   801000d0 <bread>
80101150:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101152:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80101157:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010115a:	31 c0                	xor    %eax,%eax
8010115c:	eb 2b                	jmp    80101189 <balloc+0x79>
8010115e:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
80101162:	bf 01 00 00 00       	mov    $0x1,%edi
80101167:	83 e1 07             	and    $0x7,%ecx
8010116a:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116c:	89 c1                	mov    %eax,%ecx
8010116e:	c1 f9 03             	sar    $0x3,%ecx
      m = 1 << (bi % 8);
80101171:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101174:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101179:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010117c:	89 fa                	mov    %edi,%edx
8010117e:	74 38                	je     801011b8 <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101180:	40                   	inc    %eax
80101181:	46                   	inc    %esi
80101182:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101187:	74 05                	je     8010118e <balloc+0x7e>
80101189:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118c:	77 d2                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010118e:	89 1c 24             	mov    %ebx,(%esp)
80101191:	e8 4a f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101196:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010119d:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a0:	39 05 20 2a 11 80    	cmp    %eax,0x80112a20
801011a6:	77 89                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011a8:	c7 04 24 93 8a 10 80 	movl   $0x80108a93,(%esp)
801011af:	e8 bc f1 ff ff       	call   80100370 <panic>
801011b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801011b8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801011bc:	08 c2                	or     %al,%dl
801011be:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
801011c2:	89 1c 24             	mov    %ebx,(%esp)
801011c5:	e8 46 1c 00 00       	call   80102e10 <log_write>
        brelse(bp);
801011ca:	89 1c 24             	mov    %ebx,(%esp)
801011cd:	e8 0e f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011d2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011d5:	89 74 24 04          	mov    %esi,0x4(%esp)
801011d9:	89 04 24             	mov    %eax,(%esp)
801011dc:	e8 ef ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801011e1:	ba 00 02 00 00       	mov    $0x200,%edx
801011e6:	31 c9                	xor    %ecx,%ecx
801011e8:	89 54 24 08          	mov    %edx,0x8(%esp)
801011ec:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
801011f0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011f2:	8d 40 5c             	lea    0x5c(%eax),%eax
801011f5:	89 04 24             	mov    %eax,(%esp)
801011f8:	e8 c3 4b 00 00       	call   80105dc0 <memset>
  log_write(bp);
801011fd:	89 1c 24             	mov    %ebx,(%esp)
80101200:	e8 0b 1c 00 00       	call   80102e10 <log_write>
  brelse(bp);
80101205:	89 1c 24             	mov    %ebx,(%esp)
80101208:	e8 d3 ef ff ff       	call   801001e0 <brelse>
}
8010120d:	83 c4 2c             	add    $0x2c,%esp
80101210:	89 f0                	mov    %esi,%eax
80101212:	5b                   	pop    %ebx
80101213:	5e                   	pop    %esi
80101214:	5f                   	pop    %edi
80101215:	5d                   	pop    %ebp
80101216:	c3                   	ret    
80101217:	89 f6                	mov    %esi,%esi
80101219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	89 c7                	mov    %eax,%edi
80101226:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101227:	31 f6                	xor    %esi,%esi
{
80101229:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb 74 2a 11 80       	mov    $0x80112a74,%ebx
{
8010122f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101232:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
{
80101239:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010123c:	e8 8f 4a 00 00       	call   80105cd0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101241:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101244:	eb 18                	jmp    8010125e <iget+0x3e>
80101246:	8d 76 00             	lea    0x0(%esi),%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 47                	je     801012b0 <iget+0x90>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 4d                	je     801012d1 <iget+0xb1>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101284:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101286:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101289:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101290:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101297:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010129e:	e8 cd 4a 00 00       	call   80105d70 <release>

  return ip;
}
801012a3:	83 c4 2c             	add    $0x2c,%esp
801012a6:	89 f0                	mov    %esi,%eax
801012a8:	5b                   	pop    %ebx
801012a9:	5e                   	pop    %esi
801012aa:	5f                   	pop    %edi
801012ab:	5d                   	pop    %ebp
801012ac:	c3                   	ret    
801012ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b0:	39 53 04             	cmp    %edx,0x4(%ebx)
801012b3:	75 b4                	jne    80101269 <iget+0x49>
      ip->ref++;
801012b5:	41                   	inc    %ecx
      return ip;
801012b6:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012b8:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
      ip->ref++;
801012bf:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012c2:	e8 a9 4a 00 00       	call   80105d70 <release>
}
801012c7:	83 c4 2c             	add    $0x2c,%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
    panic("iget: no inodes");
801012d1:	c7 04 24 a9 8a 10 80 	movl   $0x80108aa9,(%esp)
801012d8:	e8 93 f0 ff ff       	call   80100370 <panic>
801012dd:	8d 76 00             	lea    0x0(%esi),%esi

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012e6:	83 fa 0b             	cmp    $0xb,%edx
{
801012e9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801012ec:	89 c6                	mov    %eax,%esi
801012ee:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801012f1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
801012f4:	77 1a                	ja     80101310 <bmap+0x30>
801012f6:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801012f9:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801012fc:	85 db                	test   %ebx,%ebx
801012fe:	74 70                	je     80101370 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101300:	89 d8                	mov    %ebx,%eax
80101302:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101305:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101308:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010130b:	89 ec                	mov    %ebp,%esp
8010130d:	5d                   	pop    %ebp
8010130e:	c3                   	ret    
8010130f:	90                   	nop
  bn -= NDIRECT;
80101310:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
80101313:	83 fb 7f             	cmp    $0x7f,%ebx
80101316:	0f 87 85 00 00 00    	ja     801013a1 <bmap+0xc1>
    if((addr = ip->addrs[NDIRECT]) == 0)
8010131c:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101322:	8b 00                	mov    (%eax),%eax
80101324:	85 d2                	test   %edx,%edx
80101326:	74 68                	je     80101390 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101328:	89 54 24 04          	mov    %edx,0x4(%esp)
8010132c:	89 04 24             	mov    %eax,(%esp)
8010132f:	e8 9c ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101334:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
80101338:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010133a:	8b 1a                	mov    (%edx),%ebx
8010133c:	85 db                	test   %ebx,%ebx
8010133e:	75 19                	jne    80101359 <bmap+0x79>
      a[bn] = addr = balloc(ip->dev);
80101340:	8b 06                	mov    (%esi),%eax
80101342:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101345:	e8 c6 fd ff ff       	call   80101110 <balloc>
8010134a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010134d:	89 02                	mov    %eax,(%edx)
8010134f:	89 c3                	mov    %eax,%ebx
      log_write(bp);
80101351:	89 3c 24             	mov    %edi,(%esp)
80101354:	e8 b7 1a 00 00       	call   80102e10 <log_write>
    brelse(bp);
80101359:	89 3c 24             	mov    %edi,(%esp)
8010135c:	e8 7f ee ff ff       	call   801001e0 <brelse>
}
80101361:	89 d8                	mov    %ebx,%eax
80101363:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101366:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101369:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010136c:	89 ec                	mov    %ebp,%esp
8010136e:	5d                   	pop    %ebp
8010136f:	c3                   	ret    
      ip->addrs[bn] = addr = balloc(ip->dev);
80101370:	8b 00                	mov    (%eax),%eax
80101372:	e8 99 fd ff ff       	call   80101110 <balloc>
80101377:	89 47 5c             	mov    %eax,0x5c(%edi)
8010137a:	89 c3                	mov    %eax,%ebx
}
8010137c:	89 d8                	mov    %ebx,%eax
8010137e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101381:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101384:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101387:	89 ec                	mov    %ebp,%esp
80101389:	5d                   	pop    %ebp
8010138a:	c3                   	ret    
8010138b:	90                   	nop
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101390:	e8 7b fd ff ff       	call   80101110 <balloc>
80101395:	89 c2                	mov    %eax,%edx
80101397:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010139d:	8b 06                	mov    (%esi),%eax
8010139f:	eb 87                	jmp    80101328 <bmap+0x48>
  panic("bmap: out of range");
801013a1:	c7 04 24 b9 8a 10 80 	movl   $0x80108ab9,(%esp)
801013a8:	e8 c3 ef ff ff       	call   80100370 <panic>
801013ad:	8d 76 00             	lea    0x0(%esi),%esi

801013b0 <readsb>:
{
801013b0:	55                   	push   %ebp
  bp = bread(dev, 1);
801013b1:	b8 01 00 00 00       	mov    $0x1,%eax
{
801013b6:	89 e5                	mov    %esp,%ebp
801013b8:	83 ec 18             	sub    $0x18,%esp
  bp = bread(dev, 1);
801013bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801013bf:	8b 45 08             	mov    0x8(%ebp),%eax
{
801013c2:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801013c5:	89 75 fc             	mov    %esi,-0x4(%ebp)
801013c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013cb:	89 04 24             	mov    %eax,(%esp)
801013ce:	e8 fd ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013d3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801013d8:	89 34 24             	mov    %esi,(%esp)
801013db:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1);
801013df:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e1:	8d 40 5c             	lea    0x5c(%eax),%eax
801013e4:	89 44 24 04          	mov    %eax,0x4(%esp)
801013e8:	e8 93 4a 00 00       	call   80105e80 <memmove>
}
801013ed:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
801013f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013f3:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801013f6:	89 ec                	mov    %ebp,%esp
801013f8:	5d                   	pop    %ebp
  brelse(bp);
801013f9:	e9 e2 ed ff ff       	jmp    801001e0 <brelse>
801013fe:	66 90                	xchg   %ax,%ax

80101400 <bfree>:
{
80101400:	55                   	push   %ebp
80101401:	89 e5                	mov    %esp,%ebp
80101403:	56                   	push   %esi
80101404:	89 c6                	mov    %eax,%esi
80101406:	53                   	push   %ebx
80101407:	89 d3                	mov    %edx,%ebx
80101409:	83 ec 10             	sub    $0x10,%esp
  readsb(dev, &sb);
8010140c:	ba 20 2a 11 80       	mov    $0x80112a20,%edx
80101411:	89 54 24 04          	mov    %edx,0x4(%esp)
80101415:	89 04 24             	mov    %eax,(%esp)
80101418:	e8 93 ff ff ff       	call   801013b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010141d:	8b 0d 38 2a 11 80    	mov    0x80112a38,%ecx
80101423:	89 da                	mov    %ebx,%edx
80101425:	c1 ea 0c             	shr    $0xc,%edx
80101428:	89 34 24             	mov    %esi,(%esp)
8010142b:	01 ca                	add    %ecx,%edx
8010142d:	89 54 24 04          	mov    %edx,0x4(%esp)
80101431:	e8 9a ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101436:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101438:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010143b:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143e:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101444:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101446:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
8010144b:	0f b6 54 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%edx
  m = 1 << (bi % 8);
80101450:	d3 e0                	shl    %cl,%eax
80101452:	89 c1                	mov    %eax,%ecx
  if((bp->data[bi/8] & m) == 0)
80101454:	85 c2                	test   %eax,%edx
80101456:	74 1f                	je     80101477 <bfree+0x77>
  bp->data[bi/8] &= ~m;
80101458:	f6 d1                	not    %cl
8010145a:	20 d1                	and    %dl,%cl
8010145c:	88 4c 1e 5c          	mov    %cl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101460:	89 34 24             	mov    %esi,(%esp)
80101463:	e8 a8 19 00 00       	call   80102e10 <log_write>
  brelse(bp);
80101468:	89 34 24             	mov    %esi,(%esp)
8010146b:	e8 70 ed ff ff       	call   801001e0 <brelse>
}
80101470:	83 c4 10             	add    $0x10,%esp
80101473:	5b                   	pop    %ebx
80101474:	5e                   	pop    %esi
80101475:	5d                   	pop    %ebp
80101476:	c3                   	ret    
    panic("freeing free block");
80101477:	c7 04 24 cc 8a 10 80 	movl   $0x80108acc,(%esp)
8010147e:	e8 ed ee ff ff       	call   80100370 <panic>
80101483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
80101491:	b9 df 8a 10 80       	mov    $0x80108adf,%ecx
{
80101496:	89 e5                	mov    %esp,%ebp
80101498:	53                   	push   %ebx
80101499:	bb 80 2a 11 80       	mov    $0x80112a80,%ebx
8010149e:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014a1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014a5:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801014ac:	e8 cf 46 00 00       	call   80105b80 <initlock>
801014b1:	eb 0d                	jmp    801014c0 <iinit+0x30>
801014b3:	90                   	nop
801014b4:	90                   	nop
801014b5:	90                   	nop
801014b6:	90                   	nop
801014b7:	90                   	nop
801014b8:	90                   	nop
801014b9:	90                   	nop
801014ba:	90                   	nop
801014bb:	90                   	nop
801014bc:	90                   	nop
801014bd:	90                   	nop
801014be:	90                   	nop
801014bf:	90                   	nop
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	ba e6 8a 10 80       	mov    $0x80108ae6,%edx
801014c5:	89 1c 24             	mov    %ebx,(%esp)
801014c8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ce:	89 54 24 04          	mov    %edx,0x4(%esp)
801014d2:	e8 79 45 00 00       	call   80105a50 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014d7:	81 fb a0 46 11 80    	cmp    $0x801146a0,%ebx
801014dd:	75 e1                	jne    801014c0 <iinit+0x30>
  readsb(dev, &sb);
801014df:	b8 20 2a 11 80       	mov    $0x80112a20,%eax
801014e4:	89 44 24 04          	mov    %eax,0x4(%esp)
801014e8:	8b 45 08             	mov    0x8(%ebp),%eax
801014eb:	89 04 24             	mov    %eax,(%esp)
801014ee:	e8 bd fe ff ff       	call   801013b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014f3:	a1 38 2a 11 80       	mov    0x80112a38,%eax
801014f8:	c7 04 24 4c 8b 10 80 	movl   $0x80108b4c,(%esp)
801014ff:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101503:	a1 34 2a 11 80       	mov    0x80112a34,%eax
80101508:	89 44 24 18          	mov    %eax,0x18(%esp)
8010150c:	a1 30 2a 11 80       	mov    0x80112a30,%eax
80101511:	89 44 24 14          	mov    %eax,0x14(%esp)
80101515:	a1 2c 2a 11 80       	mov    0x80112a2c,%eax
8010151a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010151e:	a1 28 2a 11 80       	mov    0x80112a28,%eax
80101523:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101527:	a1 24 2a 11 80       	mov    0x80112a24,%eax
8010152c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101530:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80101535:	89 44 24 04          	mov    %eax,0x4(%esp)
80101539:	e8 12 f1 ff ff       	call   80100650 <cprintf>
}
8010153e:	83 c4 24             	add    $0x24,%esp
80101541:	5b                   	pop    %ebx
80101542:	5d                   	pop    %ebp
80101543:	c3                   	ret    
80101544:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010154a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101550 <ialloc>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 2c             	sub    $0x2c,%esp
80101559:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010155d:	83 3d 28 2a 11 80 01 	cmpl   $0x1,0x80112a28
{
80101564:	8b 75 08             	mov    0x8(%ebp),%esi
80101567:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010156a:	0f 86 91 00 00 00    	jbe    80101601 <ialloc+0xb1>
80101570:	bb 01 00 00 00       	mov    $0x1,%ebx
80101575:	eb 1a                	jmp    80101591 <ialloc+0x41>
80101577:	89 f6                	mov    %esi,%esi
80101579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101580:	89 3c 24             	mov    %edi,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101583:	43                   	inc    %ebx
    brelse(bp);
80101584:	e8 57 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101589:	39 1d 28 2a 11 80    	cmp    %ebx,0x80112a28
8010158f:	76 70                	jbe    80101601 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
80101591:	8b 0d 34 2a 11 80    	mov    0x80112a34,%ecx
80101597:	89 d8                	mov    %ebx,%eax
80101599:	c1 e8 03             	shr    $0x3,%eax
8010159c:	89 34 24             	mov    %esi,(%esp)
8010159f:	01 c8                	add    %ecx,%eax
801015a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a5:	e8 26 eb ff ff       	call   801000d0 <bread>
801015aa:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015ac:	89 d8                	mov    %ebx,%eax
801015ae:	83 e0 07             	and    $0x7,%eax
801015b1:	c1 e0 06             	shl    $0x6,%eax
801015b4:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015b8:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015bc:	75 c2                	jne    80101580 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015be:	31 d2                	xor    %edx,%edx
801015c0:	b8 40 00 00 00       	mov    $0x40,%eax
801015c5:	89 54 24 04          	mov    %edx,0x4(%esp)
801015c9:	89 0c 24             	mov    %ecx,(%esp)
801015cc:	89 44 24 08          	mov    %eax,0x8(%esp)
801015d0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015d3:	e8 e8 47 00 00       	call   80105dc0 <memset>
      dip->type = type;
801015d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015db:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015de:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015e1:	89 3c 24             	mov    %edi,(%esp)
801015e4:	e8 27 18 00 00       	call   80102e10 <log_write>
      brelse(bp);
801015e9:	89 3c 24             	mov    %edi,(%esp)
801015ec:	e8 ef eb ff ff       	call   801001e0 <brelse>
}
801015f1:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
801015f4:	89 da                	mov    %ebx,%edx
}
801015f6:	5b                   	pop    %ebx
      return iget(dev, inum);
801015f7:	89 f0                	mov    %esi,%eax
}
801015f9:	5e                   	pop    %esi
801015fa:	5f                   	pop    %edi
801015fb:	5d                   	pop    %ebp
      return iget(dev, inum);
801015fc:	e9 1f fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
80101601:	c7 04 24 ec 8a 10 80 	movl   $0x80108aec,(%esp)
80101608:	e8 63 ed ff ff       	call   80100370 <panic>
8010160d:	8d 76 00             	lea    0x0(%esi),%esi

80101610 <iupdate>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	56                   	push   %esi
80101614:	53                   	push   %ebx
80101615:	83 ec 10             	sub    $0x10,%esp
80101618:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010161b:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101621:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101624:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101627:	c1 e8 03             	shr    $0x3,%eax
8010162a:	01 d0                	add    %edx,%eax
8010162c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101630:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101633:	89 04 24             	mov    %eax,(%esp)
80101636:	e8 95 ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
8010163b:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163f:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101644:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101646:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101649:	83 e0 07             	and    $0x7,%eax
8010164c:	c1 e0 06             	shl    $0x6,%eax
8010164f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101653:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101656:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101659:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
8010165d:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101661:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
80101665:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101669:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
8010166d:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101671:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101674:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101677:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010167b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010167f:	89 04 24             	mov    %eax,(%esp)
80101682:	e8 f9 47 00 00       	call   80105e80 <memmove>
  log_write(bp);
80101687:	89 34 24             	mov    %esi,(%esp)
8010168a:	e8 81 17 00 00       	call   80102e10 <log_write>
  brelse(bp);
8010168f:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101692:	83 c4 10             	add    $0x10,%esp
80101695:	5b                   	pop    %ebx
80101696:	5e                   	pop    %esi
80101697:	5d                   	pop    %ebp
  brelse(bp);
80101698:	e9 43 eb ff ff       	jmp    801001e0 <brelse>
8010169d:	8d 76 00             	lea    0x0(%esi),%esi

801016a0 <idup>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	53                   	push   %ebx
801016a4:	83 ec 14             	sub    $0x14,%esp
801016a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016aa:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016b1:	e8 1a 46 00 00       	call   80105cd0 <acquire>
  ip->ref++;
801016b6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016b9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016c0:	e8 ab 46 00 00       	call   80105d70 <release>
}
801016c5:	83 c4 14             	add    $0x14,%esp
801016c8:	89 d8                	mov    %ebx,%eax
801016ca:	5b                   	pop    %ebx
801016cb:	5d                   	pop    %ebp
801016cc:	c3                   	ret    
801016cd:	8d 76 00             	lea    0x0(%esi),%esi

801016d0 <ilock>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	83 ec 10             	sub    $0x10,%esp
801016d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016db:	85 db                	test   %ebx,%ebx
801016dd:	0f 84 be 00 00 00    	je     801017a1 <ilock+0xd1>
801016e3:	8b 43 08             	mov    0x8(%ebx),%eax
801016e6:	85 c0                	test   %eax,%eax
801016e8:	0f 8e b3 00 00 00    	jle    801017a1 <ilock+0xd1>
  acquiresleep(&ip->lock);
801016ee:	8d 43 0c             	lea    0xc(%ebx),%eax
801016f1:	89 04 24             	mov    %eax,(%esp)
801016f4:	e8 97 43 00 00       	call   80105a90 <acquiresleep>
  if(ip->valid == 0){
801016f9:	8b 73 4c             	mov    0x4c(%ebx),%esi
801016fc:	85 f6                	test   %esi,%esi
801016fe:	74 10                	je     80101710 <ilock+0x40>
}
80101700:	83 c4 10             	add    $0x10,%esp
80101703:	5b                   	pop    %ebx
80101704:	5e                   	pop    %esi
80101705:	5d                   	pop    %ebp
80101706:	c3                   	ret    
80101707:	89 f6                	mov    %esi,%esi
80101709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101710:	8b 43 04             	mov    0x4(%ebx),%eax
80101713:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101719:	c1 e8 03             	shr    $0x3,%eax
8010171c:	01 d0                	add    %edx,%eax
8010171e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101722:	8b 03                	mov    (%ebx),%eax
80101724:	89 04 24             	mov    %eax,(%esp)
80101727:	e8 a4 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010172c:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101731:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101733:	8b 43 04             	mov    0x4(%ebx),%eax
80101736:	83 e0 07             	and    $0x7,%eax
80101739:	c1 e0 06             	shl    $0x6,%eax
8010173c:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101740:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101743:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101746:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
8010174a:	0f bf 50 f6          	movswl -0xa(%eax),%edx
8010174e:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101752:	0f bf 50 f8          	movswl -0x8(%eax),%edx
80101756:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010175a:	0f bf 50 fa          	movswl -0x6(%eax),%edx
8010175e:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101762:	8b 50 fc             	mov    -0x4(%eax),%edx
80101765:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101768:	89 44 24 04          	mov    %eax,0x4(%esp)
8010176c:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010176f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101773:	89 04 24             	mov    %eax,(%esp)
80101776:	e8 05 47 00 00       	call   80105e80 <memmove>
    brelse(bp);
8010177b:	89 34 24             	mov    %esi,(%esp)
8010177e:	e8 5d ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101783:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101788:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
8010178f:	0f 85 6b ff ff ff    	jne    80101700 <ilock+0x30>
      panic("ilock: no type");
80101795:	c7 04 24 04 8b 10 80 	movl   $0x80108b04,(%esp)
8010179c:	e8 cf eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017a1:	c7 04 24 fe 8a 10 80 	movl   $0x80108afe,(%esp)
801017a8:	e8 c3 eb ff ff       	call   80100370 <panic>
801017ad:	8d 76 00             	lea    0x0(%esi),%esi

801017b0 <iunlock>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	83 ec 18             	sub    $0x18,%esp
801017b6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017bf:	85 db                	test   %ebx,%ebx
801017c1:	74 27                	je     801017ea <iunlock+0x3a>
801017c3:	8d 73 0c             	lea    0xc(%ebx),%esi
801017c6:	89 34 24             	mov    %esi,(%esp)
801017c9:	e8 62 43 00 00       	call   80105b30 <holdingsleep>
801017ce:	85 c0                	test   %eax,%eax
801017d0:	74 18                	je     801017ea <iunlock+0x3a>
801017d2:	8b 43 08             	mov    0x8(%ebx),%eax
801017d5:	85 c0                	test   %eax,%eax
801017d7:	7e 11                	jle    801017ea <iunlock+0x3a>
  releasesleep(&ip->lock);
801017d9:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017dc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801017df:	8b 75 fc             	mov    -0x4(%ebp),%esi
801017e2:	89 ec                	mov    %ebp,%esp
801017e4:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017e5:	e9 06 43 00 00       	jmp    80105af0 <releasesleep>
    panic("iunlock");
801017ea:	c7 04 24 13 8b 10 80 	movl   $0x80108b13,(%esp)
801017f1:	e8 7a eb ff ff       	call   80100370 <panic>
801017f6:	8d 76 00             	lea    0x0(%esi),%esi
801017f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101800 <iput>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	83 ec 38             	sub    $0x38,%esp
80101806:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101809:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010180c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010180f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
80101812:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101815:	89 3c 24             	mov    %edi,(%esp)
80101818:	e8 73 42 00 00       	call   80105a90 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010181d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101820:	85 d2                	test   %edx,%edx
80101822:	74 07                	je     8010182b <iput+0x2b>
80101824:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101829:	74 35                	je     80101860 <iput+0x60>
  releasesleep(&ip->lock);
8010182b:	89 3c 24             	mov    %edi,(%esp)
8010182e:	e8 bd 42 00 00       	call   80105af0 <releasesleep>
  acquire(&icache.lock);
80101833:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010183a:	e8 91 44 00 00       	call   80105cd0 <acquire>
  ip->ref--;
8010183f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101842:	c7 45 08 40 2a 11 80 	movl   $0x80112a40,0x8(%ebp)
}
80101849:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010184c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010184f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101852:	89 ec                	mov    %ebp,%esp
80101854:	5d                   	pop    %ebp
  release(&icache.lock);
80101855:	e9 16 45 00 00       	jmp    80105d70 <release>
8010185a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101860:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101867:	e8 64 44 00 00       	call   80105cd0 <acquire>
    int r = ip->ref;
8010186c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010186f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101876:	e8 f5 44 00 00       	call   80105d70 <release>
    if(r == 1){
8010187b:	4e                   	dec    %esi
8010187c:	75 ad                	jne    8010182b <iput+0x2b>
8010187e:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101884:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101887:	8d 73 5c             	lea    0x5c(%ebx),%esi
8010188a:	89 cf                	mov    %ecx,%edi
8010188c:	eb 09                	jmp    80101897 <iput+0x97>
8010188e:	66 90                	xchg   %ax,%ax
80101890:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101893:	39 fe                	cmp    %edi,%esi
80101895:	74 19                	je     801018b0 <iput+0xb0>
    if(ip->addrs[i]){
80101897:	8b 16                	mov    (%esi),%edx
80101899:	85 d2                	test   %edx,%edx
8010189b:	74 f3                	je     80101890 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010189d:	8b 03                	mov    (%ebx),%eax
8010189f:	e8 5c fb ff ff       	call   80101400 <bfree>
      ip->addrs[i] = 0;
801018a4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018aa:	eb e4                	jmp    80101890 <iput+0x90>
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018b0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018b6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018b9:	85 c0                	test   %eax,%eax
801018bb:	75 33                	jne    801018f0 <iput+0xf0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018bd:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018c4:	89 1c 24             	mov    %ebx,(%esp)
801018c7:	e8 44 fd ff ff       	call   80101610 <iupdate>
      ip->type = 0;
801018cc:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
801018d2:	89 1c 24             	mov    %ebx,(%esp)
801018d5:	e8 36 fd ff ff       	call   80101610 <iupdate>
      ip->valid = 0;
801018da:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018e1:	e9 45 ff ff ff       	jmp    8010182b <iput+0x2b>
801018e6:	8d 76 00             	lea    0x0(%esi),%esi
801018e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801018f4:	8b 03                	mov    (%ebx),%eax
801018f6:	89 04 24             	mov    %eax,(%esp)
801018f9:	e8 d2 e7 ff ff       	call   801000d0 <bread>
801018fe:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101901:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101907:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010190a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010190d:	89 cf                	mov    %ecx,%edi
8010190f:	eb 0e                	jmp    8010191f <iput+0x11f>
80101911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101918:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010191b:	39 fe                	cmp    %edi,%esi
8010191d:	74 0f                	je     8010192e <iput+0x12e>
      if(a[j])
8010191f:	8b 16                	mov    (%esi),%edx
80101921:	85 d2                	test   %edx,%edx
80101923:	74 f3                	je     80101918 <iput+0x118>
        bfree(ip->dev, a[j]);
80101925:	8b 03                	mov    (%ebx),%eax
80101927:	e8 d4 fa ff ff       	call   80101400 <bfree>
8010192c:	eb ea                	jmp    80101918 <iput+0x118>
    brelse(bp);
8010192e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101931:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101934:	89 04 24             	mov    %eax,(%esp)
80101937:	e8 a4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010193c:	8b 03                	mov    (%ebx),%eax
8010193e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101944:	e8 b7 fa ff ff       	call   80101400 <bfree>
    ip->addrs[NDIRECT] = 0;
80101949:	31 c0                	xor    %eax,%eax
8010194b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101951:	e9 67 ff ff ff       	jmp    801018bd <iput+0xbd>
80101956:	8d 76 00             	lea    0x0(%esi),%esi
80101959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101960 <iunlockput>:
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	53                   	push   %ebx
80101964:	83 ec 14             	sub    $0x14,%esp
80101967:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010196a:	89 1c 24             	mov    %ebx,(%esp)
8010196d:	e8 3e fe ff ff       	call   801017b0 <iunlock>
  iput(ip);
80101972:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101975:	83 c4 14             	add    $0x14,%esp
80101978:	5b                   	pop    %ebx
80101979:	5d                   	pop    %ebp
  iput(ip);
8010197a:	e9 81 fe ff ff       	jmp    80101800 <iput>
8010197f:	90                   	nop

80101980 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	8b 55 08             	mov    0x8(%ebp),%edx
80101986:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101989:	8b 0a                	mov    (%edx),%ecx
8010198b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010198e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101991:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101994:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
80101998:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010199b:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
8010199f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019a3:	8b 52 58             	mov    0x58(%edx),%edx
801019a6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019a9:	5d                   	pop    %ebp
801019aa:	c3                   	ret    
801019ab:	90                   	nop
801019ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019b0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	57                   	push   %edi
801019b4:	56                   	push   %esi
801019b5:	53                   	push   %ebx
801019b6:	83 ec 3c             	sub    $0x3c,%esp
801019b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801019bc:	8b 7d 08             	mov    0x8(%ebp),%edi
801019bf:	8b 75 10             	mov    0x10(%ebp),%esi
801019c2:	89 45 dc             	mov    %eax,-0x24(%ebp)
801019c5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019c8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
801019cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
801019d0:	0f 84 ca 00 00 00    	je     80101aa0 <readi+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019d6:	8b 47 58             	mov    0x58(%edi),%eax
801019d9:	39 c6                	cmp    %eax,%esi
801019db:	0f 87 e3 00 00 00    	ja     80101ac4 <readi+0x114>
801019e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801019e4:	01 f2                	add    %esi,%edx
801019e6:	0f 82 d8 00 00 00    	jb     80101ac4 <readi+0x114>
    return -1;
  if(off + n > ip->size)
801019ec:	39 d0                	cmp    %edx,%eax
801019ee:	0f 82 9c 00 00 00    	jb     80101a90 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019f7:	85 c0                	test   %eax,%eax
801019f9:	0f 84 86 00 00 00    	je     80101a85 <readi+0xd5>
801019ff:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a06:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80101a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a10:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80101a13:	89 f2                	mov    %esi,%edx
80101a15:	c1 ea 09             	shr    $0x9,%edx
80101a18:	89 f8                	mov    %edi,%eax
80101a1a:	e8 c1 f8 ff ff       	call   801012e0 <bmap>
80101a1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a23:	8b 07                	mov    (%edi),%eax
80101a25:	89 04 24             	mov    %eax,(%esp)
80101a28:	e8 a3 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a2d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a30:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a35:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a38:	29 df                	sub    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a3a:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a3c:	89 f0                	mov    %esi,%eax
80101a3e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a43:	89 fb                	mov    %edi,%ebx
80101a45:	29 c1                	sub    %eax,%ecx
80101a47:	39 f9                	cmp    %edi,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a49:	8b 7d dc             	mov    -0x24(%ebp),%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a4c:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a4f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a53:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a55:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a59:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a5d:	89 3c 24             	mov    %edi,(%esp)
80101a60:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101a63:	e8 18 44 00 00       	call   80105e80 <memmove>
    brelse(bp);
80101a68:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a6b:	89 14 24             	mov    %edx,(%esp)
80101a6e:	e8 6d e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a73:	89 f9                	mov    %edi,%ecx
80101a75:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a78:	01 d9                	add    %ebx,%ecx
80101a7a:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101a7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a80:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101a83:	77 8b                	ja     80101a10 <readi+0x60>
  }
  return n;
80101a85:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101a88:	83 c4 3c             	add    $0x3c,%esp
80101a8b:	5b                   	pop    %ebx
80101a8c:	5e                   	pop    %esi
80101a8d:	5f                   	pop    %edi
80101a8e:	5d                   	pop    %ebp
80101a8f:	c3                   	ret    
    n = ip->size - off;
80101a90:	29 f0                	sub    %esi,%eax
80101a92:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a95:	e9 5a ff ff ff       	jmp    801019f4 <readi+0x44>
80101a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101aa0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101aa4:	66 83 f8 09          	cmp    $0x9,%ax
80101aa8:	77 1a                	ja     80101ac4 <readi+0x114>
80101aaa:	8b 04 c5 c0 29 11 80 	mov    -0x7feed640(,%eax,8),%eax
80101ab1:	85 c0                	test   %eax,%eax
80101ab3:	74 0f                	je     80101ac4 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101ab5:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ab8:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101abb:	83 c4 3c             	add    $0x3c,%esp
80101abe:	5b                   	pop    %ebx
80101abf:	5e                   	pop    %esi
80101ac0:	5f                   	pop    %edi
80101ac1:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101ac2:	ff e0                	jmp    *%eax
      return -1;
80101ac4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ac9:	eb bd                	jmp    80101a88 <readi+0xd8>
80101acb:	90                   	nop
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 2c             	sub    $0x2c,%esp
80101ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101adc:	8b 7d 08             	mov    0x8(%ebp),%edi
80101adf:	8b 75 10             	mov    0x10(%ebp),%esi
80101ae2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ae5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ae8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101aed:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101af0:	0f 84 da 00 00 00    	je     80101bd0 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101af6:	39 77 58             	cmp    %esi,0x58(%edi)
80101af9:	0f 82 09 01 00 00    	jb     80101c08 <writei+0x138>
80101aff:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b02:	31 d2                	xor    %edx,%edx
80101b04:	01 f0                	add    %esi,%eax
80101b06:	0f 82 03 01 00 00    	jb     80101c0f <writei+0x13f>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b0c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b11:	0f 87 f1 00 00 00    	ja     80101c08 <writei+0x138>
80101b17:	85 d2                	test   %edx,%edx
80101b19:	0f 85 e9 00 00 00    	jne    80101c08 <writei+0x138>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b1f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b29:	85 c9                	test   %ecx,%ecx
80101b2b:	0f 84 8c 00 00 00    	je     80101bbd <writei+0xed>
80101b31:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101b34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b40:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b43:	89 f8                	mov    %edi,%eax
80101b45:	89 da                	mov    %ebx,%edx
80101b47:	c1 ea 09             	shr    $0x9,%edx
80101b4a:	e8 91 f7 ff ff       	call   801012e0 <bmap>
80101b4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b53:	8b 07                	mov    (%edi),%eax
80101b55:	89 04 24             	mov    %eax,(%esp)
80101b58:	e8 73 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b5d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b60:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b65:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b68:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b6a:	89 d8                	mov    %ebx,%eax
80101b6c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101b6f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b74:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b76:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	29 d3                	sub    %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b7c:	8b 55 d8             	mov    -0x28(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7f:	39 d9                	cmp    %ebx,%ecx
80101b81:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b84:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b88:	89 54 24 04          	mov    %edx,0x4(%esp)
80101b8c:	89 04 24             	mov    %eax,(%esp)
80101b8f:	e8 ec 42 00 00       	call   80105e80 <memmove>
    log_write(bp);
80101b94:	89 34 24             	mov    %esi,(%esp)
80101b97:	e8 74 12 00 00       	call   80102e10 <log_write>
    brelse(bp);
80101b9c:	89 34 24             	mov    %esi,(%esp)
80101b9f:	e8 3c e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ba4:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101ba7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101baa:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101bad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101bb0:	39 4d dc             	cmp    %ecx,-0x24(%ebp)
80101bb3:	77 8b                	ja     80101b40 <writei+0x70>
80101bb5:	8b 75 e0             	mov    -0x20(%ebp),%esi
  }

  if(n > 0 && off > ip->size){
80101bb8:	3b 77 58             	cmp    0x58(%edi),%esi
80101bbb:	77 3b                	ja     80101bf8 <writei+0x128>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bbd:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101bc0:	83 c4 2c             	add    $0x2c,%esp
80101bc3:	5b                   	pop    %ebx
80101bc4:	5e                   	pop    %esi
80101bc5:	5f                   	pop    %edi
80101bc6:	5d                   	pop    %ebp
80101bc7:	c3                   	ret    
80101bc8:	90                   	nop
80101bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bd0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101bd4:	66 83 f8 09          	cmp    $0x9,%ax
80101bd8:	77 2e                	ja     80101c08 <writei+0x138>
80101bda:	8b 04 c5 c4 29 11 80 	mov    -0x7feed63c(,%eax,8),%eax
80101be1:	85 c0                	test   %eax,%eax
80101be3:	74 23                	je     80101c08 <writei+0x138>
    return devsw[ip->major].write(ip, src, n);
80101be5:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101be8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101beb:	83 c4 2c             	add    $0x2c,%esp
80101bee:	5b                   	pop    %ebx
80101bef:	5e                   	pop    %esi
80101bf0:	5f                   	pop    %edi
80101bf1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bf2:	ff e0                	jmp    *%eax
80101bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101bf8:	89 77 58             	mov    %esi,0x58(%edi)
    iupdate(ip);
80101bfb:	89 3c 24             	mov    %edi,(%esp)
80101bfe:	e8 0d fa ff ff       	call   80101610 <iupdate>
80101c03:	eb b8                	jmp    80101bbd <writei+0xed>
80101c05:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
80101c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c0d:	eb b1                	jmp    80101bc0 <writei+0xf0>
80101c0f:	ba 01 00 00 00       	mov    $0x1,%edx
80101c14:	e9 f3 fe ff ff       	jmp    80101b0c <writei+0x3c>
80101c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c20:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101c21:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101c26:	89 e5                	mov    %esp,%ebp
80101c28:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c32:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c36:	8b 45 08             	mov    0x8(%ebp),%eax
80101c39:	89 04 24             	mov    %eax,(%esp)
80101c3c:	e8 9f 42 00 00       	call   80105ee0 <strncmp>
}
80101c41:	c9                   	leave  
80101c42:	c3                   	ret    
80101c43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 2c             	sub    $0x2c,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c61:	0f 85 a4 00 00 00    	jne    80101d0b <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c67:	8b 43 58             	mov    0x58(%ebx),%eax
80101c6a:	31 ff                	xor    %edi,%edi
80101c6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c6f:	85 c0                	test   %eax,%eax
80101c71:	74 59                	je     80101ccc <dirlookup+0x7c>
80101c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c80:	b9 10 00 00 00       	mov    $0x10,%ecx
80101c85:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101c89:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101c8d:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c91:	89 1c 24             	mov    %ebx,(%esp)
80101c94:	e8 17 fd ff ff       	call   801019b0 <readi>
80101c99:	83 f8 10             	cmp    $0x10,%eax
80101c9c:	75 61                	jne    80101cff <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101c9e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ca3:	74 1f                	je     80101cc4 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101ca5:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ca8:	ba 0e 00 00 00       	mov    $0xe,%edx
80101cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cb4:	89 54 24 08          	mov    %edx,0x8(%esp)
80101cb8:	89 04 24             	mov    %eax,(%esp)
80101cbb:	e8 20 42 00 00       	call   80105ee0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cc0:	85 c0                	test   %eax,%eax
80101cc2:	74 1c                	je     80101ce0 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cc4:	83 c7 10             	add    $0x10,%edi
80101cc7:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cca:	72 b4                	jb     80101c80 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ccc:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101ccf:	31 c0                	xor    %eax,%eax
}
80101cd1:	5b                   	pop    %ebx
80101cd2:	5e                   	pop    %esi
80101cd3:	5f                   	pop    %edi
80101cd4:	5d                   	pop    %ebp
80101cd5:	c3                   	ret    
80101cd6:	8d 76 00             	lea    0x0(%esi),%esi
80101cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(poff)
80101ce0:	8b 45 10             	mov    0x10(%ebp),%eax
80101ce3:	85 c0                	test   %eax,%eax
80101ce5:	74 05                	je     80101cec <dirlookup+0x9c>
        *poff = off;
80101ce7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cea:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cec:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cf0:	8b 03                	mov    (%ebx),%eax
80101cf2:	e8 29 f5 ff ff       	call   80101220 <iget>
}
80101cf7:	83 c4 2c             	add    $0x2c,%esp
80101cfa:	5b                   	pop    %ebx
80101cfb:	5e                   	pop    %esi
80101cfc:	5f                   	pop    %edi
80101cfd:	5d                   	pop    %ebp
80101cfe:	c3                   	ret    
      panic("dirlookup read");
80101cff:	c7 04 24 2d 8b 10 80 	movl   $0x80108b2d,(%esp)
80101d06:	e8 65 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d0b:	c7 04 24 1b 8b 10 80 	movl   $0x80108b1b,(%esp)
80101d12:	e8 59 e6 ff ff       	call   80100370 <panic>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d20 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	89 cf                	mov    %ecx,%edi
80101d26:	56                   	push   %esi
80101d27:	53                   	push   %ebx
80101d28:	89 c3                	mov    %eax,%ebx
80101d2a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d2d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d30:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d33:	0f 84 5b 01 00 00    	je     80101e94 <namex+0x174>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d39:	e8 22 1c 00 00       	call   80103960 <myproc>
80101d3e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d41:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d48:	e8 83 3f 00 00       	call   80105cd0 <acquire>
  ip->ref++;
80101d4d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d50:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d57:	e8 14 40 00 00       	call   80105d70 <release>
80101d5c:	eb 03                	jmp    80101d61 <namex+0x41>
80101d5e:	66 90                	xchg   %ax,%ax
    path++;
80101d60:	43                   	inc    %ebx
  while(*path == '/')
80101d61:	0f b6 03             	movzbl (%ebx),%eax
80101d64:	3c 2f                	cmp    $0x2f,%al
80101d66:	74 f8                	je     80101d60 <namex+0x40>
  if(*path == 0)
80101d68:	84 c0                	test   %al,%al
80101d6a:	0f 84 f0 00 00 00    	je     80101e60 <namex+0x140>
  while(*path != '/' && *path != 0)
80101d70:	0f b6 03             	movzbl (%ebx),%eax
80101d73:	3c 2f                	cmp    $0x2f,%al
80101d75:	0f 84 b5 00 00 00    	je     80101e30 <namex+0x110>
80101d7b:	84 c0                	test   %al,%al
80101d7d:	89 da                	mov    %ebx,%edx
80101d7f:	75 13                	jne    80101d94 <namex+0x74>
80101d81:	e9 aa 00 00 00       	jmp    80101e30 <namex+0x110>
80101d86:	8d 76 00             	lea    0x0(%esi),%esi
80101d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101d90:	84 c0                	test   %al,%al
80101d92:	74 08                	je     80101d9c <namex+0x7c>
    path++;
80101d94:	42                   	inc    %edx
  while(*path != '/' && *path != 0)
80101d95:	0f b6 02             	movzbl (%edx),%eax
80101d98:	3c 2f                	cmp    $0x2f,%al
80101d9a:	75 f4                	jne    80101d90 <namex+0x70>
80101d9c:	89 d1                	mov    %edx,%ecx
80101d9e:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101da0:	83 f9 0d             	cmp    $0xd,%ecx
80101da3:	0f 8e 8b 00 00 00    	jle    80101e34 <namex+0x114>
    memmove(name, s, DIRSIZ);
80101da9:	b8 0e 00 00 00       	mov    $0xe,%eax
80101dae:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101db2:	89 44 24 08          	mov    %eax,0x8(%esp)
80101db6:	89 3c 24             	mov    %edi,(%esp)
80101db9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101dbc:	e8 bf 40 00 00       	call   80105e80 <memmove>
    path++;
80101dc1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101dc4:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101dc6:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101dc9:	75 0b                	jne    80101dd6 <namex+0xb6>
80101dcb:	90                   	nop
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dd0:	43                   	inc    %ebx
  while(*path == '/')
80101dd1:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101dd4:	74 fa                	je     80101dd0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dd6:	89 34 24             	mov    %esi,(%esp)
80101dd9:	e8 f2 f8 ff ff       	call   801016d0 <ilock>
    if(ip->type != T_DIR){
80101dde:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101de3:	0f 85 8f 00 00 00    	jne    80101e78 <namex+0x158>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101de9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dec:	85 c0                	test   %eax,%eax
80101dee:	74 09                	je     80101df9 <namex+0xd9>
80101df0:	80 3b 00             	cmpb   $0x0,(%ebx)
80101df3:	0f 84 b1 00 00 00    	je     80101eaa <namex+0x18a>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101df9:	31 c9                	xor    %ecx,%ecx
80101dfb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101dff:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101e03:	89 34 24             	mov    %esi,(%esp)
80101e06:	e8 45 fe ff ff       	call   80101c50 <dirlookup>
80101e0b:	85 c0                	test   %eax,%eax
80101e0d:	74 69                	je     80101e78 <namex+0x158>
  iunlock(ip);
80101e0f:	89 34 24             	mov    %esi,(%esp)
80101e12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e15:	e8 96 f9 ff ff       	call   801017b0 <iunlock>
  iput(ip);
80101e1a:	89 34 24             	mov    %esi,(%esp)
80101e1d:	e8 de f9 ff ff       	call   80101800 <iput>
80101e22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e25:	89 c6                	mov    %eax,%esi
80101e27:	e9 35 ff ff ff       	jmp    80101d61 <namex+0x41>
80101e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e30:	89 da                	mov    %ebx,%edx
80101e32:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e34:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e38:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e3c:	89 3c 24             	mov    %edi,(%esp)
80101e3f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e42:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e45:	e8 36 40 00 00       	call   80105e80 <memmove>
    name[len] = 0;
80101e4a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e50:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e54:	89 d3                	mov    %edx,%ebx
80101e56:	e9 6b ff ff ff       	jmp    80101dc6 <namex+0xa6>
80101e5b:	90                   	nop
80101e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e60:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e63:	85 d2                	test   %edx,%edx
80101e65:	75 55                	jne    80101ebc <namex+0x19c>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e67:	83 c4 2c             	add    $0x2c,%esp
80101e6a:	89 f0                	mov    %esi,%eax
80101e6c:	5b                   	pop    %ebx
80101e6d:	5e                   	pop    %esi
80101e6e:	5f                   	pop    %edi
80101e6f:	5d                   	pop    %ebp
80101e70:	c3                   	ret    
80101e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e78:	89 34 24             	mov    %esi,(%esp)
80101e7b:	e8 30 f9 ff ff       	call   801017b0 <iunlock>
  iput(ip);
80101e80:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e83:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e85:	e8 76 f9 ff ff       	call   80101800 <iput>
}
80101e8a:	83 c4 2c             	add    $0x2c,%esp
80101e8d:	89 f0                	mov    %esi,%eax
80101e8f:	5b                   	pop    %ebx
80101e90:	5e                   	pop    %esi
80101e91:	5f                   	pop    %edi
80101e92:	5d                   	pop    %ebp
80101e93:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e94:	ba 01 00 00 00       	mov    $0x1,%edx
80101e99:	b8 01 00 00 00       	mov    $0x1,%eax
80101e9e:	e8 7d f3 ff ff       	call   80101220 <iget>
80101ea3:	89 c6                	mov    %eax,%esi
80101ea5:	e9 b7 fe ff ff       	jmp    80101d61 <namex+0x41>
      iunlock(ip);
80101eaa:	89 34 24             	mov    %esi,(%esp)
80101ead:	e8 fe f8 ff ff       	call   801017b0 <iunlock>
}
80101eb2:	83 c4 2c             	add    $0x2c,%esp
80101eb5:	89 f0                	mov    %esi,%eax
80101eb7:	5b                   	pop    %ebx
80101eb8:	5e                   	pop    %esi
80101eb9:	5f                   	pop    %edi
80101eba:	5d                   	pop    %ebp
80101ebb:	c3                   	ret    
    iput(ip);
80101ebc:	89 34 24             	mov    %esi,(%esp)
    return 0;
80101ebf:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ec1:	e8 3a f9 ff ff       	call   80101800 <iput>
    return 0;
80101ec6:	eb 9f                	jmp    80101e67 <namex+0x147>
80101ec8:	90                   	nop
80101ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ed0 <dirlink>:
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	57                   	push   %edi
80101ed4:	56                   	push   %esi
80101ed5:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ed6:	31 db                	xor    %ebx,%ebx
{
80101ed8:	83 ec 2c             	sub    $0x2c,%esp
80101edb:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ede:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ee1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ee5:	89 3c 24             	mov    %edi,(%esp)
80101ee8:	89 44 24 04          	mov    %eax,0x4(%esp)
80101eec:	e8 5f fd ff ff       	call   80101c50 <dirlookup>
80101ef1:	85 c0                	test   %eax,%eax
80101ef3:	0f 85 8e 00 00 00    	jne    80101f87 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ef9:	8b 5f 58             	mov    0x58(%edi),%ebx
80101efc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101eff:	85 db                	test   %ebx,%ebx
80101f01:	74 3a                	je     80101f3d <dirlink+0x6d>
80101f03:	31 db                	xor    %ebx,%ebx
80101f05:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f08:	eb 0e                	jmp    80101f18 <dirlink+0x48>
80101f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f10:	83 c3 10             	add    $0x10,%ebx
80101f13:	3b 5f 58             	cmp    0x58(%edi),%ebx
80101f16:	73 25                	jae    80101f3d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f18:	b9 10 00 00 00       	mov    $0x10,%ecx
80101f1d:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101f21:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f25:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f29:	89 3c 24             	mov    %edi,(%esp)
80101f2c:	e8 7f fa ff ff       	call   801019b0 <readi>
80101f31:	83 f8 10             	cmp    $0x10,%eax
80101f34:	75 60                	jne    80101f96 <dirlink+0xc6>
    if(de.inum == 0)
80101f36:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f3b:	75 d3                	jne    80101f10 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101f3d:	b8 0e 00 00 00       	mov    $0xe,%eax
80101f42:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f46:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f49:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f4d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f50:	89 04 24             	mov    %eax,(%esp)
80101f53:	e8 e8 3f 00 00       	call   80105f40 <strncpy>
  de.inum = inum;
80101f58:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f5b:	ba 10 00 00 00       	mov    $0x10,%edx
80101f60:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101f64:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f68:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f6c:	89 3c 24             	mov    %edi,(%esp)
  de.inum = inum;
80101f6f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f73:	e8 58 fb ff ff       	call   80101ad0 <writei>
80101f78:	83 f8 10             	cmp    $0x10,%eax
80101f7b:	75 25                	jne    80101fa2 <dirlink+0xd2>
  return 0;
80101f7d:	31 c0                	xor    %eax,%eax
}
80101f7f:	83 c4 2c             	add    $0x2c,%esp
80101f82:	5b                   	pop    %ebx
80101f83:	5e                   	pop    %esi
80101f84:	5f                   	pop    %edi
80101f85:	5d                   	pop    %ebp
80101f86:	c3                   	ret    
    iput(ip);
80101f87:	89 04 24             	mov    %eax,(%esp)
80101f8a:	e8 71 f8 ff ff       	call   80101800 <iput>
    return -1;
80101f8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f94:	eb e9                	jmp    80101f7f <dirlink+0xaf>
      panic("dirlink read");
80101f96:	c7 04 24 3c 8b 10 80 	movl   $0x80108b3c,(%esp)
80101f9d:	e8 ce e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fa2:	c7 04 24 0e 92 10 80 	movl   $0x8010920e,(%esp)
80101fa9:	e8 c2 e3 ff ff       	call   80100370 <panic>
80101fae:	66 90                	xchg   %ax,%ax

80101fb0 <namei>:

struct inode*
namei(char *path)
{
80101fb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fb1:	31 d2                	xor    %edx,%edx
{
80101fb3:	89 e5                	mov    %esp,%ebp
80101fb5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fbe:	e8 5d fd ff ff       	call   80101d20 <namex>
}
80101fc3:	c9                   	leave  
80101fc4:	c3                   	ret    
80101fc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fd0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fd1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fd6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fd8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fdb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fde:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fdf:	e9 3c fd ff ff       	jmp    80101d20 <namex>
80101fe4:	66 90                	xchg   %ax,%ax
80101fe6:	66 90                	xchg   %ax,%ax
80101fe8:	66 90                	xchg   %ax,%ax
80101fea:	66 90                	xchg   %ax,%ax
80101fec:	66 90                	xchg   %ax,%ax
80101fee:	66 90                	xchg   %ax,%ax

80101ff0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	56                   	push   %esi
80101ff4:	53                   	push   %ebx
80101ff5:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101ff8:	85 c0                	test   %eax,%eax
80101ffa:	0f 84 a8 00 00 00    	je     801020a8 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102000:	8b 48 08             	mov    0x8(%eax),%ecx
80102003:	89 c6                	mov    %eax,%esi
80102005:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010200b:	0f 87 8b 00 00 00    	ja     8010209c <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102011:	bb f7 01 00 00       	mov    $0x1f7,%ebx
80102016:	8d 76 00             	lea    0x0(%esi),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102020:	89 da                	mov    %ebx,%edx
80102022:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102023:	24 c0                	and    $0xc0,%al
80102025:	3c 40                	cmp    $0x40,%al
80102027:	75 f7                	jne    80102020 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102029:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010202e:	31 c0                	xor    %eax,%eax
80102030:	ee                   	out    %al,(%dx)
80102031:	b0 01                	mov    $0x1,%al
80102033:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102038:	ee                   	out    %al,(%dx)
80102039:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010203e:	88 c8                	mov    %cl,%al
80102040:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102041:	c1 f9 08             	sar    $0x8,%ecx
80102044:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102049:	89 c8                	mov    %ecx,%eax
8010204b:	ee                   	out    %al,(%dx)
8010204c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102051:	31 c0                	xor    %eax,%eax
80102053:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102054:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102058:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010205d:	c0 e0 04             	shl    $0x4,%al
80102060:	24 10                	and    $0x10,%al
80102062:	0c e0                	or     $0xe0,%al
80102064:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102065:	f6 06 04             	testb  $0x4,(%esi)
80102068:	75 16                	jne    80102080 <idestart+0x90>
8010206a:	b0 20                	mov    $0x20,%al
8010206c:	89 da                	mov    %ebx,%edx
8010206e:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010206f:	83 c4 10             	add    $0x10,%esp
80102072:	5b                   	pop    %ebx
80102073:	5e                   	pop    %esi
80102074:	5d                   	pop    %ebp
80102075:	c3                   	ret    
80102076:	8d 76 00             	lea    0x0(%esi),%esi
80102079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102080:	b0 30                	mov    $0x30,%al
80102082:	89 da                	mov    %ebx,%edx
80102084:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102085:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
8010208a:	83 c6 5c             	add    $0x5c,%esi
8010208d:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102092:	fc                   	cld    
80102093:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102095:	83 c4 10             	add    $0x10,%esp
80102098:	5b                   	pop    %ebx
80102099:	5e                   	pop    %esi
8010209a:	5d                   	pop    %ebp
8010209b:	c3                   	ret    
    panic("incorrect blockno");
8010209c:	c7 04 24 a8 8b 10 80 	movl   $0x80108ba8,(%esp)
801020a3:	e8 c8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020a8:	c7 04 24 9f 8b 10 80 	movl   $0x80108b9f,(%esp)
801020af:	e8 bc e2 ff ff       	call   80100370 <panic>
801020b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020c0 <ideinit>:
{
801020c0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020c1:	ba ba 8b 10 80       	mov    $0x80108bba,%edx
{
801020c6:	89 e5                	mov    %esp,%ebp
801020c8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020cb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020cf:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020d6:	e8 a5 3a 00 00       	call   80105b80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020db:	a1 60 4d 11 80       	mov    0x80114d60,%eax
801020e0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801020e7:	48                   	dec    %eax
801020e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801020ec:	e8 8f 02 00 00       	call   80102380 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020f1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020f6:	8d 76 00             	lea    0x0(%esi),%esi
801020f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102100:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102101:	24 c0                	and    $0xc0,%al
80102103:	3c 40                	cmp    $0x40,%al
80102105:	75 f9                	jne    80102100 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102107:	b0 f0                	mov    $0xf0,%al
80102109:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010210e:	ee                   	out    %al,(%dx)
8010210f:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102114:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102119:	eb 08                	jmp    80102123 <ideinit+0x63>
8010211b:	90                   	nop
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102120:	49                   	dec    %ecx
80102121:	74 0f                	je     80102132 <ideinit+0x72>
80102123:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102124:	84 c0                	test   %al,%al
80102126:	74 f8                	je     80102120 <ideinit+0x60>
      havedisk1 = 1;
80102128:	b8 01 00 00 00       	mov    $0x1,%eax
8010212d:	a3 60 c5 10 80       	mov    %eax,0x8010c560
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102132:	b0 e0                	mov    $0xe0,%al
80102134:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102139:	ee                   	out    %al,(%dx)
}
8010213a:	c9                   	leave  
8010213b:	c3                   	ret    
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102146:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
{
8010214d:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102150:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102153:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&idelock);
80102156:	e8 75 3b 00 00       	call   80105cd0 <acquire>

  if((b = idequeue) == 0){
8010215b:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102161:	85 db                	test   %ebx,%ebx
80102163:	74 5c                	je     801021c1 <ideintr+0x81>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102165:	8b 43 58             	mov    0x58(%ebx),%eax
80102168:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010216d:	8b 0b                	mov    (%ebx),%ecx
8010216f:	f6 c1 04             	test   $0x4,%cl
80102172:	75 2f                	jne    801021a3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102174:	be f7 01 00 00       	mov    $0x1f7,%esi
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102180:	89 f2                	mov    %esi,%edx
80102182:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102183:	88 c2                	mov    %al,%dl
80102185:	80 e2 c0             	and    $0xc0,%dl
80102188:	80 fa 40             	cmp    $0x40,%dl
8010218b:	75 f3                	jne    80102180 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010218d:	a8 21                	test   $0x21,%al
8010218f:	75 12                	jne    801021a3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102191:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102194:	b9 80 00 00 00       	mov    $0x80,%ecx
80102199:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010219e:	fc                   	cld    
8010219f:	f3 6d                	rep insl (%dx),%es:(%edi)
801021a1:	8b 0b                	mov    (%ebx),%ecx

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021a3:	83 e1 fb             	and    $0xfffffffb,%ecx
801021a6:	83 c9 02             	or     $0x2,%ecx
801021a9:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021ab:	89 1c 24             	mov    %ebx,(%esp)
801021ae:	e8 4d 29 00 00       	call   80104b00 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021b3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021b8:	85 c0                	test   %eax,%eax
801021ba:	74 05                	je     801021c1 <ideintr+0x81>
    idestart(idequeue);
801021bc:	e8 2f fe ff ff       	call   80101ff0 <idestart>
    release(&idelock);
801021c1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021c8:	e8 a3 3b 00 00       	call   80105d70 <release>

  release(&idelock);
}
801021cd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801021d0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801021d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801021d6:	89 ec                	mov    %ebp,%esp
801021d8:	5d                   	pop    %ebp
801021d9:	c3                   	ret    
801021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	53                   	push   %ebx
801021e4:	83 ec 14             	sub    $0x14,%esp
801021e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801021ed:	89 04 24             	mov    %eax,(%esp)
801021f0:	e8 3b 39 00 00       	call   80105b30 <holdingsleep>
801021f5:	85 c0                	test   %eax,%eax
801021f7:	0f 84 b6 00 00 00    	je     801022b3 <iderw+0xd3>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801021fd:	8b 03                	mov    (%ebx),%eax
801021ff:	83 e0 06             	and    $0x6,%eax
80102202:	83 f8 02             	cmp    $0x2,%eax
80102205:	0f 84 9c 00 00 00    	je     801022a7 <iderw+0xc7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010220b:	8b 4b 04             	mov    0x4(%ebx),%ecx
8010220e:	85 c9                	test   %ecx,%ecx
80102210:	74 0e                	je     80102220 <iderw+0x40>
80102212:	8b 15 60 c5 10 80    	mov    0x8010c560,%edx
80102218:	85 d2                	test   %edx,%edx
8010221a:	0f 84 9f 00 00 00    	je     801022bf <iderw+0xdf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102220:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102227:	e8 a4 3a 00 00       	call   80105cd0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010222c:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
  b->qnext = 0;
80102232:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102239:	85 d2                	test   %edx,%edx
8010223b:	75 05                	jne    80102242 <iderw+0x62>
8010223d:	eb 61                	jmp    801022a0 <iderw+0xc0>
8010223f:	90                   	nop
80102240:	89 c2                	mov    %eax,%edx
80102242:	8b 42 58             	mov    0x58(%edx),%eax
80102245:	85 c0                	test   %eax,%eax
80102247:	75 f7                	jne    80102240 <iderw+0x60>
80102249:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010224c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010224e:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
80102254:	75 1b                	jne    80102271 <iderw+0x91>
80102256:	eb 38                	jmp    80102290 <iderw+0xb0>
80102258:	90                   	nop
80102259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102260:	b8 80 c5 10 80       	mov    $0x8010c580,%eax
80102265:	89 44 24 04          	mov    %eax,0x4(%esp)
80102269:	89 1c 24             	mov    %ebx,(%esp)
8010226c:	e8 af 24 00 00       	call   80104720 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102271:	8b 03                	mov    (%ebx),%eax
80102273:	83 e0 06             	and    $0x6,%eax
80102276:	83 f8 02             	cmp    $0x2,%eax
80102279:	75 e5                	jne    80102260 <iderw+0x80>
  }


  release(&idelock);
8010227b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102282:	83 c4 14             	add    $0x14,%esp
80102285:	5b                   	pop    %ebx
80102286:	5d                   	pop    %ebp
  release(&idelock);
80102287:	e9 e4 3a 00 00       	jmp    80105d70 <release>
8010228c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102290:	89 d8                	mov    %ebx,%eax
80102292:	e8 59 fd ff ff       	call   80101ff0 <idestart>
80102297:	eb d8                	jmp    80102271 <iderw+0x91>
80102299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022a0:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
801022a5:	eb a5                	jmp    8010224c <iderw+0x6c>
    panic("iderw: nothing to do");
801022a7:	c7 04 24 d4 8b 10 80 	movl   $0x80108bd4,(%esp)
801022ae:	e8 bd e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022b3:	c7 04 24 be 8b 10 80 	movl   $0x80108bbe,(%esp)
801022ba:	e8 b1 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022bf:	c7 04 24 e9 8b 10 80 	movl   $0x80108be9,(%esp)
801022c6:	e8 a5 e0 ff ff       	call   80100370 <panic>
801022cb:	66 90                	xchg   %ax,%ax
801022cd:	66 90                	xchg   %ax,%ax
801022cf:	90                   	nop

801022d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022d0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022d1:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
801022d6:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801022d8:	ba 01 00 00 00       	mov    $0x1,%edx
{
801022dd:	56                   	push   %esi
801022de:	53                   	push   %ebx
801022df:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
801022e2:	a3 94 46 11 80       	mov    %eax,0x80114694
  ioapic->reg = reg;
801022e7:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
801022ed:	a1 94 46 11 80       	mov    0x80114694,%eax
801022f2:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801022f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801022fb:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102301:	0f b6 15 c0 47 11 80 	movzbl 0x801147c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102308:	c1 eb 10             	shr    $0x10,%ebx
8010230b:	0f b6 db             	movzbl %bl,%ebx
  return ioapic->data;
8010230e:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102311:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102314:	39 c2                	cmp    %eax,%edx
80102316:	74 12                	je     8010232a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102318:	c7 04 24 08 8c 10 80 	movl   $0x80108c08,(%esp)
8010231f:	e8 2c e3 ff ff       	call   80100650 <cprintf>
80102324:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
8010232a:	83 c3 21             	add    $0x21,%ebx
{
8010232d:	ba 10 00 00 00       	mov    $0x10,%edx
80102332:	b8 20 00 00 00       	mov    $0x20,%eax
80102337:	89 f6                	mov    %esi,%esi
80102339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102340:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102342:	89 c6                	mov    %eax,%esi
80102344:	40                   	inc    %eax
  ioapic->data = data;
80102345:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010234b:	81 ce 00 00 01 00    	or     $0x10000,%esi
  ioapic->data = data;
80102351:	89 71 10             	mov    %esi,0x10(%ecx)
80102354:	8d 72 01             	lea    0x1(%edx),%esi
80102357:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010235a:	89 31                	mov    %esi,(%ecx)
  for(i = 0; i <= maxintr; i++){
8010235c:	39 d8                	cmp    %ebx,%eax
  ioapic->data = data;
8010235e:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
80102364:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010236b:	75 d3                	jne    80102340 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	5b                   	pop    %ebx
80102371:	5e                   	pop    %esi
80102372:	5d                   	pop    %ebp
80102373:	c3                   	ret    
80102374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010237a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102380 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102380:	55                   	push   %ebp
  ioapic->reg = reg;
80102381:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
{
80102387:	89 e5                	mov    %esp,%ebp
80102389:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010238c:	8d 50 20             	lea    0x20(%eax),%edx
8010238f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102393:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102395:	40                   	inc    %eax
  ioapic->data = data;
80102396:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
8010239c:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010239f:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023a2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023a4:	a1 94 46 11 80       	mov    0x80114694,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023a9:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023ac:	89 50 10             	mov    %edx,0x10(%eax)
}
801023af:	5d                   	pop    %ebp
801023b0:	c3                   	ret    
801023b1:	66 90                	xchg   %ax,%ax
801023b3:	66 90                	xchg   %ax,%ax
801023b5:	66 90                	xchg   %ax,%ax
801023b7:	66 90                	xchg   %ax,%ax
801023b9:	66 90                	xchg   %ax,%ax
801023bb:	66 90                	xchg   %ax,%ax
801023bd:	66 90                	xchg   %ax,%ax
801023bf:	90                   	nop

801023c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	53                   	push   %ebx
801023c4:	83 ec 14             	sub    $0x14,%esp
801023c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023d0:	0f 85 80 00 00 00    	jne    80102456 <kfree+0x96>
801023d6:	81 fb 08 81 11 80    	cmp    $0x80118108,%ebx
801023dc:	72 78                	jb     80102456 <kfree+0x96>
801023de:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023e4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023e9:	77 6b                	ja     80102456 <kfree+0x96>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023eb:	ba 00 10 00 00       	mov    $0x1000,%edx
801023f0:	b9 01 00 00 00       	mov    $0x1,%ecx
801023f5:	89 54 24 08          	mov    %edx,0x8(%esp)
801023f9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801023fd:	89 1c 24             	mov    %ebx,(%esp)
80102400:	e8 bb 39 00 00       	call   80105dc0 <memset>

  if(kmem.use_lock)
80102405:	a1 d4 46 11 80       	mov    0x801146d4,%eax
8010240a:	85 c0                	test   %eax,%eax
8010240c:	75 3a                	jne    80102448 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010240e:	a1 d8 46 11 80       	mov    0x801146d8,%eax
80102413:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102415:	a1 d4 46 11 80       	mov    0x801146d4,%eax
  kmem.freelist = r;
8010241a:	89 1d d8 46 11 80    	mov    %ebx,0x801146d8
  if(kmem.use_lock)
80102420:	85 c0                	test   %eax,%eax
80102422:	75 0c                	jne    80102430 <kfree+0x70>
    release(&kmem.lock);
}
80102424:	83 c4 14             	add    $0x14,%esp
80102427:	5b                   	pop    %ebx
80102428:	5d                   	pop    %ebp
80102429:	c3                   	ret    
8010242a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102430:	c7 45 08 a0 46 11 80 	movl   $0x801146a0,0x8(%ebp)
}
80102437:	83 c4 14             	add    $0x14,%esp
8010243a:	5b                   	pop    %ebx
8010243b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010243c:	e9 2f 39 00 00       	jmp    80105d70 <release>
80102441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102448:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010244f:	e8 7c 38 00 00       	call   80105cd0 <acquire>
80102454:	eb b8                	jmp    8010240e <kfree+0x4e>
    panic("kfree");
80102456:	c7 04 24 3a 8c 10 80 	movl   $0x80108c3a,(%esp)
8010245d:	e8 0e df ff ff       	call   80100370 <panic>
80102462:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <freerange>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
80102475:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102478:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010247b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102484:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010248a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102490:	39 de                	cmp    %ebx,%esi
80102492:	72 24                	jb     801024b8 <freerange+0x48>
80102494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010249a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
801024a0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024ac:	89 04 24             	mov    %eax,(%esp)
801024af:	e8 0c ff ff ff       	call   801023c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b4:	39 f3                	cmp    %esi,%ebx
801024b6:	76 e8                	jbe    801024a0 <freerange+0x30>
}
801024b8:	83 c4 10             	add    $0x10,%esp
801024bb:	5b                   	pop    %ebx
801024bc:	5e                   	pop    %esi
801024bd:	5d                   	pop    %ebp
801024be:	c3                   	ret    
801024bf:	90                   	nop

801024c0 <kinit1>:
{
801024c0:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
801024c1:	b8 40 8c 10 80       	mov    $0x80108c40,%eax
{
801024c6:	89 e5                	mov    %esp,%ebp
801024c8:	56                   	push   %esi
801024c9:	53                   	push   %ebx
801024ca:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
801024cd:	89 44 24 04          	mov    %eax,0x4(%esp)
{
801024d1:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024d4:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801024db:	e8 a0 36 00 00       	call   80105b80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024e0:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
801024e3:	31 d2                	xor    %edx,%edx
801024e5:	89 15 d4 46 11 80    	mov    %edx,0x801146d4
  p = (char*)PGROUNDUP((uint)vstart);
801024eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024fd:	39 de                	cmp    %ebx,%esi
801024ff:	72 27                	jb     80102528 <kinit1+0x68>
80102501:	eb 0d                	jmp    80102510 <kinit1+0x50>
80102503:	90                   	nop
80102504:	90                   	nop
80102505:	90                   	nop
80102506:	90                   	nop
80102507:	90                   	nop
80102508:	90                   	nop
80102509:	90                   	nop
8010250a:	90                   	nop
8010250b:	90                   	nop
8010250c:	90                   	nop
8010250d:	90                   	nop
8010250e:	90                   	nop
8010250f:	90                   	nop
    kfree(p);
80102510:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102516:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010251c:	89 04 24             	mov    %eax,(%esp)
8010251f:	e8 9c fe ff ff       	call   801023c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102524:	39 de                	cmp    %ebx,%esi
80102526:	73 e8                	jae    80102510 <kinit1+0x50>
}
80102528:	83 c4 10             	add    $0x10,%esp
8010252b:	5b                   	pop    %ebx
8010252c:	5e                   	pop    %esi
8010252d:	5d                   	pop    %ebp
8010252e:	c3                   	ret    
8010252f:	90                   	nop

80102530 <kinit2>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
80102535:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102538:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010253b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010253e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102544:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010254a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102550:	39 de                	cmp    %ebx,%esi
80102552:	72 24                	jb     80102578 <kinit2+0x48>
80102554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010255a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
80102560:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102566:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010256c:	89 04 24             	mov    %eax,(%esp)
8010256f:	e8 4c fe ff ff       	call   801023c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102574:	39 de                	cmp    %ebx,%esi
80102576:	73 e8                	jae    80102560 <kinit2+0x30>
  kmem.use_lock = 1;
80102578:	b8 01 00 00 00       	mov    $0x1,%eax
8010257d:	a3 d4 46 11 80       	mov    %eax,0x801146d4
}
80102582:	83 c4 10             	add    $0x10,%esp
80102585:	5b                   	pop    %ebx
80102586:	5e                   	pop    %esi
80102587:	5d                   	pop    %ebp
80102588:	c3                   	ret    
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102590 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102590:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102595:	85 c0                	test   %eax,%eax
80102597:	75 1f                	jne    801025b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102599:	a1 d8 46 11 80       	mov    0x801146d8,%eax
  if(r)
8010259e:	85 c0                	test   %eax,%eax
801025a0:	74 0e                	je     801025b0 <kalloc+0x20>
    kmem.freelist = r->next;
801025a2:	8b 10                	mov    (%eax),%edx
801025a4:	89 15 d8 46 11 80    	mov    %edx,0x801146d8
801025aa:	c3                   	ret    
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025b0:	c3                   	ret    
801025b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801025b8:	55                   	push   %ebp
801025b9:	89 e5                	mov    %esp,%ebp
801025bb:	83 ec 28             	sub    $0x28,%esp
    acquire(&kmem.lock);
801025be:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801025c5:	e8 06 37 00 00       	call   80105cd0 <acquire>
  r = kmem.freelist;
801025ca:	a1 d8 46 11 80       	mov    0x801146d8,%eax
801025cf:	8b 15 d4 46 11 80    	mov    0x801146d4,%edx
  if(r)
801025d5:	85 c0                	test   %eax,%eax
801025d7:	74 08                	je     801025e1 <kalloc+0x51>
    kmem.freelist = r->next;
801025d9:	8b 08                	mov    (%eax),%ecx
801025db:	89 0d d8 46 11 80    	mov    %ecx,0x801146d8
  if(kmem.use_lock)
801025e1:	85 d2                	test   %edx,%edx
801025e3:	74 12                	je     801025f7 <kalloc+0x67>
    release(&kmem.lock);
801025e5:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801025ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025ef:	e8 7c 37 00 00       	call   80105d70 <release>
  return (char*)r;
801025f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801025f7:	c9                   	leave  
801025f8:	c3                   	ret    
801025f9:	66 90                	xchg   %ax,%ax
801025fb:	66 90                	xchg   %ax,%ax
801025fd:	66 90                	xchg   %ax,%ax
801025ff:	90                   	nop

80102600 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102600:	ba 64 00 00 00       	mov    $0x64,%edx
80102605:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102606:	24 01                	and    $0x1,%al
80102608:	84 c0                	test   %al,%al
8010260a:	0f 84 d0 00 00 00    	je     801026e0 <kbdgetc+0xe0>
{
80102610:	55                   	push   %ebp
80102611:	ba 60 00 00 00       	mov    $0x60,%edx
80102616:	89 e5                	mov    %esp,%ebp
80102618:	53                   	push   %ebx
80102619:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010261a:	0f b6 d0             	movzbl %al,%edx
8010261d:	8b 1d b4 c5 10 80    	mov    0x8010c5b4,%ebx

  if(data == 0xE0){
80102623:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102629:	0f 84 89 00 00 00    	je     801026b8 <kbdgetc+0xb8>
8010262f:	89 d9                	mov    %ebx,%ecx
80102631:	83 e1 40             	and    $0x40,%ecx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102634:	84 c0                	test   %al,%al
80102636:	78 58                	js     80102690 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102638:	85 c9                	test   %ecx,%ecx
8010263a:	74 08                	je     80102644 <kbdgetc+0x44>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010263c:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
8010263e:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102641:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102644:	0f b6 8a 80 8d 10 80 	movzbl -0x7fef7280(%edx),%ecx
  shift ^= togglecode[data];
8010264b:	0f b6 82 80 8c 10 80 	movzbl -0x7fef7380(%edx),%eax
  shift |= shiftcode[data];
80102652:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102654:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102656:	89 c8                	mov    %ecx,%eax
80102658:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010265b:	f6 c1 08             	test   $0x8,%cl
  c = charcode[shift & (CTL | SHIFT)][data];
8010265e:	8b 04 85 60 8c 10 80 	mov    -0x7fef73a0(,%eax,4),%eax
  shift ^= togglecode[data];
80102665:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010266b:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010266f:	74 40                	je     801026b1 <kbdgetc+0xb1>
    if('a' <= c && c <= 'z')
80102671:	8d 50 9f             	lea    -0x61(%eax),%edx
80102674:	83 fa 19             	cmp    $0x19,%edx
80102677:	76 57                	jbe    801026d0 <kbdgetc+0xd0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102679:	8d 50 bf             	lea    -0x41(%eax),%edx
8010267c:	83 fa 19             	cmp    $0x19,%edx
8010267f:	77 30                	ja     801026b1 <kbdgetc+0xb1>
      c += 'a' - 'A';
80102681:	83 c0 20             	add    $0x20,%eax
  }
  return c;
80102684:	eb 2b                	jmp    801026b1 <kbdgetc+0xb1>
80102686:	8d 76 00             	lea    0x0(%esi),%esi
80102689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    data = (shift & E0ESC ? data : data & 0x7F);
80102690:	85 c9                	test   %ecx,%ecx
80102692:	75 05                	jne    80102699 <kbdgetc+0x99>
80102694:	24 7f                	and    $0x7f,%al
80102696:	0f b6 d0             	movzbl %al,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102699:	0f b6 82 80 8d 10 80 	movzbl -0x7fef7280(%edx),%eax
801026a0:	0c 40                	or     $0x40,%al
801026a2:	0f b6 c8             	movzbl %al,%ecx
    return 0;
801026a5:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026a7:	f7 d1                	not    %ecx
801026a9:	21 d9                	and    %ebx,%ecx
801026ab:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
801026b1:	5b                   	pop    %ebx
801026b2:	5d                   	pop    %ebp
801026b3:	c3                   	ret    
801026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026b8:	83 cb 40             	or     $0x40,%ebx
    return 0;
801026bb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026bd:	89 1d b4 c5 10 80    	mov    %ebx,0x8010c5b4
}
801026c3:	5b                   	pop    %ebx
801026c4:	5d                   	pop    %ebp
801026c5:	c3                   	ret    
801026c6:	8d 76 00             	lea    0x0(%esi),%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801026d0:	5b                   	pop    %ebx
      c += 'A' - 'a';
801026d1:	83 e8 20             	sub    $0x20,%eax
}
801026d4:	5d                   	pop    %ebp
801026d5:	c3                   	ret    
801026d6:	8d 76 00             	lea    0x0(%esi),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <kbdintr>:

void
kbdintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801026f6:	c7 04 24 00 26 10 80 	movl   $0x80102600,(%esp)
801026fd:	e8 ce e0 ff ff       	call   801007d0 <consoleintr>
}
80102702:	c9                   	leave  
80102703:	c3                   	ret    
80102704:	66 90                	xchg   %ax,%ax
80102706:	66 90                	xchg   %ax,%ax
80102708:	66 90                	xchg   %ax,%ax
8010270a:	66 90                	xchg   %ax,%ax
8010270c:	66 90                	xchg   %ax,%ax
8010270e:	66 90                	xchg   %ax,%ax

80102710 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102710:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	0f 84 c6 00 00 00    	je     801027e6 <lapicinit+0xd6>
  lapic[index] = value;
80102720:	ba 3f 01 00 00       	mov    $0x13f,%edx
80102725:	b9 0b 00 00 00       	mov    $0xb,%ecx
8010272a:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102730:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102733:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
80102739:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010273e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102741:	ba 20 00 02 00       	mov    $0x20020,%edx
80102746:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010274c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010274f:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102755:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010275a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010275d:	ba 00 00 01 00       	mov    $0x10000,%edx
80102762:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102768:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010276b:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102771:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102774:	8b 50 30             	mov    0x30(%eax),%edx
80102777:	c1 ea 10             	shr    $0x10,%edx
8010277a:	80 fa 03             	cmp    $0x3,%dl
8010277d:	77 71                	ja     801027f0 <lapicinit+0xe0>
  lapic[index] = value;
8010277f:	b9 33 00 00 00       	mov    $0x33,%ecx
80102784:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
8010278a:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010278c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278f:	31 d2                	xor    %edx,%edx
80102791:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102797:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279a:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
801027a0:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
801027a2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027a5:	31 d2                	xor    %edx,%edx
801027a7:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027b0:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b6:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027b9:	ba 00 85 08 00       	mov    $0x88500,%edx
801027be:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c4:	8b 50 20             	mov    0x20(%eax),%edx
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027d6:	f6 c6 10             	test   $0x10,%dh
801027d9:	75 f5                	jne    801027d0 <lapicinit+0xc0>
  lapic[index] = value;
801027db:	31 d2                	xor    %edx,%edx
801027dd:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e3:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027e6:	5d                   	pop    %ebp
801027e7:	c3                   	ret    
801027e8:	90                   	nop
801027e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801027f0:	b9 00 00 01 00       	mov    $0x10000,%ecx
801027f5:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
801027fe:	e9 7c ff ff ff       	jmp    8010277f <lapicinit+0x6f>
80102803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102810:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102815:	55                   	push   %ebp
80102816:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102818:	85 c0                	test   %eax,%eax
8010281a:	74 0c                	je     80102828 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010281c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010281f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102820:	c1 e8 18             	shr    $0x18,%eax
}
80102823:	c3                   	ret    
80102824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102828:	31 c0                	xor    %eax,%eax
}
8010282a:	5d                   	pop    %ebp
8010282b:	c3                   	ret    
8010282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102830 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102830:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0b                	je     80102847 <lapiceoi+0x17>
  lapic[index] = value;
8010283c:	31 d2                	xor    %edx,%edx
8010283e:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102844:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102847:	5d                   	pop    %ebp
80102848:	c3                   	ret    
80102849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102850 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
}
80102853:	5d                   	pop    %ebp
80102854:	c3                   	ret    
80102855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102860 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102860:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102861:	b0 0f                	mov    $0xf,%al
80102863:	89 e5                	mov    %esp,%ebp
80102865:	ba 70 00 00 00       	mov    $0x70,%edx
8010286a:	53                   	push   %ebx
8010286b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
8010286f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102872:	ee                   	out    %al,(%dx)
80102873:	b0 0a                	mov    $0xa,%al
80102875:	ba 71 00 00 00       	mov    $0x71,%edx
8010287a:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010287b:	31 c0                	xor    %eax,%eax
8010287d:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102883:	89 d8                	mov    %ebx,%eax
80102885:	c1 e8 04             	shr    $0x4,%eax
80102888:	66 a3 69 04 00 80    	mov    %ax,0x80000469

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010288e:	c1 e1 18             	shl    $0x18,%ecx
  lapic[index] = value;
80102891:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102896:	c1 eb 0c             	shr    $0xc,%ebx
80102899:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
8010289f:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028a8:	ba 00 c5 00 00       	mov    $0xc500,%edx
801028ad:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028b6:	ba 00 85 00 00       	mov    $0x8500,%edx
801028bb:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c4:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028cd:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d6:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028dc:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028df:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
801028e5:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
801028e6:	8b 40 20             	mov    0x20(%eax),%eax
}
801028e9:	5d                   	pop    %ebp
801028ea:	c3                   	ret    
801028eb:	90                   	nop
801028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028f0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028f0:	55                   	push   %ebp
801028f1:	b0 0b                	mov    $0xb,%al
801028f3:	89 e5                	mov    %esp,%ebp
801028f5:	ba 70 00 00 00       	mov    $0x70,%edx
801028fa:	57                   	push   %edi
801028fb:	56                   	push   %esi
801028fc:	53                   	push   %ebx
801028fd:	83 ec 5c             	sub    $0x5c,%esp
80102900:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102901:	ba 71 00 00 00       	mov    $0x71,%edx
80102906:	ec                   	in     (%dx),%al
80102907:	24 04                	and    $0x4,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102909:	be 70 00 00 00       	mov    $0x70,%esi
8010290e:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102911:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010291a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80102920:	31 c0                	xor    %eax,%eax
80102922:	89 f2                	mov    %esi,%edx
80102924:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102925:	bb 71 00 00 00       	mov    $0x71,%ebx
8010292a:	89 da                	mov    %ebx,%edx
8010292c:	ec                   	in     (%dx),%al
8010292d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102930:	89 f2                	mov    %esi,%edx
80102932:	b0 02                	mov    $0x2,%al
80102934:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102935:	89 da                	mov    %ebx,%edx
80102937:	ec                   	in     (%dx),%al
80102938:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010293b:	89 f2                	mov    %esi,%edx
8010293d:	b0 04                	mov    $0x4,%al
8010293f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102940:	89 da                	mov    %ebx,%edx
80102942:	ec                   	in     (%dx),%al
80102943:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102946:	89 f2                	mov    %esi,%edx
80102948:	b0 07                	mov    $0x7,%al
8010294a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294b:	89 da                	mov    %ebx,%edx
8010294d:	ec                   	in     (%dx),%al
8010294e:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102951:	89 f2                	mov    %esi,%edx
80102953:	b0 08                	mov    $0x8,%al
80102955:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102956:	89 da                	mov    %ebx,%edx
80102958:	ec                   	in     (%dx),%al
80102959:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295c:	89 f2                	mov    %esi,%edx
8010295e:	b0 09                	mov    $0x9,%al
80102960:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102961:	89 da                	mov    %ebx,%edx
80102963:	ec                   	in     (%dx),%al
80102964:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102967:	89 f2                	mov    %esi,%edx
80102969:	b0 0a                	mov    $0xa,%al
8010296b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296c:	89 da                	mov    %ebx,%edx
8010296e:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010296f:	84 c0                	test   %al,%al
80102971:	78 ad                	js     80102920 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102973:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102977:	89 f2                	mov    %esi,%edx
80102979:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010297c:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010297f:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102983:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102986:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010298a:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010298d:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102991:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102994:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
80102998:	89 45 c8             	mov    %eax,-0x38(%ebp)
8010299b:	31 c0                	xor    %eax,%eax
8010299d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299e:	89 da                	mov    %ebx,%edx
801029a0:	ec                   	in     (%dx),%al
801029a1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a4:	89 f2                	mov    %esi,%edx
801029a6:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029a9:	b0 02                	mov    $0x2,%al
801029ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ac:	89 da                	mov    %ebx,%edx
801029ae:	ec                   	in     (%dx),%al
801029af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b2:	89 f2                	mov    %esi,%edx
801029b4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029b7:	b0 04                	mov    $0x4,%al
801029b9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ba:	89 da                	mov    %ebx,%edx
801029bc:	ec                   	in     (%dx),%al
801029bd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c0:	89 f2                	mov    %esi,%edx
801029c2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029c5:	b0 07                	mov    $0x7,%al
801029c7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c8:	89 da                	mov    %ebx,%edx
801029ca:	ec                   	in     (%dx),%al
801029cb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ce:	89 f2                	mov    %esi,%edx
801029d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029d3:	b0 08                	mov    $0x8,%al
801029d5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d6:	89 da                	mov    %ebx,%edx
801029d8:	ec                   	in     (%dx),%al
801029d9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029dc:	89 f2                	mov    %esi,%edx
801029de:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029e1:	b0 09                	mov    $0x9,%al
801029e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	89 da                	mov    %ebx,%edx
801029e6:	ec                   	in     (%dx),%al
801029e7:	0f b6 c0             	movzbl %al,%eax
801029ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029ed:	b8 18 00 00 00       	mov    $0x18,%eax
801029f2:	89 44 24 08          	mov    %eax,0x8(%esp)
801029f6:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801029fd:	89 04 24             	mov    %eax,(%esp)
80102a00:	e8 1b 34 00 00       	call   80105e20 <memcmp>
80102a05:	85 c0                	test   %eax,%eax
80102a07:	0f 85 13 ff ff ff    	jne    80102920 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102a0d:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102a11:	75 78                	jne    80102a8b <cmostime+0x19b>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a13:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a16:	89 c2                	mov    %eax,%edx
80102a18:	83 e0 0f             	and    $0xf,%eax
80102a1b:	c1 ea 04             	shr    $0x4,%edx
80102a1e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a21:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a24:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a27:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a2a:	89 c2                	mov    %eax,%edx
80102a2c:	83 e0 0f             	and    $0xf,%eax
80102a2f:	c1 ea 04             	shr    $0x4,%edx
80102a32:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a35:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a38:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a3b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a3e:	89 c2                	mov    %eax,%edx
80102a40:	83 e0 0f             	and    $0xf,%eax
80102a43:	c1 ea 04             	shr    $0x4,%edx
80102a46:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a49:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4c:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a52:	89 c2                	mov    %eax,%edx
80102a54:	83 e0 0f             	and    $0xf,%eax
80102a57:	c1 ea 04             	shr    $0x4,%edx
80102a5a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a5d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a60:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a63:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a66:	89 c2                	mov    %eax,%edx
80102a68:	83 e0 0f             	and    $0xf,%eax
80102a6b:	c1 ea 04             	shr    $0x4,%edx
80102a6e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a71:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a74:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a77:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a7a:	89 c2                	mov    %eax,%edx
80102a7c:	83 e0 0f             	and    $0xf,%eax
80102a7f:	c1 ea 04             	shr    $0x4,%edx
80102a82:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a85:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a88:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a8b:	31 c0                	xor    %eax,%eax
80102a8d:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102a91:	8b 7d 08             	mov    0x8(%ebp),%edi
80102a94:	89 14 07             	mov    %edx,(%edi,%eax,1)
80102a97:	83 c0 04             	add    $0x4,%eax
80102a9a:	83 f8 18             	cmp    $0x18,%eax
80102a9d:	72 ee                	jb     80102a8d <cmostime+0x19d>
  r->year += 2000;
80102a9f:	81 47 14 d0 07 00 00 	addl   $0x7d0,0x14(%edi)
}
80102aa6:	83 c4 5c             	add    $0x5c,%esp
80102aa9:	5b                   	pop    %ebx
80102aaa:	5e                   	pop    %esi
80102aab:	5f                   	pop    %edi
80102aac:	5d                   	pop    %ebp
80102aad:	c3                   	ret    
80102aae:	66 90                	xchg   %ax,%ax

80102ab0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ab0:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102ab6:	85 d2                	test   %edx,%edx
80102ab8:	0f 8e 92 00 00 00    	jle    80102b50 <install_trans+0xa0>
{
80102abe:	55                   	push   %ebp
80102abf:	89 e5                	mov    %esp,%ebp
80102ac1:	57                   	push   %edi
80102ac2:	56                   	push   %esi
80102ac3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ac4:	31 db                	xor    %ebx,%ebx
{
80102ac6:	83 ec 1c             	sub    $0x1c,%esp
80102ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ad0:	a1 14 47 11 80       	mov    0x80114714,%eax
80102ad5:	01 d8                	add    %ebx,%eax
80102ad7:	40                   	inc    %eax
80102ad8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102adc:	a1 24 47 11 80       	mov    0x80114724,%eax
80102ae1:	89 04 24             	mov    %eax,(%esp)
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
80102ae9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102aeb:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102af2:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102af3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102af7:	a1 24 47 11 80       	mov    0x80114724,%eax
80102afc:	89 04 24             	mov    %eax,(%esp)
80102aff:	e8 cc d5 ff ff       	call   801000d0 <bread>
80102b04:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b06:	b8 00 02 00 00       	mov    $0x200,%eax
80102b0b:	89 44 24 08          	mov    %eax,0x8(%esp)
80102b0f:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b12:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b16:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b19:	89 04 24             	mov    %eax,(%esp)
80102b1c:	e8 5f 33 00 00       	call   80105e80 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b21:	89 34 24             	mov    %esi,(%esp)
80102b24:	e8 77 d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b29:	89 3c 24             	mov    %edi,(%esp)
80102b2c:	e8 af d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b31:	89 34 24             	mov    %esi,(%esp)
80102b34:	e8 a7 d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b39:	39 1d 28 47 11 80    	cmp    %ebx,0x80114728
80102b3f:	7f 8f                	jg     80102ad0 <install_trans+0x20>
  }
}
80102b41:	83 c4 1c             	add    $0x1c,%esp
80102b44:	5b                   	pop    %ebx
80102b45:	5e                   	pop    %esi
80102b46:	5f                   	pop    %edi
80102b47:	5d                   	pop    %ebp
80102b48:	c3                   	ret    
80102b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b50:	c3                   	ret    
80102b51:	eb 0d                	jmp    80102b60 <write_head>
80102b53:	90                   	nop
80102b54:	90                   	nop
80102b55:	90                   	nop
80102b56:	90                   	nop
80102b57:	90                   	nop
80102b58:	90                   	nop
80102b59:	90                   	nop
80102b5a:	90                   	nop
80102b5b:	90                   	nop
80102b5c:	90                   	nop
80102b5d:	90                   	nop
80102b5e:	90                   	nop
80102b5f:	90                   	nop

80102b60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	56                   	push   %esi
80102b64:	53                   	push   %ebx
80102b65:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b68:	a1 14 47 11 80       	mov    0x80114714,%eax
80102b6d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b71:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b76:	89 04 24             	mov    %eax,(%esp)
80102b79:	e8 52 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b7e:	8b 1d 28 47 11 80    	mov    0x80114728,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b84:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102b86:	89 c6                	mov    %eax,%esi
  hb->n = log.lh.n;
80102b88:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b8b:	7e 24                	jle    80102bb1 <write_head+0x51>
80102b8d:	c1 e3 02             	shl    $0x2,%ebx
80102b90:	31 d2                	xor    %edx,%edx
80102b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    hb->block[i] = log.lh.block[i];
80102ba0:	8b 8a 2c 47 11 80    	mov    -0x7feeb8d4(%edx),%ecx
80102ba6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102baa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bad:	39 da                	cmp    %ebx,%edx
80102baf:	75 ef                	jne    80102ba0 <write_head+0x40>
  }
  bwrite(buf);
80102bb1:	89 34 24             	mov    %esi,(%esp)
80102bb4:	e8 e7 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bb9:	89 34 24             	mov    %esi,(%esp)
80102bbc:	e8 1f d6 ff ff       	call   801001e0 <brelse>
}
80102bc1:	83 c4 10             	add    $0x10,%esp
80102bc4:	5b                   	pop    %ebx
80102bc5:	5e                   	pop    %esi
80102bc6:	5d                   	pop    %ebp
80102bc7:	c3                   	ret    
80102bc8:	90                   	nop
80102bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bd0 <initlog>:
{
80102bd0:	55                   	push   %ebp
  initlock(&log.lock, "log");
80102bd1:	ba 80 8e 10 80       	mov    $0x80108e80,%edx
{
80102bd6:	89 e5                	mov    %esp,%ebp
80102bd8:	53                   	push   %ebx
80102bd9:	83 ec 34             	sub    $0x34,%esp
80102bdc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bdf:	89 54 24 04          	mov    %edx,0x4(%esp)
80102be3:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102bea:	e8 91 2f 00 00       	call   80105b80 <initlock>
  readsb(dev, &sb);
80102bef:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bf2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bf6:	89 1c 24             	mov    %ebx,(%esp)
80102bf9:	e8 b2 e7 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
80102bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102c01:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102c04:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102c07:	89 1d 24 47 11 80    	mov    %ebx,0x80114724
  struct buf *buf = bread(log.dev, log.start);
80102c0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c11:	a3 14 47 11 80       	mov    %eax,0x80114714
  log.size = sb.nlog;
80102c16:	89 15 18 47 11 80    	mov    %edx,0x80114718
  struct buf *buf = bread(log.dev, log.start);
80102c1c:	e8 af d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c21:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c24:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c26:	89 1d 28 47 11 80    	mov    %ebx,0x80114728
  for (i = 0; i < log.lh.n; i++) {
80102c2c:	7e 23                	jle    80102c51 <initlog+0x81>
80102c2e:	c1 e3 02             	shl    $0x2,%ebx
80102c31:	31 d2                	xor    %edx,%edx
80102c33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c44:	83 c2 04             	add    $0x4,%edx
80102c47:	89 8a 28 47 11 80    	mov    %ecx,-0x7feeb8d8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 d3                	cmp    %edx,%ebx
80102c4f:	75 ef                	jne    80102c40 <initlog+0x70>
  brelse(buf);
80102c51:	89 04 24             	mov    %eax,(%esp)
80102c54:	e8 87 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c59:	e8 52 fe ff ff       	call   80102ab0 <install_trans>
  log.lh.n = 0;
80102c5e:	31 c0                	xor    %eax,%eax
80102c60:	a3 28 47 11 80       	mov    %eax,0x80114728
  write_head(); // clear the log
80102c65:	e8 f6 fe ff ff       	call   80102b60 <write_head>
}
80102c6a:	83 c4 34             	add    $0x34,%esp
80102c6d:	5b                   	pop    %ebx
80102c6e:	5d                   	pop    %ebp
80102c6f:	c3                   	ret    

80102c70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c76:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c7d:	e8 4e 30 00 00       	call   80105cd0 <acquire>
80102c82:	eb 19                	jmp    80102c9d <begin_op+0x2d>
80102c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102c8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c91:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c98:	e8 83 1a 00 00       	call   80104720 <sleep>
    if(log.committing){
80102c9d:	8b 15 20 47 11 80    	mov    0x80114720,%edx
80102ca3:	85 d2                	test   %edx,%edx
80102ca5:	75 e1                	jne    80102c88 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca7:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102cac:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102cb2:	40                   	inc    %eax
80102cb3:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cb6:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cb9:	83 fa 1e             	cmp    $0x1e,%edx
80102cbc:	7f ca                	jg     80102c88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cbe:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
      log.outstanding += 1;
80102cc5:	a3 1c 47 11 80       	mov    %eax,0x8011471c
      release(&log.lock);
80102cca:	e8 a1 30 00 00       	call   80105d70 <release>
      break;
    }
  }
}
80102ccf:	c9                   	leave  
80102cd0:	c3                   	ret    
80102cd1:	eb 0d                	jmp    80102ce0 <end_op>
80102cd3:	90                   	nop
80102cd4:	90                   	nop
80102cd5:	90                   	nop
80102cd6:	90                   	nop
80102cd7:	90                   	nop
80102cd8:	90                   	nop
80102cd9:	90                   	nop
80102cda:	90                   	nop
80102cdb:	90                   	nop
80102cdc:	90                   	nop
80102cdd:	90                   	nop
80102cde:	90                   	nop
80102cdf:	90                   	nop

80102ce0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	57                   	push   %edi
80102ce4:	56                   	push   %esi
80102ce5:	53                   	push   %ebx
80102ce6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ce9:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102cf0:	e8 db 2f 00 00       	call   80105cd0 <acquire>
  log.outstanding -= 1;
80102cf5:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102cfa:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102cfd:	a1 20 47 11 80       	mov    0x80114720,%eax
  log.outstanding -= 1;
80102d02:	89 1d 1c 47 11 80    	mov    %ebx,0x8011471c
  if(log.committing)
80102d08:	85 c0                	test   %eax,%eax
80102d0a:	0f 85 e8 00 00 00    	jne    80102df8 <end_op+0x118>
    panic("log.committing");
  if(log.outstanding == 0){
80102d10:	85 db                	test   %ebx,%ebx
80102d12:	0f 85 c0 00 00 00    	jne    80102dd8 <end_op+0xf8>
    do_commit = 1;
    log.committing = 1;
80102d18:	be 01 00 00 00       	mov    $0x1,%esi
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d1d:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
    log.committing = 1;
80102d24:	89 35 20 47 11 80    	mov    %esi,0x80114720
  release(&log.lock);
80102d2a:	e8 41 30 00 00       	call   80105d70 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d2f:	8b 3d 28 47 11 80    	mov    0x80114728,%edi
80102d35:	85 ff                	test   %edi,%edi
80102d37:	0f 8e 88 00 00 00    	jle    80102dc5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d3d:	a1 14 47 11 80       	mov    0x80114714,%eax
80102d42:	01 d8                	add    %ebx,%eax
80102d44:	40                   	inc    %eax
80102d45:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d49:	a1 24 47 11 80       	mov    0x80114724,%eax
80102d4e:	89 04 24             	mov    %eax,(%esp)
80102d51:	e8 7a d3 ff ff       	call   801000d0 <bread>
80102d56:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d58:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d5f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d60:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d64:	a1 24 47 11 80       	mov    0x80114724,%eax
80102d69:	89 04 24             	mov    %eax,(%esp)
80102d6c:	e8 5f d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d71:	b9 00 02 00 00       	mov    $0x200,%ecx
80102d76:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d7a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d7c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d83:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d86:	89 04 24             	mov    %eax,(%esp)
80102d89:	e8 f2 30 00 00       	call   80105e80 <memmove>
    bwrite(to);  // write the log
80102d8e:	89 34 24             	mov    %esi,(%esp)
80102d91:	e8 0a d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d96:	89 3c 24             	mov    %edi,(%esp)
80102d99:	e8 42 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d9e:	89 34 24             	mov    %esi,(%esp)
80102da1:	e8 3a d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102da6:	3b 1d 28 47 11 80    	cmp    0x80114728,%ebx
80102dac:	7c 8f                	jl     80102d3d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dae:	e8 ad fd ff ff       	call   80102b60 <write_head>
    install_trans(); // Now install writes to home locations
80102db3:	e8 f8 fc ff ff       	call   80102ab0 <install_trans>
    log.lh.n = 0;
80102db8:	31 d2                	xor    %edx,%edx
80102dba:	89 15 28 47 11 80    	mov    %edx,0x80114728
    write_head();    // Erase the transaction from the log
80102dc0:	e8 9b fd ff ff       	call   80102b60 <write_head>
    acquire(&log.lock);
80102dc5:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dcc:	e8 ff 2e 00 00       	call   80105cd0 <acquire>
    log.committing = 0;
80102dd1:	31 c0                	xor    %eax,%eax
80102dd3:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102dd8:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102ddf:	e8 1c 1d 00 00       	call   80104b00 <wakeup>
    release(&log.lock);
80102de4:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102deb:	e8 80 2f 00 00       	call   80105d70 <release>
}
80102df0:	83 c4 1c             	add    $0x1c,%esp
80102df3:	5b                   	pop    %ebx
80102df4:	5e                   	pop    %esi
80102df5:	5f                   	pop    %edi
80102df6:	5d                   	pop    %ebp
80102df7:	c3                   	ret    
    panic("log.committing");
80102df8:	c7 04 24 84 8e 10 80 	movl   $0x80108e84,(%esp)
80102dff:	e8 6c d5 ff ff       	call   80100370 <panic>
80102e04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e17:	8b 15 28 47 11 80    	mov    0x80114728,%edx
{
80102e1d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e20:	83 fa 1d             	cmp    $0x1d,%edx
80102e23:	0f 8f 95 00 00 00    	jg     80102ebe <log_write+0xae>
80102e29:	a1 18 47 11 80       	mov    0x80114718,%eax
80102e2e:	48                   	dec    %eax
80102e2f:	39 c2                	cmp    %eax,%edx
80102e31:	0f 8d 87 00 00 00    	jge    80102ebe <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e37:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e3c:	85 c0                	test   %eax,%eax
80102e3e:	0f 8e 86 00 00 00    	jle    80102eca <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e44:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e4b:	e8 80 2e 00 00       	call   80105cd0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e50:	8b 0d 28 47 11 80    	mov    0x80114728,%ecx
80102e56:	83 f9 00             	cmp    $0x0,%ecx
80102e59:	7e 55                	jle    80102eb0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e5b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e5e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e60:	3b 15 2c 47 11 80    	cmp    0x8011472c,%edx
80102e66:	75 11                	jne    80102e79 <log_write+0x69>
80102e68:	eb 36                	jmp    80102ea0 <log_write+0x90>
80102e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e70:	39 14 85 2c 47 11 80 	cmp    %edx,-0x7feeb8d4(,%eax,4)
80102e77:	74 27                	je     80102ea0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e79:	40                   	inc    %eax
80102e7a:	39 c1                	cmp    %eax,%ecx
80102e7c:	75 f2                	jne    80102e70 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e7e:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e85:	40                   	inc    %eax
80102e86:	a3 28 47 11 80       	mov    %eax,0x80114728
  b->flags |= B_DIRTY; // prevent eviction
80102e8b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e8e:	c7 45 08 e0 46 11 80 	movl   $0x801146e0,0x8(%ebp)
}
80102e95:	83 c4 14             	add    $0x14,%esp
80102e98:	5b                   	pop    %ebx
80102e99:	5d                   	pop    %ebp
  release(&log.lock);
80102e9a:	e9 d1 2e 00 00       	jmp    80105d70 <release>
80102e9f:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ea0:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
80102ea7:	eb e2                	jmp    80102e8b <log_write+0x7b>
80102ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eb0:	8b 43 08             	mov    0x8(%ebx),%eax
80102eb3:	a3 2c 47 11 80       	mov    %eax,0x8011472c
  if (i == log.lh.n)
80102eb8:	75 d1                	jne    80102e8b <log_write+0x7b>
80102eba:	31 c0                	xor    %eax,%eax
80102ebc:	eb c7                	jmp    80102e85 <log_write+0x75>
    panic("too big a transaction");
80102ebe:	c7 04 24 93 8e 10 80 	movl   $0x80108e93,(%esp)
80102ec5:	e8 a6 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eca:	c7 04 24 a9 8e 10 80 	movl   $0x80108ea9,(%esp)
80102ed1:	e8 9a d4 ff ff       	call   80100370 <panic>
80102ed6:	66 90                	xchg   %ax,%ax
80102ed8:	66 90                	xchg   %ax,%ax
80102eda:	66 90                	xchg   %ax,%ax
80102edc:	66 90                	xchg   %ax,%ax
80102ede:	66 90                	xchg   %ax,%ax

80102ee0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 14             	sub    $0x14,%esp
  switchkvm();
80102ee7:	e8 e4 53 00 00       	call   801082d0 <switchkvm>
  seginit();
80102eec:	e8 4f 53 00 00       	call   80108240 <seginit>
  lapicinit();
80102ef1:	e8 1a f8 ff ff       	call   80102710 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102ef6:	e8 c5 09 00 00       	call   801038c0 <mycpu>
80102efb:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102efd:	e8 3e 0a 00 00       	call   80103940 <cpuid>
80102f02:	c7 04 24 c4 8e 10 80 	movl   $0x80108ec4,(%esp)
80102f09:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f0d:	e8 3e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f12:	e8 69 42 00 00       	call   80107180 <idtinit>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f17:	b8 01 00 00 00       	mov    $0x1,%eax
80102f1c:	f0 87 83 a0 00 00 00 	lock xchg %eax,0xa0(%ebx)
80102f23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  xchg(&(c->started), 1); // tell startothers() we're up
  while(c->started != 0); // wait for the "pioneer" cpu to finish the scheduling data structures initialization
80102f30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f36:	85 c0                	test   %eax,%eax
80102f38:	75 f6                	jne    80102f30 <mpenter+0x50>
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f3a:	e8 01 0a 00 00       	call   80103940 <cpuid>
80102f3f:	89 c3                	mov    %eax,%ebx
80102f41:	e8 fa 09 00 00       	call   80103940 <cpuid>
80102f46:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f4a:	c7 04 24 14 8f 10 80 	movl   $0x80108f14,(%esp)
80102f51:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f55:	e8 f6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f5a:	e8 b1 13 00 00       	call   80104310 <scheduler>
80102f5f:	90                   	nop

80102f60 <main>:
{
80102f60:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f61:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
80102f66:	89 e5                	mov    %esp,%ebp
80102f68:	53                   	push   %ebx
80102f69:	83 e4 f0             	and    $0xfffffff0,%esp
80102f6c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f73:	c7 04 24 08 81 11 80 	movl   $0x80118108,(%esp)
80102f7a:	e8 41 f5 ff ff       	call   801024c0 <kinit1>
  kvmalloc();      // kernel page table
80102f7f:	e8 1c 58 00 00       	call   801087a0 <kvmalloc>
  mpinit();        // detect other processors
80102f84:	e8 17 02 00 00       	call   801031a0 <mpinit>
  lapicinit();     // interrupt controller
80102f89:	e8 82 f7 ff ff       	call   80102710 <lapicinit>
80102f8e:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102f90:	e8 ab 52 00 00       	call   80108240 <seginit>
  picinit();       // disable pic
80102f95:	e8 e6 03 00 00       	call   80103380 <picinit>
  ioapicinit();    // another interrupt controller
80102f9a:	e8 31 f3 ff ff       	call   801022d0 <ioapicinit>
80102f9f:	90                   	nop
  consoleinit();   // console hardware
80102fa0:	e8 db d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fa5:	e8 66 45 00 00       	call   80107510 <uartinit>
  pinit();         // process table
80102faa:	e8 f1 08 00 00       	call   801038a0 <pinit>
80102faf:	90                   	nop
  tvinit();        // trap vectors
80102fb0:	e8 4b 41 00 00       	call   80107100 <tvinit>
  binit();         // buffer cache
80102fb5:	e8 86 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fba:	e8 71 dd ff ff       	call   80100d30 <fileinit>
80102fbf:	90                   	nop
  ideinit();       // disk 
80102fc0:	e8 fb f0 ff ff       	call   801020c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fc5:	b8 8a 00 00 00       	mov    $0x8a,%eax
80102fca:	89 44 24 08          	mov    %eax,0x8(%esp)
80102fce:	b8 8c c4 10 80       	mov    $0x8010c48c,%eax
80102fd3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fd7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102fde:	e8 9d 2e 00 00       	call   80105e80 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fe3:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80102fe8:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102feb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fee:	c1 e0 04             	shl    $0x4,%eax
80102ff1:	05 e0 47 11 80       	add    $0x801147e0,%eax
80102ff6:	3d e0 47 11 80       	cmp    $0x801147e0,%eax
80102ffb:	0f 86 86 00 00 00    	jbe    80103087 <main+0x127>
80103001:	bb e0 47 11 80       	mov    $0x801147e0,%ebx
80103006:	8d 76 00             	lea    0x0(%esi),%esi
80103009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103010:	e8 ab 08 00 00       	call   801038c0 <mycpu>
80103015:	39 d8                	cmp    %ebx,%eax
80103017:	74 51                	je     8010306a <main+0x10a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103019:	e8 72 f5 ff ff       	call   80102590 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
8010301e:	ba e0 2e 10 80       	mov    $0x80102ee0,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103023:	b9 00 b0 10 00       	mov    $0x10b000,%ecx
    *(void(**)(void))(code-8) = mpenter;
80103028:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010302e:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
80103034:	05 00 10 00 00       	add    $0x1000,%eax
80103039:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010303e:	b8 00 70 00 00       	mov    $0x7000,%eax
80103043:	89 44 24 04          	mov    %eax,0x4(%esp)
80103047:	0f b6 03             	movzbl (%ebx),%eax
8010304a:	89 04 24             	mov    %eax,(%esp)
8010304d:	e8 0e f8 ff ff       	call   80102860 <lapicstartap>
80103052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103060:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103066:	85 c0                	test   %eax,%eax
80103068:	74 f6                	je     80103060 <main+0x100>
  for(c = cpus; c < cpus+ncpu; c++){
8010306a:	a1 60 4d 11 80       	mov    0x80114d60,%eax
8010306f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103075:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103078:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010307b:	c1 e0 04             	shl    $0x4,%eax
8010307e:	05 e0 47 11 80       	add    $0x801147e0,%eax
80103083:	39 c3                	cmp    %eax,%ebx
80103085:	72 89                	jb     80103010 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103087:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
8010308c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103090:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103097:	e8 94 f4 ff ff       	call   80102530 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
8010309c:	e8 4f 1f 00 00       	call   80104ff0 <initSchedDS>
	__sync_synchronize();
801030a1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030a6:	a1 60 4d 11 80       	mov    0x80114d60,%eax
801030ab:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ae:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030b1:	c1 e1 04             	shl    $0x4,%ecx
801030b4:	81 c1 e0 47 11 80    	add    $0x801147e0,%ecx
801030ba:	81 f9 e0 47 11 80    	cmp    $0x801147e0,%ecx
801030c0:	76 21                	jbe    801030e3 <main+0x183>
801030c2:	ba e0 47 11 80       	mov    $0x801147e0,%edx
801030c7:	31 db                	xor    %ebx,%ebx
801030c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030d0:	89 d8                	mov    %ebx,%eax
801030d2:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801030d9:	81 c2 b0 00 00 00    	add    $0xb0,%edx
801030df:	39 ca                	cmp    %ecx,%edx
801030e1:	72 ed                	jb     801030d0 <main+0x170>
  userinit();      // first user process
801030e3:	e8 d8 0a 00 00       	call   80103bc0 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
801030e8:	e8 53 08 00 00       	call   80103940 <cpuid>
801030ed:	89 c3                	mov    %eax,%ebx
801030ef:	e8 4c 08 00 00       	call   80103940 <cpuid>
801030f4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801030f8:	c7 04 24 0a 8f 10 80 	movl   $0x80108f0a,(%esp)
801030ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103103:	e8 48 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103108:	e8 73 40 00 00       	call   80107180 <idtinit>
  scheduler();     // start running processes
8010310d:	e8 fe 11 00 00       	call   80104310 <scheduler>
80103112:	66 90                	xchg   %ax,%ax
80103114:	66 90                	xchg   %ax,%ax
80103116:	66 90                	xchg   %ax,%ax
80103118:	66 90                	xchg   %ax,%ax
8010311a:	66 90                	xchg   %ax,%ax
8010311c:	66 90                	xchg   %ax,%ax
8010311e:	66 90                	xchg   %ax,%ax

80103120 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103125:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010312b:	53                   	push   %ebx
  e = addr+len;
8010312c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010312f:	83 ec 1c             	sub    $0x1c,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103132:	39 de                	cmp    %ebx,%esi
80103134:	72 10                	jb     80103146 <mpsearch1+0x26>
80103136:	eb 58                	jmp    80103190 <mpsearch1+0x70>
80103138:	90                   	nop
80103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103140:	39 d3                	cmp    %edx,%ebx
80103142:	89 d6                	mov    %edx,%esi
80103144:	76 4a                	jbe    80103190 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103146:	ba 28 8f 10 80       	mov    $0x80108f28,%edx
8010314b:	b8 04 00 00 00       	mov    $0x4,%eax
80103150:	89 54 24 04          	mov    %edx,0x4(%esp)
80103154:	89 44 24 08          	mov    %eax,0x8(%esp)
80103158:	89 34 24             	mov    %esi,(%esp)
8010315b:	e8 c0 2c 00 00       	call   80105e20 <memcmp>
80103160:	8d 56 10             	lea    0x10(%esi),%edx
80103163:	85 c0                	test   %eax,%eax
80103165:	75 d9                	jne    80103140 <mpsearch1+0x20>
80103167:	89 f1                	mov    %esi,%ecx
80103169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103170:	0f b6 39             	movzbl (%ecx),%edi
80103173:	41                   	inc    %ecx
80103174:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
80103176:	39 d1                	cmp    %edx,%ecx
80103178:	75 f6                	jne    80103170 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010317a:	84 c0                	test   %al,%al
8010317c:	75 c2                	jne    80103140 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
8010317e:	83 c4 1c             	add    $0x1c,%esp
80103181:	89 f0                	mov    %esi,%eax
80103183:	5b                   	pop    %ebx
80103184:	5e                   	pop    %esi
80103185:	5f                   	pop    %edi
80103186:	5d                   	pop    %ebp
80103187:	c3                   	ret    
80103188:	90                   	nop
80103189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103190:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80103193:	31 f6                	xor    %esi,%esi
}
80103195:	5b                   	pop    %ebx
80103196:	89 f0                	mov    %esi,%eax
80103198:	5e                   	pop    %esi
80103199:	5f                   	pop    %edi
8010319a:	5d                   	pop    %ebp
8010319b:	c3                   	ret    
8010319c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
801031a5:	53                   	push   %ebx
801031a6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031b7:	c1 e0 08             	shl    $0x8,%eax
801031ba:	09 d0                	or     %edx,%eax
801031bc:	c1 e0 04             	shl    $0x4,%eax
801031bf:	75 1b                	jne    801031dc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031c1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031c8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031cf:	c1 e0 08             	shl    $0x8,%eax
801031d2:	09 d0                	or     %edx,%eax
801031d4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031d7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031dc:	ba 00 04 00 00       	mov    $0x400,%edx
801031e1:	e8 3a ff ff ff       	call   80103120 <mpsearch1>
801031e6:	85 c0                	test   %eax,%eax
801031e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031eb:	0f 84 4f 01 00 00    	je     80103340 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801031f4:	8b 58 04             	mov    0x4(%eax),%ebx
801031f7:	85 db                	test   %ebx,%ebx
801031f9:	0f 84 61 01 00 00    	je     80103360 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
801031ff:	b8 04 00 00 00       	mov    $0x4,%eax
80103204:	ba 45 8f 10 80       	mov    $0x80108f45,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103209:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010320f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103213:	89 54 24 04          	mov    %edx,0x4(%esp)
80103217:	89 34 24             	mov    %esi,(%esp)
8010321a:	e8 01 2c 00 00       	call   80105e20 <memcmp>
8010321f:	85 c0                	test   %eax,%eax
80103221:	0f 85 39 01 00 00    	jne    80103360 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103227:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010322e:	3c 01                	cmp    $0x1,%al
80103230:	0f 95 c2             	setne  %dl
80103233:	3c 04                	cmp    $0x4,%al
80103235:	0f 95 c0             	setne  %al
80103238:	20 d0                	and    %dl,%al
8010323a:	0f 85 20 01 00 00    	jne    80103360 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103240:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103247:	85 ff                	test   %edi,%edi
80103249:	74 24                	je     8010326f <mpinit+0xcf>
8010324b:	89 f0                	mov    %esi,%eax
8010324d:	01 f7                	add    %esi,%edi
  sum = 0;
8010324f:	31 d2                	xor    %edx,%edx
80103251:	eb 0d                	jmp    80103260 <mpinit+0xc0>
80103253:	90                   	nop
80103254:	90                   	nop
80103255:	90                   	nop
80103256:	90                   	nop
80103257:	90                   	nop
80103258:	90                   	nop
80103259:	90                   	nop
8010325a:	90                   	nop
8010325b:	90                   	nop
8010325c:	90                   	nop
8010325d:	90                   	nop
8010325e:	90                   	nop
8010325f:	90                   	nop
    sum += addr[i];
80103260:	0f b6 08             	movzbl (%eax),%ecx
80103263:	40                   	inc    %eax
80103264:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103266:	39 c7                	cmp    %eax,%edi
80103268:	75 f6                	jne    80103260 <mpinit+0xc0>
8010326a:	84 d2                	test   %dl,%dl
8010326c:	0f 95 c0             	setne  %al
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010326f:	85 f6                	test   %esi,%esi
80103271:	0f 84 e9 00 00 00    	je     80103360 <mpinit+0x1c0>
80103277:	84 c0                	test   %al,%al
80103279:	0f 85 e1 00 00 00    	jne    80103360 <mpinit+0x1c0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010327f:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103285:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
  ismp = 1;
8010328b:	b9 01 00 00 00       	mov    $0x1,%ecx
  lapic = (uint*)conf->lapicaddr;
80103290:	a3 dc 46 11 80       	mov    %eax,0x801146dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103295:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
8010329c:	01 c6                	add    %eax,%esi
8010329e:	66 90                	xchg   %ax,%ax
801032a0:	39 d6                	cmp    %edx,%esi
801032a2:	76 23                	jbe    801032c7 <mpinit+0x127>
    switch(*p){
801032a4:	0f b6 02             	movzbl (%edx),%eax
801032a7:	3c 04                	cmp    $0x4,%al
801032a9:	0f 87 c9 00 00 00    	ja     80103378 <mpinit+0x1d8>
801032af:	ff 24 85 6c 8f 10 80 	jmp    *-0x7fef7094(,%eax,4)
801032b6:	8d 76 00             	lea    0x0(%esi),%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032c0:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c3:	39 d6                	cmp    %edx,%esi
801032c5:	77 dd                	ja     801032a4 <mpinit+0x104>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032c7:	85 c9                	test   %ecx,%ecx
801032c9:	0f 84 9d 00 00 00    	je     8010336c <mpinit+0x1cc>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032d6:	74 11                	je     801032e9 <mpinit+0x149>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d8:	b0 70                	mov    $0x70,%al
801032da:	ba 22 00 00 00       	mov    $0x22,%edx
801032df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e0:	ba 23 00 00 00       	mov    $0x23,%edx
801032e5:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032e6:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032e8:	ee                   	out    %al,(%dx)
  }
}
801032e9:	83 c4 2c             	add    $0x2c,%esp
801032ec:	5b                   	pop    %ebx
801032ed:	5e                   	pop    %esi
801032ee:	5f                   	pop    %edi
801032ef:	5d                   	pop    %ebp
801032f0:	c3                   	ret    
801032f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801032f8:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
801032fe:	83 fb 07             	cmp    $0x7,%ebx
80103301:	7f 1a                	jg     8010331d <mpinit+0x17d>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103303:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80103307:	8d 3c 9b             	lea    (%ebx,%ebx,4),%edi
8010330a:	8d 3c 7b             	lea    (%ebx,%edi,2),%edi
        ncpu++;
8010330d:	43                   	inc    %ebx
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010330e:	c1 e7 04             	shl    $0x4,%edi
        ncpu++;
80103311:	89 1d 60 4d 11 80    	mov    %ebx,0x80114d60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103317:	88 87 e0 47 11 80    	mov    %al,-0x7feeb820(%edi)
      p += sizeof(struct mpproc);
8010331d:	83 c2 14             	add    $0x14,%edx
      continue;
80103320:	e9 7b ff ff ff       	jmp    801032a0 <mpinit+0x100>
80103325:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103328:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
8010332c:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
8010332f:	a2 c0 47 11 80       	mov    %al,0x801147c0
      continue;
80103334:	e9 67 ff ff ff       	jmp    801032a0 <mpinit+0x100>
80103339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103340:	ba 00 00 01 00       	mov    $0x10000,%edx
80103345:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010334a:	e8 d1 fd ff ff       	call   80103120 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010334f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103351:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103354:	0f 85 97 fe ff ff    	jne    801031f1 <mpinit+0x51>
8010335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103360:	c7 04 24 2d 8f 10 80 	movl   $0x80108f2d,(%esp)
80103367:	e8 04 d0 ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010336c:	c7 04 24 4c 8f 10 80 	movl   $0x80108f4c,(%esp)
80103373:	e8 f8 cf ff ff       	call   80100370 <panic>
      ismp = 0;
80103378:	31 c9                	xor    %ecx,%ecx
8010337a:	e9 28 ff ff ff       	jmp    801032a7 <mpinit+0x107>
8010337f:	90                   	nop

80103380 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103380:	55                   	push   %ebp
80103381:	b0 ff                	mov    $0xff,%al
80103383:	89 e5                	mov    %esp,%ebp
80103385:	ba 21 00 00 00       	mov    $0x21,%edx
8010338a:	ee                   	out    %al,(%dx)
8010338b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103390:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103391:	5d                   	pop    %ebp
80103392:	c3                   	ret    
80103393:	66 90                	xchg   %ax,%ax
80103395:	66 90                	xchg   %ax,%ax
80103397:	66 90                	xchg   %ax,%ax
80103399:	66 90                	xchg   %ax,%ax
8010339b:	66 90                	xchg   %ax,%ax
8010339d:	66 90                	xchg   %ax,%ax
8010339f:	90                   	nop

801033a0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	56                   	push   %esi
801033a4:	53                   	push   %ebx
801033a5:	83 ec 20             	sub    $0x20,%esp
801033a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ae:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033ba:	e8 91 d9 ff ff       	call   80100d50 <filealloc>
801033bf:	85 c0                	test   %eax,%eax
801033c1:	89 03                	mov    %eax,(%ebx)
801033c3:	74 1b                	je     801033e0 <pipealloc+0x40>
801033c5:	e8 86 d9 ff ff       	call   80100d50 <filealloc>
801033ca:	85 c0                	test   %eax,%eax
801033cc:	89 06                	mov    %eax,(%esi)
801033ce:	74 30                	je     80103400 <pipealloc+0x60>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033d0:	e8 bb f1 ff ff       	call   80102590 <kalloc>
801033d5:	85 c0                	test   %eax,%eax
801033d7:	75 47                	jne    80103420 <pipealloc+0x80>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033d9:	8b 03                	mov    (%ebx),%eax
801033db:	85 c0                	test   %eax,%eax
801033dd:	75 27                	jne    80103406 <pipealloc+0x66>
801033df:	90                   	nop
    fileclose(*f0);
  if(*f1)
801033e0:	8b 06                	mov    (%esi),%eax
801033e2:	85 c0                	test   %eax,%eax
801033e4:	74 08                	je     801033ee <pipealloc+0x4e>
    fileclose(*f1);
801033e6:	89 04 24             	mov    %eax,(%esp)
801033e9:	e8 22 da ff ff       	call   80100e10 <fileclose>
  return -1;
}
801033ee:	83 c4 20             	add    $0x20,%esp
  return -1;
801033f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033f6:	5b                   	pop    %ebx
801033f7:	5e                   	pop    %esi
801033f8:	5d                   	pop    %ebp
801033f9:	c3                   	ret    
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103400:	8b 03                	mov    (%ebx),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 e8                	je     801033ee <pipealloc+0x4e>
    fileclose(*f0);
80103406:	89 04 24             	mov    %eax,(%esp)
80103409:	e8 02 da ff ff       	call   80100e10 <fileclose>
  if(*f1)
8010340e:	8b 06                	mov    (%esi),%eax
80103410:	85 c0                	test   %eax,%eax
80103412:	75 d2                	jne    801033e6 <pipealloc+0x46>
80103414:	eb d8                	jmp    801033ee <pipealloc+0x4e>
80103416:	8d 76 00             	lea    0x0(%esi),%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  p->readopen = 1;
80103420:	ba 01 00 00 00       	mov    $0x1,%edx
  p->writeopen = 1;
80103425:	b9 01 00 00 00       	mov    $0x1,%ecx
  p->readopen = 1;
8010342a:	89 90 3c 02 00 00    	mov    %edx,0x23c(%eax)
  p->nwrite = 0;
80103430:	31 d2                	xor    %edx,%edx
  p->writeopen = 1;
80103432:	89 88 40 02 00 00    	mov    %ecx,0x240(%eax)
  p->nread = 0;
80103438:	31 c9                	xor    %ecx,%ecx
  p->nwrite = 0;
8010343a:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
  initlock(&p->lock, "pipe");
80103440:	ba 80 8f 10 80       	mov    $0x80108f80,%edx
  p->nread = 0;
80103445:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010344b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010344f:	89 04 24             	mov    %eax,(%esp)
80103452:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103455:	e8 26 27 00 00       	call   80105b80 <initlock>
  (*f0)->type = FD_PIPE;
8010345a:	8b 13                	mov    (%ebx),%edx
  (*f0)->pipe = p;
8010345c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  (*f0)->type = FD_PIPE;
8010345f:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80103465:	8b 13                	mov    (%ebx),%edx
80103467:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
8010346b:	8b 13                	mov    (%ebx),%edx
8010346d:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80103471:	8b 13                	mov    (%ebx),%edx
80103473:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80103476:	8b 16                	mov    (%esi),%edx
80103478:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
8010347e:	8b 16                	mov    (%esi),%edx
80103480:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
80103484:	8b 16                	mov    (%esi),%edx
80103486:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
8010348a:	8b 16                	mov    (%esi),%edx
8010348c:	89 42 0c             	mov    %eax,0xc(%edx)
}
8010348f:	83 c4 20             	add    $0x20,%esp
  return 0;
80103492:	31 c0                	xor    %eax,%eax
}
80103494:	5b                   	pop    %ebx
80103495:	5e                   	pop    %esi
80103496:	5d                   	pop    %ebp
80103497:	c3                   	ret    
80103498:	90                   	nop
80103499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034a0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	83 ec 18             	sub    $0x18,%esp
801034a6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801034a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
801034af:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034b2:	89 1c 24             	mov    %ebx,(%esp)
801034b5:	e8 16 28 00 00       	call   80105cd0 <acquire>
  if(writable){
801034ba:	85 f6                	test   %esi,%esi
801034bc:	74 42                	je     80103500 <pipeclose+0x60>
    p->writeopen = 0;
801034be:	31 f6                	xor    %esi,%esi
    wakeup(&p->nread);
801034c0:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801034c6:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
801034cc:	89 04 24             	mov    %eax,(%esp)
801034cf:	e8 2c 16 00 00       	call   80104b00 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034d4:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034da:	85 d2                	test   %edx,%edx
801034dc:	75 0a                	jne    801034e8 <pipeclose+0x48>
801034de:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034e4:	85 c0                	test   %eax,%eax
801034e6:	74 38                	je     80103520 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034e8:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034eb:	8b 75 fc             	mov    -0x4(%ebp),%esi
801034ee:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801034f1:	89 ec                	mov    %ebp,%esp
801034f3:	5d                   	pop    %ebp
    release(&p->lock);
801034f4:	e9 77 28 00 00       	jmp    80105d70 <release>
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103500:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103502:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103508:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010350e:	89 04 24             	mov    %eax,(%esp)
80103511:	e8 ea 15 00 00       	call   80104b00 <wakeup>
80103516:	eb bc                	jmp    801034d4 <pipeclose+0x34>
80103518:	90                   	nop
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103520:	89 1c 24             	mov    %ebx,(%esp)
80103523:	e8 48 28 00 00       	call   80105d70 <release>
}
80103528:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
8010352b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010352e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103531:	89 ec                	mov    %ebp,%esp
80103533:	5d                   	pop    %ebp
    kfree((char*)p);
80103534:	e9 87 ee ff ff       	jmp    801023c0 <kfree>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103540 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 2c             	sub    $0x2c,%esp
80103549:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010354c:	89 3c 24             	mov    %edi,(%esp)
8010354f:	e8 7c 27 00 00       	call   80105cd0 <acquire>
  for(i = 0; i < n; i++){
80103554:	8b 75 10             	mov    0x10(%ebp),%esi
80103557:	85 f6                	test   %esi,%esi
80103559:	0f 8e c7 00 00 00    	jle    80103626 <pipewrite+0xe6>
8010355f:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103562:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103568:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010356b:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103571:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103574:	01 d8                	add    %ebx,%eax
80103576:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103579:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010357f:	05 00 02 00 00       	add    $0x200,%eax
80103584:	39 c1                	cmp    %eax,%ecx
80103586:	75 6c                	jne    801035f4 <pipewrite+0xb4>
      if(p->readopen == 0 || myproc()->killed){
80103588:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010358e:	85 c0                	test   %eax,%eax
80103590:	74 4d                	je     801035df <pipewrite+0x9f>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103592:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103598:	eb 39                	jmp    801035d3 <pipewrite+0x93>
8010359a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035a0:	89 34 24             	mov    %esi,(%esp)
801035a3:	e8 58 15 00 00       	call   80104b00 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035ac:	89 1c 24             	mov    %ebx,(%esp)
801035af:	e8 6c 11 00 00       	call   80104720 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035b4:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035ba:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801035c0:	05 00 02 00 00       	add    $0x200,%eax
801035c5:	39 c2                	cmp    %eax,%edx
801035c7:	75 37                	jne    80103600 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035c9:	8b 8f 3c 02 00 00    	mov    0x23c(%edi),%ecx
801035cf:	85 c9                	test   %ecx,%ecx
801035d1:	74 0c                	je     801035df <pipewrite+0x9f>
801035d3:	e8 88 03 00 00       	call   80103960 <myproc>
801035d8:	8b 50 24             	mov    0x24(%eax),%edx
801035db:	85 d2                	test   %edx,%edx
801035dd:	74 c1                	je     801035a0 <pipewrite+0x60>
        release(&p->lock);
801035df:	89 3c 24             	mov    %edi,(%esp)
801035e2:	e8 89 27 00 00       	call   80105d70 <release>
        return -1;
801035e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035ec:	83 c4 2c             	add    $0x2c,%esp
801035ef:	5b                   	pop    %ebx
801035f0:	5e                   	pop    %esi
801035f1:	5f                   	pop    %edi
801035f2:	5d                   	pop    %ebp
801035f3:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f4:	89 ca                	mov    %ecx,%edx
801035f6:	8d 76 00             	lea    0x0(%esi),%esi
801035f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103600:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103603:	8d 4a 01             	lea    0x1(%edx),%ecx
80103606:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010360c:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103612:	0f b6 03             	movzbl (%ebx),%eax
80103615:	43                   	inc    %ebx
  for(i = 0; i < n; i++){
80103616:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80103619:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010361c:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
80103620:	0f 85 53 ff ff ff    	jne    80103579 <pipewrite+0x39>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103626:	8d 87 34 02 00 00    	lea    0x234(%edi),%eax
8010362c:	89 04 24             	mov    %eax,(%esp)
8010362f:	e8 cc 14 00 00       	call   80104b00 <wakeup>
  release(&p->lock);
80103634:	89 3c 24             	mov    %edi,(%esp)
80103637:	e8 34 27 00 00       	call   80105d70 <release>
  return n;
8010363c:	8b 45 10             	mov    0x10(%ebp),%eax
8010363f:	eb ab                	jmp    801035ec <pipewrite+0xac>
80103641:	eb 0d                	jmp    80103650 <piperead>
80103643:	90                   	nop
80103644:	90                   	nop
80103645:	90                   	nop
80103646:	90                   	nop
80103647:	90                   	nop
80103648:	90                   	nop
80103649:	90                   	nop
8010364a:	90                   	nop
8010364b:	90                   	nop
8010364c:	90                   	nop
8010364d:	90                   	nop
8010364e:	90                   	nop
8010364f:	90                   	nop

80103650 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 1c             	sub    $0x1c,%esp
80103659:	8b 75 08             	mov    0x8(%ebp),%esi
8010365c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010365f:	89 34 24             	mov    %esi,(%esp)
80103662:	e8 69 26 00 00       	call   80105cd0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103667:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010366d:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103673:	75 6b                	jne    801036e0 <piperead+0x90>
80103675:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010367b:	85 db                	test   %ebx,%ebx
8010367d:	0f 84 bd 00 00 00    	je     80103740 <piperead+0xf0>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103683:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103689:	eb 2d                	jmp    801036b8 <piperead+0x68>
8010368b:	90                   	nop
8010368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103690:	89 74 24 04          	mov    %esi,0x4(%esp)
80103694:	89 1c 24             	mov    %ebx,(%esp)
80103697:	e8 84 10 00 00       	call   80104720 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010369c:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036a2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036a8:	75 36                	jne    801036e0 <piperead+0x90>
801036aa:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036b0:	85 d2                	test   %edx,%edx
801036b2:	0f 84 88 00 00 00    	je     80103740 <piperead+0xf0>
    if(myproc()->killed){
801036b8:	e8 a3 02 00 00       	call   80103960 <myproc>
801036bd:	8b 48 24             	mov    0x24(%eax),%ecx
801036c0:	85 c9                	test   %ecx,%ecx
801036c2:	74 cc                	je     80103690 <piperead+0x40>
      release(&p->lock);
801036c4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036c7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036cc:	e8 9f 26 00 00       	call   80105d70 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036d1:	83 c4 1c             	add    $0x1c,%esp
801036d4:	89 d8                	mov    %ebx,%eax
801036d6:	5b                   	pop    %ebx
801036d7:	5e                   	pop    %esi
801036d8:	5f                   	pop    %edi
801036d9:	5d                   	pop    %ebp
801036da:	c3                   	ret    
801036db:	90                   	nop
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036e0:	8b 45 10             	mov    0x10(%ebp),%eax
801036e3:	85 c0                	test   %eax,%eax
801036e5:	7e 59                	jle    80103740 <piperead+0xf0>
    if(p->nread == p->nwrite)
801036e7:	31 db                	xor    %ebx,%ebx
801036e9:	eb 13                	jmp    801036fe <piperead+0xae>
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036f0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036f6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036fc:	74 1d                	je     8010371b <piperead+0xcb>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036fe:	8d 41 01             	lea    0x1(%ecx),%eax
80103701:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103707:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010370d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103712:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103715:	43                   	inc    %ebx
80103716:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103719:	75 d5                	jne    801036f0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010371b:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103721:	89 04 24             	mov    %eax,(%esp)
80103724:	e8 d7 13 00 00       	call   80104b00 <wakeup>
  release(&p->lock);
80103729:	89 34 24             	mov    %esi,(%esp)
8010372c:	e8 3f 26 00 00       	call   80105d70 <release>
}
80103731:	83 c4 1c             	add    $0x1c,%esp
80103734:	89 d8                	mov    %ebx,%eax
80103736:	5b                   	pop    %ebx
80103737:	5e                   	pop    %esi
80103738:	5f                   	pop    %edi
80103739:	5d                   	pop    %ebp
8010373a:	c3                   	ret    
8010373b:	90                   	nop
8010373c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103740:	31 db                	xor    %ebx,%ebx
80103742:	eb d7                	jmp    8010371b <piperead+0xcb>
80103744:	66 90                	xchg   %ax,%ax
80103746:	66 90                	xchg   %ax,%ax
80103748:	66 90                	xchg   %ax,%ax
8010374a:	66 90                	xchg   %ax,%ax
8010374c:	66 90                	xchg   %ax,%ax
8010374e:	66 90                	xchg   %ax,%ax

80103750 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void) {
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	53                   	push   %ebx
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103754:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
allocproc(void) {
80103759:	83 ec 14             	sub    $0x14,%esp
    acquire(&ptable.lock);
8010375c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103763:	e8 68 25 00 00       	call   80105cd0 <acquire>
80103768:	eb 18                	jmp    80103782 <allocproc+0x32>
8010376a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	81 c3 ac 00 00 00    	add    $0xac,%ebx
80103776:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
8010377c:	0f 83 7e 00 00 00    	jae    80103800 <allocproc+0xb0>
        if (p->state == UNUSED)
80103782:	8b 43 0c             	mov    0xc(%ebx),%eax
80103785:	85 c0                	test   %eax,%eax
80103787:	75 e7                	jne    80103770 <allocproc+0x20>
    release(&ptable.lock);
    return 0;

    found:
    p->state = EMBRYO;
    p->pid = nextpid++;
80103789:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    p->state = EMBRYO;
8010378e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
    p->pid = nextpid++;
80103795:	8d 50 01             	lea    0x1(%eax),%edx
80103798:	89 43 10             	mov    %eax,0x10(%ebx)

    release(&ptable.lock);
8010379b:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
    p->pid = nextpid++;
801037a2:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
    release(&ptable.lock);
801037a8:	e8 c3 25 00 00       	call   80105d70 <release>

    // Allocate kernel stack.
    if ((p->kstack = kalloc()) == 0) {
801037ad:	e8 de ed ff ff       	call   80102590 <kalloc>
801037b2:	85 c0                	test   %eax,%eax
801037b4:	89 43 08             	mov    %eax,0x8(%ebx)
801037b7:	74 5d                	je     80103816 <allocproc+0xc6>
        return 0;
    }
    sp = p->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
801037b9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
    sp -= 4;
    *(uint *) sp = (uint) trapret;

    sp -= sizeof *p->context;
    p->context = (struct context *) sp;
    memset(p->context, 0, sizeof *p->context);
801037bf:	b9 14 00 00 00       	mov    $0x14,%ecx
    sp -= sizeof *p->tf;
801037c4:	89 53 18             	mov    %edx,0x18(%ebx)
    *(uint *) sp = (uint) trapret;
801037c7:	ba ef 70 10 80       	mov    $0x801070ef,%edx
    sp -= sizeof *p->context;
801037cc:	05 9c 0f 00 00       	add    $0xf9c,%eax
    *(uint *) sp = (uint) trapret;
801037d1:	89 50 14             	mov    %edx,0x14(%eax)
    memset(p->context, 0, sizeof *p->context);
801037d4:	31 d2                	xor    %edx,%edx
    p->context = (struct context *) sp;
801037d6:	89 43 1c             	mov    %eax,0x1c(%ebx)
    memset(p->context, 0, sizeof *p->context);
801037d9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801037dd:	89 54 24 04          	mov    %edx,0x4(%esp)
801037e1:	89 04 24             	mov    %eax,(%esp)
801037e4:	e8 d7 25 00 00       	call   80105dc0 <memset>
    p->context->eip = (uint) forkret;
801037e9:	8b 43 1c             	mov    0x1c(%ebx),%eax
801037ec:	c7 40 10 30 38 10 80 	movl   $0x80103830,0x10(%eax)

    return p;
}
801037f3:	83 c4 14             	add    $0x14,%esp
801037f6:	89 d8                	mov    %ebx,%eax
801037f8:	5b                   	pop    %ebx
801037f9:	5d                   	pop    %ebp
801037fa:	c3                   	ret    
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80103800:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
    return 0;
80103807:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80103809:	e8 62 25 00 00       	call   80105d70 <release>
}
8010380e:	83 c4 14             	add    $0x14,%esp
80103811:	89 d8                	mov    %ebx,%eax
80103813:	5b                   	pop    %ebx
80103814:	5d                   	pop    %ebp
80103815:	c3                   	ret    
        p->state = UNUSED;
80103816:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        return 0;
8010381d:	31 db                	xor    %ebx,%ebx
8010381f:	eb d2                	jmp    801037f3 <allocproc+0xa3>
80103821:	eb 0d                	jmp    80103830 <forkret>
80103823:	90                   	nop
80103824:	90                   	nop
80103825:	90                   	nop
80103826:	90                   	nop
80103827:	90                   	nop
80103828:	90                   	nop
80103829:	90                   	nop
8010382a:	90                   	nop
8010382b:	90                   	nop
8010382c:	90                   	nop
8010382d:	90                   	nop
8010382e:	90                   	nop
8010382f:	90                   	nop

80103830 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void) {
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 18             	sub    $0x18,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80103836:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010383d:	e8 2e 25 00 00       	call   80105d70 <release>

    if (first) {
80103842:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
80103848:	85 d2                	test   %edx,%edx
8010384a:	75 04                	jne    80103850 <forkret+0x20>
        iinit(ROOTDEV);
        initlog(ROOTDEV);
    }

    // Return to "caller", actually trapret (see allocproc).
}
8010384c:	c9                   	leave  
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
        first = 0;
80103850:	31 c0                	xor    %eax,%eax
        iinit(ROOTDEV);
80103852:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
        first = 0;
80103859:	a3 00 c0 10 80       	mov    %eax,0x8010c000
        iinit(ROOTDEV);
8010385e:	e8 2d dc ff ff       	call   80101490 <iinit>
        initlog(ROOTDEV);
80103863:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010386a:	e8 61 f3 ff ff       	call   80102bd0 <initlog>
}
8010386f:	c9                   	leave  
80103870:	c3                   	ret    
80103871:	eb 0d                	jmp    80103880 <getAccumulator>
80103873:	90                   	nop
80103874:	90                   	nop
80103875:	90                   	nop
80103876:	90                   	nop
80103877:	90                   	nop
80103878:	90                   	nop
80103879:	90                   	nop
8010387a:	90                   	nop
8010387b:	90                   	nop
8010387c:	90                   	nop
8010387d:	90                   	nop
8010387e:	90                   	nop
8010387f:	90                   	nop

80103880 <getAccumulator>:
long long getAccumulator(struct proc *p) {
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
    return p->acc;
80103883:	8b 45 08             	mov    0x8(%ebp),%eax
}
80103886:	5d                   	pop    %ebp
    return p->acc;
80103887:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
8010388d:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
80103893:	c3                   	ret    
80103894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010389a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038a0 <pinit>:
pinit(void) {
801038a0:	55                   	push   %ebp
    initlock(&ptable.lock, "ptable");
801038a1:	b8 85 8f 10 80       	mov    $0x80108f85,%eax
pinit(void) {
801038a6:	89 e5                	mov    %esp,%ebp
801038a8:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
801038ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801038af:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038b6:	e8 c5 22 00 00       	call   80105b80 <initlock>
}
801038bb:	c9                   	leave  
801038bc:	c3                   	ret    
801038bd:	8d 76 00             	lea    0x0(%esi),%esi

801038c0 <mycpu>:
mycpu(void) {
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
801038c5:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038c8:	9c                   	pushf  
801038c9:	58                   	pop    %eax
    if (readeflags() & FL_IF)
801038ca:	f6 c4 02             	test   $0x2,%ah
801038cd:	75 5b                	jne    8010392a <mycpu+0x6a>
    apicid = lapicid();
801038cf:	e8 3c ef ff ff       	call   80102810 <lapicid>
    for (i = 0; i < ncpu; ++i) {
801038d4:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
801038da:	85 f6                	test   %esi,%esi
801038dc:	7e 40                	jle    8010391e <mycpu+0x5e>
        if (cpus[i].apicid == apicid)
801038de:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
801038e5:	39 d0                	cmp    %edx,%eax
801038e7:	74 2e                	je     80103917 <mycpu+0x57>
801038e9:	b9 90 48 11 80       	mov    $0x80114890,%ecx
    for (i = 0; i < ncpu; ++i) {
801038ee:	31 d2                	xor    %edx,%edx
801038f0:	42                   	inc    %edx
801038f1:	39 f2                	cmp    %esi,%edx
801038f3:	74 29                	je     8010391e <mycpu+0x5e>
        if (cpus[i].apicid == apicid)
801038f5:	0f b6 19             	movzbl (%ecx),%ebx
801038f8:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038fe:	39 c3                	cmp    %eax,%ebx
80103900:	75 ee                	jne    801038f0 <mycpu+0x30>
80103902:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103905:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103908:	c1 e0 04             	shl    $0x4,%eax
8010390b:	05 e0 47 11 80       	add    $0x801147e0,%eax
}
80103910:	83 c4 10             	add    $0x10,%esp
80103913:	5b                   	pop    %ebx
80103914:	5e                   	pop    %esi
80103915:	5d                   	pop    %ebp
80103916:	c3                   	ret    
        if (cpus[i].apicid == apicid)
80103917:	b8 e0 47 11 80       	mov    $0x801147e0,%eax
            return &cpus[i];
8010391c:	eb f2                	jmp    80103910 <mycpu+0x50>
    panic("unknown apicid\n");
8010391e:	c7 04 24 8c 8f 10 80 	movl   $0x80108f8c,(%esp)
80103925:	e8 46 ca ff ff       	call   80100370 <panic>
        panic("mycpu called with interrupts enabled\n");
8010392a:	c7 04 24 80 90 10 80 	movl   $0x80109080,(%esp)
80103931:	e8 3a ca ff ff       	call   80100370 <panic>
80103936:	8d 76 00             	lea    0x0(%esi),%esi
80103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103940 <cpuid>:
cpuid() {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 08             	sub    $0x8,%esp
    return mycpu() - cpus;
80103946:	e8 75 ff ff ff       	call   801038c0 <mycpu>
}
8010394b:	c9                   	leave  
    return mycpu() - cpus;
8010394c:	2d e0 47 11 80       	sub    $0x801147e0,%eax
80103951:	c1 f8 04             	sar    $0x4,%eax
80103954:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010395a:	c3                   	ret    
8010395b:	90                   	nop
8010395c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103960 <myproc>:
myproc(void) {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80103967:	e8 84 22 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
8010396c:	e8 4f ff ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103977:	e8 b4 22 00 00       	call   80105c30 <popcli>
}
8010397c:	5a                   	pop    %edx
8010397d:	89 d8                	mov    %ebx,%eax
8010397f:	5b                   	pop    %ebx
80103980:	5d                   	pop    %ebp
80103981:	c3                   	ret    
80103982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103990 <getMinAccumulator>:
getMinAccumulator(void) {
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 24             	sub    $0x24,%esp
    pq_not_empty = pq.getMinAccumulator(&runnables);
80103997:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010399a:	89 04 24             	mov    %eax,(%esp)
8010399d:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
801039a3:	89 c3                	mov    %eax,%ebx
    rp_not_empty = rpholder.getMinAccumulator(&runnings);
801039a5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801039a8:	89 04 24             	mov    %eax,(%esp)
801039ab:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
801039b1:	89 c1                	mov    %eax,%ecx
    if(!pq_not_empty && !rp_not_empty)
801039b3:	89 d8                	mov    %ebx,%eax
801039b5:	09 c8                	or     %ecx,%eax
801039b7:	74 37                	je     801039f0 <getMinAccumulator+0x60>
    if(!pq_not_empty)
801039b9:	85 db                	test   %ebx,%ebx
801039bb:	74 23                	je     801039e0 <getMinAccumulator+0x50>
    if(!rp_not_empty)
801039bd:	85 c9                	test   %ecx,%ecx
801039bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801039c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039c5:	74 1f                	je     801039e6 <getMinAccumulator+0x56>
    return runnables < runnings ? runnables : runnings;
801039c7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801039ca:	8b 5d f0             	mov    -0x10(%ebp),%ebx
801039cd:	39 ca                	cmp    %ecx,%edx
801039cf:	7c 15                	jl     801039e6 <getMinAccumulator+0x56>
801039d1:	7e 2d                	jle    80103a00 <getMinAccumulator+0x70>
801039d3:	89 d8                	mov    %ebx,%eax
801039d5:	89 ca                	mov    %ecx,%edx
801039d7:	eb 0d                	jmp    801039e6 <getMinAccumulator+0x56>
801039d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return runnings;
801039e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
}
801039e6:	83 c4 24             	add    $0x24,%esp
801039e9:	5b                   	pop    %ebx
801039ea:	5d                   	pop    %ebp
801039eb:	c3                   	ret    
801039ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039f0:	83 c4 24             	add    $0x24,%esp
        return 0;
801039f3:	31 c0                	xor    %eax,%eax
}
801039f5:	5b                   	pop    %ebx
        return 0;
801039f6:	31 d2                	xor    %edx,%edx
}
801039f8:	5d                   	pop    %ebp
801039f9:	c3                   	ret    
801039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return runnables < runnings ? runnables : runnings;
80103a00:	39 d8                	cmp    %ebx,%eax
80103a02:	76 e2                	jbe    801039e6 <getMinAccumulator+0x56>
80103a04:	eb cd                	jmp    801039d3 <getMinAccumulator+0x43>
80103a06:	8d 76 00             	lea    0x0(%esi),%esi
80103a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a10 <wakeup1>:

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan) {
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	89 c6                	mov    %eax,%esi
80103a16:	53                   	push   %ebx
    struct proc *p;

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a17:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
wakeup1(void *chan) {
80103a1c:	83 ec 10             	sub    $0x10,%esp
80103a1f:	eb 19                	jmp    80103a3a <wakeup1+0x2a>
80103a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a28:	81 c3 ac 00 00 00    	add    $0xac,%ebx
80103a2e:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
80103a34:	0f 83 8a 00 00 00    	jae    80103ac4 <wakeup1+0xb4>
        if (p->state == SLEEPING && p->chan == chan) {
80103a3a:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a3d:	83 f8 02             	cmp    $0x2,%eax
80103a40:	75 e6                	jne    80103a28 <wakeup1+0x18>
80103a42:	39 73 20             	cmp    %esi,0x20(%ebx)
80103a45:	75 e1                	jne    80103a28 <wakeup1+0x18>
            updatePerformance(p, ticks);
80103a47:	8b 15 00 81 11 80    	mov    0x80118100,%edx
    int time = ticks - p->oldTick;
80103a4d:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103a53:	89 d1                	mov    %edx,%ecx
80103a55:	29 c1                	sub    %eax,%ecx
    switch (p->state) {
80103a57:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a5a:	83 f8 03             	cmp    $0x3,%eax
80103a5d:	74 71                	je     80103ad0 <wakeup1+0xc0>
80103a5f:	83 f8 04             	cmp    $0x4,%eax
80103a62:	0f 84 88 00 00 00    	je     80103af0 <wakeup1+0xe0>
80103a68:	83 f8 02             	cmp    $0x2,%eax
80103a6b:	74 73                	je     80103ae0 <wakeup1+0xd0>
80103a6d:	8d 76 00             	lea    0x0(%esi),%esi

            p->acc = getMinAccumulator();
80103a70:	e8 1b ff ff ff       	call   80103990 <getMinAccumulator>

            p->idle = tick;
            p->state = RUNNABLE;
80103a75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
            p->acc = getMinAccumulator();
80103a7c:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
            p->idle = tick;
80103a82:	a1 08 c0 10 80       	mov    0x8010c008,%eax
            p->acc = getMinAccumulator();
80103a87:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
            p->idle = tick;
80103a8d:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
80103a93:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)

            if (poli == 1) {
80103a99:	a1 10 c0 10 80       	mov    0x8010c010,%eax
            p->idle = tick;
80103a9e:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
            if (poli == 1) {
80103aa4:	83 f8 01             	cmp    $0x1,%eax
80103aa7:	75 57                	jne    80103b00 <wakeup1+0xf0>
                rrq.enqueue(p);
80103aa9:	89 1c 24             	mov    %ebx,(%esp)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aac:	81 c3 ac 00 00 00    	add    $0xac,%ebx
                rrq.enqueue(p);
80103ab2:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ab8:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
80103abe:	0f 82 76 ff ff ff    	jb     80103a3a <wakeup1+0x2a>
            } else if (poli == 2 || poli == 3) {
                pq.put(p);
            }
        }
}
80103ac4:	83 c4 10             	add    $0x10,%esp
80103ac7:	5b                   	pop    %ebx
80103ac8:	5e                   	pop    %esi
80103ac9:	5d                   	pop    %ebp
80103aca:	c3                   	ret    
80103acb:	90                   	nop
80103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            p->retime += time;
80103ad0:	01 8b a0 00 00 00    	add    %ecx,0xa0(%ebx)
        p->oldTick = ticks;
80103ad6:	89 93 a8 00 00 00    	mov    %edx,0xa8(%ebx)
80103adc:	eb 8f                	jmp    80103a6d <wakeup1+0x5d>
80103ade:	66 90                	xchg   %ax,%ax
            p->stime += time;
80103ae0:	01 8b 9c 00 00 00    	add    %ecx,0x9c(%ebx)
80103ae6:	eb ee                	jmp    80103ad6 <wakeup1+0xc6>
80103ae8:	90                   	nop
80103ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            p->rutime += time;
80103af0:	01 8b a4 00 00 00    	add    %ecx,0xa4(%ebx)
80103af6:	eb de                	jmp    80103ad6 <wakeup1+0xc6>
80103af8:	90                   	nop
80103af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            } else if (poli == 2 || poli == 3) {
80103b00:	83 e8 02             	sub    $0x2,%eax
80103b03:	83 f8 01             	cmp    $0x1,%eax
80103b06:	0f 87 1c ff ff ff    	ja     80103a28 <wakeup1+0x18>
                pq.put(p);
80103b0c:	89 1c 24             	mov    %ebx,(%esp)
80103b0f:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103b15:	e9 0e ff ff ff       	jmp    80103a28 <wakeup1+0x18>
80103b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b20 <updatePerformance>:
updatePerformance(struct proc *p, uint ticks) {
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	8b 45 08             	mov    0x8(%ebp),%eax
80103b26:	53                   	push   %ebx
80103b27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    int time = ticks - p->oldTick;
80103b2a:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
80103b30:	89 cb                	mov    %ecx,%ebx
80103b32:	29 d3                	sub    %edx,%ebx
    switch (p->state) {
80103b34:	8b 50 0c             	mov    0xc(%eax),%edx
80103b37:	83 fa 03             	cmp    $0x3,%edx
80103b3a:	74 34                	je     80103b70 <updatePerformance+0x50>
80103b3c:	83 fa 04             	cmp    $0x4,%edx
80103b3f:	74 1f                	je     80103b60 <updatePerformance+0x40>
80103b41:	83 fa 02             	cmp    $0x2,%edx
80103b44:	74 0a                	je     80103b50 <updatePerformance+0x30>
}
80103b46:	5b                   	pop    %ebx
80103b47:	5d                   	pop    %ebp
80103b48:	c3                   	ret    
80103b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            p->stime += time;
80103b50:	01 98 9c 00 00 00    	add    %ebx,0x9c(%eax)
        p->oldTick = ticks;
80103b56:	89 88 a8 00 00 00    	mov    %ecx,0xa8(%eax)
}
80103b5c:	5b                   	pop    %ebx
80103b5d:	5d                   	pop    %ebp
80103b5e:	c3                   	ret    
80103b5f:	90                   	nop
            p->rutime += time;
80103b60:	01 98 a4 00 00 00    	add    %ebx,0xa4(%eax)
80103b66:	eb ee                	jmp    80103b56 <updatePerformance+0x36>
80103b68:	90                   	nop
80103b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            p->retime += time;
80103b70:	01 98 a0 00 00 00    	add    %ebx,0xa0(%eax)
80103b76:	eb de                	jmp    80103b56 <updatePerformance+0x36>
80103b78:	90                   	nop
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b80 <initFields>:
initFields(struct proc *p) {
80103b80:	55                   	push   %ebp
    p->idle = 0;
80103b81:	31 d2                	xor    %edx,%edx
initFields(struct proc *p) {
80103b83:	89 e5                	mov    %esp,%ebp
    p->idle = 0;
80103b85:	31 c9                	xor    %ecx,%ecx
initFields(struct proc *p) {
80103b87:	8b 45 08             	mov    0x8(%ebp),%eax
    p->idle = 0;
80103b8a:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    p->oldTick = ticks;
80103b90:	8b 15 00 81 11 80    	mov    0x80118100,%edx
    p->idle = 0;
80103b96:	89 88 90 00 00 00    	mov    %ecx,0x90(%eax)
    p->retime = 0;
80103b9c:	31 c9                	xor    %ecx,%ecx
80103b9e:	89 88 a0 00 00 00    	mov    %ecx,0xa0(%eax)
    p->oldTick = ticks;
80103ba4:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
    p->stime = 0;
80103baa:	31 d2                	xor    %edx,%edx
80103bac:	89 90 9c 00 00 00    	mov    %edx,0x9c(%eax)
    p->rutime = 0;
80103bb2:	31 d2                	xor    %edx,%edx
80103bb4:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
80103bba:	5d                   	pop    %ebp
80103bbb:	c3                   	ret    
80103bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103bc0 <userinit>:
userinit(void) {
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	53                   	push   %ebx
80103bc4:	83 ec 14             	sub    $0x14,%esp
    p = allocproc();
80103bc7:	e8 84 fb ff ff       	call   80103750 <allocproc>
80103bcc:	89 c3                	mov    %eax,%ebx
    initproc = p;
80103bce:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
    if ((p->pgdir = setupkvm()) == 0)
80103bd3:	e8 48 4b 00 00       	call   80108720 <setupkvm>
80103bd8:	85 c0                	test   %eax,%eax
80103bda:	89 43 04             	mov    %eax,0x4(%ebx)
80103bdd:	0f 84 50 01 00 00    	je     80103d33 <userinit+0x173>
    inituvm(p->pgdir, _binary_initcode_start, (int) _binary_initcode_size);
80103be3:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103be8:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103bed:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103bf1:	89 54 24 08          	mov    %edx,0x8(%esp)
80103bf5:	89 04 24             	mov    %eax,(%esp)
80103bf8:	e8 f3 47 00 00       	call   801083f0 <inituvm>
    memset(p->tf, 0, sizeof(*p->tf));
80103bfd:	b8 4c 00 00 00       	mov    $0x4c,%eax
    p->sz = PGSIZE;
80103c02:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
    memset(p->tf, 0, sizeof(*p->tf));
80103c08:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c0c:	31 c0                	xor    %eax,%eax
80103c0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c12:	8b 43 18             	mov    0x18(%ebx),%eax
80103c15:	89 04 24             	mov    %eax,(%esp)
80103c18:	e8 a3 21 00 00       	call   80105dc0 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c1d:	8b 43 18             	mov    0x18(%ebx),%eax
80103c20:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c26:	8b 43 18             	mov    0x18(%ebx),%eax
80103c29:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
    p->tf->es = p->tf->ds;
80103c2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c32:	8b 50 2c             	mov    0x2c(%eax),%edx
80103c35:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80103c39:	8b 43 18             	mov    0x18(%ebx),%eax
80103c3c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103c3f:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80103c43:	8b 43 18             	mov    0x18(%ebx),%eax
80103c46:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80103c4d:	8b 43 18             	mov    0x18(%ebx),%eax
80103c50:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80103c57:	8b 43 18             	mov    0x18(%ebx),%eax
80103c5a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103c61:	b8 10 00 00 00       	mov    $0x10,%eax
80103c66:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c6a:	b8 b5 8f 10 80       	mov    $0x80108fb5,%eax
80103c6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c73:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c76:	89 04 24             	mov    %eax,(%esp)
80103c79:	e8 22 23 00 00       	call   80105fa0 <safestrcpy>
    p->cwd = namei("/");
80103c7e:	c7 04 24 be 8f 10 80 	movl   $0x80108fbe,(%esp)
80103c85:	e8 26 e3 ff ff       	call   80101fb0 <namei>
80103c8a:	89 43 68             	mov    %eax,0x68(%ebx)
    acquire(&ptable.lock);
80103c8d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103c94:	e8 37 20 00 00       	call   80105cd0 <acquire>
    p->priority = 5;
80103c99:	b8 05 00 00 00       	mov    $0x5,%eax
    p->acc = 0;
80103c9e:	31 d2                	xor    %edx,%edx
    p->priority = 5;
80103ca0:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    p->acc = 0;
80103ca6:	31 c0                	xor    %eax,%eax
    p->stime = 0;
80103ca8:	31 c9                	xor    %ecx,%ecx
    p->acc = 0;
80103caa:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
    p->ctime = ticks;  //ticks from trap.c
80103cb0:	a1 00 81 11 80       	mov    0x80118100,%eax
    p->acc = 0;
80103cb5:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
    p->idle = tick;
80103cbb:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
    p->stime = 0;
80103cc1:	89 8b 9c 00 00 00    	mov    %ecx,0x9c(%ebx)
    p->state = RUNNABLE;
80103cc7:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    p->ctime = ticks;  //ticks from trap.c
80103cce:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
    p->oldTick = ticks;
80103cd4:	89 83 a8 00 00 00    	mov    %eax,0xa8(%ebx)
    p->retime = 0;
80103cda:	31 c0                	xor    %eax,%eax
80103cdc:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
    p->rutime = 0;
80103ce2:	31 c0                	xor    %eax,%eax
80103ce4:	89 83 a4 00 00 00    	mov    %eax,0xa4(%ebx)
    p->idle = tick;
80103cea:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80103cef:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
80103cf5:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
    if (poli == 1) {
80103cfb:	a1 10 c0 10 80       	mov    0x8010c010,%eax
80103d00:	83 f8 01             	cmp    $0x1,%eax
80103d03:	75 1b                	jne    80103d20 <userinit+0x160>
        rrq.enqueue(p);
80103d05:	89 1c 24             	mov    %ebx,(%esp)
80103d08:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
    release(&ptable.lock);
80103d0e:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d15:	e8 56 20 00 00       	call   80105d70 <release>
}
80103d1a:	83 c4 14             	add    $0x14,%esp
80103d1d:	5b                   	pop    %ebx
80103d1e:	5d                   	pop    %ebp
80103d1f:	c3                   	ret    
    } else if (poli == 2 || poli == 3) {
80103d20:	83 e8 02             	sub    $0x2,%eax
80103d23:	83 f8 01             	cmp    $0x1,%eax
80103d26:	77 e6                	ja     80103d0e <userinit+0x14e>
        pq.put(p);
80103d28:	89 1c 24             	mov    %ebx,(%esp)
80103d2b:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103d31:	eb db                	jmp    80103d0e <userinit+0x14e>
        panic("userinit: out of memory?");
80103d33:	c7 04 24 9c 8f 10 80 	movl   $0x80108f9c,(%esp)
80103d3a:	e8 31 c6 ff ff       	call   80100370 <panic>
80103d3f:	90                   	nop

80103d40 <growproc>:
growproc(int n) {
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	56                   	push   %esi
80103d44:	53                   	push   %ebx
80103d45:	83 ec 10             	sub    $0x10,%esp
80103d48:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
80103d4b:	e8 a0 1e 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
80103d50:	e8 6b fb ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103d55:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103d5b:	e8 d0 1e 00 00       	call   80105c30 <popcli>
    if (n > 0) {
80103d60:	83 fe 00             	cmp    $0x0,%esi
    sz = curproc->sz;
80103d63:	8b 03                	mov    (%ebx),%eax
    if (n > 0) {
80103d65:	7f 19                	jg     80103d80 <growproc+0x40>
    } else if (n < 0) {
80103d67:	75 37                	jne    80103da0 <growproc+0x60>
    curproc->sz = sz;
80103d69:	89 03                	mov    %eax,(%ebx)
    switchuvm(curproc);
80103d6b:	89 1c 24             	mov    %ebx,(%esp)
80103d6e:	e8 7d 45 00 00       	call   801082f0 <switchuvm>
    return 0;
80103d73:	31 c0                	xor    %eax,%eax
}
80103d75:	83 c4 10             	add    $0x10,%esp
80103d78:	5b                   	pop    %ebx
80103d79:	5e                   	pop    %esi
80103d7a:	5d                   	pop    %ebp
80103d7b:	c3                   	ret    
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d80:	01 c6                	add    %eax,%esi
80103d82:	89 74 24 08          	mov    %esi,0x8(%esp)
80103d86:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d8a:	8b 43 04             	mov    0x4(%ebx),%eax
80103d8d:	89 04 24             	mov    %eax,(%esp)
80103d90:	e8 ab 47 00 00       	call   80108540 <allocuvm>
80103d95:	85 c0                	test   %eax,%eax
80103d97:	75 d0                	jne    80103d69 <growproc+0x29>
            return -1;
80103d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d9e:	eb d5                	jmp    80103d75 <growproc+0x35>
        if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da0:	01 c6                	add    %eax,%esi
80103da2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103da6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103daa:	8b 43 04             	mov    0x4(%ebx),%eax
80103dad:	89 04 24             	mov    %eax,(%esp)
80103db0:	e8 bb 48 00 00       	call   80108670 <deallocuvm>
80103db5:	85 c0                	test   %eax,%eax
80103db7:	75 b0                	jne    80103d69 <growproc+0x29>
80103db9:	eb de                	jmp    80103d99 <growproc+0x59>
80103dbb:	90                   	nop
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <fork>:
fork(void) {
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
80103dc9:	e8 22 1e 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
80103dce:	e8 ed fa ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103dd3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80103dd9:	e8 52 1e 00 00       	call   80105c30 <popcli>
    if ((np = allocproc()) == 0) {
80103dde:	e8 6d f9 ff ff       	call   80103750 <allocproc>
80103de3:	85 c0                	test   %eax,%eax
80103de5:	0f 84 48 01 00 00    	je     80103f33 <fork+0x173>
80103deb:	89 c6                	mov    %eax,%esi
    if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0) {
80103ded:	8b 07                	mov    (%edi),%eax
80103def:	89 44 24 04          	mov    %eax,0x4(%esp)
80103df3:	8b 47 04             	mov    0x4(%edi),%eax
80103df6:	89 04 24             	mov    %eax,(%esp)
80103df9:	e8 f2 49 00 00       	call   801087f0 <copyuvm>
80103dfe:	85 c0                	test   %eax,%eax
80103e00:	89 46 04             	mov    %eax,0x4(%esi)
80103e03:	0f 84 31 01 00 00    	je     80103f3a <fork+0x17a>
    np->sz = curproc->sz;
80103e09:	8b 07                	mov    (%edi),%eax
    np->parent = curproc;
80103e0b:	89 7e 14             	mov    %edi,0x14(%esi)
    *np->tf = *curproc->tf;
80103e0e:	8b 56 18             	mov    0x18(%esi),%edx
    np->sz = curproc->sz;
80103e11:	89 06                	mov    %eax,(%esi)
    *np->tf = *curproc->tf;
80103e13:	31 c0                	xor    %eax,%eax
80103e15:	8b 4f 18             	mov    0x18(%edi),%ecx
80103e18:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103e1b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103e1e:	83 c0 04             	add    $0x4,%eax
80103e21:	83 f8 4c             	cmp    $0x4c,%eax
80103e24:	72 f2                	jb     80103e18 <fork+0x58>
    np->tf->eax = 0;
80103e26:	8b 46 18             	mov    0x18(%esi),%eax
    for (i = 0; i < NOFILE; i++)
80103e29:	31 db                	xor    %ebx,%ebx
    np->tf->eax = 0;
80103e2b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if (curproc->ofile[i])
80103e40:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103e44:	85 c0                	test   %eax,%eax
80103e46:	74 0c                	je     80103e54 <fork+0x94>
            np->ofile[i] = filedup(curproc->ofile[i]);
80103e48:	89 04 24             	mov    %eax,(%esp)
80103e4b:	e8 70 cf ff ff       	call   80100dc0 <filedup>
80103e50:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
    for (i = 0; i < NOFILE; i++)
80103e54:	43                   	inc    %ebx
80103e55:	83 fb 10             	cmp    $0x10,%ebx
80103e58:	75 e6                	jne    80103e40 <fork+0x80>
    np->cwd = idup(curproc->cwd);
80103e5a:	8b 47 68             	mov    0x68(%edi),%eax
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e5d:	83 c7 6c             	add    $0x6c,%edi
    np->cwd = idup(curproc->cwd);
80103e60:	89 04 24             	mov    %eax,(%esp)
80103e63:	e8 38 d8 ff ff       	call   801016a0 <idup>
80103e68:	89 46 68             	mov    %eax,0x68(%esi)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e6b:	b8 10 00 00 00       	mov    $0x10,%eax
80103e70:	89 44 24 08          	mov    %eax,0x8(%esp)
80103e74:	8d 46 6c             	lea    0x6c(%esi),%eax
80103e77:	89 7c 24 04          	mov    %edi,0x4(%esp)
    p->retime = 0;
80103e7b:	31 ff                	xor    %edi,%edi
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e7d:	89 04 24             	mov    %eax,(%esp)
80103e80:	e8 1b 21 00 00       	call   80105fa0 <safestrcpy>
    pid = np->pid;
80103e85:	8b 5e 10             	mov    0x10(%esi),%ebx
    acquire(&ptable.lock);
80103e88:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e8f:	e8 3c 1e 00 00       	call   80105cd0 <acquire>
    np->priority = 5;
80103e94:	ba 05 00 00 00       	mov    $0x5,%edx
80103e99:	89 96 88 00 00 00    	mov    %edx,0x88(%esi)
    np->acc = getMinAccumulator();
80103e9f:	e8 ec fa ff ff       	call   80103990 <getMinAccumulator>
    p->stime = 0;
80103ea4:	31 c9                	xor    %ecx,%ecx
80103ea6:	89 8e 9c 00 00 00    	mov    %ecx,0x9c(%esi)
    p->retime = 0;
80103eac:	89 be a0 00 00 00    	mov    %edi,0xa0(%esi)
    np->state = RUNNABLE;
80103eb2:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
    np->acc = getMinAccumulator();
80103eb9:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
    np->ctime = ticks;  //ticks from trap.c
80103ebf:	a1 00 81 11 80       	mov    0x80118100,%eax
    np->acc = getMinAccumulator();
80103ec4:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
    np->idle = tick;
80103eca:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
    np->ctime = ticks;  //ticks from trap.c
80103ed0:	89 86 94 00 00 00    	mov    %eax,0x94(%esi)
    p->oldTick = ticks;
80103ed6:	89 86 a8 00 00 00    	mov    %eax,0xa8(%esi)
    p->rutime = 0;
80103edc:	31 c0                	xor    %eax,%eax
80103ede:	89 86 a4 00 00 00    	mov    %eax,0xa4(%esi)
    np->idle = tick;
80103ee4:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80103ee9:	89 96 90 00 00 00    	mov    %edx,0x90(%esi)
80103eef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
    if (poli == 1) {
80103ef5:	a1 10 c0 10 80       	mov    0x8010c010,%eax
80103efa:	83 f8 01             	cmp    $0x1,%eax
80103efd:	75 21                	jne    80103f20 <fork+0x160>
        rrq.enqueue(np);
80103eff:	89 34 24             	mov    %esi,(%esp)
80103f02:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
    release(&ptable.lock);
80103f08:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f0f:	e8 5c 1e 00 00       	call   80105d70 <release>
}
80103f14:	83 c4 1c             	add    $0x1c,%esp
80103f17:	89 d8                	mov    %ebx,%eax
80103f19:	5b                   	pop    %ebx
80103f1a:	5e                   	pop    %esi
80103f1b:	5f                   	pop    %edi
80103f1c:	5d                   	pop    %ebp
80103f1d:	c3                   	ret    
80103f1e:	66 90                	xchg   %ax,%ax
    } else if (poli == 2 || poli == 3) {
80103f20:	83 e8 02             	sub    $0x2,%eax
80103f23:	83 f8 01             	cmp    $0x1,%eax
80103f26:	77 e0                	ja     80103f08 <fork+0x148>
        pq.put(np);
80103f28:	89 34 24             	mov    %esi,(%esp)
80103f2b:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103f31:	eb d5                	jmp    80103f08 <fork+0x148>
        return -1;
80103f33:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f38:	eb da                	jmp    80103f14 <fork+0x154>
        kfree(np->kstack);
80103f3a:	8b 46 08             	mov    0x8(%esi),%eax
        return -1;
80103f3d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kfree(np->kstack);
80103f42:	89 04 24             	mov    %eax,(%esp)
80103f45:	e8 76 e4 ff ff       	call   801023c0 <kfree>
        np->kstack = 0;
80103f4a:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        np->state = UNUSED;
80103f51:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        return -1;
80103f58:	eb ba                	jmp    80103f14 <fork+0x154>
80103f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f60 <detach>:
int detach(int pid) {
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	56                   	push   %esi
80103f64:	53                   	push   %ebx
80103f65:	83 ec 10             	sub    $0x10,%esp
80103f68:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
80103f6b:	e8 80 1c 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
80103f70:	e8 4b f9 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103f75:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103f7b:	e8 b0 1c 00 00       	call   80105c30 <popcli>
    acquire(&ptable.lock);
80103f80:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f87:	e8 44 1d 00 00       	call   80105cd0 <acquire>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f8c:	ba b4 4d 11 80       	mov    $0x80114db4,%edx
80103f91:	eb 13                	jmp    80103fa6 <detach+0x46>
80103f93:	90                   	nop
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f98:	81 c2 ac 00 00 00    	add    $0xac,%edx
80103f9e:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
80103fa4:	73 32                	jae    80103fd8 <detach+0x78>
        if (p->parent != curproc)
80103fa6:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103fa9:	75 ed                	jne    80103f98 <detach+0x38>
        if (p->pid == pid) {
80103fab:	39 72 10             	cmp    %esi,0x10(%edx)
80103fae:	75 e8                	jne    80103f98 <detach+0x38>
            p->parent = initproc;
80103fb0:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103fb5:	89 42 14             	mov    %eax,0x14(%edx)
            if (p->state == ZOMBIE)
80103fb8:	8b 52 0c             	mov    0xc(%edx),%edx
80103fbb:	83 fa 05             	cmp    $0x5,%edx
80103fbe:	74 30                	je     80103ff0 <detach+0x90>
            release(&ptable.lock);
80103fc0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103fc7:	e8 a4 1d 00 00       	call   80105d70 <release>
}
80103fcc:	83 c4 10             	add    $0x10,%esp
            return 0;
80103fcf:	31 c0                	xor    %eax,%eax
}
80103fd1:	5b                   	pop    %ebx
80103fd2:	5e                   	pop    %esi
80103fd3:	5d                   	pop    %ebp
80103fd4:	c3                   	ret    
80103fd5:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ptable.lock);
80103fd8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103fdf:	e8 8c 1d 00 00       	call   80105d70 <release>
}
80103fe4:	83 c4 10             	add    $0x10,%esp
    return -1;
80103fe7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103fec:	5b                   	pop    %ebx
80103fed:	5e                   	pop    %esi
80103fee:	5d                   	pop    %ebp
80103fef:	c3                   	ret    
                wakeup1(initproc);
80103ff0:	e8 1b fa ff ff       	call   80103a10 <wakeup1>
80103ff5:	eb c9                	jmp    80103fc0 <detach+0x60>
80103ff7:	89 f6                	mov    %esi,%esi
80103ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104000 <priority>:
priority(int pri) {
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	83 ec 18             	sub    $0x18,%esp
80104006:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104009:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010400c:	89 75 fc             	mov    %esi,-0x4(%ebp)
    pushcli();
8010400f:	e8 dc 1b 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
80104014:	e8 a7 f8 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104019:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010401f:	e8 0c 1c 00 00       	call   80105c30 <popcli>
    switch (poli){
80104024:	a1 10 c0 10 80       	mov    0x8010c010,%eax
80104029:	83 f8 02             	cmp    $0x2,%eax
8010402c:	74 42                	je     80104070 <priority+0x70>
8010402e:	83 f8 03             	cmp    $0x3,%eax
80104031:	74 2d                	je     80104060 <priority+0x60>
80104033:	48                   	dec    %eax
80104034:	74 2f                	je     80104065 <priority+0x65>
    acquire(&ptable.lock);
80104036:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010403d:	e8 8e 1c 00 00       	call   80105cd0 <acquire>
    curproc->priority = pri;
80104042:	89 9e 88 00 00 00    	mov    %ebx,0x88(%esi)
}
80104048:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    release(&ptable.lock);
8010404b:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104052:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104055:	89 ec                	mov    %ebp,%esp
80104057:	5d                   	pop    %ebp
    release(&ptable.lock);
80104058:	e9 13 1d 00 00       	jmp    80105d70 <release>
8010405d:	8d 76 00             	lea    0x0(%esi),%esi
            if(pri < 0 || pri > 10)
80104060:	83 fb 0a             	cmp    $0xa,%ebx
80104063:	76 d1                	jbe    80104036 <priority+0x36>
}
80104065:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104068:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010406b:	89 ec                	mov    %ebp,%esp
8010406d:	5d                   	pop    %ebp
8010406e:	c3                   	ret    
8010406f:	90                   	nop
            if(pri < 1 || pri > 10)
80104070:	8d 43 ff             	lea    -0x1(%ebx),%eax
80104073:	83 f8 09             	cmp    $0x9,%eax
80104076:	76 be                	jbe    80104036 <priority+0x36>
80104078:	eb eb                	jmp    80104065 <priority+0x65>
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <policy>:
policy(int pol) {
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 14             	sub    $0x14,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (pol < 1 || pol > 3)
8010408a:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010408d:	83 f8 02             	cmp    $0x2,%eax
80104090:	0f 87 cc 00 00 00    	ja     80104162 <policy+0xe2>
    acquire(&ptable.lock);
80104096:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010409d:	e8 2e 1c 00 00       	call   80105cd0 <acquire>
    switch (pol) {
801040a2:	83 fb 02             	cmp    $0x2,%ebx
801040a5:	74 79                	je     80104120 <policy+0xa0>
801040a7:	83 fb 03             	cmp    $0x3,%ebx
801040aa:	74 44                	je     801040f0 <policy+0x70>
            if(poli == 1)
801040ac:	83 3d 10 c0 10 80 01 	cmpl   $0x1,0x8010c010
801040b3:	74 52                	je     80104107 <policy+0x87>
            if (!pq.switchToRoundRobinPolicy())
801040b5:	ff 15 ec c5 10 80    	call   *0x8010c5ec
801040bb:	85 c0                	test   %eax,%eax
801040bd:	0f 84 ab 00 00 00    	je     8010416e <policy+0xee>
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040c3:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801040c8:	90                   	nop
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                p->acc = 0;
801040d0:	31 d2                	xor    %edx,%edx
801040d2:	31 c9                	xor    %ecx,%ecx
801040d4:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040da:	05 ac 00 00 00       	add    $0xac,%eax
                p->acc = 0;
801040df:	89 48 d8             	mov    %ecx,-0x28(%eax)
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040e2:	3d b4 78 11 80       	cmp    $0x801178b4,%eax
801040e7:	72 e7                	jb     801040d0 <policy+0x50>
801040e9:	eb 1c                	jmp    80104107 <policy+0x87>
801040eb:	90                   	nop
801040ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(poli == 3 || poli==2)
801040f0:	a1 10 c0 10 80       	mov    0x8010c010,%eax
801040f5:	83 e8 02             	sub    $0x2,%eax
801040f8:	83 f8 01             	cmp    $0x1,%eax
801040fb:	76 0a                	jbe    80104107 <policy+0x87>
                if (!rrq.switchToPriorityQueuePolicy())
801040fd:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80104103:	85 c0                	test   %eax,%eax
80104105:	74 4f                	je     80104156 <policy+0xd6>
    poli = pol;
80104107:	89 1d 10 c0 10 80    	mov    %ebx,0x8010c010
    release(&ptable.lock);
8010410d:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104114:	83 c4 14             	add    $0x14,%esp
80104117:	5b                   	pop    %ebx
80104118:	5d                   	pop    %ebp
    release(&ptable.lock);
80104119:	e9 52 1c 00 00       	jmp    80105d70 <release>
8010411e:	66 90                	xchg   %ax,%ax
            if(poli == 2)
80104120:	8b 15 10 c0 10 80    	mov    0x8010c010,%edx
80104126:	83 fa 02             	cmp    $0x2,%edx
80104129:	74 dc                	je     80104107 <policy+0x87>
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010412b:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
                if (p->priority == 0)
80104130:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104136:	85 c9                	test   %ecx,%ecx
80104138:	75 0b                	jne    80104145 <policy+0xc5>
                    p->priority = 1;
8010413a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010413f:	89 88 88 00 00 00    	mov    %ecx,0x88(%eax)
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104145:	05 ac 00 00 00       	add    $0xac,%eax
8010414a:	3d b4 78 11 80       	cmp    $0x801178b4,%eax
8010414f:	72 df                	jb     80104130 <policy+0xb0>
            if(poli==1)
80104151:	4a                   	dec    %edx
80104152:	74 a9                	je     801040fd <policy+0x7d>
80104154:	eb b1                	jmp    80104107 <policy+0x87>
                panic("Can't switch to Priority Queue policy");
80104156:	c7 04 24 cc 90 10 80 	movl   $0x801090cc,(%esp)
8010415d:	e8 0e c2 ff ff       	call   80100370 <panic>
        panic("Illegal policy number");
80104162:	c7 04 24 c0 8f 10 80 	movl   $0x80108fc0,(%esp)
80104169:	e8 02 c2 ff ff       	call   80100370 <panic>
                panic("Can't switch to Round Robin policy");
8010416e:	c7 04 24 a8 90 10 80 	movl   $0x801090a8,(%esp)
80104175:	e8 f6 c1 ff ff       	call   80100370 <panic>
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104180 <run_process>:
void run_process(struct cpu *c, struct proc *p) {
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	56                   	push   %esi
80104184:	53                   	push   %ebx
80104185:	83 ec 10             	sub    $0x10,%esp
80104188:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010418b:	8b 75 08             	mov    0x8(%ebp),%esi
    c->proc = p;
8010418e:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
    switchuvm(p);
80104194:	89 1c 24             	mov    %ebx,(%esp)
80104197:	e8 54 41 00 00       	call   801082f0 <switchuvm>
    updatePerformance(p, ticks);
8010419c:	8b 15 00 81 11 80    	mov    0x80118100,%edx
    int time = ticks - p->oldTick;
801041a2:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
801041a8:	89 d1                	mov    %edx,%ecx
801041aa:	29 c1                	sub    %eax,%ecx
    switch (p->state) {
801041ac:	8b 43 0c             	mov    0xc(%ebx),%eax
801041af:	83 f8 03             	cmp    $0x3,%eax
801041b2:	74 6c                	je     80104220 <run_process+0xa0>
801041b4:	83 f8 04             	cmp    $0x4,%eax
801041b7:	74 57                	je     80104210 <run_process+0x90>
801041b9:	83 f8 02             	cmp    $0x2,%eax
801041bc:	74 3a                	je     801041f8 <run_process+0x78>
    p->state = RUNNING;
801041be:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    rpholder.add(p);
801041c5:	89 1c 24             	mov    %ebx,(%esp)
801041c8:	ff 15 c0 c5 10 80    	call   *0x8010c5c0
    swtch(&(c->scheduler), p->context);
801041ce:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041d1:	89 44 24 04          	mov    %eax,0x4(%esp)
801041d5:	8d 46 04             	lea    0x4(%esi),%eax
801041d8:	89 04 24             	mov    %eax,(%esp)
801041db:	e8 19 1e 00 00       	call   80105ff9 <swtch>
    switchkvm();
801041e0:	e8 eb 40 00 00       	call   801082d0 <switchkvm>
    c->proc = 0;
801041e5:	31 c0                	xor    %eax,%eax
801041e7:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
}
801041ed:	83 c4 10             	add    $0x10,%esp
801041f0:	5b                   	pop    %ebx
801041f1:	5e                   	pop    %esi
801041f2:	5d                   	pop    %ebp
801041f3:	c3                   	ret    
801041f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            p->stime += time;
801041f8:	01 8b 9c 00 00 00    	add    %ecx,0x9c(%ebx)
        p->oldTick = ticks;
801041fe:	89 93 a8 00 00 00    	mov    %edx,0xa8(%ebx)
80104204:	eb b8                	jmp    801041be <run_process+0x3e>
80104206:	8d 76 00             	lea    0x0(%esi),%esi
80104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            p->rutime += time;
80104210:	01 8b a4 00 00 00    	add    %ecx,0xa4(%ebx)
80104216:	eb e6                	jmp    801041fe <run_process+0x7e>
80104218:	90                   	nop
80104219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            p->retime += time;
80104220:	01 8b a0 00 00 00    	add    %ecx,0xa0(%ebx)
80104226:	eb d6                	jmp    801041fe <run_process+0x7e>
80104228:	90                   	nop
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104230 <getLongestIdleProc>:
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104230:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104235:	eb 17                	jmp    8010424e <getLongestIdleProc+0x1e>
80104237:	89 f6                	mov    %esi,%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104240:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
80104246:	89 d0                	mov    %edx,%eax
80104248:	0f 83 9a 00 00 00    	jae    801042e8 <getLongestIdleProc+0xb8>
        if (p->state == RUNNABLE) 
8010424e:	8b 48 0c             	mov    0xc(%eax),%ecx
80104251:	8d 90 ac 00 00 00    	lea    0xac(%eax),%edx
80104257:	83 f9 03             	cmp    $0x3,%ecx
8010425a:	75 e4                	jne    80104240 <getLongestIdleProc+0x10>
    for (p=p+1;p < &ptable.proc[NPROC]; p++) 
8010425c:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
80104262:	72 1a                	jb     8010427e <getLongestIdleProc+0x4e>
80104264:	e9 8f 00 00 00       	jmp    801042f8 <getLongestIdleProc+0xc8>
80104269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104270:	81 c2 ac 00 00 00    	add    $0xac,%edx
80104276:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
8010427c:	73 62                	jae    801042e0 <getLongestIdleProc+0xb0>
        if (p->state == RUNNABLE)
8010427e:	8b 4a 0c             	mov    0xc(%edx),%ecx
80104281:	83 f9 03             	cmp    $0x3,%ecx
80104284:	75 ea                	jne    80104270 <getLongestIdleProc+0x40>
getLongestIdleProc(void) {
80104286:	55                   	push   %ebp
80104287:	89 e5                	mov    %esp,%ebp
80104289:	53                   	push   %ebx
            if (p->idle < max->idle) 
8010428a:	8b 98 90 00 00 00    	mov    0x90(%eax),%ebx
80104290:	39 9a 90 00 00 00    	cmp    %ebx,0x90(%edx)
80104296:	8b 8a 8c 00 00 00    	mov    0x8c(%edx),%ecx
8010429c:	7c 3a                	jl     801042d8 <getLongestIdleProc+0xa8>
8010429e:	7e 30                	jle    801042d0 <getLongestIdleProc+0xa0>
    for (p=p+1;p < &ptable.proc[NPROC]; p++) 
801042a0:	81 c2 ac 00 00 00    	add    $0xac,%edx
801042a6:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
801042ac:	73 16                	jae    801042c4 <getLongestIdleProc+0x94>
        if (p->state == RUNNABLE)
801042ae:	8b 4a 0c             	mov    0xc(%edx),%ecx
801042b1:	83 f9 03             	cmp    $0x3,%ecx
801042b4:	74 d4                	je     8010428a <getLongestIdleProc+0x5a>
    for (p=p+1;p < &ptable.proc[NPROC]; p++) 
801042b6:	81 c2 ac 00 00 00    	add    $0xac,%edx
801042bc:	81 fa b4 78 11 80    	cmp    $0x801178b4,%edx
801042c2:	72 ea                	jb     801042ae <getLongestIdleProc+0x7e>
}
801042c4:	5b                   	pop    %ebx
801042c5:	5d                   	pop    %ebp
801042c6:	c3                   	ret    
801042c7:	89 f6                	mov    %esi,%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if (p->idle < max->idle) 
801042d0:	3b 88 8c 00 00 00    	cmp    0x8c(%eax),%ecx
801042d6:	73 c8                	jae    801042a0 <getLongestIdleProc+0x70>
801042d8:	89 d0                	mov    %edx,%eax
801042da:	eb c4                	jmp    801042a0 <getLongestIdleProc+0x70>
801042dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
801042e0:	c3                   	ret    
801042e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(!max)return 0;
801042e8:	31 c0                	xor    %eax,%eax
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042f0:	c3                   	ret    
801042f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f8:	90                   	nop
801042f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104300:	c3                   	ret    
80104301:	eb 0d                	jmp    80104310 <scheduler>
80104303:	90                   	nop
80104304:	90                   	nop
80104305:	90                   	nop
80104306:	90                   	nop
80104307:	90                   	nop
80104308:	90                   	nop
80104309:	90                   	nop
8010430a:	90                   	nop
8010430b:	90                   	nop
8010430c:	90                   	nop
8010430d:	90                   	nop
8010430e:	90                   	nop
8010430f:	90                   	nop

80104310 <scheduler>:
scheduler(void) {
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
80104315:	83 ec 10             	sub    $0x10,%esp
    struct cpu *c = mycpu();
80104318:	e8 a3 f5 ff ff       	call   801038c0 <mycpu>
    c->proc = 0;
8010431d:	31 c9                	xor    %ecx,%ecx
    struct cpu *c = mycpu();
8010431f:	89 c3                	mov    %eax,%ebx
    c->proc = 0;
80104321:	89 88 ac 00 00 00    	mov    %ecx,0xac(%eax)
80104327:	eb 35                	jmp    8010435e <scheduler+0x4e>
80104329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (rrq.isEmpty()) {
80104330:	ff 15 cc c5 10 80    	call   *0x8010c5cc
80104336:	85 c0                	test   %eax,%eax
80104338:	75 18                	jne    80104352 <scheduler+0x42>
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            p = rrq.dequeue();
80104340:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
            run_process(c, p);
80104346:	89 1c 24             	mov    %ebx,(%esp)
80104349:	89 44 24 04          	mov    %eax,0x4(%esp)
8010434d:	e8 2e fe ff ff       	call   80104180 <run_process>
                        release(&ptable.lock);
80104352:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104359:	e8 12 1a 00 00       	call   80105d70 <release>
  asm volatile("sti");
8010435e:	fb                   	sti    
        acquire(&ptable.lock);
8010435f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104366:	e8 65 19 00 00       	call   80105cd0 <acquire>
        if (poli == 1) {
8010436b:	a1 10 c0 10 80       	mov    0x8010c010,%eax
80104370:	83 f8 01             	cmp    $0x1,%eax
80104373:	74 bb                	je     80104330 <scheduler+0x20>
        } else if (poli == 2 || poli == 3) {
80104375:	83 e8 02             	sub    $0x2,%eax
80104378:	83 f8 01             	cmp    $0x1,%eax
8010437b:	77 d5                	ja     80104352 <scheduler+0x42>
            if (pq.isEmpty()) {
8010437d:	ff 15 dc c5 10 80    	call   *0x8010c5dc
80104383:	85 c0                	test   %eax,%eax
80104385:	75 cb                	jne    80104352 <scheduler+0x42>
            if (poli == 3) {
80104387:	83 3d 10 c0 10 80 03 	cmpl   $0x3,0x8010c010
8010438e:	74 18                	je     801043a8 <scheduler+0x98>
            p = pq.extractMin();
80104390:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
            run_process(c, p);
80104396:	89 1c 24             	mov    %ebx,(%esp)
80104399:	89 44 24 04          	mov    %eax,0x4(%esp)
8010439d:	e8 de fd ff ff       	call   80104180 <run_process>
801043a2:	eb ae                	jmp    80104352 <scheduler+0x42>
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                if (tick % 100 == 0) {
801043a8:	31 d2                	xor    %edx,%edx
801043aa:	b8 64 00 00 00       	mov    $0x64,%eax
801043af:	89 44 24 08          	mov    %eax,0x8(%esp)
801043b3:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801043b8:	89 54 24 0c          	mov    %edx,0xc(%esp)
801043bc:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
801043c2:	89 04 24             	mov    %eax,(%esp)
801043c5:	89 54 24 04          	mov    %edx,0x4(%esp)
801043c9:	e8 b2 15 00 00       	call   80105980 <__moddi3>
801043ce:	09 c2                	or     %eax,%edx
801043d0:	75 be                	jne    80104390 <scheduler+0x80>
                    p = getLongestIdleProc();
801043d2:	e8 59 fe ff ff       	call   80104230 <getLongestIdleProc>
                    if (p) {
801043d7:	85 c0                	test   %eax,%eax
                    p = getLongestIdleProc();
801043d9:	89 c6                	mov    %eax,%esi
                    if (p) {
801043db:	74 b3                	je     80104390 <scheduler+0x80>
                       pq.extractProc(p);
801043dd:	89 04 24             	mov    %eax,(%esp)
801043e0:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                        run_process(c, p);
801043e6:	89 74 24 04          	mov    %esi,0x4(%esp)
801043ea:	89 1c 24             	mov    %ebx,(%esp)
801043ed:	e8 8e fd ff ff       	call   80104180 <run_process>
801043f2:	e9 5b ff ff ff       	jmp    80104352 <scheduler+0x42>
801043f7:	89 f6                	mov    %esi,%esi
801043f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104400 <sched>:
sched(void) {
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	83 ec 10             	sub    $0x10,%esp
    pushcli();
80104408:	e8 e3 17 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
8010440d:	e8 ae f4 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104412:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104418:	e8 13 18 00 00       	call   80105c30 <popcli>
    if (!holding(&ptable.lock))
8010441d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104424:	e8 67 18 00 00       	call   80105c90 <holding>
80104429:	85 c0                	test   %eax,%eax
8010442b:	74 51                	je     8010447e <sched+0x7e>
    if (mycpu()->ncli != 1)
8010442d:	e8 8e f4 ff ff       	call   801038c0 <mycpu>
80104432:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104439:	75 67                	jne    801044a2 <sched+0xa2>
    if (p->state == RUNNING)
8010443b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010443e:	83 f8 04             	cmp    $0x4,%eax
80104441:	74 53                	je     80104496 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104443:	9c                   	pushf  
80104444:	58                   	pop    %eax
    if (readeflags() & FL_IF)
80104445:	f6 c4 02             	test   $0x2,%ah
80104448:	75 40                	jne    8010448a <sched+0x8a>
    intena = mycpu()->intena;
8010444a:	e8 71 f4 ff ff       	call   801038c0 <mycpu>
    swtch(&p->context, mycpu()->scheduler);
8010444f:	83 c3 1c             	add    $0x1c,%ebx
    intena = mycpu()->intena;
80104452:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&p->context, mycpu()->scheduler);
80104458:	e8 63 f4 ff ff       	call   801038c0 <mycpu>
8010445d:	8b 40 04             	mov    0x4(%eax),%eax
80104460:	89 1c 24             	mov    %ebx,(%esp)
80104463:	89 44 24 04          	mov    %eax,0x4(%esp)
80104467:	e8 8d 1b 00 00       	call   80105ff9 <swtch>
    mycpu()->intena = intena;
8010446c:	e8 4f f4 ff ff       	call   801038c0 <mycpu>
80104471:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104477:	83 c4 10             	add    $0x10,%esp
8010447a:	5b                   	pop    %ebx
8010447b:	5e                   	pop    %esi
8010447c:	5d                   	pop    %ebp
8010447d:	c3                   	ret    
        panic("sched ptable.lock");
8010447e:	c7 04 24 d6 8f 10 80 	movl   $0x80108fd6,(%esp)
80104485:	e8 e6 be ff ff       	call   80100370 <panic>
        panic("sched interruptible");
8010448a:	c7 04 24 02 90 10 80 	movl   $0x80109002,(%esp)
80104491:	e8 da be ff ff       	call   80100370 <panic>
        panic("sched running");
80104496:	c7 04 24 f4 8f 10 80 	movl   $0x80108ff4,(%esp)
8010449d:	e8 ce be ff ff       	call   80100370 <panic>
        panic("sched locks");
801044a2:	c7 04 24 e8 8f 10 80 	movl   $0x80108fe8,(%esp)
801044a9:	e8 c2 be ff ff       	call   80100370 <panic>
801044ae:	66 90                	xchg   %ax,%ax

801044b0 <exit>:
exit(int status) {
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	57                   	push   %edi
801044b4:	56                   	push   %esi
801044b5:	53                   	push   %ebx
801044b6:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
801044b9:	e8 32 17 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
801044be:	e8 fd f3 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801044c3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801044c9:	e8 62 17 00 00       	call   80105c30 <popcli>
    if (curproc == initproc)
801044ce:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
801044d4:	0f 84 0e 01 00 00    	je     801045e8 <exit+0x138>
801044da:	8d 5e 28             	lea    0x28(%esi),%ebx
801044dd:	8d 7e 68             	lea    0x68(%esi),%edi
        if (curproc->ofile[fd]) {
801044e0:	8b 03                	mov    (%ebx),%eax
801044e2:	85 c0                	test   %eax,%eax
801044e4:	74 0e                	je     801044f4 <exit+0x44>
            fileclose(curproc->ofile[fd]);
801044e6:	89 04 24             	mov    %eax,(%esp)
801044e9:	e8 22 c9 ff ff       	call   80100e10 <fileclose>
            curproc->ofile[fd] = 0;
801044ee:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801044f4:	83 c3 04             	add    $0x4,%ebx
    for (fd = 0; fd < NOFILE; fd++) {
801044f7:	39 df                	cmp    %ebx,%edi
801044f9:	75 e5                	jne    801044e0 <exit+0x30>
    begin_op();
801044fb:	e8 70 e7 ff ff       	call   80102c70 <begin_op>
    iput(curproc->cwd);
80104500:	8b 46 68             	mov    0x68(%esi),%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104503:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
    iput(curproc->cwd);
80104508:	89 04 24             	mov    %eax,(%esp)
8010450b:	e8 f0 d2 ff ff       	call   80101800 <iput>
    end_op();
80104510:	e8 cb e7 ff ff       	call   80102ce0 <end_op>
    curproc->status = status;
80104515:	8b 45 08             	mov    0x8(%ebp),%eax
    curproc->cwd = 0;
80104518:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
    curproc->status = status;
8010451f:	89 46 7c             	mov    %eax,0x7c(%esi)
    acquire(&ptable.lock);
80104522:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104529:	e8 a2 17 00 00       	call   80105cd0 <acquire>
    curproc->ttime = ticks;
8010452e:	a1 00 81 11 80       	mov    0x80118100,%eax
80104533:	89 86 98 00 00 00    	mov    %eax,0x98(%esi)
    rpholder.remove(curproc);
80104539:	89 34 24             	mov    %esi,(%esp)
8010453c:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
    wakeup1(curproc->parent);
80104542:	8b 46 14             	mov    0x14(%esi),%eax
80104545:	e8 c6 f4 ff ff       	call   80103a10 <wakeup1>
8010454a:	eb 12                	jmp    8010455e <exit+0xae>
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104550:	81 c3 ac 00 00 00    	add    $0xac,%ebx
80104556:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
8010455c:	73 32                	jae    80104590 <exit+0xe0>
        if (p->parent == curproc) {
8010455e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104561:	75 ed                	jne    80104550 <exit+0xa0>
            if (p->state == ZOMBIE)
80104563:	8b 53 0c             	mov    0xc(%ebx),%edx
            p->parent = initproc;
80104566:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
            if (p->state == ZOMBIE)
8010456b:	83 fa 05             	cmp    $0x5,%edx
            p->parent = initproc;
8010456e:	89 43 14             	mov    %eax,0x14(%ebx)
            if (p->state == ZOMBIE)
80104571:	75 dd                	jne    80104550 <exit+0xa0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104573:	81 c3 ac 00 00 00    	add    $0xac,%ebx
                wakeup1(initproc);
80104579:	e8 92 f4 ff ff       	call   80103a10 <wakeup1>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010457e:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
80104584:	72 d8                	jb     8010455e <exit+0xae>
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    updatePerformance(curproc, ticks);
80104590:	8b 15 00 81 11 80    	mov    0x80118100,%edx
    int time = ticks - p->oldTick;
80104596:	8b 86 a8 00 00 00    	mov    0xa8(%esi),%eax
8010459c:	89 d1                	mov    %edx,%ecx
8010459e:	29 c1                	sub    %eax,%ecx
    switch (p->state) {
801045a0:	8b 46 0c             	mov    0xc(%esi),%eax
801045a3:	83 f8 03             	cmp    $0x3,%eax
801045a6:	74 38                	je     801045e0 <exit+0x130>
801045a8:	83 f8 04             	cmp    $0x4,%eax
801045ab:	74 1d                	je     801045ca <exit+0x11a>
801045ad:	83 f8 02             	cmp    $0x2,%eax
801045b0:	74 26                	je     801045d8 <exit+0x128>
    curproc->state = ZOMBIE;
801045b2:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    sched();
801045b9:	e8 42 fe ff ff       	call   80104400 <sched>
    panic("zombie exit");
801045be:	c7 04 24 23 90 10 80 	movl   $0x80109023,(%esp)
801045c5:	e8 a6 bd ff ff       	call   80100370 <panic>
            p->rutime += time;
801045ca:	01 8e a4 00 00 00    	add    %ecx,0xa4(%esi)
        p->oldTick = ticks;
801045d0:	89 96 a8 00 00 00    	mov    %edx,0xa8(%esi)
801045d6:	eb da                	jmp    801045b2 <exit+0x102>
            p->stime += time;
801045d8:	01 8e 9c 00 00 00    	add    %ecx,0x9c(%esi)
801045de:	eb f0                	jmp    801045d0 <exit+0x120>
            p->retime += time;
801045e0:	01 8e a0 00 00 00    	add    %ecx,0xa0(%esi)
801045e6:	eb e8                	jmp    801045d0 <exit+0x120>
        panic("init exiting");
801045e8:	c7 04 24 16 90 10 80 	movl   $0x80109016,(%esp)
801045ef:	e8 7c bd ff ff       	call   80100370 <panic>
801045f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104600 <yield>:
yield(void) {
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
80104604:	83 ec 14             	sub    $0x14,%esp
    pushcli();
80104607:	e8 e4 15 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
8010460c:	e8 af f2 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104611:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104617:	e8 14 16 00 00       	call   80105c30 <popcli>
    acquire(&ptable.lock);  //DOC: yieldlock
8010461c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104623:	e8 a8 16 00 00       	call   80105cd0 <acquire>
    updatePerformance(p, ticks);
80104628:	8b 15 00 81 11 80    	mov    0x80118100,%edx
    int time = ticks - p->oldTick;
8010462e:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80104634:	89 d1                	mov    %edx,%ecx
80104636:	29 c1                	sub    %eax,%ecx
    switch (p->state) {
80104638:	8b 43 0c             	mov    0xc(%ebx),%eax
8010463b:	83 f8 03             	cmp    $0x3,%eax
8010463e:	0f 84 cc 00 00 00    	je     80104710 <yield+0x110>
80104644:	83 f8 04             	cmp    $0x4,%eax
80104647:	0f 84 b3 00 00 00    	je     80104700 <yield+0x100>
8010464d:	83 f8 02             	cmp    $0x2,%eax
80104650:	74 7e                	je     801046d0 <yield+0xd0>
    p->acc += p->priority;
80104652:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
    p->state = RUNNABLE;
80104658:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    p->acc += p->priority;
8010465f:	99                   	cltd   
80104660:	01 83 80 00 00 00    	add    %eax,0x80(%ebx)
80104666:	11 93 84 00 00 00    	adc    %edx,0x84(%ebx)
    rpholder.remove(p);
8010466c:	89 1c 24             	mov    %ebx,(%esp)
8010466f:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
    tick++;
80104675:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010467a:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
80104680:	83 c0 01             	add    $0x1,%eax
80104683:	a3 08 c0 10 80       	mov    %eax,0x8010c008
80104688:	83 d2 00             	adc    $0x0,%edx
    p->idle = tick;
8010468b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
    if (poli == 1) {
80104691:	a1 10 c0 10 80       	mov    0x8010c010,%eax
    tick++;
80104696:	89 15 0c c0 10 80    	mov    %edx,0x8010c00c
    p->idle = tick;
8010469c:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
    if (poli == 1) {
801046a2:	83 f8 01             	cmp    $0x1,%eax
801046a5:	75 41                	jne    801046e8 <yield+0xe8>
        rrq.enqueue(p);
801046a7:	89 1c 24             	mov    %ebx,(%esp)
801046aa:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
    sched();
801046b0:	e8 4b fd ff ff       	call   80104400 <sched>
    release(&ptable.lock);
801046b5:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801046bc:	e8 af 16 00 00       	call   80105d70 <release>
}
801046c1:	83 c4 14             	add    $0x14,%esp
801046c4:	5b                   	pop    %ebx
801046c5:	5d                   	pop    %ebp
801046c6:	c3                   	ret    
801046c7:	89 f6                	mov    %esi,%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            p->stime += time;
801046d0:	01 8b 9c 00 00 00    	add    %ecx,0x9c(%ebx)
        p->oldTick = ticks;
801046d6:	89 93 a8 00 00 00    	mov    %edx,0xa8(%ebx)
801046dc:	e9 71 ff ff ff       	jmp    80104652 <yield+0x52>
801046e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if (poli == 2 || poli == 3) {
801046e8:	83 e8 02             	sub    $0x2,%eax
801046eb:	83 f8 01             	cmp    $0x1,%eax
801046ee:	77 c0                	ja     801046b0 <yield+0xb0>
        pq.put(p);
801046f0:	89 1c 24             	mov    %ebx,(%esp)
801046f3:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
801046f9:	eb b5                	jmp    801046b0 <yield+0xb0>
801046fb:	90                   	nop
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            p->rutime += time;
80104700:	01 8b a4 00 00 00    	add    %ecx,0xa4(%ebx)
80104706:	eb ce                	jmp    801046d6 <yield+0xd6>
80104708:	90                   	nop
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            p->retime += time;
80104710:	01 8b a0 00 00 00    	add    %ecx,0xa0(%ebx)
80104716:	eb be                	jmp    801046d6 <yield+0xd6>
80104718:	90                   	nop
80104719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104720 <sleep>:
sleep(void *chan, struct spinlock *lk) {
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	83 ec 28             	sub    $0x28,%esp
80104726:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104729:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010472c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010472f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104732:	8b 7d 08             	mov    0x8(%ebp),%edi
    pushcli();
80104735:	e8 b6 14 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
8010473a:	e8 81 f1 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
8010473f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104745:	e8 e6 14 00 00       	call   80105c30 <popcli>
    if (p == 0)
8010474a:	85 db                	test   %ebx,%ebx
8010474c:	0f 84 0e 01 00 00    	je     80104860 <sleep+0x140>
    if (lk == 0)
80104752:	85 f6                	test   %esi,%esi
80104754:	0f 84 12 01 00 00    	je     8010486c <sleep+0x14c>
    if (lk != &ptable.lock) {  //DOC: sleeplock0
8010475a:	81 fe 80 4d 11 80    	cmp    $0x80114d80,%esi
80104760:	0f 84 c2 00 00 00    	je     80104828 <sleep+0x108>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104766:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010476d:	e8 5e 15 00 00       	call   80105cd0 <acquire>
        release(lk);
80104772:	89 34 24             	mov    %esi,(%esp)
80104775:	e8 f6 15 00 00       	call   80105d70 <release>
    updatePerformance(p, ticks);
8010477a:	a1 00 81 11 80       	mov    0x80118100,%eax
    p->chan = chan;
8010477f:	89 7b 20             	mov    %edi,0x20(%ebx)
    switch (p->state) {
80104782:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    int time = ticks - p->oldTick;
80104785:	8b bb a8 00 00 00    	mov    0xa8(%ebx),%edi
8010478b:	89 c2                	mov    %eax,%edx
8010478d:	29 fa                	sub    %edi,%edx
    switch (p->state) {
8010478f:	83 f9 03             	cmp    $0x3,%ecx
80104792:	74 54                	je     801047e8 <sleep+0xc8>
80104794:	83 f9 04             	cmp    $0x4,%ecx
80104797:	0f 84 bb 00 00 00    	je     80104858 <sleep+0x138>
8010479d:	83 f9 02             	cmp    $0x2,%ecx
801047a0:	0f 84 a6 00 00 00    	je     8010484c <sleep+0x12c>
    p->state = SLEEPING;
801047a6:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    rpholder.remove(p);
801047ad:	89 1c 24             	mov    %ebx,(%esp)
801047b0:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
    sched();
801047b6:	e8 45 fc ff ff       	call   80104400 <sched>
    p->chan = 0;
801047bb:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
        release(&ptable.lock);
801047c2:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047c9:	e8 a2 15 00 00       	call   80105d70 <release>
}
801047ce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        acquire(lk);
801047d1:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047d7:	8b 75 f8             	mov    -0x8(%ebp),%esi
801047da:	89 ec                	mov    %ebp,%esp
801047dc:	5d                   	pop    %ebp
        acquire(lk);
801047dd:	e9 ee 14 00 00       	jmp    80105cd0 <acquire>
801047e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            p->retime += time;
801047e8:	01 93 a0 00 00 00    	add    %edx,0xa0(%ebx)
        p->oldTick = ticks;
801047ee:	89 83 a8 00 00 00    	mov    %eax,0xa8(%ebx)
    p->state = SLEEPING;
801047f4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    rpholder.remove(p);
801047fb:	89 1c 24             	mov    %ebx,(%esp)
801047fe:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
    sched();
80104804:	e8 f7 fb ff ff       	call   80104400 <sched>
    if (lk != &ptable.lock) {  //DOC: sleeplock2
80104809:	81 fe 80 4d 11 80    	cmp    $0x80114d80,%esi
    p->chan = 0;
8010480f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    if (lk != &ptable.lock) {  //DOC: sleeplock2
80104816:	75 aa                	jne    801047c2 <sleep+0xa2>
}
80104818:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010481b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010481e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104821:	89 ec                	mov    %ebp,%esp
80104823:	5d                   	pop    %ebp
80104824:	c3                   	ret    
80104825:	8d 76 00             	lea    0x0(%esi),%esi
    updatePerformance(p, ticks);
80104828:	a1 00 81 11 80       	mov    0x80118100,%eax
    int time = ticks - p->oldTick;
8010482d:	8b 8b a8 00 00 00    	mov    0xa8(%ebx),%ecx
    p->chan = chan;
80104833:	89 7b 20             	mov    %edi,0x20(%ebx)
    int time = ticks - p->oldTick;
80104836:	89 c2                	mov    %eax,%edx
80104838:	29 ca                	sub    %ecx,%edx
    switch (p->state) {
8010483a:	8b 4b 0c             	mov    0xc(%ebx),%ecx
8010483d:	83 f9 03             	cmp    $0x3,%ecx
80104840:	74 a6                	je     801047e8 <sleep+0xc8>
80104842:	83 f9 04             	cmp    $0x4,%ecx
80104845:	74 11                	je     80104858 <sleep+0x138>
80104847:	83 f9 02             	cmp    $0x2,%ecx
8010484a:	75 a8                	jne    801047f4 <sleep+0xd4>
            p->stime += time;
8010484c:	01 93 9c 00 00 00    	add    %edx,0x9c(%ebx)
80104852:	eb 9a                	jmp    801047ee <sleep+0xce>
80104854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            p->rutime += time;
80104858:	01 93 a4 00 00 00    	add    %edx,0xa4(%ebx)
8010485e:	eb 8e                	jmp    801047ee <sleep+0xce>
        panic("sleep");
80104860:	c7 04 24 2f 90 10 80 	movl   $0x8010902f,(%esp)
80104867:	e8 04 bb ff ff       	call   80100370 <panic>
        panic("sleep without lk");
8010486c:	c7 04 24 35 90 10 80 	movl   $0x80109035,(%esp)
80104873:	e8 f8 ba ff ff       	call   80100370 <panic>
80104878:	90                   	nop
80104879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104880 <wait>:
wait(int *status) {
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	56                   	push   %esi
80104885:	53                   	push   %ebx
80104886:	83 ec 1c             	sub    $0x1c,%esp
80104889:	8b 7d 08             	mov    0x8(%ebp),%edi
    pushcli();
8010488c:	e8 5f 13 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
80104891:	e8 2a f0 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104896:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010489c:	e8 8f 13 00 00       	call   80105c30 <popcli>
    acquire(&ptable.lock);
801048a1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801048a8:	e8 23 14 00 00       	call   80105cd0 <acquire>
        havekids = 0;
801048ad:	31 c0                	xor    %eax,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048af:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801048b4:	eb 18                	jmp    801048ce <wait+0x4e>
801048b6:	8d 76 00             	lea    0x0(%esi),%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048c0:	81 c3 ac 00 00 00    	add    $0xac,%ebx
801048c6:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
801048cc:	73 20                	jae    801048ee <wait+0x6e>
            if (p->parent != curproc)
801048ce:	39 73 14             	cmp    %esi,0x14(%ebx)
801048d1:	75 ed                	jne    801048c0 <wait+0x40>
            if (p->state == ZOMBIE) {
801048d3:	8b 43 0c             	mov    0xc(%ebx),%eax
801048d6:	83 f8 05             	cmp    $0x5,%eax
801048d9:	74 35                	je     80104910 <wait+0x90>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048db:	81 c3 ac 00 00 00    	add    $0xac,%ebx
            havekids = 1;
801048e1:	b8 01 00 00 00       	mov    $0x1,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048e6:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
801048ec:	72 e0                	jb     801048ce <wait+0x4e>
        if (!havekids || curproc->killed) {
801048ee:	85 c0                	test   %eax,%eax
801048f0:	74 7d                	je     8010496f <wait+0xef>
801048f2:	8b 56 24             	mov    0x24(%esi),%edx
801048f5:	85 d2                	test   %edx,%edx
801048f7:	75 76                	jne    8010496f <wait+0xef>
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801048f9:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
801048fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80104902:	89 34 24             	mov    %esi,(%esp)
80104905:	e8 16 fe ff ff       	call   80104720 <sleep>
        havekids = 0;
8010490a:	eb a1                	jmp    801048ad <wait+0x2d>
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                kfree(p->kstack);
80104910:	8b 43 08             	mov    0x8(%ebx),%eax
                pid = p->pid;
80104913:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104916:	89 04 24             	mov    %eax,(%esp)
80104919:	e8 a2 da ff ff       	call   801023c0 <kfree>
                freevm(p->pgdir);
8010491e:	8b 43 04             	mov    0x4(%ebx),%eax
                p->kstack = 0;
80104921:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104928:	89 04 24             	mov    %eax,(%esp)
8010492b:	e8 70 3d 00 00       	call   801086a0 <freevm>
                if (status)
80104930:	85 ff                	test   %edi,%edi
                p->pid = 0;
80104932:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104939:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
80104940:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
80104944:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                if (status)
8010494b:	74 05                	je     80104952 <wait+0xd2>
                    *status = p->status;
8010494d:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104950:	89 07                	mov    %eax,(%edi)
                release(&ptable.lock);
80104952:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
                p->state = UNUSED;
80104959:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                release(&ptable.lock);
80104960:	e8 0b 14 00 00       	call   80105d70 <release>
}
80104965:	83 c4 1c             	add    $0x1c,%esp
80104968:	89 f0                	mov    %esi,%eax
8010496a:	5b                   	pop    %ebx
8010496b:	5e                   	pop    %esi
8010496c:	5f                   	pop    %edi
8010496d:	5d                   	pop    %ebp
8010496e:	c3                   	ret    
            release(&ptable.lock);
8010496f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
            return -1;
80104976:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
8010497b:	e8 f0 13 00 00       	call   80105d70 <release>
            return -1;
80104980:	eb e3                	jmp    80104965 <wait+0xe5>
80104982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <wait_stat>:
wait_stat(int *status, struct perf *perform) {
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	57                   	push   %edi
80104994:	56                   	push   %esi
80104995:	53                   	push   %ebx
80104996:	83 ec 1c             	sub    $0x1c,%esp
80104999:	8b 7d 0c             	mov    0xc(%ebp),%edi
    pushcli();
8010499c:	e8 4f 12 00 00       	call   80105bf0 <pushcli>
    c = mycpu();
801049a1:	e8 1a ef ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801049a6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801049ac:	e8 7f 12 00 00       	call   80105c30 <popcli>
    acquire(&ptable.lock);
801049b1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801049b8:	e8 13 13 00 00       	call   80105cd0 <acquire>
        havekids = 0;
801049bd:	31 c0                	xor    %eax,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049bf:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801049c4:	eb 18                	jmp    801049de <wait_stat+0x4e>
801049c6:	8d 76 00             	lea    0x0(%esi),%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049d0:	81 c3 ac 00 00 00    	add    $0xac,%ebx
801049d6:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
801049dc:	73 20                	jae    801049fe <wait_stat+0x6e>
            if (p->parent != curproc)
801049de:	39 73 14             	cmp    %esi,0x14(%ebx)
801049e1:	75 ed                	jne    801049d0 <wait_stat+0x40>
            if (p->state == ZOMBIE) {
801049e3:	8b 43 0c             	mov    0xc(%ebx),%eax
801049e6:	83 f8 05             	cmp    $0x5,%eax
801049e9:	74 3d                	je     80104a28 <wait_stat+0x98>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049eb:	81 c3 ac 00 00 00    	add    $0xac,%ebx
            havekids = 1;
801049f1:	b8 01 00 00 00       	mov    $0x1,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049f6:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
801049fc:	72 e0                	jb     801049de <wait_stat+0x4e>
        if (!havekids || curproc->killed) {
801049fe:	85 c0                	test   %eax,%eax
80104a00:	0f 84 e3 00 00 00    	je     80104ae9 <wait_stat+0x159>
80104a06:	8b 56 24             	mov    0x24(%esi),%edx
80104a09:	85 d2                	test   %edx,%edx
80104a0b:	0f 85 d8 00 00 00    	jne    80104ae9 <wait_stat+0x159>
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a11:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104a16:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a1a:	89 34 24             	mov    %esi,(%esp)
80104a1d:	e8 fe fc ff ff       	call   80104720 <sleep>
        havekids = 0;
80104a22:	eb 99                	jmp    801049bd <wait_stat+0x2d>
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                kfree(p->kstack);
80104a28:	8b 43 08             	mov    0x8(%ebx),%eax
                pid = p->pid;
80104a2b:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104a2e:	89 04 24             	mov    %eax,(%esp)
80104a31:	e8 8a d9 ff ff       	call   801023c0 <kfree>
                freevm(p->pgdir);
80104a36:	8b 43 04             	mov    0x4(%ebx),%eax
                p->kstack = 0;
80104a39:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104a40:	89 04 24             	mov    %eax,(%esp)
80104a43:	e8 58 3c 00 00       	call   801086a0 <freevm>
                if (status)
80104a48:	8b 45 08             	mov    0x8(%ebp),%eax
                p->pid = 0;
80104a4b:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104a52:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
80104a59:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                if (status)
80104a5d:	85 c0                	test   %eax,%eax
                p->killed = 0;
80104a5f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                if (status)
80104a66:	74 08                	je     80104a70 <wait_stat+0xe0>
                    *status = p->status;
80104a68:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104a6b:	8b 55 08             	mov    0x8(%ebp),%edx
80104a6e:	89 02                	mov    %eax,(%edx)
                perform->ctime = p->ctime;
80104a70:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
                p->ctime = 0;
80104a76:	31 c9                	xor    %ecx,%ecx
                p->state = UNUSED;
80104a78:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                perform->ctime = p->ctime;
80104a7f:	89 07                	mov    %eax,(%edi)
                perform->ttime = p->ttime;
80104a81:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104a87:	89 47 04             	mov    %eax,0x4(%edi)
                perform->stime = p->stime;
80104a8a:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
80104a90:	89 47 08             	mov    %eax,0x8(%edi)
                perform->retime = p->retime;
80104a93:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80104a99:	89 47 0c             	mov    %eax,0xc(%edi)
                perform->rutime = p->rutime;
80104a9c:	8b 83 a4 00 00 00    	mov    0xa4(%ebx),%eax
80104aa2:	89 47 10             	mov    %eax,0x10(%edi)
                p->stime = 0;
80104aa5:	31 c0                	xor    %eax,%eax
                p->ttime = 0;
80104aa7:	31 ff                	xor    %edi,%edi
                p->stime = 0;
80104aa9:	89 83 9c 00 00 00    	mov    %eax,0x9c(%ebx)
                p->retime = 0;
80104aaf:	31 c0                	xor    %eax,%eax
80104ab1:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
                p->rutime = 0;
80104ab7:	31 c0                	xor    %eax,%eax
80104ab9:	89 83 a4 00 00 00    	mov    %eax,0xa4(%ebx)
                p->oldTick = 0;
80104abf:	31 c0                	xor    %eax,%eax
                release(&ptable.lock);
80104ac1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
                p->ctime = 0;
80104ac8:	89 8b 94 00 00 00    	mov    %ecx,0x94(%ebx)
                p->ttime = 0;
80104ace:	89 bb 98 00 00 00    	mov    %edi,0x98(%ebx)
                p->oldTick = 0;
80104ad4:	89 83 a8 00 00 00    	mov    %eax,0xa8(%ebx)
                release(&ptable.lock);
80104ada:	e8 91 12 00 00       	call   80105d70 <release>
}
80104adf:	83 c4 1c             	add    $0x1c,%esp
80104ae2:	89 f0                	mov    %esi,%eax
80104ae4:	5b                   	pop    %ebx
80104ae5:	5e                   	pop    %esi
80104ae6:	5f                   	pop    %edi
80104ae7:	5d                   	pop    %ebp
80104ae8:	c3                   	ret    
            release(&ptable.lock);
80104ae9:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
            return -1;
80104af0:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
80104af5:	e8 76 12 00 00       	call   80105d70 <release>
            return -1;
80104afa:	eb e3                	jmp    80104adf <wait_stat+0x14f>
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b00 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan) {
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 14             	sub    $0x14,%esp
80104b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
80104b0a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b11:	e8 ba 11 00 00       	call   80105cd0 <acquire>
    wakeup1(chan);
80104b16:	89 d8                	mov    %ebx,%eax
80104b18:	e8 f3 ee ff ff       	call   80103a10 <wakeup1>
    release(&ptable.lock);
80104b1d:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104b24:	83 c4 14             	add    $0x14,%esp
80104b27:	5b                   	pop    %ebx
80104b28:	5d                   	pop    %ebp
    release(&ptable.lock);
80104b29:	e9 42 12 00 00       	jmp    80105d70 <release>
80104b2e:	66 90                	xchg   %ax,%ax

80104b30 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid) {
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
    struct proc *p;

    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104b35:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
kill(int pid) {
80104b3a:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
80104b3d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
kill(int pid) {
80104b44:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
80104b47:	e8 84 11 00 00       	call   80105cd0 <acquire>
80104b4c:	eb 14                	jmp    80104b62 <kill+0x32>
80104b4e:	66 90                	xchg   %ax,%ax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104b50:	81 c3 ac 00 00 00    	add    $0xac,%ebx
80104b56:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
80104b5c:	0f 83 9e 00 00 00    	jae    80104c00 <kill+0xd0>
        if (p->pid == pid) {
80104b62:	39 73 10             	cmp    %esi,0x10(%ebx)
80104b65:	75 e9                	jne    80104b50 <kill+0x20>
            p->killed = 1;
            // Wake process from sleep if necessary.
            if (p->state == SLEEPING) {
80104b67:	8b 43 0c             	mov    0xc(%ebx),%eax
            p->killed = 1;
80104b6a:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
            if (p->state == SLEEPING) {
80104b71:	83 f8 02             	cmp    $0x2,%eax
80104b74:	74 1a                	je     80104b90 <kill+0x60>
                    rrq.enqueue(p);
                } else if (poli == 2 || poli == 3) {
                    pq.put(p);
                }
            }
            release(&ptable.lock);
80104b76:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b7d:	e8 ee 11 00 00       	call   80105d70 <release>
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
}
80104b82:	83 c4 10             	add    $0x10,%esp
            return 0;
80104b85:	31 c0                	xor    %eax,%eax
}
80104b87:	5b                   	pop    %ebx
80104b88:	5e                   	pop    %esi
80104b89:	5d                   	pop    %ebp
80104b8a:	c3                   	ret    
80104b8b:	90                   	nop
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                p->acc = getMinAccumulator();
80104b90:	e8 fb ed ff ff       	call   80103990 <getMinAccumulator>
80104b95:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
                updatePerformance(p, ticks);
80104b9b:	8b 15 00 81 11 80    	mov    0x80118100,%edx
                p->acc = getMinAccumulator();
80104ba1:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
    int time = ticks - p->oldTick;
80104ba7:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80104bad:	89 d1                	mov    %edx,%ecx
80104baf:	29 c1                	sub    %eax,%ecx
    switch (p->state) {
80104bb1:	8b 43 0c             	mov    0xc(%ebx),%eax
80104bb4:	83 f8 03             	cmp    $0x3,%eax
80104bb7:	74 5f                	je     80104c18 <kill+0xe8>
80104bb9:	83 f8 04             	cmp    $0x4,%eax
80104bbc:	74 70                	je     80104c2e <kill+0xfe>
80104bbe:	83 f8 02             	cmp    $0x2,%eax
80104bc1:	74 63                	je     80104c26 <kill+0xf6>
                p->idle=tick;
80104bc3:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104bc8:	8b 15 0c c0 10 80    	mov    0x8010c00c,%edx
                p->state = RUNNABLE;
80104bce:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
                p->idle=tick;
80104bd5:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
                if (poli == 1) {
80104bdb:	a1 10 c0 10 80       	mov    0x8010c010,%eax
                p->idle=tick;
80104be0:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
                if (poli == 1) {
80104be6:	83 f8 01             	cmp    $0x1,%eax
80104be9:	75 4b                	jne    80104c36 <kill+0x106>
                    rrq.enqueue(p);
80104beb:	89 1c 24             	mov    %ebx,(%esp)
80104bee:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
80104bf4:	e9 7d ff ff ff       	jmp    80104b76 <kill+0x46>
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104c00:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104c07:	e8 64 11 00 00       	call   80105d70 <release>
}
80104c0c:	83 c4 10             	add    $0x10,%esp
    return -1;
80104c0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c14:	5b                   	pop    %ebx
80104c15:	5e                   	pop    %esi
80104c16:	5d                   	pop    %ebp
80104c17:	c3                   	ret    
            p->retime += time;
80104c18:	01 8b a0 00 00 00    	add    %ecx,0xa0(%ebx)
        p->oldTick = ticks;
80104c1e:	89 93 a8 00 00 00    	mov    %edx,0xa8(%ebx)
80104c24:	eb 9d                	jmp    80104bc3 <kill+0x93>
            p->stime += time;
80104c26:	01 8b 9c 00 00 00    	add    %ecx,0x9c(%ebx)
80104c2c:	eb f0                	jmp    80104c1e <kill+0xee>
            p->rutime += time;
80104c2e:	01 8b a4 00 00 00    	add    %ecx,0xa4(%ebx)
80104c34:	eb e8                	jmp    80104c1e <kill+0xee>
                } else if (poli == 2 || poli == 3) {
80104c36:	83 e8 02             	sub    $0x2,%eax
80104c39:	83 f8 01             	cmp    $0x1,%eax
80104c3c:	0f 87 34 ff ff ff    	ja     80104b76 <kill+0x46>
                    pq.put(p);
80104c42:	89 1c 24             	mov    %ebx,(%esp)
80104c45:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80104c4b:	e9 26 ff ff ff       	jmp    80104b76 <kill+0x46>

80104c50 <procdump>:
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) {
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	57                   	push   %edi
80104c54:	56                   	push   %esi
80104c55:	53                   	push   %ebx
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104c56:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
procdump(void) {
80104c5b:	83 ec 4c             	sub    $0x4c,%esp
80104c5e:	eb 1e                	jmp    80104c7e <procdump+0x2e>
        if (p->state == SLEEPING) {
            getcallerpcs((uint *) p->context->ebp + 2, pc);
            for (i = 0; i < 10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104c60:	c7 04 24 1d 91 10 80 	movl   $0x8010911d,(%esp)
80104c67:	e8 e4 b9 ff ff       	call   80100650 <cprintf>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104c6c:	81 c3 ac 00 00 00    	add    $0xac,%ebx
80104c72:	81 fb b4 78 11 80    	cmp    $0x801178b4,%ebx
80104c78:	0f 83 b2 00 00 00    	jae    80104d30 <procdump+0xe0>
        if (p->state == UNUSED)
80104c7e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104c81:	85 c0                	test   %eax,%eax
80104c83:	74 e7                	je     80104c6c <procdump+0x1c>
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c85:	8b 43 0c             	mov    0xc(%ebx),%eax
            state = "???";
80104c88:	b8 46 90 10 80       	mov    $0x80109046,%eax
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c8d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104c90:	83 fa 05             	cmp    $0x5,%edx
80104c93:	77 18                	ja     80104cad <procdump+0x5d>
80104c95:	8b 53 0c             	mov    0xc(%ebx),%edx
80104c98:	8b 14 95 f4 90 10 80 	mov    -0x7fef6f0c(,%edx,4),%edx
80104c9f:	85 d2                	test   %edx,%edx
80104ca1:	74 0a                	je     80104cad <procdump+0x5d>
            state = states[p->state];
80104ca3:	8b 43 0c             	mov    0xc(%ebx),%eax
80104ca6:	8b 04 85 f4 90 10 80 	mov    -0x7fef6f0c(,%eax,4),%eax
        cprintf("%d %s %s", p->pid, state, p->name);
80104cad:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cb1:	8b 43 10             	mov    0x10(%ebx),%eax
80104cb4:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104cb7:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104cbb:	c7 04 24 4a 90 10 80 	movl   $0x8010904a,(%esp)
80104cc2:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cc6:	e8 85 b9 ff ff       	call   80100650 <cprintf>
        if (p->state == SLEEPING) {
80104ccb:	8b 43 0c             	mov    0xc(%ebx),%eax
80104cce:	83 f8 02             	cmp    $0x2,%eax
80104cd1:	75 8d                	jne    80104c60 <procdump+0x10>
            getcallerpcs((uint *) p->context->ebp + 2, pc);
80104cd3:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104cd6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cda:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104cdd:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104ce0:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104ce3:	8b 40 0c             	mov    0xc(%eax),%eax
80104ce6:	83 c0 08             	add    $0x8,%eax
80104ce9:	89 04 24             	mov    %eax,(%esp)
80104cec:	e8 af 0e 00 00       	call   80105ba0 <getcallerpcs>
80104cf1:	eb 0d                	jmp    80104d00 <procdump+0xb0>
80104cf3:	90                   	nop
80104cf4:	90                   	nop
80104cf5:	90                   	nop
80104cf6:	90                   	nop
80104cf7:	90                   	nop
80104cf8:	90                   	nop
80104cf9:	90                   	nop
80104cfa:	90                   	nop
80104cfb:	90                   	nop
80104cfc:	90                   	nop
80104cfd:	90                   	nop
80104cfe:	90                   	nop
80104cff:	90                   	nop
            for (i = 0; i < 10 && pc[i] != 0; i++)
80104d00:	8b 16                	mov    (%esi),%edx
80104d02:	85 d2                	test   %edx,%edx
80104d04:	0f 84 56 ff ff ff    	je     80104c60 <procdump+0x10>
                cprintf(" %p", pc[i]);
80104d0a:	89 54 24 04          	mov    %edx,0x4(%esp)
80104d0e:	83 c6 04             	add    $0x4,%esi
80104d11:	c7 04 24 21 8a 10 80 	movl   $0x80108a21,(%esp)
80104d18:	e8 33 b9 ff ff       	call   80100650 <cprintf>
            for (i = 0; i < 10 && pc[i] != 0; i++)
80104d1d:	39 f7                	cmp    %esi,%edi
80104d1f:	75 df                	jne    80104d00 <procdump+0xb0>
80104d21:	e9 3a ff ff ff       	jmp    80104c60 <procdump+0x10>
80104d26:	8d 76 00             	lea    0x0(%esi),%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    }
}
80104d30:	83 c4 4c             	add    $0x4c,%esp
80104d33:	5b                   	pop    %ebx
80104d34:	5e                   	pop    %esi
80104d35:	5f                   	pop    %edi
80104d36:	5d                   	pop    %ebp
80104d37:	c3                   	ret    
80104d38:	66 90                	xchg   %ax,%ax
80104d3a:	66 90                	xchg   %ax,%ax
80104d3c:	66 90                	xchg   %ax,%ax
80104d3e:	66 90                	xchg   %ax,%ax

80104d40 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104d40:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean isEmptyPriorityQueue() {
80104d45:	55                   	push   %ebp
80104d46:	89 e5                	mov    %esp,%ebp
}
80104d48:	5d                   	pop    %ebp
	return !root;
80104d49:	8b 00                	mov    (%eax),%eax
80104d4b:	85 c0                	test   %eax,%eax
80104d4d:	0f 94 c0             	sete   %al
80104d50:	0f b6 c0             	movzbl %al,%eax
}
80104d53:	c3                   	ret    
80104d54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d60 <getMinAccumulatorPriorityQueue>:
	return !root;
80104d60:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80104d65:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104d67:	85 d2                	test   %edx,%edx
80104d69:	74 35                	je     80104da0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104d6b:	55                   	push   %ebp
80104d6c:	89 e5                	mov    %esp,%ebp
80104d6e:	53                   	push   %ebx
80104d6f:	eb 09                	jmp    80104d7a <getMinAccumulatorPriorityQueue+0x1a>
80104d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104d78:	89 c2                	mov    %eax,%edx
80104d7a:	8b 42 18             	mov    0x18(%edx),%eax
80104d7d:	85 c0                	test   %eax,%eax
80104d7f:	75 f7                	jne    80104d78 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104d81:	8b 45 08             	mov    0x8(%ebp),%eax
80104d84:	8b 5a 04             	mov    0x4(%edx),%ebx
80104d87:	8b 0a                	mov    (%edx),%ecx
80104d89:	89 58 04             	mov    %ebx,0x4(%eax)
80104d8c:	89 08                	mov    %ecx,(%eax)
80104d8e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d93:	5b                   	pop    %ebx
80104d94:	5d                   	pop    %ebp
80104d95:	c3                   	ret    
80104d96:	8d 76 00             	lea    0x0(%esi),%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104da0:	31 c0                	xor    %eax,%eax
}
80104da2:	c3                   	ret    
80104da3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <isEmptyRoundRobinQueue>:
	return !first;
80104db0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
static boolean isEmptyRoundRobinQueue() {
80104db5:	55                   	push   %ebp
80104db6:	89 e5                	mov    %esp,%ebp
}
80104db8:	5d                   	pop    %ebp
	return !first;
80104db9:	8b 00                	mov    (%eax),%eax
80104dbb:	85 c0                	test   %eax,%eax
80104dbd:	0f 94 c0             	sete   %al
80104dc0:	0f b6 c0             	movzbl %al,%eax
}
80104dc3:	c3                   	ret    
80104dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104dd0 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104dd0:	a1 00 c6 10 80       	mov    0x8010c600,%eax
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	74 47                	je     80104e20 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104dd9:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104dda:	8b 0d 08 c6 10 80    	mov    0x8010c608,%ecx
	freeLinks = freeLinks->next;
80104de0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104de3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104de5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104dec:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	ans->p = p;
80104df2:	8b 55 08             	mov    0x8(%ebp),%edx
80104df5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104df7:	8b 11                	mov    (%ecx),%edx
80104df9:	85 d2                	test   %edx,%edx
80104dfb:	74 2b                	je     80104e28 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104dfd:	8b 51 04             	mov    0x4(%ecx),%edx
80104e00:	89 42 04             	mov    %eax,0x4(%edx)
80104e03:	eb 05                	jmp    80104e0a <enqueueRoundRobinQueue+0x3a>
80104e05:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104e08:	89 d0                	mov    %edx,%eax
80104e0a:	8b 50 04             	mov    0x4(%eax),%edx
80104e0d:	85 d2                	test   %edx,%edx
80104e0f:	75 f7                	jne    80104e08 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104e11:	89 41 04             	mov    %eax,0x4(%ecx)
80104e14:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104e19:	5d                   	pop    %ebp
80104e1a:	c3                   	ret    
80104e1b:	90                   	nop
80104e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104e20:	31 c0                	xor    %eax,%eax
}
80104e22:	c3                   	ret    
80104e23:	90                   	nop
80104e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104e28:	89 01                	mov    %eax,(%ecx)
80104e2a:	eb de                	jmp    80104e0a <enqueueRoundRobinQueue+0x3a>
80104e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e30 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104e30:	8b 0d 08 c6 10 80    	mov    0x8010c608,%ecx
	return !first;
80104e36:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104e38:	85 d2                	test   %edx,%edx
80104e3a:	74 3c                	je     80104e78 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104e3c:	55                   	push   %ebp
80104e3d:	89 e5                	mov    %esp,%ebp
80104e3f:	83 ec 08             	sub    $0x8,%esp
80104e42:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104e45:	8b 35 00 c6 10 80    	mov    0x8010c600,%esi
static Proc* dequeueRoundRobinQueue() {
80104e4b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104e4e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104e51:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104e53:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104e56:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	if(isEmpty())
80104e5c:	85 db                	test   %ebx,%ebx
	first = next;
80104e5e:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104e60:	75 07                	jne    80104e69 <dequeueRoundRobinQueue+0x39>
		last = null;
80104e62:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104e69:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104e6c:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104e6f:	89 ec                	mov    %ebp,%esp
80104e71:	5d                   	pop    %ebp
80104e72:	c3                   	ret    
80104e73:	90                   	nop
80104e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104e78:	31 c0                	xor    %eax,%eax
}
80104e7a:	c3                   	ret    
80104e7b:	90                   	nop
80104e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e80 <isEmptyRunningProcessHolder>:
	return !first;
80104e80:	a1 04 c6 10 80       	mov    0x8010c604,%eax
static boolean isEmptyRunningProcessHolder() {
80104e85:	55                   	push   %ebp
80104e86:	89 e5                	mov    %esp,%ebp
}
80104e88:	5d                   	pop    %ebp
	return !first;
80104e89:	8b 00                	mov    (%eax),%eax
80104e8b:	85 c0                	test   %eax,%eax
80104e8d:	0f 94 c0             	sete   %al
80104e90:	0f b6 c0             	movzbl %al,%eax
}
80104e93:	c3                   	ret    
80104e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ea0 <addRunningProcessHolder>:
	if(!freeLinks)
80104ea0:	a1 00 c6 10 80       	mov    0x8010c600,%eax
80104ea5:	85 c0                	test   %eax,%eax
80104ea7:	74 47                	je     80104ef0 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104ea9:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104eaa:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	freeLinks = freeLinks->next;
80104eb0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104eb3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104eb5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104ebc:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	ans->p = p;
80104ec2:	8b 55 08             	mov    0x8(%ebp),%edx
80104ec5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104ec7:	8b 11                	mov    (%ecx),%edx
80104ec9:	85 d2                	test   %edx,%edx
80104ecb:	74 2b                	je     80104ef8 <addRunningProcessHolder+0x58>
	else last->next = link;
80104ecd:	8b 51 04             	mov    0x4(%ecx),%edx
80104ed0:	89 42 04             	mov    %eax,0x4(%edx)
80104ed3:	eb 05                	jmp    80104eda <addRunningProcessHolder+0x3a>
80104ed5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104ed8:	89 d0                	mov    %edx,%eax
80104eda:	8b 50 04             	mov    0x4(%eax),%edx
80104edd:	85 d2                	test   %edx,%edx
80104edf:	75 f7                	jne    80104ed8 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104ee1:	89 41 04             	mov    %eax,0x4(%ecx)
80104ee4:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104ee9:	5d                   	pop    %ebp
80104eea:	c3                   	ret    
80104eeb:	90                   	nop
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104ef0:	31 c0                	xor    %eax,%eax
}
80104ef2:	c3                   	ret    
80104ef3:	90                   	nop
80104ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104ef8:	89 01                	mov    %eax,(%ecx)
80104efa:	eb de                	jmp    80104eda <addRunningProcessHolder+0x3a>
80104efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f00 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
	if(!freeNodes)
80104f05:	8b 1d fc c5 10 80    	mov    0x8010c5fc,%ebx
80104f0b:	85 db                	test   %ebx,%ebx
80104f0d:	74 4d                	je     80104f5c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104f0f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104f11:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
	freeNodes = freeNodes->next;
80104f17:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104f1a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104f1d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104f24:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104f26:	89 35 fc c5 10 80    	mov    %esi,0x8010c5fc
	if(!freeLinks)
80104f2c:	74 3f                	je     80104f6d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104f2e:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104f31:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104f33:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104f3a:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104f3d:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
	if(isEmpty()) first = link;
80104f43:	85 c0                	test   %eax,%eax
80104f45:	74 21                	je     80104f68 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104f47:	8b 43 0c             	mov    0xc(%ebx),%eax
80104f4a:	89 50 04             	mov    %edx,0x4(%eax)
80104f4d:	eb 03                	jmp    80104f52 <_ZL9allocNodeP4procx+0x52>
80104f4f:	90                   	nop
	while(ans->next)
80104f50:	89 ca                	mov    %ecx,%edx
80104f52:	8b 4a 04             	mov    0x4(%edx),%ecx
80104f55:	85 c9                	test   %ecx,%ecx
80104f57:	75 f7                	jne    80104f50 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104f59:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104f5c:	89 d8                	mov    %ebx,%eax
80104f5e:	5b                   	pop    %ebx
80104f5f:	5e                   	pop    %esi
80104f60:	5d                   	pop    %ebp
80104f61:	c3                   	ret    
80104f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104f68:	89 53 08             	mov    %edx,0x8(%ebx)
80104f6b:	eb e5                	jmp    80104f52 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104f6d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104f74:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104f7b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104f82:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104f85:	89 1d fc c5 10 80    	mov    %ebx,0x8010c5fc
		return null;
80104f8b:	31 db                	xor    %ebx,%ebx
80104f8d:	eb cd                	jmp    80104f5c <_ZL9allocNodeP4procx+0x5c>
80104f8f:	90                   	nop

80104f90 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	53                   	push   %ebx
80104f94:	89 c3                	mov    %eax,%ebx
80104f96:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104f99:	8b 15 f4 c5 10 80    	mov    0x8010c5f4,%edx
80104f9f:	39 c2                	cmp    %eax,%edx
80104fa1:	73 26                	jae    80104fc9 <_ZL8mymallocj+0x39>
		data = kalloc();
80104fa3:	e8 e8 d5 ff ff       	call   80102590 <kalloc>
		memset(data, 0, PGSIZE);
80104fa8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104fad:	31 c9                	xor    %ecx,%ecx
80104faf:	89 54 24 08          	mov    %edx,0x8(%esp)
80104fb3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104fb7:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104fba:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8
		memset(data, 0, PGSIZE);
80104fbf:	e8 fc 0d 00 00       	call   80105dc0 <memset>
80104fc4:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104fc9:	a1 f8 c5 10 80       	mov    0x8010c5f8,%eax
	spaceLeft -= size;
80104fce:	29 da                	sub    %ebx,%edx
80104fd0:	89 15 f4 c5 10 80    	mov    %edx,0x8010c5f4
	data += size;
80104fd6:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104fd9:	89 0d f8 c5 10 80    	mov    %ecx,0x8010c5f8
}
80104fdf:	83 c4 14             	add    $0x14,%esp
80104fe2:	5b                   	pop    %ebx
80104fe3:	5d                   	pop    %ebp
80104fe4:	c3                   	ret    
80104fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ff0 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104ff0:	55                   	push   %ebp
	data               = null;
80104ff1:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	53                   	push   %ebx
	freeLinks = null;
80104ff6:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104ffb:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104ffe:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8
	spaceLeft          = 0u;
80105003:	31 c0                	xor    %eax,%eax
80105005:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	priorityQ          = (Map*)mymalloc(sizeof(Map));
8010500a:	b8 04 00 00 00       	mov    $0x4,%eax
8010500f:	e8 7c ff ff ff       	call   80104f90 <_ZL8mymallocj>
80105014:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*priorityQ         = Map();
80105019:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
8010501f:	b8 08 00 00 00       	mov    $0x8,%eax
80105024:	e8 67 ff ff ff       	call   80104f90 <_ZL8mymallocj>
80105029:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	*roundRobinQ       = LinkedList();
8010502e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105034:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
8010503b:	b8 08 00 00 00       	mov    $0x8,%eax
80105040:	e8 4b ff ff ff       	call   80104f90 <_ZL8mymallocj>
80105045:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	*runningProcHolder = LinkedList();
8010504a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105050:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80105057:	31 c0                	xor    %eax,%eax
80105059:	a3 00 c6 10 80       	mov    %eax,0x8010c600
8010505e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80105060:	b8 08 00 00 00       	mov    $0x8,%eax
80105065:	e8 26 ff ff ff       	call   80104f90 <_ZL8mymallocj>
		link->next = freeLinks;
8010506a:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80105070:	4b                   	dec    %ebx
		*link = Link();
80105071:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80105077:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
8010507a:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	for(int i = 0; i < NPROCLIST; ++i) {
8010507f:	75 df                	jne    80105060 <initSchedDS+0x70>
	freeNodes = null;
80105081:	31 c0                	xor    %eax,%eax
80105083:	bb 80 00 00 00       	mov    $0x80,%ebx
80105088:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80105090:	b8 20 00 00 00       	mov    $0x20,%eax
80105095:	e8 f6 fe ff ff       	call   80104f90 <_ZL8mymallocj>
		node->next = freeNodes;
8010509a:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
801050a0:	4b                   	dec    %ebx
		*node = MapNode();
801050a1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801050a8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
801050af:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
801050b6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
801050bd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
801050c4:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
801050c7:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	for(int i = 0; i < NPROCMAP; ++i) {
801050cc:	75 c2                	jne    80105090 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
801050ce:	b8 40 4d 10 80       	mov    $0x80104d40,%eax
	pq.put                          = putPriorityQueue;
801050d3:	ba c0 56 10 80       	mov    $0x801056c0,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
801050d8:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
801050dd:	b8 80 58 10 80       	mov    $0x80105880,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
801050e2:	b9 60 4d 10 80       	mov    $0x80104d60,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
801050e7:	a3 ec c5 10 80       	mov    %eax,0x8010c5ec
	pq.extractProc                  = extractProcPriorityQueue;
801050ec:	b8 60 59 10 80       	mov    $0x80105960,%eax
	pq.extractMin                   = extractMinPriorityQueue;
801050f1:	bb e0 57 10 80       	mov    $0x801057e0,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
801050f6:	a3 f0 c5 10 80       	mov    %eax,0x8010c5f0
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
801050fb:	b8 b0 4d 10 80       	mov    $0x80104db0,%eax
80105100:	a3 cc c5 10 80       	mov    %eax,0x8010c5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
80105105:	b8 d0 4d 10 80       	mov    $0x80104dd0,%eax
8010510a:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
	rrq.dequeue                     = dequeueRoundRobinQueue;
8010510f:	b8 30 4e 10 80       	mov    $0x80104e30,%eax
80105114:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80105119:	b8 f0 53 10 80       	mov    $0x801053f0,%eax
	pq.put                          = putPriorityQueue;
8010511e:	89 15 e0 c5 10 80    	mov    %edx,0x8010c5e0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80105124:	ba 80 4e 10 80       	mov    $0x80104e80,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80105129:	89 0d e4 c5 10 80    	mov    %ecx,0x8010c5e4
	rpholder.add                    = addRunningProcessHolder;
8010512f:	b9 a0 4e 10 80       	mov    $0x80104ea0,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80105134:	89 1d e8 c5 10 80    	mov    %ebx,0x8010c5e8
	rpholder.remove                 = removeRunningProcessHolder;
8010513a:	bb 50 53 10 80       	mov    $0x80105350,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
8010513f:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80105144:	b8 80 54 10 80       	mov    $0x80105480,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80105149:	89 1d c4 c5 10 80    	mov    %ebx,0x8010c5c4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
8010514f:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc
	rpholder.add                    = addRunningProcessHolder;
80105155:	89 0d c0 c5 10 80    	mov    %ecx,0x8010c5c0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
8010515b:	a3 c8 c5 10 80       	mov    %eax,0x8010c5c8
}
80105160:	58                   	pop    %eax
80105161:	5b                   	pop    %ebx
80105162:	5d                   	pop    %ebp
80105163:	c3                   	ret    
80105164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010516a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105170 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	8b 45 08             	mov    0x8(%ebp),%eax
80105176:	eb 0a                	jmp    80105182 <_ZN4Link7getLastEv+0x12>
80105178:	90                   	nop
80105179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105180:	89 d0                	mov    %edx,%eax
	while(ans->next)
80105182:	8b 50 04             	mov    0x4(%eax),%edx
80105185:	85 d2                	test   %edx,%edx
80105187:	75 f7                	jne    80105180 <_ZN4Link7getLastEv+0x10>
}
80105189:	5d                   	pop    %ebp
8010518a:	c3                   	ret    
8010518b:	90                   	nop
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105190 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
	return !first;
80105193:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105196:	5d                   	pop    %ebp
	return !first;
80105197:	8b 00                	mov    (%eax),%eax
80105199:	85 c0                	test   %eax,%eax
8010519b:	0f 94 c0             	sete   %al
}
8010519e:	c3                   	ret    
8010519f:	90                   	nop

801051a0 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801051a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
801051a9:	85 d2                	test   %edx,%edx
801051ab:	74 1f                	je     801051cc <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
801051ad:	8b 01                	mov    (%ecx),%eax
801051af:	85 c0                	test   %eax,%eax
801051b1:	74 1d                	je     801051d0 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
801051b3:	8b 41 04             	mov    0x4(%ecx),%eax
801051b6:	89 50 04             	mov    %edx,0x4(%eax)
801051b9:	eb 07                	jmp    801051c2 <_ZN10LinkedList6appendEP4Link+0x22>
801051bb:	90                   	nop
801051bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
801051c0:	89 c2                	mov    %eax,%edx
801051c2:	8b 42 04             	mov    0x4(%edx),%eax
801051c5:	85 c0                	test   %eax,%eax
801051c7:	75 f7                	jne    801051c0 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
801051c9:	89 51 04             	mov    %edx,0x4(%ecx)
}
801051cc:	5d                   	pop    %ebp
801051cd:	c3                   	ret    
801051ce:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801051d0:	89 11                	mov    %edx,(%ecx)
801051d2:	eb ee                	jmp    801051c2 <_ZN10LinkedList6appendEP4Link+0x22>
801051d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801051e0 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
801051e0:	a1 00 c6 10 80       	mov    0x8010c600,%eax
bool LinkedList::enqueue(Proc *p) {
801051e5:	55                   	push   %ebp
801051e6:	89 e5                	mov    %esp,%ebp
801051e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
801051eb:	85 c0                	test   %eax,%eax
801051ed:	74 41                	je     80105230 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
801051ef:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
801051f2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
801051f9:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	ans->p = p;
801051ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105202:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105204:	8b 11                	mov    (%ecx),%edx
80105206:	85 d2                	test   %edx,%edx
80105208:	74 2e                	je     80105238 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010520a:	8b 51 04             	mov    0x4(%ecx),%edx
8010520d:	89 42 04             	mov    %eax,0x4(%edx)
80105210:	eb 08                	jmp    8010521a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105218:	89 d0                	mov    %edx,%eax
8010521a:	8b 50 04             	mov    0x4(%eax),%edx
8010521d:	85 d2                	test   %edx,%edx
8010521f:	75 f7                	jne    80105218 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80105221:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80105224:	b0 01                	mov    $0x1,%al
}
80105226:	5d                   	pop    %ebp
80105227:	c3                   	ret    
80105228:	90                   	nop
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105230:	31 c0                	xor    %eax,%eax
}
80105232:	5d                   	pop    %ebp
80105233:	c3                   	ret    
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80105238:	89 01                	mov    %eax,(%ecx)
8010523a:	eb de                	jmp    8010521a <_ZN10LinkedList7enqueueEP4proc+0x3a>
8010523c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105240 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	83 ec 08             	sub    $0x8,%esp
80105246:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105249:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010524c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010524f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80105251:	85 d2                	test   %edx,%edx
80105253:	74 2b                	je     80105280 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80105255:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105258:	8b 35 00 c6 10 80    	mov    0x8010c600,%esi
	Proc *p = first->p;
8010525e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105260:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	if(isEmpty())
80105266:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105268:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010526b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
8010526d:	75 07                	jne    80105276 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
8010526f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80105276:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105279:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010527c:	89 ec                	mov    %ebp,%esp
8010527e:	5d                   	pop    %ebp
8010527f:	c3                   	ret    
		return null;
80105280:	31 c0                	xor    %eax,%eax
80105282:	eb f2                	jmp    80105276 <_ZN10LinkedList7dequeueEv+0x36>
80105284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010528a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105290 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	56                   	push   %esi
80105294:	8b 75 08             	mov    0x8(%ebp),%esi
80105297:	53                   	push   %ebx
80105298:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
8010529b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010529d:	85 db                	test   %ebx,%ebx
8010529f:	74 2f                	je     801052d0 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
801052a1:	39 0b                	cmp    %ecx,(%ebx)
801052a3:	8b 53 04             	mov    0x4(%ebx),%edx
801052a6:	74 70                	je     80105318 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
801052a8:	85 d2                	test   %edx,%edx
801052aa:	74 24                	je     801052d0 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
801052ac:	3b 0a                	cmp    (%edx),%ecx
801052ae:	66 90                	xchg   %ax,%ax
801052b0:	75 0c                	jne    801052be <_ZN10LinkedList6removeEP4proc+0x2e>
801052b2:	eb 2c                	jmp    801052e0 <_ZN10LinkedList6removeEP4proc+0x50>
801052b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052b8:	39 08                	cmp    %ecx,(%eax)
801052ba:	74 34                	je     801052f0 <_ZN10LinkedList6removeEP4proc+0x60>
801052bc:	89 c2                	mov    %eax,%edx
		cur = cur->next;
801052be:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
801052c1:	85 c0                	test   %eax,%eax
801052c3:	75 f3                	jne    801052b8 <_ZN10LinkedList6removeEP4proc+0x28>
}
801052c5:	5b                   	pop    %ebx
801052c6:	5e                   	pop    %esi
801052c7:	5d                   	pop    %ebp
801052c8:	c3                   	ret    
801052c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052d0:	5b                   	pop    %ebx
		return false;
801052d1:	31 c0                	xor    %eax,%eax
}
801052d3:	5e                   	pop    %esi
801052d4:	5d                   	pop    %ebp
801052d5:	c3                   	ret    
801052d6:	8d 76 00             	lea    0x0(%esi),%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
801052e0:	89 d0                	mov    %edx,%eax
801052e2:	89 da                	mov    %ebx,%edx
801052e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
801052f0:	8b 48 04             	mov    0x4(%eax),%ecx
801052f3:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
801052f6:	8b 48 04             	mov    0x4(%eax),%ecx
801052f9:	85 c9                	test   %ecx,%ecx
801052fb:	74 43                	je     80105340 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
801052fd:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
	freeLinks = link;
80105303:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	link->next = freeLinks;
80105308:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010530b:	b0 01                	mov    $0x1,%al
}
8010530d:	5b                   	pop    %ebx
8010530e:	5e                   	pop    %esi
8010530f:	5d                   	pop    %ebp
80105310:	c3                   	ret    
80105311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105318:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	if(isEmpty())
8010531d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010531f:	89 1d 00 c6 10 80    	mov    %ebx,0x8010c600
	link->next = freeLinks;
80105325:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80105328:	b0 01                	mov    $0x1,%al
	first = next;
8010532a:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
8010532c:	75 97                	jne    801052c5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
8010532e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80105335:	eb 8e                	jmp    801052c5 <_ZN10LinkedList6removeEP4proc+0x35>
80105337:	89 f6                	mov    %esi,%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80105340:	89 56 04             	mov    %edx,0x4(%esi)
80105343:	eb b8                	jmp    801052fd <_ZN10LinkedList6removeEP4proc+0x6d>
80105345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105350 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105356:	8b 45 08             	mov    0x8(%ebp),%eax
80105359:	89 44 24 04          	mov    %eax,0x4(%esp)
8010535d:	a1 04 c6 10 80       	mov    0x8010c604,%eax
80105362:	89 04 24             	mov    %eax,(%esp)
80105365:	e8 26 ff ff ff       	call   80105290 <_ZN10LinkedList6removeEP4proc>
}
8010536a:	c9                   	leave  
	return runningProcHolder->remove(p);
8010536b:	0f b6 c0             	movzbl %al,%eax
}
8010536e:	c3                   	ret    
8010536f:	90                   	nop

80105370 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80105370:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
		return false;
80105376:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80105378:	55                   	push   %ebp
80105379:	89 e5                	mov    %esp,%ebp
8010537b:	53                   	push   %ebx
8010537c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010537f:	8b 1a                	mov    (%edx),%ebx
80105381:	85 db                	test   %ebx,%ebx
80105383:	74 0b                	je     80105390 <_ZN10LinkedList8transferEv+0x20>
}
80105385:	5b                   	pop    %ebx
80105386:	5d                   	pop    %ebp
80105387:	c3                   	ret    
80105388:	90                   	nop
80105389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80105390:	8b 19                	mov    (%ecx),%ebx
80105392:	85 db                	test   %ebx,%ebx
80105394:	74 4a                	je     801053e0 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80105396:	8b 1d fc c5 10 80    	mov    0x8010c5fc,%ebx
8010539c:	85 db                	test   %ebx,%ebx
8010539e:	74 e5                	je     80105385 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
801053a0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
801053a3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
801053a9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801053b0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
801053b7:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
		node->listOfProcs.first = first;
801053bc:	8b 01                	mov    (%ecx),%eax
801053be:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801053c1:	8b 41 04             	mov    0x4(%ecx),%eax
801053c4:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
801053c7:	b0 01                	mov    $0x1,%al
		first = last = null;
801053c9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801053d0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801053d6:	89 1a                	mov    %ebx,(%edx)
}
801053d8:	5b                   	pop    %ebx
801053d9:	5d                   	pop    %ebp
801053da:	c3                   	ret    
801053db:	90                   	nop
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
801053e0:	b0 01                	mov    $0x1,%al
801053e2:	eb a1                	jmp    80105385 <_ZN10LinkedList8transferEv+0x15>
801053e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801053f0 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
801053f6:	a1 08 c6 10 80       	mov    0x8010c608,%eax
801053fb:	89 04 24             	mov    %eax,(%esp)
801053fe:	e8 6d ff ff ff       	call   80105370 <_ZN10LinkedList8transferEv>
}
80105403:	c9                   	leave  
	return roundRobinQ->transfer();
80105404:	0f b6 c0             	movzbl %al,%eax
}
80105407:	c3                   	ret    
80105408:	90                   	nop
80105409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105410 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105410:	55                   	push   %ebp
80105411:	31 c0                	xor    %eax,%eax
80105413:	89 e5                	mov    %esp,%ebp
80105415:	57                   	push   %edi
80105416:	56                   	push   %esi
80105417:	53                   	push   %ebx
80105418:	83 ec 1c             	sub    $0x1c,%esp
8010541b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010541e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80105420:	85 d2                	test   %edx,%edx
80105422:	74 41                	je     80105465 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80105424:	8b 02                	mov    (%edx),%eax
80105426:	89 04 24             	mov    %eax,(%esp)
80105429:	e8 52 e4 ff ff       	call   80103880 <getAccumulator>
	forEach([&](Proc *p) {
8010542e:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80105430:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80105432:	89 c6                	mov    %eax,%esi
80105434:	89 d3                	mov    %edx,%ebx
80105436:	74 23                	je     8010545b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80105438:	90                   	nop
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80105440:	8b 07                	mov    (%edi),%eax
80105442:	89 04 24             	mov    %eax,(%esp)
80105445:	e8 36 e4 ff ff       	call   80103880 <getAccumulator>
8010544a:	39 d3                	cmp    %edx,%ebx
8010544c:	7c 06                	jl     80105454 <_ZN10LinkedList9getMinKeyEPx+0x44>
8010544e:	7f 20                	jg     80105470 <_ZN10LinkedList9getMinKeyEPx+0x60>
80105450:	39 c6                	cmp    %eax,%esi
80105452:	77 1c                	ja     80105470 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80105454:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80105457:	85 ff                	test   %edi,%edi
80105459:	75 e5                	jne    80105440 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
8010545b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010545e:	89 30                	mov    %esi,(%eax)
80105460:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80105463:	b0 01                	mov    $0x1,%al
}
80105465:	83 c4 1c             	add    $0x1c,%esp
80105468:	5b                   	pop    %ebx
80105469:	5e                   	pop    %esi
8010546a:	5f                   	pop    %edi
8010546b:	5d                   	pop    %ebp
8010546c:	c3                   	ret    
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80105470:	8b 7f 04             	mov    0x4(%edi),%edi
80105473:	89 c6                	mov    %eax,%esi
80105475:	89 d3                	mov    %edx,%ebx
		while(link) {
80105477:	85 ff                	test   %edi,%edi
80105479:	75 c5                	jne    80105440 <_ZN10LinkedList9getMinKeyEPx+0x30>
8010547b:	eb de                	jmp    8010545b <_ZN10LinkedList9getMinKeyEPx+0x4b>
8010547d:	8d 76 00             	lea    0x0(%esi),%esi

80105480 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105486:	8b 45 08             	mov    0x8(%ebp),%eax
80105489:	89 44 24 04          	mov    %eax,0x4(%esp)
8010548d:	a1 04 c6 10 80       	mov    0x8010c604,%eax
80105492:	89 04 24             	mov    %eax,(%esp)
80105495:	e8 76 ff ff ff       	call   80105410 <_ZN10LinkedList9getMinKeyEPx>
}
8010549a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
8010549b:	0f b6 c0             	movzbl %al,%eax
}
8010549e:	c3                   	ret    
8010549f:	90                   	nop

801054a0 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
	return !first;
801054a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801054a6:	5d                   	pop    %ebp
	return !first;
801054a7:	8b 40 08             	mov    0x8(%eax),%eax
801054aa:	85 c0                	test   %eax,%eax
801054ac:	0f 94 c0             	sete   %al
}
801054af:	c3                   	ret    

801054b0 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	57                   	push   %edi
801054b4:	56                   	push   %esi
801054b5:	53                   	push   %ebx
801054b6:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
801054b9:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801054bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
801054bf:	89 04 24             	mov    %eax,(%esp)
801054c2:	e8 b9 e3 ff ff       	call   80103880 <getAccumulator>
801054c7:	89 d1                	mov    %edx,%ecx
801054c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
801054d0:	8b 13                	mov    (%ebx),%edx
801054d2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801054d5:	8b 43 04             	mov    0x4(%ebx),%eax
801054d8:	31 d7                	xor    %edx,%edi
801054da:	89 fe                	mov    %edi,%esi
801054dc:	89 c7                	mov    %eax,%edi
801054de:	31 cf                	xor    %ecx,%edi
801054e0:	09 fe                	or     %edi,%esi
801054e2:	74 4c                	je     80105530 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
801054e4:	39 c8                	cmp    %ecx,%eax
801054e6:	7c 20                	jl     80105508 <_ZN7MapNode3putEP4proc+0x58>
801054e8:	7f 08                	jg     801054f2 <_ZN7MapNode3putEP4proc+0x42>
801054ea:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
801054f0:	76 16                	jbe    80105508 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
801054f2:	8b 43 18             	mov    0x18(%ebx),%eax
801054f5:	85 c0                	test   %eax,%eax
801054f7:	0f 84 83 00 00 00    	je     80105580 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801054fd:	89 c3                	mov    %eax,%ebx
801054ff:	eb cf                	jmp    801054d0 <_ZN7MapNode3putEP4proc+0x20>
80105501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105508:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010550b:	85 c0                	test   %eax,%eax
8010550d:	75 ee                	jne    801054fd <_ZN7MapNode3putEP4proc+0x4d>
8010550f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105512:	8b 45 0c             	mov    0xc(%ebp),%eax
80105515:	89 f2                	mov    %esi,%edx
80105517:	e8 e4 f9 ff ff       	call   80104f00 <_ZL9allocNodeP4procx>
				if(node->right) {
8010551c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010551e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105521:	74 71                	je     80105594 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80105523:	89 58 14             	mov    %ebx,0x14(%eax)
}
80105526:	83 c4 2c             	add    $0x2c,%esp
					return true;
80105529:	b0 01                	mov    $0x1,%al
}
8010552b:	5b                   	pop    %ebx
8010552c:	5e                   	pop    %esi
8010552d:	5f                   	pop    %edi
8010552e:	5d                   	pop    %ebp
8010552f:	c3                   	ret    
	if(!freeLinks)
80105530:	a1 00 c6 10 80       	mov    0x8010c600,%eax
80105535:	85 c0                	test   %eax,%eax
80105537:	74 5b                	je     80105594 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80105539:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
8010553c:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
8010553f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80105546:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80105548:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	if(isEmpty()) first = link;
8010554e:	8b 53 08             	mov    0x8(%ebx),%edx
80105551:	85 d2                	test   %edx,%edx
80105553:	74 4b                	je     801055a0 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80105555:	8b 53 0c             	mov    0xc(%ebx),%edx
80105558:	89 42 04             	mov    %eax,0x4(%edx)
8010555b:	eb 05                	jmp    80105562 <_ZN7MapNode3putEP4proc+0xb2>
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105560:	89 d0                	mov    %edx,%eax
80105562:	8b 50 04             	mov    0x4(%eax),%edx
80105565:	85 d2                	test   %edx,%edx
80105567:	75 f7                	jne    80105560 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105569:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010556c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010556f:	b0 01                	mov    $0x1,%al
}
80105571:	5b                   	pop    %ebx
80105572:	5e                   	pop    %esi
80105573:	5f                   	pop    %edi
80105574:	5d                   	pop    %ebp
80105575:	c3                   	ret    
80105576:	8d 76 00             	lea    0x0(%esi),%esi
80105579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105580:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105583:	8b 45 0c             	mov    0xc(%ebp),%eax
80105586:	89 f2                	mov    %esi,%edx
80105588:	e8 73 f9 ff ff       	call   80104f00 <_ZL9allocNodeP4procx>
				if(node->left) {
8010558d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010558f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105592:	75 8f                	jne    80105523 <_ZN7MapNode3putEP4proc+0x73>
}
80105594:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105597:	31 c0                	xor    %eax,%eax
}
80105599:	5b                   	pop    %ebx
8010559a:	5e                   	pop    %esi
8010559b:	5f                   	pop    %edi
8010559c:	5d                   	pop    %ebp
8010559d:	c3                   	ret    
8010559e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801055a0:	89 43 08             	mov    %eax,0x8(%ebx)
801055a3:	eb bd                	jmp    80105562 <_ZN7MapNode3putEP4proc+0xb2>
801055a5:	90                   	nop
801055a6:	8d 76 00             	lea    0x0(%esi),%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	8b 45 08             	mov    0x8(%ebp),%eax
801055b6:	eb 0a                	jmp    801055c2 <_ZN7MapNode10getMinNodeEv+0x12>
801055b8:	90                   	nop
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055c0:	89 d0                	mov    %edx,%eax
	while(minNode->left)
801055c2:	8b 50 18             	mov    0x18(%eax),%edx
801055c5:	85 d2                	test   %edx,%edx
801055c7:	75 f7                	jne    801055c0 <_ZN7MapNode10getMinNodeEv+0x10>
}
801055c9:	5d                   	pop    %ebp
801055ca:	c3                   	ret    
801055cb:	90                   	nop
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	8b 55 08             	mov    0x8(%ebp),%edx
801055d6:	53                   	push   %ebx
801055d7:	eb 09                	jmp    801055e2 <_ZN7MapNode9getMinKeyEPx+0x12>
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
801055e0:	89 c2                	mov    %eax,%edx
801055e2:	8b 42 18             	mov    0x18(%edx),%eax
801055e5:	85 c0                	test   %eax,%eax
801055e7:	75 f7                	jne    801055e0 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801055e9:	8b 5a 04             	mov    0x4(%edx),%ebx
801055ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801055ef:	8b 0a                	mov    (%edx),%ecx
801055f1:	89 58 04             	mov    %ebx,0x4(%eax)
801055f4:	89 08                	mov    %ecx,(%eax)
}
801055f6:	5b                   	pop    %ebx
801055f7:	5d                   	pop    %ebp
801055f8:	c3                   	ret    
801055f9:	90                   	nop
801055fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105600 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 08             	sub    $0x8,%esp
80105606:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105609:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010560c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010560f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105612:	85 d2                	test   %edx,%edx
80105614:	74 32                	je     80105648 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105616:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105619:	8b 35 00 c6 10 80    	mov    0x8010c600,%esi
	Proc *p = first->p;
8010561f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105621:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
	if(isEmpty())
80105627:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105629:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010562c:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
8010562f:	75 07                	jne    80105638 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80105631:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80105638:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010563b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010563e:	89 ec                	mov    %ebp,%esp
80105640:	5d                   	pop    %ebp
80105641:	c3                   	ret    
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80105648:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
8010564a:	eb ec                	jmp    80105638 <_ZN7MapNode7dequeueEv+0x38>
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
	return !root;
80105653:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105656:	5d                   	pop    %ebp
	return !root;
80105657:	8b 00                	mov    (%eax),%eax
80105659:	85 c0                	test   %eax,%eax
8010565b:	0f 94 c0             	sete   %al
}
8010565e:	c3                   	ret    
8010565f:	90                   	nop

80105660 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	83 ec 18             	sub    $0x18,%esp
80105666:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105669:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010566c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010566f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105672:	89 1c 24             	mov    %ebx,(%esp)
80105675:	e8 06 e2 ff ff       	call   80103880 <getAccumulator>
	return !root;
8010567a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010567c:	85 c9                	test   %ecx,%ecx
8010567e:	74 18                	je     80105698 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105680:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105683:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105686:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105689:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010568c:	89 ec                	mov    %ebp,%esp
8010568e:	5d                   	pop    %ebp
	return root->put(p);
8010568f:	e9 1c fe ff ff       	jmp    801054b0 <_ZN7MapNode3putEP4proc>
80105694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105698:	89 d1                	mov    %edx,%ecx
8010569a:	89 c2                	mov    %eax,%edx
8010569c:	89 d8                	mov    %ebx,%eax
8010569e:	e8 5d f8 ff ff       	call   80104f00 <_ZL9allocNodeP4procx>
801056a3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801056a5:	85 c0                	test   %eax,%eax
801056a7:	0f 95 c0             	setne  %al
}
801056aa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801056ad:	8b 75 fc             	mov    -0x4(%ebp),%esi
801056b0:	89 ec                	mov    %ebp,%esp
801056b2:	5d                   	pop    %ebp
801056b3:	c3                   	ret    
801056b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801056c0 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801056c6:	8b 45 08             	mov    0x8(%ebp),%eax
801056c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801056cd:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801056d2:	89 04 24             	mov    %eax,(%esp)
801056d5:	e8 86 ff ff ff       	call   80105660 <_ZN3Map3putEP4proc>
}
801056da:	c9                   	leave  
	return priorityQ->put(p);
801056db:	0f b6 c0             	movzbl %al,%eax
}
801056de:	c3                   	ret    
801056df:	90                   	nop

801056e0 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
	return !root;
801056e3:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
801056e6:	53                   	push   %ebx
	return !root;
801056e7:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
801056e9:	85 d2                	test   %edx,%edx
801056eb:	75 05                	jne    801056f2 <_ZN3Map9getMinKeyEPx+0x12>
801056ed:	eb 21                	jmp    80105710 <_ZN3Map9getMinKeyEPx+0x30>
801056ef:	90                   	nop
	while(minNode->left)
801056f0:	89 c2                	mov    %eax,%edx
801056f2:	8b 42 18             	mov    0x18(%edx),%eax
801056f5:	85 c0                	test   %eax,%eax
801056f7:	75 f7                	jne    801056f0 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801056f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801056fc:	8b 5a 04             	mov    0x4(%edx),%ebx
801056ff:	8b 0a                	mov    (%edx),%ecx
80105701:	89 58 04             	mov    %ebx,0x4(%eax)
80105704:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105706:	b0 01                	mov    $0x1,%al
}
80105708:	5b                   	pop    %ebx
80105709:	5d                   	pop    %ebp
8010570a:	c3                   	ret    
8010570b:	90                   	nop
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105710:	5b                   	pop    %ebx
		return false;
80105711:	31 c0                	xor    %eax,%eax
}
80105713:	5d                   	pop    %ebp
80105714:	c3                   	ret    
80105715:	90                   	nop
80105716:	8d 76 00             	lea    0x0(%esi),%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105720 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	57                   	push   %edi
80105724:	56                   	push   %esi
80105725:	8b 75 08             	mov    0x8(%ebp),%esi
80105728:	53                   	push   %ebx
	return !root;
80105729:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010572b:	85 db                	test   %ebx,%ebx
8010572d:	0f 84 a5 00 00 00    	je     801057d8 <_ZN3Map10extractMinEv+0xb8>
80105733:	89 da                	mov    %ebx,%edx
80105735:	eb 0b                	jmp    80105742 <_ZN3Map10extractMinEv+0x22>
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80105740:	89 c2                	mov    %eax,%edx
80105742:	8b 42 18             	mov    0x18(%edx),%eax
80105745:	85 c0                	test   %eax,%eax
80105747:	75 f7                	jne    80105740 <_ZN3Map10extractMinEv+0x20>
	return !first;
80105749:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
8010574c:	85 c9                	test   %ecx,%ecx
8010574e:	74 70                	je     801057c0 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80105750:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80105753:	8b 3d 00 c6 10 80    	mov    0x8010c600,%edi
	Proc *p = first->p;
80105759:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
8010575b:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
	if(isEmpty())
80105761:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105763:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105766:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105769:	74 05                	je     80105770 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010576b:	5b                   	pop    %ebx
8010576c:	5e                   	pop    %esi
8010576d:	5f                   	pop    %edi
8010576e:	5d                   	pop    %ebp
8010576f:	c3                   	ret    
		last = null;
80105770:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105777:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010577a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010577c:	39 da                	cmp    %ebx,%edx
8010577e:	74 49                	je     801057c9 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105780:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105783:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105786:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105789:	85 c9                	test   %ecx,%ecx
8010578b:	74 03                	je     80105790 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010578d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105790:	8b 0d fc c5 10 80    	mov    0x8010c5fc,%ecx
	node->parent = node->left = node->right = null;
80105796:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010579d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801057a4:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801057ab:	89 4a 10             	mov    %ecx,0x10(%edx)
}
801057ae:	5b                   	pop    %ebx
	freeNodes = node;
801057af:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
}
801057b5:	5e                   	pop    %esi
801057b6:	5f                   	pop    %edi
801057b7:	5d                   	pop    %ebp
801057b8:	c3                   	ret    
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
801057c0:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
801057c2:	39 da                	cmp    %ebx,%edx
801057c4:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801057c7:	75 b7                	jne    80105780 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
801057c9:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
801057cb:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801057cd:	74 c1                	je     80105790 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
801057cf:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801057d6:	eb b8                	jmp    80105790 <_ZN3Map10extractMinEv+0x70>
		return null;
801057d8:	31 c0                	xor    %eax,%eax
801057da:	eb 8f                	jmp    8010576b <_ZN3Map10extractMinEv+0x4b>
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
801057e6:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801057eb:	89 04 24             	mov    %eax,(%esp)
801057ee:	e8 2d ff ff ff       	call   80105720 <_ZN3Map10extractMinEv>
}
801057f3:	c9                   	leave  
801057f4:	c3                   	ret    
801057f5:	90                   	nop
801057f6:	8d 76 00             	lea    0x0(%esi),%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105800 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
80105805:	89 c3                	mov    %eax,%ebx
80105807:	83 ec 04             	sub    $0x4,%esp
8010580a:	eb 16                	jmp    80105822 <_ZN3Map8transferEv.part.1+0x22>
8010580c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105810:	89 1c 24             	mov    %ebx,(%esp)
80105813:	e8 08 ff ff ff       	call   80105720 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105818:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
8010581e:	85 d2                	test   %edx,%edx
80105820:	75 0e                	jne    80105830 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80105822:	8b 03                	mov    (%ebx),%eax
80105824:	85 c0                	test   %eax,%eax
80105826:	75 e8                	jne    80105810 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105828:	5a                   	pop    %edx
80105829:	b0 01                	mov    $0x1,%al
8010582b:	5b                   	pop    %ebx
8010582c:	5e                   	pop    %esi
8010582d:	5d                   	pop    %ebp
8010582e:	c3                   	ret    
8010582f:	90                   	nop
	freeLinks = freeLinks->next;
80105830:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80105833:	8b 0d 08 c6 10 80    	mov    0x8010c608,%ecx
	ans->next = null;
80105839:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80105840:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80105842:	89 35 00 c6 10 80    	mov    %esi,0x8010c600
	if(isEmpty()) first = link;
80105848:	8b 31                	mov    (%ecx),%esi
8010584a:	85 f6                	test   %esi,%esi
8010584c:	74 22                	je     80105870 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
8010584e:	8b 41 04             	mov    0x4(%ecx),%eax
80105851:	89 50 04             	mov    %edx,0x4(%eax)
80105854:	eb 0c                	jmp    80105862 <_ZN3Map8transferEv.part.1+0x62>
80105856:	8d 76 00             	lea    0x0(%esi),%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105860:	89 c2                	mov    %eax,%edx
80105862:	8b 42 04             	mov    0x4(%edx),%eax
80105865:	85 c0                	test   %eax,%eax
80105867:	75 f7                	jne    80105860 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105869:	89 51 04             	mov    %edx,0x4(%ecx)
8010586c:	eb b4                	jmp    80105822 <_ZN3Map8transferEv.part.1+0x22>
8010586e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105870:	89 11                	mov    %edx,(%ecx)
80105872:	eb ee                	jmp    80105862 <_ZN3Map8transferEv.part.1+0x62>
80105874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010587a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105880 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105880:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
80105886:	8b 02                	mov    (%edx),%eax
80105888:	85 c0                	test   %eax,%eax
8010588a:	74 04                	je     80105890 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010588c:	31 c0                	xor    %eax,%eax
}
8010588e:	c3                   	ret    
8010588f:	90                   	nop
80105890:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105895:	55                   	push   %ebp
80105896:	89 e5                	mov    %esp,%ebp
80105898:	e8 63 ff ff ff       	call   80105800 <_ZN3Map8transferEv.part.1>
}
8010589d:	5d                   	pop    %ebp
8010589e:	0f b6 c0             	movzbl %al,%eax
801058a1:	c3                   	ret    
801058a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058b0 <_ZN3Map8transferEv>:
	return !first;
801058b0:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
bool Map::transfer() {
801058b6:	55                   	push   %ebp
801058b7:	89 e5                	mov    %esp,%ebp
801058b9:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
801058bc:	8b 12                	mov    (%edx),%edx
801058be:	85 d2                	test   %edx,%edx
801058c0:	74 0e                	je     801058d0 <_ZN3Map8transferEv+0x20>
}
801058c2:	31 c0                	xor    %eax,%eax
801058c4:	5d                   	pop    %ebp
801058c5:	c3                   	ret    
801058c6:	8d 76 00             	lea    0x0(%esi),%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801058d0:	5d                   	pop    %ebp
801058d1:	e9 2a ff ff ff       	jmp    80105800 <_ZN3Map8transferEv.part.1>
801058d6:	8d 76 00             	lea    0x0(%esi),%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	56                   	push   %esi
801058e4:	53                   	push   %ebx
801058e5:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
801058e8:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
bool Map::extractProc(Proc *p) {
801058ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
801058f1:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
801058f4:	85 d2                	test   %edx,%edx
801058f6:	74 50                	je     80105948 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
801058f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
801058ff:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105903:	eb 13                	jmp    80105918 <_ZN3Map11extractProcEP4proc+0x38>
80105905:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105908:	89 1c 24             	mov    %ebx,(%esp)
8010590b:	e8 10 fe ff ff       	call   80105720 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105910:	39 f0                	cmp    %esi,%eax
80105912:	75 1c                	jne    80105930 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105914:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105918:	8b 03                	mov    (%ebx),%eax
8010591a:	85 c0                	test   %eax,%eax
8010591c:	75 ea                	jne    80105908 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010591e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105921:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80105923:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105927:	83 c4 30             	add    $0x30,%esp
8010592a:	5b                   	pop    %ebx
8010592b:	5e                   	pop    %esi
8010592c:	5d                   	pop    %ebp
8010592d:	c3                   	ret    
8010592e:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80105930:	89 44 24 04          	mov    %eax,0x4(%esp)
80105934:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105937:	89 04 24             	mov    %eax,(%esp)
8010593a:	e8 21 fd ff ff       	call   80105660 <_ZN3Map3putEP4proc>
8010593f:	eb d7                	jmp    80105918 <_ZN3Map11extractProcEP4proc+0x38>
80105941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105948:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
8010594c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105950:	83 c4 30             	add    $0x30,%esp
80105953:	5b                   	pop    %ebx
80105954:	5e                   	pop    %esi
80105955:	5d                   	pop    %ebp
80105956:	c3                   	ret    
80105957:	89 f6                	mov    %esi,%esi
80105959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105960 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105966:	8b 45 08             	mov    0x8(%ebp),%eax
80105969:	89 44 24 04          	mov    %eax,0x4(%esp)
8010596d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105972:	89 04 24             	mov    %eax,(%esp)
80105975:	e8 66 ff ff ff       	call   801058e0 <_ZN3Map11extractProcEP4proc>
}
8010597a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010597b:	0f b6 c0             	movzbl %al,%eax
}
8010597e:	c3                   	ret    
8010597f:	90                   	nop

80105980 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
80105985:	53                   	push   %ebx
80105986:	83 ec 2c             	sub    $0x2c,%esp
80105989:	8b 45 08             	mov    0x8(%ebp),%eax
8010598c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010598f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105992:	8b 45 10             	mov    0x10(%ebp),%eax
80105995:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105998:	8b 55 14             	mov    0x14(%ebp),%edx
8010599b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010599e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
801059a0:	09 c2                	or     %eax,%edx
801059a2:	0f 84 9a 00 00 00    	je     80105a42 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
801059a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
801059ab:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
801059af:	85 c0                	test   %eax,%eax
801059b1:	79 0e                	jns    801059c1 <__moddi3+0x41>
		number = -number;
801059b3:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801059b6:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
801059ba:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801059be:	f7 5d e4             	negl   -0x1c(%ebp)
801059c1:	8b 55 d8             	mov    -0x28(%ebp),%edx
801059c4:	89 f8                	mov    %edi,%eax
801059c6:	c1 ff 1f             	sar    $0x1f,%edi
801059c9:	31 f8                	xor    %edi,%eax
801059cb:	89 f9                	mov    %edi,%ecx
801059cd:	31 fa                	xor    %edi,%edx
801059cf:	89 c7                	mov    %eax,%edi
801059d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059d4:	89 d6                	mov    %edx,%esi
801059d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801059d9:	29 ce                	sub    %ecx,%esi
801059db:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801059dd:	39 fa                	cmp    %edi,%edx
801059df:	7d 1f                	jge    80105a00 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
801059e1:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
801059e5:	74 07                	je     801059ee <__moddi3+0x6e>
801059e7:	f7 d8                	neg    %eax
801059e9:	83 d2 00             	adc    $0x0,%edx
801059ec:	f7 da                	neg    %edx
	}
}
801059ee:	83 c4 2c             	add    $0x2c,%esp
801059f1:	5b                   	pop    %ebx
801059f2:	5e                   	pop    %esi
801059f3:	5f                   	pop    %edi
801059f4:	5d                   	pop    %ebp
801059f5:	c3                   	ret    
801059f6:	8d 76 00             	lea    0x0(%esi),%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105a00:	7f 04                	jg     80105a06 <__moddi3+0x86>
80105a02:	39 f0                	cmp    %esi,%eax
80105a04:	72 db                	jb     801059e1 <__moddi3+0x61>
80105a06:	89 f1                	mov    %esi,%ecx
80105a08:	89 fb                	mov    %edi,%ebx
80105a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105a10:	29 c8                	sub    %ecx,%eax
80105a12:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105a14:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105a18:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
80105a1a:	39 da                	cmp    %ebx,%edx
80105a1c:	7f f2                	jg     80105a10 <__moddi3+0x90>
80105a1e:	7d 18                	jge    80105a38 <__moddi3+0xb8>
		if(number < divisor)
80105a20:	39 d7                	cmp    %edx,%edi
80105a22:	7c b9                	jl     801059dd <__moddi3+0x5d>
80105a24:	7f bb                	jg     801059e1 <__moddi3+0x61>
80105a26:	39 c6                	cmp    %eax,%esi
80105a28:	76 b3                	jbe    801059dd <__moddi3+0x5d>
80105a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a30:	eb af                	jmp    801059e1 <__moddi3+0x61>
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
80105a38:	39 c8                	cmp    %ecx,%eax
80105a3a:	73 d4                	jae    80105a10 <__moddi3+0x90>
80105a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a40:	eb de                	jmp    80105a20 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
80105a42:	c7 04 24 0c 91 10 80 	movl   $0x8010910c,(%esp)
80105a49:	e8 22 a9 ff ff       	call   80100370 <panic>
80105a4e:	66 90                	xchg   %ax,%ax

80105a50 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105a50:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105a51:	b8 1f 91 10 80       	mov    $0x8010911f,%eax
{
80105a56:	89 e5                	mov    %esp,%ebp
80105a58:	53                   	push   %ebx
80105a59:	83 ec 14             	sub    $0x14,%esp
80105a5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80105a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a63:	8d 43 04             	lea    0x4(%ebx),%eax
80105a66:	89 04 24             	mov    %eax,(%esp)
80105a69:	e8 12 01 00 00       	call   80105b80 <initlock>
  lk->name = name;
80105a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105a71:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105a77:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80105a7e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105a81:	83 c4 14             	add    $0x14,%esp
80105a84:	5b                   	pop    %ebx
80105a85:	5d                   	pop    %ebp
80105a86:	c3                   	ret    
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a90 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	56                   	push   %esi
80105a94:	53                   	push   %ebx
80105a95:	83 ec 10             	sub    $0x10,%esp
80105a98:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a9b:	8d 73 04             	lea    0x4(%ebx),%esi
80105a9e:	89 34 24             	mov    %esi,(%esp)
80105aa1:	e8 2a 02 00 00       	call   80105cd0 <acquire>
  while (lk->locked) {
80105aa6:	8b 13                	mov    (%ebx),%edx
80105aa8:	85 d2                	test   %edx,%edx
80105aaa:	74 16                	je     80105ac2 <acquiresleep+0x32>
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105ab0:	89 74 24 04          	mov    %esi,0x4(%esp)
80105ab4:	89 1c 24             	mov    %ebx,(%esp)
80105ab7:	e8 64 ec ff ff       	call   80104720 <sleep>
  while (lk->locked) {
80105abc:	8b 03                	mov    (%ebx),%eax
80105abe:	85 c0                	test   %eax,%eax
80105ac0:	75 ee                	jne    80105ab0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105ac2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105ac8:	e8 93 de ff ff       	call   80103960 <myproc>
80105acd:	8b 40 10             	mov    0x10(%eax),%eax
80105ad0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105ad3:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105ad6:	83 c4 10             	add    $0x10,%esp
80105ad9:	5b                   	pop    %ebx
80105ada:	5e                   	pop    %esi
80105adb:	5d                   	pop    %ebp
  release(&lk->lk);
80105adc:	e9 8f 02 00 00       	jmp    80105d70 <release>
80105ae1:	eb 0d                	jmp    80105af0 <releasesleep>
80105ae3:	90                   	nop
80105ae4:	90                   	nop
80105ae5:	90                   	nop
80105ae6:	90                   	nop
80105ae7:	90                   	nop
80105ae8:	90                   	nop
80105ae9:	90                   	nop
80105aea:	90                   	nop
80105aeb:	90                   	nop
80105aec:	90                   	nop
80105aed:	90                   	nop
80105aee:	90                   	nop
80105aef:	90                   	nop

80105af0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 18             	sub    $0x18,%esp
80105af6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105afc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
80105aff:	8d 73 04             	lea    0x4(%ebx),%esi
80105b02:	89 34 24             	mov    %esi,(%esp)
80105b05:	e8 c6 01 00 00       	call   80105cd0 <acquire>
  lk->locked = 0;
80105b0a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105b10:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105b17:	89 1c 24             	mov    %ebx,(%esp)
80105b1a:	e8 e1 ef ff ff       	call   80104b00 <wakeup>
  release(&lk->lk);
}
80105b1f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105b22:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105b25:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105b28:	89 ec                	mov    %ebp,%esp
80105b2a:	5d                   	pop    %ebp
  release(&lk->lk);
80105b2b:	e9 40 02 00 00       	jmp    80105d70 <release>

80105b30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 28             	sub    $0x28,%esp
80105b36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105b39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b3c:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105b3f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105b42:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105b44:	8d 7b 04             	lea    0x4(%ebx),%edi
80105b47:	89 3c 24             	mov    %edi,(%esp)
80105b4a:	e8 81 01 00 00       	call   80105cd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105b4f:	8b 03                	mov    (%ebx),%eax
80105b51:	85 c0                	test   %eax,%eax
80105b53:	74 11                	je     80105b66 <holdingsleep+0x36>
80105b55:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105b58:	e8 03 de ff ff       	call   80103960 <myproc>
80105b5d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105b60:	0f 94 c0             	sete   %al
80105b63:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105b66:	89 3c 24             	mov    %edi,(%esp)
80105b69:	e8 02 02 00 00       	call   80105d70 <release>
  return r;
}
80105b6e:	89 f0                	mov    %esi,%eax
80105b70:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105b73:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105b76:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105b79:	89 ec                	mov    %ebp,%esp
80105b7b:	5d                   	pop    %ebp
80105b7c:	c3                   	ret    
80105b7d:	66 90                	xchg   %ax,%ax
80105b7f:	90                   	nop

80105b80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105b86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105b89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105b8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105b92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105b99:	5d                   	pop    %ebp
80105b9a:	c3                   	ret    
80105b9b:	90                   	nop
80105b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ba0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105ba0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105ba1:	31 d2                	xor    %edx,%edx
{
80105ba3:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105ba5:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105ba8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105bab:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105bac:	83 e8 08             	sub    $0x8,%eax
80105baf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105bb0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105bb6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105bbc:	77 12                	ja     80105bd0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105bbe:	8b 58 04             	mov    0x4(%eax),%ebx
80105bc1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105bc4:	42                   	inc    %edx
80105bc5:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105bc8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105bca:	75 e4                	jne    80105bb0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105bcc:	5b                   	pop    %ebx
80105bcd:	5d                   	pop    %ebp
80105bce:	c3                   	ret    
80105bcf:	90                   	nop
80105bd0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105bd3:	83 c1 28             	add    $0x28,%ecx
80105bd6:	8d 76 00             	lea    0x0(%esi),%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105be0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105be6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105be9:	39 c1                	cmp    %eax,%ecx
80105beb:	75 f3                	jne    80105be0 <getcallerpcs+0x40>
}
80105bed:	5b                   	pop    %ebx
80105bee:	5d                   	pop    %ebp
80105bef:	c3                   	ret    

80105bf0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
80105bf4:	83 ec 04             	sub    $0x4,%esp
80105bf7:	9c                   	pushf  
80105bf8:	5b                   	pop    %ebx
  asm volatile("cli");
80105bf9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105bfa:	e8 c1 dc ff ff       	call   801038c0 <mycpu>
80105bff:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105c05:	85 d2                	test   %edx,%edx
80105c07:	75 11                	jne    80105c1a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105c09:	e8 b2 dc ff ff       	call   801038c0 <mycpu>
80105c0e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105c14:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105c1a:	e8 a1 dc ff ff       	call   801038c0 <mycpu>
80105c1f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105c25:	58                   	pop    %eax
80105c26:	5b                   	pop    %ebx
80105c27:	5d                   	pop    %ebp
80105c28:	c3                   	ret    
80105c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c30 <popcli>:

void
popcli(void)
{
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105c36:	9c                   	pushf  
80105c37:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105c38:	f6 c4 02             	test   $0x2,%ah
80105c3b:	75 35                	jne    80105c72 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105c3d:	e8 7e dc ff ff       	call   801038c0 <mycpu>
80105c42:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105c48:	78 34                	js     80105c7e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105c4a:	e8 71 dc ff ff       	call   801038c0 <mycpu>
80105c4f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105c55:	85 d2                	test   %edx,%edx
80105c57:	74 07                	je     80105c60 <popcli+0x30>
    sti();
}
80105c59:	c9                   	leave  
80105c5a:	c3                   	ret    
80105c5b:	90                   	nop
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105c60:	e8 5b dc ff ff       	call   801038c0 <mycpu>
80105c65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105c6b:	85 c0                	test   %eax,%eax
80105c6d:	74 ea                	je     80105c59 <popcli+0x29>
  asm volatile("sti");
80105c6f:	fb                   	sti    
}
80105c70:	c9                   	leave  
80105c71:	c3                   	ret    
    panic("popcli - interruptible");
80105c72:	c7 04 24 2a 91 10 80 	movl   $0x8010912a,(%esp)
80105c79:	e8 f2 a6 ff ff       	call   80100370 <panic>
    panic("popcli");
80105c7e:	c7 04 24 41 91 10 80 	movl   $0x80109141,(%esp)
80105c85:	e8 e6 a6 ff ff       	call   80100370 <panic>
80105c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c90 <holding>:
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	83 ec 08             	sub    $0x8,%esp
80105c96:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105c99:	8b 75 08             	mov    0x8(%ebp),%esi
80105c9c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105c9f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105ca1:	e8 4a ff ff ff       	call   80105bf0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105ca6:	8b 06                	mov    (%esi),%eax
80105ca8:	85 c0                	test   %eax,%eax
80105caa:	74 10                	je     80105cbc <holding+0x2c>
80105cac:	8b 5e 08             	mov    0x8(%esi),%ebx
80105caf:	e8 0c dc ff ff       	call   801038c0 <mycpu>
80105cb4:	39 c3                	cmp    %eax,%ebx
80105cb6:	0f 94 c3             	sete   %bl
80105cb9:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105cbc:	e8 6f ff ff ff       	call   80105c30 <popcli>
}
80105cc1:	89 d8                	mov    %ebx,%eax
80105cc3:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105cc6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105cc9:	89 ec                	mov    %ebp,%esp
80105ccb:	5d                   	pop    %ebp
80105ccc:	c3                   	ret    
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi

80105cd0 <acquire>:
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	56                   	push   %esi
80105cd4:	53                   	push   %ebx
80105cd5:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105cd8:	e8 13 ff ff ff       	call   80105bf0 <pushcli>
  if(holding(lk))
80105cdd:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105ce0:	89 1c 24             	mov    %ebx,(%esp)
80105ce3:	e8 a8 ff ff ff       	call   80105c90 <holding>
80105ce8:	85 c0                	test   %eax,%eax
80105cea:	75 78                	jne    80105d64 <acquire+0x94>
80105cec:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105cee:	ba 01 00 00 00       	mov    $0x1,%edx
80105cf3:	eb 06                	jmp    80105cfb <acquire+0x2b>
80105cf5:	8d 76 00             	lea    0x0(%esi),%esi
80105cf8:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105cfb:	89 d0                	mov    %edx,%eax
80105cfd:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105d00:	85 c0                	test   %eax,%eax
80105d02:	75 f4                	jne    80105cf8 <acquire+0x28>
  __sync_synchronize();
80105d04:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105d0c:	e8 af db ff ff       	call   801038c0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105d11:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105d14:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105d17:	89 e8                	mov    %ebp,%eax
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105d20:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105d26:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105d2c:	77 1a                	ja     80105d48 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105d2e:	8b 48 04             	mov    0x4(%eax),%ecx
80105d31:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105d34:	46                   	inc    %esi
80105d35:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105d38:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105d3a:	75 e4                	jne    80105d20 <acquire+0x50>
}
80105d3c:	83 c4 10             	add    $0x10,%esp
80105d3f:	5b                   	pop    %ebx
80105d40:	5e                   	pop    %esi
80105d41:	5d                   	pop    %ebp
80105d42:	c3                   	ret    
80105d43:	90                   	nop
80105d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d48:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105d4b:	83 c2 28             	add    $0x28,%edx
80105d4e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105d50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105d56:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105d59:	39 d0                	cmp    %edx,%eax
80105d5b:	75 f3                	jne    80105d50 <acquire+0x80>
}
80105d5d:	83 c4 10             	add    $0x10,%esp
80105d60:	5b                   	pop    %ebx
80105d61:	5e                   	pop    %esi
80105d62:	5d                   	pop    %ebp
80105d63:	c3                   	ret    
    panic("acquire");
80105d64:	c7 04 24 48 91 10 80 	movl   $0x80109148,(%esp)
80105d6b:	e8 00 a6 ff ff       	call   80100370 <panic>

80105d70 <release>:
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	53                   	push   %ebx
80105d74:	83 ec 14             	sub    $0x14,%esp
80105d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105d7a:	89 1c 24             	mov    %ebx,(%esp)
80105d7d:	e8 0e ff ff ff       	call   80105c90 <holding>
80105d82:	85 c0                	test   %eax,%eax
80105d84:	74 23                	je     80105da9 <release+0x39>
  lk->pcs[0] = 0;
80105d86:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105d8d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105d94:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105d99:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105d9f:	83 c4 14             	add    $0x14,%esp
80105da2:	5b                   	pop    %ebx
80105da3:	5d                   	pop    %ebp
  popcli();
80105da4:	e9 87 fe ff ff       	jmp    80105c30 <popcli>
    panic("release");
80105da9:	c7 04 24 50 91 10 80 	movl   $0x80109150,(%esp)
80105db0:	e8 bb a5 ff ff       	call   80100370 <panic>
80105db5:	66 90                	xchg   %ax,%ax
80105db7:	66 90                	xchg   %ax,%ax
80105db9:	66 90                	xchg   %ax,%ax
80105dbb:	66 90                	xchg   %ax,%ax
80105dbd:	66 90                	xchg   %ax,%ax
80105dbf:	90                   	nop

80105dc0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	83 ec 08             	sub    $0x8,%esp
80105dc6:	8b 55 08             	mov    0x8(%ebp),%edx
80105dc9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105dcc:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105dcf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105dd2:	f6 c2 03             	test   $0x3,%dl
80105dd5:	75 05                	jne    80105ddc <memset+0x1c>
80105dd7:	f6 c1 03             	test   $0x3,%cl
80105dda:	74 14                	je     80105df0 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105ddc:	89 d7                	mov    %edx,%edi
80105dde:	8b 45 0c             	mov    0xc(%ebp),%eax
80105de1:	fc                   	cld    
80105de2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105de4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105de7:	89 d0                	mov    %edx,%eax
80105de9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105dec:	89 ec                	mov    %ebp,%esp
80105dee:	5d                   	pop    %ebp
80105def:	c3                   	ret    
    c &= 0xFF;
80105df0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105df4:	c1 e9 02             	shr    $0x2,%ecx
80105df7:	89 f8                	mov    %edi,%eax
80105df9:	89 fb                	mov    %edi,%ebx
80105dfb:	c1 e0 18             	shl    $0x18,%eax
80105dfe:	c1 e3 10             	shl    $0x10,%ebx
80105e01:	09 d8                	or     %ebx,%eax
80105e03:	09 f8                	or     %edi,%eax
80105e05:	c1 e7 08             	shl    $0x8,%edi
80105e08:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105e0a:	89 d7                	mov    %edx,%edi
80105e0c:	fc                   	cld    
80105e0d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105e0f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105e12:	89 d0                	mov    %edx,%eax
80105e14:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105e17:	89 ec                	mov    %ebp,%esp
80105e19:	5d                   	pop    %ebp
80105e1a:	c3                   	ret    
80105e1b:	90                   	nop
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e20 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	57                   	push   %edi
80105e24:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105e27:	56                   	push   %esi
80105e28:	8b 75 08             	mov    0x8(%ebp),%esi
80105e2b:	53                   	push   %ebx
80105e2c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105e2f:	85 db                	test   %ebx,%ebx
80105e31:	74 27                	je     80105e5a <memcmp+0x3a>
    if(*s1 != *s2)
80105e33:	0f b6 16             	movzbl (%esi),%edx
80105e36:	0f b6 0f             	movzbl (%edi),%ecx
80105e39:	38 d1                	cmp    %dl,%cl
80105e3b:	75 2b                	jne    80105e68 <memcmp+0x48>
80105e3d:	b8 01 00 00 00       	mov    $0x1,%eax
80105e42:	eb 12                	jmp    80105e56 <memcmp+0x36>
80105e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e48:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105e4c:	40                   	inc    %eax
80105e4d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105e52:	38 ca                	cmp    %cl,%dl
80105e54:	75 12                	jne    80105e68 <memcmp+0x48>
  while(n-- > 0){
80105e56:	39 d8                	cmp    %ebx,%eax
80105e58:	75 ee                	jne    80105e48 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105e5a:	5b                   	pop    %ebx
  return 0;
80105e5b:	31 c0                	xor    %eax,%eax
}
80105e5d:	5e                   	pop    %esi
80105e5e:	5f                   	pop    %edi
80105e5f:	5d                   	pop    %ebp
80105e60:	c3                   	ret    
80105e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e68:	5b                   	pop    %ebx
      return *s1 - *s2;
80105e69:	0f b6 c2             	movzbl %dl,%eax
80105e6c:	29 c8                	sub    %ecx,%eax
}
80105e6e:	5e                   	pop    %esi
80105e6f:	5f                   	pop    %edi
80105e70:	5d                   	pop    %ebp
80105e71:	c3                   	ret    
80105e72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e80 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	56                   	push   %esi
80105e84:	8b 45 08             	mov    0x8(%ebp),%eax
80105e87:	53                   	push   %ebx
80105e88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105e8b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105e8e:	39 c3                	cmp    %eax,%ebx
80105e90:	73 26                	jae    80105eb8 <memmove+0x38>
80105e92:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105e95:	39 c8                	cmp    %ecx,%eax
80105e97:	73 1f                	jae    80105eb8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105e99:	85 f6                	test   %esi,%esi
80105e9b:	8d 56 ff             	lea    -0x1(%esi),%edx
80105e9e:	74 0d                	je     80105ead <memmove+0x2d>
      *--d = *--s;
80105ea0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ea4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105ea7:	4a                   	dec    %edx
80105ea8:	83 fa ff             	cmp    $0xffffffff,%edx
80105eab:	75 f3                	jne    80105ea0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105ead:	5b                   	pop    %ebx
80105eae:	5e                   	pop    %esi
80105eaf:	5d                   	pop    %ebp
80105eb0:	c3                   	ret    
80105eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105eb8:	31 d2                	xor    %edx,%edx
80105eba:	85 f6                	test   %esi,%esi
80105ebc:	74 ef                	je     80105ead <memmove+0x2d>
80105ebe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105ec0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ec4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105ec7:	42                   	inc    %edx
    while(n-- > 0)
80105ec8:	39 d6                	cmp    %edx,%esi
80105eca:	75 f4                	jne    80105ec0 <memmove+0x40>
}
80105ecc:	5b                   	pop    %ebx
80105ecd:	5e                   	pop    %esi
80105ece:	5d                   	pop    %ebp
80105ecf:	c3                   	ret    

80105ed0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105ed3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105ed4:	eb aa                	jmp    80105e80 <memmove>
80105ed6:	8d 76 00             	lea    0x0(%esi),%esi
80105ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ee0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	57                   	push   %edi
80105ee4:	8b 7d 10             	mov    0x10(%ebp),%edi
80105ee7:	56                   	push   %esi
80105ee8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105eeb:	53                   	push   %ebx
80105eec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105eef:	85 ff                	test   %edi,%edi
80105ef1:	74 2d                	je     80105f20 <strncmp+0x40>
80105ef3:	0f b6 03             	movzbl (%ebx),%eax
80105ef6:	0f b6 0e             	movzbl (%esi),%ecx
80105ef9:	84 c0                	test   %al,%al
80105efb:	74 37                	je     80105f34 <strncmp+0x54>
80105efd:	38 c1                	cmp    %al,%cl
80105eff:	75 33                	jne    80105f34 <strncmp+0x54>
80105f01:	01 f7                	add    %esi,%edi
80105f03:	eb 13                	jmp    80105f18 <strncmp+0x38>
80105f05:	8d 76 00             	lea    0x0(%esi),%esi
80105f08:	0f b6 03             	movzbl (%ebx),%eax
80105f0b:	84 c0                	test   %al,%al
80105f0d:	74 21                	je     80105f30 <strncmp+0x50>
80105f0f:	0f b6 0a             	movzbl (%edx),%ecx
80105f12:	89 d6                	mov    %edx,%esi
80105f14:	38 c8                	cmp    %cl,%al
80105f16:	75 1c                	jne    80105f34 <strncmp+0x54>
    n--, p++, q++;
80105f18:	8d 56 01             	lea    0x1(%esi),%edx
80105f1b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105f1c:	39 fa                	cmp    %edi,%edx
80105f1e:	75 e8                	jne    80105f08 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105f20:	5b                   	pop    %ebx
    return 0;
80105f21:	31 c0                	xor    %eax,%eax
}
80105f23:	5e                   	pop    %esi
80105f24:	5f                   	pop    %edi
80105f25:	5d                   	pop    %ebp
80105f26:	c3                   	ret    
80105f27:	89 f6                	mov    %esi,%esi
80105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f30:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105f34:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105f35:	29 c8                	sub    %ecx,%eax
}
80105f37:	5e                   	pop    %esi
80105f38:	5f                   	pop    %edi
80105f39:	5d                   	pop    %ebp
80105f3a:	c3                   	ret    
80105f3b:	90                   	nop
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	8b 45 08             	mov    0x8(%ebp),%eax
80105f46:	56                   	push   %esi
80105f47:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105f4a:	53                   	push   %ebx
80105f4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105f4e:	89 c2                	mov    %eax,%edx
80105f50:	eb 15                	jmp    80105f67 <strncpy+0x27>
80105f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f58:	46                   	inc    %esi
80105f59:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105f5d:	42                   	inc    %edx
80105f5e:	84 c9                	test   %cl,%cl
80105f60:	88 4a ff             	mov    %cl,-0x1(%edx)
80105f63:	74 09                	je     80105f6e <strncpy+0x2e>
80105f65:	89 d9                	mov    %ebx,%ecx
80105f67:	85 c9                	test   %ecx,%ecx
80105f69:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105f6c:	7f ea                	jg     80105f58 <strncpy+0x18>
    ;
  while(n-- > 0)
80105f6e:	31 c9                	xor    %ecx,%ecx
80105f70:	85 db                	test   %ebx,%ebx
80105f72:	7e 19                	jle    80105f8d <strncpy+0x4d>
80105f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105f80:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105f84:	89 de                	mov    %ebx,%esi
80105f86:	41                   	inc    %ecx
80105f87:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105f89:	85 f6                	test   %esi,%esi
80105f8b:	7f f3                	jg     80105f80 <strncpy+0x40>
  return os;
}
80105f8d:	5b                   	pop    %ebx
80105f8e:	5e                   	pop    %esi
80105f8f:	5d                   	pop    %ebp
80105f90:	c3                   	ret    
80105f91:	eb 0d                	jmp    80105fa0 <safestrcpy>
80105f93:	90                   	nop
80105f94:	90                   	nop
80105f95:	90                   	nop
80105f96:	90                   	nop
80105f97:	90                   	nop
80105f98:	90                   	nop
80105f99:	90                   	nop
80105f9a:	90                   	nop
80105f9b:	90                   	nop
80105f9c:	90                   	nop
80105f9d:	90                   	nop
80105f9e:	90                   	nop
80105f9f:	90                   	nop

80105fa0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105fa6:	56                   	push   %esi
80105fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80105faa:	53                   	push   %ebx
80105fab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105fae:	85 c9                	test   %ecx,%ecx
80105fb0:	7e 22                	jle    80105fd4 <safestrcpy+0x34>
80105fb2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105fb6:	89 c1                	mov    %eax,%ecx
80105fb8:	eb 13                	jmp    80105fcd <safestrcpy+0x2d>
80105fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105fc0:	42                   	inc    %edx
80105fc1:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105fc5:	41                   	inc    %ecx
80105fc6:	84 db                	test   %bl,%bl
80105fc8:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105fcb:	74 04                	je     80105fd1 <safestrcpy+0x31>
80105fcd:	39 f2                	cmp    %esi,%edx
80105fcf:	75 ef                	jne    80105fc0 <safestrcpy+0x20>
    ;
  *s = 0;
80105fd1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105fd4:	5b                   	pop    %ebx
80105fd5:	5e                   	pop    %esi
80105fd6:	5d                   	pop    %ebp
80105fd7:	c3                   	ret    
80105fd8:	90                   	nop
80105fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fe0 <strlen>:

int
strlen(const char *s)
{
80105fe0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105fe1:	31 c0                	xor    %eax,%eax
{
80105fe3:	89 e5                	mov    %esp,%ebp
80105fe5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105fe8:	80 3a 00             	cmpb   $0x0,(%edx)
80105feb:	74 0a                	je     80105ff7 <strlen+0x17>
80105fed:	8d 76 00             	lea    0x0(%esi),%esi
80105ff0:	40                   	inc    %eax
80105ff1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105ff5:	75 f9                	jne    80105ff0 <strlen+0x10>
    ;
  return n;
}
80105ff7:	5d                   	pop    %ebp
80105ff8:	c3                   	ret    

80105ff9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105ff9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105ffd:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80106001:	55                   	push   %ebp
  pushl %ebx
80106002:	53                   	push   %ebx
  pushl %esi
80106003:	56                   	push   %esi
  pushl %edi
80106004:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106005:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80106007:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80106009:	5f                   	pop    %edi
  popl %esi
8010600a:	5e                   	pop    %esi
  popl %ebx
8010600b:	5b                   	pop    %ebx
  popl %ebp
8010600c:	5d                   	pop    %ebp
  ret
8010600d:	c3                   	ret    
8010600e:	66 90                	xchg   %ax,%ax

80106010 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip) {
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	53                   	push   %ebx
80106014:	83 ec 04             	sub    $0x4,%esp
80106017:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *curproc = myproc();
8010601a:	e8 41 d9 ff ff       	call   80103960 <myproc>

    if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010601f:	8b 00                	mov    (%eax),%eax
80106021:	39 d8                	cmp    %ebx,%eax
80106023:	76 1b                	jbe    80106040 <fetchint+0x30>
80106025:	8d 53 04             	lea    0x4(%ebx),%edx
80106028:	39 d0                	cmp    %edx,%eax
8010602a:	72 14                	jb     80106040 <fetchint+0x30>
        return -1;
    *ip = *(int *) (addr);
8010602c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010602f:	8b 13                	mov    (%ebx),%edx
80106031:	89 10                	mov    %edx,(%eax)
    return 0;
80106033:	31 c0                	xor    %eax,%eax
}
80106035:	5a                   	pop    %edx
80106036:	5b                   	pop    %ebx
80106037:	5d                   	pop    %ebp
80106038:	c3                   	ret    
80106039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106045:	eb ee                	jmp    80106035 <fetchint+0x25>
80106047:	89 f6                	mov    %esi,%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106050 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp) {
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	53                   	push   %ebx
80106054:	83 ec 04             	sub    $0x4,%esp
80106057:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char *s, *ep;
    struct proc *curproc = myproc();
8010605a:	e8 01 d9 ff ff       	call   80103960 <myproc>

    if (addr >= curproc->sz)
8010605f:	39 18                	cmp    %ebx,(%eax)
80106061:	76 27                	jbe    8010608a <fetchstr+0x3a>
        return -1;
    *pp = (char *) addr;
80106063:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106066:	89 da                	mov    %ebx,%edx
80106068:	89 19                	mov    %ebx,(%ecx)
    ep = (char *) curproc->sz;
8010606a:	8b 00                	mov    (%eax),%eax
    for (s = *pp; s < ep; s++) {
8010606c:	39 c3                	cmp    %eax,%ebx
8010606e:	73 1a                	jae    8010608a <fetchstr+0x3a>
        if (*s == 0)
80106070:	80 3b 00             	cmpb   $0x0,(%ebx)
80106073:	75 10                	jne    80106085 <fetchstr+0x35>
80106075:	eb 29                	jmp    801060a0 <fetchstr+0x50>
80106077:	89 f6                	mov    %esi,%esi
80106079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106080:	80 3a 00             	cmpb   $0x0,(%edx)
80106083:	74 13                	je     80106098 <fetchstr+0x48>
    for (s = *pp; s < ep; s++) {
80106085:	42                   	inc    %edx
80106086:	39 d0                	cmp    %edx,%eax
80106088:	77 f6                	ja     80106080 <fetchstr+0x30>
        return -1;
8010608a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
            return s - *pp;
    }
    return -1;
}
8010608f:	5a                   	pop    %edx
80106090:	5b                   	pop    %ebx
80106091:	5d                   	pop    %ebp
80106092:	c3                   	ret    
80106093:	90                   	nop
80106094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106098:	89 d0                	mov    %edx,%eax
8010609a:	5a                   	pop    %edx
8010609b:	29 d8                	sub    %ebx,%eax
8010609d:	5b                   	pop    %ebx
8010609e:	5d                   	pop    %ebp
8010609f:	c3                   	ret    
        if (*s == 0)
801060a0:	31 c0                	xor    %eax,%eax
            return s - *pp;
801060a2:	eb eb                	jmp    8010608f <fetchstr+0x3f>
801060a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801060b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip) {
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	56                   	push   %esi
801060b4:	53                   	push   %ebx
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801060b5:	e8 a6 d8 ff ff       	call   80103960 <myproc>
801060ba:	8b 55 08             	mov    0x8(%ebp),%edx
801060bd:	8b 40 18             	mov    0x18(%eax),%eax
801060c0:	8b 40 44             	mov    0x44(%eax),%eax
801060c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    struct proc *curproc = myproc();
801060c6:	e8 95 d8 ff ff       	call   80103960 <myproc>
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801060cb:	8d 73 04             	lea    0x4(%ebx),%esi
    if (addr >= curproc->sz || addr + 4 > curproc->sz)
801060ce:	8b 00                	mov    (%eax),%eax
801060d0:	39 c6                	cmp    %eax,%esi
801060d2:	73 1c                	jae    801060f0 <argint+0x40>
801060d4:	8d 53 08             	lea    0x8(%ebx),%edx
801060d7:	39 d0                	cmp    %edx,%eax
801060d9:	72 15                	jb     801060f0 <argint+0x40>
    *ip = *(int *) (addr);
801060db:	8b 45 0c             	mov    0xc(%ebp),%eax
801060de:	8b 53 04             	mov    0x4(%ebx),%edx
801060e1:	89 10                	mov    %edx,(%eax)
    return 0;
801060e3:	31 c0                	xor    %eax,%eax
}
801060e5:	5b                   	pop    %ebx
801060e6:	5e                   	pop    %esi
801060e7:	5d                   	pop    %ebp
801060e8:	c3                   	ret    
801060e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801060f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801060f5:	eb ee                	jmp    801060e5 <argint+0x35>
801060f7:	89 f6                	mov    %esi,%esi
801060f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106100 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size) {
80106100:	55                   	push   %ebp
80106101:	89 e5                	mov    %esp,%ebp
80106103:	56                   	push   %esi
80106104:	53                   	push   %ebx
80106105:	83 ec 20             	sub    $0x20,%esp
80106108:	8b 5d 10             	mov    0x10(%ebp),%ebx
    int i;
    struct proc *curproc = myproc();
8010610b:	e8 50 d8 ff ff       	call   80103960 <myproc>
80106110:	89 c6                	mov    %eax,%esi

    if (argint(n, &i) < 0)
80106112:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106115:	89 44 24 04          	mov    %eax,0x4(%esp)
80106119:	8b 45 08             	mov    0x8(%ebp),%eax
8010611c:	89 04 24             	mov    %eax,(%esp)
8010611f:	e8 8c ff ff ff       	call   801060b0 <argint>
        return -1;
    if (size < 0 || (uint) i >= curproc->sz || (uint) i + size > curproc->sz)
80106124:	c1 e8 1f             	shr    $0x1f,%eax
80106127:	84 c0                	test   %al,%al
80106129:	75 2d                	jne    80106158 <argptr+0x58>
8010612b:	89 d8                	mov    %ebx,%eax
8010612d:	c1 e8 1f             	shr    $0x1f,%eax
80106130:	84 c0                	test   %al,%al
80106132:	75 24                	jne    80106158 <argptr+0x58>
80106134:	8b 16                	mov    (%esi),%edx
80106136:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106139:	39 c2                	cmp    %eax,%edx
8010613b:	76 1b                	jbe    80106158 <argptr+0x58>
8010613d:	01 c3                	add    %eax,%ebx
8010613f:	39 da                	cmp    %ebx,%edx
80106141:	72 15                	jb     80106158 <argptr+0x58>
        return -1;
    *pp = (char *) i;
80106143:	8b 55 0c             	mov    0xc(%ebp),%edx
80106146:	89 02                	mov    %eax,(%edx)
    return 0;
80106148:	31 c0                	xor    %eax,%eax
}
8010614a:	83 c4 20             	add    $0x20,%esp
8010614d:	5b                   	pop    %ebx
8010614e:	5e                   	pop    %esi
8010614f:	5d                   	pop    %ebp
80106150:	c3                   	ret    
80106151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010615d:	eb eb                	jmp    8010614a <argptr+0x4a>
8010615f:	90                   	nop

80106160 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp) {
80106160:	55                   	push   %ebp
80106161:	89 e5                	mov    %esp,%ebp
80106163:	83 ec 28             	sub    $0x28,%esp
    int addr;
    if (argint(n, &addr) < 0)
80106166:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106169:	89 44 24 04          	mov    %eax,0x4(%esp)
8010616d:	8b 45 08             	mov    0x8(%ebp),%eax
80106170:	89 04 24             	mov    %eax,(%esp)
80106173:	e8 38 ff ff ff       	call   801060b0 <argint>
80106178:	85 c0                	test   %eax,%eax
8010617a:	78 14                	js     80106190 <argstr+0x30>
        return -1;
    return fetchstr(addr, pp);
8010617c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010617f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106183:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106186:	89 04 24             	mov    %eax,(%esp)
80106189:	e8 c2 fe ff ff       	call   80106050 <fetchstr>
}
8010618e:	c9                   	leave  
8010618f:	c3                   	ret    
        return -1;
80106190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106195:	c9                   	leave  
80106196:	c3                   	ret    
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061a0 <syscall>:
        [SYS_policy]  sys_policy,
	    [SYS_wait_stat] sys_wait_stat
};

void
syscall(void) {
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	53                   	push   %ebx
801061a4:	83 ec 14             	sub    $0x14,%esp
    int num;
    struct proc *curproc = myproc();
801061a7:	e8 b4 d7 ff ff       	call   80103960 <myproc>
801061ac:	89 c3                	mov    %eax,%ebx

    num = curproc->tf->eax;
801061ae:	8b 40 18             	mov    0x18(%eax),%eax
801061b1:	8b 40 1c             	mov    0x1c(%eax),%eax
    if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801061b4:	8d 50 ff             	lea    -0x1(%eax),%edx
801061b7:	83 fa 18             	cmp    $0x18,%edx
801061ba:	77 1c                	ja     801061d8 <syscall+0x38>
801061bc:	8b 14 85 80 91 10 80 	mov    -0x7fef6e80(,%eax,4),%edx
801061c3:	85 d2                	test   %edx,%edx
801061c5:	74 11                	je     801061d8 <syscall+0x38>
        curproc->tf->eax = syscalls[num]();
801061c7:	ff d2                	call   *%edx
801061c9:	8b 53 18             	mov    0x18(%ebx),%edx
801061cc:	89 42 1c             	mov    %eax,0x1c(%edx)
    } else {
        cprintf("%d %s: unknown sys call %d\n",
                curproc->pid, curproc->name, num);
        curproc->tf->eax = -1;
    }
}
801061cf:	83 c4 14             	add    $0x14,%esp
801061d2:	5b                   	pop    %ebx
801061d3:	5d                   	pop    %ebp
801061d4:	c3                   	ret    
801061d5:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("%d %s: unknown sys call %d\n",
801061d8:	89 44 24 0c          	mov    %eax,0xc(%esp)
                curproc->pid, curproc->name, num);
801061dc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801061df:	89 44 24 08          	mov    %eax,0x8(%esp)
        cprintf("%d %s: unknown sys call %d\n",
801061e3:	8b 43 10             	mov    0x10(%ebx),%eax
801061e6:	c7 04 24 58 91 10 80 	movl   $0x80109158,(%esp)
801061ed:	89 44 24 04          	mov    %eax,0x4(%esp)
801061f1:	e8 5a a4 ff ff       	call   80100650 <cprintf>
        curproc->tf->eax = -1;
801061f6:	8b 43 18             	mov    0x18(%ebx),%eax
801061f9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106200:	83 c4 14             	add    $0x14,%esp
80106203:	5b                   	pop    %ebx
80106204:	5d                   	pop    %ebp
80106205:	c3                   	ret    
80106206:	66 90                	xchg   %ax,%ax
80106208:	66 90                	xchg   %ax,%ax
8010620a:	66 90                	xchg   %ax,%ax
8010620c:	66 90                	xchg   %ax,%ax
8010620e:	66 90                	xchg   %ax,%ax

80106210 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106210:	55                   	push   %ebp
80106211:	0f bf d2             	movswl %dx,%edx
80106214:	89 e5                	mov    %esp,%ebp
80106216:	83 ec 58             	sub    $0x58,%esp
80106219:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010621c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80106220:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106223:	89 04 24             	mov    %eax,(%esp)
{
80106226:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106229:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010622c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010622f:	8d 7d da             	lea    -0x26(%ebp),%edi
80106232:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80106236:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80106239:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010623c:	e8 8f bd ff ff       	call   80101fd0 <nameiparent>
80106241:	85 c0                	test   %eax,%eax
80106243:	0f 84 4f 01 00 00    	je     80106398 <create+0x188>
    return 0;
  ilock(dp);
80106249:	89 04 24             	mov    %eax,(%esp)
8010624c:	89 c3                	mov    %eax,%ebx
8010624e:	e8 7d b4 ff ff       	call   801016d0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80106253:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80106256:	89 44 24 08          	mov    %eax,0x8(%esp)
8010625a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010625e:	89 1c 24             	mov    %ebx,(%esp)
80106261:	e8 ea b9 ff ff       	call   80101c50 <dirlookup>
80106266:	85 c0                	test   %eax,%eax
80106268:	89 c6                	mov    %eax,%esi
8010626a:	74 34                	je     801062a0 <create+0x90>
    iunlockput(dp);
8010626c:	89 1c 24             	mov    %ebx,(%esp)
8010626f:	e8 ec b6 ff ff       	call   80101960 <iunlockput>
    ilock(ip);
80106274:	89 34 24             	mov    %esi,(%esp)
80106277:	e8 54 b4 ff ff       	call   801016d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010627c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80106280:	0f 85 9a 00 00 00    	jne    80106320 <create+0x110>
80106286:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010628b:	0f 85 8f 00 00 00    	jne    80106320 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80106291:	89 f0                	mov    %esi,%eax
80106293:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106296:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106299:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010629c:	89 ec                	mov    %ebp,%esp
8010629e:	5d                   	pop    %ebp
8010629f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801062a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801062a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801062a7:	8b 03                	mov    (%ebx),%eax
801062a9:	89 04 24             	mov    %eax,(%esp)
801062ac:	e8 9f b2 ff ff       	call   80101550 <ialloc>
801062b1:	85 c0                	test   %eax,%eax
801062b3:	89 c6                	mov    %eax,%esi
801062b5:	0f 84 f0 00 00 00    	je     801063ab <create+0x19b>
  ilock(ip);
801062bb:	89 04 24             	mov    %eax,(%esp)
801062be:	e8 0d b4 ff ff       	call   801016d0 <ilock>
  ip->major = major;
801062c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
801062c6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
801062cc:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801062d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
801062d3:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
801062d7:	89 34 24             	mov    %esi,(%esp)
801062da:	e8 31 b3 ff ff       	call   80101610 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801062df:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
801062e3:	74 5b                	je     80106340 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801062e5:	8b 46 04             	mov    0x4(%esi),%eax
801062e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801062ec:	89 1c 24             	mov    %ebx,(%esp)
801062ef:	89 44 24 08          	mov    %eax,0x8(%esp)
801062f3:	e8 d8 bb ff ff       	call   80101ed0 <dirlink>
801062f8:	85 c0                	test   %eax,%eax
801062fa:	0f 88 9f 00 00 00    	js     8010639f <create+0x18f>
  iunlockput(dp);
80106300:	89 1c 24             	mov    %ebx,(%esp)
80106303:	e8 58 b6 ff ff       	call   80101960 <iunlockput>
}
80106308:	89 f0                	mov    %esi,%eax
8010630a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010630d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106310:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106313:	89 ec                	mov    %ebp,%esp
80106315:	5d                   	pop    %ebp
80106316:	c3                   	ret    
80106317:	89 f6                	mov    %esi,%esi
80106319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106320:	89 34 24             	mov    %esi,(%esp)
    return 0;
80106323:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106325:	e8 36 b6 ff ff       	call   80101960 <iunlockput>
}
8010632a:	89 f0                	mov    %esi,%eax
8010632c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010632f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106332:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106335:	89 ec                	mov    %ebp,%esp
80106337:	5d                   	pop    %ebp
80106338:	c3                   	ret    
80106339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106340:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106344:	89 1c 24             	mov    %ebx,(%esp)
80106347:	e8 c4 b2 ff ff       	call   80101610 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010634c:	8b 46 04             	mov    0x4(%esi),%eax
8010634f:	ba 04 92 10 80       	mov    $0x80109204,%edx
80106354:	89 54 24 04          	mov    %edx,0x4(%esp)
80106358:	89 34 24             	mov    %esi,(%esp)
8010635b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010635f:	e8 6c bb ff ff       	call   80101ed0 <dirlink>
80106364:	85 c0                	test   %eax,%eax
80106366:	78 20                	js     80106388 <create+0x178>
80106368:	8b 43 04             	mov    0x4(%ebx),%eax
8010636b:	89 34 24             	mov    %esi,(%esp)
8010636e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106372:	b8 03 92 10 80       	mov    $0x80109203,%eax
80106377:	89 44 24 04          	mov    %eax,0x4(%esp)
8010637b:	e8 50 bb ff ff       	call   80101ed0 <dirlink>
80106380:	85 c0                	test   %eax,%eax
80106382:	0f 89 5d ff ff ff    	jns    801062e5 <create+0xd5>
      panic("create dots");
80106388:	c7 04 24 f7 91 10 80 	movl   $0x801091f7,(%esp)
8010638f:	e8 dc 9f ff ff       	call   80100370 <panic>
80106394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106398:	31 f6                	xor    %esi,%esi
8010639a:	e9 f2 fe ff ff       	jmp    80106291 <create+0x81>
    panic("create: dirlink");
8010639f:	c7 04 24 06 92 10 80 	movl   $0x80109206,(%esp)
801063a6:	e8 c5 9f ff ff       	call   80100370 <panic>
    panic("create: ialloc");
801063ab:	c7 04 24 e8 91 10 80 	movl   $0x801091e8,(%esp)
801063b2:	e8 b9 9f ff ff       	call   80100370 <panic>
801063b7:	89 f6                	mov    %esi,%esi
801063b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063c0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	56                   	push   %esi
801063c4:	89 d6                	mov    %edx,%esi
801063c6:	53                   	push   %ebx
801063c7:	89 c3                	mov    %eax,%ebx
801063c9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801063cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801063d3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801063da:	e8 d1 fc ff ff       	call   801060b0 <argint>
801063df:	85 c0                	test   %eax,%eax
801063e1:	78 2d                	js     80106410 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801063e3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801063e7:	77 27                	ja     80106410 <argfd.constprop.0+0x50>
801063e9:	e8 72 d5 ff ff       	call   80103960 <myproc>
801063ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063f1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801063f5:	85 c0                	test   %eax,%eax
801063f7:	74 17                	je     80106410 <argfd.constprop.0+0x50>
  if(pfd)
801063f9:	85 db                	test   %ebx,%ebx
801063fb:	74 02                	je     801063ff <argfd.constprop.0+0x3f>
    *pfd = fd;
801063fd:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801063ff:	89 06                	mov    %eax,(%esi)
  return 0;
80106401:	31 c0                	xor    %eax,%eax
}
80106403:	83 c4 20             	add    $0x20,%esp
80106406:	5b                   	pop    %ebx
80106407:	5e                   	pop    %esi
80106408:	5d                   	pop    %ebp
80106409:	c3                   	ret    
8010640a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106415:	eb ec                	jmp    80106403 <argfd.constprop.0+0x43>
80106417:	89 f6                	mov    %esi,%esi
80106419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106420 <sys_dup>:
{
80106420:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106421:	31 c0                	xor    %eax,%eax
{
80106423:	89 e5                	mov    %esp,%ebp
80106425:	56                   	push   %esi
80106426:	53                   	push   %ebx
80106427:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
8010642a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010642d:	e8 8e ff ff ff       	call   801063c0 <argfd.constprop.0>
80106432:	85 c0                	test   %eax,%eax
80106434:	78 3a                	js     80106470 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80106436:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106439:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010643b:	e8 20 d5 ff ff       	call   80103960 <myproc>
80106440:	eb 0c                	jmp    8010644e <sys_dup+0x2e>
80106442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106448:	43                   	inc    %ebx
80106449:	83 fb 10             	cmp    $0x10,%ebx
8010644c:	74 22                	je     80106470 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010644e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106452:	85 d2                	test   %edx,%edx
80106454:	75 f2                	jne    80106448 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80106456:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010645a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010645d:	89 04 24             	mov    %eax,(%esp)
80106460:	e8 5b a9 ff ff       	call   80100dc0 <filedup>
}
80106465:	83 c4 20             	add    $0x20,%esp
80106468:	89 d8                	mov    %ebx,%eax
8010646a:	5b                   	pop    %ebx
8010646b:	5e                   	pop    %esi
8010646c:	5d                   	pop    %ebp
8010646d:	c3                   	ret    
8010646e:	66 90                	xchg   %ax,%ax
80106470:	83 c4 20             	add    $0x20,%esp
    return -1;
80106473:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80106478:	89 d8                	mov    %ebx,%eax
8010647a:	5b                   	pop    %ebx
8010647b:	5e                   	pop    %esi
8010647c:	5d                   	pop    %ebp
8010647d:	c3                   	ret    
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_read>:
{
80106480:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106481:	31 c0                	xor    %eax,%eax
{
80106483:	89 e5                	mov    %esp,%ebp
80106485:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106488:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010648b:	e8 30 ff ff ff       	call   801063c0 <argfd.constprop.0>
80106490:	85 c0                	test   %eax,%eax
80106492:	78 54                	js     801064e8 <sys_read+0x68>
80106494:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106497:	89 44 24 04          	mov    %eax,0x4(%esp)
8010649b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801064a2:	e8 09 fc ff ff       	call   801060b0 <argint>
801064a7:	85 c0                	test   %eax,%eax
801064a9:	78 3d                	js     801064e8 <sys_read+0x68>
801064ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064b5:	89 44 24 08          	mov    %eax,0x8(%esp)
801064b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801064c0:	e8 3b fc ff ff       	call   80106100 <argptr>
801064c5:	85 c0                	test   %eax,%eax
801064c7:	78 1f                	js     801064e8 <sys_read+0x68>
  return fileread(f, p, n);
801064c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064cc:	89 44 24 08          	mov    %eax,0x8(%esp)
801064d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801064d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801064da:	89 04 24             	mov    %eax,(%esp)
801064dd:	e8 5e aa ff ff       	call   80100f40 <fileread>
}
801064e2:	c9                   	leave  
801064e3:	c3                   	ret    
801064e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801064e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064ed:	c9                   	leave  
801064ee:	c3                   	ret    
801064ef:	90                   	nop

801064f0 <sys_write>:
{
801064f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801064f1:	31 c0                	xor    %eax,%eax
{
801064f3:	89 e5                	mov    %esp,%ebp
801064f5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801064f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801064fb:	e8 c0 fe ff ff       	call   801063c0 <argfd.constprop.0>
80106500:	85 c0                	test   %eax,%eax
80106502:	78 54                	js     80106558 <sys_write+0x68>
80106504:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106507:	89 44 24 04          	mov    %eax,0x4(%esp)
8010650b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106512:	e8 99 fb ff ff       	call   801060b0 <argint>
80106517:	85 c0                	test   %eax,%eax
80106519:	78 3d                	js     80106558 <sys_write+0x68>
8010651b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010651e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106525:	89 44 24 08          	mov    %eax,0x8(%esp)
80106529:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010652c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106530:	e8 cb fb ff ff       	call   80106100 <argptr>
80106535:	85 c0                	test   %eax,%eax
80106537:	78 1f                	js     80106558 <sys_write+0x68>
  return filewrite(f, p, n);
80106539:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010653c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106540:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106543:	89 44 24 04          	mov    %eax,0x4(%esp)
80106547:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010654a:	89 04 24             	mov    %eax,(%esp)
8010654d:	e8 9e aa ff ff       	call   80100ff0 <filewrite>
}
80106552:	c9                   	leave  
80106553:	c3                   	ret    
80106554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106558:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010655d:	c9                   	leave  
8010655e:	c3                   	ret    
8010655f:	90                   	nop

80106560 <sys_close>:
{
80106560:	55                   	push   %ebp
80106561:	89 e5                	mov    %esp,%ebp
80106563:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106566:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106569:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010656c:	e8 4f fe ff ff       	call   801063c0 <argfd.constprop.0>
80106571:	85 c0                	test   %eax,%eax
80106573:	78 23                	js     80106598 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106575:	e8 e6 d3 ff ff       	call   80103960 <myproc>
8010657a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010657d:	31 c9                	xor    %ecx,%ecx
8010657f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106583:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106586:	89 04 24             	mov    %eax,(%esp)
80106589:	e8 82 a8 ff ff       	call   80100e10 <fileclose>
  return 0;
8010658e:	31 c0                	xor    %eax,%eax
}
80106590:	c9                   	leave  
80106591:	c3                   	ret    
80106592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106598:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010659d:	c9                   	leave  
8010659e:	c3                   	ret    
8010659f:	90                   	nop

801065a0 <sys_fstat>:
{
801065a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801065a1:	31 c0                	xor    %eax,%eax
{
801065a3:	89 e5                	mov    %esp,%ebp
801065a5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801065a8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801065ab:	e8 10 fe ff ff       	call   801063c0 <argfd.constprop.0>
801065b0:	85 c0                	test   %eax,%eax
801065b2:	78 3c                	js     801065f0 <sys_fstat+0x50>
801065b4:	b8 14 00 00 00       	mov    $0x14,%eax
801065b9:	89 44 24 08          	mov    %eax,0x8(%esp)
801065bd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801065c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801065cb:	e8 30 fb ff ff       	call   80106100 <argptr>
801065d0:	85 c0                	test   %eax,%eax
801065d2:	78 1c                	js     801065f0 <sys_fstat+0x50>
  return filestat(f, st);
801065d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801065db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065de:	89 04 24             	mov    %eax,(%esp)
801065e1:	e8 0a a9 ff ff       	call   80100ef0 <filestat>
}
801065e6:	c9                   	leave  
801065e7:	c3                   	ret    
801065e8:	90                   	nop
801065e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801065f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065f5:	c9                   	leave  
801065f6:	c3                   	ret    
801065f7:	89 f6                	mov    %esi,%esi
801065f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106600 <sys_link>:
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	57                   	push   %edi
80106604:	56                   	push   %esi
80106605:	53                   	push   %ebx
80106606:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106609:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010660c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106610:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106617:	e8 44 fb ff ff       	call   80106160 <argstr>
8010661c:	85 c0                	test   %eax,%eax
8010661e:	0f 88 e5 00 00 00    	js     80106709 <sys_link+0x109>
80106624:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106627:	89 44 24 04          	mov    %eax,0x4(%esp)
8010662b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106632:	e8 29 fb ff ff       	call   80106160 <argstr>
80106637:	85 c0                	test   %eax,%eax
80106639:	0f 88 ca 00 00 00    	js     80106709 <sys_link+0x109>
  begin_op();
8010663f:	e8 2c c6 ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
80106644:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106647:	89 04 24             	mov    %eax,(%esp)
8010664a:	e8 61 b9 ff ff       	call   80101fb0 <namei>
8010664f:	85 c0                	test   %eax,%eax
80106651:	89 c3                	mov    %eax,%ebx
80106653:	0f 84 ab 00 00 00    	je     80106704 <sys_link+0x104>
  ilock(ip);
80106659:	89 04 24             	mov    %eax,(%esp)
8010665c:	e8 6f b0 ff ff       	call   801016d0 <ilock>
  if(ip->type == T_DIR){
80106661:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106666:	0f 84 90 00 00 00    	je     801066fc <sys_link+0xfc>
  ip->nlink++;
8010666c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106670:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106673:	89 1c 24             	mov    %ebx,(%esp)
80106676:	e8 95 af ff ff       	call   80101610 <iupdate>
  iunlock(ip);
8010667b:	89 1c 24             	mov    %ebx,(%esp)
8010667e:	e8 2d b1 ff ff       	call   801017b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106683:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106686:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010668a:	89 04 24             	mov    %eax,(%esp)
8010668d:	e8 3e b9 ff ff       	call   80101fd0 <nameiparent>
80106692:	85 c0                	test   %eax,%eax
80106694:	89 c6                	mov    %eax,%esi
80106696:	74 50                	je     801066e8 <sys_link+0xe8>
  ilock(dp);
80106698:	89 04 24             	mov    %eax,(%esp)
8010669b:	e8 30 b0 ff ff       	call   801016d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801066a0:	8b 03                	mov    (%ebx),%eax
801066a2:	39 06                	cmp    %eax,(%esi)
801066a4:	75 3a                	jne    801066e0 <sys_link+0xe0>
801066a6:	8b 43 04             	mov    0x4(%ebx),%eax
801066a9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801066ad:	89 34 24             	mov    %esi,(%esp)
801066b0:	89 44 24 08          	mov    %eax,0x8(%esp)
801066b4:	e8 17 b8 ff ff       	call   80101ed0 <dirlink>
801066b9:	85 c0                	test   %eax,%eax
801066bb:	78 23                	js     801066e0 <sys_link+0xe0>
  iunlockput(dp);
801066bd:	89 34 24             	mov    %esi,(%esp)
801066c0:	e8 9b b2 ff ff       	call   80101960 <iunlockput>
  iput(ip);
801066c5:	89 1c 24             	mov    %ebx,(%esp)
801066c8:	e8 33 b1 ff ff       	call   80101800 <iput>
  end_op();
801066cd:	e8 0e c6 ff ff       	call   80102ce0 <end_op>
}
801066d2:	83 c4 3c             	add    $0x3c,%esp
  return 0;
801066d5:	31 c0                	xor    %eax,%eax
}
801066d7:	5b                   	pop    %ebx
801066d8:	5e                   	pop    %esi
801066d9:	5f                   	pop    %edi
801066da:	5d                   	pop    %ebp
801066db:	c3                   	ret    
801066dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801066e0:	89 34 24             	mov    %esi,(%esp)
801066e3:	e8 78 b2 ff ff       	call   80101960 <iunlockput>
  ilock(ip);
801066e8:	89 1c 24             	mov    %ebx,(%esp)
801066eb:	e8 e0 af ff ff       	call   801016d0 <ilock>
  ip->nlink--;
801066f0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801066f4:	89 1c 24             	mov    %ebx,(%esp)
801066f7:	e8 14 af ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
801066fc:	89 1c 24             	mov    %ebx,(%esp)
801066ff:	e8 5c b2 ff ff       	call   80101960 <iunlockput>
  end_op();
80106704:	e8 d7 c5 ff ff       	call   80102ce0 <end_op>
}
80106709:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010670c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106711:	5b                   	pop    %ebx
80106712:	5e                   	pop    %esi
80106713:	5f                   	pop    %edi
80106714:	5d                   	pop    %ebp
80106715:	c3                   	ret    
80106716:	8d 76 00             	lea    0x0(%esi),%esi
80106719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106720 <sys_unlink>:
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	57                   	push   %edi
80106724:	56                   	push   %esi
80106725:	53                   	push   %ebx
80106726:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80106729:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010672c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106730:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106737:	e8 24 fa ff ff       	call   80106160 <argstr>
8010673c:	85 c0                	test   %eax,%eax
8010673e:	0f 88 68 01 00 00    	js     801068ac <sys_unlink+0x18c>
  begin_op();
80106744:	e8 27 c5 ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106749:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010674c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010674f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106753:	89 04 24             	mov    %eax,(%esp)
80106756:	e8 75 b8 ff ff       	call   80101fd0 <nameiparent>
8010675b:	85 c0                	test   %eax,%eax
8010675d:	89 c6                	mov    %eax,%esi
8010675f:	0f 84 42 01 00 00    	je     801068a7 <sys_unlink+0x187>
  ilock(dp);
80106765:	89 04 24             	mov    %eax,(%esp)
80106768:	e8 63 af ff ff       	call   801016d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010676d:	b8 04 92 10 80       	mov    $0x80109204,%eax
80106772:	89 44 24 04          	mov    %eax,0x4(%esp)
80106776:	89 1c 24             	mov    %ebx,(%esp)
80106779:	e8 a2 b4 ff ff       	call   80101c20 <namecmp>
8010677e:	85 c0                	test   %eax,%eax
80106780:	0f 84 19 01 00 00    	je     8010689f <sys_unlink+0x17f>
80106786:	b8 03 92 10 80       	mov    $0x80109203,%eax
8010678b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010678f:	89 1c 24             	mov    %ebx,(%esp)
80106792:	e8 89 b4 ff ff       	call   80101c20 <namecmp>
80106797:	85 c0                	test   %eax,%eax
80106799:	0f 84 00 01 00 00    	je     8010689f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010679f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801067a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801067a6:	89 44 24 08          	mov    %eax,0x8(%esp)
801067aa:	89 34 24             	mov    %esi,(%esp)
801067ad:	e8 9e b4 ff ff       	call   80101c50 <dirlookup>
801067b2:	85 c0                	test   %eax,%eax
801067b4:	89 c3                	mov    %eax,%ebx
801067b6:	0f 84 e3 00 00 00    	je     8010689f <sys_unlink+0x17f>
  ilock(ip);
801067bc:	89 04 24             	mov    %eax,(%esp)
801067bf:	e8 0c af ff ff       	call   801016d0 <ilock>
  if(ip->nlink < 1)
801067c4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801067c9:	0f 8e 0e 01 00 00    	jle    801068dd <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
801067cf:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801067d4:	8d 7d d8             	lea    -0x28(%ebp),%edi
801067d7:	74 77                	je     80106850 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801067d9:	31 d2                	xor    %edx,%edx
801067db:	b8 10 00 00 00       	mov    $0x10,%eax
801067e0:	89 54 24 04          	mov    %edx,0x4(%esp)
801067e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801067e8:	89 3c 24             	mov    %edi,(%esp)
801067eb:	e8 d0 f5 ff ff       	call   80105dc0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801067f0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801067f3:	b9 10 00 00 00       	mov    $0x10,%ecx
801067f8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801067fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106800:	89 34 24             	mov    %esi,(%esp)
80106803:	89 44 24 08          	mov    %eax,0x8(%esp)
80106807:	e8 c4 b2 ff ff       	call   80101ad0 <writei>
8010680c:	83 f8 10             	cmp    $0x10,%eax
8010680f:	0f 85 d4 00 00 00    	jne    801068e9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106815:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010681a:	0f 84 a0 00 00 00    	je     801068c0 <sys_unlink+0x1a0>
  iunlockput(dp);
80106820:	89 34 24             	mov    %esi,(%esp)
80106823:	e8 38 b1 ff ff       	call   80101960 <iunlockput>
  ip->nlink--;
80106828:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010682c:	89 1c 24             	mov    %ebx,(%esp)
8010682f:	e8 dc ad ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
80106834:	89 1c 24             	mov    %ebx,(%esp)
80106837:	e8 24 b1 ff ff       	call   80101960 <iunlockput>
  end_op();
8010683c:	e8 9f c4 ff ff       	call   80102ce0 <end_op>
}
80106841:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80106844:	31 c0                	xor    %eax,%eax
}
80106846:	5b                   	pop    %ebx
80106847:	5e                   	pop    %esi
80106848:	5f                   	pop    %edi
80106849:	5d                   	pop    %ebp
8010684a:	c3                   	ret    
8010684b:	90                   	nop
8010684c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106850:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106854:	76 83                	jbe    801067d9 <sys_unlink+0xb9>
80106856:	ba 20 00 00 00       	mov    $0x20,%edx
8010685b:	eb 0f                	jmp    8010686c <sys_unlink+0x14c>
8010685d:	8d 76 00             	lea    0x0(%esi),%esi
80106860:	83 c2 10             	add    $0x10,%edx
80106863:	3b 53 58             	cmp    0x58(%ebx),%edx
80106866:	0f 83 6d ff ff ff    	jae    801067d9 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010686c:	b8 10 00 00 00       	mov    $0x10,%eax
80106871:	89 54 24 08          	mov    %edx,0x8(%esp)
80106875:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106879:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010687d:	89 1c 24             	mov    %ebx,(%esp)
80106880:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106883:	e8 28 b1 ff ff       	call   801019b0 <readi>
80106888:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010688b:	83 f8 10             	cmp    $0x10,%eax
8010688e:	75 41                	jne    801068d1 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106890:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106895:	74 c9                	je     80106860 <sys_unlink+0x140>
    iunlockput(ip);
80106897:	89 1c 24             	mov    %ebx,(%esp)
8010689a:	e8 c1 b0 ff ff       	call   80101960 <iunlockput>
  iunlockput(dp);
8010689f:	89 34 24             	mov    %esi,(%esp)
801068a2:	e8 b9 b0 ff ff       	call   80101960 <iunlockput>
  end_op();
801068a7:	e8 34 c4 ff ff       	call   80102ce0 <end_op>
}
801068ac:	83 c4 5c             	add    $0x5c,%esp
  return -1;
801068af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068b4:	5b                   	pop    %ebx
801068b5:	5e                   	pop    %esi
801068b6:	5f                   	pop    %edi
801068b7:	5d                   	pop    %ebp
801068b8:	c3                   	ret    
801068b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801068c0:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
801068c4:	89 34 24             	mov    %esi,(%esp)
801068c7:	e8 44 ad ff ff       	call   80101610 <iupdate>
801068cc:	e9 4f ff ff ff       	jmp    80106820 <sys_unlink+0x100>
      panic("isdirempty: readi");
801068d1:	c7 04 24 28 92 10 80 	movl   $0x80109228,(%esp)
801068d8:	e8 93 9a ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
801068dd:	c7 04 24 16 92 10 80 	movl   $0x80109216,(%esp)
801068e4:	e8 87 9a ff ff       	call   80100370 <panic>
    panic("unlink: writei");
801068e9:	c7 04 24 3a 92 10 80 	movl   $0x8010923a,(%esp)
801068f0:	e8 7b 9a ff ff       	call   80100370 <panic>
801068f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106900 <sys_open>:

int
sys_open(void)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
80106906:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106909:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010690c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106910:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106917:	e8 44 f8 ff ff       	call   80106160 <argstr>
8010691c:	85 c0                	test   %eax,%eax
8010691e:	0f 88 e9 00 00 00    	js     80106a0d <sys_open+0x10d>
80106924:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106927:	89 44 24 04          	mov    %eax,0x4(%esp)
8010692b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106932:	e8 79 f7 ff ff       	call   801060b0 <argint>
80106937:	85 c0                	test   %eax,%eax
80106939:	0f 88 ce 00 00 00    	js     80106a0d <sys_open+0x10d>
    return -1;

  begin_op();
8010693f:	e8 2c c3 ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
80106944:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106948:	0f 85 9a 00 00 00    	jne    801069e8 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010694e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106951:	89 04 24             	mov    %eax,(%esp)
80106954:	e8 57 b6 ff ff       	call   80101fb0 <namei>
80106959:	85 c0                	test   %eax,%eax
8010695b:	89 c6                	mov    %eax,%esi
8010695d:	0f 84 a5 00 00 00    	je     80106a08 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106963:	89 04 24             	mov    %eax,(%esp)
80106966:	e8 65 ad ff ff       	call   801016d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010696b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106970:	0f 84 a2 00 00 00    	je     80106a18 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106976:	e8 d5 a3 ff ff       	call   80100d50 <filealloc>
8010697b:	85 c0                	test   %eax,%eax
8010697d:	89 c7                	mov    %eax,%edi
8010697f:	0f 84 9e 00 00 00    	je     80106a23 <sys_open+0x123>
  struct proc *curproc = myproc();
80106985:	e8 d6 cf ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010698a:	31 db                	xor    %ebx,%ebx
8010698c:	eb 0c                	jmp    8010699a <sys_open+0x9a>
8010698e:	66 90                	xchg   %ax,%ax
80106990:	43                   	inc    %ebx
80106991:	83 fb 10             	cmp    $0x10,%ebx
80106994:	0f 84 96 00 00 00    	je     80106a30 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010699a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010699e:	85 d2                	test   %edx,%edx
801069a0:	75 ee                	jne    80106990 <sys_open+0x90>
      curproc->ofile[fd] = f;
801069a2:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801069a6:	89 34 24             	mov    %esi,(%esp)
801069a9:	e8 02 ae ff ff       	call   801017b0 <iunlock>
  end_op();
801069ae:	e8 2d c3 ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
801069b3:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801069b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
801069bc:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801069bf:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801069c6:	89 d0                	mov    %edx,%eax
801069c8:	f7 d0                	not    %eax
801069ca:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801069cd:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
801069d0:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801069d3:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801069d7:	83 c4 2c             	add    $0x2c,%esp
801069da:	89 d8                	mov    %ebx,%eax
801069dc:	5b                   	pop    %ebx
801069dd:	5e                   	pop    %esi
801069de:	5f                   	pop    %edi
801069df:	5d                   	pop    %ebp
801069e0:	c3                   	ret    
801069e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801069e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069eb:	31 c9                	xor    %ecx,%ecx
801069ed:	ba 02 00 00 00       	mov    $0x2,%edx
801069f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069f9:	e8 12 f8 ff ff       	call   80106210 <create>
    if(ip == 0){
801069fe:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106a00:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106a02:	0f 85 6e ff ff ff    	jne    80106976 <sys_open+0x76>
    end_op();
80106a08:	e8 d3 c2 ff ff       	call   80102ce0 <end_op>
    return -1;
80106a0d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a12:	eb c3                	jmp    801069d7 <sys_open+0xd7>
80106a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106a18:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a1b:	85 c9                	test   %ecx,%ecx
80106a1d:	0f 84 53 ff ff ff    	je     80106976 <sys_open+0x76>
    iunlockput(ip);
80106a23:	89 34 24             	mov    %esi,(%esp)
80106a26:	e8 35 af ff ff       	call   80101960 <iunlockput>
80106a2b:	eb db                	jmp    80106a08 <sys_open+0x108>
80106a2d:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80106a30:	89 3c 24             	mov    %edi,(%esp)
80106a33:	e8 d8 a3 ff ff       	call   80100e10 <fileclose>
80106a38:	eb e9                	jmp    80106a23 <sys_open+0x123>
80106a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a40 <sys_mkdir>:

int
sys_mkdir(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106a46:	e8 25 c2 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106a4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a59:	e8 02 f7 ff ff       	call   80106160 <argstr>
80106a5e:	85 c0                	test   %eax,%eax
80106a60:	78 2e                	js     80106a90 <sys_mkdir+0x50>
80106a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a65:	31 c9                	xor    %ecx,%ecx
80106a67:	ba 01 00 00 00       	mov    $0x1,%edx
80106a6c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a73:	e8 98 f7 ff ff       	call   80106210 <create>
80106a78:	85 c0                	test   %eax,%eax
80106a7a:	74 14                	je     80106a90 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106a7c:	89 04 24             	mov    %eax,(%esp)
80106a7f:	e8 dc ae ff ff       	call   80101960 <iunlockput>
  end_op();
80106a84:	e8 57 c2 ff ff       	call   80102ce0 <end_op>
  return 0;
80106a89:	31 c0                	xor    %eax,%eax
}
80106a8b:	c9                   	leave  
80106a8c:	c3                   	ret    
80106a8d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106a90:	e8 4b c2 ff ff       	call   80102ce0 <end_op>
    return -1;
80106a95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a9a:	c9                   	leave  
80106a9b:	c3                   	ret    
80106a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106aa0 <sys_mknod>:

int
sys_mknod(void)
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106aa6:	e8 c5 c1 ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106aab:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106aae:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ab2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ab9:	e8 a2 f6 ff ff       	call   80106160 <argstr>
80106abe:	85 c0                	test   %eax,%eax
80106ac0:	78 5e                	js     80106b20 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106ac2:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ac9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106ad0:	e8 db f5 ff ff       	call   801060b0 <argint>
  if((argstr(0, &path)) < 0 ||
80106ad5:	85 c0                	test   %eax,%eax
80106ad7:	78 47                	js     80106b20 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106ad9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106adc:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ae0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106ae7:	e8 c4 f5 ff ff       	call   801060b0 <argint>
     argint(1, &major) < 0 ||
80106aec:	85 c0                	test   %eax,%eax
80106aee:	78 30                	js     80106b20 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106af0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106af4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106af9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106afd:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106b03:	e8 08 f7 ff ff       	call   80106210 <create>
80106b08:	85 c0                	test   %eax,%eax
80106b0a:	74 14                	je     80106b20 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106b0c:	89 04 24             	mov    %eax,(%esp)
80106b0f:	e8 4c ae ff ff       	call   80101960 <iunlockput>
  end_op();
80106b14:	e8 c7 c1 ff ff       	call   80102ce0 <end_op>
  return 0;
80106b19:	31 c0                	xor    %eax,%eax
}
80106b1b:	c9                   	leave  
80106b1c:	c3                   	ret    
80106b1d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106b20:	e8 bb c1 ff ff       	call   80102ce0 <end_op>
    return -1;
80106b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b2a:	c9                   	leave  
80106b2b:	c3                   	ret    
80106b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b30 <sys_chdir>:

int
sys_chdir(void)
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	56                   	push   %esi
80106b34:	53                   	push   %ebx
80106b35:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106b38:	e8 23 ce ff ff       	call   80103960 <myproc>
80106b3d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106b3f:	e8 2c c1 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106b44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b47:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b52:	e8 09 f6 ff ff       	call   80106160 <argstr>
80106b57:	85 c0                	test   %eax,%eax
80106b59:	78 4a                	js     80106ba5 <sys_chdir+0x75>
80106b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b5e:	89 04 24             	mov    %eax,(%esp)
80106b61:	e8 4a b4 ff ff       	call   80101fb0 <namei>
80106b66:	85 c0                	test   %eax,%eax
80106b68:	89 c3                	mov    %eax,%ebx
80106b6a:	74 39                	je     80106ba5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
80106b6c:	89 04 24             	mov    %eax,(%esp)
80106b6f:	e8 5c ab ff ff       	call   801016d0 <ilock>
  if(ip->type != T_DIR){
80106b74:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106b79:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
80106b7c:	75 22                	jne    80106ba0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
80106b7e:	e8 2d ac ff ff       	call   801017b0 <iunlock>
  iput(curproc->cwd);
80106b83:	8b 46 68             	mov    0x68(%esi),%eax
80106b86:	89 04 24             	mov    %eax,(%esp)
80106b89:	e8 72 ac ff ff       	call   80101800 <iput>
  end_op();
80106b8e:	e8 4d c1 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
  return 0;
80106b93:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106b95:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106b98:	83 c4 20             	add    $0x20,%esp
80106b9b:	5b                   	pop    %ebx
80106b9c:	5e                   	pop    %esi
80106b9d:	5d                   	pop    %ebp
80106b9e:	c3                   	ret    
80106b9f:	90                   	nop
    iunlockput(ip);
80106ba0:	e8 bb ad ff ff       	call   80101960 <iunlockput>
    end_op();
80106ba5:	e8 36 c1 ff ff       	call   80102ce0 <end_op>
    return -1;
80106baa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106baf:	eb e7                	jmp    80106b98 <sys_chdir+0x68>
80106bb1:	eb 0d                	jmp    80106bc0 <sys_exec>
80106bb3:	90                   	nop
80106bb4:	90                   	nop
80106bb5:	90                   	nop
80106bb6:	90                   	nop
80106bb7:	90                   	nop
80106bb8:	90                   	nop
80106bb9:	90                   	nop
80106bba:	90                   	nop
80106bbb:	90                   	nop
80106bbc:	90                   	nop
80106bbd:	90                   	nop
80106bbe:	90                   	nop
80106bbf:	90                   	nop

80106bc0 <sys_exec>:

int
sys_exec(void)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
80106bc6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106bcc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106bd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bd6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106bdd:	e8 7e f5 ff ff       	call   80106160 <argstr>
80106be2:	85 c0                	test   %eax,%eax
80106be4:	0f 88 8e 00 00 00    	js     80106c78 <sys_exec+0xb8>
80106bea:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106bf0:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bf4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106bfb:	e8 b0 f4 ff ff       	call   801060b0 <argint>
80106c00:	85 c0                	test   %eax,%eax
80106c02:	78 74                	js     80106c78 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106c04:	ba 80 00 00 00       	mov    $0x80,%edx
80106c09:	31 c9                	xor    %ecx,%ecx
80106c0b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106c11:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106c13:	89 54 24 08          	mov    %edx,0x8(%esp)
80106c17:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106c1d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106c21:	89 04 24             	mov    %eax,(%esp)
80106c24:	e8 97 f1 ff ff       	call   80105dc0 <memset>
80106c29:	eb 2e                	jmp    80106c59 <sys_exec+0x99>
80106c2b:	90                   	nop
80106c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106c30:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106c36:	85 c0                	test   %eax,%eax
80106c38:	74 56                	je     80106c90 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106c3a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106c40:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106c43:	89 54 24 04          	mov    %edx,0x4(%esp)
80106c47:	89 04 24             	mov    %eax,(%esp)
80106c4a:	e8 01 f4 ff ff       	call   80106050 <fetchstr>
80106c4f:	85 c0                	test   %eax,%eax
80106c51:	78 25                	js     80106c78 <sys_exec+0xb8>
  for(i=0;; i++){
80106c53:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106c54:	83 fb 20             	cmp    $0x20,%ebx
80106c57:	74 1f                	je     80106c78 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106c59:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106c5f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106c66:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106c6a:	01 f0                	add    %esi,%eax
80106c6c:	89 04 24             	mov    %eax,(%esp)
80106c6f:	e8 9c f3 ff ff       	call   80106010 <fetchint>
80106c74:	85 c0                	test   %eax,%eax
80106c76:	79 b8                	jns    80106c30 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106c78:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106c7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c83:	5b                   	pop    %ebx
80106c84:	5e                   	pop    %esi
80106c85:	5f                   	pop    %edi
80106c86:	5d                   	pop    %ebp
80106c87:	c3                   	ret    
80106c88:	90                   	nop
80106c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106c90:	31 c0                	xor    %eax,%eax
80106c92:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106c99:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106c9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ca3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106ca9:	89 04 24             	mov    %eax,(%esp)
80106cac:	e8 1f 9d ff ff       	call   801009d0 <exec>
}
80106cb1:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106cb7:	5b                   	pop    %ebx
80106cb8:	5e                   	pop    %esi
80106cb9:	5f                   	pop    %edi
80106cba:	5d                   	pop    %ebp
80106cbb:	c3                   	ret    
80106cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106cc0 <sys_pipe>:

int
sys_pipe(void)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106cc4:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106cc9:	56                   	push   %esi
80106cca:	53                   	push   %ebx
80106ccb:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106cce:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106cd1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106cd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cd9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ce0:	e8 1b f4 ff ff       	call   80106100 <argptr>
80106ce5:	85 c0                	test   %eax,%eax
80106ce7:	0f 88 a9 00 00 00    	js     80106d96 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106ced:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cf4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106cf7:	89 04 24             	mov    %eax,(%esp)
80106cfa:	e8 a1 c6 ff ff       	call   801033a0 <pipealloc>
80106cff:	85 c0                	test   %eax,%eax
80106d01:	0f 88 8f 00 00 00    	js     80106d96 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106d07:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106d0a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106d0c:	e8 4f cc ff ff       	call   80103960 <myproc>
80106d11:	eb 0b                	jmp    80106d1e <sys_pipe+0x5e>
80106d13:	90                   	nop
80106d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106d18:	43                   	inc    %ebx
80106d19:	83 fb 10             	cmp    $0x10,%ebx
80106d1c:	74 62                	je     80106d80 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106d1e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106d22:	85 f6                	test   %esi,%esi
80106d24:	75 f2                	jne    80106d18 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106d26:	8d 73 08             	lea    0x8(%ebx),%esi
80106d29:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106d2d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106d30:	e8 2b cc ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106d35:	31 d2                	xor    %edx,%edx
80106d37:	eb 0d                	jmp    80106d46 <sys_pipe+0x86>
80106d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d40:	42                   	inc    %edx
80106d41:	83 fa 10             	cmp    $0x10,%edx
80106d44:	74 2a                	je     80106d70 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106d46:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106d4a:	85 c9                	test   %ecx,%ecx
80106d4c:	75 f2                	jne    80106d40 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106d4e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106d52:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106d55:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106d57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106d5a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106d5d:	31 c0                	xor    %eax,%eax
}
80106d5f:	83 c4 2c             	add    $0x2c,%esp
80106d62:	5b                   	pop    %ebx
80106d63:	5e                   	pop    %esi
80106d64:	5f                   	pop    %edi
80106d65:	5d                   	pop    %ebp
80106d66:	c3                   	ret    
80106d67:	89 f6                	mov    %esi,%esi
80106d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106d70:	e8 eb cb ff ff       	call   80103960 <myproc>
80106d75:	31 d2                	xor    %edx,%edx
80106d77:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106d7b:	90                   	nop
80106d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106d80:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d83:	89 04 24             	mov    %eax,(%esp)
80106d86:	e8 85 a0 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
80106d8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d8e:	89 04 24             	mov    %eax,(%esp)
80106d91:	e8 7a a0 ff ff       	call   80100e10 <fileclose>
    return -1;
80106d96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d9b:	eb c2                	jmp    80106d5f <sys_pipe+0x9f>
80106d9d:	66 90                	xchg   %ax,%ax
80106d9f:	90                   	nop

80106da0 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void) {
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
    return fork();
}
80106da3:	5d                   	pop    %ebp
    return fork();
80106da4:	e9 17 d0 ff ff       	jmp    80103dc0 <fork>
80106da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106db0 <sys_exit>:

int
sys_exit(void) {
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	83 ec 28             	sub    $0x28,%esp
    int status;

    if(argint(0, &status) < 0)
80106db6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106db9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106dc4:	e8 e7 f2 ff ff       	call   801060b0 <argint>
80106dc9:	85 c0                	test   %eax,%eax
80106dcb:	78 13                	js     80106de0 <sys_exit+0x30>
        return -1;
    exit(status);
80106dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dd0:	89 04 24             	mov    %eax,(%esp)
80106dd3:	e8 d8 d6 ff ff       	call   801044b0 <exit>
    return 0;  // not reached
80106dd8:	31 c0                	xor    %eax,%eax
}
80106dda:	c9                   	leave  
80106ddb:	c3                   	ret    
80106ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106de5:	c9                   	leave  
80106de6:	c3                   	ret    
80106de7:	89 f6                	mov    %esi,%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <sys_wait>:

int
sys_wait(void) {
80106df0:	55                   	push   %ebp

    int* status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106df1:	b8 04 00 00 00       	mov    $0x4,%eax
sys_wait(void) {
80106df6:	89 e5                	mov    %esp,%ebp
80106df8:	83 ec 28             	sub    $0x28,%esp
    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106dfb:	89 44 24 08          	mov    %eax,0x8(%esp)
80106dff:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e02:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e06:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e0d:	e8 ee f2 ff ff       	call   80106100 <argptr>
80106e12:	85 c0                	test   %eax,%eax
80106e14:	78 12                	js     80106e28 <sys_wait+0x38>
        return -1;
    return wait(status);
80106e16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e19:	89 04 24             	mov    %eax,(%esp)
80106e1c:	e8 5f da ff ff       	call   80104880 <wait>
}
80106e21:	c9                   	leave  
80106e22:	c3                   	ret    
80106e23:	90                   	nop
80106e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e2d:	c9                   	leave  
80106e2e:	c3                   	ret    
80106e2f:	90                   	nop

80106e30 <sys_wait_stat>:

int
sys_wait_stat(void) {
80106e30:	55                   	push   %ebp
	int *status;
	struct perf *p;
  

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106e31:	ba 04 00 00 00       	mov    $0x4,%edx
sys_wait_stat(void) {
80106e36:	89 e5                	mov    %esp,%ebp
80106e38:	83 ec 28             	sub    $0x28,%esp
    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106e3b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e3e:	89 54 24 08          	mov    %edx,0x8(%esp)
80106e42:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e46:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e4d:	e8 ae f2 ff ff       	call   80106100 <argptr>
80106e52:	85 c0                	test   %eax,%eax
80106e54:	78 3a                	js     80106e90 <sys_wait_stat+0x60>
	{
       	 return -1;
	}
    if(argptr(1, (void*)&p, sizeof(*status)) < 0)
80106e56:	b8 04 00 00 00       	mov    $0x4,%eax
80106e5b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106e5f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e62:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106e6d:	e8 8e f2 ff ff       	call   80106100 <argptr>
80106e72:	85 c0                	test   %eax,%eax
80106e74:	78 1a                	js     80106e90 <sys_wait_stat+0x60>
	{
       	 return -1;
	}	 

	
    return wait_stat(status,p);
80106e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e79:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e80:	89 04 24             	mov    %eax,(%esp)
80106e83:	e8 08 db ff ff       	call   80104990 <wait_stat>
}
80106e88:	c9                   	leave  
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       	 return -1;
80106e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e95:	c9                   	leave  
80106e96:	c3                   	ret    
80106e97:	89 f6                	mov    %esi,%esi
80106e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ea0 <sys_kill>:

int
sys_kill(void) {
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	83 ec 28             	sub    $0x28,%esp
    int pid;

    if (argint(0, &pid) < 0)
80106ea6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ea9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ead:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106eb4:	e8 f7 f1 ff ff       	call   801060b0 <argint>
80106eb9:	85 c0                	test   %eax,%eax
80106ebb:	78 13                	js     80106ed0 <sys_kill+0x30>
        return -1;
    return kill(pid);
80106ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ec0:	89 04 24             	mov    %eax,(%esp)
80106ec3:	e8 68 dc ff ff       	call   80104b30 <kill>
}
80106ec8:	c9                   	leave  
80106ec9:	c3                   	ret    
80106eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80106ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ed5:	c9                   	leave  
80106ed6:	c3                   	ret    
80106ed7:	89 f6                	mov    %esi,%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ee0 <sys_getpid>:

int
sys_getpid(void) {
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	83 ec 08             	sub    $0x8,%esp
    return myproc()->pid;
80106ee6:	e8 75 ca ff ff       	call   80103960 <myproc>
80106eeb:	8b 40 10             	mov    0x10(%eax),%eax
}
80106eee:	c9                   	leave  
80106eef:	c3                   	ret    

80106ef0 <sys_sbrk>:

int
sys_sbrk(void) {
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	53                   	push   %ebx
80106ef4:	83 ec 24             	sub    $0x24,%esp
    int addr;
    int n;

    if (argint(0, &n) < 0)
80106ef7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106efa:	89 44 24 04          	mov    %eax,0x4(%esp)
80106efe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f05:	e8 a6 f1 ff ff       	call   801060b0 <argint>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	78 22                	js     80106f30 <sys_sbrk+0x40>
        return -1;
    addr = myproc()->sz;
80106f0e:	e8 4d ca ff ff       	call   80103960 <myproc>
80106f13:	8b 18                	mov    (%eax),%ebx
    if (growproc(n) < 0)
80106f15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f18:	89 04 24             	mov    %eax,(%esp)
80106f1b:	e8 20 ce ff ff       	call   80103d40 <growproc>
80106f20:	85 c0                	test   %eax,%eax
80106f22:	78 0c                	js     80106f30 <sys_sbrk+0x40>
        return -1;
    return addr;
}
80106f24:	83 c4 24             	add    $0x24,%esp
80106f27:	89 d8                	mov    %ebx,%eax
80106f29:	5b                   	pop    %ebx
80106f2a:	5d                   	pop    %ebp
80106f2b:	c3                   	ret    
80106f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106f30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106f35:	eb ed                	jmp    80106f24 <sys_sbrk+0x34>
80106f37:	89 f6                	mov    %esi,%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f40 <sys_sleep>:

int
sys_sleep(void) {
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	53                   	push   %ebx
80106f44:	83 ec 24             	sub    $0x24,%esp
    int n;
    uint ticks0;

    if (argint(0, &n) < 0)
80106f47:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106f4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f55:	e8 56 f1 ff ff       	call   801060b0 <argint>
80106f5a:	85 c0                	test   %eax,%eax
80106f5c:	78 7e                	js     80106fdc <sys_sleep+0x9c>
        return -1;
    acquire(&tickslock);
80106f5e:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80106f65:	e8 66 ed ff ff       	call   80105cd0 <acquire>
    ticks0 = ticks;
    while (ticks - ticks0 < n) {
80106f6a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    ticks0 = ticks;
80106f6d:	8b 1d 00 81 11 80    	mov    0x80118100,%ebx
    while (ticks - ticks0 < n) {
80106f73:	85 c9                	test   %ecx,%ecx
80106f75:	75 2a                	jne    80106fa1 <sys_sleep+0x61>
80106f77:	eb 4f                	jmp    80106fc8 <sys_sleep+0x88>
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (myproc()->killed) {
            release(&tickslock);
            return -1;
        }
        sleep(&ticks, &tickslock);
80106f80:	b8 c0 78 11 80       	mov    $0x801178c0,%eax
80106f85:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f89:	c7 04 24 00 81 11 80 	movl   $0x80118100,(%esp)
80106f90:	e8 8b d7 ff ff       	call   80104720 <sleep>
    while (ticks - ticks0 < n) {
80106f95:	a1 00 81 11 80       	mov    0x80118100,%eax
80106f9a:	29 d8                	sub    %ebx,%eax
80106f9c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106f9f:	73 27                	jae    80106fc8 <sys_sleep+0x88>
        if (myproc()->killed) {
80106fa1:	e8 ba c9 ff ff       	call   80103960 <myproc>
80106fa6:	8b 50 24             	mov    0x24(%eax),%edx
80106fa9:	85 d2                	test   %edx,%edx
80106fab:	74 d3                	je     80106f80 <sys_sleep+0x40>
            release(&tickslock);
80106fad:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80106fb4:	e8 b7 ed ff ff       	call   80105d70 <release>
    }
    release(&tickslock);
    return 0;
}
80106fb9:	83 c4 24             	add    $0x24,%esp
            return -1;
80106fbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fc1:	5b                   	pop    %ebx
80106fc2:	5d                   	pop    %ebp
80106fc3:	c3                   	ret    
80106fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&tickslock);
80106fc8:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80106fcf:	e8 9c ed ff ff       	call   80105d70 <release>
    return 0;
80106fd4:	31 c0                	xor    %eax,%eax
}
80106fd6:	83 c4 24             	add    $0x24,%esp
80106fd9:	5b                   	pop    %ebx
80106fda:	5d                   	pop    %ebp
80106fdb:	c3                   	ret    
        return -1;
80106fdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fe1:	eb f3                	jmp    80106fd6 <sys_sleep+0x96>
80106fe3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ff0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void) {
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	53                   	push   %ebx
80106ff4:	83 ec 14             	sub    $0x14,%esp
    uint xticks;

    acquire(&tickslock);
80106ff7:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80106ffe:	e8 cd ec ff ff       	call   80105cd0 <acquire>
    xticks = ticks;
80107003:	8b 1d 00 81 11 80    	mov    0x80118100,%ebx
    release(&tickslock);
80107009:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80107010:	e8 5b ed ff ff       	call   80105d70 <release>
    return xticks;
}
80107015:	83 c4 14             	add    $0x14,%esp
80107018:	89 d8                	mov    %ebx,%eax
8010701a:	5b                   	pop    %ebx
8010701b:	5d                   	pop    %ebp
8010701c:	c3                   	ret    
8010701d:	8d 76 00             	lea    0x0(%esi),%esi

80107020 <sys_detach>:

int
sys_detach(void) {
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	83 ec 28             	sub    $0x28,%esp

    int pid;

    if (argint(0, &pid) < 0)
80107026:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107029:	89 44 24 04          	mov    %eax,0x4(%esp)
8010702d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107034:	e8 77 f0 ff ff       	call   801060b0 <argint>
80107039:	85 c0                	test   %eax,%eax
8010703b:	78 13                	js     80107050 <sys_detach+0x30>
        return -1;
    return detach(pid);
8010703d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107040:	89 04 24             	mov    %eax,(%esp)
80107043:	e8 18 cf ff ff       	call   80103f60 <detach>
}
80107048:	c9                   	leave  
80107049:	c3                   	ret    
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80107050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107055:	c9                   	leave  
80107056:	c3                   	ret    
80107057:	89 f6                	mov    %esi,%esi
80107059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107060 <sys_priority>:

int
sys_priority(void){
80107060:	55                   	push   %ebp
80107061:	89 e5                	mov    %esp,%ebp
80107063:	83 ec 28             	sub    $0x28,%esp

    int pri;

    if (argint(0, &pri) < 0)
80107066:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107069:	89 44 24 04          	mov    %eax,0x4(%esp)
8010706d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107074:	e8 37 f0 ff ff       	call   801060b0 <argint>
80107079:	85 c0                	test   %eax,%eax
8010707b:	78 13                	js     80107090 <sys_priority+0x30>
        return -1;
    priority(pri);
8010707d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107080:	89 04 24             	mov    %eax,(%esp)
80107083:	e8 78 cf ff ff       	call   80104000 <priority>
    return 0;
80107088:	31 c0                	xor    %eax,%eax
}
8010708a:	c9                   	leave  
8010708b:	c3                   	ret    
8010708c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80107090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107095:	c9                   	leave  
80107096:	c3                   	ret    
80107097:	89 f6                	mov    %esi,%esi
80107099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070a0 <sys_policy>:

int
sys_policy(void){
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	83 ec 28             	sub    $0x28,%esp
    int pol;

    if (argint(0, &pol) < 0)
801070a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801070ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801070b4:	e8 f7 ef ff ff       	call   801060b0 <argint>
801070b9:	85 c0                	test   %eax,%eax
801070bb:	78 13                	js     801070d0 <sys_policy+0x30>
        return -1;
    policy(pol);
801070bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801070c0:	89 04 24             	mov    %eax,(%esp)
801070c3:	e8 b8 cf ff ff       	call   80104080 <policy>
    return 0;
801070c8:	31 c0                	xor    %eax,%eax
}
801070ca:	c9                   	leave  
801070cb:	c3                   	ret    
801070cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801070d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070d5:	c9                   	leave  
801070d6:	c3                   	ret    

801070d7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801070d7:	1e                   	push   %ds
  pushl %es
801070d8:	06                   	push   %es
  pushl %fs
801070d9:	0f a0                	push   %fs
  pushl %gs
801070db:	0f a8                	push   %gs
  pushal
801070dd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801070de:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801070e2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801070e4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801070e6:	54                   	push   %esp
  call trap
801070e7:	e8 c4 00 00 00       	call   801071b0 <trap>
  addl $4, %esp
801070ec:	83 c4 04             	add    $0x4,%esp

801070ef <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801070ef:	61                   	popa   
  popl %gs
801070f0:	0f a9                	pop    %gs
  popl %fs
801070f2:	0f a1                	pop    %fs
  popl %es
801070f4:	07                   	pop    %es
  popl %ds
801070f5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801070f6:	83 c4 08             	add    $0x8,%esp
  iret
801070f9:	cf                   	iret   
801070fa:	66 90                	xchg   %ax,%ax
801070fc:	66 90                	xchg   %ax,%ax
801070fe:	66 90                	xchg   %ax,%ax

80107100 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107100:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107101:	31 c0                	xor    %eax,%eax
{
80107103:	89 e5                	mov    %esp,%ebp
80107105:	83 ec 18             	sub    $0x18,%esp
80107108:	90                   	nop
80107109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107110:	8b 14 85 14 c0 10 80 	mov    -0x7fef3fec(,%eax,4),%edx
80107117:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
8010711c:	89 0c c5 02 79 11 80 	mov    %ecx,-0x7fee86fe(,%eax,8)
80107123:	66 89 14 c5 00 79 11 	mov    %dx,-0x7fee8700(,%eax,8)
8010712a:	80 
8010712b:	c1 ea 10             	shr    $0x10,%edx
8010712e:	66 89 14 c5 06 79 11 	mov    %dx,-0x7fee86fa(,%eax,8)
80107135:	80 
  for(i = 0; i < 256; i++)
80107136:	40                   	inc    %eax
80107137:	3d 00 01 00 00       	cmp    $0x100,%eax
8010713c:	75 d2                	jne    80107110 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010713e:	a1 14 c1 10 80       	mov    0x8010c114,%eax

  initlock(&tickslock, "time");
80107143:	b9 49 92 10 80       	mov    $0x80109249,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107148:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
8010714d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107151:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107158:	89 15 02 7b 11 80    	mov    %edx,0x80117b02
8010715e:	66 a3 00 7b 11 80    	mov    %ax,0x80117b00
80107164:	c1 e8 10             	shr    $0x10,%eax
80107167:	66 a3 06 7b 11 80    	mov    %ax,0x80117b06
  initlock(&tickslock, "time");
8010716d:	e8 0e ea ff ff       	call   80105b80 <initlock>
}
80107172:	c9                   	leave  
80107173:	c3                   	ret    
80107174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010717a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107180 <idtinit>:

void
idtinit(void)
{
80107180:	55                   	push   %ebp
  pd[1] = (uint)p;
80107181:	b8 00 79 11 80       	mov    $0x80117900,%eax
80107186:	89 e5                	mov    %esp,%ebp
80107188:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010718b:	c1 e8 10             	shr    $0x10,%eax
8010718e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80107191:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80107197:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010719b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010719f:	8d 45 fa             	lea    -0x6(%ebp),%eax
801071a2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801071a5:	c9                   	leave  
801071a6:	c3                   	ret    
801071a7:	89 f6                	mov    %esi,%esi
801071a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	83 ec 48             	sub    $0x48,%esp
801071b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801071b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801071bc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801071bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
801071c2:	8b 43 30             	mov    0x30(%ebx),%eax
801071c5:	83 f8 40             	cmp    $0x40,%eax
801071c8:	0f 84 02 01 00 00    	je     801072d0 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
801071ce:	83 e8 20             	sub    $0x20,%eax
801071d1:	83 f8 1f             	cmp    $0x1f,%eax
801071d4:	77 0a                	ja     801071e0 <trap+0x30>
801071d6:	ff 24 85 f0 92 10 80 	jmp    *-0x7fef6d10(,%eax,4)
801071dd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801071e0:	e8 7b c7 ff ff       	call   80103960 <myproc>
801071e5:	8b 7b 38             	mov    0x38(%ebx),%edi
801071e8:	85 c0                	test   %eax,%eax
801071ea:	0f 84 5f 02 00 00    	je     8010744f <trap+0x29f>
801071f0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801071f4:	0f 84 55 02 00 00    	je     8010744f <trap+0x29f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801071fa:	0f 20 d1             	mov    %cr2,%ecx
801071fd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107200:	e8 3b c7 ff ff       	call   80103940 <cpuid>
80107205:	8b 73 30             	mov    0x30(%ebx),%esi
80107208:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010720b:	8b 43 34             	mov    0x34(%ebx),%eax
8010720e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107211:	e8 4a c7 ff ff       	call   80103960 <myproc>
80107216:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107219:	e8 42 c7 ff ff       	call   80103960 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010721e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107221:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80107225:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107228:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010722b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010722f:	89 54 24 14          	mov    %edx,0x14(%esp)
80107233:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80107236:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107239:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010723d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107241:	89 54 24 10          	mov    %edx,0x10(%esp)
80107245:	8b 40 10             	mov    0x10(%eax),%eax
80107248:	c7 04 24 ac 92 10 80 	movl   $0x801092ac,(%esp)
8010724f:	89 44 24 04          	mov    %eax,0x4(%esp)
80107253:	e8 f8 93 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107258:	e8 03 c7 ff ff       	call   80103960 <myproc>
8010725d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107264:	e8 f7 c6 ff ff       	call   80103960 <myproc>
80107269:	85 c0                	test   %eax,%eax
8010726b:	74 1b                	je     80107288 <trap+0xd8>
8010726d:	e8 ee c6 ff ff       	call   80103960 <myproc>
80107272:	8b 50 24             	mov    0x24(%eax),%edx
80107275:	85 d2                	test   %edx,%edx
80107277:	74 0f                	je     80107288 <trap+0xd8>
80107279:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010727c:	83 e0 03             	and    $0x3,%eax
8010727f:	83 f8 03             	cmp    $0x3,%eax
80107282:	0f 84 80 01 00 00    	je     80107408 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107288:	e8 d3 c6 ff ff       	call   80103960 <myproc>
8010728d:	85 c0                	test   %eax,%eax
8010728f:	74 0d                	je     8010729e <trap+0xee>
80107291:	e8 ca c6 ff ff       	call   80103960 <myproc>
80107296:	8b 40 0c             	mov    0xc(%eax),%eax
80107299:	83 f8 04             	cmp    $0x4,%eax
8010729c:	74 7a                	je     80107318 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010729e:	e8 bd c6 ff ff       	call   80103960 <myproc>
801072a3:	85 c0                	test   %eax,%eax
801072a5:	74 17                	je     801072be <trap+0x10e>
801072a7:	e8 b4 c6 ff ff       	call   80103960 <myproc>
801072ac:	8b 40 24             	mov    0x24(%eax),%eax
801072af:	85 c0                	test   %eax,%eax
801072b1:	74 0b                	je     801072be <trap+0x10e>
801072b3:	8b 43 3c             	mov    0x3c(%ebx),%eax
801072b6:	83 e0 03             	and    $0x3,%eax
801072b9:	83 f8 03             	cmp    $0x3,%eax
801072bc:	74 3b                	je     801072f9 <trap+0x149>
    exit(0);
}
801072be:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801072c1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801072c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801072c7:	89 ec                	mov    %ebp,%esp
801072c9:	5d                   	pop    %ebp
801072ca:	c3                   	ret    
801072cb:	90                   	nop
801072cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801072d0:	e8 8b c6 ff ff       	call   80103960 <myproc>
801072d5:	8b 70 24             	mov    0x24(%eax),%esi
801072d8:	85 f6                	test   %esi,%esi
801072da:	0f 85 10 01 00 00    	jne    801073f0 <trap+0x240>
    myproc()->tf = tf;
801072e0:	e8 7b c6 ff ff       	call   80103960 <myproc>
801072e5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801072e8:	e8 b3 ee ff ff       	call   801061a0 <syscall>
    if(myproc()->killed)
801072ed:	e8 6e c6 ff ff       	call   80103960 <myproc>
801072f2:	8b 48 24             	mov    0x24(%eax),%ecx
801072f5:	85 c9                	test   %ecx,%ecx
801072f7:	74 c5                	je     801072be <trap+0x10e>
      exit(0);
801072f9:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107300:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107303:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107306:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107309:	89 ec                	mov    %ebp,%esp
8010730b:	5d                   	pop    %ebp
      exit(0);
8010730c:	e9 9f d1 ff ff       	jmp    801044b0 <exit>
80107311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107318:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010731c:	75 80                	jne    8010729e <trap+0xee>
    yield();
8010731e:	e8 dd d2 ff ff       	call   80104600 <yield>
80107323:	e9 76 ff ff ff       	jmp    8010729e <trap+0xee>
80107328:	90                   	nop
80107329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107330:	e8 0b c6 ff ff       	call   80103940 <cpuid>
80107335:	85 c0                	test   %eax,%eax
80107337:	0f 84 e3 00 00 00    	je     80107420 <trap+0x270>
8010733d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80107340:	e8 eb b4 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107345:	e8 16 c6 ff ff       	call   80103960 <myproc>
8010734a:	85 c0                	test   %eax,%eax
8010734c:	0f 85 1b ff ff ff    	jne    8010726d <trap+0xbd>
80107352:	e9 31 ff ff ff       	jmp    80107288 <trap+0xd8>
80107357:	89 f6                	mov    %esi,%esi
80107359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80107360:	e8 8b b3 ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80107365:	e8 c6 b4 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010736a:	e8 f1 c5 ff ff       	call   80103960 <myproc>
8010736f:	85 c0                	test   %eax,%eax
80107371:	0f 85 f6 fe ff ff    	jne    8010726d <trap+0xbd>
80107377:	e9 0c ff ff ff       	jmp    80107288 <trap+0xd8>
8010737c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107380:	e8 6b 02 00 00       	call   801075f0 <uartintr>
    lapiceoi();
80107385:	e8 a6 b4 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010738a:	e8 d1 c5 ff ff       	call   80103960 <myproc>
8010738f:	85 c0                	test   %eax,%eax
80107391:	0f 85 d6 fe ff ff    	jne    8010726d <trap+0xbd>
80107397:	e9 ec fe ff ff       	jmp    80107288 <trap+0xd8>
8010739c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801073a0:	8b 7b 38             	mov    0x38(%ebx),%edi
801073a3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801073a7:	e8 94 c5 ff ff       	call   80103940 <cpuid>
801073ac:	c7 04 24 54 92 10 80 	movl   $0x80109254,(%esp)
801073b3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801073b7:	89 74 24 08          	mov    %esi,0x8(%esp)
801073bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801073bf:	e8 8c 92 ff ff       	call   80100650 <cprintf>
    lapiceoi();
801073c4:	e8 67 b4 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801073c9:	e8 92 c5 ff ff       	call   80103960 <myproc>
801073ce:	85 c0                	test   %eax,%eax
801073d0:	0f 85 97 fe ff ff    	jne    8010726d <trap+0xbd>
801073d6:	e9 ad fe ff ff       	jmp    80107288 <trap+0xd8>
801073db:	90                   	nop
801073dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801073e0:	e8 5b ad ff ff       	call   80102140 <ideintr>
801073e5:	e9 53 ff ff ff       	jmp    8010733d <trap+0x18d>
801073ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
801073f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801073f7:	e8 b4 d0 ff ff       	call   801044b0 <exit>
801073fc:	e9 df fe ff ff       	jmp    801072e0 <trap+0x130>
80107401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107408:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010740f:	e8 9c d0 ff ff       	call   801044b0 <exit>
80107414:	e9 6f fe ff ff       	jmp    80107288 <trap+0xd8>
80107419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80107420:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80107427:	e8 a4 e8 ff ff       	call   80105cd0 <acquire>
      wakeup(&ticks);
8010742c:	c7 04 24 00 81 11 80 	movl   $0x80118100,(%esp)
      ticks++;
80107433:	ff 05 00 81 11 80    	incl   0x80118100
      wakeup(&ticks);
80107439:	e8 c2 d6 ff ff       	call   80104b00 <wakeup>
      release(&tickslock);
8010743e:	c7 04 24 c0 78 11 80 	movl   $0x801178c0,(%esp)
80107445:	e8 26 e9 ff ff       	call   80105d70 <release>
8010744a:	e9 ee fe ff ff       	jmp    8010733d <trap+0x18d>
8010744f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107452:	e8 e9 c4 ff ff       	call   80103940 <cpuid>
80107457:	89 74 24 10          	mov    %esi,0x10(%esp)
8010745b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010745f:	89 44 24 08          	mov    %eax,0x8(%esp)
80107463:	8b 43 30             	mov    0x30(%ebx),%eax
80107466:	c7 04 24 78 92 10 80 	movl   $0x80109278,(%esp)
8010746d:	89 44 24 04          	mov    %eax,0x4(%esp)
80107471:	e8 da 91 ff ff       	call   80100650 <cprintf>
      panic("trap");
80107476:	c7 04 24 4e 92 10 80 	movl   $0x8010924e,(%esp)
8010747d:	e8 ee 8e ff ff       	call   80100370 <panic>
80107482:	66 90                	xchg   %ax,%ax
80107484:	66 90                	xchg   %ax,%ax
80107486:	66 90                	xchg   %ax,%ax
80107488:	66 90                	xchg   %ax,%ax
8010748a:	66 90                	xchg   %ax,%ax
8010748c:	66 90                	xchg   %ax,%ax
8010748e:	66 90                	xchg   %ax,%ax

80107490 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107490:	a1 10 c6 10 80       	mov    0x8010c610,%eax
{
80107495:	55                   	push   %ebp
80107496:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107498:	85 c0                	test   %eax,%eax
8010749a:	74 1c                	je     801074b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010749c:	ba fd 03 00 00       	mov    $0x3fd,%edx
801074a1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801074a2:	24 01                	and    $0x1,%al
801074a4:	84 c0                	test   %al,%al
801074a6:	74 10                	je     801074b8 <uartgetc+0x28>
801074a8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801074ad:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801074ae:	0f b6 c0             	movzbl %al,%eax
}
801074b1:	5d                   	pop    %ebp
801074b2:	c3                   	ret    
801074b3:	90                   	nop
801074b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801074b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074bd:	5d                   	pop    %ebp
801074be:	c3                   	ret    
801074bf:	90                   	nop

801074c0 <uartputc.part.0>:
uartputc(int c)
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	56                   	push   %esi
801074c4:	be fd 03 00 00       	mov    $0x3fd,%esi
801074c9:	53                   	push   %ebx
801074ca:	bb 80 00 00 00       	mov    $0x80,%ebx
801074cf:	83 ec 20             	sub    $0x20,%esp
801074d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801074d5:	eb 18                	jmp    801074ef <uartputc.part.0+0x2f>
801074d7:	89 f6                	mov    %esi,%esi
801074d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801074e0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801074e7:	e8 64 b3 ff ff       	call   80102850 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801074ec:	4b                   	dec    %ebx
801074ed:	74 09                	je     801074f8 <uartputc.part.0+0x38>
801074ef:	89 f2                	mov    %esi,%edx
801074f1:	ec                   	in     (%dx),%al
801074f2:	24 20                	and    $0x20,%al
801074f4:	84 c0                	test   %al,%al
801074f6:	74 e8                	je     801074e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801074f8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801074fd:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107501:	ee                   	out    %al,(%dx)
}
80107502:	83 c4 20             	add    $0x20,%esp
80107505:	5b                   	pop    %ebx
80107506:	5e                   	pop    %esi
80107507:	5d                   	pop    %ebp
80107508:	c3                   	ret    
80107509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107510 <uartinit>:
{
80107510:	55                   	push   %ebp
80107511:	31 c9                	xor    %ecx,%ecx
80107513:	89 e5                	mov    %esp,%ebp
80107515:	88 c8                	mov    %cl,%al
80107517:	57                   	push   %edi
80107518:	56                   	push   %esi
80107519:	53                   	push   %ebx
8010751a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010751f:	83 ec 1c             	sub    $0x1c,%esp
80107522:	89 da                	mov    %ebx,%edx
80107524:	ee                   	out    %al,(%dx)
80107525:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010752a:	b0 80                	mov    $0x80,%al
8010752c:	89 fa                	mov    %edi,%edx
8010752e:	ee                   	out    %al,(%dx)
8010752f:	b0 0c                	mov    $0xc,%al
80107531:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107536:	ee                   	out    %al,(%dx)
80107537:	be f9 03 00 00       	mov    $0x3f9,%esi
8010753c:	88 c8                	mov    %cl,%al
8010753e:	89 f2                	mov    %esi,%edx
80107540:	ee                   	out    %al,(%dx)
80107541:	b0 03                	mov    $0x3,%al
80107543:	89 fa                	mov    %edi,%edx
80107545:	ee                   	out    %al,(%dx)
80107546:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010754b:	88 c8                	mov    %cl,%al
8010754d:	ee                   	out    %al,(%dx)
8010754e:	b0 01                	mov    $0x1,%al
80107550:	89 f2                	mov    %esi,%edx
80107552:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107553:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107558:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107559:	fe c0                	inc    %al
8010755b:	74 52                	je     801075af <uartinit+0x9f>
  uart = 1;
8010755d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107562:	89 da                	mov    %ebx,%edx
80107564:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
8010756a:	ec                   	in     (%dx),%al
8010756b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107570:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107571:	31 db                	xor    %ebx,%ebx
80107573:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80107577:	bb 70 93 10 80       	mov    $0x80109370,%ebx
  ioapicenable(IRQ_COM1, 0);
8010757c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107583:	e8 f8 ad ff ff       	call   80102380 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107588:	b8 78 00 00 00       	mov    $0x78,%eax
8010758d:	eb 09                	jmp    80107598 <uartinit+0x88>
8010758f:	90                   	nop
80107590:	43                   	inc    %ebx
80107591:	0f be 03             	movsbl (%ebx),%eax
80107594:	84 c0                	test   %al,%al
80107596:	74 17                	je     801075af <uartinit+0x9f>
  if(!uart)
80107598:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
8010759e:	85 d2                	test   %edx,%edx
801075a0:	74 ee                	je     80107590 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801075a2:	43                   	inc    %ebx
801075a3:	e8 18 ff ff ff       	call   801074c0 <uartputc.part.0>
801075a8:	0f be 03             	movsbl (%ebx),%eax
801075ab:	84 c0                	test   %al,%al
801075ad:	75 e9                	jne    80107598 <uartinit+0x88>
}
801075af:	83 c4 1c             	add    $0x1c,%esp
801075b2:	5b                   	pop    %ebx
801075b3:	5e                   	pop    %esi
801075b4:	5f                   	pop    %edi
801075b5:	5d                   	pop    %ebp
801075b6:	c3                   	ret    
801075b7:	89 f6                	mov    %esi,%esi
801075b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075c0 <uartputc>:
  if(!uart)
801075c0:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
{
801075c6:	55                   	push   %ebp
801075c7:	89 e5                	mov    %esp,%ebp
801075c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801075cc:	85 d2                	test   %edx,%edx
801075ce:	74 10                	je     801075e0 <uartputc+0x20>
}
801075d0:	5d                   	pop    %ebp
801075d1:	e9 ea fe ff ff       	jmp    801074c0 <uartputc.part.0>
801075d6:	8d 76 00             	lea    0x0(%esi),%esi
801075d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801075e0:	5d                   	pop    %ebp
801075e1:	c3                   	ret    
801075e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075f0 <uartintr>:

void
uartintr(void)
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801075f6:	c7 04 24 90 74 10 80 	movl   $0x80107490,(%esp)
801075fd:	e8 ce 91 ff ff       	call   801007d0 <consoleintr>
}
80107602:	c9                   	leave  
80107603:	c3                   	ret    

80107604 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107604:	6a 00                	push   $0x0
  pushl $0
80107606:	6a 00                	push   $0x0
  jmp alltraps
80107608:	e9 ca fa ff ff       	jmp    801070d7 <alltraps>

8010760d <vector1>:
.globl vector1
vector1:
  pushl $0
8010760d:	6a 00                	push   $0x0
  pushl $1
8010760f:	6a 01                	push   $0x1
  jmp alltraps
80107611:	e9 c1 fa ff ff       	jmp    801070d7 <alltraps>

80107616 <vector2>:
.globl vector2
vector2:
  pushl $0
80107616:	6a 00                	push   $0x0
  pushl $2
80107618:	6a 02                	push   $0x2
  jmp alltraps
8010761a:	e9 b8 fa ff ff       	jmp    801070d7 <alltraps>

8010761f <vector3>:
.globl vector3
vector3:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $3
80107621:	6a 03                	push   $0x3
  jmp alltraps
80107623:	e9 af fa ff ff       	jmp    801070d7 <alltraps>

80107628 <vector4>:
.globl vector4
vector4:
  pushl $0
80107628:	6a 00                	push   $0x0
  pushl $4
8010762a:	6a 04                	push   $0x4
  jmp alltraps
8010762c:	e9 a6 fa ff ff       	jmp    801070d7 <alltraps>

80107631 <vector5>:
.globl vector5
vector5:
  pushl $0
80107631:	6a 00                	push   $0x0
  pushl $5
80107633:	6a 05                	push   $0x5
  jmp alltraps
80107635:	e9 9d fa ff ff       	jmp    801070d7 <alltraps>

8010763a <vector6>:
.globl vector6
vector6:
  pushl $0
8010763a:	6a 00                	push   $0x0
  pushl $6
8010763c:	6a 06                	push   $0x6
  jmp alltraps
8010763e:	e9 94 fa ff ff       	jmp    801070d7 <alltraps>

80107643 <vector7>:
.globl vector7
vector7:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $7
80107645:	6a 07                	push   $0x7
  jmp alltraps
80107647:	e9 8b fa ff ff       	jmp    801070d7 <alltraps>

8010764c <vector8>:
.globl vector8
vector8:
  pushl $8
8010764c:	6a 08                	push   $0x8
  jmp alltraps
8010764e:	e9 84 fa ff ff       	jmp    801070d7 <alltraps>

80107653 <vector9>:
.globl vector9
vector9:
  pushl $0
80107653:	6a 00                	push   $0x0
  pushl $9
80107655:	6a 09                	push   $0x9
  jmp alltraps
80107657:	e9 7b fa ff ff       	jmp    801070d7 <alltraps>

8010765c <vector10>:
.globl vector10
vector10:
  pushl $10
8010765c:	6a 0a                	push   $0xa
  jmp alltraps
8010765e:	e9 74 fa ff ff       	jmp    801070d7 <alltraps>

80107663 <vector11>:
.globl vector11
vector11:
  pushl $11
80107663:	6a 0b                	push   $0xb
  jmp alltraps
80107665:	e9 6d fa ff ff       	jmp    801070d7 <alltraps>

8010766a <vector12>:
.globl vector12
vector12:
  pushl $12
8010766a:	6a 0c                	push   $0xc
  jmp alltraps
8010766c:	e9 66 fa ff ff       	jmp    801070d7 <alltraps>

80107671 <vector13>:
.globl vector13
vector13:
  pushl $13
80107671:	6a 0d                	push   $0xd
  jmp alltraps
80107673:	e9 5f fa ff ff       	jmp    801070d7 <alltraps>

80107678 <vector14>:
.globl vector14
vector14:
  pushl $14
80107678:	6a 0e                	push   $0xe
  jmp alltraps
8010767a:	e9 58 fa ff ff       	jmp    801070d7 <alltraps>

8010767f <vector15>:
.globl vector15
vector15:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $15
80107681:	6a 0f                	push   $0xf
  jmp alltraps
80107683:	e9 4f fa ff ff       	jmp    801070d7 <alltraps>

80107688 <vector16>:
.globl vector16
vector16:
  pushl $0
80107688:	6a 00                	push   $0x0
  pushl $16
8010768a:	6a 10                	push   $0x10
  jmp alltraps
8010768c:	e9 46 fa ff ff       	jmp    801070d7 <alltraps>

80107691 <vector17>:
.globl vector17
vector17:
  pushl $17
80107691:	6a 11                	push   $0x11
  jmp alltraps
80107693:	e9 3f fa ff ff       	jmp    801070d7 <alltraps>

80107698 <vector18>:
.globl vector18
vector18:
  pushl $0
80107698:	6a 00                	push   $0x0
  pushl $18
8010769a:	6a 12                	push   $0x12
  jmp alltraps
8010769c:	e9 36 fa ff ff       	jmp    801070d7 <alltraps>

801076a1 <vector19>:
.globl vector19
vector19:
  pushl $0
801076a1:	6a 00                	push   $0x0
  pushl $19
801076a3:	6a 13                	push   $0x13
  jmp alltraps
801076a5:	e9 2d fa ff ff       	jmp    801070d7 <alltraps>

801076aa <vector20>:
.globl vector20
vector20:
  pushl $0
801076aa:	6a 00                	push   $0x0
  pushl $20
801076ac:	6a 14                	push   $0x14
  jmp alltraps
801076ae:	e9 24 fa ff ff       	jmp    801070d7 <alltraps>

801076b3 <vector21>:
.globl vector21
vector21:
  pushl $0
801076b3:	6a 00                	push   $0x0
  pushl $21
801076b5:	6a 15                	push   $0x15
  jmp alltraps
801076b7:	e9 1b fa ff ff       	jmp    801070d7 <alltraps>

801076bc <vector22>:
.globl vector22
vector22:
  pushl $0
801076bc:	6a 00                	push   $0x0
  pushl $22
801076be:	6a 16                	push   $0x16
  jmp alltraps
801076c0:	e9 12 fa ff ff       	jmp    801070d7 <alltraps>

801076c5 <vector23>:
.globl vector23
vector23:
  pushl $0
801076c5:	6a 00                	push   $0x0
  pushl $23
801076c7:	6a 17                	push   $0x17
  jmp alltraps
801076c9:	e9 09 fa ff ff       	jmp    801070d7 <alltraps>

801076ce <vector24>:
.globl vector24
vector24:
  pushl $0
801076ce:	6a 00                	push   $0x0
  pushl $24
801076d0:	6a 18                	push   $0x18
  jmp alltraps
801076d2:	e9 00 fa ff ff       	jmp    801070d7 <alltraps>

801076d7 <vector25>:
.globl vector25
vector25:
  pushl $0
801076d7:	6a 00                	push   $0x0
  pushl $25
801076d9:	6a 19                	push   $0x19
  jmp alltraps
801076db:	e9 f7 f9 ff ff       	jmp    801070d7 <alltraps>

801076e0 <vector26>:
.globl vector26
vector26:
  pushl $0
801076e0:	6a 00                	push   $0x0
  pushl $26
801076e2:	6a 1a                	push   $0x1a
  jmp alltraps
801076e4:	e9 ee f9 ff ff       	jmp    801070d7 <alltraps>

801076e9 <vector27>:
.globl vector27
vector27:
  pushl $0
801076e9:	6a 00                	push   $0x0
  pushl $27
801076eb:	6a 1b                	push   $0x1b
  jmp alltraps
801076ed:	e9 e5 f9 ff ff       	jmp    801070d7 <alltraps>

801076f2 <vector28>:
.globl vector28
vector28:
  pushl $0
801076f2:	6a 00                	push   $0x0
  pushl $28
801076f4:	6a 1c                	push   $0x1c
  jmp alltraps
801076f6:	e9 dc f9 ff ff       	jmp    801070d7 <alltraps>

801076fb <vector29>:
.globl vector29
vector29:
  pushl $0
801076fb:	6a 00                	push   $0x0
  pushl $29
801076fd:	6a 1d                	push   $0x1d
  jmp alltraps
801076ff:	e9 d3 f9 ff ff       	jmp    801070d7 <alltraps>

80107704 <vector30>:
.globl vector30
vector30:
  pushl $0
80107704:	6a 00                	push   $0x0
  pushl $30
80107706:	6a 1e                	push   $0x1e
  jmp alltraps
80107708:	e9 ca f9 ff ff       	jmp    801070d7 <alltraps>

8010770d <vector31>:
.globl vector31
vector31:
  pushl $0
8010770d:	6a 00                	push   $0x0
  pushl $31
8010770f:	6a 1f                	push   $0x1f
  jmp alltraps
80107711:	e9 c1 f9 ff ff       	jmp    801070d7 <alltraps>

80107716 <vector32>:
.globl vector32
vector32:
  pushl $0
80107716:	6a 00                	push   $0x0
  pushl $32
80107718:	6a 20                	push   $0x20
  jmp alltraps
8010771a:	e9 b8 f9 ff ff       	jmp    801070d7 <alltraps>

8010771f <vector33>:
.globl vector33
vector33:
  pushl $0
8010771f:	6a 00                	push   $0x0
  pushl $33
80107721:	6a 21                	push   $0x21
  jmp alltraps
80107723:	e9 af f9 ff ff       	jmp    801070d7 <alltraps>

80107728 <vector34>:
.globl vector34
vector34:
  pushl $0
80107728:	6a 00                	push   $0x0
  pushl $34
8010772a:	6a 22                	push   $0x22
  jmp alltraps
8010772c:	e9 a6 f9 ff ff       	jmp    801070d7 <alltraps>

80107731 <vector35>:
.globl vector35
vector35:
  pushl $0
80107731:	6a 00                	push   $0x0
  pushl $35
80107733:	6a 23                	push   $0x23
  jmp alltraps
80107735:	e9 9d f9 ff ff       	jmp    801070d7 <alltraps>

8010773a <vector36>:
.globl vector36
vector36:
  pushl $0
8010773a:	6a 00                	push   $0x0
  pushl $36
8010773c:	6a 24                	push   $0x24
  jmp alltraps
8010773e:	e9 94 f9 ff ff       	jmp    801070d7 <alltraps>

80107743 <vector37>:
.globl vector37
vector37:
  pushl $0
80107743:	6a 00                	push   $0x0
  pushl $37
80107745:	6a 25                	push   $0x25
  jmp alltraps
80107747:	e9 8b f9 ff ff       	jmp    801070d7 <alltraps>

8010774c <vector38>:
.globl vector38
vector38:
  pushl $0
8010774c:	6a 00                	push   $0x0
  pushl $38
8010774e:	6a 26                	push   $0x26
  jmp alltraps
80107750:	e9 82 f9 ff ff       	jmp    801070d7 <alltraps>

80107755 <vector39>:
.globl vector39
vector39:
  pushl $0
80107755:	6a 00                	push   $0x0
  pushl $39
80107757:	6a 27                	push   $0x27
  jmp alltraps
80107759:	e9 79 f9 ff ff       	jmp    801070d7 <alltraps>

8010775e <vector40>:
.globl vector40
vector40:
  pushl $0
8010775e:	6a 00                	push   $0x0
  pushl $40
80107760:	6a 28                	push   $0x28
  jmp alltraps
80107762:	e9 70 f9 ff ff       	jmp    801070d7 <alltraps>

80107767 <vector41>:
.globl vector41
vector41:
  pushl $0
80107767:	6a 00                	push   $0x0
  pushl $41
80107769:	6a 29                	push   $0x29
  jmp alltraps
8010776b:	e9 67 f9 ff ff       	jmp    801070d7 <alltraps>

80107770 <vector42>:
.globl vector42
vector42:
  pushl $0
80107770:	6a 00                	push   $0x0
  pushl $42
80107772:	6a 2a                	push   $0x2a
  jmp alltraps
80107774:	e9 5e f9 ff ff       	jmp    801070d7 <alltraps>

80107779 <vector43>:
.globl vector43
vector43:
  pushl $0
80107779:	6a 00                	push   $0x0
  pushl $43
8010777b:	6a 2b                	push   $0x2b
  jmp alltraps
8010777d:	e9 55 f9 ff ff       	jmp    801070d7 <alltraps>

80107782 <vector44>:
.globl vector44
vector44:
  pushl $0
80107782:	6a 00                	push   $0x0
  pushl $44
80107784:	6a 2c                	push   $0x2c
  jmp alltraps
80107786:	e9 4c f9 ff ff       	jmp    801070d7 <alltraps>

8010778b <vector45>:
.globl vector45
vector45:
  pushl $0
8010778b:	6a 00                	push   $0x0
  pushl $45
8010778d:	6a 2d                	push   $0x2d
  jmp alltraps
8010778f:	e9 43 f9 ff ff       	jmp    801070d7 <alltraps>

80107794 <vector46>:
.globl vector46
vector46:
  pushl $0
80107794:	6a 00                	push   $0x0
  pushl $46
80107796:	6a 2e                	push   $0x2e
  jmp alltraps
80107798:	e9 3a f9 ff ff       	jmp    801070d7 <alltraps>

8010779d <vector47>:
.globl vector47
vector47:
  pushl $0
8010779d:	6a 00                	push   $0x0
  pushl $47
8010779f:	6a 2f                	push   $0x2f
  jmp alltraps
801077a1:	e9 31 f9 ff ff       	jmp    801070d7 <alltraps>

801077a6 <vector48>:
.globl vector48
vector48:
  pushl $0
801077a6:	6a 00                	push   $0x0
  pushl $48
801077a8:	6a 30                	push   $0x30
  jmp alltraps
801077aa:	e9 28 f9 ff ff       	jmp    801070d7 <alltraps>

801077af <vector49>:
.globl vector49
vector49:
  pushl $0
801077af:	6a 00                	push   $0x0
  pushl $49
801077b1:	6a 31                	push   $0x31
  jmp alltraps
801077b3:	e9 1f f9 ff ff       	jmp    801070d7 <alltraps>

801077b8 <vector50>:
.globl vector50
vector50:
  pushl $0
801077b8:	6a 00                	push   $0x0
  pushl $50
801077ba:	6a 32                	push   $0x32
  jmp alltraps
801077bc:	e9 16 f9 ff ff       	jmp    801070d7 <alltraps>

801077c1 <vector51>:
.globl vector51
vector51:
  pushl $0
801077c1:	6a 00                	push   $0x0
  pushl $51
801077c3:	6a 33                	push   $0x33
  jmp alltraps
801077c5:	e9 0d f9 ff ff       	jmp    801070d7 <alltraps>

801077ca <vector52>:
.globl vector52
vector52:
  pushl $0
801077ca:	6a 00                	push   $0x0
  pushl $52
801077cc:	6a 34                	push   $0x34
  jmp alltraps
801077ce:	e9 04 f9 ff ff       	jmp    801070d7 <alltraps>

801077d3 <vector53>:
.globl vector53
vector53:
  pushl $0
801077d3:	6a 00                	push   $0x0
  pushl $53
801077d5:	6a 35                	push   $0x35
  jmp alltraps
801077d7:	e9 fb f8 ff ff       	jmp    801070d7 <alltraps>

801077dc <vector54>:
.globl vector54
vector54:
  pushl $0
801077dc:	6a 00                	push   $0x0
  pushl $54
801077de:	6a 36                	push   $0x36
  jmp alltraps
801077e0:	e9 f2 f8 ff ff       	jmp    801070d7 <alltraps>

801077e5 <vector55>:
.globl vector55
vector55:
  pushl $0
801077e5:	6a 00                	push   $0x0
  pushl $55
801077e7:	6a 37                	push   $0x37
  jmp alltraps
801077e9:	e9 e9 f8 ff ff       	jmp    801070d7 <alltraps>

801077ee <vector56>:
.globl vector56
vector56:
  pushl $0
801077ee:	6a 00                	push   $0x0
  pushl $56
801077f0:	6a 38                	push   $0x38
  jmp alltraps
801077f2:	e9 e0 f8 ff ff       	jmp    801070d7 <alltraps>

801077f7 <vector57>:
.globl vector57
vector57:
  pushl $0
801077f7:	6a 00                	push   $0x0
  pushl $57
801077f9:	6a 39                	push   $0x39
  jmp alltraps
801077fb:	e9 d7 f8 ff ff       	jmp    801070d7 <alltraps>

80107800 <vector58>:
.globl vector58
vector58:
  pushl $0
80107800:	6a 00                	push   $0x0
  pushl $58
80107802:	6a 3a                	push   $0x3a
  jmp alltraps
80107804:	e9 ce f8 ff ff       	jmp    801070d7 <alltraps>

80107809 <vector59>:
.globl vector59
vector59:
  pushl $0
80107809:	6a 00                	push   $0x0
  pushl $59
8010780b:	6a 3b                	push   $0x3b
  jmp alltraps
8010780d:	e9 c5 f8 ff ff       	jmp    801070d7 <alltraps>

80107812 <vector60>:
.globl vector60
vector60:
  pushl $0
80107812:	6a 00                	push   $0x0
  pushl $60
80107814:	6a 3c                	push   $0x3c
  jmp alltraps
80107816:	e9 bc f8 ff ff       	jmp    801070d7 <alltraps>

8010781b <vector61>:
.globl vector61
vector61:
  pushl $0
8010781b:	6a 00                	push   $0x0
  pushl $61
8010781d:	6a 3d                	push   $0x3d
  jmp alltraps
8010781f:	e9 b3 f8 ff ff       	jmp    801070d7 <alltraps>

80107824 <vector62>:
.globl vector62
vector62:
  pushl $0
80107824:	6a 00                	push   $0x0
  pushl $62
80107826:	6a 3e                	push   $0x3e
  jmp alltraps
80107828:	e9 aa f8 ff ff       	jmp    801070d7 <alltraps>

8010782d <vector63>:
.globl vector63
vector63:
  pushl $0
8010782d:	6a 00                	push   $0x0
  pushl $63
8010782f:	6a 3f                	push   $0x3f
  jmp alltraps
80107831:	e9 a1 f8 ff ff       	jmp    801070d7 <alltraps>

80107836 <vector64>:
.globl vector64
vector64:
  pushl $0
80107836:	6a 00                	push   $0x0
  pushl $64
80107838:	6a 40                	push   $0x40
  jmp alltraps
8010783a:	e9 98 f8 ff ff       	jmp    801070d7 <alltraps>

8010783f <vector65>:
.globl vector65
vector65:
  pushl $0
8010783f:	6a 00                	push   $0x0
  pushl $65
80107841:	6a 41                	push   $0x41
  jmp alltraps
80107843:	e9 8f f8 ff ff       	jmp    801070d7 <alltraps>

80107848 <vector66>:
.globl vector66
vector66:
  pushl $0
80107848:	6a 00                	push   $0x0
  pushl $66
8010784a:	6a 42                	push   $0x42
  jmp alltraps
8010784c:	e9 86 f8 ff ff       	jmp    801070d7 <alltraps>

80107851 <vector67>:
.globl vector67
vector67:
  pushl $0
80107851:	6a 00                	push   $0x0
  pushl $67
80107853:	6a 43                	push   $0x43
  jmp alltraps
80107855:	e9 7d f8 ff ff       	jmp    801070d7 <alltraps>

8010785a <vector68>:
.globl vector68
vector68:
  pushl $0
8010785a:	6a 00                	push   $0x0
  pushl $68
8010785c:	6a 44                	push   $0x44
  jmp alltraps
8010785e:	e9 74 f8 ff ff       	jmp    801070d7 <alltraps>

80107863 <vector69>:
.globl vector69
vector69:
  pushl $0
80107863:	6a 00                	push   $0x0
  pushl $69
80107865:	6a 45                	push   $0x45
  jmp alltraps
80107867:	e9 6b f8 ff ff       	jmp    801070d7 <alltraps>

8010786c <vector70>:
.globl vector70
vector70:
  pushl $0
8010786c:	6a 00                	push   $0x0
  pushl $70
8010786e:	6a 46                	push   $0x46
  jmp alltraps
80107870:	e9 62 f8 ff ff       	jmp    801070d7 <alltraps>

80107875 <vector71>:
.globl vector71
vector71:
  pushl $0
80107875:	6a 00                	push   $0x0
  pushl $71
80107877:	6a 47                	push   $0x47
  jmp alltraps
80107879:	e9 59 f8 ff ff       	jmp    801070d7 <alltraps>

8010787e <vector72>:
.globl vector72
vector72:
  pushl $0
8010787e:	6a 00                	push   $0x0
  pushl $72
80107880:	6a 48                	push   $0x48
  jmp alltraps
80107882:	e9 50 f8 ff ff       	jmp    801070d7 <alltraps>

80107887 <vector73>:
.globl vector73
vector73:
  pushl $0
80107887:	6a 00                	push   $0x0
  pushl $73
80107889:	6a 49                	push   $0x49
  jmp alltraps
8010788b:	e9 47 f8 ff ff       	jmp    801070d7 <alltraps>

80107890 <vector74>:
.globl vector74
vector74:
  pushl $0
80107890:	6a 00                	push   $0x0
  pushl $74
80107892:	6a 4a                	push   $0x4a
  jmp alltraps
80107894:	e9 3e f8 ff ff       	jmp    801070d7 <alltraps>

80107899 <vector75>:
.globl vector75
vector75:
  pushl $0
80107899:	6a 00                	push   $0x0
  pushl $75
8010789b:	6a 4b                	push   $0x4b
  jmp alltraps
8010789d:	e9 35 f8 ff ff       	jmp    801070d7 <alltraps>

801078a2 <vector76>:
.globl vector76
vector76:
  pushl $0
801078a2:	6a 00                	push   $0x0
  pushl $76
801078a4:	6a 4c                	push   $0x4c
  jmp alltraps
801078a6:	e9 2c f8 ff ff       	jmp    801070d7 <alltraps>

801078ab <vector77>:
.globl vector77
vector77:
  pushl $0
801078ab:	6a 00                	push   $0x0
  pushl $77
801078ad:	6a 4d                	push   $0x4d
  jmp alltraps
801078af:	e9 23 f8 ff ff       	jmp    801070d7 <alltraps>

801078b4 <vector78>:
.globl vector78
vector78:
  pushl $0
801078b4:	6a 00                	push   $0x0
  pushl $78
801078b6:	6a 4e                	push   $0x4e
  jmp alltraps
801078b8:	e9 1a f8 ff ff       	jmp    801070d7 <alltraps>

801078bd <vector79>:
.globl vector79
vector79:
  pushl $0
801078bd:	6a 00                	push   $0x0
  pushl $79
801078bf:	6a 4f                	push   $0x4f
  jmp alltraps
801078c1:	e9 11 f8 ff ff       	jmp    801070d7 <alltraps>

801078c6 <vector80>:
.globl vector80
vector80:
  pushl $0
801078c6:	6a 00                	push   $0x0
  pushl $80
801078c8:	6a 50                	push   $0x50
  jmp alltraps
801078ca:	e9 08 f8 ff ff       	jmp    801070d7 <alltraps>

801078cf <vector81>:
.globl vector81
vector81:
  pushl $0
801078cf:	6a 00                	push   $0x0
  pushl $81
801078d1:	6a 51                	push   $0x51
  jmp alltraps
801078d3:	e9 ff f7 ff ff       	jmp    801070d7 <alltraps>

801078d8 <vector82>:
.globl vector82
vector82:
  pushl $0
801078d8:	6a 00                	push   $0x0
  pushl $82
801078da:	6a 52                	push   $0x52
  jmp alltraps
801078dc:	e9 f6 f7 ff ff       	jmp    801070d7 <alltraps>

801078e1 <vector83>:
.globl vector83
vector83:
  pushl $0
801078e1:	6a 00                	push   $0x0
  pushl $83
801078e3:	6a 53                	push   $0x53
  jmp alltraps
801078e5:	e9 ed f7 ff ff       	jmp    801070d7 <alltraps>

801078ea <vector84>:
.globl vector84
vector84:
  pushl $0
801078ea:	6a 00                	push   $0x0
  pushl $84
801078ec:	6a 54                	push   $0x54
  jmp alltraps
801078ee:	e9 e4 f7 ff ff       	jmp    801070d7 <alltraps>

801078f3 <vector85>:
.globl vector85
vector85:
  pushl $0
801078f3:	6a 00                	push   $0x0
  pushl $85
801078f5:	6a 55                	push   $0x55
  jmp alltraps
801078f7:	e9 db f7 ff ff       	jmp    801070d7 <alltraps>

801078fc <vector86>:
.globl vector86
vector86:
  pushl $0
801078fc:	6a 00                	push   $0x0
  pushl $86
801078fe:	6a 56                	push   $0x56
  jmp alltraps
80107900:	e9 d2 f7 ff ff       	jmp    801070d7 <alltraps>

80107905 <vector87>:
.globl vector87
vector87:
  pushl $0
80107905:	6a 00                	push   $0x0
  pushl $87
80107907:	6a 57                	push   $0x57
  jmp alltraps
80107909:	e9 c9 f7 ff ff       	jmp    801070d7 <alltraps>

8010790e <vector88>:
.globl vector88
vector88:
  pushl $0
8010790e:	6a 00                	push   $0x0
  pushl $88
80107910:	6a 58                	push   $0x58
  jmp alltraps
80107912:	e9 c0 f7 ff ff       	jmp    801070d7 <alltraps>

80107917 <vector89>:
.globl vector89
vector89:
  pushl $0
80107917:	6a 00                	push   $0x0
  pushl $89
80107919:	6a 59                	push   $0x59
  jmp alltraps
8010791b:	e9 b7 f7 ff ff       	jmp    801070d7 <alltraps>

80107920 <vector90>:
.globl vector90
vector90:
  pushl $0
80107920:	6a 00                	push   $0x0
  pushl $90
80107922:	6a 5a                	push   $0x5a
  jmp alltraps
80107924:	e9 ae f7 ff ff       	jmp    801070d7 <alltraps>

80107929 <vector91>:
.globl vector91
vector91:
  pushl $0
80107929:	6a 00                	push   $0x0
  pushl $91
8010792b:	6a 5b                	push   $0x5b
  jmp alltraps
8010792d:	e9 a5 f7 ff ff       	jmp    801070d7 <alltraps>

80107932 <vector92>:
.globl vector92
vector92:
  pushl $0
80107932:	6a 00                	push   $0x0
  pushl $92
80107934:	6a 5c                	push   $0x5c
  jmp alltraps
80107936:	e9 9c f7 ff ff       	jmp    801070d7 <alltraps>

8010793b <vector93>:
.globl vector93
vector93:
  pushl $0
8010793b:	6a 00                	push   $0x0
  pushl $93
8010793d:	6a 5d                	push   $0x5d
  jmp alltraps
8010793f:	e9 93 f7 ff ff       	jmp    801070d7 <alltraps>

80107944 <vector94>:
.globl vector94
vector94:
  pushl $0
80107944:	6a 00                	push   $0x0
  pushl $94
80107946:	6a 5e                	push   $0x5e
  jmp alltraps
80107948:	e9 8a f7 ff ff       	jmp    801070d7 <alltraps>

8010794d <vector95>:
.globl vector95
vector95:
  pushl $0
8010794d:	6a 00                	push   $0x0
  pushl $95
8010794f:	6a 5f                	push   $0x5f
  jmp alltraps
80107951:	e9 81 f7 ff ff       	jmp    801070d7 <alltraps>

80107956 <vector96>:
.globl vector96
vector96:
  pushl $0
80107956:	6a 00                	push   $0x0
  pushl $96
80107958:	6a 60                	push   $0x60
  jmp alltraps
8010795a:	e9 78 f7 ff ff       	jmp    801070d7 <alltraps>

8010795f <vector97>:
.globl vector97
vector97:
  pushl $0
8010795f:	6a 00                	push   $0x0
  pushl $97
80107961:	6a 61                	push   $0x61
  jmp alltraps
80107963:	e9 6f f7 ff ff       	jmp    801070d7 <alltraps>

80107968 <vector98>:
.globl vector98
vector98:
  pushl $0
80107968:	6a 00                	push   $0x0
  pushl $98
8010796a:	6a 62                	push   $0x62
  jmp alltraps
8010796c:	e9 66 f7 ff ff       	jmp    801070d7 <alltraps>

80107971 <vector99>:
.globl vector99
vector99:
  pushl $0
80107971:	6a 00                	push   $0x0
  pushl $99
80107973:	6a 63                	push   $0x63
  jmp alltraps
80107975:	e9 5d f7 ff ff       	jmp    801070d7 <alltraps>

8010797a <vector100>:
.globl vector100
vector100:
  pushl $0
8010797a:	6a 00                	push   $0x0
  pushl $100
8010797c:	6a 64                	push   $0x64
  jmp alltraps
8010797e:	e9 54 f7 ff ff       	jmp    801070d7 <alltraps>

80107983 <vector101>:
.globl vector101
vector101:
  pushl $0
80107983:	6a 00                	push   $0x0
  pushl $101
80107985:	6a 65                	push   $0x65
  jmp alltraps
80107987:	e9 4b f7 ff ff       	jmp    801070d7 <alltraps>

8010798c <vector102>:
.globl vector102
vector102:
  pushl $0
8010798c:	6a 00                	push   $0x0
  pushl $102
8010798e:	6a 66                	push   $0x66
  jmp alltraps
80107990:	e9 42 f7 ff ff       	jmp    801070d7 <alltraps>

80107995 <vector103>:
.globl vector103
vector103:
  pushl $0
80107995:	6a 00                	push   $0x0
  pushl $103
80107997:	6a 67                	push   $0x67
  jmp alltraps
80107999:	e9 39 f7 ff ff       	jmp    801070d7 <alltraps>

8010799e <vector104>:
.globl vector104
vector104:
  pushl $0
8010799e:	6a 00                	push   $0x0
  pushl $104
801079a0:	6a 68                	push   $0x68
  jmp alltraps
801079a2:	e9 30 f7 ff ff       	jmp    801070d7 <alltraps>

801079a7 <vector105>:
.globl vector105
vector105:
  pushl $0
801079a7:	6a 00                	push   $0x0
  pushl $105
801079a9:	6a 69                	push   $0x69
  jmp alltraps
801079ab:	e9 27 f7 ff ff       	jmp    801070d7 <alltraps>

801079b0 <vector106>:
.globl vector106
vector106:
  pushl $0
801079b0:	6a 00                	push   $0x0
  pushl $106
801079b2:	6a 6a                	push   $0x6a
  jmp alltraps
801079b4:	e9 1e f7 ff ff       	jmp    801070d7 <alltraps>

801079b9 <vector107>:
.globl vector107
vector107:
  pushl $0
801079b9:	6a 00                	push   $0x0
  pushl $107
801079bb:	6a 6b                	push   $0x6b
  jmp alltraps
801079bd:	e9 15 f7 ff ff       	jmp    801070d7 <alltraps>

801079c2 <vector108>:
.globl vector108
vector108:
  pushl $0
801079c2:	6a 00                	push   $0x0
  pushl $108
801079c4:	6a 6c                	push   $0x6c
  jmp alltraps
801079c6:	e9 0c f7 ff ff       	jmp    801070d7 <alltraps>

801079cb <vector109>:
.globl vector109
vector109:
  pushl $0
801079cb:	6a 00                	push   $0x0
  pushl $109
801079cd:	6a 6d                	push   $0x6d
  jmp alltraps
801079cf:	e9 03 f7 ff ff       	jmp    801070d7 <alltraps>

801079d4 <vector110>:
.globl vector110
vector110:
  pushl $0
801079d4:	6a 00                	push   $0x0
  pushl $110
801079d6:	6a 6e                	push   $0x6e
  jmp alltraps
801079d8:	e9 fa f6 ff ff       	jmp    801070d7 <alltraps>

801079dd <vector111>:
.globl vector111
vector111:
  pushl $0
801079dd:	6a 00                	push   $0x0
  pushl $111
801079df:	6a 6f                	push   $0x6f
  jmp alltraps
801079e1:	e9 f1 f6 ff ff       	jmp    801070d7 <alltraps>

801079e6 <vector112>:
.globl vector112
vector112:
  pushl $0
801079e6:	6a 00                	push   $0x0
  pushl $112
801079e8:	6a 70                	push   $0x70
  jmp alltraps
801079ea:	e9 e8 f6 ff ff       	jmp    801070d7 <alltraps>

801079ef <vector113>:
.globl vector113
vector113:
  pushl $0
801079ef:	6a 00                	push   $0x0
  pushl $113
801079f1:	6a 71                	push   $0x71
  jmp alltraps
801079f3:	e9 df f6 ff ff       	jmp    801070d7 <alltraps>

801079f8 <vector114>:
.globl vector114
vector114:
  pushl $0
801079f8:	6a 00                	push   $0x0
  pushl $114
801079fa:	6a 72                	push   $0x72
  jmp alltraps
801079fc:	e9 d6 f6 ff ff       	jmp    801070d7 <alltraps>

80107a01 <vector115>:
.globl vector115
vector115:
  pushl $0
80107a01:	6a 00                	push   $0x0
  pushl $115
80107a03:	6a 73                	push   $0x73
  jmp alltraps
80107a05:	e9 cd f6 ff ff       	jmp    801070d7 <alltraps>

80107a0a <vector116>:
.globl vector116
vector116:
  pushl $0
80107a0a:	6a 00                	push   $0x0
  pushl $116
80107a0c:	6a 74                	push   $0x74
  jmp alltraps
80107a0e:	e9 c4 f6 ff ff       	jmp    801070d7 <alltraps>

80107a13 <vector117>:
.globl vector117
vector117:
  pushl $0
80107a13:	6a 00                	push   $0x0
  pushl $117
80107a15:	6a 75                	push   $0x75
  jmp alltraps
80107a17:	e9 bb f6 ff ff       	jmp    801070d7 <alltraps>

80107a1c <vector118>:
.globl vector118
vector118:
  pushl $0
80107a1c:	6a 00                	push   $0x0
  pushl $118
80107a1e:	6a 76                	push   $0x76
  jmp alltraps
80107a20:	e9 b2 f6 ff ff       	jmp    801070d7 <alltraps>

80107a25 <vector119>:
.globl vector119
vector119:
  pushl $0
80107a25:	6a 00                	push   $0x0
  pushl $119
80107a27:	6a 77                	push   $0x77
  jmp alltraps
80107a29:	e9 a9 f6 ff ff       	jmp    801070d7 <alltraps>

80107a2e <vector120>:
.globl vector120
vector120:
  pushl $0
80107a2e:	6a 00                	push   $0x0
  pushl $120
80107a30:	6a 78                	push   $0x78
  jmp alltraps
80107a32:	e9 a0 f6 ff ff       	jmp    801070d7 <alltraps>

80107a37 <vector121>:
.globl vector121
vector121:
  pushl $0
80107a37:	6a 00                	push   $0x0
  pushl $121
80107a39:	6a 79                	push   $0x79
  jmp alltraps
80107a3b:	e9 97 f6 ff ff       	jmp    801070d7 <alltraps>

80107a40 <vector122>:
.globl vector122
vector122:
  pushl $0
80107a40:	6a 00                	push   $0x0
  pushl $122
80107a42:	6a 7a                	push   $0x7a
  jmp alltraps
80107a44:	e9 8e f6 ff ff       	jmp    801070d7 <alltraps>

80107a49 <vector123>:
.globl vector123
vector123:
  pushl $0
80107a49:	6a 00                	push   $0x0
  pushl $123
80107a4b:	6a 7b                	push   $0x7b
  jmp alltraps
80107a4d:	e9 85 f6 ff ff       	jmp    801070d7 <alltraps>

80107a52 <vector124>:
.globl vector124
vector124:
  pushl $0
80107a52:	6a 00                	push   $0x0
  pushl $124
80107a54:	6a 7c                	push   $0x7c
  jmp alltraps
80107a56:	e9 7c f6 ff ff       	jmp    801070d7 <alltraps>

80107a5b <vector125>:
.globl vector125
vector125:
  pushl $0
80107a5b:	6a 00                	push   $0x0
  pushl $125
80107a5d:	6a 7d                	push   $0x7d
  jmp alltraps
80107a5f:	e9 73 f6 ff ff       	jmp    801070d7 <alltraps>

80107a64 <vector126>:
.globl vector126
vector126:
  pushl $0
80107a64:	6a 00                	push   $0x0
  pushl $126
80107a66:	6a 7e                	push   $0x7e
  jmp alltraps
80107a68:	e9 6a f6 ff ff       	jmp    801070d7 <alltraps>

80107a6d <vector127>:
.globl vector127
vector127:
  pushl $0
80107a6d:	6a 00                	push   $0x0
  pushl $127
80107a6f:	6a 7f                	push   $0x7f
  jmp alltraps
80107a71:	e9 61 f6 ff ff       	jmp    801070d7 <alltraps>

80107a76 <vector128>:
.globl vector128
vector128:
  pushl $0
80107a76:	6a 00                	push   $0x0
  pushl $128
80107a78:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107a7d:	e9 55 f6 ff ff       	jmp    801070d7 <alltraps>

80107a82 <vector129>:
.globl vector129
vector129:
  pushl $0
80107a82:	6a 00                	push   $0x0
  pushl $129
80107a84:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107a89:	e9 49 f6 ff ff       	jmp    801070d7 <alltraps>

80107a8e <vector130>:
.globl vector130
vector130:
  pushl $0
80107a8e:	6a 00                	push   $0x0
  pushl $130
80107a90:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107a95:	e9 3d f6 ff ff       	jmp    801070d7 <alltraps>

80107a9a <vector131>:
.globl vector131
vector131:
  pushl $0
80107a9a:	6a 00                	push   $0x0
  pushl $131
80107a9c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107aa1:	e9 31 f6 ff ff       	jmp    801070d7 <alltraps>

80107aa6 <vector132>:
.globl vector132
vector132:
  pushl $0
80107aa6:	6a 00                	push   $0x0
  pushl $132
80107aa8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107aad:	e9 25 f6 ff ff       	jmp    801070d7 <alltraps>

80107ab2 <vector133>:
.globl vector133
vector133:
  pushl $0
80107ab2:	6a 00                	push   $0x0
  pushl $133
80107ab4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107ab9:	e9 19 f6 ff ff       	jmp    801070d7 <alltraps>

80107abe <vector134>:
.globl vector134
vector134:
  pushl $0
80107abe:	6a 00                	push   $0x0
  pushl $134
80107ac0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107ac5:	e9 0d f6 ff ff       	jmp    801070d7 <alltraps>

80107aca <vector135>:
.globl vector135
vector135:
  pushl $0
80107aca:	6a 00                	push   $0x0
  pushl $135
80107acc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107ad1:	e9 01 f6 ff ff       	jmp    801070d7 <alltraps>

80107ad6 <vector136>:
.globl vector136
vector136:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $136
80107ad8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107add:	e9 f5 f5 ff ff       	jmp    801070d7 <alltraps>

80107ae2 <vector137>:
.globl vector137
vector137:
  pushl $0
80107ae2:	6a 00                	push   $0x0
  pushl $137
80107ae4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107ae9:	e9 e9 f5 ff ff       	jmp    801070d7 <alltraps>

80107aee <vector138>:
.globl vector138
vector138:
  pushl $0
80107aee:	6a 00                	push   $0x0
  pushl $138
80107af0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107af5:	e9 dd f5 ff ff       	jmp    801070d7 <alltraps>

80107afa <vector139>:
.globl vector139
vector139:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $139
80107afc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107b01:	e9 d1 f5 ff ff       	jmp    801070d7 <alltraps>

80107b06 <vector140>:
.globl vector140
vector140:
  pushl $0
80107b06:	6a 00                	push   $0x0
  pushl $140
80107b08:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107b0d:	e9 c5 f5 ff ff       	jmp    801070d7 <alltraps>

80107b12 <vector141>:
.globl vector141
vector141:
  pushl $0
80107b12:	6a 00                	push   $0x0
  pushl $141
80107b14:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107b19:	e9 b9 f5 ff ff       	jmp    801070d7 <alltraps>

80107b1e <vector142>:
.globl vector142
vector142:
  pushl $0
80107b1e:	6a 00                	push   $0x0
  pushl $142
80107b20:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107b25:	e9 ad f5 ff ff       	jmp    801070d7 <alltraps>

80107b2a <vector143>:
.globl vector143
vector143:
  pushl $0
80107b2a:	6a 00                	push   $0x0
  pushl $143
80107b2c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107b31:	e9 a1 f5 ff ff       	jmp    801070d7 <alltraps>

80107b36 <vector144>:
.globl vector144
vector144:
  pushl $0
80107b36:	6a 00                	push   $0x0
  pushl $144
80107b38:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107b3d:	e9 95 f5 ff ff       	jmp    801070d7 <alltraps>

80107b42 <vector145>:
.globl vector145
vector145:
  pushl $0
80107b42:	6a 00                	push   $0x0
  pushl $145
80107b44:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107b49:	e9 89 f5 ff ff       	jmp    801070d7 <alltraps>

80107b4e <vector146>:
.globl vector146
vector146:
  pushl $0
80107b4e:	6a 00                	push   $0x0
  pushl $146
80107b50:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107b55:	e9 7d f5 ff ff       	jmp    801070d7 <alltraps>

80107b5a <vector147>:
.globl vector147
vector147:
  pushl $0
80107b5a:	6a 00                	push   $0x0
  pushl $147
80107b5c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107b61:	e9 71 f5 ff ff       	jmp    801070d7 <alltraps>

80107b66 <vector148>:
.globl vector148
vector148:
  pushl $0
80107b66:	6a 00                	push   $0x0
  pushl $148
80107b68:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107b6d:	e9 65 f5 ff ff       	jmp    801070d7 <alltraps>

80107b72 <vector149>:
.globl vector149
vector149:
  pushl $0
80107b72:	6a 00                	push   $0x0
  pushl $149
80107b74:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107b79:	e9 59 f5 ff ff       	jmp    801070d7 <alltraps>

80107b7e <vector150>:
.globl vector150
vector150:
  pushl $0
80107b7e:	6a 00                	push   $0x0
  pushl $150
80107b80:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107b85:	e9 4d f5 ff ff       	jmp    801070d7 <alltraps>

80107b8a <vector151>:
.globl vector151
vector151:
  pushl $0
80107b8a:	6a 00                	push   $0x0
  pushl $151
80107b8c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107b91:	e9 41 f5 ff ff       	jmp    801070d7 <alltraps>

80107b96 <vector152>:
.globl vector152
vector152:
  pushl $0
80107b96:	6a 00                	push   $0x0
  pushl $152
80107b98:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107b9d:	e9 35 f5 ff ff       	jmp    801070d7 <alltraps>

80107ba2 <vector153>:
.globl vector153
vector153:
  pushl $0
80107ba2:	6a 00                	push   $0x0
  pushl $153
80107ba4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107ba9:	e9 29 f5 ff ff       	jmp    801070d7 <alltraps>

80107bae <vector154>:
.globl vector154
vector154:
  pushl $0
80107bae:	6a 00                	push   $0x0
  pushl $154
80107bb0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107bb5:	e9 1d f5 ff ff       	jmp    801070d7 <alltraps>

80107bba <vector155>:
.globl vector155
vector155:
  pushl $0
80107bba:	6a 00                	push   $0x0
  pushl $155
80107bbc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107bc1:	e9 11 f5 ff ff       	jmp    801070d7 <alltraps>

80107bc6 <vector156>:
.globl vector156
vector156:
  pushl $0
80107bc6:	6a 00                	push   $0x0
  pushl $156
80107bc8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107bcd:	e9 05 f5 ff ff       	jmp    801070d7 <alltraps>

80107bd2 <vector157>:
.globl vector157
vector157:
  pushl $0
80107bd2:	6a 00                	push   $0x0
  pushl $157
80107bd4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107bd9:	e9 f9 f4 ff ff       	jmp    801070d7 <alltraps>

80107bde <vector158>:
.globl vector158
vector158:
  pushl $0
80107bde:	6a 00                	push   $0x0
  pushl $158
80107be0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107be5:	e9 ed f4 ff ff       	jmp    801070d7 <alltraps>

80107bea <vector159>:
.globl vector159
vector159:
  pushl $0
80107bea:	6a 00                	push   $0x0
  pushl $159
80107bec:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107bf1:	e9 e1 f4 ff ff       	jmp    801070d7 <alltraps>

80107bf6 <vector160>:
.globl vector160
vector160:
  pushl $0
80107bf6:	6a 00                	push   $0x0
  pushl $160
80107bf8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107bfd:	e9 d5 f4 ff ff       	jmp    801070d7 <alltraps>

80107c02 <vector161>:
.globl vector161
vector161:
  pushl $0
80107c02:	6a 00                	push   $0x0
  pushl $161
80107c04:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107c09:	e9 c9 f4 ff ff       	jmp    801070d7 <alltraps>

80107c0e <vector162>:
.globl vector162
vector162:
  pushl $0
80107c0e:	6a 00                	push   $0x0
  pushl $162
80107c10:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107c15:	e9 bd f4 ff ff       	jmp    801070d7 <alltraps>

80107c1a <vector163>:
.globl vector163
vector163:
  pushl $0
80107c1a:	6a 00                	push   $0x0
  pushl $163
80107c1c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107c21:	e9 b1 f4 ff ff       	jmp    801070d7 <alltraps>

80107c26 <vector164>:
.globl vector164
vector164:
  pushl $0
80107c26:	6a 00                	push   $0x0
  pushl $164
80107c28:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107c2d:	e9 a5 f4 ff ff       	jmp    801070d7 <alltraps>

80107c32 <vector165>:
.globl vector165
vector165:
  pushl $0
80107c32:	6a 00                	push   $0x0
  pushl $165
80107c34:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107c39:	e9 99 f4 ff ff       	jmp    801070d7 <alltraps>

80107c3e <vector166>:
.globl vector166
vector166:
  pushl $0
80107c3e:	6a 00                	push   $0x0
  pushl $166
80107c40:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107c45:	e9 8d f4 ff ff       	jmp    801070d7 <alltraps>

80107c4a <vector167>:
.globl vector167
vector167:
  pushl $0
80107c4a:	6a 00                	push   $0x0
  pushl $167
80107c4c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107c51:	e9 81 f4 ff ff       	jmp    801070d7 <alltraps>

80107c56 <vector168>:
.globl vector168
vector168:
  pushl $0
80107c56:	6a 00                	push   $0x0
  pushl $168
80107c58:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107c5d:	e9 75 f4 ff ff       	jmp    801070d7 <alltraps>

80107c62 <vector169>:
.globl vector169
vector169:
  pushl $0
80107c62:	6a 00                	push   $0x0
  pushl $169
80107c64:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107c69:	e9 69 f4 ff ff       	jmp    801070d7 <alltraps>

80107c6e <vector170>:
.globl vector170
vector170:
  pushl $0
80107c6e:	6a 00                	push   $0x0
  pushl $170
80107c70:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107c75:	e9 5d f4 ff ff       	jmp    801070d7 <alltraps>

80107c7a <vector171>:
.globl vector171
vector171:
  pushl $0
80107c7a:	6a 00                	push   $0x0
  pushl $171
80107c7c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107c81:	e9 51 f4 ff ff       	jmp    801070d7 <alltraps>

80107c86 <vector172>:
.globl vector172
vector172:
  pushl $0
80107c86:	6a 00                	push   $0x0
  pushl $172
80107c88:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107c8d:	e9 45 f4 ff ff       	jmp    801070d7 <alltraps>

80107c92 <vector173>:
.globl vector173
vector173:
  pushl $0
80107c92:	6a 00                	push   $0x0
  pushl $173
80107c94:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107c99:	e9 39 f4 ff ff       	jmp    801070d7 <alltraps>

80107c9e <vector174>:
.globl vector174
vector174:
  pushl $0
80107c9e:	6a 00                	push   $0x0
  pushl $174
80107ca0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107ca5:	e9 2d f4 ff ff       	jmp    801070d7 <alltraps>

80107caa <vector175>:
.globl vector175
vector175:
  pushl $0
80107caa:	6a 00                	push   $0x0
  pushl $175
80107cac:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107cb1:	e9 21 f4 ff ff       	jmp    801070d7 <alltraps>

80107cb6 <vector176>:
.globl vector176
vector176:
  pushl $0
80107cb6:	6a 00                	push   $0x0
  pushl $176
80107cb8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107cbd:	e9 15 f4 ff ff       	jmp    801070d7 <alltraps>

80107cc2 <vector177>:
.globl vector177
vector177:
  pushl $0
80107cc2:	6a 00                	push   $0x0
  pushl $177
80107cc4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107cc9:	e9 09 f4 ff ff       	jmp    801070d7 <alltraps>

80107cce <vector178>:
.globl vector178
vector178:
  pushl $0
80107cce:	6a 00                	push   $0x0
  pushl $178
80107cd0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107cd5:	e9 fd f3 ff ff       	jmp    801070d7 <alltraps>

80107cda <vector179>:
.globl vector179
vector179:
  pushl $0
80107cda:	6a 00                	push   $0x0
  pushl $179
80107cdc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107ce1:	e9 f1 f3 ff ff       	jmp    801070d7 <alltraps>

80107ce6 <vector180>:
.globl vector180
vector180:
  pushl $0
80107ce6:	6a 00                	push   $0x0
  pushl $180
80107ce8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107ced:	e9 e5 f3 ff ff       	jmp    801070d7 <alltraps>

80107cf2 <vector181>:
.globl vector181
vector181:
  pushl $0
80107cf2:	6a 00                	push   $0x0
  pushl $181
80107cf4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107cf9:	e9 d9 f3 ff ff       	jmp    801070d7 <alltraps>

80107cfe <vector182>:
.globl vector182
vector182:
  pushl $0
80107cfe:	6a 00                	push   $0x0
  pushl $182
80107d00:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107d05:	e9 cd f3 ff ff       	jmp    801070d7 <alltraps>

80107d0a <vector183>:
.globl vector183
vector183:
  pushl $0
80107d0a:	6a 00                	push   $0x0
  pushl $183
80107d0c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107d11:	e9 c1 f3 ff ff       	jmp    801070d7 <alltraps>

80107d16 <vector184>:
.globl vector184
vector184:
  pushl $0
80107d16:	6a 00                	push   $0x0
  pushl $184
80107d18:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107d1d:	e9 b5 f3 ff ff       	jmp    801070d7 <alltraps>

80107d22 <vector185>:
.globl vector185
vector185:
  pushl $0
80107d22:	6a 00                	push   $0x0
  pushl $185
80107d24:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107d29:	e9 a9 f3 ff ff       	jmp    801070d7 <alltraps>

80107d2e <vector186>:
.globl vector186
vector186:
  pushl $0
80107d2e:	6a 00                	push   $0x0
  pushl $186
80107d30:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107d35:	e9 9d f3 ff ff       	jmp    801070d7 <alltraps>

80107d3a <vector187>:
.globl vector187
vector187:
  pushl $0
80107d3a:	6a 00                	push   $0x0
  pushl $187
80107d3c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107d41:	e9 91 f3 ff ff       	jmp    801070d7 <alltraps>

80107d46 <vector188>:
.globl vector188
vector188:
  pushl $0
80107d46:	6a 00                	push   $0x0
  pushl $188
80107d48:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107d4d:	e9 85 f3 ff ff       	jmp    801070d7 <alltraps>

80107d52 <vector189>:
.globl vector189
vector189:
  pushl $0
80107d52:	6a 00                	push   $0x0
  pushl $189
80107d54:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107d59:	e9 79 f3 ff ff       	jmp    801070d7 <alltraps>

80107d5e <vector190>:
.globl vector190
vector190:
  pushl $0
80107d5e:	6a 00                	push   $0x0
  pushl $190
80107d60:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107d65:	e9 6d f3 ff ff       	jmp    801070d7 <alltraps>

80107d6a <vector191>:
.globl vector191
vector191:
  pushl $0
80107d6a:	6a 00                	push   $0x0
  pushl $191
80107d6c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107d71:	e9 61 f3 ff ff       	jmp    801070d7 <alltraps>

80107d76 <vector192>:
.globl vector192
vector192:
  pushl $0
80107d76:	6a 00                	push   $0x0
  pushl $192
80107d78:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107d7d:	e9 55 f3 ff ff       	jmp    801070d7 <alltraps>

80107d82 <vector193>:
.globl vector193
vector193:
  pushl $0
80107d82:	6a 00                	push   $0x0
  pushl $193
80107d84:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107d89:	e9 49 f3 ff ff       	jmp    801070d7 <alltraps>

80107d8e <vector194>:
.globl vector194
vector194:
  pushl $0
80107d8e:	6a 00                	push   $0x0
  pushl $194
80107d90:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107d95:	e9 3d f3 ff ff       	jmp    801070d7 <alltraps>

80107d9a <vector195>:
.globl vector195
vector195:
  pushl $0
80107d9a:	6a 00                	push   $0x0
  pushl $195
80107d9c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107da1:	e9 31 f3 ff ff       	jmp    801070d7 <alltraps>

80107da6 <vector196>:
.globl vector196
vector196:
  pushl $0
80107da6:	6a 00                	push   $0x0
  pushl $196
80107da8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107dad:	e9 25 f3 ff ff       	jmp    801070d7 <alltraps>

80107db2 <vector197>:
.globl vector197
vector197:
  pushl $0
80107db2:	6a 00                	push   $0x0
  pushl $197
80107db4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107db9:	e9 19 f3 ff ff       	jmp    801070d7 <alltraps>

80107dbe <vector198>:
.globl vector198
vector198:
  pushl $0
80107dbe:	6a 00                	push   $0x0
  pushl $198
80107dc0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107dc5:	e9 0d f3 ff ff       	jmp    801070d7 <alltraps>

80107dca <vector199>:
.globl vector199
vector199:
  pushl $0
80107dca:	6a 00                	push   $0x0
  pushl $199
80107dcc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107dd1:	e9 01 f3 ff ff       	jmp    801070d7 <alltraps>

80107dd6 <vector200>:
.globl vector200
vector200:
  pushl $0
80107dd6:	6a 00                	push   $0x0
  pushl $200
80107dd8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107ddd:	e9 f5 f2 ff ff       	jmp    801070d7 <alltraps>

80107de2 <vector201>:
.globl vector201
vector201:
  pushl $0
80107de2:	6a 00                	push   $0x0
  pushl $201
80107de4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107de9:	e9 e9 f2 ff ff       	jmp    801070d7 <alltraps>

80107dee <vector202>:
.globl vector202
vector202:
  pushl $0
80107dee:	6a 00                	push   $0x0
  pushl $202
80107df0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107df5:	e9 dd f2 ff ff       	jmp    801070d7 <alltraps>

80107dfa <vector203>:
.globl vector203
vector203:
  pushl $0
80107dfa:	6a 00                	push   $0x0
  pushl $203
80107dfc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107e01:	e9 d1 f2 ff ff       	jmp    801070d7 <alltraps>

80107e06 <vector204>:
.globl vector204
vector204:
  pushl $0
80107e06:	6a 00                	push   $0x0
  pushl $204
80107e08:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107e0d:	e9 c5 f2 ff ff       	jmp    801070d7 <alltraps>

80107e12 <vector205>:
.globl vector205
vector205:
  pushl $0
80107e12:	6a 00                	push   $0x0
  pushl $205
80107e14:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107e19:	e9 b9 f2 ff ff       	jmp    801070d7 <alltraps>

80107e1e <vector206>:
.globl vector206
vector206:
  pushl $0
80107e1e:	6a 00                	push   $0x0
  pushl $206
80107e20:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107e25:	e9 ad f2 ff ff       	jmp    801070d7 <alltraps>

80107e2a <vector207>:
.globl vector207
vector207:
  pushl $0
80107e2a:	6a 00                	push   $0x0
  pushl $207
80107e2c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107e31:	e9 a1 f2 ff ff       	jmp    801070d7 <alltraps>

80107e36 <vector208>:
.globl vector208
vector208:
  pushl $0
80107e36:	6a 00                	push   $0x0
  pushl $208
80107e38:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107e3d:	e9 95 f2 ff ff       	jmp    801070d7 <alltraps>

80107e42 <vector209>:
.globl vector209
vector209:
  pushl $0
80107e42:	6a 00                	push   $0x0
  pushl $209
80107e44:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107e49:	e9 89 f2 ff ff       	jmp    801070d7 <alltraps>

80107e4e <vector210>:
.globl vector210
vector210:
  pushl $0
80107e4e:	6a 00                	push   $0x0
  pushl $210
80107e50:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107e55:	e9 7d f2 ff ff       	jmp    801070d7 <alltraps>

80107e5a <vector211>:
.globl vector211
vector211:
  pushl $0
80107e5a:	6a 00                	push   $0x0
  pushl $211
80107e5c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107e61:	e9 71 f2 ff ff       	jmp    801070d7 <alltraps>

80107e66 <vector212>:
.globl vector212
vector212:
  pushl $0
80107e66:	6a 00                	push   $0x0
  pushl $212
80107e68:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107e6d:	e9 65 f2 ff ff       	jmp    801070d7 <alltraps>

80107e72 <vector213>:
.globl vector213
vector213:
  pushl $0
80107e72:	6a 00                	push   $0x0
  pushl $213
80107e74:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107e79:	e9 59 f2 ff ff       	jmp    801070d7 <alltraps>

80107e7e <vector214>:
.globl vector214
vector214:
  pushl $0
80107e7e:	6a 00                	push   $0x0
  pushl $214
80107e80:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107e85:	e9 4d f2 ff ff       	jmp    801070d7 <alltraps>

80107e8a <vector215>:
.globl vector215
vector215:
  pushl $0
80107e8a:	6a 00                	push   $0x0
  pushl $215
80107e8c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107e91:	e9 41 f2 ff ff       	jmp    801070d7 <alltraps>

80107e96 <vector216>:
.globl vector216
vector216:
  pushl $0
80107e96:	6a 00                	push   $0x0
  pushl $216
80107e98:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107e9d:	e9 35 f2 ff ff       	jmp    801070d7 <alltraps>

80107ea2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107ea2:	6a 00                	push   $0x0
  pushl $217
80107ea4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107ea9:	e9 29 f2 ff ff       	jmp    801070d7 <alltraps>

80107eae <vector218>:
.globl vector218
vector218:
  pushl $0
80107eae:	6a 00                	push   $0x0
  pushl $218
80107eb0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107eb5:	e9 1d f2 ff ff       	jmp    801070d7 <alltraps>

80107eba <vector219>:
.globl vector219
vector219:
  pushl $0
80107eba:	6a 00                	push   $0x0
  pushl $219
80107ebc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107ec1:	e9 11 f2 ff ff       	jmp    801070d7 <alltraps>

80107ec6 <vector220>:
.globl vector220
vector220:
  pushl $0
80107ec6:	6a 00                	push   $0x0
  pushl $220
80107ec8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107ecd:	e9 05 f2 ff ff       	jmp    801070d7 <alltraps>

80107ed2 <vector221>:
.globl vector221
vector221:
  pushl $0
80107ed2:	6a 00                	push   $0x0
  pushl $221
80107ed4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107ed9:	e9 f9 f1 ff ff       	jmp    801070d7 <alltraps>

80107ede <vector222>:
.globl vector222
vector222:
  pushl $0
80107ede:	6a 00                	push   $0x0
  pushl $222
80107ee0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107ee5:	e9 ed f1 ff ff       	jmp    801070d7 <alltraps>

80107eea <vector223>:
.globl vector223
vector223:
  pushl $0
80107eea:	6a 00                	push   $0x0
  pushl $223
80107eec:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107ef1:	e9 e1 f1 ff ff       	jmp    801070d7 <alltraps>

80107ef6 <vector224>:
.globl vector224
vector224:
  pushl $0
80107ef6:	6a 00                	push   $0x0
  pushl $224
80107ef8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107efd:	e9 d5 f1 ff ff       	jmp    801070d7 <alltraps>

80107f02 <vector225>:
.globl vector225
vector225:
  pushl $0
80107f02:	6a 00                	push   $0x0
  pushl $225
80107f04:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107f09:	e9 c9 f1 ff ff       	jmp    801070d7 <alltraps>

80107f0e <vector226>:
.globl vector226
vector226:
  pushl $0
80107f0e:	6a 00                	push   $0x0
  pushl $226
80107f10:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107f15:	e9 bd f1 ff ff       	jmp    801070d7 <alltraps>

80107f1a <vector227>:
.globl vector227
vector227:
  pushl $0
80107f1a:	6a 00                	push   $0x0
  pushl $227
80107f1c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107f21:	e9 b1 f1 ff ff       	jmp    801070d7 <alltraps>

80107f26 <vector228>:
.globl vector228
vector228:
  pushl $0
80107f26:	6a 00                	push   $0x0
  pushl $228
80107f28:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107f2d:	e9 a5 f1 ff ff       	jmp    801070d7 <alltraps>

80107f32 <vector229>:
.globl vector229
vector229:
  pushl $0
80107f32:	6a 00                	push   $0x0
  pushl $229
80107f34:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107f39:	e9 99 f1 ff ff       	jmp    801070d7 <alltraps>

80107f3e <vector230>:
.globl vector230
vector230:
  pushl $0
80107f3e:	6a 00                	push   $0x0
  pushl $230
80107f40:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107f45:	e9 8d f1 ff ff       	jmp    801070d7 <alltraps>

80107f4a <vector231>:
.globl vector231
vector231:
  pushl $0
80107f4a:	6a 00                	push   $0x0
  pushl $231
80107f4c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107f51:	e9 81 f1 ff ff       	jmp    801070d7 <alltraps>

80107f56 <vector232>:
.globl vector232
vector232:
  pushl $0
80107f56:	6a 00                	push   $0x0
  pushl $232
80107f58:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107f5d:	e9 75 f1 ff ff       	jmp    801070d7 <alltraps>

80107f62 <vector233>:
.globl vector233
vector233:
  pushl $0
80107f62:	6a 00                	push   $0x0
  pushl $233
80107f64:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107f69:	e9 69 f1 ff ff       	jmp    801070d7 <alltraps>

80107f6e <vector234>:
.globl vector234
vector234:
  pushl $0
80107f6e:	6a 00                	push   $0x0
  pushl $234
80107f70:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107f75:	e9 5d f1 ff ff       	jmp    801070d7 <alltraps>

80107f7a <vector235>:
.globl vector235
vector235:
  pushl $0
80107f7a:	6a 00                	push   $0x0
  pushl $235
80107f7c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107f81:	e9 51 f1 ff ff       	jmp    801070d7 <alltraps>

80107f86 <vector236>:
.globl vector236
vector236:
  pushl $0
80107f86:	6a 00                	push   $0x0
  pushl $236
80107f88:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107f8d:	e9 45 f1 ff ff       	jmp    801070d7 <alltraps>

80107f92 <vector237>:
.globl vector237
vector237:
  pushl $0
80107f92:	6a 00                	push   $0x0
  pushl $237
80107f94:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107f99:	e9 39 f1 ff ff       	jmp    801070d7 <alltraps>

80107f9e <vector238>:
.globl vector238
vector238:
  pushl $0
80107f9e:	6a 00                	push   $0x0
  pushl $238
80107fa0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107fa5:	e9 2d f1 ff ff       	jmp    801070d7 <alltraps>

80107faa <vector239>:
.globl vector239
vector239:
  pushl $0
80107faa:	6a 00                	push   $0x0
  pushl $239
80107fac:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107fb1:	e9 21 f1 ff ff       	jmp    801070d7 <alltraps>

80107fb6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107fb6:	6a 00                	push   $0x0
  pushl $240
80107fb8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107fbd:	e9 15 f1 ff ff       	jmp    801070d7 <alltraps>

80107fc2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107fc2:	6a 00                	push   $0x0
  pushl $241
80107fc4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107fc9:	e9 09 f1 ff ff       	jmp    801070d7 <alltraps>

80107fce <vector242>:
.globl vector242
vector242:
  pushl $0
80107fce:	6a 00                	push   $0x0
  pushl $242
80107fd0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107fd5:	e9 fd f0 ff ff       	jmp    801070d7 <alltraps>

80107fda <vector243>:
.globl vector243
vector243:
  pushl $0
80107fda:	6a 00                	push   $0x0
  pushl $243
80107fdc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107fe1:	e9 f1 f0 ff ff       	jmp    801070d7 <alltraps>

80107fe6 <vector244>:
.globl vector244
vector244:
  pushl $0
80107fe6:	6a 00                	push   $0x0
  pushl $244
80107fe8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107fed:	e9 e5 f0 ff ff       	jmp    801070d7 <alltraps>

80107ff2 <vector245>:
.globl vector245
vector245:
  pushl $0
80107ff2:	6a 00                	push   $0x0
  pushl $245
80107ff4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107ff9:	e9 d9 f0 ff ff       	jmp    801070d7 <alltraps>

80107ffe <vector246>:
.globl vector246
vector246:
  pushl $0
80107ffe:	6a 00                	push   $0x0
  pushl $246
80108000:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108005:	e9 cd f0 ff ff       	jmp    801070d7 <alltraps>

8010800a <vector247>:
.globl vector247
vector247:
  pushl $0
8010800a:	6a 00                	push   $0x0
  pushl $247
8010800c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108011:	e9 c1 f0 ff ff       	jmp    801070d7 <alltraps>

80108016 <vector248>:
.globl vector248
vector248:
  pushl $0
80108016:	6a 00                	push   $0x0
  pushl $248
80108018:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010801d:	e9 b5 f0 ff ff       	jmp    801070d7 <alltraps>

80108022 <vector249>:
.globl vector249
vector249:
  pushl $0
80108022:	6a 00                	push   $0x0
  pushl $249
80108024:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80108029:	e9 a9 f0 ff ff       	jmp    801070d7 <alltraps>

8010802e <vector250>:
.globl vector250
vector250:
  pushl $0
8010802e:	6a 00                	push   $0x0
  pushl $250
80108030:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108035:	e9 9d f0 ff ff       	jmp    801070d7 <alltraps>

8010803a <vector251>:
.globl vector251
vector251:
  pushl $0
8010803a:	6a 00                	push   $0x0
  pushl $251
8010803c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108041:	e9 91 f0 ff ff       	jmp    801070d7 <alltraps>

80108046 <vector252>:
.globl vector252
vector252:
  pushl $0
80108046:	6a 00                	push   $0x0
  pushl $252
80108048:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010804d:	e9 85 f0 ff ff       	jmp    801070d7 <alltraps>

80108052 <vector253>:
.globl vector253
vector253:
  pushl $0
80108052:	6a 00                	push   $0x0
  pushl $253
80108054:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108059:	e9 79 f0 ff ff       	jmp    801070d7 <alltraps>

8010805e <vector254>:
.globl vector254
vector254:
  pushl $0
8010805e:	6a 00                	push   $0x0
  pushl $254
80108060:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108065:	e9 6d f0 ff ff       	jmp    801070d7 <alltraps>

8010806a <vector255>:
.globl vector255
vector255:
  pushl $0
8010806a:	6a 00                	push   $0x0
  pushl $255
8010806c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108071:	e9 61 f0 ff ff       	jmp    801070d7 <alltraps>
80108076:	66 90                	xchg   %ax,%ax
80108078:	66 90                	xchg   %ax,%ax
8010807a:	66 90                	xchg   %ax,%ax
8010807c:	66 90                	xchg   %ax,%ax
8010807e:	66 90                	xchg   %ax,%ax

80108080 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108080:	55                   	push   %ebp
80108081:	89 e5                	mov    %esp,%ebp
80108083:	83 ec 28             	sub    $0x28,%esp
80108086:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108089:	89 d3                	mov    %edx,%ebx
8010808b:	c1 eb 16             	shr    $0x16,%ebx
{
8010808e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80108091:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80108094:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108097:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80108099:	8b 06                	mov    (%esi),%eax
8010809b:	a8 01                	test   $0x1,%al
8010809d:	74 29                	je     801080c8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010809f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080a4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801080aa:	c1 ef 0a             	shr    $0xa,%edi
}
801080ad:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
801080b0:	89 fa                	mov    %edi,%edx
}
801080b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
801080b5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801080bb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801080be:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801080c1:	89 ec                	mov    %ebp,%esp
801080c3:	5d                   	pop    %ebp
801080c4:	c3                   	ret    
801080c5:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801080c8:	85 c9                	test   %ecx,%ecx
801080ca:	74 34                	je     80108100 <walkpgdir+0x80>
801080cc:	e8 bf a4 ff ff       	call   80102590 <kalloc>
801080d1:	85 c0                	test   %eax,%eax
801080d3:	89 c3                	mov    %eax,%ebx
801080d5:	74 29                	je     80108100 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
801080d7:	b8 00 10 00 00       	mov    $0x1000,%eax
801080dc:	31 d2                	xor    %edx,%edx
801080de:	89 44 24 08          	mov    %eax,0x8(%esp)
801080e2:	89 54 24 04          	mov    %edx,0x4(%esp)
801080e6:	89 1c 24             	mov    %ebx,(%esp)
801080e9:	e8 d2 dc ff ff       	call   80105dc0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801080ee:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801080f4:	83 c8 07             	or     $0x7,%eax
801080f7:	89 06                	mov    %eax,(%esi)
801080f9:	eb af                	jmp    801080aa <walkpgdir+0x2a>
801080fb:	90                   	nop
801080fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80108100:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80108103:	31 c0                	xor    %eax,%eax
}
80108105:	8b 75 f8             	mov    -0x8(%ebp),%esi
80108108:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010810b:	89 ec                	mov    %ebp,%esp
8010810d:	5d                   	pop    %ebp
8010810e:	c3                   	ret    
8010810f:	90                   	nop

80108110 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108110:	55                   	push   %ebp
80108111:	89 e5                	mov    %esp,%ebp
80108113:	57                   	push   %edi
80108114:	56                   	push   %esi
80108115:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80108116:	89 d3                	mov    %edx,%ebx
{
80108118:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
8010811b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80108121:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108124:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108128:	8b 7d 08             	mov    0x8(%ebp),%edi
8010812b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108130:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80108133:	8b 45 0c             	mov    0xc(%ebp),%eax
80108136:	29 df                	sub    %ebx,%edi
80108138:	83 c8 01             	or     $0x1,%eax
8010813b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010813e:	eb 17                	jmp    80108157 <mappages+0x47>
    if(*pte & PTE_P)
80108140:	f6 00 01             	testb  $0x1,(%eax)
80108143:	75 45                	jne    8010818a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80108145:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108148:	09 d6                	or     %edx,%esi
    if(a == last)
8010814a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010814d:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010814f:	74 2f                	je     80108180 <mappages+0x70>
      break;
    a += PGSIZE;
80108151:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010815a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010815f:	89 da                	mov    %ebx,%edx
80108161:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80108164:	e8 17 ff ff ff       	call   80108080 <walkpgdir>
80108169:	85 c0                	test   %eax,%eax
8010816b:	75 d3                	jne    80108140 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010816d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80108170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108175:	5b                   	pop    %ebx
80108176:	5e                   	pop    %esi
80108177:	5f                   	pop    %edi
80108178:	5d                   	pop    %ebp
80108179:	c3                   	ret    
8010817a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108180:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80108183:	31 c0                	xor    %eax,%eax
}
80108185:	5b                   	pop    %ebx
80108186:	5e                   	pop    %esi
80108187:	5f                   	pop    %edi
80108188:	5d                   	pop    %ebp
80108189:	c3                   	ret    
      panic("remap");
8010818a:	c7 04 24 78 93 10 80 	movl   $0x80109378,(%esp)
80108191:	e8 da 81 ff ff       	call   80100370 <panic>
80108196:	8d 76 00             	lea    0x0(%esi),%esi
80108199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801081a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	57                   	push   %edi
801081a4:	89 c7                	mov    %eax,%edi
801081a6:	56                   	push   %esi
801081a7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801081a8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801081ae:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
801081b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801081b7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801081b9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801081bc:	73 62                	jae    80108220 <deallocuvm.part.0+0x80>
801081be:	89 d6                	mov    %edx,%esi
801081c0:	eb 39                	jmp    801081fb <deallocuvm.part.0+0x5b>
801081c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801081c8:	8b 10                	mov    (%eax),%edx
801081ca:	f6 c2 01             	test   $0x1,%dl
801081cd:	74 22                	je     801081f1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801081cf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801081d5:	74 54                	je     8010822b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801081d7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801081dd:	89 14 24             	mov    %edx,(%esp)
801081e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081e3:	e8 d8 a1 ff ff       	call   801023c0 <kfree>
      *pte = 0;
801081e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801081eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801081f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801081f7:	39 f3                	cmp    %esi,%ebx
801081f9:	73 25                	jae    80108220 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
801081fb:	31 c9                	xor    %ecx,%ecx
801081fd:	89 da                	mov    %ebx,%edx
801081ff:	89 f8                	mov    %edi,%eax
80108201:	e8 7a fe ff ff       	call   80108080 <walkpgdir>
    if(!pte)
80108206:	85 c0                	test   %eax,%eax
80108208:	75 be                	jne    801081c8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010820a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108210:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108216:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010821c:	39 f3                	cmp    %esi,%ebx
8010821e:	72 db                	jb     801081fb <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80108220:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108223:	83 c4 2c             	add    $0x2c,%esp
80108226:	5b                   	pop    %ebx
80108227:	5e                   	pop    %esi
80108228:	5f                   	pop    %edi
80108229:	5d                   	pop    %ebp
8010822a:	c3                   	ret    
        panic("kfree");
8010822b:	c7 04 24 3a 8c 10 80 	movl   $0x80108c3a,(%esp)
80108232:	e8 39 81 ff ff       	call   80100370 <panic>
80108237:	89 f6                	mov    %esi,%esi
80108239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108240 <seginit>:
{
80108240:	55                   	push   %ebp
80108241:	89 e5                	mov    %esp,%ebp
80108243:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108246:	e8 f5 b6 ff ff       	call   80103940 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010824b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80108250:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80108256:	8d 14 80             	lea    (%eax,%eax,4),%edx
80108259:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010825c:	ba ff ff 00 00       	mov    $0xffff,%edx
80108261:	c1 e0 04             	shl    $0x4,%eax
80108264:	89 90 58 48 11 80    	mov    %edx,-0x7feeb7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010826a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010826f:	89 88 5c 48 11 80    	mov    %ecx,-0x7feeb7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108275:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010827a:	89 90 60 48 11 80    	mov    %edx,-0x7feeb7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108280:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108285:	89 88 64 48 11 80    	mov    %ecx,-0x7feeb79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010828b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80108290:	89 90 68 48 11 80    	mov    %edx,-0x7feeb798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108296:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010829b:	89 88 6c 48 11 80    	mov    %ecx,-0x7feeb794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801082a1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
801082a6:	89 90 70 48 11 80    	mov    %edx,-0x7feeb790(%eax)
801082ac:	89 88 74 48 11 80    	mov    %ecx,-0x7feeb78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801082b2:	05 50 48 11 80       	add    $0x80114850,%eax
  pd[1] = (uint)p;
801082b7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
801082ba:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
801082bd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801082c1:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801082c5:	8d 45 f2             	lea    -0xe(%ebp),%eax
801082c8:	0f 01 10             	lgdtl  (%eax)
}
801082cb:	c9                   	leave  
801082cc:	c3                   	ret    
801082cd:	8d 76 00             	lea    0x0(%esi),%esi

801082d0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801082d0:	a1 04 81 11 80       	mov    0x80118104,%eax
{
801082d5:	55                   	push   %ebp
801082d6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801082d8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801082dd:	0f 22 d8             	mov    %eax,%cr3
}
801082e0:	5d                   	pop    %ebp
801082e1:	c3                   	ret    
801082e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801082f0 <switchuvm>:
{
801082f0:	55                   	push   %ebp
801082f1:	89 e5                	mov    %esp,%ebp
801082f3:	57                   	push   %edi
801082f4:	56                   	push   %esi
801082f5:	53                   	push   %ebx
801082f6:	83 ec 2c             	sub    $0x2c,%esp
801082f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801082fc:	85 db                	test   %ebx,%ebx
801082fe:	0f 84 c5 00 00 00    	je     801083c9 <switchuvm+0xd9>
  if(p->kstack == 0)
80108304:	8b 7b 08             	mov    0x8(%ebx),%edi
80108307:	85 ff                	test   %edi,%edi
80108309:	0f 84 d2 00 00 00    	je     801083e1 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010830f:	8b 73 04             	mov    0x4(%ebx),%esi
80108312:	85 f6                	test   %esi,%esi
80108314:	0f 84 bb 00 00 00    	je     801083d5 <switchuvm+0xe5>
  pushcli();
8010831a:	e8 d1 d8 ff ff       	call   80105bf0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010831f:	e8 9c b5 ff ff       	call   801038c0 <mycpu>
80108324:	89 c6                	mov    %eax,%esi
80108326:	e8 95 b5 ff ff       	call   801038c0 <mycpu>
8010832b:	89 c7                	mov    %eax,%edi
8010832d:	e8 8e b5 ff ff       	call   801038c0 <mycpu>
80108332:	83 c7 08             	add    $0x8,%edi
80108335:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108338:	e8 83 b5 ff ff       	call   801038c0 <mycpu>
8010833d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108340:	ba 67 00 00 00       	mov    $0x67,%edx
80108345:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
8010834c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108353:	83 c1 08             	add    $0x8,%ecx
80108356:	c1 e9 10             	shr    $0x10,%ecx
80108359:	83 c0 08             	add    $0x8,%eax
8010835c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108362:	c1 e8 18             	shr    $0x18,%eax
80108365:	b9 99 40 00 00       	mov    $0x4099,%ecx
8010836a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80108371:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80108377:	e8 44 b5 ff ff       	call   801038c0 <mycpu>
8010837c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108383:	e8 38 b5 ff ff       	call   801038c0 <mycpu>
80108388:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010838e:	8b 73 08             	mov    0x8(%ebx),%esi
80108391:	e8 2a b5 ff ff       	call   801038c0 <mycpu>
80108396:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010839c:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010839f:	e8 1c b5 ff ff       	call   801038c0 <mycpu>
801083a4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801083aa:	b8 28 00 00 00       	mov    $0x28,%eax
801083af:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801083b2:	8b 43 04             	mov    0x4(%ebx),%eax
801083b5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801083ba:	0f 22 d8             	mov    %eax,%cr3
}
801083bd:	83 c4 2c             	add    $0x2c,%esp
801083c0:	5b                   	pop    %ebx
801083c1:	5e                   	pop    %esi
801083c2:	5f                   	pop    %edi
801083c3:	5d                   	pop    %ebp
  popcli();
801083c4:	e9 67 d8 ff ff       	jmp    80105c30 <popcli>
    panic("switchuvm: no process");
801083c9:	c7 04 24 7e 93 10 80 	movl   $0x8010937e,(%esp)
801083d0:	e8 9b 7f ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
801083d5:	c7 04 24 a9 93 10 80 	movl   $0x801093a9,(%esp)
801083dc:	e8 8f 7f ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
801083e1:	c7 04 24 94 93 10 80 	movl   $0x80109394,(%esp)
801083e8:	e8 83 7f ff ff       	call   80100370 <panic>
801083ed:	8d 76 00             	lea    0x0(%esi),%esi

801083f0 <inituvm>:
{
801083f0:	55                   	push   %ebp
801083f1:	89 e5                	mov    %esp,%ebp
801083f3:	83 ec 38             	sub    $0x38,%esp
801083f6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801083f9:	8b 75 10             	mov    0x10(%ebp),%esi
801083fc:	8b 45 08             	mov    0x8(%ebp),%eax
801083ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108402:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108405:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108408:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010840e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108411:	77 59                	ja     8010846c <inituvm+0x7c>
  mem = kalloc();
80108413:	e8 78 a1 ff ff       	call   80102590 <kalloc>
  memset(mem, 0, PGSIZE);
80108418:	31 d2                	xor    %edx,%edx
8010841a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010841e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108420:	b8 00 10 00 00       	mov    $0x1000,%eax
80108425:	89 1c 24             	mov    %ebx,(%esp)
80108428:	89 44 24 08          	mov    %eax,0x8(%esp)
8010842c:	e8 8f d9 ff ff       	call   80105dc0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108431:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108437:	b9 06 00 00 00       	mov    $0x6,%ecx
8010843c:	89 04 24             	mov    %eax,(%esp)
8010843f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108442:	31 d2                	xor    %edx,%edx
80108444:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108448:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010844d:	e8 be fc ff ff       	call   80108110 <mappages>
  memmove(mem, init, sz);
80108452:	89 75 10             	mov    %esi,0x10(%ebp)
}
80108455:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80108458:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010845b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
8010845e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108461:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108464:	89 ec                	mov    %ebp,%esp
80108466:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108467:	e9 14 da ff ff       	jmp    80105e80 <memmove>
    panic("inituvm: more than a page");
8010846c:	c7 04 24 bd 93 10 80 	movl   $0x801093bd,(%esp)
80108473:	e8 f8 7e ff ff       	call   80100370 <panic>
80108478:	90                   	nop
80108479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108480 <loaduvm>:
{
80108480:	55                   	push   %ebp
80108481:	89 e5                	mov    %esp,%ebp
80108483:	57                   	push   %edi
80108484:	56                   	push   %esi
80108485:	53                   	push   %ebx
80108486:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80108489:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108490:	0f 85 98 00 00 00    	jne    8010852e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80108496:	8b 75 18             	mov    0x18(%ebp),%esi
80108499:	31 db                	xor    %ebx,%ebx
8010849b:	85 f6                	test   %esi,%esi
8010849d:	75 1a                	jne    801084b9 <loaduvm+0x39>
8010849f:	eb 77                	jmp    80108518 <loaduvm+0x98>
801084a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801084ae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801084b4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801084b7:	76 5f                	jbe    80108518 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801084b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801084bc:	31 c9                	xor    %ecx,%ecx
801084be:	8b 45 08             	mov    0x8(%ebp),%eax
801084c1:	01 da                	add    %ebx,%edx
801084c3:	e8 b8 fb ff ff       	call   80108080 <walkpgdir>
801084c8:	85 c0                	test   %eax,%eax
801084ca:	74 56                	je     80108522 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
801084cc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
801084ce:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801084d3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
801084d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801084db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801084e1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801084e4:	05 00 00 00 80       	add    $0x80000000,%eax
801084e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801084ed:	8b 45 10             	mov    0x10(%ebp),%eax
801084f0:	01 d9                	add    %ebx,%ecx
801084f2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801084f6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801084fa:	89 04 24             	mov    %eax,(%esp)
801084fd:	e8 ae 94 ff ff       	call   801019b0 <readi>
80108502:	39 f8                	cmp    %edi,%eax
80108504:	74 a2                	je     801084a8 <loaduvm+0x28>
}
80108506:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010850e:	5b                   	pop    %ebx
8010850f:	5e                   	pop    %esi
80108510:	5f                   	pop    %edi
80108511:	5d                   	pop    %ebp
80108512:	c3                   	ret    
80108513:	90                   	nop
80108514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108518:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010851b:	31 c0                	xor    %eax,%eax
}
8010851d:	5b                   	pop    %ebx
8010851e:	5e                   	pop    %esi
8010851f:	5f                   	pop    %edi
80108520:	5d                   	pop    %ebp
80108521:	c3                   	ret    
      panic("loaduvm: address should exist");
80108522:	c7 04 24 d7 93 10 80 	movl   $0x801093d7,(%esp)
80108529:	e8 42 7e ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010852e:	c7 04 24 78 94 10 80 	movl   $0x80109478,(%esp)
80108535:	e8 36 7e ff ff       	call   80100370 <panic>
8010853a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108540 <allocuvm>:
{
80108540:	55                   	push   %ebp
80108541:	89 e5                	mov    %esp,%ebp
80108543:	57                   	push   %edi
80108544:	56                   	push   %esi
80108545:	53                   	push   %ebx
80108546:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80108549:	8b 7d 10             	mov    0x10(%ebp),%edi
8010854c:	85 ff                	test   %edi,%edi
8010854e:	0f 88 91 00 00 00    	js     801085e5 <allocuvm+0xa5>
  if(newsz < oldsz)
80108554:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108557:	0f 82 9b 00 00 00    	jb     801085f8 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010855d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108560:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108566:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010856c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010856f:	0f 86 86 00 00 00    	jbe    801085fb <allocuvm+0xbb>
80108575:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108578:	8b 7d 08             	mov    0x8(%ebp),%edi
8010857b:	eb 49                	jmp    801085c6 <allocuvm+0x86>
8010857d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108580:	31 d2                	xor    %edx,%edx
80108582:	b8 00 10 00 00       	mov    $0x1000,%eax
80108587:	89 54 24 04          	mov    %edx,0x4(%esp)
8010858b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010858f:	89 34 24             	mov    %esi,(%esp)
80108592:	e8 29 d8 ff ff       	call   80105dc0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108597:	b9 06 00 00 00       	mov    $0x6,%ecx
8010859c:	89 da                	mov    %ebx,%edx
8010859e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801085a4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801085a8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801085ad:	89 04 24             	mov    %eax,(%esp)
801085b0:	89 f8                	mov    %edi,%eax
801085b2:	e8 59 fb ff ff       	call   80108110 <mappages>
801085b7:	85 c0                	test   %eax,%eax
801085b9:	78 4d                	js     80108608 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
801085bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801085c1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801085c4:	76 7a                	jbe    80108640 <allocuvm+0x100>
    mem = kalloc();
801085c6:	e8 c5 9f ff ff       	call   80102590 <kalloc>
    if(mem == 0){
801085cb:	85 c0                	test   %eax,%eax
    mem = kalloc();
801085cd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801085cf:	75 af                	jne    80108580 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801085d1:	c7 04 24 f5 93 10 80 	movl   $0x801093f5,(%esp)
801085d8:	e8 73 80 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801085dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801085e0:	39 45 10             	cmp    %eax,0x10(%ebp)
801085e3:	77 6b                	ja     80108650 <allocuvm+0x110>
}
801085e5:	83 c4 2c             	add    $0x2c,%esp
    return 0;
801085e8:	31 ff                	xor    %edi,%edi
}
801085ea:	5b                   	pop    %ebx
801085eb:	89 f8                	mov    %edi,%eax
801085ed:	5e                   	pop    %esi
801085ee:	5f                   	pop    %edi
801085ef:	5d                   	pop    %ebp
801085f0:	c3                   	ret    
801085f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801085f8:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801085fb:	83 c4 2c             	add    $0x2c,%esp
801085fe:	89 f8                	mov    %edi,%eax
80108600:	5b                   	pop    %ebx
80108601:	5e                   	pop    %esi
80108602:	5f                   	pop    %edi
80108603:	5d                   	pop    %ebp
80108604:	c3                   	ret    
80108605:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108608:	c7 04 24 0d 94 10 80 	movl   $0x8010940d,(%esp)
8010860f:	e8 3c 80 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108614:	8b 45 0c             	mov    0xc(%ebp),%eax
80108617:	39 45 10             	cmp    %eax,0x10(%ebp)
8010861a:	76 0d                	jbe    80108629 <allocuvm+0xe9>
8010861c:	89 c1                	mov    %eax,%ecx
8010861e:	8b 55 10             	mov    0x10(%ebp),%edx
80108621:	8b 45 08             	mov    0x8(%ebp),%eax
80108624:	e8 77 fb ff ff       	call   801081a0 <deallocuvm.part.0>
      kfree(mem);
80108629:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010862c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010862e:	e8 8d 9d ff ff       	call   801023c0 <kfree>
}
80108633:	83 c4 2c             	add    $0x2c,%esp
80108636:	89 f8                	mov    %edi,%eax
80108638:	5b                   	pop    %ebx
80108639:	5e                   	pop    %esi
8010863a:	5f                   	pop    %edi
8010863b:	5d                   	pop    %ebp
8010863c:	c3                   	ret    
8010863d:	8d 76 00             	lea    0x0(%esi),%esi
80108640:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108643:	83 c4 2c             	add    $0x2c,%esp
80108646:	5b                   	pop    %ebx
80108647:	5e                   	pop    %esi
80108648:	89 f8                	mov    %edi,%eax
8010864a:	5f                   	pop    %edi
8010864b:	5d                   	pop    %ebp
8010864c:	c3                   	ret    
8010864d:	8d 76 00             	lea    0x0(%esi),%esi
80108650:	89 c1                	mov    %eax,%ecx
80108652:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108655:	31 ff                	xor    %edi,%edi
80108657:	8b 45 08             	mov    0x8(%ebp),%eax
8010865a:	e8 41 fb ff ff       	call   801081a0 <deallocuvm.part.0>
8010865f:	eb 9a                	jmp    801085fb <allocuvm+0xbb>
80108661:	eb 0d                	jmp    80108670 <deallocuvm>
80108663:	90                   	nop
80108664:	90                   	nop
80108665:	90                   	nop
80108666:	90                   	nop
80108667:	90                   	nop
80108668:	90                   	nop
80108669:	90                   	nop
8010866a:	90                   	nop
8010866b:	90                   	nop
8010866c:	90                   	nop
8010866d:	90                   	nop
8010866e:	90                   	nop
8010866f:	90                   	nop

80108670 <deallocuvm>:
{
80108670:	55                   	push   %ebp
80108671:	89 e5                	mov    %esp,%ebp
80108673:	8b 55 0c             	mov    0xc(%ebp),%edx
80108676:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108679:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010867c:	39 d1                	cmp    %edx,%ecx
8010867e:	73 10                	jae    80108690 <deallocuvm+0x20>
}
80108680:	5d                   	pop    %ebp
80108681:	e9 1a fb ff ff       	jmp    801081a0 <deallocuvm.part.0>
80108686:	8d 76 00             	lea    0x0(%esi),%esi
80108689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108690:	89 d0                	mov    %edx,%eax
80108692:	5d                   	pop    %ebp
80108693:	c3                   	ret    
80108694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010869a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801086a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801086a0:	55                   	push   %ebp
801086a1:	89 e5                	mov    %esp,%ebp
801086a3:	57                   	push   %edi
801086a4:	56                   	push   %esi
801086a5:	53                   	push   %ebx
801086a6:	83 ec 1c             	sub    $0x1c,%esp
801086a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801086ac:	85 f6                	test   %esi,%esi
801086ae:	74 55                	je     80108705 <freevm+0x65>
801086b0:	31 c9                	xor    %ecx,%ecx
801086b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801086b7:	89 f0                	mov    %esi,%eax
801086b9:	89 f3                	mov    %esi,%ebx
801086bb:	e8 e0 fa ff ff       	call   801081a0 <deallocuvm.part.0>
801086c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801086c6:	eb 0f                	jmp    801086d7 <freevm+0x37>
801086c8:	90                   	nop
801086c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086d0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801086d3:	39 fb                	cmp    %edi,%ebx
801086d5:	74 1f                	je     801086f6 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801086d7:	8b 03                	mov    (%ebx),%eax
801086d9:	a8 01                	test   $0x1,%al
801086db:	74 f3                	je     801086d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801086dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086e2:	83 c3 04             	add    $0x4,%ebx
801086e5:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801086ea:	89 04 24             	mov    %eax,(%esp)
801086ed:	e8 ce 9c ff ff       	call   801023c0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
801086f2:	39 fb                	cmp    %edi,%ebx
801086f4:	75 e1                	jne    801086d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801086f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801086f9:	83 c4 1c             	add    $0x1c,%esp
801086fc:	5b                   	pop    %ebx
801086fd:	5e                   	pop    %esi
801086fe:	5f                   	pop    %edi
801086ff:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108700:	e9 bb 9c ff ff       	jmp    801023c0 <kfree>
    panic("freevm: no pgdir");
80108705:	c7 04 24 29 94 10 80 	movl   $0x80109429,(%esp)
8010870c:	e8 5f 7c ff ff       	call   80100370 <panic>
80108711:	eb 0d                	jmp    80108720 <setupkvm>
80108713:	90                   	nop
80108714:	90                   	nop
80108715:	90                   	nop
80108716:	90                   	nop
80108717:	90                   	nop
80108718:	90                   	nop
80108719:	90                   	nop
8010871a:	90                   	nop
8010871b:	90                   	nop
8010871c:	90                   	nop
8010871d:	90                   	nop
8010871e:	90                   	nop
8010871f:	90                   	nop

80108720 <setupkvm>:
{
80108720:	55                   	push   %ebp
80108721:	89 e5                	mov    %esp,%ebp
80108723:	56                   	push   %esi
80108724:	53                   	push   %ebx
80108725:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108728:	e8 63 9e ff ff       	call   80102590 <kalloc>
8010872d:	85 c0                	test   %eax,%eax
8010872f:	89 c6                	mov    %eax,%esi
80108731:	74 46                	je     80108779 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108733:	b8 00 10 00 00       	mov    $0x1000,%eax
80108738:	31 d2                	xor    %edx,%edx
8010873a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010873e:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108743:	89 54 24 04          	mov    %edx,0x4(%esp)
80108747:	89 34 24             	mov    %esi,(%esp)
8010874a:	e8 71 d6 ff ff       	call   80105dc0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010874f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108752:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108755:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108758:	89 54 24 04          	mov    %edx,0x4(%esp)
8010875c:	8b 13                	mov    (%ebx),%edx
8010875e:	89 04 24             	mov    %eax,(%esp)
80108761:	29 c1                	sub    %eax,%ecx
80108763:	89 f0                	mov    %esi,%eax
80108765:	e8 a6 f9 ff ff       	call   80108110 <mappages>
8010876a:	85 c0                	test   %eax,%eax
8010876c:	78 1a                	js     80108788 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010876e:	83 c3 10             	add    $0x10,%ebx
80108771:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108777:	75 d6                	jne    8010874f <setupkvm+0x2f>
}
80108779:	83 c4 10             	add    $0x10,%esp
8010877c:	89 f0                	mov    %esi,%eax
8010877e:	5b                   	pop    %ebx
8010877f:	5e                   	pop    %esi
80108780:	5d                   	pop    %ebp
80108781:	c3                   	ret    
80108782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80108788:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010878b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010878d:	e8 0e ff ff ff       	call   801086a0 <freevm>
}
80108792:	83 c4 10             	add    $0x10,%esp
80108795:	89 f0                	mov    %esi,%eax
80108797:	5b                   	pop    %ebx
80108798:	5e                   	pop    %esi
80108799:	5d                   	pop    %ebp
8010879a:	c3                   	ret    
8010879b:	90                   	nop
8010879c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801087a0 <kvmalloc>:
{
801087a0:	55                   	push   %ebp
801087a1:	89 e5                	mov    %esp,%ebp
801087a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801087a6:	e8 75 ff ff ff       	call   80108720 <setupkvm>
801087ab:	a3 04 81 11 80       	mov    %eax,0x80118104
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801087b0:	05 00 00 00 80       	add    $0x80000000,%eax
801087b5:	0f 22 d8             	mov    %eax,%cr3
}
801087b8:	c9                   	leave  
801087b9:	c3                   	ret    
801087ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801087c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801087c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801087c1:	31 c9                	xor    %ecx,%ecx
{
801087c3:	89 e5                	mov    %esp,%ebp
801087c5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
801087c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801087cb:	8b 45 08             	mov    0x8(%ebp),%eax
801087ce:	e8 ad f8 ff ff       	call   80108080 <walkpgdir>
  if(pte == 0)
801087d3:	85 c0                	test   %eax,%eax
801087d5:	74 05                	je     801087dc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801087d7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801087da:	c9                   	leave  
801087db:	c3                   	ret    
    panic("clearpteu");
801087dc:	c7 04 24 3a 94 10 80 	movl   $0x8010943a,(%esp)
801087e3:	e8 88 7b ff ff       	call   80100370 <panic>
801087e8:	90                   	nop
801087e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801087f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801087f0:	55                   	push   %ebp
801087f1:	89 e5                	mov    %esp,%ebp
801087f3:	57                   	push   %edi
801087f4:	56                   	push   %esi
801087f5:	53                   	push   %ebx
801087f6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801087f9:	e8 22 ff ff ff       	call   80108720 <setupkvm>
801087fe:	85 c0                	test   %eax,%eax
80108800:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108803:	0f 84 a3 00 00 00    	je     801088ac <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108809:	8b 55 0c             	mov    0xc(%ebp),%edx
8010880c:	85 d2                	test   %edx,%edx
8010880e:	0f 84 98 00 00 00    	je     801088ac <copyuvm+0xbc>
80108814:	31 ff                	xor    %edi,%edi
80108816:	eb 50                	jmp    80108868 <copyuvm+0x78>
80108818:	90                   	nop
80108819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108820:	b8 00 10 00 00       	mov    $0x1000,%eax
80108825:	89 44 24 08          	mov    %eax,0x8(%esp)
80108829:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010882c:	89 34 24             	mov    %esi,(%esp)
8010882f:	05 00 00 00 80       	add    $0x80000000,%eax
80108834:	89 44 24 04          	mov    %eax,0x4(%esp)
80108838:	e8 43 d6 ff ff       	call   80105e80 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010883d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108843:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108848:	89 04 24             	mov    %eax,(%esp)
8010884b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010884e:	89 fa                	mov    %edi,%edx
80108850:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108854:	e8 b7 f8 ff ff       	call   80108110 <mappages>
80108859:	85 c0                	test   %eax,%eax
8010885b:	78 63                	js     801088c0 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010885d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108863:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108866:	76 44                	jbe    801088ac <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108868:	8b 45 08             	mov    0x8(%ebp),%eax
8010886b:	31 c9                	xor    %ecx,%ecx
8010886d:	89 fa                	mov    %edi,%edx
8010886f:	e8 0c f8 ff ff       	call   80108080 <walkpgdir>
80108874:	85 c0                	test   %eax,%eax
80108876:	74 5e                	je     801088d6 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80108878:	8b 18                	mov    (%eax),%ebx
8010887a:	f6 c3 01             	test   $0x1,%bl
8010887d:	74 4b                	je     801088ca <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
8010887f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108881:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108887:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010888c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010888f:	e8 fc 9c ff ff       	call   80102590 <kalloc>
80108894:	85 c0                	test   %eax,%eax
80108896:	89 c6                	mov    %eax,%esi
80108898:	75 86                	jne    80108820 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010889a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010889d:	89 04 24             	mov    %eax,(%esp)
801088a0:	e8 fb fd ff ff       	call   801086a0 <freevm>
  return 0;
801088a5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801088ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
801088af:	83 c4 2c             	add    $0x2c,%esp
801088b2:	5b                   	pop    %ebx
801088b3:	5e                   	pop    %esi
801088b4:	5f                   	pop    %edi
801088b5:	5d                   	pop    %ebp
801088b6:	c3                   	ret    
801088b7:	89 f6                	mov    %esi,%esi
801088b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
801088c0:	89 34 24             	mov    %esi,(%esp)
801088c3:	e8 f8 9a ff ff       	call   801023c0 <kfree>
      goto bad;
801088c8:	eb d0                	jmp    8010889a <copyuvm+0xaa>
      panic("copyuvm: page not present");
801088ca:	c7 04 24 5e 94 10 80 	movl   $0x8010945e,(%esp)
801088d1:	e8 9a 7a ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
801088d6:	c7 04 24 44 94 10 80 	movl   $0x80109444,(%esp)
801088dd:	e8 8e 7a ff ff       	call   80100370 <panic>
801088e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801088e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801088f0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801088f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801088f1:	31 c9                	xor    %ecx,%ecx
{
801088f3:	89 e5                	mov    %esp,%ebp
801088f5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801088f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801088fb:	8b 45 08             	mov    0x8(%ebp),%eax
801088fe:	e8 7d f7 ff ff       	call   80108080 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108903:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108905:	89 c2                	mov    %eax,%edx
80108907:	83 e2 05             	and    $0x5,%edx
8010890a:	83 fa 05             	cmp    $0x5,%edx
8010890d:	75 11                	jne    80108920 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010890f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108914:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108919:	c9                   	leave  
8010891a:	c3                   	ret    
8010891b:	90                   	nop
8010891c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108920:	31 c0                	xor    %eax,%eax
}
80108922:	c9                   	leave  
80108923:	c3                   	ret    
80108924:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010892a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108930 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108930:	55                   	push   %ebp
80108931:	89 e5                	mov    %esp,%ebp
80108933:	57                   	push   %edi
80108934:	56                   	push   %esi
80108935:	53                   	push   %ebx
80108936:	83 ec 2c             	sub    $0x2c,%esp
80108939:	8b 75 14             	mov    0x14(%ebp),%esi
8010893c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010893f:	85 f6                	test   %esi,%esi
80108941:	74 75                	je     801089b8 <copyout+0x88>
80108943:	89 da                	mov    %ebx,%edx
80108945:	eb 3f                	jmp    80108986 <copyout+0x56>
80108947:	89 f6                	mov    %esi,%esi
80108949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108950:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108953:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108955:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108958:	29 d7                	sub    %edx,%edi
8010895a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108960:	39 f7                	cmp    %esi,%edi
80108962:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80108965:	29 da                	sub    %ebx,%edx
80108967:	01 c2                	add    %eax,%edx
80108969:	89 14 24             	mov    %edx,(%esp)
8010896c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108970:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108974:	e8 07 d5 ff ff       	call   80105e80 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108979:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
8010897f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80108982:	29 fe                	sub    %edi,%esi
80108984:	74 32                	je     801089b8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80108986:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80108989:	89 d3                	mov    %edx,%ebx
8010898b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108991:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80108995:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108998:	89 04 24             	mov    %eax,(%esp)
8010899b:	e8 50 ff ff ff       	call   801088f0 <uva2ka>
    if(pa0 == 0)
801089a0:	85 c0                	test   %eax,%eax
801089a2:	75 ac                	jne    80108950 <copyout+0x20>
  }
  return 0;
}
801089a4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801089a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801089ac:	5b                   	pop    %ebx
801089ad:	5e                   	pop    %esi
801089ae:	5f                   	pop    %edi
801089af:	5d                   	pop    %ebp
801089b0:	c3                   	ret    
801089b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801089b8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801089bb:	31 c0                	xor    %eax,%eax
}
801089bd:	5b                   	pop    %ebx
801089be:	5e                   	pop    %esi
801089bf:	5f                   	pop    %edi
801089c0:	5d                   	pop    %ebp
801089c1:	c3                   	ret    
