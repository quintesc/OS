
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 07                	jle    25 <main+0x25>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	eb 2d                	jmp    52 <main+0x52>
    printf(2, "usage: kill pid...\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	68 04 06 00 00       	push   $0x604
  2d:	6a 02                	push   $0x2
  2f:	e8 23 03 00 00       	call   357 <printf>
    exit();
  34:	e8 c1 01 00 00       	call   1fa <exit>
    kill(atoi(argv[i]));
  39:	83 ec 0c             	sub    $0xc,%esp
  3c:	ff 34 9f             	push   (%edi,%ebx,4)
  3f:	e8 52 01 00 00       	call   196 <atoi>
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 de 01 00 00       	call   22a <kill>
  for(i=1; i<argc; i++)
  4c:	83 c3 01             	add    $0x1,%ebx
  4f:	83 c4 10             	add    $0x10,%esp
  52:	39 f3                	cmp    %esi,%ebx
  54:	7c e3                	jl     39 <main+0x39>
  exit();
  56:	e8 9f 01 00 00       	call   1fa <exit>

0000005b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  5b:	55                   	push   %ebp
  5c:	89 e5                	mov    %esp,%ebp
  5e:	56                   	push   %esi
  5f:	53                   	push   %ebx
  60:	8b 75 08             	mov    0x8(%ebp),%esi
  63:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	89 f0                	mov    %esi,%eax
  68:	89 d1                	mov    %edx,%ecx
  6a:	83 c2 01             	add    $0x1,%edx
  6d:	89 c3                	mov    %eax,%ebx
  6f:	83 c0 01             	add    $0x1,%eax
  72:	0f b6 09             	movzbl (%ecx),%ecx
  75:	88 0b                	mov    %cl,(%ebx)
  77:	84 c9                	test   %cl,%cl
  79:	75 ed                	jne    68 <strcpy+0xd>
    ;
  return os;
}
  7b:	89 f0                	mov    %esi,%eax
  7d:	5b                   	pop    %ebx
  7e:	5e                   	pop    %esi
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret    

00000081 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  81:	55                   	push   %ebp
  82:	89 e5                	mov    %esp,%ebp
  84:	8b 4d 08             	mov    0x8(%ebp),%ecx
  87:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  8a:	eb 06                	jmp    92 <strcmp+0x11>
    p++, q++;
  8c:	83 c1 01             	add    $0x1,%ecx
  8f:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  92:	0f b6 01             	movzbl (%ecx),%eax
  95:	84 c0                	test   %al,%al
  97:	74 04                	je     9d <strcmp+0x1c>
  99:	3a 02                	cmp    (%edx),%al
  9b:	74 ef                	je     8c <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  9d:	0f b6 c0             	movzbl %al,%eax
  a0:	0f b6 12             	movzbl (%edx),%edx
  a3:	29 d0                	sub    %edx,%eax
}
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    

000000a7 <strlen>:

uint
strlen(const char *s)
{
  a7:	55                   	push   %ebp
  a8:	89 e5                	mov    %esp,%ebp
  aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ad:	b8 00 00 00 00       	mov    $0x0,%eax
  b2:	eb 03                	jmp    b7 <strlen+0x10>
  b4:	83 c0 01             	add    $0x1,%eax
  b7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  bb:	75 f7                	jne    b4 <strlen+0xd>
    ;
  return n;
}
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    

000000bf <memset>:

