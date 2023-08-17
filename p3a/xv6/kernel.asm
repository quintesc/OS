
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
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
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 34 2a 10 80       	mov    $0x80102a34,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	57                   	push   %edi
80100038:	56                   	push   %esi
80100039:	53                   	push   %ebx
8010003a:	83 ec 18             	sub    $0x18,%esp
8010003d:	89 c6                	mov    %eax,%esi
8010003f:	89 d7                	mov    %edx,%edi
  struct buf *b;

  acquire(&bcache.lock);
80100041:	68 20 a5 10 80       	push   $0x8010a520
80100046:	e8 07 3b 00 00       	call   80103b52 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010004b:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
80100051:	83 c4 10             	add    $0x10,%esp
80100054:	eb 03                	jmp    80100059 <bget+0x25>
80100056:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100059:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010005f:	74 30                	je     80100091 <bget+0x5d>
    if(b->dev == dev && b->blockno == blockno){
80100061:	39 73 04             	cmp    %esi,0x4(%ebx)
80100064:	75 f0                	jne    80100056 <bget+0x22>
80100066:	39 7b 08             	cmp    %edi,0x8(%ebx)
80100069:	75 eb                	jne    80100056 <bget+0x22>
      b->refcnt++;
8010006b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010006e:	83 c0 01             	add    $0x1,%eax
80100071:	89 43 4c             	mov    %eax,0x4c(%ebx)
      release(&bcache.lock);
80100074:	83 ec 0c             	sub    $0xc,%esp
80100077:	68 20 a5 10 80       	push   $0x8010a520
8010007c:	e8 36 3b 00 00       	call   80103bb7 <release>
      acquiresleep(&b->lock);
80100081:	8d 43 0c             	lea    0xc(%ebx),%eax
80100084:	89 04 24             	mov    %eax,(%esp)
80100087:	e8 b2 38 00 00       	call   8010393e <acquiresleep>
      return b;
8010008c:	83 c4 10             	add    $0x10,%esp
8010008f:	eb 4c                	jmp    801000dd <bget+0xa9>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100091:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100097:	eb 03                	jmp    8010009c <bget+0x68>
80100099:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010009c:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000a2:	74 43                	je     801000e7 <bget+0xb3>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
801000a4:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
801000a8:	75 ef                	jne    80100099 <bget+0x65>
801000aa:	f6 03 04             	testb  $0x4,(%ebx)
801000ad:	75 ea                	jne    80100099 <bget+0x65>
      b->dev = dev;
801000af:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
801000b2:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
801000b5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
801000bb:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
801000c2:	83 ec 0c             	sub    $0xc,%esp
801000c5:	68 20 a5 10 80       	push   $0x8010a520
801000ca:	e8 e8 3a 00 00       	call   80103bb7 <release>
      acquiresleep(&b->lock);
801000cf:	8d 43 0c             	lea    0xc(%ebx),%eax
801000d2:	89 04 24             	mov    %eax,(%esp)
801000d5:	e8 64 38 00 00       	call   8010393e <acquiresleep>
      return b;
801000da:	83 c4 10             	add    $0x10,%esp
    }
  }
  panic("bget: no buffers");
}
801000dd:	89 d8                	mov    %ebx,%eax
801000df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801000e2:	5b                   	pop    %ebx
801000e3:	5e                   	pop    %esi
801000e4:	5f                   	pop    %edi
801000e5:	5d                   	pop    %ebp
801000e6:	c3                   	ret    
  panic("bget: no buffers");
801000e7:	83 ec 0c             	sub    $0xc,%esp
801000ea:	68 40 69 10 80       	push   $0x80106940
801000ef:	e8 54 02 00 00       	call   80100348 <panic>

801000f4 <binit>:
{
801000f4:	55                   	push   %ebp
801000f5:	89 e5                	mov    %esp,%ebp
801000f7:	53                   	push   %ebx
801000f8:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
801000fb:	68 51 69 10 80       	push   $0x80106951
80100100:	68 20 a5 10 80       	push   $0x8010a520
80100105:	e8 0c 39 00 00       	call   80103a16 <initlock>
  bcache.head.prev = &bcache.head;
8010010a:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
80100111:	ec 10 80 
  bcache.head.next = &bcache.head;
80100114:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
8010011b:	ec 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010011e:	83 c4 10             	add    $0x10,%esp
80100121:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
80100126:	eb 37                	jmp    8010015f <binit+0x6b>
    b->next = bcache.head.next;
80100128:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010012d:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100130:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100137:	83 ec 08             	sub    $0x8,%esp
8010013a:	68 58 69 10 80       	push   $0x80106958
8010013f:	8d 43 0c             	lea    0xc(%ebx),%eax
80100142:	50                   	push   %eax
80100143:	e8 c3 37 00 00       	call   8010390b <initsleeplock>
    bcache.head.next->prev = b;
80100148:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010014d:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100150:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100156:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
8010015c:	83 c4 10             	add    $0x10,%esp
8010015f:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100165:	72 c1                	jb     80100128 <binit+0x34>
}
80100167:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010016a:	c9                   	leave  
8010016b:	c3                   	ret    

8010016c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
8010016c:	55                   	push   %ebp
8010016d:	89 e5                	mov    %esp,%ebp
8010016f:	53                   	push   %ebx
80100170:	83 ec 04             	sub    $0x4,%esp
  struct buf *b;

  b = bget(dev, blockno);
80100173:	8b 55 0c             	mov    0xc(%ebp),%edx
80100176:	8b 45 08             	mov    0x8(%ebp),%eax
80100179:	e8 b6 fe ff ff       	call   80100034 <bget>
8010017e:	89 c3                	mov    %eax,%ebx
  if((b->flags & B_VALID) == 0) {
80100180:	f6 00 02             	testb  $0x2,(%eax)
80100183:	74 07                	je     8010018c <bread+0x20>
    iderw(b);
  }
  return b;
}
80100185:	89 d8                	mov    %ebx,%eax
80100187:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010018a:	c9                   	leave  
8010018b:	c3                   	ret    
    iderw(b);
8010018c:	83 ec 0c             	sub    $0xc,%esp
8010018f:	50                   	push   %eax
80100190:	e8 62 1c 00 00       	call   80101df7 <iderw>
80100195:	83 c4 10             	add    $0x10,%esp
  return b;
80100198:	eb eb                	jmp    80100185 <bread+0x19>

8010019a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
8010019a:	55                   	push   %ebp
8010019b:	89 e5                	mov    %esp,%ebp
8010019d:	53                   	push   %ebx
8010019e:	83 ec 10             	sub    $0x10,%esp
801001a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001a4:	8d 43 0c             	lea    0xc(%ebx),%eax
801001a7:	50                   	push   %eax
801001a8:	e8 1b 38 00 00       	call   801039c8 <holdingsleep>
801001ad:	83 c4 10             	add    $0x10,%esp
801001b0:	85 c0                	test   %eax,%eax
801001b2:	74 14                	je     801001c8 <bwrite+0x2e>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b4:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001b7:	83 ec 0c             	sub    $0xc,%esp
801001ba:	53                   	push   %ebx
801001bb:	e8 37 1c 00 00       	call   80101df7 <iderw>
}
801001c0:	83 c4 10             	add    $0x10,%esp
801001c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c6:	c9                   	leave  
801001c7:	c3                   	ret    
    panic("bwrite");
801001c8:	83 ec 0c             	sub    $0xc,%esp
801001cb:	68 5f 69 10 80       	push   $0x8010695f
801001d0:	e8 73 01 00 00       	call   80100348 <panic>

801001d5 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d5:	55                   	push   %ebp
801001d6:	89 e5                	mov    %esp,%ebp
801001d8:	56                   	push   %esi
801001d9:	53                   	push   %ebx
801001da:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001dd:	8d 73 0c             	lea    0xc(%ebx),%esi
801001e0:	83 ec 0c             	sub    $0xc,%esp
801001e3:	56                   	push   %esi
801001e4:	e8 df 37 00 00       	call   801039c8 <holdingsleep>
801001e9:	83 c4 10             	add    $0x10,%esp
801001ec:	85 c0                	test   %eax,%eax
801001ee:	74 6b                	je     8010025b <brelse+0x86>
    panic("brelse");

  releasesleep(&b->lock);
801001f0:	83 ec 0c             	sub    $0xc,%esp
801001f3:	56                   	push   %esi
801001f4:	e8 94 37 00 00       	call   8010398d <releasesleep>

  acquire(&bcache.lock);
801001f9:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100200:	e8 4d 39 00 00       	call   80103b52 <acquire>
  b->refcnt--;
80100205:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100208:	83 e8 01             	sub    $0x1,%eax
8010020b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010020e:	83 c4 10             	add    $0x10,%esp
80100211:	85 c0                	test   %eax,%eax
80100213:	75 2f                	jne    80100244 <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100215:	8b 43 54             	mov    0x54(%ebx),%eax
80100218:	8b 53 50             	mov    0x50(%ebx),%edx
8010021b:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021e:	8b 43 50             	mov    0x50(%ebx),%eax
80100221:	8b 53 54             	mov    0x54(%ebx),%edx
80100224:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100227:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010022c:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
8010022f:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    bcache.head.next->prev = b;
80100236:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010023b:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023e:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
80100244:	83 ec 0c             	sub    $0xc,%esp
80100247:	68 20 a5 10 80       	push   $0x8010a520
8010024c:	e8 66 39 00 00       	call   80103bb7 <release>
}
80100251:	83 c4 10             	add    $0x10,%esp
80100254:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100257:	5b                   	pop    %ebx
80100258:	5e                   	pop    %esi
80100259:	5d                   	pop    %ebp
8010025a:	c3                   	ret    
    panic("brelse");
8010025b:	83 ec 0c             	sub    $0xc,%esp
8010025e:	68 66 69 10 80       	push   $0x80106966
80100263:	e8 e0 00 00 00       	call   80100348 <panic>

80100268 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100268:	55                   	push   %ebp
80100269:	89 e5                	mov    %esp,%ebp
8010026b:	57                   	push   %edi
8010026c:	56                   	push   %esi
8010026d:	53                   	push   %ebx
8010026e:	83 ec 28             	sub    $0x28,%esp
80100271:	8b 7d 08             	mov    0x8(%ebp),%edi
80100274:	8b 75 0c             	mov    0xc(%ebp),%esi
80100277:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
8010027a:	57                   	push   %edi
8010027b:	e8 b1 13 00 00       	call   80101631 <iunlock>
  target = n;
80100280:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
80100283:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
8010028a:	e8 c3 38 00 00       	call   80103b52 <acquire>
  while(n > 0){
8010028f:	83 c4 10             	add    $0x10,%esp
80100292:	85 db                	test   %ebx,%ebx
80100294:	0f 8e 8f 00 00 00    	jle    80100329 <consoleread+0xc1>
    while(input.r == input.w){
8010029a:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
8010029f:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002a5:	75 47                	jne    801002ee <consoleread+0x86>
      if(myproc()->killed){
801002a7:	e8 09 2f 00 00       	call   801031b5 <myproc>
801002ac:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
801002b0:	75 17                	jne    801002c9 <consoleread+0x61>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b2:	83 ec 08             	sub    $0x8,%esp
801002b5:	68 20 ef 10 80       	push   $0x8010ef20
801002ba:	68 00 ef 10 80       	push   $0x8010ef00
801002bf:	e8 93 33 00 00       	call   80103657 <sleep>
801002c4:	83 c4 10             	add    $0x10,%esp
801002c7:	eb d1                	jmp    8010029a <consoleread+0x32>
        release(&cons.lock);
801002c9:	83 ec 0c             	sub    $0xc,%esp
801002cc:	68 20 ef 10 80       	push   $0x8010ef20
801002d1:	e8 e1 38 00 00       	call   80103bb7 <release>
        ilock(ip);
801002d6:	89 3c 24             	mov    %edi,(%esp)
801002d9:	e8 91 12 00 00       	call   8010156f <ilock>
        return -1;
801002de:	83 c4 10             	add    $0x10,%esp
801002e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002e9:	5b                   	pop    %ebx
801002ea:	5e                   	pop    %esi
801002eb:	5f                   	pop    %edi
801002ec:	5d                   	pop    %ebp
801002ed:	c3                   	ret    
    c = input.buf[input.r++ % INPUT_BUF];
801002ee:	8d 50 01             	lea    0x1(%eax),%edx
801002f1:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
801002f7:	89 c2                	mov    %eax,%edx
801002f9:	83 e2 7f             	and    $0x7f,%edx
801002fc:	0f b6 92 80 ee 10 80 	movzbl -0x7fef1180(%edx),%edx
80100303:	0f be ca             	movsbl %dl,%ecx
    if(c == C('D')){  // EOF
80100306:	80 fa 04             	cmp    $0x4,%dl
80100309:	74 14                	je     8010031f <consoleread+0xb7>
    *dst++ = c;
8010030b:	8d 46 01             	lea    0x1(%esi),%eax
8010030e:	88 16                	mov    %dl,(%esi)
    --n;
80100310:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100313:	83 f9 0a             	cmp    $0xa,%ecx
80100316:	74 11                	je     80100329 <consoleread+0xc1>
    *dst++ = c;
80100318:	89 c6                	mov    %eax,%esi
8010031a:	e9 73 ff ff ff       	jmp    80100292 <consoleread+0x2a>
      if(n < target){
8010031f:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80100322:	73 05                	jae    80100329 <consoleread+0xc1>
        input.r--;
80100324:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
  release(&cons.lock);
80100329:	83 ec 0c             	sub    $0xc,%esp
8010032c:	68 20 ef 10 80       	push   $0x8010ef20
80100331:	e8 81 38 00 00       	call   80103bb7 <release>
  ilock(ip);
80100336:	89 3c 24             	mov    %edi,(%esp)
80100339:	e8 31 12 00 00       	call   8010156f <ilock>
  return target - n;
8010033e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100341:	29 d8                	sub    %ebx,%eax
80100343:	83 c4 10             	add    $0x10,%esp
80100346:	eb 9e                	jmp    801002e6 <consoleread+0x7e>

80100348 <panic>:
{
80100348:	55                   	push   %ebp
80100349:	89 e5                	mov    %esp,%ebp
8010034b:	53                   	push   %ebx
8010034c:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010034f:	fa                   	cli    
  cons.locking = 0;
80100350:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100357:	00 00 00 
  cprintf("lapicid %d: panic: ", lapicid());
8010035a:	e8 01 20 00 00       	call   80102360 <lapicid>
8010035f:	83 ec 08             	sub    $0x8,%esp
80100362:	50                   	push   %eax
80100363:	68 6d 69 10 80       	push   $0x8010696d
80100368:	e8 9a 02 00 00       	call   80100607 <cprintf>
  cprintf(s);
8010036d:	83 c4 04             	add    $0x4,%esp
80100370:	ff 75 08             	push   0x8(%ebp)
80100373:	e8 8f 02 00 00       	call   80100607 <cprintf>
  cprintf("\n");
80100378:	c7 04 24 eb 72 10 80 	movl   $0x801072eb,(%esp)
8010037f:	e8 83 02 00 00       	call   80100607 <cprintf>
  getcallerpcs(&s, pcs);
80100384:	83 c4 08             	add    $0x8,%esp
80100387:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010038a:	50                   	push   %eax
8010038b:	8d 45 08             	lea    0x8(%ebp),%eax
8010038e:	50                   	push   %eax
8010038f:	e8 9d 36 00 00       	call   80103a31 <getcallerpcs>
  for(i=0; i<10; i++)
80100394:	83 c4 10             	add    $0x10,%esp
80100397:	bb 00 00 00 00       	mov    $0x0,%ebx
8010039c:	eb 17                	jmp    801003b5 <panic+0x6d>
    cprintf(" %p", pcs[i]);
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	ff 74 9d d0          	push   -0x30(%ebp,%ebx,4)
801003a5:	68 81 69 10 80       	push   $0x80106981
801003aa:	e8 58 02 00 00       	call   80100607 <cprintf>
  for(i=0; i<10; i++)
801003af:	83 c3 01             	add    $0x1,%ebx
801003b2:	83 c4 10             	add    $0x10,%esp
801003b5:	83 fb 09             	cmp    $0x9,%ebx
801003b8:	7e e4                	jle    8010039e <panic+0x56>
  panicked = 1; // freeze other CPU
801003ba:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003c1:	00 00 00 
  for(;;)
801003c4:	eb fe                	jmp    801003c4 <panic+0x7c>

801003c6 <cgaputc>:
{
801003c6:	55                   	push   %ebp
801003c7:	89 e5                	mov    %esp,%ebp
801003c9:	57                   	push   %edi
801003ca:	56                   	push   %esi
801003cb:	53                   	push   %ebx
801003cc:	83 ec 0c             	sub    $0xc,%esp
801003cf:	89 c3                	mov    %eax,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003d1:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003d6:	b8 0e 00 00 00       	mov    $0xe,%eax
801003db:	89 fa                	mov    %edi,%edx
801003dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003de:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003e3:	89 ca                	mov    %ecx,%edx
801003e5:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003e6:	0f b6 f0             	movzbl %al,%esi
801003e9:	c1 e6 08             	shl    $0x8,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003ec:	b8 0f 00 00 00       	mov    $0xf,%eax
801003f1:	89 fa                	mov    %edi,%edx
801003f3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003f4:	89 ca                	mov    %ecx,%edx
801003f6:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801003f7:	0f b6 c8             	movzbl %al,%ecx
801003fa:	09 f1                	or     %esi,%ecx
  if(c == '\n')
801003fc:	83 fb 0a             	cmp    $0xa,%ebx
801003ff:	74 60                	je     80100461 <cgaputc+0x9b>
  else if(c == BACKSPACE){
80100401:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100407:	74 79                	je     80100482 <cgaputc+0xbc>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100409:	0f b6 c3             	movzbl %bl,%eax
8010040c:	8d 59 01             	lea    0x1(%ecx),%ebx
8010040f:	80 cc 07             	or     $0x7,%ah
80100412:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100419:	80 
  if(pos < 0 || pos > 25*80)
8010041a:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100420:	77 6d                	ja     8010048f <cgaputc+0xc9>
  if((pos/80) >= 24){  // Scroll up.
80100422:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100428:	7f 72                	jg     8010049c <cgaputc+0xd6>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042a:	be d4 03 00 00       	mov    $0x3d4,%esi
8010042f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100434:	89 f2                	mov    %esi,%edx
80100436:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, pos>>8);
80100437:	0f b6 c7             	movzbl %bh,%eax
8010043a:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043f:	89 ca                	mov    %ecx,%edx
80100441:	ee                   	out    %al,(%dx)
80100442:	b8 0f 00 00 00       	mov    $0xf,%eax
80100447:	89 f2                	mov    %esi,%edx
80100449:	ee                   	out    %al,(%dx)
8010044a:	89 d8                	mov    %ebx,%eax
8010044c:	89 ca                	mov    %ecx,%edx
8010044e:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
8010044f:	66 c7 84 1b 00 80 0b 	movw   $0x720,-0x7ff48000(%ebx,%ebx,1)
80100456:	80 20 07 
}
80100459:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010045c:	5b                   	pop    %ebx
8010045d:	5e                   	pop    %esi
8010045e:	5f                   	pop    %edi
8010045f:	5d                   	pop    %ebp
80100460:	c3                   	ret    
    pos += 80 - pos%80;
80100461:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100466:	89 c8                	mov    %ecx,%eax
80100468:	f7 ea                	imul   %edx
8010046a:	c1 fa 05             	sar    $0x5,%edx
8010046d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100470:	c1 e0 04             	shl    $0x4,%eax
80100473:	89 ca                	mov    %ecx,%edx
80100475:	29 c2                	sub    %eax,%edx
80100477:	bb 50 00 00 00       	mov    $0x50,%ebx
8010047c:	29 d3                	sub    %edx,%ebx
8010047e:	01 cb                	add    %ecx,%ebx
80100480:	eb 98                	jmp    8010041a <cgaputc+0x54>
    if(pos > 0) --pos;
80100482:	85 c9                	test   %ecx,%ecx
80100484:	7e 05                	jle    8010048b <cgaputc+0xc5>
80100486:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80100489:	eb 8f                	jmp    8010041a <cgaputc+0x54>
  pos |= inb(CRTPORT+1);
8010048b:	89 cb                	mov    %ecx,%ebx
8010048d:	eb 8b                	jmp    8010041a <cgaputc+0x54>
    panic("pos under/overflow");
8010048f:	83 ec 0c             	sub    $0xc,%esp
80100492:	68 85 69 10 80       	push   $0x80106985
80100497:	e8 ac fe ff ff       	call   80100348 <panic>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010049c:	83 ec 04             	sub    $0x4,%esp
8010049f:	68 60 0e 00 00       	push   $0xe60
801004a4:	68 a0 80 0b 80       	push   $0x800b80a0
801004a9:	68 00 80 0b 80       	push   $0x800b8000
801004ae:	e8 c3 37 00 00       	call   80103c76 <memmove>
    pos -= 80;
801004b3:	83 eb 50             	sub    $0x50,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004b6:	b8 80 07 00 00       	mov    $0x780,%eax
801004bb:	29 d8                	sub    %ebx,%eax
801004bd:	8d 94 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edx
801004c4:	83 c4 0c             	add    $0xc,%esp
801004c7:	01 c0                	add    %eax,%eax
801004c9:	50                   	push   %eax
801004ca:	6a 00                	push   $0x0
801004cc:	52                   	push   %edx
801004cd:	e8 2c 37 00 00       	call   80103bfe <memset>
801004d2:	83 c4 10             	add    $0x10,%esp
801004d5:	e9 50 ff ff ff       	jmp    8010042a <cgaputc+0x64>

801004da <consputc>:
  if(panicked){
801004da:	83 3d 58 ef 10 80 00 	cmpl   $0x0,0x8010ef58
801004e1:	74 03                	je     801004e6 <consputc+0xc>
  asm volatile("cli");
801004e3:	fa                   	cli    
    for(;;)
801004e4:	eb fe                	jmp    801004e4 <consputc+0xa>
{
801004e6:	55                   	push   %ebp
801004e7:	89 e5                	mov    %esp,%ebp
801004e9:	53                   	push   %ebx
801004ea:	83 ec 04             	sub    $0x4,%esp
801004ed:	89 c3                	mov    %eax,%ebx
  if(c == BACKSPACE){
801004ef:	3d 00 01 00 00       	cmp    $0x100,%eax
801004f4:	74 18                	je     8010050e <consputc+0x34>
    uartputc(c);
801004f6:	83 ec 0c             	sub    $0xc,%esp
801004f9:	50                   	push   %eax
801004fa:	e8 f0 4b 00 00       	call   801050ef <uartputc>
801004ff:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100502:	89 d8                	mov    %ebx,%eax
80100504:	e8 bd fe ff ff       	call   801003c6 <cgaputc>
}
80100509:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010050c:	c9                   	leave  
8010050d:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010050e:	83 ec 0c             	sub    $0xc,%esp
80100511:	6a 08                	push   $0x8
80100513:	e8 d7 4b 00 00       	call   801050ef <uartputc>
80100518:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010051f:	e8 cb 4b 00 00       	call   801050ef <uartputc>
80100524:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052b:	e8 bf 4b 00 00       	call   801050ef <uartputc>
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	eb cd                	jmp    80100502 <consputc+0x28>

80100535 <printint>:
{
80100535:	55                   	push   %ebp
80100536:	89 e5                	mov    %esp,%ebp
80100538:	57                   	push   %edi
80100539:	56                   	push   %esi
8010053a:	53                   	push   %ebx
8010053b:	83 ec 2c             	sub    $0x2c,%esp
8010053e:	89 d6                	mov    %edx,%esi
80100540:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100543:	85 c9                	test   %ecx,%ecx
80100545:	74 0c                	je     80100553 <printint+0x1e>
80100547:	89 c7                	mov    %eax,%edi
80100549:	c1 ef 1f             	shr    $0x1f,%edi
8010054c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010054f:	85 c0                	test   %eax,%eax
80100551:	78 38                	js     8010058b <printint+0x56>
    x = xx;
80100553:	89 c1                	mov    %eax,%ecx
  i = 0;
80100555:	bb 00 00 00 00       	mov    $0x0,%ebx
    buf[i++] = digits[x % base];
8010055a:	89 c8                	mov    %ecx,%eax
8010055c:	ba 00 00 00 00       	mov    $0x0,%edx
80100561:	f7 f6                	div    %esi
80100563:	89 df                	mov    %ebx,%edi
80100565:	83 c3 01             	add    $0x1,%ebx
80100568:	0f b6 92 b0 69 10 80 	movzbl -0x7fef9650(%edx),%edx
8010056f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
80100573:	89 ca                	mov    %ecx,%edx
80100575:	89 c1                	mov    %eax,%ecx
80100577:	39 d6                	cmp    %edx,%esi
80100579:	76 df                	jbe    8010055a <printint+0x25>
  if(sign)
8010057b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
8010057f:	74 1a                	je     8010059b <printint+0x66>
    buf[i++] = '-';
80100581:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
80100586:	8d 5f 02             	lea    0x2(%edi),%ebx
80100589:	eb 10                	jmp    8010059b <printint+0x66>
    x = -xx;
8010058b:	f7 d8                	neg    %eax
8010058d:	89 c1                	mov    %eax,%ecx
8010058f:	eb c4                	jmp    80100555 <printint+0x20>
    consputc(buf[i]);
80100591:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
80100596:	e8 3f ff ff ff       	call   801004da <consputc>
  while(--i >= 0)
8010059b:	83 eb 01             	sub    $0x1,%ebx
8010059e:	79 f1                	jns    80100591 <printint+0x5c>
}
801005a0:	83 c4 2c             	add    $0x2c,%esp
801005a3:	5b                   	pop    %ebx
801005a4:	5e                   	pop    %esi
801005a5:	5f                   	pop    %edi
801005a6:	5d                   	pop    %ebp
801005a7:	c3                   	ret    

801005a8 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005a8:	55                   	push   %ebp
801005a9:	89 e5                	mov    %esp,%ebp
801005ab:	57                   	push   %edi
801005ac:	56                   	push   %esi
801005ad:	53                   	push   %ebx
801005ae:	83 ec 18             	sub    $0x18,%esp
801005b1:	8b 7d 0c             	mov    0xc(%ebp),%edi
801005b4:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005b7:	ff 75 08             	push   0x8(%ebp)
801005ba:	e8 72 10 00 00       	call   80101631 <iunlock>
  acquire(&cons.lock);
801005bf:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801005c6:	e8 87 35 00 00       	call   80103b52 <acquire>
  for(i = 0; i < n; i++)
801005cb:	83 c4 10             	add    $0x10,%esp
801005ce:	bb 00 00 00 00       	mov    $0x0,%ebx
801005d3:	eb 0c                	jmp    801005e1 <consolewrite+0x39>
    consputc(buf[i] & 0xff);
801005d5:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801005d9:	e8 fc fe ff ff       	call   801004da <consputc>
  for(i = 0; i < n; i++)
801005de:	83 c3 01             	add    $0x1,%ebx
801005e1:	39 f3                	cmp    %esi,%ebx
801005e3:	7c f0                	jl     801005d5 <consolewrite+0x2d>
  release(&cons.lock);
801005e5:	83 ec 0c             	sub    $0xc,%esp
801005e8:	68 20 ef 10 80       	push   $0x8010ef20
801005ed:	e8 c5 35 00 00       	call   80103bb7 <release>
  ilock(ip);
801005f2:	83 c4 04             	add    $0x4,%esp
801005f5:	ff 75 08             	push   0x8(%ebp)
801005f8:	e8 72 0f 00 00       	call   8010156f <ilock>

  return n;
}
801005fd:	89 f0                	mov    %esi,%eax
801005ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100602:	5b                   	pop    %ebx
80100603:	5e                   	pop    %esi
80100604:	5f                   	pop    %edi
80100605:	5d                   	pop    %ebp
80100606:	c3                   	ret    

80100607 <cprintf>:
{
80100607:	55                   	push   %ebp
80100608:	89 e5                	mov    %esp,%ebp
8010060a:	57                   	push   %edi
8010060b:	56                   	push   %esi
8010060c:	53                   	push   %ebx
8010060d:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100610:	a1 54 ef 10 80       	mov    0x8010ef54,%eax
80100615:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100618:	85 c0                	test   %eax,%eax
8010061a:	75 10                	jne    8010062c <cprintf+0x25>
  if (fmt == 0)
8010061c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80100620:	74 1c                	je     8010063e <cprintf+0x37>
  argp = (uint*)(void*)(&fmt + 1);
80100622:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100625:	be 00 00 00 00       	mov    $0x0,%esi
8010062a:	eb 27                	jmp    80100653 <cprintf+0x4c>
    acquire(&cons.lock);
8010062c:	83 ec 0c             	sub    $0xc,%esp
8010062f:	68 20 ef 10 80       	push   $0x8010ef20
80100634:	e8 19 35 00 00       	call   80103b52 <acquire>
80100639:	83 c4 10             	add    $0x10,%esp
8010063c:	eb de                	jmp    8010061c <cprintf+0x15>
    panic("null fmt");
8010063e:	83 ec 0c             	sub    $0xc,%esp
80100641:	68 9f 69 10 80       	push   $0x8010699f
80100646:	e8 fd fc ff ff       	call   80100348 <panic>
      consputc(c);
8010064b:	e8 8a fe ff ff       	call   801004da <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100650:	83 c6 01             	add    $0x1,%esi
80100653:	8b 55 08             	mov    0x8(%ebp),%edx
80100656:	0f b6 04 32          	movzbl (%edx,%esi,1),%eax
8010065a:	85 c0                	test   %eax,%eax
8010065c:	0f 84 b1 00 00 00    	je     80100713 <cprintf+0x10c>
    if(c != '%'){
80100662:	83 f8 25             	cmp    $0x25,%eax
80100665:	75 e4                	jne    8010064b <cprintf+0x44>
    c = fmt[++i] & 0xff;
80100667:	83 c6 01             	add    $0x1,%esi
8010066a:	0f b6 1c 32          	movzbl (%edx,%esi,1),%ebx
    if(c == 0)
8010066e:	85 db                	test   %ebx,%ebx
80100670:	0f 84 9d 00 00 00    	je     80100713 <cprintf+0x10c>
    switch(c){
80100676:	83 fb 70             	cmp    $0x70,%ebx
80100679:	74 2e                	je     801006a9 <cprintf+0xa2>
8010067b:	7f 22                	jg     8010069f <cprintf+0x98>
8010067d:	83 fb 25             	cmp    $0x25,%ebx
80100680:	74 6c                	je     801006ee <cprintf+0xe7>
80100682:	83 fb 64             	cmp    $0x64,%ebx
80100685:	75 76                	jne    801006fd <cprintf+0xf6>
      printint(*argp++, 10, 1);
80100687:	8d 5f 04             	lea    0x4(%edi),%ebx
8010068a:	8b 07                	mov    (%edi),%eax
8010068c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100691:	ba 0a 00 00 00       	mov    $0xa,%edx
80100696:	e8 9a fe ff ff       	call   80100535 <printint>
8010069b:	89 df                	mov    %ebx,%edi
      break;
8010069d:	eb b1                	jmp    80100650 <cprintf+0x49>
    switch(c){
8010069f:	83 fb 73             	cmp    $0x73,%ebx
801006a2:	74 1d                	je     801006c1 <cprintf+0xba>
801006a4:	83 fb 78             	cmp    $0x78,%ebx
801006a7:	75 54                	jne    801006fd <cprintf+0xf6>
      printint(*argp++, 16, 0);
801006a9:	8d 5f 04             	lea    0x4(%edi),%ebx
801006ac:	8b 07                	mov    (%edi),%eax
801006ae:	b9 00 00 00 00       	mov    $0x0,%ecx
801006b3:	ba 10 00 00 00       	mov    $0x10,%edx
801006b8:	e8 78 fe ff ff       	call   80100535 <printint>
801006bd:	89 df                	mov    %ebx,%edi
      break;
801006bf:	eb 8f                	jmp    80100650 <cprintf+0x49>
      if((s = (char*)*argp++) == 0)
801006c1:	8d 47 04             	lea    0x4(%edi),%eax
801006c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006c7:	8b 1f                	mov    (%edi),%ebx
801006c9:	85 db                	test   %ebx,%ebx
801006cb:	75 12                	jne    801006df <cprintf+0xd8>
        s = "(null)";
801006cd:	bb 98 69 10 80       	mov    $0x80106998,%ebx
801006d2:	eb 0b                	jmp    801006df <cprintf+0xd8>
        consputc(*s);
801006d4:	0f be c0             	movsbl %al,%eax
801006d7:	e8 fe fd ff ff       	call   801004da <consputc>
      for(; *s; s++)
801006dc:	83 c3 01             	add    $0x1,%ebx
801006df:	0f b6 03             	movzbl (%ebx),%eax
801006e2:	84 c0                	test   %al,%al
801006e4:	75 ee                	jne    801006d4 <cprintf+0xcd>
      if((s = (char*)*argp++) == 0)
801006e6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801006e9:	e9 62 ff ff ff       	jmp    80100650 <cprintf+0x49>
      consputc('%');
801006ee:	b8 25 00 00 00       	mov    $0x25,%eax
801006f3:	e8 e2 fd ff ff       	call   801004da <consputc>
      break;
801006f8:	e9 53 ff ff ff       	jmp    80100650 <cprintf+0x49>
      consputc('%');
801006fd:	b8 25 00 00 00       	mov    $0x25,%eax
80100702:	e8 d3 fd ff ff       	call   801004da <consputc>
      consputc(c);
80100707:	89 d8                	mov    %ebx,%eax
80100709:	e8 cc fd ff ff       	call   801004da <consputc>
      break;
8010070e:	e9 3d ff ff ff       	jmp    80100650 <cprintf+0x49>
  if(locking)
80100713:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100717:	75 08                	jne    80100721 <cprintf+0x11a>
}
80100719:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071c:	5b                   	pop    %ebx
8010071d:	5e                   	pop    %esi
8010071e:	5f                   	pop    %edi
8010071f:	5d                   	pop    %ebp
80100720:	c3                   	ret    
    release(&cons.lock);
80100721:	83 ec 0c             	sub    $0xc,%esp
80100724:	68 20 ef 10 80       	push   $0x8010ef20
80100729:	e8 89 34 00 00       	call   80103bb7 <release>
8010072e:	83 c4 10             	add    $0x10,%esp
}
80100731:	eb e6                	jmp    80100719 <cprintf+0x112>

80100733 <consoleintr>:
{
80100733:	55                   	push   %ebp
80100734:	89 e5                	mov    %esp,%ebp
80100736:	57                   	push   %edi
80100737:	56                   	push   %esi
80100738:	53                   	push   %ebx
80100739:	83 ec 18             	sub    $0x18,%esp
8010073c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010073f:	68 20 ef 10 80       	push   $0x8010ef20
80100744:	e8 09 34 00 00       	call   80103b52 <acquire>
  while((c = getc()) >= 0){
80100749:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
8010074c:	be 00 00 00 00       	mov    $0x0,%esi
  while((c = getc()) >= 0){
80100751:	eb 13                	jmp    80100766 <consoleintr+0x33>
    switch(c){
80100753:	83 ff 08             	cmp    $0x8,%edi
80100756:	0f 84 d9 00 00 00    	je     80100835 <consoleintr+0x102>
8010075c:	83 ff 10             	cmp    $0x10,%edi
8010075f:	75 25                	jne    80100786 <consoleintr+0x53>
80100761:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100766:	ff d3                	call   *%ebx
80100768:	89 c7                	mov    %eax,%edi
8010076a:	85 c0                	test   %eax,%eax
8010076c:	0f 88 f5 00 00 00    	js     80100867 <consoleintr+0x134>
    switch(c){
80100772:	83 ff 15             	cmp    $0x15,%edi
80100775:	0f 84 93 00 00 00    	je     8010080e <consoleintr+0xdb>
8010077b:	7e d6                	jle    80100753 <consoleintr+0x20>
8010077d:	83 ff 7f             	cmp    $0x7f,%edi
80100780:	0f 84 af 00 00 00    	je     80100835 <consoleintr+0x102>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100786:	85 ff                	test   %edi,%edi
80100788:	74 dc                	je     80100766 <consoleintr+0x33>
8010078a:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010078f:	89 c2                	mov    %eax,%edx
80100791:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100797:	83 fa 7f             	cmp    $0x7f,%edx
8010079a:	77 ca                	ja     80100766 <consoleintr+0x33>
        c = (c == '\r') ? '\n' : c;
8010079c:	83 ff 0d             	cmp    $0xd,%edi
8010079f:	0f 84 b8 00 00 00    	je     8010085d <consoleintr+0x12a>
        input.buf[input.e++ % INPUT_BUF] = c;
801007a5:	8d 50 01             	lea    0x1(%eax),%edx
801007a8:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
801007ae:	83 e0 7f             	and    $0x7f,%eax
801007b1:	89 f9                	mov    %edi,%ecx
801007b3:	88 88 80 ee 10 80    	mov    %cl,-0x7fef1180(%eax)
        consputc(c);
801007b9:	89 f8                	mov    %edi,%eax
801007bb:	e8 1a fd ff ff       	call   801004da <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801007c0:	83 ff 0a             	cmp    $0xa,%edi
801007c3:	0f 94 c0             	sete   %al
801007c6:	83 ff 04             	cmp    $0x4,%edi
801007c9:	0f 94 c2             	sete   %dl
801007cc:	08 d0                	or     %dl,%al
801007ce:	75 10                	jne    801007e0 <consoleintr+0xad>
801007d0:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801007d5:	83 e8 80             	sub    $0xffffff80,%eax
801007d8:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
801007de:	75 86                	jne    80100766 <consoleintr+0x33>
          input.w = input.e;
801007e0:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801007e5:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
          wakeup(&input.r);
801007ea:	83 ec 0c             	sub    $0xc,%esp
801007ed:	68 00 ef 10 80       	push   $0x8010ef00
801007f2:	e8 c5 2f 00 00       	call   801037bc <wakeup>
801007f7:	83 c4 10             	add    $0x10,%esp
801007fa:	e9 67 ff ff ff       	jmp    80100766 <consoleintr+0x33>
        input.e--;
801007ff:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
        consputc(BACKSPACE);
80100804:	b8 00 01 00 00       	mov    $0x100,%eax
80100809:	e8 cc fc ff ff       	call   801004da <consputc>
      while(input.e != input.w &&
8010080e:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100813:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100819:	0f 84 47 ff ff ff    	je     80100766 <consoleintr+0x33>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010081f:	83 e8 01             	sub    $0x1,%eax
80100822:	89 c2                	mov    %eax,%edx
80100824:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100827:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
8010082e:	75 cf                	jne    801007ff <consoleintr+0xcc>
80100830:	e9 31 ff ff ff       	jmp    80100766 <consoleintr+0x33>
      if(input.e != input.w){
80100835:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010083a:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100840:	0f 84 20 ff ff ff    	je     80100766 <consoleintr+0x33>
        input.e--;
80100846:	83 e8 01             	sub    $0x1,%eax
80100849:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
        consputc(BACKSPACE);
8010084e:	b8 00 01 00 00       	mov    $0x100,%eax
80100853:	e8 82 fc ff ff       	call   801004da <consputc>
80100858:	e9 09 ff ff ff       	jmp    80100766 <consoleintr+0x33>
        c = (c == '\r') ? '\n' : c;
8010085d:	bf 0a 00 00 00       	mov    $0xa,%edi
80100862:	e9 3e ff ff ff       	jmp    801007a5 <consoleintr+0x72>
  release(&cons.lock);
80100867:	83 ec 0c             	sub    $0xc,%esp
8010086a:	68 20 ef 10 80       	push   $0x8010ef20
8010086f:	e8 43 33 00 00       	call   80103bb7 <release>
  if(doprocdump) {
80100874:	83 c4 10             	add    $0x10,%esp
80100877:	85 f6                	test   %esi,%esi
80100879:	75 08                	jne    80100883 <consoleintr+0x150>
}
8010087b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087e:	5b                   	pop    %ebx
8010087f:	5e                   	pop    %esi
80100880:	5f                   	pop    %edi
80100881:	5d                   	pop    %ebp
80100882:	c3                   	ret    
    procdump();  // now call procdump() wo. cons.lock held
80100883:	e8 d1 2f 00 00       	call   80103859 <procdump>
}
80100888:	eb f1                	jmp    8010087b <consoleintr+0x148>

8010088a <consoleinit>:

void
consoleinit(void)
{
8010088a:	55                   	push   %ebp
8010088b:	89 e5                	mov    %esp,%ebp
8010088d:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100890:	68 a8 69 10 80       	push   $0x801069a8
80100895:	68 20 ef 10 80       	push   $0x8010ef20
8010089a:	e8 77 31 00 00       	call   80103a16 <initlock>

  devsw[CONSOLE].write = consolewrite;
8010089f:	c7 05 0c f9 10 80 a8 	movl   $0x801005a8,0x8010f90c
801008a6:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801008a9:	c7 05 08 f9 10 80 68 	movl   $0x80100268,0x8010f908
801008b0:	02 10 80 
  cons.locking = 1;
801008b3:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
801008ba:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801008bd:	83 c4 08             	add    $0x8,%esp
801008c0:	6a 00                	push   $0x0
801008c2:	6a 01                	push   $0x1
801008c4:	e8 98 16 00 00       	call   80101f61 <ioapicenable>
}
801008c9:	83 c4 10             	add    $0x10,%esp
801008cc:	c9                   	leave  
801008cd:	c3                   	ret    

801008ce <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801008ce:	55                   	push   %ebp
801008cf:	89 e5                	mov    %esp,%ebp
801008d1:	57                   	push   %edi
801008d2:	56                   	push   %esi
801008d3:	53                   	push   %ebx
801008d4:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801008da:	e8 d6 28 00 00       	call   801031b5 <myproc>
801008df:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801008e5:	e8 94 1e 00 00       	call   8010277e <begin_op>

  if((ip = namei(path)) == 0){
801008ea:	83 ec 0c             	sub    $0xc,%esp
801008ed:	ff 75 08             	push   0x8(%ebp)
801008f0:	e8 d8 12 00 00       	call   80101bcd <namei>
801008f5:	83 c4 10             	add    $0x10,%esp
801008f8:	85 c0                	test   %eax,%eax
801008fa:	74 56                	je     80100952 <exec+0x84>
801008fc:	89 c3                	mov    %eax,%ebx
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801008fe:	83 ec 0c             	sub    $0xc,%esp
80100901:	50                   	push   %eax
80100902:	e8 68 0c 00 00       	call   8010156f <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100907:	6a 34                	push   $0x34
80100909:	6a 00                	push   $0x0
8010090b:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100911:	50                   	push   %eax
80100912:	53                   	push   %ebx
80100913:	e8 49 0e 00 00       	call   80101761 <readi>
80100918:	83 c4 20             	add    $0x20,%esp
8010091b:	83 f8 34             	cmp    $0x34,%eax
8010091e:	75 0c                	jne    8010092c <exec+0x5e>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100920:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100927:	45 4c 46 
8010092a:	74 42                	je     8010096e <exec+0xa0>
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
8010092c:	85 db                	test   %ebx,%ebx
8010092e:	0f 84 c5 02 00 00    	je     80100bf9 <exec+0x32b>
    iunlockput(ip);
80100934:	83 ec 0c             	sub    $0xc,%esp
80100937:	53                   	push   %ebx
80100938:	e8 d9 0d 00 00       	call   80101716 <iunlockput>
    end_op();
8010093d:	e8 b6 1e 00 00       	call   801027f8 <end_op>
80100942:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010094a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010094d:	5b                   	pop    %ebx
8010094e:	5e                   	pop    %esi
8010094f:	5f                   	pop    %edi
80100950:	5d                   	pop    %ebp
80100951:	c3                   	ret    
    end_op();
80100952:	e8 a1 1e 00 00       	call   801027f8 <end_op>
    cprintf("exec: fail\n");
80100957:	83 ec 0c             	sub    $0xc,%esp
8010095a:	68 c1 69 10 80       	push   $0x801069c1
8010095f:	e8 a3 fc ff ff       	call   80100607 <cprintf>
    return -1;
80100964:	83 c4 10             	add    $0x10,%esp
80100967:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010096c:	eb dc                	jmp    8010094a <exec+0x7c>
  if((pgdir = setupkvm()) == 0)
8010096e:	e8 ad 5a 00 00       	call   80106420 <setupkvm>
80100973:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100979:	85 c0                	test   %eax,%eax
8010097b:	0f 84 09 01 00 00    	je     80100a8a <exec+0x1bc>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100981:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  sz = 0;
80100987:	bf 00 00 00 00       	mov    $0x0,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010098c:	be 00 00 00 00       	mov    $0x0,%esi
80100991:	eb 0c                	jmp    8010099f <exec+0xd1>
80100993:	83 c6 01             	add    $0x1,%esi
80100996:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
8010099c:	83 c0 20             	add    $0x20,%eax
8010099f:	0f b7 95 50 ff ff ff 	movzwl -0xb0(%ebp),%edx
801009a6:	39 f2                	cmp    %esi,%edx
801009a8:	0f 8e 98 00 00 00    	jle    80100a46 <exec+0x178>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801009ae:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801009b4:	6a 20                	push   $0x20
801009b6:	50                   	push   %eax
801009b7:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801009bd:	50                   	push   %eax
801009be:	53                   	push   %ebx
801009bf:	e8 9d 0d 00 00       	call   80101761 <readi>
801009c4:	83 c4 10             	add    $0x10,%esp
801009c7:	83 f8 20             	cmp    $0x20,%eax
801009ca:	0f 85 ba 00 00 00    	jne    80100a8a <exec+0x1bc>
    if(ph.type != ELF_PROG_LOAD)
801009d0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801009d7:	75 ba                	jne    80100993 <exec+0xc5>
    if(ph.memsz < ph.filesz)
801009d9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801009df:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801009e5:	0f 82 9f 00 00 00    	jb     80100a8a <exec+0x1bc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801009eb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801009f1:	0f 82 93 00 00 00    	jb     80100a8a <exec+0x1bc>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801009f7:	83 ec 04             	sub    $0x4,%esp
801009fa:	50                   	push   %eax
801009fb:	57                   	push   %edi
801009fc:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100a02:	e8 bc 58 00 00       	call   801062c3 <allocuvm>
80100a07:	89 c7                	mov    %eax,%edi
80100a09:	83 c4 10             	add    $0x10,%esp
80100a0c:	85 c0                	test   %eax,%eax
80100a0e:	74 7a                	je     80100a8a <exec+0x1bc>
    if(ph.vaddr % PGSIZE != 0)
80100a10:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100a16:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100a1b:	75 6d                	jne    80100a8a <exec+0x1bc>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100a1d:	83 ec 0c             	sub    $0xc,%esp
80100a20:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100a26:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100a2c:	53                   	push   %ebx
80100a2d:	50                   	push   %eax
80100a2e:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100a34:	e8 5a 57 00 00       	call   80106193 <loaduvm>
80100a39:	83 c4 20             	add    $0x20,%esp
80100a3c:	85 c0                	test   %eax,%eax
80100a3e:	0f 89 4f ff ff ff    	jns    80100993 <exec+0xc5>
80100a44:	eb 44                	jmp    80100a8a <exec+0x1bc>
  iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 c7 0c 00 00       	call   80101716 <iunlockput>
  end_op();
80100a4f:	e8 a4 1d 00 00       	call   801027f8 <end_op>
  sz = PGROUNDUP(sz);
80100a54:	8d 87 ff 0f 00 00    	lea    0xfff(%edi),%eax
80100a5a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100a5f:	83 c4 0c             	add    $0xc,%esp
80100a62:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100a68:	52                   	push   %edx
80100a69:	50                   	push   %eax
80100a6a:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100a70:	57                   	push   %edi
80100a71:	e8 4d 58 00 00       	call   801062c3 <allocuvm>
80100a76:	89 c6                	mov    %eax,%esi
80100a78:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a7e:	83 c4 10             	add    $0x10,%esp
80100a81:	85 c0                	test   %eax,%eax
80100a83:	75 24                	jne    80100aa9 <exec+0x1db>
  ip = 0;
80100a85:	bb 00 00 00 00       	mov    $0x0,%ebx
  if(pgdir)
80100a8a:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a90:	85 c0                	test   %eax,%eax
80100a92:	0f 84 94 fe ff ff    	je     8010092c <exec+0x5e>
    freevm(pgdir);
80100a98:	83 ec 0c             	sub    $0xc,%esp
80100a9b:	50                   	push   %eax
80100a9c:	e8 0c 59 00 00       	call   801063ad <freevm>
80100aa1:	83 c4 10             	add    $0x10,%esp
80100aa4:	e9 83 fe ff ff       	jmp    8010092c <exec+0x5e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100aa9:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100aaf:	83 ec 08             	sub    $0x8,%esp
80100ab2:	50                   	push   %eax
80100ab3:	57                   	push   %edi
80100ab4:	e8 ec 59 00 00       	call   801064a5 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ab9:	83 c4 10             	add    $0x10,%esp
80100abc:	bf 00 00 00 00       	mov    $0x0,%edi
80100ac1:	eb 0a                	jmp    80100acd <exec+0x1ff>
    ustack[3+argc] = sp;
80100ac3:	89 b4 bd 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100aca:	83 c7 01             	add    $0x1,%edi
80100acd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ad0:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
80100ad3:	8b 03                	mov    (%ebx),%eax
80100ad5:	85 c0                	test   %eax,%eax
80100ad7:	74 47                	je     80100b20 <exec+0x252>
    if(argc >= MAXARG)
80100ad9:	83 ff 1f             	cmp    $0x1f,%edi
80100adc:	0f 87 0d 01 00 00    	ja     80100bef <exec+0x321>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	50                   	push   %eax
80100ae6:	e8 bc 32 00 00       	call   80103da7 <strlen>
80100aeb:	29 c6                	sub    %eax,%esi
80100aed:	83 ee 01             	sub    $0x1,%esi
80100af0:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100af3:	83 c4 04             	add    $0x4,%esp
80100af6:	ff 33                	push   (%ebx)
80100af8:	e8 aa 32 00 00       	call   80103da7 <strlen>
80100afd:	83 c0 01             	add    $0x1,%eax
80100b00:	50                   	push   %eax
80100b01:	ff 33                	push   (%ebx)
80100b03:	56                   	push   %esi
80100b04:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b0a:	e8 ea 5a 00 00       	call   801065f9 <copyout>
80100b0f:	83 c4 20             	add    $0x20,%esp
80100b12:	85 c0                	test   %eax,%eax
80100b14:	79 ad                	jns    80100ac3 <exec+0x1f5>
  ip = 0;
80100b16:	bb 00 00 00 00       	mov    $0x0,%ebx
80100b1b:	e9 6a ff ff ff       	jmp    80100a8a <exec+0x1bc>
  ustack[3+argc] = 0;
80100b20:	89 f1                	mov    %esi,%ecx
80100b22:	89 c3                	mov    %eax,%ebx
80100b24:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100b2b:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100b2f:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100b36:	ff ff ff 
  ustack[1] = argc;
80100b39:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100b3f:	8d 14 bd 04 00 00 00 	lea    0x4(,%edi,4),%edx
80100b46:	89 f0                	mov    %esi,%eax
80100b48:	29 d0                	sub    %edx,%eax
80100b4a:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80100b50:	8d 04 bd 10 00 00 00 	lea    0x10(,%edi,4),%eax
80100b57:	29 c1                	sub    %eax,%ecx
80100b59:	89 ce                	mov    %ecx,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100b5b:	50                   	push   %eax
80100b5c:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
80100b62:	50                   	push   %eax
80100b63:	51                   	push   %ecx
80100b64:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b6a:	e8 8a 5a 00 00       	call   801065f9 <copyout>
80100b6f:	83 c4 10             	add    $0x10,%esp
80100b72:	85 c0                	test   %eax,%eax
80100b74:	0f 88 10 ff ff ff    	js     80100a8a <exec+0x1bc>
  for(last=s=path; *s; s++)
80100b7a:	8b 55 08             	mov    0x8(%ebp),%edx
80100b7d:	89 d0                	mov    %edx,%eax
80100b7f:	eb 03                	jmp    80100b84 <exec+0x2b6>
80100b81:	83 c0 01             	add    $0x1,%eax
80100b84:	0f b6 08             	movzbl (%eax),%ecx
80100b87:	84 c9                	test   %cl,%cl
80100b89:	74 0a                	je     80100b95 <exec+0x2c7>
    if(*s == '/')
80100b8b:	80 f9 2f             	cmp    $0x2f,%cl
80100b8e:	75 f1                	jne    80100b81 <exec+0x2b3>
      last = s+1;
80100b90:	8d 50 01             	lea    0x1(%eax),%edx
80100b93:	eb ec                	jmp    80100b81 <exec+0x2b3>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100b95:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100b9b:	89 f8                	mov    %edi,%eax
80100b9d:	83 c0 6c             	add    $0x6c,%eax
80100ba0:	83 ec 04             	sub    $0x4,%esp
80100ba3:	6a 10                	push   $0x10
80100ba5:	52                   	push   %edx
80100ba6:	50                   	push   %eax
80100ba7:	e8 be 31 00 00       	call   80103d6a <safestrcpy>
  oldpgdir = curproc->pgdir;
80100bac:	8b 5f 04             	mov    0x4(%edi),%ebx
  curproc->pgdir = pgdir;
80100baf:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100bb5:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100bb8:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100bbe:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100bc0:	8b 47 18             	mov    0x18(%edi),%eax
80100bc3:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100bc9:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100bcc:	8b 47 18             	mov    0x18(%edi),%eax
80100bcf:	89 70 44             	mov    %esi,0x44(%eax)
  switchuvm(curproc);
80100bd2:	89 3c 24             	mov    %edi,(%esp)
80100bd5:	e8 f0 53 00 00       	call   80105fca <switchuvm>
  freevm(oldpgdir);
80100bda:	89 1c 24             	mov    %ebx,(%esp)
80100bdd:	e8 cb 57 00 00       	call   801063ad <freevm>
  return 0;
80100be2:	83 c4 10             	add    $0x10,%esp
80100be5:	b8 00 00 00 00       	mov    $0x0,%eax
80100bea:	e9 5b fd ff ff       	jmp    8010094a <exec+0x7c>
  ip = 0;
80100bef:	bb 00 00 00 00       	mov    $0x0,%ebx
80100bf4:	e9 91 fe ff ff       	jmp    80100a8a <exec+0x1bc>
  return -1;
80100bf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bfe:	e9 47 fd ff ff       	jmp    8010094a <exec+0x7c>

80100c03 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100c03:	55                   	push   %ebp
80100c04:	89 e5                	mov    %esp,%ebp
80100c06:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100c09:	68 cd 69 10 80       	push   $0x801069cd
80100c0e:	68 60 ef 10 80       	push   $0x8010ef60
80100c13:	e8 fe 2d 00 00       	call   80103a16 <initlock>
}
80100c18:	83 c4 10             	add    $0x10,%esp
80100c1b:	c9                   	leave  
80100c1c:	c3                   	ret    

80100c1d <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100c1d:	55                   	push   %ebp
80100c1e:	89 e5                	mov    %esp,%ebp
80100c20:	53                   	push   %ebx
80100c21:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100c24:	68 60 ef 10 80       	push   $0x8010ef60
80100c29:	e8 24 2f 00 00       	call   80103b52 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100c2e:	83 c4 10             	add    $0x10,%esp
80100c31:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
80100c36:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100c3c:	73 29                	jae    80100c67 <filealloc+0x4a>
    if(f->ref == 0){
80100c3e:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
80100c42:	74 05                	je     80100c49 <filealloc+0x2c>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100c44:	83 c3 18             	add    $0x18,%ebx
80100c47:	eb ed                	jmp    80100c36 <filealloc+0x19>
      f->ref = 1;
80100c49:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100c50:	83 ec 0c             	sub    $0xc,%esp
80100c53:	68 60 ef 10 80       	push   $0x8010ef60
80100c58:	e8 5a 2f 00 00       	call   80103bb7 <release>
      return f;
80100c5d:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100c60:	89 d8                	mov    %ebx,%eax
80100c62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c65:	c9                   	leave  
80100c66:	c3                   	ret    
  release(&ftable.lock);
80100c67:	83 ec 0c             	sub    $0xc,%esp
80100c6a:	68 60 ef 10 80       	push   $0x8010ef60
80100c6f:	e8 43 2f 00 00       	call   80103bb7 <release>
  return 0;
80100c74:	83 c4 10             	add    $0x10,%esp
80100c77:	bb 00 00 00 00       	mov    $0x0,%ebx
80100c7c:	eb e2                	jmp    80100c60 <filealloc+0x43>

80100c7e <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100c7e:	55                   	push   %ebp
80100c7f:	89 e5                	mov    %esp,%ebp
80100c81:	53                   	push   %ebx
80100c82:	83 ec 10             	sub    $0x10,%esp
80100c85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100c88:	68 60 ef 10 80       	push   $0x8010ef60
80100c8d:	e8 c0 2e 00 00       	call   80103b52 <acquire>
  if(f->ref < 1)
80100c92:	8b 43 04             	mov    0x4(%ebx),%eax
80100c95:	83 c4 10             	add    $0x10,%esp
80100c98:	85 c0                	test   %eax,%eax
80100c9a:	7e 1a                	jle    80100cb6 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100c9c:	83 c0 01             	add    $0x1,%eax
80100c9f:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ca2:	83 ec 0c             	sub    $0xc,%esp
80100ca5:	68 60 ef 10 80       	push   $0x8010ef60
80100caa:	e8 08 2f 00 00       	call   80103bb7 <release>
  return f;
}
80100caf:	89 d8                	mov    %ebx,%eax
80100cb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100cb4:	c9                   	leave  
80100cb5:	c3                   	ret    
    panic("filedup");
80100cb6:	83 ec 0c             	sub    $0xc,%esp
80100cb9:	68 d4 69 10 80       	push   $0x801069d4
80100cbe:	e8 85 f6 ff ff       	call   80100348 <panic>

80100cc3 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100cc3:	55                   	push   %ebp
80100cc4:	89 e5                	mov    %esp,%ebp
80100cc6:	53                   	push   %ebx
80100cc7:	83 ec 30             	sub    $0x30,%esp
80100cca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ccd:	68 60 ef 10 80       	push   $0x8010ef60
80100cd2:	e8 7b 2e 00 00       	call   80103b52 <acquire>
  if(f->ref < 1)
80100cd7:	8b 43 04             	mov    0x4(%ebx),%eax
80100cda:	83 c4 10             	add    $0x10,%esp
80100cdd:	85 c0                	test   %eax,%eax
80100cdf:	7e 71                	jle    80100d52 <fileclose+0x8f>
    panic("fileclose");
  if(--f->ref > 0){
80100ce1:	83 e8 01             	sub    $0x1,%eax
80100ce4:	89 43 04             	mov    %eax,0x4(%ebx)
80100ce7:	85 c0                	test   %eax,%eax
80100ce9:	7f 74                	jg     80100d5f <fileclose+0x9c>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ceb:	8b 03                	mov    (%ebx),%eax
80100ced:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cf0:	8b 43 04             	mov    0x4(%ebx),%eax
80100cf3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100cf6:	8b 43 08             	mov    0x8(%ebx),%eax
80100cf9:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100cfc:	8b 43 0c             	mov    0xc(%ebx),%eax
80100cff:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100d02:	8b 43 10             	mov    0x10(%ebx),%eax
80100d05:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100d08:	8b 43 14             	mov    0x14(%ebx),%eax
80100d0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80100d0e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
80100d15:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
80100d1b:	83 ec 0c             	sub    $0xc,%esp
80100d1e:	68 60 ef 10 80       	push   $0x8010ef60
80100d23:	e8 8f 2e 00 00       	call   80103bb7 <release>

  if(ff.type == FD_PIPE)
80100d28:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d2b:	83 c4 10             	add    $0x10,%esp
80100d2e:	83 f8 01             	cmp    $0x1,%eax
80100d31:	74 41                	je     80100d74 <fileclose+0xb1>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100d33:	83 f8 02             	cmp    $0x2,%eax
80100d36:	75 37                	jne    80100d6f <fileclose+0xac>
    begin_op();
80100d38:	e8 41 1a 00 00       	call   8010277e <begin_op>
    iput(ff.ip);
80100d3d:	83 ec 0c             	sub    $0xc,%esp
80100d40:	ff 75 f0             	push   -0x10(%ebp)
80100d43:	e8 2e 09 00 00       	call   80101676 <iput>
    end_op();
80100d48:	e8 ab 1a 00 00       	call   801027f8 <end_op>
80100d4d:	83 c4 10             	add    $0x10,%esp
80100d50:	eb 1d                	jmp    80100d6f <fileclose+0xac>
    panic("fileclose");
80100d52:	83 ec 0c             	sub    $0xc,%esp
80100d55:	68 dc 69 10 80       	push   $0x801069dc
80100d5a:	e8 e9 f5 ff ff       	call   80100348 <panic>
    release(&ftable.lock);
80100d5f:	83 ec 0c             	sub    $0xc,%esp
80100d62:	68 60 ef 10 80       	push   $0x8010ef60
80100d67:	e8 4b 2e 00 00       	call   80103bb7 <release>
    return;
80100d6c:	83 c4 10             	add    $0x10,%esp
  }
}
80100d6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d72:	c9                   	leave  
80100d73:	c3                   	ret    
    pipeclose(ff.pipe, ff.writable);
80100d74:	83 ec 08             	sub    $0x8,%esp
80100d77:	0f be 45 e9          	movsbl -0x17(%ebp),%eax
80100d7b:	50                   	push   %eax
80100d7c:	ff 75 ec             	push   -0x14(%ebp)
80100d7f:	e8 6d 20 00 00       	call   80102df1 <pipeclose>
80100d84:	83 c4 10             	add    $0x10,%esp
80100d87:	eb e6                	jmp    80100d6f <fileclose+0xac>

80100d89 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100d89:	55                   	push   %ebp
80100d8a:	89 e5                	mov    %esp,%ebp
80100d8c:	53                   	push   %ebx
80100d8d:	83 ec 04             	sub    $0x4,%esp
80100d90:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100d93:	83 3b 02             	cmpl   $0x2,(%ebx)
80100d96:	75 31                	jne    80100dc9 <filestat+0x40>
    ilock(f->ip);
80100d98:	83 ec 0c             	sub    $0xc,%esp
80100d9b:	ff 73 10             	push   0x10(%ebx)
80100d9e:	e8 cc 07 00 00       	call   8010156f <ilock>
    stati(f->ip, st);
80100da3:	83 c4 08             	add    $0x8,%esp
80100da6:	ff 75 0c             	push   0xc(%ebp)
80100da9:	ff 73 10             	push   0x10(%ebx)
80100dac:	e8 85 09 00 00       	call   80101736 <stati>
    iunlock(f->ip);
80100db1:	83 c4 04             	add    $0x4,%esp
80100db4:	ff 73 10             	push   0x10(%ebx)
80100db7:	e8 75 08 00 00       	call   80101631 <iunlock>
    return 0;
80100dbc:	83 c4 10             	add    $0x10,%esp
80100dbf:	b8 00 00 00 00       	mov    $0x0,%eax
  }
  return -1;
}
80100dc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc7:	c9                   	leave  
80100dc8:	c3                   	ret    
  return -1;
80100dc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dce:	eb f4                	jmp    80100dc4 <filestat+0x3b>

80100dd0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	56                   	push   %esi
80100dd4:	53                   	push   %ebx
80100dd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;

  if(f->readable == 0)
80100dd8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100ddc:	74 70                	je     80100e4e <fileread+0x7e>
    return -1;
  if(f->type == FD_PIPE)
80100dde:	8b 03                	mov    (%ebx),%eax
80100de0:	83 f8 01             	cmp    $0x1,%eax
80100de3:	74 44                	je     80100e29 <fileread+0x59>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100de5:	83 f8 02             	cmp    $0x2,%eax
80100de8:	75 57                	jne    80100e41 <fileread+0x71>
    ilock(f->ip);
80100dea:	83 ec 0c             	sub    $0xc,%esp
80100ded:	ff 73 10             	push   0x10(%ebx)
80100df0:	e8 7a 07 00 00       	call   8010156f <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100df5:	ff 75 10             	push   0x10(%ebp)
80100df8:	ff 73 14             	push   0x14(%ebx)
80100dfb:	ff 75 0c             	push   0xc(%ebp)
80100dfe:	ff 73 10             	push   0x10(%ebx)
80100e01:	e8 5b 09 00 00       	call   80101761 <readi>
80100e06:	89 c6                	mov    %eax,%esi
80100e08:	83 c4 20             	add    $0x20,%esp
80100e0b:	85 c0                	test   %eax,%eax
80100e0d:	7e 03                	jle    80100e12 <fileread+0x42>
      f->off += r;
80100e0f:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100e12:	83 ec 0c             	sub    $0xc,%esp
80100e15:	ff 73 10             	push   0x10(%ebx)
80100e18:	e8 14 08 00 00       	call   80101631 <iunlock>
    return r;
80100e1d:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100e20:	89 f0                	mov    %esi,%eax
80100e22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100e25:	5b                   	pop    %ebx
80100e26:	5e                   	pop    %esi
80100e27:	5d                   	pop    %ebp
80100e28:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100e29:	83 ec 04             	sub    $0x4,%esp
80100e2c:	ff 75 10             	push   0x10(%ebp)
80100e2f:	ff 75 0c             	push   0xc(%ebp)
80100e32:	ff 73 0c             	push   0xc(%ebx)
80100e35:	e8 08 21 00 00       	call   80102f42 <piperead>
80100e3a:	89 c6                	mov    %eax,%esi
80100e3c:	83 c4 10             	add    $0x10,%esp
80100e3f:	eb df                	jmp    80100e20 <fileread+0x50>
  panic("fileread");
80100e41:	83 ec 0c             	sub    $0xc,%esp
80100e44:	68 e6 69 10 80       	push   $0x801069e6
80100e49:	e8 fa f4 ff ff       	call   80100348 <panic>
    return -1;
80100e4e:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100e53:	eb cb                	jmp    80100e20 <fileread+0x50>

80100e55 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100e55:	55                   	push   %ebp
80100e56:	89 e5                	mov    %esp,%ebp
80100e58:	57                   	push   %edi
80100e59:	56                   	push   %esi
80100e5a:	53                   	push   %ebx
80100e5b:	83 ec 1c             	sub    $0x1c,%esp
80100e5e:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;

  if(f->writable == 0)
80100e61:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
80100e65:	0f 84 d0 00 00 00    	je     80100f3b <filewrite+0xe6>
    return -1;
  if(f->type == FD_PIPE)
80100e6b:	8b 06                	mov    (%esi),%eax
80100e6d:	83 f8 01             	cmp    $0x1,%eax
80100e70:	74 12                	je     80100e84 <filewrite+0x2f>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e72:	83 f8 02             	cmp    $0x2,%eax
80100e75:	0f 85 b3 00 00 00    	jne    80100f2e <filewrite+0xd9>
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
80100e7b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100e82:	eb 66                	jmp    80100eea <filewrite+0x95>
    return pipewrite(f->pipe, addr, n);
80100e84:	83 ec 04             	sub    $0x4,%esp
80100e87:	ff 75 10             	push   0x10(%ebp)
80100e8a:	ff 75 0c             	push   0xc(%ebp)
80100e8d:	ff 76 0c             	push   0xc(%esi)
80100e90:	e8 e8 1f 00 00       	call   80102e7d <pipewrite>
80100e95:	83 c4 10             	add    $0x10,%esp
80100e98:	e9 84 00 00 00       	jmp    80100f21 <filewrite+0xcc>
    while(i < n){
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
80100e9d:	e8 dc 18 00 00       	call   8010277e <begin_op>
      ilock(f->ip);
80100ea2:	83 ec 0c             	sub    $0xc,%esp
80100ea5:	ff 76 10             	push   0x10(%esi)
80100ea8:	e8 c2 06 00 00       	call   8010156f <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100ead:	57                   	push   %edi
80100eae:	ff 76 14             	push   0x14(%esi)
80100eb1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eb4:	03 45 0c             	add    0xc(%ebp),%eax
80100eb7:	50                   	push   %eax
80100eb8:	ff 76 10             	push   0x10(%esi)
80100ebb:	e8 9e 09 00 00       	call   8010185e <writei>
80100ec0:	89 c3                	mov    %eax,%ebx
80100ec2:	83 c4 20             	add    $0x20,%esp
80100ec5:	85 c0                	test   %eax,%eax
80100ec7:	7e 03                	jle    80100ecc <filewrite+0x77>
        f->off += r;
80100ec9:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80100ecc:	83 ec 0c             	sub    $0xc,%esp
80100ecf:	ff 76 10             	push   0x10(%esi)
80100ed2:	e8 5a 07 00 00       	call   80101631 <iunlock>
      end_op();
80100ed7:	e8 1c 19 00 00       	call   801027f8 <end_op>

      if(r < 0)
80100edc:	83 c4 10             	add    $0x10,%esp
80100edf:	85 db                	test   %ebx,%ebx
80100ee1:	78 31                	js     80100f14 <filewrite+0xbf>
        break;
      if(r != n1)
80100ee3:	39 df                	cmp    %ebx,%edi
80100ee5:	75 20                	jne    80100f07 <filewrite+0xb2>
        panic("short filewrite");
      i += r;
80100ee7:	01 5d e4             	add    %ebx,-0x1c(%ebp)
    while(i < n){
80100eea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eed:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ef0:	7d 22                	jge    80100f14 <filewrite+0xbf>
      int n1 = n - i;
80100ef2:	8b 7d 10             	mov    0x10(%ebp),%edi
80100ef5:	2b 7d e4             	sub    -0x1c(%ebp),%edi
      if(n1 > max)
80100ef8:	81 ff 00 06 00 00    	cmp    $0x600,%edi
80100efe:	7e 9d                	jle    80100e9d <filewrite+0x48>
        n1 = max;
80100f00:	bf 00 06 00 00       	mov    $0x600,%edi
80100f05:	eb 96                	jmp    80100e9d <filewrite+0x48>
        panic("short filewrite");
80100f07:	83 ec 0c             	sub    $0xc,%esp
80100f0a:	68 ef 69 10 80       	push   $0x801069ef
80100f0f:	e8 34 f4 ff ff       	call   80100348 <panic>
    }
    return i == n ? n : -1;
80100f14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f17:	3b 45 10             	cmp    0x10(%ebp),%eax
80100f1a:	74 0d                	je     80100f29 <filewrite+0xd4>
80100f1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80100f21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f24:	5b                   	pop    %ebx
80100f25:	5e                   	pop    %esi
80100f26:	5f                   	pop    %edi
80100f27:	5d                   	pop    %ebp
80100f28:	c3                   	ret    
    return i == n ? n : -1;
80100f29:	8b 45 10             	mov    0x10(%ebp),%eax
80100f2c:	eb f3                	jmp    80100f21 <filewrite+0xcc>
  panic("filewrite");
80100f2e:	83 ec 0c             	sub    $0xc,%esp
80100f31:	68 f5 69 10 80       	push   $0x801069f5
80100f36:	e8 0d f4 ff ff       	call   80100348 <panic>
    return -1;
80100f3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f40:	eb df                	jmp    80100f21 <filewrite+0xcc>

80100f42 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80100f42:	55                   	push   %ebp
80100f43:	89 e5                	mov    %esp,%ebp
80100f45:	57                   	push   %edi
80100f46:	56                   	push   %esi
80100f47:	53                   	push   %ebx
80100f48:	83 ec 0c             	sub    $0xc,%esp
80100f4b:	89 d6                	mov    %edx,%esi
  char *s;
  int len;

  while(*path == '/')
80100f4d:	eb 03                	jmp    80100f52 <skipelem+0x10>
    path++;
80100f4f:	83 c0 01             	add    $0x1,%eax
  while(*path == '/')
80100f52:	0f b6 10             	movzbl (%eax),%edx
80100f55:	80 fa 2f             	cmp    $0x2f,%dl
80100f58:	74 f5                	je     80100f4f <skipelem+0xd>
  if(*path == 0)
80100f5a:	84 d2                	test   %dl,%dl
80100f5c:	74 53                	je     80100fb1 <skipelem+0x6f>
80100f5e:	89 c3                	mov    %eax,%ebx
80100f60:	eb 03                	jmp    80100f65 <skipelem+0x23>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80100f62:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80100f65:	0f b6 13             	movzbl (%ebx),%edx
80100f68:	80 fa 2f             	cmp    $0x2f,%dl
80100f6b:	74 04                	je     80100f71 <skipelem+0x2f>
80100f6d:	84 d2                	test   %dl,%dl
80100f6f:	75 f1                	jne    80100f62 <skipelem+0x20>
  len = path - s;
80100f71:	89 df                	mov    %ebx,%edi
80100f73:	29 c7                	sub    %eax,%edi
  if(len >= DIRSIZ)
80100f75:	83 ff 0d             	cmp    $0xd,%edi
80100f78:	7e 11                	jle    80100f8b <skipelem+0x49>
    memmove(name, s, DIRSIZ);
80100f7a:	83 ec 04             	sub    $0x4,%esp
80100f7d:	6a 0e                	push   $0xe
80100f7f:	50                   	push   %eax
80100f80:	56                   	push   %esi
80100f81:	e8 f0 2c 00 00       	call   80103c76 <memmove>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	eb 17                	jmp    80100fa2 <skipelem+0x60>
  else {
    memmove(name, s, len);
80100f8b:	83 ec 04             	sub    $0x4,%esp
80100f8e:	57                   	push   %edi
80100f8f:	50                   	push   %eax
80100f90:	56                   	push   %esi
80100f91:	e8 e0 2c 00 00       	call   80103c76 <memmove>
    name[len] = 0;
80100f96:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
80100f9a:	83 c4 10             	add    $0x10,%esp
80100f9d:	eb 03                	jmp    80100fa2 <skipelem+0x60>
  }
  while(*path == '/')
    path++;
80100f9f:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80100fa2:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80100fa5:	74 f8                	je     80100f9f <skipelem+0x5d>
  return path;
}
80100fa7:	89 d8                	mov    %ebx,%eax
80100fa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fac:	5b                   	pop    %ebx
80100fad:	5e                   	pop    %esi
80100fae:	5f                   	pop    %edi
80100faf:	5d                   	pop    %ebp
80100fb0:	c3                   	ret    
    return 0;
80100fb1:	bb 00 00 00 00       	mov    $0x0,%ebx
80100fb6:	eb ef                	jmp    80100fa7 <skipelem+0x65>

80100fb8 <bzero>:
{
80100fb8:	55                   	push   %ebp
80100fb9:	89 e5                	mov    %esp,%ebp
80100fbb:	53                   	push   %ebx
80100fbc:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, bno);
80100fbf:	52                   	push   %edx
80100fc0:	50                   	push   %eax
80100fc1:	e8 a6 f1 ff ff       	call   8010016c <bread>
80100fc6:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80100fc8:	8d 40 5c             	lea    0x5c(%eax),%eax
80100fcb:	83 c4 0c             	add    $0xc,%esp
80100fce:	68 00 02 00 00       	push   $0x200
80100fd3:	6a 00                	push   $0x0
80100fd5:	50                   	push   %eax
80100fd6:	e8 23 2c 00 00       	call   80103bfe <memset>
  log_write(bp);
80100fdb:	89 1c 24             	mov    %ebx,(%esp)
80100fde:	e8 c4 18 00 00       	call   801028a7 <log_write>
  brelse(bp);
80100fe3:	89 1c 24             	mov    %ebx,(%esp)
80100fe6:	e8 ea f1 ff ff       	call   801001d5 <brelse>
}
80100feb:	83 c4 10             	add    $0x10,%esp
80100fee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ff1:	c9                   	leave  
80100ff2:	c3                   	ret    

80100ff3 <bfree>:
{
80100ff3:	55                   	push   %ebp
80100ff4:	89 e5                	mov    %esp,%ebp
80100ff6:	56                   	push   %esi
80100ff7:	53                   	push   %ebx
80100ff8:	89 c3                	mov    %eax,%ebx
80100ffa:	89 d6                	mov    %edx,%esi
  bp = bread(dev, BBLOCK(b, sb));
80100ffc:	89 d0                	mov    %edx,%eax
80100ffe:	c1 e8 0c             	shr    $0xc,%eax
80101001:	83 ec 08             	sub    $0x8,%esp
80101004:	03 05 cc 15 11 80    	add    0x801115cc,%eax
8010100a:	50                   	push   %eax
8010100b:	53                   	push   %ebx
8010100c:	e8 5b f1 ff ff       	call   8010016c <bread>
80101011:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
80101013:	89 f2                	mov    %esi,%edx
80101015:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
8010101b:	89 f1                	mov    %esi,%ecx
8010101d:	83 e1 07             	and    $0x7,%ecx
80101020:	b8 01 00 00 00       	mov    $0x1,%eax
80101025:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101027:	83 c4 10             	add    $0x10,%esp
8010102a:	c1 fa 03             	sar    $0x3,%edx
8010102d:	0f b6 4c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ecx
80101032:	0f b6 f1             	movzbl %cl,%esi
80101035:	85 c6                	test   %eax,%esi
80101037:	74 23                	je     8010105c <bfree+0x69>
  bp->data[bi/8] &= ~m;
80101039:	f7 d0                	not    %eax
8010103b:	21 c8                	and    %ecx,%eax
8010103d:	88 44 13 5c          	mov    %al,0x5c(%ebx,%edx,1)
  log_write(bp);
80101041:	83 ec 0c             	sub    $0xc,%esp
80101044:	53                   	push   %ebx
80101045:	e8 5d 18 00 00       	call   801028a7 <log_write>
  brelse(bp);
8010104a:	89 1c 24             	mov    %ebx,(%esp)
8010104d:	e8 83 f1 ff ff       	call   801001d5 <brelse>
}
80101052:	83 c4 10             	add    $0x10,%esp
80101055:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101058:	5b                   	pop    %ebx
80101059:	5e                   	pop    %esi
8010105a:	5d                   	pop    %ebp
8010105b:	c3                   	ret    
    panic("freeing free block");
8010105c:	83 ec 0c             	sub    $0xc,%esp
8010105f:	68 ff 69 10 80       	push   $0x801069ff
80101064:	e8 df f2 ff ff       	call   80100348 <panic>

80101069 <balloc>:
{
80101069:	55                   	push   %ebp
8010106a:	89 e5                	mov    %esp,%ebp
8010106c:	57                   	push   %edi
8010106d:	56                   	push   %esi
8010106e:	53                   	push   %ebx
8010106f:	83 ec 1c             	sub    $0x1c,%esp
80101072:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101075:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010107c:	eb 15                	jmp    80101093 <balloc+0x2a>
    brelse(bp);
8010107e:	83 ec 0c             	sub    $0xc,%esp
80101081:	ff 75 e0             	push   -0x20(%ebp)
80101084:	e8 4c f1 ff ff       	call   801001d5 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101089:	81 45 e4 00 10 00 00 	addl   $0x1000,-0x1c(%ebp)
80101090:	83 c4 10             	add    $0x10,%esp
80101093:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101096:	39 05 b4 15 11 80    	cmp    %eax,0x801115b4
8010109c:	76 75                	jbe    80101113 <balloc+0xaa>
    bp = bread(dev, BBLOCK(b, sb));
8010109e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010a1:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
801010a7:	85 db                	test   %ebx,%ebx
801010a9:	0f 49 c3             	cmovns %ebx,%eax
801010ac:	c1 f8 0c             	sar    $0xc,%eax
801010af:	83 ec 08             	sub    $0x8,%esp
801010b2:	03 05 cc 15 11 80    	add    0x801115cc,%eax
801010b8:	50                   	push   %eax
801010b9:	ff 75 d8             	push   -0x28(%ebp)
801010bc:	e8 ab f0 ff ff       	call   8010016c <bread>
801010c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801010c4:	83 c4 10             	add    $0x10,%esp
801010c7:	b8 00 00 00 00       	mov    $0x0,%eax
801010cc:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801010d1:	7f ab                	jg     8010107e <balloc+0x15>
801010d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801010d6:	8d 1c 07             	lea    (%edi,%eax,1),%ebx
801010d9:	3b 1d b4 15 11 80    	cmp    0x801115b4,%ebx
801010df:	73 9d                	jae    8010107e <balloc+0x15>
      m = 1 << (bi % 8);
801010e1:	89 c1                	mov    %eax,%ecx
801010e3:	83 e1 07             	and    $0x7,%ecx
801010e6:	ba 01 00 00 00       	mov    $0x1,%edx
801010eb:	d3 e2                	shl    %cl,%edx
801010ed:	89 d1                	mov    %edx,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801010ef:	8d 50 07             	lea    0x7(%eax),%edx
801010f2:	85 c0                	test   %eax,%eax
801010f4:	0f 49 d0             	cmovns %eax,%edx
801010f7:	c1 fa 03             	sar    $0x3,%edx
801010fa:	89 55 dc             	mov    %edx,-0x24(%ebp)
801010fd:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101100:	0f b6 74 16 5c       	movzbl 0x5c(%esi,%edx,1),%esi
80101105:	89 f2                	mov    %esi,%edx
80101107:	0f b6 fa             	movzbl %dl,%edi
8010110a:	85 cf                	test   %ecx,%edi
8010110c:	74 12                	je     80101120 <balloc+0xb7>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010110e:	83 c0 01             	add    $0x1,%eax
80101111:	eb b9                	jmp    801010cc <balloc+0x63>
  panic("balloc: out of blocks");
80101113:	83 ec 0c             	sub    $0xc,%esp
80101116:	68 12 6a 10 80       	push   $0x80106a12
8010111b:	e8 28 f2 ff ff       	call   80100348 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
80101120:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101123:	09 f1                	or     %esi,%ecx
80101125:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101128:	88 4c 17 5c          	mov    %cl,0x5c(%edi,%edx,1)
        log_write(bp);
8010112c:	83 ec 0c             	sub    $0xc,%esp
8010112f:	57                   	push   %edi
80101130:	e8 72 17 00 00       	call   801028a7 <log_write>
        brelse(bp);
80101135:	89 3c 24             	mov    %edi,(%esp)
80101138:	e8 98 f0 ff ff       	call   801001d5 <brelse>
        bzero(dev, b + bi);
8010113d:	89 da                	mov    %ebx,%edx
8010113f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101142:	e8 71 fe ff ff       	call   80100fb8 <bzero>
}
80101147:	89 d8                	mov    %ebx,%eax
80101149:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010114c:	5b                   	pop    %ebx
8010114d:	5e                   	pop    %esi
8010114e:	5f                   	pop    %edi
8010114f:	5d                   	pop    %ebp
80101150:	c3                   	ret    

80101151 <bmap>:
{
80101151:	55                   	push   %ebp
80101152:	89 e5                	mov    %esp,%ebp
80101154:	57                   	push   %edi
80101155:	56                   	push   %esi
80101156:	53                   	push   %ebx
80101157:	83 ec 1c             	sub    $0x1c,%esp
8010115a:	89 c3                	mov    %eax,%ebx
8010115c:	89 d7                	mov    %edx,%edi
  if(bn < NDIRECT){
8010115e:	83 fa 0b             	cmp    $0xb,%edx
80101161:	76 45                	jbe    801011a8 <bmap+0x57>
  bn -= NDIRECT;
80101163:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
80101166:	83 fe 7f             	cmp    $0x7f,%esi
80101169:	77 7f                	ja     801011ea <bmap+0x99>
    if((addr = ip->addrs[NDIRECT]) == 0)
8010116b:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101171:	85 c0                	test   %eax,%eax
80101173:	74 4a                	je     801011bf <bmap+0x6e>
    bp = bread(ip->dev, addr);
80101175:	83 ec 08             	sub    $0x8,%esp
80101178:	50                   	push   %eax
80101179:	ff 33                	push   (%ebx)
8010117b:	e8 ec ef ff ff       	call   8010016c <bread>
80101180:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101182:	8d 44 b0 5c          	lea    0x5c(%eax,%esi,4),%eax
80101186:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101189:	8b 30                	mov    (%eax),%esi
8010118b:	83 c4 10             	add    $0x10,%esp
8010118e:	85 f6                	test   %esi,%esi
80101190:	74 3c                	je     801011ce <bmap+0x7d>
    brelse(bp);
80101192:	83 ec 0c             	sub    $0xc,%esp
80101195:	57                   	push   %edi
80101196:	e8 3a f0 ff ff       	call   801001d5 <brelse>
    return addr;
8010119b:	83 c4 10             	add    $0x10,%esp
}
8010119e:	89 f0                	mov    %esi,%eax
801011a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a3:	5b                   	pop    %ebx
801011a4:	5e                   	pop    %esi
801011a5:	5f                   	pop    %edi
801011a6:	5d                   	pop    %ebp
801011a7:	c3                   	ret    
    if((addr = ip->addrs[bn]) == 0)
801011a8:	8b 74 90 5c          	mov    0x5c(%eax,%edx,4),%esi
801011ac:	85 f6                	test   %esi,%esi
801011ae:	75 ee                	jne    8010119e <bmap+0x4d>
      ip->addrs[bn] = addr = balloc(ip->dev);
801011b0:	8b 00                	mov    (%eax),%eax
801011b2:	e8 b2 fe ff ff       	call   80101069 <balloc>
801011b7:	89 c6                	mov    %eax,%esi
801011b9:	89 44 bb 5c          	mov    %eax,0x5c(%ebx,%edi,4)
    return addr;
801011bd:	eb df                	jmp    8010119e <bmap+0x4d>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801011bf:	8b 03                	mov    (%ebx),%eax
801011c1:	e8 a3 fe ff ff       	call   80101069 <balloc>
801011c6:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801011cc:	eb a7                	jmp    80101175 <bmap+0x24>
      a[bn] = addr = balloc(ip->dev);
801011ce:	8b 03                	mov    (%ebx),%eax
801011d0:	e8 94 fe ff ff       	call   80101069 <balloc>
801011d5:	89 c6                	mov    %eax,%esi
801011d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011da:	89 30                	mov    %esi,(%eax)
      log_write(bp);
801011dc:	83 ec 0c             	sub    $0xc,%esp
801011df:	57                   	push   %edi
801011e0:	e8 c2 16 00 00       	call   801028a7 <log_write>
801011e5:	83 c4 10             	add    $0x10,%esp
801011e8:	eb a8                	jmp    80101192 <bmap+0x41>
  panic("bmap: out of range");
801011ea:	83 ec 0c             	sub    $0xc,%esp
801011ed:	68 28 6a 10 80       	push   $0x80106a28
801011f2:	e8 51 f1 ff ff       	call   80100348 <panic>

801011f7 <iget>:
{
801011f7:	55                   	push   %ebp
801011f8:	89 e5                	mov    %esp,%ebp
801011fa:	57                   	push   %edi
801011fb:	56                   	push   %esi
801011fc:	53                   	push   %ebx
801011fd:	83 ec 28             	sub    $0x28,%esp
80101200:	89 c7                	mov    %eax,%edi
80101202:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101205:	68 60 f9 10 80       	push   $0x8010f960
8010120a:	e8 43 29 00 00       	call   80103b52 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010120f:	83 c4 10             	add    $0x10,%esp
  empty = 0;
80101212:	be 00 00 00 00       	mov    $0x0,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101217:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
8010121c:	eb 0a                	jmp    80101228 <iget+0x31>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010121e:	85 f6                	test   %esi,%esi
80101220:	74 3b                	je     8010125d <iget+0x66>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101222:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101228:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
8010122e:	73 35                	jae    80101265 <iget+0x6e>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101230:	8b 43 08             	mov    0x8(%ebx),%eax
80101233:	85 c0                	test   %eax,%eax
80101235:	7e e7                	jle    8010121e <iget+0x27>
80101237:	39 3b                	cmp    %edi,(%ebx)
80101239:	75 e3                	jne    8010121e <iget+0x27>
8010123b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010123e:	39 4b 04             	cmp    %ecx,0x4(%ebx)
80101241:	75 db                	jne    8010121e <iget+0x27>
      ip->ref++;
80101243:	83 c0 01             	add    $0x1,%eax
80101246:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101249:	83 ec 0c             	sub    $0xc,%esp
8010124c:	68 60 f9 10 80       	push   $0x8010f960
80101251:	e8 61 29 00 00       	call   80103bb7 <release>
      return ip;
80101256:	83 c4 10             	add    $0x10,%esp
80101259:	89 de                	mov    %ebx,%esi
8010125b:	eb 32                	jmp    8010128f <iget+0x98>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010125d:	85 c0                	test   %eax,%eax
8010125f:	75 c1                	jne    80101222 <iget+0x2b>
      empty = ip;
80101261:	89 de                	mov    %ebx,%esi
80101263:	eb bd                	jmp    80101222 <iget+0x2b>
  if(empty == 0)
80101265:	85 f6                	test   %esi,%esi
80101267:	74 30                	je     80101299 <iget+0xa2>
  ip->dev = dev;
80101269:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
8010126b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010126e:	89 46 04             	mov    %eax,0x4(%esi)
  ip->ref = 1;
80101271:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101278:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010127f:	83 ec 0c             	sub    $0xc,%esp
80101282:	68 60 f9 10 80       	push   $0x8010f960
80101287:	e8 2b 29 00 00       	call   80103bb7 <release>
  return ip;
8010128c:	83 c4 10             	add    $0x10,%esp
}
8010128f:	89 f0                	mov    %esi,%eax
80101291:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101294:	5b                   	pop    %ebx
80101295:	5e                   	pop    %esi
80101296:	5f                   	pop    %edi
80101297:	5d                   	pop    %ebp
80101298:	c3                   	ret    
    panic("iget: no inodes");
80101299:	83 ec 0c             	sub    $0xc,%esp
8010129c:	68 3b 6a 10 80       	push   $0x80106a3b
801012a1:	e8 a2 f0 ff ff       	call   80100348 <panic>

801012a6 <readsb>:
{
801012a6:	55                   	push   %ebp
801012a7:	89 e5                	mov    %esp,%ebp
801012a9:	53                   	push   %ebx
801012aa:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, 1);
801012ad:	6a 01                	push   $0x1
801012af:	ff 75 08             	push   0x8(%ebp)
801012b2:	e8 b5 ee ff ff       	call   8010016c <bread>
801012b7:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801012b9:	8d 40 5c             	lea    0x5c(%eax),%eax
801012bc:	83 c4 0c             	add    $0xc,%esp
801012bf:	6a 1c                	push   $0x1c
801012c1:	50                   	push   %eax
801012c2:	ff 75 0c             	push   0xc(%ebp)
801012c5:	e8 ac 29 00 00       	call   80103c76 <memmove>
  brelse(bp);
801012ca:	89 1c 24             	mov    %ebx,(%esp)
801012cd:	e8 03 ef ff ff       	call   801001d5 <brelse>
}
801012d2:	83 c4 10             	add    $0x10,%esp
801012d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801012d8:	c9                   	leave  
801012d9:	c3                   	ret    

801012da <iinit>:
{
801012da:	55                   	push   %ebp
801012db:	89 e5                	mov    %esp,%ebp
801012dd:	53                   	push   %ebx
801012de:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801012e1:	68 4b 6a 10 80       	push   $0x80106a4b
801012e6:	68 60 f9 10 80       	push   $0x8010f960
801012eb:	e8 26 27 00 00       	call   80103a16 <initlock>
  for(i = 0; i < NINODE; i++) {
801012f0:	83 c4 10             	add    $0x10,%esp
801012f3:	bb 00 00 00 00       	mov    $0x0,%ebx
801012f8:	eb 21                	jmp    8010131b <iinit+0x41>
    initsleeplock(&icache.inode[i].lock, "inode");
801012fa:	83 ec 08             	sub    $0x8,%esp
801012fd:	68 52 6a 10 80       	push   $0x80106a52
80101302:	8d 14 db             	lea    (%ebx,%ebx,8),%edx
80101305:	89 d0                	mov    %edx,%eax
80101307:	c1 e0 04             	shl    $0x4,%eax
8010130a:	05 a0 f9 10 80       	add    $0x8010f9a0,%eax
8010130f:	50                   	push   %eax
80101310:	e8 f6 25 00 00       	call   8010390b <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101315:	83 c3 01             	add    $0x1,%ebx
80101318:	83 c4 10             	add    $0x10,%esp
8010131b:	83 fb 31             	cmp    $0x31,%ebx
8010131e:	7e da                	jle    801012fa <iinit+0x20>
  readsb(dev, &sb);
80101320:	83 ec 08             	sub    $0x8,%esp
80101323:	68 b4 15 11 80       	push   $0x801115b4
80101328:	ff 75 08             	push   0x8(%ebp)
8010132b:	e8 76 ff ff ff       	call   801012a6 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101330:	ff 35 cc 15 11 80    	push   0x801115cc
80101336:	ff 35 c8 15 11 80    	push   0x801115c8
8010133c:	ff 35 c4 15 11 80    	push   0x801115c4
80101342:	ff 35 c0 15 11 80    	push   0x801115c0
80101348:	ff 35 bc 15 11 80    	push   0x801115bc
8010134e:	ff 35 b8 15 11 80    	push   0x801115b8
80101354:	ff 35 b4 15 11 80    	push   0x801115b4
8010135a:	68 b8 6a 10 80       	push   $0x80106ab8
8010135f:	e8 a3 f2 ff ff       	call   80100607 <cprintf>
}
80101364:	83 c4 30             	add    $0x30,%esp
80101367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010136a:	c9                   	leave  
8010136b:	c3                   	ret    

8010136c <ialloc>:
{
8010136c:	55                   	push   %ebp
8010136d:	89 e5                	mov    %esp,%ebp
8010136f:	57                   	push   %edi
80101370:	56                   	push   %esi
80101371:	53                   	push   %ebx
80101372:	83 ec 1c             	sub    $0x1c,%esp
80101375:	8b 45 0c             	mov    0xc(%ebp),%eax
80101378:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010137b:	bb 01 00 00 00       	mov    $0x1,%ebx
80101380:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101383:	39 1d bc 15 11 80    	cmp    %ebx,0x801115bc
80101389:	76 3f                	jbe    801013ca <ialloc+0x5e>
    bp = bread(dev, IBLOCK(inum, sb));
8010138b:	89 d8                	mov    %ebx,%eax
8010138d:	c1 e8 03             	shr    $0x3,%eax
80101390:	83 ec 08             	sub    $0x8,%esp
80101393:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101399:	50                   	push   %eax
8010139a:	ff 75 08             	push   0x8(%ebp)
8010139d:	e8 ca ed ff ff       	call   8010016c <bread>
801013a2:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
801013a4:	89 d8                	mov    %ebx,%eax
801013a6:	83 e0 07             	and    $0x7,%eax
801013a9:	c1 e0 06             	shl    $0x6,%eax
801013ac:	8d 7c 06 5c          	lea    0x5c(%esi,%eax,1),%edi
    if(dip->type == 0){  // a free inode
801013b0:	83 c4 10             	add    $0x10,%esp
801013b3:	66 83 3f 00          	cmpw   $0x0,(%edi)
801013b7:	74 1e                	je     801013d7 <ialloc+0x6b>
    brelse(bp);
801013b9:	83 ec 0c             	sub    $0xc,%esp
801013bc:	56                   	push   %esi
801013bd:	e8 13 ee ff ff       	call   801001d5 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801013c2:	83 c3 01             	add    $0x1,%ebx
801013c5:	83 c4 10             	add    $0x10,%esp
801013c8:	eb b6                	jmp    80101380 <ialloc+0x14>
  panic("ialloc: no inodes");
801013ca:	83 ec 0c             	sub    $0xc,%esp
801013cd:	68 58 6a 10 80       	push   $0x80106a58
801013d2:	e8 71 ef ff ff       	call   80100348 <panic>
      memset(dip, 0, sizeof(*dip));
801013d7:	83 ec 04             	sub    $0x4,%esp
801013da:	6a 40                	push   $0x40
801013dc:	6a 00                	push   $0x0
801013de:	57                   	push   %edi
801013df:	e8 1a 28 00 00       	call   80103bfe <memset>
      dip->type = type;
801013e4:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801013e8:	66 89 07             	mov    %ax,(%edi)
      log_write(bp);   // mark it allocated on the disk
801013eb:	89 34 24             	mov    %esi,(%esp)
801013ee:	e8 b4 14 00 00       	call   801028a7 <log_write>
      brelse(bp);
801013f3:	89 34 24             	mov    %esi,(%esp)
801013f6:	e8 da ed ff ff       	call   801001d5 <brelse>
      return iget(dev, inum);
801013fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101401:	e8 f1 fd ff ff       	call   801011f7 <iget>
}
80101406:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101409:	5b                   	pop    %ebx
8010140a:	5e                   	pop    %esi
8010140b:	5f                   	pop    %edi
8010140c:	5d                   	pop    %ebp
8010140d:	c3                   	ret    

8010140e <iupdate>:
{
8010140e:	55                   	push   %ebp
8010140f:	89 e5                	mov    %esp,%ebp
80101411:	56                   	push   %esi
80101412:	53                   	push   %ebx
80101413:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101416:	8b 43 04             	mov    0x4(%ebx),%eax
80101419:	c1 e8 03             	shr    $0x3,%eax
8010141c:	83 ec 08             	sub    $0x8,%esp
8010141f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101425:	50                   	push   %eax
80101426:	ff 33                	push   (%ebx)
80101428:	e8 3f ed ff ff       	call   8010016c <bread>
8010142d:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010142f:	8b 43 04             	mov    0x4(%ebx),%eax
80101432:	83 e0 07             	and    $0x7,%eax
80101435:	c1 e0 06             	shl    $0x6,%eax
80101438:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
8010143c:	0f b7 53 50          	movzwl 0x50(%ebx),%edx
80101440:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101443:	0f b7 53 52          	movzwl 0x52(%ebx),%edx
80101447:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010144b:	0f b7 53 54          	movzwl 0x54(%ebx),%edx
8010144f:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101453:	0f b7 53 56          	movzwl 0x56(%ebx),%edx
80101457:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010145b:	8b 53 58             	mov    0x58(%ebx),%edx
8010145e:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101461:	83 c3 5c             	add    $0x5c,%ebx
80101464:	83 c0 0c             	add    $0xc,%eax
80101467:	83 c4 0c             	add    $0xc,%esp
8010146a:	6a 34                	push   $0x34
8010146c:	53                   	push   %ebx
8010146d:	50                   	push   %eax
8010146e:	e8 03 28 00 00       	call   80103c76 <memmove>
  log_write(bp);
80101473:	89 34 24             	mov    %esi,(%esp)
80101476:	e8 2c 14 00 00       	call   801028a7 <log_write>
  brelse(bp);
8010147b:	89 34 24             	mov    %esi,(%esp)
8010147e:	e8 52 ed ff ff       	call   801001d5 <brelse>
}
80101483:	83 c4 10             	add    $0x10,%esp
80101486:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101489:	5b                   	pop    %ebx
8010148a:	5e                   	pop    %esi
8010148b:	5d                   	pop    %ebp
8010148c:	c3                   	ret    

8010148d <itrunc>:
{
8010148d:	55                   	push   %ebp
8010148e:	89 e5                	mov    %esp,%ebp
80101490:	57                   	push   %edi
80101491:	56                   	push   %esi
80101492:	53                   	push   %ebx
80101493:	83 ec 1c             	sub    $0x1c,%esp
80101496:	89 c6                	mov    %eax,%esi
  for(i = 0; i < NDIRECT; i++){
80101498:	bb 00 00 00 00       	mov    $0x0,%ebx
8010149d:	eb 03                	jmp    801014a2 <itrunc+0x15>
8010149f:	83 c3 01             	add    $0x1,%ebx
801014a2:	83 fb 0b             	cmp    $0xb,%ebx
801014a5:	7f 19                	jg     801014c0 <itrunc+0x33>
    if(ip->addrs[i]){
801014a7:	8b 54 9e 5c          	mov    0x5c(%esi,%ebx,4),%edx
801014ab:	85 d2                	test   %edx,%edx
801014ad:	74 f0                	je     8010149f <itrunc+0x12>
      bfree(ip->dev, ip->addrs[i]);
801014af:	8b 06                	mov    (%esi),%eax
801014b1:	e8 3d fb ff ff       	call   80100ff3 <bfree>
      ip->addrs[i] = 0;
801014b6:	c7 44 9e 5c 00 00 00 	movl   $0x0,0x5c(%esi,%ebx,4)
801014bd:	00 
801014be:	eb df                	jmp    8010149f <itrunc+0x12>
  if(ip->addrs[NDIRECT]){
801014c0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801014c6:	85 c0                	test   %eax,%eax
801014c8:	75 1b                	jne    801014e5 <itrunc+0x58>
  ip->size = 0;
801014ca:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801014d1:	83 ec 0c             	sub    $0xc,%esp
801014d4:	56                   	push   %esi
801014d5:	e8 34 ff ff ff       	call   8010140e <iupdate>
}
801014da:	83 c4 10             	add    $0x10,%esp
801014dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014e0:	5b                   	pop    %ebx
801014e1:	5e                   	pop    %esi
801014e2:	5f                   	pop    %edi
801014e3:	5d                   	pop    %ebp
801014e4:	c3                   	ret    
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801014e5:	83 ec 08             	sub    $0x8,%esp
801014e8:	50                   	push   %eax
801014e9:	ff 36                	push   (%esi)
801014eb:	e8 7c ec ff ff       	call   8010016c <bread>
801014f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801014f3:	8d 78 5c             	lea    0x5c(%eax),%edi
    for(j = 0; j < NINDIRECT; j++){
801014f6:	83 c4 10             	add    $0x10,%esp
801014f9:	bb 00 00 00 00       	mov    $0x0,%ebx
801014fe:	eb 03                	jmp    80101503 <itrunc+0x76>
80101500:	83 c3 01             	add    $0x1,%ebx
80101503:	83 fb 7f             	cmp    $0x7f,%ebx
80101506:	77 10                	ja     80101518 <itrunc+0x8b>
      if(a[j])
80101508:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
8010150b:	85 d2                	test   %edx,%edx
8010150d:	74 f1                	je     80101500 <itrunc+0x73>
        bfree(ip->dev, a[j]);
8010150f:	8b 06                	mov    (%esi),%eax
80101511:	e8 dd fa ff ff       	call   80100ff3 <bfree>
80101516:	eb e8                	jmp    80101500 <itrunc+0x73>
    brelse(bp);
80101518:	83 ec 0c             	sub    $0xc,%esp
8010151b:	ff 75 e4             	push   -0x1c(%ebp)
8010151e:	e8 b2 ec ff ff       	call   801001d5 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101523:	8b 06                	mov    (%esi),%eax
80101525:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
8010152b:	e8 c3 fa ff ff       	call   80100ff3 <bfree>
    ip->addrs[NDIRECT] = 0;
80101530:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101537:	00 00 00 
8010153a:	83 c4 10             	add    $0x10,%esp
8010153d:	eb 8b                	jmp    801014ca <itrunc+0x3d>

8010153f <idup>:
{
8010153f:	55                   	push   %ebp
80101540:	89 e5                	mov    %esp,%ebp
80101542:	53                   	push   %ebx
80101543:	83 ec 10             	sub    $0x10,%esp
80101546:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101549:	68 60 f9 10 80       	push   $0x8010f960
8010154e:	e8 ff 25 00 00       	call   80103b52 <acquire>
  ip->ref++;
80101553:	8b 43 08             	mov    0x8(%ebx),%eax
80101556:	83 c0 01             	add    $0x1,%eax
80101559:	89 43 08             	mov    %eax,0x8(%ebx)
  release(&icache.lock);
8010155c:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101563:	e8 4f 26 00 00       	call   80103bb7 <release>
}
80101568:	89 d8                	mov    %ebx,%eax
8010156a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010156d:	c9                   	leave  
8010156e:	c3                   	ret    

8010156f <ilock>:
{
8010156f:	55                   	push   %ebp
80101570:	89 e5                	mov    %esp,%ebp
80101572:	56                   	push   %esi
80101573:	53                   	push   %ebx
80101574:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101577:	85 db                	test   %ebx,%ebx
80101579:	74 22                	je     8010159d <ilock+0x2e>
8010157b:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
8010157f:	7e 1c                	jle    8010159d <ilock+0x2e>
  acquiresleep(&ip->lock);
80101581:	83 ec 0c             	sub    $0xc,%esp
80101584:	8d 43 0c             	lea    0xc(%ebx),%eax
80101587:	50                   	push   %eax
80101588:	e8 b1 23 00 00       	call   8010393e <acquiresleep>
  if(ip->valid == 0){
8010158d:	83 c4 10             	add    $0x10,%esp
80101590:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
80101594:	74 14                	je     801015aa <ilock+0x3b>
}
80101596:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101599:	5b                   	pop    %ebx
8010159a:	5e                   	pop    %esi
8010159b:	5d                   	pop    %ebp
8010159c:	c3                   	ret    
    panic("ilock");
8010159d:	83 ec 0c             	sub    $0xc,%esp
801015a0:	68 6a 6a 10 80       	push   $0x80106a6a
801015a5:	e8 9e ed ff ff       	call   80100348 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015aa:	8b 43 04             	mov    0x4(%ebx),%eax
801015ad:	c1 e8 03             	shr    $0x3,%eax
801015b0:	83 ec 08             	sub    $0x8,%esp
801015b3:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801015b9:	50                   	push   %eax
801015ba:	ff 33                	push   (%ebx)
801015bc:	e8 ab eb ff ff       	call   8010016c <bread>
801015c1:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801015c3:	8b 43 04             	mov    0x4(%ebx),%eax
801015c6:	83 e0 07             	and    $0x7,%eax
801015c9:	c1 e0 06             	shl    $0x6,%eax
801015cc:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801015d0:	0f b7 10             	movzwl (%eax),%edx
801015d3:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801015d7:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801015db:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801015df:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801015e3:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801015e7:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801015eb:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801015ef:	8b 50 08             	mov    0x8(%eax),%edx
801015f2:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801015f5:	83 c0 0c             	add    $0xc,%eax
801015f8:	8d 53 5c             	lea    0x5c(%ebx),%edx
801015fb:	83 c4 0c             	add    $0xc,%esp
801015fe:	6a 34                	push   $0x34
80101600:	50                   	push   %eax
80101601:	52                   	push   %edx
80101602:	e8 6f 26 00 00       	call   80103c76 <memmove>
    brelse(bp);
80101607:	89 34 24             	mov    %esi,(%esp)
8010160a:	e8 c6 eb ff ff       	call   801001d5 <brelse>
    ip->valid = 1;
8010160f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101616:	83 c4 10             	add    $0x10,%esp
80101619:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010161e:	0f 85 72 ff ff ff    	jne    80101596 <ilock+0x27>
      panic("ilock: no type");
80101624:	83 ec 0c             	sub    $0xc,%esp
80101627:	68 70 6a 10 80       	push   $0x80106a70
8010162c:	e8 17 ed ff ff       	call   80100348 <panic>

80101631 <iunlock>:
{
80101631:	55                   	push   %ebp
80101632:	89 e5                	mov    %esp,%ebp
80101634:	56                   	push   %esi
80101635:	53                   	push   %ebx
80101636:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101639:	85 db                	test   %ebx,%ebx
8010163b:	74 2c                	je     80101669 <iunlock+0x38>
8010163d:	8d 73 0c             	lea    0xc(%ebx),%esi
80101640:	83 ec 0c             	sub    $0xc,%esp
80101643:	56                   	push   %esi
80101644:	e8 7f 23 00 00       	call   801039c8 <holdingsleep>
80101649:	83 c4 10             	add    $0x10,%esp
8010164c:	85 c0                	test   %eax,%eax
8010164e:	74 19                	je     80101669 <iunlock+0x38>
80101650:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
80101654:	7e 13                	jle    80101669 <iunlock+0x38>
  releasesleep(&ip->lock);
80101656:	83 ec 0c             	sub    $0xc,%esp
80101659:	56                   	push   %esi
8010165a:	e8 2e 23 00 00       	call   8010398d <releasesleep>
}
8010165f:	83 c4 10             	add    $0x10,%esp
80101662:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101665:	5b                   	pop    %ebx
80101666:	5e                   	pop    %esi
80101667:	5d                   	pop    %ebp
80101668:	c3                   	ret    
    panic("iunlock");
80101669:	83 ec 0c             	sub    $0xc,%esp
8010166c:	68 7f 6a 10 80       	push   $0x80106a7f
80101671:	e8 d2 ec ff ff       	call   80100348 <panic>

80101676 <iput>:
{
80101676:	55                   	push   %ebp
80101677:	89 e5                	mov    %esp,%ebp
80101679:	57                   	push   %edi
8010167a:	56                   	push   %esi
8010167b:	53                   	push   %ebx
8010167c:	83 ec 18             	sub    $0x18,%esp
8010167f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101682:	8d 73 0c             	lea    0xc(%ebx),%esi
80101685:	56                   	push   %esi
80101686:	e8 b3 22 00 00       	call   8010393e <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010168b:	83 c4 10             	add    $0x10,%esp
8010168e:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
80101692:	74 07                	je     8010169b <iput+0x25>
80101694:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101699:	74 35                	je     801016d0 <iput+0x5a>
  releasesleep(&ip->lock);
8010169b:	83 ec 0c             	sub    $0xc,%esp
8010169e:	56                   	push   %esi
8010169f:	e8 e9 22 00 00       	call   8010398d <releasesleep>
  acquire(&icache.lock);
801016a4:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801016ab:	e8 a2 24 00 00       	call   80103b52 <acquire>
  ip->ref--;
801016b0:	8b 43 08             	mov    0x8(%ebx),%eax
801016b3:	83 e8 01             	sub    $0x1,%eax
801016b6:	89 43 08             	mov    %eax,0x8(%ebx)
  release(&icache.lock);
801016b9:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801016c0:	e8 f2 24 00 00       	call   80103bb7 <release>
}
801016c5:	83 c4 10             	add    $0x10,%esp
801016c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016cb:	5b                   	pop    %ebx
801016cc:	5e                   	pop    %esi
801016cd:	5f                   	pop    %edi
801016ce:	5d                   	pop    %ebp
801016cf:	c3                   	ret    
    acquire(&icache.lock);
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	68 60 f9 10 80       	push   $0x8010f960
801016d8:	e8 75 24 00 00       	call   80103b52 <acquire>
    int r = ip->ref;
801016dd:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
801016e0:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801016e7:	e8 cb 24 00 00       	call   80103bb7 <release>
    if(r == 1){
801016ec:	83 c4 10             	add    $0x10,%esp
801016ef:	83 ff 01             	cmp    $0x1,%edi
801016f2:	75 a7                	jne    8010169b <iput+0x25>
      itrunc(ip);
801016f4:	89 d8                	mov    %ebx,%eax
801016f6:	e8 92 fd ff ff       	call   8010148d <itrunc>
      ip->type = 0;
801016fb:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
80101701:	83 ec 0c             	sub    $0xc,%esp
80101704:	53                   	push   %ebx
80101705:	e8 04 fd ff ff       	call   8010140e <iupdate>
      ip->valid = 0;
8010170a:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101711:	83 c4 10             	add    $0x10,%esp
80101714:	eb 85                	jmp    8010169b <iput+0x25>

80101716 <iunlockput>:
{
80101716:	55                   	push   %ebp
80101717:	89 e5                	mov    %esp,%ebp
80101719:	53                   	push   %ebx
8010171a:	83 ec 10             	sub    $0x10,%esp
8010171d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101720:	53                   	push   %ebx
80101721:	e8 0b ff ff ff       	call   80101631 <iunlock>
  iput(ip);
80101726:	89 1c 24             	mov    %ebx,(%esp)
80101729:	e8 48 ff ff ff       	call   80101676 <iput>
}
8010172e:	83 c4 10             	add    $0x10,%esp
80101731:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101734:	c9                   	leave  
80101735:	c3                   	ret    

80101736 <stati>:
{
80101736:	55                   	push   %ebp
80101737:	89 e5                	mov    %esp,%ebp
80101739:	8b 55 08             	mov    0x8(%ebp),%edx
8010173c:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
8010173f:	8b 0a                	mov    (%edx),%ecx
80101741:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101744:	8b 4a 04             	mov    0x4(%edx),%ecx
80101747:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
8010174a:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
8010174e:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101751:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101755:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101759:	8b 52 58             	mov    0x58(%edx),%edx
8010175c:	89 50 10             	mov    %edx,0x10(%eax)
}
8010175f:	5d                   	pop    %ebp
80101760:	c3                   	ret    

80101761 <readi>:
{
80101761:	55                   	push   %ebp
80101762:	89 e5                	mov    %esp,%ebp
80101764:	57                   	push   %edi
80101765:	56                   	push   %esi
80101766:	53                   	push   %ebx
80101767:	83 ec 1c             	sub    $0x1c,%esp
8010176a:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
8010176d:	8b 45 08             	mov    0x8(%ebp),%eax
80101770:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101775:	74 2c                	je     801017a3 <readi+0x42>
  if(off > ip->size || off + n < off)
80101777:	8b 45 08             	mov    0x8(%ebp),%eax
8010177a:	8b 40 58             	mov    0x58(%eax),%eax
8010177d:	39 f8                	cmp    %edi,%eax
8010177f:	0f 82 cb 00 00 00    	jb     80101850 <readi+0xef>
80101785:	89 fa                	mov    %edi,%edx
80101787:	03 55 14             	add    0x14(%ebp),%edx
8010178a:	0f 82 c7 00 00 00    	jb     80101857 <readi+0xf6>
  if(off + n > ip->size)
80101790:	39 d0                	cmp    %edx,%eax
80101792:	73 05                	jae    80101799 <readi+0x38>
    n = ip->size - off;
80101794:	29 f8                	sub    %edi,%eax
80101796:	89 45 14             	mov    %eax,0x14(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101799:	be 00 00 00 00       	mov    $0x0,%esi
8010179e:	e9 8f 00 00 00       	jmp    80101832 <readi+0xd1>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801017a3:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801017a7:	66 83 f8 09          	cmp    $0x9,%ax
801017ab:	0f 87 91 00 00 00    	ja     80101842 <readi+0xe1>
801017b1:	98                   	cwtl   
801017b2:	8b 04 c5 00 f9 10 80 	mov    -0x7fef0700(,%eax,8),%eax
801017b9:	85 c0                	test   %eax,%eax
801017bb:	0f 84 88 00 00 00    	je     80101849 <readi+0xe8>
    return devsw[ip->major].read(ip, dst, n);
801017c1:	83 ec 04             	sub    $0x4,%esp
801017c4:	ff 75 14             	push   0x14(%ebp)
801017c7:	ff 75 0c             	push   0xc(%ebp)
801017ca:	ff 75 08             	push   0x8(%ebp)
801017cd:	ff d0                	call   *%eax
801017cf:	83 c4 10             	add    $0x10,%esp
801017d2:	eb 66                	jmp    8010183a <readi+0xd9>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017d4:	89 fa                	mov    %edi,%edx
801017d6:	c1 ea 09             	shr    $0x9,%edx
801017d9:	8b 45 08             	mov    0x8(%ebp),%eax
801017dc:	e8 70 f9 ff ff       	call   80101151 <bmap>
801017e1:	83 ec 08             	sub    $0x8,%esp
801017e4:	50                   	push   %eax
801017e5:	8b 45 08             	mov    0x8(%ebp),%eax
801017e8:	ff 30                	push   (%eax)
801017ea:	e8 7d e9 ff ff       	call   8010016c <bread>
801017ef:	89 c1                	mov    %eax,%ecx
    m = min(n - tot, BSIZE - off%BSIZE);
801017f1:	89 f8                	mov    %edi,%eax
801017f3:	25 ff 01 00 00       	and    $0x1ff,%eax
801017f8:	bb 00 02 00 00       	mov    $0x200,%ebx
801017fd:	29 c3                	sub    %eax,%ebx
801017ff:	8b 55 14             	mov    0x14(%ebp),%edx
80101802:	29 f2                	sub    %esi,%edx
80101804:	39 d3                	cmp    %edx,%ebx
80101806:	0f 47 da             	cmova  %edx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101809:	83 c4 0c             	add    $0xc,%esp
8010180c:	53                   	push   %ebx
8010180d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101810:	8d 44 01 5c          	lea    0x5c(%ecx,%eax,1),%eax
80101814:	50                   	push   %eax
80101815:	ff 75 0c             	push   0xc(%ebp)
80101818:	e8 59 24 00 00       	call   80103c76 <memmove>
    brelse(bp);
8010181d:	83 c4 04             	add    $0x4,%esp
80101820:	ff 75 e4             	push   -0x1c(%ebp)
80101823:	e8 ad e9 ff ff       	call   801001d5 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101828:	01 de                	add    %ebx,%esi
8010182a:	01 df                	add    %ebx,%edi
8010182c:	01 5d 0c             	add    %ebx,0xc(%ebp)
8010182f:	83 c4 10             	add    $0x10,%esp
80101832:	39 75 14             	cmp    %esi,0x14(%ebp)
80101835:	77 9d                	ja     801017d4 <readi+0x73>
  return n;
80101837:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010183a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183d:	5b                   	pop    %ebx
8010183e:	5e                   	pop    %esi
8010183f:	5f                   	pop    %edi
80101840:	5d                   	pop    %ebp
80101841:	c3                   	ret    
      return -1;
80101842:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101847:	eb f1                	jmp    8010183a <readi+0xd9>
80101849:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010184e:	eb ea                	jmp    8010183a <readi+0xd9>
    return -1;
80101850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101855:	eb e3                	jmp    8010183a <readi+0xd9>
80101857:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010185c:	eb dc                	jmp    8010183a <readi+0xd9>

8010185e <writei>:
{
8010185e:	55                   	push   %ebp
8010185f:	89 e5                	mov    %esp,%ebp
80101861:	57                   	push   %edi
80101862:	56                   	push   %esi
80101863:	53                   	push   %ebx
80101864:	83 ec 1c             	sub    $0x1c,%esp
80101867:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
8010186a:	8b 45 08             	mov    0x8(%ebp),%eax
8010186d:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101872:	74 2e                	je     801018a2 <writei+0x44>
  if(off > ip->size || off + n < off)
80101874:	8b 45 08             	mov    0x8(%ebp),%eax
80101877:	39 78 58             	cmp    %edi,0x58(%eax)
8010187a:	0f 82 f5 00 00 00    	jb     80101975 <writei+0x117>
80101880:	89 f8                	mov    %edi,%eax
80101882:	03 45 14             	add    0x14(%ebp),%eax
80101885:	0f 82 f1 00 00 00    	jb     8010197c <writei+0x11e>
  if(off + n > MAXFILE*BSIZE)
8010188b:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101890:	0f 87 ed 00 00 00    	ja     80101983 <writei+0x125>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101896:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010189d:	e9 93 00 00 00       	jmp    80101935 <writei+0xd7>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801018a2:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801018a6:	66 83 f8 09          	cmp    $0x9,%ax
801018aa:	0f 87 b7 00 00 00    	ja     80101967 <writei+0x109>
801018b0:	98                   	cwtl   
801018b1:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
801018b8:	85 c0                	test   %eax,%eax
801018ba:	0f 84 ae 00 00 00    	je     8010196e <writei+0x110>
    return devsw[ip->major].write(ip, src, n);
801018c0:	83 ec 04             	sub    $0x4,%esp
801018c3:	ff 75 14             	push   0x14(%ebp)
801018c6:	ff 75 0c             	push   0xc(%ebp)
801018c9:	ff 75 08             	push   0x8(%ebp)
801018cc:	ff d0                	call   *%eax
801018ce:	83 c4 10             	add    $0x10,%esp
801018d1:	eb 7b                	jmp    8010194e <writei+0xf0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801018d3:	89 fa                	mov    %edi,%edx
801018d5:	c1 ea 09             	shr    $0x9,%edx
801018d8:	8b 45 08             	mov    0x8(%ebp),%eax
801018db:	e8 71 f8 ff ff       	call   80101151 <bmap>
801018e0:	83 ec 08             	sub    $0x8,%esp
801018e3:	50                   	push   %eax
801018e4:	8b 45 08             	mov    0x8(%ebp),%eax
801018e7:	ff 30                	push   (%eax)
801018e9:	e8 7e e8 ff ff       	call   8010016c <bread>
801018ee:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
801018f0:	89 f8                	mov    %edi,%eax
801018f2:	25 ff 01 00 00       	and    $0x1ff,%eax
801018f7:	bb 00 02 00 00       	mov    $0x200,%ebx
801018fc:	29 c3                	sub    %eax,%ebx
801018fe:	8b 55 14             	mov    0x14(%ebp),%edx
80101901:	2b 55 e4             	sub    -0x1c(%ebp),%edx
80101904:	39 d3                	cmp    %edx,%ebx
80101906:	0f 47 da             	cmova  %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101909:	83 c4 0c             	add    $0xc,%esp
8010190c:	53                   	push   %ebx
8010190d:	ff 75 0c             	push   0xc(%ebp)
80101910:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101914:	50                   	push   %eax
80101915:	e8 5c 23 00 00       	call   80103c76 <memmove>
    log_write(bp);
8010191a:	89 34 24             	mov    %esi,(%esp)
8010191d:	e8 85 0f 00 00       	call   801028a7 <log_write>
    brelse(bp);
80101922:	89 34 24             	mov    %esi,(%esp)
80101925:	e8 ab e8 ff ff       	call   801001d5 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010192a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010192d:	01 df                	add    %ebx,%edi
8010192f:	01 5d 0c             	add    %ebx,0xc(%ebp)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101938:	3b 45 14             	cmp    0x14(%ebp),%eax
8010193b:	72 96                	jb     801018d3 <writei+0x75>
  if(n > 0 && off > ip->size){
8010193d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80101941:	74 08                	je     8010194b <writei+0xed>
80101943:	8b 45 08             	mov    0x8(%ebp),%eax
80101946:	39 78 58             	cmp    %edi,0x58(%eax)
80101949:	72 0b                	jb     80101956 <writei+0xf8>
  return n;
8010194b:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010194e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101951:	5b                   	pop    %ebx
80101952:	5e                   	pop    %esi
80101953:	5f                   	pop    %edi
80101954:	5d                   	pop    %ebp
80101955:	c3                   	ret    
    ip->size = off;
80101956:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101959:	83 ec 0c             	sub    $0xc,%esp
8010195c:	50                   	push   %eax
8010195d:	e8 ac fa ff ff       	call   8010140e <iupdate>
80101962:	83 c4 10             	add    $0x10,%esp
80101965:	eb e4                	jmp    8010194b <writei+0xed>
      return -1;
80101967:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010196c:	eb e0                	jmp    8010194e <writei+0xf0>
8010196e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101973:	eb d9                	jmp    8010194e <writei+0xf0>
    return -1;
80101975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010197a:	eb d2                	jmp    8010194e <writei+0xf0>
8010197c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101981:	eb cb                	jmp    8010194e <writei+0xf0>
    return -1;
80101983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101988:	eb c4                	jmp    8010194e <writei+0xf0>

8010198a <namecmp>:
{
8010198a:	55                   	push   %ebp
8010198b:	89 e5                	mov    %esp,%ebp
8010198d:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101990:	6a 0e                	push   $0xe
80101992:	ff 75 0c             	push   0xc(%ebp)
80101995:	ff 75 08             	push   0x8(%ebp)
80101998:	e8 45 23 00 00       	call   80103ce2 <strncmp>
}
8010199d:	c9                   	leave  
8010199e:	c3                   	ret    

8010199f <dirlookup>:
{
8010199f:	55                   	push   %ebp
801019a0:	89 e5                	mov    %esp,%ebp
801019a2:	57                   	push   %edi
801019a3:	56                   	push   %esi
801019a4:	53                   	push   %ebx
801019a5:	83 ec 1c             	sub    $0x1c,%esp
801019a8:	8b 75 08             	mov    0x8(%ebp),%esi
801019ab:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(dp->type != T_DIR)
801019ae:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801019b3:	75 07                	jne    801019bc <dirlookup+0x1d>
  for(off = 0; off < dp->size; off += sizeof(de)){
801019b5:	bb 00 00 00 00       	mov    $0x0,%ebx
801019ba:	eb 1d                	jmp    801019d9 <dirlookup+0x3a>
    panic("dirlookup not DIR");
801019bc:	83 ec 0c             	sub    $0xc,%esp
801019bf:	68 87 6a 10 80       	push   $0x80106a87
801019c4:	e8 7f e9 ff ff       	call   80100348 <panic>
      panic("dirlookup read");
801019c9:	83 ec 0c             	sub    $0xc,%esp
801019cc:	68 99 6a 10 80       	push   $0x80106a99
801019d1:	e8 72 e9 ff ff       	call   80100348 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
801019d6:	83 c3 10             	add    $0x10,%ebx
801019d9:	39 5e 58             	cmp    %ebx,0x58(%esi)
801019dc:	76 48                	jbe    80101a26 <dirlookup+0x87>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801019de:	6a 10                	push   $0x10
801019e0:	53                   	push   %ebx
801019e1:	8d 45 d8             	lea    -0x28(%ebp),%eax
801019e4:	50                   	push   %eax
801019e5:	56                   	push   %esi
801019e6:	e8 76 fd ff ff       	call   80101761 <readi>
801019eb:	83 c4 10             	add    $0x10,%esp
801019ee:	83 f8 10             	cmp    $0x10,%eax
801019f1:	75 d6                	jne    801019c9 <dirlookup+0x2a>
    if(de.inum == 0)
801019f3:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801019f8:	74 dc                	je     801019d6 <dirlookup+0x37>
    if(namecmp(name, de.name) == 0){
801019fa:	83 ec 08             	sub    $0x8,%esp
801019fd:	8d 45 da             	lea    -0x26(%ebp),%eax
80101a00:	50                   	push   %eax
80101a01:	57                   	push   %edi
80101a02:	e8 83 ff ff ff       	call   8010198a <namecmp>
80101a07:	83 c4 10             	add    $0x10,%esp
80101a0a:	85 c0                	test   %eax,%eax
80101a0c:	75 c8                	jne    801019d6 <dirlookup+0x37>
      if(poff)
80101a0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80101a12:	74 05                	je     80101a19 <dirlookup+0x7a>
        *poff = off;
80101a14:	8b 45 10             	mov    0x10(%ebp),%eax
80101a17:	89 18                	mov    %ebx,(%eax)
      inum = de.inum;
80101a19:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101a1d:	8b 06                	mov    (%esi),%eax
80101a1f:	e8 d3 f7 ff ff       	call   801011f7 <iget>
80101a24:	eb 05                	jmp    80101a2b <dirlookup+0x8c>
  return 0;
80101a26:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101a2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a2e:	5b                   	pop    %ebx
80101a2f:	5e                   	pop    %esi
80101a30:	5f                   	pop    %edi
80101a31:	5d                   	pop    %ebp
80101a32:	c3                   	ret    

80101a33 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101a33:	55                   	push   %ebp
80101a34:	89 e5                	mov    %esp,%ebp
80101a36:	57                   	push   %edi
80101a37:	56                   	push   %esi
80101a38:	53                   	push   %ebx
80101a39:	83 ec 1c             	sub    $0x1c,%esp
80101a3c:	89 c3                	mov    %eax,%ebx
80101a3e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101a41:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101a44:	80 38 2f             	cmpb   $0x2f,(%eax)
80101a47:	74 17                	je     80101a60 <namex+0x2d>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101a49:	e8 67 17 00 00       	call   801031b5 <myproc>
80101a4e:	83 ec 0c             	sub    $0xc,%esp
80101a51:	ff 70 68             	push   0x68(%eax)
80101a54:	e8 e6 fa ff ff       	call   8010153f <idup>
80101a59:	89 c6                	mov    %eax,%esi
80101a5b:	83 c4 10             	add    $0x10,%esp
80101a5e:	eb 53                	jmp    80101ab3 <namex+0x80>
    ip = iget(ROOTDEV, ROOTINO);
80101a60:	ba 01 00 00 00       	mov    $0x1,%edx
80101a65:	b8 01 00 00 00       	mov    $0x1,%eax
80101a6a:	e8 88 f7 ff ff       	call   801011f7 <iget>
80101a6f:	89 c6                	mov    %eax,%esi
80101a71:	eb 40                	jmp    80101ab3 <namex+0x80>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
80101a73:	83 ec 0c             	sub    $0xc,%esp
80101a76:	56                   	push   %esi
80101a77:	e8 9a fc ff ff       	call   80101716 <iunlockput>
      return 0;
80101a7c:	83 c4 10             	add    $0x10,%esp
80101a7f:	be 00 00 00 00       	mov    $0x0,%esi
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101a84:	89 f0                	mov    %esi,%eax
80101a86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a89:	5b                   	pop    %ebx
80101a8a:	5e                   	pop    %esi
80101a8b:	5f                   	pop    %edi
80101a8c:	5d                   	pop    %ebp
80101a8d:	c3                   	ret    
    if((next = dirlookup(ip, name, 0)) == 0){
80101a8e:	83 ec 04             	sub    $0x4,%esp
80101a91:	6a 00                	push   $0x0
80101a93:	ff 75 e4             	push   -0x1c(%ebp)
80101a96:	56                   	push   %esi
80101a97:	e8 03 ff ff ff       	call   8010199f <dirlookup>
80101a9c:	89 c7                	mov    %eax,%edi
80101a9e:	83 c4 10             	add    $0x10,%esp
80101aa1:	85 c0                	test   %eax,%eax
80101aa3:	74 4a                	je     80101aef <namex+0xbc>
    iunlockput(ip);
80101aa5:	83 ec 0c             	sub    $0xc,%esp
80101aa8:	56                   	push   %esi
80101aa9:	e8 68 fc ff ff       	call   80101716 <iunlockput>
80101aae:	83 c4 10             	add    $0x10,%esp
    ip = next;
80101ab1:	89 fe                	mov    %edi,%esi
  while((path = skipelem(path, name)) != 0){
80101ab3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ab6:	89 d8                	mov    %ebx,%eax
80101ab8:	e8 85 f4 ff ff       	call   80100f42 <skipelem>
80101abd:	89 c3                	mov    %eax,%ebx
80101abf:	85 c0                	test   %eax,%eax
80101ac1:	74 3c                	je     80101aff <namex+0xcc>
    ilock(ip);
80101ac3:	83 ec 0c             	sub    $0xc,%esp
80101ac6:	56                   	push   %esi
80101ac7:	e8 a3 fa ff ff       	call   8010156f <ilock>
    if(ip->type != T_DIR){
80101acc:	83 c4 10             	add    $0x10,%esp
80101acf:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ad4:	75 9d                	jne    80101a73 <namex+0x40>
    if(nameiparent && *path == '\0'){
80101ad6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101ada:	74 b2                	je     80101a8e <namex+0x5b>
80101adc:	80 3b 00             	cmpb   $0x0,(%ebx)
80101adf:	75 ad                	jne    80101a8e <namex+0x5b>
      iunlock(ip);
80101ae1:	83 ec 0c             	sub    $0xc,%esp
80101ae4:	56                   	push   %esi
80101ae5:	e8 47 fb ff ff       	call   80101631 <iunlock>
      return ip;
80101aea:	83 c4 10             	add    $0x10,%esp
80101aed:	eb 95                	jmp    80101a84 <namex+0x51>
      iunlockput(ip);
80101aef:	83 ec 0c             	sub    $0xc,%esp
80101af2:	56                   	push   %esi
80101af3:	e8 1e fc ff ff       	call   80101716 <iunlockput>
      return 0;
80101af8:	83 c4 10             	add    $0x10,%esp
80101afb:	89 fe                	mov    %edi,%esi
80101afd:	eb 85                	jmp    80101a84 <namex+0x51>
  if(nameiparent){
80101aff:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101b03:	0f 84 7b ff ff ff    	je     80101a84 <namex+0x51>
    iput(ip);
80101b09:	83 ec 0c             	sub    $0xc,%esp
80101b0c:	56                   	push   %esi
80101b0d:	e8 64 fb ff ff       	call   80101676 <iput>
    return 0;
80101b12:	83 c4 10             	add    $0x10,%esp
80101b15:	89 de                	mov    %ebx,%esi
80101b17:	e9 68 ff ff ff       	jmp    80101a84 <namex+0x51>

80101b1c <dirlink>:
{
80101b1c:	55                   	push   %ebp
80101b1d:	89 e5                	mov    %esp,%ebp
80101b1f:	57                   	push   %edi
80101b20:	56                   	push   %esi
80101b21:	53                   	push   %ebx
80101b22:	83 ec 20             	sub    $0x20,%esp
80101b25:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101b28:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
80101b2b:	6a 00                	push   $0x0
80101b2d:	57                   	push   %edi
80101b2e:	53                   	push   %ebx
80101b2f:	e8 6b fe ff ff       	call   8010199f <dirlookup>
80101b34:	83 c4 10             	add    $0x10,%esp
80101b37:	85 c0                	test   %eax,%eax
80101b39:	75 2d                	jne    80101b68 <dirlink+0x4c>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b3b:	b8 00 00 00 00       	mov    $0x0,%eax
80101b40:	89 c6                	mov    %eax,%esi
80101b42:	39 43 58             	cmp    %eax,0x58(%ebx)
80101b45:	76 41                	jbe    80101b88 <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101b47:	6a 10                	push   $0x10
80101b49:	50                   	push   %eax
80101b4a:	8d 45 d8             	lea    -0x28(%ebp),%eax
80101b4d:	50                   	push   %eax
80101b4e:	53                   	push   %ebx
80101b4f:	e8 0d fc ff ff       	call   80101761 <readi>
80101b54:	83 c4 10             	add    $0x10,%esp
80101b57:	83 f8 10             	cmp    $0x10,%eax
80101b5a:	75 1f                	jne    80101b7b <dirlink+0x5f>
    if(de.inum == 0)
80101b5c:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101b61:	74 25                	je     80101b88 <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b63:	8d 46 10             	lea    0x10(%esi),%eax
80101b66:	eb d8                	jmp    80101b40 <dirlink+0x24>
    iput(ip);
80101b68:	83 ec 0c             	sub    $0xc,%esp
80101b6b:	50                   	push   %eax
80101b6c:	e8 05 fb ff ff       	call   80101676 <iput>
    return -1;
80101b71:	83 c4 10             	add    $0x10,%esp
80101b74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b79:	eb 3d                	jmp    80101bb8 <dirlink+0x9c>
      panic("dirlink read");
80101b7b:	83 ec 0c             	sub    $0xc,%esp
80101b7e:	68 a8 6a 10 80       	push   $0x80106aa8
80101b83:	e8 c0 e7 ff ff       	call   80100348 <panic>
  strncpy(de.name, name, DIRSIZ);
80101b88:	83 ec 04             	sub    $0x4,%esp
80101b8b:	6a 0e                	push   $0xe
80101b8d:	57                   	push   %edi
80101b8e:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101b91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101b94:	50                   	push   %eax
80101b95:	e8 87 21 00 00       	call   80103d21 <strncpy>
  de.inum = inum;
80101b9a:	8b 45 10             	mov    0x10(%ebp),%eax
80101b9d:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ba1:	6a 10                	push   $0x10
80101ba3:	56                   	push   %esi
80101ba4:	57                   	push   %edi
80101ba5:	53                   	push   %ebx
80101ba6:	e8 b3 fc ff ff       	call   8010185e <writei>
80101bab:	83 c4 20             	add    $0x20,%esp
80101bae:	83 f8 10             	cmp    $0x10,%eax
80101bb1:	75 0d                	jne    80101bc0 <dirlink+0xa4>
  return 0;
80101bb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bbb:	5b                   	pop    %ebx
80101bbc:	5e                   	pop    %esi
80101bbd:	5f                   	pop    %edi
80101bbe:	5d                   	pop    %ebp
80101bbf:	c3                   	ret    
    panic("dirlink");
80101bc0:	83 ec 0c             	sub    $0xc,%esp
80101bc3:	68 9c 70 10 80       	push   $0x8010709c
80101bc8:	e8 7b e7 ff ff       	call   80100348 <panic>

80101bcd <namei>:

struct inode*
namei(char *path)
{
80101bcd:	55                   	push   %ebp
80101bce:	89 e5                	mov    %esp,%ebp
80101bd0:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101bd3:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101bd6:	ba 00 00 00 00       	mov    $0x0,%edx
80101bdb:	8b 45 08             	mov    0x8(%ebp),%eax
80101bde:	e8 50 fe ff ff       	call   80101a33 <namex>
}
80101be3:	c9                   	leave  
80101be4:	c3                   	ret    

80101be5 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101be5:	55                   	push   %ebp
80101be6:	89 e5                	mov    %esp,%ebp
80101be8:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80101beb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101bee:	ba 01 00 00 00       	mov    $0x1,%edx
80101bf3:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf6:	e8 38 fe ff ff       	call   80101a33 <namex>
}
80101bfb:	c9                   	leave  
80101bfc:	c3                   	ret    

80101bfd <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80101bfd:	89 c1                	mov    %eax,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101bff:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101c04:	ec                   	in     (%dx),%al
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101c05:	89 c2                	mov    %eax,%edx
80101c07:	83 e2 c0             	and    $0xffffffc0,%edx
80101c0a:	80 fa 40             	cmp    $0x40,%dl
80101c0d:	75 f0                	jne    80101bff <idewait+0x2>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101c0f:	85 c9                	test   %ecx,%ecx
80101c11:	74 09                	je     80101c1c <idewait+0x1f>
80101c13:	a8 21                	test   $0x21,%al
80101c15:	75 08                	jne    80101c1f <idewait+0x22>
    return -1;
  return 0;
80101c17:	b9 00 00 00 00       	mov    $0x0,%ecx
}
80101c1c:	89 c8                	mov    %ecx,%eax
80101c1e:	c3                   	ret    
    return -1;
80101c1f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80101c24:	eb f6                	jmp    80101c1c <idewait+0x1f>

80101c26 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101c26:	55                   	push   %ebp
80101c27:	89 e5                	mov    %esp,%ebp
80101c29:	56                   	push   %esi
80101c2a:	53                   	push   %ebx
  if(b == 0)
80101c2b:	85 c0                	test   %eax,%eax
80101c2d:	0f 84 8f 00 00 00    	je     80101cc2 <idestart+0x9c>
80101c33:	89 c6                	mov    %eax,%esi
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101c35:	8b 58 08             	mov    0x8(%eax),%ebx
80101c38:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101c3e:	0f 87 8b 00 00 00    	ja     80101ccf <idestart+0xa9>
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;

  if (sector_per_block > 7) panic("idestart");

  idewait(0);
80101c44:	b8 00 00 00 00       	mov    $0x0,%eax
80101c49:	e8 af ff ff ff       	call   80101bfd <idewait>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101c4e:	b8 00 00 00 00       	mov    $0x0,%eax
80101c53:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101c58:	ee                   	out    %al,(%dx)
80101c59:	b8 01 00 00 00       	mov    $0x1,%eax
80101c5e:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101c63:	ee                   	out    %al,(%dx)
80101c64:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101c69:	89 d8                	mov    %ebx,%eax
80101c6b:	ee                   	out    %al,(%dx)
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101c6c:	0f b6 c7             	movzbl %bh,%eax
80101c6f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101c74:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
80101c75:	89 d8                	mov    %ebx,%eax
80101c77:	c1 f8 10             	sar    $0x10,%eax
80101c7a:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101c7f:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101c80:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101c84:	c1 e0 04             	shl    $0x4,%eax
80101c87:	83 e0 10             	and    $0x10,%eax
80101c8a:	c1 fb 18             	sar    $0x18,%ebx
80101c8d:	83 e3 0f             	and    $0xf,%ebx
80101c90:	09 d8                	or     %ebx,%eax
80101c92:	83 c8 e0             	or     $0xffffffe0,%eax
80101c95:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101c9a:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101c9b:	f6 06 04             	testb  $0x4,(%esi)
80101c9e:	74 3c                	je     80101cdc <idestart+0xb6>
80101ca0:	b8 30 00 00 00       	mov    $0x30,%eax
80101ca5:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101caa:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101cab:	83 c6 5c             	add    $0x5c,%esi
  asm volatile("cld; rep outsl" :
80101cae:	b9 80 00 00 00       	mov    $0x80,%ecx
80101cb3:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101cb8:	fc                   	cld    
80101cb9:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101cbb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cbe:	5b                   	pop    %ebx
80101cbf:	5e                   	pop    %esi
80101cc0:	5d                   	pop    %ebp
80101cc1:	c3                   	ret    
    panic("idestart");
80101cc2:	83 ec 0c             	sub    $0xc,%esp
80101cc5:	68 0b 6b 10 80       	push   $0x80106b0b
80101cca:	e8 79 e6 ff ff       	call   80100348 <panic>
    panic("incorrect blockno");
80101ccf:	83 ec 0c             	sub    $0xc,%esp
80101cd2:	68 14 6b 10 80       	push   $0x80106b14
80101cd7:	e8 6c e6 ff ff       	call   80100348 <panic>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101cdc:	b8 20 00 00 00       	mov    $0x20,%eax
80101ce1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ce6:	ee                   	out    %al,(%dx)
}
80101ce7:	eb d2                	jmp    80101cbb <idestart+0x95>

80101ce9 <ideinit>:
{
80101ce9:	55                   	push   %ebp
80101cea:	89 e5                	mov    %esp,%ebp
80101cec:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101cef:	68 26 6b 10 80       	push   $0x80106b26
80101cf4:	68 00 16 11 80       	push   $0x80111600
80101cf9:	e8 18 1d 00 00       	call   80103a16 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101cfe:	83 c4 08             	add    $0x8,%esp
80101d01:	a1 84 17 11 80       	mov    0x80111784,%eax
80101d06:	83 e8 01             	sub    $0x1,%eax
80101d09:	50                   	push   %eax
80101d0a:	6a 0e                	push   $0xe
80101d0c:	e8 50 02 00 00       	call   80101f61 <ioapicenable>
  idewait(0);
80101d11:	b8 00 00 00 00       	mov    $0x0,%eax
80101d16:	e8 e2 fe ff ff       	call   80101bfd <idewait>
80101d1b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101d20:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101d25:	ee                   	out    %al,(%dx)
  for(i=0; i<1000; i++){
80101d26:	83 c4 10             	add    $0x10,%esp
80101d29:	b9 00 00 00 00       	mov    $0x0,%ecx
80101d2e:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101d34:	7f 19                	jg     80101d4f <ideinit+0x66>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d36:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d3b:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101d3c:	84 c0                	test   %al,%al
80101d3e:	75 05                	jne    80101d45 <ideinit+0x5c>
  for(i=0; i<1000; i++){
80101d40:	83 c1 01             	add    $0x1,%ecx
80101d43:	eb e9                	jmp    80101d2e <ideinit+0x45>
      havedisk1 = 1;
80101d45:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
80101d4c:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d4f:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80101d54:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101d59:	ee                   	out    %al,(%dx)
}
80101d5a:	c9                   	leave  
80101d5b:	c3                   	ret    

80101d5c <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80101d5c:	55                   	push   %ebp
80101d5d:	89 e5                	mov    %esp,%ebp
80101d5f:	57                   	push   %edi
80101d60:	53                   	push   %ebx
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101d61:	83 ec 0c             	sub    $0xc,%esp
80101d64:	68 00 16 11 80       	push   $0x80111600
80101d69:	e8 e4 1d 00 00       	call   80103b52 <acquire>

  if((b = idequeue) == 0){
80101d6e:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80101d74:	83 c4 10             	add    $0x10,%esp
80101d77:	85 db                	test   %ebx,%ebx
80101d79:	74 4a                	je     80101dc5 <ideintr+0x69>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101d7b:	8b 43 58             	mov    0x58(%ebx),%eax
80101d7e:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101d83:	f6 03 04             	testb  $0x4,(%ebx)
80101d86:	74 4f                	je     80101dd7 <ideintr+0x7b>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80101d88:	8b 03                	mov    (%ebx),%eax
80101d8a:	83 c8 02             	or     $0x2,%eax
80101d8d:	89 03                	mov    %eax,(%ebx)
  b->flags &= ~B_DIRTY;
80101d8f:	83 e0 fb             	and    $0xfffffffb,%eax
80101d92:	89 03                	mov    %eax,(%ebx)
  wakeup(b);
80101d94:	83 ec 0c             	sub    $0xc,%esp
80101d97:	53                   	push   %ebx
80101d98:	e8 1f 1a 00 00       	call   801037bc <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101d9d:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80101da2:	83 c4 10             	add    $0x10,%esp
80101da5:	85 c0                	test   %eax,%eax
80101da7:	74 05                	je     80101dae <ideintr+0x52>
    idestart(idequeue);
80101da9:	e8 78 fe ff ff       	call   80101c26 <idestart>

  release(&idelock);
80101dae:	83 ec 0c             	sub    $0xc,%esp
80101db1:	68 00 16 11 80       	push   $0x80111600
80101db6:	e8 fc 1d 00 00       	call   80103bb7 <release>
80101dbb:	83 c4 10             	add    $0x10,%esp
}
80101dbe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101dc1:	5b                   	pop    %ebx
80101dc2:	5f                   	pop    %edi
80101dc3:	5d                   	pop    %ebp
80101dc4:	c3                   	ret    
    release(&idelock);
80101dc5:	83 ec 0c             	sub    $0xc,%esp
80101dc8:	68 00 16 11 80       	push   $0x80111600
80101dcd:	e8 e5 1d 00 00       	call   80103bb7 <release>
    return;
80101dd2:	83 c4 10             	add    $0x10,%esp
80101dd5:	eb e7                	jmp    80101dbe <ideintr+0x62>
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101dd7:	b8 01 00 00 00       	mov    $0x1,%eax
80101ddc:	e8 1c fe ff ff       	call   80101bfd <idewait>
80101de1:	85 c0                	test   %eax,%eax
80101de3:	78 a3                	js     80101d88 <ideintr+0x2c>
    insl(0x1f0, b->data, BSIZE/4);
80101de5:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80101de8:	b9 80 00 00 00       	mov    $0x80,%ecx
80101ded:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101df2:	fc                   	cld    
80101df3:	f3 6d                	rep insl (%dx),%es:(%edi)
}
80101df5:	eb 91                	jmp    80101d88 <ideintr+0x2c>

80101df7 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80101df7:	55                   	push   %ebp
80101df8:	89 e5                	mov    %esp,%ebp
80101dfa:	53                   	push   %ebx
80101dfb:	83 ec 10             	sub    $0x10,%esp
80101dfe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80101e01:	8d 43 0c             	lea    0xc(%ebx),%eax
80101e04:	50                   	push   %eax
80101e05:	e8 be 1b 00 00       	call   801039c8 <holdingsleep>
80101e0a:	83 c4 10             	add    $0x10,%esp
80101e0d:	85 c0                	test   %eax,%eax
80101e0f:	74 37                	je     80101e48 <iderw+0x51>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101e11:	8b 03                	mov    (%ebx),%eax
80101e13:	83 e0 06             	and    $0x6,%eax
80101e16:	83 f8 02             	cmp    $0x2,%eax
80101e19:	74 3a                	je     80101e55 <iderw+0x5e>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80101e1b:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
80101e1f:	74 09                	je     80101e2a <iderw+0x33>
80101e21:	83 3d e0 15 11 80 00 	cmpl   $0x0,0x801115e0
80101e28:	74 38                	je     80101e62 <iderw+0x6b>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80101e2a:	83 ec 0c             	sub    $0xc,%esp
80101e2d:	68 00 16 11 80       	push   $0x80111600
80101e32:	e8 1b 1d 00 00       	call   80103b52 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80101e37:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101e3e:	83 c4 10             	add    $0x10,%esp
80101e41:	ba e4 15 11 80       	mov    $0x801115e4,%edx
80101e46:	eb 2a                	jmp    80101e72 <iderw+0x7b>
    panic("iderw: buf not locked");
80101e48:	83 ec 0c             	sub    $0xc,%esp
80101e4b:	68 2a 6b 10 80       	push   $0x80106b2a
80101e50:	e8 f3 e4 ff ff       	call   80100348 <panic>
    panic("iderw: nothing to do");
80101e55:	83 ec 0c             	sub    $0xc,%esp
80101e58:	68 40 6b 10 80       	push   $0x80106b40
80101e5d:	e8 e6 e4 ff ff       	call   80100348 <panic>
    panic("iderw: ide disk 1 not present");
80101e62:	83 ec 0c             	sub    $0xc,%esp
80101e65:	68 55 6b 10 80       	push   $0x80106b55
80101e6a:	e8 d9 e4 ff ff       	call   80100348 <panic>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101e6f:	8d 50 58             	lea    0x58(%eax),%edx
80101e72:	8b 02                	mov    (%edx),%eax
80101e74:	85 c0                	test   %eax,%eax
80101e76:	75 f7                	jne    80101e6f <iderw+0x78>
    ;
  *pp = b;
80101e78:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80101e7a:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80101e80:	75 1a                	jne    80101e9c <iderw+0xa5>
    idestart(b);
80101e82:	89 d8                	mov    %ebx,%eax
80101e84:	e8 9d fd ff ff       	call   80101c26 <idestart>
80101e89:	eb 11                	jmp    80101e9c <iderw+0xa5>

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80101e8b:	83 ec 08             	sub    $0x8,%esp
80101e8e:	68 00 16 11 80       	push   $0x80111600
80101e93:	53                   	push   %ebx
80101e94:	e8 be 17 00 00       	call   80103657 <sleep>
80101e99:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101e9c:	8b 03                	mov    (%ebx),%eax
80101e9e:	83 e0 06             	and    $0x6,%eax
80101ea1:	83 f8 02             	cmp    $0x2,%eax
80101ea4:	75 e5                	jne    80101e8b <iderw+0x94>
  }


  release(&idelock);
80101ea6:	83 ec 0c             	sub    $0xc,%esp
80101ea9:	68 00 16 11 80       	push   $0x80111600
80101eae:	e8 04 1d 00 00       	call   80103bb7 <release>
}
80101eb3:	83 c4 10             	add    $0x10,%esp
80101eb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101eb9:	c9                   	leave  
80101eba:	c3                   	ret    

80101ebb <ioapicread>:
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101ebb:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80101ec1:	89 02                	mov    %eax,(%edx)
  return ioapic->data;
80101ec3:	a1 34 16 11 80       	mov    0x80111634,%eax
80101ec8:	8b 40 10             	mov    0x10(%eax),%eax
}
80101ecb:	c3                   	ret    

80101ecc <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101ecc:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101ed2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80101ed4:	a1 34 16 11 80       	mov    0x80111634,%eax
80101ed9:	89 50 10             	mov    %edx,0x10(%eax)
}
80101edc:	c3                   	ret    

80101edd <ioapicinit>:

void
ioapicinit(void)
{
80101edd:	55                   	push   %ebp
80101ede:	89 e5                	mov    %esp,%ebp
80101ee0:	57                   	push   %edi
80101ee1:	56                   	push   %esi
80101ee2:	53                   	push   %ebx
80101ee3:	83 ec 0c             	sub    $0xc,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101ee6:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
80101eed:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80101ef0:	b8 01 00 00 00       	mov    $0x1,%eax
80101ef5:	e8 c1 ff ff ff       	call   80101ebb <ioapicread>
80101efa:	c1 e8 10             	shr    $0x10,%eax
80101efd:	0f b6 f8             	movzbl %al,%edi
  id = ioapicread(REG_ID) >> 24;
80101f00:	b8 00 00 00 00       	mov    $0x0,%eax
80101f05:	e8 b1 ff ff ff       	call   80101ebb <ioapicread>
80101f0a:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80101f0d:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
80101f14:	39 c2                	cmp    %eax,%edx
80101f16:	75 07                	jne    80101f1f <ioapicinit+0x42>
{
80101f18:	bb 00 00 00 00       	mov    $0x0,%ebx
80101f1d:	eb 36                	jmp    80101f55 <ioapicinit+0x78>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80101f1f:	83 ec 0c             	sub    $0xc,%esp
80101f22:	68 74 6b 10 80       	push   $0x80106b74
80101f27:	e8 db e6 ff ff       	call   80100607 <cprintf>
80101f2c:	83 c4 10             	add    $0x10,%esp
80101f2f:	eb e7                	jmp    80101f18 <ioapicinit+0x3b>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80101f31:	8d 53 20             	lea    0x20(%ebx),%edx
80101f34:	81 ca 00 00 01 00    	or     $0x10000,%edx
80101f3a:	8d 74 1b 10          	lea    0x10(%ebx,%ebx,1),%esi
80101f3e:	89 f0                	mov    %esi,%eax
80101f40:	e8 87 ff ff ff       	call   80101ecc <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80101f45:	8d 46 01             	lea    0x1(%esi),%eax
80101f48:	ba 00 00 00 00       	mov    $0x0,%edx
80101f4d:	e8 7a ff ff ff       	call   80101ecc <ioapicwrite>
  for(i = 0; i <= maxintr; i++){
80101f52:	83 c3 01             	add    $0x1,%ebx
80101f55:	39 fb                	cmp    %edi,%ebx
80101f57:	7e d8                	jle    80101f31 <ioapicinit+0x54>
  }
}
80101f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5c:	5b                   	pop    %ebx
80101f5d:	5e                   	pop    %esi
80101f5e:	5f                   	pop    %edi
80101f5f:	5d                   	pop    %ebp
80101f60:	c3                   	ret    

80101f61 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80101f61:	55                   	push   %ebp
80101f62:	89 e5                	mov    %esp,%ebp
80101f64:	53                   	push   %ebx
80101f65:	83 ec 04             	sub    $0x4,%esp
80101f68:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80101f6b:	8d 50 20             	lea    0x20(%eax),%edx
80101f6e:	8d 5c 00 10          	lea    0x10(%eax,%eax,1),%ebx
80101f72:	89 d8                	mov    %ebx,%eax
80101f74:	e8 53 ff ff ff       	call   80101ecc <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80101f79:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f7c:	c1 e2 18             	shl    $0x18,%edx
80101f7f:	8d 43 01             	lea    0x1(%ebx),%eax
80101f82:	e8 45 ff ff ff       	call   80101ecc <ioapicwrite>
}
80101f87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f8a:	c9                   	leave  
80101f8b:	c3                   	ret    

80101f8c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80101f8c:	55                   	push   %ebp
80101f8d:	89 e5                	mov    %esp,%ebp
80101f8f:	53                   	push   %ebx
80101f90:	83 ec 04             	sub    $0x4,%esp
80101f93:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80101f96:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80101f9c:	75 4c                	jne    80101fea <kfree+0x5e>
80101f9e:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
80101fa4:	72 44                	jb     80101fea <kfree+0x5e>
80101fa6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80101fac:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80101fb1:	77 37                	ja     80101fea <kfree+0x5e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80101fb3:	83 ec 04             	sub    $0x4,%esp
80101fb6:	68 00 10 00 00       	push   $0x1000
80101fbb:	6a 01                	push   $0x1
80101fbd:	53                   	push   %ebx
80101fbe:	e8 3b 1c 00 00       	call   80103bfe <memset>

  if(kmem.use_lock)
80101fc3:	83 c4 10             	add    $0x10,%esp
80101fc6:	83 3d 74 16 11 80 00 	cmpl   $0x0,0x80111674
80101fcd:	75 28                	jne    80101ff7 <kfree+0x6b>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80101fcf:	a1 78 16 11 80       	mov    0x80111678,%eax
80101fd4:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
80101fd6:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80101fdc:	83 3d 74 16 11 80 00 	cmpl   $0x0,0x80111674
80101fe3:	75 24                	jne    80102009 <kfree+0x7d>
    release(&kmem.lock);
}
80101fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101fe8:	c9                   	leave  
80101fe9:	c3                   	ret    
    panic("kfree");
80101fea:	83 ec 0c             	sub    $0xc,%esp
80101fed:	68 a6 6b 10 80       	push   $0x80106ba6
80101ff2:	e8 51 e3 ff ff       	call   80100348 <panic>
    acquire(&kmem.lock);
80101ff7:	83 ec 0c             	sub    $0xc,%esp
80101ffa:	68 40 16 11 80       	push   $0x80111640
80101fff:	e8 4e 1b 00 00       	call   80103b52 <acquire>
80102004:	83 c4 10             	add    $0x10,%esp
80102007:	eb c6                	jmp    80101fcf <kfree+0x43>
    release(&kmem.lock);
80102009:	83 ec 0c             	sub    $0xc,%esp
8010200c:	68 40 16 11 80       	push   $0x80111640
80102011:	e8 a1 1b 00 00       	call   80103bb7 <release>
80102016:	83 c4 10             	add    $0x10,%esp
}
80102019:	eb ca                	jmp    80101fe5 <kfree+0x59>

8010201b <freerange>:
{
8010201b:	55                   	push   %ebp
8010201c:	89 e5                	mov    %esp,%ebp
8010201e:	56                   	push   %esi
8010201f:	53                   	push   %ebx
80102020:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102023:	8b 45 08             	mov    0x8(%ebp),%eax
80102026:	05 ff 0f 00 00       	add    $0xfff,%eax
8010202b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102030:	eb 0e                	jmp    80102040 <freerange+0x25>
    kfree(p);
80102032:	83 ec 0c             	sub    $0xc,%esp
80102035:	50                   	push   %eax
80102036:	e8 51 ff ff ff       	call   80101f8c <kfree>
8010203b:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010203e:	89 f0                	mov    %esi,%eax
80102040:	8d b0 00 10 00 00    	lea    0x1000(%eax),%esi
80102046:	39 de                	cmp    %ebx,%esi
80102048:	76 e8                	jbe    80102032 <freerange+0x17>
}
8010204a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010204d:	5b                   	pop    %ebx
8010204e:	5e                   	pop    %esi
8010204f:	5d                   	pop    %ebp
80102050:	c3                   	ret    

80102051 <kinit1>:
{
80102051:	55                   	push   %ebp
80102052:	89 e5                	mov    %esp,%ebp
80102054:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
80102057:	68 ac 6b 10 80       	push   $0x80106bac
8010205c:	68 40 16 11 80       	push   $0x80111640
80102061:	e8 b0 19 00 00       	call   80103a16 <initlock>
  kmem.use_lock = 0;
80102066:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
8010206d:	00 00 00 
  freerange(vstart, vend);
80102070:	83 c4 08             	add    $0x8,%esp
80102073:	ff 75 0c             	push   0xc(%ebp)
80102076:	ff 75 08             	push   0x8(%ebp)
80102079:	e8 9d ff ff ff       	call   8010201b <freerange>
}
8010207e:	83 c4 10             	add    $0x10,%esp
80102081:	c9                   	leave  
80102082:	c3                   	ret    

80102083 <kinit2>:
{
80102083:	55                   	push   %ebp
80102084:	89 e5                	mov    %esp,%ebp
80102086:	83 ec 10             	sub    $0x10,%esp
  freerange(vstart, vend);
80102089:	ff 75 0c             	push   0xc(%ebp)
8010208c:	ff 75 08             	push   0x8(%ebp)
8010208f:	e8 87 ff ff ff       	call   8010201b <freerange>
  kmem.use_lock = 1;
80102094:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
8010209b:	00 00 00 
}
8010209e:	83 c4 10             	add    $0x10,%esp
801020a1:	c9                   	leave  
801020a2:	c3                   	ret    

801020a3 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801020a3:	55                   	push   %ebp
801020a4:	89 e5                	mov    %esp,%ebp
801020a6:	53                   	push   %ebx
801020a7:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801020aa:	83 3d 74 16 11 80 00 	cmpl   $0x0,0x80111674
801020b1:	75 21                	jne    801020d4 <kalloc+0x31>
    acquire(&kmem.lock);
  r = kmem.freelist;
801020b3:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(r)
801020b9:	85 db                	test   %ebx,%ebx
801020bb:	74 07                	je     801020c4 <kalloc+0x21>
    kmem.freelist = r->next;
801020bd:	8b 03                	mov    (%ebx),%eax
801020bf:	a3 78 16 11 80       	mov    %eax,0x80111678
  if(kmem.use_lock)
801020c4:	83 3d 74 16 11 80 00 	cmpl   $0x0,0x80111674
801020cb:	75 19                	jne    801020e6 <kalloc+0x43>
    release(&kmem.lock);
  return (char*)r;
}
801020cd:	89 d8                	mov    %ebx,%eax
801020cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801020d2:	c9                   	leave  
801020d3:	c3                   	ret    
    acquire(&kmem.lock);
801020d4:	83 ec 0c             	sub    $0xc,%esp
801020d7:	68 40 16 11 80       	push   $0x80111640
801020dc:	e8 71 1a 00 00       	call   80103b52 <acquire>
801020e1:	83 c4 10             	add    $0x10,%esp
801020e4:	eb cd                	jmp    801020b3 <kalloc+0x10>
    release(&kmem.lock);
801020e6:	83 ec 0c             	sub    $0xc,%esp
801020e9:	68 40 16 11 80       	push   $0x80111640
801020ee:	e8 c4 1a 00 00       	call   80103bb7 <release>
801020f3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
801020f6:	eb d5                	jmp    801020cd <kalloc+0x2a>

801020f8 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020f8:	ba 64 00 00 00       	mov    $0x64,%edx
801020fd:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801020fe:	a8 01                	test   $0x1,%al
80102100:	0f 84 b4 00 00 00    	je     801021ba <kbdgetc+0xc2>
80102106:	ba 60 00 00 00       	mov    $0x60,%edx
8010210b:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010210c:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
8010210f:	3c e0                	cmp    $0xe0,%al
80102111:	74 61                	je     80102174 <kbdgetc+0x7c>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102113:	84 c0                	test   %al,%al
80102115:	78 6a                	js     80102181 <kbdgetc+0x89>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102117:	8b 15 7c 16 11 80    	mov    0x8011167c,%edx
8010211d:	f6 c2 40             	test   $0x40,%dl
80102120:	74 0f                	je     80102131 <kbdgetc+0x39>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102122:	83 c8 80             	or     $0xffffff80,%eax
80102125:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
80102128:	83 e2 bf             	and    $0xffffffbf,%edx
8010212b:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  }

  shift |= shiftcode[data];
80102131:	0f b6 91 e0 6c 10 80 	movzbl -0x7fef9320(%ecx),%edx
80102138:	0b 15 7c 16 11 80    	or     0x8011167c,%edx
8010213e:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  shift ^= togglecode[data];
80102144:	0f b6 81 e0 6b 10 80 	movzbl -0x7fef9420(%ecx),%eax
8010214b:	31 c2                	xor    %eax,%edx
8010214d:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102153:	89 d0                	mov    %edx,%eax
80102155:	83 e0 03             	and    $0x3,%eax
80102158:	8b 04 85 c0 6b 10 80 	mov    -0x7fef9440(,%eax,4),%eax
8010215f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102163:	f6 c2 08             	test   $0x8,%dl
80102166:	74 57                	je     801021bf <kbdgetc+0xc7>
    if('a' <= c && c <= 'z')
80102168:	8d 50 9f             	lea    -0x61(%eax),%edx
8010216b:	83 fa 19             	cmp    $0x19,%edx
8010216e:	77 3e                	ja     801021ae <kbdgetc+0xb6>
      c += 'A' - 'a';
80102170:	83 e8 20             	sub    $0x20,%eax
80102173:	c3                   	ret    
    shift |= E0ESC;
80102174:	83 0d 7c 16 11 80 40 	orl    $0x40,0x8011167c
    return 0;
8010217b:	b8 00 00 00 00       	mov    $0x0,%eax
80102180:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102181:	8b 15 7c 16 11 80    	mov    0x8011167c,%edx
80102187:	f6 c2 40             	test   $0x40,%dl
8010218a:	75 05                	jne    80102191 <kbdgetc+0x99>
8010218c:	89 c1                	mov    %eax,%ecx
8010218e:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102191:	0f b6 81 e0 6c 10 80 	movzbl -0x7fef9320(%ecx),%eax
80102198:	83 c8 40             	or     $0x40,%eax
8010219b:	0f b6 c0             	movzbl %al,%eax
8010219e:	f7 d0                	not    %eax
801021a0:	21 c2                	and    %eax,%edx
801021a2:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
    return 0;
801021a8:	b8 00 00 00 00       	mov    $0x0,%eax
801021ad:	c3                   	ret    
    else if('A' <= c && c <= 'Z')
801021ae:	8d 50 bf             	lea    -0x41(%eax),%edx
801021b1:	83 fa 19             	cmp    $0x19,%edx
801021b4:	77 09                	ja     801021bf <kbdgetc+0xc7>
      c += 'a' - 'A';
801021b6:	83 c0 20             	add    $0x20,%eax
  }
  return c;
801021b9:	c3                   	ret    
    return -1;
801021ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801021bf:	c3                   	ret    

801021c0 <kbdintr>:

void
kbdintr(void)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801021c6:	68 f8 20 10 80       	push   $0x801020f8
801021cb:	e8 63 e5 ff ff       	call   80100733 <consoleintr>
}
801021d0:	83 c4 10             	add    $0x10,%esp
801021d3:	c9                   	leave  
801021d4:	c3                   	ret    

801021d5 <lapicw>:

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801021d5:	8b 0d 80 16 11 80    	mov    0x80111680,%ecx
801021db:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801021de:	89 10                	mov    %edx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
801021e0:	a1 80 16 11 80       	mov    0x80111680,%eax
801021e5:	8b 40 20             	mov    0x20(%eax),%eax
}
801021e8:	c3                   	ret    

801021e9 <cmos_read>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021e9:	ba 70 00 00 00       	mov    $0x70,%edx
801021ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ef:	ba 71 00 00 00       	mov    $0x71,%edx
801021f4:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801021f5:	0f b6 c0             	movzbl %al,%eax
}
801021f8:	c3                   	ret    

801021f9 <fill_rtcdate>:

static void
fill_rtcdate(struct rtcdate *r)
{
801021f9:	55                   	push   %ebp
801021fa:	89 e5                	mov    %esp,%ebp
801021fc:	53                   	push   %ebx
801021fd:	83 ec 04             	sub    $0x4,%esp
80102200:	89 c3                	mov    %eax,%ebx
  r->second = cmos_read(SECS);
80102202:	b8 00 00 00 00       	mov    $0x0,%eax
80102207:	e8 dd ff ff ff       	call   801021e9 <cmos_read>
8010220c:	89 03                	mov    %eax,(%ebx)
  r->minute = cmos_read(MINS);
8010220e:	b8 02 00 00 00       	mov    $0x2,%eax
80102213:	e8 d1 ff ff ff       	call   801021e9 <cmos_read>
80102218:	89 43 04             	mov    %eax,0x4(%ebx)
  r->hour   = cmos_read(HOURS);
8010221b:	b8 04 00 00 00       	mov    $0x4,%eax
80102220:	e8 c4 ff ff ff       	call   801021e9 <cmos_read>
80102225:	89 43 08             	mov    %eax,0x8(%ebx)
  r->day    = cmos_read(DAY);
80102228:	b8 07 00 00 00       	mov    $0x7,%eax
8010222d:	e8 b7 ff ff ff       	call   801021e9 <cmos_read>
80102232:	89 43 0c             	mov    %eax,0xc(%ebx)
  r->month  = cmos_read(MONTH);
80102235:	b8 08 00 00 00       	mov    $0x8,%eax
8010223a:	e8 aa ff ff ff       	call   801021e9 <cmos_read>
8010223f:	89 43 10             	mov    %eax,0x10(%ebx)
  r->year   = cmos_read(YEAR);
80102242:	b8 09 00 00 00       	mov    $0x9,%eax
80102247:	e8 9d ff ff ff       	call   801021e9 <cmos_read>
8010224c:	89 43 14             	mov    %eax,0x14(%ebx)
}
8010224f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102252:	c9                   	leave  
80102253:	c3                   	ret    

80102254 <lapicinit>:
  if(!lapic)
80102254:	83 3d 80 16 11 80 00 	cmpl   $0x0,0x80111680
8010225b:	0f 84 fe 00 00 00    	je     8010235f <lapicinit+0x10b>
{
80102261:	55                   	push   %ebp
80102262:	89 e5                	mov    %esp,%ebp
80102264:	83 ec 08             	sub    $0x8,%esp
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102267:	ba 3f 01 00 00       	mov    $0x13f,%edx
8010226c:	b8 3c 00 00 00       	mov    $0x3c,%eax
80102271:	e8 5f ff ff ff       	call   801021d5 <lapicw>
  lapicw(TDCR, X1);
80102276:	ba 0b 00 00 00       	mov    $0xb,%edx
8010227b:	b8 f8 00 00 00       	mov    $0xf8,%eax
80102280:	e8 50 ff ff ff       	call   801021d5 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102285:	ba 20 00 02 00       	mov    $0x20020,%edx
8010228a:	b8 c8 00 00 00       	mov    $0xc8,%eax
8010228f:	e8 41 ff ff ff       	call   801021d5 <lapicw>
  lapicw(TICR, 10000000);
80102294:	ba 80 96 98 00       	mov    $0x989680,%edx
80102299:	b8 e0 00 00 00       	mov    $0xe0,%eax
8010229e:	e8 32 ff ff ff       	call   801021d5 <lapicw>
  lapicw(LINT0, MASKED);
801022a3:	ba 00 00 01 00       	mov    $0x10000,%edx
801022a8:	b8 d4 00 00 00       	mov    $0xd4,%eax
801022ad:	e8 23 ff ff ff       	call   801021d5 <lapicw>
  lapicw(LINT1, MASKED);
801022b2:	ba 00 00 01 00       	mov    $0x10000,%edx
801022b7:	b8 d8 00 00 00       	mov    $0xd8,%eax
801022bc:	e8 14 ff ff ff       	call   801021d5 <lapicw>
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801022c1:	a1 80 16 11 80       	mov    0x80111680,%eax
801022c6:	8b 40 30             	mov    0x30(%eax),%eax
801022c9:	c1 e8 10             	shr    $0x10,%eax
801022cc:	a8 fc                	test   $0xfc,%al
801022ce:	75 7b                	jne    8010234b <lapicinit+0xf7>
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801022d0:	ba 33 00 00 00       	mov    $0x33,%edx
801022d5:	b8 dc 00 00 00       	mov    $0xdc,%eax
801022da:	e8 f6 fe ff ff       	call   801021d5 <lapicw>
  lapicw(ESR, 0);
801022df:	ba 00 00 00 00       	mov    $0x0,%edx
801022e4:	b8 a0 00 00 00       	mov    $0xa0,%eax
801022e9:	e8 e7 fe ff ff       	call   801021d5 <lapicw>
  lapicw(ESR, 0);
801022ee:	ba 00 00 00 00       	mov    $0x0,%edx
801022f3:	b8 a0 00 00 00       	mov    $0xa0,%eax
801022f8:	e8 d8 fe ff ff       	call   801021d5 <lapicw>
  lapicw(EOI, 0);
801022fd:	ba 00 00 00 00       	mov    $0x0,%edx
80102302:	b8 2c 00 00 00       	mov    $0x2c,%eax
80102307:	e8 c9 fe ff ff       	call   801021d5 <lapicw>
  lapicw(ICRHI, 0);
8010230c:	ba 00 00 00 00       	mov    $0x0,%edx
80102311:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102316:	e8 ba fe ff ff       	call   801021d5 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
8010231b:	ba 00 85 08 00       	mov    $0x88500,%edx
80102320:	b8 c0 00 00 00       	mov    $0xc0,%eax
80102325:	e8 ab fe ff ff       	call   801021d5 <lapicw>
  while(lapic[ICRLO] & DELIVS)
8010232a:	a1 80 16 11 80       	mov    0x80111680,%eax
8010232f:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
80102335:	f6 c4 10             	test   $0x10,%ah
80102338:	75 f0                	jne    8010232a <lapicinit+0xd6>
  lapicw(TPR, 0);
8010233a:	ba 00 00 00 00       	mov    $0x0,%edx
8010233f:	b8 20 00 00 00       	mov    $0x20,%eax
80102344:	e8 8c fe ff ff       	call   801021d5 <lapicw>
}
80102349:	c9                   	leave  
8010234a:	c3                   	ret    
    lapicw(PCINT, MASKED);
8010234b:	ba 00 00 01 00       	mov    $0x10000,%edx
80102350:	b8 d0 00 00 00       	mov    $0xd0,%eax
80102355:	e8 7b fe ff ff       	call   801021d5 <lapicw>
8010235a:	e9 71 ff ff ff       	jmp    801022d0 <lapicinit+0x7c>
8010235f:	c3                   	ret    

80102360 <lapicid>:
  if (!lapic)
80102360:	a1 80 16 11 80       	mov    0x80111680,%eax
80102365:	85 c0                	test   %eax,%eax
80102367:	74 07                	je     80102370 <lapicid+0x10>
  return lapic[ID] >> 24;
80102369:	8b 40 20             	mov    0x20(%eax),%eax
8010236c:	c1 e8 18             	shr    $0x18,%eax
8010236f:	c3                   	ret    
    return 0;
80102370:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102375:	c3                   	ret    

80102376 <lapiceoi>:
  if(lapic)
80102376:	83 3d 80 16 11 80 00 	cmpl   $0x0,0x80111680
8010237d:	74 17                	je     80102396 <lapiceoi+0x20>
{
8010237f:	55                   	push   %ebp
80102380:	89 e5                	mov    %esp,%ebp
80102382:	83 ec 08             	sub    $0x8,%esp
    lapicw(EOI, 0);
80102385:	ba 00 00 00 00       	mov    $0x0,%edx
8010238a:	b8 2c 00 00 00       	mov    $0x2c,%eax
8010238f:	e8 41 fe ff ff       	call   801021d5 <lapicw>
}
80102394:	c9                   	leave  
80102395:	c3                   	ret    
80102396:	c3                   	ret    

80102397 <microdelay>:
}
80102397:	c3                   	ret    

80102398 <lapicstartap>:
{
80102398:	55                   	push   %ebp
80102399:	89 e5                	mov    %esp,%ebp
8010239b:	57                   	push   %edi
8010239c:	56                   	push   %esi
8010239d:	53                   	push   %ebx
8010239e:	83 ec 0c             	sub    $0xc,%esp
801023a1:	8b 75 08             	mov    0x8(%ebp),%esi
801023a4:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023a7:	b8 0f 00 00 00       	mov    $0xf,%eax
801023ac:	ba 70 00 00 00       	mov    $0x70,%edx
801023b1:	ee                   	out    %al,(%dx)
801023b2:	b8 0a 00 00 00       	mov    $0xa,%eax
801023b7:	ba 71 00 00 00       	mov    $0x71,%edx
801023bc:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801023bd:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801023c4:	00 00 
  wrv[1] = addr >> 4;
801023c6:	89 f8                	mov    %edi,%eax
801023c8:	c1 e8 04             	shr    $0x4,%eax
801023cb:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapicw(ICRHI, apicid<<24);
801023d1:	c1 e6 18             	shl    $0x18,%esi
801023d4:	89 f2                	mov    %esi,%edx
801023d6:	b8 c4 00 00 00       	mov    $0xc4,%eax
801023db:	e8 f5 fd ff ff       	call   801021d5 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801023e0:	ba 00 c5 00 00       	mov    $0xc500,%edx
801023e5:	b8 c0 00 00 00       	mov    $0xc0,%eax
801023ea:	e8 e6 fd ff ff       	call   801021d5 <lapicw>
  lapicw(ICRLO, INIT | LEVEL);
801023ef:	ba 00 85 00 00       	mov    $0x8500,%edx
801023f4:	b8 c0 00 00 00       	mov    $0xc0,%eax
801023f9:	e8 d7 fd ff ff       	call   801021d5 <lapicw>
  for(i = 0; i < 2; i++){
801023fe:	bb 00 00 00 00       	mov    $0x0,%ebx
80102403:	eb 21                	jmp    80102426 <lapicstartap+0x8e>
    lapicw(ICRHI, apicid<<24);
80102405:	89 f2                	mov    %esi,%edx
80102407:	b8 c4 00 00 00       	mov    $0xc4,%eax
8010240c:	e8 c4 fd ff ff       	call   801021d5 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80102411:	89 fa                	mov    %edi,%edx
80102413:	c1 ea 0c             	shr    $0xc,%edx
80102416:	80 ce 06             	or     $0x6,%dh
80102419:	b8 c0 00 00 00       	mov    $0xc0,%eax
8010241e:	e8 b2 fd ff ff       	call   801021d5 <lapicw>
  for(i = 0; i < 2; i++){
80102423:	83 c3 01             	add    $0x1,%ebx
80102426:	83 fb 01             	cmp    $0x1,%ebx
80102429:	7e da                	jle    80102405 <lapicstartap+0x6d>
}
8010242b:	83 c4 0c             	add    $0xc,%esp
8010242e:	5b                   	pop    %ebx
8010242f:	5e                   	pop    %esi
80102430:	5f                   	pop    %edi
80102431:	5d                   	pop    %ebp
80102432:	c3                   	ret    

80102433 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102433:	55                   	push   %ebp
80102434:	89 e5                	mov    %esp,%ebp
80102436:	57                   	push   %edi
80102437:	56                   	push   %esi
80102438:	53                   	push   %ebx
80102439:	83 ec 3c             	sub    $0x3c,%esp
8010243c:	8b 75 08             	mov    0x8(%ebp),%esi
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
8010243f:	b8 0b 00 00 00       	mov    $0xb,%eax
80102444:	e8 a0 fd ff ff       	call   801021e9 <cmos_read>

  bcd = (sb & (1 << 2)) == 0;
80102449:	83 e0 04             	and    $0x4,%eax
8010244c:	89 c7                	mov    %eax,%edi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010244e:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102451:	e8 a3 fd ff ff       	call   801021f9 <fill_rtcdate>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102456:	b8 0a 00 00 00       	mov    $0xa,%eax
8010245b:	e8 89 fd ff ff       	call   801021e9 <cmos_read>
80102460:	a8 80                	test   $0x80,%al
80102462:	75 ea                	jne    8010244e <cmostime+0x1b>
        continue;
    fill_rtcdate(&t2);
80102464:	8d 5d b8             	lea    -0x48(%ebp),%ebx
80102467:	89 d8                	mov    %ebx,%eax
80102469:	e8 8b fd ff ff       	call   801021f9 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010246e:	83 ec 04             	sub    $0x4,%esp
80102471:	6a 18                	push   $0x18
80102473:	53                   	push   %ebx
80102474:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102477:	50                   	push   %eax
80102478:	e8 c4 17 00 00       	call   80103c41 <memcmp>
8010247d:	83 c4 10             	add    $0x10,%esp
80102480:	85 c0                	test   %eax,%eax
80102482:	75 ca                	jne    8010244e <cmostime+0x1b>
      break;
  }

  // convert
  if(bcd) {
80102484:	85 ff                	test   %edi,%edi
80102486:	75 78                	jne    80102500 <cmostime+0xcd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102488:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010248b:	89 c2                	mov    %eax,%edx
8010248d:	c1 ea 04             	shr    $0x4,%edx
80102490:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102493:	83 e0 0f             	and    $0xf,%eax
80102496:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102499:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(minute);
8010249c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010249f:	89 c2                	mov    %eax,%edx
801024a1:	c1 ea 04             	shr    $0x4,%edx
801024a4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801024a7:	83 e0 0f             	and    $0xf,%eax
801024aa:	8d 04 50             	lea    (%eax,%edx,2),%eax
801024ad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(hour  );
801024b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
801024b3:	89 c2                	mov    %eax,%edx
801024b5:	c1 ea 04             	shr    $0x4,%edx
801024b8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801024bb:	83 e0 0f             	and    $0xf,%eax
801024be:	8d 04 50             	lea    (%eax,%edx,2),%eax
801024c1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(day   );
801024c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801024c7:	89 c2                	mov    %eax,%edx
801024c9:	c1 ea 04             	shr    $0x4,%edx
801024cc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801024cf:	83 e0 0f             	and    $0xf,%eax
801024d2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801024d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(month );
801024d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801024db:	89 c2                	mov    %eax,%edx
801024dd:	c1 ea 04             	shr    $0x4,%edx
801024e0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801024e3:	83 e0 0f             	and    $0xf,%eax
801024e6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801024e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(year  );
801024ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801024ef:	89 c2                	mov    %eax,%edx
801024f1:	c1 ea 04             	shr    $0x4,%edx
801024f4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801024f7:	83 e0 0f             	and    $0xf,%eax
801024fa:	8d 04 50             	lea    (%eax,%edx,2),%eax
801024fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
#undef     CONV
  }

  *r = t1;
80102500:	8b 45 d0             	mov    -0x30(%ebp),%eax
80102503:	89 06                	mov    %eax,(%esi)
80102505:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80102508:	89 46 04             	mov    %eax,0x4(%esi)
8010250b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010250e:	89 46 08             	mov    %eax,0x8(%esi)
80102511:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102514:	89 46 0c             	mov    %eax,0xc(%esi)
80102517:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010251a:	89 46 10             	mov    %eax,0x10(%esi)
8010251d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102520:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102523:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
8010252a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010252d:	5b                   	pop    %ebx
8010252e:	5e                   	pop    %esi
8010252f:	5f                   	pop    %edi
80102530:	5d                   	pop    %ebp
80102531:	c3                   	ret    

80102532 <read_head>:
}

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80102532:	55                   	push   %ebp
80102533:	89 e5                	mov    %esp,%ebp
80102535:	53                   	push   %ebx
80102536:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102539:	ff 35 d4 16 11 80    	push   0x801116d4
8010253f:	ff 35 e4 16 11 80    	push   0x801116e4
80102545:	e8 22 dc ff ff       	call   8010016c <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
8010254a:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010254d:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102553:	83 c4 10             	add    $0x10,%esp
80102556:	ba 00 00 00 00       	mov    $0x0,%edx
8010255b:	eb 0e                	jmp    8010256b <read_head+0x39>
    log.lh.block[i] = lh->block[i];
8010255d:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102561:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102568:	83 c2 01             	add    $0x1,%edx
8010256b:	39 d3                	cmp    %edx,%ebx
8010256d:	7f ee                	jg     8010255d <read_head+0x2b>
  }
  brelse(buf);
8010256f:	83 ec 0c             	sub    $0xc,%esp
80102572:	50                   	push   %eax
80102573:	e8 5d dc ff ff       	call   801001d5 <brelse>
}
80102578:	83 c4 10             	add    $0x10,%esp
8010257b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010257e:	c9                   	leave  
8010257f:	c3                   	ret    

80102580 <install_trans>:
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	57                   	push   %edi
80102584:	56                   	push   %esi
80102585:	53                   	push   %ebx
80102586:	83 ec 0c             	sub    $0xc,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80102589:	be 00 00 00 00       	mov    $0x0,%esi
8010258e:	eb 66                	jmp    801025f6 <install_trans+0x76>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102590:	89 f0                	mov    %esi,%eax
80102592:	03 05 d4 16 11 80    	add    0x801116d4,%eax
80102598:	83 c0 01             	add    $0x1,%eax
8010259b:	83 ec 08             	sub    $0x8,%esp
8010259e:	50                   	push   %eax
8010259f:	ff 35 e4 16 11 80    	push   0x801116e4
801025a5:	e8 c2 db ff ff       	call   8010016c <bread>
801025aa:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801025ac:	83 c4 08             	add    $0x8,%esp
801025af:	ff 34 b5 ec 16 11 80 	push   -0x7feee914(,%esi,4)
801025b6:	ff 35 e4 16 11 80    	push   0x801116e4
801025bc:	e8 ab db ff ff       	call   8010016c <bread>
801025c1:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801025c3:	8d 57 5c             	lea    0x5c(%edi),%edx
801025c6:	8d 40 5c             	lea    0x5c(%eax),%eax
801025c9:	83 c4 0c             	add    $0xc,%esp
801025cc:	68 00 02 00 00       	push   $0x200
801025d1:	52                   	push   %edx
801025d2:	50                   	push   %eax
801025d3:	e8 9e 16 00 00       	call   80103c76 <memmove>
    bwrite(dbuf);  // write dst to disk
801025d8:	89 1c 24             	mov    %ebx,(%esp)
801025db:	e8 ba db ff ff       	call   8010019a <bwrite>
    brelse(lbuf);
801025e0:	89 3c 24             	mov    %edi,(%esp)
801025e3:	e8 ed db ff ff       	call   801001d5 <brelse>
    brelse(dbuf);
801025e8:	89 1c 24             	mov    %ebx,(%esp)
801025eb:	e8 e5 db ff ff       	call   801001d5 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801025f0:	83 c6 01             	add    $0x1,%esi
801025f3:	83 c4 10             	add    $0x10,%esp
801025f6:	39 35 e8 16 11 80    	cmp    %esi,0x801116e8
801025fc:	7f 92                	jg     80102590 <install_trans+0x10>
}
801025fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5f                   	pop    %edi
80102604:	5d                   	pop    %ebp
80102605:	c3                   	ret    

80102606 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102606:	55                   	push   %ebp
80102607:	89 e5                	mov    %esp,%ebp
80102609:	53                   	push   %ebx
8010260a:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
8010260d:	ff 35 d4 16 11 80    	push   0x801116d4
80102613:	ff 35 e4 16 11 80    	push   0x801116e4
80102619:	e8 4e db ff ff       	call   8010016c <bread>
8010261e:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102620:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102626:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102629:	83 c4 10             	add    $0x10,%esp
8010262c:	b8 00 00 00 00       	mov    $0x0,%eax
80102631:	eb 0e                	jmp    80102641 <write_head+0x3b>
    hb->block[i] = log.lh.block[i];
80102633:	8b 14 85 ec 16 11 80 	mov    -0x7feee914(,%eax,4),%edx
8010263a:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
8010263e:	83 c0 01             	add    $0x1,%eax
80102641:	39 c1                	cmp    %eax,%ecx
80102643:	7f ee                	jg     80102633 <write_head+0x2d>
  }
  bwrite(buf);
80102645:	83 ec 0c             	sub    $0xc,%esp
80102648:	53                   	push   %ebx
80102649:	e8 4c db ff ff       	call   8010019a <bwrite>
  brelse(buf);
8010264e:	89 1c 24             	mov    %ebx,(%esp)
80102651:	e8 7f db ff ff       	call   801001d5 <brelse>
}
80102656:	83 c4 10             	add    $0x10,%esp
80102659:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010265c:	c9                   	leave  
8010265d:	c3                   	ret    

8010265e <recover_from_log>:

static void
recover_from_log(void)
{
8010265e:	55                   	push   %ebp
8010265f:	89 e5                	mov    %esp,%ebp
80102661:	83 ec 08             	sub    $0x8,%esp
  read_head();
80102664:	e8 c9 fe ff ff       	call   80102532 <read_head>
  install_trans(); // if committed, copy from log to disk
80102669:	e8 12 ff ff ff       	call   80102580 <install_trans>
  log.lh.n = 0;
8010266e:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102675:	00 00 00 
  write_head(); // clear the log
80102678:	e8 89 ff ff ff       	call   80102606 <write_head>
}
8010267d:	c9                   	leave  
8010267e:	c3                   	ret    

8010267f <write_log>:
}

// Copy modified blocks from cache to log.
static void
write_log(void)
{
8010267f:	55                   	push   %ebp
80102680:	89 e5                	mov    %esp,%ebp
80102682:	57                   	push   %edi
80102683:	56                   	push   %esi
80102684:	53                   	push   %ebx
80102685:	83 ec 0c             	sub    $0xc,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102688:	be 00 00 00 00       	mov    $0x0,%esi
8010268d:	eb 66                	jmp    801026f5 <write_log+0x76>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
8010268f:	89 f0                	mov    %esi,%eax
80102691:	03 05 d4 16 11 80    	add    0x801116d4,%eax
80102697:	83 c0 01             	add    $0x1,%eax
8010269a:	83 ec 08             	sub    $0x8,%esp
8010269d:	50                   	push   %eax
8010269e:	ff 35 e4 16 11 80    	push   0x801116e4
801026a4:	e8 c3 da ff ff       	call   8010016c <bread>
801026a9:	89 c3                	mov    %eax,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801026ab:	83 c4 08             	add    $0x8,%esp
801026ae:	ff 34 b5 ec 16 11 80 	push   -0x7feee914(,%esi,4)
801026b5:	ff 35 e4 16 11 80    	push   0x801116e4
801026bb:	e8 ac da ff ff       	call   8010016c <bread>
801026c0:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801026c2:	8d 50 5c             	lea    0x5c(%eax),%edx
801026c5:	8d 43 5c             	lea    0x5c(%ebx),%eax
801026c8:	83 c4 0c             	add    $0xc,%esp
801026cb:	68 00 02 00 00       	push   $0x200
801026d0:	52                   	push   %edx
801026d1:	50                   	push   %eax
801026d2:	e8 9f 15 00 00       	call   80103c76 <memmove>
    bwrite(to);  // write the log
801026d7:	89 1c 24             	mov    %ebx,(%esp)
801026da:	e8 bb da ff ff       	call   8010019a <bwrite>
    brelse(from);
801026df:	89 3c 24             	mov    %edi,(%esp)
801026e2:	e8 ee da ff ff       	call   801001d5 <brelse>
    brelse(to);
801026e7:	89 1c 24             	mov    %ebx,(%esp)
801026ea:	e8 e6 da ff ff       	call   801001d5 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801026ef:	83 c6 01             	add    $0x1,%esi
801026f2:	83 c4 10             	add    $0x10,%esp
801026f5:	39 35 e8 16 11 80    	cmp    %esi,0x801116e8
801026fb:	7f 92                	jg     8010268f <write_log+0x10>
  }
}
801026fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102700:	5b                   	pop    %ebx
80102701:	5e                   	pop    %esi
80102702:	5f                   	pop    %edi
80102703:	5d                   	pop    %ebp
80102704:	c3                   	ret    

80102705 <commit>:

static void
commit()
{
  if (log.lh.n > 0) {
80102705:	83 3d e8 16 11 80 00 	cmpl   $0x0,0x801116e8
8010270c:	7f 01                	jg     8010270f <commit+0xa>
8010270e:	c3                   	ret    
{
8010270f:	55                   	push   %ebp
80102710:	89 e5                	mov    %esp,%ebp
80102712:	83 ec 08             	sub    $0x8,%esp
    write_log();     // Write modified blocks from cache to log
80102715:	e8 65 ff ff ff       	call   8010267f <write_log>
    write_head();    // Write header to disk -- the real commit
8010271a:	e8 e7 fe ff ff       	call   80102606 <write_head>
    install_trans(); // Now install writes to home locations
8010271f:	e8 5c fe ff ff       	call   80102580 <install_trans>
    log.lh.n = 0;
80102724:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
8010272b:	00 00 00 
    write_head();    // Erase the transaction from the log
8010272e:	e8 d3 fe ff ff       	call   80102606 <write_head>
  }
}
80102733:	c9                   	leave  
80102734:	c3                   	ret    

80102735 <initlog>:
{
80102735:	55                   	push   %ebp
80102736:	89 e5                	mov    %esp,%ebp
80102738:	53                   	push   %ebx
80102739:	83 ec 2c             	sub    $0x2c,%esp
8010273c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010273f:	68 e0 6d 10 80       	push   $0x80106de0
80102744:	68 a0 16 11 80       	push   $0x801116a0
80102749:	e8 c8 12 00 00       	call   80103a16 <initlock>
  readsb(dev, &sb);
8010274e:	83 c4 08             	add    $0x8,%esp
80102751:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102754:	50                   	push   %eax
80102755:	53                   	push   %ebx
80102756:	e8 4b eb ff ff       	call   801012a6 <readsb>
  log.start = sb.logstart;
8010275b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010275e:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102763:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102766:	a3 d8 16 11 80       	mov    %eax,0x801116d8
  log.dev = dev;
8010276b:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  recover_from_log();
80102771:	e8 e8 fe ff ff       	call   8010265e <recover_from_log>
}
80102776:	83 c4 10             	add    $0x10,%esp
80102779:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277c:	c9                   	leave  
8010277d:	c3                   	ret    

8010277e <begin_op>:
{
8010277e:	55                   	push   %ebp
8010277f:	89 e5                	mov    %esp,%ebp
80102781:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102784:	68 a0 16 11 80       	push   $0x801116a0
80102789:	e8 c4 13 00 00       	call   80103b52 <acquire>
8010278e:	83 c4 10             	add    $0x10,%esp
80102791:	eb 15                	jmp    801027a8 <begin_op+0x2a>
      sleep(&log, &log.lock);
80102793:	83 ec 08             	sub    $0x8,%esp
80102796:	68 a0 16 11 80       	push   $0x801116a0
8010279b:	68 a0 16 11 80       	push   $0x801116a0
801027a0:	e8 b2 0e 00 00       	call   80103657 <sleep>
801027a5:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801027a8:	83 3d e0 16 11 80 00 	cmpl   $0x0,0x801116e0
801027af:	75 e2                	jne    80102793 <begin_op+0x15>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801027b1:	a1 dc 16 11 80       	mov    0x801116dc,%eax
801027b6:	83 c0 01             	add    $0x1,%eax
801027b9:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801027bc:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
801027bf:	03 15 e8 16 11 80    	add    0x801116e8,%edx
801027c5:	83 fa 1e             	cmp    $0x1e,%edx
801027c8:	7e 17                	jle    801027e1 <begin_op+0x63>
      sleep(&log, &log.lock);
801027ca:	83 ec 08             	sub    $0x8,%esp
801027cd:	68 a0 16 11 80       	push   $0x801116a0
801027d2:	68 a0 16 11 80       	push   $0x801116a0
801027d7:	e8 7b 0e 00 00       	call   80103657 <sleep>
801027dc:	83 c4 10             	add    $0x10,%esp
801027df:	eb c7                	jmp    801027a8 <begin_op+0x2a>
      log.outstanding += 1;
801027e1:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
801027e6:	83 ec 0c             	sub    $0xc,%esp
801027e9:	68 a0 16 11 80       	push   $0x801116a0
801027ee:	e8 c4 13 00 00       	call   80103bb7 <release>
}
801027f3:	83 c4 10             	add    $0x10,%esp
801027f6:	c9                   	leave  
801027f7:	c3                   	ret    

801027f8 <end_op>:
{
801027f8:	55                   	push   %ebp
801027f9:	89 e5                	mov    %esp,%ebp
801027fb:	53                   	push   %ebx
801027fc:	83 ec 10             	sub    $0x10,%esp
  acquire(&log.lock);
801027ff:	68 a0 16 11 80       	push   $0x801116a0
80102804:	e8 49 13 00 00       	call   80103b52 <acquire>
  log.outstanding -= 1;
80102809:	a1 dc 16 11 80       	mov    0x801116dc,%eax
8010280e:	83 e8 01             	sub    $0x1,%eax
80102811:	a3 dc 16 11 80       	mov    %eax,0x801116dc
  if(log.committing)
80102816:	8b 1d e0 16 11 80    	mov    0x801116e0,%ebx
8010281c:	83 c4 10             	add    $0x10,%esp
8010281f:	85 db                	test   %ebx,%ebx
80102821:	75 2c                	jne    8010284f <end_op+0x57>
  if(log.outstanding == 0){
80102823:	85 c0                	test   %eax,%eax
80102825:	75 35                	jne    8010285c <end_op+0x64>
    log.committing = 1;
80102827:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
8010282e:	00 00 00 
    do_commit = 1;
80102831:	bb 01 00 00 00       	mov    $0x1,%ebx
  release(&log.lock);
80102836:	83 ec 0c             	sub    $0xc,%esp
80102839:	68 a0 16 11 80       	push   $0x801116a0
8010283e:	e8 74 13 00 00       	call   80103bb7 <release>
  if(do_commit){
80102843:	83 c4 10             	add    $0x10,%esp
80102846:	85 db                	test   %ebx,%ebx
80102848:	75 24                	jne    8010286e <end_op+0x76>
}
8010284a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010284d:	c9                   	leave  
8010284e:	c3                   	ret    
    panic("log.committing");
8010284f:	83 ec 0c             	sub    $0xc,%esp
80102852:	68 e4 6d 10 80       	push   $0x80106de4
80102857:	e8 ec da ff ff       	call   80100348 <panic>
    wakeup(&log);
8010285c:	83 ec 0c             	sub    $0xc,%esp
8010285f:	68 a0 16 11 80       	push   $0x801116a0
80102864:	e8 53 0f 00 00       	call   801037bc <wakeup>
80102869:	83 c4 10             	add    $0x10,%esp
8010286c:	eb c8                	jmp    80102836 <end_op+0x3e>
    commit();
8010286e:	e8 92 fe ff ff       	call   80102705 <commit>
    acquire(&log.lock);
80102873:	83 ec 0c             	sub    $0xc,%esp
80102876:	68 a0 16 11 80       	push   $0x801116a0
8010287b:	e8 d2 12 00 00       	call   80103b52 <acquire>
    log.committing = 0;
80102880:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102887:	00 00 00 
    wakeup(&log);
8010288a:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102891:	e8 26 0f 00 00       	call   801037bc <wakeup>
    release(&log.lock);
80102896:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
8010289d:	e8 15 13 00 00       	call   80103bb7 <release>
801028a2:	83 c4 10             	add    $0x10,%esp
}
801028a5:	eb a3                	jmp    8010284a <end_op+0x52>

801028a7 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801028a7:	55                   	push   %ebp
801028a8:	89 e5                	mov    %esp,%ebp
801028aa:	53                   	push   %ebx
801028ab:	83 ec 04             	sub    $0x4,%esp
801028ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801028b1:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
801028b7:	83 fa 1d             	cmp    $0x1d,%edx
801028ba:	7f 2c                	jg     801028e8 <log_write+0x41>
801028bc:	a1 d8 16 11 80       	mov    0x801116d8,%eax
801028c1:	83 e8 01             	sub    $0x1,%eax
801028c4:	39 c2                	cmp    %eax,%edx
801028c6:	7d 20                	jge    801028e8 <log_write+0x41>
    panic("too big a transaction");
  if (log.outstanding < 1)
801028c8:	83 3d dc 16 11 80 00 	cmpl   $0x0,0x801116dc
801028cf:	7e 24                	jle    801028f5 <log_write+0x4e>
    panic("log_write outside of trans");

  acquire(&log.lock);
801028d1:	83 ec 0c             	sub    $0xc,%esp
801028d4:	68 a0 16 11 80       	push   $0x801116a0
801028d9:	e8 74 12 00 00       	call   80103b52 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801028de:	83 c4 10             	add    $0x10,%esp
801028e1:	b8 00 00 00 00       	mov    $0x0,%eax
801028e6:	eb 1d                	jmp    80102905 <log_write+0x5e>
    panic("too big a transaction");
801028e8:	83 ec 0c             	sub    $0xc,%esp
801028eb:	68 f3 6d 10 80       	push   $0x80106df3
801028f0:	e8 53 da ff ff       	call   80100348 <panic>
    panic("log_write outside of trans");
801028f5:	83 ec 0c             	sub    $0xc,%esp
801028f8:	68 09 6e 10 80       	push   $0x80106e09
801028fd:	e8 46 da ff ff       	call   80100348 <panic>
  for (i = 0; i < log.lh.n; i++) {
80102902:	83 c0 01             	add    $0x1,%eax
80102905:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
8010290b:	39 c2                	cmp    %eax,%edx
8010290d:	7e 0c                	jle    8010291b <log_write+0x74>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
8010290f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102912:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
80102919:	75 e7                	jne    80102902 <log_write+0x5b>
      break;
  }
  log.lh.block[i] = b->blockno;
8010291b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010291e:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
80102925:	39 c2                	cmp    %eax,%edx
80102927:	74 18                	je     80102941 <log_write+0x9a>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102929:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
8010292c:	83 ec 0c             	sub    $0xc,%esp
8010292f:	68 a0 16 11 80       	push   $0x801116a0
80102934:	e8 7e 12 00 00       	call   80103bb7 <release>
}
80102939:	83 c4 10             	add    $0x10,%esp
8010293c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010293f:	c9                   	leave  
80102940:	c3                   	ret    
    log.lh.n++;
80102941:	83 c2 01             	add    $0x1,%edx
80102944:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
8010294a:	eb dd                	jmp    80102929 <log_write+0x82>

8010294c <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
8010294c:	55                   	push   %ebp
8010294d:	89 e5                	mov    %esp,%ebp
8010294f:	53                   	push   %ebx
80102950:	83 ec 08             	sub    $0x8,%esp

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102953:	68 8a 00 00 00       	push   $0x8a
80102958:	68 8c a4 10 80       	push   $0x8010a48c
8010295d:	68 00 70 00 80       	push   $0x80007000
80102962:	e8 0f 13 00 00       	call   80103c76 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102967:	83 c4 10             	add    $0x10,%esp
8010296a:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
8010296f:	eb 06                	jmp    80102977 <startothers+0x2b>
80102971:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102977:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
8010297e:	00 00 00 
80102981:	05 a0 17 11 80       	add    $0x801117a0,%eax
80102986:	39 d8                	cmp    %ebx,%eax
80102988:	76 4c                	jbe    801029d6 <startothers+0x8a>
    if(c == mycpu())  // We've started already.
8010298a:	e8 af 07 00 00       	call   8010313e <mycpu>
8010298f:	39 c3                	cmp    %eax,%ebx
80102991:	74 de                	je     80102971 <startothers+0x25>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102993:	e8 0b f7 ff ff       	call   801020a3 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102998:	05 00 10 00 00       	add    $0x1000,%eax
8010299d:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
801029a2:	c7 05 f8 6f 00 80 1a 	movl   $0x80102a1a,0x80006ff8
801029a9:	2a 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801029ac:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801029b3:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
801029b6:	83 ec 08             	sub    $0x8,%esp
801029b9:	68 00 70 00 00       	push   $0x7000
801029be:	0f b6 03             	movzbl (%ebx),%eax
801029c1:	50                   	push   %eax
801029c2:	e8 d1 f9 ff ff       	call   80102398 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801029c7:	83 c4 10             	add    $0x10,%esp
801029ca:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801029d0:	85 c0                	test   %eax,%eax
801029d2:	74 f6                	je     801029ca <startothers+0x7e>
801029d4:	eb 9b                	jmp    80102971 <startothers+0x25>
      ;
  }
}
801029d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029d9:	c9                   	leave  
801029da:	c3                   	ret    

801029db <mpmain>:
{
801029db:	55                   	push   %ebp
801029dc:	89 e5                	mov    %esp,%ebp
801029de:	53                   	push   %ebx
801029df:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801029e2:	e8 b3 07 00 00       	call   8010319a <cpuid>
801029e7:	89 c3                	mov    %eax,%ebx
801029e9:	e8 ac 07 00 00       	call   8010319a <cpuid>
801029ee:	83 ec 04             	sub    $0x4,%esp
801029f1:	53                   	push   %ebx
801029f2:	50                   	push   %eax
801029f3:	68 24 6e 10 80       	push   $0x80106e24
801029f8:	e8 0a dc ff ff       	call   80100607 <cprintf>
  idtinit();       // load idt register
801029fd:	e8 69 24 00 00       	call   80104e6b <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102a02:	e8 37 07 00 00       	call   8010313e <mycpu>
80102a07:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102a09:	b8 01 00 00 00       	mov    $0x1,%eax
80102a0e:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102a15:	e8 18 0a 00 00       	call   80103432 <scheduler>

80102a1a <mpenter>:
{
80102a1a:	55                   	push   %ebp
80102a1b:	89 e5                	mov    %esp,%ebp
80102a1d:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102a20:	e8 97 35 00 00       	call   80105fbc <switchkvm>
  seginit();
80102a25:	e8 1d 33 00 00       	call   80105d47 <seginit>
  lapicinit();
80102a2a:	e8 25 f8 ff ff       	call   80102254 <lapicinit>
  mpmain();
80102a2f:	e8 a7 ff ff ff       	call   801029db <mpmain>

80102a34 <main>:
{
80102a34:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102a38:	83 e4 f0             	and    $0xfffffff0,%esp
80102a3b:	ff 71 fc             	push   -0x4(%ecx)
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	51                   	push   %ecx
80102a42:	83 ec 0c             	sub    $0xc,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102a45:	68 00 00 40 80       	push   $0x80400000
80102a4a:	68 d0 54 11 80       	push   $0x801154d0
80102a4f:	e8 fd f5 ff ff       	call   80102051 <kinit1>
  kvmalloc();      // kernel page table
80102a54:	e8 35 3a 00 00       	call   8010648e <kvmalloc>
  mpinit();        // detect other processors
80102a59:	e8 c1 01 00 00       	call   80102c1f <mpinit>
  lapicinit();     // interrupt controller
80102a5e:	e8 f1 f7 ff ff       	call   80102254 <lapicinit>
  seginit();       // segment descriptors
80102a63:	e8 df 32 00 00       	call   80105d47 <seginit>
  picinit();       // disable pic
80102a68:	e8 88 02 00 00       	call   80102cf5 <picinit>
  ioapicinit();    // another interrupt controller
80102a6d:	e8 6b f4 ff ff       	call   80101edd <ioapicinit>
  consoleinit();   // console hardware
80102a72:	e8 13 de ff ff       	call   8010088a <consoleinit>
  uartinit();      // serial port
80102a77:	e8 b8 26 00 00       	call   80105134 <uartinit>
  pinit();         // process table
80102a7c:	e8 a3 06 00 00       	call   80103124 <pinit>
  tvinit();        // trap vectors
80102a81:	e8 e0 22 00 00       	call   80104d66 <tvinit>
  binit();         // buffer cache
80102a86:	e8 69 d6 ff ff       	call   801000f4 <binit>
  fileinit();      // file table
80102a8b:	e8 73 e1 ff ff       	call   80100c03 <fileinit>
  ideinit();       // disk 
80102a90:	e8 54 f2 ff ff       	call   80101ce9 <ideinit>
  startothers();   // start other processors
80102a95:	e8 b2 fe ff ff       	call   8010294c <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102a9a:	83 c4 08             	add    $0x8,%esp
80102a9d:	68 00 00 00 8e       	push   $0x8e000000
80102aa2:	68 00 00 40 80       	push   $0x80400000
80102aa7:	e8 d7 f5 ff ff       	call   80102083 <kinit2>
  userinit();      // first user process
80102aac:	e8 27 07 00 00       	call   801031d8 <userinit>
  mpmain();        // finish this processor's setup
80102ab1:	e8 25 ff ff ff       	call   801029db <mpmain>

80102ab6 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80102ab6:	55                   	push   %ebp
80102ab7:	89 e5                	mov    %esp,%ebp
80102ab9:	56                   	push   %esi
80102aba:	53                   	push   %ebx
80102abb:	89 c6                	mov    %eax,%esi
  int i, sum;

  sum = 0;
80102abd:	b8 00 00 00 00       	mov    $0x0,%eax
  for(i=0; i<len; i++)
80102ac2:	b9 00 00 00 00       	mov    $0x0,%ecx
80102ac7:	eb 09                	jmp    80102ad2 <sum+0x1c>
    sum += addr[i];
80102ac9:	0f b6 1c 0e          	movzbl (%esi,%ecx,1),%ebx
80102acd:	01 d8                	add    %ebx,%eax
  for(i=0; i<len; i++)
80102acf:	83 c1 01             	add    $0x1,%ecx
80102ad2:	39 d1                	cmp    %edx,%ecx
80102ad4:	7c f3                	jl     80102ac9 <sum+0x13>
  return sum;
}
80102ad6:	5b                   	pop    %ebx
80102ad7:	5e                   	pop    %esi
80102ad8:	5d                   	pop    %ebp
80102ad9:	c3                   	ret    

80102ada <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102ada:	55                   	push   %ebp
80102adb:	89 e5                	mov    %esp,%ebp
80102add:	56                   	push   %esi
80102ade:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80102adf:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80102ae5:	89 f3                	mov    %esi,%ebx
  e = addr+len;
80102ae7:	01 d6                	add    %edx,%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80102ae9:	eb 03                	jmp    80102aee <mpsearch1+0x14>
80102aeb:	83 c3 10             	add    $0x10,%ebx
80102aee:	39 f3                	cmp    %esi,%ebx
80102af0:	73 29                	jae    80102b1b <mpsearch1+0x41>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102af2:	83 ec 04             	sub    $0x4,%esp
80102af5:	6a 04                	push   $0x4
80102af7:	68 38 6e 10 80       	push   $0x80106e38
80102afc:	53                   	push   %ebx
80102afd:	e8 3f 11 00 00       	call   80103c41 <memcmp>
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	85 c0                	test   %eax,%eax
80102b07:	75 e2                	jne    80102aeb <mpsearch1+0x11>
80102b09:	ba 10 00 00 00       	mov    $0x10,%edx
80102b0e:	89 d8                	mov    %ebx,%eax
80102b10:	e8 a1 ff ff ff       	call   80102ab6 <sum>
80102b15:	84 c0                	test   %al,%al
80102b17:	75 d2                	jne    80102aeb <mpsearch1+0x11>
80102b19:	eb 05                	jmp    80102b20 <mpsearch1+0x46>
      return (struct mp*)p;
  return 0;
80102b1b:	bb 00 00 00 00       	mov    $0x0,%ebx
}
80102b20:	89 d8                	mov    %ebx,%eax
80102b22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b25:	5b                   	pop    %ebx
80102b26:	5e                   	pop    %esi
80102b27:	5d                   	pop    %ebp
80102b28:	c3                   	ret    

80102b29 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80102b29:	55                   	push   %ebp
80102b2a:	89 e5                	mov    %esp,%ebp
80102b2c:	83 ec 08             	sub    $0x8,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102b2f:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102b36:	c1 e0 08             	shl    $0x8,%eax
80102b39:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102b40:	09 d0                	or     %edx,%eax
80102b42:	c1 e0 04             	shl    $0x4,%eax
80102b45:	74 1f                	je     80102b66 <mpsearch+0x3d>
    if((mp = mpsearch1(p, 1024)))
80102b47:	ba 00 04 00 00       	mov    $0x400,%edx
80102b4c:	e8 89 ff ff ff       	call   80102ada <mpsearch1>
80102b51:	85 c0                	test   %eax,%eax
80102b53:	75 0f                	jne    80102b64 <mpsearch+0x3b>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80102b55:	ba 00 00 01 00       	mov    $0x10000,%edx
80102b5a:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102b5f:	e8 76 ff ff ff       	call   80102ada <mpsearch1>
}
80102b64:	c9                   	leave  
80102b65:	c3                   	ret    
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102b66:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102b6d:	c1 e0 08             	shl    $0x8,%eax
80102b70:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102b77:	09 d0                	or     %edx,%eax
80102b79:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102b7c:	2d 00 04 00 00       	sub    $0x400,%eax
80102b81:	ba 00 04 00 00       	mov    $0x400,%edx
80102b86:	e8 4f ff ff ff       	call   80102ada <mpsearch1>
80102b8b:	85 c0                	test   %eax,%eax
80102b8d:	75 d5                	jne    80102b64 <mpsearch+0x3b>
80102b8f:	eb c4                	jmp    80102b55 <mpsearch+0x2c>

80102b91 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80102b91:	55                   	push   %ebp
80102b92:	89 e5                	mov    %esp,%ebp
80102b94:	57                   	push   %edi
80102b95:	56                   	push   %esi
80102b96:	53                   	push   %ebx
80102b97:	83 ec 1c             	sub    $0x1c,%esp
80102b9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102b9d:	e8 87 ff ff ff       	call   80102b29 <mpsearch>
80102ba2:	89 c3                	mov    %eax,%ebx
80102ba4:	85 c0                	test   %eax,%eax
80102ba6:	74 5a                	je     80102c02 <mpconfig+0x71>
80102ba8:	8b 70 04             	mov    0x4(%eax),%esi
80102bab:	85 f6                	test   %esi,%esi
80102bad:	74 57                	je     80102c06 <mpconfig+0x75>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102baf:	8d be 00 00 00 80    	lea    -0x80000000(%esi),%edi
  if(memcmp(conf, "PCMP", 4) != 0)
80102bb5:	83 ec 04             	sub    $0x4,%esp
80102bb8:	6a 04                	push   $0x4
80102bba:	68 3d 6e 10 80       	push   $0x80106e3d
80102bbf:	57                   	push   %edi
80102bc0:	e8 7c 10 00 00       	call   80103c41 <memcmp>
80102bc5:	83 c4 10             	add    $0x10,%esp
80102bc8:	85 c0                	test   %eax,%eax
80102bca:	75 3e                	jne    80102c0a <mpconfig+0x79>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80102bcc:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80102bd3:	3c 01                	cmp    $0x1,%al
80102bd5:	0f 95 c2             	setne  %dl
80102bd8:	3c 04                	cmp    $0x4,%al
80102bda:	0f 95 c0             	setne  %al
80102bdd:	84 c2                	test   %al,%dl
80102bdf:	75 30                	jne    80102c11 <mpconfig+0x80>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102be1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80102be8:	89 f8                	mov    %edi,%eax
80102bea:	e8 c7 fe ff ff       	call   80102ab6 <sum>
80102bef:	84 c0                	test   %al,%al
80102bf1:	75 25                	jne    80102c18 <mpconfig+0x87>
    return 0;
  *pmp = mp;
80102bf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102bf6:	89 18                	mov    %ebx,(%eax)
  return conf;
}
80102bf8:	89 f8                	mov    %edi,%eax
80102bfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bfd:	5b                   	pop    %ebx
80102bfe:	5e                   	pop    %esi
80102bff:	5f                   	pop    %edi
80102c00:	5d                   	pop    %ebp
80102c01:	c3                   	ret    
    return 0;
80102c02:	89 c7                	mov    %eax,%edi
80102c04:	eb f2                	jmp    80102bf8 <mpconfig+0x67>
80102c06:	89 f7                	mov    %esi,%edi
80102c08:	eb ee                	jmp    80102bf8 <mpconfig+0x67>
    return 0;
80102c0a:	bf 00 00 00 00       	mov    $0x0,%edi
80102c0f:	eb e7                	jmp    80102bf8 <mpconfig+0x67>
    return 0;
80102c11:	bf 00 00 00 00       	mov    $0x0,%edi
80102c16:	eb e0                	jmp    80102bf8 <mpconfig+0x67>
    return 0;
80102c18:	bf 00 00 00 00       	mov    $0x0,%edi
80102c1d:	eb d9                	jmp    80102bf8 <mpconfig+0x67>

80102c1f <mpinit>:

void
mpinit(void)
{
80102c1f:	55                   	push   %ebp
80102c20:	89 e5                	mov    %esp,%ebp
80102c22:	57                   	push   %edi
80102c23:	56                   	push   %esi
80102c24:	53                   	push   %ebx
80102c25:	83 ec 1c             	sub    $0x1c,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102c28:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80102c2b:	e8 61 ff ff ff       	call   80102b91 <mpconfig>
80102c30:	85 c0                	test   %eax,%eax
80102c32:	74 19                	je     80102c4d <mpinit+0x2e>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102c34:	8b 50 24             	mov    0x24(%eax),%edx
80102c37:	89 15 80 16 11 80    	mov    %edx,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c3d:	8d 50 2c             	lea    0x2c(%eax),%edx
80102c40:	0f b7 48 04          	movzwl 0x4(%eax),%ecx
80102c44:	01 c1                	add    %eax,%ecx
  ismp = 1;
80102c46:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c4b:	eb 20                	jmp    80102c6d <mpinit+0x4e>
    panic("Expect to run on an SMP");
80102c4d:	83 ec 0c             	sub    $0xc,%esp
80102c50:	68 42 6e 10 80       	push   $0x80106e42
80102c55:	e8 ee d6 ff ff       	call   80100348 <panic>
    switch(*p){
80102c5a:	bb 00 00 00 00       	mov    $0x0,%ebx
80102c5f:	eb 0c                	jmp    80102c6d <mpinit+0x4e>
80102c61:	83 e8 03             	sub    $0x3,%eax
80102c64:	3c 01                	cmp    $0x1,%al
80102c66:	76 1a                	jbe    80102c82 <mpinit+0x63>
80102c68:	bb 00 00 00 00       	mov    $0x0,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c6d:	39 ca                	cmp    %ecx,%edx
80102c6f:	73 4d                	jae    80102cbe <mpinit+0x9f>
    switch(*p){
80102c71:	0f b6 02             	movzbl (%edx),%eax
80102c74:	3c 02                	cmp    $0x2,%al
80102c76:	74 38                	je     80102cb0 <mpinit+0x91>
80102c78:	77 e7                	ja     80102c61 <mpinit+0x42>
80102c7a:	84 c0                	test   %al,%al
80102c7c:	74 09                	je     80102c87 <mpinit+0x68>
80102c7e:	3c 01                	cmp    $0x1,%al
80102c80:	75 d8                	jne    80102c5a <mpinit+0x3b>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102c82:	83 c2 08             	add    $0x8,%edx
      continue;
80102c85:	eb e6                	jmp    80102c6d <mpinit+0x4e>
      if(ncpu < NCPU) {
80102c87:	8b 35 84 17 11 80    	mov    0x80111784,%esi
80102c8d:	83 fe 07             	cmp    $0x7,%esi
80102c90:	7f 19                	jg     80102cab <mpinit+0x8c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102c92:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80102c96:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
80102c9c:	88 87 a0 17 11 80    	mov    %al,-0x7feee860(%edi)
        ncpu++;
80102ca2:	83 c6 01             	add    $0x1,%esi
80102ca5:	89 35 84 17 11 80    	mov    %esi,0x80111784
      p += sizeof(struct mpproc);
80102cab:	83 c2 14             	add    $0x14,%edx
      continue;
80102cae:	eb bd                	jmp    80102c6d <mpinit+0x4e>
      ioapicid = ioapic->apicno;
80102cb0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80102cb4:	a2 80 17 11 80       	mov    %al,0x80111780
      p += sizeof(struct mpioapic);
80102cb9:	83 c2 08             	add    $0x8,%edx
      continue;
80102cbc:	eb af                	jmp    80102c6d <mpinit+0x4e>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102cbe:	85 db                	test   %ebx,%ebx
80102cc0:	74 26                	je     80102ce8 <mpinit+0xc9>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102cc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102cc5:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80102cc9:	74 15                	je     80102ce0 <mpinit+0xc1>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ccb:	b8 70 00 00 00       	mov    $0x70,%eax
80102cd0:	ba 22 00 00 00       	mov    $0x22,%edx
80102cd5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cd6:	ba 23 00 00 00       	mov    $0x23,%edx
80102cdb:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102cdc:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cdf:	ee                   	out    %al,(%dx)
  }
}
80102ce0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ce3:	5b                   	pop    %ebx
80102ce4:	5e                   	pop    %esi
80102ce5:	5f                   	pop    %edi
80102ce6:	5d                   	pop    %ebp
80102ce7:	c3                   	ret    
    panic("Didn't find a suitable machine");
80102ce8:	83 ec 0c             	sub    $0xc,%esp
80102ceb:	68 5c 6e 10 80       	push   $0x80106e5c
80102cf0:	e8 53 d6 ff ff       	call   80100348 <panic>

80102cf5 <picinit>:
80102cf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102cfa:	ba 21 00 00 00       	mov    $0x21,%edx
80102cff:	ee                   	out    %al,(%dx)
80102d00:	ba a1 00 00 00       	mov    $0xa1,%edx
80102d05:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102d06:	c3                   	ret    

80102d07 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102d07:	55                   	push   %ebp
80102d08:	89 e5                	mov    %esp,%ebp
80102d0a:	57                   	push   %edi
80102d0b:	56                   	push   %esi
80102d0c:	53                   	push   %ebx
80102d0d:	83 ec 0c             	sub    $0xc,%esp
80102d10:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d13:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102d16:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102d1c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102d22:	e8 f6 de ff ff       	call   80100c1d <filealloc>
80102d27:	89 03                	mov    %eax,(%ebx)
80102d29:	85 c0                	test   %eax,%eax
80102d2b:	0f 84 88 00 00 00    	je     80102db9 <pipealloc+0xb2>
80102d31:	e8 e7 de ff ff       	call   80100c1d <filealloc>
80102d36:	89 06                	mov    %eax,(%esi)
80102d38:	85 c0                	test   %eax,%eax
80102d3a:	74 7d                	je     80102db9 <pipealloc+0xb2>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102d3c:	e8 62 f3 ff ff       	call   801020a3 <kalloc>
80102d41:	89 c7                	mov    %eax,%edi
80102d43:	85 c0                	test   %eax,%eax
80102d45:	74 72                	je     80102db9 <pipealloc+0xb2>
    goto bad;
  p->readopen = 1;
80102d47:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102d4e:	00 00 00 
  p->writeopen = 1;
80102d51:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102d58:	00 00 00 
  p->nwrite = 0;
80102d5b:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102d62:	00 00 00 
  p->nread = 0;
80102d65:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102d6c:	00 00 00 
  initlock(&p->lock, "pipe");
80102d6f:	83 ec 08             	sub    $0x8,%esp
80102d72:	68 7b 6e 10 80       	push   $0x80106e7b
80102d77:	50                   	push   %eax
80102d78:	e8 99 0c 00 00       	call   80103a16 <initlock>
  (*f0)->type = FD_PIPE;
80102d7d:	8b 03                	mov    (%ebx),%eax
80102d7f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80102d85:	8b 03                	mov    (%ebx),%eax
80102d87:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80102d8b:	8b 03                	mov    (%ebx),%eax
80102d8d:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80102d91:	8b 03                	mov    (%ebx),%eax
80102d93:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80102d96:	8b 06                	mov    (%esi),%eax
80102d98:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80102d9e:	8b 06                	mov    (%esi),%eax
80102da0:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80102da4:	8b 06                	mov    (%esi),%eax
80102da6:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80102daa:	8b 06                	mov    (%esi),%eax
80102dac:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
80102daf:	83 c4 10             	add    $0x10,%esp
80102db2:	b8 00 00 00 00       	mov    $0x0,%eax
80102db7:	eb 29                	jmp    80102de2 <pipealloc+0xdb>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102db9:	8b 03                	mov    (%ebx),%eax
80102dbb:	85 c0                	test   %eax,%eax
80102dbd:	74 0c                	je     80102dcb <pipealloc+0xc4>
    fileclose(*f0);
80102dbf:	83 ec 0c             	sub    $0xc,%esp
80102dc2:	50                   	push   %eax
80102dc3:	e8 fb de ff ff       	call   80100cc3 <fileclose>
80102dc8:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80102dcb:	8b 06                	mov    (%esi),%eax
80102dcd:	85 c0                	test   %eax,%eax
80102dcf:	74 19                	je     80102dea <pipealloc+0xe3>
    fileclose(*f1);
80102dd1:	83 ec 0c             	sub    $0xc,%esp
80102dd4:	50                   	push   %eax
80102dd5:	e8 e9 de ff ff       	call   80100cc3 <fileclose>
80102dda:	83 c4 10             	add    $0x10,%esp
  return -1;
80102ddd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102de2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102de5:	5b                   	pop    %ebx
80102de6:	5e                   	pop    %esi
80102de7:	5f                   	pop    %edi
80102de8:	5d                   	pop    %ebp
80102de9:	c3                   	ret    
  return -1;
80102dea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102def:	eb f1                	jmp    80102de2 <pipealloc+0xdb>

80102df1 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80102df1:	55                   	push   %ebp
80102df2:	89 e5                	mov    %esp,%ebp
80102df4:	53                   	push   %ebx
80102df5:	83 ec 10             	sub    $0x10,%esp
80102df8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&p->lock);
80102dfb:	53                   	push   %ebx
80102dfc:	e8 51 0d 00 00       	call   80103b52 <acquire>
  if(writable){
80102e01:	83 c4 10             	add    $0x10,%esp
80102e04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102e08:	74 3f                	je     80102e49 <pipeclose+0x58>
    p->writeopen = 0;
80102e0a:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80102e11:	00 00 00 
    wakeup(&p->nread);
80102e14:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102e1a:	83 ec 0c             	sub    $0xc,%esp
80102e1d:	50                   	push   %eax
80102e1e:	e8 99 09 00 00       	call   801037bc <wakeup>
80102e23:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80102e26:	83 bb 3c 02 00 00 00 	cmpl   $0x0,0x23c(%ebx)
80102e2d:	75 09                	jne    80102e38 <pipeclose+0x47>
80102e2f:	83 bb 40 02 00 00 00 	cmpl   $0x0,0x240(%ebx)
80102e36:	74 2f                	je     80102e67 <pipeclose+0x76>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102e38:	83 ec 0c             	sub    $0xc,%esp
80102e3b:	53                   	push   %ebx
80102e3c:	e8 76 0d 00 00       	call   80103bb7 <release>
80102e41:	83 c4 10             	add    $0x10,%esp
}
80102e44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e47:	c9                   	leave  
80102e48:	c3                   	ret    
    p->readopen = 0;
80102e49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80102e50:	00 00 00 
    wakeup(&p->nwrite);
80102e53:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102e59:	83 ec 0c             	sub    $0xc,%esp
80102e5c:	50                   	push   %eax
80102e5d:	e8 5a 09 00 00       	call   801037bc <wakeup>
80102e62:	83 c4 10             	add    $0x10,%esp
80102e65:	eb bf                	jmp    80102e26 <pipeclose+0x35>
    release(&p->lock);
80102e67:	83 ec 0c             	sub    $0xc,%esp
80102e6a:	53                   	push   %ebx
80102e6b:	e8 47 0d 00 00       	call   80103bb7 <release>
    kfree((char*)p);
80102e70:	89 1c 24             	mov    %ebx,(%esp)
80102e73:	e8 14 f1 ff ff       	call   80101f8c <kfree>
80102e78:	83 c4 10             	add    $0x10,%esp
80102e7b:	eb c7                	jmp    80102e44 <pipeclose+0x53>

80102e7d <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80102e7d:	55                   	push   %ebp
80102e7e:	89 e5                	mov    %esp,%ebp
80102e80:	57                   	push   %edi
80102e81:	56                   	push   %esi
80102e82:	53                   	push   %ebx
80102e83:	83 ec 18             	sub    $0x18,%esp
80102e86:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e89:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  acquire(&p->lock);
80102e8c:	53                   	push   %ebx
80102e8d:	e8 c0 0c 00 00       	call   80103b52 <acquire>
  for(i = 0; i < n; i++){
80102e92:	83 c4 10             	add    $0x10,%esp
80102e95:	bf 00 00 00 00       	mov    $0x0,%edi
80102e9a:	39 f7                	cmp    %esi,%edi
80102e9c:	7c 40                	jl     80102ede <pipewrite+0x61>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80102e9e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102ea4:	83 ec 0c             	sub    $0xc,%esp
80102ea7:	50                   	push   %eax
80102ea8:	e8 0f 09 00 00       	call   801037bc <wakeup>
  release(&p->lock);
80102ead:	89 1c 24             	mov    %ebx,(%esp)
80102eb0:	e8 02 0d 00 00       	call   80103bb7 <release>
  return n;
80102eb5:	83 c4 10             	add    $0x10,%esp
80102eb8:	89 f0                	mov    %esi,%eax
80102eba:	eb 5c                	jmp    80102f18 <pipewrite+0x9b>
      wakeup(&p->nread);
80102ebc:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102ec2:	83 ec 0c             	sub    $0xc,%esp
80102ec5:	50                   	push   %eax
80102ec6:	e8 f1 08 00 00       	call   801037bc <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102ecb:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102ed1:	83 c4 08             	add    $0x8,%esp
80102ed4:	53                   	push   %ebx
80102ed5:	50                   	push   %eax
80102ed6:	e8 7c 07 00 00       	call   80103657 <sleep>
80102edb:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102ede:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80102ee4:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102eea:	05 00 02 00 00       	add    $0x200,%eax
80102eef:	39 c2                	cmp    %eax,%edx
80102ef1:	75 2d                	jne    80102f20 <pipewrite+0xa3>
      if(p->readopen == 0 || myproc()->killed){
80102ef3:	83 bb 3c 02 00 00 00 	cmpl   $0x0,0x23c(%ebx)
80102efa:	74 0b                	je     80102f07 <pipewrite+0x8a>
80102efc:	e8 b4 02 00 00       	call   801031b5 <myproc>
80102f01:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80102f05:	74 b5                	je     80102ebc <pipewrite+0x3f>
        release(&p->lock);
80102f07:	83 ec 0c             	sub    $0xc,%esp
80102f0a:	53                   	push   %ebx
80102f0b:	e8 a7 0c 00 00       	call   80103bb7 <release>
        return -1;
80102f10:	83 c4 10             	add    $0x10,%esp
80102f13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102f18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1b:	5b                   	pop    %ebx
80102f1c:	5e                   	pop    %esi
80102f1d:	5f                   	pop    %edi
80102f1e:	5d                   	pop    %ebp
80102f1f:	c3                   	ret    
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80102f20:	8d 42 01             	lea    0x1(%edx),%eax
80102f23:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80102f29:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80102f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f32:	0f b6 04 38          	movzbl (%eax,%edi,1),%eax
80102f36:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80102f3a:	83 c7 01             	add    $0x1,%edi
80102f3d:	e9 58 ff ff ff       	jmp    80102e9a <pipewrite+0x1d>

80102f42 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80102f42:	55                   	push   %ebp
80102f43:	89 e5                	mov    %esp,%ebp
80102f45:	57                   	push   %edi
80102f46:	56                   	push   %esi
80102f47:	53                   	push   %ebx
80102f48:	83 ec 18             	sub    $0x18,%esp
80102f4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102f4e:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80102f51:	53                   	push   %ebx
80102f52:	e8 fb 0b 00 00       	call   80103b52 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102f57:	83 c4 10             	add    $0x10,%esp
80102f5a:	eb 13                	jmp    80102f6f <piperead+0x2d>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80102f5c:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102f62:	83 ec 08             	sub    $0x8,%esp
80102f65:	53                   	push   %ebx
80102f66:	50                   	push   %eax
80102f67:	e8 eb 06 00 00       	call   80103657 <sleep>
80102f6c:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102f6f:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102f75:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80102f7b:	75 78                	jne    80102ff5 <piperead+0xb3>
80102f7d:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
80102f83:	85 f6                	test   %esi,%esi
80102f85:	74 37                	je     80102fbe <piperead+0x7c>
    if(myproc()->killed){
80102f87:	e8 29 02 00 00       	call   801031b5 <myproc>
80102f8c:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80102f90:	74 ca                	je     80102f5c <piperead+0x1a>
      release(&p->lock);
80102f92:	83 ec 0c             	sub    $0xc,%esp
80102f95:	53                   	push   %ebx
80102f96:	e8 1c 0c 00 00       	call   80103bb7 <release>
      return -1;
80102f9b:	83 c4 10             	add    $0x10,%esp
80102f9e:	be ff ff ff ff       	mov    $0xffffffff,%esi
80102fa3:	eb 46                	jmp    80102feb <piperead+0xa9>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80102fa5:	8d 50 01             	lea    0x1(%eax),%edx
80102fa8:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
80102fae:	25 ff 01 00 00       	and    $0x1ff,%eax
80102fb3:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80102fb8:	88 04 37             	mov    %al,(%edi,%esi,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80102fbb:	83 c6 01             	add    $0x1,%esi
80102fbe:	3b 75 10             	cmp    0x10(%ebp),%esi
80102fc1:	7d 0e                	jge    80102fd1 <piperead+0x8f>
    if(p->nread == p->nwrite)
80102fc3:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102fc9:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80102fcf:	75 d4                	jne    80102fa5 <piperead+0x63>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80102fd1:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102fd7:	83 ec 0c             	sub    $0xc,%esp
80102fda:	50                   	push   %eax
80102fdb:	e8 dc 07 00 00       	call   801037bc <wakeup>
  release(&p->lock);
80102fe0:	89 1c 24             	mov    %ebx,(%esp)
80102fe3:	e8 cf 0b 00 00       	call   80103bb7 <release>
  return i;
80102fe8:	83 c4 10             	add    $0x10,%esp
}
80102feb:	89 f0                	mov    %esi,%eax
80102fed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ff0:	5b                   	pop    %ebx
80102ff1:	5e                   	pop    %esi
80102ff2:	5f                   	pop    %edi
80102ff3:	5d                   	pop    %ebp
80102ff4:	c3                   	ret    
80102ff5:	be 00 00 00 00       	mov    $0x0,%esi
80102ffa:	eb c2                	jmp    80102fbe <piperead+0x7c>

80102ffc <wakeup1>:
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80102ffc:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80103001:	eb 03                	jmp    80103006 <wakeup1+0xa>
80103003:	83 c2 7c             	add    $0x7c,%edx
80103006:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
8010300c:	73 14                	jae    80103022 <wakeup1+0x26>
    if(p->state == SLEEPING && p->chan == chan)
8010300e:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103012:	75 ef                	jne    80103003 <wakeup1+0x7>
80103014:	39 42 20             	cmp    %eax,0x20(%edx)
80103017:	75 ea                	jne    80103003 <wakeup1+0x7>
      p->state = RUNNABLE;
80103019:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103020:	eb e1                	jmp    80103003 <wakeup1+0x7>
}
80103022:	c3                   	ret    

80103023 <allocproc>:
{
80103023:	55                   	push   %ebp
80103024:	89 e5                	mov    %esp,%ebp
80103026:	53                   	push   %ebx
80103027:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010302a:	68 20 1d 11 80       	push   $0x80111d20
8010302f:	e8 1e 0b 00 00       	call   80103b52 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103034:	83 c4 10             	add    $0x10,%esp
80103037:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010303c:	eb 03                	jmp    80103041 <allocproc+0x1e>
8010303e:	83 c3 7c             	add    $0x7c,%ebx
80103041:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103047:	73 76                	jae    801030bf <allocproc+0x9c>
    if(p->state == UNUSED)
80103049:	83 7b 0c 00          	cmpl   $0x0,0xc(%ebx)
8010304d:	75 ef                	jne    8010303e <allocproc+0x1b>
  p->state = EMBRYO;
8010304f:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103056:	a1 04 a0 10 80       	mov    0x8010a004,%eax
8010305b:	8d 50 01             	lea    0x1(%eax),%edx
8010305e:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103064:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103067:	83 ec 0c             	sub    $0xc,%esp
8010306a:	68 20 1d 11 80       	push   $0x80111d20
8010306f:	e8 43 0b 00 00       	call   80103bb7 <release>
  if((p->kstack = kalloc()) == 0){
80103074:	e8 2a f0 ff ff       	call   801020a3 <kalloc>
80103079:	89 43 08             	mov    %eax,0x8(%ebx)
8010307c:	83 c4 10             	add    $0x10,%esp
8010307f:	85 c0                	test   %eax,%eax
80103081:	74 53                	je     801030d6 <allocproc+0xb3>
  sp -= sizeof *p->tf;
80103083:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->tf = (struct trapframe*)sp;
80103089:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010308c:	c7 80 b0 0f 00 00 5b 	movl   $0x80104d5b,0xfb0(%eax)
80103093:	4d 10 80 
  sp -= sizeof *p->context;
80103096:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
8010309b:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010309e:	83 ec 04             	sub    $0x4,%esp
801030a1:	6a 14                	push   $0x14
801030a3:	6a 00                	push   $0x0
801030a5:	50                   	push   %eax
801030a6:	e8 53 0b 00 00       	call   80103bfe <memset>
  p->context->eip = (uint)forkret;
801030ab:	8b 43 1c             	mov    0x1c(%ebx),%eax
801030ae:	c7 40 10 e1 30 10 80 	movl   $0x801030e1,0x10(%eax)
  return p;
801030b5:	83 c4 10             	add    $0x10,%esp
}
801030b8:	89 d8                	mov    %ebx,%eax
801030ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030bd:	c9                   	leave  
801030be:	c3                   	ret    
  release(&ptable.lock);
801030bf:	83 ec 0c             	sub    $0xc,%esp
801030c2:	68 20 1d 11 80       	push   $0x80111d20
801030c7:	e8 eb 0a 00 00       	call   80103bb7 <release>
  return 0;
801030cc:	83 c4 10             	add    $0x10,%esp
801030cf:	bb 00 00 00 00       	mov    $0x0,%ebx
801030d4:	eb e2                	jmp    801030b8 <allocproc+0x95>
    p->state = UNUSED;
801030d6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801030dd:	89 c3                	mov    %eax,%ebx
801030df:	eb d7                	jmp    801030b8 <allocproc+0x95>

801030e1 <forkret>:
{
801030e1:	55                   	push   %ebp
801030e2:	89 e5                	mov    %esp,%ebp
801030e4:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
801030e7:	68 20 1d 11 80       	push   $0x80111d20
801030ec:	e8 c6 0a 00 00       	call   80103bb7 <release>
  if (first) {
801030f1:	83 c4 10             	add    $0x10,%esp
801030f4:	83 3d 00 a0 10 80 00 	cmpl   $0x0,0x8010a000
801030fb:	75 02                	jne    801030ff <forkret+0x1e>
}
801030fd:	c9                   	leave  
801030fe:	c3                   	ret    
    first = 0;
801030ff:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103106:	00 00 00 
    iinit(ROOTDEV);
80103109:	83 ec 0c             	sub    $0xc,%esp
8010310c:	6a 01                	push   $0x1
8010310e:	e8 c7 e1 ff ff       	call   801012da <iinit>
    initlog(ROOTDEV);
80103113:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010311a:	e8 16 f6 ff ff       	call   80102735 <initlog>
8010311f:	83 c4 10             	add    $0x10,%esp
}
80103122:	eb d9                	jmp    801030fd <forkret+0x1c>

80103124 <pinit>:
{
80103124:	55                   	push   %ebp
80103125:	89 e5                	mov    %esp,%ebp
80103127:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
8010312a:	68 80 6e 10 80       	push   $0x80106e80
8010312f:	68 20 1d 11 80       	push   $0x80111d20
80103134:	e8 dd 08 00 00       	call   80103a16 <initlock>
}
80103139:	83 c4 10             	add    $0x10,%esp
8010313c:	c9                   	leave  
8010313d:	c3                   	ret    

8010313e <mycpu>:
{
8010313e:	55                   	push   %ebp
8010313f:	89 e5                	mov    %esp,%ebp
80103141:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103144:	9c                   	pushf  
80103145:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103146:	f6 c4 02             	test   $0x2,%ah
80103149:	75 28                	jne    80103173 <mycpu+0x35>
  apicid = lapicid();
8010314b:	e8 10 f2 ff ff       	call   80102360 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103150:	ba 00 00 00 00       	mov    $0x0,%edx
80103155:	39 15 84 17 11 80    	cmp    %edx,0x80111784
8010315b:	7e 23                	jle    80103180 <mycpu+0x42>
    if (cpus[i].apicid == apicid)
8010315d:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103163:	0f b6 89 a0 17 11 80 	movzbl -0x7feee860(%ecx),%ecx
8010316a:	39 c1                	cmp    %eax,%ecx
8010316c:	74 1f                	je     8010318d <mycpu+0x4f>
  for (i = 0; i < ncpu; ++i) {
8010316e:	83 c2 01             	add    $0x1,%edx
80103171:	eb e2                	jmp    80103155 <mycpu+0x17>
    panic("mycpu called with interrupts enabled\n");
80103173:	83 ec 0c             	sub    $0xc,%esp
80103176:	68 64 6f 10 80       	push   $0x80106f64
8010317b:	e8 c8 d1 ff ff       	call   80100348 <panic>
  panic("unknown apicid\n");
80103180:	83 ec 0c             	sub    $0xc,%esp
80103183:	68 87 6e 10 80       	push   $0x80106e87
80103188:	e8 bb d1 ff ff       	call   80100348 <panic>
      return &cpus[i];
8010318d:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103193:	05 a0 17 11 80       	add    $0x801117a0,%eax
}
80103198:	c9                   	leave  
80103199:	c3                   	ret    

8010319a <cpuid>:
cpuid() {
8010319a:	55                   	push   %ebp
8010319b:	89 e5                	mov    %esp,%ebp
8010319d:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801031a0:	e8 99 ff ff ff       	call   8010313e <mycpu>
801031a5:	2d a0 17 11 80       	sub    $0x801117a0,%eax
801031aa:	c1 f8 04             	sar    $0x4,%eax
801031ad:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801031b3:	c9                   	leave  
801031b4:	c3                   	ret    

801031b5 <myproc>:
myproc(void) {
801031b5:	55                   	push   %ebp
801031b6:	89 e5                	mov    %esp,%ebp
801031b8:	53                   	push   %ebx
801031b9:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801031bc:	e8 b6 08 00 00       	call   80103a77 <pushcli>
  c = mycpu();
801031c1:	e8 78 ff ff ff       	call   8010313e <mycpu>
  p = c->proc;
801031c6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801031cc:	e8 e2 08 00 00       	call   80103ab3 <popcli>
}
801031d1:	89 d8                	mov    %ebx,%eax
801031d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031d6:	c9                   	leave  
801031d7:	c3                   	ret    

801031d8 <userinit>:
{
801031d8:	55                   	push   %ebp
801031d9:	89 e5                	mov    %esp,%ebp
801031db:	53                   	push   %ebx
801031dc:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801031df:	e8 3f fe ff ff       	call   80103023 <allocproc>
801031e4:	89 c3                	mov    %eax,%ebx
  initproc = p;
801031e6:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
801031eb:	e8 30 32 00 00       	call   80106420 <setupkvm>
801031f0:	89 43 04             	mov    %eax,0x4(%ebx)
801031f3:	85 c0                	test   %eax,%eax
801031f5:	0f 84 b8 00 00 00    	je     801032b3 <userinit+0xdb>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801031fb:	83 ec 04             	sub    $0x4,%esp
801031fe:	68 2c 00 00 00       	push   $0x2c
80103203:	68 60 a4 10 80       	push   $0x8010a460
80103208:	50                   	push   %eax
80103209:	e8 1c 2f 00 00       	call   8010612a <inituvm>
  p->sz = PGSIZE;
8010320e:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103214:	8b 43 18             	mov    0x18(%ebx),%eax
80103217:	83 c4 0c             	add    $0xc,%esp
8010321a:	6a 4c                	push   $0x4c
8010321c:	6a 00                	push   $0x0
8010321e:	50                   	push   %eax
8010321f:	e8 da 09 00 00       	call   80103bfe <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103224:	8b 43 18             	mov    0x18(%ebx),%eax
80103227:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010322d:	8b 43 18             	mov    0x18(%ebx),%eax
80103230:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103236:	8b 43 18             	mov    0x18(%ebx),%eax
80103239:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010323d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103241:	8b 43 18             	mov    0x18(%ebx),%eax
80103244:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103248:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010324c:	8b 43 18             	mov    0x18(%ebx),%eax
8010324f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103256:	8b 43 18             	mov    0x18(%ebx),%eax
80103259:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103260:	8b 43 18             	mov    0x18(%ebx),%eax
80103263:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010326a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010326d:	83 c4 0c             	add    $0xc,%esp
80103270:	6a 10                	push   $0x10
80103272:	68 b0 6e 10 80       	push   $0x80106eb0
80103277:	50                   	push   %eax
80103278:	e8 ed 0a 00 00       	call   80103d6a <safestrcpy>
  p->cwd = namei("/");
8010327d:	c7 04 24 b9 6e 10 80 	movl   $0x80106eb9,(%esp)
80103284:	e8 44 e9 ff ff       	call   80101bcd <namei>
80103289:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010328c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103293:	e8 ba 08 00 00       	call   80103b52 <acquire>
  p->state = RUNNABLE;
80103298:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010329f:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801032a6:	e8 0c 09 00 00       	call   80103bb7 <release>
}
801032ab:	83 c4 10             	add    $0x10,%esp
801032ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032b1:	c9                   	leave  
801032b2:	c3                   	ret    
    panic("userinit: out of memory?");
801032b3:	83 ec 0c             	sub    $0xc,%esp
801032b6:	68 97 6e 10 80       	push   $0x80106e97
801032bb:	e8 88 d0 ff ff       	call   80100348 <panic>

801032c0 <growproc>:
{
801032c0:	55                   	push   %ebp
801032c1:	89 e5                	mov    %esp,%ebp
801032c3:	56                   	push   %esi
801032c4:	53                   	push   %ebx
801032c5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
801032c8:	e8 e8 fe ff ff       	call   801031b5 <myproc>
801032cd:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
801032cf:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801032d1:	85 f6                	test   %esi,%esi
801032d3:	7f 1c                	jg     801032f1 <growproc+0x31>
  } else if(n < 0){
801032d5:	78 37                	js     8010330e <growproc+0x4e>
  curproc->sz = sz;
801032d7:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801032d9:	83 ec 0c             	sub    $0xc,%esp
801032dc:	53                   	push   %ebx
801032dd:	e8 e8 2c 00 00       	call   80105fca <switchuvm>
  return 0;
801032e2:	83 c4 10             	add    $0x10,%esp
801032e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801032ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032ed:	5b                   	pop    %ebx
801032ee:	5e                   	pop    %esi
801032ef:	5d                   	pop    %ebp
801032f0:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801032f1:	83 ec 04             	sub    $0x4,%esp
801032f4:	01 c6                	add    %eax,%esi
801032f6:	56                   	push   %esi
801032f7:	50                   	push   %eax
801032f8:	ff 73 04             	push   0x4(%ebx)
801032fb:	e8 c3 2f 00 00       	call   801062c3 <allocuvm>
80103300:	83 c4 10             	add    $0x10,%esp
80103303:	85 c0                	test   %eax,%eax
80103305:	75 d0                	jne    801032d7 <growproc+0x17>
      return -1;
80103307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010330c:	eb dc                	jmp    801032ea <growproc+0x2a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010330e:	83 ec 04             	sub    $0x4,%esp
80103311:	01 c6                	add    %eax,%esi
80103313:	56                   	push   %esi
80103314:	50                   	push   %eax
80103315:	ff 73 04             	push   0x4(%ebx)
80103318:	e8 11 2f 00 00       	call   8010622e <deallocuvm>
8010331d:	83 c4 10             	add    $0x10,%esp
80103320:	85 c0                	test   %eax,%eax
80103322:	75 b3                	jne    801032d7 <growproc+0x17>
      return -1;
80103324:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103329:	eb bf                	jmp    801032ea <growproc+0x2a>

8010332b <fork>:
{
8010332b:	55                   	push   %ebp
8010332c:	89 e5                	mov    %esp,%ebp
8010332e:	57                   	push   %edi
8010332f:	56                   	push   %esi
80103330:	53                   	push   %ebx
80103331:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
80103334:	e8 7c fe ff ff       	call   801031b5 <myproc>
80103339:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
8010333b:	e8 e3 fc ff ff       	call   80103023 <allocproc>
80103340:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103343:	85 c0                	test   %eax,%eax
80103345:	0f 84 e0 00 00 00    	je     8010342b <fork+0x100>
8010334b:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010334d:	83 ec 08             	sub    $0x8,%esp
80103350:	ff 33                	push   (%ebx)
80103352:	ff 73 04             	push   0x4(%ebx)
80103355:	e8 77 31 00 00       	call   801064d1 <copyuvm>
8010335a:	89 47 04             	mov    %eax,0x4(%edi)
8010335d:	83 c4 10             	add    $0x10,%esp
80103360:	85 c0                	test   %eax,%eax
80103362:	74 2a                	je     8010338e <fork+0x63>
  np->sz = curproc->sz;
80103364:	8b 03                	mov    (%ebx),%eax
80103366:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103369:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
8010336b:	89 c8                	mov    %ecx,%eax
8010336d:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103370:	8b 73 18             	mov    0x18(%ebx),%esi
80103373:	8b 79 18             	mov    0x18(%ecx),%edi
80103376:	b9 13 00 00 00       	mov    $0x13,%ecx
8010337b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
8010337d:	8b 40 18             	mov    0x18(%eax),%eax
80103380:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103387:	be 00 00 00 00       	mov    $0x0,%esi
8010338c:	eb 29                	jmp    801033b7 <fork+0x8c>
    kfree(np->kstack);
8010338e:	83 ec 0c             	sub    $0xc,%esp
80103391:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103394:	ff 73 08             	push   0x8(%ebx)
80103397:	e8 f0 eb ff ff       	call   80101f8c <kfree>
    np->kstack = 0;
8010339c:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
801033a3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801033aa:	83 c4 10             	add    $0x10,%esp
801033ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801033b2:	eb 6d                	jmp    80103421 <fork+0xf6>
  for(i = 0; i < NOFILE; i++)
801033b4:	83 c6 01             	add    $0x1,%esi
801033b7:	83 fe 0f             	cmp    $0xf,%esi
801033ba:	7f 1d                	jg     801033d9 <fork+0xae>
    if(curproc->ofile[i])
801033bc:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801033c0:	85 c0                	test   %eax,%eax
801033c2:	74 f0                	je     801033b4 <fork+0x89>
      np->ofile[i] = filedup(curproc->ofile[i]);
801033c4:	83 ec 0c             	sub    $0xc,%esp
801033c7:	50                   	push   %eax
801033c8:	e8 b1 d8 ff ff       	call   80100c7e <filedup>
801033cd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801033d0:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801033d4:	83 c4 10             	add    $0x10,%esp
801033d7:	eb db                	jmp    801033b4 <fork+0x89>
  np->cwd = idup(curproc->cwd);
801033d9:	83 ec 0c             	sub    $0xc,%esp
801033dc:	ff 73 68             	push   0x68(%ebx)
801033df:	e8 5b e1 ff ff       	call   8010153f <idup>
801033e4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801033e7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801033ea:	83 c3 6c             	add    $0x6c,%ebx
801033ed:	8d 47 6c             	lea    0x6c(%edi),%eax
801033f0:	83 c4 0c             	add    $0xc,%esp
801033f3:	6a 10                	push   $0x10
801033f5:	53                   	push   %ebx
801033f6:	50                   	push   %eax
801033f7:	e8 6e 09 00 00       	call   80103d6a <safestrcpy>
  pid = np->pid;
801033fc:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801033ff:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103406:	e8 47 07 00 00       	call   80103b52 <acquire>
  np->state = RUNNABLE;
8010340b:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103412:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103419:	e8 99 07 00 00       	call   80103bb7 <release>
  return pid;
8010341e:	83 c4 10             	add    $0x10,%esp
}
80103421:	89 d8                	mov    %ebx,%eax
80103423:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103426:	5b                   	pop    %ebx
80103427:	5e                   	pop    %esi
80103428:	5f                   	pop    %edi
80103429:	5d                   	pop    %ebp
8010342a:	c3                   	ret    
    return -1;
8010342b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103430:	eb ef                	jmp    80103421 <fork+0xf6>

80103432 <scheduler>:
{
80103432:	55                   	push   %ebp
80103433:	89 e5                	mov    %esp,%ebp
80103435:	56                   	push   %esi
80103436:	53                   	push   %ebx
  struct cpu *c = mycpu();
80103437:	e8 02 fd ff ff       	call   8010313e <mycpu>
8010343c:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010343e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103445:	00 00 00 
80103448:	eb 5a                	jmp    801034a4 <scheduler+0x72>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010344a:	83 c3 7c             	add    $0x7c,%ebx
8010344d:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103453:	73 3f                	jae    80103494 <scheduler+0x62>
      if(p->state != RUNNABLE)
80103455:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103459:	75 ef                	jne    8010344a <scheduler+0x18>
      c->proc = p;
8010345b:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103461:	83 ec 0c             	sub    $0xc,%esp
80103464:	53                   	push   %ebx
80103465:	e8 60 2b 00 00       	call   80105fca <switchuvm>
      p->state = RUNNING;
8010346a:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103471:	83 c4 08             	add    $0x8,%esp
80103474:	ff 73 1c             	push   0x1c(%ebx)
80103477:	8d 46 04             	lea    0x4(%esi),%eax
8010347a:	50                   	push   %eax
8010347b:	e8 3f 09 00 00       	call   80103dbf <swtch>
      switchkvm();
80103480:	e8 37 2b 00 00       	call   80105fbc <switchkvm>
      c->proc = 0;
80103485:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
8010348c:	00 00 00 
8010348f:	83 c4 10             	add    $0x10,%esp
80103492:	eb b6                	jmp    8010344a <scheduler+0x18>
    release(&ptable.lock);
80103494:	83 ec 0c             	sub    $0xc,%esp
80103497:	68 20 1d 11 80       	push   $0x80111d20
8010349c:	e8 16 07 00 00       	call   80103bb7 <release>
    sti();
801034a1:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
801034a4:	fb                   	sti    
    acquire(&ptable.lock);
801034a5:	83 ec 0c             	sub    $0xc,%esp
801034a8:	68 20 1d 11 80       	push   $0x80111d20
801034ad:	e8 a0 06 00 00       	call   80103b52 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801034b2:	83 c4 10             	add    $0x10,%esp
801034b5:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801034ba:	eb 91                	jmp    8010344d <scheduler+0x1b>

801034bc <sched>:
{
801034bc:	55                   	push   %ebp
801034bd:	89 e5                	mov    %esp,%ebp
801034bf:	56                   	push   %esi
801034c0:	53                   	push   %ebx
  struct proc *p = myproc();
801034c1:	e8 ef fc ff ff       	call   801031b5 <myproc>
801034c6:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
801034c8:	83 ec 0c             	sub    $0xc,%esp
801034cb:	68 20 1d 11 80       	push   $0x80111d20
801034d0:	e8 3e 06 00 00       	call   80103b13 <holding>
801034d5:	83 c4 10             	add    $0x10,%esp
801034d8:	85 c0                	test   %eax,%eax
801034da:	74 4f                	je     8010352b <sched+0x6f>
  if(mycpu()->ncli != 1)
801034dc:	e8 5d fc ff ff       	call   8010313e <mycpu>
801034e1:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801034e8:	75 4e                	jne    80103538 <sched+0x7c>
  if(p->state == RUNNING)
801034ea:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801034ee:	74 55                	je     80103545 <sched+0x89>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801034f0:	9c                   	pushf  
801034f1:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801034f2:	f6 c4 02             	test   $0x2,%ah
801034f5:	75 5b                	jne    80103552 <sched+0x96>
  intena = mycpu()->intena;
801034f7:	e8 42 fc ff ff       	call   8010313e <mycpu>
801034fc:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103502:	e8 37 fc ff ff       	call   8010313e <mycpu>
80103507:	83 ec 08             	sub    $0x8,%esp
8010350a:	ff 70 04             	push   0x4(%eax)
8010350d:	83 c3 1c             	add    $0x1c,%ebx
80103510:	53                   	push   %ebx
80103511:	e8 a9 08 00 00       	call   80103dbf <swtch>
  mycpu()->intena = intena;
80103516:	e8 23 fc ff ff       	call   8010313e <mycpu>
8010351b:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103521:	83 c4 10             	add    $0x10,%esp
80103524:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103527:	5b                   	pop    %ebx
80103528:	5e                   	pop    %esi
80103529:	5d                   	pop    %ebp
8010352a:	c3                   	ret    
    panic("sched ptable.lock");
8010352b:	83 ec 0c             	sub    $0xc,%esp
8010352e:	68 bb 6e 10 80       	push   $0x80106ebb
80103533:	e8 10 ce ff ff       	call   80100348 <panic>
    panic("sched locks");
80103538:	83 ec 0c             	sub    $0xc,%esp
8010353b:	68 cd 6e 10 80       	push   $0x80106ecd
80103540:	e8 03 ce ff ff       	call   80100348 <panic>
    panic("sched running");
80103545:	83 ec 0c             	sub    $0xc,%esp
80103548:	68 d9 6e 10 80       	push   $0x80106ed9
8010354d:	e8 f6 cd ff ff       	call   80100348 <panic>
    panic("sched interruptible");
80103552:	83 ec 0c             	sub    $0xc,%esp
80103555:	68 e7 6e 10 80       	push   $0x80106ee7
8010355a:	e8 e9 cd ff ff       	call   80100348 <panic>

8010355f <exit>:
{
8010355f:	55                   	push   %ebp
80103560:	89 e5                	mov    %esp,%ebp
80103562:	56                   	push   %esi
80103563:	53                   	push   %ebx
  struct proc *curproc = myproc();
80103564:	e8 4c fc ff ff       	call   801031b5 <myproc>
  if(curproc == initproc)
80103569:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
8010356f:	74 09                	je     8010357a <exit+0x1b>
80103571:	89 c6                	mov    %eax,%esi
  for(fd = 0; fd < NOFILE; fd++){
80103573:	bb 00 00 00 00       	mov    $0x0,%ebx
80103578:	eb 24                	jmp    8010359e <exit+0x3f>
    panic("init exiting");
8010357a:	83 ec 0c             	sub    $0xc,%esp
8010357d:	68 fb 6e 10 80       	push   $0x80106efb
80103582:	e8 c1 cd ff ff       	call   80100348 <panic>
      fileclose(curproc->ofile[fd]);
80103587:	83 ec 0c             	sub    $0xc,%esp
8010358a:	50                   	push   %eax
8010358b:	e8 33 d7 ff ff       	call   80100cc3 <fileclose>
      curproc->ofile[fd] = 0;
80103590:	c7 44 9e 28 00 00 00 	movl   $0x0,0x28(%esi,%ebx,4)
80103597:	00 
80103598:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
8010359b:	83 c3 01             	add    $0x1,%ebx
8010359e:	83 fb 0f             	cmp    $0xf,%ebx
801035a1:	7f 0a                	jg     801035ad <exit+0x4e>
    if(curproc->ofile[fd]){
801035a3:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
801035a7:	85 c0                	test   %eax,%eax
801035a9:	75 dc                	jne    80103587 <exit+0x28>
801035ab:	eb ee                	jmp    8010359b <exit+0x3c>
  begin_op();
801035ad:	e8 cc f1 ff ff       	call   8010277e <begin_op>
  iput(curproc->cwd);
801035b2:	83 ec 0c             	sub    $0xc,%esp
801035b5:	ff 76 68             	push   0x68(%esi)
801035b8:	e8 b9 e0 ff ff       	call   80101676 <iput>
  end_op();
801035bd:	e8 36 f2 ff ff       	call   801027f8 <end_op>
  curproc->cwd = 0;
801035c2:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801035c9:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801035d0:	e8 7d 05 00 00       	call   80103b52 <acquire>
  wakeup1(curproc->parent);
801035d5:	8b 46 14             	mov    0x14(%esi),%eax
801035d8:	e8 1f fa ff ff       	call   80102ffc <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035dd:	83 c4 10             	add    $0x10,%esp
801035e0:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801035e5:	eb 03                	jmp    801035ea <exit+0x8b>
801035e7:	83 c3 7c             	add    $0x7c,%ebx
801035ea:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801035f0:	73 1a                	jae    8010360c <exit+0xad>
    if(p->parent == curproc){
801035f2:	39 73 14             	cmp    %esi,0x14(%ebx)
801035f5:	75 f0                	jne    801035e7 <exit+0x88>
      p->parent = initproc;
801035f7:	a1 54 3c 11 80       	mov    0x80113c54,%eax
801035fc:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
801035ff:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103603:	75 e2                	jne    801035e7 <exit+0x88>
        wakeup1(initproc);
80103605:	e8 f2 f9 ff ff       	call   80102ffc <wakeup1>
8010360a:	eb db                	jmp    801035e7 <exit+0x88>
  curproc->state = ZOMBIE;
8010360c:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103613:	e8 a4 fe ff ff       	call   801034bc <sched>
  panic("zombie exit");
80103618:	83 ec 0c             	sub    $0xc,%esp
8010361b:	68 08 6f 10 80       	push   $0x80106f08
80103620:	e8 23 cd ff ff       	call   80100348 <panic>

80103625 <yield>:
{
80103625:	55                   	push   %ebp
80103626:	89 e5                	mov    %esp,%ebp
80103628:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010362b:	68 20 1d 11 80       	push   $0x80111d20
80103630:	e8 1d 05 00 00       	call   80103b52 <acquire>
  myproc()->state = RUNNABLE;
80103635:	e8 7b fb ff ff       	call   801031b5 <myproc>
8010363a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103641:	e8 76 fe ff ff       	call   801034bc <sched>
  release(&ptable.lock);
80103646:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010364d:	e8 65 05 00 00       	call   80103bb7 <release>
}
80103652:	83 c4 10             	add    $0x10,%esp
80103655:	c9                   	leave  
80103656:	c3                   	ret    

80103657 <sleep>:
{
80103657:	55                   	push   %ebp
80103658:	89 e5                	mov    %esp,%ebp
8010365a:	56                   	push   %esi
8010365b:	53                   	push   %ebx
8010365c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
8010365f:	e8 51 fb ff ff       	call   801031b5 <myproc>
  if(p == 0)
80103664:	85 c0                	test   %eax,%eax
80103666:	74 66                	je     801036ce <sleep+0x77>
80103668:	89 c3                	mov    %eax,%ebx
  if(lk == 0)
8010366a:	85 f6                	test   %esi,%esi
8010366c:	74 6d                	je     801036db <sleep+0x84>
  if(lk != &ptable.lock){  //DOC: sleeplock0
8010366e:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80103674:	74 18                	je     8010368e <sleep+0x37>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103676:	83 ec 0c             	sub    $0xc,%esp
80103679:	68 20 1d 11 80       	push   $0x80111d20
8010367e:	e8 cf 04 00 00       	call   80103b52 <acquire>
    release(lk);
80103683:	89 34 24             	mov    %esi,(%esp)
80103686:	e8 2c 05 00 00       	call   80103bb7 <release>
8010368b:	83 c4 10             	add    $0x10,%esp
  p->chan = chan;
8010368e:	8b 45 08             	mov    0x8(%ebp),%eax
80103691:	89 43 20             	mov    %eax,0x20(%ebx)
  p->state = SLEEPING;
80103694:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010369b:	e8 1c fe ff ff       	call   801034bc <sched>
  p->chan = 0;
801036a0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  if(lk != &ptable.lock){  //DOC: sleeplock2
801036a7:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
801036ad:	74 18                	je     801036c7 <sleep+0x70>
    release(&ptable.lock);
801036af:	83 ec 0c             	sub    $0xc,%esp
801036b2:	68 20 1d 11 80       	push   $0x80111d20
801036b7:	e8 fb 04 00 00       	call   80103bb7 <release>
    acquire(lk);
801036bc:	89 34 24             	mov    %esi,(%esp)
801036bf:	e8 8e 04 00 00       	call   80103b52 <acquire>
801036c4:	83 c4 10             	add    $0x10,%esp
}
801036c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036ca:	5b                   	pop    %ebx
801036cb:	5e                   	pop    %esi
801036cc:	5d                   	pop    %ebp
801036cd:	c3                   	ret    
    panic("sleep");
801036ce:	83 ec 0c             	sub    $0xc,%esp
801036d1:	68 14 6f 10 80       	push   $0x80106f14
801036d6:	e8 6d cc ff ff       	call   80100348 <panic>
    panic("sleep without lk");
801036db:	83 ec 0c             	sub    $0xc,%esp
801036de:	68 1a 6f 10 80       	push   $0x80106f1a
801036e3:	e8 60 cc ff ff       	call   80100348 <panic>

801036e8 <wait>:
{
801036e8:	55                   	push   %ebp
801036e9:	89 e5                	mov    %esp,%ebp
801036eb:	56                   	push   %esi
801036ec:	53                   	push   %ebx
  struct proc *curproc = myproc();
801036ed:	e8 c3 fa ff ff       	call   801031b5 <myproc>
801036f2:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
801036f4:	83 ec 0c             	sub    $0xc,%esp
801036f7:	68 20 1d 11 80       	push   $0x80111d20
801036fc:	e8 51 04 00 00       	call   80103b52 <acquire>
80103701:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103704:	b8 00 00 00 00       	mov    $0x0,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103709:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010370e:	eb 5b                	jmp    8010376b <wait+0x83>
        pid = p->pid;
80103710:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103713:	83 ec 0c             	sub    $0xc,%esp
80103716:	ff 73 08             	push   0x8(%ebx)
80103719:	e8 6e e8 ff ff       	call   80101f8c <kfree>
        p->kstack = 0;
8010371e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103725:	83 c4 04             	add    $0x4,%esp
80103728:	ff 73 04             	push   0x4(%ebx)
8010372b:	e8 7d 2c 00 00       	call   801063ad <freevm>
        p->pid = 0;
80103730:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103737:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010373e:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103742:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103749:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103750:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103757:	e8 5b 04 00 00       	call   80103bb7 <release>
        return pid;
8010375c:	83 c4 10             	add    $0x10,%esp
}
8010375f:	89 f0                	mov    %esi,%eax
80103761:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103764:	5b                   	pop    %ebx
80103765:	5e                   	pop    %esi
80103766:	5d                   	pop    %ebp
80103767:	c3                   	ret    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103768:	83 c3 7c             	add    $0x7c,%ebx
8010376b:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103771:	73 12                	jae    80103785 <wait+0x9d>
      if(p->parent != curproc)
80103773:	39 73 14             	cmp    %esi,0x14(%ebx)
80103776:	75 f0                	jne    80103768 <wait+0x80>
      if(p->state == ZOMBIE){
80103778:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010377c:	74 92                	je     80103710 <wait+0x28>
      havekids = 1;
8010377e:	b8 01 00 00 00       	mov    $0x1,%eax
80103783:	eb e3                	jmp    80103768 <wait+0x80>
    if(!havekids || curproc->killed){
80103785:	85 c0                	test   %eax,%eax
80103787:	74 06                	je     8010378f <wait+0xa7>
80103789:	83 7e 24 00          	cmpl   $0x0,0x24(%esi)
8010378d:	74 17                	je     801037a6 <wait+0xbe>
      release(&ptable.lock);
8010378f:	83 ec 0c             	sub    $0xc,%esp
80103792:	68 20 1d 11 80       	push   $0x80111d20
80103797:	e8 1b 04 00 00       	call   80103bb7 <release>
      return -1;
8010379c:	83 c4 10             	add    $0x10,%esp
8010379f:	be ff ff ff ff       	mov    $0xffffffff,%esi
801037a4:	eb b9                	jmp    8010375f <wait+0x77>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801037a6:	83 ec 08             	sub    $0x8,%esp
801037a9:	68 20 1d 11 80       	push   $0x80111d20
801037ae:	56                   	push   %esi
801037af:	e8 a3 fe ff ff       	call   80103657 <sleep>
    havekids = 0;
801037b4:	83 c4 10             	add    $0x10,%esp
801037b7:	e9 48 ff ff ff       	jmp    80103704 <wait+0x1c>

801037bc <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801037bc:	55                   	push   %ebp
801037bd:	89 e5                	mov    %esp,%ebp
801037bf:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801037c2:	68 20 1d 11 80       	push   $0x80111d20
801037c7:	e8 86 03 00 00       	call   80103b52 <acquire>
  wakeup1(chan);
801037cc:	8b 45 08             	mov    0x8(%ebp),%eax
801037cf:	e8 28 f8 ff ff       	call   80102ffc <wakeup1>
  release(&ptable.lock);
801037d4:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801037db:	e8 d7 03 00 00       	call   80103bb7 <release>
}
801037e0:	83 c4 10             	add    $0x10,%esp
801037e3:	c9                   	leave  
801037e4:	c3                   	ret    

801037e5 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801037e5:	55                   	push   %ebp
801037e6:	89 e5                	mov    %esp,%ebp
801037e8:	53                   	push   %ebx
801037e9:	83 ec 10             	sub    $0x10,%esp
801037ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801037ef:	68 20 1d 11 80       	push   $0x80111d20
801037f4:	e8 59 03 00 00       	call   80103b52 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037f9:	83 c4 10             	add    $0x10,%esp
801037fc:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103801:	eb 0c                	jmp    8010380f <kill+0x2a>
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103803:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010380a:	eb 1c                	jmp    80103828 <kill+0x43>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010380c:	83 c0 7c             	add    $0x7c,%eax
8010380f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103814:	73 2c                	jae    80103842 <kill+0x5d>
    if(p->pid == pid){
80103816:	39 58 10             	cmp    %ebx,0x10(%eax)
80103819:	75 f1                	jne    8010380c <kill+0x27>
      p->killed = 1;
8010381b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103822:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103826:	74 db                	je     80103803 <kill+0x1e>
      release(&ptable.lock);
80103828:	83 ec 0c             	sub    $0xc,%esp
8010382b:	68 20 1d 11 80       	push   $0x80111d20
80103830:	e8 82 03 00 00       	call   80103bb7 <release>
      return 0;
80103835:	83 c4 10             	add    $0x10,%esp
80103838:	b8 00 00 00 00       	mov    $0x0,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010383d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103840:	c9                   	leave  
80103841:	c3                   	ret    
  release(&ptable.lock);
80103842:	83 ec 0c             	sub    $0xc,%esp
80103845:	68 20 1d 11 80       	push   $0x80111d20
8010384a:	e8 68 03 00 00       	call   80103bb7 <release>
  return -1;
8010384f:	83 c4 10             	add    $0x10,%esp
80103852:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103857:	eb e4                	jmp    8010383d <kill+0x58>

80103859 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103859:	55                   	push   %ebp
8010385a:	89 e5                	mov    %esp,%ebp
8010385c:	56                   	push   %esi
8010385d:	53                   	push   %ebx
8010385e:	83 ec 30             	sub    $0x30,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103861:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103866:	eb 33                	jmp    8010389b <procdump+0x42>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
80103868:	b8 2b 6f 10 80       	mov    $0x80106f2b,%eax
    cprintf("%d %s %s", p->pid, state, p->name);
8010386d:	8d 53 6c             	lea    0x6c(%ebx),%edx
80103870:	52                   	push   %edx
80103871:	50                   	push   %eax
80103872:	ff 73 10             	push   0x10(%ebx)
80103875:	68 2f 6f 10 80       	push   $0x80106f2f
8010387a:	e8 88 cd ff ff       	call   80100607 <cprintf>
    if(p->state == SLEEPING){
8010387f:	83 c4 10             	add    $0x10,%esp
80103882:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103886:	74 39                	je     801038c1 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103888:	83 ec 0c             	sub    $0xc,%esp
8010388b:	68 eb 72 10 80       	push   $0x801072eb
80103890:	e8 72 cd ff ff       	call   80100607 <cprintf>
80103895:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103898:	83 c3 7c             	add    $0x7c,%ebx
8010389b:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801038a1:	73 61                	jae    80103904 <procdump+0xab>
    if(p->state == UNUSED)
801038a3:	8b 43 0c             	mov    0xc(%ebx),%eax
801038a6:	85 c0                	test   %eax,%eax
801038a8:	74 ee                	je     80103898 <procdump+0x3f>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801038aa:	83 f8 05             	cmp    $0x5,%eax
801038ad:	77 b9                	ja     80103868 <procdump+0xf>
801038af:	8b 04 85 8c 6f 10 80 	mov    -0x7fef9074(,%eax,4),%eax
801038b6:	85 c0                	test   %eax,%eax
801038b8:	75 b3                	jne    8010386d <procdump+0x14>
      state = "???";
801038ba:	b8 2b 6f 10 80       	mov    $0x80106f2b,%eax
801038bf:	eb ac                	jmp    8010386d <procdump+0x14>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801038c1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801038c4:	8b 40 0c             	mov    0xc(%eax),%eax
801038c7:	83 c0 08             	add    $0x8,%eax
801038ca:	83 ec 08             	sub    $0x8,%esp
801038cd:	8d 55 d0             	lea    -0x30(%ebp),%edx
801038d0:	52                   	push   %edx
801038d1:	50                   	push   %eax
801038d2:	e8 5a 01 00 00       	call   80103a31 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801038d7:	83 c4 10             	add    $0x10,%esp
801038da:	be 00 00 00 00       	mov    $0x0,%esi
801038df:	eb 14                	jmp    801038f5 <procdump+0x9c>
        cprintf(" %p", pc[i]);
801038e1:	83 ec 08             	sub    $0x8,%esp
801038e4:	50                   	push   %eax
801038e5:	68 81 69 10 80       	push   $0x80106981
801038ea:	e8 18 cd ff ff       	call   80100607 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801038ef:	83 c6 01             	add    $0x1,%esi
801038f2:	83 c4 10             	add    $0x10,%esp
801038f5:	83 fe 09             	cmp    $0x9,%esi
801038f8:	7f 8e                	jg     80103888 <procdump+0x2f>
801038fa:	8b 44 b5 d0          	mov    -0x30(%ebp,%esi,4),%eax
801038fe:	85 c0                	test   %eax,%eax
80103900:	75 df                	jne    801038e1 <procdump+0x88>
80103902:	eb 84                	jmp    80103888 <procdump+0x2f>
  }
}
80103904:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103907:	5b                   	pop    %ebx
80103908:	5e                   	pop    %esi
80103909:	5d                   	pop    %ebp
8010390a:	c3                   	ret    

8010390b <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
8010390b:	55                   	push   %ebp
8010390c:	89 e5                	mov    %esp,%ebp
8010390e:	53                   	push   %ebx
8010390f:	83 ec 0c             	sub    $0xc,%esp
80103912:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103915:	68 a4 6f 10 80       	push   $0x80106fa4
8010391a:	8d 43 04             	lea    0x4(%ebx),%eax
8010391d:	50                   	push   %eax
8010391e:	e8 f3 00 00 00       	call   80103a16 <initlock>
  lk->name = name;
80103923:	8b 45 0c             	mov    0xc(%ebp),%eax
80103926:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103929:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010392f:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80103936:	83 c4 10             	add    $0x10,%esp
80103939:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010393c:	c9                   	leave  
8010393d:	c3                   	ret    

8010393e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
8010393e:	55                   	push   %ebp
8010393f:	89 e5                	mov    %esp,%ebp
80103941:	56                   	push   %esi
80103942:	53                   	push   %ebx
80103943:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103946:	8d 73 04             	lea    0x4(%ebx),%esi
80103949:	83 ec 0c             	sub    $0xc,%esp
8010394c:	56                   	push   %esi
8010394d:	e8 00 02 00 00       	call   80103b52 <acquire>
  while (lk->locked) {
80103952:	83 c4 10             	add    $0x10,%esp
80103955:	eb 0d                	jmp    80103964 <acquiresleep+0x26>
    sleep(lk, &lk->lk);
80103957:	83 ec 08             	sub    $0x8,%esp
8010395a:	56                   	push   %esi
8010395b:	53                   	push   %ebx
8010395c:	e8 f6 fc ff ff       	call   80103657 <sleep>
80103961:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80103964:	83 3b 00             	cmpl   $0x0,(%ebx)
80103967:	75 ee                	jne    80103957 <acquiresleep+0x19>
  }
  lk->locked = 1;
80103969:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
8010396f:	e8 41 f8 ff ff       	call   801031b5 <myproc>
80103974:	8b 40 10             	mov    0x10(%eax),%eax
80103977:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
8010397a:	83 ec 0c             	sub    $0xc,%esp
8010397d:	56                   	push   %esi
8010397e:	e8 34 02 00 00       	call   80103bb7 <release>
}
80103983:	83 c4 10             	add    $0x10,%esp
80103986:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103989:	5b                   	pop    %ebx
8010398a:	5e                   	pop    %esi
8010398b:	5d                   	pop    %ebp
8010398c:	c3                   	ret    

8010398d <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
8010398d:	55                   	push   %ebp
8010398e:	89 e5                	mov    %esp,%ebp
80103990:	56                   	push   %esi
80103991:	53                   	push   %ebx
80103992:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103995:	8d 73 04             	lea    0x4(%ebx),%esi
80103998:	83 ec 0c             	sub    $0xc,%esp
8010399b:	56                   	push   %esi
8010399c:	e8 b1 01 00 00       	call   80103b52 <acquire>
  lk->locked = 0;
801039a1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801039a7:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801039ae:	89 1c 24             	mov    %ebx,(%esp)
801039b1:	e8 06 fe ff ff       	call   801037bc <wakeup>
  release(&lk->lk);
801039b6:	89 34 24             	mov    %esi,(%esp)
801039b9:	e8 f9 01 00 00       	call   80103bb7 <release>
}
801039be:	83 c4 10             	add    $0x10,%esp
801039c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039c4:	5b                   	pop    %ebx
801039c5:	5e                   	pop    %esi
801039c6:	5d                   	pop    %ebp
801039c7:	c3                   	ret    

801039c8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801039c8:	55                   	push   %ebp
801039c9:	89 e5                	mov    %esp,%ebp
801039cb:	56                   	push   %esi
801039cc:	53                   	push   %ebx
801039cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801039d0:	8d 73 04             	lea    0x4(%ebx),%esi
801039d3:	83 ec 0c             	sub    $0xc,%esp
801039d6:	56                   	push   %esi
801039d7:	e8 76 01 00 00       	call   80103b52 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801039dc:	83 c4 10             	add    $0x10,%esp
801039df:	83 3b 00             	cmpl   $0x0,(%ebx)
801039e2:	75 17                	jne    801039fb <holdingsleep+0x33>
801039e4:	bb 00 00 00 00       	mov    $0x0,%ebx
  release(&lk->lk);
801039e9:	83 ec 0c             	sub    $0xc,%esp
801039ec:	56                   	push   %esi
801039ed:	e8 c5 01 00 00       	call   80103bb7 <release>
  return r;
}
801039f2:	89 d8                	mov    %ebx,%eax
801039f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039f7:	5b                   	pop    %ebx
801039f8:	5e                   	pop    %esi
801039f9:	5d                   	pop    %ebp
801039fa:	c3                   	ret    
  r = lk->locked && (lk->pid == myproc()->pid);
801039fb:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801039fe:	e8 b2 f7 ff ff       	call   801031b5 <myproc>
80103a03:	3b 58 10             	cmp    0x10(%eax),%ebx
80103a06:	74 07                	je     80103a0f <holdingsleep+0x47>
80103a08:	bb 00 00 00 00       	mov    $0x0,%ebx
80103a0d:	eb da                	jmp    801039e9 <holdingsleep+0x21>
80103a0f:	bb 01 00 00 00       	mov    $0x1,%ebx
80103a14:	eb d3                	jmp    801039e9 <holdingsleep+0x21>

80103a16 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103a16:	55                   	push   %ebp
80103a17:	89 e5                	mov    %esp,%ebp
80103a19:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103a1c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a1f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103a22:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103a28:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103a2f:	5d                   	pop    %ebp
80103a30:	c3                   	ret    

80103a31 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103a31:	55                   	push   %ebp
80103a32:	89 e5                	mov    %esp,%ebp
80103a34:	53                   	push   %ebx
80103a35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103a38:	8b 45 08             	mov    0x8(%ebp),%eax
80103a3b:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
80103a3e:	b8 00 00 00 00       	mov    $0x0,%eax
80103a43:	83 f8 09             	cmp    $0x9,%eax
80103a46:	7f 25                	jg     80103a6d <getcallerpcs+0x3c>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103a48:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80103a4e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103a54:	77 17                	ja     80103a6d <getcallerpcs+0x3c>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103a56:	8b 5a 04             	mov    0x4(%edx),%ebx
80103a59:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103a5c:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80103a5e:	83 c0 01             	add    $0x1,%eax
80103a61:	eb e0                	jmp    80103a43 <getcallerpcs+0x12>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80103a63:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
80103a6a:	83 c0 01             	add    $0x1,%eax
80103a6d:	83 f8 09             	cmp    $0x9,%eax
80103a70:	7e f1                	jle    80103a63 <getcallerpcs+0x32>
}
80103a72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a75:	c9                   	leave  
80103a76:	c3                   	ret    

80103a77 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103a77:	55                   	push   %ebp
80103a78:	89 e5                	mov    %esp,%ebp
80103a7a:	53                   	push   %ebx
80103a7b:	83 ec 04             	sub    $0x4,%esp
80103a7e:	9c                   	pushf  
80103a7f:	5b                   	pop    %ebx
  asm volatile("cli");
80103a80:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103a81:	e8 b8 f6 ff ff       	call   8010313e <mycpu>
80103a86:	83 b8 a4 00 00 00 00 	cmpl   $0x0,0xa4(%eax)
80103a8d:	74 11                	je     80103aa0 <pushcli+0x29>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80103a8f:	e8 aa f6 ff ff       	call   8010313e <mycpu>
80103a94:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80103a9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a9e:	c9                   	leave  
80103a9f:	c3                   	ret    
    mycpu()->intena = eflags & FL_IF;
80103aa0:	e8 99 f6 ff ff       	call   8010313e <mycpu>
80103aa5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103aab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80103ab1:	eb dc                	jmp    80103a8f <pushcli+0x18>

80103ab3 <popcli>:

void
popcli(void)
{
80103ab3:	55                   	push   %ebp
80103ab4:	89 e5                	mov    %esp,%ebp
80103ab6:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ab9:	9c                   	pushf  
80103aba:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103abb:	f6 c4 02             	test   $0x2,%ah
80103abe:	75 28                	jne    80103ae8 <popcli+0x35>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103ac0:	e8 79 f6 ff ff       	call   8010313e <mycpu>
80103ac5:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103acb:	8d 51 ff             	lea    -0x1(%ecx),%edx
80103ace:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80103ad4:	85 d2                	test   %edx,%edx
80103ad6:	78 1d                	js     80103af5 <popcli+0x42>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103ad8:	e8 61 f6 ff ff       	call   8010313e <mycpu>
80103add:	83 b8 a4 00 00 00 00 	cmpl   $0x0,0xa4(%eax)
80103ae4:	74 1c                	je     80103b02 <popcli+0x4f>
    sti();
}
80103ae6:	c9                   	leave  
80103ae7:	c3                   	ret    
    panic("popcli - interruptible");
80103ae8:	83 ec 0c             	sub    $0xc,%esp
80103aeb:	68 af 6f 10 80       	push   $0x80106faf
80103af0:	e8 53 c8 ff ff       	call   80100348 <panic>
    panic("popcli");
80103af5:	83 ec 0c             	sub    $0xc,%esp
80103af8:	68 c6 6f 10 80       	push   $0x80106fc6
80103afd:	e8 46 c8 ff ff       	call   80100348 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103b02:	e8 37 f6 ff ff       	call   8010313e <mycpu>
80103b07:	83 b8 a8 00 00 00 00 	cmpl   $0x0,0xa8(%eax)
80103b0e:	74 d6                	je     80103ae6 <popcli+0x33>
  asm volatile("sti");
80103b10:	fb                   	sti    
}
80103b11:	eb d3                	jmp    80103ae6 <popcli+0x33>

80103b13 <holding>:
{
80103b13:	55                   	push   %ebp
80103b14:	89 e5                	mov    %esp,%ebp
80103b16:	53                   	push   %ebx
80103b17:	83 ec 04             	sub    $0x4,%esp
80103b1a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103b1d:	e8 55 ff ff ff       	call   80103a77 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103b22:	83 3b 00             	cmpl   $0x0,(%ebx)
80103b25:	75 11                	jne    80103b38 <holding+0x25>
80103b27:	bb 00 00 00 00       	mov    $0x0,%ebx
  popcli();
80103b2c:	e8 82 ff ff ff       	call   80103ab3 <popcli>
}
80103b31:	89 d8                	mov    %ebx,%eax
80103b33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b36:	c9                   	leave  
80103b37:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80103b38:	8b 5b 08             	mov    0x8(%ebx),%ebx
80103b3b:	e8 fe f5 ff ff       	call   8010313e <mycpu>
80103b40:	39 c3                	cmp    %eax,%ebx
80103b42:	74 07                	je     80103b4b <holding+0x38>
80103b44:	bb 00 00 00 00       	mov    $0x0,%ebx
80103b49:	eb e1                	jmp    80103b2c <holding+0x19>
80103b4b:	bb 01 00 00 00       	mov    $0x1,%ebx
80103b50:	eb da                	jmp    80103b2c <holding+0x19>

80103b52 <acquire>:
{
80103b52:	55                   	push   %ebp
80103b53:	89 e5                	mov    %esp,%ebp
80103b55:	53                   	push   %ebx
80103b56:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80103b59:	e8 19 ff ff ff       	call   80103a77 <pushcli>
  if(holding(lk))
80103b5e:	83 ec 0c             	sub    $0xc,%esp
80103b61:	ff 75 08             	push   0x8(%ebp)
80103b64:	e8 aa ff ff ff       	call   80103b13 <holding>
80103b69:	83 c4 10             	add    $0x10,%esp
80103b6c:	85 c0                	test   %eax,%eax
80103b6e:	75 3a                	jne    80103baa <acquire+0x58>
  while(xchg(&lk->locked, 1) != 0)
80103b70:	8b 55 08             	mov    0x8(%ebp),%edx
  asm volatile("lock; xchgl %0, %1" :
80103b73:	b8 01 00 00 00       	mov    $0x1,%eax
80103b78:	f0 87 02             	lock xchg %eax,(%edx)
80103b7b:	85 c0                	test   %eax,%eax
80103b7d:	75 f1                	jne    80103b70 <acquire+0x1e>
  __sync_synchronize();
80103b7f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80103b84:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b87:	e8 b2 f5 ff ff       	call   8010313e <mycpu>
80103b8c:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80103b8f:	8b 45 08             	mov    0x8(%ebp),%eax
80103b92:	83 c0 0c             	add    $0xc,%eax
80103b95:	83 ec 08             	sub    $0x8,%esp
80103b98:	50                   	push   %eax
80103b99:	8d 45 08             	lea    0x8(%ebp),%eax
80103b9c:	50                   	push   %eax
80103b9d:	e8 8f fe ff ff       	call   80103a31 <getcallerpcs>
}
80103ba2:	83 c4 10             	add    $0x10,%esp
80103ba5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ba8:	c9                   	leave  
80103ba9:	c3                   	ret    
    panic("acquire");
80103baa:	83 ec 0c             	sub    $0xc,%esp
80103bad:	68 cd 6f 10 80       	push   $0x80106fcd
80103bb2:	e8 91 c7 ff ff       	call   80100348 <panic>

80103bb7 <release>:
{
80103bb7:	55                   	push   %ebp
80103bb8:	89 e5                	mov    %esp,%ebp
80103bba:	53                   	push   %ebx
80103bbb:	83 ec 10             	sub    $0x10,%esp
80103bbe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80103bc1:	53                   	push   %ebx
80103bc2:	e8 4c ff ff ff       	call   80103b13 <holding>
80103bc7:	83 c4 10             	add    $0x10,%esp
80103bca:	85 c0                	test   %eax,%eax
80103bcc:	74 23                	je     80103bf1 <release+0x3a>
  lk->pcs[0] = 0;
80103bce:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80103bd5:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80103bdc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80103be1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  popcli();
80103be7:	e8 c7 fe ff ff       	call   80103ab3 <popcli>
}
80103bec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bef:	c9                   	leave  
80103bf0:	c3                   	ret    
    panic("release");
80103bf1:	83 ec 0c             	sub    $0xc,%esp
80103bf4:	68 d5 6f 10 80       	push   $0x80106fd5
80103bf9:	e8 4a c7 ff ff       	call   80100348 <panic>

80103bfe <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80103bfe:	55                   	push   %ebp
80103bff:	89 e5                	mov    %esp,%ebp
80103c01:	57                   	push   %edi
80103c02:	53                   	push   %ebx
80103c03:	8b 55 08             	mov    0x8(%ebp),%edx
80103c06:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c09:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80103c0c:	f6 c2 03             	test   $0x3,%dl
80103c0f:	75 25                	jne    80103c36 <memset+0x38>
80103c11:	f6 c1 03             	test   $0x3,%cl
80103c14:	75 20                	jne    80103c36 <memset+0x38>
    c &= 0xFF;
80103c16:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80103c19:	c1 e9 02             	shr    $0x2,%ecx
80103c1c:	c1 e0 18             	shl    $0x18,%eax
80103c1f:	89 fb                	mov    %edi,%ebx
80103c21:	c1 e3 10             	shl    $0x10,%ebx
80103c24:	09 d8                	or     %ebx,%eax
80103c26:	89 fb                	mov    %edi,%ebx
80103c28:	c1 e3 08             	shl    $0x8,%ebx
80103c2b:	09 d8                	or     %ebx,%eax
80103c2d:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80103c2f:	89 d7                	mov    %edx,%edi
80103c31:	fc                   	cld    
80103c32:	f3 ab                	rep stos %eax,%es:(%edi)
}
80103c34:	eb 05                	jmp    80103c3b <memset+0x3d>
  asm volatile("cld; rep stosb" :
80103c36:	89 d7                	mov    %edx,%edi
80103c38:	fc                   	cld    
80103c39:	f3 aa                	rep stos %al,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80103c3b:	89 d0                	mov    %edx,%eax
80103c3d:	5b                   	pop    %ebx
80103c3e:	5f                   	pop    %edi
80103c3f:	5d                   	pop    %ebp
80103c40:	c3                   	ret    

80103c41 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80103c41:	55                   	push   %ebp
80103c42:	89 e5                	mov    %esp,%ebp
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103c49:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c4c:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103c4f:	eb 08                	jmp    80103c59 <memcmp+0x18>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80103c51:	83 c1 01             	add    $0x1,%ecx
80103c54:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80103c57:	89 f0                	mov    %esi,%eax
80103c59:	8d 70 ff             	lea    -0x1(%eax),%esi
80103c5c:	85 c0                	test   %eax,%eax
80103c5e:	74 12                	je     80103c72 <memcmp+0x31>
    if(*s1 != *s2)
80103c60:	0f b6 01             	movzbl (%ecx),%eax
80103c63:	0f b6 1a             	movzbl (%edx),%ebx
80103c66:	38 d8                	cmp    %bl,%al
80103c68:	74 e7                	je     80103c51 <memcmp+0x10>
      return *s1 - *s2;
80103c6a:	0f b6 c0             	movzbl %al,%eax
80103c6d:	0f b6 db             	movzbl %bl,%ebx
80103c70:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80103c72:	5b                   	pop    %ebx
80103c73:	5e                   	pop    %esi
80103c74:	5d                   	pop    %ebp
80103c75:	c3                   	ret    

80103c76 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80103c76:	55                   	push   %ebp
80103c77:	89 e5                	mov    %esp,%ebp
80103c79:	56                   	push   %esi
80103c7a:	53                   	push   %ebx
80103c7b:	8b 75 08             	mov    0x8(%ebp),%esi
80103c7e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c81:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80103c84:	39 f2                	cmp    %esi,%edx
80103c86:	73 3c                	jae    80103cc4 <memmove+0x4e>
80103c88:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80103c8b:	39 f1                	cmp    %esi,%ecx
80103c8d:	76 39                	jbe    80103cc8 <memmove+0x52>
    s += n;
    d += n;
80103c8f:	8d 14 06             	lea    (%esi,%eax,1),%edx
    while(n-- > 0)
80103c92:	eb 0d                	jmp    80103ca1 <memmove+0x2b>
      *--d = *--s;
80103c94:	83 e9 01             	sub    $0x1,%ecx
80103c97:	83 ea 01             	sub    $0x1,%edx
80103c9a:	0f b6 01             	movzbl (%ecx),%eax
80103c9d:	88 02                	mov    %al,(%edx)
    while(n-- > 0)
80103c9f:	89 d8                	mov    %ebx,%eax
80103ca1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103ca4:	85 c0                	test   %eax,%eax
80103ca6:	75 ec                	jne    80103c94 <memmove+0x1e>
80103ca8:	eb 14                	jmp    80103cbe <memmove+0x48>
  } else
    while(n-- > 0)
      *d++ = *s++;
80103caa:	0f b6 02             	movzbl (%edx),%eax
80103cad:	88 01                	mov    %al,(%ecx)
80103caf:	8d 49 01             	lea    0x1(%ecx),%ecx
80103cb2:	8d 52 01             	lea    0x1(%edx),%edx
    while(n-- > 0)
80103cb5:	89 d8                	mov    %ebx,%eax
80103cb7:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	75 ec                	jne    80103caa <memmove+0x34>

  return dst;
}
80103cbe:	89 f0                	mov    %esi,%eax
80103cc0:	5b                   	pop    %ebx
80103cc1:	5e                   	pop    %esi
80103cc2:	5d                   	pop    %ebp
80103cc3:	c3                   	ret    
80103cc4:	89 f1                	mov    %esi,%ecx
80103cc6:	eb ef                	jmp    80103cb7 <memmove+0x41>
80103cc8:	89 f1                	mov    %esi,%ecx
80103cca:	eb eb                	jmp    80103cb7 <memmove+0x41>

80103ccc <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80103ccc:	55                   	push   %ebp
80103ccd:	89 e5                	mov    %esp,%ebp
80103ccf:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80103cd2:	ff 75 10             	push   0x10(%ebp)
80103cd5:	ff 75 0c             	push   0xc(%ebp)
80103cd8:	ff 75 08             	push   0x8(%ebp)
80103cdb:	e8 96 ff ff ff       	call   80103c76 <memmove>
}
80103ce0:	c9                   	leave  
80103ce1:	c3                   	ret    

80103ce2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80103ce2:	55                   	push   %ebp
80103ce3:	89 e5                	mov    %esp,%ebp
80103ce5:	53                   	push   %ebx
80103ce6:	8b 55 08             	mov    0x8(%ebp),%edx
80103ce9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103cec:	8b 45 10             	mov    0x10(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80103cef:	eb 09                	jmp    80103cfa <strncmp+0x18>
    n--, p++, q++;
80103cf1:	83 e8 01             	sub    $0x1,%eax
80103cf4:	83 c2 01             	add    $0x1,%edx
80103cf7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80103cfa:	85 c0                	test   %eax,%eax
80103cfc:	74 0b                	je     80103d09 <strncmp+0x27>
80103cfe:	0f b6 1a             	movzbl (%edx),%ebx
80103d01:	84 db                	test   %bl,%bl
80103d03:	74 04                	je     80103d09 <strncmp+0x27>
80103d05:	3a 19                	cmp    (%ecx),%bl
80103d07:	74 e8                	je     80103cf1 <strncmp+0xf>
  if(n == 0)
80103d09:	85 c0                	test   %eax,%eax
80103d0b:	74 0d                	je     80103d1a <strncmp+0x38>
    return 0;
  return (uchar)*p - (uchar)*q;
80103d0d:	0f b6 02             	movzbl (%edx),%eax
80103d10:	0f b6 11             	movzbl (%ecx),%edx
80103d13:	29 d0                	sub    %edx,%eax
}
80103d15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d18:	c9                   	leave  
80103d19:	c3                   	ret    
    return 0;
80103d1a:	b8 00 00 00 00       	mov    $0x0,%eax
80103d1f:	eb f4                	jmp    80103d15 <strncmp+0x33>

80103d21 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80103d21:	55                   	push   %ebp
80103d22:	89 e5                	mov    %esp,%ebp
80103d24:	57                   	push   %edi
80103d25:	56                   	push   %esi
80103d26:	53                   	push   %ebx
80103d27:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103d2d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80103d30:	89 fa                	mov    %edi,%edx
80103d32:	eb 04                	jmp    80103d38 <strncpy+0x17>
80103d34:	89 f1                	mov    %esi,%ecx
80103d36:	89 da                	mov    %ebx,%edx
80103d38:	89 c3                	mov    %eax,%ebx
80103d3a:	83 e8 01             	sub    $0x1,%eax
80103d3d:	85 db                	test   %ebx,%ebx
80103d3f:	7e 11                	jle    80103d52 <strncpy+0x31>
80103d41:	8d 71 01             	lea    0x1(%ecx),%esi
80103d44:	8d 5a 01             	lea    0x1(%edx),%ebx
80103d47:	0f b6 09             	movzbl (%ecx),%ecx
80103d4a:	88 0a                	mov    %cl,(%edx)
80103d4c:	84 c9                	test   %cl,%cl
80103d4e:	75 e4                	jne    80103d34 <strncpy+0x13>
80103d50:	89 da                	mov    %ebx,%edx
    ;
  while(n-- > 0)
80103d52:	8d 48 ff             	lea    -0x1(%eax),%ecx
80103d55:	85 c0                	test   %eax,%eax
80103d57:	7e 0a                	jle    80103d63 <strncpy+0x42>
    *s++ = 0;
80103d59:	c6 02 00             	movb   $0x0,(%edx)
  while(n-- > 0)
80103d5c:	89 c8                	mov    %ecx,%eax
    *s++ = 0;
80103d5e:	8d 52 01             	lea    0x1(%edx),%edx
80103d61:	eb ef                	jmp    80103d52 <strncpy+0x31>
  return os;
}
80103d63:	89 f8                	mov    %edi,%eax
80103d65:	5b                   	pop    %ebx
80103d66:	5e                   	pop    %esi
80103d67:	5f                   	pop    %edi
80103d68:	5d                   	pop    %ebp
80103d69:	c3                   	ret    

80103d6a <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80103d6a:	55                   	push   %ebp
80103d6b:	89 e5                	mov    %esp,%ebp
80103d6d:	57                   	push   %edi
80103d6e:	56                   	push   %esi
80103d6f:	53                   	push   %ebx
80103d70:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103d76:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80103d79:	85 c0                	test   %eax,%eax
80103d7b:	7e 23                	jle    80103da0 <safestrcpy+0x36>
80103d7d:	89 fa                	mov    %edi,%edx
80103d7f:	eb 04                	jmp    80103d85 <safestrcpy+0x1b>
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80103d81:	89 f1                	mov    %esi,%ecx
80103d83:	89 da                	mov    %ebx,%edx
80103d85:	83 e8 01             	sub    $0x1,%eax
80103d88:	85 c0                	test   %eax,%eax
80103d8a:	7e 11                	jle    80103d9d <safestrcpy+0x33>
80103d8c:	8d 71 01             	lea    0x1(%ecx),%esi
80103d8f:	8d 5a 01             	lea    0x1(%edx),%ebx
80103d92:	0f b6 09             	movzbl (%ecx),%ecx
80103d95:	88 0a                	mov    %cl,(%edx)
80103d97:	84 c9                	test   %cl,%cl
80103d99:	75 e6                	jne    80103d81 <safestrcpy+0x17>
80103d9b:	89 da                	mov    %ebx,%edx
    ;
  *s = 0;
80103d9d:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80103da0:	89 f8                	mov    %edi,%eax
80103da2:	5b                   	pop    %ebx
80103da3:	5e                   	pop    %esi
80103da4:	5f                   	pop    %edi
80103da5:	5d                   	pop    %ebp
80103da6:	c3                   	ret    

80103da7 <strlen>:

int
strlen(const char *s)
{
80103da7:	55                   	push   %ebp
80103da8:	89 e5                	mov    %esp,%ebp
80103daa:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80103dad:	b8 00 00 00 00       	mov    $0x0,%eax
80103db2:	eb 03                	jmp    80103db7 <strlen+0x10>
80103db4:	83 c0 01             	add    $0x1,%eax
80103db7:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80103dbb:	75 f7                	jne    80103db4 <strlen+0xd>
    ;
  return n;
}
80103dbd:	5d                   	pop    %ebp
80103dbe:	c3                   	ret    

80103dbf <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80103dbf:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80103dc3:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80103dc7:	55                   	push   %ebp
  pushl %ebx
80103dc8:	53                   	push   %ebx
  pushl %esi
80103dc9:	56                   	push   %esi
  pushl %edi
80103dca:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80103dcb:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80103dcd:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80103dcf:	5f                   	pop    %edi
  popl %esi
80103dd0:	5e                   	pop    %esi
  popl %ebx
80103dd1:	5b                   	pop    %ebx
  popl %ebp
80103dd2:	5d                   	pop    %ebp
  ret
80103dd3:	c3                   	ret    

80103dd4 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80103dd4:	55                   	push   %ebp
80103dd5:	89 e5                	mov    %esp,%ebp
80103dd7:	53                   	push   %ebx
80103dd8:	83 ec 04             	sub    $0x4,%esp
80103ddb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80103dde:	e8 d2 f3 ff ff       	call   801031b5 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80103de3:	8b 00                	mov    (%eax),%eax
80103de5:	39 d8                	cmp    %ebx,%eax
80103de7:	76 18                	jbe    80103e01 <fetchint+0x2d>
80103de9:	8d 53 04             	lea    0x4(%ebx),%edx
80103dec:	39 d0                	cmp    %edx,%eax
80103dee:	72 18                	jb     80103e08 <fetchint+0x34>
    return -1;
  *ip = *(int*)(addr);
80103df0:	8b 13                	mov    (%ebx),%edx
80103df2:	8b 45 0c             	mov    0xc(%ebp),%eax
80103df5:	89 10                	mov    %edx,(%eax)
  return 0;
80103df7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103dfc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dff:	c9                   	leave  
80103e00:	c3                   	ret    
    return -1;
80103e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e06:	eb f4                	jmp    80103dfc <fetchint+0x28>
80103e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e0d:	eb ed                	jmp    80103dfc <fetchint+0x28>

80103e0f <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80103e0f:	55                   	push   %ebp
80103e10:	89 e5                	mov    %esp,%ebp
80103e12:	53                   	push   %ebx
80103e13:	83 ec 04             	sub    $0x4,%esp
80103e16:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80103e19:	e8 97 f3 ff ff       	call   801031b5 <myproc>

  if(addr >= curproc->sz)
80103e1e:	39 18                	cmp    %ebx,(%eax)
80103e20:	76 25                	jbe    80103e47 <fetchstr+0x38>
    return -1;
  *pp = (char*)addr;
80103e22:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e25:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80103e27:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80103e29:	89 d8                	mov    %ebx,%eax
80103e2b:	eb 03                	jmp    80103e30 <fetchstr+0x21>
80103e2d:	83 c0 01             	add    $0x1,%eax
80103e30:	39 d0                	cmp    %edx,%eax
80103e32:	73 09                	jae    80103e3d <fetchstr+0x2e>
    if(*s == 0)
80103e34:	80 38 00             	cmpb   $0x0,(%eax)
80103e37:	75 f4                	jne    80103e2d <fetchstr+0x1e>
      return s - *pp;
80103e39:	29 d8                	sub    %ebx,%eax
80103e3b:	eb 05                	jmp    80103e42 <fetchstr+0x33>
  }
  return -1;
80103e3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103e42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e45:	c9                   	leave  
80103e46:	c3                   	ret    
    return -1;
80103e47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e4c:	eb f4                	jmp    80103e42 <fetchstr+0x33>

80103e4e <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80103e4e:	55                   	push   %ebp
80103e4f:	89 e5                	mov    %esp,%ebp
80103e51:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80103e54:	e8 5c f3 ff ff       	call   801031b5 <myproc>
80103e59:	8b 50 18             	mov    0x18(%eax),%edx
80103e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e5f:	c1 e0 02             	shl    $0x2,%eax
80103e62:	03 42 44             	add    0x44(%edx),%eax
80103e65:	83 ec 08             	sub    $0x8,%esp
80103e68:	ff 75 0c             	push   0xc(%ebp)
80103e6b:	83 c0 04             	add    $0x4,%eax
80103e6e:	50                   	push   %eax
80103e6f:	e8 60 ff ff ff       	call   80103dd4 <fetchint>
}
80103e74:	c9                   	leave  
80103e75:	c3                   	ret    

80103e76 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80103e76:	55                   	push   %ebp
80103e77:	89 e5                	mov    %esp,%ebp
80103e79:	56                   	push   %esi
80103e7a:	53                   	push   %ebx
80103e7b:	83 ec 10             	sub    $0x10,%esp
80103e7e:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80103e81:	e8 2f f3 ff ff       	call   801031b5 <myproc>
80103e86:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80103e88:	83 ec 08             	sub    $0x8,%esp
80103e8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80103e8e:	50                   	push   %eax
80103e8f:	ff 75 08             	push   0x8(%ebp)
80103e92:	e8 b7 ff ff ff       	call   80103e4e <argint>
80103e97:	83 c4 10             	add    $0x10,%esp
80103e9a:	85 c0                	test   %eax,%eax
80103e9c:	78 24                	js     80103ec2 <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80103e9e:	85 db                	test   %ebx,%ebx
80103ea0:	78 27                	js     80103ec9 <argptr+0x53>
80103ea2:	8b 16                	mov    (%esi),%edx
80103ea4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ea7:	39 c2                	cmp    %eax,%edx
80103ea9:	76 25                	jbe    80103ed0 <argptr+0x5a>
80103eab:	01 c3                	add    %eax,%ebx
80103ead:	39 da                	cmp    %ebx,%edx
80103eaf:	72 26                	jb     80103ed7 <argptr+0x61>
    return -1;
  *pp = (char*)i;
80103eb1:	8b 55 0c             	mov    0xc(%ebp),%edx
80103eb4:	89 02                	mov    %eax,(%edx)
  return 0;
80103eb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ebb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ebe:	5b                   	pop    %ebx
80103ebf:	5e                   	pop    %esi
80103ec0:	5d                   	pop    %ebp
80103ec1:	c3                   	ret    
    return -1;
80103ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ec7:	eb f2                	jmp    80103ebb <argptr+0x45>
    return -1;
80103ec9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ece:	eb eb                	jmp    80103ebb <argptr+0x45>
80103ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ed5:	eb e4                	jmp    80103ebb <argptr+0x45>
80103ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103edc:	eb dd                	jmp    80103ebb <argptr+0x45>

80103ede <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80103ede:	55                   	push   %ebp
80103edf:	89 e5                	mov    %esp,%ebp
80103ee1:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80103ee4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80103ee7:	50                   	push   %eax
80103ee8:	ff 75 08             	push   0x8(%ebp)
80103eeb:	e8 5e ff ff ff       	call   80103e4e <argint>
80103ef0:	83 c4 10             	add    $0x10,%esp
80103ef3:	85 c0                	test   %eax,%eax
80103ef5:	78 13                	js     80103f0a <argstr+0x2c>
    return -1;
  return fetchstr(addr, pp);
80103ef7:	83 ec 08             	sub    $0x8,%esp
80103efa:	ff 75 0c             	push   0xc(%ebp)
80103efd:	ff 75 f4             	push   -0xc(%ebp)
80103f00:	e8 0a ff ff ff       	call   80103e0f <fetchstr>
80103f05:	83 c4 10             	add    $0x10,%esp
}
80103f08:	c9                   	leave  
80103f09:	c3                   	ret    
    return -1;
80103f0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f0f:	eb f7                	jmp    80103f08 <argstr+0x2a>

80103f11 <syscall>:
[SYS_dump_rawphymem] sys_dump_rawphymem,
};

void
syscall(void)
{
80103f11:	55                   	push   %ebp
80103f12:	89 e5                	mov    %esp,%ebp
80103f14:	53                   	push   %ebx
80103f15:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80103f18:	e8 98 f2 ff ff       	call   801031b5 <myproc>
80103f1d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80103f1f:	8b 40 18             	mov    0x18(%eax),%eax
80103f22:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80103f25:	8d 50 ff             	lea    -0x1(%eax),%edx
80103f28:	83 fa 17             	cmp    $0x17,%edx
80103f2b:	77 17                	ja     80103f44 <syscall+0x33>
80103f2d:	8b 14 85 00 70 10 80 	mov    -0x7fef9000(,%eax,4),%edx
80103f34:	85 d2                	test   %edx,%edx
80103f36:	74 0c                	je     80103f44 <syscall+0x33>
    curproc->tf->eax = syscalls[num]();
80103f38:	ff d2                	call   *%edx
80103f3a:	89 c2                	mov    %eax,%edx
80103f3c:	8b 43 18             	mov    0x18(%ebx),%eax
80103f3f:	89 50 1c             	mov    %edx,0x1c(%eax)
80103f42:	eb 1f                	jmp    80103f63 <syscall+0x52>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
80103f44:	8d 53 6c             	lea    0x6c(%ebx),%edx
    cprintf("%d %s: unknown sys call %d\n",
80103f47:	50                   	push   %eax
80103f48:	52                   	push   %edx
80103f49:	ff 73 10             	push   0x10(%ebx)
80103f4c:	68 dd 6f 10 80       	push   $0x80106fdd
80103f51:	e8 b1 c6 ff ff       	call   80100607 <cprintf>
    curproc->tf->eax = -1;
80103f56:	8b 43 18             	mov    0x18(%ebx),%eax
80103f59:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80103f60:	83 c4 10             	add    $0x10,%esp
  }
}
80103f63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f66:	c9                   	leave  
80103f67:	c3                   	ret    

80103f68 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80103f68:	55                   	push   %ebp
80103f69:	89 e5                	mov    %esp,%ebp
80103f6b:	56                   	push   %esi
80103f6c:	53                   	push   %ebx
80103f6d:	83 ec 18             	sub    $0x18,%esp
80103f70:	89 d6                	mov    %edx,%esi
80103f72:	89 cb                	mov    %ecx,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80103f74:	8d 55 f4             	lea    -0xc(%ebp),%edx
80103f77:	52                   	push   %edx
80103f78:	50                   	push   %eax
80103f79:	e8 d0 fe ff ff       	call   80103e4e <argint>
80103f7e:	83 c4 10             	add    $0x10,%esp
80103f81:	85 c0                	test   %eax,%eax
80103f83:	78 35                	js     80103fba <argfd+0x52>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80103f85:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80103f89:	77 28                	ja     80103fb3 <argfd+0x4b>
80103f8b:	e8 25 f2 ff ff       	call   801031b5 <myproc>
80103f90:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103f93:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80103f97:	85 c0                	test   %eax,%eax
80103f99:	74 18                	je     80103fb3 <argfd+0x4b>
    return -1;
  if(pfd)
80103f9b:	85 f6                	test   %esi,%esi
80103f9d:	74 02                	je     80103fa1 <argfd+0x39>
    *pfd = fd;
80103f9f:	89 16                	mov    %edx,(%esi)
  if(pf)
80103fa1:	85 db                	test   %ebx,%ebx
80103fa3:	74 1c                	je     80103fc1 <argfd+0x59>
    *pf = f;
80103fa5:	89 03                	mov    %eax,(%ebx)
  return 0;
80103fa7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103fac:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103faf:	5b                   	pop    %ebx
80103fb0:	5e                   	pop    %esi
80103fb1:	5d                   	pop    %ebp
80103fb2:	c3                   	ret    
    return -1;
80103fb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fb8:	eb f2                	jmp    80103fac <argfd+0x44>
    return -1;
80103fba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fbf:	eb eb                	jmp    80103fac <argfd+0x44>
  return 0;
80103fc1:	b8 00 00 00 00       	mov    $0x0,%eax
80103fc6:	eb e4                	jmp    80103fac <argfd+0x44>

80103fc8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80103fc8:	55                   	push   %ebp
80103fc9:	89 e5                	mov    %esp,%ebp
80103fcb:	53                   	push   %ebx
80103fcc:	83 ec 04             	sub    $0x4,%esp
80103fcf:	89 c3                	mov    %eax,%ebx
  int fd;
  struct proc *curproc = myproc();
80103fd1:	e8 df f1 ff ff       	call   801031b5 <myproc>
80103fd6:	89 c2                	mov    %eax,%edx

  for(fd = 0; fd < NOFILE; fd++){
80103fd8:	b8 00 00 00 00       	mov    $0x0,%eax
80103fdd:	83 f8 0f             	cmp    $0xf,%eax
80103fe0:	7f 12                	jg     80103ff4 <fdalloc+0x2c>
    if(curproc->ofile[fd] == 0){
80103fe2:	83 7c 82 28 00       	cmpl   $0x0,0x28(%edx,%eax,4)
80103fe7:	74 05                	je     80103fee <fdalloc+0x26>
  for(fd = 0; fd < NOFILE; fd++){
80103fe9:	83 c0 01             	add    $0x1,%eax
80103fec:	eb ef                	jmp    80103fdd <fdalloc+0x15>
      curproc->ofile[fd] = f;
80103fee:	89 5c 82 28          	mov    %ebx,0x28(%edx,%eax,4)
      return fd;
80103ff2:	eb 05                	jmp    80103ff9 <fdalloc+0x31>
    }
  }
  return -1;
80103ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103ff9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ffc:	c9                   	leave  
80103ffd:	c3                   	ret    

80103ffe <isdirempty>:
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80103ffe:	55                   	push   %ebp
80103fff:	89 e5                	mov    %esp,%ebp
80104001:	56                   	push   %esi
80104002:	53                   	push   %ebx
80104003:	83 ec 10             	sub    $0x10,%esp
80104006:	89 c3                	mov    %eax,%ebx
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104008:	b8 20 00 00 00       	mov    $0x20,%eax
8010400d:	89 c6                	mov    %eax,%esi
8010400f:	39 43 58             	cmp    %eax,0x58(%ebx)
80104012:	76 2e                	jbe    80104042 <isdirempty+0x44>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104014:	6a 10                	push   $0x10
80104016:	50                   	push   %eax
80104017:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010401a:	50                   	push   %eax
8010401b:	53                   	push   %ebx
8010401c:	e8 40 d7 ff ff       	call   80101761 <readi>
80104021:	83 c4 10             	add    $0x10,%esp
80104024:	83 f8 10             	cmp    $0x10,%eax
80104027:	75 0c                	jne    80104035 <isdirempty+0x37>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104029:	66 83 7d e8 00       	cmpw   $0x0,-0x18(%ebp)
8010402e:	75 1e                	jne    8010404e <isdirempty+0x50>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104030:	8d 46 10             	lea    0x10(%esi),%eax
80104033:	eb d8                	jmp    8010400d <isdirempty+0xf>
      panic("isdirempty: readi");
80104035:	83 ec 0c             	sub    $0xc,%esp
80104038:	68 64 70 10 80       	push   $0x80107064
8010403d:	e8 06 c3 ff ff       	call   80100348 <panic>
      return 0;
  }
  return 1;
80104042:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104047:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010404a:	5b                   	pop    %ebx
8010404b:	5e                   	pop    %esi
8010404c:	5d                   	pop    %ebp
8010404d:	c3                   	ret    
      return 0;
8010404e:	b8 00 00 00 00       	mov    $0x0,%eax
80104053:	eb f2                	jmp    80104047 <isdirempty+0x49>

80104055 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104055:	55                   	push   %ebp
80104056:	89 e5                	mov    %esp,%ebp
80104058:	57                   	push   %edi
80104059:	56                   	push   %esi
8010405a:	53                   	push   %ebx
8010405b:	83 ec 34             	sub    $0x34,%esp
8010405e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104061:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104064:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104067:	8d 55 da             	lea    -0x26(%ebp),%edx
8010406a:	52                   	push   %edx
8010406b:	50                   	push   %eax
8010406c:	e8 74 db ff ff       	call   80101be5 <nameiparent>
80104071:	89 c6                	mov    %eax,%esi
80104073:	83 c4 10             	add    $0x10,%esp
80104076:	85 c0                	test   %eax,%eax
80104078:	0f 84 33 01 00 00    	je     801041b1 <create+0x15c>
    return 0;
  ilock(dp);
8010407e:	83 ec 0c             	sub    $0xc,%esp
80104081:	50                   	push   %eax
80104082:	e8 e8 d4 ff ff       	call   8010156f <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104087:	83 c4 0c             	add    $0xc,%esp
8010408a:	6a 00                	push   $0x0
8010408c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010408f:	50                   	push   %eax
80104090:	56                   	push   %esi
80104091:	e8 09 d9 ff ff       	call   8010199f <dirlookup>
80104096:	89 c3                	mov    %eax,%ebx
80104098:	83 c4 10             	add    $0x10,%esp
8010409b:	85 c0                	test   %eax,%eax
8010409d:	74 3d                	je     801040dc <create+0x87>
    iunlockput(dp);
8010409f:	83 ec 0c             	sub    $0xc,%esp
801040a2:	56                   	push   %esi
801040a3:	e8 6e d6 ff ff       	call   80101716 <iunlockput>
    ilock(ip);
801040a8:	89 1c 24             	mov    %ebx,(%esp)
801040ab:	e8 bf d4 ff ff       	call   8010156f <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801040b0:	83 c4 10             	add    $0x10,%esp
801040b3:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801040b8:	75 07                	jne    801040c1 <create+0x6c>
801040ba:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
801040bf:	74 11                	je     801040d2 <create+0x7d>
      return ip;
    iunlockput(ip);
801040c1:	83 ec 0c             	sub    $0xc,%esp
801040c4:	53                   	push   %ebx
801040c5:	e8 4c d6 ff ff       	call   80101716 <iunlockput>
    return 0;
801040ca:	83 c4 10             	add    $0x10,%esp
801040cd:	bb 00 00 00 00       	mov    $0x0,%ebx
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801040d2:	89 d8                	mov    %ebx,%eax
801040d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040d7:	5b                   	pop    %ebx
801040d8:	5e                   	pop    %esi
801040d9:	5f                   	pop    %edi
801040da:	5d                   	pop    %ebp
801040db:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801040dc:	83 ec 08             	sub    $0x8,%esp
801040df:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801040e3:	50                   	push   %eax
801040e4:	ff 36                	push   (%esi)
801040e6:	e8 81 d2 ff ff       	call   8010136c <ialloc>
801040eb:	89 c3                	mov    %eax,%ebx
801040ed:	83 c4 10             	add    $0x10,%esp
801040f0:	85 c0                	test   %eax,%eax
801040f2:	74 52                	je     80104146 <create+0xf1>
  ilock(ip);
801040f4:	83 ec 0c             	sub    $0xc,%esp
801040f7:	50                   	push   %eax
801040f8:	e8 72 d4 ff ff       	call   8010156f <ilock>
  ip->major = major;
801040fd:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104101:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104105:	66 89 7b 54          	mov    %di,0x54(%ebx)
  ip->nlink = 1;
80104109:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  iupdate(ip);
8010410f:	89 1c 24             	mov    %ebx,(%esp)
80104112:	e8 f7 d2 ff ff       	call   8010140e <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104117:	83 c4 10             	add    $0x10,%esp
8010411a:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010411f:	74 32                	je     80104153 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
80104121:	83 ec 04             	sub    $0x4,%esp
80104124:	ff 73 04             	push   0x4(%ebx)
80104127:	8d 45 da             	lea    -0x26(%ebp),%eax
8010412a:	50                   	push   %eax
8010412b:	56                   	push   %esi
8010412c:	e8 eb d9 ff ff       	call   80101b1c <dirlink>
80104131:	83 c4 10             	add    $0x10,%esp
80104134:	85 c0                	test   %eax,%eax
80104136:	78 6c                	js     801041a4 <create+0x14f>
  iunlockput(dp);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	56                   	push   %esi
8010413c:	e8 d5 d5 ff ff       	call   80101716 <iunlockput>
  return ip;
80104141:	83 c4 10             	add    $0x10,%esp
80104144:	eb 8c                	jmp    801040d2 <create+0x7d>
    panic("create: ialloc");
80104146:	83 ec 0c             	sub    $0xc,%esp
80104149:	68 76 70 10 80       	push   $0x80107076
8010414e:	e8 f5 c1 ff ff       	call   80100348 <panic>
    dp->nlink++;  // for ".."
80104153:	0f b7 46 56          	movzwl 0x56(%esi),%eax
80104157:	83 c0 01             	add    $0x1,%eax
8010415a:	66 89 46 56          	mov    %ax,0x56(%esi)
    iupdate(dp);
8010415e:	83 ec 0c             	sub    $0xc,%esp
80104161:	56                   	push   %esi
80104162:	e8 a7 d2 ff ff       	call   8010140e <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104167:	83 c4 0c             	add    $0xc,%esp
8010416a:	ff 73 04             	push   0x4(%ebx)
8010416d:	68 86 70 10 80       	push   $0x80107086
80104172:	53                   	push   %ebx
80104173:	e8 a4 d9 ff ff       	call   80101b1c <dirlink>
80104178:	83 c4 10             	add    $0x10,%esp
8010417b:	85 c0                	test   %eax,%eax
8010417d:	78 18                	js     80104197 <create+0x142>
8010417f:	83 ec 04             	sub    $0x4,%esp
80104182:	ff 76 04             	push   0x4(%esi)
80104185:	68 85 70 10 80       	push   $0x80107085
8010418a:	53                   	push   %ebx
8010418b:	e8 8c d9 ff ff       	call   80101b1c <dirlink>
80104190:	83 c4 10             	add    $0x10,%esp
80104193:	85 c0                	test   %eax,%eax
80104195:	79 8a                	jns    80104121 <create+0xcc>
      panic("create dots");
80104197:	83 ec 0c             	sub    $0xc,%esp
8010419a:	68 88 70 10 80       	push   $0x80107088
8010419f:	e8 a4 c1 ff ff       	call   80100348 <panic>
    panic("create: dirlink");
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	68 94 70 10 80       	push   $0x80107094
801041ac:	e8 97 c1 ff ff       	call   80100348 <panic>
    return 0;
801041b1:	89 c3                	mov    %eax,%ebx
801041b3:	e9 1a ff ff ff       	jmp    801040d2 <create+0x7d>

801041b8 <sys_dup>:
{
801041b8:	55                   	push   %ebp
801041b9:	89 e5                	mov    %esp,%ebp
801041bb:	53                   	push   %ebx
801041bc:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
801041bf:	8d 4d f4             	lea    -0xc(%ebp),%ecx
801041c2:	ba 00 00 00 00       	mov    $0x0,%edx
801041c7:	b8 00 00 00 00       	mov    $0x0,%eax
801041cc:	e8 97 fd ff ff       	call   80103f68 <argfd>
801041d1:	85 c0                	test   %eax,%eax
801041d3:	78 23                	js     801041f8 <sys_dup+0x40>
  if((fd=fdalloc(f)) < 0)
801041d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d8:	e8 eb fd ff ff       	call   80103fc8 <fdalloc>
801041dd:	89 c3                	mov    %eax,%ebx
801041df:	85 c0                	test   %eax,%eax
801041e1:	78 1c                	js     801041ff <sys_dup+0x47>
  filedup(f);
801041e3:	83 ec 0c             	sub    $0xc,%esp
801041e6:	ff 75 f4             	push   -0xc(%ebp)
801041e9:	e8 90 ca ff ff       	call   80100c7e <filedup>
  return fd;
801041ee:	83 c4 10             	add    $0x10,%esp
}
801041f1:	89 d8                	mov    %ebx,%eax
801041f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041f6:	c9                   	leave  
801041f7:	c3                   	ret    
    return -1;
801041f8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801041fd:	eb f2                	jmp    801041f1 <sys_dup+0x39>
    return -1;
801041ff:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104204:	eb eb                	jmp    801041f1 <sys_dup+0x39>

80104206 <sys_read>:
{
80104206:	55                   	push   %ebp
80104207:	89 e5                	mov    %esp,%ebp
80104209:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010420c:	8d 4d f4             	lea    -0xc(%ebp),%ecx
8010420f:	ba 00 00 00 00       	mov    $0x0,%edx
80104214:	b8 00 00 00 00       	mov    $0x0,%eax
80104219:	e8 4a fd ff ff       	call   80103f68 <argfd>
8010421e:	85 c0                	test   %eax,%eax
80104220:	78 43                	js     80104265 <sys_read+0x5f>
80104222:	83 ec 08             	sub    $0x8,%esp
80104225:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104228:	50                   	push   %eax
80104229:	6a 02                	push   $0x2
8010422b:	e8 1e fc ff ff       	call   80103e4e <argint>
80104230:	83 c4 10             	add    $0x10,%esp
80104233:	85 c0                	test   %eax,%eax
80104235:	78 2e                	js     80104265 <sys_read+0x5f>
80104237:	83 ec 04             	sub    $0x4,%esp
8010423a:	ff 75 f0             	push   -0x10(%ebp)
8010423d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104240:	50                   	push   %eax
80104241:	6a 01                	push   $0x1
80104243:	e8 2e fc ff ff       	call   80103e76 <argptr>
80104248:	83 c4 10             	add    $0x10,%esp
8010424b:	85 c0                	test   %eax,%eax
8010424d:	78 16                	js     80104265 <sys_read+0x5f>
  return fileread(f, p, n);
8010424f:	83 ec 04             	sub    $0x4,%esp
80104252:	ff 75 f0             	push   -0x10(%ebp)
80104255:	ff 75 ec             	push   -0x14(%ebp)
80104258:	ff 75 f4             	push   -0xc(%ebp)
8010425b:	e8 70 cb ff ff       	call   80100dd0 <fileread>
80104260:	83 c4 10             	add    $0x10,%esp
}
80104263:	c9                   	leave  
80104264:	c3                   	ret    
    return -1;
80104265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010426a:	eb f7                	jmp    80104263 <sys_read+0x5d>

8010426c <sys_write>:
{
8010426c:	55                   	push   %ebp
8010426d:	89 e5                	mov    %esp,%ebp
8010426f:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104272:	8d 4d f4             	lea    -0xc(%ebp),%ecx
80104275:	ba 00 00 00 00       	mov    $0x0,%edx
8010427a:	b8 00 00 00 00       	mov    $0x0,%eax
8010427f:	e8 e4 fc ff ff       	call   80103f68 <argfd>
80104284:	85 c0                	test   %eax,%eax
80104286:	78 43                	js     801042cb <sys_write+0x5f>
80104288:	83 ec 08             	sub    $0x8,%esp
8010428b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010428e:	50                   	push   %eax
8010428f:	6a 02                	push   $0x2
80104291:	e8 b8 fb ff ff       	call   80103e4e <argint>
80104296:	83 c4 10             	add    $0x10,%esp
80104299:	85 c0                	test   %eax,%eax
8010429b:	78 2e                	js     801042cb <sys_write+0x5f>
8010429d:	83 ec 04             	sub    $0x4,%esp
801042a0:	ff 75 f0             	push   -0x10(%ebp)
801042a3:	8d 45 ec             	lea    -0x14(%ebp),%eax
801042a6:	50                   	push   %eax
801042a7:	6a 01                	push   $0x1
801042a9:	e8 c8 fb ff ff       	call   80103e76 <argptr>
801042ae:	83 c4 10             	add    $0x10,%esp
801042b1:	85 c0                	test   %eax,%eax
801042b3:	78 16                	js     801042cb <sys_write+0x5f>
  return filewrite(f, p, n);
801042b5:	83 ec 04             	sub    $0x4,%esp
801042b8:	ff 75 f0             	push   -0x10(%ebp)
801042bb:	ff 75 ec             	push   -0x14(%ebp)
801042be:	ff 75 f4             	push   -0xc(%ebp)
801042c1:	e8 8f cb ff ff       	call   80100e55 <filewrite>
801042c6:	83 c4 10             	add    $0x10,%esp
}
801042c9:	c9                   	leave  
801042ca:	c3                   	ret    
    return -1;
801042cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042d0:	eb f7                	jmp    801042c9 <sys_write+0x5d>

801042d2 <sys_close>:
{
801042d2:	55                   	push   %ebp
801042d3:	89 e5                	mov    %esp,%ebp
801042d5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801042d8:	8d 4d f0             	lea    -0x10(%ebp),%ecx
801042db:	8d 55 f4             	lea    -0xc(%ebp),%edx
801042de:	b8 00 00 00 00       	mov    $0x0,%eax
801042e3:	e8 80 fc ff ff       	call   80103f68 <argfd>
801042e8:	85 c0                	test   %eax,%eax
801042ea:	78 25                	js     80104311 <sys_close+0x3f>
  myproc()->ofile[fd] = 0;
801042ec:	e8 c4 ee ff ff       	call   801031b5 <myproc>
801042f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042f4:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801042fb:	00 
  fileclose(f);
801042fc:	83 ec 0c             	sub    $0xc,%esp
801042ff:	ff 75 f0             	push   -0x10(%ebp)
80104302:	e8 bc c9 ff ff       	call   80100cc3 <fileclose>
  return 0;
80104307:	83 c4 10             	add    $0x10,%esp
8010430a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010430f:	c9                   	leave  
80104310:	c3                   	ret    
    return -1;
80104311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104316:	eb f7                	jmp    8010430f <sys_close+0x3d>

80104318 <sys_fstat>:
{
80104318:	55                   	push   %ebp
80104319:	89 e5                	mov    %esp,%ebp
8010431b:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010431e:	8d 4d f4             	lea    -0xc(%ebp),%ecx
80104321:	ba 00 00 00 00       	mov    $0x0,%edx
80104326:	b8 00 00 00 00       	mov    $0x0,%eax
8010432b:	e8 38 fc ff ff       	call   80103f68 <argfd>
80104330:	85 c0                	test   %eax,%eax
80104332:	78 2a                	js     8010435e <sys_fstat+0x46>
80104334:	83 ec 04             	sub    $0x4,%esp
80104337:	6a 14                	push   $0x14
80104339:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010433c:	50                   	push   %eax
8010433d:	6a 01                	push   $0x1
8010433f:	e8 32 fb ff ff       	call   80103e76 <argptr>
80104344:	83 c4 10             	add    $0x10,%esp
80104347:	85 c0                	test   %eax,%eax
80104349:	78 13                	js     8010435e <sys_fstat+0x46>
  return filestat(f, st);
8010434b:	83 ec 08             	sub    $0x8,%esp
8010434e:	ff 75 f0             	push   -0x10(%ebp)
80104351:	ff 75 f4             	push   -0xc(%ebp)
80104354:	e8 30 ca ff ff       	call   80100d89 <filestat>
80104359:	83 c4 10             	add    $0x10,%esp
}
8010435c:	c9                   	leave  
8010435d:	c3                   	ret    
    return -1;
8010435e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104363:	eb f7                	jmp    8010435c <sys_fstat+0x44>

80104365 <sys_link>:
{
80104365:	55                   	push   %ebp
80104366:	89 e5                	mov    %esp,%ebp
80104368:	56                   	push   %esi
80104369:	53                   	push   %ebx
8010436a:	83 ec 28             	sub    $0x28,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010436d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104370:	50                   	push   %eax
80104371:	6a 00                	push   $0x0
80104373:	e8 66 fb ff ff       	call   80103ede <argstr>
80104378:	83 c4 10             	add    $0x10,%esp
8010437b:	85 c0                	test   %eax,%eax
8010437d:	0f 88 d3 00 00 00    	js     80104456 <sys_link+0xf1>
80104383:	83 ec 08             	sub    $0x8,%esp
80104386:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104389:	50                   	push   %eax
8010438a:	6a 01                	push   $0x1
8010438c:	e8 4d fb ff ff       	call   80103ede <argstr>
80104391:	83 c4 10             	add    $0x10,%esp
80104394:	85 c0                	test   %eax,%eax
80104396:	0f 88 ba 00 00 00    	js     80104456 <sys_link+0xf1>
  begin_op();
8010439c:	e8 dd e3 ff ff       	call   8010277e <begin_op>
  if((ip = namei(old)) == 0){
801043a1:	83 ec 0c             	sub    $0xc,%esp
801043a4:	ff 75 e0             	push   -0x20(%ebp)
801043a7:	e8 21 d8 ff ff       	call   80101bcd <namei>
801043ac:	89 c3                	mov    %eax,%ebx
801043ae:	83 c4 10             	add    $0x10,%esp
801043b1:	85 c0                	test   %eax,%eax
801043b3:	0f 84 a4 00 00 00    	je     8010445d <sys_link+0xf8>
  ilock(ip);
801043b9:	83 ec 0c             	sub    $0xc,%esp
801043bc:	50                   	push   %eax
801043bd:	e8 ad d1 ff ff       	call   8010156f <ilock>
  if(ip->type == T_DIR){
801043c2:	83 c4 10             	add    $0x10,%esp
801043c5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801043ca:	0f 84 99 00 00 00    	je     80104469 <sys_link+0x104>
  ip->nlink++;
801043d0:	0f b7 43 56          	movzwl 0x56(%ebx),%eax
801043d4:	83 c0 01             	add    $0x1,%eax
801043d7:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	53                   	push   %ebx
801043df:	e8 2a d0 ff ff       	call   8010140e <iupdate>
  iunlock(ip);
801043e4:	89 1c 24             	mov    %ebx,(%esp)
801043e7:	e8 45 d2 ff ff       	call   80101631 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801043ec:	83 c4 08             	add    $0x8,%esp
801043ef:	8d 45 ea             	lea    -0x16(%ebp),%eax
801043f2:	50                   	push   %eax
801043f3:	ff 75 e4             	push   -0x1c(%ebp)
801043f6:	e8 ea d7 ff ff       	call   80101be5 <nameiparent>
801043fb:	89 c6                	mov    %eax,%esi
801043fd:	83 c4 10             	add    $0x10,%esp
80104400:	85 c0                	test   %eax,%eax
80104402:	0f 84 85 00 00 00    	je     8010448d <sys_link+0x128>
  ilock(dp);
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	50                   	push   %eax
8010440c:	e8 5e d1 ff ff       	call   8010156f <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104411:	83 c4 10             	add    $0x10,%esp
80104414:	8b 03                	mov    (%ebx),%eax
80104416:	39 06                	cmp    %eax,(%esi)
80104418:	75 67                	jne    80104481 <sys_link+0x11c>
8010441a:	83 ec 04             	sub    $0x4,%esp
8010441d:	ff 73 04             	push   0x4(%ebx)
80104420:	8d 45 ea             	lea    -0x16(%ebp),%eax
80104423:	50                   	push   %eax
80104424:	56                   	push   %esi
80104425:	e8 f2 d6 ff ff       	call   80101b1c <dirlink>
8010442a:	83 c4 10             	add    $0x10,%esp
8010442d:	85 c0                	test   %eax,%eax
8010442f:	78 50                	js     80104481 <sys_link+0x11c>
  iunlockput(dp);
80104431:	83 ec 0c             	sub    $0xc,%esp
80104434:	56                   	push   %esi
80104435:	e8 dc d2 ff ff       	call   80101716 <iunlockput>
  iput(ip);
8010443a:	89 1c 24             	mov    %ebx,(%esp)
8010443d:	e8 34 d2 ff ff       	call   80101676 <iput>
  end_op();
80104442:	e8 b1 e3 ff ff       	call   801027f8 <end_op>
  return 0;
80104447:	83 c4 10             	add    $0x10,%esp
8010444a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010444f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104452:	5b                   	pop    %ebx
80104453:	5e                   	pop    %esi
80104454:	5d                   	pop    %ebp
80104455:	c3                   	ret    
    return -1;
80104456:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010445b:	eb f2                	jmp    8010444f <sys_link+0xea>
    end_op();
8010445d:	e8 96 e3 ff ff       	call   801027f8 <end_op>
    return -1;
80104462:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104467:	eb e6                	jmp    8010444f <sys_link+0xea>
    iunlockput(ip);
80104469:	83 ec 0c             	sub    $0xc,%esp
8010446c:	53                   	push   %ebx
8010446d:	e8 a4 d2 ff ff       	call   80101716 <iunlockput>
    end_op();
80104472:	e8 81 e3 ff ff       	call   801027f8 <end_op>
    return -1;
80104477:	83 c4 10             	add    $0x10,%esp
8010447a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010447f:	eb ce                	jmp    8010444f <sys_link+0xea>
    iunlockput(dp);
80104481:	83 ec 0c             	sub    $0xc,%esp
80104484:	56                   	push   %esi
80104485:	e8 8c d2 ff ff       	call   80101716 <iunlockput>
    goto bad;
8010448a:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010448d:	83 ec 0c             	sub    $0xc,%esp
80104490:	53                   	push   %ebx
80104491:	e8 d9 d0 ff ff       	call   8010156f <ilock>
  ip->nlink--;
80104496:	0f b7 43 56          	movzwl 0x56(%ebx),%eax
8010449a:	83 e8 01             	sub    $0x1,%eax
8010449d:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801044a1:	89 1c 24             	mov    %ebx,(%esp)
801044a4:	e8 65 cf ff ff       	call   8010140e <iupdate>
  iunlockput(ip);
801044a9:	89 1c 24             	mov    %ebx,(%esp)
801044ac:	e8 65 d2 ff ff       	call   80101716 <iunlockput>
  end_op();
801044b1:	e8 42 e3 ff ff       	call   801027f8 <end_op>
  return -1;
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044be:	eb 8f                	jmp    8010444f <sys_link+0xea>

801044c0 <sys_unlink>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	56                   	push   %esi
801044c5:	53                   	push   %ebx
801044c6:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801044c9:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801044cc:	50                   	push   %eax
801044cd:	6a 00                	push   $0x0
801044cf:	e8 0a fa ff ff       	call   80103ede <argstr>
801044d4:	83 c4 10             	add    $0x10,%esp
801044d7:	85 c0                	test   %eax,%eax
801044d9:	0f 88 83 01 00 00    	js     80104662 <sys_unlink+0x1a2>
  begin_op();
801044df:	e8 9a e2 ff ff       	call   8010277e <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801044e4:	83 ec 08             	sub    $0x8,%esp
801044e7:	8d 45 ca             	lea    -0x36(%ebp),%eax
801044ea:	50                   	push   %eax
801044eb:	ff 75 c4             	push   -0x3c(%ebp)
801044ee:	e8 f2 d6 ff ff       	call   80101be5 <nameiparent>
801044f3:	89 c6                	mov    %eax,%esi
801044f5:	83 c4 10             	add    $0x10,%esp
801044f8:	85 c0                	test   %eax,%eax
801044fa:	0f 84 ed 00 00 00    	je     801045ed <sys_unlink+0x12d>
  ilock(dp);
80104500:	83 ec 0c             	sub    $0xc,%esp
80104503:	50                   	push   %eax
80104504:	e8 66 d0 ff ff       	call   8010156f <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104509:	83 c4 08             	add    $0x8,%esp
8010450c:	68 86 70 10 80       	push   $0x80107086
80104511:	8d 45 ca             	lea    -0x36(%ebp),%eax
80104514:	50                   	push   %eax
80104515:	e8 70 d4 ff ff       	call   8010198a <namecmp>
8010451a:	83 c4 10             	add    $0x10,%esp
8010451d:	85 c0                	test   %eax,%eax
8010451f:	0f 84 fc 00 00 00    	je     80104621 <sys_unlink+0x161>
80104525:	83 ec 08             	sub    $0x8,%esp
80104528:	68 85 70 10 80       	push   $0x80107085
8010452d:	8d 45 ca             	lea    -0x36(%ebp),%eax
80104530:	50                   	push   %eax
80104531:	e8 54 d4 ff ff       	call   8010198a <namecmp>
80104536:	83 c4 10             	add    $0x10,%esp
80104539:	85 c0                	test   %eax,%eax
8010453b:	0f 84 e0 00 00 00    	je     80104621 <sys_unlink+0x161>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104541:	83 ec 04             	sub    $0x4,%esp
80104544:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104547:	50                   	push   %eax
80104548:	8d 45 ca             	lea    -0x36(%ebp),%eax
8010454b:	50                   	push   %eax
8010454c:	56                   	push   %esi
8010454d:	e8 4d d4 ff ff       	call   8010199f <dirlookup>
80104552:	89 c3                	mov    %eax,%ebx
80104554:	83 c4 10             	add    $0x10,%esp
80104557:	85 c0                	test   %eax,%eax
80104559:	0f 84 c2 00 00 00    	je     80104621 <sys_unlink+0x161>
  ilock(ip);
8010455f:	83 ec 0c             	sub    $0xc,%esp
80104562:	50                   	push   %eax
80104563:	e8 07 d0 ff ff       	call   8010156f <ilock>
  if(ip->nlink < 1)
80104568:	83 c4 10             	add    $0x10,%esp
8010456b:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104570:	0f 8e 83 00 00 00    	jle    801045f9 <sys_unlink+0x139>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104576:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010457b:	0f 84 85 00 00 00    	je     80104606 <sys_unlink+0x146>
  memset(&de, 0, sizeof(de));
80104581:	83 ec 04             	sub    $0x4,%esp
80104584:	6a 10                	push   $0x10
80104586:	6a 00                	push   $0x0
80104588:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010458b:	57                   	push   %edi
8010458c:	e8 6d f6 ff ff       	call   80103bfe <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104591:	6a 10                	push   $0x10
80104593:	ff 75 c0             	push   -0x40(%ebp)
80104596:	57                   	push   %edi
80104597:	56                   	push   %esi
80104598:	e8 c1 d2 ff ff       	call   8010185e <writei>
8010459d:	83 c4 20             	add    $0x20,%esp
801045a0:	83 f8 10             	cmp    $0x10,%eax
801045a3:	0f 85 90 00 00 00    	jne    80104639 <sys_unlink+0x179>
  if(ip->type == T_DIR){
801045a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801045ae:	0f 84 92 00 00 00    	je     80104646 <sys_unlink+0x186>
  iunlockput(dp);
801045b4:	83 ec 0c             	sub    $0xc,%esp
801045b7:	56                   	push   %esi
801045b8:	e8 59 d1 ff ff       	call   80101716 <iunlockput>
  ip->nlink--;
801045bd:	0f b7 43 56          	movzwl 0x56(%ebx),%eax
801045c1:	83 e8 01             	sub    $0x1,%eax
801045c4:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801045c8:	89 1c 24             	mov    %ebx,(%esp)
801045cb:	e8 3e ce ff ff       	call   8010140e <iupdate>
  iunlockput(ip);
801045d0:	89 1c 24             	mov    %ebx,(%esp)
801045d3:	e8 3e d1 ff ff       	call   80101716 <iunlockput>
  end_op();
801045d8:	e8 1b e2 ff ff       	call   801027f8 <end_op>
  return 0;
801045dd:	83 c4 10             	add    $0x10,%esp
801045e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045e8:	5b                   	pop    %ebx
801045e9:	5e                   	pop    %esi
801045ea:	5f                   	pop    %edi
801045eb:	5d                   	pop    %ebp
801045ec:	c3                   	ret    
    end_op();
801045ed:	e8 06 e2 ff ff       	call   801027f8 <end_op>
    return -1;
801045f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045f7:	eb ec                	jmp    801045e5 <sys_unlink+0x125>
    panic("unlink: nlink < 1");
801045f9:	83 ec 0c             	sub    $0xc,%esp
801045fc:	68 a4 70 10 80       	push   $0x801070a4
80104601:	e8 42 bd ff ff       	call   80100348 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104606:	89 d8                	mov    %ebx,%eax
80104608:	e8 f1 f9 ff ff       	call   80103ffe <isdirempty>
8010460d:	85 c0                	test   %eax,%eax
8010460f:	0f 85 6c ff ff ff    	jne    80104581 <sys_unlink+0xc1>
    iunlockput(ip);
80104615:	83 ec 0c             	sub    $0xc,%esp
80104618:	53                   	push   %ebx
80104619:	e8 f8 d0 ff ff       	call   80101716 <iunlockput>
    goto bad;
8010461e:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80104621:	83 ec 0c             	sub    $0xc,%esp
80104624:	56                   	push   %esi
80104625:	e8 ec d0 ff ff       	call   80101716 <iunlockput>
  end_op();
8010462a:	e8 c9 e1 ff ff       	call   801027f8 <end_op>
  return -1;
8010462f:	83 c4 10             	add    $0x10,%esp
80104632:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104637:	eb ac                	jmp    801045e5 <sys_unlink+0x125>
    panic("unlink: writei");
80104639:	83 ec 0c             	sub    $0xc,%esp
8010463c:	68 b6 70 10 80       	push   $0x801070b6
80104641:	e8 02 bd ff ff       	call   80100348 <panic>
    dp->nlink--;
80104646:	0f b7 46 56          	movzwl 0x56(%esi),%eax
8010464a:	83 e8 01             	sub    $0x1,%eax
8010464d:	66 89 46 56          	mov    %ax,0x56(%esi)
    iupdate(dp);
80104651:	83 ec 0c             	sub    $0xc,%esp
80104654:	56                   	push   %esi
80104655:	e8 b4 cd ff ff       	call   8010140e <iupdate>
8010465a:	83 c4 10             	add    $0x10,%esp
8010465d:	e9 52 ff ff ff       	jmp    801045b4 <sys_unlink+0xf4>
    return -1;
80104662:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104667:	e9 79 ff ff ff       	jmp    801045e5 <sys_unlink+0x125>

8010466c <sys_open>:

int
sys_open(void)
{
8010466c:	55                   	push   %ebp
8010466d:	89 e5                	mov    %esp,%ebp
8010466f:	57                   	push   %edi
80104670:	56                   	push   %esi
80104671:	53                   	push   %ebx
80104672:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104675:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104678:	50                   	push   %eax
80104679:	6a 00                	push   $0x0
8010467b:	e8 5e f8 ff ff       	call   80103ede <argstr>
80104680:	83 c4 10             	add    $0x10,%esp
80104683:	85 c0                	test   %eax,%eax
80104685:	0f 88 a0 00 00 00    	js     8010472b <sys_open+0xbf>
8010468b:	83 ec 08             	sub    $0x8,%esp
8010468e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104691:	50                   	push   %eax
80104692:	6a 01                	push   $0x1
80104694:	e8 b5 f7 ff ff       	call   80103e4e <argint>
80104699:	83 c4 10             	add    $0x10,%esp
8010469c:	85 c0                	test   %eax,%eax
8010469e:	0f 88 87 00 00 00    	js     8010472b <sys_open+0xbf>
    return -1;

  begin_op();
801046a4:	e8 d5 e0 ff ff       	call   8010277e <begin_op>

  if(omode & O_CREATE){
801046a9:	f6 45 e1 02          	testb  $0x2,-0x1f(%ebp)
801046ad:	0f 84 8b 00 00 00    	je     8010473e <sys_open+0xd2>
    ip = create(path, T_FILE, 0, 0);
801046b3:	83 ec 0c             	sub    $0xc,%esp
801046b6:	6a 00                	push   $0x0
801046b8:	b9 00 00 00 00       	mov    $0x0,%ecx
801046bd:	ba 02 00 00 00       	mov    $0x2,%edx
801046c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801046c5:	e8 8b f9 ff ff       	call   80104055 <create>
801046ca:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801046cc:	83 c4 10             	add    $0x10,%esp
801046cf:	85 c0                	test   %eax,%eax
801046d1:	74 5f                	je     80104732 <sys_open+0xc6>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801046d3:	e8 45 c5 ff ff       	call   80100c1d <filealloc>
801046d8:	89 c3                	mov    %eax,%ebx
801046da:	85 c0                	test   %eax,%eax
801046dc:	0f 84 b5 00 00 00    	je     80104797 <sys_open+0x12b>
801046e2:	e8 e1 f8 ff ff       	call   80103fc8 <fdalloc>
801046e7:	89 c7                	mov    %eax,%edi
801046e9:	85 c0                	test   %eax,%eax
801046eb:	0f 88 a6 00 00 00    	js     80104797 <sys_open+0x12b>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801046f1:	83 ec 0c             	sub    $0xc,%esp
801046f4:	56                   	push   %esi
801046f5:	e8 37 cf ff ff       	call   80101631 <iunlock>
  end_op();
801046fa:	e8 f9 e0 ff ff       	call   801027f8 <end_op>

  f->type = FD_INODE;
801046ff:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80104705:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104708:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
8010470f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104712:	83 c4 10             	add    $0x10,%esp
80104715:	a8 01                	test   $0x1,%al
80104717:	0f 94 43 08          	sete   0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010471b:	a8 03                	test   $0x3,%al
8010471d:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
}
80104721:	89 f8                	mov    %edi,%eax
80104723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104726:	5b                   	pop    %ebx
80104727:	5e                   	pop    %esi
80104728:	5f                   	pop    %edi
80104729:	5d                   	pop    %ebp
8010472a:	c3                   	ret    
    return -1;
8010472b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104730:	eb ef                	jmp    80104721 <sys_open+0xb5>
      end_op();
80104732:	e8 c1 e0 ff ff       	call   801027f8 <end_op>
      return -1;
80104737:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010473c:	eb e3                	jmp    80104721 <sys_open+0xb5>
    if((ip = namei(path)) == 0){
8010473e:	83 ec 0c             	sub    $0xc,%esp
80104741:	ff 75 e4             	push   -0x1c(%ebp)
80104744:	e8 84 d4 ff ff       	call   80101bcd <namei>
80104749:	89 c6                	mov    %eax,%esi
8010474b:	83 c4 10             	add    $0x10,%esp
8010474e:	85 c0                	test   %eax,%eax
80104750:	74 39                	je     8010478b <sys_open+0x11f>
    ilock(ip);
80104752:	83 ec 0c             	sub    $0xc,%esp
80104755:	50                   	push   %eax
80104756:	e8 14 ce ff ff       	call   8010156f <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010475b:	83 c4 10             	add    $0x10,%esp
8010475e:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104763:	0f 85 6a ff ff ff    	jne    801046d3 <sys_open+0x67>
80104769:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010476d:	0f 84 60 ff ff ff    	je     801046d3 <sys_open+0x67>
      iunlockput(ip);
80104773:	83 ec 0c             	sub    $0xc,%esp
80104776:	56                   	push   %esi
80104777:	e8 9a cf ff ff       	call   80101716 <iunlockput>
      end_op();
8010477c:	e8 77 e0 ff ff       	call   801027f8 <end_op>
      return -1;
80104781:	83 c4 10             	add    $0x10,%esp
80104784:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104789:	eb 96                	jmp    80104721 <sys_open+0xb5>
      end_op();
8010478b:	e8 68 e0 ff ff       	call   801027f8 <end_op>
      return -1;
80104790:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104795:	eb 8a                	jmp    80104721 <sys_open+0xb5>
    if(f)
80104797:	85 db                	test   %ebx,%ebx
80104799:	74 0c                	je     801047a7 <sys_open+0x13b>
      fileclose(f);
8010479b:	83 ec 0c             	sub    $0xc,%esp
8010479e:	53                   	push   %ebx
8010479f:	e8 1f c5 ff ff       	call   80100cc3 <fileclose>
801047a4:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801047a7:	83 ec 0c             	sub    $0xc,%esp
801047aa:	56                   	push   %esi
801047ab:	e8 66 cf ff ff       	call   80101716 <iunlockput>
    end_op();
801047b0:	e8 43 e0 ff ff       	call   801027f8 <end_op>
    return -1;
801047b5:	83 c4 10             	add    $0x10,%esp
801047b8:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801047bd:	e9 5f ff ff ff       	jmp    80104721 <sys_open+0xb5>

801047c2 <sys_mkdir>:
// int mkdir(const char*);

int
sys_mkdir(void)
{
801047c2:	55                   	push   %ebp
801047c3:	89 e5                	mov    %esp,%ebp
801047c5:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801047c8:	e8 b1 df ff ff       	call   8010277e <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801047cd:	83 ec 08             	sub    $0x8,%esp
801047d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801047d3:	50                   	push   %eax
801047d4:	6a 00                	push   $0x0
801047d6:	e8 03 f7 ff ff       	call   80103ede <argstr>
801047db:	83 c4 10             	add    $0x10,%esp
801047de:	85 c0                	test   %eax,%eax
801047e0:	78 36                	js     80104818 <sys_mkdir+0x56>
801047e2:	83 ec 0c             	sub    $0xc,%esp
801047e5:	6a 00                	push   $0x0
801047e7:	b9 00 00 00 00       	mov    $0x0,%ecx
801047ec:	ba 01 00 00 00       	mov    $0x1,%edx
801047f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047f4:	e8 5c f8 ff ff       	call   80104055 <create>
801047f9:	83 c4 10             	add    $0x10,%esp
801047fc:	85 c0                	test   %eax,%eax
801047fe:	74 18                	je     80104818 <sys_mkdir+0x56>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	50                   	push   %eax
80104804:	e8 0d cf ff ff       	call   80101716 <iunlockput>
  end_op();
80104809:	e8 ea df ff ff       	call   801027f8 <end_op>
  return 0;
8010480e:	83 c4 10             	add    $0x10,%esp
80104811:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104816:	c9                   	leave  
80104817:	c3                   	ret    
    end_op();
80104818:	e8 db df ff ff       	call   801027f8 <end_op>
    return -1;
8010481d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104822:	eb f2                	jmp    80104816 <sys_mkdir+0x54>

80104824 <sys_mknod>:

int
sys_mknod(void)
{
80104824:	55                   	push   %ebp
80104825:	89 e5                	mov    %esp,%ebp
80104827:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
8010482a:	e8 4f df ff ff       	call   8010277e <begin_op>
  if((argstr(0, &path)) < 0 ||
8010482f:	83 ec 08             	sub    $0x8,%esp
80104832:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104835:	50                   	push   %eax
80104836:	6a 00                	push   $0x0
80104838:	e8 a1 f6 ff ff       	call   80103ede <argstr>
8010483d:	83 c4 10             	add    $0x10,%esp
80104840:	85 c0                	test   %eax,%eax
80104842:	78 62                	js     801048a6 <sys_mknod+0x82>
     argint(1, &major) < 0 ||
80104844:	83 ec 08             	sub    $0x8,%esp
80104847:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010484a:	50                   	push   %eax
8010484b:	6a 01                	push   $0x1
8010484d:	e8 fc f5 ff ff       	call   80103e4e <argint>
  if((argstr(0, &path)) < 0 ||
80104852:	83 c4 10             	add    $0x10,%esp
80104855:	85 c0                	test   %eax,%eax
80104857:	78 4d                	js     801048a6 <sys_mknod+0x82>
     argint(2, &minor) < 0 ||
80104859:	83 ec 08             	sub    $0x8,%esp
8010485c:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010485f:	50                   	push   %eax
80104860:	6a 02                	push   $0x2
80104862:	e8 e7 f5 ff ff       	call   80103e4e <argint>
     argint(1, &major) < 0 ||
80104867:	83 c4 10             	add    $0x10,%esp
8010486a:	85 c0                	test   %eax,%eax
8010486c:	78 38                	js     801048a6 <sys_mknod+0x82>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010486e:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104872:	83 ec 0c             	sub    $0xc,%esp
80104875:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
80104879:	50                   	push   %eax
8010487a:	ba 03 00 00 00       	mov    $0x3,%edx
8010487f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104882:	e8 ce f7 ff ff       	call   80104055 <create>
     argint(2, &minor) < 0 ||
80104887:	83 c4 10             	add    $0x10,%esp
8010488a:	85 c0                	test   %eax,%eax
8010488c:	74 18                	je     801048a6 <sys_mknod+0x82>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010488e:	83 ec 0c             	sub    $0xc,%esp
80104891:	50                   	push   %eax
80104892:	e8 7f ce ff ff       	call   80101716 <iunlockput>
  end_op();
80104897:	e8 5c df ff ff       	call   801027f8 <end_op>
  return 0;
8010489c:	83 c4 10             	add    $0x10,%esp
8010489f:	b8 00 00 00 00       	mov    $0x0,%eax
}
801048a4:	c9                   	leave  
801048a5:	c3                   	ret    
    end_op();
801048a6:	e8 4d df ff ff       	call   801027f8 <end_op>
    return -1;
801048ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048b0:	eb f2                	jmp    801048a4 <sys_mknod+0x80>

801048b2 <sys_chdir>:

int
sys_chdir(void)
{
801048b2:	55                   	push   %ebp
801048b3:	89 e5                	mov    %esp,%ebp
801048b5:	56                   	push   %esi
801048b6:	53                   	push   %ebx
801048b7:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801048ba:	e8 f6 e8 ff ff       	call   801031b5 <myproc>
801048bf:	89 c6                	mov    %eax,%esi
  
  begin_op();
801048c1:	e8 b8 de ff ff       	call   8010277e <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801048c6:	83 ec 08             	sub    $0x8,%esp
801048c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048cc:	50                   	push   %eax
801048cd:	6a 00                	push   $0x0
801048cf:	e8 0a f6 ff ff       	call   80103ede <argstr>
801048d4:	83 c4 10             	add    $0x10,%esp
801048d7:	85 c0                	test   %eax,%eax
801048d9:	78 52                	js     8010492d <sys_chdir+0x7b>
801048db:	83 ec 0c             	sub    $0xc,%esp
801048de:	ff 75 f4             	push   -0xc(%ebp)
801048e1:	e8 e7 d2 ff ff       	call   80101bcd <namei>
801048e6:	89 c3                	mov    %eax,%ebx
801048e8:	83 c4 10             	add    $0x10,%esp
801048eb:	85 c0                	test   %eax,%eax
801048ed:	74 3e                	je     8010492d <sys_chdir+0x7b>
    end_op();
    return -1;
  }
  ilock(ip);
801048ef:	83 ec 0c             	sub    $0xc,%esp
801048f2:	50                   	push   %eax
801048f3:	e8 77 cc ff ff       	call   8010156f <ilock>
  if(ip->type != T_DIR){
801048f8:	83 c4 10             	add    $0x10,%esp
801048fb:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104900:	75 37                	jne    80104939 <sys_chdir+0x87>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104902:	83 ec 0c             	sub    $0xc,%esp
80104905:	53                   	push   %ebx
80104906:	e8 26 cd ff ff       	call   80101631 <iunlock>
  iput(curproc->cwd);
8010490b:	83 c4 04             	add    $0x4,%esp
8010490e:	ff 76 68             	push   0x68(%esi)
80104911:	e8 60 cd ff ff       	call   80101676 <iput>
  end_op();
80104916:	e8 dd de ff ff       	call   801027f8 <end_op>
  curproc->cwd = ip;
8010491b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010491e:	83 c4 10             	add    $0x10,%esp
80104921:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104926:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104929:	5b                   	pop    %ebx
8010492a:	5e                   	pop    %esi
8010492b:	5d                   	pop    %ebp
8010492c:	c3                   	ret    
    end_op();
8010492d:	e8 c6 de ff ff       	call   801027f8 <end_op>
    return -1;
80104932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104937:	eb ed                	jmp    80104926 <sys_chdir+0x74>
    iunlockput(ip);
80104939:	83 ec 0c             	sub    $0xc,%esp
8010493c:	53                   	push   %ebx
8010493d:	e8 d4 cd ff ff       	call   80101716 <iunlockput>
    end_op();
80104942:	e8 b1 de ff ff       	call   801027f8 <end_op>
    return -1;
80104947:	83 c4 10             	add    $0x10,%esp
8010494a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010494f:	eb d5                	jmp    80104926 <sys_chdir+0x74>

80104951 <sys_exec>:

int
sys_exec(void)
{
80104951:	55                   	push   %ebp
80104952:	89 e5                	mov    %esp,%ebp
80104954:	53                   	push   %ebx
80104955:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010495b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010495e:	50                   	push   %eax
8010495f:	6a 00                	push   $0x0
80104961:	e8 78 f5 ff ff       	call   80103ede <argstr>
80104966:	83 c4 10             	add    $0x10,%esp
80104969:	85 c0                	test   %eax,%eax
8010496b:	78 38                	js     801049a5 <sys_exec+0x54>
8010496d:	83 ec 08             	sub    $0x8,%esp
80104970:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80104976:	50                   	push   %eax
80104977:	6a 01                	push   $0x1
80104979:	e8 d0 f4 ff ff       	call   80103e4e <argint>
8010497e:	83 c4 10             	add    $0x10,%esp
80104981:	85 c0                	test   %eax,%eax
80104983:	78 20                	js     801049a5 <sys_exec+0x54>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104985:	83 ec 04             	sub    $0x4,%esp
80104988:	68 80 00 00 00       	push   $0x80
8010498d:	6a 00                	push   $0x0
8010498f:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
80104995:	50                   	push   %eax
80104996:	e8 63 f2 ff ff       	call   80103bfe <memset>
8010499b:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
8010499e:	bb 00 00 00 00       	mov    $0x0,%ebx
801049a3:	eb 2c                	jmp    801049d1 <sys_exec+0x80>
    return -1;
801049a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049aa:	eb 78                	jmp    80104a24 <sys_exec+0xd3>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801049ac:	c7 84 9d 74 ff ff ff 	movl   $0x0,-0x8c(%ebp,%ebx,4)
801049b3:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801049b7:	83 ec 08             	sub    $0x8,%esp
801049ba:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
801049c0:	50                   	push   %eax
801049c1:	ff 75 f4             	push   -0xc(%ebp)
801049c4:	e8 05 bf ff ff       	call   801008ce <exec>
801049c9:	83 c4 10             	add    $0x10,%esp
801049cc:	eb 56                	jmp    80104a24 <sys_exec+0xd3>
  for(i=0;; i++){
801049ce:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801049d1:	83 fb 1f             	cmp    $0x1f,%ebx
801049d4:	77 49                	ja     80104a1f <sys_exec+0xce>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801049d6:	83 ec 08             	sub    $0x8,%esp
801049d9:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801049df:	50                   	push   %eax
801049e0:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
801049e6:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801049e9:	50                   	push   %eax
801049ea:	e8 e5 f3 ff ff       	call   80103dd4 <fetchint>
801049ef:	83 c4 10             	add    $0x10,%esp
801049f2:	85 c0                	test   %eax,%eax
801049f4:	78 33                	js     80104a29 <sys_exec+0xd8>
    if(uarg == 0){
801049f6:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801049fc:	85 c0                	test   %eax,%eax
801049fe:	74 ac                	je     801049ac <sys_exec+0x5b>
    if(fetchstr(uarg, &argv[i]) < 0)
80104a00:	83 ec 08             	sub    $0x8,%esp
80104a03:	8d 94 9d 74 ff ff ff 	lea    -0x8c(%ebp,%ebx,4),%edx
80104a0a:	52                   	push   %edx
80104a0b:	50                   	push   %eax
80104a0c:	e8 fe f3 ff ff       	call   80103e0f <fetchstr>
80104a11:	83 c4 10             	add    $0x10,%esp
80104a14:	85 c0                	test   %eax,%eax
80104a16:	79 b6                	jns    801049ce <sys_exec+0x7d>
      return -1;
80104a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a1d:	eb 05                	jmp    80104a24 <sys_exec+0xd3>
      return -1;
80104a1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a27:	c9                   	leave  
80104a28:	c3                   	ret    
      return -1;
80104a29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a2e:	eb f4                	jmp    80104a24 <sys_exec+0xd3>

80104a30 <sys_pipe>:

int
sys_pipe(void)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	53                   	push   %ebx
80104a34:	83 ec 18             	sub    $0x18,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104a37:	6a 08                	push   $0x8
80104a39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a3c:	50                   	push   %eax
80104a3d:	6a 00                	push   $0x0
80104a3f:	e8 32 f4 ff ff       	call   80103e76 <argptr>
80104a44:	83 c4 10             	add    $0x10,%esp
80104a47:	85 c0                	test   %eax,%eax
80104a49:	78 79                	js     80104ac4 <sys_pipe+0x94>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104a4b:	83 ec 08             	sub    $0x8,%esp
80104a4e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104a51:	50                   	push   %eax
80104a52:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a55:	50                   	push   %eax
80104a56:	e8 ac e2 ff ff       	call   80102d07 <pipealloc>
80104a5b:	83 c4 10             	add    $0x10,%esp
80104a5e:	85 c0                	test   %eax,%eax
80104a60:	78 69                	js     80104acb <sys_pipe+0x9b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a65:	e8 5e f5 ff ff       	call   80103fc8 <fdalloc>
80104a6a:	89 c3                	mov    %eax,%ebx
80104a6c:	85 c0                	test   %eax,%eax
80104a6e:	78 21                	js     80104a91 <sys_pipe+0x61>
80104a70:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a73:	e8 50 f5 ff ff       	call   80103fc8 <fdalloc>
80104a78:	85 c0                	test   %eax,%eax
80104a7a:	78 15                	js     80104a91 <sys_pipe+0x61>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104a7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a7f:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80104a81:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a84:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80104a87:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104a8c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a8f:	c9                   	leave  
80104a90:	c3                   	ret    
    if(fd0 >= 0)
80104a91:	85 db                	test   %ebx,%ebx
80104a93:	79 20                	jns    80104ab5 <sys_pipe+0x85>
    fileclose(rf);
80104a95:	83 ec 0c             	sub    $0xc,%esp
80104a98:	ff 75 f0             	push   -0x10(%ebp)
80104a9b:	e8 23 c2 ff ff       	call   80100cc3 <fileclose>
    fileclose(wf);
80104aa0:	83 c4 04             	add    $0x4,%esp
80104aa3:	ff 75 ec             	push   -0x14(%ebp)
80104aa6:	e8 18 c2 ff ff       	call   80100cc3 <fileclose>
    return -1;
80104aab:	83 c4 10             	add    $0x10,%esp
80104aae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ab3:	eb d7                	jmp    80104a8c <sys_pipe+0x5c>
      myproc()->ofile[fd0] = 0;
80104ab5:	e8 fb e6 ff ff       	call   801031b5 <myproc>
80104aba:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
80104ac1:	00 
80104ac2:	eb d1                	jmp    80104a95 <sys_pipe+0x65>
    return -1;
80104ac4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ac9:	eb c1                	jmp    80104a8c <sys_pipe+0x5c>
    return -1;
80104acb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad0:	eb ba                	jmp    80104a8c <sys_pipe+0x5c>

80104ad2 <sys_fork>:
#include "proc.h"
#include "ptentry.h"

int
sys_fork(void)
{
80104ad2:	55                   	push   %ebp
80104ad3:	89 e5                	mov    %esp,%ebp
80104ad5:	83 ec 08             	sub    $0x8,%esp
  return fork();
80104ad8:	e8 4e e8 ff ff       	call   8010332b <fork>
}
80104add:	c9                   	leave  
80104ade:	c3                   	ret    

80104adf <sys_exit>:

int
sys_exit(void)
{
80104adf:	55                   	push   %ebp
80104ae0:	89 e5                	mov    %esp,%ebp
80104ae2:	83 ec 08             	sub    $0x8,%esp
  exit();
80104ae5:	e8 75 ea ff ff       	call   8010355f <exit>
  return 0;  // not reached
}
80104aea:	b8 00 00 00 00       	mov    $0x0,%eax
80104aef:	c9                   	leave  
80104af0:	c3                   	ret    

80104af1 <sys_wait>:

int
sys_wait(void)
{
80104af1:	55                   	push   %ebp
80104af2:	89 e5                	mov    %esp,%ebp
80104af4:	83 ec 08             	sub    $0x8,%esp
  return wait();
80104af7:	e8 ec eb ff ff       	call   801036e8 <wait>
}
80104afc:	c9                   	leave  
80104afd:	c3                   	ret    

80104afe <sys_kill>:

int
sys_kill(void)
{
80104afe:	55                   	push   %ebp
80104aff:	89 e5                	mov    %esp,%ebp
80104b01:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104b04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b07:	50                   	push   %eax
80104b08:	6a 00                	push   $0x0
80104b0a:	e8 3f f3 ff ff       	call   80103e4e <argint>
80104b0f:	83 c4 10             	add    $0x10,%esp
80104b12:	85 c0                	test   %eax,%eax
80104b14:	78 10                	js     80104b26 <sys_kill+0x28>
    return -1;
  return kill(pid);
80104b16:	83 ec 0c             	sub    $0xc,%esp
80104b19:	ff 75 f4             	push   -0xc(%ebp)
80104b1c:	e8 c4 ec ff ff       	call   801037e5 <kill>
80104b21:	83 c4 10             	add    $0x10,%esp
}
80104b24:	c9                   	leave  
80104b25:	c3                   	ret    
    return -1;
80104b26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b2b:	eb f7                	jmp    80104b24 <sys_kill+0x26>

80104b2d <sys_getpid>:

int
sys_getpid(void)
{
80104b2d:	55                   	push   %ebp
80104b2e:	89 e5                	mov    %esp,%ebp
80104b30:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104b33:	e8 7d e6 ff ff       	call   801031b5 <myproc>
80104b38:	8b 40 10             	mov    0x10(%eax),%eax
}
80104b3b:	c9                   	leave  
80104b3c:	c3                   	ret    

80104b3d <sys_sbrk>:

int
sys_sbrk(void)
{
80104b3d:	55                   	push   %ebp
80104b3e:	89 e5                	mov    %esp,%ebp
80104b40:	53                   	push   %ebx
80104b41:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104b44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b47:	50                   	push   %eax
80104b48:	6a 00                	push   $0x0
80104b4a:	e8 ff f2 ff ff       	call   80103e4e <argint>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	78 20                	js     80104b76 <sys_sbrk+0x39>
    return -1;
  addr = myproc()->sz;
80104b56:	e8 5a e6 ff ff       	call   801031b5 <myproc>
80104b5b:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104b5d:	83 ec 0c             	sub    $0xc,%esp
80104b60:	ff 75 f4             	push   -0xc(%ebp)
80104b63:	e8 58 e7 ff ff       	call   801032c0 <growproc>
80104b68:	83 c4 10             	add    $0x10,%esp
80104b6b:	85 c0                	test   %eax,%eax
80104b6d:	78 0e                	js     80104b7d <sys_sbrk+0x40>
    return -1;
  return addr;
}
80104b6f:	89 d8                	mov    %ebx,%eax
80104b71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b74:	c9                   	leave  
80104b75:	c3                   	ret    
    return -1;
80104b76:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104b7b:	eb f2                	jmp    80104b6f <sys_sbrk+0x32>
    return -1;
80104b7d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104b82:	eb eb                	jmp    80104b6f <sys_sbrk+0x32>

80104b84 <sys_sleep>:

int
sys_sleep(void)
{
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	53                   	push   %ebx
80104b88:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104b8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b8e:	50                   	push   %eax
80104b8f:	6a 00                	push   $0x0
80104b91:	e8 b8 f2 ff ff       	call   80103e4e <argint>
80104b96:	83 c4 10             	add    $0x10,%esp
80104b99:	85 c0                	test   %eax,%eax
80104b9b:	78 75                	js     80104c12 <sys_sleep+0x8e>
    return -1;
  acquire(&tickslock);
80104b9d:	83 ec 0c             	sub    $0xc,%esp
80104ba0:	68 80 3c 11 80       	push   $0x80113c80
80104ba5:	e8 a8 ef ff ff       	call   80103b52 <acquire>
  ticks0 = ticks;
80104baa:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
80104bb0:	83 c4 10             	add    $0x10,%esp
80104bb3:	a1 60 3c 11 80       	mov    0x80113c60,%eax
80104bb8:	29 d8                	sub    %ebx,%eax
80104bba:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80104bbd:	73 39                	jae    80104bf8 <sys_sleep+0x74>
    if(myproc()->killed){
80104bbf:	e8 f1 e5 ff ff       	call   801031b5 <myproc>
80104bc4:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104bc8:	75 17                	jne    80104be1 <sys_sleep+0x5d>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80104bca:	83 ec 08             	sub    $0x8,%esp
80104bcd:	68 80 3c 11 80       	push   $0x80113c80
80104bd2:	68 60 3c 11 80       	push   $0x80113c60
80104bd7:	e8 7b ea ff ff       	call   80103657 <sleep>
80104bdc:	83 c4 10             	add    $0x10,%esp
80104bdf:	eb d2                	jmp    80104bb3 <sys_sleep+0x2f>
      release(&tickslock);
80104be1:	83 ec 0c             	sub    $0xc,%esp
80104be4:	68 80 3c 11 80       	push   $0x80113c80
80104be9:	e8 c9 ef ff ff       	call   80103bb7 <release>
      return -1;
80104bee:	83 c4 10             	add    $0x10,%esp
80104bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bf6:	eb 15                	jmp    80104c0d <sys_sleep+0x89>
  }
  release(&tickslock);
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	68 80 3c 11 80       	push   $0x80113c80
80104c00:	e8 b2 ef ff ff       	call   80103bb7 <release>
  return 0;
80104c05:	83 c4 10             	add    $0x10,%esp
80104c08:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104c0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c10:	c9                   	leave  
80104c11:	c3                   	ret    
    return -1;
80104c12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c17:	eb f4                	jmp    80104c0d <sys_sleep+0x89>

80104c19 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80104c19:	55                   	push   %ebp
80104c1a:	89 e5                	mov    %esp,%ebp
80104c1c:	53                   	push   %ebx
80104c1d:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80104c20:	68 80 3c 11 80       	push   $0x80113c80
80104c25:	e8 28 ef ff ff       	call   80103b52 <acquire>
  xticks = ticks;
80104c2a:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
80104c30:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80104c37:	e8 7b ef ff ff       	call   80103bb7 <release>
  return xticks;
}
80104c3c:	89 d8                	mov    %ebx,%eax
80104c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c41:	c9                   	leave  
80104c42:	c3                   	ret    

80104c43 <sys_mencrypt>:


// int mencrypt(char *virtual_addr, int len)
int
sys_mencrypt(void)
{
80104c43:	55                   	push   %ebp
80104c44:	89 e5                	mov    %esp,%ebp
80104c46:	83 ec 20             	sub    $0x20,%esp
  char *virtual_addr;
  int len;

  if(argstr(0, &virtual_addr) < 0 || argint(1, &len) < 0)
80104c49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c4c:	50                   	push   %eax
80104c4d:	6a 00                	push   $0x0
80104c4f:	e8 8a f2 ff ff       	call   80103ede <argstr>
80104c54:	83 c4 10             	add    $0x10,%esp
80104c57:	85 c0                	test   %eax,%eax
80104c59:	78 28                	js     80104c83 <sys_mencrypt+0x40>
80104c5b:	83 ec 08             	sub    $0x8,%esp
80104c5e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c61:	50                   	push   %eax
80104c62:	6a 01                	push   $0x1
80104c64:	e8 e5 f1 ff ff       	call   80103e4e <argint>
80104c69:	83 c4 10             	add    $0x10,%esp
80104c6c:	85 c0                	test   %eax,%eax
80104c6e:	78 13                	js     80104c83 <sys_mencrypt+0x40>
    return -1;

  return mencrypt(virtual_addr, len);
80104c70:	83 ec 08             	sub    $0x8,%esp
80104c73:	ff 75 f0             	push   -0x10(%ebp)
80104c76:	ff 75 f4             	push   -0xc(%ebp)
80104c79:	e8 f5 19 00 00       	call   80106673 <mencrypt>
80104c7e:	83 c4 10             	add    $0x10,%esp
}
80104c81:	c9                   	leave  
80104c82:	c3                   	ret    
    return -1;
80104c83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c88:	eb f7                	jmp    80104c81 <sys_mencrypt+0x3e>

80104c8a <sys_getpgtable>:

// int getpgtable(struct pt_entry* entries, int num)
int
sys_getpgtable(void)
{
80104c8a:	55                   	push   %ebp
80104c8b:	89 e5                	mov    %esp,%ebp
80104c8d:	83 ec 20             	sub    $0x20,%esp
  struct pt_entry *entries;
  int num;

  if(argint(1, &num) < 0)
80104c90:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c93:	50                   	push   %eax
80104c94:	6a 01                	push   $0x1
80104c96:	e8 b3 f1 ff ff       	call   80103e4e <argint>
80104c9b:	83 c4 10             	add    $0x10,%esp
80104c9e:	85 c0                	test   %eax,%eax
80104ca0:	78 39                	js     80104cdb <sys_getpgtable+0x51>
    return -1;

  if(argptr(0, (void*)&entries, num*sizeof(struct pt_entry)) < 0)
80104ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ca5:	c1 e0 03             	shl    $0x3,%eax
80104ca8:	83 ec 04             	sub    $0x4,%esp
80104cab:	50                   	push   %eax
80104cac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104caf:	50                   	push   %eax
80104cb0:	6a 00                	push   $0x0
80104cb2:	e8 bf f1 ff ff       	call   80103e76 <argptr>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	78 24                	js     80104ce2 <sys_getpgtable+0x58>
    return -1;
  
  if(num > 0 || !entries || entries == 0)
80104cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cc1:	85 c0                	test   %eax,%eax
80104cc3:	7f 24                	jg     80104ce9 <sys_getpgtable+0x5f>
80104cc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cc8:	85 d2                	test   %edx,%edx
80104cca:	74 24                	je     80104cf0 <sys_getpgtable+0x66>
    return -1;

  return getpgtable(entries, num);
80104ccc:	83 ec 08             	sub    $0x8,%esp
80104ccf:	50                   	push   %eax
80104cd0:	52                   	push   %edx
80104cd1:	e8 10 1b 00 00       	call   801067e6 <getpgtable>
80104cd6:	83 c4 10             	add    $0x10,%esp
}
80104cd9:	c9                   	leave  
80104cda:	c3                   	ret    
    return -1;
80104cdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ce0:	eb f7                	jmp    80104cd9 <sys_getpgtable+0x4f>
    return -1;
80104ce2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ce7:	eb f0                	jmp    80104cd9 <sys_getpgtable+0x4f>
    return -1;
80104ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cee:	eb e9                	jmp    80104cd9 <sys_getpgtable+0x4f>
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cf5:	eb e2                	jmp    80104cd9 <sys_getpgtable+0x4f>

80104cf7 <sys_dump_rawphymem>:

// int dump_rawphymem(uint physical_addr, char * buffer)
int
sys_dump_rawphymem(void)
{
80104cf7:	55                   	push   %ebp
80104cf8:	89 e5                	mov    %esp,%ebp
80104cfa:	83 ec 20             	sub    $0x20,%esp
  uint physical_addr;
  char *buffer;

  if(argint(0, (int *)&physical_addr) < 0 || argptr(1, (void*)&buffer, PGSIZE) < 0)
80104cfd:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d00:	50                   	push   %eax
80104d01:	6a 00                	push   $0x0
80104d03:	e8 46 f1 ff ff       	call   80103e4e <argint>
80104d08:	83 c4 10             	add    $0x10,%esp
80104d0b:	85 c0                	test   %eax,%eax
80104d0d:	78 2d                	js     80104d3c <sys_dump_rawphymem+0x45>
80104d0f:	83 ec 04             	sub    $0x4,%esp
80104d12:	68 00 10 00 00       	push   $0x1000
80104d17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d1a:	50                   	push   %eax
80104d1b:	6a 01                	push   $0x1
80104d1d:	e8 54 f1 ff ff       	call   80103e76 <argptr>
80104d22:	83 c4 10             	add    $0x10,%esp
80104d25:	85 c0                	test   %eax,%eax
80104d27:	78 13                	js     80104d3c <sys_dump_rawphymem+0x45>
    return -1;
  
  return dump_rawphymem(physical_addr, buffer);
80104d29:	83 ec 08             	sub    $0x8,%esp
80104d2c:	ff 75 f0             	push   -0x10(%ebp)
80104d2f:	ff 75 f4             	push   -0xc(%ebp)
80104d32:	e8 ab 1b 00 00       	call   801068e2 <dump_rawphymem>
80104d37:	83 c4 10             	add    $0x10,%esp
}
80104d3a:	c9                   	leave  
80104d3b:	c3                   	ret    
    return -1;
80104d3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d41:	eb f7                	jmp    80104d3a <sys_dump_rawphymem+0x43>

80104d43 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80104d43:	1e                   	push   %ds
  pushl %es
80104d44:	06                   	push   %es
  pushl %fs
80104d45:	0f a0                	push   %fs
  pushl %gs
80104d47:	0f a8                	push   %gs
  pushal
80104d49:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80104d4a:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80104d4e:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80104d50:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80104d52:	54                   	push   %esp
  call trap
80104d53:	e8 37 01 00 00       	call   80104e8f <trap>
  addl $4, %esp
80104d58:	83 c4 04             	add    $0x4,%esp

80104d5b <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80104d5b:	61                   	popa   
  popl %gs
80104d5c:	0f a9                	pop    %gs
  popl %fs
80104d5e:	0f a1                	pop    %fs
  popl %es
80104d60:	07                   	pop    %es
  popl %ds
80104d61:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80104d62:	83 c4 08             	add    $0x8,%esp
  iret
80104d65:	cf                   	iret   

80104d66 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80104d66:	55                   	push   %ebp
80104d67:	89 e5                	mov    %esp,%ebp
80104d69:	53                   	push   %ebx
80104d6a:	83 ec 04             	sub    $0x4,%esp
  int i;

  for(i = 0; i < 256; i++)
80104d6d:	b8 00 00 00 00       	mov    $0x0,%eax
80104d72:	eb 76                	jmp    80104dea <tvinit+0x84>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80104d74:	8b 0c 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%ecx
80104d7b:	66 89 0c c5 c0 3c 11 	mov    %cx,-0x7feec340(,%eax,8)
80104d82:	80 
80104d83:	66 c7 04 c5 c2 3c 11 	movw   $0x8,-0x7feec33e(,%eax,8)
80104d8a:	80 08 00 
80104d8d:	0f b6 14 c5 c4 3c 11 	movzbl -0x7feec33c(,%eax,8),%edx
80104d94:	80 
80104d95:	83 e2 e0             	and    $0xffffffe0,%edx
80104d98:	88 14 c5 c4 3c 11 80 	mov    %dl,-0x7feec33c(,%eax,8)
80104d9f:	c6 04 c5 c4 3c 11 80 	movb   $0x0,-0x7feec33c(,%eax,8)
80104da6:	00 
80104da7:	0f b6 14 c5 c5 3c 11 	movzbl -0x7feec33b(,%eax,8),%edx
80104dae:	80 
80104daf:	83 e2 f0             	and    $0xfffffff0,%edx
80104db2:	83 ca 0e             	or     $0xe,%edx
80104db5:	88 14 c5 c5 3c 11 80 	mov    %dl,-0x7feec33b(,%eax,8)
80104dbc:	89 d3                	mov    %edx,%ebx
80104dbe:	83 e3 ef             	and    $0xffffffef,%ebx
80104dc1:	88 1c c5 c5 3c 11 80 	mov    %bl,-0x7feec33b(,%eax,8)
80104dc8:	83 e2 8f             	and    $0xffffff8f,%edx
80104dcb:	88 14 c5 c5 3c 11 80 	mov    %dl,-0x7feec33b(,%eax,8)
80104dd2:	83 ca 80             	or     $0xffffff80,%edx
80104dd5:	88 14 c5 c5 3c 11 80 	mov    %dl,-0x7feec33b(,%eax,8)
80104ddc:	c1 e9 10             	shr    $0x10,%ecx
80104ddf:	66 89 0c c5 c6 3c 11 	mov    %cx,-0x7feec33a(,%eax,8)
80104de6:	80 
  for(i = 0; i < 256; i++)
80104de7:	83 c0 01             	add    $0x1,%eax
80104dea:	3d ff 00 00 00       	cmp    $0xff,%eax
80104def:	7e 83                	jle    80104d74 <tvinit+0xe>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80104df1:	8b 15 08 a1 10 80    	mov    0x8010a108,%edx
80104df7:	66 89 15 c0 3e 11 80 	mov    %dx,0x80113ec0
80104dfe:	66 c7 05 c2 3e 11 80 	movw   $0x8,0x80113ec2
80104e05:	08 00 
80104e07:	0f b6 05 c4 3e 11 80 	movzbl 0x80113ec4,%eax
80104e0e:	83 e0 e0             	and    $0xffffffe0,%eax
80104e11:	a2 c4 3e 11 80       	mov    %al,0x80113ec4
80104e16:	c6 05 c4 3e 11 80 00 	movb   $0x0,0x80113ec4
80104e1d:	0f b6 05 c5 3e 11 80 	movzbl 0x80113ec5,%eax
80104e24:	83 c8 0f             	or     $0xf,%eax
80104e27:	a2 c5 3e 11 80       	mov    %al,0x80113ec5
80104e2c:	83 e0 ef             	and    $0xffffffef,%eax
80104e2f:	a2 c5 3e 11 80       	mov    %al,0x80113ec5
80104e34:	89 c1                	mov    %eax,%ecx
80104e36:	83 c9 60             	or     $0x60,%ecx
80104e39:	88 0d c5 3e 11 80    	mov    %cl,0x80113ec5
80104e3f:	83 c8 e0             	or     $0xffffffe0,%eax
80104e42:	a2 c5 3e 11 80       	mov    %al,0x80113ec5
80104e47:	c1 ea 10             	shr    $0x10,%edx
80104e4a:	66 89 15 c6 3e 11 80 	mov    %dx,0x80113ec6

  initlock(&tickslock, "time");
80104e51:	83 ec 08             	sub    $0x8,%esp
80104e54:	68 c5 70 10 80       	push   $0x801070c5
80104e59:	68 80 3c 11 80       	push   $0x80113c80
80104e5e:	e8 b3 eb ff ff       	call   80103a16 <initlock>
}
80104e63:	83 c4 10             	add    $0x10,%esp
80104e66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e69:	c9                   	leave  
80104e6a:	c3                   	ret    

80104e6b <idtinit>:

void
idtinit(void)
{
80104e6b:	55                   	push   %ebp
80104e6c:	89 e5                	mov    %esp,%ebp
80104e6e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80104e71:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80104e77:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80104e7c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80104e80:	c1 e8 10             	shr    $0x10,%eax
80104e83:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80104e87:	8d 45 fa             	lea    -0x6(%ebp),%eax
80104e8a:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80104e8d:	c9                   	leave  
80104e8e:	c3                   	ret    

80104e8f <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80104e8f:	55                   	push   %ebp
80104e90:	89 e5                	mov    %esp,%ebp
80104e92:	57                   	push   %edi
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	83 ec 1c             	sub    $0x1c,%esp
80104e98:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80104e9b:	8b 43 30             	mov    0x30(%ebx),%eax
80104e9e:	83 f8 40             	cmp    $0x40,%eax
80104ea1:	74 13                	je     80104eb6 <trap+0x27>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80104ea3:	83 e8 0e             	sub    $0xe,%eax
80104ea6:	83 f8 31             	cmp    $0x31,%eax
80104ea9:	0f 87 5c 01 00 00    	ja     8010500b <trap+0x17c>
80104eaf:	ff 24 85 6c 71 10 80 	jmp    *-0x7fef8e94(,%eax,4)
    if(myproc()->killed)
80104eb6:	e8 fa e2 ff ff       	call   801031b5 <myproc>
80104ebb:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104ebf:	75 1f                	jne    80104ee0 <trap+0x51>
    myproc()->tf = tf;
80104ec1:	e8 ef e2 ff ff       	call   801031b5 <myproc>
80104ec6:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80104ec9:	e8 43 f0 ff ff       	call   80103f11 <syscall>
    if(myproc()->killed)
80104ece:	e8 e2 e2 ff ff       	call   801031b5 <myproc>
80104ed3:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104ed7:	74 7e                	je     80104f57 <trap+0xc8>
      exit();
80104ed9:	e8 81 e6 ff ff       	call   8010355f <exit>
    return;
80104ede:	eb 77                	jmp    80104f57 <trap+0xc8>
      exit();
80104ee0:	e8 7a e6 ff ff       	call   8010355f <exit>
80104ee5:	eb da                	jmp    80104ec1 <trap+0x32>
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80104ee7:	e8 ae e2 ff ff       	call   8010319a <cpuid>
80104eec:	85 c0                	test   %eax,%eax
80104eee:	74 6f                	je     80104f5f <trap+0xd0>
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
80104ef0:	e8 81 d4 ff ff       	call   80102376 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104ef5:	e8 bb e2 ff ff       	call   801031b5 <myproc>
80104efa:	85 c0                	test   %eax,%eax
80104efc:	74 1c                	je     80104f1a <trap+0x8b>
80104efe:	e8 b2 e2 ff ff       	call   801031b5 <myproc>
80104f03:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104f07:	74 11                	je     80104f1a <trap+0x8b>
80104f09:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80104f0d:	83 e0 03             	and    $0x3,%eax
80104f10:	66 83 f8 03          	cmp    $0x3,%ax
80104f14:	0f 84 84 01 00 00    	je     8010509e <trap+0x20f>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80104f1a:	e8 96 e2 ff ff       	call   801031b5 <myproc>
80104f1f:	85 c0                	test   %eax,%eax
80104f21:	74 0f                	je     80104f32 <trap+0xa3>
80104f23:	e8 8d e2 ff ff       	call   801031b5 <myproc>
80104f28:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80104f2c:	0f 84 76 01 00 00    	je     801050a8 <trap+0x219>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104f32:	e8 7e e2 ff ff       	call   801031b5 <myproc>
80104f37:	85 c0                	test   %eax,%eax
80104f39:	74 1c                	je     80104f57 <trap+0xc8>
80104f3b:	e8 75 e2 ff ff       	call   801031b5 <myproc>
80104f40:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104f44:	74 11                	je     80104f57 <trap+0xc8>
80104f46:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80104f4a:	83 e0 03             	and    $0x3,%eax
80104f4d:	66 83 f8 03          	cmp    $0x3,%ax
80104f51:	0f 84 65 01 00 00    	je     801050bc <trap+0x22d>
    exit();
}
80104f57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f5a:	5b                   	pop    %ebx
80104f5b:	5e                   	pop    %esi
80104f5c:	5f                   	pop    %edi
80104f5d:	5d                   	pop    %ebp
80104f5e:	c3                   	ret    
      acquire(&tickslock);
80104f5f:	83 ec 0c             	sub    $0xc,%esp
80104f62:	68 80 3c 11 80       	push   $0x80113c80
80104f67:	e8 e6 eb ff ff       	call   80103b52 <acquire>
      ticks++;
80104f6c:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
      wakeup(&ticks);
80104f73:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80104f7a:	e8 3d e8 ff ff       	call   801037bc <wakeup>
      release(&tickslock);
80104f7f:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80104f86:	e8 2c ec ff ff       	call   80103bb7 <release>
80104f8b:	83 c4 10             	add    $0x10,%esp
80104f8e:	e9 5d ff ff ff       	jmp    80104ef0 <trap+0x61>
    ideintr();
80104f93:	e8 c4 cd ff ff       	call   80101d5c <ideintr>
    lapiceoi();
80104f98:	e8 d9 d3 ff ff       	call   80102376 <lapiceoi>
    break;
80104f9d:	e9 53 ff ff ff       	jmp    80104ef5 <trap+0x66>
    kbdintr();
80104fa2:	e8 19 d2 ff ff       	call   801021c0 <kbdintr>
    lapiceoi();
80104fa7:	e8 ca d3 ff ff       	call   80102376 <lapiceoi>
    break;
80104fac:	e9 44 ff ff ff       	jmp    80104ef5 <trap+0x66>
    uartintr();
80104fb1:	e8 20 02 00 00       	call   801051d6 <uartintr>
    lapiceoi();
80104fb6:	e8 bb d3 ff ff       	call   80102376 <lapiceoi>
    break;
80104fbb:	e9 35 ff ff ff       	jmp    80104ef5 <trap+0x66>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80104fc0:	8b 7b 38             	mov    0x38(%ebx),%edi
            cpuid(), tf->cs, tf->eip);
80104fc3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80104fc7:	e8 ce e1 ff ff       	call   8010319a <cpuid>
80104fcc:	57                   	push   %edi
80104fcd:	0f b7 f6             	movzwl %si,%esi
80104fd0:	56                   	push   %esi
80104fd1:	50                   	push   %eax
80104fd2:	68 d0 70 10 80       	push   $0x801070d0
80104fd7:	e8 2b b6 ff ff       	call   80100607 <cprintf>
    lapiceoi();
80104fdc:	e8 95 d3 ff ff       	call   80102376 <lapiceoi>
    break;
80104fe1:	83 c4 10             	add    $0x10,%esp
80104fe4:	e9 0c ff ff ff       	jmp    80104ef5 <trap+0x66>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80104fe9:	0f 20 d0             	mov    %cr2,%eax
    if(mdecrypt((char *)rcr2()) == -1)
80104fec:	83 ec 0c             	sub    $0xc,%esp
80104fef:	50                   	push   %eax
80104ff0:	e8 6b 17 00 00       	call   80106760 <mdecrypt>
80104ff5:	83 c4 10             	add    $0x10,%esp
80104ff8:	83 f8 ff             	cmp    $0xffffffff,%eax
80104ffb:	0f 85 f4 fe ff ff    	jne    80104ef5 <trap+0x66>
      exit();
80105001:	e8 59 e5 ff ff       	call   8010355f <exit>
80105006:	e9 ea fe ff ff       	jmp    80104ef5 <trap+0x66>
    if(myproc() == 0 || (tf->cs&3) == 0){
8010500b:	e8 a5 e1 ff ff       	call   801031b5 <myproc>
80105010:	85 c0                	test   %eax,%eax
80105012:	74 5f                	je     80105073 <trap+0x1e4>
80105014:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105018:	74 59                	je     80105073 <trap+0x1e4>
8010501a:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010501d:	8b 43 38             	mov    0x38(%ebx),%eax
80105020:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105023:	e8 72 e1 ff ff       	call   8010319a <cpuid>
80105028:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010502b:	8b 53 34             	mov    0x34(%ebx),%edx
8010502e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105031:	8b 73 30             	mov    0x30(%ebx),%esi
            myproc()->pid, myproc()->name, tf->trapno,
80105034:	e8 7c e1 ff ff       	call   801031b5 <myproc>
80105039:	8d 48 6c             	lea    0x6c(%eax),%ecx
8010503c:	89 4d d8             	mov    %ecx,-0x28(%ebp)
8010503f:	e8 71 e1 ff ff       	call   801031b5 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105044:	57                   	push   %edi
80105045:	ff 75 e4             	push   -0x1c(%ebp)
80105048:	ff 75 e0             	push   -0x20(%ebp)
8010504b:	ff 75 dc             	push   -0x24(%ebp)
8010504e:	56                   	push   %esi
8010504f:	ff 75 d8             	push   -0x28(%ebp)
80105052:	ff 70 10             	push   0x10(%eax)
80105055:	68 28 71 10 80       	push   $0x80107128
8010505a:	e8 a8 b5 ff ff       	call   80100607 <cprintf>
    myproc()->killed = 1;
8010505f:	83 c4 20             	add    $0x20,%esp
80105062:	e8 4e e1 ff ff       	call   801031b5 <myproc>
80105067:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010506e:	e9 82 fe ff ff       	jmp    80104ef5 <trap+0x66>
80105073:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105076:	8b 73 38             	mov    0x38(%ebx),%esi
80105079:	e8 1c e1 ff ff       	call   8010319a <cpuid>
8010507e:	83 ec 0c             	sub    $0xc,%esp
80105081:	57                   	push   %edi
80105082:	56                   	push   %esi
80105083:	50                   	push   %eax
80105084:	ff 73 30             	push   0x30(%ebx)
80105087:	68 f4 70 10 80       	push   $0x801070f4
8010508c:	e8 76 b5 ff ff       	call   80100607 <cprintf>
      panic("trap");
80105091:	83 c4 14             	add    $0x14,%esp
80105094:	68 ca 70 10 80       	push   $0x801070ca
80105099:	e8 aa b2 ff ff       	call   80100348 <panic>
    exit();
8010509e:	e8 bc e4 ff ff       	call   8010355f <exit>
801050a3:	e9 72 fe ff ff       	jmp    80104f1a <trap+0x8b>
  if(myproc() && myproc()->state == RUNNING &&
801050a8:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801050ac:	0f 85 80 fe ff ff    	jne    80104f32 <trap+0xa3>
    yield();
801050b2:	e8 6e e5 ff ff       	call   80103625 <yield>
801050b7:	e9 76 fe ff ff       	jmp    80104f32 <trap+0xa3>
    exit();
801050bc:	e8 9e e4 ff ff       	call   8010355f <exit>
801050c1:	e9 91 fe ff ff       	jmp    80104f57 <trap+0xc8>

801050c6 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801050c6:	83 3d c0 44 11 80 00 	cmpl   $0x0,0x801144c0
801050cd:	74 14                	je     801050e3 <uartgetc+0x1d>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801050cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801050d4:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801050d5:	a8 01                	test   $0x1,%al
801050d7:	74 10                	je     801050e9 <uartgetc+0x23>
801050d9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801050de:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801050df:	0f b6 c0             	movzbl %al,%eax
801050e2:	c3                   	ret    
    return -1;
801050e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050e8:	c3                   	ret    
    return -1;
801050e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050ee:	c3                   	ret    

801050ef <uartputc>:
  if(!uart)
801050ef:	83 3d c0 44 11 80 00 	cmpl   $0x0,0x801144c0
801050f6:	74 3b                	je     80105133 <uartputc+0x44>
{
801050f8:	55                   	push   %ebp
801050f9:	89 e5                	mov    %esp,%ebp
801050fb:	53                   	push   %ebx
801050fc:	83 ec 04             	sub    $0x4,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801050ff:	bb 00 00 00 00       	mov    $0x0,%ebx
80105104:	eb 10                	jmp    80105116 <uartputc+0x27>
    microdelay(10);
80105106:	83 ec 0c             	sub    $0xc,%esp
80105109:	6a 0a                	push   $0xa
8010510b:	e8 87 d2 ff ff       	call   80102397 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105110:	83 c3 01             	add    $0x1,%ebx
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	83 fb 7f             	cmp    $0x7f,%ebx
80105119:	7f 0a                	jg     80105125 <uartputc+0x36>
8010511b:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105120:	ec                   	in     (%dx),%al
80105121:	a8 20                	test   $0x20,%al
80105123:	74 e1                	je     80105106 <uartputc+0x17>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105125:	8b 45 08             	mov    0x8(%ebp),%eax
80105128:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010512d:	ee                   	out    %al,(%dx)
}
8010512e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105131:	c9                   	leave  
80105132:	c3                   	ret    
80105133:	c3                   	ret    

80105134 <uartinit>:
{
80105134:	55                   	push   %ebp
80105135:	89 e5                	mov    %esp,%ebp
80105137:	56                   	push   %esi
80105138:	53                   	push   %ebx
80105139:	b9 00 00 00 00       	mov    $0x0,%ecx
8010513e:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105143:	89 c8                	mov    %ecx,%eax
80105145:	ee                   	out    %al,(%dx)
80105146:	be fb 03 00 00       	mov    $0x3fb,%esi
8010514b:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105150:	89 f2                	mov    %esi,%edx
80105152:	ee                   	out    %al,(%dx)
80105153:	b8 0c 00 00 00       	mov    $0xc,%eax
80105158:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010515d:	ee                   	out    %al,(%dx)
8010515e:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105163:	89 c8                	mov    %ecx,%eax
80105165:	89 da                	mov    %ebx,%edx
80105167:	ee                   	out    %al,(%dx)
80105168:	b8 03 00 00 00       	mov    $0x3,%eax
8010516d:	89 f2                	mov    %esi,%edx
8010516f:	ee                   	out    %al,(%dx)
80105170:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105175:	89 c8                	mov    %ecx,%eax
80105177:	ee                   	out    %al,(%dx)
80105178:	b8 01 00 00 00       	mov    $0x1,%eax
8010517d:	89 da                	mov    %ebx,%edx
8010517f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105180:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105185:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105186:	3c ff                	cmp    $0xff,%al
80105188:	74 45                	je     801051cf <uartinit+0x9b>
  uart = 1;
8010518a:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
80105191:	00 00 00 
80105194:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105199:	ec                   	in     (%dx),%al
8010519a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010519f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801051a0:	83 ec 08             	sub    $0x8,%esp
801051a3:	6a 00                	push   $0x0
801051a5:	6a 04                	push   $0x4
801051a7:	e8 b5 cd ff ff       	call   80101f61 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801051ac:	83 c4 10             	add    $0x10,%esp
801051af:	bb 34 72 10 80       	mov    $0x80107234,%ebx
801051b4:	eb 12                	jmp    801051c8 <uartinit+0x94>
    uartputc(*p);
801051b6:	83 ec 0c             	sub    $0xc,%esp
801051b9:	0f be c0             	movsbl %al,%eax
801051bc:	50                   	push   %eax
801051bd:	e8 2d ff ff ff       	call   801050ef <uartputc>
  for(p="xv6...\n"; *p; p++)
801051c2:	83 c3 01             	add    $0x1,%ebx
801051c5:	83 c4 10             	add    $0x10,%esp
801051c8:	0f b6 03             	movzbl (%ebx),%eax
801051cb:	84 c0                	test   %al,%al
801051cd:	75 e7                	jne    801051b6 <uartinit+0x82>
}
801051cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051d2:	5b                   	pop    %ebx
801051d3:	5e                   	pop    %esi
801051d4:	5d                   	pop    %ebp
801051d5:	c3                   	ret    

801051d6 <uartintr>:

void
uartintr(void)
{
801051d6:	55                   	push   %ebp
801051d7:	89 e5                	mov    %esp,%ebp
801051d9:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801051dc:	68 c6 50 10 80       	push   $0x801050c6
801051e1:	e8 4d b5 ff ff       	call   80100733 <consoleintr>
}
801051e6:	83 c4 10             	add    $0x10,%esp
801051e9:	c9                   	leave  
801051ea:	c3                   	ret    

801051eb <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801051eb:	6a 00                	push   $0x0
  pushl $0
801051ed:	6a 00                	push   $0x0
  jmp alltraps
801051ef:	e9 4f fb ff ff       	jmp    80104d43 <alltraps>

801051f4 <vector1>:
.globl vector1
vector1:
  pushl $0
801051f4:	6a 00                	push   $0x0
  pushl $1
801051f6:	6a 01                	push   $0x1
  jmp alltraps
801051f8:	e9 46 fb ff ff       	jmp    80104d43 <alltraps>

801051fd <vector2>:
.globl vector2
vector2:
  pushl $0
801051fd:	6a 00                	push   $0x0
  pushl $2
801051ff:	6a 02                	push   $0x2
  jmp alltraps
80105201:	e9 3d fb ff ff       	jmp    80104d43 <alltraps>

80105206 <vector3>:
.globl vector3
vector3:
  pushl $0
80105206:	6a 00                	push   $0x0
  pushl $3
80105208:	6a 03                	push   $0x3
  jmp alltraps
8010520a:	e9 34 fb ff ff       	jmp    80104d43 <alltraps>

8010520f <vector4>:
.globl vector4
vector4:
  pushl $0
8010520f:	6a 00                	push   $0x0
  pushl $4
80105211:	6a 04                	push   $0x4
  jmp alltraps
80105213:	e9 2b fb ff ff       	jmp    80104d43 <alltraps>

80105218 <vector5>:
.globl vector5
vector5:
  pushl $0
80105218:	6a 00                	push   $0x0
  pushl $5
8010521a:	6a 05                	push   $0x5
  jmp alltraps
8010521c:	e9 22 fb ff ff       	jmp    80104d43 <alltraps>

80105221 <vector6>:
.globl vector6
vector6:
  pushl $0
80105221:	6a 00                	push   $0x0
  pushl $6
80105223:	6a 06                	push   $0x6
  jmp alltraps
80105225:	e9 19 fb ff ff       	jmp    80104d43 <alltraps>

8010522a <vector7>:
.globl vector7
vector7:
  pushl $0
8010522a:	6a 00                	push   $0x0
  pushl $7
8010522c:	6a 07                	push   $0x7
  jmp alltraps
8010522e:	e9 10 fb ff ff       	jmp    80104d43 <alltraps>

80105233 <vector8>:
.globl vector8
vector8:
  pushl $8
80105233:	6a 08                	push   $0x8
  jmp alltraps
80105235:	e9 09 fb ff ff       	jmp    80104d43 <alltraps>

8010523a <vector9>:
.globl vector9
vector9:
  pushl $0
8010523a:	6a 00                	push   $0x0
  pushl $9
8010523c:	6a 09                	push   $0x9
  jmp alltraps
8010523e:	e9 00 fb ff ff       	jmp    80104d43 <alltraps>

80105243 <vector10>:
.globl vector10
vector10:
  pushl $10
80105243:	6a 0a                	push   $0xa
  jmp alltraps
80105245:	e9 f9 fa ff ff       	jmp    80104d43 <alltraps>

8010524a <vector11>:
.globl vector11
vector11:
  pushl $11
8010524a:	6a 0b                	push   $0xb
  jmp alltraps
8010524c:	e9 f2 fa ff ff       	jmp    80104d43 <alltraps>

80105251 <vector12>:
.globl vector12
vector12:
  pushl $12
80105251:	6a 0c                	push   $0xc
  jmp alltraps
80105253:	e9 eb fa ff ff       	jmp    80104d43 <alltraps>

80105258 <vector13>:
.globl vector13
vector13:
  pushl $13
80105258:	6a 0d                	push   $0xd
  jmp alltraps
8010525a:	e9 e4 fa ff ff       	jmp    80104d43 <alltraps>

8010525f <vector14>:
.globl vector14
vector14:
  pushl $14
8010525f:	6a 0e                	push   $0xe
  jmp alltraps
80105261:	e9 dd fa ff ff       	jmp    80104d43 <alltraps>

80105266 <vector15>:
.globl vector15
vector15:
  pushl $0
80105266:	6a 00                	push   $0x0
  pushl $15
80105268:	6a 0f                	push   $0xf
  jmp alltraps
8010526a:	e9 d4 fa ff ff       	jmp    80104d43 <alltraps>

8010526f <vector16>:
.globl vector16
vector16:
  pushl $0
8010526f:	6a 00                	push   $0x0
  pushl $16
80105271:	6a 10                	push   $0x10
  jmp alltraps
80105273:	e9 cb fa ff ff       	jmp    80104d43 <alltraps>

80105278 <vector17>:
.globl vector17
vector17:
  pushl $17
80105278:	6a 11                	push   $0x11
  jmp alltraps
8010527a:	e9 c4 fa ff ff       	jmp    80104d43 <alltraps>

8010527f <vector18>:
.globl vector18
vector18:
  pushl $0
8010527f:	6a 00                	push   $0x0
  pushl $18
80105281:	6a 12                	push   $0x12
  jmp alltraps
80105283:	e9 bb fa ff ff       	jmp    80104d43 <alltraps>

80105288 <vector19>:
.globl vector19
vector19:
  pushl $0
80105288:	6a 00                	push   $0x0
  pushl $19
8010528a:	6a 13                	push   $0x13
  jmp alltraps
8010528c:	e9 b2 fa ff ff       	jmp    80104d43 <alltraps>

80105291 <vector20>:
.globl vector20
vector20:
  pushl $0
80105291:	6a 00                	push   $0x0
  pushl $20
80105293:	6a 14                	push   $0x14
  jmp alltraps
80105295:	e9 a9 fa ff ff       	jmp    80104d43 <alltraps>

8010529a <vector21>:
.globl vector21
vector21:
  pushl $0
8010529a:	6a 00                	push   $0x0
  pushl $21
8010529c:	6a 15                	push   $0x15
  jmp alltraps
8010529e:	e9 a0 fa ff ff       	jmp    80104d43 <alltraps>

801052a3 <vector22>:
.globl vector22
vector22:
  pushl $0
801052a3:	6a 00                	push   $0x0
  pushl $22
801052a5:	6a 16                	push   $0x16
  jmp alltraps
801052a7:	e9 97 fa ff ff       	jmp    80104d43 <alltraps>

801052ac <vector23>:
.globl vector23
vector23:
  pushl $0
801052ac:	6a 00                	push   $0x0
  pushl $23
801052ae:	6a 17                	push   $0x17
  jmp alltraps
801052b0:	e9 8e fa ff ff       	jmp    80104d43 <alltraps>

801052b5 <vector24>:
.globl vector24
vector24:
  pushl $0
801052b5:	6a 00                	push   $0x0
  pushl $24
801052b7:	6a 18                	push   $0x18
  jmp alltraps
801052b9:	e9 85 fa ff ff       	jmp    80104d43 <alltraps>

801052be <vector25>:
.globl vector25
vector25:
  pushl $0
801052be:	6a 00                	push   $0x0
  pushl $25
801052c0:	6a 19                	push   $0x19
  jmp alltraps
801052c2:	e9 7c fa ff ff       	jmp    80104d43 <alltraps>

801052c7 <vector26>:
.globl vector26
vector26:
  pushl $0
801052c7:	6a 00                	push   $0x0
  pushl $26
801052c9:	6a 1a                	push   $0x1a
  jmp alltraps
801052cb:	e9 73 fa ff ff       	jmp    80104d43 <alltraps>

801052d0 <vector27>:
.globl vector27
vector27:
  pushl $0
801052d0:	6a 00                	push   $0x0
  pushl $27
801052d2:	6a 1b                	push   $0x1b
  jmp alltraps
801052d4:	e9 6a fa ff ff       	jmp    80104d43 <alltraps>

801052d9 <vector28>:
.globl vector28
vector28:
  pushl $0
801052d9:	6a 00                	push   $0x0
  pushl $28
801052db:	6a 1c                	push   $0x1c
  jmp alltraps
801052dd:	e9 61 fa ff ff       	jmp    80104d43 <alltraps>

801052e2 <vector29>:
.globl vector29
vector29:
  pushl $0
801052e2:	6a 00                	push   $0x0
  pushl $29
801052e4:	6a 1d                	push   $0x1d
  jmp alltraps
801052e6:	e9 58 fa ff ff       	jmp    80104d43 <alltraps>

801052eb <vector30>:
.globl vector30
vector30:
  pushl $0
801052eb:	6a 00                	push   $0x0
  pushl $30
801052ed:	6a 1e                	push   $0x1e
  jmp alltraps
801052ef:	e9 4f fa ff ff       	jmp    80104d43 <alltraps>

801052f4 <vector31>:
.globl vector31
vector31:
  pushl $0
801052f4:	6a 00                	push   $0x0
  pushl $31
801052f6:	6a 1f                	push   $0x1f
  jmp alltraps
801052f8:	e9 46 fa ff ff       	jmp    80104d43 <alltraps>

801052fd <vector32>:
.globl vector32
vector32:
  pushl $0
801052fd:	6a 00                	push   $0x0
  pushl $32
801052ff:	6a 20                	push   $0x20
  jmp alltraps
80105301:	e9 3d fa ff ff       	jmp    80104d43 <alltraps>

80105306 <vector33>:
.globl vector33
vector33:
  pushl $0
80105306:	6a 00                	push   $0x0
  pushl $33
80105308:	6a 21                	push   $0x21
  jmp alltraps
8010530a:	e9 34 fa ff ff       	jmp    80104d43 <alltraps>

8010530f <vector34>:
.globl vector34
vector34:
  pushl $0
8010530f:	6a 00                	push   $0x0
  pushl $34
80105311:	6a 22                	push   $0x22
  jmp alltraps
80105313:	e9 2b fa ff ff       	jmp    80104d43 <alltraps>

80105318 <vector35>:
.globl vector35
vector35:
  pushl $0
80105318:	6a 00                	push   $0x0
  pushl $35
8010531a:	6a 23                	push   $0x23
  jmp alltraps
8010531c:	e9 22 fa ff ff       	jmp    80104d43 <alltraps>

80105321 <vector36>:
.globl vector36
vector36:
  pushl $0
80105321:	6a 00                	push   $0x0
  pushl $36
80105323:	6a 24                	push   $0x24
  jmp alltraps
80105325:	e9 19 fa ff ff       	jmp    80104d43 <alltraps>

8010532a <vector37>:
.globl vector37
vector37:
  pushl $0
8010532a:	6a 00                	push   $0x0
  pushl $37
8010532c:	6a 25                	push   $0x25
  jmp alltraps
8010532e:	e9 10 fa ff ff       	jmp    80104d43 <alltraps>

80105333 <vector38>:
.globl vector38
vector38:
  pushl $0
80105333:	6a 00                	push   $0x0
  pushl $38
80105335:	6a 26                	push   $0x26
  jmp alltraps
80105337:	e9 07 fa ff ff       	jmp    80104d43 <alltraps>

8010533c <vector39>:
.globl vector39
vector39:
  pushl $0
8010533c:	6a 00                	push   $0x0
  pushl $39
8010533e:	6a 27                	push   $0x27
  jmp alltraps
80105340:	e9 fe f9 ff ff       	jmp    80104d43 <alltraps>

80105345 <vector40>:
.globl vector40
vector40:
  pushl $0
80105345:	6a 00                	push   $0x0
  pushl $40
80105347:	6a 28                	push   $0x28
  jmp alltraps
80105349:	e9 f5 f9 ff ff       	jmp    80104d43 <alltraps>

8010534e <vector41>:
.globl vector41
vector41:
  pushl $0
8010534e:	6a 00                	push   $0x0
  pushl $41
80105350:	6a 29                	push   $0x29
  jmp alltraps
80105352:	e9 ec f9 ff ff       	jmp    80104d43 <alltraps>

80105357 <vector42>:
.globl vector42
vector42:
  pushl $0
80105357:	6a 00                	push   $0x0
  pushl $42
80105359:	6a 2a                	push   $0x2a
  jmp alltraps
8010535b:	e9 e3 f9 ff ff       	jmp    80104d43 <alltraps>

80105360 <vector43>:
.globl vector43
vector43:
  pushl $0
80105360:	6a 00                	push   $0x0
  pushl $43
80105362:	6a 2b                	push   $0x2b
  jmp alltraps
80105364:	e9 da f9 ff ff       	jmp    80104d43 <alltraps>

80105369 <vector44>:
.globl vector44
vector44:
  pushl $0
80105369:	6a 00                	push   $0x0
  pushl $44
8010536b:	6a 2c                	push   $0x2c
  jmp alltraps
8010536d:	e9 d1 f9 ff ff       	jmp    80104d43 <alltraps>

80105372 <vector45>:
.globl vector45
vector45:
  pushl $0
80105372:	6a 00                	push   $0x0
  pushl $45
80105374:	6a 2d                	push   $0x2d
  jmp alltraps
80105376:	e9 c8 f9 ff ff       	jmp    80104d43 <alltraps>

8010537b <vector46>:
.globl vector46
vector46:
  pushl $0
8010537b:	6a 00                	push   $0x0
  pushl $46
8010537d:	6a 2e                	push   $0x2e
  jmp alltraps
8010537f:	e9 bf f9 ff ff       	jmp    80104d43 <alltraps>

80105384 <vector47>:
.globl vector47
vector47:
  pushl $0
80105384:	6a 00                	push   $0x0
  pushl $47
80105386:	6a 2f                	push   $0x2f
  jmp alltraps
80105388:	e9 b6 f9 ff ff       	jmp    80104d43 <alltraps>

8010538d <vector48>:
.globl vector48
vector48:
  pushl $0
8010538d:	6a 00                	push   $0x0
  pushl $48
8010538f:	6a 30                	push   $0x30
  jmp alltraps
80105391:	e9 ad f9 ff ff       	jmp    80104d43 <alltraps>

80105396 <vector49>:
.globl vector49
vector49:
  pushl $0
80105396:	6a 00                	push   $0x0
  pushl $49
80105398:	6a 31                	push   $0x31
  jmp alltraps
8010539a:	e9 a4 f9 ff ff       	jmp    80104d43 <alltraps>

8010539f <vector50>:
.globl vector50
vector50:
  pushl $0
8010539f:	6a 00                	push   $0x0
  pushl $50
801053a1:	6a 32                	push   $0x32
  jmp alltraps
801053a3:	e9 9b f9 ff ff       	jmp    80104d43 <alltraps>

801053a8 <vector51>:
.globl vector51
vector51:
  pushl $0
801053a8:	6a 00                	push   $0x0
  pushl $51
801053aa:	6a 33                	push   $0x33
  jmp alltraps
801053ac:	e9 92 f9 ff ff       	jmp    80104d43 <alltraps>

801053b1 <vector52>:
.globl vector52
vector52:
  pushl $0
801053b1:	6a 00                	push   $0x0
  pushl $52
801053b3:	6a 34                	push   $0x34
  jmp alltraps
801053b5:	e9 89 f9 ff ff       	jmp    80104d43 <alltraps>

801053ba <vector53>:
.globl vector53
vector53:
  pushl $0
801053ba:	6a 00                	push   $0x0
  pushl $53
801053bc:	6a 35                	push   $0x35
  jmp alltraps
801053be:	e9 80 f9 ff ff       	jmp    80104d43 <alltraps>

801053c3 <vector54>:
.globl vector54
vector54:
  pushl $0
801053c3:	6a 00                	push   $0x0
  pushl $54
801053c5:	6a 36                	push   $0x36
  jmp alltraps
801053c7:	e9 77 f9 ff ff       	jmp    80104d43 <alltraps>

801053cc <vector55>:
.globl vector55
vector55:
  pushl $0
801053cc:	6a 00                	push   $0x0
  pushl $55
801053ce:	6a 37                	push   $0x37
  jmp alltraps
801053d0:	e9 6e f9 ff ff       	jmp    80104d43 <alltraps>

801053d5 <vector56>:
.globl vector56
vector56:
  pushl $0
801053d5:	6a 00                	push   $0x0
  pushl $56
801053d7:	6a 38                	push   $0x38
  jmp alltraps
801053d9:	e9 65 f9 ff ff       	jmp    80104d43 <alltraps>

801053de <vector57>:
.globl vector57
vector57:
  pushl $0
801053de:	6a 00                	push   $0x0
  pushl $57
801053e0:	6a 39                	push   $0x39
  jmp alltraps
801053e2:	e9 5c f9 ff ff       	jmp    80104d43 <alltraps>

801053e7 <vector58>:
.globl vector58
vector58:
  pushl $0
801053e7:	6a 00                	push   $0x0
  pushl $58
801053e9:	6a 3a                	push   $0x3a
  jmp alltraps
801053eb:	e9 53 f9 ff ff       	jmp    80104d43 <alltraps>

801053f0 <vector59>:
.globl vector59
vector59:
  pushl $0
801053f0:	6a 00                	push   $0x0
  pushl $59
801053f2:	6a 3b                	push   $0x3b
  jmp alltraps
801053f4:	e9 4a f9 ff ff       	jmp    80104d43 <alltraps>

801053f9 <vector60>:
.globl vector60
vector60:
  pushl $0
801053f9:	6a 00                	push   $0x0
  pushl $60
801053fb:	6a 3c                	push   $0x3c
  jmp alltraps
801053fd:	e9 41 f9 ff ff       	jmp    80104d43 <alltraps>

80105402 <vector61>:
.globl vector61
vector61:
  pushl $0
80105402:	6a 00                	push   $0x0
  pushl $61
80105404:	6a 3d                	push   $0x3d
  jmp alltraps
80105406:	e9 38 f9 ff ff       	jmp    80104d43 <alltraps>

8010540b <vector62>:
.globl vector62
vector62:
  pushl $0
8010540b:	6a 00                	push   $0x0
  pushl $62
8010540d:	6a 3e                	push   $0x3e
  jmp alltraps
8010540f:	e9 2f f9 ff ff       	jmp    80104d43 <alltraps>

80105414 <vector63>:
.globl vector63
vector63:
  pushl $0
80105414:	6a 00                	push   $0x0
  pushl $63
80105416:	6a 3f                	push   $0x3f
  jmp alltraps
80105418:	e9 26 f9 ff ff       	jmp    80104d43 <alltraps>

8010541d <vector64>:
.globl vector64
vector64:
  pushl $0
8010541d:	6a 00                	push   $0x0
  pushl $64
8010541f:	6a 40                	push   $0x40
  jmp alltraps
80105421:	e9 1d f9 ff ff       	jmp    80104d43 <alltraps>

80105426 <vector65>:
.globl vector65
vector65:
  pushl $0
80105426:	6a 00                	push   $0x0
  pushl $65
80105428:	6a 41                	push   $0x41
  jmp alltraps
8010542a:	e9 14 f9 ff ff       	jmp    80104d43 <alltraps>

8010542f <vector66>:
.globl vector66
vector66:
  pushl $0
8010542f:	6a 00                	push   $0x0
  pushl $66
80105431:	6a 42                	push   $0x42
  jmp alltraps
80105433:	e9 0b f9 ff ff       	jmp    80104d43 <alltraps>

80105438 <vector67>:
.globl vector67
vector67:
  pushl $0
80105438:	6a 00                	push   $0x0
  pushl $67
8010543a:	6a 43                	push   $0x43
  jmp alltraps
8010543c:	e9 02 f9 ff ff       	jmp    80104d43 <alltraps>

80105441 <vector68>:
.globl vector68
vector68:
  pushl $0
80105441:	6a 00                	push   $0x0
  pushl $68
80105443:	6a 44                	push   $0x44
  jmp alltraps
80105445:	e9 f9 f8 ff ff       	jmp    80104d43 <alltraps>

8010544a <vector69>:
.globl vector69
vector69:
  pushl $0
8010544a:	6a 00                	push   $0x0
  pushl $69
8010544c:	6a 45                	push   $0x45
  jmp alltraps
8010544e:	e9 f0 f8 ff ff       	jmp    80104d43 <alltraps>

80105453 <vector70>:
.globl vector70
vector70:
  pushl $0
80105453:	6a 00                	push   $0x0
  pushl $70
80105455:	6a 46                	push   $0x46
  jmp alltraps
80105457:	e9 e7 f8 ff ff       	jmp    80104d43 <alltraps>

8010545c <vector71>:
.globl vector71
vector71:
  pushl $0
8010545c:	6a 00                	push   $0x0
  pushl $71
8010545e:	6a 47                	push   $0x47
  jmp alltraps
80105460:	e9 de f8 ff ff       	jmp    80104d43 <alltraps>

80105465 <vector72>:
.globl vector72
vector72:
  pushl $0
80105465:	6a 00                	push   $0x0
  pushl $72
80105467:	6a 48                	push   $0x48
  jmp alltraps
80105469:	e9 d5 f8 ff ff       	jmp    80104d43 <alltraps>

8010546e <vector73>:
.globl vector73
vector73:
  pushl $0
8010546e:	6a 00                	push   $0x0
  pushl $73
80105470:	6a 49                	push   $0x49
  jmp alltraps
80105472:	e9 cc f8 ff ff       	jmp    80104d43 <alltraps>

80105477 <vector74>:
.globl vector74
vector74:
  pushl $0
80105477:	6a 00                	push   $0x0
  pushl $74
80105479:	6a 4a                	push   $0x4a
  jmp alltraps
8010547b:	e9 c3 f8 ff ff       	jmp    80104d43 <alltraps>

80105480 <vector75>:
.globl vector75
vector75:
  pushl $0
80105480:	6a 00                	push   $0x0
  pushl $75
80105482:	6a 4b                	push   $0x4b
  jmp alltraps
80105484:	e9 ba f8 ff ff       	jmp    80104d43 <alltraps>

80105489 <vector76>:
.globl vector76
vector76:
  pushl $0
80105489:	6a 00                	push   $0x0
  pushl $76
8010548b:	6a 4c                	push   $0x4c
  jmp alltraps
8010548d:	e9 b1 f8 ff ff       	jmp    80104d43 <alltraps>

80105492 <vector77>:
.globl vector77
vector77:
  pushl $0
80105492:	6a 00                	push   $0x0
  pushl $77
80105494:	6a 4d                	push   $0x4d
  jmp alltraps
80105496:	e9 a8 f8 ff ff       	jmp    80104d43 <alltraps>

8010549b <vector78>:
.globl vector78
vector78:
  pushl $0
8010549b:	6a 00                	push   $0x0
  pushl $78
8010549d:	6a 4e                	push   $0x4e
  jmp alltraps
8010549f:	e9 9f f8 ff ff       	jmp    80104d43 <alltraps>

801054a4 <vector79>:
.globl vector79
vector79:
  pushl $0
801054a4:	6a 00                	push   $0x0
  pushl $79
801054a6:	6a 4f                	push   $0x4f
  jmp alltraps
801054a8:	e9 96 f8 ff ff       	jmp    80104d43 <alltraps>

801054ad <vector80>:
.globl vector80
vector80:
  pushl $0
801054ad:	6a 00                	push   $0x0
  pushl $80
801054af:	6a 50                	push   $0x50
  jmp alltraps
801054b1:	e9 8d f8 ff ff       	jmp    80104d43 <alltraps>

801054b6 <vector81>:
.globl vector81
vector81:
  pushl $0
801054b6:	6a 00                	push   $0x0
  pushl $81
801054b8:	6a 51                	push   $0x51
  jmp alltraps
801054ba:	e9 84 f8 ff ff       	jmp    80104d43 <alltraps>

801054bf <vector82>:
.globl vector82
vector82:
  pushl $0
801054bf:	6a 00                	push   $0x0
  pushl $82
801054c1:	6a 52                	push   $0x52
  jmp alltraps
801054c3:	e9 7b f8 ff ff       	jmp    80104d43 <alltraps>

801054c8 <vector83>:
.globl vector83
vector83:
  pushl $0
801054c8:	6a 00                	push   $0x0
  pushl $83
801054ca:	6a 53                	push   $0x53
  jmp alltraps
801054cc:	e9 72 f8 ff ff       	jmp    80104d43 <alltraps>

801054d1 <vector84>:
.globl vector84
vector84:
  pushl $0
801054d1:	6a 00                	push   $0x0
  pushl $84
801054d3:	6a 54                	push   $0x54
  jmp alltraps
801054d5:	e9 69 f8 ff ff       	jmp    80104d43 <alltraps>

801054da <vector85>:
.globl vector85
vector85:
  pushl $0
801054da:	6a 00                	push   $0x0
  pushl $85
801054dc:	6a 55                	push   $0x55
  jmp alltraps
801054de:	e9 60 f8 ff ff       	jmp    80104d43 <alltraps>

801054e3 <vector86>:
.globl vector86
vector86:
  pushl $0
801054e3:	6a 00                	push   $0x0
  pushl $86
801054e5:	6a 56                	push   $0x56
  jmp alltraps
801054e7:	e9 57 f8 ff ff       	jmp    80104d43 <alltraps>

801054ec <vector87>:
.globl vector87
vector87:
  pushl $0
801054ec:	6a 00                	push   $0x0
  pushl $87
801054ee:	6a 57                	push   $0x57
  jmp alltraps
801054f0:	e9 4e f8 ff ff       	jmp    80104d43 <alltraps>

801054f5 <vector88>:
.globl vector88
vector88:
  pushl $0
801054f5:	6a 00                	push   $0x0
  pushl $88
801054f7:	6a 58                	push   $0x58
  jmp alltraps
801054f9:	e9 45 f8 ff ff       	jmp    80104d43 <alltraps>

801054fe <vector89>:
.globl vector89
vector89:
  pushl $0
801054fe:	6a 00                	push   $0x0
  pushl $89
80105500:	6a 59                	push   $0x59
  jmp alltraps
80105502:	e9 3c f8 ff ff       	jmp    80104d43 <alltraps>

80105507 <vector90>:
.globl vector90
vector90:
  pushl $0
80105507:	6a 00                	push   $0x0
  pushl $90
80105509:	6a 5a                	push   $0x5a
  jmp alltraps
8010550b:	e9 33 f8 ff ff       	jmp    80104d43 <alltraps>

80105510 <vector91>:
.globl vector91
vector91:
  pushl $0
80105510:	6a 00                	push   $0x0
  pushl $91
80105512:	6a 5b                	push   $0x5b
  jmp alltraps
80105514:	e9 2a f8 ff ff       	jmp    80104d43 <alltraps>

80105519 <vector92>:
.globl vector92
vector92:
  pushl $0
80105519:	6a 00                	push   $0x0
  pushl $92
8010551b:	6a 5c                	push   $0x5c
  jmp alltraps
8010551d:	e9 21 f8 ff ff       	jmp    80104d43 <alltraps>

80105522 <vector93>:
.globl vector93
vector93:
  pushl $0
80105522:	6a 00                	push   $0x0
  pushl $93
80105524:	6a 5d                	push   $0x5d
  jmp alltraps
80105526:	e9 18 f8 ff ff       	jmp    80104d43 <alltraps>

8010552b <vector94>:
.globl vector94
vector94:
  pushl $0
8010552b:	6a 00                	push   $0x0
  pushl $94
8010552d:	6a 5e                	push   $0x5e
  jmp alltraps
8010552f:	e9 0f f8 ff ff       	jmp    80104d43 <alltraps>

80105534 <vector95>:
.globl vector95
vector95:
  pushl $0
80105534:	6a 00                	push   $0x0
  pushl $95
80105536:	6a 5f                	push   $0x5f
  jmp alltraps
80105538:	e9 06 f8 ff ff       	jmp    80104d43 <alltraps>

8010553d <vector96>:
.globl vector96
vector96:
  pushl $0
8010553d:	6a 00                	push   $0x0
  pushl $96
8010553f:	6a 60                	push   $0x60
  jmp alltraps
80105541:	e9 fd f7 ff ff       	jmp    80104d43 <alltraps>

80105546 <vector97>:
.globl vector97
vector97:
  pushl $0
80105546:	6a 00                	push   $0x0
  pushl $97
80105548:	6a 61                	push   $0x61
  jmp alltraps
8010554a:	e9 f4 f7 ff ff       	jmp    80104d43 <alltraps>

8010554f <vector98>:
.globl vector98
vector98:
  pushl $0
8010554f:	6a 00                	push   $0x0
  pushl $98
80105551:	6a 62                	push   $0x62
  jmp alltraps
80105553:	e9 eb f7 ff ff       	jmp    80104d43 <alltraps>

80105558 <vector99>:
.globl vector99
vector99:
  pushl $0
80105558:	6a 00                	push   $0x0
  pushl $99
8010555a:	6a 63                	push   $0x63
  jmp alltraps
8010555c:	e9 e2 f7 ff ff       	jmp    80104d43 <alltraps>

80105561 <vector100>:
.globl vector100
vector100:
  pushl $0
80105561:	6a 00                	push   $0x0
  pushl $100
80105563:	6a 64                	push   $0x64
  jmp alltraps
80105565:	e9 d9 f7 ff ff       	jmp    80104d43 <alltraps>

8010556a <vector101>:
.globl vector101
vector101:
  pushl $0
8010556a:	6a 00                	push   $0x0
  pushl $101
8010556c:	6a 65                	push   $0x65
  jmp alltraps
8010556e:	e9 d0 f7 ff ff       	jmp    80104d43 <alltraps>

80105573 <vector102>:
.globl vector102
vector102:
  pushl $0
80105573:	6a 00                	push   $0x0
  pushl $102
80105575:	6a 66                	push   $0x66
  jmp alltraps
80105577:	e9 c7 f7 ff ff       	jmp    80104d43 <alltraps>

8010557c <vector103>:
.globl vector103
vector103:
  pushl $0
8010557c:	6a 00                	push   $0x0
  pushl $103
8010557e:	6a 67                	push   $0x67
  jmp alltraps
80105580:	e9 be f7 ff ff       	jmp    80104d43 <alltraps>

80105585 <vector104>:
.globl vector104
vector104:
  pushl $0
80105585:	6a 00                	push   $0x0
  pushl $104
80105587:	6a 68                	push   $0x68
  jmp alltraps
80105589:	e9 b5 f7 ff ff       	jmp    80104d43 <alltraps>

8010558e <vector105>:
.globl vector105
vector105:
  pushl $0
8010558e:	6a 00                	push   $0x0
  pushl $105
80105590:	6a 69                	push   $0x69
  jmp alltraps
80105592:	e9 ac f7 ff ff       	jmp    80104d43 <alltraps>

80105597 <vector106>:
.globl vector106
vector106:
  pushl $0
80105597:	6a 00                	push   $0x0
  pushl $106
80105599:	6a 6a                	push   $0x6a
  jmp alltraps
8010559b:	e9 a3 f7 ff ff       	jmp    80104d43 <alltraps>

801055a0 <vector107>:
.globl vector107
vector107:
  pushl $0
801055a0:	6a 00                	push   $0x0
  pushl $107
801055a2:	6a 6b                	push   $0x6b
  jmp alltraps
801055a4:	e9 9a f7 ff ff       	jmp    80104d43 <alltraps>

801055a9 <vector108>:
.globl vector108
vector108:
  pushl $0
801055a9:	6a 00                	push   $0x0
  pushl $108
801055ab:	6a 6c                	push   $0x6c
  jmp alltraps
801055ad:	e9 91 f7 ff ff       	jmp    80104d43 <alltraps>

801055b2 <vector109>:
.globl vector109
vector109:
  pushl $0
801055b2:	6a 00                	push   $0x0
  pushl $109
801055b4:	6a 6d                	push   $0x6d
  jmp alltraps
801055b6:	e9 88 f7 ff ff       	jmp    80104d43 <alltraps>

801055bb <vector110>:
.globl vector110
vector110:
  pushl $0
801055bb:	6a 00                	push   $0x0
  pushl $110
801055bd:	6a 6e                	push   $0x6e
  jmp alltraps
801055bf:	e9 7f f7 ff ff       	jmp    80104d43 <alltraps>

801055c4 <vector111>:
.globl vector111
vector111:
  pushl $0
801055c4:	6a 00                	push   $0x0
  pushl $111
801055c6:	6a 6f                	push   $0x6f
  jmp alltraps
801055c8:	e9 76 f7 ff ff       	jmp    80104d43 <alltraps>

801055cd <vector112>:
.globl vector112
vector112:
  pushl $0
801055cd:	6a 00                	push   $0x0
  pushl $112
801055cf:	6a 70                	push   $0x70
  jmp alltraps
801055d1:	e9 6d f7 ff ff       	jmp    80104d43 <alltraps>

801055d6 <vector113>:
.globl vector113
vector113:
  pushl $0
801055d6:	6a 00                	push   $0x0
  pushl $113
801055d8:	6a 71                	push   $0x71
  jmp alltraps
801055da:	e9 64 f7 ff ff       	jmp    80104d43 <alltraps>

801055df <vector114>:
.globl vector114
vector114:
  pushl $0
801055df:	6a 00                	push   $0x0
  pushl $114
801055e1:	6a 72                	push   $0x72
  jmp alltraps
801055e3:	e9 5b f7 ff ff       	jmp    80104d43 <alltraps>

801055e8 <vector115>:
.globl vector115
vector115:
  pushl $0
801055e8:	6a 00                	push   $0x0
  pushl $115
801055ea:	6a 73                	push   $0x73
  jmp alltraps
801055ec:	e9 52 f7 ff ff       	jmp    80104d43 <alltraps>

801055f1 <vector116>:
.globl vector116
vector116:
  pushl $0
801055f1:	6a 00                	push   $0x0
  pushl $116
801055f3:	6a 74                	push   $0x74
  jmp alltraps
801055f5:	e9 49 f7 ff ff       	jmp    80104d43 <alltraps>

801055fa <vector117>:
.globl vector117
vector117:
  pushl $0
801055fa:	6a 00                	push   $0x0
  pushl $117
801055fc:	6a 75                	push   $0x75
  jmp alltraps
801055fe:	e9 40 f7 ff ff       	jmp    80104d43 <alltraps>

80105603 <vector118>:
.globl vector118
vector118:
  pushl $0
80105603:	6a 00                	push   $0x0
  pushl $118
80105605:	6a 76                	push   $0x76
  jmp alltraps
80105607:	e9 37 f7 ff ff       	jmp    80104d43 <alltraps>

8010560c <vector119>:
.globl vector119
vector119:
  pushl $0
8010560c:	6a 00                	push   $0x0
  pushl $119
8010560e:	6a 77                	push   $0x77
  jmp alltraps
80105610:	e9 2e f7 ff ff       	jmp    80104d43 <alltraps>

80105615 <vector120>:
.globl vector120
vector120:
  pushl $0
80105615:	6a 00                	push   $0x0
  pushl $120
80105617:	6a 78                	push   $0x78
  jmp alltraps
80105619:	e9 25 f7 ff ff       	jmp    80104d43 <alltraps>

8010561e <vector121>:
.globl vector121
vector121:
  pushl $0
8010561e:	6a 00                	push   $0x0
  pushl $121
80105620:	6a 79                	push   $0x79
  jmp alltraps
80105622:	e9 1c f7 ff ff       	jmp    80104d43 <alltraps>

80105627 <vector122>:
.globl vector122
vector122:
  pushl $0
80105627:	6a 00                	push   $0x0
  pushl $122
80105629:	6a 7a                	push   $0x7a
  jmp alltraps
8010562b:	e9 13 f7 ff ff       	jmp    80104d43 <alltraps>

80105630 <vector123>:
.globl vector123
vector123:
  pushl $0
80105630:	6a 00                	push   $0x0
  pushl $123
80105632:	6a 7b                	push   $0x7b
  jmp alltraps
80105634:	e9 0a f7 ff ff       	jmp    80104d43 <alltraps>

80105639 <vector124>:
.globl vector124
vector124:
  pushl $0
80105639:	6a 00                	push   $0x0
  pushl $124
8010563b:	6a 7c                	push   $0x7c
  jmp alltraps
8010563d:	e9 01 f7 ff ff       	jmp    80104d43 <alltraps>

80105642 <vector125>:
.globl vector125
vector125:
  pushl $0
80105642:	6a 00                	push   $0x0
  pushl $125
80105644:	6a 7d                	push   $0x7d
  jmp alltraps
80105646:	e9 f8 f6 ff ff       	jmp    80104d43 <alltraps>

8010564b <vector126>:
.globl vector126
vector126:
  pushl $0
8010564b:	6a 00                	push   $0x0
  pushl $126
8010564d:	6a 7e                	push   $0x7e
  jmp alltraps
8010564f:	e9 ef f6 ff ff       	jmp    80104d43 <alltraps>

80105654 <vector127>:
.globl vector127
vector127:
  pushl $0
80105654:	6a 00                	push   $0x0
  pushl $127
80105656:	6a 7f                	push   $0x7f
  jmp alltraps
80105658:	e9 e6 f6 ff ff       	jmp    80104d43 <alltraps>

8010565d <vector128>:
.globl vector128
vector128:
  pushl $0
8010565d:	6a 00                	push   $0x0
  pushl $128
8010565f:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105664:	e9 da f6 ff ff       	jmp    80104d43 <alltraps>

80105669 <vector129>:
.globl vector129
vector129:
  pushl $0
80105669:	6a 00                	push   $0x0
  pushl $129
8010566b:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105670:	e9 ce f6 ff ff       	jmp    80104d43 <alltraps>

80105675 <vector130>:
.globl vector130
vector130:
  pushl $0
80105675:	6a 00                	push   $0x0
  pushl $130
80105677:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010567c:	e9 c2 f6 ff ff       	jmp    80104d43 <alltraps>

80105681 <vector131>:
.globl vector131
vector131:
  pushl $0
80105681:	6a 00                	push   $0x0
  pushl $131
80105683:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105688:	e9 b6 f6 ff ff       	jmp    80104d43 <alltraps>

8010568d <vector132>:
.globl vector132
vector132:
  pushl $0
8010568d:	6a 00                	push   $0x0
  pushl $132
8010568f:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105694:	e9 aa f6 ff ff       	jmp    80104d43 <alltraps>

80105699 <vector133>:
.globl vector133
vector133:
  pushl $0
80105699:	6a 00                	push   $0x0
  pushl $133
8010569b:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801056a0:	e9 9e f6 ff ff       	jmp    80104d43 <alltraps>

801056a5 <vector134>:
.globl vector134
vector134:
  pushl $0
801056a5:	6a 00                	push   $0x0
  pushl $134
801056a7:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801056ac:	e9 92 f6 ff ff       	jmp    80104d43 <alltraps>

801056b1 <vector135>:
.globl vector135
vector135:
  pushl $0
801056b1:	6a 00                	push   $0x0
  pushl $135
801056b3:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801056b8:	e9 86 f6 ff ff       	jmp    80104d43 <alltraps>

801056bd <vector136>:
.globl vector136
vector136:
  pushl $0
801056bd:	6a 00                	push   $0x0
  pushl $136
801056bf:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801056c4:	e9 7a f6 ff ff       	jmp    80104d43 <alltraps>

801056c9 <vector137>:
.globl vector137
vector137:
  pushl $0
801056c9:	6a 00                	push   $0x0
  pushl $137
801056cb:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801056d0:	e9 6e f6 ff ff       	jmp    80104d43 <alltraps>

801056d5 <vector138>:
.globl vector138
vector138:
  pushl $0
801056d5:	6a 00                	push   $0x0
  pushl $138
801056d7:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801056dc:	e9 62 f6 ff ff       	jmp    80104d43 <alltraps>

801056e1 <vector139>:
.globl vector139
vector139:
  pushl $0
801056e1:	6a 00                	push   $0x0
  pushl $139
801056e3:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801056e8:	e9 56 f6 ff ff       	jmp    80104d43 <alltraps>

801056ed <vector140>:
.globl vector140
vector140:
  pushl $0
801056ed:	6a 00                	push   $0x0
  pushl $140
801056ef:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801056f4:	e9 4a f6 ff ff       	jmp    80104d43 <alltraps>

801056f9 <vector141>:
.globl vector141
vector141:
  pushl $0
801056f9:	6a 00                	push   $0x0
  pushl $141
801056fb:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105700:	e9 3e f6 ff ff       	jmp    80104d43 <alltraps>

80105705 <vector142>:
.globl vector142
vector142:
  pushl $0
80105705:	6a 00                	push   $0x0
  pushl $142
80105707:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010570c:	e9 32 f6 ff ff       	jmp    80104d43 <alltraps>

80105711 <vector143>:
.globl vector143
vector143:
  pushl $0
80105711:	6a 00                	push   $0x0
  pushl $143
80105713:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105718:	e9 26 f6 ff ff       	jmp    80104d43 <alltraps>

8010571d <vector144>:
.globl vector144
vector144:
  pushl $0
8010571d:	6a 00                	push   $0x0
  pushl $144
8010571f:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105724:	e9 1a f6 ff ff       	jmp    80104d43 <alltraps>

80105729 <vector145>:
.globl vector145
vector145:
  pushl $0
80105729:	6a 00                	push   $0x0
  pushl $145
8010572b:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105730:	e9 0e f6 ff ff       	jmp    80104d43 <alltraps>

80105735 <vector146>:
.globl vector146
vector146:
  pushl $0
80105735:	6a 00                	push   $0x0
  pushl $146
80105737:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010573c:	e9 02 f6 ff ff       	jmp    80104d43 <alltraps>

80105741 <vector147>:
.globl vector147
vector147:
  pushl $0
80105741:	6a 00                	push   $0x0
  pushl $147
80105743:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105748:	e9 f6 f5 ff ff       	jmp    80104d43 <alltraps>

8010574d <vector148>:
.globl vector148
vector148:
  pushl $0
8010574d:	6a 00                	push   $0x0
  pushl $148
8010574f:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105754:	e9 ea f5 ff ff       	jmp    80104d43 <alltraps>

80105759 <vector149>:
.globl vector149
vector149:
  pushl $0
80105759:	6a 00                	push   $0x0
  pushl $149
8010575b:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105760:	e9 de f5 ff ff       	jmp    80104d43 <alltraps>

80105765 <vector150>:
.globl vector150
vector150:
  pushl $0
80105765:	6a 00                	push   $0x0
  pushl $150
80105767:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010576c:	e9 d2 f5 ff ff       	jmp    80104d43 <alltraps>

80105771 <vector151>:
.globl vector151
vector151:
  pushl $0
80105771:	6a 00                	push   $0x0
  pushl $151
80105773:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105778:	e9 c6 f5 ff ff       	jmp    80104d43 <alltraps>

8010577d <vector152>:
.globl vector152
vector152:
  pushl $0
8010577d:	6a 00                	push   $0x0
  pushl $152
8010577f:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105784:	e9 ba f5 ff ff       	jmp    80104d43 <alltraps>

80105789 <vector153>:
.globl vector153
vector153:
  pushl $0
80105789:	6a 00                	push   $0x0
  pushl $153
8010578b:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105790:	e9 ae f5 ff ff       	jmp    80104d43 <alltraps>

80105795 <vector154>:
.globl vector154
vector154:
  pushl $0
80105795:	6a 00                	push   $0x0
  pushl $154
80105797:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010579c:	e9 a2 f5 ff ff       	jmp    80104d43 <alltraps>

801057a1 <vector155>:
.globl vector155
vector155:
  pushl $0
801057a1:	6a 00                	push   $0x0
  pushl $155
801057a3:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801057a8:	e9 96 f5 ff ff       	jmp    80104d43 <alltraps>

801057ad <vector156>:
.globl vector156
vector156:
  pushl $0
801057ad:	6a 00                	push   $0x0
  pushl $156
801057af:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801057b4:	e9 8a f5 ff ff       	jmp    80104d43 <alltraps>

801057b9 <vector157>:
.globl vector157
vector157:
  pushl $0
801057b9:	6a 00                	push   $0x0
  pushl $157
801057bb:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801057c0:	e9 7e f5 ff ff       	jmp    80104d43 <alltraps>

801057c5 <vector158>:
.globl vector158
vector158:
  pushl $0
801057c5:	6a 00                	push   $0x0
  pushl $158
801057c7:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801057cc:	e9 72 f5 ff ff       	jmp    80104d43 <alltraps>

801057d1 <vector159>:
.globl vector159
vector159:
  pushl $0
801057d1:	6a 00                	push   $0x0
  pushl $159
801057d3:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801057d8:	e9 66 f5 ff ff       	jmp    80104d43 <alltraps>

801057dd <vector160>:
.globl vector160
vector160:
  pushl $0
801057dd:	6a 00                	push   $0x0
  pushl $160
801057df:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801057e4:	e9 5a f5 ff ff       	jmp    80104d43 <alltraps>

801057e9 <vector161>:
.globl vector161
vector161:
  pushl $0
801057e9:	6a 00                	push   $0x0
  pushl $161
801057eb:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801057f0:	e9 4e f5 ff ff       	jmp    80104d43 <alltraps>

801057f5 <vector162>:
.globl vector162
vector162:
  pushl $0
801057f5:	6a 00                	push   $0x0
  pushl $162
801057f7:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801057fc:	e9 42 f5 ff ff       	jmp    80104d43 <alltraps>

80105801 <vector163>:
.globl vector163
vector163:
  pushl $0
80105801:	6a 00                	push   $0x0
  pushl $163
80105803:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105808:	e9 36 f5 ff ff       	jmp    80104d43 <alltraps>

8010580d <vector164>:
.globl vector164
vector164:
  pushl $0
8010580d:	6a 00                	push   $0x0
  pushl $164
8010580f:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105814:	e9 2a f5 ff ff       	jmp    80104d43 <alltraps>

80105819 <vector165>:
.globl vector165
vector165:
  pushl $0
80105819:	6a 00                	push   $0x0
  pushl $165
8010581b:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105820:	e9 1e f5 ff ff       	jmp    80104d43 <alltraps>

80105825 <vector166>:
.globl vector166
vector166:
  pushl $0
80105825:	6a 00                	push   $0x0
  pushl $166
80105827:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010582c:	e9 12 f5 ff ff       	jmp    80104d43 <alltraps>

80105831 <vector167>:
.globl vector167
vector167:
  pushl $0
80105831:	6a 00                	push   $0x0
  pushl $167
80105833:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105838:	e9 06 f5 ff ff       	jmp    80104d43 <alltraps>

8010583d <vector168>:
.globl vector168
vector168:
  pushl $0
8010583d:	6a 00                	push   $0x0
  pushl $168
8010583f:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105844:	e9 fa f4 ff ff       	jmp    80104d43 <alltraps>

80105849 <vector169>:
.globl vector169
vector169:
  pushl $0
80105849:	6a 00                	push   $0x0
  pushl $169
8010584b:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105850:	e9 ee f4 ff ff       	jmp    80104d43 <alltraps>

80105855 <vector170>:
.globl vector170
vector170:
  pushl $0
80105855:	6a 00                	push   $0x0
  pushl $170
80105857:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010585c:	e9 e2 f4 ff ff       	jmp    80104d43 <alltraps>

80105861 <vector171>:
.globl vector171
vector171:
  pushl $0
80105861:	6a 00                	push   $0x0
  pushl $171
80105863:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80105868:	e9 d6 f4 ff ff       	jmp    80104d43 <alltraps>

8010586d <vector172>:
.globl vector172
vector172:
  pushl $0
8010586d:	6a 00                	push   $0x0
  pushl $172
8010586f:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105874:	e9 ca f4 ff ff       	jmp    80104d43 <alltraps>

80105879 <vector173>:
.globl vector173
vector173:
  pushl $0
80105879:	6a 00                	push   $0x0
  pushl $173
8010587b:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105880:	e9 be f4 ff ff       	jmp    80104d43 <alltraps>

80105885 <vector174>:
.globl vector174
vector174:
  pushl $0
80105885:	6a 00                	push   $0x0
  pushl $174
80105887:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010588c:	e9 b2 f4 ff ff       	jmp    80104d43 <alltraps>

80105891 <vector175>:
.globl vector175
vector175:
  pushl $0
80105891:	6a 00                	push   $0x0
  pushl $175
80105893:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105898:	e9 a6 f4 ff ff       	jmp    80104d43 <alltraps>

8010589d <vector176>:
.globl vector176
vector176:
  pushl $0
8010589d:	6a 00                	push   $0x0
  pushl $176
8010589f:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801058a4:	e9 9a f4 ff ff       	jmp    80104d43 <alltraps>

801058a9 <vector177>:
.globl vector177
vector177:
  pushl $0
801058a9:	6a 00                	push   $0x0
  pushl $177
801058ab:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801058b0:	e9 8e f4 ff ff       	jmp    80104d43 <alltraps>

801058b5 <vector178>:
.globl vector178
vector178:
  pushl $0
801058b5:	6a 00                	push   $0x0
  pushl $178
801058b7:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801058bc:	e9 82 f4 ff ff       	jmp    80104d43 <alltraps>

801058c1 <vector179>:
.globl vector179
vector179:
  pushl $0
801058c1:	6a 00                	push   $0x0
  pushl $179
801058c3:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801058c8:	e9 76 f4 ff ff       	jmp    80104d43 <alltraps>

801058cd <vector180>:
.globl vector180
vector180:
  pushl $0
801058cd:	6a 00                	push   $0x0
  pushl $180
801058cf:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801058d4:	e9 6a f4 ff ff       	jmp    80104d43 <alltraps>

801058d9 <vector181>:
.globl vector181
vector181:
  pushl $0
801058d9:	6a 00                	push   $0x0
  pushl $181
801058db:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801058e0:	e9 5e f4 ff ff       	jmp    80104d43 <alltraps>

801058e5 <vector182>:
.globl vector182
vector182:
  pushl $0
801058e5:	6a 00                	push   $0x0
  pushl $182
801058e7:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801058ec:	e9 52 f4 ff ff       	jmp    80104d43 <alltraps>

801058f1 <vector183>:
.globl vector183
vector183:
  pushl $0
801058f1:	6a 00                	push   $0x0
  pushl $183
801058f3:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801058f8:	e9 46 f4 ff ff       	jmp    80104d43 <alltraps>

801058fd <vector184>:
.globl vector184
vector184:
  pushl $0
801058fd:	6a 00                	push   $0x0
  pushl $184
801058ff:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80105904:	e9 3a f4 ff ff       	jmp    80104d43 <alltraps>

80105909 <vector185>:
.globl vector185
vector185:
  pushl $0
80105909:	6a 00                	push   $0x0
  pushl $185
8010590b:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80105910:	e9 2e f4 ff ff       	jmp    80104d43 <alltraps>

80105915 <vector186>:
.globl vector186
vector186:
  pushl $0
80105915:	6a 00                	push   $0x0
  pushl $186
80105917:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010591c:	e9 22 f4 ff ff       	jmp    80104d43 <alltraps>

80105921 <vector187>:
.globl vector187
vector187:
  pushl $0
80105921:	6a 00                	push   $0x0
  pushl $187
80105923:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80105928:	e9 16 f4 ff ff       	jmp    80104d43 <alltraps>

8010592d <vector188>:
.globl vector188
vector188:
  pushl $0
8010592d:	6a 00                	push   $0x0
  pushl $188
8010592f:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80105934:	e9 0a f4 ff ff       	jmp    80104d43 <alltraps>

80105939 <vector189>:
.globl vector189
vector189:
  pushl $0
80105939:	6a 00                	push   $0x0
  pushl $189
8010593b:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80105940:	e9 fe f3 ff ff       	jmp    80104d43 <alltraps>

80105945 <vector190>:
.globl vector190
vector190:
  pushl $0
80105945:	6a 00                	push   $0x0
  pushl $190
80105947:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010594c:	e9 f2 f3 ff ff       	jmp    80104d43 <alltraps>

80105951 <vector191>:
.globl vector191
vector191:
  pushl $0
80105951:	6a 00                	push   $0x0
  pushl $191
80105953:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80105958:	e9 e6 f3 ff ff       	jmp    80104d43 <alltraps>

8010595d <vector192>:
.globl vector192
vector192:
  pushl $0
8010595d:	6a 00                	push   $0x0
  pushl $192
8010595f:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80105964:	e9 da f3 ff ff       	jmp    80104d43 <alltraps>

80105969 <vector193>:
.globl vector193
vector193:
  pushl $0
80105969:	6a 00                	push   $0x0
  pushl $193
8010596b:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105970:	e9 ce f3 ff ff       	jmp    80104d43 <alltraps>

80105975 <vector194>:
.globl vector194
vector194:
  pushl $0
80105975:	6a 00                	push   $0x0
  pushl $194
80105977:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010597c:	e9 c2 f3 ff ff       	jmp    80104d43 <alltraps>

80105981 <vector195>:
.globl vector195
vector195:
  pushl $0
80105981:	6a 00                	push   $0x0
  pushl $195
80105983:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105988:	e9 b6 f3 ff ff       	jmp    80104d43 <alltraps>

8010598d <vector196>:
.globl vector196
vector196:
  pushl $0
8010598d:	6a 00                	push   $0x0
  pushl $196
8010598f:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105994:	e9 aa f3 ff ff       	jmp    80104d43 <alltraps>

80105999 <vector197>:
.globl vector197
vector197:
  pushl $0
80105999:	6a 00                	push   $0x0
  pushl $197
8010599b:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801059a0:	e9 9e f3 ff ff       	jmp    80104d43 <alltraps>

801059a5 <vector198>:
.globl vector198
vector198:
  pushl $0
801059a5:	6a 00                	push   $0x0
  pushl $198
801059a7:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801059ac:	e9 92 f3 ff ff       	jmp    80104d43 <alltraps>

801059b1 <vector199>:
.globl vector199
vector199:
  pushl $0
801059b1:	6a 00                	push   $0x0
  pushl $199
801059b3:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801059b8:	e9 86 f3 ff ff       	jmp    80104d43 <alltraps>

801059bd <vector200>:
.globl vector200
vector200:
  pushl $0
801059bd:	6a 00                	push   $0x0
  pushl $200
801059bf:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801059c4:	e9 7a f3 ff ff       	jmp    80104d43 <alltraps>

801059c9 <vector201>:
.globl vector201
vector201:
  pushl $0
801059c9:	6a 00                	push   $0x0
  pushl $201
801059cb:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801059d0:	e9 6e f3 ff ff       	jmp    80104d43 <alltraps>

801059d5 <vector202>:
.globl vector202
vector202:
  pushl $0
801059d5:	6a 00                	push   $0x0
  pushl $202
801059d7:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801059dc:	e9 62 f3 ff ff       	jmp    80104d43 <alltraps>

801059e1 <vector203>:
.globl vector203
vector203:
  pushl $0
801059e1:	6a 00                	push   $0x0
  pushl $203
801059e3:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801059e8:	e9 56 f3 ff ff       	jmp    80104d43 <alltraps>

801059ed <vector204>:
.globl vector204
vector204:
  pushl $0
801059ed:	6a 00                	push   $0x0
  pushl $204
801059ef:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801059f4:	e9 4a f3 ff ff       	jmp    80104d43 <alltraps>

801059f9 <vector205>:
.globl vector205
vector205:
  pushl $0
801059f9:	6a 00                	push   $0x0
  pushl $205
801059fb:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105a00:	e9 3e f3 ff ff       	jmp    80104d43 <alltraps>

80105a05 <vector206>:
.globl vector206
vector206:
  pushl $0
80105a05:	6a 00                	push   $0x0
  pushl $206
80105a07:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80105a0c:	e9 32 f3 ff ff       	jmp    80104d43 <alltraps>

80105a11 <vector207>:
.globl vector207
vector207:
  pushl $0
80105a11:	6a 00                	push   $0x0
  pushl $207
80105a13:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80105a18:	e9 26 f3 ff ff       	jmp    80104d43 <alltraps>

80105a1d <vector208>:
.globl vector208
vector208:
  pushl $0
80105a1d:	6a 00                	push   $0x0
  pushl $208
80105a1f:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80105a24:	e9 1a f3 ff ff       	jmp    80104d43 <alltraps>

80105a29 <vector209>:
.globl vector209
vector209:
  pushl $0
80105a29:	6a 00                	push   $0x0
  pushl $209
80105a2b:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105a30:	e9 0e f3 ff ff       	jmp    80104d43 <alltraps>

80105a35 <vector210>:
.globl vector210
vector210:
  pushl $0
80105a35:	6a 00                	push   $0x0
  pushl $210
80105a37:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80105a3c:	e9 02 f3 ff ff       	jmp    80104d43 <alltraps>

80105a41 <vector211>:
.globl vector211
vector211:
  pushl $0
80105a41:	6a 00                	push   $0x0
  pushl $211
80105a43:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105a48:	e9 f6 f2 ff ff       	jmp    80104d43 <alltraps>

80105a4d <vector212>:
.globl vector212
vector212:
  pushl $0
80105a4d:	6a 00                	push   $0x0
  pushl $212
80105a4f:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105a54:	e9 ea f2 ff ff       	jmp    80104d43 <alltraps>

80105a59 <vector213>:
.globl vector213
vector213:
  pushl $0
80105a59:	6a 00                	push   $0x0
  pushl $213
80105a5b:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105a60:	e9 de f2 ff ff       	jmp    80104d43 <alltraps>

80105a65 <vector214>:
.globl vector214
vector214:
  pushl $0
80105a65:	6a 00                	push   $0x0
  pushl $214
80105a67:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80105a6c:	e9 d2 f2 ff ff       	jmp    80104d43 <alltraps>

80105a71 <vector215>:
.globl vector215
vector215:
  pushl $0
80105a71:	6a 00                	push   $0x0
  pushl $215
80105a73:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105a78:	e9 c6 f2 ff ff       	jmp    80104d43 <alltraps>

80105a7d <vector216>:
.globl vector216
vector216:
  pushl $0
80105a7d:	6a 00                	push   $0x0
  pushl $216
80105a7f:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105a84:	e9 ba f2 ff ff       	jmp    80104d43 <alltraps>

80105a89 <vector217>:
.globl vector217
vector217:
  pushl $0
80105a89:	6a 00                	push   $0x0
  pushl $217
80105a8b:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105a90:	e9 ae f2 ff ff       	jmp    80104d43 <alltraps>

80105a95 <vector218>:
.globl vector218
vector218:
  pushl $0
80105a95:	6a 00                	push   $0x0
  pushl $218
80105a97:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105a9c:	e9 a2 f2 ff ff       	jmp    80104d43 <alltraps>

80105aa1 <vector219>:
.globl vector219
vector219:
  pushl $0
80105aa1:	6a 00                	push   $0x0
  pushl $219
80105aa3:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105aa8:	e9 96 f2 ff ff       	jmp    80104d43 <alltraps>

80105aad <vector220>:
.globl vector220
vector220:
  pushl $0
80105aad:	6a 00                	push   $0x0
  pushl $220
80105aaf:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105ab4:	e9 8a f2 ff ff       	jmp    80104d43 <alltraps>

80105ab9 <vector221>:
.globl vector221
vector221:
  pushl $0
80105ab9:	6a 00                	push   $0x0
  pushl $221
80105abb:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105ac0:	e9 7e f2 ff ff       	jmp    80104d43 <alltraps>

80105ac5 <vector222>:
.globl vector222
vector222:
  pushl $0
80105ac5:	6a 00                	push   $0x0
  pushl $222
80105ac7:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105acc:	e9 72 f2 ff ff       	jmp    80104d43 <alltraps>

80105ad1 <vector223>:
.globl vector223
vector223:
  pushl $0
80105ad1:	6a 00                	push   $0x0
  pushl $223
80105ad3:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105ad8:	e9 66 f2 ff ff       	jmp    80104d43 <alltraps>

80105add <vector224>:
.globl vector224
vector224:
  pushl $0
80105add:	6a 00                	push   $0x0
  pushl $224
80105adf:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105ae4:	e9 5a f2 ff ff       	jmp    80104d43 <alltraps>

80105ae9 <vector225>:
.globl vector225
vector225:
  pushl $0
80105ae9:	6a 00                	push   $0x0
  pushl $225
80105aeb:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105af0:	e9 4e f2 ff ff       	jmp    80104d43 <alltraps>

80105af5 <vector226>:
.globl vector226
vector226:
  pushl $0
80105af5:	6a 00                	push   $0x0
  pushl $226
80105af7:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105afc:	e9 42 f2 ff ff       	jmp    80104d43 <alltraps>

80105b01 <vector227>:
.globl vector227
vector227:
  pushl $0
80105b01:	6a 00                	push   $0x0
  pushl $227
80105b03:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105b08:	e9 36 f2 ff ff       	jmp    80104d43 <alltraps>

80105b0d <vector228>:
.globl vector228
vector228:
  pushl $0
80105b0d:	6a 00                	push   $0x0
  pushl $228
80105b0f:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105b14:	e9 2a f2 ff ff       	jmp    80104d43 <alltraps>

80105b19 <vector229>:
.globl vector229
vector229:
  pushl $0
80105b19:	6a 00                	push   $0x0
  pushl $229
80105b1b:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105b20:	e9 1e f2 ff ff       	jmp    80104d43 <alltraps>

80105b25 <vector230>:
.globl vector230
vector230:
  pushl $0
80105b25:	6a 00                	push   $0x0
  pushl $230
80105b27:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105b2c:	e9 12 f2 ff ff       	jmp    80104d43 <alltraps>

80105b31 <vector231>:
.globl vector231
vector231:
  pushl $0
80105b31:	6a 00                	push   $0x0
  pushl $231
80105b33:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105b38:	e9 06 f2 ff ff       	jmp    80104d43 <alltraps>

80105b3d <vector232>:
.globl vector232
vector232:
  pushl $0
80105b3d:	6a 00                	push   $0x0
  pushl $232
80105b3f:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105b44:	e9 fa f1 ff ff       	jmp    80104d43 <alltraps>

80105b49 <vector233>:
.globl vector233
vector233:
  pushl $0
80105b49:	6a 00                	push   $0x0
  pushl $233
80105b4b:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105b50:	e9 ee f1 ff ff       	jmp    80104d43 <alltraps>

80105b55 <vector234>:
.globl vector234
vector234:
  pushl $0
80105b55:	6a 00                	push   $0x0
  pushl $234
80105b57:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105b5c:	e9 e2 f1 ff ff       	jmp    80104d43 <alltraps>

80105b61 <vector235>:
.globl vector235
vector235:
  pushl $0
80105b61:	6a 00                	push   $0x0
  pushl $235
80105b63:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105b68:	e9 d6 f1 ff ff       	jmp    80104d43 <alltraps>

80105b6d <vector236>:
.globl vector236
vector236:
  pushl $0
80105b6d:	6a 00                	push   $0x0
  pushl $236
80105b6f:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105b74:	e9 ca f1 ff ff       	jmp    80104d43 <alltraps>

80105b79 <vector237>:
.globl vector237
vector237:
  pushl $0
80105b79:	6a 00                	push   $0x0
  pushl $237
80105b7b:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105b80:	e9 be f1 ff ff       	jmp    80104d43 <alltraps>

80105b85 <vector238>:
.globl vector238
vector238:
  pushl $0
80105b85:	6a 00                	push   $0x0
  pushl $238
80105b87:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105b8c:	e9 b2 f1 ff ff       	jmp    80104d43 <alltraps>

80105b91 <vector239>:
.globl vector239
vector239:
  pushl $0
80105b91:	6a 00                	push   $0x0
  pushl $239
80105b93:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105b98:	e9 a6 f1 ff ff       	jmp    80104d43 <alltraps>

80105b9d <vector240>:
.globl vector240
vector240:
  pushl $0
80105b9d:	6a 00                	push   $0x0
  pushl $240
80105b9f:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105ba4:	e9 9a f1 ff ff       	jmp    80104d43 <alltraps>

80105ba9 <vector241>:
.globl vector241
vector241:
  pushl $0
80105ba9:	6a 00                	push   $0x0
  pushl $241
80105bab:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105bb0:	e9 8e f1 ff ff       	jmp    80104d43 <alltraps>

80105bb5 <vector242>:
.globl vector242
vector242:
  pushl $0
80105bb5:	6a 00                	push   $0x0
  pushl $242
80105bb7:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105bbc:	e9 82 f1 ff ff       	jmp    80104d43 <alltraps>

80105bc1 <vector243>:
.globl vector243
vector243:
  pushl $0
80105bc1:	6a 00                	push   $0x0
  pushl $243
80105bc3:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105bc8:	e9 76 f1 ff ff       	jmp    80104d43 <alltraps>

80105bcd <vector244>:
.globl vector244
vector244:
  pushl $0
80105bcd:	6a 00                	push   $0x0
  pushl $244
80105bcf:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105bd4:	e9 6a f1 ff ff       	jmp    80104d43 <alltraps>

80105bd9 <vector245>:
.globl vector245
vector245:
  pushl $0
80105bd9:	6a 00                	push   $0x0
  pushl $245
80105bdb:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105be0:	e9 5e f1 ff ff       	jmp    80104d43 <alltraps>

80105be5 <vector246>:
.globl vector246
vector246:
  pushl $0
80105be5:	6a 00                	push   $0x0
  pushl $246
80105be7:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105bec:	e9 52 f1 ff ff       	jmp    80104d43 <alltraps>

80105bf1 <vector247>:
.globl vector247
vector247:
  pushl $0
80105bf1:	6a 00                	push   $0x0
  pushl $247
80105bf3:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105bf8:	e9 46 f1 ff ff       	jmp    80104d43 <alltraps>

80105bfd <vector248>:
.globl vector248
vector248:
  pushl $0
80105bfd:	6a 00                	push   $0x0
  pushl $248
80105bff:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105c04:	e9 3a f1 ff ff       	jmp    80104d43 <alltraps>

80105c09 <vector249>:
.globl vector249
vector249:
  pushl $0
80105c09:	6a 00                	push   $0x0
  pushl $249
80105c0b:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105c10:	e9 2e f1 ff ff       	jmp    80104d43 <alltraps>

80105c15 <vector250>:
.globl vector250
vector250:
  pushl $0
80105c15:	6a 00                	push   $0x0
  pushl $250
80105c17:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105c1c:	e9 22 f1 ff ff       	jmp    80104d43 <alltraps>

80105c21 <vector251>:
.globl vector251
vector251:
  pushl $0
80105c21:	6a 00                	push   $0x0
  pushl $251
80105c23:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105c28:	e9 16 f1 ff ff       	jmp    80104d43 <alltraps>

80105c2d <vector252>:
.globl vector252
vector252:
  pushl $0
80105c2d:	6a 00                	push   $0x0
  pushl $252
80105c2f:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105c34:	e9 0a f1 ff ff       	jmp    80104d43 <alltraps>

80105c39 <vector253>:
.globl vector253
vector253:
  pushl $0
80105c39:	6a 00                	push   $0x0
  pushl $253
80105c3b:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105c40:	e9 fe f0 ff ff       	jmp    80104d43 <alltraps>

80105c45 <vector254>:
.globl vector254
vector254:
  pushl $0
80105c45:	6a 00                	push   $0x0
  pushl $254
80105c47:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105c4c:	e9 f2 f0 ff ff       	jmp    80104d43 <alltraps>

80105c51 <vector255>:
.globl vector255
vector255:
  pushl $0
80105c51:	6a 00                	push   $0x0
  pushl $255
80105c53:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105c58:	e9 e6 f0 ff ff       	jmp    80104d43 <alltraps>

80105c5d <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80105c5d:	55                   	push   %ebp
80105c5e:	89 e5                	mov    %esp,%ebp
80105c60:	57                   	push   %edi
80105c61:	56                   	push   %esi
80105c62:	53                   	push   %ebx
80105c63:	83 ec 0c             	sub    $0xc,%esp
80105c66:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80105c68:	c1 ea 16             	shr    $0x16,%edx
80105c6b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & (PTE_P | PTE_E)){ 
80105c6e:	8b 37                	mov    (%edi),%esi
80105c70:	f7 c6 01 01 00 00    	test   $0x101,%esi
80105c76:	74 20                	je     80105c98 <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105c78:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80105c7e:	81 c6 00 00 00 80    	add    $0x80000000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80105c84:	c1 eb 0c             	shr    $0xc,%ebx
80105c87:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80105c8d:	8d 04 9e             	lea    (%esi,%ebx,4),%eax
}
80105c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c93:	5b                   	pop    %ebx
80105c94:	5e                   	pop    %esi
80105c95:	5f                   	pop    %edi
80105c96:	5d                   	pop    %ebp
80105c97:	c3                   	ret    
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105c98:	85 c9                	test   %ecx,%ecx
80105c9a:	74 2b                	je     80105cc7 <walkpgdir+0x6a>
80105c9c:	e8 02 c4 ff ff       	call   801020a3 <kalloc>
80105ca1:	89 c6                	mov    %eax,%esi
80105ca3:	85 c0                	test   %eax,%eax
80105ca5:	74 20                	je     80105cc7 <walkpgdir+0x6a>
    memset(pgtab, 0, PGSIZE);
80105ca7:	83 ec 04             	sub    $0x4,%esp
80105caa:	68 00 10 00 00       	push   $0x1000
80105caf:	6a 00                	push   $0x0
80105cb1:	50                   	push   %eax
80105cb2:	e8 47 df ff ff       	call   80103bfe <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105cb7:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80105cbd:	83 c8 07             	or     $0x7,%eax
80105cc0:	89 07                	mov    %eax,(%edi)
80105cc2:	83 c4 10             	add    $0x10,%esp
80105cc5:	eb bd                	jmp    80105c84 <walkpgdir+0x27>
      return 0;
80105cc7:	b8 00 00 00 00       	mov    $0x0,%eax
80105ccc:	eb c2                	jmp    80105c90 <walkpgdir+0x33>

80105cce <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80105cce:	55                   	push   %ebp
80105ccf:	89 e5                	mov    %esp,%ebp
80105cd1:	57                   	push   %edi
80105cd2:	56                   	push   %esi
80105cd3:	53                   	push   %ebx
80105cd4:	83 ec 1c             	sub    $0x1c,%esp
80105cd7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105cda:	8b 75 08             	mov    0x8(%ebp),%esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80105cdd:	89 d3                	mov    %edx,%ebx
80105cdf:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80105ce5:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
80105ce9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105cef:	b9 01 00 00 00       	mov    $0x1,%ecx
80105cf4:	89 da                	mov    %ebx,%edx
80105cf6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105cf9:	e8 5f ff ff ff       	call   80105c5d <walkpgdir>
80105cfe:	85 c0                	test   %eax,%eax
80105d00:	74 31                	je     80105d33 <mappages+0x65>
      return -1;
    if(*pte & (PTE_P | PTE_E))
80105d02:	f7 00 01 01 00 00    	testl  $0x101,(%eax)
80105d08:	75 1c                	jne    80105d26 <mappages+0x58>
      panic("remap");
    *pte = pa | perm | PTE_P; // TODO?
80105d0a:	89 f2                	mov    %esi,%edx
80105d0c:	0b 55 0c             	or     0xc(%ebp),%edx
80105d0f:	83 ca 01             	or     $0x1,%edx
80105d12:	89 10                	mov    %edx,(%eax)
    if(a == last)
80105d14:	39 fb                	cmp    %edi,%ebx
80105d16:	74 28                	je     80105d40 <mappages+0x72>
      break;
    a += PGSIZE;
80105d18:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
80105d1e:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105d24:	eb c9                	jmp    80105cef <mappages+0x21>
      panic("remap");
80105d26:	83 ec 0c             	sub    $0xc,%esp
80105d29:	68 3c 72 10 80       	push   $0x8010723c
80105d2e:	e8 15 a6 ff ff       	call   80100348 <panic>
      return -1;
80105d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80105d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d3b:	5b                   	pop    %ebx
80105d3c:	5e                   	pop    %esi
80105d3d:	5f                   	pop    %edi
80105d3e:	5d                   	pop    %ebp
80105d3f:	c3                   	ret    
  return 0;
80105d40:	b8 00 00 00 00       	mov    $0x0,%eax
80105d45:	eb f1                	jmp    80105d38 <mappages+0x6a>

80105d47 <seginit>:
{
80105d47:	55                   	push   %ebp
80105d48:	89 e5                	mov    %esp,%ebp
80105d4a:	57                   	push   %edi
80105d4b:	56                   	push   %esi
80105d4c:	53                   	push   %ebx
80105d4d:	83 ec 1c             	sub    $0x1c,%esp
  c = &cpus[cpuid()];
80105d50:	e8 45 d4 ff ff       	call   8010319a <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80105d55:	69 f8 b0 00 00 00    	imul   $0xb0,%eax,%edi
80105d5b:	66 c7 87 18 18 11 80 	movw   $0xffff,-0x7feee7e8(%edi)
80105d62:	ff ff 
80105d64:	66 c7 87 1a 18 11 80 	movw   $0x0,-0x7feee7e6(%edi)
80105d6b:	00 00 
80105d6d:	c6 87 1c 18 11 80 00 	movb   $0x0,-0x7feee7e4(%edi)
80105d74:	0f b6 8f 1d 18 11 80 	movzbl -0x7feee7e3(%edi),%ecx
80105d7b:	83 e1 f0             	and    $0xfffffff0,%ecx
80105d7e:	89 ce                	mov    %ecx,%esi
80105d80:	83 ce 0a             	or     $0xa,%esi
80105d83:	89 f2                	mov    %esi,%edx
80105d85:	88 97 1d 18 11 80    	mov    %dl,-0x7feee7e3(%edi)
80105d8b:	83 c9 1a             	or     $0x1a,%ecx
80105d8e:	88 8f 1d 18 11 80    	mov    %cl,-0x7feee7e3(%edi)
80105d94:	83 e1 9f             	and    $0xffffff9f,%ecx
80105d97:	88 8f 1d 18 11 80    	mov    %cl,-0x7feee7e3(%edi)
80105d9d:	83 c9 80             	or     $0xffffff80,%ecx
80105da0:	88 8f 1d 18 11 80    	mov    %cl,-0x7feee7e3(%edi)
80105da6:	0f b6 8f 1e 18 11 80 	movzbl -0x7feee7e2(%edi),%ecx
80105dad:	83 c9 0f             	or     $0xf,%ecx
80105db0:	88 8f 1e 18 11 80    	mov    %cl,-0x7feee7e2(%edi)
80105db6:	89 ce                	mov    %ecx,%esi
80105db8:	83 e6 ef             	and    $0xffffffef,%esi
80105dbb:	89 f2                	mov    %esi,%edx
80105dbd:	88 97 1e 18 11 80    	mov    %dl,-0x7feee7e2(%edi)
80105dc3:	83 e1 cf             	and    $0xffffffcf,%ecx
80105dc6:	88 8f 1e 18 11 80    	mov    %cl,-0x7feee7e2(%edi)
80105dcc:	89 ce                	mov    %ecx,%esi
80105dce:	83 ce 40             	or     $0x40,%esi
80105dd1:	89 f2                	mov    %esi,%edx
80105dd3:	88 97 1e 18 11 80    	mov    %dl,-0x7feee7e2(%edi)
80105dd9:	83 c9 c0             	or     $0xffffffc0,%ecx
80105ddc:	88 8f 1e 18 11 80    	mov    %cl,-0x7feee7e2(%edi)
80105de2:	c6 87 1f 18 11 80 00 	movb   $0x0,-0x7feee7e1(%edi)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80105de9:	66 c7 87 20 18 11 80 	movw   $0xffff,-0x7feee7e0(%edi)
80105df0:	ff ff 
80105df2:	66 c7 87 22 18 11 80 	movw   $0x0,-0x7feee7de(%edi)
80105df9:	00 00 
80105dfb:	c6 87 24 18 11 80 00 	movb   $0x0,-0x7feee7dc(%edi)
80105e02:	0f b6 8f 25 18 11 80 	movzbl -0x7feee7db(%edi),%ecx
80105e09:	83 e1 f0             	and    $0xfffffff0,%ecx
80105e0c:	89 ce                	mov    %ecx,%esi
80105e0e:	83 ce 02             	or     $0x2,%esi
80105e11:	89 f2                	mov    %esi,%edx
80105e13:	88 97 25 18 11 80    	mov    %dl,-0x7feee7db(%edi)
80105e19:	83 c9 12             	or     $0x12,%ecx
80105e1c:	88 8f 25 18 11 80    	mov    %cl,-0x7feee7db(%edi)
80105e22:	83 e1 9f             	and    $0xffffff9f,%ecx
80105e25:	88 8f 25 18 11 80    	mov    %cl,-0x7feee7db(%edi)
80105e2b:	83 c9 80             	or     $0xffffff80,%ecx
80105e2e:	88 8f 25 18 11 80    	mov    %cl,-0x7feee7db(%edi)
80105e34:	0f b6 8f 26 18 11 80 	movzbl -0x7feee7da(%edi),%ecx
80105e3b:	83 c9 0f             	or     $0xf,%ecx
80105e3e:	88 8f 26 18 11 80    	mov    %cl,-0x7feee7da(%edi)
80105e44:	89 ce                	mov    %ecx,%esi
80105e46:	83 e6 ef             	and    $0xffffffef,%esi
80105e49:	89 f2                	mov    %esi,%edx
80105e4b:	88 97 26 18 11 80    	mov    %dl,-0x7feee7da(%edi)
80105e51:	83 e1 cf             	and    $0xffffffcf,%ecx
80105e54:	88 8f 26 18 11 80    	mov    %cl,-0x7feee7da(%edi)
80105e5a:	89 ce                	mov    %ecx,%esi
80105e5c:	83 ce 40             	or     $0x40,%esi
80105e5f:	89 f2                	mov    %esi,%edx
80105e61:	88 97 26 18 11 80    	mov    %dl,-0x7feee7da(%edi)
80105e67:	83 c9 c0             	or     $0xffffffc0,%ecx
80105e6a:	88 8f 26 18 11 80    	mov    %cl,-0x7feee7da(%edi)
80105e70:	c6 87 27 18 11 80 00 	movb   $0x0,-0x7feee7d9(%edi)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80105e77:	66 c7 87 28 18 11 80 	movw   $0xffff,-0x7feee7d8(%edi)
80105e7e:	ff ff 
80105e80:	66 c7 87 2a 18 11 80 	movw   $0x0,-0x7feee7d6(%edi)
80105e87:	00 00 
80105e89:	c6 87 2c 18 11 80 00 	movb   $0x0,-0x7feee7d4(%edi)
80105e90:	0f b6 9f 2d 18 11 80 	movzbl -0x7feee7d3(%edi),%ebx
80105e97:	83 e3 f0             	and    $0xfffffff0,%ebx
80105e9a:	89 de                	mov    %ebx,%esi
80105e9c:	83 ce 0a             	or     $0xa,%esi
80105e9f:	89 f2                	mov    %esi,%edx
80105ea1:	88 97 2d 18 11 80    	mov    %dl,-0x7feee7d3(%edi)
80105ea7:	89 de                	mov    %ebx,%esi
80105ea9:	83 ce 1a             	or     $0x1a,%esi
80105eac:	89 f2                	mov    %esi,%edx
80105eae:	88 97 2d 18 11 80    	mov    %dl,-0x7feee7d3(%edi)
80105eb4:	83 cb 7a             	or     $0x7a,%ebx
80105eb7:	88 9f 2d 18 11 80    	mov    %bl,-0x7feee7d3(%edi)
80105ebd:	c6 87 2d 18 11 80 fa 	movb   $0xfa,-0x7feee7d3(%edi)
80105ec4:	0f b6 9f 2e 18 11 80 	movzbl -0x7feee7d2(%edi),%ebx
80105ecb:	83 cb 0f             	or     $0xf,%ebx
80105ece:	88 9f 2e 18 11 80    	mov    %bl,-0x7feee7d2(%edi)
80105ed4:	89 de                	mov    %ebx,%esi
80105ed6:	83 e6 ef             	and    $0xffffffef,%esi
80105ed9:	89 f2                	mov    %esi,%edx
80105edb:	88 97 2e 18 11 80    	mov    %dl,-0x7feee7d2(%edi)
80105ee1:	83 e3 cf             	and    $0xffffffcf,%ebx
80105ee4:	88 9f 2e 18 11 80    	mov    %bl,-0x7feee7d2(%edi)
80105eea:	89 de                	mov    %ebx,%esi
80105eec:	83 ce 40             	or     $0x40,%esi
80105eef:	89 f2                	mov    %esi,%edx
80105ef1:	88 97 2e 18 11 80    	mov    %dl,-0x7feee7d2(%edi)
80105ef7:	83 cb c0             	or     $0xffffffc0,%ebx
80105efa:	88 9f 2e 18 11 80    	mov    %bl,-0x7feee7d2(%edi)
80105f00:	c6 87 2f 18 11 80 00 	movb   $0x0,-0x7feee7d1(%edi)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80105f07:	66 c7 87 30 18 11 80 	movw   $0xffff,-0x7feee7d0(%edi)
80105f0e:	ff ff 
80105f10:	66 c7 87 32 18 11 80 	movw   $0x0,-0x7feee7ce(%edi)
80105f17:	00 00 
80105f19:	c6 87 34 18 11 80 00 	movb   $0x0,-0x7feee7cc(%edi)
80105f20:	0f b6 9f 35 18 11 80 	movzbl -0x7feee7cb(%edi),%ebx
80105f27:	83 e3 f0             	and    $0xfffffff0,%ebx
80105f2a:	89 de                	mov    %ebx,%esi
80105f2c:	83 ce 02             	or     $0x2,%esi
80105f2f:	89 f2                	mov    %esi,%edx
80105f31:	88 97 35 18 11 80    	mov    %dl,-0x7feee7cb(%edi)
80105f37:	89 de                	mov    %ebx,%esi
80105f39:	83 ce 12             	or     $0x12,%esi
80105f3c:	89 f2                	mov    %esi,%edx
80105f3e:	88 97 35 18 11 80    	mov    %dl,-0x7feee7cb(%edi)
80105f44:	83 cb 72             	or     $0x72,%ebx
80105f47:	88 9f 35 18 11 80    	mov    %bl,-0x7feee7cb(%edi)
80105f4d:	c6 87 35 18 11 80 f2 	movb   $0xf2,-0x7feee7cb(%edi)
80105f54:	0f b6 9f 36 18 11 80 	movzbl -0x7feee7ca(%edi),%ebx
80105f5b:	83 cb 0f             	or     $0xf,%ebx
80105f5e:	88 9f 36 18 11 80    	mov    %bl,-0x7feee7ca(%edi)
80105f64:	89 de                	mov    %ebx,%esi
80105f66:	83 e6 ef             	and    $0xffffffef,%esi
80105f69:	89 f2                	mov    %esi,%edx
80105f6b:	88 97 36 18 11 80    	mov    %dl,-0x7feee7ca(%edi)
80105f71:	83 e3 cf             	and    $0xffffffcf,%ebx
80105f74:	88 9f 36 18 11 80    	mov    %bl,-0x7feee7ca(%edi)
80105f7a:	89 de                	mov    %ebx,%esi
80105f7c:	83 ce 40             	or     $0x40,%esi
80105f7f:	89 f2                	mov    %esi,%edx
80105f81:	88 97 36 18 11 80    	mov    %dl,-0x7feee7ca(%edi)
80105f87:	83 cb c0             	or     $0xffffffc0,%ebx
80105f8a:	88 9f 36 18 11 80    	mov    %bl,-0x7feee7ca(%edi)
80105f90:	c6 87 37 18 11 80 00 	movb   $0x0,-0x7feee7c9(%edi)
  lgdt(c->gdt, sizeof(c->gdt));
80105f97:	8d 97 10 18 11 80    	lea    -0x7feee7f0(%edi),%edx
  pd[0] = size-1;
80105f9d:	66 c7 45 e2 2f 00    	movw   $0x2f,-0x1e(%ebp)
  pd[1] = (uint)p;
80105fa3:	66 89 55 e4          	mov    %dx,-0x1c(%ebp)
  pd[2] = (uint)p >> 16;
80105fa7:	c1 ea 10             	shr    $0x10,%edx
80105faa:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80105fae:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105fb1:	0f 01 10             	lgdtl  (%eax)
}
80105fb4:	83 c4 1c             	add    $0x1c,%esp
80105fb7:	5b                   	pop    %ebx
80105fb8:	5e                   	pop    %esi
80105fb9:	5f                   	pop    %edi
80105fba:	5d                   	pop    %ebp
80105fbb:	c3                   	ret    

80105fbc <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80105fbc:	a1 c4 44 11 80       	mov    0x801144c4,%eax
80105fc1:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80105fc6:	0f 22 d8             	mov    %eax,%cr3
}
80105fc9:	c3                   	ret    

80105fca <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80105fca:	55                   	push   %ebp
80105fcb:	89 e5                	mov    %esp,%ebp
80105fcd:	57                   	push   %edi
80105fce:	56                   	push   %esi
80105fcf:	53                   	push   %ebx
80105fd0:	83 ec 1c             	sub    $0x1c,%esp
80105fd3:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80105fd6:	85 f6                	test   %esi,%esi
80105fd8:	0f 84 25 01 00 00    	je     80106103 <switchuvm+0x139>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80105fde:	83 7e 08 00          	cmpl   $0x0,0x8(%esi)
80105fe2:	0f 84 28 01 00 00    	je     80106110 <switchuvm+0x146>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80105fe8:	83 7e 04 00          	cmpl   $0x0,0x4(%esi)
80105fec:	0f 84 2b 01 00 00    	je     8010611d <switchuvm+0x153>
    panic("switchuvm: no pgdir");

  pushcli();
80105ff2:	e8 80 da ff ff       	call   80103a77 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80105ff7:	e8 42 d1 ff ff       	call   8010313e <mycpu>
80105ffc:	89 c3                	mov    %eax,%ebx
80105ffe:	e8 3b d1 ff ff       	call   8010313e <mycpu>
80106003:	8d 78 08             	lea    0x8(%eax),%edi
80106006:	e8 33 d1 ff ff       	call   8010313e <mycpu>
8010600b:	83 c0 08             	add    $0x8,%eax
8010600e:	c1 e8 10             	shr    $0x10,%eax
80106011:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106014:	e8 25 d1 ff ff       	call   8010313e <mycpu>
80106019:	83 c0 08             	add    $0x8,%eax
8010601c:	c1 e8 18             	shr    $0x18,%eax
8010601f:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80106026:	67 00 
80106028:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010602f:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
80106033:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106039:	0f b6 93 9d 00 00 00 	movzbl 0x9d(%ebx),%edx
80106040:	83 e2 f0             	and    $0xfffffff0,%edx
80106043:	89 d1                	mov    %edx,%ecx
80106045:	83 c9 09             	or     $0x9,%ecx
80106048:	88 8b 9d 00 00 00    	mov    %cl,0x9d(%ebx)
8010604e:	83 ca 19             	or     $0x19,%edx
80106051:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80106057:	83 e2 9f             	and    $0xffffff9f,%edx
8010605a:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80106060:	83 ca 80             	or     $0xffffff80,%edx
80106063:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80106069:	0f b6 93 9e 00 00 00 	movzbl 0x9e(%ebx),%edx
80106070:	89 d1                	mov    %edx,%ecx
80106072:	83 e1 f0             	and    $0xfffffff0,%ecx
80106075:	88 8b 9e 00 00 00    	mov    %cl,0x9e(%ebx)
8010607b:	89 d1                	mov    %edx,%ecx
8010607d:	83 e1 e0             	and    $0xffffffe0,%ecx
80106080:	88 8b 9e 00 00 00    	mov    %cl,0x9e(%ebx)
80106086:	83 e2 c0             	and    $0xffffffc0,%edx
80106089:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
8010608f:	83 ca 40             	or     $0x40,%edx
80106092:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80106098:	83 e2 7f             	and    $0x7f,%edx
8010609b:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
801060a1:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801060a7:	e8 92 d0 ff ff       	call   8010313e <mycpu>
801060ac:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801060b3:	83 e2 ef             	and    $0xffffffef,%edx
801060b6:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801060bc:	e8 7d d0 ff ff       	call   8010313e <mycpu>
801060c1:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801060c7:	8b 5e 08             	mov    0x8(%esi),%ebx
801060ca:	e8 6f d0 ff ff       	call   8010313e <mycpu>
801060cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801060d5:	89 58 0c             	mov    %ebx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801060d8:	e8 61 d0 ff ff       	call   8010313e <mycpu>
801060dd:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801060e3:	b8 28 00 00 00       	mov    $0x28,%eax
801060e8:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801060eb:	8b 46 04             	mov    0x4(%esi),%eax
801060ee:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801060f3:	0f 22 d8             	mov    %eax,%cr3
  popcli();
801060f6:	e8 b8 d9 ff ff       	call   80103ab3 <popcli>
}
801060fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060fe:	5b                   	pop    %ebx
801060ff:	5e                   	pop    %esi
80106100:	5f                   	pop    %edi
80106101:	5d                   	pop    %ebp
80106102:	c3                   	ret    
    panic("switchuvm: no process");
80106103:	83 ec 0c             	sub    $0xc,%esp
80106106:	68 42 72 10 80       	push   $0x80107242
8010610b:	e8 38 a2 ff ff       	call   80100348 <panic>
    panic("switchuvm: no kstack");
80106110:	83 ec 0c             	sub    $0xc,%esp
80106113:	68 58 72 10 80       	push   $0x80107258
80106118:	e8 2b a2 ff ff       	call   80100348 <panic>
    panic("switchuvm: no pgdir");
8010611d:	83 ec 0c             	sub    $0xc,%esp
80106120:	68 6d 72 10 80       	push   $0x8010726d
80106125:	e8 1e a2 ff ff       	call   80100348 <panic>

8010612a <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010612a:	55                   	push   %ebp
8010612b:	89 e5                	mov    %esp,%ebp
8010612d:	56                   	push   %esi
8010612e:	53                   	push   %ebx
8010612f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80106132:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106138:	77 4c                	ja     80106186 <inituvm+0x5c>
    panic("inituvm: more than a page");
  mem = kalloc();
8010613a:	e8 64 bf ff ff       	call   801020a3 <kalloc>
8010613f:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106141:	83 ec 04             	sub    $0x4,%esp
80106144:	68 00 10 00 00       	push   $0x1000
80106149:	6a 00                	push   $0x0
8010614b:	50                   	push   %eax
8010614c:	e8 ad da ff ff       	call   80103bfe <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106151:	83 c4 08             	add    $0x8,%esp
80106154:	6a 06                	push   $0x6
80106156:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010615c:	50                   	push   %eax
8010615d:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106162:	ba 00 00 00 00       	mov    $0x0,%edx
80106167:	8b 45 08             	mov    0x8(%ebp),%eax
8010616a:	e8 5f fb ff ff       	call   80105cce <mappages>
  memmove(mem, init, sz);
8010616f:	83 c4 0c             	add    $0xc,%esp
80106172:	56                   	push   %esi
80106173:	ff 75 0c             	push   0xc(%ebp)
80106176:	53                   	push   %ebx
80106177:	e8 fa da ff ff       	call   80103c76 <memmove>
}
8010617c:	83 c4 10             	add    $0x10,%esp
8010617f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106182:	5b                   	pop    %ebx
80106183:	5e                   	pop    %esi
80106184:	5d                   	pop    %ebp
80106185:	c3                   	ret    
    panic("inituvm: more than a page");
80106186:	83 ec 0c             	sub    $0xc,%esp
80106189:	68 81 72 10 80       	push   $0x80107281
8010618e:	e8 b5 a1 ff ff       	call   80100348 <panic>

80106193 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106193:	55                   	push   %ebp
80106194:	89 e5                	mov    %esp,%ebp
80106196:	57                   	push   %edi
80106197:	56                   	push   %esi
80106198:	53                   	push   %ebx
80106199:	83 ec 0c             	sub    $0xc,%esp
8010619c:	8b 7d 18             	mov    0x18(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010619f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801061a2:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801061a8:	74 3c                	je     801061e6 <loaduvm+0x53>
    panic("loaduvm: addr must be page aligned");
801061aa:	83 ec 0c             	sub    $0xc,%esp
801061ad:	68 3c 73 10 80       	push   $0x8010733c
801061b2:	e8 91 a1 ff ff       	call   80100348 <panic>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801061b7:	83 ec 0c             	sub    $0xc,%esp
801061ba:	68 9b 72 10 80       	push   $0x8010729b
801061bf:	e8 84 a1 ff ff       	call   80100348 <panic>
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801061c4:	05 00 00 00 80       	add    $0x80000000,%eax
801061c9:	56                   	push   %esi
801061ca:	89 da                	mov    %ebx,%edx
801061cc:	03 55 14             	add    0x14(%ebp),%edx
801061cf:	52                   	push   %edx
801061d0:	50                   	push   %eax
801061d1:	ff 75 10             	push   0x10(%ebp)
801061d4:	e8 88 b5 ff ff       	call   80101761 <readi>
801061d9:	83 c4 10             	add    $0x10,%esp
801061dc:	39 f0                	cmp    %esi,%eax
801061de:	75 47                	jne    80106227 <loaduvm+0x94>
  for(i = 0; i < sz; i += PGSIZE){
801061e0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801061e6:	39 fb                	cmp    %edi,%ebx
801061e8:	73 30                	jae    8010621a <loaduvm+0x87>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801061ea:	89 da                	mov    %ebx,%edx
801061ec:	03 55 0c             	add    0xc(%ebp),%edx
801061ef:	b9 00 00 00 00       	mov    $0x0,%ecx
801061f4:	8b 45 08             	mov    0x8(%ebp),%eax
801061f7:	e8 61 fa ff ff       	call   80105c5d <walkpgdir>
801061fc:	85 c0                	test   %eax,%eax
801061fe:	74 b7                	je     801061b7 <loaduvm+0x24>
    pa = PTE_ADDR(*pte);
80106200:	8b 00                	mov    (%eax),%eax
80106202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106207:	89 fe                	mov    %edi,%esi
80106209:	29 de                	sub    %ebx,%esi
8010620b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106211:	76 b1                	jbe    801061c4 <loaduvm+0x31>
      n = PGSIZE;
80106213:	be 00 10 00 00       	mov    $0x1000,%esi
80106218:	eb aa                	jmp    801061c4 <loaduvm+0x31>
      return -1;
  }
  return 0;
8010621a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010621f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106222:	5b                   	pop    %ebx
80106223:	5e                   	pop    %esi
80106224:	5f                   	pop    %edi
80106225:	5d                   	pop    %ebp
80106226:	c3                   	ret    
      return -1;
80106227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010622c:	eb f1                	jmp    8010621f <loaduvm+0x8c>

8010622e <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010622e:	55                   	push   %ebp
8010622f:	89 e5                	mov    %esp,%ebp
80106231:	57                   	push   %edi
80106232:	56                   	push   %esi
80106233:	53                   	push   %ebx
80106234:	83 ec 0c             	sub    $0xc,%esp
80106237:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010623a:	39 7d 10             	cmp    %edi,0x10(%ebp)
8010623d:	73 11                	jae    80106250 <deallocuvm+0x22>
    return oldsz;

  a = PGROUNDUP(newsz);
8010623f:	8b 45 10             	mov    0x10(%ebp),%eax
80106242:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106248:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010624e:	eb 19                	jmp    80106269 <deallocuvm+0x3b>
    return oldsz;
80106250:	89 f8                	mov    %edi,%eax
80106252:	eb 67                	jmp    801062bb <deallocuvm+0x8d>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106254:	c1 eb 16             	shr    $0x16,%ebx
80106257:	83 c3 01             	add    $0x1,%ebx
8010625a:	c1 e3 16             	shl    $0x16,%ebx
8010625d:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106263:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106269:	39 fb                	cmp    %edi,%ebx
8010626b:	73 4b                	jae    801062b8 <deallocuvm+0x8a>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010626d:	b9 00 00 00 00       	mov    $0x0,%ecx
80106272:	89 da                	mov    %ebx,%edx
80106274:	8b 45 08             	mov    0x8(%ebp),%eax
80106277:	e8 e1 f9 ff ff       	call   80105c5d <walkpgdir>
8010627c:	89 c6                	mov    %eax,%esi
    if(!pte)
8010627e:	85 c0                	test   %eax,%eax
80106280:	74 d2                	je     80106254 <deallocuvm+0x26>
    else if((*pte & (PTE_P | PTE_E)) != 0){
80106282:	8b 00                	mov    (%eax),%eax
80106284:	a9 01 01 00 00       	test   $0x101,%eax
80106289:	74 d8                	je     80106263 <deallocuvm+0x35>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010628b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106290:	74 19                	je     801062ab <deallocuvm+0x7d>
        panic("kfree");
      char *v = P2V(pa);
80106292:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106297:	83 ec 0c             	sub    $0xc,%esp
8010629a:	50                   	push   %eax
8010629b:	e8 ec bc ff ff       	call   80101f8c <kfree>
      *pte = 0;
801062a0:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801062a6:	83 c4 10             	add    $0x10,%esp
801062a9:	eb b8                	jmp    80106263 <deallocuvm+0x35>
        panic("kfree");
801062ab:	83 ec 0c             	sub    $0xc,%esp
801062ae:	68 a6 6b 10 80       	push   $0x80106ba6
801062b3:	e8 90 a0 ff ff       	call   80100348 <panic>
    }
  }
  return newsz;
801062b8:	8b 45 10             	mov    0x10(%ebp),%eax
}
801062bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062be:	5b                   	pop    %ebx
801062bf:	5e                   	pop    %esi
801062c0:	5f                   	pop    %edi
801062c1:	5d                   	pop    %ebp
801062c2:	c3                   	ret    

801062c3 <allocuvm>:
{
801062c3:	55                   	push   %ebp
801062c4:	89 e5                	mov    %esp,%ebp
801062c6:	57                   	push   %edi
801062c7:	56                   	push   %esi
801062c8:	53                   	push   %ebx
801062c9:	83 ec 1c             	sub    $0x1c,%esp
801062cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
801062cf:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801062d2:	85 ff                	test   %edi,%edi
801062d4:	0f 88 c1 00 00 00    	js     8010639b <allocuvm+0xd8>
  if(newsz < oldsz)
801062da:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801062dd:	72 5c                	jb     8010633b <allocuvm+0x78>
  a = PGROUNDUP(oldsz);
801062df:	8b 45 0c             	mov    0xc(%ebp),%eax
801062e2:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801062e8:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801062ee:	39 fe                	cmp    %edi,%esi
801062f0:	0f 83 ac 00 00 00    	jae    801063a2 <allocuvm+0xdf>
    mem = kalloc();
801062f6:	e8 a8 bd ff ff       	call   801020a3 <kalloc>
801062fb:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801062fd:	85 c0                	test   %eax,%eax
801062ff:	74 42                	je     80106343 <allocuvm+0x80>
    memset(mem, 0, PGSIZE);
80106301:	83 ec 04             	sub    $0x4,%esp
80106304:	68 00 10 00 00       	push   $0x1000
80106309:	6a 00                	push   $0x0
8010630b:	50                   	push   %eax
8010630c:	e8 ed d8 ff ff       	call   80103bfe <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106311:	83 c4 08             	add    $0x8,%esp
80106314:	6a 06                	push   $0x6
80106316:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010631c:	50                   	push   %eax
8010631d:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106322:	89 f2                	mov    %esi,%edx
80106324:	8b 45 08             	mov    0x8(%ebp),%eax
80106327:	e8 a2 f9 ff ff       	call   80105cce <mappages>
8010632c:	83 c4 10             	add    $0x10,%esp
8010632f:	85 c0                	test   %eax,%eax
80106331:	78 38                	js     8010636b <allocuvm+0xa8>
  for(; a < newsz; a += PGSIZE){
80106333:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106339:	eb b3                	jmp    801062ee <allocuvm+0x2b>
    return oldsz;
8010633b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010633e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106341:	eb 5f                	jmp    801063a2 <allocuvm+0xdf>
      cprintf("allocuvm out of memory\n");
80106343:	83 ec 0c             	sub    $0xc,%esp
80106346:	68 b9 72 10 80       	push   $0x801072b9
8010634b:	e8 b7 a2 ff ff       	call   80100607 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106350:	83 c4 0c             	add    $0xc,%esp
80106353:	ff 75 0c             	push   0xc(%ebp)
80106356:	57                   	push   %edi
80106357:	ff 75 08             	push   0x8(%ebp)
8010635a:	e8 cf fe ff ff       	call   8010622e <deallocuvm>
      return 0;
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106369:	eb 37                	jmp    801063a2 <allocuvm+0xdf>
      cprintf("allocuvm out of memory (2)\n");
8010636b:	83 ec 0c             	sub    $0xc,%esp
8010636e:	68 d1 72 10 80       	push   $0x801072d1
80106373:	e8 8f a2 ff ff       	call   80100607 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106378:	83 c4 0c             	add    $0xc,%esp
8010637b:	ff 75 0c             	push   0xc(%ebp)
8010637e:	57                   	push   %edi
8010637f:	ff 75 08             	push   0x8(%ebp)
80106382:	e8 a7 fe ff ff       	call   8010622e <deallocuvm>
      kfree(mem);
80106387:	89 1c 24             	mov    %ebx,(%esp)
8010638a:	e8 fd bb ff ff       	call   80101f8c <kfree>
      return 0;
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106399:	eb 07                	jmp    801063a2 <allocuvm+0xdf>
    return 0;
8010639b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801063a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063a8:	5b                   	pop    %ebx
801063a9:	5e                   	pop    %esi
801063aa:	5f                   	pop    %edi
801063ab:	5d                   	pop    %ebp
801063ac:	c3                   	ret    

801063ad <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801063ad:	55                   	push   %ebp
801063ae:	89 e5                	mov    %esp,%ebp
801063b0:	56                   	push   %esi
801063b1:	53                   	push   %ebx
801063b2:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801063b5:	85 f6                	test   %esi,%esi
801063b7:	74 1a                	je     801063d3 <freevm+0x26>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
801063b9:	83 ec 04             	sub    $0x4,%esp
801063bc:	6a 00                	push   $0x0
801063be:	68 00 00 00 80       	push   $0x80000000
801063c3:	56                   	push   %esi
801063c4:	e8 65 fe ff ff       	call   8010622e <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
801063c9:	83 c4 10             	add    $0x10,%esp
801063cc:	bb 00 00 00 00       	mov    $0x0,%ebx
801063d1:	eb 10                	jmp    801063e3 <freevm+0x36>
    panic("freevm: no pgdir");
801063d3:	83 ec 0c             	sub    $0xc,%esp
801063d6:	68 ed 72 10 80       	push   $0x801072ed
801063db:	e8 68 9f ff ff       	call   80100348 <panic>
  for(i = 0; i < NPDENTRIES; i++){
801063e0:	83 c3 01             	add    $0x1,%ebx
801063e3:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
801063e9:	77 22                	ja     8010640d <freevm+0x60>
    if(pgdir[i] & (PTE_P | PTE_E)){
801063eb:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
801063ee:	a9 01 01 00 00       	test   $0x101,%eax
801063f3:	74 eb                	je     801063e0 <freevm+0x33>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801063f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801063fa:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801063ff:	83 ec 0c             	sub    $0xc,%esp
80106402:	50                   	push   %eax
80106403:	e8 84 bb ff ff       	call   80101f8c <kfree>
80106408:	83 c4 10             	add    $0x10,%esp
8010640b:	eb d3                	jmp    801063e0 <freevm+0x33>
    }
  }
  kfree((char*)pgdir);
8010640d:	83 ec 0c             	sub    $0xc,%esp
80106410:	56                   	push   %esi
80106411:	e8 76 bb ff ff       	call   80101f8c <kfree>
}
80106416:	83 c4 10             	add    $0x10,%esp
80106419:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010641c:	5b                   	pop    %ebx
8010641d:	5e                   	pop    %esi
8010641e:	5d                   	pop    %ebp
8010641f:	c3                   	ret    

80106420 <setupkvm>:
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	56                   	push   %esi
80106424:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106425:	e8 79 bc ff ff       	call   801020a3 <kalloc>
8010642a:	89 c6                	mov    %eax,%esi
8010642c:	85 c0                	test   %eax,%eax
8010642e:	74 55                	je     80106485 <setupkvm+0x65>
  memset(pgdir, 0, PGSIZE);
80106430:	83 ec 04             	sub    $0x4,%esp
80106433:	68 00 10 00 00       	push   $0x1000
80106438:	6a 00                	push   $0x0
8010643a:	50                   	push   %eax
8010643b:	e8 be d7 ff ff       	call   80103bfe <memset>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106440:	83 c4 10             	add    $0x10,%esp
80106443:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
80106448:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
8010644e:	73 35                	jae    80106485 <setupkvm+0x65>
                (uint)k->phys_start, k->perm) < 0) {
80106450:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106453:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106456:	29 c1                	sub    %eax,%ecx
80106458:	83 ec 08             	sub    $0x8,%esp
8010645b:	ff 73 0c             	push   0xc(%ebx)
8010645e:	50                   	push   %eax
8010645f:	8b 13                	mov    (%ebx),%edx
80106461:	89 f0                	mov    %esi,%eax
80106463:	e8 66 f8 ff ff       	call   80105cce <mappages>
80106468:	83 c4 10             	add    $0x10,%esp
8010646b:	85 c0                	test   %eax,%eax
8010646d:	78 05                	js     80106474 <setupkvm+0x54>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010646f:	83 c3 10             	add    $0x10,%ebx
80106472:	eb d4                	jmp    80106448 <setupkvm+0x28>
      freevm(pgdir);
80106474:	83 ec 0c             	sub    $0xc,%esp
80106477:	56                   	push   %esi
80106478:	e8 30 ff ff ff       	call   801063ad <freevm>
      return 0;
8010647d:	83 c4 10             	add    $0x10,%esp
80106480:	be 00 00 00 00       	mov    $0x0,%esi
}
80106485:	89 f0                	mov    %esi,%eax
80106487:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010648a:	5b                   	pop    %ebx
8010648b:	5e                   	pop    %esi
8010648c:	5d                   	pop    %ebp
8010648d:	c3                   	ret    

8010648e <kvmalloc>:
{
8010648e:	55                   	push   %ebp
8010648f:	89 e5                	mov    %esp,%ebp
80106491:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106494:	e8 87 ff ff ff       	call   80106420 <setupkvm>
80106499:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  switchkvm();
8010649e:	e8 19 fb ff ff       	call   80105fbc <switchkvm>
}
801064a3:	c9                   	leave  
801064a4:	c3                   	ret    

801064a5 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801064a5:	55                   	push   %ebp
801064a6:	89 e5                	mov    %esp,%ebp
801064a8:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801064ab:	b9 00 00 00 00       	mov    $0x0,%ecx
801064b0:	8b 55 0c             	mov    0xc(%ebp),%edx
801064b3:	8b 45 08             	mov    0x8(%ebp),%eax
801064b6:	e8 a2 f7 ff ff       	call   80105c5d <walkpgdir>
  if(pte == 0)
801064bb:	85 c0                	test   %eax,%eax
801064bd:	74 05                	je     801064c4 <clearpteu+0x1f>
    panic("clearpteu");
  *pte &= ~PTE_U;
801064bf:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801064c2:	c9                   	leave  
801064c3:	c3                   	ret    
    panic("clearpteu");
801064c4:	83 ec 0c             	sub    $0xc,%esp
801064c7:	68 fe 72 10 80       	push   $0x801072fe
801064cc:	e8 77 9e ff ff       	call   80100348 <panic>

801064d1 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801064d1:	55                   	push   %ebp
801064d2:	89 e5                	mov    %esp,%ebp
801064d4:	57                   	push   %edi
801064d5:	56                   	push   %esi
801064d6:	53                   	push   %ebx
801064d7:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801064da:	e8 41 ff ff ff       	call   80106420 <setupkvm>
801064df:	89 45 dc             	mov    %eax,-0x24(%ebp)
801064e2:	85 c0                	test   %eax,%eax
801064e4:	0f 84 c7 00 00 00    	je     801065b1 <copyuvm+0xe0>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801064ea:	bf 00 00 00 00       	mov    $0x0,%edi
801064ef:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801064f2:	0f 83 b9 00 00 00    	jae    801065b1 <copyuvm+0xe0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801064f8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801064fb:	b9 00 00 00 00       	mov    $0x0,%ecx
80106500:	89 fa                	mov    %edi,%edx
80106502:	8b 45 08             	mov    0x8(%ebp),%eax
80106505:	e8 53 f7 ff ff       	call   80105c5d <walkpgdir>
8010650a:	85 c0                	test   %eax,%eax
8010650c:	74 68                	je     80106576 <copyuvm+0xa5>
      panic("copyuvm: pte should exist");
    if(!(*pte & (PTE_P | PTE_E)))
8010650e:	8b 00                	mov    (%eax),%eax
80106510:	a9 01 01 00 00       	test   $0x101,%eax
80106515:	74 6c                	je     80106583 <copyuvm+0xb2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106517:	89 c6                	mov    %eax,%esi
80106519:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    flags = PTE_FLAGS(*pte);
8010651f:	25 ff 0f 00 00       	and    $0xfff,%eax
80106524:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if((mem = kalloc()) == 0)
80106527:	e8 77 bb ff ff       	call   801020a3 <kalloc>
8010652c:	89 c3                	mov    %eax,%ebx
8010652e:	85 c0                	test   %eax,%eax
80106530:	74 6a                	je     8010659c <copyuvm+0xcb>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106532:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106538:	83 ec 04             	sub    $0x4,%esp
8010653b:	68 00 10 00 00       	push   $0x1000
80106540:	56                   	push   %esi
80106541:	50                   	push   %eax
80106542:	e8 2f d7 ff ff       	call   80103c76 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106547:	83 c4 08             	add    $0x8,%esp
8010654a:	ff 75 e0             	push   -0x20(%ebp)
8010654d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106553:	50                   	push   %eax
80106554:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106559:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010655c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010655f:	e8 6a f7 ff ff       	call   80105cce <mappages>
80106564:	83 c4 10             	add    $0x10,%esp
80106567:	85 c0                	test   %eax,%eax
80106569:	78 25                	js     80106590 <copyuvm+0xbf>
  for(i = 0; i < sz; i += PGSIZE){
8010656b:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106571:	e9 79 ff ff ff       	jmp    801064ef <copyuvm+0x1e>
      panic("copyuvm: pte should exist");
80106576:	83 ec 0c             	sub    $0xc,%esp
80106579:	68 08 73 10 80       	push   $0x80107308
8010657e:	e8 c5 9d ff ff       	call   80100348 <panic>
      panic("copyuvm: page not present");
80106583:	83 ec 0c             	sub    $0xc,%esp
80106586:	68 22 73 10 80       	push   $0x80107322
8010658b:	e8 b8 9d ff ff       	call   80100348 <panic>
      kfree(mem);
80106590:	83 ec 0c             	sub    $0xc,%esp
80106593:	53                   	push   %ebx
80106594:	e8 f3 b9 ff ff       	call   80101f8c <kfree>
      goto bad;
80106599:	83 c4 10             	add    $0x10,%esp
    }
  }
  return d;

bad:
  freevm(d);
8010659c:	83 ec 0c             	sub    $0xc,%esp
8010659f:	ff 75 dc             	push   -0x24(%ebp)
801065a2:	e8 06 fe ff ff       	call   801063ad <freevm>
  return 0;
801065a7:	83 c4 10             	add    $0x10,%esp
801065aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
}
801065b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801065b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065b7:	5b                   	pop    %ebx
801065b8:	5e                   	pop    %esi
801065b9:	5f                   	pop    %edi
801065ba:	5d                   	pop    %ebp
801065bb:	c3                   	ret    

801065bc <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801065bc:	55                   	push   %ebp
801065bd:	89 e5                	mov    %esp,%ebp
801065bf:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801065c2:	b9 00 00 00 00       	mov    $0x0,%ecx
801065c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801065ca:	8b 45 08             	mov    0x8(%ebp),%eax
801065cd:	e8 8b f6 ff ff       	call   80105c5d <walkpgdir>
  if((*pte & (PTE_P | PTE_E)) == 0) // not present or encrypted
801065d2:	8b 00                	mov    (%eax),%eax
801065d4:	a9 01 01 00 00       	test   $0x101,%eax
801065d9:	74 10                	je     801065eb <uva2ka+0x2f>
    return 0;
  if((*pte & PTE_U) == 0)
801065db:	a8 04                	test   $0x4,%al
801065dd:	74 13                	je     801065f2 <uva2ka+0x36>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801065df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801065e4:	05 00 00 00 80       	add    $0x80000000,%eax
}
801065e9:	c9                   	leave  
801065ea:	c3                   	ret    
    return 0;
801065eb:	b8 00 00 00 00       	mov    $0x0,%eax
801065f0:	eb f7                	jmp    801065e9 <uva2ka+0x2d>
    return 0;
801065f2:	b8 00 00 00 00       	mov    $0x0,%eax
801065f7:	eb f0                	jmp    801065e9 <uva2ka+0x2d>

801065f9 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801065f9:	55                   	push   %ebp
801065fa:	89 e5                	mov    %esp,%ebp
801065fc:	57                   	push   %edi
801065fd:	56                   	push   %esi
801065fe:	53                   	push   %ebx
801065ff:	83 ec 0c             	sub    $0xc,%esp
80106602:	8b 7d 14             	mov    0x14(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106605:	eb 25                	jmp    8010662c <copyout+0x33>
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106607:	8b 55 0c             	mov    0xc(%ebp),%edx
8010660a:	29 f2                	sub    %esi,%edx
8010660c:	01 d0                	add    %edx,%eax
8010660e:	83 ec 04             	sub    $0x4,%esp
80106611:	53                   	push   %ebx
80106612:	ff 75 10             	push   0x10(%ebp)
80106615:	50                   	push   %eax
80106616:	e8 5b d6 ff ff       	call   80103c76 <memmove>
    len -= n;
8010661b:	29 df                	sub    %ebx,%edi
    buf += n;
8010661d:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80106620:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
80106626:	89 45 0c             	mov    %eax,0xc(%ebp)
80106629:	83 c4 10             	add    $0x10,%esp
  while(len > 0){
8010662c:	85 ff                	test   %edi,%edi
8010662e:	74 2f                	je     8010665f <copyout+0x66>
    va0 = (uint)PGROUNDDOWN(va);
80106630:	8b 75 0c             	mov    0xc(%ebp),%esi
80106633:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106639:	83 ec 08             	sub    $0x8,%esp
8010663c:	56                   	push   %esi
8010663d:	ff 75 08             	push   0x8(%ebp)
80106640:	e8 77 ff ff ff       	call   801065bc <uva2ka>
    if(pa0 == 0)
80106645:	83 c4 10             	add    $0x10,%esp
80106648:	85 c0                	test   %eax,%eax
8010664a:	74 20                	je     8010666c <copyout+0x73>
    n = PGSIZE - (va - va0);
8010664c:	89 f3                	mov    %esi,%ebx
8010664e:	2b 5d 0c             	sub    0xc(%ebp),%ebx
80106651:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80106657:	39 df                	cmp    %ebx,%edi
80106659:	73 ac                	jae    80106607 <copyout+0xe>
      n = len;
8010665b:	89 fb                	mov    %edi,%ebx
8010665d:	eb a8                	jmp    80106607 <copyout+0xe>
  }
  return 0;
8010665f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106664:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106667:	5b                   	pop    %ebx
80106668:	5e                   	pop    %esi
80106669:	5f                   	pop    %edi
8010666a:	5d                   	pop    %ebp
8010666b:	c3                   	ret    
      return -1;
8010666c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106671:	eb f1                	jmp    80106664 <copyout+0x6b>

80106673 <mencrypt>:

// encrypt [PGROUNDDOWN(virtual_addr), PGROUNDDOWN(virtual_addr) + len * PGSIZE)
int          
mencrypt(char *virtual_addr, int len)
{
80106673:	55                   	push   %ebp
80106674:	89 e5                	mov    %esp,%ebp
80106676:	57                   	push   %edi
80106677:	56                   	push   %esi
80106678:	53                   	push   %ebx
80106679:	83 ec 1c             	sub    $0x1c,%esp
8010667c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(len == 0)
8010667f:	85 ff                	test   %edi,%edi
80106681:	0f 84 c8 00 00 00    	je     8010674f <mencrypt+0xdc>
    return 0;
  
  if (len < 0)
80106687:	0f 88 cc 00 00 00    	js     80106759 <mencrypt+0xe6>
    return -1;

  pte_t *pte;
  pde_t *pgdir = myproc()->pgdir; 
8010668d:	e8 23 cb ff ff       	call   801031b5 <myproc>
80106692:	8b 40 04             	mov    0x4(%eax),%eax
80106695:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  virtual_addr = (char *)PGROUNDDOWN((uint)virtual_addr);
80106698:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010669b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801066a1:	89 5d e0             	mov    %ebx,-0x20(%ebp)
  char *page_slider = virtual_addr;

  // check all pages requested are valid
  for(int i = 0; i < len; i++){
801066a4:	be 00 00 00 00       	mov    $0x0,%esi
801066a9:	eb 09                	jmp    801066b4 <mencrypt+0x41>
    if(uva2ka(pgdir, page_slider) == 0) // check if valid virtual address 
      return -1;
    page_slider += PGSIZE;
801066ab:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(int i = 0; i < len; i++){
801066b1:	83 c6 01             	add    $0x1,%esi
801066b4:	39 fe                	cmp    %edi,%esi
801066b6:	7d 1a                	jge    801066d2 <mencrypt+0x5f>
    if(uva2ka(pgdir, page_slider) == 0) // check if valid virtual address 
801066b8:	83 ec 08             	sub    $0x8,%esp
801066bb:	53                   	push   %ebx
801066bc:	ff 75 e4             	push   -0x1c(%ebp)
801066bf:	e8 f8 fe ff ff       	call   801065bc <uva2ka>
801066c4:	83 c4 10             	add    $0x10,%esp
801066c7:	85 c0                	test   %eax,%eax
801066c9:	75 e0                	jne    801066ab <mencrypt+0x38>
      return -1;
801066cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066d0:	eb 7f                	jmp    80106751 <mencrypt+0xde>
  }

  // encrypt all pages
  for(int i = 0; i < len; i++){
801066d2:	be 00 00 00 00       	mov    $0x0,%esi
801066d7:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801066da:	89 7d 0c             	mov    %edi,0xc(%ebp)
801066dd:	eb 24                	jmp    80106703 <mencrypt+0x90>
      continue;
    }

    page_slider = (char*)P2V(PTE_ADDR(*pte)); // base address of current page
    for(int offset = 0; offset < PGSIZE; offset++){ // encrypt whole page
      *page_slider = *page_slider ^ 0xFF;
801066df:	0f b6 10             	movzbl (%eax),%edx
801066e2:	f7 d2                	not    %edx
801066e4:	88 10                	mov    %dl,(%eax)
      page_slider++;
801066e6:	83 c0 01             	add    $0x1,%eax
    for(int offset = 0; offset < PGSIZE; offset++){ // encrypt whole page
801066e9:	83 c1 01             	add    $0x1,%ecx
801066ec:	81 f9 ff 0f 00 00    	cmp    $0xfff,%ecx
801066f2:	7e eb                	jle    801066df <mencrypt+0x6c>
    }

    // set it as not present so it causes page fault on access -> traps into decryption
    *pte = *pte | PTE_E;
801066f4:	8b 07                	mov    (%edi),%eax
801066f6:	80 cc 01             	or     $0x1,%ah
801066f9:	89 07                	mov    %eax,(%edi)
    *pte = *pte & (~PTE_P);
801066fb:	83 e0 fe             	and    $0xfffffffe,%eax
801066fe:	89 07                	mov    %eax,(%edi)
  for(int i = 0; i < len; i++){
80106700:	83 c6 01             	add    $0x1,%esi
80106703:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106706:	7d 2f                	jge    80106737 <mencrypt+0xc4>
    pte = walkpgdir(pgdir, virtual_addr, 0); // pte of current page
80106708:	b9 00 00 00 00       	mov    $0x0,%ecx
8010670d:	89 da                	mov    %ebx,%edx
8010670f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106712:	e8 46 f5 ff ff       	call   80105c5d <walkpgdir>
80106717:	89 c7                	mov    %eax,%edi
    virtual_addr += PGSIZE;
80106719:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(*pte & PTE_E){ // already encrypted -> skip
8010671f:	8b 00                	mov    (%eax),%eax
80106721:	f6 c4 01             	test   $0x1,%ah
80106724:	75 da                	jne    80106700 <mencrypt+0x8d>
    page_slider = (char*)P2V(PTE_ADDR(*pte)); // base address of current page
80106726:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010672b:	05 00 00 00 80       	add    $0x80000000,%eax
    for(int offset = 0; offset < PGSIZE; offset++){ // encrypt whole page
80106730:	b9 00 00 00 00       	mov    $0x0,%ecx
80106735:	eb b5                	jmp    801066ec <mencrypt+0x79>
  }

  switchuvm(myproc()); // clear tlb for reasons beyond my comprehension
80106737:	e8 79 ca ff ff       	call   801031b5 <myproc>
8010673c:	83 ec 0c             	sub    $0xc,%esp
8010673f:	50                   	push   %eax
80106740:	e8 85 f8 ff ff       	call   80105fca <switchuvm>
  return 0;
80106745:	83 c4 10             	add    $0x10,%esp
80106748:	b8 00 00 00 00       	mov    $0x0,%eax
8010674d:	eb 02                	jmp    80106751 <mencrypt+0xde>
    return 0;
8010674f:	89 f8                	mov    %edi,%eax
}
80106751:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106754:	5b                   	pop    %ebx
80106755:	5e                   	pop    %esi
80106756:	5f                   	pop    %edi
80106757:	5d                   	pop    %ebp
80106758:	c3                   	ret    
    return -1;
80106759:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010675e:	eb f1                	jmp    80106751 <mencrypt+0xde>

80106760 <mdecrypt>:

// return 0 if page decrypted, -1 otherwise eg if page is not encrypted to begin with, or error
int
mdecrypt(char *virtual_addr){
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	53                   	push   %ebx
80106764:	83 ec 04             	sub    $0x4,%esp
  virtual_addr = (char *)PGROUNDDOWN((uint)virtual_addr);
80106767:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010676a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  /*
  if(uva2ka(myproc()->pgdir, virtual_addr) == 0); // check if valid virtual address 
    return -1;
  */

  pte_t *pte = walkpgdir(myproc()->pgdir, virtual_addr, 0);
80106770:	e8 40 ca ff ff       	call   801031b5 <myproc>
80106775:	8b 40 04             	mov    0x4(%eax),%eax
80106778:	b9 00 00 00 00       	mov    $0x0,%ecx
8010677d:	89 da                	mov    %ebx,%edx
8010677f:	e8 d9 f4 ff ff       	call   80105c5d <walkpgdir>
  if (!pte || *pte == 0) // walk failed
80106784:	85 c0                	test   %eax,%eax
80106786:	74 49                	je     801067d1 <mdecrypt+0x71>
80106788:	89 c3                	mov    %eax,%ebx
8010678a:	8b 00                	mov    (%eax),%eax
8010678c:	85 c0                	test   %eax,%eax
8010678e:	74 48                	je     801067d8 <mdecrypt+0x78>
    return -1;  
  if((*pte & PTE_E) == 0) // not encrypted
80106790:	f6 c4 01             	test   $0x1,%ah
80106793:	74 4a                	je     801067df <mdecrypt+0x7f>
    return -1;
  

  char *page_slider = (char*)P2V(PTE_ADDR(*pte)); // base address of current page
80106795:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010679a:	05 00 00 00 80       	add    $0x80000000,%eax
  for(int offset = 0; offset < PGSIZE; offset++){ // encrypt whole page
8010679f:	b9 00 00 00 00       	mov    $0x0,%ecx
801067a4:	eb 0d                	jmp    801067b3 <mdecrypt+0x53>
    *page_slider = *page_slider ^ 0xFF;
801067a6:	0f b6 10             	movzbl (%eax),%edx
801067a9:	f7 d2                	not    %edx
801067ab:	88 10                	mov    %dl,(%eax)
    page_slider++;
801067ad:	83 c0 01             	add    $0x1,%eax
  for(int offset = 0; offset < PGSIZE; offset++){ // encrypt whole page
801067b0:	83 c1 01             	add    $0x1,%ecx
801067b3:	81 f9 ff 0f 00 00    	cmp    $0xfff,%ecx
801067b9:	7e eb                	jle    801067a6 <mdecrypt+0x46>
  }

  *pte = *pte | PTE_P;
801067bb:	8b 03                	mov    (%ebx),%eax
801067bd:	83 c8 01             	or     $0x1,%eax
801067c0:	89 03                	mov    %eax,(%ebx)
  *pte = *pte & (~PTE_E);
801067c2:	80 e4 fe             	and    $0xfe,%ah
801067c5:	89 03                	mov    %eax,(%ebx)

  return 0;
801067c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801067cf:	c9                   	leave  
801067d0:	c3                   	ret    
    return -1;  
801067d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067d6:	eb f4                	jmp    801067cc <mdecrypt+0x6c>
801067d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067dd:	eb ed                	jmp    801067cc <mdecrypt+0x6c>
    return -1;
801067df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067e4:	eb e6                	jmp    801067cc <mdecrypt+0x6c>

801067e6 <getpgtable>:


int getpgtable(struct pt_entry* entries, int num) {
801067e6:	55                   	push   %ebp
801067e7:	89 e5                	mov    %esp,%ebp
801067e9:	57                   	push   %edi
801067ea:	56                   	push   %esi
801067eb:	53                   	push   %ebx
801067ec:	83 ec 1c             	sub    $0x1c,%esp

  struct proc *p = myproc();
801067ef:	e8 c1 c9 ff ff       	call   801031b5 <myproc>
801067f4:	89 c6                	mov    %eax,%esi

  int count = 0;
  pte_t * pte;

  // go reverse order
  for (char *i = (char*) PGROUNDDOWN((p->sz)); (int)i >= 0 && count < num; i -= PGSIZE) {
801067f6:	8b 18                	mov    (%eax),%ebx
801067f8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  int count = 0;
801067fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  for (char *i = (char*) PGROUNDDOWN((p->sz)); (int)i >= 0 && count < num; i -= PGSIZE) {
80106805:	eb 06                	jmp    8010680d <getpgtable+0x27>
80106807:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
8010680d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106810:	3b 45 0c             	cmp    0xc(%ebp),%eax
80106813:	0f 9c c0             	setl   %al
80106816:	85 db                	test   %ebx,%ebx
80106818:	0f 88 b9 00 00 00    	js     801068d7 <getpgtable+0xf1>
8010681e:	84 c0                	test   %al,%al
80106820:	0f 84 b1 00 00 00    	je     801068d7 <getpgtable+0xf1>
    // iterate through the page table and read the entries
    pte = walkpgdir(p->pgdir, i, 0);
80106826:	8b 46 04             	mov    0x4(%esi),%eax
80106829:	b9 00 00 00 00       	mov    $0x0,%ecx
8010682e:	89 da                	mov    %ebx,%edx
80106830:	e8 28 f4 ff ff       	call   80105c5d <walkpgdir>
    if(!pte || *pte == 0)
80106835:	85 c0                	test   %eax,%eax
80106837:	74 ce                	je     80106807 <getpgtable+0x21>
80106839:	8b 10                	mov    (%eax),%edx
8010683b:	85 d2                	test   %edx,%edx
8010683d:	74 c8                	je     80106807 <getpgtable+0x21>
      continue; // or return -1?
      
    if (*pte) { 
      if(!(*pte & PTE_U))  // not counting non-user pages
8010683f:	f6 c2 04             	test   $0x4,%dl
80106842:	74 c3                	je     80106807 <getpgtable+0x21>
        continue;
      if(!(*pte & (PTE_P | PTE_E))) // also not counting pages that arents present/encrypted
80106844:	f7 c2 01 01 00 00    	test   $0x101,%edx
8010684a:	74 bb                	je     80106807 <getpgtable+0x21>
        continue;

      entries[count].pdx = PDX(i); 
8010684c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010684f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106852:	8d 0c cf             	lea    (%edi,%ecx,8),%ecx
80106855:	89 df                	mov    %ebx,%edi
80106857:	c1 ef 16             	shr    $0x16,%edi
8010685a:	0f b7 11             	movzwl (%ecx),%edx
8010685d:	66 81 e2 00 fc       	and    $0xfc00,%dx
80106862:	09 fa                	or     %edi,%edx
80106864:	66 89 11             	mov    %dx,(%ecx)
      entries[count].ptx = PTX(i);
80106867:	89 df                	mov    %ebx,%edi
80106869:	c1 ef 0c             	shr    $0xc,%edi
8010686c:	81 e7 ff 03 00 00    	and    $0x3ff,%edi
80106872:	c1 e7 0a             	shl    $0xa,%edi
80106875:	8b 11                	mov    (%ecx),%edx
80106877:	81 e2 ff 03 f0 ff    	and    $0xfff003ff,%edx
8010687d:	09 fa                	or     %edi,%edx
8010687f:	89 11                	mov    %edx,(%ecx)
      entries[count].ppage = (uint)(((uint)(pte)) >> PTXSHIFT);
80106881:	89 c7                	mov    %eax,%edi
80106883:	c1 ef 0c             	shr    $0xc,%edi
80106886:	8b 51 04             	mov    0x4(%ecx),%edx
80106889:	81 e2 00 00 f0 ff    	and    $0xfff00000,%edx
8010688f:	09 fa                	or     %edi,%edx
80106891:	89 51 04             	mov    %edx,0x4(%ecx)
      entries[count].present = (*pte & PTE_P) ? 1 : 0;
80106894:	0f b6 38             	movzbl (%eax),%edi
80106897:	83 e7 01             	and    $0x1,%edi
8010689a:	c1 e7 04             	shl    $0x4,%edi
8010689d:	0f b6 51 06          	movzbl 0x6(%ecx),%edx
801068a1:	83 e2 ef             	and    $0xffffffef,%edx
801068a4:	09 fa                	or     %edi,%edx
801068a6:	88 51 06             	mov    %dl,0x6(%ecx)
      entries[count].writable = (*pte & PTE_W) ? 1 : 0;
801068a9:	8b 38                	mov    (%eax),%edi
801068ab:	d1 ef                	shr    %edi
801068ad:	83 e7 01             	and    $0x1,%edi
801068b0:	c1 e7 05             	shl    $0x5,%edi
801068b3:	83 e2 df             	and    $0xffffffdf,%edx
801068b6:	09 fa                	or     %edi,%edx
801068b8:	88 51 06             	mov    %dl,0x6(%ecx)
      entries[count].encrypted = (*pte & PTE_E) ? 1 : 0;
801068bb:	8b 00                	mov    (%eax),%eax
801068bd:	c1 e8 08             	shr    $0x8,%eax
801068c0:	83 e0 01             	and    $0x1,%eax
801068c3:	c1 e0 06             	shl    $0x6,%eax
801068c6:	83 e2 bf             	and    $0xffffffbf,%edx
801068c9:	09 c2                	or     %eax,%edx
801068cb:	88 51 06             	mov    %dl,0x6(%ecx)
      count++;
801068ce:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801068d2:	e9 30 ff ff ff       	jmp    80106807 <getpgtable+0x21>
    }
  }
  return count; // number of ptes copied
}
801068d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068da:	83 c4 1c             	add    $0x1c,%esp
801068dd:	5b                   	pop    %ebx
801068de:	5e                   	pop    %esi
801068df:	5f                   	pop    %edi
801068e0:	5d                   	pop    %ebp
801068e1:	c3                   	ret    

801068e2 <dump_rawphymem>:


int dump_rawphymem(uint physical_addr, char *buffer) {
801068e2:	55                   	push   %ebp
801068e3:	89 e5                	mov    %esp,%ebp
801068e5:	53                   	push   %ebx
801068e6:	83 ec 04             	sub    $0x4,%esp
  *buffer = *buffer;
  int retval = copyout(myproc()->pgdir, (uint) buffer, (void *) PGROUNDDOWN((int)P2V(physical_addr)), PGSIZE);
801068e9:	8b 45 08             	mov    0x8(%ebp),%eax
801068ec:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801068f2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801068f8:	e8 b8 c8 ff ff       	call   801031b5 <myproc>
801068fd:	68 00 10 00 00       	push   $0x1000
80106902:	53                   	push   %ebx
80106903:	ff 75 0c             	push   0xc(%ebp)
80106906:	ff 70 04             	push   0x4(%eax)
80106909:	e8 eb fc ff ff       	call   801065f9 <copyout>
  if (retval)
8010690e:	83 c4 10             	add    $0x10,%esp
80106911:	85 c0                	test   %eax,%eax
80106913:	75 05                	jne    8010691a <dump_rawphymem+0x38>
    return -1;
  return 0;
}
80106915:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106918:	c9                   	leave  
80106919:	c3                   	ret    
    return -1;
8010691a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010691f:	eb f4                	jmp    80106915 <dump_rawphymem+0x33>
