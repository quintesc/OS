
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc f0 70 11 80       	mov    $0x801170f0,%esp
8010002d:	b8 70 30 10 80       	mov    $0x80103070,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 60 79 10 80       	push   $0x80107960
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 4a 00 00       	call   80104a80 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 67 79 10 80       	push   $0x80107967
80100097:	50                   	push   %eax
80100098:	e8 b3 48 00 00       	call   80104950 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 67 4b 00 00       	call   80104c50 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 89 4a 00 00       	call   80104bf0 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 48 00 00       	call   80104990 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 4f 21 00 00       	call   801022e0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 79 10 80       	push   $0x8010796e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 6d 48 00 00       	call   80104a30 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 07 21 00 00       	jmp    801022e0 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 79 10 80       	push   $0x8010797f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 48 00 00       	call   80104a30 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 47 00 00       	call   801049f0 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 30 4a 00 00       	call   80104c50 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
8010026c:	e9 7f 49 00 00       	jmp    80104bf0 <release>
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 86 79 10 80       	push   $0x80107986
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 c7 15 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 ab 49 00 00       	call   80104c50 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 9e 3b 00 00       	call   80103e70 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 c9 37 00 00       	call   80103ab0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 f5 48 00 00       	call   80104bf0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 14 00 00       	call   80101780 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 9f 48 00 00       	call   80104bf0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 14 00 00       	call   80101780 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 52 25 00 00       	call   801028f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 8d 79 10 80       	push   $0x8010798d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 27 83 10 80 	movl   $0x80108327,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 d3 46 00 00       	call   80104aa0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 a1 79 10 80       	push   $0x801079a1
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 61 60 00 00       	call   80106480 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
  if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 76 5f 00 00       	call   80106480 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 6a 5f 00 00       	call   80106480 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 5e 5f 00 00       	call   80106480 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 6a 48 00 00       	call   80104dc0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 b5 47 00 00       	call   80104d20 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 a5 79 10 80       	push   $0x801079a5
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100599:	ff 75 08             	push   0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010059f:	e8 bc 12 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 a0 46 00 00       	call   80104c50 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
    for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
  release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 07 46 00 00       	call   80104bf0 <release>
  ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 8e 11 00 00       	call   80101780 <ilock>

  return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
    x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 d0 79 10 80 	movzbl -0x7fef8630(%edx),%edx
  }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
  if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
    buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
    for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
    consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
    x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
  if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
    switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
  if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
      for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
  if(panicked){
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
    for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 63 44 00 00       	call   80104c50 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
    for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
    for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
        s = "(null)";
80100838:	bf b8 79 10 80       	mov    $0x801079b8,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 90 43 00 00       	call   80104bf0 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 bf 79 10 80       	push   $0x801079bf
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi
{
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 b8 43 00 00       	call   80104c50 <acquire>
  while((c = getc()) >= 0){
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100915:	83 fb 0a             	cmp    $0xa,%ebx
80100918:	0f 84 14 01 00 00    	je     80100a32 <consoleintr+0x1b2>
8010091e:	83 fb 04             	cmp    $0x4,%ebx
80100921:	0f 84 0b 01 00 00    	je     80100a32 <consoleintr+0x1b2>
80100927:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 1b 42 00 00       	call   80104bf0 <release>
  if(doprocdump) {
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
}
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
}
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a0e:	e9 6d 35 00 00       	jmp    80103f80 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
    for(;;)
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 07 35 00 00       	call   80103f50 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 c8 79 10 80       	push   $0x801079c8
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 0b 40 00 00       	call   80104a80 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 e2 19 00 00       	call   80102480 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave  
80100aa2:	c3                   	ret    
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 ef 2f 00 00       	call   80103ab0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 94 22 00 00       	call   80102d60 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 c9 15 00 00       	call   801020a0 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 02 03 00 00    	je     80100de4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c3                	mov    %eax,%ebx
80100ae7:	50                   	push   %eax
80100ae8:	e8 93 0c 00 00       	call   80101780 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	53                   	push   %ebx
80100af9:	e8 92 0f 00 00       	call   80101a90 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	74 22                	je     80100b28 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	53                   	push   %ebx
80100b0a:	e8 01 0f 00 00       	call   80101a10 <iunlockput>
    end_op();
80100b0f:	e8 bc 22 00 00       	call   80102dd0 <end_op>
80100b14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1f:	5b                   	pop    %ebx
80100b20:	5e                   	pop    %esi
80100b21:	5f                   	pop    %edi
80100b22:	5d                   	pop    %ebp
80100b23:	c3                   	ret    
80100b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b2f:	45 4c 46 
80100b32:	75 d2                	jne    80100b06 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b34:	e8 d7 6a 00 00       	call   80107610 <setupkvm>
80100b39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b3f:	85 c0                	test   %eax,%eax
80100b41:	74 c3                	je     80100b06 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b4a:	00 
80100b4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b51:	0f 84 ac 02 00 00    	je     80100e03 <exec+0x353>
  sz = 0;
80100b57:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b5e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b61:	31 ff                	xor    %edi,%edi
80100b63:	e9 8e 00 00 00       	jmp    80100bf6 <exec+0x146>
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 88 68 00 00       	call   80107430 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 62 67 00 00       	call   80107340 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 8a 0e 00 00       	call   80101a90 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
    freevm(pgdir);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 70 69 00 00       	call   80107590 <freevm>
  if(ip){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 de fe ff ff       	jmp    80100b06 <exec+0x56>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
  sz = PGROUNDUP(sz);
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	53                   	push   %ebx
80100c4c:	e8 bf 0d 00 00       	call   80101a10 <iunlockput>
  end_op();
80100c51:	e8 7a 21 00 00       	call   80102dd0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	56                   	push   %esi
80100c5a:	57                   	push   %edi
80100c5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c61:	57                   	push   %edi
80100c62:	e8 c9 67 00 00       	call   80107430 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c6                	mov    %eax,%esi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 94 00 00 00    	je     80100d08 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 28 6a 00 00       	call   801076b0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c94:	8b 00                	mov    (%eax),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	0f 84 8b 00 00 00    	je     80100d29 <exec+0x279>
80100c9e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100ca4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100caa:	eb 23                	jmp    80100ccf <exec+0x21f>
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100cb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100cba:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100cbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc6:	85 c0                	test   %eax,%eax
80100cc8:	74 59                	je     80100d23 <exec+0x273>
    if(argc >= MAXARG)
80100cca:	83 ff 20             	cmp    $0x20,%edi
80100ccd:	74 39                	je     80100d08 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ccf:	83 ec 0c             	sub    $0xc,%esp
80100cd2:	50                   	push   %eax
80100cd3:	e8 48 42 00 00       	call   80104f20 <strlen>
80100cd8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cda:	58                   	pop    %eax
80100cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cde:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce7:	e8 34 42 00 00       	call   80104f20 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 83 6b 00 00       	call   80107880 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 7a 68 00 00       	call   80107590 <freevm>
80100d16:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d1e:	e9 f9 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100d23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d29:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d30:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d32:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d39:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d3d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d3f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d42:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d48:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d4a:	50                   	push   %eax
80100d4b:	52                   	push   %edx
80100d4c:	53                   	push   %ebx
80100d4d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d53:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d5a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d63:	e8 18 6b 00 00       	call   80107880 <copyout>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	85 c0                	test   %eax,%eax
80100d6d:	78 99                	js     80100d08 <exec+0x258>
  for(last=s=path; *s; s++)
80100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d72:	8b 55 08             	mov    0x8(%ebp),%edx
80100d75:	0f b6 00             	movzbl (%eax),%eax
80100d78:	84 c0                	test   %al,%al
80100d7a:	74 13                	je     80100d8f <exec+0x2df>
80100d7c:	89 d1                	mov    %edx,%ecx
80100d7e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d95:	83 ec 04             	sub    $0x4,%esp
80100d98:	6a 10                	push   $0x10
80100d9a:	89 f8                	mov    %edi,%eax
80100d9c:	52                   	push   %edx
80100d9d:	83 c0 6c             	add    $0x6c,%eax
80100da0:	50                   	push   %eax
80100da1:	e8 3a 41 00 00       	call   80104ee0 <safestrcpy>
  curproc->pgdir = pgdir;
80100da6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dac:	89 f8                	mov    %edi,%eax
80100dae:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100db1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100db3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db6:	89 c1                	mov    %eax,%ecx
80100db8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbe:	8b 40 18             	mov    0x18(%eax),%eax
80100dc1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc4:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dca:	89 0c 24             	mov    %ecx,(%esp)
80100dcd:	e8 de 63 00 00       	call   801071b0 <switchuvm>
  freevm(oldpgdir);
80100dd2:	89 3c 24             	mov    %edi,(%esp)
80100dd5:	e8 b6 67 00 00       	call   80107590 <freevm>
  return 0;
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	31 c0                	xor    %eax,%eax
80100ddf:	e9 38 fd ff ff       	jmp    80100b1c <exec+0x6c>
    end_op();
80100de4:	e8 e7 1f 00 00       	call   80102dd0 <end_op>
    cprintf("exec: fail\n");
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	68 e1 79 10 80       	push   $0x801079e1
80100df1:	e8 aa f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100df6:	83 c4 10             	add    $0x10,%esp
80100df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dfe:	e9 19 fd ff ff       	jmp    80100b1c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e03:	be 00 20 00 00       	mov    $0x2000,%esi
80100e08:	31 ff                	xor    %edi,%edi
80100e0a:	e9 39 fe ff ff       	jmp    80100c48 <exec+0x198>
80100e0f:	90                   	nop

80100e10 <fileinit>:
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 10             	sub    $0x10,%esp
80100e16:	68 ed 79 10 80       	push   $0x801079ed
80100e1b:	68 60 ff 10 80       	push   $0x8010ff60
80100e20:	e8 5b 3c 00 00       	call   80104a80 <initlock>
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	c9                   	leave  
80100e29:	c3                   	ret    
80100e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e30 <filealloc>:
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
80100e34:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
80100e39:	83 ec 10             	sub    $0x10,%esp
80100e3c:	68 60 ff 10 80       	push   $0x8010ff60
80100e41:	e8 0a 3e 00 00       	call   80104c50 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e4f:	90                   	nop
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e59:	74 25                	je     80100e80 <filealloc+0x50>
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
80100e62:	83 ec 0c             	sub    $0xc,%esp
80100e65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100e6c:	68 60 ff 10 80       	push   $0x8010ff60
80100e71:	e8 7a 3d 00 00       	call   80104bf0 <release>
80100e76:	89 d8                	mov    %ebx,%eax
80100e78:	83 c4 10             	add    $0x10,%esp
80100e7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e7e:	c9                   	leave  
80100e7f:	c3                   	ret    
80100e80:	83 ec 0c             	sub    $0xc,%esp
80100e83:	31 db                	xor    %ebx,%ebx
80100e85:	68 60 ff 10 80       	push   $0x8010ff60
80100e8a:	e8 61 3d 00 00       	call   80104bf0 <release>
80100e8f:	89 d8                	mov    %ebx,%eax
80100e91:	83 c4 10             	add    $0x10,%esp
80100e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e97:	c9                   	leave  
80100e98:	c3                   	ret    
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ea0 <filedup>:
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 10             	sub    $0x10,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100eaa:	68 60 ff 10 80       	push   $0x8010ff60
80100eaf:	e8 9c 3d 00 00       	call   80104c50 <acquire>
80100eb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb7:	83 c4 10             	add    $0x10,%esp
80100eba:	85 c0                	test   %eax,%eax
80100ebc:	7e 1a                	jle    80100ed8 <filedup+0x38>
80100ebe:	83 c0 01             	add    $0x1,%eax
80100ec1:	83 ec 0c             	sub    $0xc,%esp
80100ec4:	89 43 04             	mov    %eax,0x4(%ebx)
80100ec7:	68 60 ff 10 80       	push   $0x8010ff60
80100ecc:	e8 1f 3d 00 00       	call   80104bf0 <release>
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 f4 79 10 80       	push   $0x801079f4
80100ee0:	e8 9b f4 ff ff       	call   80100380 <panic>
80100ee5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <fileclose>:
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 28             	sub    $0x28,%esp
80100ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100efc:	68 60 ff 10 80       	push   $0x8010ff60
80100f01:	e8 4a 3d 00 00       	call   80104c50 <acquire>
80100f06:	8b 53 04             	mov    0x4(%ebx),%edx
80100f09:	83 c4 10             	add    $0x10,%esp
80100f0c:	85 d2                	test   %edx,%edx
80100f0e:	0f 8e a5 00 00 00    	jle    80100fb9 <fileclose+0xc9>
80100f14:	83 ea 01             	sub    $0x1,%edx
80100f17:	89 53 04             	mov    %edx,0x4(%ebx)
80100f1a:	75 44                	jne    80100f60 <fileclose+0x70>
80100f1c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f20:	83 ec 0c             	sub    $0xc,%esp
80100f23:	8b 3b                	mov    (%ebx),%edi
80100f25:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100f2b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f2e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	68 60 ff 10 80       	push   $0x8010ff60
80100f39:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100f3c:	e8 af 3c 00 00       	call   80104bf0 <release>
80100f41:	83 c4 10             	add    $0x10,%esp
80100f44:	83 ff 01             	cmp    $0x1,%edi
80100f47:	74 57                	je     80100fa0 <fileclose+0xb0>
80100f49:	83 ff 02             	cmp    $0x2,%edi
80100f4c:	74 2a                	je     80100f78 <fileclose+0x88>
80100f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f51:	5b                   	pop    %ebx
80100f52:	5e                   	pop    %esi
80100f53:	5f                   	pop    %edi
80100f54:	5d                   	pop    %ebp
80100f55:	c3                   	ret    
80100f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5d:	8d 76 00             	lea    0x0(%esi),%esi
80100f60:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
80100f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6a:	5b                   	pop    %ebx
80100f6b:	5e                   	pop    %esi
80100f6c:	5f                   	pop    %edi
80100f6d:	5d                   	pop    %ebp
80100f6e:	e9 7d 3c 00 00       	jmp    80104bf0 <release>
80100f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f77:	90                   	nop
80100f78:	e8 e3 1d 00 00       	call   80102d60 <begin_op>
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	ff 75 e0             	push   -0x20(%ebp)
80100f83:	e8 28 09 00 00       	call   801018b0 <iput>
80100f88:	83 c4 10             	add    $0x10,%esp
80100f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8e:	5b                   	pop    %ebx
80100f8f:	5e                   	pop    %esi
80100f90:	5f                   	pop    %edi
80100f91:	5d                   	pop    %ebp
80100f92:	e9 39 1e 00 00       	jmp    80102dd0 <end_op>
80100f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9e:	66 90                	xchg   %ax,%ax
80100fa0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fa4:	83 ec 08             	sub    $0x8,%esp
80100fa7:	53                   	push   %ebx
80100fa8:	56                   	push   %esi
80100fa9:	e8 92 25 00 00       	call   80103540 <pipeclose>
80100fae:	83 c4 10             	add    $0x10,%esp
80100fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb4:	5b                   	pop    %ebx
80100fb5:	5e                   	pop    %esi
80100fb6:	5f                   	pop    %edi
80100fb7:	5d                   	pop    %ebp
80100fb8:	c3                   	ret    
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 fc 79 10 80       	push   $0x801079fc
80100fc1:	e8 ba f3 ff ff       	call   80100380 <panic>
80100fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcd:	8d 76 00             	lea    0x0(%esi),%esi

80100fd0 <filestat>:
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	push   0x10(%ebx)
80100fe5:	e8 96 07 00 00       	call   80101780 <ilock>
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	push   0xc(%ebp)
80100fef:	ff 73 10             	push   0x10(%ebx)
80100ff2:	e8 69 0a 00 00       	call   80101a60 <stati>
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	push   0x10(%ebx)
80100ffb:	e8 60 08 00 00       	call   80101860 <iunlock>
80101000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101003:	83 c4 10             	add    $0x10,%esp
80101006:	31 c0                	xor    %eax,%eax
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101010:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101020 <fileread>:
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	push   0x10(%ebx)
8010104a:	e8 31 07 00 00       	call   80101780 <ilock>
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	push   0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	push   0x10(%ebx)
80101057:	e8 34 0a 00 00       	call   80101a90 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	89 c6                	mov    %eax,%esi
80101061:	85 c0                	test   %eax,%eax
80101063:	7e 03                	jle    80101068 <fileread+0x48>
80101065:	01 43 14             	add    %eax,0x14(%ebx)
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	push   0x10(%ebx)
8010106e:	e8 ed 07 00 00       	call   80101860 <iunlock>
80101073:	83 c4 10             	add    $0x10,%esp
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
8010108d:	e9 4e 26 00 00       	jmp    801036e0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 06 7a 10 80       	push   $0x80107a06
801010a7:	e8 d4 f2 ff ff       	call   80100380 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 1c             	sub    $0x1c,%esp
801010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c2:	8b 45 10             	mov    0x10(%ebp),%eax
801010c5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801010cc:	0f 84 bd 00 00 00    	je     8010118f <filewrite+0xdf>
801010d2:	8b 03                	mov    (%ebx),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 bf 00 00 00    	je     8010119c <filewrite+0xec>
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 c8 00 00 00    	jne    801011ae <filewrite+0xfe>
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010e9:	31 f6                	xor    %esi,%esi
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 30                	jg     8010111f <filewrite+0x6f>
801010ef:	e9 94 00 00 00       	jmp    80101188 <filewrite+0xd8>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010f8:	01 43 14             	add    %eax,0x14(%ebx)
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 73 10             	push   0x10(%ebx)
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101104:	e8 57 07 00 00       	call   80101860 <iunlock>
80101109:	e8 c2 1c 00 00       	call   80102dd0 <end_op>
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp
80101114:	39 c7                	cmp    %eax,%edi
80101116:	75 5c                	jne    80101174 <filewrite+0xc4>
80101118:	01 fe                	add    %edi,%esi
8010111a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010111d:	7e 69                	jle    80101188 <filewrite+0xd8>
8010111f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101122:	b8 00 06 00 00       	mov    $0x600,%eax
80101127:	29 f7                	sub    %esi,%edi
80101129:	39 c7                	cmp    %eax,%edi
8010112b:	0f 4f f8             	cmovg  %eax,%edi
8010112e:	e8 2d 1c 00 00       	call   80102d60 <begin_op>
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 73 10             	push   0x10(%ebx)
80101139:	e8 42 06 00 00       	call   80101780 <ilock>
8010113e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101141:	57                   	push   %edi
80101142:	ff 73 14             	push   0x14(%ebx)
80101145:	01 f0                	add    %esi,%eax
80101147:	50                   	push   %eax
80101148:	ff 73 10             	push   0x10(%ebx)
8010114b:	e8 40 0a 00 00       	call   80101b90 <writei>
80101150:	83 c4 20             	add    $0x20,%esp
80101153:	85 c0                	test   %eax,%eax
80101155:	7f a1                	jg     801010f8 <filewrite+0x48>
80101157:	83 ec 0c             	sub    $0xc,%esp
8010115a:	ff 73 10             	push   0x10(%ebx)
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	e8 fb 06 00 00       	call   80101860 <iunlock>
80101165:	e8 66 1c 00 00       	call   80102dd0 <end_op>
8010116a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010116d:	83 c4 10             	add    $0x10,%esp
80101170:	85 c0                	test   %eax,%eax
80101172:	75 1b                	jne    8010118f <filewrite+0xdf>
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	68 0f 7a 10 80       	push   $0x80107a0f
8010117c:	e8 ff f1 ff ff       	call   80100380 <panic>
80101181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101188:	89 f0                	mov    %esi,%eax
8010118a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010118d:	74 05                	je     80101194 <filewrite+0xe4>
8010118f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101197:	5b                   	pop    %ebx
80101198:	5e                   	pop    %esi
80101199:	5f                   	pop    %edi
8010119a:	5d                   	pop    %ebp
8010119b:	c3                   	ret    
8010119c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010119f:	89 45 08             	mov    %eax,0x8(%ebp)
801011a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a5:	5b                   	pop    %ebx
801011a6:	5e                   	pop    %esi
801011a7:	5f                   	pop    %edi
801011a8:	5d                   	pop    %ebp
801011a9:	e9 32 24 00 00       	jmp    801035e0 <pipewrite>
801011ae:	83 ec 0c             	sub    $0xc,%esp
801011b1:	68 15 7a 10 80       	push   $0x80107a15
801011b6:	e8 c5 f1 ff ff       	call   80100380 <panic>
801011bb:	66 90                	xchg   %ax,%ax
801011bd:	66 90                	xchg   %ax,%ax
801011bf:	90                   	nop

801011c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011c0:	55                   	push   %ebp
801011c1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011c3:	89 d0                	mov    %edx,%eax
801011c5:	c1 e8 0c             	shr    $0xc,%eax
801011c8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801011ce:	89 e5                	mov    %esp,%ebp
801011d0:	56                   	push   %esi
801011d1:	53                   	push   %ebx
801011d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	50                   	push   %eax
801011d8:	51                   	push   %ecx
801011d9:	e8 f2 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011e0:	c1 fb 03             	sar    $0x3,%ebx
801011e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801011e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801011e8:	83 e1 07             	and    $0x7,%ecx
801011eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801011f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801011f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801011f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801011fd:	85 c1                	test   %eax,%ecx
801011ff:	74 23                	je     80101224 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101201:	f7 d0                	not    %eax
  log_write(bp);
80101203:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101206:	21 c8                	and    %ecx,%eax
80101208:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010120c:	56                   	push   %esi
8010120d:	e8 2e 1d 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101212:	89 34 24             	mov    %esi,(%esp)
80101215:	e8 d6 ef ff ff       	call   801001f0 <brelse>
}
8010121a:	83 c4 10             	add    $0x10,%esp
8010121d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101220:	5b                   	pop    %ebx
80101221:	5e                   	pop    %esi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
    panic("freeing free block");
80101224:	83 ec 0c             	sub    $0xc,%esp
80101227:	68 1f 7a 10 80       	push   $0x80107a1f
8010122c:	e8 4f f1 ff ff       	call   80100380 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop

80101240 <balloc>:
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101249:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010124f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101252:	85 c9                	test   %ecx,%ecx
80101254:	0f 84 87 00 00 00    	je     801012e1 <balloc+0xa1>
8010125a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101261:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101264:	83 ec 08             	sub    $0x8,%esp
80101267:	89 f0                	mov    %esi,%eax
80101269:	c1 f8 0c             	sar    $0xc,%eax
8010126c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101272:	50                   	push   %eax
80101273:	ff 75 d8             	push   -0x28(%ebp)
80101276:	e8 55 ee ff ff       	call   801000d0 <bread>
8010127b:	83 c4 10             	add    $0x10,%esp
8010127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101281:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101286:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101289:	31 c0                	xor    %eax,%eax
8010128b:	eb 2f                	jmp    801012bc <balloc+0x7c>
8010128d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101290:	89 c1                	mov    %eax,%ecx
80101292:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101297:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010129f:	89 c1                	mov    %eax,%ecx
801012a1:	c1 f9 03             	sar    $0x3,%ecx
801012a4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	85 df                	test   %ebx,%edi
801012ad:	74 41                	je     801012f0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012af:	83 c0 01             	add    $0x1,%eax
801012b2:	83 c6 01             	add    $0x1,%esi
801012b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ba:	74 05                	je     801012c1 <balloc+0x81>
801012bc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012bf:	77 cf                	ja     80101290 <balloc+0x50>
    brelse(bp);
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	ff 75 e4             	push   -0x1c(%ebp)
801012c7:	e8 24 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012cc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012d9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012df:	77 80                	ja     80101261 <balloc+0x21>
  panic("balloc: out of blocks");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 32 7a 10 80       	push   $0x80107a32
801012e9:	e8 92 f0 ff ff       	call   80100380 <panic>
801012ee:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012f3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012f6:	09 da                	or     %ebx,%edx
801012f8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012fc:	57                   	push   %edi
801012fd:	e8 3e 1c 00 00       	call   80102f40 <log_write>
        brelse(bp);
80101302:	89 3c 24             	mov    %edi,(%esp)
80101305:	e8 e6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010130a:	58                   	pop    %eax
8010130b:	5a                   	pop    %edx
8010130c:	56                   	push   %esi
8010130d:	ff 75 d8             	push   -0x28(%ebp)
80101310:	e8 bb ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101315:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101318:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010131a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010131d:	68 00 02 00 00       	push   $0x200
80101322:	6a 00                	push   $0x0
80101324:	50                   	push   %eax
80101325:	e8 f6 39 00 00       	call   80104d20 <memset>
  log_write(bp);
8010132a:	89 1c 24             	mov    %ebx,(%esp)
8010132d:	e8 0e 1c 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 b6 ee ff ff       	call   801001f0 <brelse>
}
8010133a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133d:	89 f0                	mov    %esi,%eax
8010133f:	5b                   	pop    %ebx
80101340:	5e                   	pop    %esi
80101341:	5f                   	pop    %edi
80101342:	5d                   	pop    %ebp
80101343:	c3                   	ret    
80101344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010134f:	90                   	nop

80101350 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	89 c7                	mov    %eax,%edi
80101356:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101357:	31 f6                	xor    %esi,%esi
{
80101359:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101365:	68 60 09 11 80       	push   $0x80110960
8010136a:	e8 e1 38 00 00       	call   80104c50 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101372:	83 c4 10             	add    $0x10,%esp
80101375:	eb 1b                	jmp    80101392 <iget+0x42>
80101377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010137e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101380:	39 3b                	cmp    %edi,(%ebx)
80101382:	74 6c                	je     801013f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101384:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010138a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101390:	73 26                	jae    801013b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101392:	8b 43 08             	mov    0x8(%ebx),%eax
80101395:	85 c0                	test   %eax,%eax
80101397:	7f e7                	jg     80101380 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101399:	85 f6                	test   %esi,%esi
8010139b:	75 e7                	jne    80101384 <iget+0x34>
8010139d:	85 c0                	test   %eax,%eax
8010139f:	75 76                	jne    80101417 <iget+0xc7>
801013a1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013a9:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013af:	72 e1                	jb     80101392 <iget+0x42>
801013b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013b8:	85 f6                	test   %esi,%esi
801013ba:	74 79                	je     80101435 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013bf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013c1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013c4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013d2:	68 60 09 11 80       	push   $0x80110960
801013d7:	e8 14 38 00 00       	call   80104bf0 <release>

  return ip;
801013dc:	83 c4 10             	add    $0x10,%esp
}
801013df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e2:	89 f0                	mov    %esi,%eax
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret    
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013f3:	75 8f                	jne    80101384 <iget+0x34>
      release(&icache.lock);
801013f5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801013f8:	83 c0 01             	add    $0x1,%eax
      return ip;
801013fb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801013fd:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101402:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101405:	e8 e6 37 00 00       	call   80104bf0 <release>
      return ip;
8010140a:	83 c4 10             	add    $0x10,%esp
}
8010140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101410:	89 f0                	mov    %esi,%eax
80101412:	5b                   	pop    %ebx
80101413:	5e                   	pop    %esi
80101414:	5f                   	pop    %edi
80101415:	5d                   	pop    %ebp
80101416:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101417:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101423:	73 10                	jae    80101435 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
    panic("iget: no inodes");
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 48 7a 10 80       	push   $0x80107a48
8010143d:	e8 3e ef ff ff       	call   80100380 <panic>
80101442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	89 c6                	mov    %eax,%esi
80101457:	53                   	push   %ebx
80101458:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	0f 86 8c 00 00 00    	jbe    801014f0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101464:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101467:	83 fb 7f             	cmp    $0x7f,%ebx
8010146a:	0f 87 a2 00 00 00    	ja     80101512 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	85 c0                	test   %eax,%eax
80101478:	74 5e                	je     801014d8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010147a:	83 ec 08             	sub    $0x8,%esp
8010147d:	50                   	push   %eax
8010147e:	ff 36                	push   (%esi)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010148c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010148e:	8b 3b                	mov    (%ebx),%edi
80101490:	85 ff                	test   %edi,%edi
80101492:	74 1c                	je     801014b0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101494:	83 ec 0c             	sub    $0xc,%esp
80101497:	52                   	push   %edx
80101498:	e8 53 ed ff ff       	call   801001f0 <brelse>
8010149d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a3:	89 f8                	mov    %edi,%eax
801014a5:	5b                   	pop    %ebx
801014a6:	5e                   	pop    %esi
801014a7:	5f                   	pop    %edi
801014a8:	5d                   	pop    %ebp
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014b3:	8b 06                	mov    (%esi),%eax
801014b5:	e8 86 fd ff ff       	call   80101240 <balloc>
      log_write(bp);
801014ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014bd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014c0:	89 03                	mov    %eax,(%ebx)
801014c2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014c4:	52                   	push   %edx
801014c5:	e8 76 1a 00 00       	call   80102f40 <log_write>
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 c4 10             	add    $0x10,%esp
801014d0:	eb c2                	jmp    80101494 <bmap+0x44>
801014d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014d8:	8b 06                	mov    (%esi),%eax
801014da:	e8 61 fd ff ff       	call   80101240 <balloc>
801014df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014e5:	eb 93                	jmp    8010147a <bmap+0x2a>
801014e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ee:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014f0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014f3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014f7:	85 ff                	test   %edi,%edi
801014f9:	75 a5                	jne    801014a0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014fb:	8b 00                	mov    (%eax),%eax
801014fd:	e8 3e fd ff ff       	call   80101240 <balloc>
80101502:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101506:	89 c7                	mov    %eax,%edi
}
80101508:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150b:	5b                   	pop    %ebx
8010150c:	89 f8                	mov    %edi,%eax
8010150e:	5e                   	pop    %esi
8010150f:	5f                   	pop    %edi
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
  panic("bmap: out of range");
80101512:	83 ec 0c             	sub    $0xc,%esp
80101515:	68 58 7a 10 80       	push   $0x80107a58
8010151a:	e8 61 ee ff ff       	call   80100380 <panic>
8010151f:	90                   	nop

80101520 <readsb>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	56                   	push   %esi
80101524:	53                   	push   %ebx
80101525:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101528:	83 ec 08             	sub    $0x8,%esp
8010152b:	6a 01                	push   $0x1
8010152d:	ff 75 08             	push   0x8(%ebp)
80101530:	e8 9b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101535:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101538:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010153a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010153d:	6a 1c                	push   $0x1c
8010153f:	50                   	push   %eax
80101540:	56                   	push   %esi
80101541:	e8 7a 38 00 00       	call   80104dc0 <memmove>
  brelse(bp);
80101546:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101549:	83 c4 10             	add    $0x10,%esp
}
8010154c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154f:	5b                   	pop    %ebx
80101550:	5e                   	pop    %esi
80101551:	5d                   	pop    %ebp
  brelse(bp);
80101552:	e9 99 ec ff ff       	jmp    801001f0 <brelse>
80101557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 6b 7a 10 80       	push   $0x80107a6b
80101571:	68 60 09 11 80       	push   $0x80110960
80101576:	e8 05 35 00 00       	call   80104a80 <initlock>
  for(i = 0; i < NINODE; i++) {
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 72 7a 10 80       	push   $0x80107a72
80101588:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010158f:	e8 bc 33 00 00       	call   80104950 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
  bp = bread(dev, 1);
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	6a 01                	push   $0x1
801015a4:	ff 75 08             	push   0x8(%ebp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015ac:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015af:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015b1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015b4:	6a 1c                	push   $0x1c
801015b6:	50                   	push   %eax
801015b7:	68 b4 25 11 80       	push   $0x801125b4
801015bc:	e8 ff 37 00 00       	call   80104dc0 <memmove>
  brelse(bp);
801015c1:	89 1c 24             	mov    %ebx,(%esp)
801015c4:	e8 27 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015c9:	ff 35 cc 25 11 80    	push   0x801125cc
801015cf:	ff 35 c8 25 11 80    	push   0x801125c8
801015d5:	ff 35 c4 25 11 80    	push   0x801125c4
801015db:	ff 35 c0 25 11 80    	push   0x801125c0
801015e1:	ff 35 bc 25 11 80    	push   0x801125bc
801015e7:	ff 35 b8 25 11 80    	push   0x801125b8
801015ed:	ff 35 b4 25 11 80    	push   0x801125b4
801015f3:	68 d8 7a 10 80       	push   $0x80107ad8
801015f8:	e8 a3 f0 ff ff       	call   801006a0 <cprintf>
}
801015fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101600:	83 c4 30             	add    $0x30,%esp
80101603:	c9                   	leave  
80101604:	c3                   	ret    
80101605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101610 <ialloc>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 1c             	sub    $0x1c,%esp
80101619:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101623:	8b 75 08             	mov    0x8(%ebp),%esi
80101626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101629:	0f 86 91 00 00 00    	jbe    801016c0 <ialloc+0xb0>
8010162f:	bf 01 00 00 00       	mov    $0x1,%edi
80101634:	eb 21                	jmp    80101657 <ialloc+0x47>
80101636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010163d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101640:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101643:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101646:	53                   	push   %ebx
80101647:	e8 a4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010164c:	83 c4 10             	add    $0x10,%esp
8010164f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101655:	73 69                	jae    801016c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101657:	89 f8                	mov    %edi,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	c1 e8 03             	shr    $0x3,%eax
8010165f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101665:	50                   	push   %eax
80101666:	56                   	push   %esi
80101667:	e8 64 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010166c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010166f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101671:	89 f8                	mov    %edi,%eax
80101673:	83 e0 07             	and    $0x7,%eax
80101676:	c1 e0 06             	shl    $0x6,%eax
80101679:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010167d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101681:	75 bd                	jne    80101640 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101683:	83 ec 04             	sub    $0x4,%esp
80101686:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101689:	6a 40                	push   $0x40
8010168b:	6a 00                	push   $0x0
8010168d:	51                   	push   %ecx
8010168e:	e8 8d 36 00 00       	call   80104d20 <memset>
      dip->type = type;
80101693:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101697:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010169a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010169d:	89 1c 24             	mov    %ebx,(%esp)
801016a0:	e8 9b 18 00 00       	call   80102f40 <log_write>
      brelse(bp);
801016a5:	89 1c 24             	mov    %ebx,(%esp)
801016a8:	e8 43 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016ad:	83 c4 10             	add    $0x10,%esp
}
801016b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016b3:	89 fa                	mov    %edi,%edx
}
801016b5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016b6:	89 f0                	mov    %esi,%eax
}
801016b8:	5e                   	pop    %esi
801016b9:	5f                   	pop    %edi
801016ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801016bb:	e9 90 fc ff ff       	jmp    80101350 <iget>
  panic("ialloc: no inodes");
801016c0:	83 ec 0c             	sub    $0xc,%esp
801016c3:	68 78 7a 10 80       	push   $0x80107a78
801016c8:	e8 b3 ec ff ff       	call   80100380 <panic>
801016cd:	8d 76 00             	lea    0x0(%esi),%esi

801016d0 <iupdate>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016db:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016de:	83 ec 08             	sub    $0x8,%esp
801016e1:	c1 e8 03             	shr    $0x3,%eax
801016e4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801016ea:	50                   	push   %eax
801016eb:	ff 73 a4             	push   -0x5c(%ebx)
801016ee:	e8 dd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016fa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101709:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010170c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101710:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101713:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101717:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010171b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010171f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101723:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101727:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010172a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010172d:	6a 34                	push   $0x34
8010172f:	53                   	push   %ebx
80101730:	50                   	push   %eax
80101731:	e8 8a 36 00 00       	call   80104dc0 <memmove>
  log_write(bp);
80101736:	89 34 24             	mov    %esi,(%esp)
80101739:	e8 02 18 00 00       	call   80102f40 <log_write>
  brelse(bp);
8010173e:	89 75 08             	mov    %esi,0x8(%ebp)
80101741:	83 c4 10             	add    $0x10,%esp
}
80101744:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101747:	5b                   	pop    %ebx
80101748:	5e                   	pop    %esi
80101749:	5d                   	pop    %ebp
  brelse(bp);
8010174a:	e9 a1 ea ff ff       	jmp    801001f0 <brelse>
8010174f:	90                   	nop

80101750 <idup>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	53                   	push   %ebx
80101754:	83 ec 10             	sub    $0x10,%esp
80101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010175a:	68 60 09 11 80       	push   $0x80110960
8010175f:	e8 ec 34 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101764:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101768:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010176f:	e8 7c 34 00 00       	call   80104bf0 <release>
}
80101774:	89 d8                	mov    %ebx,%eax
80101776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101779:	c9                   	leave  
8010177a:	c3                   	ret    
8010177b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010177f:	90                   	nop

80101780 <ilock>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101788:	85 db                	test   %ebx,%ebx
8010178a:	0f 84 b7 00 00 00    	je     80101847 <ilock+0xc7>
80101790:	8b 53 08             	mov    0x8(%ebx),%edx
80101793:	85 d2                	test   %edx,%edx
80101795:	0f 8e ac 00 00 00    	jle    80101847 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010179b:	83 ec 0c             	sub    $0xc,%esp
8010179e:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a1:	50                   	push   %eax
801017a2:	e8 e9 31 00 00       	call   80104990 <acquiresleep>
  if(ip->valid == 0){
801017a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017aa:	83 c4 10             	add    $0x10,%esp
801017ad:	85 c0                	test   %eax,%eax
801017af:	74 0f                	je     801017c0 <ilock+0x40>
}
801017b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b4:	5b                   	pop    %ebx
801017b5:	5e                   	pop    %esi
801017b6:	5d                   	pop    %ebp
801017b7:	c3                   	ret    
801017b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017bf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c0:	8b 43 04             	mov    0x4(%ebx),%eax
801017c3:	83 ec 08             	sub    $0x8,%esp
801017c6:	c1 e8 03             	shr    $0x3,%eax
801017c9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017cf:	50                   	push   %eax
801017d0:	ff 33                	push   (%ebx)
801017d2:	e8 f9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017d7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017da:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017dc:	8b 43 04             	mov    0x4(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101803:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101807:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010180b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010180e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101811:	6a 34                	push   $0x34
80101813:	50                   	push   %eax
80101814:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101817:	50                   	push   %eax
80101818:	e8 a3 35 00 00       	call   80104dc0 <memmove>
    brelse(bp);
8010181d:	89 34 24             	mov    %esi,(%esp)
80101820:	e8 cb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101834:	0f 85 77 ff ff ff    	jne    801017b1 <ilock+0x31>
      panic("ilock: no type");
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 90 7a 10 80       	push   $0x80107a90
80101842:	e8 39 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 8a 7a 10 80       	push   $0x80107a8a
8010184f:	e8 2c eb ff ff       	call   80100380 <panic>
80101854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iunlock>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101868:	85 db                	test   %ebx,%ebx
8010186a:	74 28                	je     80101894 <iunlock+0x34>
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101872:	56                   	push   %esi
80101873:	e8 b8 31 00 00       	call   80104a30 <holdingsleep>
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 c0                	test   %eax,%eax
8010187d:	74 15                	je     80101894 <iunlock+0x34>
8010187f:	8b 43 08             	mov    0x8(%ebx),%eax
80101882:	85 c0                	test   %eax,%eax
80101884:	7e 0e                	jle    80101894 <iunlock+0x34>
  releasesleep(&ip->lock);
80101886:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101889:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188c:	5b                   	pop    %ebx
8010188d:	5e                   	pop    %esi
8010188e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010188f:	e9 5c 31 00 00       	jmp    801049f0 <releasesleep>
    panic("iunlock");
80101894:	83 ec 0c             	sub    $0xc,%esp
80101897:	68 9f 7a 10 80       	push   $0x80107a9f
8010189c:	e8 df ea ff ff       	call   80100380 <panic>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop

801018b0 <iput>:
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	57                   	push   %edi
801018b4:	56                   	push   %esi
801018b5:	53                   	push   %ebx
801018b6:	83 ec 28             	sub    $0x28,%esp
801018b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018bf:	57                   	push   %edi
801018c0:	e8 cb 30 00 00       	call   80104990 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	85 d2                	test   %edx,%edx
801018cd:	74 07                	je     801018d6 <iput+0x26>
801018cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018d4:	74 32                	je     80101908 <iput+0x58>
  releasesleep(&ip->lock);
801018d6:	83 ec 0c             	sub    $0xc,%esp
801018d9:	57                   	push   %edi
801018da:	e8 11 31 00 00       	call   801049f0 <releasesleep>
  acquire(&icache.lock);
801018df:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018e6:	e8 65 33 00 00       	call   80104c50 <acquire>
  ip->ref--;
801018eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ef:	83 c4 10             	add    $0x10,%esp
801018f2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801018f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5f                   	pop    %edi
801018ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101900:	e9 eb 32 00 00       	jmp    80104bf0 <release>
80101905:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	68 60 09 11 80       	push   $0x80110960
80101910:	e8 3b 33 00 00       	call   80104c50 <acquire>
    int r = ip->ref;
80101915:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101918:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010191f:	e8 cc 32 00 00       	call   80104bf0 <release>
    if(r == 1){
80101924:	83 c4 10             	add    $0x10,%esp
80101927:	83 fe 01             	cmp    $0x1,%esi
8010192a:	75 aa                	jne    801018d6 <iput+0x26>
8010192c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101932:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101935:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101938:	89 cf                	mov    %ecx,%edi
8010193a:	eb 0b                	jmp    80101947 <iput+0x97>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101940:	83 c6 04             	add    $0x4,%esi
80101943:	39 fe                	cmp    %edi,%esi
80101945:	74 19                	je     80101960 <iput+0xb0>
    if(ip->addrs[i]){
80101947:	8b 16                	mov    (%esi),%edx
80101949:	85 d2                	test   %edx,%edx
8010194b:	74 f3                	je     80101940 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010194d:	8b 03                	mov    (%ebx),%eax
8010194f:	e8 6c f8 ff ff       	call   801011c0 <bfree>
      ip->addrs[i] = 0;
80101954:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010195a:	eb e4                	jmp    80101940 <iput+0x90>
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101960:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101966:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101969:	85 c0                	test   %eax,%eax
8010196b:	75 2d                	jne    8010199a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010196d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101970:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101977:	53                   	push   %ebx
80101978:	e8 53 fd ff ff       	call   801016d0 <iupdate>
      ip->type = 0;
8010197d:	31 c0                	xor    %eax,%eax
8010197f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101983:	89 1c 24             	mov    %ebx,(%esp)
80101986:	e8 45 fd ff ff       	call   801016d0 <iupdate>
      ip->valid = 0;
8010198b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101992:	83 c4 10             	add    $0x10,%esp
80101995:	e9 3c ff ff ff       	jmp    801018d6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010199a:	83 ec 08             	sub    $0x8,%esp
8010199d:	50                   	push   %eax
8010199e:	ff 33                	push   (%ebx)
801019a0:	e8 2b e7 ff ff       	call   801000d0 <bread>
801019a5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801019b4:	8d 70 5c             	lea    0x5c(%eax),%esi
801019b7:	89 cf                	mov    %ecx,%edi
801019b9:	eb 0c                	jmp    801019c7 <iput+0x117>
801019bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019bf:	90                   	nop
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 f7                	cmp    %esi,%edi
801019c5:	74 0f                	je     801019d6 <iput+0x126>
      if(a[j])
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019cd:	8b 03                	mov    (%ebx),%eax
801019cf:	e8 ec f7 ff ff       	call   801011c0 <bfree>
801019d4:	eb ea                	jmp    801019c0 <iput+0x110>
    brelse(bp);
801019d6:	83 ec 0c             	sub    $0xc,%esp
801019d9:	ff 75 e4             	push   -0x1c(%ebp)
801019dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019df:	e8 0c e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019e4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019ea:	8b 03                	mov    (%ebx),%eax
801019ec:	e8 cf f7 ff ff       	call   801011c0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019f1:	83 c4 10             	add    $0x10,%esp
801019f4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019fb:	00 00 00 
801019fe:	e9 6a ff ff ff       	jmp    8010196d <iput+0xbd>
80101a03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a10 <iunlockput>:
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	56                   	push   %esi
80101a14:	53                   	push   %ebx
80101a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a18:	85 db                	test   %ebx,%ebx
80101a1a:	74 34                	je     80101a50 <iunlockput+0x40>
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a22:	56                   	push   %esi
80101a23:	e8 08 30 00 00       	call   80104a30 <holdingsleep>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	74 21                	je     80101a50 <iunlockput+0x40>
80101a2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	7e 1a                	jle    80101a50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a36:	83 ec 0c             	sub    $0xc,%esp
80101a39:	56                   	push   %esi
80101a3a:	e8 b1 2f 00 00       	call   801049f0 <releasesleep>
  iput(ip);
80101a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a42:	83 c4 10             	add    $0x10,%esp
}
80101a45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5d                   	pop    %ebp
  iput(ip);
80101a4b:	e9 60 fe ff ff       	jmp    801018b0 <iput>
    panic("iunlock");
80101a50:	83 ec 0c             	sub    $0xc,%esp
80101a53:	68 9f 7a 10 80       	push   $0x80107a9f
80101a58:	e8 23 e9 ff ff       	call   80100380 <panic>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi

80101a60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	8b 55 08             	mov    0x8(%ebp),%edx
80101a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a69:	8b 0a                	mov    (%edx),%ecx
80101a6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a83:	8b 52 58             	mov    0x58(%edx),%edx
80101a86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a89:	5d                   	pop    %ebp
80101a8a:	c3                   	ret    
80101a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a8f:	90                   	nop

80101a90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 1c             	sub    $0x1c,%esp
80101a99:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9f:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101aa5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 a7 00 00 00    	je     80101b60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	8b 40 58             	mov    0x58(%eax),%eax
80101abf:	39 c6                	cmp    %eax,%esi
80101ac1:	0f 87 ba 00 00 00    	ja     80101b81 <readi+0xf1>
80101ac7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101aca:	31 c9                	xor    %ecx,%ecx
80101acc:	89 da                	mov    %ebx,%edx
80101ace:	01 f2                	add    %esi,%edx
80101ad0:	0f 92 c1             	setb   %cl
80101ad3:	89 cf                	mov    %ecx,%edi
80101ad5:	0f 82 a6 00 00 00    	jb     80101b81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101adb:	89 c1                	mov    %eax,%ecx
80101add:	29 f1                	sub    %esi,%ecx
80101adf:	39 d0                	cmp    %edx,%eax
80101ae1:	0f 43 cb             	cmovae %ebx,%ecx
80101ae4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae7:	85 c9                	test   %ecx,%ecx
80101ae9:	74 67                	je     80101b52 <readi+0xc2>
80101aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 d8                	mov    %ebx,%eax
80101afa:	e8 51 f9 ff ff       	call   80101450 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 33                	push   (%ebx)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b0d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b12:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b14:	89 f0                	mov    %esi,%eax
80101b16:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b1d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b20:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b22:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b26:	39 d9                	cmp    %ebx,%ecx
80101b28:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2b:	83 c4 0c             	add    $0xc,%esp
80101b2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b2f:	01 df                	add    %ebx,%edi
80101b31:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b33:	50                   	push   %eax
80101b34:	ff 75 e0             	push   -0x20(%ebp)
80101b37:	e8 84 32 00 00       	call   80104dc0 <memmove>
    brelse(bp);
80101b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b3f:	89 14 24             	mov    %edx,(%esp)
80101b42:	e8 a9 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
80101b4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b50:	77 9e                	ja     80101af0 <readi+0x60>
  }
  return n;
80101b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 17                	ja     80101b81 <readi+0xf1>
80101b6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 0c                	je     80101b81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b7f:	ff e0                	jmp    *%eax
      return -1;
80101b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b86:	eb cd                	jmp    80101b55 <readi+0xc5>
80101b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b8f:	90                   	nop

80101b90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b9f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ba2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ba7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101baa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bad:	8b 75 10             	mov    0x10(%ebp),%esi
80101bb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bb3:	0f 84 b7 00 00 00    	je     80101c70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bbf:	0f 87 e7 00 00 00    	ja     80101cac <writei+0x11c>
80101bc5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bc8:	31 d2                	xor    %edx,%edx
80101bca:	89 f8                	mov    %edi,%eax
80101bcc:	01 f0                	add    %esi,%eax
80101bce:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bd1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bd6:	0f 87 d0 00 00 00    	ja     80101cac <writei+0x11c>
80101bdc:	85 d2                	test   %edx,%edx
80101bde:	0f 85 c8 00 00 00    	jne    80101cac <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101beb:	85 ff                	test   %edi,%edi
80101bed:	74 72                	je     80101c61 <writei+0xd1>
80101bef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bf3:	89 f2                	mov    %esi,%edx
80101bf5:	c1 ea 09             	shr    $0x9,%edx
80101bf8:	89 f8                	mov    %edi,%eax
80101bfa:	e8 51 f8 ff ff       	call   80101450 <bmap>
80101bff:	83 ec 08             	sub    $0x8,%esp
80101c02:	50                   	push   %eax
80101c03:	ff 37                	push   (%edi)
80101c05:	e8 c6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c15:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	89 f0                	mov    %esi,%eax
80101c19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c1e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c24:	39 d9                	cmp    %ebx,%ecx
80101c26:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c29:	83 c4 0c             	add    $0xc,%esp
80101c2c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c2d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c2f:	ff 75 dc             	push   -0x24(%ebp)
80101c32:	50                   	push   %eax
80101c33:	e8 88 31 00 00       	call   80104dc0 <memmove>
    log_write(bp);
80101c38:	89 3c 24             	mov    %edi,(%esp)
80101c3b:	e8 00 13 00 00       	call   80102f40 <log_write>
    brelse(bp);
80101c40:	89 3c 24             	mov    %edi,(%esp)
80101c43:	e8 a8 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c4b:	83 c4 10             	add    $0x10,%esp
80101c4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c57:	77 97                	ja     80101bf0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c5f:	77 37                	ja     80101c98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c67:	5b                   	pop    %ebx
80101c68:	5e                   	pop    %esi
80101c69:	5f                   	pop    %edi
80101c6a:	5d                   	pop    %ebp
80101c6b:	c3                   	ret    
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c74:	66 83 f8 09          	cmp    $0x9,%ax
80101c78:	77 32                	ja     80101cac <writei+0x11c>
80101c7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 27                	je     80101cac <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c85:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101c88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8b:	5b                   	pop    %ebx
80101c8c:	5e                   	pop    %esi
80101c8d:	5f                   	pop    %edi
80101c8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c8f:	ff e0                	jmp    *%eax
80101c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ca1:	50                   	push   %eax
80101ca2:	e8 29 fa ff ff       	call   801016d0 <iupdate>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	eb b5                	jmp    80101c61 <writei+0xd1>
      return -1;
80101cac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cb1:	eb b1                	jmp    80101c64 <writei+0xd4>
80101cb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cc6:	6a 0e                	push   $0xe
80101cc8:	ff 75 0c             	push   0xc(%ebp)
80101ccb:	ff 75 08             	push   0x8(%ebp)
80101cce:	e8 5d 31 00 00       	call   80104e30 <strncmp>
}
80101cd3:	c9                   	leave  
80101cd4:	c3                   	ret    
80101cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cf1:	0f 85 85 00 00 00    	jne    80101d7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cfa:	31 ff                	xor    %edi,%edi
80101cfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cff:	85 d2                	test   %edx,%edx
80101d01:	74 3e                	je     80101d41 <dirlookup+0x61>
80101d03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d07:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d08:	6a 10                	push   $0x10
80101d0a:	57                   	push   %edi
80101d0b:	56                   	push   %esi
80101d0c:	53                   	push   %ebx
80101d0d:	e8 7e fd ff ff       	call   80101a90 <readi>
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	83 f8 10             	cmp    $0x10,%eax
80101d18:	75 55                	jne    80101d6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d1f:	74 18                	je     80101d39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d21:	83 ec 04             	sub    $0x4,%esp
80101d24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d27:	6a 0e                	push   $0xe
80101d29:	50                   	push   %eax
80101d2a:	ff 75 0c             	push   0xc(%ebp)
80101d2d:	e8 fe 30 00 00       	call   80104e30 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	85 c0                	test   %eax,%eax
80101d37:	74 17                	je     80101d50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d39:	83 c7 10             	add    $0x10,%edi
80101d3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d3f:	72 c7                	jb     80101d08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d44:	31 c0                	xor    %eax,%eax
}
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
80101d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
      if(poff)
80101d50:	8b 45 10             	mov    0x10(%ebp),%eax
80101d53:	85 c0                	test   %eax,%eax
80101d55:	74 05                	je     80101d5c <dirlookup+0x7c>
        *poff = off;
80101d57:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d60:	8b 03                	mov    (%ebx),%eax
80101d62:	e8 e9 f5 ff ff       	call   80101350 <iget>
}
80101d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6a:	5b                   	pop    %ebx
80101d6b:	5e                   	pop    %esi
80101d6c:	5f                   	pop    %edi
80101d6d:	5d                   	pop    %ebp
80101d6e:	c3                   	ret    
      panic("dirlookup read");
80101d6f:	83 ec 0c             	sub    $0xc,%esp
80101d72:	68 b9 7a 10 80       	push   $0x80107ab9
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 a7 7a 10 80       	push   $0x80107aa7
80101d84:	e8 f7 e5 ff ff       	call   80100380 <panic>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101da4:	0f 84 64 01 00 00    	je     80101f0e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101daa:	e8 01 1d 00 00       	call   80103ab0 <myproc>
  acquire(&icache.lock);
80101daf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101db2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101db5:	68 60 09 11 80       	push   $0x80110960
80101dba:	e8 91 2e 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dca:	e8 21 2e 00 00       	call   80104bf0 <release>
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	eb 07                	jmp    80101ddb <namex+0x4b>
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ddb:	0f b6 03             	movzbl (%ebx),%eax
80101dde:	3c 2f                	cmp    $0x2f,%al
80101de0:	74 f6                	je     80101dd8 <namex+0x48>
  if(*path == 0)
80101de2:	84 c0                	test   %al,%al
80101de4:	0f 84 06 01 00 00    	je     80101ef0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dea:	0f b6 03             	movzbl (%ebx),%eax
80101ded:	84 c0                	test   %al,%al
80101def:	0f 84 10 01 00 00    	je     80101f05 <namex+0x175>
80101df5:	89 df                	mov    %ebx,%edi
80101df7:	3c 2f                	cmp    $0x2f,%al
80101df9:	0f 84 06 01 00 00    	je     80101f05 <namex+0x175>
80101dff:	90                   	nop
80101e00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	74 04                	je     80101e0f <namex+0x7f>
80101e0b:	84 c0                	test   %al,%al
80101e0d:	75 f1                	jne    80101e00 <namex+0x70>
  len = path - s;
80101e0f:	89 f8                	mov    %edi,%eax
80101e11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e13:	83 f8 0d             	cmp    $0xd,%eax
80101e16:	0f 8e ac 00 00 00    	jle    80101ec8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e1c:	83 ec 04             	sub    $0x4,%esp
80101e1f:	6a 0e                	push   $0xe
80101e21:	53                   	push   %ebx
    path++;
80101e22:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e24:	ff 75 e4             	push   -0x1c(%ebp)
80101e27:	e8 94 2f 00 00       	call   80104dc0 <memmove>
80101e2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e32:	75 0c                	jne    80101e40 <namex+0xb0>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e3e:	74 f8                	je     80101e38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 37 f9 ff ff       	call   80101780 <ilock>
    if(ip->type != T_DIR){
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e51:	0f 85 cd 00 00 00    	jne    80101f24 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 09                	je     80101e67 <namex+0xd7>
80101e5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e61:	0f 84 22 01 00 00    	je     80101f89 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e67:	83 ec 04             	sub    $0x4,%esp
80101e6a:	6a 00                	push   $0x0
80101e6c:	ff 75 e4             	push   -0x1c(%ebp)
80101e6f:	56                   	push   %esi
80101e70:	e8 6b fe ff ff       	call   80101ce0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e75:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101e78:	83 c4 10             	add    $0x10,%esp
80101e7b:	89 c7                	mov    %eax,%edi
80101e7d:	85 c0                	test   %eax,%eax
80101e7f:	0f 84 e1 00 00 00    	je     80101f66 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e8b:	52                   	push   %edx
80101e8c:	e8 9f 2b 00 00       	call   80104a30 <holdingsleep>
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	85 c0                	test   %eax,%eax
80101e96:	0f 84 30 01 00 00    	je     80101fcc <namex+0x23c>
80101e9c:	8b 56 08             	mov    0x8(%esi),%edx
80101e9f:	85 d2                	test   %edx,%edx
80101ea1:	0f 8e 25 01 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101ea7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	52                   	push   %edx
80101eae:	e8 3d 2b 00 00       	call   801049f0 <releasesleep>
  iput(ip);
80101eb3:	89 34 24             	mov    %esi,(%esp)
80101eb6:	89 fe                	mov    %edi,%esi
80101eb8:	e8 f3 f9 ff ff       	call   801018b0 <iput>
80101ebd:	83 c4 10             	add    $0x10,%esp
80101ec0:	e9 16 ff ff ff       	jmp    80101ddb <namex+0x4b>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ec8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ecb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ed4:	50                   	push   %eax
80101ed5:	53                   	push   %ebx
    name[len] = 0;
80101ed6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ed8:	ff 75 e4             	push   -0x1c(%ebp)
80101edb:	e8 e0 2e 00 00       	call   80104dc0 <memmove>
    name[len] = 0;
80101ee0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 02 00             	movb   $0x0,(%edx)
80101ee9:	e9 41 ff ff ff       	jmp    80101e2f <namex+0x9f>
80101eee:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ef0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ef3:	85 c0                	test   %eax,%eax
80101ef5:	0f 85 be 00 00 00    	jne    80101fb9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efe:	89 f0                	mov    %esi,%eax
80101f00:	5b                   	pop    %ebx
80101f01:	5e                   	pop    %esi
80101f02:	5f                   	pop    %edi
80101f03:	5d                   	pop    %ebp
80101f04:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f08:	89 df                	mov    %ebx,%edi
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb c0                	jmp    80101ece <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f0e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f13:	b8 01 00 00 00       	mov    $0x1,%eax
80101f18:	e8 33 f4 ff ff       	call   80101350 <iget>
80101f1d:	89 c6                	mov    %eax,%esi
80101f1f:	e9 b7 fe ff ff       	jmp    80101ddb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f24:	83 ec 0c             	sub    $0xc,%esp
80101f27:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f2a:	53                   	push   %ebx
80101f2b:	e8 00 2b 00 00       	call   80104a30 <holdingsleep>
80101f30:	83 c4 10             	add    $0x10,%esp
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 91 00 00 00    	je     80101fcc <namex+0x23c>
80101f3b:	8b 46 08             	mov    0x8(%esi),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	0f 8e 86 00 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	53                   	push   %ebx
80101f4a:	e8 a1 2a 00 00       	call   801049f0 <releasesleep>
  iput(ip);
80101f4f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f52:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f54:	e8 57 f9 ff ff       	call   801018b0 <iput>
      return 0;
80101f59:	83 c4 10             	add    $0x10,%esp
}
80101f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5f:	89 f0                	mov    %esi,%eax
80101f61:	5b                   	pop    %ebx
80101f62:	5e                   	pop    %esi
80101f63:	5f                   	pop    %edi
80101f64:	5d                   	pop    %ebp
80101f65:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f6c:	52                   	push   %edx
80101f6d:	e8 be 2a 00 00       	call   80104a30 <holdingsleep>
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 53                	je     80101fcc <namex+0x23c>
80101f79:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f7c:	85 c9                	test   %ecx,%ecx
80101f7e:	7e 4c                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f83:	83 ec 0c             	sub    $0xc,%esp
80101f86:	52                   	push   %edx
80101f87:	eb c1                	jmp    80101f4a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f89:	83 ec 0c             	sub    $0xc,%esp
80101f8c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f8f:	53                   	push   %ebx
80101f90:	e8 9b 2a 00 00       	call   80104a30 <holdingsleep>
80101f95:	83 c4 10             	add    $0x10,%esp
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	74 30                	je     80101fcc <namex+0x23c>
80101f9c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f9f:	85 ff                	test   %edi,%edi
80101fa1:	7e 29                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101fa3:	83 ec 0c             	sub    $0xc,%esp
80101fa6:	53                   	push   %ebx
80101fa7:	e8 44 2a 00 00       	call   801049f0 <releasesleep>
}
80101fac:	83 c4 10             	add    $0x10,%esp
}
80101faf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb2:	89 f0                	mov    %esi,%eax
80101fb4:	5b                   	pop    %ebx
80101fb5:	5e                   	pop    %esi
80101fb6:	5f                   	pop    %edi
80101fb7:	5d                   	pop    %ebp
80101fb8:	c3                   	ret    
    iput(ip);
80101fb9:	83 ec 0c             	sub    $0xc,%esp
80101fbc:	56                   	push   %esi
    return 0;
80101fbd:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fbf:	e8 ec f8 ff ff       	call   801018b0 <iput>
    return 0;
80101fc4:	83 c4 10             	add    $0x10,%esp
80101fc7:	e9 2f ff ff ff       	jmp    80101efb <namex+0x16b>
    panic("iunlock");
80101fcc:	83 ec 0c             	sub    $0xc,%esp
80101fcf:	68 9f 7a 10 80       	push   $0x80107a9f
80101fd4:	e8 a7 e3 ff ff       	call   80100380 <panic>
80101fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <dirlink>:
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	83 ec 20             	sub    $0x20,%esp
80101fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fec:	6a 00                	push   $0x0
80101fee:	ff 75 0c             	push   0xc(%ebp)
80101ff1:	53                   	push   %ebx
80101ff2:	e8 e9 fc ff ff       	call   80101ce0 <dirlookup>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	85 c0                	test   %eax,%eax
80101ffc:	75 67                	jne    80102065 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ffe:	8b 7b 58             	mov    0x58(%ebx),%edi
80102001:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102004:	85 ff                	test   %edi,%edi
80102006:	74 29                	je     80102031 <dirlink+0x51>
80102008:	31 ff                	xor    %edi,%edi
8010200a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010200d:	eb 09                	jmp    80102018 <dirlink+0x38>
8010200f:	90                   	nop
80102010:	83 c7 10             	add    $0x10,%edi
80102013:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102016:	73 19                	jae    80102031 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102018:	6a 10                	push   $0x10
8010201a:	57                   	push   %edi
8010201b:	56                   	push   %esi
8010201c:	53                   	push   %ebx
8010201d:	e8 6e fa ff ff       	call   80101a90 <readi>
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	83 f8 10             	cmp    $0x10,%eax
80102028:	75 4e                	jne    80102078 <dirlink+0x98>
    if(de.inum == 0)
8010202a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010202f:	75 df                	jne    80102010 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102031:	83 ec 04             	sub    $0x4,%esp
80102034:	8d 45 da             	lea    -0x26(%ebp),%eax
80102037:	6a 0e                	push   $0xe
80102039:	ff 75 0c             	push   0xc(%ebp)
8010203c:	50                   	push   %eax
8010203d:	e8 3e 2e 00 00       	call   80104e80 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102042:	6a 10                	push   $0x10
  de.inum = inum;
80102044:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102047:	57                   	push   %edi
80102048:	56                   	push   %esi
80102049:	53                   	push   %ebx
  de.inum = inum;
8010204a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010204e:	e8 3d fb ff ff       	call   80101b90 <writei>
80102053:	83 c4 20             	add    $0x20,%esp
80102056:	83 f8 10             	cmp    $0x10,%eax
80102059:	75 2a                	jne    80102085 <dirlink+0xa5>
  return 0;
8010205b:	31 c0                	xor    %eax,%eax
}
8010205d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102060:	5b                   	pop    %ebx
80102061:	5e                   	pop    %esi
80102062:	5f                   	pop    %edi
80102063:	5d                   	pop    %ebp
80102064:	c3                   	ret    
    iput(ip);
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	50                   	push   %eax
80102069:	e8 42 f8 ff ff       	call   801018b0 <iput>
    return -1;
8010206e:	83 c4 10             	add    $0x10,%esp
80102071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102076:	eb e5                	jmp    8010205d <dirlink+0x7d>
      panic("dirlink read");
80102078:	83 ec 0c             	sub    $0xc,%esp
8010207b:	68 c8 7a 10 80       	push   $0x80107ac8
80102080:	e8 fb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	68 0e 81 10 80       	push   $0x8010810e
8010208d:	e8 ee e2 ff ff       	call   80100380 <panic>
80102092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020a0 <namei>:

struct inode*
namei(char *path)
{
801020a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020a1:	31 d2                	xor    %edx,%edx
{
801020a3:	89 e5                	mov    %esp,%ebp
801020a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020a8:	8b 45 08             	mov    0x8(%ebp),%eax
801020ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ae:	e8 dd fc ff ff       	call   80101d90 <namex>
}
801020b3:	c9                   	leave  
801020b4:	c3                   	ret    
801020b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020c0:	55                   	push   %ebp
  return namex(path, 1, name);
801020c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020cf:	e9 bc fc ff ff       	jmp    80101d90 <namex>
801020d4:	66 90                	xchg   %ax,%ax
801020d6:	66 90                	xchg   %ax,%ax
801020d8:	66 90                	xchg   %ax,%ax
801020da:	66 90                	xchg   %ax,%ax
801020dc:	66 90                	xchg   %ax,%ax
801020de:	66 90                	xchg   %ax,%ax

801020e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020e9:	85 c0                	test   %eax,%eax
801020eb:	0f 84 b4 00 00 00    	je     801021a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020f1:	8b 70 08             	mov    0x8(%eax),%esi
801020f4:	89 c3                	mov    %eax,%ebx
801020f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020fc:	0f 87 96 00 00 00    	ja     80102198 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102102:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010210e:	66 90                	xchg   %ax,%ax
80102110:	89 ca                	mov    %ecx,%edx
80102112:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102113:	83 e0 c0             	and    $0xffffffc0,%eax
80102116:	3c 40                	cmp    $0x40,%al
80102118:	75 f6                	jne    80102110 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010211a:	31 ff                	xor    %edi,%edi
8010211c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102121:	89 f8                	mov    %edi,%eax
80102123:	ee                   	out    %al,(%dx)
80102124:	b8 01 00 00 00       	mov    $0x1,%eax
80102129:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010212e:	ee                   	out    %al,(%dx)
8010212f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102134:	89 f0                	mov    %esi,%eax
80102136:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102137:	89 f0                	mov    %esi,%eax
80102139:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010213e:	c1 f8 08             	sar    $0x8,%eax
80102141:	ee                   	out    %al,(%dx)
80102142:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102147:	89 f8                	mov    %edi,%eax
80102149:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010214a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010214e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102153:	c1 e0 04             	shl    $0x4,%eax
80102156:	83 e0 10             	and    $0x10,%eax
80102159:	83 c8 e0             	or     $0xffffffe0,%eax
8010215c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010215d:	f6 03 04             	testb  $0x4,(%ebx)
80102160:	75 16                	jne    80102178 <idestart+0x98>
80102162:	b8 20 00 00 00       	mov    $0x20,%eax
80102167:	89 ca                	mov    %ecx,%edx
80102169:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010216a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010216d:	5b                   	pop    %ebx
8010216e:	5e                   	pop    %esi
8010216f:	5f                   	pop    %edi
80102170:	5d                   	pop    %ebp
80102171:	c3                   	ret    
80102172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102178:	b8 30 00 00 00       	mov    $0x30,%eax
8010217d:	89 ca                	mov    %ecx,%edx
8010217f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102180:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102185:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102188:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010218d:	fc                   	cld    
8010218e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102190:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102193:	5b                   	pop    %ebx
80102194:	5e                   	pop    %esi
80102195:	5f                   	pop    %edi
80102196:	5d                   	pop    %ebp
80102197:	c3                   	ret    
    panic("incorrect blockno");
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 34 7b 10 80       	push   $0x80107b34
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 2b 7b 10 80       	push   $0x80107b2b
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ideinit>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021c6:	68 46 7b 10 80       	push   $0x80107b46
801021cb:	68 00 26 11 80       	push   $0x80112600
801021d0:	e8 ab 28 00 00       	call   80104a80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021d5:	58                   	pop    %eax
801021d6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021db:	5a                   	pop    %edx
801021dc:	83 e8 01             	sub    $0x1,%eax
801021df:	50                   	push   %eax
801021e0:	6a 0e                	push   $0xe
801021e2:	e8 99 02 00 00       	call   80102480 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ef:	90                   	nop
801021f0:	ec                   	in     (%dx),%al
801021f1:	83 e0 c0             	and    $0xffffffc0,%eax
801021f4:	3c 40                	cmp    $0x40,%al
801021f6:	75 f8                	jne    801021f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102202:	ee                   	out    %al,(%dx)
80102203:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102208:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220d:	eb 06                	jmp    80102215 <ideinit+0x55>
8010220f:	90                   	nop
  for(i=0; i<1000; i++){
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x64>
80102215:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x50>
      havedisk1 = 1;
8010221a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102221:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102224:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102229:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010222e:	ee                   	out    %al,(%dx)
}
8010222f:	c9                   	leave  
80102230:	c3                   	ret    
80102231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop

80102240 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102249:	68 00 26 11 80       	push   $0x80112600
8010224e:	e8 fd 29 00 00       	call   80104c50 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	75 2f                	jne    801022a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102272:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax
80102280:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102281:	89 c1                	mov    %eax,%ecx
80102283:	83 e1 c0             	and    $0xffffffc0,%ecx
80102286:	80 f9 40             	cmp    $0x40,%cl
80102289:	75 f5                	jne    80102280 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010228b:	a8 21                	test   $0x21,%al
8010228d:	75 12                	jne    801022a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010228f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102292:	b9 80 00 00 00       	mov    $0x80,%ecx
80102297:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010229c:	fc                   	cld    
8010229d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010229f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022a7:	83 ce 02             	or     $0x2,%esi
801022aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022ac:	53                   	push   %ebx
801022ad:	e8 9e 1c 00 00       	call   80103f50 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022b2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
    idestart(idequeue);
801022be:	e8 1d fe ff ff       	call   801020e0 <idestart>
    release(&idelock);
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 26 11 80       	push   $0x80112600
801022cb:	e8 20 29 00 00       	call   80104bf0 <release>

  release(&idelock);
}
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	5b                   	pop    %ebx
801022d4:	5e                   	pop    %esi
801022d5:	5f                   	pop    %edi
801022d6:	5d                   	pop    %ebp
801022d7:	c3                   	ret    
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop

801022e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 3d 27 00 00       	call   80104a30 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 c3 00 00 00    	je     801023c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 a8 00 00 00    	je     801023b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 26 11 80       	push   $0x80112600
80102328:	e8 23 29 00 00       	call   80104c50 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102332:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102339:	83 c4 10             	add    $0x10,%esp
8010233c:	85 c0                	test   %eax,%eax
8010233e:	74 60                	je     801023a0 <iderw+0xc0>
80102340:	89 c2                	mov    %eax,%edx
80102342:	8b 40 58             	mov    0x58(%eax),%eax
80102345:	85 c0                	test   %eax,%eax
80102347:	75 f7                	jne    80102340 <iderw+0x60>
80102349:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010234c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010234e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102354:	74 3a                	je     80102390 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102356:	8b 03                	mov    (%ebx),%eax
80102358:	83 e0 06             	and    $0x6,%eax
8010235b:	83 f8 02             	cmp    $0x2,%eax
8010235e:	74 1b                	je     8010237b <iderw+0x9b>
    sleep(b, &idelock);
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 00 26 11 80       	push   $0x80112600
80102368:	53                   	push   %ebx
80102369:	e8 02 1b 00 00       	call   80103e70 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
  }


  release(&idelock);
8010237b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave  
  release(&idelock);
80102386:	e9 65 28 00 00       	jmp    80104bf0 <release>
8010238b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010238f:	90                   	nop
    idestart(b);
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 49 fd ff ff       	call   801020e0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023a0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 75 7b 10 80       	push   $0x80107b75
801023af:	e8 cc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 60 7b 10 80       	push   $0x80107b60
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 4a 7b 10 80       	push   $0x80107b4a
801023c9:	e8 b2 df ff ff       	call   80100380 <panic>
801023ce:	66 90                	xchg   %ax,%ax

801023d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023d0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023d1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023d8:	00 c0 fe 
{
801023db:	89 e5                	mov    %esp,%ebp
801023dd:	56                   	push   %esi
801023de:	53                   	push   %ebx
  ioapic->reg = reg;
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
  return ioapic->data;
801023e9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023f8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102405:	c1 ee 10             	shr    $0x10,%esi
80102408:	89 f0                	mov    %esi,%eax
8010240a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010240d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102410:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102413:	39 c2                	cmp    %eax,%edx
80102415:	74 16                	je     8010242d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 94 7b 10 80       	push   $0x80107b94
8010241f:	e8 7c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102424:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010242a:	83 c4 10             	add    $0x10,%esp
8010242d:	83 c6 21             	add    $0x21,%esi
{
80102430:	ba 10 00 00 00       	mov    $0x10,%edx
80102435:	b8 20 00 00 00       	mov    $0x20,%eax
8010243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102440:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102442:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102444:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010244a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010244d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102453:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102456:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102459:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010245c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010245e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102464:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010246b:	39 f0                	cmp    %esi,%eax
8010246d:	75 d1                	jne    80102440 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010246f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102472:	5b                   	pop    %ebx
80102473:	5e                   	pop    %esi
80102474:	5d                   	pop    %ebp
80102475:	c3                   	ret    
80102476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247d:	8d 76 00             	lea    0x0(%esi),%esi

80102480 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102480:	55                   	push   %ebp
  ioapic->reg = reg;
80102481:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102487:	89 e5                	mov    %esp,%ebp
80102489:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010248c:	8d 50 20             	lea    0x20(%eax),%edx
8010248f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102493:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102495:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010249b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010249e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801024ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801024b1:	5d                   	pop    %ebp
801024b2:	c3                   	ret    
801024b3:	66 90                	xchg   %ax,%ax
801024b5:	66 90                	xchg   %ax,%ax
801024b7:	66 90                	xchg   %ax,%ax
801024b9:	66 90                	xchg   %ax,%ax
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	53                   	push   %ebx
801024c4:	83 ec 04             	sub    $0x4,%esp
801024c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024d0:	75 76                	jne    80102548 <kfree+0x88>
801024d2:	81 fb f0 70 11 80    	cmp    $0x801170f0,%ebx
801024d8:	72 6e                	jb     80102548 <kfree+0x88>
801024da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024e5:	77 61                	ja     80102548 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024e7:	83 ec 04             	sub    $0x4,%esp
801024ea:	68 00 10 00 00       	push   $0x1000
801024ef:	6a 01                	push   $0x1
801024f1:	53                   	push   %ebx
801024f2:	e8 29 28 00 00       	call   80104d20 <memset>

  if(kmem.use_lock)
801024f7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	85 d2                	test   %edx,%edx
80102502:	75 1c                	jne    80102520 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102504:	a1 78 26 11 80       	mov    0x80112678,%eax
80102509:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010250b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102510:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102516:	85 c0                	test   %eax,%eax
80102518:	75 1e                	jne    80102538 <kfree+0x78>
    release(&kmem.lock);
}
8010251a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251d:	c9                   	leave  
8010251e:	c3                   	ret    
8010251f:	90                   	nop
    acquire(&kmem.lock);
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 40 26 11 80       	push   $0x80112640
80102528:	e8 23 27 00 00       	call   80104c50 <acquire>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	eb d2                	jmp    80102504 <kfree+0x44>
80102532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102538:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010253f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102542:	c9                   	leave  
    release(&kmem.lock);
80102543:	e9 a8 26 00 00       	jmp    80104bf0 <release>
    panic("kfree");
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	68 c6 7b 10 80       	push   $0x80107bc6
80102550:	e8 2b de ff ff       	call   80100380 <panic>
80102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <freerange>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102564:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102567:	8b 75 0c             	mov    0xc(%ebp),%esi
8010256a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <freerange+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 23 ff ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 f3                	cmp    %esi,%ebx
801025a2:	76 e4                	jbe    80102588 <freerange+0x28>
}
801025a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a7:	5b                   	pop    %ebx
801025a8:	5e                   	pop    %esi
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <kinit2>:
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025b4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ba:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025cd:	39 de                	cmp    %ebx,%esi
801025cf:	72 23                	jb     801025f4 <kinit2+0x44>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025d8:	83 ec 0c             	sub    $0xc,%esp
801025db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025e7:	50                   	push   %eax
801025e8:	e8 d3 fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ed:	83 c4 10             	add    $0x10,%esp
801025f0:	39 de                	cmp    %ebx,%esi
801025f2:	73 e4                	jae    801025d8 <kinit2+0x28>
  kmem.use_lock = 1;
801025f4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025fb:	00 00 00 
}
801025fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5d                   	pop    %ebp
80102604:	c3                   	ret    
80102605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102610 <kinit1>:
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	56                   	push   %esi
80102614:	53                   	push   %ebx
80102615:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102618:	83 ec 08             	sub    $0x8,%esp
8010261b:	68 cc 7b 10 80       	push   $0x80107bcc
80102620:	68 40 26 11 80       	push   $0x80112640
80102625:	e8 56 24 00 00       	call   80104a80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010262a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102630:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102637:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010263a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102640:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102646:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264c:	39 de                	cmp    %ebx,%esi
8010264e:	72 1c                	jb     8010266c <kinit1+0x5c>
    kfree(p);
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102659:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010265f:	50                   	push   %eax
80102660:	e8 5b fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102665:	83 c4 10             	add    $0x10,%esp
80102668:	39 de                	cmp    %ebx,%esi
8010266a:	73 e4                	jae    80102650 <kinit1+0x40>
}
8010266c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010266f:	5b                   	pop    %ebx
80102670:	5e                   	pop    %esi
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102680 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102680:	a1 74 26 11 80       	mov    0x80112674,%eax
80102685:	85 c0                	test   %eax,%eax
80102687:	75 1f                	jne    801026a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102689:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 0e                	je     801026a0 <kalloc+0x20>
    kmem.freelist = r->next;
80102692:	8b 10                	mov    (%eax),%edx
80102694:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010269a:	c3                   	ret    
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801026a0:	c3                   	ret    
801026a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801026a8:	55                   	push   %ebp
801026a9:	89 e5                	mov    %esp,%ebp
801026ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801026ae:	68 40 26 11 80       	push   $0x80112640
801026b3:	e8 98 25 00 00       	call   80104c50 <acquire>
  r = kmem.freelist;
801026b8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801026bd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	74 08                	je     801026d2 <kalloc+0x52>
    kmem.freelist = r->next;
801026ca:	8b 08                	mov    (%eax),%ecx
801026cc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801026d2:	85 d2                	test   %edx,%edx
801026d4:	74 16                	je     801026ec <kalloc+0x6c>
    release(&kmem.lock);
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026dc:	68 40 26 11 80       	push   $0x80112640
801026e1:	e8 0a 25 00 00       	call   80104bf0 <release>
  return (char*)r;
801026e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026e9:	83 c4 10             	add    $0x10,%esp
}
801026ec:	c9                   	leave  
801026ed:	c3                   	ret    
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <kbdgetc>:
801026f0:	ba 64 00 00 00       	mov    $0x64,%edx
801026f5:	ec                   	in     (%dx),%al
801026f6:	a8 01                	test   $0x1,%al
801026f8:	0f 84 c2 00 00 00    	je     801027c0 <kbdgetc+0xd0>
801026fe:	55                   	push   %ebp
801026ff:	ba 60 00 00 00       	mov    $0x60,%edx
80102704:	89 e5                	mov    %esp,%ebp
80102706:	53                   	push   %ebx
80102707:	ec                   	in     (%dx),%al
80102708:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
8010270e:	0f b6 c8             	movzbl %al,%ecx
80102711:	3c e0                	cmp    $0xe0,%al
80102713:	74 5b                	je     80102770 <kbdgetc+0x80>
80102715:	89 da                	mov    %ebx,%edx
80102717:	83 e2 40             	and    $0x40,%edx
8010271a:	84 c0                	test   %al,%al
8010271c:	78 62                	js     80102780 <kbdgetc+0x90>
8010271e:	85 d2                	test   %edx,%edx
80102720:	74 09                	je     8010272b <kbdgetc+0x3b>
80102722:	83 c8 80             	or     $0xffffff80,%eax
80102725:	83 e3 bf             	and    $0xffffffbf,%ebx
80102728:	0f b6 c8             	movzbl %al,%ecx
8010272b:	0f b6 91 00 7d 10 80 	movzbl -0x7fef8300(%ecx),%edx
80102732:	0f b6 81 00 7c 10 80 	movzbl -0x7fef8400(%ecx),%eax
80102739:	09 da                	or     %ebx,%edx
8010273b:	31 c2                	xor    %eax,%edx
8010273d:	89 d0                	mov    %edx,%eax
8010273f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
80102745:	83 e0 03             	and    $0x3,%eax
80102748:	83 e2 08             	and    $0x8,%edx
8010274b:	8b 04 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%eax
80102752:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80102756:	74 0b                	je     80102763 <kbdgetc+0x73>
80102758:	8d 50 9f             	lea    -0x61(%eax),%edx
8010275b:	83 fa 19             	cmp    $0x19,%edx
8010275e:	77 48                	ja     801027a8 <kbdgetc+0xb8>
80102760:	83 e8 20             	sub    $0x20,%eax
80102763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102766:	c9                   	leave  
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop
80102770:	83 cb 40             	or     $0x40,%ebx
80102773:	31 c0                	xor    %eax,%eax
80102775:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave  
8010277f:	c3                   	ret    
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
80102788:	0f b6 81 00 7d 10 80 	movzbl -0x7fef8300(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
80102799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010279c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
801027a1:	31 c0                	xor    %eax,%eax
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	8d 76 00             	lea    0x0(%esi),%esi
801027a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
801027ab:	8d 50 20             	lea    0x20(%eax),%edx
801027ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b1:	c9                   	leave  
801027b2:	83 f9 1a             	cmp    $0x1a,%ecx
801027b5:	0f 42 c2             	cmovb  %edx,%eax
801027b8:	c3                   	ret    
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027c5:	c3                   	ret    
801027c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <kbdintr>:
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
801027d6:	68 f0 26 10 80       	push   $0x801026f0
801027db:	e8 a0 e0 ff ff       	call   80100880 <consoleintr>
801027e0:	83 c4 10             	add    $0x10,%esp
801027e3:	c9                   	leave  
801027e4:	c3                   	ret    
801027e5:	66 90                	xchg   %ax,%ax
801027e7:	66 90                	xchg   %ax,%ax
801027e9:	66 90                	xchg   %ax,%ax
801027eb:	66 90                	xchg   %ax,%ax
801027ed:	66 90                	xchg   %ax,%ax
801027ef:	90                   	nop

801027f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	0f 84 cb 00 00 00    	je     801028c8 <lapicinit+0xd8>
  lapic[index] = value;
801027fd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102804:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102811:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102817:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010281e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102838:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102845:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102848:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010284b:	8b 50 30             	mov    0x30(%eax),%edx
8010284e:	c1 ea 10             	shr    $0x10,%edx
80102851:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102857:	75 77                	jne    801028d0 <lapicinit+0xe0>
  lapic[index] = value;
80102859:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102860:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102866:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102870:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102873:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102880:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102887:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010288d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102894:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102897:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010289a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028a4:	8b 50 20             	mov    0x20(%eax),%edx
801028a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ae:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028b6:	80 e6 10             	and    $0x10,%dh
801028b9:	75 f5                	jne    801028b0 <lapicinit+0xc0>
  lapic[index] = value;
801028bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028c8:	c3                   	ret    
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028da:	8b 50 20             	mov    0x20(%eax),%edx
}
801028dd:	e9 77 ff ff ff       	jmp    80102859 <lapicinit+0x69>
801028e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028f5:	85 c0                	test   %eax,%eax
801028f7:	74 07                	je     80102900 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028f9:	8b 40 20             	mov    0x20(%eax),%eax
801028fc:	c1 e8 18             	shr    $0x18,%eax
801028ff:	c3                   	ret    
    return 0;
80102900:	31 c0                	xor    %eax,%eax
}
80102902:	c3                   	ret    
80102903:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102910 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102910:	a1 80 26 11 80       	mov    0x80112680,%eax
80102915:	85 c0                	test   %eax,%eax
80102917:	74 0d                	je     80102926 <lapiceoi+0x16>
  lapic[index] = value;
80102919:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102920:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102923:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102926:	c3                   	ret    
80102927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292e:	66 90                	xchg   %ax,%ax

80102930 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102930:	c3                   	ret    
80102931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293f:	90                   	nop

80102940 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102940:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102941:	b8 0f 00 00 00       	mov    $0xf,%eax
80102946:	ba 70 00 00 00       	mov    $0x70,%edx
8010294b:	89 e5                	mov    %esp,%ebp
8010294d:	53                   	push   %ebx
8010294e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102954:	ee                   	out    %al,(%dx)
80102955:	b8 0a 00 00 00       	mov    $0xa,%eax
8010295a:	ba 71 00 00 00       	mov    $0x71,%edx
8010295f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102960:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102962:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102965:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010296b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010296d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102970:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102972:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102975:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102978:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010297e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102983:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102989:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010298c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102993:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102996:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102999:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029cd:	c9                   	leave  
801029ce:	c3                   	ret    
801029cf:	90                   	nop

801029d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029d0:	55                   	push   %ebp
801029d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029d6:	ba 70 00 00 00       	mov    $0x70,%edx
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	57                   	push   %edi
801029de:	56                   	push   %esi
801029df:	53                   	push   %ebx
801029e0:	83 ec 4c             	sub    $0x4c,%esp
801029e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	ba 71 00 00 00       	mov    $0x71,%edx
801029e9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801029f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029f5:	8d 76 00             	lea    0x0(%esi),%esi
801029f8:	31 c0                	xor    %eax,%eax
801029fa:	89 da                	mov    %ebx,%edx
801029fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a02:	89 ca                	mov    %ecx,%edx
80102a04:	ec                   	in     (%dx),%al
80102a05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a08:	89 da                	mov    %ebx,%edx
80102a0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a10:	89 ca                	mov    %ecx,%edx
80102a12:	ec                   	in     (%dx),%al
80102a13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a16:	89 da                	mov    %ebx,%edx
80102a18:	b8 04 00 00 00       	mov    $0x4,%eax
80102a1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1e:	89 ca                	mov    %ecx,%edx
80102a20:	ec                   	in     (%dx),%al
80102a21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a24:	89 da                	mov    %ebx,%edx
80102a26:	b8 07 00 00 00       	mov    $0x7,%eax
80102a2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
80102a2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a32:	89 da                	mov    %ebx,%edx
80102a34:	b8 08 00 00 00       	mov    $0x8,%eax
80102a39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3a:	89 ca                	mov    %ecx,%edx
80102a3c:	ec                   	in     (%dx),%al
80102a3d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a3f:	89 da                	mov    %ebx,%edx
80102a41:	b8 09 00 00 00       	mov    $0x9,%eax
80102a46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a47:	89 ca                	mov    %ecx,%edx
80102a49:	ec                   	in     (%dx),%al
80102a4a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4c:	89 da                	mov    %ebx,%edx
80102a4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a54:	89 ca                	mov    %ecx,%edx
80102a56:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a57:	84 c0                	test   %al,%al
80102a59:	78 9d                	js     801029f8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	0f b6 fa             	movzbl %dl,%edi
80102a64:	89 f2                	mov    %esi,%edx
80102a66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a6d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 da                	mov    %ebx,%edx
80102a72:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a75:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a78:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a7c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a7f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a82:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a86:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a89:	31 c0                	xor    %eax,%eax
80102a8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 da                	mov    %ebx,%edx
80102a94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a97:	b8 02 00 00 00       	mov    $0x2,%eax
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa3:	89 da                	mov    %ebx,%edx
80102aa5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102aa8:	b8 04 00 00 00       	mov    $0x4,%eax
80102aad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
80102ab1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab4:	89 da                	mov    %ebx,%edx
80102ab6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ab9:	b8 07 00 00 00       	mov    $0x7,%eax
80102abe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
80102ac2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac5:	89 da                	mov    %ebx,%edx
80102ac7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aca:	b8 08 00 00 00       	mov    $0x8,%eax
80102acf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
80102ad3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad6:	89 da                	mov    %ebx,%edx
80102ad8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102adb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ae0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae1:	89 ca                	mov    %ecx,%edx
80102ae3:	ec                   	in     (%dx),%al
80102ae4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ae7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aed:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102af0:	6a 18                	push   $0x18
80102af2:	50                   	push   %eax
80102af3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102af6:	50                   	push   %eax
80102af7:	e8 74 22 00 00       	call   80104d70 <memcmp>
80102afc:	83 c4 10             	add    $0x10,%esp
80102aff:	85 c0                	test   %eax,%eax
80102b01:	0f 85 f1 fe ff ff    	jne    801029f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102b07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b0b:	75 78                	jne    80102b85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b38:	89 c2                	mov    %eax,%edx
80102b3a:	83 e0 0f             	and    $0xf,%eax
80102b3d:	c1 ea 04             	shr    $0x4,%edx
80102b40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 c2                	mov    %eax,%edx
80102b4e:	83 e0 0f             	and    $0xf,%eax
80102b51:	c1 ea 04             	shr    $0x4,%edx
80102b54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b60:	89 c2                	mov    %eax,%edx
80102b62:	83 e0 0f             	and    $0xf,%eax
80102b65:	c1 ea 04             	shr    $0x4,%edx
80102b68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b74:	89 c2                	mov    %eax,%edx
80102b76:	83 e0 0f             	and    $0xf,%eax
80102b79:	c1 ea 04             	shr    $0x4,%edx
80102b7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b85:	8b 75 08             	mov    0x8(%ebp),%esi
80102b88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b8b:	89 06                	mov    %eax,(%esi)
80102b8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b90:	89 46 04             	mov    %eax,0x4(%esi)
80102b93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b96:	89 46 08             	mov    %eax,0x8(%esi)
80102b99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b9c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ba2:	89 46 10             	mov    %eax,0x10(%esi)
80102ba5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ba8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102bab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102bb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bb5:	5b                   	pop    %ebx
80102bb6:	5e                   	pop    %esi
80102bb7:	5f                   	pop    %edi
80102bb8:	5d                   	pop    %ebp
80102bb9:	c3                   	ret    
80102bba:	66 90                	xchg   %ax,%ax
80102bbc:	66 90                	xchg   %ax,%ax
80102bbe:	66 90                	xchg   %ax,%ax

80102bc0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bc0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102bc6:	85 c9                	test   %ecx,%ecx
80102bc8:	0f 8e 8a 00 00 00    	jle    80102c58 <install_trans+0x98>
{
80102bce:	55                   	push   %ebp
80102bcf:	89 e5                	mov    %esp,%ebp
80102bd1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bd2:	31 ff                	xor    %edi,%edi
{
80102bd4:	56                   	push   %esi
80102bd5:	53                   	push   %ebx
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102be0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102be5:	83 ec 08             	sub    $0x8,%esp
80102be8:	01 f8                	add    %edi,%eax
80102bea:	83 c0 01             	add    $0x1,%eax
80102bed:	50                   	push   %eax
80102bee:	ff 35 e4 26 11 80    	push   0x801126e4
80102bf4:	e8 d7 d4 ff ff       	call   801000d0 <bread>
80102bf9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfb:	58                   	pop    %eax
80102bfc:	5a                   	pop    %edx
80102bfd:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102c04:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c0d:	e8 be d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c17:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c1a:	68 00 02 00 00       	push   $0x200
80102c1f:	50                   	push   %eax
80102c20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c23:	50                   	push   %eax
80102c24:	e8 97 21 00 00       	call   80104dc0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 7f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c31:	89 34 24             	mov    %esi,(%esp)
80102c34:	e8 b7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c39:	89 1c 24             	mov    %ebx,(%esp)
80102c3c:	e8 af d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c41:	83 c4 10             	add    $0x10,%esp
80102c44:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c4a:	7f 94                	jg     80102be0 <install_trans+0x20>
  }
}
80102c4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c4f:	5b                   	pop    %ebx
80102c50:	5e                   	pop    %esi
80102c51:	5f                   	pop    %edi
80102c52:	5d                   	pop    %ebp
80102c53:	c3                   	ret    
80102c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c58:	c3                   	ret    
80102c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	53                   	push   %ebx
80102c64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c67:	ff 35 d4 26 11 80    	push   0x801126d4
80102c6d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c73:	e8 58 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c7d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c85:	85 c0                	test   %eax,%eax
80102c87:	7e 19                	jle    80102ca2 <write_head+0x42>
80102c89:	31 d2                	xor    %edx,%edx
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c90:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c9b:	83 c2 01             	add    $0x1,%edx
80102c9e:	39 d0                	cmp    %edx,%eax
80102ca0:	75 ee                	jne    80102c90 <write_head+0x30>
  }
  bwrite(buf);
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	53                   	push   %ebx
80102ca6:	e8 05 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102cab:	89 1c 24             	mov    %ebx,(%esp)
80102cae:	e8 3d d5 ff ff       	call   801001f0 <brelse>
}
80102cb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cb6:	83 c4 10             	add    $0x10,%esp
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <initlog>:
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 2c             	sub    $0x2c,%esp
80102cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cca:	68 00 7e 10 80       	push   $0x80107e00
80102ccf:	68 a0 26 11 80       	push   $0x801126a0
80102cd4:	e8 a7 1d 00 00       	call   80104a80 <initlock>
  readsb(dev, &sb);
80102cd9:	58                   	pop    %eax
80102cda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 3b e8 ff ff       	call   80101520 <readsb>
  log.start = sb.logstart;
80102ce5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ce8:	59                   	pop    %ecx
  log.dev = dev;
80102ce9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102cef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cf2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102cf7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102cfd:	5a                   	pop    %edx
80102cfe:	50                   	push   %eax
80102cff:	53                   	push   %ebx
80102d00:	e8 cb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d0b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102d11:	85 db                	test   %ebx,%ebx
80102d13:	7e 1d                	jle    80102d32 <initlog+0x72>
80102d15:	31 d2                	xor    %edx,%edx
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d24:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d2b:	83 c2 01             	add    $0x1,%edx
80102d2e:	39 d3                	cmp    %edx,%ebx
80102d30:	75 ee                	jne    80102d20 <initlog+0x60>
  brelse(buf);
80102d32:	83 ec 0c             	sub    $0xc,%esp
80102d35:	50                   	push   %eax
80102d36:	e8 b5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d3b:	e8 80 fe ff ff       	call   80102bc0 <install_trans>
  log.lh.n = 0;
80102d40:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d47:	00 00 00 
  write_head(); // clear the log
80102d4a:	e8 11 ff ff ff       	call   80102c60 <write_head>
}
80102d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d52:	83 c4 10             	add    $0x10,%esp
80102d55:	c9                   	leave  
80102d56:	c3                   	ret    
80102d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d66:	68 a0 26 11 80       	push   $0x801126a0
80102d6b:	e8 e0 1e 00 00       	call   80104c50 <acquire>
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	eb 18                	jmp    80102d8d <begin_op+0x2d>
80102d75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d78:	83 ec 08             	sub    $0x8,%esp
80102d7b:	68 a0 26 11 80       	push   $0x801126a0
80102d80:	68 a0 26 11 80       	push   $0x801126a0
80102d85:	e8 e6 10 00 00       	call   80103e70 <sleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d8d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d92:	85 c0                	test   %eax,%eax
80102d94:	75 e2                	jne    80102d78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d96:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102da1:	83 c0 01             	add    $0x1,%eax
80102da4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102da7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102daa:	83 fa 1e             	cmp    $0x1e,%edx
80102dad:	7f c9                	jg     80102d78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102daf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102db2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102db7:	68 a0 26 11 80       	push   $0x801126a0
80102dbc:	e8 2f 1e 00 00       	call   80104bf0 <release>
      break;
    }
  }
}
80102dc1:	83 c4 10             	add    $0x10,%esp
80102dc4:	c9                   	leave  
80102dc5:	c3                   	ret    
80102dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi

80102dd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	57                   	push   %edi
80102dd4:	56                   	push   %esi
80102dd5:	53                   	push   %ebx
80102dd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dd9:	68 a0 26 11 80       	push   $0x801126a0
80102dde:	e8 6d 1e 00 00       	call   80104c50 <acquire>
  log.outstanding -= 1;
80102de3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102de8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102df1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102df4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dfa:	85 f6                	test   %esi,%esi
80102dfc:	0f 85 22 01 00 00    	jne    80102f24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e02:	85 db                	test   %ebx,%ebx
80102e04:	0f 85 f6 00 00 00    	jne    80102f00 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e0a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 a0 26 11 80       	push   $0x801126a0
80102e1c:	e8 cf 1d 00 00       	call   80104bf0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e21:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e27:	83 c4 10             	add    $0x10,%esp
80102e2a:	85 c9                	test   %ecx,%ecx
80102e2c:	7f 42                	jg     80102e70 <end_op+0xa0>
    acquire(&log.lock);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	68 a0 26 11 80       	push   $0x801126a0
80102e36:	e8 15 1e 00 00       	call   80104c50 <acquire>
    wakeup(&log);
80102e3b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e42:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e49:	00 00 00 
    wakeup(&log);
80102e4c:	e8 ff 10 00 00       	call   80103f50 <wakeup>
    release(&log.lock);
80102e51:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e58:	e8 93 1d 00 00       	call   80104bf0 <release>
80102e5d:	83 c4 10             	add    $0x10,%esp
}
80102e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e63:	5b                   	pop    %ebx
80102e64:	5e                   	pop    %esi
80102e65:	5f                   	pop    %edi
80102e66:	5d                   	pop    %ebp
80102e67:	c3                   	ret    
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e70:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e75:	83 ec 08             	sub    $0x8,%esp
80102e78:	01 d8                	add    %ebx,%eax
80102e7a:	83 c0 01             	add    $0x1,%eax
80102e7d:	50                   	push   %eax
80102e7e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e84:	e8 47 d2 ff ff       	call   801000d0 <bread>
80102e89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8b:	58                   	pop    %eax
80102e8c:	5a                   	pop    %edx
80102e8d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e94:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e9d:	e8 2e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102ea2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ea5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ea7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eaa:	68 00 02 00 00       	push   $0x200
80102eaf:	50                   	push   %eax
80102eb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102eb3:	50                   	push   %eax
80102eb4:	e8 07 1f 00 00       	call   80104dc0 <memmove>
    bwrite(to);  // write the log
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 ef d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102ec1:	89 3c 24             	mov    %edi,(%esp)
80102ec4:	e8 27 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102ec9:	89 34 24             	mov    %esi,(%esp)
80102ecc:	e8 1f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ed1:	83 c4 10             	add    $0x10,%esp
80102ed4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eda:	7c 94                	jl     80102e70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102edc:	e8 7f fd ff ff       	call   80102c60 <write_head>
    install_trans(); // Now install writes to home locations
80102ee1:	e8 da fc ff ff       	call   80102bc0 <install_trans>
    log.lh.n = 0;
80102ee6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102eed:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ef0:	e8 6b fd ff ff       	call   80102c60 <write_head>
80102ef5:	e9 34 ff ff ff       	jmp    80102e2e <end_op+0x5e>
80102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 a0 26 11 80       	push   $0x801126a0
80102f08:	e8 43 10 00 00       	call   80103f50 <wakeup>
  release(&log.lock);
80102f0d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f14:	e8 d7 1c 00 00       	call   80104bf0 <release>
80102f19:	83 c4 10             	add    $0x10,%esp
}
80102f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1f:	5b                   	pop    %ebx
80102f20:	5e                   	pop    %esi
80102f21:	5f                   	pop    %edi
80102f22:	5d                   	pop    %ebp
80102f23:	c3                   	ret    
    panic("log.committing");
80102f24:	83 ec 0c             	sub    $0xc,%esp
80102f27:	68 04 7e 10 80       	push   $0x80107e04
80102f2c:	e8 4f d4 ff ff       	call   80100380 <panic>
80102f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop

80102f40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	53                   	push   %ebx
80102f44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f47:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f50:	83 fa 1d             	cmp    $0x1d,%edx
80102f53:	0f 8f 85 00 00 00    	jg     80102fde <log_write+0x9e>
80102f59:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f5e:	83 e8 01             	sub    $0x1,%eax
80102f61:	39 c2                	cmp    %eax,%edx
80102f63:	7d 79                	jge    80102fde <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f65:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	7e 7d                	jle    80102feb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f6e:	83 ec 0c             	sub    $0xc,%esp
80102f71:	68 a0 26 11 80       	push   $0x801126a0
80102f76:	e8 d5 1c 00 00       	call   80104c50 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	85 d2                	test   %edx,%edx
80102f86:	7e 4a                	jle    80102fd2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f88:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	31 c0                	xor    %eax,%eax
80102f8d:	eb 08                	jmp    80102f97 <log_write+0x57>
80102f8f:	90                   	nop
80102f90:	83 c0 01             	add    $0x1,%eax
80102f93:	39 c2                	cmp    %eax,%edx
80102f95:	74 29                	je     80102fc0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f97:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fad:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102fb4:	c9                   	leave  
  release(&log.lock);
80102fb5:	e9 36 1c 00 00       	jmp    80104bf0 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fc0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102fda:	75 cb                	jne    80102fa7 <log_write+0x67>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x87>
    panic("too big a transaction");
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 13 7e 10 80       	push   $0x80107e13
80102fe6:	e8 95 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 29 7e 10 80       	push   $0x80107e29
80102ff3:	e8 88 d3 ff ff       	call   80100380 <panic>
80102ff8:	66 90                	xchg   %ax,%ax
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103007:	e8 84 0a 00 00       	call   80103a90 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 7d 0a 00 00       	call   80103a90 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 44 7e 10 80       	push   $0x80107e44
8010301d:	e8 7e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103022:	e8 89 30 00 00       	call   801060b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103027:	e8 04 0a 00 00       	call   80103a30 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  cprintf("heading to scheduler\n");
8010303a:	c7 04 24 58 7e 10 80 	movl   $0x80107e58,(%esp)
80103041:	e8 5a d6 ff ff       	call   801006a0 <cprintf>
  scheduler();     // start running processes
80103046:	e8 f5 0f 00 00       	call   80104040 <scheduler>
8010304b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010304f:	90                   	nop

80103050 <mpenter>:
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103056:	e8 45 41 00 00       	call   801071a0 <switchkvm>
  seginit();
8010305b:	e8 b0 40 00 00       	call   80107110 <seginit>
  lapicinit();
80103060:	e8 8b f7 ff ff       	call   801027f0 <lapicinit>
  mpmain();
80103065:	e8 96 ff ff ff       	call   80103000 <mpmain>
8010306a:	66 90                	xchg   %ax,%ax
8010306c:	66 90                	xchg   %ax,%ax
8010306e:	66 90                	xchg   %ax,%ax

80103070 <main>:
{
80103070:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103074:	83 e4 f0             	and    $0xfffffff0,%esp
80103077:	ff 71 fc             	push   -0x4(%ecx)
8010307a:	55                   	push   %ebp
8010307b:	89 e5                	mov    %esp,%ebp
8010307d:	53                   	push   %ebx
8010307e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010307f:	83 ec 08             	sub    $0x8,%esp
80103082:	68 00 00 40 80       	push   $0x80400000
80103087:	68 f0 70 11 80       	push   $0x801170f0
8010308c:	e8 7f f5 ff ff       	call   80102610 <kinit1>
  kvmalloc();      // kernel page table
80103091:	e8 fa 45 00 00       	call   80107690 <kvmalloc>
  mpinit();        // detect other processors
80103096:	e8 85 01 00 00       	call   80103220 <mpinit>
  lapicinit();     // interrupt controller
8010309b:	e8 50 f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
801030a0:	e8 6b 40 00 00       	call   80107110 <seginit>
  picinit();       // disable pic
801030a5:	e8 76 03 00 00       	call   80103420 <picinit>
  ioapicinit();    // another interrupt controller
801030aa:	e8 21 f3 ff ff       	call   801023d0 <ioapicinit>
  consoleinit();   // console hardware
801030af:	e8 ac d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030b4:	e8 e7 32 00 00       	call   801063a0 <uartinit>
  pinit();         // process table
801030b9:	e8 52 09 00 00       	call   80103a10 <pinit>
  tvinit();        // trap vectors
801030be:	e8 6d 2f 00 00       	call   80106030 <tvinit>
  binit();         // buffer cache
801030c3:	e8 78 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030c8:	e8 43 dd ff ff       	call   80100e10 <fileinit>
  ideinit();       // disk 
801030cd:	e8 ee f0 ff ff       	call   801021c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030d2:	83 c4 0c             	add    $0xc,%esp
801030d5:	68 8a 00 00 00       	push   $0x8a
801030da:	68 8c b4 10 80       	push   $0x8010b48c
801030df:	68 00 70 00 80       	push   $0x80007000
801030e4:	e8 d7 1c 00 00       	call   80104dc0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030e9:	83 c4 10             	add    $0x10,%esp
801030ec:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030f3:	00 00 00 
801030f6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030fb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103100:	76 7e                	jbe    80103180 <main+0x110>
80103102:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103107:	eb 20                	jmp    80103129 <main+0xb9>
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103117:	00 00 00 
8010311a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103120:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103125:	39 c3                	cmp    %eax,%ebx
80103127:	73 57                	jae    80103180 <main+0x110>
    if(c == mycpu())  // We've started already.
80103129:	e8 02 09 00 00       	call   80103a30 <mycpu>
8010312e:	39 c3                	cmp    %eax,%ebx
80103130:	74 de                	je     80103110 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103132:	e8 49 f5 ff ff       	call   80102680 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103137:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010313a:	c7 05 f8 6f 00 80 50 	movl   $0x80103050,0x80006ff8
80103141:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103144:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010314b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010314e:	05 00 10 00 00       	add    $0x1000,%eax
80103153:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103158:	0f b6 03             	movzbl (%ebx),%eax
8010315b:	68 00 70 00 00       	push   $0x7000
80103160:	50                   	push   %eax
80103161:	e8 da f7 ff ff       	call   80102940 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103166:	83 c4 10             	add    $0x10,%esp
80103169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103170:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103176:	85 c0                	test   %eax,%eax
80103178:	74 f6                	je     80103170 <main+0x100>
8010317a:	eb 94                	jmp    80103110 <main+0xa0>
8010317c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103180:	83 ec 08             	sub    $0x8,%esp
80103183:	68 00 00 00 8e       	push   $0x8e000000
80103188:	68 00 00 40 80       	push   $0x80400000
8010318d:	e8 1e f4 ff ff       	call   801025b0 <kinit2>
  userinit();      // first user process
80103192:	e8 c9 12 00 00       	call   80104460 <userinit>
  mpmain();        // finish this processor's setup
80103197:	e8 64 fe ff ff       	call   80103000 <mpmain>
8010319c:	66 90                	xchg   %ax,%ax
8010319e:	66 90                	xchg   %ax,%ax

801031a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801031a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801031ab:	53                   	push   %ebx
  e = addr+len;
801031ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801031af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031b2:	39 de                	cmp    %ebx,%esi
801031b4:	72 10                	jb     801031c6 <mpsearch1+0x26>
801031b6:	eb 50                	jmp    80103208 <mpsearch1+0x68>
801031b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bf:	90                   	nop
801031c0:	89 fe                	mov    %edi,%esi
801031c2:	39 fb                	cmp    %edi,%ebx
801031c4:	76 42                	jbe    80103208 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031c6:	83 ec 04             	sub    $0x4,%esp
801031c9:	8d 7e 10             	lea    0x10(%esi),%edi
801031cc:	6a 04                	push   $0x4
801031ce:	68 6e 7e 10 80       	push   $0x80107e6e
801031d3:	56                   	push   %esi
801031d4:	e8 97 1b 00 00       	call   80104d70 <memcmp>
801031d9:	83 c4 10             	add    $0x10,%esp
801031dc:	85 c0                	test   %eax,%eax
801031de:	75 e0                	jne    801031c0 <mpsearch1+0x20>
801031e0:	89 f2                	mov    %esi,%edx
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031e8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031eb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031ee:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031f0:	39 fa                	cmp    %edi,%edx
801031f2:	75 f4                	jne    801031e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031f4:	84 c0                	test   %al,%al
801031f6:	75 c8                	jne    801031c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031fb:	89 f0                	mov    %esi,%eax
801031fd:	5b                   	pop    %ebx
801031fe:	5e                   	pop    %esi
801031ff:	5f                   	pop    %edi
80103200:	5d                   	pop    %ebp
80103201:	c3                   	ret    
80103202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103208:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010320b:	31 f6                	xor    %esi,%esi
}
8010320d:	5b                   	pop    %ebx
8010320e:	89 f0                	mov    %esi,%eax
80103210:	5e                   	pop    %esi
80103211:	5f                   	pop    %edi
80103212:	5d                   	pop    %ebp
80103213:	c3                   	ret    
80103214:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010321b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010321f:	90                   	nop

80103220 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	57                   	push   %edi
80103224:	56                   	push   %esi
80103225:	53                   	push   %ebx
80103226:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103229:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103230:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103237:	c1 e0 08             	shl    $0x8,%eax
8010323a:	09 d0                	or     %edx,%eax
8010323c:	c1 e0 04             	shl    $0x4,%eax
8010323f:	75 1b                	jne    8010325c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103241:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103248:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010324f:	c1 e0 08             	shl    $0x8,%eax
80103252:	09 d0                	or     %edx,%eax
80103254:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103257:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010325c:	ba 00 04 00 00       	mov    $0x400,%edx
80103261:	e8 3a ff ff ff       	call   801031a0 <mpsearch1>
80103266:	89 c3                	mov    %eax,%ebx
80103268:	85 c0                	test   %eax,%eax
8010326a:	0f 84 40 01 00 00    	je     801033b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103270:	8b 73 04             	mov    0x4(%ebx),%esi
80103273:	85 f6                	test   %esi,%esi
80103275:	0f 84 25 01 00 00    	je     801033a0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010327b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010327e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103284:	6a 04                	push   $0x4
80103286:	68 73 7e 10 80       	push   $0x80107e73
8010328b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010328c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010328f:	e8 dc 1a 00 00       	call   80104d70 <memcmp>
80103294:	83 c4 10             	add    $0x10,%esp
80103297:	85 c0                	test   %eax,%eax
80103299:	0f 85 01 01 00 00    	jne    801033a0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010329f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801032a6:	3c 01                	cmp    $0x1,%al
801032a8:	74 08                	je     801032b2 <mpinit+0x92>
801032aa:	3c 04                	cmp    $0x4,%al
801032ac:	0f 85 ee 00 00 00    	jne    801033a0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801032b2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801032b9:	66 85 d2             	test   %dx,%dx
801032bc:	74 22                	je     801032e0 <mpinit+0xc0>
801032be:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032c1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032c3:	31 d2                	xor    %edx,%edx
801032c5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032c8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032cf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032d2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032d4:	39 c7                	cmp    %eax,%edi
801032d6:	75 f0                	jne    801032c8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032d8:	84 d2                	test   %dl,%dl
801032da:	0f 85 c0 00 00 00    	jne    801033a0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032e0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032e6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032eb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032f2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801032f8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032fd:	03 55 e4             	add    -0x1c(%ebp),%edx
80103300:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103307:	90                   	nop
80103308:	39 d0                	cmp    %edx,%eax
8010330a:	73 15                	jae    80103321 <mpinit+0x101>
    switch(*p){
8010330c:	0f b6 08             	movzbl (%eax),%ecx
8010330f:	80 f9 02             	cmp    $0x2,%cl
80103312:	74 4c                	je     80103360 <mpinit+0x140>
80103314:	77 3a                	ja     80103350 <mpinit+0x130>
80103316:	84 c9                	test   %cl,%cl
80103318:	74 56                	je     80103370 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010331a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010331d:	39 d0                	cmp    %edx,%eax
8010331f:	72 eb                	jb     8010330c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103321:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103324:	85 f6                	test   %esi,%esi
80103326:	0f 84 d9 00 00 00    	je     80103405 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010332c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103330:	74 15                	je     80103347 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103332:	b8 70 00 00 00       	mov    $0x70,%eax
80103337:	ba 22 00 00 00       	mov    $0x22,%edx
8010333c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010333d:	ba 23 00 00 00       	mov    $0x23,%edx
80103342:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103343:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103346:	ee                   	out    %al,(%dx)
  }
}
80103347:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010334a:	5b                   	pop    %ebx
8010334b:	5e                   	pop    %esi
8010334c:	5f                   	pop    %edi
8010334d:	5d                   	pop    %ebp
8010334e:	c3                   	ret    
8010334f:	90                   	nop
    switch(*p){
80103350:	83 e9 03             	sub    $0x3,%ecx
80103353:	80 f9 01             	cmp    $0x1,%cl
80103356:	76 c2                	jbe    8010331a <mpinit+0xfa>
80103358:	31 f6                	xor    %esi,%esi
8010335a:	eb ac                	jmp    80103308 <mpinit+0xe8>
8010335c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103360:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103364:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103367:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010336d:	eb 99                	jmp    80103308 <mpinit+0xe8>
8010336f:	90                   	nop
      if(ncpu < NCPU) {
80103370:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103376:	83 f9 07             	cmp    $0x7,%ecx
80103379:	7f 19                	jg     80103394 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010337b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103381:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103385:	83 c1 01             	add    $0x1,%ecx
80103388:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010338e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103394:	83 c0 14             	add    $0x14,%eax
      continue;
80103397:	e9 6c ff ff ff       	jmp    80103308 <mpinit+0xe8>
8010339c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801033a0:	83 ec 0c             	sub    $0xc,%esp
801033a3:	68 78 7e 10 80       	push   $0x80107e78
801033a8:	e8 d3 cf ff ff       	call   80100380 <panic>
801033ad:	8d 76 00             	lea    0x0(%esi),%esi
{
801033b0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033b5:	eb 13                	jmp    801033ca <mpinit+0x1aa>
801033b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033be:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801033c0:	89 f3                	mov    %esi,%ebx
801033c2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033c8:	74 d6                	je     801033a0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ca:	83 ec 04             	sub    $0x4,%esp
801033cd:	8d 73 10             	lea    0x10(%ebx),%esi
801033d0:	6a 04                	push   $0x4
801033d2:	68 6e 7e 10 80       	push   $0x80107e6e
801033d7:	53                   	push   %ebx
801033d8:	e8 93 19 00 00       	call   80104d70 <memcmp>
801033dd:	83 c4 10             	add    $0x10,%esp
801033e0:	85 c0                	test   %eax,%eax
801033e2:	75 dc                	jne    801033c0 <mpinit+0x1a0>
801033e4:	89 da                	mov    %ebx,%edx
801033e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033f0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033f3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033f6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033f8:	39 d6                	cmp    %edx,%esi
801033fa:	75 f4                	jne    801033f0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033fc:	84 c0                	test   %al,%al
801033fe:	75 c0                	jne    801033c0 <mpinit+0x1a0>
80103400:	e9 6b fe ff ff       	jmp    80103270 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103405:	83 ec 0c             	sub    $0xc,%esp
80103408:	68 90 7e 10 80       	push   $0x80107e90
8010340d:	e8 6e cf ff ff       	call   80100380 <panic>
80103412:	66 90                	xchg   %ax,%ax
80103414:	66 90                	xchg   %ax,%ax
80103416:	66 90                	xchg   %ax,%ax
80103418:	66 90                	xchg   %ax,%ax
8010341a:	66 90                	xchg   %ax,%ax
8010341c:	66 90                	xchg   %ax,%ax
8010341e:	66 90                	xchg   %ax,%ax

80103420 <picinit>:
80103420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103425:	ba 21 00 00 00       	mov    $0x21,%edx
8010342a:	ee                   	out    %al,(%dx)
8010342b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103430:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103431:	c3                   	ret    
80103432:	66 90                	xchg   %ax,%ax
80103434:	66 90                	xchg   %ax,%ax
80103436:	66 90                	xchg   %ax,%ax
80103438:	66 90                	xchg   %ax,%ax
8010343a:	66 90                	xchg   %ax,%ax
8010343c:	66 90                	xchg   %ax,%ax
8010343e:	66 90                	xchg   %ax,%ax

80103440 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103440:	55                   	push   %ebp
80103441:	89 e5                	mov    %esp,%ebp
80103443:	57                   	push   %edi
80103444:	56                   	push   %esi
80103445:	53                   	push   %ebx
80103446:	83 ec 0c             	sub    $0xc,%esp
80103449:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010344c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010344f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103455:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010345b:	e8 d0 d9 ff ff       	call   80100e30 <filealloc>
80103460:	89 03                	mov    %eax,(%ebx)
80103462:	85 c0                	test   %eax,%eax
80103464:	0f 84 a8 00 00 00    	je     80103512 <pipealloc+0xd2>
8010346a:	e8 c1 d9 ff ff       	call   80100e30 <filealloc>
8010346f:	89 06                	mov    %eax,(%esi)
80103471:	85 c0                	test   %eax,%eax
80103473:	0f 84 87 00 00 00    	je     80103500 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103479:	e8 02 f2 ff ff       	call   80102680 <kalloc>
8010347e:	89 c7                	mov    %eax,%edi
80103480:	85 c0                	test   %eax,%eax
80103482:	0f 84 b0 00 00 00    	je     80103538 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103488:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010348f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103492:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103495:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010349c:	00 00 00 
  p->nwrite = 0;
8010349f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034a6:	00 00 00 
  p->nread = 0;
801034a9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034b0:	00 00 00 
  initlock(&p->lock, "pipe");
801034b3:	68 af 7e 10 80       	push   $0x80107eaf
801034b8:	50                   	push   %eax
801034b9:	e8 c2 15 00 00       	call   80104a80 <initlock>
  (*f0)->type = FD_PIPE;
801034be:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034c0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034c3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034c9:	8b 03                	mov    (%ebx),%eax
801034cb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034cf:	8b 03                	mov    (%ebx),%eax
801034d1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034d5:	8b 03                	mov    (%ebx),%eax
801034d7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034da:	8b 06                	mov    (%esi),%eax
801034dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034e2:	8b 06                	mov    (%esi),%eax
801034e4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034e8:	8b 06                	mov    (%esi),%eax
801034ea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034ee:	8b 06                	mov    (%esi),%eax
801034f0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034f6:	31 c0                	xor    %eax,%eax
}
801034f8:	5b                   	pop    %ebx
801034f9:	5e                   	pop    %esi
801034fa:	5f                   	pop    %edi
801034fb:	5d                   	pop    %ebp
801034fc:	c3                   	ret    
801034fd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103500:	8b 03                	mov    (%ebx),%eax
80103502:	85 c0                	test   %eax,%eax
80103504:	74 1e                	je     80103524 <pipealloc+0xe4>
    fileclose(*f0);
80103506:	83 ec 0c             	sub    $0xc,%esp
80103509:	50                   	push   %eax
8010350a:	e8 e1 d9 ff ff       	call   80100ef0 <fileclose>
8010350f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103512:	8b 06                	mov    (%esi),%eax
80103514:	85 c0                	test   %eax,%eax
80103516:	74 0c                	je     80103524 <pipealloc+0xe4>
    fileclose(*f1);
80103518:	83 ec 0c             	sub    $0xc,%esp
8010351b:	50                   	push   %eax
8010351c:	e8 cf d9 ff ff       	call   80100ef0 <fileclose>
80103521:	83 c4 10             	add    $0x10,%esp
}
80103524:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010352c:	5b                   	pop    %ebx
8010352d:	5e                   	pop    %esi
8010352e:	5f                   	pop    %edi
8010352f:	5d                   	pop    %ebp
80103530:	c3                   	ret    
80103531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103538:	8b 03                	mov    (%ebx),%eax
8010353a:	85 c0                	test   %eax,%eax
8010353c:	75 c8                	jne    80103506 <pipealloc+0xc6>
8010353e:	eb d2                	jmp    80103512 <pipealloc+0xd2>

80103540 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103548:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	53                   	push   %ebx
8010354f:	e8 fc 16 00 00       	call   80104c50 <acquire>
  if(writable){
80103554:	83 c4 10             	add    $0x10,%esp
80103557:	85 f6                	test   %esi,%esi
80103559:	74 65                	je     801035c0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010355b:	83 ec 0c             	sub    $0xc,%esp
8010355e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103564:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010356b:	00 00 00 
    wakeup(&p->nread);
8010356e:	50                   	push   %eax
8010356f:	e8 dc 09 00 00       	call   80103f50 <wakeup>
80103574:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103577:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010357d:	85 d2                	test   %edx,%edx
8010357f:	75 0a                	jne    8010358b <pipeclose+0x4b>
80103581:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103587:	85 c0                	test   %eax,%eax
80103589:	74 15                	je     801035a0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010358b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010358e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103591:	5b                   	pop    %ebx
80103592:	5e                   	pop    %esi
80103593:	5d                   	pop    %ebp
    release(&p->lock);
80103594:	e9 57 16 00 00       	jmp    80104bf0 <release>
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	53                   	push   %ebx
801035a4:	e8 47 16 00 00       	call   80104bf0 <release>
    kfree((char*)p);
801035a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801035ac:	83 c4 10             	add    $0x10,%esp
}
801035af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035b2:	5b                   	pop    %ebx
801035b3:	5e                   	pop    %esi
801035b4:	5d                   	pop    %ebp
    kfree((char*)p);
801035b5:	e9 06 ef ff ff       	jmp    801024c0 <kfree>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035d0:	00 00 00 
    wakeup(&p->nwrite);
801035d3:	50                   	push   %eax
801035d4:	e8 77 09 00 00       	call   80103f50 <wakeup>
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	eb 99                	jmp    80103577 <pipeclose+0x37>
801035de:	66 90                	xchg   %ax,%ax

801035e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	57                   	push   %edi
801035e4:	56                   	push   %esi
801035e5:	53                   	push   %ebx
801035e6:	83 ec 28             	sub    $0x28,%esp
801035e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035ec:	53                   	push   %ebx
801035ed:	e8 5e 16 00 00       	call   80104c50 <acquire>
  for(i = 0; i < n; i++){
801035f2:	8b 45 10             	mov    0x10(%ebp),%eax
801035f5:	83 c4 10             	add    $0x10,%esp
801035f8:	85 c0                	test   %eax,%eax
801035fa:	0f 8e c0 00 00 00    	jle    801036c0 <pipewrite+0xe0>
80103600:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103603:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103609:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010360f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103612:	03 45 10             	add    0x10(%ebp),%eax
80103615:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103618:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010361e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103624:	89 ca                	mov    %ecx,%edx
80103626:	05 00 02 00 00       	add    $0x200,%eax
8010362b:	39 c1                	cmp    %eax,%ecx
8010362d:	74 3f                	je     8010366e <pipewrite+0x8e>
8010362f:	eb 67                	jmp    80103698 <pipewrite+0xb8>
80103631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103638:	e8 73 04 00 00       	call   80103ab0 <myproc>
8010363d:	8b 48 24             	mov    0x24(%eax),%ecx
80103640:	85 c9                	test   %ecx,%ecx
80103642:	75 34                	jne    80103678 <pipewrite+0x98>
      wakeup(&p->nread);
80103644:	83 ec 0c             	sub    $0xc,%esp
80103647:	57                   	push   %edi
80103648:	e8 03 09 00 00       	call   80103f50 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010364d:	58                   	pop    %eax
8010364e:	5a                   	pop    %edx
8010364f:	53                   	push   %ebx
80103650:	56                   	push   %esi
80103651:	e8 1a 08 00 00       	call   80103e70 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103656:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103662:	83 c4 10             	add    $0x10,%esp
80103665:	05 00 02 00 00       	add    $0x200,%eax
8010366a:	39 c2                	cmp    %eax,%edx
8010366c:	75 2a                	jne    80103698 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010366e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103674:	85 c0                	test   %eax,%eax
80103676:	75 c0                	jne    80103638 <pipewrite+0x58>
        release(&p->lock);
80103678:	83 ec 0c             	sub    $0xc,%esp
8010367b:	53                   	push   %ebx
8010367c:	e8 6f 15 00 00       	call   80104bf0 <release>
        return -1;
80103681:	83 c4 10             	add    $0x10,%esp
80103684:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103689:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010368c:	5b                   	pop    %ebx
8010368d:	5e                   	pop    %esi
8010368e:	5f                   	pop    %edi
8010368f:	5d                   	pop    %ebp
80103690:	c3                   	ret    
80103691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103698:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010369b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010369e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036a4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801036aa:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801036ad:	83 c6 01             	add    $0x1,%esi
801036b0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036b3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036b7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801036ba:	0f 85 58 ff ff ff    	jne    80103618 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036c0:	83 ec 0c             	sub    $0xc,%esp
801036c3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036c9:	50                   	push   %eax
801036ca:	e8 81 08 00 00       	call   80103f50 <wakeup>
  release(&p->lock);
801036cf:	89 1c 24             	mov    %ebx,(%esp)
801036d2:	e8 19 15 00 00       	call   80104bf0 <release>
  return n;
801036d7:	8b 45 10             	mov    0x10(%ebp),%eax
801036da:	83 c4 10             	add    $0x10,%esp
801036dd:	eb aa                	jmp    80103689 <pipewrite+0xa9>
801036df:	90                   	nop

801036e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	57                   	push   %edi
801036e4:	56                   	push   %esi
801036e5:	53                   	push   %ebx
801036e6:	83 ec 18             	sub    $0x18,%esp
801036e9:	8b 75 08             	mov    0x8(%ebp),%esi
801036ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036ef:	56                   	push   %esi
801036f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036f6:	e8 55 15 00 00       	call   80104c50 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103701:	83 c4 10             	add    $0x10,%esp
80103704:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010370a:	74 2f                	je     8010373b <piperead+0x5b>
8010370c:	eb 37                	jmp    80103745 <piperead+0x65>
8010370e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103710:	e8 9b 03 00 00       	call   80103ab0 <myproc>
80103715:	8b 48 24             	mov    0x24(%eax),%ecx
80103718:	85 c9                	test   %ecx,%ecx
8010371a:	0f 85 80 00 00 00    	jne    801037a0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103720:	83 ec 08             	sub    $0x8,%esp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx
80103725:	e8 46 07 00 00       	call   80103e70 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010372a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103730:	83 c4 10             	add    $0x10,%esp
80103733:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103739:	75 0a                	jne    80103745 <piperead+0x65>
8010373b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103741:	85 c0                	test   %eax,%eax
80103743:	75 cb                	jne    80103710 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103745:	8b 55 10             	mov    0x10(%ebp),%edx
80103748:	31 db                	xor    %ebx,%ebx
8010374a:	85 d2                	test   %edx,%edx
8010374c:	7f 20                	jg     8010376e <piperead+0x8e>
8010374e:	eb 2c                	jmp    8010377c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103750:	8d 48 01             	lea    0x1(%eax),%ecx
80103753:	25 ff 01 00 00       	and    $0x1ff,%eax
80103758:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010375e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103763:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103766:	83 c3 01             	add    $0x1,%ebx
80103769:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010376c:	74 0e                	je     8010377c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010376e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103774:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010377a:	75 d4                	jne    80103750 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010377c:	83 ec 0c             	sub    $0xc,%esp
8010377f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103785:	50                   	push   %eax
80103786:	e8 c5 07 00 00       	call   80103f50 <wakeup>
  release(&p->lock);
8010378b:	89 34 24             	mov    %esi,(%esp)
8010378e:	e8 5d 14 00 00       	call   80104bf0 <release>
  return i;
80103793:	83 c4 10             	add    $0x10,%esp
}
80103796:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103799:	89 d8                	mov    %ebx,%eax
8010379b:	5b                   	pop    %ebx
8010379c:	5e                   	pop    %esi
8010379d:	5f                   	pop    %edi
8010379e:	5d                   	pop    %ebp
8010379f:	c3                   	ret    
      release(&p->lock);
801037a0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037a8:	56                   	push   %esi
801037a9:	e8 42 14 00 00       	call   80104bf0 <release>
      return -1;
801037ae:	83 c4 10             	add    $0x10,%esp
}
801037b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037b4:	89 d8                	mov    %ebx,%eax
801037b6:	5b                   	pop    %ebx
801037b7:	5e                   	pop    %esi
801037b8:	5f                   	pop    %edi
801037b9:	5d                   	pop    %ebp
801037ba:	c3                   	ret    
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c4:	bb 74 2e 11 80       	mov    $0x80112e74,%ebx
{
801037c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037cc:	68 40 2e 11 80       	push   $0x80112e40
801037d1:	e8 7a 14 00 00       	call   80104c50 <acquire>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	eb 13                	jmp    801037ee <allocproc+0x2e>
801037db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037df:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801037e6:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
801037ec:	74 7a                	je     80103868 <allocproc+0xa8>
    if(p->state == UNUSED)
801037ee:	8b 43 0c             	mov    0xc(%ebx),%eax
801037f1:	85 c0                	test   %eax,%eax
801037f3:	75 eb                	jne    801037e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037f5:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801037fa:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037fd:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103804:	89 43 10             	mov    %eax,0x10(%ebx)
80103807:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
8010380a:	68 40 2e 11 80       	push   $0x80112e40
  p->pid = nextpid++;
8010380f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103815:	e8 d6 13 00 00       	call   80104bf0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010381a:	e8 61 ee ff ff       	call   80102680 <kalloc>
8010381f:	83 c4 10             	add    $0x10,%esp
80103822:	89 43 08             	mov    %eax,0x8(%ebx)
80103825:	85 c0                	test   %eax,%eax
80103827:	74 58                	je     80103881 <allocproc+0xc1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103829:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010382f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103832:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103837:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010383a:	c7 40 14 1f 60 10 80 	movl   $0x8010601f,0x14(%eax)
  p->context = (struct context*)sp;
80103841:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103844:	6a 14                	push   $0x14
80103846:	6a 00                	push   $0x0
80103848:	50                   	push   %eax
80103849:	e8 d2 14 00 00       	call   80104d20 <memset>
  p->context->eip = (uint)forkret;
8010384e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103851:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103854:	c7 40 10 a0 38 10 80 	movl   $0x801038a0,0x10(%eax)
}
8010385b:	89 d8                	mov    %ebx,%eax
8010385d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103860:	c9                   	leave  
80103861:	c3                   	ret    
80103862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103868:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010386b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010386d:	68 40 2e 11 80       	push   $0x80112e40
80103872:	e8 79 13 00 00       	call   80104bf0 <release>
}
80103877:	89 d8                	mov    %ebx,%eax
  return 0;
80103879:	83 c4 10             	add    $0x10,%esp
}
8010387c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010387f:	c9                   	leave  
80103880:	c3                   	ret    
    p->state = UNUSED;
80103881:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103888:	31 db                	xor    %ebx,%ebx
}
8010388a:	89 d8                	mov    %ebx,%eax
8010388c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010388f:	c9                   	leave  
80103890:	c3                   	ret    
80103891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010389f:	90                   	nop

801038a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038a6:	68 40 2e 11 80       	push   $0x80112e40
801038ab:	e8 40 13 00 00       	call   80104bf0 <release>

  if (first) {
801038b0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038b5:	83 c4 10             	add    $0x10,%esp
801038b8:	85 c0                	test   %eax,%eax
801038ba:	75 04                	jne    801038c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038bc:	c9                   	leave  
801038bd:	c3                   	ret    
801038be:	66 90                	xchg   %ax,%ax
    first = 0;
801038c0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038c7:	00 00 00 
    iinit(ROOTDEV);
801038ca:	83 ec 0c             	sub    $0xc,%esp
801038cd:	6a 01                	push   $0x1
801038cf:	e8 8c dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
801038d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038db:	e8 e0 f3 ff ff       	call   80102cc0 <initlog>
}
801038e0:	83 c4 10             	add    $0x10,%esp
801038e3:	c9                   	leave  
801038e4:	c3                   	ret    
801038e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038f0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	57                   	push   %edi
801038f4:	56                   	push   %esi
801038f5:	89 c6                	mov    %eax,%esi
801038f7:	53                   	push   %ebx
  struct proc *p;
  int tick = 0;

  if(chan == &ticks){tick = 1;}

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801038f8:	bb 74 2e 11 80       	mov    $0x80112e74,%ebx
{
801038fd:	83 ec 0c             	sub    $0xc,%esp
80103900:	eb 18                	jmp    8010391a <wakeup1+0x2a>
80103902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103908:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010390e:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103914:	0f 84 e5 00 00 00    	je     801039ff <wakeup1+0x10f>
    if(p->state == SLEEPING){
8010391a:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
8010391e:	75 e8                	jne    80103908 <wakeup1+0x18>
      ptable.pstats.sleepticks[get_pstat_index(p->pid)]++;
80103920:	8b 53 10             	mov    0x10(%ebx),%edx
}

int 
get_pstat_index(int pid){
  int i;
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80103923:	31 c0                	xor    %eax,%eax
80103925:	3b 15 74 52 11 80    	cmp    0x80115274,%edx
8010392b:	74 0f                	je     8010393c <wakeup1+0x4c>
8010392d:	8d 76 00             	lea    0x0(%esi),%esi
80103930:	83 c0 01             	add    $0x1,%eax
80103933:	3b 14 85 74 52 11 80 	cmp    -0x7feead8c(,%eax,4),%edx
8010393a:	75 f4                	jne    80103930 <wakeup1+0x40>
      ptable.pstats.sleepticks[get_pstat_index(p->pid)]++;
8010393c:	83 04 85 74 56 11 80 	addl   $0x1,-0x7feea98c(,%eax,4)
80103943:	01 
    if(p->state == SLEEPING && p->chan == chan){
80103944:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103948:	75 be                	jne    80103908 <wakeup1+0x18>
8010394a:	39 73 20             	cmp    %esi,0x20(%ebx)
8010394d:	75 b9                	jne    80103908 <wakeup1+0x18>
      if(tick){
8010394f:	81 fe 80 58 11 80    	cmp    $0x80115880,%esi
80103955:	75 07                	jne    8010395e <wakeup1+0x6e>
        p->comp_slices++;
80103957:	83 83 80 00 00 00 01 	addl   $0x1,0x80(%ebx)
  return queue;
}

// enqueue a proc
int enq(struct queue* queue, struct proc* process) {
  cprintf("enq ");
8010395e:	83 ec 0c             	sub    $0xc,%esp
      p->state = RUNNABLE;
80103961:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  cprintf("enq ");
80103968:	68 b4 7e 10 80       	push   $0x80107eb4
8010396d:	e8 2e cd ff ff       	call   801006a0 <cprintf>
  queue->rear = (queue->rear + 1) % NPROC;
80103972:	a1 24 2e 11 80       	mov    0x80112e24,%eax
  cprintf("QUEUE:\n");
80103977:	c7 04 24 b9 7e 10 80 	movl   $0x80107eb9,(%esp)
  queue->buffer[queue->rear] = process;
  queue->size++;
8010397e:	83 05 28 2e 11 80 01 	addl   $0x1,0x80112e28
  queue->rear = (queue->rear + 1) % NPROC;
80103985:	83 c0 01             	add    $0x1,%eax
80103988:	99                   	cltd   
80103989:	c1 ea 1a             	shr    $0x1a,%edx
8010398c:	01 d0                	add    %edx,%eax
8010398e:	83 e0 3f             	and    $0x3f,%eax
80103991:	29 d0                	sub    %edx,%eax
80103993:	a3 24 2e 11 80       	mov    %eax,0x80112e24
  queue->buffer[queue->rear] = process;
80103998:	89 1c 85 20 2d 11 80 	mov    %ebx,-0x7feed2e0(,%eax,4)
  cprintf("QUEUE:\n");
8010399f:	e8 fc cc ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
801039a4:	a1 28 2e 11 80       	mov    0x80112e28,%eax
801039a9:	83 c4 10             	add    $0x10,%esp
801039ac:	85 c0                	test   %eax,%eax
801039ae:	0f 8e 54 ff ff ff    	jle    80103908 <wakeup1+0x18>
  int i = 0;
801039b4:	31 ff                	xor    %edi,%edi
801039b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039bd:	8d 76 00             	lea    0x0(%esi),%esi
    p = q->buffer[q->front + i];
801039c0:	a1 20 2e 11 80       	mov    0x80112e20,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801039c5:	83 ec 04             	sub    $0x4,%esp
    p = q->buffer[q->front + i];
801039c8:	01 f8                	add    %edi,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801039ca:	8b 04 85 20 2d 11 80 	mov    -0x7feed2e0(,%eax,4),%eax
801039d1:	ff 70 10             	push   0x10(%eax)
801039d4:	57                   	push   %edi
    i++;
801039d5:	83 c7 01             	add    $0x1,%edi
    cprintf("[%d]: pid %d\n", i, p->pid);
801039d8:	68 c1 7e 10 80       	push   $0x80107ec1
801039dd:	e8 be cc ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
801039e2:	83 c4 10             	add    $0x10,%esp
801039e5:	3b 3d 28 2e 11 80    	cmp    0x80112e28,%edi
801039eb:	7c d3                	jl     801039c0 <wakeup1+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039ed:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801039f3:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
801039f9:	0f 85 1b ff ff ff    	jne    8010391a <wakeup1+0x2a>
}
801039ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a02:	5b                   	pop    %ebx
80103a03:	5e                   	pop    %esi
80103a04:	5f                   	pop    %edi
80103a05:	5d                   	pop    %ebp
80103a06:	c3                   	ret    
80103a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a0e:	66 90                	xchg   %ax,%ax

80103a10 <pinit>:
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a16:	68 cf 7e 10 80       	push   $0x80107ecf
80103a1b:	68 40 2e 11 80       	push   $0x80112e40
80103a20:	e8 5b 10 00 00       	call   80104a80 <initlock>
}
80103a25:	83 c4 10             	add    $0x10,%esp
80103a28:	c9                   	leave  
80103a29:	c3                   	ret    
80103a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a30 <mycpu>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	56                   	push   %esi
80103a34:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a35:	9c                   	pushf  
80103a36:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a37:	f6 c4 02             	test   $0x2,%ah
80103a3a:	75 46                	jne    80103a82 <mycpu+0x52>
  apicid = lapicid();
80103a3c:	e8 af ee ff ff       	call   801028f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a41:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103a47:	85 f6                	test   %esi,%esi
80103a49:	7e 2a                	jle    80103a75 <mycpu+0x45>
80103a4b:	31 d2                	xor    %edx,%edx
80103a4d:	eb 08                	jmp    80103a57 <mycpu+0x27>
80103a4f:	90                   	nop
80103a50:	83 c2 01             	add    $0x1,%edx
80103a53:	39 f2                	cmp    %esi,%edx
80103a55:	74 1e                	je     80103a75 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103a57:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103a5d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103a64:	39 c3                	cmp    %eax,%ebx
80103a66:	75 e8                	jne    80103a50 <mycpu+0x20>
}
80103a68:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a6b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103a71:	5b                   	pop    %ebx
80103a72:	5e                   	pop    %esi
80103a73:	5d                   	pop    %ebp
80103a74:	c3                   	ret    
  panic("unknown apicid\n");
80103a75:	83 ec 0c             	sub    $0xc,%esp
80103a78:	68 d6 7e 10 80       	push   $0x80107ed6
80103a7d:	e8 fe c8 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a82:	83 ec 0c             	sub    $0xc,%esp
80103a85:	68 c8 7f 10 80       	push   $0x80107fc8
80103a8a:	e8 f1 c8 ff ff       	call   80100380 <panic>
80103a8f:	90                   	nop

80103a90 <cpuid>:
cpuid() {
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a96:	e8 95 ff ff ff       	call   80103a30 <mycpu>
}
80103a9b:	c9                   	leave  
  return mycpu()-cpus;
80103a9c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103aa1:	c1 f8 04             	sar    $0x4,%eax
80103aa4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103aaa:	c3                   	ret    
80103aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103aaf:	90                   	nop

80103ab0 <myproc>:
myproc(void) {
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ab7:	e8 44 10 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103abc:	e8 6f ff ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103ac1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ac7:	e8 84 10 00 00       	call   80104b50 <popcli>
}
80103acc:	89 d8                	mov    %ebx,%eax
80103ace:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ad1:	c9                   	leave  
80103ad2:	c3                   	ret    
80103ad3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ae0 <growproc>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
80103ae5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ae8:	e8 13 10 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103aed:	e8 3e ff ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103af2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af8:	e8 53 10 00 00       	call   80104b50 <popcli>
  sz = curproc->sz;
80103afd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103aff:	85 f6                	test   %esi,%esi
80103b01:	7f 1d                	jg     80103b20 <growproc+0x40>
  } else if(n < 0){
80103b03:	75 3b                	jne    80103b40 <growproc+0x60>
  switchuvm(curproc);
80103b05:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b08:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b0a:	53                   	push   %ebx
80103b0b:	e8 a0 36 00 00       	call   801071b0 <switchuvm>
  return 0;
80103b10:	83 c4 10             	add    $0x10,%esp
80103b13:	31 c0                	xor    %eax,%eax
}
80103b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b18:	5b                   	pop    %ebx
80103b19:	5e                   	pop    %esi
80103b1a:	5d                   	pop    %ebp
80103b1b:	c3                   	ret    
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b20:	83 ec 04             	sub    $0x4,%esp
80103b23:	01 c6                	add    %eax,%esi
80103b25:	56                   	push   %esi
80103b26:	50                   	push   %eax
80103b27:	ff 73 04             	push   0x4(%ebx)
80103b2a:	e8 01 39 00 00       	call   80107430 <allocuvm>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 cf                	jne    80103b05 <growproc+0x25>
      return -1;
80103b36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b3b:	eb d8                	jmp    80103b15 <growproc+0x35>
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b40:	83 ec 04             	sub    $0x4,%esp
80103b43:	01 c6                	add    %eax,%esi
80103b45:	56                   	push   %esi
80103b46:	50                   	push   %eax
80103b47:	ff 73 04             	push   0x4(%ebx)
80103b4a:	e8 11 3a 00 00       	call   80107560 <deallocuvm>
80103b4f:	83 c4 10             	add    $0x10,%esp
80103b52:	85 c0                	test   %eax,%eax
80103b54:	75 af                	jne    80103b05 <growproc+0x25>
80103b56:	eb de                	jmp    80103b36 <growproc+0x56>
80103b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b5f:	90                   	nop

80103b60 <sched>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	56                   	push   %esi
80103b64:	53                   	push   %ebx
  pushcli();
80103b65:	e8 96 0f 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103b6a:	e8 c1 fe ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103b6f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b75:	e8 d6 0f 00 00       	call   80104b50 <popcli>
  if(!holding(&ptable.lock))
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 40 2e 11 80       	push   $0x80112e40
80103b82:	e8 29 10 00 00       	call   80104bb0 <holding>
80103b87:	83 c4 10             	add    $0x10,%esp
80103b8a:	85 c0                	test   %eax,%eax
80103b8c:	74 4f                	je     80103bdd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103b8e:	e8 9d fe ff ff       	call   80103a30 <mycpu>
80103b93:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b9a:	75 68                	jne    80103c04 <sched+0xa4>
  if(p->state == RUNNING)
80103b9c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ba0:	74 55                	je     80103bf7 <sched+0x97>
80103ba2:	9c                   	pushf  
80103ba3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ba4:	f6 c4 02             	test   $0x2,%ah
80103ba7:	75 41                	jne    80103bea <sched+0x8a>
  intena = mycpu()->intena;
80103ba9:	e8 82 fe ff ff       	call   80103a30 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103bae:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103bb1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103bb7:	e8 74 fe ff ff       	call   80103a30 <mycpu>
80103bbc:	83 ec 08             	sub    $0x8,%esp
80103bbf:	ff 70 04             	push   0x4(%eax)
80103bc2:	53                   	push   %ebx
80103bc3:	e8 73 13 00 00       	call   80104f3b <swtch>
  mycpu()->intena = intena;
80103bc8:	e8 63 fe ff ff       	call   80103a30 <mycpu>
}
80103bcd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103bd0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bd9:	5b                   	pop    %ebx
80103bda:	5e                   	pop    %esi
80103bdb:	5d                   	pop    %ebp
80103bdc:	c3                   	ret    
    panic("sched ptable.lock");
80103bdd:	83 ec 0c             	sub    $0xc,%esp
80103be0:	68 e6 7e 10 80       	push   $0x80107ee6
80103be5:	e8 96 c7 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103bea:	83 ec 0c             	sub    $0xc,%esp
80103bed:	68 12 7f 10 80       	push   $0x80107f12
80103bf2:	e8 89 c7 ff ff       	call   80100380 <panic>
    panic("sched running");
80103bf7:	83 ec 0c             	sub    $0xc,%esp
80103bfa:	68 04 7f 10 80       	push   $0x80107f04
80103bff:	e8 7c c7 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	68 f8 7e 10 80       	push   $0x80107ef8
80103c0c:	e8 6f c7 ff ff       	call   80100380 <panic>
80103c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c1f:	90                   	nop

80103c20 <exit>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	57                   	push   %edi
80103c24:	56                   	push   %esi
80103c25:	53                   	push   %ebx
80103c26:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103c29:	e8 82 fe ff ff       	call   80103ab0 <myproc>
  if(curproc == initproc)
80103c2e:	39 05 74 58 11 80    	cmp    %eax,0x80115874
80103c34:	0f 84 e6 00 00 00    	je     80103d20 <exit+0x100>
80103c3a:	89 c6                	mov    %eax,%esi
80103c3c:	8d 58 28             	lea    0x28(%eax),%ebx
80103c3f:	8d 78 68             	lea    0x68(%eax),%edi
80103c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103c48:	8b 03                	mov    (%ebx),%eax
80103c4a:	85 c0                	test   %eax,%eax
80103c4c:	74 12                	je     80103c60 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103c4e:	83 ec 0c             	sub    $0xc,%esp
80103c51:	50                   	push   %eax
80103c52:	e8 99 d2 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80103c57:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c5d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103c60:	83 c3 04             	add    $0x4,%ebx
80103c63:	39 fb                	cmp    %edi,%ebx
80103c65:	75 e1                	jne    80103c48 <exit+0x28>
  begin_op();
80103c67:	e8 f4 f0 ff ff       	call   80102d60 <begin_op>
  iput(curproc->cwd);
80103c6c:	83 ec 0c             	sub    $0xc,%esp
80103c6f:	ff 76 68             	push   0x68(%esi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c72:	bb 74 2e 11 80       	mov    $0x80112e74,%ebx
  iput(curproc->cwd);
80103c77:	e8 34 dc ff ff       	call   801018b0 <iput>
  end_op();
80103c7c:	e8 4f f1 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = 0;
80103c81:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103c88:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80103c8f:	e8 bc 0f 00 00       	call   80104c50 <acquire>
  wakeup1(curproc->parent);
80103c94:	8b 46 14             	mov    0x14(%esi),%eax
80103c97:	e8 54 fc ff ff       	call   801038f0 <wakeup1>
80103c9c:	83 c4 10             	add    $0x10,%esp
80103c9f:	eb 15                	jmp    80103cb6 <exit+0x96>
80103ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ca8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103cae:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103cb4:	74 2a                	je     80103ce0 <exit+0xc0>
    if(p->parent == curproc){
80103cb6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103cb9:	75 ed                	jne    80103ca8 <exit+0x88>
      p->parent = initproc;
80103cbb:	a1 74 58 11 80       	mov    0x80115874,%eax
      if(p->state == ZOMBIE)
80103cc0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
      p->parent = initproc;
80103cc4:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80103cc7:	75 df                	jne    80103ca8 <exit+0x88>
        wakeup1(initproc);
80103cc9:	e8 22 fc ff ff       	call   801038f0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cce:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103cd4:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103cda:	75 da                	jne    80103cb6 <exit+0x96>
80103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ptable.pstats.inuse[get_pstat_index(curproc->pid)] = 0;
80103ce0:	8b 56 10             	mov    0x10(%esi),%edx
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80103ce3:	31 c0                	xor    %eax,%eax
80103ce5:	39 15 74 52 11 80    	cmp    %edx,0x80115274
80103ceb:	74 0f                	je     80103cfc <exit+0xdc>
80103ced:	8d 76 00             	lea    0x0(%esi),%esi
80103cf0:	83 c0 01             	add    $0x1,%eax
80103cf3:	3b 14 85 74 52 11 80 	cmp    -0x7feead8c(,%eax,4),%edx
80103cfa:	75 f4                	jne    80103cf0 <exit+0xd0>
  ptable.pstats.inuse[get_pstat_index(curproc->pid)] = 0;
80103cfc:	c7 04 85 74 51 11 80 	movl   $0x0,-0x7feeae8c(,%eax,4)
80103d03:	00 00 00 00 
  curproc->state = ZOMBIE;
80103d07:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103d0e:	e8 4d fe ff ff       	call   80103b60 <sched>
  panic("zombie exit");
80103d13:	83 ec 0c             	sub    $0xc,%esp
80103d16:	68 33 7f 10 80       	push   $0x80107f33
80103d1b:	e8 60 c6 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103d20:	83 ec 0c             	sub    $0xc,%esp
80103d23:	68 26 7f 10 80       	push   $0x80107f26
80103d28:	e8 53 c6 ff ff       	call   80100380 <panic>
80103d2d:	8d 76 00             	lea    0x0(%esi),%esi

80103d30 <wait>:
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	56                   	push   %esi
80103d34:	53                   	push   %ebx
  pushcli();
80103d35:	e8 c6 0d 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103d3a:	e8 f1 fc ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103d3f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d45:	e8 06 0e 00 00       	call   80104b50 <popcli>
  acquire(&ptable.lock);
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 40 2e 11 80       	push   $0x80112e40
80103d52:	e8 f9 0e 00 00       	call   80104c50 <acquire>
80103d57:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103d5a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d5c:	bb 74 2e 11 80       	mov    $0x80112e74,%ebx
80103d61:	eb 13                	jmp    80103d76 <wait+0x46>
80103d63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d67:	90                   	nop
80103d68:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103d6e:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103d74:	74 1e                	je     80103d94 <wait+0x64>
      if(p->parent != curproc)
80103d76:	39 73 14             	cmp    %esi,0x14(%ebx)
80103d79:	75 ed                	jne    80103d68 <wait+0x38>
      if(p->state == ZOMBIE){
80103d7b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103d7f:	74 6f                	je     80103df0 <wait+0xc0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d81:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80103d87:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d8c:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103d92:	75 e2                	jne    80103d76 <wait+0x46>
    if(!havekids || curproc->killed){
80103d94:	85 c0                	test   %eax,%eax
80103d96:	0f 84 aa 00 00 00    	je     80103e46 <wait+0x116>
80103d9c:	8b 46 24             	mov    0x24(%esi),%eax
80103d9f:	85 c0                	test   %eax,%eax
80103da1:	0f 85 9f 00 00 00    	jne    80103e46 <wait+0x116>
  pushcli();
80103da7:	e8 54 0d 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103dac:	e8 7f fc ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103db1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103db7:	e8 94 0d 00 00       	call   80104b50 <popcli>
  if(p == 0)
80103dbc:	85 db                	test   %ebx,%ebx
80103dbe:	0f 84 99 00 00 00    	je     80103e5d <wait+0x12d>
  p->chan = chan;
80103dc4:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103dc7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  p->comp_slices = 0;
80103dce:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103dd5:	00 00 00 
  sched();
80103dd8:	e8 83 fd ff ff       	call   80103b60 <sched>
  p->chan = 0;
80103ddd:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103de4:	e9 71 ff ff ff       	jmp    80103d5a <wait+0x2a>
80103de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103df0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103df3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103df6:	ff 73 08             	push   0x8(%ebx)
80103df9:	e8 c2 e6 ff ff       	call   801024c0 <kfree>
        p->kstack = 0;
80103dfe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e05:	5a                   	pop    %edx
80103e06:	ff 73 04             	push   0x4(%ebx)
80103e09:	e8 82 37 00 00       	call   80107590 <freevm>
        p->pid = 0;
80103e0e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e15:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103e1c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103e20:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103e27:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103e2e:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80103e35:	e8 b6 0d 00 00       	call   80104bf0 <release>
        return pid;
80103e3a:	83 c4 10             	add    $0x10,%esp
}
80103e3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e40:	89 f0                	mov    %esi,%eax
80103e42:	5b                   	pop    %ebx
80103e43:	5e                   	pop    %esi
80103e44:	5d                   	pop    %ebp
80103e45:	c3                   	ret    
      release(&ptable.lock);
80103e46:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103e49:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103e4e:	68 40 2e 11 80       	push   $0x80112e40
80103e53:	e8 98 0d 00 00       	call   80104bf0 <release>
      return -1;
80103e58:	83 c4 10             	add    $0x10,%esp
80103e5b:	eb e0                	jmp    80103e3d <wait+0x10d>
    panic("sleep");
80103e5d:	83 ec 0c             	sub    $0xc,%esp
80103e60:	68 3f 7f 10 80       	push   $0x80107f3f
80103e65:	e8 16 c5 ff ff       	call   80100380 <panic>
80103e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e70 <sleep>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e7c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e7f:	e8 7c 0c 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80103e84:	e8 a7 fb ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80103e89:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e8f:	e8 bc 0c 00 00       	call   80104b50 <popcli>
  if(p == 0)
80103e94:	85 db                	test   %ebx,%ebx
80103e96:	0f 84 99 00 00 00    	je     80103f35 <sleep+0xc5>
  if(lk == 0)
80103e9c:	85 f6                	test   %esi,%esi
80103e9e:	0f 84 84 00 00 00    	je     80103f28 <sleep+0xb8>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ea4:	81 fe 40 2e 11 80    	cmp    $0x80112e40,%esi
80103eaa:	74 54                	je     80103f00 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103eac:	83 ec 0c             	sub    $0xc,%esp
80103eaf:	68 40 2e 11 80       	push   $0x80112e40
80103eb4:	e8 97 0d 00 00       	call   80104c50 <acquire>
    release(lk);
80103eb9:	89 34 24             	mov    %esi,(%esp)
80103ebc:	e8 2f 0d 00 00       	call   80104bf0 <release>
  p->chan = chan;
80103ec1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ec4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  p->comp_slices = 0;
80103ecb:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103ed2:	00 00 00 
  sched();
80103ed5:	e8 86 fc ff ff       	call   80103b60 <sched>
  p->chan = 0;
80103eda:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ee1:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80103ee8:	e8 03 0d 00 00       	call   80104bf0 <release>
    acquire(lk);
80103eed:	89 75 08             	mov    %esi,0x8(%ebp)
80103ef0:	83 c4 10             	add    $0x10,%esp
}
80103ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ef6:	5b                   	pop    %ebx
80103ef7:	5e                   	pop    %esi
80103ef8:	5f                   	pop    %edi
80103ef9:	5d                   	pop    %ebp
    acquire(lk);
80103efa:	e9 51 0d 00 00       	jmp    80104c50 <acquire>
80103eff:	90                   	nop
  p->chan = chan;
80103f00:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f03:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  p->comp_slices = 0;
80103f0a:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103f11:	00 00 00 
  sched();
80103f14:	e8 47 fc ff ff       	call   80103b60 <sched>
  p->chan = 0;
80103f19:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f23:	5b                   	pop    %ebx
80103f24:	5e                   	pop    %esi
80103f25:	5f                   	pop    %edi
80103f26:	5d                   	pop    %ebp
80103f27:	c3                   	ret    
    panic("sleep without lk");
80103f28:	83 ec 0c             	sub    $0xc,%esp
80103f2b:	68 45 7f 10 80       	push   $0x80107f45
80103f30:	e8 4b c4 ff ff       	call   80100380 <panic>
    panic("sleep");
80103f35:	83 ec 0c             	sub    $0xc,%esp
80103f38:	68 3f 7f 10 80       	push   $0x80107f3f
80103f3d:	e8 3e c4 ff ff       	call   80100380 <panic>
80103f42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f50 <wakeup>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 10             	sub    $0x10,%esp
80103f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f5a:	68 40 2e 11 80       	push   $0x80112e40
80103f5f:	e8 ec 0c 00 00       	call   80104c50 <acquire>
  wakeup1(chan);
80103f64:	89 d8                	mov    %ebx,%eax
80103f66:	e8 85 f9 ff ff       	call   801038f0 <wakeup1>
  release(&ptable.lock);
80103f6b:	c7 45 08 40 2e 11 80 	movl   $0x80112e40,0x8(%ebp)
}
80103f72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
80103f75:	83 c4 10             	add    $0x10,%esp
}
80103f78:	c9                   	leave  
  release(&ptable.lock);
80103f79:	e9 72 0c 00 00       	jmp    80104bf0 <release>
80103f7e:	66 90                	xchg   %ax,%ax

80103f80 <procdump>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	57                   	push   %edi
80103f84:	56                   	push   %esi
80103f85:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103f88:	53                   	push   %ebx
80103f89:	bb e0 2e 11 80       	mov    $0x80112ee0,%ebx
80103f8e:	83 ec 3c             	sub    $0x3c,%esp
80103f91:	eb 27                	jmp    80103fba <procdump+0x3a>
80103f93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f97:	90                   	nop
    cprintf("\n");
80103f98:	83 ec 0c             	sub    $0xc,%esp
80103f9b:	68 27 83 10 80       	push   $0x80108327
80103fa0:	e8 fb c6 ff ff       	call   801006a0 <cprintf>
80103fa5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103fae:	81 fb e0 51 11 80    	cmp    $0x801151e0,%ebx
80103fb4:	0f 84 7e 00 00 00    	je     80104038 <procdump+0xb8>
    if(p->state == UNUSED)
80103fba:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103fbd:	85 c0                	test   %eax,%eax
80103fbf:	74 e7                	je     80103fa8 <procdump+0x28>
      state = "???";
80103fc1:	ba 56 7f 10 80       	mov    $0x80107f56,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103fc6:	83 f8 05             	cmp    $0x5,%eax
80103fc9:	77 11                	ja     80103fdc <procdump+0x5c>
80103fcb:	8b 14 85 f0 7f 10 80 	mov    -0x7fef8010(,%eax,4),%edx
      state = "???";
80103fd2:	b8 56 7f 10 80       	mov    $0x80107f56,%eax
80103fd7:	85 d2                	test   %edx,%edx
80103fd9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80103fdc:	53                   	push   %ebx
80103fdd:	52                   	push   %edx
80103fde:	ff 73 a4             	push   -0x5c(%ebx)
80103fe1:	68 5a 7f 10 80       	push   $0x80107f5a
80103fe6:	e8 b5 c6 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80103feb:	83 c4 10             	add    $0x10,%esp
80103fee:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103ff2:	75 a4                	jne    80103f98 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103ff4:	83 ec 08             	sub    $0x8,%esp
80103ff7:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103ffa:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103ffd:	50                   	push   %eax
80103ffe:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104001:	8b 40 0c             	mov    0xc(%eax),%eax
80104004:	83 c0 08             	add    $0x8,%eax
80104007:	50                   	push   %eax
80104008:	e8 93 0a 00 00       	call   80104aa0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010400d:	83 c4 10             	add    $0x10,%esp
80104010:	8b 17                	mov    (%edi),%edx
80104012:	85 d2                	test   %edx,%edx
80104014:	74 82                	je     80103f98 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104016:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104019:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010401c:	52                   	push   %edx
8010401d:	68 a1 79 10 80       	push   $0x801079a1
80104022:	e8 79 c6 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104027:	83 c4 10             	add    $0x10,%esp
8010402a:	39 fe                	cmp    %edi,%esi
8010402c:	75 e2                	jne    80104010 <procdump+0x90>
8010402e:	e9 65 ff ff ff       	jmp    80103f98 <procdump+0x18>
80104033:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104037:	90                   	nop
}
80104038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010403b:	5b                   	pop    %ebx
8010403c:	5e                   	pop    %esi
8010403d:	5f                   	pop    %edi
8010403e:	5d                   	pop    %ebp
8010403f:	c3                   	ret    

80104040 <scheduler>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80104049:	e8 e2 f9 ff ff       	call   80103a30 <mycpu>
  c->proc = 0;
8010404e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104055:	00 00 00 
  struct cpu *c = mycpu();
80104058:	89 c7                	mov    %eax,%edi
  c->proc = 0;
8010405a:	8d 40 04             	lea    0x4(%eax),%eax
8010405d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80104060:	fb                   	sti    
    acquire(&ptable.lock); 
80104061:	83 ec 0c             	sub    $0xc,%esp
80104064:	68 40 2e 11 80       	push   $0x80112e40
80104069:	e8 e2 0b 00 00       	call   80104c50 <acquire>
    cprintf("procdump:\n");
8010406e:	c7 04 24 63 7f 10 80 	movl   $0x80107f63,(%esp)
80104075:	e8 26 c6 ff ff       	call   801006a0 <cprintf>
    procdump();
8010407a:	e8 01 ff ff ff       	call   80103f80 <procdump>
    while((p = deq(&q)) != 0){
8010407f:	83 c4 10             	add    $0x10,%esp
80104082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return 1;
}

// dequeue a proc
struct proc* deq(struct queue* queue) {
  cprintf("deq ");
80104088:	83 ec 0c             	sub    $0xc,%esp
8010408b:	68 6e 7f 10 80       	push   $0x80107f6e
80104090:	e8 0b c6 ff ff       	call   801006a0 <cprintf>
  if(queue->size == 0){
80104095:	8b 15 28 2e 11 80    	mov    0x80112e28,%edx
8010409b:	83 c4 10             	add    $0x10,%esp
8010409e:	85 d2                	test   %edx,%edx
801040a0:	0f 84 5a 01 00 00    	je     80104200 <scheduler+0x1c0>
    cprintf("empty\n");
    return (struct proc *)0;
  }
    
  struct proc* process = queue->buffer[queue->front];
801040a6:	a1 20 2e 11 80       	mov    0x80112e20,%eax
  cprintf("QUEUE:\n");
801040ab:	83 ec 0c             	sub    $0xc,%esp
  queue->front = (queue->front + 1) % NPROC;
  queue->size--;
801040ae:	83 ea 01             	sub    $0x1,%edx
  int i = 0;
801040b1:	31 f6                	xor    %esi,%esi
  cprintf("QUEUE:\n");
801040b3:	68 b9 7e 10 80       	push   $0x80107eb9
  struct proc* process = queue->buffer[queue->front];
801040b8:	8b 1c 85 20 2d 11 80 	mov    -0x7feed2e0(,%eax,4),%ebx
  queue->front = (queue->front + 1) % NPROC;
801040bf:	83 c0 01             	add    $0x1,%eax
  queue->size--;
801040c2:	89 15 28 2e 11 80    	mov    %edx,0x80112e28
  queue->front = (queue->front + 1) % NPROC;
801040c8:	89 c1                	mov    %eax,%ecx
801040ca:	c1 f9 1f             	sar    $0x1f,%ecx
801040cd:	c1 e9 1a             	shr    $0x1a,%ecx
801040d0:	01 c8                	add    %ecx,%eax
801040d2:	83 e0 3f             	and    $0x3f,%eax
801040d5:	29 c8                	sub    %ecx,%eax
801040d7:	a3 20 2e 11 80       	mov    %eax,0x80112e20
  cprintf("QUEUE:\n");
801040dc:	e8 bf c5 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
801040e1:	a1 28 2e 11 80       	mov    0x80112e28,%eax
801040e6:	83 c4 10             	add    $0x10,%esp
801040e9:	85 c0                	test   %eax,%eax
801040eb:	7e 30                	jle    8010411d <scheduler+0xdd>
801040ed:	8d 76 00             	lea    0x0(%esi),%esi
    p = q->buffer[q->front + i];
801040f0:	a1 20 2e 11 80       	mov    0x80112e20,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801040f5:	83 ec 04             	sub    $0x4,%esp
    p = q->buffer[q->front + i];
801040f8:	01 f0                	add    %esi,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801040fa:	8b 04 85 20 2d 11 80 	mov    -0x7feed2e0(,%eax,4),%eax
80104101:	ff 70 10             	push   0x10(%eax)
80104104:	56                   	push   %esi
    i++;
80104105:	83 c6 01             	add    $0x1,%esi
    cprintf("[%d]: pid %d\n", i, p->pid);
80104108:	68 c1 7e 10 80       	push   $0x80107ec1
8010410d:	e8 8e c5 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
80104112:	83 c4 10             	add    $0x10,%esp
80104115:	3b 35 28 2e 11 80    	cmp    0x80112e28,%esi
8010411b:	7c d3                	jl     801040f0 <scheduler+0xb0>
    while((p = deq(&q)) != 0){
8010411d:	85 db                	test   %ebx,%ebx
8010411f:	0f 84 eb 00 00 00    	je     80104210 <scheduler+0x1d0>
      if(p->state != RUNNABLE){continue;}
80104125:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104129:	0f 85 59 ff ff ff    	jne    80104088 <scheduler+0x48>
      pstat_index = get_pstat_index(p->pid);      
8010412f:	8b 43 10             	mov    0x10(%ebx),%eax
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80104132:	31 f6                	xor    %esi,%esi
80104134:	3b 05 74 52 11 80    	cmp    0x80115274,%eax
8010413a:	74 10                	je     8010414c <scheduler+0x10c>
8010413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104140:	83 c6 01             	add    $0x1,%esi
80104143:	3b 04 b5 74 52 11 80 	cmp    -0x7feead8c(,%esi,4),%eax
8010414a:	75 f4                	jne    80104140 <scheduler+0x100>
      ptable.pstats.switches[pstat_index]++;
8010414c:	83 04 b5 74 57 11 80 	addl   $0x1,-0x7feea88c(,%esi,4)
80104153:	01 
      p->slices_left = p->slice + p->comp_slices;
80104154:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
        ptable.pstats.schedticks[pstat_index]++;
8010415a:	8d 96 cc 09 00 00    	lea    0x9cc(%esi),%edx
      p->slices_left = p->slice + p->comp_slices;
80104160:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104163:	01 c8                	add    %ecx,%eax
      while(p->state == RUNNABLE && p->slices_left > 0){
80104165:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
      p->slices_left = p->slice + p->comp_slices;
80104169:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
      while(p->state == RUNNABLE && p->slices_left > 0){
8010416f:	75 6c                	jne    801041dd <scheduler+0x19d>
80104171:	89 75 e0             	mov    %esi,-0x20(%ebp)
80104174:	89 d6                	mov    %edx,%esi
80104176:	eb 58                	jmp    801041d0 <scheduler+0x190>
80104178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010417f:	90                   	nop
        switchuvm(p); // switch to user?
80104180:	83 ec 0c             	sub    $0xc,%esp
        ptable.pstats.schedticks[pstat_index]++;
80104183:	83 04 b5 44 2e 11 80 	addl   $0x1,-0x7feed1bc(,%esi,4)
8010418a:	01 
        p->slices_left--;
8010418b:	83 ab 84 00 00 00 01 	subl   $0x1,0x84(%ebx)
        c->proc = p;
80104192:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
        switchuvm(p); // switch to user?
80104198:	53                   	push   %ebx
80104199:	e8 12 30 00 00       	call   801071b0 <switchuvm>
        p->state = RUNNING;
8010419e:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        swtch(&(c->scheduler), p->context);
801041a5:	5a                   	pop    %edx
801041a6:	59                   	pop    %ecx
801041a7:	ff 73 1c             	push   0x1c(%ebx)
801041aa:	ff 75 e4             	push   -0x1c(%ebp)
801041ad:	e8 89 0d 00 00       	call   80104f3b <swtch>
        switchkvm(); 
801041b2:	e8 e9 2f 00 00       	call   801071a0 <switchkvm>
      while(p->state == RUNNABLE && p->slices_left > 0){
801041b7:	83 c4 10             	add    $0x10,%esp
        c->proc = 0;
801041ba:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
801041c1:	00 00 00 
      while(p->state == RUNNABLE && p->slices_left > 0){
801041c4:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801041c8:	75 5e                	jne    80104228 <scheduler+0x1e8>
      if(p->slices_left < p->comp_slices)
801041ca:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
      while(p->state == RUNNABLE && p->slices_left > 0){
801041d0:	85 c0                	test   %eax,%eax
801041d2:	7f ac                	jg     80104180 <scheduler+0x140>
      if(p->slices_left < p->comp_slices)
801041d4:	8b 75 e0             	mov    -0x20(%ebp),%esi
801041d7:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
801041dd:	39 c8                	cmp    %ecx,%eax
801041df:	7d 09                	jge    801041ea <scheduler+0x1aa>
        ptable.pstats.compticks[pstat_index] +=  p->comp_slices - p->slices_left;
801041e1:	29 c1                	sub    %eax,%ecx
801041e3:	01 0c b5 74 54 11 80 	add    %ecx,-0x7feeab8c(,%esi,4)
      p->comp_slices = 0;
801041ea:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801041f1:	00 00 00 
801041f4:	e9 8f fe ff ff       	jmp    80104088 <scheduler+0x48>
801041f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("empty\n");
80104200:	83 ec 0c             	sub    $0xc,%esp
80104203:	68 73 7f 10 80       	push   $0x80107f73
80104208:	e8 93 c4 ff ff       	call   801006a0 <cprintf>
8010420d:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80104210:	83 ec 0c             	sub    $0xc,%esp
80104213:	68 40 2e 11 80       	push   $0x80112e40
80104218:	e8 d3 09 00 00       	call   80104bf0 <release>
    sti();
8010421d:	83 c4 10             	add    $0x10,%esp
80104220:	e9 3b fe ff ff       	jmp    80104060 <scheduler+0x20>
80104225:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->slices_left < p->comp_slices)
80104228:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010422b:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104231:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
80104237:	eb a4                	jmp    801041dd <scheduler+0x19d>
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104240 <setslice>:
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	8b 55 08             	mov    0x8(%ebp),%edx
80104246:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(pid < 0 || slice < 0) {
80104249:	89 d0                	mov    %edx,%eax
8010424b:	09 c8                	or     %ecx,%eax
8010424d:	78 51                	js     801042a0 <setslice+0x60>
  for((p = ptable.proc); p < &ptable.proc[NPROC]; p++){
8010424f:	b8 74 2e 11 80       	mov    $0x80112e74,%eax
80104254:	eb 16                	jmp    8010426c <setslice+0x2c>
80104256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010425d:	8d 76 00             	lea    0x0(%esi),%esi
80104260:	05 8c 00 00 00       	add    $0x8c,%eax
80104265:	3d 74 51 11 80       	cmp    $0x80115174,%eax
8010426a:	74 34                	je     801042a0 <setslice+0x60>
    if(p->pid == pid){
8010426c:	39 50 10             	cmp    %edx,0x10(%eax)
8010426f:	75 ef                	jne    80104260 <setslice+0x20>
      p->slice = slice;
80104271:	89 48 7c             	mov    %ecx,0x7c(%eax)
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80104274:	31 c0                	xor    %eax,%eax
80104276:	3b 15 74 52 11 80    	cmp    0x80115274,%edx
8010427c:	74 0e                	je     8010428c <setslice+0x4c>
8010427e:	66 90                	xchg   %ax,%ax
80104280:	83 c0 01             	add    $0x1,%eax
80104283:	3b 14 85 74 52 11 80 	cmp    -0x7feead8c(,%eax,4),%edx
8010428a:	75 f4                	jne    80104280 <setslice+0x40>
      ptable.pstats.timeslice[get_pstat_index(p->pid)] = slice;
8010428c:	89 0c 85 74 53 11 80 	mov    %ecx,-0x7feeac8c(,%eax,4)
}
80104293:	5d                   	pop    %ebp
      return 0;
80104294:	31 c0                	xor    %eax,%eax
}
80104296:	c3                   	ret    
80104297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010429e:	66 90                	xchg   %ax,%ax
    return -1;
801042a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042a5:	5d                   	pop    %ebp
801042a6:	c3                   	ret    
801042a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042ae:	66 90                	xchg   %ax,%ax

801042b0 <getslice>:
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	8b 55 08             	mov    0x8(%ebp),%edx
  if(pid < 0) {
801042b6:	85 d2                	test   %edx,%edx
801042b8:	78 2d                	js     801042e7 <getslice+0x37>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801042ba:	b8 74 2e 11 80       	mov    $0x80112e74,%eax
801042bf:	eb 13                	jmp    801042d4 <getslice+0x24>
801042c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042c8:	05 8c 00 00 00       	add    $0x8c,%eax
801042cd:	3d 74 51 11 80       	cmp    $0x80115174,%eax
801042d2:	74 0c                	je     801042e0 <getslice+0x30>
    if(p->pid == pid) {
801042d4:	39 50 10             	cmp    %edx,0x10(%eax)
801042d7:	75 ef                	jne    801042c8 <getslice+0x18>
      return p->slice;
801042d9:	8b 40 7c             	mov    0x7c(%eax),%eax
}
801042dc:	5d                   	pop    %ebp
801042dd:	c3                   	ret    
801042de:	66 90                	xchg   %ax,%ax
  return 1;
801042e0:	b8 01 00 00 00       	mov    $0x1,%eax
}
801042e5:	5d                   	pop    %ebp
801042e6:	c3                   	ret    
    return -1;
801042e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042ec:	5d                   	pop    %ebp
801042ed:	c3                   	ret    
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <getpinfo>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 0c             	sub    $0xc,%esp
  memmove(addr, &ptable.pstats, sizeof(struct pstat)); 
801042f6:	68 00 07 00 00       	push   $0x700
801042fb:	68 74 51 11 80       	push   $0x80115174
80104300:	ff 75 08             	push   0x8(%ebp)
80104303:	e8 b8 0a 00 00       	call   80104dc0 <memmove>
}
80104308:	31 c0                	xor    %eax,%eax
8010430a:	c9                   	leave  
8010430b:	c3                   	ret    
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104310 <get_pstat_index>:
get_pstat_index(int pid){
80104310:	55                   	push   %ebp
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80104311:	31 c0                	xor    %eax,%eax
get_pstat_index(int pid){
80104313:	89 e5                	mov    %esp,%ebp
80104315:	8b 55 08             	mov    0x8(%ebp),%edx
  for(i = 0; ptable.pstats.pid[i] != pid && i < NPROC; i++){;}
80104318:	3b 15 74 52 11 80    	cmp    0x80115274,%edx
8010431e:	74 0c                	je     8010432c <get_pstat_index+0x1c>
80104320:	83 c0 01             	add    $0x1,%eax
80104323:	39 14 85 74 52 11 80 	cmp    %edx,-0x7feead8c(,%eax,4)
8010432a:	75 f4                	jne    80104320 <get_pstat_index+0x10>
}
8010432c:	5d                   	pop    %ebp
8010432d:	c3                   	ret    
8010432e:	66 90                	xchg   %ax,%ax

80104330 <printq>:
void printq(struct queue *q){
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 75 08             	mov    0x8(%ebp),%esi
  cprintf("QUEUE:\n");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 b9 7e 10 80       	push   $0x80107eb9
80104340:	e8 5b c3 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
80104345:	8b 86 08 01 00 00    	mov    0x108(%esi),%eax
8010434b:	83 c4 10             	add    $0x10,%esp
8010434e:	85 c0                	test   %eax,%eax
80104350:	7e 30                	jle    80104382 <printq+0x52>
  int i = 0;
80104352:	31 db                	xor    %ebx,%ebx
80104354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p = q->buffer[q->front + i];
80104358:	8b 86 00 01 00 00    	mov    0x100(%esi),%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
8010435e:	83 ec 04             	sub    $0x4,%esp
    p = q->buffer[q->front + i];
80104361:	01 d8                	add    %ebx,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
80104363:	8b 04 86             	mov    (%esi,%eax,4),%eax
80104366:	ff 70 10             	push   0x10(%eax)
80104369:	53                   	push   %ebx
    i++;
8010436a:	83 c3 01             	add    $0x1,%ebx
    cprintf("[%d]: pid %d\n", i, p->pid);
8010436d:	68 c1 7e 10 80       	push   $0x80107ec1
80104372:	e8 29 c3 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
80104377:	83 c4 10             	add    $0x10,%esp
8010437a:	39 9e 08 01 00 00    	cmp    %ebx,0x108(%esi)
80104380:	7f d6                	jg     80104358 <printq+0x28>
}
80104382:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104385:	5b                   	pop    %ebx
80104386:	5e                   	pop    %esi
80104387:	5d                   	pop    %ebp
80104388:	c3                   	ret    
80104389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104390 <init_q>:
struct queue init_q() {
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	8b 45 08             	mov    0x8(%ebp),%eax
  return queue;
80104396:	c7 80 00 01 00 00 00 	movl   $0x0,0x100(%eax)
8010439d:	00 00 00 
801043a0:	c7 80 04 01 00 00 ff 	movl   $0xffffffff,0x104(%eax)
801043a7:	ff ff ff 
801043aa:	c7 80 08 01 00 00 00 	movl   $0x0,0x108(%eax)
801043b1:	00 00 00 
}
801043b4:	5d                   	pop    %ebp
801043b5:	c2 04 00             	ret    $0x4
801043b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043bf:	90                   	nop

801043c0 <enq>:
int enq(struct queue* queue, struct proc* process) {
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 75 08             	mov    0x8(%ebp),%esi
  cprintf("enq ");
801043c8:	83 ec 0c             	sub    $0xc,%esp
801043cb:	68 b4 7e 10 80       	push   $0x80107eb4
801043d0:	e8 cb c2 ff ff       	call   801006a0 <cprintf>
  queue->rear = (queue->rear + 1) % NPROC;
801043d5:	8b 86 04 01 00 00    	mov    0x104(%esi),%eax
801043db:	83 c0 01             	add    $0x1,%eax
801043de:	99                   	cltd   
801043df:	c1 ea 1a             	shr    $0x1a,%edx
801043e2:	01 d0                	add    %edx,%eax
801043e4:	83 e0 3f             	and    $0x3f,%eax
801043e7:	29 d0                	sub    %edx,%eax
  queue->buffer[queue->rear] = process;
801043e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  queue->rear = (queue->rear + 1) % NPROC;
801043ec:	89 86 04 01 00 00    	mov    %eax,0x104(%esi)
  queue->buffer[queue->rear] = process;
801043f2:	89 14 86             	mov    %edx,(%esi,%eax,4)
  queue->size++;
801043f5:	83 86 08 01 00 00 01 	addl   $0x1,0x108(%esi)
  cprintf("QUEUE:\n");
801043fc:	c7 04 24 b9 7e 10 80 	movl   $0x80107eb9,(%esp)
80104403:	e8 98 c2 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
80104408:	8b 86 08 01 00 00    	mov    0x108(%esi),%eax
8010440e:	83 c4 10             	add    $0x10,%esp
80104411:	85 c0                	test   %eax,%eax
80104413:	7e 35                	jle    8010444a <enq+0x8a>
  int i = 0;
80104415:	31 db                	xor    %ebx,%ebx
80104417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010441e:	66 90                	xchg   %ax,%ax
    p = q->buffer[q->front + i];
80104420:	8b 86 00 01 00 00    	mov    0x100(%esi),%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
80104426:	83 ec 04             	sub    $0x4,%esp
    p = q->buffer[q->front + i];
80104429:	01 d8                	add    %ebx,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
8010442b:	8b 04 86             	mov    (%esi,%eax,4),%eax
8010442e:	ff 70 10             	push   0x10(%eax)
80104431:	53                   	push   %ebx
    i++;
80104432:	83 c3 01             	add    $0x1,%ebx
    cprintf("[%d]: pid %d\n", i, p->pid);
80104435:	68 c1 7e 10 80       	push   $0x80107ec1
8010443a:	e8 61 c2 ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
8010443f:	83 c4 10             	add    $0x10,%esp
80104442:	3b 9e 08 01 00 00    	cmp    0x108(%esi),%ebx
80104448:	7c d6                	jl     80104420 <enq+0x60>
}
8010444a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010444d:	b8 01 00 00 00       	mov    $0x1,%eax
80104452:	5b                   	pop    %ebx
80104453:	5e                   	pop    %esi
80104454:	5d                   	pop    %ebp
80104455:	c3                   	ret    
80104456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010445d:	8d 76 00             	lea    0x0(%esi),%esi

80104460 <userinit>:
{
80104460:	55                   	push   %ebp
  for(int i = 0; i < NPROC; i++){ptable.pstats.inuse[i] = 0;}
80104461:	31 c0                	xor    %eax,%eax
{
80104463:	89 e5                	mov    %esp,%ebp
80104465:	53                   	push   %ebx
80104466:	83 ec 04             	sub    $0x4,%esp
  q = init_q(); // process queue for choosing next proc
80104469:	c7 05 20 2e 11 80 00 	movl   $0x0,0x80112e20
80104470:	00 00 00 
80104473:	c7 05 24 2e 11 80 ff 	movl   $0xffffffff,0x80112e24
8010447a:	ff ff ff 
8010447d:	c7 05 28 2e 11 80 00 	movl   $0x0,0x80112e28
80104484:	00 00 00 
  for(int i = 0; i < NPROC; i++){ptable.pstats.inuse[i] = 0;}
80104487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010448e:	66 90                	xchg   %ax,%ax
80104490:	c7 04 85 74 51 11 80 	movl   $0x0,-0x7feeae8c(,%eax,4)
80104497:	00 00 00 00 
8010449b:	83 c0 01             	add    $0x1,%eax
8010449e:	83 f8 40             	cmp    $0x40,%eax
801044a1:	75 ed                	jne    80104490 <userinit+0x30>
  p = allocproc(); 
801044a3:	e8 18 f3 ff ff       	call   801037c0 <allocproc>
801044a8:	89 c3                	mov    %eax,%ebx
  initproc = p;
801044aa:	a3 74 58 11 80       	mov    %eax,0x80115874
  if((p->pgdir = setupkvm()) == 0)
801044af:	e8 5c 31 00 00       	call   80107610 <setupkvm>
801044b4:	89 43 04             	mov    %eax,0x4(%ebx)
801044b7:	85 c0                	test   %eax,%eax
801044b9:	0f 84 d1 00 00 00    	je     80104590 <userinit+0x130>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044bf:	83 ec 04             	sub    $0x4,%esp
801044c2:	68 2c 00 00 00       	push   $0x2c
801044c7:	68 60 b4 10 80       	push   $0x8010b460
801044cc:	50                   	push   %eax
801044cd:	e8 ee 2d 00 00       	call   801072c0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801044d2:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801044d5:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801044db:	6a 4c                	push   $0x4c
801044dd:	6a 00                	push   $0x0
801044df:	ff 73 18             	push   0x18(%ebx)
801044e2:	e8 39 08 00 00       	call   80104d20 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044e7:	8b 43 18             	mov    0x18(%ebx),%eax
801044ea:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801044ef:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044f2:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044f7:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044fb:	8b 43 18             	mov    0x18(%ebx),%eax
801044fe:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104502:	8b 43 18             	mov    0x18(%ebx),%eax
80104505:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104509:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010450d:	8b 43 18             	mov    0x18(%ebx),%eax
80104510:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104514:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104518:	8b 43 18             	mov    0x18(%ebx),%eax
8010451b:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104522:	8b 43 18             	mov    0x18(%ebx),%eax
80104525:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;   // beginning of initcode.S
8010452c:	8b 43 18             	mov    0x18(%ebx),%eax
8010452f:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104536:	8d 43 6c             	lea    0x6c(%ebx),%eax
  p->slice = 1;     // tiny slice :(
80104539:	c7 43 7c 01 00 00 00 	movl   $0x1,0x7c(%ebx)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104540:	6a 10                	push   $0x10
80104542:	68 93 7f 10 80       	push   $0x80107f93
80104547:	50                   	push   %eax
80104548:	e8 93 09 00 00       	call   80104ee0 <safestrcpy>
  p->cwd = namei("/");
8010454d:	c7 04 24 9c 7f 10 80 	movl   $0x80107f9c,(%esp)
80104554:	e8 47 db ff ff       	call   801020a0 <namei>
80104559:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010455c:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80104563:	e8 e8 06 00 00       	call   80104c50 <acquire>
  p->state = RUNNABLE;
80104568:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010456f:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80104576:	e8 75 06 00 00       	call   80104bf0 <release>
  enq(&q, p);
8010457b:	58                   	pop    %eax
8010457c:	5a                   	pop    %edx
8010457d:	53                   	push   %ebx
8010457e:	68 20 2d 11 80       	push   $0x80112d20
80104583:	e8 38 fe ff ff       	call   801043c0 <enq>
}
80104588:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010458b:	83 c4 10             	add    $0x10,%esp
8010458e:	c9                   	leave  
8010458f:	c3                   	ret    
    panic("userinit: out of memory?");
80104590:	83 ec 0c             	sub    $0xc,%esp
80104593:	68 7a 7f 10 80       	push   $0x80107f7a
80104598:	e8 e3 bd ff ff       	call   80100380 <panic>
8010459d:	8d 76 00             	lea    0x0(%esi),%esi

801045a0 <yield>:
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	53                   	push   %ebx
801045a4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801045a7:	68 40 2e 11 80       	push   $0x80112e40
801045ac:	e8 9f 06 00 00       	call   80104c50 <acquire>
  pushcli();
801045b1:	e8 4a 05 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801045b6:	e8 75 f4 ff ff       	call   80103a30 <mycpu>
  p = c->proc;
801045bb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045c1:	e8 8a 05 00 00       	call   80104b50 <popcli>
  myproc()->state = RUNNABLE;
801045c6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
801045cd:	e8 2e 05 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801045d2:	e8 59 f4 ff ff       	call   80103a30 <mycpu>
  p = c->proc;
801045d7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045dd:	e8 6e 05 00 00       	call   80104b50 <popcli>
  enq(&q, myproc());
801045e2:	58                   	pop    %eax
801045e3:	5a                   	pop    %edx
801045e4:	53                   	push   %ebx
801045e5:	68 20 2d 11 80       	push   $0x80112d20
801045ea:	e8 d1 fd ff ff       	call   801043c0 <enq>
  sched();
801045ef:	e8 6c f5 ff ff       	call   80103b60 <sched>
  release(&ptable.lock);
801045f4:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
801045fb:	e8 f0 05 00 00       	call   80104bf0 <release>
}
80104600:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104603:	83 c4 10             	add    $0x10,%esp
80104606:	c9                   	leave  
80104607:	c3                   	ret    
80104608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010460f:	90                   	nop

80104610 <kill>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 10             	sub    $0x10,%esp
80104617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010461a:	68 40 2e 11 80       	push   $0x80112e40
8010461f:	e8 2c 06 00 00       	call   80104c50 <acquire>
80104624:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104627:	b8 74 2e 11 80       	mov    $0x80112e74,%eax
8010462c:	eb 0e                	jmp    8010463c <kill+0x2c>
8010462e:	66 90                	xchg   %ax,%ax
80104630:	05 8c 00 00 00       	add    $0x8c,%eax
80104635:	3d 74 51 11 80       	cmp    $0x80115174,%eax
8010463a:	74 2c                	je     80104668 <kill+0x58>
    if(p->pid == pid){
8010463c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010463f:	75 ef                	jne    80104630 <kill+0x20>
      if(p->state == SLEEPING){
80104641:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104645:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING){
8010464c:	74 3a                	je     80104688 <kill+0x78>
      release(&ptable.lock);
8010464e:	83 ec 0c             	sub    $0xc,%esp
80104651:	68 40 2e 11 80       	push   $0x80112e40
80104656:	e8 95 05 00 00       	call   80104bf0 <release>
}
8010465b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010465e:	83 c4 10             	add    $0x10,%esp
80104661:	31 c0                	xor    %eax,%eax
}
80104663:	c9                   	leave  
80104664:	c3                   	ret    
80104665:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104668:	83 ec 0c             	sub    $0xc,%esp
8010466b:	68 40 2e 11 80       	push   $0x80112e40
80104670:	e8 7b 05 00 00       	call   80104bf0 <release>
}
80104675:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104678:	83 c4 10             	add    $0x10,%esp
8010467b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104680:	c9                   	leave  
80104681:	c3                   	ret    
80104682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        enq(&q, p); 
80104688:	83 ec 08             	sub    $0x8,%esp
        p->state = RUNNABLE;
8010468b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
        enq(&q, p); 
80104692:	50                   	push   %eax
80104693:	68 20 2d 11 80       	push   $0x80112d20
80104698:	e8 23 fd ff ff       	call   801043c0 <enq>
8010469d:	83 c4 10             	add    $0x10,%esp
801046a0:	eb ac                	jmp    8010464e <kill+0x3e>
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046b0 <fork2>:
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	56                   	push   %esi
801046b5:	53                   	push   %ebx
801046b6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801046b9:	e8 42 04 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801046be:	e8 6d f3 ff ff       	call   80103a30 <mycpu>
  p = c->proc;
801046c3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046c9:	e8 82 04 00 00       	call   80104b50 <popcli>
  if(slice < 0) {
801046ce:	8b 75 08             	mov    0x8(%ebp),%esi
801046d1:	85 f6                	test   %esi,%esi
801046d3:	0f 88 70 01 00 00    	js     80104849 <fork2+0x199>
  if((np = allocproc()) == 0){ // p gets pid and a spot in the ptable
801046d9:	e8 e2 f0 ff ff       	call   801037c0 <allocproc>
801046de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801046e1:	89 c7                	mov    %eax,%edi
801046e3:	85 c0                	test   %eax,%eax
801046e5:	0f 84 5e 01 00 00    	je     80104849 <fork2+0x199>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801046eb:	83 ec 08             	sub    $0x8,%esp
801046ee:	ff 33                	push   (%ebx)
801046f0:	ff 73 04             	push   0x4(%ebx)
801046f3:	e8 08 30 00 00       	call   80107700 <copyuvm>
801046f8:	83 c4 10             	add    $0x10,%esp
801046fb:	89 47 04             	mov    %eax,0x4(%edi)
801046fe:	85 c0                	test   %eax,%eax
80104700:	0f 84 24 01 00 00    	je     8010482a <fork2+0x17a>
  np->sz = curproc->sz;
80104706:	8b 03                	mov    (%ebx),%eax
80104708:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *np->tf = *curproc->tf;
8010470b:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80104710:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80104712:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80104715:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80104718:	8b 73 18             	mov    0x18(%ebx),%esi
8010471b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
8010471d:	89 d7                	mov    %edx,%edi
  for(i = 0; i < NOFILE; i++)
8010471f:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104721:	8b 42 18             	mov    0x18(%edx),%eax
80104724:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
8010472b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010472f:	90                   	nop
    if(curproc->ofile[i])
80104730:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104734:	85 c0                	test   %eax,%eax
80104736:	74 10                	je     80104748 <fork2+0x98>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	50                   	push   %eax
8010473c:	e8 5f c7 ff ff       	call   80100ea0 <filedup>
80104741:	83 c4 10             	add    $0x10,%esp
80104744:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104748:	83 c6 01             	add    $0x1,%esi
8010474b:	83 fe 10             	cmp    $0x10,%esi
8010474e:	75 e0                	jne    80104730 <fork2+0x80>
  np->cwd = idup(curproc->cwd);
80104750:	83 ec 0c             	sub    $0xc,%esp
80104753:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104756:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104759:	e8 f2 cf ff ff       	call   80101750 <idup>
8010475e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104761:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104764:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104767:	8d 47 6c             	lea    0x6c(%edi),%eax
8010476a:	6a 10                	push   $0x10
8010476c:	53                   	push   %ebx
8010476d:	50                   	push   %eax
8010476e:	e8 6d 07 00 00       	call   80104ee0 <safestrcpy>
  np->slice = slice;
80104773:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pid = np->pid;
80104776:	8b 5f 10             	mov    0x10(%edi),%ebx
  for(i = 0; !pstats->inuse[i]; i++){;} 
80104779:	83 c4 10             	add    $0x10,%esp
  np->slice = slice;
8010477c:	89 4f 7c             	mov    %ecx,0x7c(%edi)
  for(i = 0; !pstats->inuse[i]; i++){;} 
8010477f:	a1 74 51 11 80       	mov    0x80115174,%eax
80104784:	85 c0                	test   %eax,%eax
80104786:	0f 85 97 00 00 00    	jne    80104823 <fork2+0x173>
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104790:	83 c0 01             	add    $0x1,%eax
80104793:	8b 0c 85 74 51 11 80 	mov    -0x7feeae8c(,%eax,4),%ecx
8010479a:	85 c9                	test   %ecx,%ecx
8010479c:	74 f2                	je     80104790 <fork2+0xe0>
  acquire(&ptable.lock);
8010479e:	83 ec 0c             	sub    $0xc,%esp
  pstats->timeslice[i] = slice;
801047a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pstats->inuse[i] = 1;
801047a4:	c7 04 85 74 51 11 80 	movl   $0x1,-0x7feeae8c(,%eax,4)
801047ab:	01 00 00 00 
  acquire(&ptable.lock);
801047af:	68 40 2e 11 80       	push   $0x80112e40
  pstats->timeslice[i] = slice;
801047b4:	89 0c 85 74 53 11 80 	mov    %ecx,-0x7feeac8c(,%eax,4)
  pstats->pid[i] = pid;
801047bb:	89 1c 85 74 52 11 80 	mov    %ebx,-0x7feead8c(,%eax,4)
  pstats->compticks[i] = 0;
801047c2:	c7 04 85 74 54 11 80 	movl   $0x0,-0x7feeab8c(,%eax,4)
801047c9:	00 00 00 00 
  pstats->schedticks[i] = 0;
801047cd:	c7 04 85 74 55 11 80 	movl   $0x0,-0x7feeaa8c(,%eax,4)
801047d4:	00 00 00 00 
  pstats->sleepticks[i] = 0;
801047d8:	c7 04 85 74 56 11 80 	movl   $0x0,-0x7feea98c(,%eax,4)
801047df:	00 00 00 00 
  pstats->switches[i] = 0;
801047e3:	c7 04 85 74 57 11 80 	movl   $0x0,-0x7feea88c(,%eax,4)
801047ea:	00 00 00 00 
  acquire(&ptable.lock);
801047ee:	e8 5d 04 00 00       	call   80104c50 <acquire>
  np->state = RUNNABLE;
801047f3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801047f6:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801047fd:	c7 04 24 40 2e 11 80 	movl   $0x80112e40,(%esp)
80104804:	e8 e7 03 00 00       	call   80104bf0 <release>
  enq(&q, np);
80104809:	58                   	pop    %eax
8010480a:	5a                   	pop    %edx
8010480b:	57                   	push   %edi
8010480c:	68 20 2d 11 80       	push   $0x80112d20
80104811:	e8 aa fb ff ff       	call   801043c0 <enq>
  return pid;
80104816:	83 c4 10             	add    $0x10,%esp
}
80104819:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010481c:	89 d8                	mov    %ebx,%eax
8010481e:	5b                   	pop    %ebx
8010481f:	5e                   	pop    %esi
80104820:	5f                   	pop    %edi
80104821:	5d                   	pop    %ebp
80104822:	c3                   	ret    
  for(i = 0; !pstats->inuse[i]; i++){;} 
80104823:	31 c0                	xor    %eax,%eax
80104825:	e9 74 ff ff ff       	jmp    8010479e <fork2+0xee>
    kfree(np->kstack);
8010482a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010482d:	83 ec 0c             	sub    $0xc,%esp
80104830:	ff 73 08             	push   0x8(%ebx)
80104833:	e8 88 dc ff ff       	call   801024c0 <kfree>
    np->kstack = 0;
80104838:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
8010483f:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104842:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104849:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010484e:	eb c9                	jmp    80104819 <fork2+0x169>

80104850 <fork>:
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	53                   	push   %ebx
80104854:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104857:	e8 a4 02 00 00       	call   80104b00 <pushcli>
  c = mycpu();
8010485c:	e8 cf f1 ff ff       	call   80103a30 <mycpu>
  p = c->proc;
80104861:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104867:	e8 e4 02 00 00       	call   80104b50 <popcli>
  return fork2(myproc()->slice);
8010486c:	83 ec 0c             	sub    $0xc,%esp
8010486f:	ff 73 7c             	push   0x7c(%ebx)
80104872:	e8 39 fe ff ff       	call   801046b0 <fork2>
}
80104877:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010487a:	c9                   	leave  
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <deq>:
struct proc* deq(struct queue* queue) {
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	56                   	push   %esi
80104885:	53                   	push   %ebx
80104886:	83 ec 18             	sub    $0x18,%esp
80104889:	8b 75 08             	mov    0x8(%ebp),%esi
  cprintf("deq ");
8010488c:	68 6e 7f 10 80       	push   $0x80107f6e
80104891:	e8 0a be ff ff       	call   801006a0 <cprintf>
  if(queue->size == 0){
80104896:	8b 96 08 01 00 00    	mov    0x108(%esi),%edx
8010489c:	83 c4 10             	add    $0x10,%esp
8010489f:	85 d2                	test   %edx,%edx
801048a1:	0f 84 81 00 00 00    	je     80104928 <deq+0xa8>
  struct proc* process = queue->buffer[queue->front];
801048a7:	8b 86 00 01 00 00    	mov    0x100(%esi),%eax
  cprintf("QUEUE:\n");
801048ad:	83 ec 0c             	sub    $0xc,%esp
  queue->size--;
801048b0:	83 ea 01             	sub    $0x1,%edx
  struct proc* process = queue->buffer[queue->front];
801048b3:	8b 3c 86             	mov    (%esi,%eax,4),%edi
  queue->front = (queue->front + 1) % NPROC;
801048b6:	83 c0 01             	add    $0x1,%eax
  queue->size--;
801048b9:	89 96 08 01 00 00    	mov    %edx,0x108(%esi)
  queue->front = (queue->front + 1) % NPROC;
801048bf:	89 c1                	mov    %eax,%ecx
801048c1:	c1 f9 1f             	sar    $0x1f,%ecx
801048c4:	c1 e9 1a             	shr    $0x1a,%ecx
801048c7:	01 c8                	add    %ecx,%eax
801048c9:	83 e0 3f             	and    $0x3f,%eax
801048cc:	29 c8                	sub    %ecx,%eax
801048ce:	89 86 00 01 00 00    	mov    %eax,0x100(%esi)
  cprintf("QUEUE:\n");
801048d4:	68 b9 7e 10 80       	push   $0x80107eb9
801048d9:	e8 c2 bd ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
801048de:	8b 86 08 01 00 00    	mov    0x108(%esi),%eax
801048e4:	83 c4 10             	add    $0x10,%esp
801048e7:	85 c0                	test   %eax,%eax
801048e9:	7e 2f                	jle    8010491a <deq+0x9a>
  int i = 0;
801048eb:	31 db                	xor    %ebx,%ebx
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
    p = q->buffer[q->front + i];
801048f0:	8b 86 00 01 00 00    	mov    0x100(%esi),%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801048f6:	83 ec 04             	sub    $0x4,%esp
    p = q->buffer[q->front + i];
801048f9:	01 d8                	add    %ebx,%eax
    cprintf("[%d]: pid %d\n", i, p->pid);
801048fb:	8b 04 86             	mov    (%esi,%eax,4),%eax
801048fe:	ff 70 10             	push   0x10(%eax)
80104901:	53                   	push   %ebx
    i++;
80104902:	83 c3 01             	add    $0x1,%ebx
    cprintf("[%d]: pid %d\n", i, p->pid);
80104905:	68 c1 7e 10 80       	push   $0x80107ec1
8010490a:	e8 91 bd ff ff       	call   801006a0 <cprintf>
  while(i < q->size){
8010490f:	83 c4 10             	add    $0x10,%esp
80104912:	3b 9e 08 01 00 00    	cmp    0x108(%esi),%ebx
80104918:	7c d6                	jl     801048f0 <deq+0x70>
  printq(queue);
  return process;
}
8010491a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010491d:	89 f8                	mov    %edi,%eax
8010491f:	5b                   	pop    %ebx
80104920:	5e                   	pop    %esi
80104921:	5f                   	pop    %edi
80104922:	5d                   	pop    %ebp
80104923:	c3                   	ret    
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("empty\n");
80104928:	83 ec 0c             	sub    $0xc,%esp
    return (struct proc *)0;
8010492b:	31 ff                	xor    %edi,%edi
    cprintf("empty\n");
8010492d:	68 73 7f 10 80       	push   $0x80107f73
80104932:	e8 69 bd ff ff       	call   801006a0 <cprintf>
    return (struct proc *)0;
80104937:	83 c4 10             	add    $0x10,%esp
}
8010493a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010493d:	89 f8                	mov    %edi,%eax
8010493f:	5b                   	pop    %ebx
80104940:	5e                   	pop    %esi
80104941:	5f                   	pop    %edi
80104942:	5d                   	pop    %ebp
80104943:	c3                   	ret    
80104944:	66 90                	xchg   %ax,%ax
80104946:	66 90                	xchg   %ax,%ax
80104948:	66 90                	xchg   %ax,%ax
8010494a:	66 90                	xchg   %ax,%ax
8010494c:	66 90                	xchg   %ax,%ax
8010494e:	66 90                	xchg   %ax,%ax

80104950 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 0c             	sub    $0xc,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010495a:	68 08 80 10 80       	push   $0x80108008
8010495f:	8d 43 04             	lea    0x4(%ebx),%eax
80104962:	50                   	push   %eax
80104963:	e8 18 01 00 00       	call   80104a80 <initlock>
  lk->name = name;
80104968:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010496b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104971:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104974:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010497b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010497e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104981:	c9                   	leave  
80104982:	c3                   	ret    
80104983:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104990 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	56                   	push   %esi
80104994:	53                   	push   %ebx
80104995:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104998:	8d 73 04             	lea    0x4(%ebx),%esi
8010499b:	83 ec 0c             	sub    $0xc,%esp
8010499e:	56                   	push   %esi
8010499f:	e8 ac 02 00 00       	call   80104c50 <acquire>
  while (lk->locked) {
801049a4:	8b 13                	mov    (%ebx),%edx
801049a6:	83 c4 10             	add    $0x10,%esp
801049a9:	85 d2                	test   %edx,%edx
801049ab:	74 16                	je     801049c3 <acquiresleep+0x33>
801049ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801049b0:	83 ec 08             	sub    $0x8,%esp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
801049b5:	e8 b6 f4 ff ff       	call   80103e70 <sleep>
  while (lk->locked) {
801049ba:	8b 03                	mov    (%ebx),%eax
801049bc:	83 c4 10             	add    $0x10,%esp
801049bf:	85 c0                	test   %eax,%eax
801049c1:	75 ed                	jne    801049b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801049c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801049c9:	e8 e2 f0 ff ff       	call   80103ab0 <myproc>
801049ce:	8b 40 10             	mov    0x10(%eax),%eax
801049d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801049d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049da:	5b                   	pop    %ebx
801049db:	5e                   	pop    %esi
801049dc:	5d                   	pop    %ebp
  release(&lk->lk);
801049dd:	e9 0e 02 00 00       	jmp    80104bf0 <release>
801049e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
801049f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049f8:	8d 73 04             	lea    0x4(%ebx),%esi
801049fb:	83 ec 0c             	sub    $0xc,%esp
801049fe:	56                   	push   %esi
801049ff:	e8 4c 02 00 00       	call   80104c50 <acquire>
  lk->locked = 0;
80104a04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104a11:	89 1c 24             	mov    %ebx,(%esp)
80104a14:	e8 37 f5 ff ff       	call   80103f50 <wakeup>
  release(&lk->lk);
80104a19:	89 75 08             	mov    %esi,0x8(%ebp)
80104a1c:	83 c4 10             	add    $0x10,%esp
}
80104a1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a22:	5b                   	pop    %ebx
80104a23:	5e                   	pop    %esi
80104a24:	5d                   	pop    %ebp
  release(&lk->lk);
80104a25:	e9 c6 01 00 00       	jmp    80104bf0 <release>
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	31 ff                	xor    %edi,%edi
80104a36:	56                   	push   %esi
80104a37:	53                   	push   %ebx
80104a38:	83 ec 18             	sub    $0x18,%esp
80104a3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a3e:	8d 73 04             	lea    0x4(%ebx),%esi
80104a41:	56                   	push   %esi
80104a42:	e8 09 02 00 00       	call   80104c50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a47:	8b 03                	mov    (%ebx),%eax
80104a49:	83 c4 10             	add    $0x10,%esp
80104a4c:	85 c0                	test   %eax,%eax
80104a4e:	75 18                	jne    80104a68 <holdingsleep+0x38>
  release(&lk->lk);
80104a50:	83 ec 0c             	sub    $0xc,%esp
80104a53:	56                   	push   %esi
80104a54:	e8 97 01 00 00       	call   80104bf0 <release>
  return r;
}
80104a59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a5c:	89 f8                	mov    %edi,%eax
80104a5e:	5b                   	pop    %ebx
80104a5f:	5e                   	pop    %esi
80104a60:	5f                   	pop    %edi
80104a61:	5d                   	pop    %ebp
80104a62:	c3                   	ret    
80104a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a67:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104a68:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a6b:	e8 40 f0 ff ff       	call   80103ab0 <myproc>
80104a70:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a73:	0f 94 c0             	sete   %al
80104a76:	0f b6 c0             	movzbl %al,%eax
80104a79:	89 c7                	mov    %eax,%edi
80104a7b:	eb d3                	jmp    80104a50 <holdingsleep+0x20>
80104a7d:	66 90                	xchg   %ax,%ax
80104a7f:	90                   	nop

80104a80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104a8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104a92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104a99:	5d                   	pop    %ebp
80104a9a:	c3                   	ret    
80104a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a9f:	90                   	nop

80104aa0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104aa0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104aa1:	31 d2                	xor    %edx,%edx
{
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104aa6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104aa9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104aac:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104aaf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ab0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104ab6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104abc:	77 1a                	ja     80104ad8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104abe:	8b 58 04             	mov    0x4(%eax),%ebx
80104ac1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104ac4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104ac7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ac9:	83 fa 0a             	cmp    $0xa,%edx
80104acc:	75 e2                	jne    80104ab0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104ace:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ad1:	c9                   	leave  
80104ad2:	c3                   	ret    
80104ad3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ad7:	90                   	nop
  for(; i < 10; i++)
80104ad8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104adb:	8d 51 28             	lea    0x28(%ecx),%edx
80104ade:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ae0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ae6:	83 c0 04             	add    $0x4,%eax
80104ae9:	39 d0                	cmp    %edx,%eax
80104aeb:	75 f3                	jne    80104ae0 <getcallerpcs+0x40>
}
80104aed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104af0:	c9                   	leave  
80104af1:	c3                   	ret    
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b00 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b07:	9c                   	pushf  
80104b08:	5b                   	pop    %ebx
  asm volatile("cli");
80104b09:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b0a:	e8 21 ef ff ff       	call   80103a30 <mycpu>
80104b0f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b15:	85 c0                	test   %eax,%eax
80104b17:	74 17                	je     80104b30 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104b19:	e8 12 ef ff ff       	call   80103a30 <mycpu>
80104b1e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104b25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b28:	c9                   	leave  
80104b29:	c3                   	ret    
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104b30:	e8 fb ee ff ff       	call   80103a30 <mycpu>
80104b35:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b3b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b41:	eb d6                	jmp    80104b19 <pushcli+0x19>
80104b43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b50 <popcli>:

void
popcli(void)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b56:	9c                   	pushf  
80104b57:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b58:	f6 c4 02             	test   $0x2,%ah
80104b5b:	75 35                	jne    80104b92 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104b5d:	e8 ce ee ff ff       	call   80103a30 <mycpu>
80104b62:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b69:	78 34                	js     80104b9f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b6b:	e8 c0 ee ff ff       	call   80103a30 <mycpu>
80104b70:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b76:	85 d2                	test   %edx,%edx
80104b78:	74 06                	je     80104b80 <popcli+0x30>
    sti();
}
80104b7a:	c9                   	leave  
80104b7b:	c3                   	ret    
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b80:	e8 ab ee ff ff       	call   80103a30 <mycpu>
80104b85:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b8b:	85 c0                	test   %eax,%eax
80104b8d:	74 eb                	je     80104b7a <popcli+0x2a>
  asm volatile("sti");
80104b8f:	fb                   	sti    
}
80104b90:	c9                   	leave  
80104b91:	c3                   	ret    
    panic("popcli - interruptible");
80104b92:	83 ec 0c             	sub    $0xc,%esp
80104b95:	68 13 80 10 80       	push   $0x80108013
80104b9a:	e8 e1 b7 ff ff       	call   80100380 <panic>
    panic("popcli");
80104b9f:	83 ec 0c             	sub    $0xc,%esp
80104ba2:	68 2a 80 10 80       	push   $0x8010802a
80104ba7:	e8 d4 b7 ff ff       	call   80100380 <panic>
80104bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <holding>:
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
80104bb5:	8b 75 08             	mov    0x8(%ebp),%esi
80104bb8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104bba:	e8 41 ff ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bbf:	8b 06                	mov    (%esi),%eax
80104bc1:	85 c0                	test   %eax,%eax
80104bc3:	75 0b                	jne    80104bd0 <holding+0x20>
  popcli();
80104bc5:	e8 86 ff ff ff       	call   80104b50 <popcli>
}
80104bca:	89 d8                	mov    %ebx,%eax
80104bcc:	5b                   	pop    %ebx
80104bcd:	5e                   	pop    %esi
80104bce:	5d                   	pop    %ebp
80104bcf:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104bd0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104bd3:	e8 58 ee ff ff       	call   80103a30 <mycpu>
80104bd8:	39 c3                	cmp    %eax,%ebx
80104bda:	0f 94 c3             	sete   %bl
  popcli();
80104bdd:	e8 6e ff ff ff       	call   80104b50 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104be2:	0f b6 db             	movzbl %bl,%ebx
}
80104be5:	89 d8                	mov    %ebx,%eax
80104be7:	5b                   	pop    %ebx
80104be8:	5e                   	pop    %esi
80104be9:	5d                   	pop    %ebp
80104bea:	c3                   	ret    
80104beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bef:	90                   	nop

80104bf0 <release>:
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104bf8:	e8 03 ff ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bfd:	8b 03                	mov    (%ebx),%eax
80104bff:	85 c0                	test   %eax,%eax
80104c01:	75 15                	jne    80104c18 <release+0x28>
  popcli();
80104c03:	e8 48 ff ff ff       	call   80104b50 <popcli>
    panic("release");
80104c08:	83 ec 0c             	sub    $0xc,%esp
80104c0b:	68 31 80 10 80       	push   $0x80108031
80104c10:	e8 6b b7 ff ff       	call   80100380 <panic>
80104c15:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104c18:	8b 73 08             	mov    0x8(%ebx),%esi
80104c1b:	e8 10 ee ff ff       	call   80103a30 <mycpu>
80104c20:	39 c6                	cmp    %eax,%esi
80104c22:	75 df                	jne    80104c03 <release+0x13>
  popcli();
80104c24:	e8 27 ff ff ff       	call   80104b50 <popcli>
  lk->pcs[0] = 0;
80104c29:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104c30:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104c37:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104c3c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104c42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c45:	5b                   	pop    %ebx
80104c46:	5e                   	pop    %esi
80104c47:	5d                   	pop    %ebp
  popcli();
80104c48:	e9 03 ff ff ff       	jmp    80104b50 <popcli>
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi

80104c50 <acquire>:
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	53                   	push   %ebx
80104c54:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104c57:	e8 a4 fe ff ff       	call   80104b00 <pushcli>
  if(holding(lk)){
80104c5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104c5f:	e8 9c fe ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c64:	8b 03                	mov    (%ebx),%eax
80104c66:	85 c0                	test   %eax,%eax
80104c68:	75 7e                	jne    80104ce8 <acquire+0x98>
  popcli();
80104c6a:	e8 e1 fe ff ff       	call   80104b50 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104c6f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104c78:	8b 55 08             	mov    0x8(%ebp),%edx
80104c7b:	89 c8                	mov    %ecx,%eax
80104c7d:	f0 87 02             	lock xchg %eax,(%edx)
80104c80:	85 c0                	test   %eax,%eax
80104c82:	75 f4                	jne    80104c78 <acquire+0x28>
  __sync_synchronize();
80104c84:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c8c:	e8 9f ed ff ff       	call   80103a30 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104c91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104c94:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104c96:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104c99:	31 c0                	xor    %eax,%eax
80104c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ca0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104ca6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104cac:	77 1a                	ja     80104cc8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80104cae:	8b 5a 04             	mov    0x4(%edx),%ebx
80104cb1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104cb5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104cb8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104cba:	83 f8 0a             	cmp    $0xa,%eax
80104cbd:	75 e1                	jne    80104ca0 <acquire+0x50>
}
80104cbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc2:	c9                   	leave  
80104cc3:	c3                   	ret    
80104cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104cc8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104ccc:	8d 51 34             	lea    0x34(%ecx),%edx
80104ccf:	90                   	nop
    pcs[i] = 0;
80104cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104cd6:	83 c0 04             	add    $0x4,%eax
80104cd9:	39 c2                	cmp    %eax,%edx
80104cdb:	75 f3                	jne    80104cd0 <acquire+0x80>
}
80104cdd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ce0:	c9                   	leave  
80104ce1:	c3                   	ret    
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104ce8:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104ceb:	e8 40 ed ff ff       	call   80103a30 <mycpu>
80104cf0:	39 c3                	cmp    %eax,%ebx
80104cf2:	0f 85 72 ff ff ff    	jne    80104c6a <acquire+0x1a>
  popcli();
80104cf8:	e8 53 fe ff ff       	call   80104b50 <popcli>
    cprintf("BITCH %s\n", lk->name);
80104cfd:	8b 45 08             	mov    0x8(%ebp),%eax
80104d00:	83 ec 08             	sub    $0x8,%esp
80104d03:	ff 70 04             	push   0x4(%eax)
80104d06:	68 39 80 10 80       	push   $0x80108039
80104d0b:	e8 90 b9 ff ff       	call   801006a0 <cprintf>
    panic("acquire");
80104d10:	c7 04 24 43 80 10 80 	movl   $0x80108043,(%esp)
80104d17:	e8 64 b6 ff ff       	call   80100380 <panic>
80104d1c:	66 90                	xchg   %ax,%ax
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	57                   	push   %edi
80104d24:	8b 55 08             	mov    0x8(%ebp),%edx
80104d27:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d2a:	53                   	push   %ebx
80104d2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104d2e:	89 d7                	mov    %edx,%edi
80104d30:	09 cf                	or     %ecx,%edi
80104d32:	83 e7 03             	and    $0x3,%edi
80104d35:	75 29                	jne    80104d60 <memset+0x40>
    c &= 0xFF;
80104d37:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d3a:	c1 e0 18             	shl    $0x18,%eax
80104d3d:	89 fb                	mov    %edi,%ebx
80104d3f:	c1 e9 02             	shr    $0x2,%ecx
80104d42:	c1 e3 10             	shl    $0x10,%ebx
80104d45:	09 d8                	or     %ebx,%eax
80104d47:	09 f8                	or     %edi,%eax
80104d49:	c1 e7 08             	shl    $0x8,%edi
80104d4c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104d4e:	89 d7                	mov    %edx,%edi
80104d50:	fc                   	cld    
80104d51:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d53:	5b                   	pop    %ebx
80104d54:	89 d0                	mov    %edx,%eax
80104d56:	5f                   	pop    %edi
80104d57:	5d                   	pop    %ebp
80104d58:	c3                   	ret    
80104d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104d60:	89 d7                	mov    %edx,%edi
80104d62:	fc                   	cld    
80104d63:	f3 aa                	rep stos %al,%es:(%edi)
80104d65:	5b                   	pop    %ebx
80104d66:	89 d0                	mov    %edx,%eax
80104d68:	5f                   	pop    %edi
80104d69:	5d                   	pop    %ebp
80104d6a:	c3                   	ret    
80104d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d6f:	90                   	nop

80104d70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	8b 75 10             	mov    0x10(%ebp),%esi
80104d77:	8b 55 08             	mov    0x8(%ebp),%edx
80104d7a:	53                   	push   %ebx
80104d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d7e:	85 f6                	test   %esi,%esi
80104d80:	74 2e                	je     80104db0 <memcmp+0x40>
80104d82:	01 c6                	add    %eax,%esi
80104d84:	eb 14                	jmp    80104d9a <memcmp+0x2a>
80104d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d90:	83 c0 01             	add    $0x1,%eax
80104d93:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d96:	39 f0                	cmp    %esi,%eax
80104d98:	74 16                	je     80104db0 <memcmp+0x40>
    if(*s1 != *s2)
80104d9a:	0f b6 0a             	movzbl (%edx),%ecx
80104d9d:	0f b6 18             	movzbl (%eax),%ebx
80104da0:	38 d9                	cmp    %bl,%cl
80104da2:	74 ec                	je     80104d90 <memcmp+0x20>
      return *s1 - *s2;
80104da4:	0f b6 c1             	movzbl %cl,%eax
80104da7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104da9:	5b                   	pop    %ebx
80104daa:	5e                   	pop    %esi
80104dab:	5d                   	pop    %ebp
80104dac:	c3                   	ret    
80104dad:	8d 76 00             	lea    0x0(%esi),%esi
80104db0:	5b                   	pop    %ebx
  return 0;
80104db1:	31 c0                	xor    %eax,%eax
}
80104db3:	5e                   	pop    %esi
80104db4:	5d                   	pop    %ebp
80104db5:	c3                   	ret    
80104db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi

80104dc0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	57                   	push   %edi
80104dc4:	8b 55 08             	mov    0x8(%ebp),%edx
80104dc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104dca:	56                   	push   %esi
80104dcb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104dce:	39 d6                	cmp    %edx,%esi
80104dd0:	73 26                	jae    80104df8 <memmove+0x38>
80104dd2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104dd5:	39 fa                	cmp    %edi,%edx
80104dd7:	73 1f                	jae    80104df8 <memmove+0x38>
80104dd9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104ddc:	85 c9                	test   %ecx,%ecx
80104dde:	74 0c                	je     80104dec <memmove+0x2c>
      *--d = *--s;
80104de0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104de4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104de7:	83 e8 01             	sub    $0x1,%eax
80104dea:	73 f4                	jae    80104de0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104dec:	5e                   	pop    %esi
80104ded:	89 d0                	mov    %edx,%eax
80104def:	5f                   	pop    %edi
80104df0:	5d                   	pop    %ebp
80104df1:	c3                   	ret    
80104df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104df8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104dfb:	89 d7                	mov    %edx,%edi
80104dfd:	85 c9                	test   %ecx,%ecx
80104dff:	74 eb                	je     80104dec <memmove+0x2c>
80104e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104e08:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104e09:	39 c6                	cmp    %eax,%esi
80104e0b:	75 fb                	jne    80104e08 <memmove+0x48>
}
80104e0d:	5e                   	pop    %esi
80104e0e:	89 d0                	mov    %edx,%eax
80104e10:	5f                   	pop    %edi
80104e11:	5d                   	pop    %ebp
80104e12:	c3                   	ret    
80104e13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104e20:	eb 9e                	jmp    80104dc0 <memmove>
80104e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e30 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	8b 75 10             	mov    0x10(%ebp),%esi
80104e37:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e3a:	53                   	push   %ebx
80104e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104e3e:	85 f6                	test   %esi,%esi
80104e40:	74 2e                	je     80104e70 <strncmp+0x40>
80104e42:	01 d6                	add    %edx,%esi
80104e44:	eb 18                	jmp    80104e5e <strncmp+0x2e>
80104e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e4d:	8d 76 00             	lea    0x0(%esi),%esi
80104e50:	38 d8                	cmp    %bl,%al
80104e52:	75 14                	jne    80104e68 <strncmp+0x38>
    n--, p++, q++;
80104e54:	83 c2 01             	add    $0x1,%edx
80104e57:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e5a:	39 f2                	cmp    %esi,%edx
80104e5c:	74 12                	je     80104e70 <strncmp+0x40>
80104e5e:	0f b6 01             	movzbl (%ecx),%eax
80104e61:	0f b6 1a             	movzbl (%edx),%ebx
80104e64:	84 c0                	test   %al,%al
80104e66:	75 e8                	jne    80104e50 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104e68:	29 d8                	sub    %ebx,%eax
}
80104e6a:	5b                   	pop    %ebx
80104e6b:	5e                   	pop    %esi
80104e6c:	5d                   	pop    %ebp
80104e6d:	c3                   	ret    
80104e6e:	66 90                	xchg   %ax,%ax
80104e70:	5b                   	pop    %ebx
    return 0;
80104e71:	31 c0                	xor    %eax,%eax
}
80104e73:	5e                   	pop    %esi
80104e74:	5d                   	pop    %ebp
80104e75:	c3                   	ret    
80104e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi

80104e80 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	57                   	push   %edi
80104e84:	56                   	push   %esi
80104e85:	8b 75 08             	mov    0x8(%ebp),%esi
80104e88:	53                   	push   %ebx
80104e89:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e8c:	89 f0                	mov    %esi,%eax
80104e8e:	eb 15                	jmp    80104ea5 <strncpy+0x25>
80104e90:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e94:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e97:	83 c0 01             	add    $0x1,%eax
80104e9a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104e9e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104ea1:	84 d2                	test   %dl,%dl
80104ea3:	74 09                	je     80104eae <strncpy+0x2e>
80104ea5:	89 cb                	mov    %ecx,%ebx
80104ea7:	83 e9 01             	sub    $0x1,%ecx
80104eaa:	85 db                	test   %ebx,%ebx
80104eac:	7f e2                	jg     80104e90 <strncpy+0x10>
    ;
  while(n-- > 0)
80104eae:	89 c2                	mov    %eax,%edx
80104eb0:	85 c9                	test   %ecx,%ecx
80104eb2:	7e 17                	jle    80104ecb <strncpy+0x4b>
80104eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104eb8:	83 c2 01             	add    $0x1,%edx
80104ebb:	89 c1                	mov    %eax,%ecx
80104ebd:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104ec1:	29 d1                	sub    %edx,%ecx
80104ec3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104ec7:	85 c9                	test   %ecx,%ecx
80104ec9:	7f ed                	jg     80104eb8 <strncpy+0x38>
  return os;
}
80104ecb:	5b                   	pop    %ebx
80104ecc:	89 f0                	mov    %esi,%eax
80104ece:	5e                   	pop    %esi
80104ecf:	5f                   	pop    %edi
80104ed0:	5d                   	pop    %ebp
80104ed1:	c3                   	ret    
80104ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ee0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	56                   	push   %esi
80104ee4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ee7:	8b 75 08             	mov    0x8(%ebp),%esi
80104eea:	53                   	push   %ebx
80104eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104eee:	85 d2                	test   %edx,%edx
80104ef0:	7e 25                	jle    80104f17 <safestrcpy+0x37>
80104ef2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104ef6:	89 f2                	mov    %esi,%edx
80104ef8:	eb 16                	jmp    80104f10 <safestrcpy+0x30>
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f00:	0f b6 08             	movzbl (%eax),%ecx
80104f03:	83 c0 01             	add    $0x1,%eax
80104f06:	83 c2 01             	add    $0x1,%edx
80104f09:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f0c:	84 c9                	test   %cl,%cl
80104f0e:	74 04                	je     80104f14 <safestrcpy+0x34>
80104f10:	39 d8                	cmp    %ebx,%eax
80104f12:	75 ec                	jne    80104f00 <safestrcpy+0x20>
    ;
  *s = 0;
80104f14:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104f17:	89 f0                	mov    %esi,%eax
80104f19:	5b                   	pop    %ebx
80104f1a:	5e                   	pop    %esi
80104f1b:	5d                   	pop    %ebp
80104f1c:	c3                   	ret    
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi

80104f20 <strlen>:

int
strlen(const char *s)
{
80104f20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f21:	31 c0                	xor    %eax,%eax
{
80104f23:	89 e5                	mov    %esp,%ebp
80104f25:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f28:	80 3a 00             	cmpb   $0x0,(%edx)
80104f2b:	74 0c                	je     80104f39 <strlen+0x19>
80104f2d:	8d 76 00             	lea    0x0(%esi),%esi
80104f30:	83 c0 01             	add    $0x1,%eax
80104f33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f37:	75 f7                	jne    80104f30 <strlen+0x10>
    ;
  return n;
}
80104f39:	5d                   	pop    %ebp
80104f3a:	c3                   	ret    

80104f3b <swtch>:
80104f3b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104f3f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104f43:	55                   	push   %ebp
80104f44:	53                   	push   %ebx
80104f45:	56                   	push   %esi
80104f46:	57                   	push   %edi
80104f47:	89 20                	mov    %esp,(%eax)
80104f49:	89 d4                	mov    %edx,%esp
80104f4b:	5f                   	pop    %edi
80104f4c:	5e                   	pop    %esi
80104f4d:	5b                   	pop    %ebx
80104f4e:	5d                   	pop    %ebp
80104f4f:	c3                   	ret    

80104f50 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	53                   	push   %ebx
80104f54:	83 ec 04             	sub    $0x4,%esp
80104f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f5a:	e8 51 eb ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f5f:	8b 00                	mov    (%eax),%eax
80104f61:	39 d8                	cmp    %ebx,%eax
80104f63:	76 1b                	jbe    80104f80 <fetchint+0x30>
80104f65:	8d 53 04             	lea    0x4(%ebx),%edx
80104f68:	39 d0                	cmp    %edx,%eax
80104f6a:	72 14                	jb     80104f80 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f6f:	8b 13                	mov    (%ebx),%edx
80104f71:	89 10                	mov    %edx,(%eax)
  return 0;
80104f73:	31 c0                	xor    %eax,%eax
}
80104f75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f78:	c9                   	leave  
80104f79:	c3                   	ret    
80104f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f85:	eb ee                	jmp    80104f75 <fetchint+0x25>
80104f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8e:	66 90                	xchg   %ax,%ax

80104f90 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	53                   	push   %ebx
80104f94:	83 ec 04             	sub    $0x4,%esp
80104f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f9a:	e8 11 eb ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz)
80104f9f:	39 18                	cmp    %ebx,(%eax)
80104fa1:	76 2d                	jbe    80104fd0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fa6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104fa8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104faa:	39 d3                	cmp    %edx,%ebx
80104fac:	73 22                	jae    80104fd0 <fetchstr+0x40>
80104fae:	89 d8                	mov    %ebx,%eax
80104fb0:	eb 0d                	jmp    80104fbf <fetchstr+0x2f>
80104fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fb8:	83 c0 01             	add    $0x1,%eax
80104fbb:	39 c2                	cmp    %eax,%edx
80104fbd:	76 11                	jbe    80104fd0 <fetchstr+0x40>
    if(*s == 0)
80104fbf:	80 38 00             	cmpb   $0x0,(%eax)
80104fc2:	75 f4                	jne    80104fb8 <fetchstr+0x28>
      return s - *pp;
80104fc4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104fc6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fc9:	c9                   	leave  
80104fca:	c3                   	ret    
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop
80104fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd8:	c9                   	leave  
80104fd9:	c3                   	ret    
80104fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fe0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fe5:	e8 c6 ea ff ff       	call   80103ab0 <myproc>
80104fea:	8b 55 08             	mov    0x8(%ebp),%edx
80104fed:	8b 40 18             	mov    0x18(%eax),%eax
80104ff0:	8b 40 44             	mov    0x44(%eax),%eax
80104ff3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ff6:	e8 b5 ea ff ff       	call   80103ab0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ffb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ffe:	8b 00                	mov    (%eax),%eax
80105000:	39 c6                	cmp    %eax,%esi
80105002:	73 1c                	jae    80105020 <argint+0x40>
80105004:	8d 53 08             	lea    0x8(%ebx),%edx
80105007:	39 d0                	cmp    %edx,%eax
80105009:	72 15                	jb     80105020 <argint+0x40>
  *ip = *(int*)(addr);
8010500b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010500e:	8b 53 04             	mov    0x4(%ebx),%edx
80105011:	89 10                	mov    %edx,(%eax)
  return 0;
80105013:	31 c0                	xor    %eax,%eax
}
80105015:	5b                   	pop    %ebx
80105016:	5e                   	pop    %esi
80105017:	5d                   	pop    %ebp
80105018:	c3                   	ret    
80105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105025:	eb ee                	jmp    80105015 <argint+0x35>
80105027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010502e:	66 90                	xchg   %ax,%ax

80105030 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
80105036:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105039:	e8 72 ea ff ff       	call   80103ab0 <myproc>
8010503e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105040:	e8 6b ea ff ff       	call   80103ab0 <myproc>
80105045:	8b 55 08             	mov    0x8(%ebp),%edx
80105048:	8b 40 18             	mov    0x18(%eax),%eax
8010504b:	8b 40 44             	mov    0x44(%eax),%eax
8010504e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105051:	e8 5a ea ff ff       	call   80103ab0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105056:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105059:	8b 00                	mov    (%eax),%eax
8010505b:	39 c7                	cmp    %eax,%edi
8010505d:	73 31                	jae    80105090 <argptr+0x60>
8010505f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105062:	39 c8                	cmp    %ecx,%eax
80105064:	72 2a                	jb     80105090 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105066:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105069:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010506c:	85 d2                	test   %edx,%edx
8010506e:	78 20                	js     80105090 <argptr+0x60>
80105070:	8b 16                	mov    (%esi),%edx
80105072:	39 c2                	cmp    %eax,%edx
80105074:	76 1a                	jbe    80105090 <argptr+0x60>
80105076:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105079:	01 c3                	add    %eax,%ebx
8010507b:	39 da                	cmp    %ebx,%edx
8010507d:	72 11                	jb     80105090 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010507f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105082:	89 02                	mov    %eax,(%edx)
  return 0;
80105084:	31 c0                	xor    %eax,%eax
}
80105086:	83 c4 0c             	add    $0xc,%esp
80105089:	5b                   	pop    %ebx
8010508a:	5e                   	pop    %esi
8010508b:	5f                   	pop    %edi
8010508c:	5d                   	pop    %ebp
8010508d:	c3                   	ret    
8010508e:	66 90                	xchg   %ax,%ax
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105095:	eb ef                	jmp    80105086 <argptr+0x56>
80105097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509e:	66 90                	xchg   %ax,%ax

801050a0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050a5:	e8 06 ea ff ff       	call   80103ab0 <myproc>
801050aa:	8b 55 08             	mov    0x8(%ebp),%edx
801050ad:	8b 40 18             	mov    0x18(%eax),%eax
801050b0:	8b 40 44             	mov    0x44(%eax),%eax
801050b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801050b6:	e8 f5 e9 ff ff       	call   80103ab0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050bb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050be:	8b 00                	mov    (%eax),%eax
801050c0:	39 c6                	cmp    %eax,%esi
801050c2:	73 44                	jae    80105108 <argstr+0x68>
801050c4:	8d 53 08             	lea    0x8(%ebx),%edx
801050c7:	39 d0                	cmp    %edx,%eax
801050c9:	72 3d                	jb     80105108 <argstr+0x68>
  *ip = *(int*)(addr);
801050cb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801050ce:	e8 dd e9 ff ff       	call   80103ab0 <myproc>
  if(addr >= curproc->sz)
801050d3:	3b 18                	cmp    (%eax),%ebx
801050d5:	73 31                	jae    80105108 <argstr+0x68>
  *pp = (char*)addr;
801050d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801050da:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801050dc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801050de:	39 d3                	cmp    %edx,%ebx
801050e0:	73 26                	jae    80105108 <argstr+0x68>
801050e2:	89 d8                	mov    %ebx,%eax
801050e4:	eb 11                	jmp    801050f7 <argstr+0x57>
801050e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ed:	8d 76 00             	lea    0x0(%esi),%esi
801050f0:	83 c0 01             	add    $0x1,%eax
801050f3:	39 c2                	cmp    %eax,%edx
801050f5:	76 11                	jbe    80105108 <argstr+0x68>
    if(*s == 0)
801050f7:	80 38 00             	cmpb   $0x0,(%eax)
801050fa:	75 f4                	jne    801050f0 <argstr+0x50>
      return s - *pp;
801050fc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801050fe:	5b                   	pop    %ebx
801050ff:	5e                   	pop    %esi
80105100:	5d                   	pop    %ebp
80105101:	c3                   	ret    
80105102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105108:	5b                   	pop    %ebx
    return -1;
80105109:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010510e:	5e                   	pop    %esi
8010510f:	5d                   	pop    %ebp
80105110:	c3                   	ret    
80105111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010511f:	90                   	nop

80105120 <syscall>:
[SYS_getpinfo]  sys_getpinfo
};

void
syscall(void)
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	53                   	push   %ebx
80105124:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105127:	e8 84 e9 ff ff       	call   80103ab0 <myproc>
8010512c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010512e:	8b 40 18             	mov    0x18(%eax),%eax
80105131:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105134:	8d 50 ff             	lea    -0x1(%eax),%edx
80105137:	83 fa 18             	cmp    $0x18,%edx
8010513a:	77 24                	ja     80105160 <syscall+0x40>
8010513c:	8b 14 85 80 80 10 80 	mov    -0x7fef7f80(,%eax,4),%edx
80105143:	85 d2                	test   %edx,%edx
80105145:	74 19                	je     80105160 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105147:	ff d2                	call   *%edx
80105149:	89 c2                	mov    %eax,%edx
8010514b:	8b 43 18             	mov    0x18(%ebx),%eax
8010514e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105151:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105154:	c9                   	leave  
80105155:	c3                   	ret    
80105156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105160:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105161:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105164:	50                   	push   %eax
80105165:	ff 73 10             	push   0x10(%ebx)
80105168:	68 4b 80 10 80       	push   $0x8010804b
8010516d:	e8 2e b5 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80105172:	8b 43 18             	mov    0x18(%ebx),%eax
80105175:	83 c4 10             	add    $0x10,%esp
80105178:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010517f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105182:	c9                   	leave  
80105183:	c3                   	ret    
80105184:	66 90                	xchg   %ax,%ax
80105186:	66 90                	xchg   %ax,%ax
80105188:	66 90                	xchg   %ax,%ax
8010518a:	66 90                	xchg   %ax,%ax
8010518c:	66 90                	xchg   %ax,%ax
8010518e:	66 90                	xchg   %ax,%ax

80105190 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105195:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105198:	53                   	push   %ebx
80105199:	83 ec 34             	sub    $0x34,%esp
8010519c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010519f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801051a2:	57                   	push   %edi
801051a3:	50                   	push   %eax
{
801051a4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801051a7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801051aa:	e8 11 cf ff ff       	call   801020c0 <nameiparent>
801051af:	83 c4 10             	add    $0x10,%esp
801051b2:	85 c0                	test   %eax,%eax
801051b4:	0f 84 46 01 00 00    	je     80105300 <create+0x170>
    return 0;
  ilock(dp);
801051ba:	83 ec 0c             	sub    $0xc,%esp
801051bd:	89 c3                	mov    %eax,%ebx
801051bf:	50                   	push   %eax
801051c0:	e8 bb c5 ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801051c5:	83 c4 0c             	add    $0xc,%esp
801051c8:	6a 00                	push   $0x0
801051ca:	57                   	push   %edi
801051cb:	53                   	push   %ebx
801051cc:	e8 0f cb ff ff       	call   80101ce0 <dirlookup>
801051d1:	83 c4 10             	add    $0x10,%esp
801051d4:	89 c6                	mov    %eax,%esi
801051d6:	85 c0                	test   %eax,%eax
801051d8:	74 56                	je     80105230 <create+0xa0>
    iunlockput(dp);
801051da:	83 ec 0c             	sub    $0xc,%esp
801051dd:	53                   	push   %ebx
801051de:	e8 2d c8 ff ff       	call   80101a10 <iunlockput>
    ilock(ip);
801051e3:	89 34 24             	mov    %esi,(%esp)
801051e6:	e8 95 c5 ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051eb:	83 c4 10             	add    $0x10,%esp
801051ee:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801051f3:	75 1b                	jne    80105210 <create+0x80>
801051f5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801051fa:	75 14                	jne    80105210 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ff:	89 f0                	mov    %esi,%eax
80105201:	5b                   	pop    %ebx
80105202:	5e                   	pop    %esi
80105203:	5f                   	pop    %edi
80105204:	5d                   	pop    %ebp
80105205:	c3                   	ret    
80105206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010520d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105210:	83 ec 0c             	sub    $0xc,%esp
80105213:	56                   	push   %esi
    return 0;
80105214:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105216:	e8 f5 c7 ff ff       	call   80101a10 <iunlockput>
    return 0;
8010521b:	83 c4 10             	add    $0x10,%esp
}
8010521e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105221:	89 f0                	mov    %esi,%eax
80105223:	5b                   	pop    %ebx
80105224:	5e                   	pop    %esi
80105225:	5f                   	pop    %edi
80105226:	5d                   	pop    %ebp
80105227:	c3                   	ret    
80105228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105230:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105234:	83 ec 08             	sub    $0x8,%esp
80105237:	50                   	push   %eax
80105238:	ff 33                	push   (%ebx)
8010523a:	e8 d1 c3 ff ff       	call   80101610 <ialloc>
8010523f:	83 c4 10             	add    $0x10,%esp
80105242:	89 c6                	mov    %eax,%esi
80105244:	85 c0                	test   %eax,%eax
80105246:	0f 84 cd 00 00 00    	je     80105319 <create+0x189>
  ilock(ip);
8010524c:	83 ec 0c             	sub    $0xc,%esp
8010524f:	50                   	push   %eax
80105250:	e8 2b c5 ff ff       	call   80101780 <ilock>
  ip->major = major;
80105255:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105259:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010525d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105261:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105265:	b8 01 00 00 00       	mov    $0x1,%eax
8010526a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010526e:	89 34 24             	mov    %esi,(%esp)
80105271:	e8 5a c4 ff ff       	call   801016d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105276:	83 c4 10             	add    $0x10,%esp
80105279:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010527e:	74 30                	je     801052b0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105280:	83 ec 04             	sub    $0x4,%esp
80105283:	ff 76 04             	push   0x4(%esi)
80105286:	57                   	push   %edi
80105287:	53                   	push   %ebx
80105288:	e8 53 cd ff ff       	call   80101fe0 <dirlink>
8010528d:	83 c4 10             	add    $0x10,%esp
80105290:	85 c0                	test   %eax,%eax
80105292:	78 78                	js     8010530c <create+0x17c>
  iunlockput(dp);
80105294:	83 ec 0c             	sub    $0xc,%esp
80105297:	53                   	push   %ebx
80105298:	e8 73 c7 ff ff       	call   80101a10 <iunlockput>
  return ip;
8010529d:	83 c4 10             	add    $0x10,%esp
}
801052a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052a3:	89 f0                	mov    %esi,%eax
801052a5:	5b                   	pop    %ebx
801052a6:	5e                   	pop    %esi
801052a7:	5f                   	pop    %edi
801052a8:	5d                   	pop    %ebp
801052a9:	c3                   	ret    
801052aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801052b0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801052b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052b8:	53                   	push   %ebx
801052b9:	e8 12 c4 ff ff       	call   801016d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052be:	83 c4 0c             	add    $0xc,%esp
801052c1:	ff 76 04             	push   0x4(%esi)
801052c4:	68 04 81 10 80       	push   $0x80108104
801052c9:	56                   	push   %esi
801052ca:	e8 11 cd ff ff       	call   80101fe0 <dirlink>
801052cf:	83 c4 10             	add    $0x10,%esp
801052d2:	85 c0                	test   %eax,%eax
801052d4:	78 18                	js     801052ee <create+0x15e>
801052d6:	83 ec 04             	sub    $0x4,%esp
801052d9:	ff 73 04             	push   0x4(%ebx)
801052dc:	68 03 81 10 80       	push   $0x80108103
801052e1:	56                   	push   %esi
801052e2:	e8 f9 cc ff ff       	call   80101fe0 <dirlink>
801052e7:	83 c4 10             	add    $0x10,%esp
801052ea:	85 c0                	test   %eax,%eax
801052ec:	79 92                	jns    80105280 <create+0xf0>
      panic("create dots");
801052ee:	83 ec 0c             	sub    $0xc,%esp
801052f1:	68 f7 80 10 80       	push   $0x801080f7
801052f6:	e8 85 b0 ff ff       	call   80100380 <panic>
801052fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052ff:	90                   	nop
}
80105300:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105303:	31 f6                	xor    %esi,%esi
}
80105305:	5b                   	pop    %ebx
80105306:	89 f0                	mov    %esi,%eax
80105308:	5e                   	pop    %esi
80105309:	5f                   	pop    %edi
8010530a:	5d                   	pop    %ebp
8010530b:	c3                   	ret    
    panic("create: dirlink");
8010530c:	83 ec 0c             	sub    $0xc,%esp
8010530f:	68 06 81 10 80       	push   $0x80108106
80105314:	e8 67 b0 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105319:	83 ec 0c             	sub    $0xc,%esp
8010531c:	68 e8 80 10 80       	push   $0x801080e8
80105321:	e8 5a b0 ff ff       	call   80100380 <panic>
80105326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010532d:	8d 76 00             	lea    0x0(%esi),%esi

80105330 <sys_dup>:
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	56                   	push   %esi
80105334:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105335:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105338:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010533b:	50                   	push   %eax
8010533c:	6a 00                	push   $0x0
8010533e:	e8 9d fc ff ff       	call   80104fe0 <argint>
80105343:	83 c4 10             	add    $0x10,%esp
80105346:	85 c0                	test   %eax,%eax
80105348:	78 36                	js     80105380 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010534a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010534e:	77 30                	ja     80105380 <sys_dup+0x50>
80105350:	e8 5b e7 ff ff       	call   80103ab0 <myproc>
80105355:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105358:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010535c:	85 f6                	test   %esi,%esi
8010535e:	74 20                	je     80105380 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105360:	e8 4b e7 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105365:	31 db                	xor    %ebx,%ebx
80105367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105370:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105374:	85 d2                	test   %edx,%edx
80105376:	74 18                	je     80105390 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105378:	83 c3 01             	add    $0x1,%ebx
8010537b:	83 fb 10             	cmp    $0x10,%ebx
8010537e:	75 f0                	jne    80105370 <sys_dup+0x40>
}
80105380:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105383:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105388:	89 d8                	mov    %ebx,%eax
8010538a:	5b                   	pop    %ebx
8010538b:	5e                   	pop    %esi
8010538c:	5d                   	pop    %ebp
8010538d:	c3                   	ret    
8010538e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105390:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105393:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105397:	56                   	push   %esi
80105398:	e8 03 bb ff ff       	call   80100ea0 <filedup>
  return fd;
8010539d:	83 c4 10             	add    $0x10,%esp
}
801053a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053a3:	89 d8                	mov    %ebx,%eax
801053a5:	5b                   	pop    %ebx
801053a6:	5e                   	pop    %esi
801053a7:	5d                   	pop    %ebp
801053a8:	c3                   	ret    
801053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_read>:
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
801053b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801053b5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801053b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053bb:	53                   	push   %ebx
801053bc:	6a 00                	push   $0x0
801053be:	e8 1d fc ff ff       	call   80104fe0 <argint>
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 5e                	js     80105428 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053ce:	77 58                	ja     80105428 <sys_read+0x78>
801053d0:	e8 db e6 ff ff       	call   80103ab0 <myproc>
801053d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801053dc:	85 f6                	test   %esi,%esi
801053de:	74 48                	je     80105428 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053e0:	83 ec 08             	sub    $0x8,%esp
801053e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053e6:	50                   	push   %eax
801053e7:	6a 02                	push   $0x2
801053e9:	e8 f2 fb ff ff       	call   80104fe0 <argint>
801053ee:	83 c4 10             	add    $0x10,%esp
801053f1:	85 c0                	test   %eax,%eax
801053f3:	78 33                	js     80105428 <sys_read+0x78>
801053f5:	83 ec 04             	sub    $0x4,%esp
801053f8:	ff 75 f0             	push   -0x10(%ebp)
801053fb:	53                   	push   %ebx
801053fc:	6a 01                	push   $0x1
801053fe:	e8 2d fc ff ff       	call   80105030 <argptr>
80105403:	83 c4 10             	add    $0x10,%esp
80105406:	85 c0                	test   %eax,%eax
80105408:	78 1e                	js     80105428 <sys_read+0x78>
  return fileread(f, p, n);
8010540a:	83 ec 04             	sub    $0x4,%esp
8010540d:	ff 75 f0             	push   -0x10(%ebp)
80105410:	ff 75 f4             	push   -0xc(%ebp)
80105413:	56                   	push   %esi
80105414:	e8 07 bc ff ff       	call   80101020 <fileread>
80105419:	83 c4 10             	add    $0x10,%esp
}
8010541c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010541f:	5b                   	pop    %ebx
80105420:	5e                   	pop    %esi
80105421:	5d                   	pop    %ebp
80105422:	c3                   	ret    
80105423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105427:	90                   	nop
    return -1;
80105428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542d:	eb ed                	jmp    8010541c <sys_read+0x6c>
8010542f:	90                   	nop

80105430 <sys_write>:
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	56                   	push   %esi
80105434:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105435:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105438:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010543b:	53                   	push   %ebx
8010543c:	6a 00                	push   $0x0
8010543e:	e8 9d fb ff ff       	call   80104fe0 <argint>
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	78 5e                	js     801054a8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010544a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010544e:	77 58                	ja     801054a8 <sys_write+0x78>
80105450:	e8 5b e6 ff ff       	call   80103ab0 <myproc>
80105455:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105458:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010545c:	85 f6                	test   %esi,%esi
8010545e:	74 48                	je     801054a8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105460:	83 ec 08             	sub    $0x8,%esp
80105463:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105466:	50                   	push   %eax
80105467:	6a 02                	push   $0x2
80105469:	e8 72 fb ff ff       	call   80104fe0 <argint>
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	85 c0                	test   %eax,%eax
80105473:	78 33                	js     801054a8 <sys_write+0x78>
80105475:	83 ec 04             	sub    $0x4,%esp
80105478:	ff 75 f0             	push   -0x10(%ebp)
8010547b:	53                   	push   %ebx
8010547c:	6a 01                	push   $0x1
8010547e:	e8 ad fb ff ff       	call   80105030 <argptr>
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	78 1e                	js     801054a8 <sys_write+0x78>
  return filewrite(f, p, n);
8010548a:	83 ec 04             	sub    $0x4,%esp
8010548d:	ff 75 f0             	push   -0x10(%ebp)
80105490:	ff 75 f4             	push   -0xc(%ebp)
80105493:	56                   	push   %esi
80105494:	e8 17 bc ff ff       	call   801010b0 <filewrite>
80105499:	83 c4 10             	add    $0x10,%esp
}
8010549c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010549f:	5b                   	pop    %ebx
801054a0:	5e                   	pop    %esi
801054a1:	5d                   	pop    %ebp
801054a2:	c3                   	ret    
801054a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054a7:	90                   	nop
    return -1;
801054a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ad:	eb ed                	jmp    8010549c <sys_write+0x6c>
801054af:	90                   	nop

801054b0 <sys_close>:
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	56                   	push   %esi
801054b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801054b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801054b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801054bb:	50                   	push   %eax
801054bc:	6a 00                	push   $0x0
801054be:	e8 1d fb ff ff       	call   80104fe0 <argint>
801054c3:	83 c4 10             	add    $0x10,%esp
801054c6:	85 c0                	test   %eax,%eax
801054c8:	78 3e                	js     80105508 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801054ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054ce:	77 38                	ja     80105508 <sys_close+0x58>
801054d0:	e8 db e5 ff ff       	call   80103ab0 <myproc>
801054d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054d8:	8d 5a 08             	lea    0x8(%edx),%ebx
801054db:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801054df:	85 f6                	test   %esi,%esi
801054e1:	74 25                	je     80105508 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801054e3:	e8 c8 e5 ff ff       	call   80103ab0 <myproc>
  fileclose(f);
801054e8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801054eb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801054f2:	00 
  fileclose(f);
801054f3:	56                   	push   %esi
801054f4:	e8 f7 b9 ff ff       	call   80100ef0 <fileclose>
  return 0;
801054f9:	83 c4 10             	add    $0x10,%esp
801054fc:	31 c0                	xor    %eax,%eax
}
801054fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105501:	5b                   	pop    %ebx
80105502:	5e                   	pop    %esi
80105503:	5d                   	pop    %ebp
80105504:	c3                   	ret    
80105505:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105508:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550d:	eb ef                	jmp    801054fe <sys_close+0x4e>
8010550f:	90                   	nop

80105510 <sys_fstat>:
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	56                   	push   %esi
80105514:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105515:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105518:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010551b:	53                   	push   %ebx
8010551c:	6a 00                	push   $0x0
8010551e:	e8 bd fa ff ff       	call   80104fe0 <argint>
80105523:	83 c4 10             	add    $0x10,%esp
80105526:	85 c0                	test   %eax,%eax
80105528:	78 46                	js     80105570 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010552a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010552e:	77 40                	ja     80105570 <sys_fstat+0x60>
80105530:	e8 7b e5 ff ff       	call   80103ab0 <myproc>
80105535:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105538:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010553c:	85 f6                	test   %esi,%esi
8010553e:	74 30                	je     80105570 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105540:	83 ec 04             	sub    $0x4,%esp
80105543:	6a 14                	push   $0x14
80105545:	53                   	push   %ebx
80105546:	6a 01                	push   $0x1
80105548:	e8 e3 fa ff ff       	call   80105030 <argptr>
8010554d:	83 c4 10             	add    $0x10,%esp
80105550:	85 c0                	test   %eax,%eax
80105552:	78 1c                	js     80105570 <sys_fstat+0x60>
  return filestat(f, st);
80105554:	83 ec 08             	sub    $0x8,%esp
80105557:	ff 75 f4             	push   -0xc(%ebp)
8010555a:	56                   	push   %esi
8010555b:	e8 70 ba ff ff       	call   80100fd0 <filestat>
80105560:	83 c4 10             	add    $0x10,%esp
}
80105563:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105566:	5b                   	pop    %ebx
80105567:	5e                   	pop    %esi
80105568:	5d                   	pop    %ebp
80105569:	c3                   	ret    
8010556a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105575:	eb ec                	jmp    80105563 <sys_fstat+0x53>
80105577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010557e:	66 90                	xchg   %ax,%ax

80105580 <sys_link>:
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105585:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105588:	53                   	push   %ebx
80105589:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010558c:	50                   	push   %eax
8010558d:	6a 00                	push   $0x0
8010558f:	e8 0c fb ff ff       	call   801050a0 <argstr>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	85 c0                	test   %eax,%eax
80105599:	0f 88 fb 00 00 00    	js     8010569a <sys_link+0x11a>
8010559f:	83 ec 08             	sub    $0x8,%esp
801055a2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055a5:	50                   	push   %eax
801055a6:	6a 01                	push   $0x1
801055a8:	e8 f3 fa ff ff       	call   801050a0 <argstr>
801055ad:	83 c4 10             	add    $0x10,%esp
801055b0:	85 c0                	test   %eax,%eax
801055b2:	0f 88 e2 00 00 00    	js     8010569a <sys_link+0x11a>
  begin_op();
801055b8:	e8 a3 d7 ff ff       	call   80102d60 <begin_op>
  if((ip = namei(old)) == 0){
801055bd:	83 ec 0c             	sub    $0xc,%esp
801055c0:	ff 75 d4             	push   -0x2c(%ebp)
801055c3:	e8 d8 ca ff ff       	call   801020a0 <namei>
801055c8:	83 c4 10             	add    $0x10,%esp
801055cb:	89 c3                	mov    %eax,%ebx
801055cd:	85 c0                	test   %eax,%eax
801055cf:	0f 84 e4 00 00 00    	je     801056b9 <sys_link+0x139>
  ilock(ip);
801055d5:	83 ec 0c             	sub    $0xc,%esp
801055d8:	50                   	push   %eax
801055d9:	e8 a2 c1 ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
801055de:	83 c4 10             	add    $0x10,%esp
801055e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055e6:	0f 84 b5 00 00 00    	je     801056a1 <sys_link+0x121>
  iupdate(ip);
801055ec:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801055ef:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801055f4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055f7:	53                   	push   %ebx
801055f8:	e8 d3 c0 ff ff       	call   801016d0 <iupdate>
  iunlock(ip);
801055fd:	89 1c 24             	mov    %ebx,(%esp)
80105600:	e8 5b c2 ff ff       	call   80101860 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105605:	58                   	pop    %eax
80105606:	5a                   	pop    %edx
80105607:	57                   	push   %edi
80105608:	ff 75 d0             	push   -0x30(%ebp)
8010560b:	e8 b0 ca ff ff       	call   801020c0 <nameiparent>
80105610:	83 c4 10             	add    $0x10,%esp
80105613:	89 c6                	mov    %eax,%esi
80105615:	85 c0                	test   %eax,%eax
80105617:	74 5b                	je     80105674 <sys_link+0xf4>
  ilock(dp);
80105619:	83 ec 0c             	sub    $0xc,%esp
8010561c:	50                   	push   %eax
8010561d:	e8 5e c1 ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105622:	8b 03                	mov    (%ebx),%eax
80105624:	83 c4 10             	add    $0x10,%esp
80105627:	39 06                	cmp    %eax,(%esi)
80105629:	75 3d                	jne    80105668 <sys_link+0xe8>
8010562b:	83 ec 04             	sub    $0x4,%esp
8010562e:	ff 73 04             	push   0x4(%ebx)
80105631:	57                   	push   %edi
80105632:	56                   	push   %esi
80105633:	e8 a8 c9 ff ff       	call   80101fe0 <dirlink>
80105638:	83 c4 10             	add    $0x10,%esp
8010563b:	85 c0                	test   %eax,%eax
8010563d:	78 29                	js     80105668 <sys_link+0xe8>
  iunlockput(dp);
8010563f:	83 ec 0c             	sub    $0xc,%esp
80105642:	56                   	push   %esi
80105643:	e8 c8 c3 ff ff       	call   80101a10 <iunlockput>
  iput(ip);
80105648:	89 1c 24             	mov    %ebx,(%esp)
8010564b:	e8 60 c2 ff ff       	call   801018b0 <iput>
  end_op();
80105650:	e8 7b d7 ff ff       	call   80102dd0 <end_op>
  return 0;
80105655:	83 c4 10             	add    $0x10,%esp
80105658:	31 c0                	xor    %eax,%eax
}
8010565a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010565d:	5b                   	pop    %ebx
8010565e:	5e                   	pop    %esi
8010565f:	5f                   	pop    %edi
80105660:	5d                   	pop    %ebp
80105661:	c3                   	ret    
80105662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105668:	83 ec 0c             	sub    $0xc,%esp
8010566b:	56                   	push   %esi
8010566c:	e8 9f c3 ff ff       	call   80101a10 <iunlockput>
    goto bad;
80105671:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105674:	83 ec 0c             	sub    $0xc,%esp
80105677:	53                   	push   %ebx
80105678:	e8 03 c1 ff ff       	call   80101780 <ilock>
  ip->nlink--;
8010567d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105682:	89 1c 24             	mov    %ebx,(%esp)
80105685:	e8 46 c0 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
8010568a:	89 1c 24             	mov    %ebx,(%esp)
8010568d:	e8 7e c3 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105692:	e8 39 d7 ff ff       	call   80102dd0 <end_op>
  return -1;
80105697:	83 c4 10             	add    $0x10,%esp
8010569a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010569f:	eb b9                	jmp    8010565a <sys_link+0xda>
    iunlockput(ip);
801056a1:	83 ec 0c             	sub    $0xc,%esp
801056a4:	53                   	push   %ebx
801056a5:	e8 66 c3 ff ff       	call   80101a10 <iunlockput>
    end_op();
801056aa:	e8 21 d7 ff ff       	call   80102dd0 <end_op>
    return -1;
801056af:	83 c4 10             	add    $0x10,%esp
801056b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056b7:	eb a1                	jmp    8010565a <sys_link+0xda>
    end_op();
801056b9:	e8 12 d7 ff ff       	call   80102dd0 <end_op>
    return -1;
801056be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c3:	eb 95                	jmp    8010565a <sys_link+0xda>
801056c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056d0 <sys_unlink>:
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	57                   	push   %edi
801056d4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801056d5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056d8:	53                   	push   %ebx
801056d9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801056dc:	50                   	push   %eax
801056dd:	6a 00                	push   $0x0
801056df:	e8 bc f9 ff ff       	call   801050a0 <argstr>
801056e4:	83 c4 10             	add    $0x10,%esp
801056e7:	85 c0                	test   %eax,%eax
801056e9:	0f 88 7a 01 00 00    	js     80105869 <sys_unlink+0x199>
  begin_op();
801056ef:	e8 6c d6 ff ff       	call   80102d60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801056f4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801056f7:	83 ec 08             	sub    $0x8,%esp
801056fa:	53                   	push   %ebx
801056fb:	ff 75 c0             	push   -0x40(%ebp)
801056fe:	e8 bd c9 ff ff       	call   801020c0 <nameiparent>
80105703:	83 c4 10             	add    $0x10,%esp
80105706:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105709:	85 c0                	test   %eax,%eax
8010570b:	0f 84 62 01 00 00    	je     80105873 <sys_unlink+0x1a3>
  ilock(dp);
80105711:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105714:	83 ec 0c             	sub    $0xc,%esp
80105717:	57                   	push   %edi
80105718:	e8 63 c0 ff ff       	call   80101780 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010571d:	58                   	pop    %eax
8010571e:	5a                   	pop    %edx
8010571f:	68 04 81 10 80       	push   $0x80108104
80105724:	53                   	push   %ebx
80105725:	e8 96 c5 ff ff       	call   80101cc0 <namecmp>
8010572a:	83 c4 10             	add    $0x10,%esp
8010572d:	85 c0                	test   %eax,%eax
8010572f:	0f 84 fb 00 00 00    	je     80105830 <sys_unlink+0x160>
80105735:	83 ec 08             	sub    $0x8,%esp
80105738:	68 03 81 10 80       	push   $0x80108103
8010573d:	53                   	push   %ebx
8010573e:	e8 7d c5 ff ff       	call   80101cc0 <namecmp>
80105743:	83 c4 10             	add    $0x10,%esp
80105746:	85 c0                	test   %eax,%eax
80105748:	0f 84 e2 00 00 00    	je     80105830 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010574e:	83 ec 04             	sub    $0x4,%esp
80105751:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105754:	50                   	push   %eax
80105755:	53                   	push   %ebx
80105756:	57                   	push   %edi
80105757:	e8 84 c5 ff ff       	call   80101ce0 <dirlookup>
8010575c:	83 c4 10             	add    $0x10,%esp
8010575f:	89 c3                	mov    %eax,%ebx
80105761:	85 c0                	test   %eax,%eax
80105763:	0f 84 c7 00 00 00    	je     80105830 <sys_unlink+0x160>
  ilock(ip);
80105769:	83 ec 0c             	sub    $0xc,%esp
8010576c:	50                   	push   %eax
8010576d:	e8 0e c0 ff ff       	call   80101780 <ilock>
  if(ip->nlink < 1)
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010577a:	0f 8e 1c 01 00 00    	jle    8010589c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105780:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105785:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105788:	74 66                	je     801057f0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010578a:	83 ec 04             	sub    $0x4,%esp
8010578d:	6a 10                	push   $0x10
8010578f:	6a 00                	push   $0x0
80105791:	57                   	push   %edi
80105792:	e8 89 f5 ff ff       	call   80104d20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105797:	6a 10                	push   $0x10
80105799:	ff 75 c4             	push   -0x3c(%ebp)
8010579c:	57                   	push   %edi
8010579d:	ff 75 b4             	push   -0x4c(%ebp)
801057a0:	e8 eb c3 ff ff       	call   80101b90 <writei>
801057a5:	83 c4 20             	add    $0x20,%esp
801057a8:	83 f8 10             	cmp    $0x10,%eax
801057ab:	0f 85 de 00 00 00    	jne    8010588f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
801057b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057b6:	0f 84 94 00 00 00    	je     80105850 <sys_unlink+0x180>
  iunlockput(dp);
801057bc:	83 ec 0c             	sub    $0xc,%esp
801057bf:	ff 75 b4             	push   -0x4c(%ebp)
801057c2:	e8 49 c2 ff ff       	call   80101a10 <iunlockput>
  ip->nlink--;
801057c7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057cc:	89 1c 24             	mov    %ebx,(%esp)
801057cf:	e8 fc be ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
801057d4:	89 1c 24             	mov    %ebx,(%esp)
801057d7:	e8 34 c2 ff ff       	call   80101a10 <iunlockput>
  end_op();
801057dc:	e8 ef d5 ff ff       	call   80102dd0 <end_op>
  return 0;
801057e1:	83 c4 10             	add    $0x10,%esp
801057e4:	31 c0                	xor    %eax,%eax
}
801057e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057e9:	5b                   	pop    %ebx
801057ea:	5e                   	pop    %esi
801057eb:	5f                   	pop    %edi
801057ec:	5d                   	pop    %ebp
801057ed:	c3                   	ret    
801057ee:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801057f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801057f4:	76 94                	jbe    8010578a <sys_unlink+0xba>
801057f6:	be 20 00 00 00       	mov    $0x20,%esi
801057fb:	eb 0b                	jmp    80105808 <sys_unlink+0x138>
801057fd:	8d 76 00             	lea    0x0(%esi),%esi
80105800:	83 c6 10             	add    $0x10,%esi
80105803:	3b 73 58             	cmp    0x58(%ebx),%esi
80105806:	73 82                	jae    8010578a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105808:	6a 10                	push   $0x10
8010580a:	56                   	push   %esi
8010580b:	57                   	push   %edi
8010580c:	53                   	push   %ebx
8010580d:	e8 7e c2 ff ff       	call   80101a90 <readi>
80105812:	83 c4 10             	add    $0x10,%esp
80105815:	83 f8 10             	cmp    $0x10,%eax
80105818:	75 68                	jne    80105882 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010581a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010581f:	74 df                	je     80105800 <sys_unlink+0x130>
    iunlockput(ip);
80105821:	83 ec 0c             	sub    $0xc,%esp
80105824:	53                   	push   %ebx
80105825:	e8 e6 c1 ff ff       	call   80101a10 <iunlockput>
    goto bad;
8010582a:	83 c4 10             	add    $0x10,%esp
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	ff 75 b4             	push   -0x4c(%ebp)
80105836:	e8 d5 c1 ff ff       	call   80101a10 <iunlockput>
  end_op();
8010583b:	e8 90 d5 ff ff       	call   80102dd0 <end_op>
  return -1;
80105840:	83 c4 10             	add    $0x10,%esp
80105843:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105848:	eb 9c                	jmp    801057e6 <sys_unlink+0x116>
8010584a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105850:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105853:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105856:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010585b:	50                   	push   %eax
8010585c:	e8 6f be ff ff       	call   801016d0 <iupdate>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	e9 53 ff ff ff       	jmp    801057bc <sys_unlink+0xec>
    return -1;
80105869:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586e:	e9 73 ff ff ff       	jmp    801057e6 <sys_unlink+0x116>
    end_op();
80105873:	e8 58 d5 ff ff       	call   80102dd0 <end_op>
    return -1;
80105878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010587d:	e9 64 ff ff ff       	jmp    801057e6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105882:	83 ec 0c             	sub    $0xc,%esp
80105885:	68 28 81 10 80       	push   $0x80108128
8010588a:	e8 f1 aa ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010588f:	83 ec 0c             	sub    $0xc,%esp
80105892:	68 3a 81 10 80       	push   $0x8010813a
80105897:	e8 e4 aa ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010589c:	83 ec 0c             	sub    $0xc,%esp
8010589f:	68 16 81 10 80       	push   $0x80108116
801058a4:	e8 d7 aa ff ff       	call   80100380 <panic>
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058b0 <sys_open>:

int
sys_open(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	57                   	push   %edi
801058b4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058b5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801058b8:	53                   	push   %ebx
801058b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058bc:	50                   	push   %eax
801058bd:	6a 00                	push   $0x0
801058bf:	e8 dc f7 ff ff       	call   801050a0 <argstr>
801058c4:	83 c4 10             	add    $0x10,%esp
801058c7:	85 c0                	test   %eax,%eax
801058c9:	0f 88 8e 00 00 00    	js     8010595d <sys_open+0xad>
801058cf:	83 ec 08             	sub    $0x8,%esp
801058d2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058d5:	50                   	push   %eax
801058d6:	6a 01                	push   $0x1
801058d8:	e8 03 f7 ff ff       	call   80104fe0 <argint>
801058dd:	83 c4 10             	add    $0x10,%esp
801058e0:	85 c0                	test   %eax,%eax
801058e2:	78 79                	js     8010595d <sys_open+0xad>
    return -1;

  begin_op();
801058e4:	e8 77 d4 ff ff       	call   80102d60 <begin_op>

  if(omode & O_CREATE){
801058e9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801058ed:	75 79                	jne    80105968 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801058ef:	83 ec 0c             	sub    $0xc,%esp
801058f2:	ff 75 e0             	push   -0x20(%ebp)
801058f5:	e8 a6 c7 ff ff       	call   801020a0 <namei>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	89 c6                	mov    %eax,%esi
801058ff:	85 c0                	test   %eax,%eax
80105901:	0f 84 7e 00 00 00    	je     80105985 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105907:	83 ec 0c             	sub    $0xc,%esp
8010590a:	50                   	push   %eax
8010590b:	e8 70 be ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105910:	83 c4 10             	add    $0x10,%esp
80105913:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105918:	0f 84 c2 00 00 00    	je     801059e0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010591e:	e8 0d b5 ff ff       	call   80100e30 <filealloc>
80105923:	89 c7                	mov    %eax,%edi
80105925:	85 c0                	test   %eax,%eax
80105927:	74 23                	je     8010594c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105929:	e8 82 e1 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010592e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105930:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105934:	85 d2                	test   %edx,%edx
80105936:	74 60                	je     80105998 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105938:	83 c3 01             	add    $0x1,%ebx
8010593b:	83 fb 10             	cmp    $0x10,%ebx
8010593e:	75 f0                	jne    80105930 <sys_open+0x80>
    if(f)
      fileclose(f);
80105940:	83 ec 0c             	sub    $0xc,%esp
80105943:	57                   	push   %edi
80105944:	e8 a7 b5 ff ff       	call   80100ef0 <fileclose>
80105949:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010594c:	83 ec 0c             	sub    $0xc,%esp
8010594f:	56                   	push   %esi
80105950:	e8 bb c0 ff ff       	call   80101a10 <iunlockput>
    end_op();
80105955:	e8 76 d4 ff ff       	call   80102dd0 <end_op>
    return -1;
8010595a:	83 c4 10             	add    $0x10,%esp
8010595d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105962:	eb 6d                	jmp    801059d1 <sys_open+0x121>
80105964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010596e:	31 c9                	xor    %ecx,%ecx
80105970:	ba 02 00 00 00       	mov    $0x2,%edx
80105975:	6a 00                	push   $0x0
80105977:	e8 14 f8 ff ff       	call   80105190 <create>
    if(ip == 0){
8010597c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010597f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105981:	85 c0                	test   %eax,%eax
80105983:	75 99                	jne    8010591e <sys_open+0x6e>
      end_op();
80105985:	e8 46 d4 ff ff       	call   80102dd0 <end_op>
      return -1;
8010598a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010598f:	eb 40                	jmp    801059d1 <sys_open+0x121>
80105991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105998:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010599b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010599f:	56                   	push   %esi
801059a0:	e8 bb be ff ff       	call   80101860 <iunlock>
  end_op();
801059a5:	e8 26 d4 ff ff       	call   80102dd0 <end_op>

  f->type = FD_INODE;
801059aa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059b3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059b6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801059b9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801059bb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059c2:	f7 d0                	not    %eax
801059c4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059c7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059ca:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059cd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059d4:	89 d8                	mov    %ebx,%eax
801059d6:	5b                   	pop    %ebx
801059d7:	5e                   	pop    %esi
801059d8:	5f                   	pop    %edi
801059d9:	5d                   	pop    %ebp
801059da:	c3                   	ret    
801059db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059df:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801059e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801059e3:	85 c9                	test   %ecx,%ecx
801059e5:	0f 84 33 ff ff ff    	je     8010591e <sys_open+0x6e>
801059eb:	e9 5c ff ff ff       	jmp    8010594c <sys_open+0x9c>

801059f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801059f6:	e8 65 d3 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801059fb:	83 ec 08             	sub    $0x8,%esp
801059fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a01:	50                   	push   %eax
80105a02:	6a 00                	push   $0x0
80105a04:	e8 97 f6 ff ff       	call   801050a0 <argstr>
80105a09:	83 c4 10             	add    $0x10,%esp
80105a0c:	85 c0                	test   %eax,%eax
80105a0e:	78 30                	js     80105a40 <sys_mkdir+0x50>
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a16:	31 c9                	xor    %ecx,%ecx
80105a18:	ba 01 00 00 00       	mov    $0x1,%edx
80105a1d:	6a 00                	push   $0x0
80105a1f:	e8 6c f7 ff ff       	call   80105190 <create>
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	85 c0                	test   %eax,%eax
80105a29:	74 15                	je     80105a40 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a2b:	83 ec 0c             	sub    $0xc,%esp
80105a2e:	50                   	push   %eax
80105a2f:	e8 dc bf ff ff       	call   80101a10 <iunlockput>
  end_op();
80105a34:	e8 97 d3 ff ff       	call   80102dd0 <end_op>
  return 0;
80105a39:	83 c4 10             	add    $0x10,%esp
80105a3c:	31 c0                	xor    %eax,%eax
}
80105a3e:	c9                   	leave  
80105a3f:	c3                   	ret    
    end_op();
80105a40:	e8 8b d3 ff ff       	call   80102dd0 <end_op>
    return -1;
80105a45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a4a:	c9                   	leave  
80105a4b:	c3                   	ret    
80105a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a50 <sys_mknod>:

int
sys_mknod(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a56:	e8 05 d3 ff ff       	call   80102d60 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105a5b:	83 ec 08             	sub    $0x8,%esp
80105a5e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a61:	50                   	push   %eax
80105a62:	6a 00                	push   $0x0
80105a64:	e8 37 f6 ff ff       	call   801050a0 <argstr>
80105a69:	83 c4 10             	add    $0x10,%esp
80105a6c:	85 c0                	test   %eax,%eax
80105a6e:	78 60                	js     80105ad0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105a70:	83 ec 08             	sub    $0x8,%esp
80105a73:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a76:	50                   	push   %eax
80105a77:	6a 01                	push   $0x1
80105a79:	e8 62 f5 ff ff       	call   80104fe0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	85 c0                	test   %eax,%eax
80105a83:	78 4b                	js     80105ad0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105a85:	83 ec 08             	sub    $0x8,%esp
80105a88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a8b:	50                   	push   %eax
80105a8c:	6a 02                	push   $0x2
80105a8e:	e8 4d f5 ff ff       	call   80104fe0 <argint>
     argint(1, &major) < 0 ||
80105a93:	83 c4 10             	add    $0x10,%esp
80105a96:	85 c0                	test   %eax,%eax
80105a98:	78 36                	js     80105ad0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a9a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a9e:	83 ec 0c             	sub    $0xc,%esp
80105aa1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105aa5:	ba 03 00 00 00       	mov    $0x3,%edx
80105aaa:	50                   	push   %eax
80105aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105aae:	e8 dd f6 ff ff       	call   80105190 <create>
     argint(2, &minor) < 0 ||
80105ab3:	83 c4 10             	add    $0x10,%esp
80105ab6:	85 c0                	test   %eax,%eax
80105ab8:	74 16                	je     80105ad0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105aba:	83 ec 0c             	sub    $0xc,%esp
80105abd:	50                   	push   %eax
80105abe:	e8 4d bf ff ff       	call   80101a10 <iunlockput>
  end_op();
80105ac3:	e8 08 d3 ff ff       	call   80102dd0 <end_op>
  return 0;
80105ac8:	83 c4 10             	add    $0x10,%esp
80105acb:	31 c0                	xor    %eax,%eax
}
80105acd:	c9                   	leave  
80105ace:	c3                   	ret    
80105acf:	90                   	nop
    end_op();
80105ad0:	e8 fb d2 ff ff       	call   80102dd0 <end_op>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ada:	c9                   	leave  
80105adb:	c3                   	ret    
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_chdir>:

int
sys_chdir(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	56                   	push   %esi
80105ae4:	53                   	push   %ebx
80105ae5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105ae8:	e8 c3 df ff ff       	call   80103ab0 <myproc>
80105aed:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105aef:	e8 6c d2 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105af4:	83 ec 08             	sub    $0x8,%esp
80105af7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105afa:	50                   	push   %eax
80105afb:	6a 00                	push   $0x0
80105afd:	e8 9e f5 ff ff       	call   801050a0 <argstr>
80105b02:	83 c4 10             	add    $0x10,%esp
80105b05:	85 c0                	test   %eax,%eax
80105b07:	78 77                	js     80105b80 <sys_chdir+0xa0>
80105b09:	83 ec 0c             	sub    $0xc,%esp
80105b0c:	ff 75 f4             	push   -0xc(%ebp)
80105b0f:	e8 8c c5 ff ff       	call   801020a0 <namei>
80105b14:	83 c4 10             	add    $0x10,%esp
80105b17:	89 c3                	mov    %eax,%ebx
80105b19:	85 c0                	test   %eax,%eax
80105b1b:	74 63                	je     80105b80 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b1d:	83 ec 0c             	sub    $0xc,%esp
80105b20:	50                   	push   %eax
80105b21:	e8 5a bc ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
80105b26:	83 c4 10             	add    $0x10,%esp
80105b29:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b2e:	75 30                	jne    80105b60 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b30:	83 ec 0c             	sub    $0xc,%esp
80105b33:	53                   	push   %ebx
80105b34:	e8 27 bd ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
80105b39:	58                   	pop    %eax
80105b3a:	ff 76 68             	push   0x68(%esi)
80105b3d:	e8 6e bd ff ff       	call   801018b0 <iput>
  end_op();
80105b42:	e8 89 d2 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = ip;
80105b47:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105b4a:	83 c4 10             	add    $0x10,%esp
80105b4d:	31 c0                	xor    %eax,%eax
}
80105b4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b52:	5b                   	pop    %ebx
80105b53:	5e                   	pop    %esi
80105b54:	5d                   	pop    %ebp
80105b55:	c3                   	ret    
80105b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b5d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b60:	83 ec 0c             	sub    $0xc,%esp
80105b63:	53                   	push   %ebx
80105b64:	e8 a7 be ff ff       	call   80101a10 <iunlockput>
    end_op();
80105b69:	e8 62 d2 ff ff       	call   80102dd0 <end_op>
    return -1;
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b76:	eb d7                	jmp    80105b4f <sys_chdir+0x6f>
80105b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b7f:	90                   	nop
    end_op();
80105b80:	e8 4b d2 ff ff       	call   80102dd0 <end_op>
    return -1;
80105b85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b8a:	eb c3                	jmp    80105b4f <sys_chdir+0x6f>
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b90 <sys_exec>:

int
sys_exec(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b95:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b9b:	53                   	push   %ebx
80105b9c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105ba2:	50                   	push   %eax
80105ba3:	6a 00                	push   $0x0
80105ba5:	e8 f6 f4 ff ff       	call   801050a0 <argstr>
80105baa:	83 c4 10             	add    $0x10,%esp
80105bad:	85 c0                	test   %eax,%eax
80105baf:	0f 88 87 00 00 00    	js     80105c3c <sys_exec+0xac>
80105bb5:	83 ec 08             	sub    $0x8,%esp
80105bb8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105bbe:	50                   	push   %eax
80105bbf:	6a 01                	push   $0x1
80105bc1:	e8 1a f4 ff ff       	call   80104fe0 <argint>
80105bc6:	83 c4 10             	add    $0x10,%esp
80105bc9:	85 c0                	test   %eax,%eax
80105bcb:	78 6f                	js     80105c3c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105bcd:	83 ec 04             	sub    $0x4,%esp
80105bd0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105bd6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105bd8:	68 80 00 00 00       	push   $0x80
80105bdd:	6a 00                	push   $0x0
80105bdf:	56                   	push   %esi
80105be0:	e8 3b f1 ff ff       	call   80104d20 <memset>
80105be5:	83 c4 10             	add    $0x10,%esp
80105be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bef:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105bf0:	83 ec 08             	sub    $0x8,%esp
80105bf3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105bf9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105c00:	50                   	push   %eax
80105c01:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c07:	01 f8                	add    %edi,%eax
80105c09:	50                   	push   %eax
80105c0a:	e8 41 f3 ff ff       	call   80104f50 <fetchint>
80105c0f:	83 c4 10             	add    $0x10,%esp
80105c12:	85 c0                	test   %eax,%eax
80105c14:	78 26                	js     80105c3c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105c16:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c1c:	85 c0                	test   %eax,%eax
80105c1e:	74 30                	je     80105c50 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c20:	83 ec 08             	sub    $0x8,%esp
80105c23:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105c26:	52                   	push   %edx
80105c27:	50                   	push   %eax
80105c28:	e8 63 f3 ff ff       	call   80104f90 <fetchstr>
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	85 c0                	test   %eax,%eax
80105c32:	78 08                	js     80105c3c <sys_exec+0xac>
  for(i=0;; i++){
80105c34:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105c37:	83 fb 20             	cmp    $0x20,%ebx
80105c3a:	75 b4                	jne    80105bf0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105c3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c44:	5b                   	pop    %ebx
80105c45:	5e                   	pop    %esi
80105c46:	5f                   	pop    %edi
80105c47:	5d                   	pop    %ebp
80105c48:	c3                   	ret    
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105c50:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c57:	00 00 00 00 
  return exec(path, argv);
80105c5b:	83 ec 08             	sub    $0x8,%esp
80105c5e:	56                   	push   %esi
80105c5f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105c65:	e8 46 ae ff ff       	call   80100ab0 <exec>
80105c6a:	83 c4 10             	add    $0x10,%esp
}
80105c6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c70:	5b                   	pop    %ebx
80105c71:	5e                   	pop    %esi
80105c72:	5f                   	pop    %edi
80105c73:	5d                   	pop    %ebp
80105c74:	c3                   	ret    
80105c75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <sys_pipe>:

int
sys_pipe(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	57                   	push   %edi
80105c84:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c85:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c88:	53                   	push   %ebx
80105c89:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c8c:	6a 08                	push   $0x8
80105c8e:	50                   	push   %eax
80105c8f:	6a 00                	push   $0x0
80105c91:	e8 9a f3 ff ff       	call   80105030 <argptr>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	78 4a                	js     80105ce7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c9d:	83 ec 08             	sub    $0x8,%esp
80105ca0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ca3:	50                   	push   %eax
80105ca4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ca7:	50                   	push   %eax
80105ca8:	e8 93 d7 ff ff       	call   80103440 <pipealloc>
80105cad:	83 c4 10             	add    $0x10,%esp
80105cb0:	85 c0                	test   %eax,%eax
80105cb2:	78 33                	js     80105ce7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cb4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105cb7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105cb9:	e8 f2 dd ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cbe:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105cc0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105cc4:	85 f6                	test   %esi,%esi
80105cc6:	74 28                	je     80105cf0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105cc8:	83 c3 01             	add    $0x1,%ebx
80105ccb:	83 fb 10             	cmp    $0x10,%ebx
80105cce:	75 f0                	jne    80105cc0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
80105cd3:	ff 75 e0             	push   -0x20(%ebp)
80105cd6:	e8 15 b2 ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
80105cdb:	58                   	pop    %eax
80105cdc:	ff 75 e4             	push   -0x1c(%ebp)
80105cdf:	e8 0c b2 ff ff       	call   80100ef0 <fileclose>
    return -1;
80105ce4:	83 c4 10             	add    $0x10,%esp
80105ce7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cec:	eb 53                	jmp    80105d41 <sys_pipe+0xc1>
80105cee:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105cf0:	8d 73 08             	lea    0x8(%ebx),%esi
80105cf3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cf7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105cfa:	e8 b1 dd ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cff:	31 d2                	xor    %edx,%edx
80105d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105d08:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105d0c:	85 c9                	test   %ecx,%ecx
80105d0e:	74 20                	je     80105d30 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105d10:	83 c2 01             	add    $0x1,%edx
80105d13:	83 fa 10             	cmp    $0x10,%edx
80105d16:	75 f0                	jne    80105d08 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105d18:	e8 93 dd ff ff       	call   80103ab0 <myproc>
80105d1d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105d24:	00 
80105d25:	eb a9                	jmp    80105cd0 <sys_pipe+0x50>
80105d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105d30:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105d34:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d37:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105d39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d3c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d3f:	31 c0                	xor    %eax,%eax
}
80105d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d44:	5b                   	pop    %ebx
80105d45:	5e                   	pop    %esi
80105d46:	5f                   	pop    %edi
80105d47:	5d                   	pop    %ebp
80105d48:	c3                   	ret    
80105d49:	66 90                	xchg   %ax,%ax
80105d4b:	66 90                	xchg   %ax,%ax
80105d4d:	66 90                	xchg   %ax,%ax
80105d4f:	90                   	nop

80105d50 <sys_fork>:
#include "pstat.h"

int
sys_fork(void)
{
  return fork();
80105d50:	e9 fb ea ff ff       	jmp    80104850 <fork>
80105d55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d60 <sys_exit>:
}

int
sys_exit(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d66:	e8 b5 de ff ff       	call   80103c20 <exit>
  return 0;  // not reached
}
80105d6b:	31 c0                	xor    %eax,%eax
80105d6d:	c9                   	leave  
80105d6e:	c3                   	ret    
80105d6f:	90                   	nop

80105d70 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105d70:	e9 bb df ff ff       	jmp    80103d30 <wait>
80105d75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d80 <sys_kill>:
}

int
sys_kill(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d89:	50                   	push   %eax
80105d8a:	6a 00                	push   $0x0
80105d8c:	e8 4f f2 ff ff       	call   80104fe0 <argint>
80105d91:	83 c4 10             	add    $0x10,%esp
80105d94:	85 c0                	test   %eax,%eax
80105d96:	78 18                	js     80105db0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d98:	83 ec 0c             	sub    $0xc,%esp
80105d9b:	ff 75 f4             	push   -0xc(%ebp)
80105d9e:	e8 6d e8 ff ff       	call   80104610 <kill>
80105da3:	83 c4 10             	add    $0x10,%esp
}
80105da6:	c9                   	leave  
80105da7:	c3                   	ret    
80105da8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105daf:	90                   	nop
80105db0:	c9                   	leave  
    return -1;
80105db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105db6:	c3                   	ret    
80105db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dbe:	66 90                	xchg   %ax,%ax

80105dc0 <sys_getpid>:

int
sys_getpid(void)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105dc6:	e8 e5 dc ff ff       	call   80103ab0 <myproc>
80105dcb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105dce:	c9                   	leave  
80105dcf:	c3                   	ret    

80105dd0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105dd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105dd7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105dda:	50                   	push   %eax
80105ddb:	6a 00                	push   $0x0
80105ddd:	e8 fe f1 ff ff       	call   80104fe0 <argint>
80105de2:	83 c4 10             	add    $0x10,%esp
80105de5:	85 c0                	test   %eax,%eax
80105de7:	78 27                	js     80105e10 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105de9:	e8 c2 dc ff ff       	call   80103ab0 <myproc>
  if(growproc(n) < 0)
80105dee:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105df1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105df3:	ff 75 f4             	push   -0xc(%ebp)
80105df6:	e8 e5 dc ff ff       	call   80103ae0 <growproc>
80105dfb:	83 c4 10             	add    $0x10,%esp
80105dfe:	85 c0                	test   %eax,%eax
80105e00:	78 0e                	js     80105e10 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e02:	89 d8                	mov    %ebx,%eax
80105e04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e07:	c9                   	leave  
80105e08:	c3                   	ret    
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e10:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e15:	eb eb                	jmp    80105e02 <sys_sbrk+0x32>
80105e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e1e:	66 90                	xchg   %ax,%ax

80105e20 <sys_sleep>:

int
sys_sleep(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e2a:	50                   	push   %eax
80105e2b:	6a 00                	push   $0x0
80105e2d:	e8 ae f1 ff ff       	call   80104fe0 <argint>
80105e32:	83 c4 10             	add    $0x10,%esp
80105e35:	85 c0                	test   %eax,%eax
80105e37:	0f 88 8a 00 00 00    	js     80105ec7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e3d:	83 ec 0c             	sub    $0xc,%esp
80105e40:	68 a0 58 11 80       	push   $0x801158a0
80105e45:	e8 06 ee ff ff       	call   80104c50 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105e4d:	8b 1d 80 58 11 80    	mov    0x80115880,%ebx
  while(ticks - ticks0 < n){
80105e53:	83 c4 10             	add    $0x10,%esp
80105e56:	85 d2                	test   %edx,%edx
80105e58:	75 27                	jne    80105e81 <sys_sleep+0x61>
80105e5a:	eb 54                	jmp    80105eb0 <sys_sleep+0x90>
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e60:	83 ec 08             	sub    $0x8,%esp
80105e63:	68 a0 58 11 80       	push   $0x801158a0
80105e68:	68 80 58 11 80       	push   $0x80115880
80105e6d:	e8 fe df ff ff       	call   80103e70 <sleep>
  while(ticks - ticks0 < n){
80105e72:	a1 80 58 11 80       	mov    0x80115880,%eax
80105e77:	83 c4 10             	add    $0x10,%esp
80105e7a:	29 d8                	sub    %ebx,%eax
80105e7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105e7f:	73 2f                	jae    80105eb0 <sys_sleep+0x90>
    if(myproc()->killed){
80105e81:	e8 2a dc ff ff       	call   80103ab0 <myproc>
80105e86:	8b 40 24             	mov    0x24(%eax),%eax
80105e89:	85 c0                	test   %eax,%eax
80105e8b:	74 d3                	je     80105e60 <sys_sleep+0x40>
      release(&tickslock);
80105e8d:	83 ec 0c             	sub    $0xc,%esp
80105e90:	68 a0 58 11 80       	push   $0x801158a0
80105e95:	e8 56 ed ff ff       	call   80104bf0 <release>
  }
  release(&tickslock);
  return 0;
}
80105e9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105e9d:	83 c4 10             	add    $0x10,%esp
80105ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ea5:	c9                   	leave  
80105ea6:	c3                   	ret    
80105ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eae:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	68 a0 58 11 80       	push   $0x801158a0
80105eb8:	e8 33 ed ff ff       	call   80104bf0 <release>
  return 0;
80105ebd:	83 c4 10             	add    $0x10,%esp
80105ec0:	31 c0                	xor    %eax,%eax
}
80105ec2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ec5:	c9                   	leave  
80105ec6:	c3                   	ret    
    return -1;
80105ec7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ecc:	eb f4                	jmp    80105ec2 <sys_sleep+0xa2>
80105ece:	66 90                	xchg   %ax,%ax

80105ed0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	53                   	push   %ebx
80105ed4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ed7:	68 a0 58 11 80       	push   $0x801158a0
80105edc:	e8 6f ed ff ff       	call   80104c50 <acquire>
  xticks = ticks;
80105ee1:	8b 1d 80 58 11 80    	mov    0x80115880,%ebx
  release(&tickslock);
80105ee7:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
80105eee:	e8 fd ec ff ff       	call   80104bf0 <release>
  return xticks;
}
80105ef3:	89 d8                	mov    %ebx,%eax
80105ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef8:	c9                   	leave  
80105ef9:	c3                   	ret    
80105efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f00 <sys_setslice>:

// p2b syscalls </3

int
sys_setslice(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int slice;

  if((argint(0, &pid) < 0) || (argint(1, &slice) < 0)) {
80105f06:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f09:	50                   	push   %eax
80105f0a:	6a 00                	push   $0x0
80105f0c:	e8 cf f0 ff ff       	call   80104fe0 <argint>
80105f11:	83 c4 10             	add    $0x10,%esp
80105f14:	85 c0                	test   %eax,%eax
80105f16:	78 28                	js     80105f40 <sys_setslice+0x40>
80105f18:	83 ec 08             	sub    $0x8,%esp
80105f1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f1e:	50                   	push   %eax
80105f1f:	6a 01                	push   $0x1
80105f21:	e8 ba f0 ff ff       	call   80104fe0 <argint>
80105f26:	83 c4 10             	add    $0x10,%esp
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	78 13                	js     80105f40 <sys_setslice+0x40>
    return -1;
  }
  return setslice(pid, slice);
80105f2d:	83 ec 08             	sub    $0x8,%esp
80105f30:	ff 75 f4             	push   -0xc(%ebp)
80105f33:	ff 75 f0             	push   -0x10(%ebp)
80105f36:	e8 05 e3 ff ff       	call   80104240 <setslice>
80105f3b:	83 c4 10             	add    $0x10,%esp
}
80105f3e:	c9                   	leave  
80105f3f:	c3                   	ret    
80105f40:	c9                   	leave  
    return -1;
80105f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f46:	c3                   	ret    
80105f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4e:	66 90                	xchg   %ax,%ax

80105f50 <sys_getslice>:

int
sys_getslice(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0) {
80105f56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f59:	50                   	push   %eax
80105f5a:	6a 00                	push   $0x0
80105f5c:	e8 7f f0 ff ff       	call   80104fe0 <argint>
80105f61:	83 c4 10             	add    $0x10,%esp
80105f64:	85 c0                	test   %eax,%eax
80105f66:	78 18                	js     80105f80 <sys_getslice+0x30>
    return -1;
  }
  return getslice(pid);
80105f68:	83 ec 0c             	sub    $0xc,%esp
80105f6b:	ff 75 f4             	push   -0xc(%ebp)
80105f6e:	e8 3d e3 ff ff       	call   801042b0 <getslice>
80105f73:	83 c4 10             	add    $0x10,%esp
}
80105f76:	c9                   	leave  
80105f77:	c3                   	ret    
80105f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7f:	90                   	nop
80105f80:	c9                   	leave  
    return -1;
80105f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f86:	c3                   	ret    
80105f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f8e:	66 90                	xchg   %ax,%ax

80105f90 <sys_fork2>:


int
sys_fork2(void)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	83 ec 20             	sub    $0x20,%esp
  int slice;

  if(argint(0, &slice) < 0) {
80105f96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f99:	50                   	push   %eax
80105f9a:	6a 00                	push   $0x0
80105f9c:	e8 3f f0 ff ff       	call   80104fe0 <argint>
80105fa1:	83 c4 10             	add    $0x10,%esp
80105fa4:	85 c0                	test   %eax,%eax
80105fa6:	78 18                	js     80105fc0 <sys_fork2+0x30>
    return -1;
  }
  return fork2(slice);
80105fa8:	83 ec 0c             	sub    $0xc,%esp
80105fab:	ff 75 f4             	push   -0xc(%ebp)
80105fae:	e8 fd e6 ff ff       	call   801046b0 <fork2>
80105fb3:	83 c4 10             	add    $0x10,%esp
}
80105fb6:	c9                   	leave  
80105fb7:	c3                   	ret    
80105fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbf:	90                   	nop
80105fc0:	c9                   	leave  
    return -1;
80105fc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fc6:	c3                   	ret    
80105fc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fce:	66 90                	xchg   %ax,%ax

80105fd0 <sys_getpinfo>:

int 
sys_getpinfo(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	83 ec 1c             	sub    $0x1c,%esp
  struct pstat* addr;
  if(argptr(0, (void *)&addr, sizeof(struct pstat))) {  //n non zero value
80105fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fd9:	68 00 07 00 00       	push   $0x700
80105fde:	50                   	push   %eax
80105fdf:	6a 00                	push   $0x0
80105fe1:	e8 4a f0 ff ff       	call   80105030 <argptr>
80105fe6:	83 c4 10             	add    $0x10,%esp
80105fe9:	85 c0                	test   %eax,%eax
80105feb:	75 13                	jne    80106000 <sys_getpinfo+0x30>
    return -1;
  }
  return getpinfo((void *)addr);
80105fed:	83 ec 0c             	sub    $0xc,%esp
80105ff0:	ff 75 f4             	push   -0xc(%ebp)
80105ff3:	e8 f8 e2 ff ff       	call   801042f0 <getpinfo>
80105ff8:	83 c4 10             	add    $0x10,%esp
}
80105ffb:	c9                   	leave  
80105ffc:	c3                   	ret    
80105ffd:	8d 76 00             	lea    0x0(%esi),%esi
80106000:	c9                   	leave  
    return -1;
80106001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106006:	c3                   	ret    

80106007 <alltraps>:
80106007:	1e                   	push   %ds
80106008:	06                   	push   %es
80106009:	0f a0                	push   %fs
8010600b:	0f a8                	push   %gs
8010600d:	60                   	pusha  
8010600e:	66 b8 10 00          	mov    $0x10,%ax
80106012:	8e d8                	mov    %eax,%ds
80106014:	8e c0                	mov    %eax,%es
80106016:	54                   	push   %esp
80106017:	e8 c4 00 00 00       	call   801060e0 <trap>
8010601c:	83 c4 04             	add    $0x4,%esp

8010601f <trapret>:
8010601f:	61                   	popa   
80106020:	0f a9                	pop    %gs
80106022:	0f a1                	pop    %fs
80106024:	07                   	pop    %es
80106025:	1f                   	pop    %ds
80106026:	83 c4 08             	add    $0x8,%esp
80106029:	cf                   	iret   
8010602a:	66 90                	xchg   %ax,%ax
8010602c:	66 90                	xchg   %ax,%ax
8010602e:	66 90                	xchg   %ax,%ax

80106030 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106030:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106031:	31 c0                	xor    %eax,%eax
{
80106033:	89 e5                	mov    %esp,%ebp
80106035:	83 ec 08             	sub    $0x8,%esp
80106038:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010603f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106040:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106047:	c7 04 c5 e2 58 11 80 	movl   $0x8e000008,-0x7feea71e(,%eax,8)
8010604e:	08 00 00 8e 
80106052:	66 89 14 c5 e0 58 11 	mov    %dx,-0x7feea720(,%eax,8)
80106059:	80 
8010605a:	c1 ea 10             	shr    $0x10,%edx
8010605d:	66 89 14 c5 e6 58 11 	mov    %dx,-0x7feea71a(,%eax,8)
80106064:	80 
  for(i = 0; i < 256; i++)
80106065:	83 c0 01             	add    $0x1,%eax
80106068:	3d 00 01 00 00       	cmp    $0x100,%eax
8010606d:	75 d1                	jne    80106040 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010606f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106072:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106077:	c7 05 e2 5a 11 80 08 	movl   $0xef000008,0x80115ae2
8010607e:	00 00 ef 
  initlock(&tickslock, "time");
80106081:	68 49 81 10 80       	push   $0x80108149
80106086:	68 a0 58 11 80       	push   $0x801158a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010608b:	66 a3 e0 5a 11 80    	mov    %ax,0x80115ae0
80106091:	c1 e8 10             	shr    $0x10,%eax
80106094:	66 a3 e6 5a 11 80    	mov    %ax,0x80115ae6
  initlock(&tickslock, "time");
8010609a:	e8 e1 e9 ff ff       	call   80104a80 <initlock>
}
8010609f:	83 c4 10             	add    $0x10,%esp
801060a2:	c9                   	leave  
801060a3:	c3                   	ret    
801060a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060af:	90                   	nop

801060b0 <idtinit>:

void
idtinit(void)
{
801060b0:	55                   	push   %ebp
  pd[0] = size-1;
801060b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801060b6:	89 e5                	mov    %esp,%ebp
801060b8:	83 ec 10             	sub    $0x10,%esp
801060bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801060bf:	b8 e0 58 11 80       	mov    $0x801158e0,%eax
801060c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801060c8:	c1 e8 10             	shr    $0x10,%eax
801060cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801060cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801060d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801060d5:	c9                   	leave  
801060d6:	c3                   	ret    
801060d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060de:	66 90                	xchg   %ax,%ax

801060e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	57                   	push   %edi
801060e4:	56                   	push   %esi
801060e5:	53                   	push   %ebx
801060e6:	83 ec 1c             	sub    $0x1c,%esp
801060e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801060ec:	8b 43 30             	mov    0x30(%ebx),%eax
801060ef:	83 f8 40             	cmp    $0x40,%eax
801060f2:	0f 84 68 01 00 00    	je     80106260 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801060f8:	83 e8 20             	sub    $0x20,%eax
801060fb:	83 f8 1f             	cmp    $0x1f,%eax
801060fe:	0f 87 8c 00 00 00    	ja     80106190 <trap+0xb0>
80106104:	ff 24 85 f0 81 10 80 	jmp    *-0x7fef7e10(,%eax,4)
8010610b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010610f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106110:	e8 2b c1 ff ff       	call   80102240 <ideintr>
    lapiceoi();
80106115:	e8 f6 c7 ff ff       	call   80102910 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010611a:	e8 91 d9 ff ff       	call   80103ab0 <myproc>
8010611f:	85 c0                	test   %eax,%eax
80106121:	74 1d                	je     80106140 <trap+0x60>
80106123:	e8 88 d9 ff ff       	call   80103ab0 <myproc>
80106128:	8b 50 24             	mov    0x24(%eax),%edx
8010612b:	85 d2                	test   %edx,%edx
8010612d:	74 11                	je     80106140 <trap+0x60>
8010612f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106133:	83 e0 03             	and    $0x3,%eax
80106136:	66 83 f8 03          	cmp    $0x3,%ax
8010613a:	0f 84 e8 01 00 00    	je     80106328 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106140:	e8 6b d9 ff ff       	call   80103ab0 <myproc>
80106145:	85 c0                	test   %eax,%eax
80106147:	74 0f                	je     80106158 <trap+0x78>
80106149:	e8 62 d9 ff ff       	call   80103ab0 <myproc>
8010614e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106152:	0f 84 b8 00 00 00    	je     80106210 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106158:	e8 53 d9 ff ff       	call   80103ab0 <myproc>
8010615d:	85 c0                	test   %eax,%eax
8010615f:	74 1d                	je     8010617e <trap+0x9e>
80106161:	e8 4a d9 ff ff       	call   80103ab0 <myproc>
80106166:	8b 40 24             	mov    0x24(%eax),%eax
80106169:	85 c0                	test   %eax,%eax
8010616b:	74 11                	je     8010617e <trap+0x9e>
8010616d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106171:	83 e0 03             	and    $0x3,%eax
80106174:	66 83 f8 03          	cmp    $0x3,%ax
80106178:	0f 84 0f 01 00 00    	je     8010628d <trap+0x1ad>
    exit();
}
8010617e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106181:	5b                   	pop    %ebx
80106182:	5e                   	pop    %esi
80106183:	5f                   	pop    %edi
80106184:	5d                   	pop    %ebp
80106185:	c3                   	ret    
80106186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010618d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106190:	e8 1b d9 ff ff       	call   80103ab0 <myproc>
80106195:	8b 7b 38             	mov    0x38(%ebx),%edi
80106198:	85 c0                	test   %eax,%eax
8010619a:	0f 84 a2 01 00 00    	je     80106342 <trap+0x262>
801061a0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801061a4:	0f 84 98 01 00 00    	je     80106342 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801061aa:	0f 20 d1             	mov    %cr2,%ecx
801061ad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061b0:	e8 db d8 ff ff       	call   80103a90 <cpuid>
801061b5:	8b 73 30             	mov    0x30(%ebx),%esi
801061b8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801061bb:	8b 43 34             	mov    0x34(%ebx),%eax
801061be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801061c1:	e8 ea d8 ff ff       	call   80103ab0 <myproc>
801061c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061c9:	e8 e2 d8 ff ff       	call   80103ab0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061ce:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061d1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061d4:	51                   	push   %ecx
801061d5:	57                   	push   %edi
801061d6:	52                   	push   %edx
801061d7:	ff 75 e4             	push   -0x1c(%ebp)
801061da:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801061db:	8b 75 e0             	mov    -0x20(%ebp),%esi
801061de:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061e1:	56                   	push   %esi
801061e2:	ff 70 10             	push   0x10(%eax)
801061e5:	68 ac 81 10 80       	push   $0x801081ac
801061ea:	e8 b1 a4 ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
801061ef:	83 c4 20             	add    $0x20,%esp
801061f2:	e8 b9 d8 ff ff       	call   80103ab0 <myproc>
801061f7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061fe:	e8 ad d8 ff ff       	call   80103ab0 <myproc>
80106203:	85 c0                	test   %eax,%eax
80106205:	0f 85 18 ff ff ff    	jne    80106123 <trap+0x43>
8010620b:	e9 30 ff ff ff       	jmp    80106140 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106210:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106214:	0f 85 3e ff ff ff    	jne    80106158 <trap+0x78>
    yield();
8010621a:	e8 81 e3 ff ff       	call   801045a0 <yield>
8010621f:	e9 34 ff ff ff       	jmp    80106158 <trap+0x78>
80106224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106228:	8b 7b 38             	mov    0x38(%ebx),%edi
8010622b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010622f:	e8 5c d8 ff ff       	call   80103a90 <cpuid>
80106234:	57                   	push   %edi
80106235:	56                   	push   %esi
80106236:	50                   	push   %eax
80106237:	68 54 81 10 80       	push   $0x80108154
8010623c:	e8 5f a4 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80106241:	e8 ca c6 ff ff       	call   80102910 <lapiceoi>
    break;
80106246:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106249:	e8 62 d8 ff ff       	call   80103ab0 <myproc>
8010624e:	85 c0                	test   %eax,%eax
80106250:	0f 85 cd fe ff ff    	jne    80106123 <trap+0x43>
80106256:	e9 e5 fe ff ff       	jmp    80106140 <trap+0x60>
8010625b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010625f:	90                   	nop
    if(myproc()->killed)
80106260:	e8 4b d8 ff ff       	call   80103ab0 <myproc>
80106265:	8b 70 24             	mov    0x24(%eax),%esi
80106268:	85 f6                	test   %esi,%esi
8010626a:	0f 85 c8 00 00 00    	jne    80106338 <trap+0x258>
    myproc()->tf = tf;
80106270:	e8 3b d8 ff ff       	call   80103ab0 <myproc>
80106275:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106278:	e8 a3 ee ff ff       	call   80105120 <syscall>
    if(myproc()->killed)
8010627d:	e8 2e d8 ff ff       	call   80103ab0 <myproc>
80106282:	8b 48 24             	mov    0x24(%eax),%ecx
80106285:	85 c9                	test   %ecx,%ecx
80106287:	0f 84 f1 fe ff ff    	je     8010617e <trap+0x9e>
}
8010628d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106290:	5b                   	pop    %ebx
80106291:	5e                   	pop    %esi
80106292:	5f                   	pop    %edi
80106293:	5d                   	pop    %ebp
      exit();
80106294:	e9 87 d9 ff ff       	jmp    80103c20 <exit>
80106299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801062a0:	e8 3b 02 00 00       	call   801064e0 <uartintr>
    lapiceoi();
801062a5:	e8 66 c6 ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062aa:	e8 01 d8 ff ff       	call   80103ab0 <myproc>
801062af:	85 c0                	test   %eax,%eax
801062b1:	0f 85 6c fe ff ff    	jne    80106123 <trap+0x43>
801062b7:	e9 84 fe ff ff       	jmp    80106140 <trap+0x60>
801062bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801062c0:	e8 0b c5 ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
801062c5:	e8 46 c6 ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062ca:	e8 e1 d7 ff ff       	call   80103ab0 <myproc>
801062cf:	85 c0                	test   %eax,%eax
801062d1:	0f 85 4c fe ff ff    	jne    80106123 <trap+0x43>
801062d7:	e9 64 fe ff ff       	jmp    80106140 <trap+0x60>
801062dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801062e0:	e8 ab d7 ff ff       	call   80103a90 <cpuid>
801062e5:	85 c0                	test   %eax,%eax
801062e7:	0f 85 28 fe ff ff    	jne    80106115 <trap+0x35>
      acquire(&tickslock);
801062ed:	83 ec 0c             	sub    $0xc,%esp
801062f0:	68 a0 58 11 80       	push   $0x801158a0
801062f5:	e8 56 e9 ff ff       	call   80104c50 <acquire>
      wakeup(&ticks);
801062fa:	c7 04 24 80 58 11 80 	movl   $0x80115880,(%esp)
      ticks++;
80106301:	83 05 80 58 11 80 01 	addl   $0x1,0x80115880
      wakeup(&ticks);
80106308:	e8 43 dc ff ff       	call   80103f50 <wakeup>
      release(&tickslock);
8010630d:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
80106314:	e8 d7 e8 ff ff       	call   80104bf0 <release>
80106319:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010631c:	e9 f4 fd ff ff       	jmp    80106115 <trap+0x35>
80106321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106328:	e8 f3 d8 ff ff       	call   80103c20 <exit>
8010632d:	e9 0e fe ff ff       	jmp    80106140 <trap+0x60>
80106332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106338:	e8 e3 d8 ff ff       	call   80103c20 <exit>
8010633d:	e9 2e ff ff ff       	jmp    80106270 <trap+0x190>
80106342:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106345:	e8 46 d7 ff ff       	call   80103a90 <cpuid>
8010634a:	83 ec 0c             	sub    $0xc,%esp
8010634d:	56                   	push   %esi
8010634e:	57                   	push   %edi
8010634f:	50                   	push   %eax
80106350:	ff 73 30             	push   0x30(%ebx)
80106353:	68 78 81 10 80       	push   $0x80108178
80106358:	e8 43 a3 ff ff       	call   801006a0 <cprintf>
      panic("trap");
8010635d:	83 c4 14             	add    $0x14,%esp
80106360:	68 4e 81 10 80       	push   $0x8010814e
80106365:	e8 16 a0 ff ff       	call   80100380 <panic>
8010636a:	66 90                	xchg   %ax,%ax
8010636c:	66 90                	xchg   %ax,%ax
8010636e:	66 90                	xchg   %ax,%ax

80106370 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106370:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80106375:	85 c0                	test   %eax,%eax
80106377:	74 17                	je     80106390 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106379:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010637e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010637f:	a8 01                	test   $0x1,%al
80106381:	74 0d                	je     80106390 <uartgetc+0x20>
80106383:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106388:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106389:	0f b6 c0             	movzbl %al,%eax
8010638c:	c3                   	ret    
8010638d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106395:	c3                   	ret    
80106396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639d:	8d 76 00             	lea    0x0(%esi),%esi

801063a0 <uartinit>:
{
801063a0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801063a1:	31 c9                	xor    %ecx,%ecx
801063a3:	89 c8                	mov    %ecx,%eax
801063a5:	89 e5                	mov    %esp,%ebp
801063a7:	57                   	push   %edi
801063a8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801063ad:	56                   	push   %esi
801063ae:	89 fa                	mov    %edi,%edx
801063b0:	53                   	push   %ebx
801063b1:	83 ec 1c             	sub    $0x1c,%esp
801063b4:	ee                   	out    %al,(%dx)
801063b5:	be fb 03 00 00       	mov    $0x3fb,%esi
801063ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801063bf:	89 f2                	mov    %esi,%edx
801063c1:	ee                   	out    %al,(%dx)
801063c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801063c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063cc:	ee                   	out    %al,(%dx)
801063cd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801063d2:	89 c8                	mov    %ecx,%eax
801063d4:	89 da                	mov    %ebx,%edx
801063d6:	ee                   	out    %al,(%dx)
801063d7:	b8 03 00 00 00       	mov    $0x3,%eax
801063dc:	89 f2                	mov    %esi,%edx
801063de:	ee                   	out    %al,(%dx)
801063df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801063e4:	89 c8                	mov    %ecx,%eax
801063e6:	ee                   	out    %al,(%dx)
801063e7:	b8 01 00 00 00       	mov    $0x1,%eax
801063ec:	89 da                	mov    %ebx,%edx
801063ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801063ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063f4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801063f5:	3c ff                	cmp    $0xff,%al
801063f7:	74 78                	je     80106471 <uartinit+0xd1>
  uart = 1;
801063f9:	c7 05 e0 60 11 80 01 	movl   $0x1,0x801160e0
80106400:	00 00 00 
80106403:	89 fa                	mov    %edi,%edx
80106405:	ec                   	in     (%dx),%al
80106406:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010640b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010640c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010640f:	bf 70 82 10 80       	mov    $0x80108270,%edi
80106414:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106419:	6a 00                	push   $0x0
8010641b:	6a 04                	push   $0x4
8010641d:	e8 5e c0 ff ff       	call   80102480 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106422:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106426:	83 c4 10             	add    $0x10,%esp
80106429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106430:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80106435:	bb 80 00 00 00       	mov    $0x80,%ebx
8010643a:	85 c0                	test   %eax,%eax
8010643c:	75 14                	jne    80106452 <uartinit+0xb2>
8010643e:	eb 23                	jmp    80106463 <uartinit+0xc3>
    microdelay(10);
80106440:	83 ec 0c             	sub    $0xc,%esp
80106443:	6a 0a                	push   $0xa
80106445:	e8 e6 c4 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010644a:	83 c4 10             	add    $0x10,%esp
8010644d:	83 eb 01             	sub    $0x1,%ebx
80106450:	74 07                	je     80106459 <uartinit+0xb9>
80106452:	89 f2                	mov    %esi,%edx
80106454:	ec                   	in     (%dx),%al
80106455:	a8 20                	test   $0x20,%al
80106457:	74 e7                	je     80106440 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106459:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010645d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106462:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106463:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106467:	83 c7 01             	add    $0x1,%edi
8010646a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010646d:	84 c0                	test   %al,%al
8010646f:	75 bf                	jne    80106430 <uartinit+0x90>
}
80106471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106474:	5b                   	pop    %ebx
80106475:	5e                   	pop    %esi
80106476:	5f                   	pop    %edi
80106477:	5d                   	pop    %ebp
80106478:	c3                   	ret    
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106480 <uartputc>:
  if(!uart)
80106480:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80106485:	85 c0                	test   %eax,%eax
80106487:	74 47                	je     801064d0 <uartputc+0x50>
{
80106489:	55                   	push   %ebp
8010648a:	89 e5                	mov    %esp,%ebp
8010648c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010648d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106492:	53                   	push   %ebx
80106493:	bb 80 00 00 00       	mov    $0x80,%ebx
80106498:	eb 18                	jmp    801064b2 <uartputc+0x32>
8010649a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801064a0:	83 ec 0c             	sub    $0xc,%esp
801064a3:	6a 0a                	push   $0xa
801064a5:	e8 86 c4 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801064aa:	83 c4 10             	add    $0x10,%esp
801064ad:	83 eb 01             	sub    $0x1,%ebx
801064b0:	74 07                	je     801064b9 <uartputc+0x39>
801064b2:	89 f2                	mov    %esi,%edx
801064b4:	ec                   	in     (%dx),%al
801064b5:	a8 20                	test   $0x20,%al
801064b7:	74 e7                	je     801064a0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801064b9:	8b 45 08             	mov    0x8(%ebp),%eax
801064bc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064c1:	ee                   	out    %al,(%dx)
}
801064c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801064c5:	5b                   	pop    %ebx
801064c6:	5e                   	pop    %esi
801064c7:	5d                   	pop    %ebp
801064c8:	c3                   	ret    
801064c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064d0:	c3                   	ret    
801064d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064df:	90                   	nop

801064e0 <uartintr>:

void
uartintr(void)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801064e6:	68 70 63 10 80       	push   $0x80106370
801064eb:	e8 90 a3 ff ff       	call   80100880 <consoleintr>
}
801064f0:	83 c4 10             	add    $0x10,%esp
801064f3:	c9                   	leave  
801064f4:	c3                   	ret    

801064f5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801064f5:	6a 00                	push   $0x0
  pushl $0
801064f7:	6a 00                	push   $0x0
  jmp alltraps
801064f9:	e9 09 fb ff ff       	jmp    80106007 <alltraps>

801064fe <vector1>:
.globl vector1
vector1:
  pushl $0
801064fe:	6a 00                	push   $0x0
  pushl $1
80106500:	6a 01                	push   $0x1
  jmp alltraps
80106502:	e9 00 fb ff ff       	jmp    80106007 <alltraps>

80106507 <vector2>:
.globl vector2
vector2:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $2
80106509:	6a 02                	push   $0x2
  jmp alltraps
8010650b:	e9 f7 fa ff ff       	jmp    80106007 <alltraps>

80106510 <vector3>:
.globl vector3
vector3:
  pushl $0
80106510:	6a 00                	push   $0x0
  pushl $3
80106512:	6a 03                	push   $0x3
  jmp alltraps
80106514:	e9 ee fa ff ff       	jmp    80106007 <alltraps>

80106519 <vector4>:
.globl vector4
vector4:
  pushl $0
80106519:	6a 00                	push   $0x0
  pushl $4
8010651b:	6a 04                	push   $0x4
  jmp alltraps
8010651d:	e9 e5 fa ff ff       	jmp    80106007 <alltraps>

80106522 <vector5>:
.globl vector5
vector5:
  pushl $0
80106522:	6a 00                	push   $0x0
  pushl $5
80106524:	6a 05                	push   $0x5
  jmp alltraps
80106526:	e9 dc fa ff ff       	jmp    80106007 <alltraps>

8010652b <vector6>:
.globl vector6
vector6:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $6
8010652d:	6a 06                	push   $0x6
  jmp alltraps
8010652f:	e9 d3 fa ff ff       	jmp    80106007 <alltraps>

80106534 <vector7>:
.globl vector7
vector7:
  pushl $0
80106534:	6a 00                	push   $0x0
  pushl $7
80106536:	6a 07                	push   $0x7
  jmp alltraps
80106538:	e9 ca fa ff ff       	jmp    80106007 <alltraps>

8010653d <vector8>:
.globl vector8
vector8:
  pushl $8
8010653d:	6a 08                	push   $0x8
  jmp alltraps
8010653f:	e9 c3 fa ff ff       	jmp    80106007 <alltraps>

80106544 <vector9>:
.globl vector9
vector9:
  pushl $0
80106544:	6a 00                	push   $0x0
  pushl $9
80106546:	6a 09                	push   $0x9
  jmp alltraps
80106548:	e9 ba fa ff ff       	jmp    80106007 <alltraps>

8010654d <vector10>:
.globl vector10
vector10:
  pushl $10
8010654d:	6a 0a                	push   $0xa
  jmp alltraps
8010654f:	e9 b3 fa ff ff       	jmp    80106007 <alltraps>

80106554 <vector11>:
.globl vector11
vector11:
  pushl $11
80106554:	6a 0b                	push   $0xb
  jmp alltraps
80106556:	e9 ac fa ff ff       	jmp    80106007 <alltraps>

8010655b <vector12>:
.globl vector12
vector12:
  pushl $12
8010655b:	6a 0c                	push   $0xc
  jmp alltraps
8010655d:	e9 a5 fa ff ff       	jmp    80106007 <alltraps>

80106562 <vector13>:
.globl vector13
vector13:
  pushl $13
80106562:	6a 0d                	push   $0xd
  jmp alltraps
80106564:	e9 9e fa ff ff       	jmp    80106007 <alltraps>

80106569 <vector14>:
.globl vector14
vector14:
  pushl $14
80106569:	6a 0e                	push   $0xe
  jmp alltraps
8010656b:	e9 97 fa ff ff       	jmp    80106007 <alltraps>

80106570 <vector15>:
.globl vector15
vector15:
  pushl $0
80106570:	6a 00                	push   $0x0
  pushl $15
80106572:	6a 0f                	push   $0xf
  jmp alltraps
80106574:	e9 8e fa ff ff       	jmp    80106007 <alltraps>

80106579 <vector16>:
.globl vector16
vector16:
  pushl $0
80106579:	6a 00                	push   $0x0
  pushl $16
8010657b:	6a 10                	push   $0x10
  jmp alltraps
8010657d:	e9 85 fa ff ff       	jmp    80106007 <alltraps>

80106582 <vector17>:
.globl vector17
vector17:
  pushl $17
80106582:	6a 11                	push   $0x11
  jmp alltraps
80106584:	e9 7e fa ff ff       	jmp    80106007 <alltraps>

80106589 <vector18>:
.globl vector18
vector18:
  pushl $0
80106589:	6a 00                	push   $0x0
  pushl $18
8010658b:	6a 12                	push   $0x12
  jmp alltraps
8010658d:	e9 75 fa ff ff       	jmp    80106007 <alltraps>

80106592 <vector19>:
.globl vector19
vector19:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $19
80106594:	6a 13                	push   $0x13
  jmp alltraps
80106596:	e9 6c fa ff ff       	jmp    80106007 <alltraps>

8010659b <vector20>:
.globl vector20
vector20:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $20
8010659d:	6a 14                	push   $0x14
  jmp alltraps
8010659f:	e9 63 fa ff ff       	jmp    80106007 <alltraps>

801065a4 <vector21>:
.globl vector21
vector21:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $21
801065a6:	6a 15                	push   $0x15
  jmp alltraps
801065a8:	e9 5a fa ff ff       	jmp    80106007 <alltraps>

801065ad <vector22>:
.globl vector22
vector22:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $22
801065af:	6a 16                	push   $0x16
  jmp alltraps
801065b1:	e9 51 fa ff ff       	jmp    80106007 <alltraps>

801065b6 <vector23>:
.globl vector23
vector23:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $23
801065b8:	6a 17                	push   $0x17
  jmp alltraps
801065ba:	e9 48 fa ff ff       	jmp    80106007 <alltraps>

801065bf <vector24>:
.globl vector24
vector24:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $24
801065c1:	6a 18                	push   $0x18
  jmp alltraps
801065c3:	e9 3f fa ff ff       	jmp    80106007 <alltraps>

801065c8 <vector25>:
.globl vector25
vector25:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $25
801065ca:	6a 19                	push   $0x19
  jmp alltraps
801065cc:	e9 36 fa ff ff       	jmp    80106007 <alltraps>

801065d1 <vector26>:
.globl vector26
vector26:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $26
801065d3:	6a 1a                	push   $0x1a
  jmp alltraps
801065d5:	e9 2d fa ff ff       	jmp    80106007 <alltraps>

801065da <vector27>:
.globl vector27
vector27:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $27
801065dc:	6a 1b                	push   $0x1b
  jmp alltraps
801065de:	e9 24 fa ff ff       	jmp    80106007 <alltraps>

801065e3 <vector28>:
.globl vector28
vector28:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $28
801065e5:	6a 1c                	push   $0x1c
  jmp alltraps
801065e7:	e9 1b fa ff ff       	jmp    80106007 <alltraps>

801065ec <vector29>:
.globl vector29
vector29:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $29
801065ee:	6a 1d                	push   $0x1d
  jmp alltraps
801065f0:	e9 12 fa ff ff       	jmp    80106007 <alltraps>

801065f5 <vector30>:
.globl vector30
vector30:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $30
801065f7:	6a 1e                	push   $0x1e
  jmp alltraps
801065f9:	e9 09 fa ff ff       	jmp    80106007 <alltraps>

801065fe <vector31>:
.globl vector31
vector31:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $31
80106600:	6a 1f                	push   $0x1f
  jmp alltraps
80106602:	e9 00 fa ff ff       	jmp    80106007 <alltraps>

80106607 <vector32>:
.globl vector32
vector32:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $32
80106609:	6a 20                	push   $0x20
  jmp alltraps
8010660b:	e9 f7 f9 ff ff       	jmp    80106007 <alltraps>

80106610 <vector33>:
.globl vector33
vector33:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $33
80106612:	6a 21                	push   $0x21
  jmp alltraps
80106614:	e9 ee f9 ff ff       	jmp    80106007 <alltraps>

80106619 <vector34>:
.globl vector34
vector34:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $34
8010661b:	6a 22                	push   $0x22
  jmp alltraps
8010661d:	e9 e5 f9 ff ff       	jmp    80106007 <alltraps>

80106622 <vector35>:
.globl vector35
vector35:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $35
80106624:	6a 23                	push   $0x23
  jmp alltraps
80106626:	e9 dc f9 ff ff       	jmp    80106007 <alltraps>

8010662b <vector36>:
.globl vector36
vector36:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $36
8010662d:	6a 24                	push   $0x24
  jmp alltraps
8010662f:	e9 d3 f9 ff ff       	jmp    80106007 <alltraps>

80106634 <vector37>:
.globl vector37
vector37:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $37
80106636:	6a 25                	push   $0x25
  jmp alltraps
80106638:	e9 ca f9 ff ff       	jmp    80106007 <alltraps>

8010663d <vector38>:
.globl vector38
vector38:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $38
8010663f:	6a 26                	push   $0x26
  jmp alltraps
80106641:	e9 c1 f9 ff ff       	jmp    80106007 <alltraps>

80106646 <vector39>:
.globl vector39
vector39:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $39
80106648:	6a 27                	push   $0x27
  jmp alltraps
8010664a:	e9 b8 f9 ff ff       	jmp    80106007 <alltraps>

8010664f <vector40>:
.globl vector40
vector40:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $40
80106651:	6a 28                	push   $0x28
  jmp alltraps
80106653:	e9 af f9 ff ff       	jmp    80106007 <alltraps>

80106658 <vector41>:
.globl vector41
vector41:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $41
8010665a:	6a 29                	push   $0x29
  jmp alltraps
8010665c:	e9 a6 f9 ff ff       	jmp    80106007 <alltraps>

80106661 <vector42>:
.globl vector42
vector42:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $42
80106663:	6a 2a                	push   $0x2a
  jmp alltraps
80106665:	e9 9d f9 ff ff       	jmp    80106007 <alltraps>

8010666a <vector43>:
.globl vector43
vector43:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $43
8010666c:	6a 2b                	push   $0x2b
  jmp alltraps
8010666e:	e9 94 f9 ff ff       	jmp    80106007 <alltraps>

80106673 <vector44>:
.globl vector44
vector44:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $44
80106675:	6a 2c                	push   $0x2c
  jmp alltraps
80106677:	e9 8b f9 ff ff       	jmp    80106007 <alltraps>

8010667c <vector45>:
.globl vector45
vector45:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $45
8010667e:	6a 2d                	push   $0x2d
  jmp alltraps
80106680:	e9 82 f9 ff ff       	jmp    80106007 <alltraps>

80106685 <vector46>:
.globl vector46
vector46:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $46
80106687:	6a 2e                	push   $0x2e
  jmp alltraps
80106689:	e9 79 f9 ff ff       	jmp    80106007 <alltraps>

8010668e <vector47>:
.globl vector47
vector47:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $47
80106690:	6a 2f                	push   $0x2f
  jmp alltraps
80106692:	e9 70 f9 ff ff       	jmp    80106007 <alltraps>

80106697 <vector48>:
.globl vector48
vector48:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $48
80106699:	6a 30                	push   $0x30
  jmp alltraps
8010669b:	e9 67 f9 ff ff       	jmp    80106007 <alltraps>

801066a0 <vector49>:
.globl vector49
vector49:
  pushl $0
801066a0:	6a 00                	push   $0x0
  pushl $49
801066a2:	6a 31                	push   $0x31
  jmp alltraps
801066a4:	e9 5e f9 ff ff       	jmp    80106007 <alltraps>

801066a9 <vector50>:
.globl vector50
vector50:
  pushl $0
801066a9:	6a 00                	push   $0x0
  pushl $50
801066ab:	6a 32                	push   $0x32
  jmp alltraps
801066ad:	e9 55 f9 ff ff       	jmp    80106007 <alltraps>

801066b2 <vector51>:
.globl vector51
vector51:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $51
801066b4:	6a 33                	push   $0x33
  jmp alltraps
801066b6:	e9 4c f9 ff ff       	jmp    80106007 <alltraps>

801066bb <vector52>:
.globl vector52
vector52:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $52
801066bd:	6a 34                	push   $0x34
  jmp alltraps
801066bf:	e9 43 f9 ff ff       	jmp    80106007 <alltraps>

801066c4 <vector53>:
.globl vector53
vector53:
  pushl $0
801066c4:	6a 00                	push   $0x0
  pushl $53
801066c6:	6a 35                	push   $0x35
  jmp alltraps
801066c8:	e9 3a f9 ff ff       	jmp    80106007 <alltraps>

801066cd <vector54>:
.globl vector54
vector54:
  pushl $0
801066cd:	6a 00                	push   $0x0
  pushl $54
801066cf:	6a 36                	push   $0x36
  jmp alltraps
801066d1:	e9 31 f9 ff ff       	jmp    80106007 <alltraps>

801066d6 <vector55>:
.globl vector55
vector55:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $55
801066d8:	6a 37                	push   $0x37
  jmp alltraps
801066da:	e9 28 f9 ff ff       	jmp    80106007 <alltraps>

801066df <vector56>:
.globl vector56
vector56:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $56
801066e1:	6a 38                	push   $0x38
  jmp alltraps
801066e3:	e9 1f f9 ff ff       	jmp    80106007 <alltraps>

801066e8 <vector57>:
.globl vector57
vector57:
  pushl $0
801066e8:	6a 00                	push   $0x0
  pushl $57
801066ea:	6a 39                	push   $0x39
  jmp alltraps
801066ec:	e9 16 f9 ff ff       	jmp    80106007 <alltraps>

801066f1 <vector58>:
.globl vector58
vector58:
  pushl $0
801066f1:	6a 00                	push   $0x0
  pushl $58
801066f3:	6a 3a                	push   $0x3a
  jmp alltraps
801066f5:	e9 0d f9 ff ff       	jmp    80106007 <alltraps>

801066fa <vector59>:
.globl vector59
vector59:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $59
801066fc:	6a 3b                	push   $0x3b
  jmp alltraps
801066fe:	e9 04 f9 ff ff       	jmp    80106007 <alltraps>

80106703 <vector60>:
.globl vector60
vector60:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $60
80106705:	6a 3c                	push   $0x3c
  jmp alltraps
80106707:	e9 fb f8 ff ff       	jmp    80106007 <alltraps>

8010670c <vector61>:
.globl vector61
vector61:
  pushl $0
8010670c:	6a 00                	push   $0x0
  pushl $61
8010670e:	6a 3d                	push   $0x3d
  jmp alltraps
80106710:	e9 f2 f8 ff ff       	jmp    80106007 <alltraps>

80106715 <vector62>:
.globl vector62
vector62:
  pushl $0
80106715:	6a 00                	push   $0x0
  pushl $62
80106717:	6a 3e                	push   $0x3e
  jmp alltraps
80106719:	e9 e9 f8 ff ff       	jmp    80106007 <alltraps>

8010671e <vector63>:
.globl vector63
vector63:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $63
80106720:	6a 3f                	push   $0x3f
  jmp alltraps
80106722:	e9 e0 f8 ff ff       	jmp    80106007 <alltraps>

80106727 <vector64>:
.globl vector64
vector64:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $64
80106729:	6a 40                	push   $0x40
  jmp alltraps
8010672b:	e9 d7 f8 ff ff       	jmp    80106007 <alltraps>

80106730 <vector65>:
.globl vector65
vector65:
  pushl $0
80106730:	6a 00                	push   $0x0
  pushl $65
80106732:	6a 41                	push   $0x41
  jmp alltraps
80106734:	e9 ce f8 ff ff       	jmp    80106007 <alltraps>

80106739 <vector66>:
.globl vector66
vector66:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $66
8010673b:	6a 42                	push   $0x42
  jmp alltraps
8010673d:	e9 c5 f8 ff ff       	jmp    80106007 <alltraps>

80106742 <vector67>:
.globl vector67
vector67:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $67
80106744:	6a 43                	push   $0x43
  jmp alltraps
80106746:	e9 bc f8 ff ff       	jmp    80106007 <alltraps>

8010674b <vector68>:
.globl vector68
vector68:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $68
8010674d:	6a 44                	push   $0x44
  jmp alltraps
8010674f:	e9 b3 f8 ff ff       	jmp    80106007 <alltraps>

80106754 <vector69>:
.globl vector69
vector69:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $69
80106756:	6a 45                	push   $0x45
  jmp alltraps
80106758:	e9 aa f8 ff ff       	jmp    80106007 <alltraps>

8010675d <vector70>:
.globl vector70
vector70:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $70
8010675f:	6a 46                	push   $0x46
  jmp alltraps
80106761:	e9 a1 f8 ff ff       	jmp    80106007 <alltraps>

80106766 <vector71>:
.globl vector71
vector71:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $71
80106768:	6a 47                	push   $0x47
  jmp alltraps
8010676a:	e9 98 f8 ff ff       	jmp    80106007 <alltraps>

8010676f <vector72>:
.globl vector72
vector72:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $72
80106771:	6a 48                	push   $0x48
  jmp alltraps
80106773:	e9 8f f8 ff ff       	jmp    80106007 <alltraps>

80106778 <vector73>:
.globl vector73
vector73:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $73
8010677a:	6a 49                	push   $0x49
  jmp alltraps
8010677c:	e9 86 f8 ff ff       	jmp    80106007 <alltraps>

80106781 <vector74>:
.globl vector74
vector74:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $74
80106783:	6a 4a                	push   $0x4a
  jmp alltraps
80106785:	e9 7d f8 ff ff       	jmp    80106007 <alltraps>

8010678a <vector75>:
.globl vector75
vector75:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $75
8010678c:	6a 4b                	push   $0x4b
  jmp alltraps
8010678e:	e9 74 f8 ff ff       	jmp    80106007 <alltraps>

80106793 <vector76>:
.globl vector76
vector76:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $76
80106795:	6a 4c                	push   $0x4c
  jmp alltraps
80106797:	e9 6b f8 ff ff       	jmp    80106007 <alltraps>

8010679c <vector77>:
.globl vector77
vector77:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $77
8010679e:	6a 4d                	push   $0x4d
  jmp alltraps
801067a0:	e9 62 f8 ff ff       	jmp    80106007 <alltraps>

801067a5 <vector78>:
.globl vector78
vector78:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $78
801067a7:	6a 4e                	push   $0x4e
  jmp alltraps
801067a9:	e9 59 f8 ff ff       	jmp    80106007 <alltraps>

801067ae <vector79>:
.globl vector79
vector79:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $79
801067b0:	6a 4f                	push   $0x4f
  jmp alltraps
801067b2:	e9 50 f8 ff ff       	jmp    80106007 <alltraps>

801067b7 <vector80>:
.globl vector80
vector80:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $80
801067b9:	6a 50                	push   $0x50
  jmp alltraps
801067bb:	e9 47 f8 ff ff       	jmp    80106007 <alltraps>

801067c0 <vector81>:
.globl vector81
vector81:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $81
801067c2:	6a 51                	push   $0x51
  jmp alltraps
801067c4:	e9 3e f8 ff ff       	jmp    80106007 <alltraps>

801067c9 <vector82>:
.globl vector82
vector82:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $82
801067cb:	6a 52                	push   $0x52
  jmp alltraps
801067cd:	e9 35 f8 ff ff       	jmp    80106007 <alltraps>

801067d2 <vector83>:
.globl vector83
vector83:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $83
801067d4:	6a 53                	push   $0x53
  jmp alltraps
801067d6:	e9 2c f8 ff ff       	jmp    80106007 <alltraps>

801067db <vector84>:
.globl vector84
vector84:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $84
801067dd:	6a 54                	push   $0x54
  jmp alltraps
801067df:	e9 23 f8 ff ff       	jmp    80106007 <alltraps>

801067e4 <vector85>:
.globl vector85
vector85:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $85
801067e6:	6a 55                	push   $0x55
  jmp alltraps
801067e8:	e9 1a f8 ff ff       	jmp    80106007 <alltraps>

801067ed <vector86>:
.globl vector86
vector86:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $86
801067ef:	6a 56                	push   $0x56
  jmp alltraps
801067f1:	e9 11 f8 ff ff       	jmp    80106007 <alltraps>

801067f6 <vector87>:
.globl vector87
vector87:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $87
801067f8:	6a 57                	push   $0x57
  jmp alltraps
801067fa:	e9 08 f8 ff ff       	jmp    80106007 <alltraps>

801067ff <vector88>:
.globl vector88
vector88:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $88
80106801:	6a 58                	push   $0x58
  jmp alltraps
80106803:	e9 ff f7 ff ff       	jmp    80106007 <alltraps>

80106808 <vector89>:
.globl vector89
vector89:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $89
8010680a:	6a 59                	push   $0x59
  jmp alltraps
8010680c:	e9 f6 f7 ff ff       	jmp    80106007 <alltraps>

80106811 <vector90>:
.globl vector90
vector90:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $90
80106813:	6a 5a                	push   $0x5a
  jmp alltraps
80106815:	e9 ed f7 ff ff       	jmp    80106007 <alltraps>

8010681a <vector91>:
.globl vector91
vector91:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $91
8010681c:	6a 5b                	push   $0x5b
  jmp alltraps
8010681e:	e9 e4 f7 ff ff       	jmp    80106007 <alltraps>

80106823 <vector92>:
.globl vector92
vector92:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $92
80106825:	6a 5c                	push   $0x5c
  jmp alltraps
80106827:	e9 db f7 ff ff       	jmp    80106007 <alltraps>

8010682c <vector93>:
.globl vector93
vector93:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $93
8010682e:	6a 5d                	push   $0x5d
  jmp alltraps
80106830:	e9 d2 f7 ff ff       	jmp    80106007 <alltraps>

80106835 <vector94>:
.globl vector94
vector94:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $94
80106837:	6a 5e                	push   $0x5e
  jmp alltraps
80106839:	e9 c9 f7 ff ff       	jmp    80106007 <alltraps>

8010683e <vector95>:
.globl vector95
vector95:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $95
80106840:	6a 5f                	push   $0x5f
  jmp alltraps
80106842:	e9 c0 f7 ff ff       	jmp    80106007 <alltraps>

80106847 <vector96>:
.globl vector96
vector96:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $96
80106849:	6a 60                	push   $0x60
  jmp alltraps
8010684b:	e9 b7 f7 ff ff       	jmp    80106007 <alltraps>

80106850 <vector97>:
.globl vector97
vector97:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $97
80106852:	6a 61                	push   $0x61
  jmp alltraps
80106854:	e9 ae f7 ff ff       	jmp    80106007 <alltraps>

80106859 <vector98>:
.globl vector98
vector98:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $98
8010685b:	6a 62                	push   $0x62
  jmp alltraps
8010685d:	e9 a5 f7 ff ff       	jmp    80106007 <alltraps>

80106862 <vector99>:
.globl vector99
vector99:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $99
80106864:	6a 63                	push   $0x63
  jmp alltraps
80106866:	e9 9c f7 ff ff       	jmp    80106007 <alltraps>

8010686b <vector100>:
.globl vector100
vector100:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $100
8010686d:	6a 64                	push   $0x64
  jmp alltraps
8010686f:	e9 93 f7 ff ff       	jmp    80106007 <alltraps>

80106874 <vector101>:
.globl vector101
vector101:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $101
80106876:	6a 65                	push   $0x65
  jmp alltraps
80106878:	e9 8a f7 ff ff       	jmp    80106007 <alltraps>

8010687d <vector102>:
.globl vector102
vector102:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $102
8010687f:	6a 66                	push   $0x66
  jmp alltraps
80106881:	e9 81 f7 ff ff       	jmp    80106007 <alltraps>

80106886 <vector103>:
.globl vector103
vector103:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $103
80106888:	6a 67                	push   $0x67
  jmp alltraps
8010688a:	e9 78 f7 ff ff       	jmp    80106007 <alltraps>

8010688f <vector104>:
.globl vector104
vector104:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $104
80106891:	6a 68                	push   $0x68
  jmp alltraps
80106893:	e9 6f f7 ff ff       	jmp    80106007 <alltraps>

80106898 <vector105>:
.globl vector105
vector105:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $105
8010689a:	6a 69                	push   $0x69
  jmp alltraps
8010689c:	e9 66 f7 ff ff       	jmp    80106007 <alltraps>

801068a1 <vector106>:
.globl vector106
vector106:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $106
801068a3:	6a 6a                	push   $0x6a
  jmp alltraps
801068a5:	e9 5d f7 ff ff       	jmp    80106007 <alltraps>

801068aa <vector107>:
.globl vector107
vector107:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $107
801068ac:	6a 6b                	push   $0x6b
  jmp alltraps
801068ae:	e9 54 f7 ff ff       	jmp    80106007 <alltraps>

801068b3 <vector108>:
.globl vector108
vector108:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $108
801068b5:	6a 6c                	push   $0x6c
  jmp alltraps
801068b7:	e9 4b f7 ff ff       	jmp    80106007 <alltraps>

801068bc <vector109>:
.globl vector109
vector109:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $109
801068be:	6a 6d                	push   $0x6d
  jmp alltraps
801068c0:	e9 42 f7 ff ff       	jmp    80106007 <alltraps>

801068c5 <vector110>:
.globl vector110
vector110:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $110
801068c7:	6a 6e                	push   $0x6e
  jmp alltraps
801068c9:	e9 39 f7 ff ff       	jmp    80106007 <alltraps>

801068ce <vector111>:
.globl vector111
vector111:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $111
801068d0:	6a 6f                	push   $0x6f
  jmp alltraps
801068d2:	e9 30 f7 ff ff       	jmp    80106007 <alltraps>

801068d7 <vector112>:
.globl vector112
vector112:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $112
801068d9:	6a 70                	push   $0x70
  jmp alltraps
801068db:	e9 27 f7 ff ff       	jmp    80106007 <alltraps>

801068e0 <vector113>:
.globl vector113
vector113:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $113
801068e2:	6a 71                	push   $0x71
  jmp alltraps
801068e4:	e9 1e f7 ff ff       	jmp    80106007 <alltraps>

801068e9 <vector114>:
.globl vector114
vector114:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $114
801068eb:	6a 72                	push   $0x72
  jmp alltraps
801068ed:	e9 15 f7 ff ff       	jmp    80106007 <alltraps>

801068f2 <vector115>:
.globl vector115
vector115:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $115
801068f4:	6a 73                	push   $0x73
  jmp alltraps
801068f6:	e9 0c f7 ff ff       	jmp    80106007 <alltraps>

801068fb <vector116>:
.globl vector116
vector116:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $116
801068fd:	6a 74                	push   $0x74
  jmp alltraps
801068ff:	e9 03 f7 ff ff       	jmp    80106007 <alltraps>

80106904 <vector117>:
.globl vector117
vector117:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $117
80106906:	6a 75                	push   $0x75
  jmp alltraps
80106908:	e9 fa f6 ff ff       	jmp    80106007 <alltraps>

8010690d <vector118>:
.globl vector118
vector118:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $118
8010690f:	6a 76                	push   $0x76
  jmp alltraps
80106911:	e9 f1 f6 ff ff       	jmp    80106007 <alltraps>

80106916 <vector119>:
.globl vector119
vector119:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $119
80106918:	6a 77                	push   $0x77
  jmp alltraps
8010691a:	e9 e8 f6 ff ff       	jmp    80106007 <alltraps>

8010691f <vector120>:
.globl vector120
vector120:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $120
80106921:	6a 78                	push   $0x78
  jmp alltraps
80106923:	e9 df f6 ff ff       	jmp    80106007 <alltraps>

80106928 <vector121>:
.globl vector121
vector121:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $121
8010692a:	6a 79                	push   $0x79
  jmp alltraps
8010692c:	e9 d6 f6 ff ff       	jmp    80106007 <alltraps>

80106931 <vector122>:
.globl vector122
vector122:
  pushl $0
80106931:	6a 00                	push   $0x0
  pushl $122
80106933:	6a 7a                	push   $0x7a
  jmp alltraps
80106935:	e9 cd f6 ff ff       	jmp    80106007 <alltraps>

8010693a <vector123>:
.globl vector123
vector123:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $123
8010693c:	6a 7b                	push   $0x7b
  jmp alltraps
8010693e:	e9 c4 f6 ff ff       	jmp    80106007 <alltraps>

80106943 <vector124>:
.globl vector124
vector124:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $124
80106945:	6a 7c                	push   $0x7c
  jmp alltraps
80106947:	e9 bb f6 ff ff       	jmp    80106007 <alltraps>

8010694c <vector125>:
.globl vector125
vector125:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $125
8010694e:	6a 7d                	push   $0x7d
  jmp alltraps
80106950:	e9 b2 f6 ff ff       	jmp    80106007 <alltraps>

80106955 <vector126>:
.globl vector126
vector126:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $126
80106957:	6a 7e                	push   $0x7e
  jmp alltraps
80106959:	e9 a9 f6 ff ff       	jmp    80106007 <alltraps>

8010695e <vector127>:
.globl vector127
vector127:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $127
80106960:	6a 7f                	push   $0x7f
  jmp alltraps
80106962:	e9 a0 f6 ff ff       	jmp    80106007 <alltraps>

80106967 <vector128>:
.globl vector128
vector128:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $128
80106969:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010696e:	e9 94 f6 ff ff       	jmp    80106007 <alltraps>

80106973 <vector129>:
.globl vector129
vector129:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $129
80106975:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010697a:	e9 88 f6 ff ff       	jmp    80106007 <alltraps>

8010697f <vector130>:
.globl vector130
vector130:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $130
80106981:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106986:	e9 7c f6 ff ff       	jmp    80106007 <alltraps>

8010698b <vector131>:
.globl vector131
vector131:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $131
8010698d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106992:	e9 70 f6 ff ff       	jmp    80106007 <alltraps>

80106997 <vector132>:
.globl vector132
vector132:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $132
80106999:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010699e:	e9 64 f6 ff ff       	jmp    80106007 <alltraps>

801069a3 <vector133>:
.globl vector133
vector133:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $133
801069a5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801069aa:	e9 58 f6 ff ff       	jmp    80106007 <alltraps>

801069af <vector134>:
.globl vector134
vector134:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $134
801069b1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801069b6:	e9 4c f6 ff ff       	jmp    80106007 <alltraps>

801069bb <vector135>:
.globl vector135
vector135:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $135
801069bd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801069c2:	e9 40 f6 ff ff       	jmp    80106007 <alltraps>

801069c7 <vector136>:
.globl vector136
vector136:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $136
801069c9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801069ce:	e9 34 f6 ff ff       	jmp    80106007 <alltraps>

801069d3 <vector137>:
.globl vector137
vector137:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $137
801069d5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801069da:	e9 28 f6 ff ff       	jmp    80106007 <alltraps>

801069df <vector138>:
.globl vector138
vector138:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $138
801069e1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801069e6:	e9 1c f6 ff ff       	jmp    80106007 <alltraps>

801069eb <vector139>:
.globl vector139
vector139:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $139
801069ed:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801069f2:	e9 10 f6 ff ff       	jmp    80106007 <alltraps>

801069f7 <vector140>:
.globl vector140
vector140:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $140
801069f9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801069fe:	e9 04 f6 ff ff       	jmp    80106007 <alltraps>

80106a03 <vector141>:
.globl vector141
vector141:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $141
80106a05:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106a0a:	e9 f8 f5 ff ff       	jmp    80106007 <alltraps>

80106a0f <vector142>:
.globl vector142
vector142:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $142
80106a11:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106a16:	e9 ec f5 ff ff       	jmp    80106007 <alltraps>

80106a1b <vector143>:
.globl vector143
vector143:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $143
80106a1d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106a22:	e9 e0 f5 ff ff       	jmp    80106007 <alltraps>

80106a27 <vector144>:
.globl vector144
vector144:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $144
80106a29:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106a2e:	e9 d4 f5 ff ff       	jmp    80106007 <alltraps>

80106a33 <vector145>:
.globl vector145
vector145:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $145
80106a35:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106a3a:	e9 c8 f5 ff ff       	jmp    80106007 <alltraps>

80106a3f <vector146>:
.globl vector146
vector146:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $146
80106a41:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a46:	e9 bc f5 ff ff       	jmp    80106007 <alltraps>

80106a4b <vector147>:
.globl vector147
vector147:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $147
80106a4d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106a52:	e9 b0 f5 ff ff       	jmp    80106007 <alltraps>

80106a57 <vector148>:
.globl vector148
vector148:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $148
80106a59:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106a5e:	e9 a4 f5 ff ff       	jmp    80106007 <alltraps>

80106a63 <vector149>:
.globl vector149
vector149:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $149
80106a65:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106a6a:	e9 98 f5 ff ff       	jmp    80106007 <alltraps>

80106a6f <vector150>:
.globl vector150
vector150:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $150
80106a71:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106a76:	e9 8c f5 ff ff       	jmp    80106007 <alltraps>

80106a7b <vector151>:
.globl vector151
vector151:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $151
80106a7d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a82:	e9 80 f5 ff ff       	jmp    80106007 <alltraps>

80106a87 <vector152>:
.globl vector152
vector152:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $152
80106a89:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a8e:	e9 74 f5 ff ff       	jmp    80106007 <alltraps>

80106a93 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $153
80106a95:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a9a:	e9 68 f5 ff ff       	jmp    80106007 <alltraps>

80106a9f <vector154>:
.globl vector154
vector154:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $154
80106aa1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106aa6:	e9 5c f5 ff ff       	jmp    80106007 <alltraps>

80106aab <vector155>:
.globl vector155
vector155:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $155
80106aad:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ab2:	e9 50 f5 ff ff       	jmp    80106007 <alltraps>

80106ab7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $156
80106ab9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106abe:	e9 44 f5 ff ff       	jmp    80106007 <alltraps>

80106ac3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $157
80106ac5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106aca:	e9 38 f5 ff ff       	jmp    80106007 <alltraps>

80106acf <vector158>:
.globl vector158
vector158:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $158
80106ad1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ad6:	e9 2c f5 ff ff       	jmp    80106007 <alltraps>

80106adb <vector159>:
.globl vector159
vector159:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $159
80106add:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ae2:	e9 20 f5 ff ff       	jmp    80106007 <alltraps>

80106ae7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $160
80106ae9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106aee:	e9 14 f5 ff ff       	jmp    80106007 <alltraps>

80106af3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $161
80106af5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106afa:	e9 08 f5 ff ff       	jmp    80106007 <alltraps>

80106aff <vector162>:
.globl vector162
vector162:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $162
80106b01:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106b06:	e9 fc f4 ff ff       	jmp    80106007 <alltraps>

80106b0b <vector163>:
.globl vector163
vector163:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $163
80106b0d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106b12:	e9 f0 f4 ff ff       	jmp    80106007 <alltraps>

80106b17 <vector164>:
.globl vector164
vector164:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $164
80106b19:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106b1e:	e9 e4 f4 ff ff       	jmp    80106007 <alltraps>

80106b23 <vector165>:
.globl vector165
vector165:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $165
80106b25:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106b2a:	e9 d8 f4 ff ff       	jmp    80106007 <alltraps>

80106b2f <vector166>:
.globl vector166
vector166:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $166
80106b31:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106b36:	e9 cc f4 ff ff       	jmp    80106007 <alltraps>

80106b3b <vector167>:
.globl vector167
vector167:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $167
80106b3d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b42:	e9 c0 f4 ff ff       	jmp    80106007 <alltraps>

80106b47 <vector168>:
.globl vector168
vector168:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $168
80106b49:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106b4e:	e9 b4 f4 ff ff       	jmp    80106007 <alltraps>

80106b53 <vector169>:
.globl vector169
vector169:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $169
80106b55:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106b5a:	e9 a8 f4 ff ff       	jmp    80106007 <alltraps>

80106b5f <vector170>:
.globl vector170
vector170:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $170
80106b61:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106b66:	e9 9c f4 ff ff       	jmp    80106007 <alltraps>

80106b6b <vector171>:
.globl vector171
vector171:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $171
80106b6d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106b72:	e9 90 f4 ff ff       	jmp    80106007 <alltraps>

80106b77 <vector172>:
.globl vector172
vector172:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $172
80106b79:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106b7e:	e9 84 f4 ff ff       	jmp    80106007 <alltraps>

80106b83 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $173
80106b85:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b8a:	e9 78 f4 ff ff       	jmp    80106007 <alltraps>

80106b8f <vector174>:
.globl vector174
vector174:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $174
80106b91:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b96:	e9 6c f4 ff ff       	jmp    80106007 <alltraps>

80106b9b <vector175>:
.globl vector175
vector175:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $175
80106b9d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106ba2:	e9 60 f4 ff ff       	jmp    80106007 <alltraps>

80106ba7 <vector176>:
.globl vector176
vector176:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $176
80106ba9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106bae:	e9 54 f4 ff ff       	jmp    80106007 <alltraps>

80106bb3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $177
80106bb5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106bba:	e9 48 f4 ff ff       	jmp    80106007 <alltraps>

80106bbf <vector178>:
.globl vector178
vector178:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $178
80106bc1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106bc6:	e9 3c f4 ff ff       	jmp    80106007 <alltraps>

80106bcb <vector179>:
.globl vector179
vector179:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $179
80106bcd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106bd2:	e9 30 f4 ff ff       	jmp    80106007 <alltraps>

80106bd7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $180
80106bd9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106bde:	e9 24 f4 ff ff       	jmp    80106007 <alltraps>

80106be3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $181
80106be5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106bea:	e9 18 f4 ff ff       	jmp    80106007 <alltraps>

80106bef <vector182>:
.globl vector182
vector182:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $182
80106bf1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106bf6:	e9 0c f4 ff ff       	jmp    80106007 <alltraps>

80106bfb <vector183>:
.globl vector183
vector183:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $183
80106bfd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106c02:	e9 00 f4 ff ff       	jmp    80106007 <alltraps>

80106c07 <vector184>:
.globl vector184
vector184:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $184
80106c09:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106c0e:	e9 f4 f3 ff ff       	jmp    80106007 <alltraps>

80106c13 <vector185>:
.globl vector185
vector185:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $185
80106c15:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106c1a:	e9 e8 f3 ff ff       	jmp    80106007 <alltraps>

80106c1f <vector186>:
.globl vector186
vector186:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $186
80106c21:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106c26:	e9 dc f3 ff ff       	jmp    80106007 <alltraps>

80106c2b <vector187>:
.globl vector187
vector187:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $187
80106c2d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106c32:	e9 d0 f3 ff ff       	jmp    80106007 <alltraps>

80106c37 <vector188>:
.globl vector188
vector188:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $188
80106c39:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106c3e:	e9 c4 f3 ff ff       	jmp    80106007 <alltraps>

80106c43 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $189
80106c45:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c4a:	e9 b8 f3 ff ff       	jmp    80106007 <alltraps>

80106c4f <vector190>:
.globl vector190
vector190:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $190
80106c51:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106c56:	e9 ac f3 ff ff       	jmp    80106007 <alltraps>

80106c5b <vector191>:
.globl vector191
vector191:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $191
80106c5d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106c62:	e9 a0 f3 ff ff       	jmp    80106007 <alltraps>

80106c67 <vector192>:
.globl vector192
vector192:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $192
80106c69:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106c6e:	e9 94 f3 ff ff       	jmp    80106007 <alltraps>

80106c73 <vector193>:
.globl vector193
vector193:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $193
80106c75:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106c7a:	e9 88 f3 ff ff       	jmp    80106007 <alltraps>

80106c7f <vector194>:
.globl vector194
vector194:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $194
80106c81:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c86:	e9 7c f3 ff ff       	jmp    80106007 <alltraps>

80106c8b <vector195>:
.globl vector195
vector195:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $195
80106c8d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c92:	e9 70 f3 ff ff       	jmp    80106007 <alltraps>

80106c97 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $196
80106c99:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c9e:	e9 64 f3 ff ff       	jmp    80106007 <alltraps>

80106ca3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $197
80106ca5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106caa:	e9 58 f3 ff ff       	jmp    80106007 <alltraps>

80106caf <vector198>:
.globl vector198
vector198:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $198
80106cb1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106cb6:	e9 4c f3 ff ff       	jmp    80106007 <alltraps>

80106cbb <vector199>:
.globl vector199
vector199:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $199
80106cbd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106cc2:	e9 40 f3 ff ff       	jmp    80106007 <alltraps>

80106cc7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $200
80106cc9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106cce:	e9 34 f3 ff ff       	jmp    80106007 <alltraps>

80106cd3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $201
80106cd5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106cda:	e9 28 f3 ff ff       	jmp    80106007 <alltraps>

80106cdf <vector202>:
.globl vector202
vector202:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $202
80106ce1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ce6:	e9 1c f3 ff ff       	jmp    80106007 <alltraps>

80106ceb <vector203>:
.globl vector203
vector203:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $203
80106ced:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106cf2:	e9 10 f3 ff ff       	jmp    80106007 <alltraps>

80106cf7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $204
80106cf9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106cfe:	e9 04 f3 ff ff       	jmp    80106007 <alltraps>

80106d03 <vector205>:
.globl vector205
vector205:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $205
80106d05:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106d0a:	e9 f8 f2 ff ff       	jmp    80106007 <alltraps>

80106d0f <vector206>:
.globl vector206
vector206:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $206
80106d11:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106d16:	e9 ec f2 ff ff       	jmp    80106007 <alltraps>

80106d1b <vector207>:
.globl vector207
vector207:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $207
80106d1d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106d22:	e9 e0 f2 ff ff       	jmp    80106007 <alltraps>

80106d27 <vector208>:
.globl vector208
vector208:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $208
80106d29:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106d2e:	e9 d4 f2 ff ff       	jmp    80106007 <alltraps>

80106d33 <vector209>:
.globl vector209
vector209:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $209
80106d35:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106d3a:	e9 c8 f2 ff ff       	jmp    80106007 <alltraps>

80106d3f <vector210>:
.globl vector210
vector210:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $210
80106d41:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d46:	e9 bc f2 ff ff       	jmp    80106007 <alltraps>

80106d4b <vector211>:
.globl vector211
vector211:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $211
80106d4d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106d52:	e9 b0 f2 ff ff       	jmp    80106007 <alltraps>

80106d57 <vector212>:
.globl vector212
vector212:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $212
80106d59:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106d5e:	e9 a4 f2 ff ff       	jmp    80106007 <alltraps>

80106d63 <vector213>:
.globl vector213
vector213:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $213
80106d65:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106d6a:	e9 98 f2 ff ff       	jmp    80106007 <alltraps>

80106d6f <vector214>:
.globl vector214
vector214:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $214
80106d71:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106d76:	e9 8c f2 ff ff       	jmp    80106007 <alltraps>

80106d7b <vector215>:
.globl vector215
vector215:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $215
80106d7d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d82:	e9 80 f2 ff ff       	jmp    80106007 <alltraps>

80106d87 <vector216>:
.globl vector216
vector216:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $216
80106d89:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d8e:	e9 74 f2 ff ff       	jmp    80106007 <alltraps>

80106d93 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $217
80106d95:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d9a:	e9 68 f2 ff ff       	jmp    80106007 <alltraps>

80106d9f <vector218>:
.globl vector218
vector218:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $218
80106da1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106da6:	e9 5c f2 ff ff       	jmp    80106007 <alltraps>

80106dab <vector219>:
.globl vector219
vector219:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $219
80106dad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106db2:	e9 50 f2 ff ff       	jmp    80106007 <alltraps>

80106db7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $220
80106db9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106dbe:	e9 44 f2 ff ff       	jmp    80106007 <alltraps>

80106dc3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $221
80106dc5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106dca:	e9 38 f2 ff ff       	jmp    80106007 <alltraps>

80106dcf <vector222>:
.globl vector222
vector222:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $222
80106dd1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106dd6:	e9 2c f2 ff ff       	jmp    80106007 <alltraps>

80106ddb <vector223>:
.globl vector223
vector223:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $223
80106ddd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106de2:	e9 20 f2 ff ff       	jmp    80106007 <alltraps>

80106de7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $224
80106de9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106dee:	e9 14 f2 ff ff       	jmp    80106007 <alltraps>

80106df3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $225
80106df5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106dfa:	e9 08 f2 ff ff       	jmp    80106007 <alltraps>

80106dff <vector226>:
.globl vector226
vector226:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $226
80106e01:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106e06:	e9 fc f1 ff ff       	jmp    80106007 <alltraps>

80106e0b <vector227>:
.globl vector227
vector227:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $227
80106e0d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106e12:	e9 f0 f1 ff ff       	jmp    80106007 <alltraps>

80106e17 <vector228>:
.globl vector228
vector228:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $228
80106e19:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106e1e:	e9 e4 f1 ff ff       	jmp    80106007 <alltraps>

80106e23 <vector229>:
.globl vector229
vector229:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $229
80106e25:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106e2a:	e9 d8 f1 ff ff       	jmp    80106007 <alltraps>

80106e2f <vector230>:
.globl vector230
vector230:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $230
80106e31:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106e36:	e9 cc f1 ff ff       	jmp    80106007 <alltraps>

80106e3b <vector231>:
.globl vector231
vector231:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $231
80106e3d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e42:	e9 c0 f1 ff ff       	jmp    80106007 <alltraps>

80106e47 <vector232>:
.globl vector232
vector232:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $232
80106e49:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106e4e:	e9 b4 f1 ff ff       	jmp    80106007 <alltraps>

80106e53 <vector233>:
.globl vector233
vector233:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $233
80106e55:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106e5a:	e9 a8 f1 ff ff       	jmp    80106007 <alltraps>

80106e5f <vector234>:
.globl vector234
vector234:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $234
80106e61:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106e66:	e9 9c f1 ff ff       	jmp    80106007 <alltraps>

80106e6b <vector235>:
.globl vector235
vector235:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $235
80106e6d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106e72:	e9 90 f1 ff ff       	jmp    80106007 <alltraps>

80106e77 <vector236>:
.globl vector236
vector236:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $236
80106e79:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106e7e:	e9 84 f1 ff ff       	jmp    80106007 <alltraps>

80106e83 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $237
80106e85:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e8a:	e9 78 f1 ff ff       	jmp    80106007 <alltraps>

80106e8f <vector238>:
.globl vector238
vector238:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $238
80106e91:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e96:	e9 6c f1 ff ff       	jmp    80106007 <alltraps>

80106e9b <vector239>:
.globl vector239
vector239:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $239
80106e9d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ea2:	e9 60 f1 ff ff       	jmp    80106007 <alltraps>

80106ea7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $240
80106ea9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106eae:	e9 54 f1 ff ff       	jmp    80106007 <alltraps>

80106eb3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $241
80106eb5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106eba:	e9 48 f1 ff ff       	jmp    80106007 <alltraps>

80106ebf <vector242>:
.globl vector242
vector242:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $242
80106ec1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106ec6:	e9 3c f1 ff ff       	jmp    80106007 <alltraps>

80106ecb <vector243>:
.globl vector243
vector243:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $243
80106ecd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ed2:	e9 30 f1 ff ff       	jmp    80106007 <alltraps>

80106ed7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $244
80106ed9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106ede:	e9 24 f1 ff ff       	jmp    80106007 <alltraps>

80106ee3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $245
80106ee5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106eea:	e9 18 f1 ff ff       	jmp    80106007 <alltraps>

80106eef <vector246>:
.globl vector246
vector246:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $246
80106ef1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106ef6:	e9 0c f1 ff ff       	jmp    80106007 <alltraps>

80106efb <vector247>:
.globl vector247
vector247:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $247
80106efd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106f02:	e9 00 f1 ff ff       	jmp    80106007 <alltraps>

80106f07 <vector248>:
.globl vector248
vector248:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $248
80106f09:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106f0e:	e9 f4 f0 ff ff       	jmp    80106007 <alltraps>

80106f13 <vector249>:
.globl vector249
vector249:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $249
80106f15:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106f1a:	e9 e8 f0 ff ff       	jmp    80106007 <alltraps>

80106f1f <vector250>:
.globl vector250
vector250:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $250
80106f21:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106f26:	e9 dc f0 ff ff       	jmp    80106007 <alltraps>

80106f2b <vector251>:
.globl vector251
vector251:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $251
80106f2d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106f32:	e9 d0 f0 ff ff       	jmp    80106007 <alltraps>

80106f37 <vector252>:
.globl vector252
vector252:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $252
80106f39:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106f3e:	e9 c4 f0 ff ff       	jmp    80106007 <alltraps>

80106f43 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $253
80106f45:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f4a:	e9 b8 f0 ff ff       	jmp    80106007 <alltraps>

80106f4f <vector254>:
.globl vector254
vector254:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $254
80106f51:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106f56:	e9 ac f0 ff ff       	jmp    80106007 <alltraps>

80106f5b <vector255>:
.globl vector255
vector255:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $255
80106f5d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106f62:	e9 a0 f0 ff ff       	jmp    80106007 <alltraps>
80106f67:	66 90                	xchg   %ax,%ax
80106f69:	66 90                	xchg   %ax,%ax
80106f6b:	66 90                	xchg   %ax,%ax
80106f6d:	66 90                	xchg   %ax,%ax
80106f6f:	90                   	nop

80106f70 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	57                   	push   %edi
80106f74:	56                   	push   %esi
80106f75:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106f76:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106f7c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f82:	83 ec 1c             	sub    $0x1c,%esp
80106f85:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106f88:	39 d3                	cmp    %edx,%ebx
80106f8a:	73 49                	jae    80106fd5 <deallocuvm.part.0+0x65>
80106f8c:	89 c7                	mov    %eax,%edi
80106f8e:	eb 0c                	jmp    80106f9c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f90:	83 c0 01             	add    $0x1,%eax
80106f93:	c1 e0 16             	shl    $0x16,%eax
80106f96:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f98:	39 da                	cmp    %ebx,%edx
80106f9a:	76 39                	jbe    80106fd5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80106f9c:	89 d8                	mov    %ebx,%eax
80106f9e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106fa1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106fa4:	f6 c1 01             	test   $0x1,%cl
80106fa7:	74 e7                	je     80106f90 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106fa9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fab:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106fb1:	c1 ee 0a             	shr    $0xa,%esi
80106fb4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106fba:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106fc1:	85 f6                	test   %esi,%esi
80106fc3:	74 cb                	je     80106f90 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106fc5:	8b 06                	mov    (%esi),%eax
80106fc7:	a8 01                	test   $0x1,%al
80106fc9:	75 15                	jne    80106fe0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106fcb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fd1:	39 da                	cmp    %ebx,%edx
80106fd3:	77 c7                	ja     80106f9c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106fd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fdb:	5b                   	pop    %ebx
80106fdc:	5e                   	pop    %esi
80106fdd:	5f                   	pop    %edi
80106fde:	5d                   	pop    %ebp
80106fdf:	c3                   	ret    
      if(pa == 0)
80106fe0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fe5:	74 25                	je     8010700c <deallocuvm.part.0+0x9c>
      kfree(v);
80106fe7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106fea:	05 00 00 00 80       	add    $0x80000000,%eax
80106fef:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106ff2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106ff8:	50                   	push   %eax
80106ff9:	e8 c2 b4 ff ff       	call   801024c0 <kfree>
      *pte = 0;
80106ffe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107004:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107007:	83 c4 10             	add    $0x10,%esp
8010700a:	eb 8c                	jmp    80106f98 <deallocuvm.part.0+0x28>
        panic("kfree");
8010700c:	83 ec 0c             	sub    $0xc,%esp
8010700f:	68 c6 7b 10 80       	push   $0x80107bc6
80107014:	e8 67 93 ff ff       	call   80100380 <panic>
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107020 <mappages>:
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107026:	89 d3                	mov    %edx,%ebx
80107028:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010702e:	83 ec 1c             	sub    $0x1c,%esp
80107031:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107034:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107038:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010703d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107040:	8b 45 08             	mov    0x8(%ebp),%eax
80107043:	29 d8                	sub    %ebx,%eax
80107045:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107048:	eb 3d                	jmp    80107087 <mappages+0x67>
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107050:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107057:	c1 ea 0a             	shr    $0xa,%edx
8010705a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107060:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107067:	85 c0                	test   %eax,%eax
80107069:	74 75                	je     801070e0 <mappages+0xc0>
    if(*pte & PTE_P)
8010706b:	f6 00 01             	testb  $0x1,(%eax)
8010706e:	0f 85 86 00 00 00    	jne    801070fa <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107074:	0b 75 0c             	or     0xc(%ebp),%esi
80107077:	83 ce 01             	or     $0x1,%esi
8010707a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010707c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010707f:	74 6f                	je     801070f0 <mappages+0xd0>
    a += PGSIZE;
80107081:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107087:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010708a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010708d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107090:	89 d8                	mov    %ebx,%eax
80107092:	c1 e8 16             	shr    $0x16,%eax
80107095:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107098:	8b 07                	mov    (%edi),%eax
8010709a:	a8 01                	test   $0x1,%al
8010709c:	75 b2                	jne    80107050 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010709e:	e8 dd b5 ff ff       	call   80102680 <kalloc>
801070a3:	85 c0                	test   %eax,%eax
801070a5:	74 39                	je     801070e0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801070a7:	83 ec 04             	sub    $0x4,%esp
801070aa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801070ad:	68 00 10 00 00       	push   $0x1000
801070b2:	6a 00                	push   $0x0
801070b4:	50                   	push   %eax
801070b5:	e8 66 dc ff ff       	call   80104d20 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801070ba:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801070bd:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801070c0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801070c6:	83 c8 07             	or     $0x7,%eax
801070c9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801070cb:	89 d8                	mov    %ebx,%eax
801070cd:	c1 e8 0a             	shr    $0xa,%eax
801070d0:	25 fc 0f 00 00       	and    $0xffc,%eax
801070d5:	01 d0                	add    %edx,%eax
801070d7:	eb 92                	jmp    8010706b <mappages+0x4b>
801070d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801070e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070e8:	5b                   	pop    %ebx
801070e9:	5e                   	pop    %esi
801070ea:	5f                   	pop    %edi
801070eb:	5d                   	pop    %ebp
801070ec:	c3                   	ret    
801070ed:	8d 76 00             	lea    0x0(%esi),%esi
801070f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070f3:	31 c0                	xor    %eax,%eax
}
801070f5:	5b                   	pop    %ebx
801070f6:	5e                   	pop    %esi
801070f7:	5f                   	pop    %edi
801070f8:	5d                   	pop    %ebp
801070f9:	c3                   	ret    
      panic("remap");
801070fa:	83 ec 0c             	sub    $0xc,%esp
801070fd:	68 78 82 10 80       	push   $0x80108278
80107102:	e8 79 92 ff ff       	call   80100380 <panic>
80107107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010710e:	66 90                	xchg   %ax,%ax

80107110 <seginit>:
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107116:	e8 75 c9 ff ff       	call   80103a90 <cpuid>
  pd[0] = size-1;
8010711b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107120:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107126:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010712a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80107131:	ff 00 00 
80107134:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010713b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010713e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80107145:	ff 00 00 
80107148:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010714f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107152:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80107159:	ff 00 00 
8010715c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80107163:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107166:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
8010716d:	ff 00 00 
80107170:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80107177:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010717a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
8010717f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107183:	c1 e8 10             	shr    $0x10,%eax
80107186:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010718a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010718d:	0f 01 10             	lgdtl  (%eax)
}
80107190:	c9                   	leave  
80107191:	c3                   	ret    
80107192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071a0:	a1 e4 60 11 80       	mov    0x801160e4,%eax
801071a5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801071aa:	0f 22 d8             	mov    %eax,%cr3
}
801071ad:	c3                   	ret    
801071ae:	66 90                	xchg   %ax,%ax

801071b0 <switchuvm>:
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
801071b6:	83 ec 1c             	sub    $0x1c,%esp
801071b9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801071bc:	85 f6                	test   %esi,%esi
801071be:	0f 84 cb 00 00 00    	je     8010728f <switchuvm+0xdf>
  if(p->kstack == 0)
801071c4:	8b 46 08             	mov    0x8(%esi),%eax
801071c7:	85 c0                	test   %eax,%eax
801071c9:	0f 84 da 00 00 00    	je     801072a9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801071cf:	8b 46 04             	mov    0x4(%esi),%eax
801071d2:	85 c0                	test   %eax,%eax
801071d4:	0f 84 c2 00 00 00    	je     8010729c <switchuvm+0xec>
  pushcli();
801071da:	e8 21 d9 ff ff       	call   80104b00 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801071df:	e8 4c c8 ff ff       	call   80103a30 <mycpu>
801071e4:	89 c3                	mov    %eax,%ebx
801071e6:	e8 45 c8 ff ff       	call   80103a30 <mycpu>
801071eb:	89 c7                	mov    %eax,%edi
801071ed:	e8 3e c8 ff ff       	call   80103a30 <mycpu>
801071f2:	83 c7 08             	add    $0x8,%edi
801071f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071f8:	e8 33 c8 ff ff       	call   80103a30 <mycpu>
801071fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107200:	ba 67 00 00 00       	mov    $0x67,%edx
80107205:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010720c:	83 c0 08             	add    $0x8,%eax
8010720f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107216:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010721b:	83 c1 08             	add    $0x8,%ecx
8010721e:	c1 e8 18             	shr    $0x18,%eax
80107221:	c1 e9 10             	shr    $0x10,%ecx
80107224:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010722a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107230:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107235:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010723c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107241:	e8 ea c7 ff ff       	call   80103a30 <mycpu>
80107246:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010724d:	e8 de c7 ff ff       	call   80103a30 <mycpu>
80107252:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107256:	8b 5e 08             	mov    0x8(%esi),%ebx
80107259:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010725f:	e8 cc c7 ff ff       	call   80103a30 <mycpu>
80107264:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107267:	e8 c4 c7 ff ff       	call   80103a30 <mycpu>
8010726c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107270:	b8 28 00 00 00       	mov    $0x28,%eax
80107275:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107278:	8b 46 04             	mov    0x4(%esi),%eax
8010727b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107280:	0f 22 d8             	mov    %eax,%cr3
}
80107283:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107286:	5b                   	pop    %ebx
80107287:	5e                   	pop    %esi
80107288:	5f                   	pop    %edi
80107289:	5d                   	pop    %ebp
  popcli();
8010728a:	e9 c1 d8 ff ff       	jmp    80104b50 <popcli>
    panic("switchuvm: no process");
8010728f:	83 ec 0c             	sub    $0xc,%esp
80107292:	68 7e 82 10 80       	push   $0x8010827e
80107297:	e8 e4 90 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010729c:	83 ec 0c             	sub    $0xc,%esp
8010729f:	68 a9 82 10 80       	push   $0x801082a9
801072a4:	e8 d7 90 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
801072a9:	83 ec 0c             	sub    $0xc,%esp
801072ac:	68 94 82 10 80       	push   $0x80108294
801072b1:	e8 ca 90 ff ff       	call   80100380 <panic>
801072b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bd:	8d 76 00             	lea    0x0(%esi),%esi

801072c0 <inituvm>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	57                   	push   %edi
801072c4:	56                   	push   %esi
801072c5:	53                   	push   %ebx
801072c6:	83 ec 1c             	sub    $0x1c,%esp
801072c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801072cc:	8b 75 10             	mov    0x10(%ebp),%esi
801072cf:	8b 7d 08             	mov    0x8(%ebp),%edi
801072d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801072d5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801072db:	77 4b                	ja     80107328 <inituvm+0x68>
  mem = kalloc();
801072dd:	e8 9e b3 ff ff       	call   80102680 <kalloc>
  memset(mem, 0, PGSIZE);
801072e2:	83 ec 04             	sub    $0x4,%esp
801072e5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801072ea:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801072ec:	6a 00                	push   $0x0
801072ee:	50                   	push   %eax
801072ef:	e8 2c da ff ff       	call   80104d20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801072f4:	58                   	pop    %eax
801072f5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072fb:	5a                   	pop    %edx
801072fc:	6a 06                	push   $0x6
801072fe:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107303:	31 d2                	xor    %edx,%edx
80107305:	50                   	push   %eax
80107306:	89 f8                	mov    %edi,%eax
80107308:	e8 13 fd ff ff       	call   80107020 <mappages>
  memmove(mem, init, sz);
8010730d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107310:	89 75 10             	mov    %esi,0x10(%ebp)
80107313:	83 c4 10             	add    $0x10,%esp
80107316:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107319:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010731c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010731f:	5b                   	pop    %ebx
80107320:	5e                   	pop    %esi
80107321:	5f                   	pop    %edi
80107322:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107323:	e9 98 da ff ff       	jmp    80104dc0 <memmove>
    panic("inituvm: more than a page");
80107328:	83 ec 0c             	sub    $0xc,%esp
8010732b:	68 bd 82 10 80       	push   $0x801082bd
80107330:	e8 4b 90 ff ff       	call   80100380 <panic>
80107335:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107340 <loaduvm>:
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	53                   	push   %ebx
80107346:	83 ec 1c             	sub    $0x1c,%esp
80107349:	8b 45 0c             	mov    0xc(%ebp),%eax
8010734c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010734f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107354:	0f 85 bb 00 00 00    	jne    80107415 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010735a:	01 f0                	add    %esi,%eax
8010735c:	89 f3                	mov    %esi,%ebx
8010735e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107361:	8b 45 14             	mov    0x14(%ebp),%eax
80107364:	01 f0                	add    %esi,%eax
80107366:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107369:	85 f6                	test   %esi,%esi
8010736b:	0f 84 87 00 00 00    	je     801073f8 <loaduvm+0xb8>
80107371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107378:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010737b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010737e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107380:	89 c2                	mov    %eax,%edx
80107382:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107385:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107388:	f6 c2 01             	test   $0x1,%dl
8010738b:	75 13                	jne    801073a0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010738d:	83 ec 0c             	sub    $0xc,%esp
80107390:	68 d7 82 10 80       	push   $0x801082d7
80107395:	e8 e6 8f ff ff       	call   80100380 <panic>
8010739a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801073a0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073a3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801073a9:	25 fc 0f 00 00       	and    $0xffc,%eax
801073ae:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073b5:	85 c0                	test   %eax,%eax
801073b7:	74 d4                	je     8010738d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
801073b9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073bb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801073be:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801073c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801073c8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801073ce:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073d1:	29 d9                	sub    %ebx,%ecx
801073d3:	05 00 00 00 80       	add    $0x80000000,%eax
801073d8:	57                   	push   %edi
801073d9:	51                   	push   %ecx
801073da:	50                   	push   %eax
801073db:	ff 75 10             	push   0x10(%ebp)
801073de:	e8 ad a6 ff ff       	call   80101a90 <readi>
801073e3:	83 c4 10             	add    $0x10,%esp
801073e6:	39 f8                	cmp    %edi,%eax
801073e8:	75 1e                	jne    80107408 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801073ea:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073f0:	89 f0                	mov    %esi,%eax
801073f2:	29 d8                	sub    %ebx,%eax
801073f4:	39 c6                	cmp    %eax,%esi
801073f6:	77 80                	ja     80107378 <loaduvm+0x38>
}
801073f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073fb:	31 c0                	xor    %eax,%eax
}
801073fd:	5b                   	pop    %ebx
801073fe:	5e                   	pop    %esi
801073ff:	5f                   	pop    %edi
80107400:	5d                   	pop    %ebp
80107401:	c3                   	ret    
80107402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107408:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010740b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107410:	5b                   	pop    %ebx
80107411:	5e                   	pop    %esi
80107412:	5f                   	pop    %edi
80107413:	5d                   	pop    %ebp
80107414:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107415:	83 ec 0c             	sub    $0xc,%esp
80107418:	68 78 83 10 80       	push   $0x80108378
8010741d:	e8 5e 8f ff ff       	call   80100380 <panic>
80107422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107430 <allocuvm>:
{
80107430:	55                   	push   %ebp
80107431:	89 e5                	mov    %esp,%ebp
80107433:	57                   	push   %edi
80107434:	56                   	push   %esi
80107435:	53                   	push   %ebx
80107436:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107439:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010743c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010743f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107442:	85 c0                	test   %eax,%eax
80107444:	0f 88 b6 00 00 00    	js     80107500 <allocuvm+0xd0>
  if(newsz < oldsz)
8010744a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010744d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107450:	0f 82 9a 00 00 00    	jb     801074f0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107456:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010745c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107462:	39 75 10             	cmp    %esi,0x10(%ebp)
80107465:	77 44                	ja     801074ab <allocuvm+0x7b>
80107467:	e9 87 00 00 00       	jmp    801074f3 <allocuvm+0xc3>
8010746c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107470:	83 ec 04             	sub    $0x4,%esp
80107473:	68 00 10 00 00       	push   $0x1000
80107478:	6a 00                	push   $0x0
8010747a:	50                   	push   %eax
8010747b:	e8 a0 d8 ff ff       	call   80104d20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107480:	58                   	pop    %eax
80107481:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107487:	5a                   	pop    %edx
80107488:	6a 06                	push   $0x6
8010748a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010748f:	89 f2                	mov    %esi,%edx
80107491:	50                   	push   %eax
80107492:	89 f8                	mov    %edi,%eax
80107494:	e8 87 fb ff ff       	call   80107020 <mappages>
80107499:	83 c4 10             	add    $0x10,%esp
8010749c:	85 c0                	test   %eax,%eax
8010749e:	78 78                	js     80107518 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801074a0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074a6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074a9:	76 48                	jbe    801074f3 <allocuvm+0xc3>
    mem = kalloc();
801074ab:	e8 d0 b1 ff ff       	call   80102680 <kalloc>
801074b0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801074b2:	85 c0                	test   %eax,%eax
801074b4:	75 ba                	jne    80107470 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801074b6:	83 ec 0c             	sub    $0xc,%esp
801074b9:	68 f5 82 10 80       	push   $0x801082f5
801074be:	e8 dd 91 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
801074c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801074c6:	83 c4 10             	add    $0x10,%esp
801074c9:	39 45 10             	cmp    %eax,0x10(%ebp)
801074cc:	74 32                	je     80107500 <allocuvm+0xd0>
801074ce:	8b 55 10             	mov    0x10(%ebp),%edx
801074d1:	89 c1                	mov    %eax,%ecx
801074d3:	89 f8                	mov    %edi,%eax
801074d5:	e8 96 fa ff ff       	call   80106f70 <deallocuvm.part.0>
      return 0;
801074da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801074e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074e7:	5b                   	pop    %ebx
801074e8:	5e                   	pop    %esi
801074e9:	5f                   	pop    %edi
801074ea:	5d                   	pop    %ebp
801074eb:	c3                   	ret    
801074ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801074f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801074f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074f9:	5b                   	pop    %ebx
801074fa:	5e                   	pop    %esi
801074fb:	5f                   	pop    %edi
801074fc:	5d                   	pop    %ebp
801074fd:	c3                   	ret    
801074fe:	66 90                	xchg   %ax,%ax
    return 0;
80107500:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010750a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010750d:	5b                   	pop    %ebx
8010750e:	5e                   	pop    %esi
8010750f:	5f                   	pop    %edi
80107510:	5d                   	pop    %ebp
80107511:	c3                   	ret    
80107512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107518:	83 ec 0c             	sub    $0xc,%esp
8010751b:	68 0d 83 10 80       	push   $0x8010830d
80107520:	e8 7b 91 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107525:	8b 45 0c             	mov    0xc(%ebp),%eax
80107528:	83 c4 10             	add    $0x10,%esp
8010752b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010752e:	74 0c                	je     8010753c <allocuvm+0x10c>
80107530:	8b 55 10             	mov    0x10(%ebp),%edx
80107533:	89 c1                	mov    %eax,%ecx
80107535:	89 f8                	mov    %edi,%eax
80107537:	e8 34 fa ff ff       	call   80106f70 <deallocuvm.part.0>
      kfree(mem);
8010753c:	83 ec 0c             	sub    $0xc,%esp
8010753f:	53                   	push   %ebx
80107540:	e8 7b af ff ff       	call   801024c0 <kfree>
      return 0;
80107545:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010754c:	83 c4 10             	add    $0x10,%esp
}
8010754f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107552:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107555:	5b                   	pop    %ebx
80107556:	5e                   	pop    %esi
80107557:	5f                   	pop    %edi
80107558:	5d                   	pop    %ebp
80107559:	c3                   	ret    
8010755a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107560 <deallocuvm>:
{
80107560:	55                   	push   %ebp
80107561:	89 e5                	mov    %esp,%ebp
80107563:	8b 55 0c             	mov    0xc(%ebp),%edx
80107566:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107569:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010756c:	39 d1                	cmp    %edx,%ecx
8010756e:	73 10                	jae    80107580 <deallocuvm+0x20>
}
80107570:	5d                   	pop    %ebp
80107571:	e9 fa f9 ff ff       	jmp    80106f70 <deallocuvm.part.0>
80107576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010757d:	8d 76 00             	lea    0x0(%esi),%esi
80107580:	89 d0                	mov    %edx,%eax
80107582:	5d                   	pop    %ebp
80107583:	c3                   	ret    
80107584:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010758b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010758f:	90                   	nop

80107590 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	57                   	push   %edi
80107594:	56                   	push   %esi
80107595:	53                   	push   %ebx
80107596:	83 ec 0c             	sub    $0xc,%esp
80107599:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010759c:	85 f6                	test   %esi,%esi
8010759e:	74 59                	je     801075f9 <freevm+0x69>
  if(newsz >= oldsz)
801075a0:	31 c9                	xor    %ecx,%ecx
801075a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801075a7:	89 f0                	mov    %esi,%eax
801075a9:	89 f3                	mov    %esi,%ebx
801075ab:	e8 c0 f9 ff ff       	call   80106f70 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801075b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801075b6:	eb 0f                	jmp    801075c7 <freevm+0x37>
801075b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075bf:	90                   	nop
801075c0:	83 c3 04             	add    $0x4,%ebx
801075c3:	39 df                	cmp    %ebx,%edi
801075c5:	74 23                	je     801075ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801075c7:	8b 03                	mov    (%ebx),%eax
801075c9:	a8 01                	test   $0x1,%al
801075cb:	74 f3                	je     801075c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801075cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801075d2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801075d5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801075d8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801075dd:	50                   	push   %eax
801075de:	e8 dd ae ff ff       	call   801024c0 <kfree>
801075e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801075e6:	39 df                	cmp    %ebx,%edi
801075e8:	75 dd                	jne    801075c7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801075ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801075ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075f0:	5b                   	pop    %ebx
801075f1:	5e                   	pop    %esi
801075f2:	5f                   	pop    %edi
801075f3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801075f4:	e9 c7 ae ff ff       	jmp    801024c0 <kfree>
    panic("freevm: no pgdir");
801075f9:	83 ec 0c             	sub    $0xc,%esp
801075fc:	68 29 83 10 80       	push   $0x80108329
80107601:	e8 7a 8d ff ff       	call   80100380 <panic>
80107606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010760d:	8d 76 00             	lea    0x0(%esi),%esi

80107610 <setupkvm>:
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	56                   	push   %esi
80107614:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107615:	e8 66 b0 ff ff       	call   80102680 <kalloc>
8010761a:	89 c6                	mov    %eax,%esi
8010761c:	85 c0                	test   %eax,%eax
8010761e:	74 42                	je     80107662 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107620:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107623:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107628:	68 00 10 00 00       	push   $0x1000
8010762d:	6a 00                	push   $0x0
8010762f:	50                   	push   %eax
80107630:	e8 eb d6 ff ff       	call   80104d20 <memset>
80107635:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107638:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010763b:	83 ec 08             	sub    $0x8,%esp
8010763e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107641:	ff 73 0c             	push   0xc(%ebx)
80107644:	8b 13                	mov    (%ebx),%edx
80107646:	50                   	push   %eax
80107647:	29 c1                	sub    %eax,%ecx
80107649:	89 f0                	mov    %esi,%eax
8010764b:	e8 d0 f9 ff ff       	call   80107020 <mappages>
80107650:	83 c4 10             	add    $0x10,%esp
80107653:	85 c0                	test   %eax,%eax
80107655:	78 19                	js     80107670 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107657:	83 c3 10             	add    $0x10,%ebx
8010765a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107660:	75 d6                	jne    80107638 <setupkvm+0x28>
}
80107662:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107665:	89 f0                	mov    %esi,%eax
80107667:	5b                   	pop    %ebx
80107668:	5e                   	pop    %esi
80107669:	5d                   	pop    %ebp
8010766a:	c3                   	ret    
8010766b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010766f:	90                   	nop
      freevm(pgdir);
80107670:	83 ec 0c             	sub    $0xc,%esp
80107673:	56                   	push   %esi
      return 0;
80107674:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107676:	e8 15 ff ff ff       	call   80107590 <freevm>
      return 0;
8010767b:	83 c4 10             	add    $0x10,%esp
}
8010767e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107681:	89 f0                	mov    %esi,%eax
80107683:	5b                   	pop    %ebx
80107684:	5e                   	pop    %esi
80107685:	5d                   	pop    %ebp
80107686:	c3                   	ret    
80107687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010768e:	66 90                	xchg   %ax,%ax

80107690 <kvmalloc>:
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107696:	e8 75 ff ff ff       	call   80107610 <setupkvm>
8010769b:	a3 e4 60 11 80       	mov    %eax,0x801160e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076a0:	05 00 00 00 80       	add    $0x80000000,%eax
801076a5:	0f 22 d8             	mov    %eax,%cr3
}
801076a8:	c9                   	leave  
801076a9:	c3                   	ret    
801076aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801076b0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	83 ec 08             	sub    $0x8,%esp
801076b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801076b9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801076bc:	89 c1                	mov    %eax,%ecx
801076be:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801076c1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801076c4:	f6 c2 01             	test   $0x1,%dl
801076c7:	75 17                	jne    801076e0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801076c9:	83 ec 0c             	sub    $0xc,%esp
801076cc:	68 3a 83 10 80       	push   $0x8010833a
801076d1:	e8 aa 8c ff ff       	call   80100380 <panic>
801076d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076dd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801076e0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076e3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801076e9:	25 fc 0f 00 00       	and    $0xffc,%eax
801076ee:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801076f5:	85 c0                	test   %eax,%eax
801076f7:	74 d0                	je     801076c9 <clearpteu+0x19>
  *pte &= ~PTE_U;
801076f9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801076fc:	c9                   	leave  
801076fd:	c3                   	ret    
801076fe:	66 90                	xchg   %ax,%ax

80107700 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	57                   	push   %edi
80107704:	56                   	push   %esi
80107705:	53                   	push   %ebx
80107706:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107709:	e8 02 ff ff ff       	call   80107610 <setupkvm>
8010770e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107711:	85 c0                	test   %eax,%eax
80107713:	0f 84 bd 00 00 00    	je     801077d6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107719:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010771c:	85 c9                	test   %ecx,%ecx
8010771e:	0f 84 b2 00 00 00    	je     801077d6 <copyuvm+0xd6>
80107724:	31 f6                	xor    %esi,%esi
80107726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010772d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107730:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107733:	89 f0                	mov    %esi,%eax
80107735:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107738:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010773b:	a8 01                	test   $0x1,%al
8010773d:	75 11                	jne    80107750 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010773f:	83 ec 0c             	sub    $0xc,%esp
80107742:	68 44 83 10 80       	push   $0x80108344
80107747:	e8 34 8c ff ff       	call   80100380 <panic>
8010774c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107750:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107752:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107757:	c1 ea 0a             	shr    $0xa,%edx
8010775a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107760:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107767:	85 c0                	test   %eax,%eax
80107769:	74 d4                	je     8010773f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010776b:	8b 00                	mov    (%eax),%eax
8010776d:	a8 01                	test   $0x1,%al
8010776f:	0f 84 9f 00 00 00    	je     80107814 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107775:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107777:	25 ff 0f 00 00       	and    $0xfff,%eax
8010777c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010777f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107785:	e8 f6 ae ff ff       	call   80102680 <kalloc>
8010778a:	89 c3                	mov    %eax,%ebx
8010778c:	85 c0                	test   %eax,%eax
8010778e:	74 64                	je     801077f4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107790:	83 ec 04             	sub    $0x4,%esp
80107793:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107799:	68 00 10 00 00       	push   $0x1000
8010779e:	57                   	push   %edi
8010779f:	50                   	push   %eax
801077a0:	e8 1b d6 ff ff       	call   80104dc0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801077a5:	58                   	pop    %eax
801077a6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801077ac:	5a                   	pop    %edx
801077ad:	ff 75 e4             	push   -0x1c(%ebp)
801077b0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077b5:	89 f2                	mov    %esi,%edx
801077b7:	50                   	push   %eax
801077b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077bb:	e8 60 f8 ff ff       	call   80107020 <mappages>
801077c0:	83 c4 10             	add    $0x10,%esp
801077c3:	85 c0                	test   %eax,%eax
801077c5:	78 21                	js     801077e8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801077c7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801077cd:	39 75 0c             	cmp    %esi,0xc(%ebp)
801077d0:	0f 87 5a ff ff ff    	ja     80107730 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801077d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077dc:	5b                   	pop    %ebx
801077dd:	5e                   	pop    %esi
801077de:	5f                   	pop    %edi
801077df:	5d                   	pop    %ebp
801077e0:	c3                   	ret    
801077e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801077e8:	83 ec 0c             	sub    $0xc,%esp
801077eb:	53                   	push   %ebx
801077ec:	e8 cf ac ff ff       	call   801024c0 <kfree>
      goto bad;
801077f1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801077f4:	83 ec 0c             	sub    $0xc,%esp
801077f7:	ff 75 e0             	push   -0x20(%ebp)
801077fa:	e8 91 fd ff ff       	call   80107590 <freevm>
  return 0;
801077ff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107806:	83 c4 10             	add    $0x10,%esp
}
80107809:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010780c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010780f:	5b                   	pop    %ebx
80107810:	5e                   	pop    %esi
80107811:	5f                   	pop    %edi
80107812:	5d                   	pop    %ebp
80107813:	c3                   	ret    
      panic("copyuvm: page not present");
80107814:	83 ec 0c             	sub    $0xc,%esp
80107817:	68 5e 83 10 80       	push   $0x8010835e
8010781c:	e8 5f 8b ff ff       	call   80100380 <panic>
80107821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010782f:	90                   	nop

80107830 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107836:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107839:	89 c1                	mov    %eax,%ecx
8010783b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010783e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107841:	f6 c2 01             	test   $0x1,%dl
80107844:	0f 84 00 01 00 00    	je     8010794a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010784a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010784d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107853:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107854:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107859:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107860:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107862:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107867:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010786a:	05 00 00 00 80       	add    $0x80000000,%eax
8010786f:	83 fa 05             	cmp    $0x5,%edx
80107872:	ba 00 00 00 00       	mov    $0x0,%edx
80107877:	0f 45 c2             	cmovne %edx,%eax
}
8010787a:	c3                   	ret    
8010787b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010787f:	90                   	nop

80107880 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 0c             	sub    $0xc,%esp
80107889:	8b 75 14             	mov    0x14(%ebp),%esi
8010788c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010788f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107892:	85 f6                	test   %esi,%esi
80107894:	75 51                	jne    801078e7 <copyout+0x67>
80107896:	e9 a5 00 00 00       	jmp    80107940 <copyout+0xc0>
8010789b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010789f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801078a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801078a6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801078ac:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801078b2:	74 75                	je     80107929 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801078b4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801078b6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801078b9:	29 c3                	sub    %eax,%ebx
801078bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078c1:	39 f3                	cmp    %esi,%ebx
801078c3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801078c6:	29 f8                	sub    %edi,%eax
801078c8:	83 ec 04             	sub    $0x4,%esp
801078cb:	01 c1                	add    %eax,%ecx
801078cd:	53                   	push   %ebx
801078ce:	52                   	push   %edx
801078cf:	51                   	push   %ecx
801078d0:	e8 eb d4 ff ff       	call   80104dc0 <memmove>
    len -= n;
    buf += n;
801078d5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801078d8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801078de:	83 c4 10             	add    $0x10,%esp
    buf += n;
801078e1:	01 da                	add    %ebx,%edx
  while(len > 0){
801078e3:	29 de                	sub    %ebx,%esi
801078e5:	74 59                	je     80107940 <copyout+0xc0>
  if(*pde & PTE_P){
801078e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801078ea:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801078ec:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801078ee:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801078f1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801078f7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801078fa:	f6 c1 01             	test   $0x1,%cl
801078fd:	0f 84 4e 00 00 00    	je     80107951 <copyout.cold>
  return &pgtab[PTX(va)];
80107903:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107905:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010790b:	c1 eb 0c             	shr    $0xc,%ebx
8010790e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107914:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010791b:	89 d9                	mov    %ebx,%ecx
8010791d:	83 e1 05             	and    $0x5,%ecx
80107920:	83 f9 05             	cmp    $0x5,%ecx
80107923:	0f 84 77 ff ff ff    	je     801078a0 <copyout+0x20>
  }
  return 0;
}
80107929:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010792c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107931:	5b                   	pop    %ebx
80107932:	5e                   	pop    %esi
80107933:	5f                   	pop    %edi
80107934:	5d                   	pop    %ebp
80107935:	c3                   	ret    
80107936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010793d:	8d 76 00             	lea    0x0(%esi),%esi
80107940:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107943:	31 c0                	xor    %eax,%eax
}
80107945:	5b                   	pop    %ebx
80107946:	5e                   	pop    %esi
80107947:	5f                   	pop    %edi
80107948:	5d                   	pop    %ebp
80107949:	c3                   	ret    

8010794a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010794a:	a1 00 00 00 00       	mov    0x0,%eax
8010794f:	0f 0b                	ud2    

80107951 <copyout.cold>:
80107951:	a1 00 00 00 00       	mov    0x0,%eax
80107956:	0f 0b                	ud2    