void*
memset(void *dst, int c, uint n)
{
  bf:	55                   	push   %ebp
  c0:	89 e5                	mov    %esp,%ebp
  c2:	57                   	push   %edi
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c6:	89 d7                	mov    %edx,%edi
  c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ce:	fc                   	cld    
  cf:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d1:	89 d0                	mov    %edx,%eax
  d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  d6:	c9                   	leave  
  d7:	c3                   	ret    

000000d8 <strchr>:

char*
strchr(const char *s, char c)
{
  d8:	55                   	push   %ebp
  d9:	89 e5                	mov    %esp,%ebp
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  e2:	eb 03                	jmp    e7 <strchr+0xf>
  e4:	83 c0 01             	add    $0x1,%eax
  e7:	0f b6 10             	movzbl (%eax),%edx
  ea:	84 d2                	test   %dl,%dl
  ec:	74 06                	je     f4 <strchr+0x1c>
    if(*s == c)
  ee:	38 ca                	cmp    %cl,%dl
  f0:	75 f2                	jne    e4 <strchr+0xc>
  f2:	eb 05                	jmp    f9 <strchr+0x21>
      return (char*)s;
  return 0;
  f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    

000000fb <gets>:

char*
gets(char *buf, int max)
{
  fb:	55                   	push   %ebp
  fc:	89 e5                	mov    %esp,%ebp
  fe:	57                   	push   %edi
  ff:	56                   	push   %esi
 100:	53                   	push   %ebx
 101:	83 ec 1c             	sub    $0x1c,%esp
 104:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 107:	bb 00 00 00 00       	mov    $0x0,%ebx
 10c:	89 de                	mov    %ebx,%esi
 10e:	83 c3 01             	add    $0x1,%ebx
 111:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 114:	7d 2e                	jge    144 <gets+0x49>
    cc = read(0, &c, 1);
 116:	83 ec 04             	sub    $0x4,%esp
 119:	6a 01                	push   $0x1
 11b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 11e:	50                   	push   %eax
 11f:	6a 00                	push   $0x0
 121:	e8 ec 00 00 00       	call   212 <read>
    if(cc < 1)
 126:	83 c4 10             	add    $0x10,%esp
 129:	85 c0                	test   %eax,%eax
 12b:	7e 17                	jle    144 <gets+0x49>
      break;
    buf[i++] = c;
 12d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 131:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 134:	3c 0a                	cmp    $0xa,%al
 136:	0f 94 c2             	sete   %dl
 139:	3c 0d                	cmp    $0xd,%al
 13b:	0f 94 c0             	sete   %al
 13e:	08 c2                	or     %al,%dl
 140:	74 ca                	je     10c <gets+0x11>
    buf[i++] = c;
 142:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 144:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 148:	89 f8                	mov    %edi,%eax
 14a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 14d:	5b                   	pop    %ebx
 14e:	5e                   	pop    %esi
 14f:	5f                   	pop    %edi
 150:	5d                   	pop    %ebp
 151:	c3                   	ret    

00000152 <stat>:

int
stat(const char *n, struct stat *st)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	56                   	push   %esi
 156:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 157:	83 ec 08             	sub    $0x8,%esp
 15a:	6a 00                	push   $0x0
 15c:	ff 75 08             	push   0x8(%ebp)
 15f:	e8 d6 00 00 00       	call   23a <open>
  if(fd < 0)
 164:	83 c4 10             	add    $0x10,%esp
 167:	85 c0                	test   %eax,%eax
 169:	78 24                	js     18f <stat+0x3d>
 16b:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 16d:	83 ec 08             	sub    $0x8,%esp
 170:	ff 75 0c             	push   0xc(%ebp)
 173:	50                   	push   %eax
 174:	e8 d9 00 00 00       	call   252 <fstat>
 179:	89 c6                	mov    %eax,%esi
  close(fd);
 17b:	89 1c 24             	mov    %ebx,(%esp)
 17e:	e8 9f 00 00 00       	call   222 <close>
  return r;
 183:	83 c4 10             	add    $0x10,%esp
}
 186:	89 f0                	mov    %esi,%eax
 188:	8d 65 f8             	lea    -0x8(%ebp),%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
    return -1;
 18f:	be ff ff ff ff       	mov    $0xffffffff,%esi
 194:	eb f0                	jmp    186 <stat+0x34>

00000196 <atoi>:

int
atoi(const char *s)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	53                   	push   %ebx
 19a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 19d:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1a2:	eb 10                	jmp    1b4 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 1a4:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 1a7:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 1aa:	83 c1 01             	add    $0x1,%ecx
 1ad:	0f be c0             	movsbl %al,%eax
 1b0:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 1b4:	0f b6 01             	movzbl (%ecx),%eax
 1b7:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1ba:	80 fb 09             	cmp    $0x9,%bl
 1bd:	76 e5                	jbe    1a4 <atoi+0xe>
  return n;
}
 1bf:	89 d0                	mov    %edx,%eax
 1c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c4:	c9                   	leave  
 1c5:	c3                   	ret    

000001c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1c6:	55                   	push   %ebp
 1c7:	89 e5                	mov    %esp,%ebp
 1c9:	56                   	push   %esi
 1ca:	53                   	push   %ebx
 1cb:	8b 75 08             	mov    0x8(%ebp),%esi
 1ce:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1d1:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 1d4:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 1d6:	eb 0d                	jmp    1e5 <memmove+0x1f>
    *dst++ = *src++;
 1d8:	0f b6 01             	movzbl (%ecx),%eax
 1db:	88 02                	mov    %al,(%edx)
 1dd:	8d 49 01             	lea    0x1(%ecx),%ecx
 1e0:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 1e3:	89 d8                	mov    %ebx,%eax
 1e5:	8d 58 ff             	lea    -0x1(%eax),%ebx
 1e8:	85 c0                	test   %eax,%eax
 1ea:	7f ec                	jg     1d8 <memmove+0x12>
  return vdst;
}
 1ec:	89 f0                	mov    %esi,%eax
 1ee:	5b                   	pop    %ebx
 1ef:	5e                   	pop    %esi
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    

000001f2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1f2:	b8 01 00 00 00       	mov    $0x1,%eax
 1f7:	cd 40                	int    $0x40
 1f9:	c3                   	ret    

000001fa <exit>:
SYSCALL(exit)
 1fa:	b8 02 00 00 00       	mov    $0x2,%eax
 1ff:	cd 40                	int    $0x40
 201:	c3                   	ret    

00000202 <wait>:
SYSCALL(wait)
 202:	b8 03 00 00 00       	mov    $0x3,%eax
 207:	cd 40                	int    $0x40
 209:	c3                   	ret    

0000020a <pipe>:
SYSCALL(pipe)
 20a:	b8 04 00 00 00       	mov    $0x4,%eax
 20f:	cd 40                	int    $0x40
 211:	c3                   	ret    

00000212 <read>:
SYSCALL(read)
 212:	b8 05 00 00 00       	mov    $0x5,%eax
 217:	cd 40                	int    $0x40
 219:	c3                   	ret    

0000021a <write>:
SYSCALL(write)
 21a:	b8 10 00 00 00       	mov    $0x10,%eax
 21f:	cd 40                	int    $0x40
 221:	c3                   	ret    

00000222 <close>:
SYSCALL(close)
 222:	b8 15 00 00 00       	mov    $0x15,%eax
 227:	cd 40                	int    $0x40
 229:	c3                   	ret    

0000022a <kill>:
SYSCALL(kill)
 22a:	b8 06 00 00 00       	mov    $0x6,%eax
 22f:	cd 40                	int    $0x40
 231:	c3                   	ret    

00000232 <exec>:
SYSCALL(exec)
 232:	b8 07 00 00 00       	mov    $0x7,%eax
 237:	cd 40                	int    $0x40
 239:	c3                   	ret    

0000023a <open>:
SYSCALL(open)
 23a:	b8 0f 00 00 00       	mov    $0xf,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <mknod>:
SYSCALL(mknod)
 242:	b8 11 00 00 00       	mov    $0x11,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <unlink>:
SYSCALL(unlink)
 24a:	b8 12 00 00 00       	mov    $0x12,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <fstat>:
SYSCALL(fstat)
 252:	b8 08 00 00 00       	mov    $0x8,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <link>:
SYSCALL(link)
 25a:	b8 13 00 00 00       	mov    $0x13,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <mkdir>:
SYSCALL(mkdir)
 262:	b8 14 00 00 00       	mov    $0x14,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <chdir>:
SYSCALL(chdir)
 26a:	b8 09 00 00 00       	mov    $0x9,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <dup>:
SYSCALL(dup)
 272:	b8 0a 00 00 00       	mov    $0xa,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <getpid>:
SYSCALL(getpid)
 27a:	b8 0b 00 00 00       	mov    $0xb,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <sbrk>:
SYSCALL(sbrk)
 282:	b8 0c 00 00 00       	mov    $0xc,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <sleep>:
SYSCALL(sleep)
 28a:	b8 0d 00 00 00       	mov    $0xd,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <uptime>:
SYSCALL(uptime)
 292:	b8 0e 00 00 00       	mov    $0xe,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <mencrypt>:
SYSCALL(mencrypt)
 29a:	b8 16 00 00 00       	mov    $0x16,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <getpgtable>:
SYSCALL(getpgtable)
 2a2:	b8 17 00 00 00       	mov    $0x17,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <dump_rawphymem>:
SYSCALL(dump_rawphymem)
 2aa:	b8 18 00 00 00       	mov    $0x18,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 1c             	sub    $0x1c,%esp
 2b8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2bb:	6a 01                	push   $0x1
 2bd:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2c0:	52                   	push   %edx
 2c1:	50                   	push   %eax
 2c2:	e8 53 ff ff ff       	call   21a <write>
}
 2c7:	83 c4 10             	add    $0x10,%esp
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	57                   	push   %edi
 2d0:	56                   	push   %esi
 2d1:	53                   	push   %ebx
 2d2:	83 ec 2c             	sub    $0x2c,%esp
 2d5:	89 45 d0             	mov    %eax,-0x30(%ebp)
 2d8:	89 d0                	mov    %edx,%eax
 2da:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2e0:	0f 95 c1             	setne  %cl
 2e3:	c1 ea 1f             	shr    $0x1f,%edx
 2e6:	84 d1                	test   %dl,%cl
 2e8:	74 44                	je     32e <printint+0x62>
    neg = 1;
    x = -xx;
 2ea:	f7 d8                	neg    %eax
 2ec:	89 c1                	mov    %eax,%ecx
    neg = 1;
 2ee:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2f5:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 2fa:	89 c8                	mov    %ecx,%eax
 2fc:	ba 00 00 00 00       	mov    $0x0,%edx
 301:	f7 f6                	div    %esi
 303:	89 df                	mov    %ebx,%edi
 305:	83 c3 01             	add    $0x1,%ebx
 308:	0f b6 92 78 06 00 00 	movzbl 0x678(%edx),%edx
 30f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 313:	89 ca                	mov    %ecx,%edx
 315:	89 c1                	mov    %eax,%ecx
 317:	39 d6                	cmp    %edx,%esi
 319:	76 df                	jbe    2fa <printint+0x2e>
  if(neg)
 31b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 31f:	74 31                	je     352 <printint+0x86>
    buf[i++] = '-';
 321:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 326:	8d 5f 02             	lea    0x2(%edi),%ebx
 329:	8b 75 d0             	mov    -0x30(%ebp),%esi
 32c:	eb 17                	jmp    345 <printint+0x79>
    x = xx;
 32e:	89 c1                	mov    %eax,%ecx
  neg = 0;
 330:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 337:	eb bc                	jmp    2f5 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
 339:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 33e:	89 f0                	mov    %esi,%eax
 340:	e8 6d ff ff ff       	call   2b2 <putc>
  while(--i >= 0)
 345:	83 eb 01             	sub    $0x1,%ebx
 348:	79 ef                	jns    339 <printint+0x6d>
}
 34a:	83 c4 2c             	add    $0x2c,%esp
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5f                   	pop    %edi
 350:	5d                   	pop    %ebp
 351:	c3                   	ret    
 352:	8b 75 d0             	mov    -0x30(%ebp),%esi
 355:	eb ee                	jmp    345 <printint+0x79>

00000357 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 357:	55                   	push   %ebp
 358:	89 e5                	mov    %esp,%ebp
 35a:	57                   	push   %edi
 35b:	56                   	push   %esi
 35c:	53                   	push   %ebx
 35d:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 360:	8d 45 10             	lea    0x10(%ebp),%eax
 363:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 366:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 36b:	bb 00 00 00 00       	mov    $0x0,%ebx
 370:	eb 14                	jmp    386 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 372:	89 fa                	mov    %edi,%edx
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	e8 36 ff ff ff       	call   2b2 <putc>
 37c:	eb 05                	jmp    383 <printf+0x2c>
      }
    } else if(state == '%'){
 37e:	83 fe 25             	cmp    $0x25,%esi
 381:	74 25                	je     3a8 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 383:	83 c3 01             	add    $0x1,%ebx
 386:	8b 45 0c             	mov    0xc(%ebp),%eax
 389:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 38d:	84 c0                	test   %al,%al
 38f:	0f 84 20 01 00 00    	je     4b5 <printf+0x15e>
    c = fmt[i] & 0xff;
 395:	0f be f8             	movsbl %al,%edi
 398:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 39b:	85 f6                	test   %esi,%esi
 39d:	75 df                	jne    37e <printf+0x27>
      if(c == '%'){
 39f:	83 f8 25             	cmp    $0x25,%eax
 3a2:	75 ce                	jne    372 <printf+0x1b>
        state = '%';
 3a4:	89 c6                	mov    %eax,%esi
 3a6:	eb db                	jmp    383 <printf+0x2c>
      if(c == 'd'){
 3a8:	83 f8 25             	cmp    $0x25,%eax
 3ab:	0f 84 cf 00 00 00    	je     480 <printf+0x129>
 3b1:	0f 8c dd 00 00 00    	jl     494 <printf+0x13d>
 3b7:	83 f8 78             	cmp    $0x78,%eax
 3ba:	0f 8f d4 00 00 00    	jg     494 <printf+0x13d>
 3c0:	83 f8 63             	cmp    $0x63,%eax
 3c3:	0f 8c cb 00 00 00    	jl     494 <printf+0x13d>
 3c9:	83 e8 63             	sub    $0x63,%eax
 3cc:	83 f8 15             	cmp    $0x15,%eax
 3cf:	0f 87 bf 00 00 00    	ja     494 <printf+0x13d>
 3d5:	ff 24 85 20 06 00 00 	jmp    *0x620(,%eax,4)
        printint(fd, *ap, 10, 1);
 3dc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3df:	8b 17                	mov    (%edi),%edx
 3e1:	83 ec 0c             	sub    $0xc,%esp
 3e4:	6a 01                	push   $0x1
 3e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3eb:	8b 45 08             	mov    0x8(%ebp),%eax
 3ee:	e8 d9 fe ff ff       	call   2cc <printint>
        ap++;
 3f3:	83 c7 04             	add    $0x4,%edi
 3f6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3f9:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3fc:	be 00 00 00 00       	mov    $0x0,%esi
 401:	eb 80                	jmp    383 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 403:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 406:	8b 17                	mov    (%edi),%edx
 408:	83 ec 0c             	sub    $0xc,%esp
 40b:	6a 00                	push   $0x0
 40d:	b9 10 00 00 00       	mov    $0x10,%ecx
 412:	8b 45 08             	mov    0x8(%ebp),%eax
 415:	e8 b2 fe ff ff       	call   2cc <printint>
        ap++;
 41a:	83 c7 04             	add    $0x4,%edi
 41d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 420:	83 c4 10             	add    $0x10,%esp
      state = 0;
 423:	be 00 00 00 00       	mov    $0x0,%esi
 428:	e9 56 ff ff ff       	jmp    383 <printf+0x2c>
        s = (char*)*ap;
 42d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 430:	8b 30                	mov    (%eax),%esi
        ap++;
 432:	83 c0 04             	add    $0x4,%eax
 435:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 438:	85 f6                	test   %esi,%esi
 43a:	75 15                	jne    451 <printf+0xfa>
          s = "(null)";
 43c:	be 18 06 00 00       	mov    $0x618,%esi
 441:	eb 0e                	jmp    451 <printf+0xfa>
          putc(fd, *s);
 443:	0f be d2             	movsbl %dl,%edx
 446:	8b 45 08             	mov    0x8(%ebp),%eax
 449:	e8 64 fe ff ff       	call   2b2 <putc>
          s++;
 44e:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 451:	0f b6 16             	movzbl (%esi),%edx
 454:	84 d2                	test   %dl,%dl
 456:	75 eb                	jne    443 <printf+0xec>
      state = 0;
 458:	be 00 00 00 00       	mov    $0x0,%esi
 45d:	e9 21 ff ff ff       	jmp    383 <printf+0x2c>
        putc(fd, *ap);
 462:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 465:	0f be 17             	movsbl (%edi),%edx
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	e8 42 fe ff ff       	call   2b2 <putc>
        ap++;
 470:	83 c7 04             	add    $0x4,%edi
 473:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 476:	be 00 00 00 00       	mov    $0x0,%esi
 47b:	e9 03 ff ff ff       	jmp    383 <printf+0x2c>
        putc(fd, c);
 480:	89 fa                	mov    %edi,%edx
 482:	8b 45 08             	mov    0x8(%ebp),%eax
 485:	e8 28 fe ff ff       	call   2b2 <putc>
      state = 0;
 48a:	be 00 00 00 00       	mov    $0x0,%esi
 48f:	e9 ef fe ff ff       	jmp    383 <printf+0x2c>
        putc(fd, '%');
 494:	ba 25 00 00 00       	mov    $0x25,%edx
 499:	8b 45 08             	mov    0x8(%ebp),%eax
 49c:	e8 11 fe ff ff       	call   2b2 <putc>
        putc(fd, c);
 4a1:	89 fa                	mov    %edi,%edx
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	e8 07 fe ff ff       	call   2b2 <putc>
      state = 0;
 4ab:	be 00 00 00 00       	mov    $0x0,%esi
 4b0:	e9 ce fe ff ff       	jmp    383 <printf+0x2c>
    }
  }
}
 4b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    

000004bd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4bd:	55                   	push   %ebp
 4be:	89 e5                	mov    %esp,%ebp
 4c0:	57                   	push   %edi
 4c1:	56                   	push   %esi
 4c2:	53                   	push   %ebx
 4c3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4c6:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4c9:	a1 24 09 00 00       	mov    0x924,%eax
 4ce:	eb 02                	jmp    4d2 <free+0x15>
 4d0:	89 d0                	mov    %edx,%eax
 4d2:	39 c8                	cmp    %ecx,%eax
 4d4:	73 04                	jae    4da <free+0x1d>
 4d6:	39 08                	cmp    %ecx,(%eax)
 4d8:	77 12                	ja     4ec <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4da:	8b 10                	mov    (%eax),%edx
 4dc:	39 c2                	cmp    %eax,%edx
 4de:	77 f0                	ja     4d0 <free+0x13>
 4e0:	39 c8                	cmp    %ecx,%eax
 4e2:	72 08                	jb     4ec <free+0x2f>
 4e4:	39 ca                	cmp    %ecx,%edx
 4e6:	77 04                	ja     4ec <free+0x2f>
 4e8:	89 d0                	mov    %edx,%eax
 4ea:	eb e6                	jmp    4d2 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4ec:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4ef:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4f2:	8b 10                	mov    (%eax),%edx
 4f4:	39 d7                	cmp    %edx,%edi
 4f6:	74 19                	je     511 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4fb:	8b 50 04             	mov    0x4(%eax),%edx
 4fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 501:	39 ce                	cmp    %ecx,%esi
 503:	74 1b                	je     520 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 505:	89 08                	mov    %ecx,(%eax)
  freep = p;
 507:	a3 24 09 00 00       	mov    %eax,0x924
}
 50c:	5b                   	pop    %ebx
 50d:	5e                   	pop    %esi
 50e:	5f                   	pop    %edi
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 511:	03 72 04             	add    0x4(%edx),%esi
 514:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 517:	8b 10                	mov    (%eax),%edx
 519:	8b 12                	mov    (%edx),%edx
 51b:	89 53 f8             	mov    %edx,-0x8(%ebx)
 51e:	eb db                	jmp    4fb <free+0x3e>
    p->s.size += bp->s.size;
 520:	03 53 fc             	add    -0x4(%ebx),%edx
 523:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 526:	8b 53 f8             	mov    -0x8(%ebx),%edx
 529:	89 10                	mov    %edx,(%eax)
 52b:	eb da                	jmp    507 <free+0x4a>

0000052d <morecore>:

static Header*
morecore(uint nu)
{
 52d:	55                   	push   %ebp
 52e:	89 e5                	mov    %esp,%ebp
 530:	53                   	push   %ebx
 531:	83 ec 04             	sub    $0x4,%esp
 534:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 536:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 53b:	77 05                	ja     542 <morecore+0x15>
    nu = 4096;
 53d:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 542:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 549:	83 ec 0c             	sub    $0xc,%esp
 54c:	50                   	push   %eax
 54d:	e8 30 fd ff ff       	call   282 <sbrk>
  if(p == (char*)-1)
 552:	83 c4 10             	add    $0x10,%esp
 555:	83 f8 ff             	cmp    $0xffffffff,%eax
 558:	74 1c                	je     576 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 55a:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 55d:	83 c0 08             	add    $0x8,%eax
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	50                   	push   %eax
 564:	e8 54 ff ff ff       	call   4bd <free>
  return freep;
 569:	a1 24 09 00 00       	mov    0x924,%eax
 56e:	83 c4 10             	add    $0x10,%esp
}
 571:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 574:	c9                   	leave  
 575:	c3                   	ret    
    return 0;
 576:	b8 00 00 00 00       	mov    $0x0,%eax
 57b:	eb f4                	jmp    571 <morecore+0x44>

0000057d <malloc>:

void*
malloc(uint nbytes)
{
 57d:	55                   	push   %ebp
 57e:	89 e5                	mov    %esp,%ebp
 580:	53                   	push   %ebx
 581:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	8d 58 07             	lea    0x7(%eax),%ebx
 58a:	c1 eb 03             	shr    $0x3,%ebx
 58d:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 590:	8b 0d 24 09 00 00    	mov    0x924,%ecx
 596:	85 c9                	test   %ecx,%ecx
 598:	74 04                	je     59e <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 59a:	8b 01                	mov    (%ecx),%eax
 59c:	eb 4a                	jmp    5e8 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 59e:	c7 05 24 09 00 00 28 	movl   $0x928,0x924
 5a5:	09 00 00 
 5a8:	c7 05 28 09 00 00 28 	movl   $0x928,0x928
 5af:	09 00 00 
    base.s.size = 0;
 5b2:	c7 05 2c 09 00 00 00 	movl   $0x0,0x92c
 5b9:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5bc:	b9 28 09 00 00       	mov    $0x928,%ecx
 5c1:	eb d7                	jmp    59a <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5c3:	74 19                	je     5de <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5c5:	29 da                	sub    %ebx,%edx
 5c7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5ca:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5cd:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5d0:	89 0d 24 09 00 00    	mov    %ecx,0x924
      return (void*)(p + 1);
 5d6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5dc:	c9                   	leave  
 5dd:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5de:	8b 10                	mov    (%eax),%edx
 5e0:	89 11                	mov    %edx,(%ecx)
 5e2:	eb ec                	jmp    5d0 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e4:	89 c1                	mov    %eax,%ecx
 5e6:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 5e8:	8b 50 04             	mov    0x4(%eax),%edx
 5eb:	39 da                	cmp    %ebx,%edx
 5ed:	73 d4                	jae    5c3 <malloc+0x46>
    if(p == freep)
 5ef:	39 05 24 09 00 00    	cmp    %eax,0x924
 5f5:	75 ed                	jne    5e4 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 5f7:	89 d8                	mov    %ebx,%eax
 5f9:	e8 2f ff ff ff       	call   52d <morecore>
 5fe:	85 c0                	test   %eax,%eax
 600:	75 e2                	jne    5e4 <malloc+0x67>
 602:	eb d5                	jmp    5d9 <malloc+0x5c>
