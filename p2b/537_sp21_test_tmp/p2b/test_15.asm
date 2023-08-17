
_test_15:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}


int
main(int argc, char *argv[])
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
  int sret = setslice(getpid(), 3);
  14:	e8 8a 05 00 00       	call   5a3 <getpid>
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	6a 03                	push   $0x3
  1e:	50                   	push   %eax
  1f:	e8 9f 05 00 00       	call   5c3 <setslice>
  if (sret != 0) {
  24:	83 c4 10             	add    $0x10,%esp
  27:	85 c0                	test   %eax,%eax
  29:	74 13                	je     3e <main+0x3e>
    printf(1, "XV6_SCHEDULER\t setslice(getpid(), 3) failed\n");
  2b:	50                   	push   %eax
  2c:	50                   	push   %eax
  2d:	68 30 0a 00 00       	push   $0xa30
  32:	6a 01                	push   $0x1
  34:	e8 67 06 00 00       	call   6a0 <printf>
    exit();
  39:	e8 e5 04 00 00       	call   523 <exit>
  }

  int pid_c0 = fork2(3);
  3e:	83 ec 0c             	sub    $0xc,%esp
  41:	6a 03                	push   $0x3
  43:	e8 8b 05 00 00       	call   5d3 <fork2>
  if (pid_c0 < 0) {
  48:	83 c4 10             	add    $0x10,%esp
  4b:	85 c0                	test   %eax,%eax
  4d:	78 37                	js     86 <main+0x86>
    printf(1, "XV6_SCHEDULER\t fork2(3) failed\n");
    exit();
  }

  if (pid_c0 == 0) {  // child 0
  4f:	75 2b                	jne    7c <main+0x7c>
    int mypid = getpid();
  51:	e8 4d 05 00 00       	call   5a3 <getpid>
  56:	89 c3                	mov    %eax,%ebx

    int sret = setslice(mypid, 3);
  58:	50                   	push   %eax
  59:	50                   	push   %eax
  5a:	6a 03                	push   $0x3
  5c:	53                   	push   %ebx
  5d:	e8 61 05 00 00       	call   5c3 <setslice>
    if (sret != 0) {
  62:	83 c4 10             	add    $0x10,%esp
  65:	85 c0                	test   %eax,%eax
  67:	74 30                	je     99 <main+0x99>
      printf(1, "XV6_SCHEDULER\t setslice(mypid, 3) failed\n");
  69:	50                   	push   %eax
  6a:	50                   	push   %eax
  6b:	68 80 0a 00 00       	push   $0xa80
  70:	6a 01                	push   $0x1
  72:	e8 29 06 00 00       	call   6a0 <printf>
      exit();
  77:	e8 a7 04 00 00       	call   523 <exit>
        printf(1, "XV6_SCHEDULER\t at least %d compensation ticks accumulated on the next cycle\n",
               compticks - compticks_used - 5);
        exit();
      }

      wait();
  7c:	e8 aa 04 00 00       	call   52b <wait>
      exit();
  81:	e8 9d 04 00 00       	call   523 <exit>
    printf(1, "XV6_SCHEDULER\t fork2(3) failed\n");
  86:	50                   	push   %eax
  87:	50                   	push   %eax
  88:	68 60 0a 00 00       	push   $0xa60
  8d:	6a 01                	push   $0x1
  8f:	e8 0c 06 00 00       	call   6a0 <printf>
    exit();
  94:	e8 8a 04 00 00       	call   523 <exit>
    get_comp_info(mypid);
  99:	89 d8                	mov    %ebx,%eax
  9b:	e8 a0 01 00 00       	call   240 <get_comp_info>
    if (compticks != 0 || sleepticks != 0) {
  a0:	a1 e8 0f 00 00       	mov    0xfe8,%eax
  a5:	0b 05 e4 0f 00 00    	or     0xfe4,%eax
  ab:	74 13                	je     c0 <main+0xc0>
      printf(1, "XV6_SCHEDULER\t sleepticks and compticks should start with 0\n");
  ad:	57                   	push   %edi
  ae:	57                   	push   %edi
  af:	68 ac 0a 00 00       	push   $0xaac
  b4:	6a 01                	push   $0x1
  b6:	e8 e5 05 00 00       	call   6a0 <printf>
      exit();
  bb:	e8 63 04 00 00       	call   523 <exit>
    sleep(64);
  c0:	83 ec 0c             	sub    $0xc,%esp
  c3:	6a 40                	push   $0x40
  c5:	e8 e9 04 00 00       	call   5b3 <sleep>
    get_comp_info(mypid);
  ca:	89 d8                	mov    %ebx,%eax
  cc:	e8 6f 01 00 00       	call   240 <get_comp_info>
    if (sleepticks < 63 || sleepticks > 65) {
  d1:	a1 e4 0f 00 00       	mov    0xfe4,%eax
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	8d 50 c1             	lea    -0x3f(%eax),%edx
  dc:	83 fa 02             	cmp    $0x2,%edx
  df:	77 5f                	ja     140 <main+0x140>
    } else if (compticks != 0) {
  e1:	8b 35 e8 0f 00 00    	mov    0xfe8,%esi
    int compticks_used = 0;
  e7:	31 ff                	xor    %edi,%edi
    } else if (compticks != 0) {
  e9:	85 f6                	test   %esi,%esi
  eb:	75 66                	jne    153 <main+0x153>
  int i = 0, j = 0;
  ed:	31 d2                	xor    %edx,%edx
  ef:	31 c0                	xor    %eax,%eax
    j += i * j + 1;
  f1:	89 c1                	mov    %eax,%ecx
    i++;
  f3:	83 c0 01             	add    $0x1,%eax
    j += i * j + 1;
  f6:	0f af ca             	imul   %edx,%ecx
  f9:	8d 54 0a 01          	lea    0x1(%edx,%ecx,1),%edx
  while (i < iters) {
  fd:	3d a0 86 01 00       	cmp    $0x186a0,%eax
 102:	75 ed                	jne    f1 <main+0xf1>
      kill(-w0);  // an unelegant way of "using" the workload value to avoid optimized out
 104:	83 ec 0c             	sub    $0xc,%esp
 107:	f7 da                	neg    %edx
 109:	52                   	push   %edx
 10a:	e8 44 04 00 00       	call   553 <kill>
      get_comp_info(mypid);
 10f:	89 d8                	mov    %ebx,%eax
 111:	e8 2a 01 00 00       	call   240 <get_comp_info>
      if (compticks > compticks_used)
 116:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 11b:	39 c7                	cmp    %eax,%edi
 11d:	0f 4c f8             	cmovl  %eax,%edi
    while (compticks_used < 10) {   // stop early just at 10
 120:	83 c4 10             	add    $0x10,%esp
 123:	83 ff 09             	cmp    $0x9,%edi
 126:	7e c5                	jle    ed <main+0xed>
    if (compticks_used >= 64) {
 128:	83 ff 3f             	cmp    $0x3f,%edi
 12b:	7e 39                	jle    166 <main+0x166>
      printf(1, "XV6_SCHEDULER\t used up all compensation ticks, should not happen\n");
 12d:	51                   	push   %ecx
 12e:	51                   	push   %ecx
 12f:	68 74 0b 00 00       	push   $0xb74
 134:	6a 01                	push   $0x1
 136:	e8 65 05 00 00       	call   6a0 <printf>
      exit();
 13b:	e8 e3 03 00 00       	call   523 <exit>
      printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
 140:	56                   	push   %esi
 141:	50                   	push   %eax
 142:	68 ec 0a 00 00       	push   $0xaec
 147:	6a 01                	push   $0x1
 149:	e8 52 05 00 00       	call   6a0 <printf>
      exit();
 14e:	e8 d0 03 00 00       	call   523 <exit>
      printf(1, "XV6_SCHEDULER\t compticks used %d should be 0 at this time\n", compticks);
 153:	53                   	push   %ebx
 154:	56                   	push   %esi
 155:	68 38 0b 00 00       	push   $0xb38
 15a:	6a 01                	push   $0x1
 15c:	e8 3f 05 00 00       	call   6a0 <printf>
      exit();
 161:	e8 bd 03 00 00       	call   523 <exit>
    sleep(4);
 166:	83 ec 0c             	sub    $0xc,%esp
 169:	6a 04                	push   $0x4
 16b:	e8 43 04 00 00       	call   5b3 <sleep>
    int pid_c1 = fork2(3);
 170:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 177:	e8 57 04 00 00       	call   5d3 <fork2>
    if (pid_c1 < 0) {
 17c:	83 c4 10             	add    $0x10,%esp
 17f:	85 c0                	test   %eax,%eax
 181:	0f 88 ff fe ff ff    	js     86 <main+0x86>
    if (pid_c1 == 0) {   // child 1
 187:	75 34                	jne    1bd <main+0x1bd>
  int i = 0, j = 0;
 189:	31 d2                	xor    %edx,%edx
    j += i * j + 1;
 18b:	89 d1                	mov    %edx,%ecx
    i++;
 18d:	83 c2 01             	add    $0x1,%edx
    j += i * j + 1;
 190:	0f af c8             	imul   %eax,%ecx
 193:	8d 44 08 01          	lea    0x1(%eax,%ecx,1),%eax
  while (i < iters) {
 197:	81 fa 40 e2 01 00    	cmp    $0x1e240,%edx
 19d:	75 ec                	jne    18b <main+0x18b>
      kill(-w1);   // an unelegant way of "using" the workload value to avoid optimized out
 19f:	83 ec 0c             	sub    $0xc,%esp
 1a2:	f7 d8                	neg    %eax
 1a4:	50                   	push   %eax
 1a5:	e8 a9 03 00 00       	call   553 <kill>
      printf(1, "XV6_SCHEDULER\t inner child 1 workload DONE\n");
 1aa:	58                   	pop    %eax
 1ab:	5a                   	pop    %edx
 1ac:	68 b8 0b 00 00       	push   $0xbb8
 1b1:	6a 01                	push   $0x1
 1b3:	e8 e8 04 00 00       	call   6a0 <printf>
      exit();
 1b8:	e8 66 03 00 00       	call   523 <exit>
  int i = 0, j = 0;
 1bd:	31 c0                	xor    %eax,%eax
    j += i * j + 1;
 1bf:	89 c2                	mov    %eax,%edx
    i++;
 1c1:	83 c0 01             	add    $0x1,%eax
    j += i * j + 1;
 1c4:	0f af d6             	imul   %esi,%edx
 1c7:	8d 74 16 01          	lea    0x1(%esi,%edx,1),%esi
  while (i < iters) {
 1cb:	3d 04 28 62 21       	cmp    $0x21622804,%eax
 1d0:	75 ed                	jne    1bf <main+0x1bf>
      kill(-w0);  // an unelegant way of "using" the workload value to avoid optimized out
 1d2:	83 ec 0c             	sub    $0xc,%esp
 1d5:	f7 de                	neg    %esi
 1d7:	56                   	push   %esi
 1d8:	e8 76 03 00 00       	call   553 <kill>
      printf(1, "XV6_SCHEDULER\t outer child 0 workload DONE\n");
 1dd:	5e                   	pop    %esi
 1de:	58                   	pop    %eax
 1df:	68 e4 0b 00 00       	push   $0xbe4
 1e4:	6a 01                	push   $0x1
 1e6:	e8 b5 04 00 00       	call   6a0 <printf>
      get_comp_info(mypid);
 1eb:	89 d8                	mov    %ebx,%eax
 1ed:	e8 4e 00 00 00       	call   240 <get_comp_info>
      if (compticks <= compticks_used) {
 1f2:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 1f7:	83 c4 10             	add    $0x10,%esp
 1fa:	39 f8                	cmp    %edi,%eax
 1fc:	7e 23                	jle    221 <main+0x221>
      } else if (compticks > compticks_used + 5) {
 1fe:	8d 57 05             	lea    0x5(%edi),%edx
 201:	39 d0                	cmp    %edx,%eax
 203:	0f 8e 73 fe ff ff    	jle    7c <main+0x7c>
               compticks - compticks_used - 5);
 209:	29 f8                	sub    %edi,%eax
        printf(1, "XV6_SCHEDULER\t at least %d compensation ticks accumulated on the next cycle\n",
 20b:	52                   	push   %edx
 20c:	83 e8 05             	sub    $0x5,%eax
 20f:	50                   	push   %eax
 210:	68 5c 0c 00 00       	push   $0xc5c
 215:	6a 01                	push   $0x1
 217:	e8 84 04 00 00       	call   6a0 <printf>
        exit();
 21c:	e8 02 03 00 00       	call   523 <exit>
        printf(1, "XV6_SCHEDULER\t the second sleep(4) did not grant any compensation ticks\n");
 221:	51                   	push   %ecx
 222:	51                   	push   %ecx
 223:	68 10 0c 00 00       	push   $0xc10
 228:	6a 01                	push   $0x1
 22a:	e8 71 04 00 00       	call   6a0 <printf>
        exit();
 22f:	e8 ef 02 00 00       	call   523 <exit>
 234:	66 90                	xchg   %ax,%ax
 236:	66 90                	xchg   %ax,%ax
 238:	66 90                	xchg   %ax,%ax
 23a:	66 90                	xchg   %ax,%ax
 23c:	66 90                	xchg   %ax,%ax
 23e:	66 90                	xchg   %ax,%ax

00000240 <get_comp_info>:
static void get_comp_info(int pid) {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	89 c3                	mov    %eax,%ebx
 246:	83 ec 10             	sub    $0x10,%esp
  int pret = getpinfo(&pstat);
 249:	68 00 10 00 00       	push   $0x1000
 24e:	e8 88 03 00 00       	call   5db <getpinfo>
  if (pret != 0) {
 253:	83 c4 10             	add    $0x10,%esp
 256:	85 c0                	test   %eax,%eax
 258:	74 0e                	je     268 <get_comp_info+0x28>
 25a:	eb 59                	jmp    2b5 <get_comp_info+0x75>
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < NPROC; ++i) {
 260:	83 c0 01             	add    $0x1,%eax
 263:	83 f8 40             	cmp    $0x40,%eax
 266:	74 38                	je     2a0 <get_comp_info+0x60>
    if (pstat.inuse[i] == 1 && pstat.pid[i] == pid) {
 268:	83 3c 85 00 10 00 00 	cmpl   $0x1,0x1000(,%eax,4)
 26f:	01 
 270:	75 ee                	jne    260 <get_comp_info+0x20>
 272:	3b 1c 85 00 11 00 00 	cmp    0x1100(,%eax,4),%ebx
 279:	75 e5                	jne    260 <get_comp_info+0x20>
      compticks = pstat.compticks[i];
 27b:	8b 14 85 00 13 00 00 	mov    0x1300(,%eax,4),%edx
      sleepticks = pstat.sleepticks[i];
 282:	8b 04 85 00 15 00 00 	mov    0x1500(,%eax,4),%eax
}
 289:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      compticks = pstat.compticks[i];
 28c:	89 15 e8 0f 00 00    	mov    %edx,0xfe8
      sleepticks = pstat.sleepticks[i];
 292:	a3 e4 0f 00 00       	mov    %eax,0xfe4
}
 297:	c9                   	leave  
 298:	c3                   	ret    
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "XV6_SCHEDULER\t did not find process %d in the fetched pstat\n", pid);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	53                   	push   %ebx
 2a4:	68 f0 09 00 00       	push   $0x9f0
 2a9:	6a 01                	push   $0x1
 2ab:	e8 f0 03 00 00       	call   6a0 <printf>
  exit();
 2b0:	e8 6e 02 00 00       	call   523 <exit>
    printf(1, "XV6_SCHEDULER\t getpinfo(&pstat) failed\n");
 2b5:	50                   	push   %eax
 2b6:	50                   	push   %eax
 2b7:	68 c8 09 00 00       	push   $0x9c8
 2bc:	6a 01                	push   $0x1
 2be:	e8 dd 03 00 00       	call   6a0 <printf>
    exit();
 2c3:	e8 5b 02 00 00       	call   523 <exit>
 2c8:	66 90                	xchg   %ax,%ax
 2ca:	66 90                	xchg   %ax,%ax
 2cc:	66 90                	xchg   %ax,%ax
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2d0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d1:	31 c0                	xor    %eax,%eax
{
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	53                   	push   %ebx
 2d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 2e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2e7:	83 c0 01             	add    $0x1,%eax
 2ea:	84 d2                	test   %dl,%dl
 2ec:	75 f2                	jne    2e0 <strcpy+0x10>
    ;
  return os;
}
 2ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2f1:	89 c8                	mov    %ecx,%eax
 2f3:	c9                   	leave  
 2f4:	c3                   	ret    
 2f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
 307:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 30a:	0f b6 02             	movzbl (%edx),%eax
 30d:	84 c0                	test   %al,%al
 30f:	75 17                	jne    328 <strcmp+0x28>
 311:	eb 3a                	jmp    34d <strcmp+0x4d>
 313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 317:	90                   	nop
 318:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 31c:	83 c2 01             	add    $0x1,%edx
 31f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 322:	84 c0                	test   %al,%al
 324:	74 1a                	je     340 <strcmp+0x40>
    p++, q++;
 326:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 328:	0f b6 19             	movzbl (%ecx),%ebx
 32b:	38 c3                	cmp    %al,%bl
 32d:	74 e9                	je     318 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 32f:	29 d8                	sub    %ebx,%eax
}
 331:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 334:	c9                   	leave  
 335:	c3                   	ret    
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 340:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 344:	31 c0                	xor    %eax,%eax
 346:	29 d8                	sub    %ebx,%eax
}
 348:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 34b:	c9                   	leave  
 34c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 34d:	0f b6 19             	movzbl (%ecx),%ebx
 350:	31 c0                	xor    %eax,%eax
 352:	eb db                	jmp    32f <strcmp+0x2f>
 354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop

00000360 <strlen>:

uint
strlen(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 366:	80 3a 00             	cmpb   $0x0,(%edx)
 369:	74 15                	je     380 <strlen+0x20>
 36b:	31 c0                	xor    %eax,%eax
 36d:	8d 76 00             	lea    0x0(%esi),%esi
 370:	83 c0 01             	add    $0x1,%eax
 373:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 377:	89 c1                	mov    %eax,%ecx
 379:	75 f5                	jne    370 <strlen+0x10>
    ;
  return n;
}
 37b:	89 c8                	mov    %ecx,%eax
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
 37f:	90                   	nop
  for(n = 0; s[n]; n++)
 380:	31 c9                	xor    %ecx,%ecx
}
 382:	5d                   	pop    %ebp
 383:	89 c8                	mov    %ecx,%eax
 385:	c3                   	ret    
 386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38d:	8d 76 00             	lea    0x0(%esi),%esi

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 397:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	89 d7                	mov    %edx,%edi
 39f:	fc                   	cld    
 3a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 3a5:	89 d0                	mov    %edx,%eax
 3a7:	c9                   	leave  
 3a8:	c3                   	ret    
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3ba:	0f b6 10             	movzbl (%eax),%edx
 3bd:	84 d2                	test   %dl,%dl
 3bf:	75 12                	jne    3d3 <strchr+0x23>
 3c1:	eb 1d                	jmp    3e0 <strchr+0x30>
 3c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c7:	90                   	nop
 3c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3cc:	83 c0 01             	add    $0x1,%eax
 3cf:	84 d2                	test   %dl,%dl
 3d1:	74 0d                	je     3e0 <strchr+0x30>
    if(*s == c)
 3d3:	38 d1                	cmp    %dl,%cl
 3d5:	75 f1                	jne    3c8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 3d7:	5d                   	pop    %ebp
 3d8:	c3                   	ret    
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3e0:	31 c0                	xor    %eax,%eax
}
 3e2:	5d                   	pop    %ebp
 3e3:	c3                   	ret    
 3e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop

000003f0 <gets>:

char*
gets(char *buf, int max)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 3f5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 3f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 3f9:	31 db                	xor    %ebx,%ebx
{
 3fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 3fe:	eb 27                	jmp    427 <gets+0x37>
    cc = read(0, &c, 1);
 400:	83 ec 04             	sub    $0x4,%esp
 403:	6a 01                	push   $0x1
 405:	57                   	push   %edi
 406:	6a 00                	push   $0x0
 408:	e8 2e 01 00 00       	call   53b <read>
    if(cc < 1)
 40d:	83 c4 10             	add    $0x10,%esp
 410:	85 c0                	test   %eax,%eax
 412:	7e 1d                	jle    431 <gets+0x41>
      break;
    buf[i++] = c;
 414:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 418:	8b 55 08             	mov    0x8(%ebp),%edx
 41b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 41f:	3c 0a                	cmp    $0xa,%al
 421:	74 1d                	je     440 <gets+0x50>
 423:	3c 0d                	cmp    $0xd,%al
 425:	74 19                	je     440 <gets+0x50>
  for(i=0; i+1 < max; ){
 427:	89 de                	mov    %ebx,%esi
 429:	83 c3 01             	add    $0x1,%ebx
 42c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 42f:	7c cf                	jl     400 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 431:	8b 45 08             	mov    0x8(%ebp),%eax
 434:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 438:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5f                   	pop    %edi
 43e:	5d                   	pop    %ebp
 43f:	c3                   	ret    
  buf[i] = '\0';
 440:	8b 45 08             	mov    0x8(%ebp),%eax
 443:	89 de                	mov    %ebx,%esi
 445:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 449:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44c:	5b                   	pop    %ebx
 44d:	5e                   	pop    %esi
 44e:	5f                   	pop    %edi
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop

00000460 <stat>:

int
stat(const char *n, struct stat *st)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 465:	83 ec 08             	sub    $0x8,%esp
 468:	6a 00                	push   $0x0
 46a:	ff 75 08             	push   0x8(%ebp)
 46d:	e8 f1 00 00 00       	call   563 <open>
  if(fd < 0)
 472:	83 c4 10             	add    $0x10,%esp
 475:	85 c0                	test   %eax,%eax
 477:	78 27                	js     4a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	ff 75 0c             	push   0xc(%ebp)
 47f:	89 c3                	mov    %eax,%ebx
 481:	50                   	push   %eax
 482:	e8 f4 00 00 00       	call   57b <fstat>
  close(fd);
 487:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 48a:	89 c6                	mov    %eax,%esi
  close(fd);
 48c:	e8 ba 00 00 00       	call   54b <close>
  return r;
 491:	83 c4 10             	add    $0x10,%esp
}
 494:	8d 65 f8             	lea    -0x8(%ebp),%esp
 497:	89 f0                	mov    %esi,%eax
 499:	5b                   	pop    %ebx
 49a:	5e                   	pop    %esi
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
 49d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4a5:	eb ed                	jmp    494 <stat+0x34>
 4a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ae:	66 90                	xchg   %ax,%ax

000004b0 <atoi>:

int
atoi(const char *s)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	53                   	push   %ebx
 4b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b7:	0f be 02             	movsbl (%edx),%eax
 4ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4c5:	77 1e                	ja     4e5 <atoi+0x35>
 4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ce:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4d0:	83 c2 01             	add    $0x1,%edx
 4d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4da:	0f be 02             	movsbl (%edx),%eax
 4dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4e0:	80 fb 09             	cmp    $0x9,%bl
 4e3:	76 eb                	jbe    4d0 <atoi+0x20>
  return n;
}
 4e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4e8:	89 c8                	mov    %ecx,%eax
 4ea:	c9                   	leave  
 4eb:	c3                   	ret    
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	8b 45 10             	mov    0x10(%ebp),%eax
 4f7:	8b 55 08             	mov    0x8(%ebp),%edx
 4fa:	56                   	push   %esi
 4fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4fe:	85 c0                	test   %eax,%eax
 500:	7e 13                	jle    515 <memmove+0x25>
 502:	01 d0                	add    %edx,%eax
  dst = vdst;
 504:	89 d7                	mov    %edx,%edi
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 510:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 511:	39 f8                	cmp    %edi,%eax
 513:	75 fb                	jne    510 <memmove+0x20>
  return vdst;
}
 515:	5e                   	pop    %esi
 516:	89 d0                	mov    %edx,%eax
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    

0000051b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 51b:	b8 01 00 00 00       	mov    $0x1,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <exit>:
SYSCALL(exit)
 523:	b8 02 00 00 00       	mov    $0x2,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <wait>:
SYSCALL(wait)
 52b:	b8 03 00 00 00       	mov    $0x3,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <pipe>:
SYSCALL(pipe)
 533:	b8 04 00 00 00       	mov    $0x4,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <read>:
SYSCALL(read)
 53b:	b8 05 00 00 00       	mov    $0x5,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <write>:
SYSCALL(write)
 543:	b8 10 00 00 00       	mov    $0x10,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <close>:
SYSCALL(close)
 54b:	b8 15 00 00 00       	mov    $0x15,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <kill>:
SYSCALL(kill)
 553:	b8 06 00 00 00       	mov    $0x6,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <exec>:
SYSCALL(exec)
 55b:	b8 07 00 00 00       	mov    $0x7,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <open>:
SYSCALL(open)
 563:	b8 0f 00 00 00       	mov    $0xf,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <mknod>:
SYSCALL(mknod)
 56b:	b8 11 00 00 00       	mov    $0x11,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <unlink>:
SYSCALL(unlink)
 573:	b8 12 00 00 00       	mov    $0x12,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <fstat>:
SYSCALL(fstat)
 57b:	b8 08 00 00 00       	mov    $0x8,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <link>:
SYSCALL(link)
 583:	b8 13 00 00 00       	mov    $0x13,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <mkdir>:
SYSCALL(mkdir)
 58b:	b8 14 00 00 00       	mov    $0x14,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <chdir>:
SYSCALL(chdir)
 593:	b8 09 00 00 00       	mov    $0x9,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <dup>:
SYSCALL(dup)
 59b:	b8 0a 00 00 00       	mov    $0xa,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <getpid>:
SYSCALL(getpid)
 5a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <sbrk>:
SYSCALL(sbrk)
 5ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <sleep>:
SYSCALL(sleep)
 5b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <uptime>:
SYSCALL(uptime)
 5bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <setslice>:
SYSCALL(setslice)
 5c3:	b8 16 00 00 00       	mov    $0x16,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <getslice>:
SYSCALL(getslice)
 5cb:	b8 17 00 00 00       	mov    $0x17,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <fork2>:
SYSCALL(fork2)
 5d3:	b8 18 00 00 00       	mov    $0x18,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <getpinfo>:
SYSCALL(getpinfo)
 5db:	b8 19 00 00 00       	mov    $0x19,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    
 5e3:	66 90                	xchg   %ax,%ax
 5e5:	66 90                	xchg   %ax,%ax
 5e7:	66 90                	xchg   %ax,%ax
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 3c             	sub    $0x3c,%esp
 5f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5fc:	89 d1                	mov    %edx,%ecx
{
 5fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 601:	85 d2                	test   %edx,%edx
 603:	0f 89 7f 00 00 00    	jns    688 <printint+0x98>
 609:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 60d:	74 79                	je     688 <printint+0x98>
    neg = 1;
 60f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 616:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 618:	31 db                	xor    %ebx,%ebx
 61a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 620:	89 c8                	mov    %ecx,%eax
 622:	31 d2                	xor    %edx,%edx
 624:	89 cf                	mov    %ecx,%edi
 626:	f7 75 c4             	divl   -0x3c(%ebp)
 629:	0f b6 92 08 0d 00 00 	movzbl 0xd08(%edx),%edx
 630:	89 45 c0             	mov    %eax,-0x40(%ebp)
 633:	89 d8                	mov    %ebx,%eax
 635:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 638:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 63b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 63e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 641:	76 dd                	jbe    620 <printint+0x30>
  if(neg)
 643:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 646:	85 c9                	test   %ecx,%ecx
 648:	74 0c                	je     656 <printint+0x66>
    buf[i++] = '-';
 64a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 64f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 651:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 656:	8b 7d b8             	mov    -0x48(%ebp),%edi
 659:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 65d:	eb 07                	jmp    666 <printint+0x76>
 65f:	90                   	nop
    putc(fd, buf[i]);
 660:	0f b6 13             	movzbl (%ebx),%edx
 663:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 666:	83 ec 04             	sub    $0x4,%esp
 669:	88 55 d7             	mov    %dl,-0x29(%ebp)
 66c:	6a 01                	push   $0x1
 66e:	56                   	push   %esi
 66f:	57                   	push   %edi
 670:	e8 ce fe ff ff       	call   543 <write>
  while(--i >= 0)
 675:	83 c4 10             	add    $0x10,%esp
 678:	39 de                	cmp    %ebx,%esi
 67a:	75 e4                	jne    660 <printint+0x70>
}
 67c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 688:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 68f:	eb 87                	jmp    618 <printint+0x28>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop

000006a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 6ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6af:	0f b6 13             	movzbl (%ebx),%edx
 6b2:	84 d2                	test   %dl,%dl
 6b4:	74 6a                	je     720 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 6b6:	8d 45 10             	lea    0x10(%ebp),%eax
 6b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 6bf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 6c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c4:	eb 36                	jmp    6fc <printf+0x5c>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6d3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 6d8:	83 f8 25             	cmp    $0x25,%eax
 6db:	74 15                	je     6f2 <printf+0x52>
  write(fd, &c, 1);
 6dd:	83 ec 04             	sub    $0x4,%esp
 6e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6e3:	6a 01                	push   $0x1
 6e5:	57                   	push   %edi
 6e6:	56                   	push   %esi
 6e7:	e8 57 fe ff ff       	call   543 <write>
 6ec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 6ef:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6f2:	0f b6 13             	movzbl (%ebx),%edx
 6f5:	83 c3 01             	add    $0x1,%ebx
 6f8:	84 d2                	test   %dl,%dl
 6fa:	74 24                	je     720 <printf+0x80>
    c = fmt[i] & 0xff;
 6fc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 6ff:	85 c9                	test   %ecx,%ecx
 701:	74 cd                	je     6d0 <printf+0x30>
      }
    } else if(state == '%'){
 703:	83 f9 25             	cmp    $0x25,%ecx
 706:	75 ea                	jne    6f2 <printf+0x52>
      if(c == 'd'){
 708:	83 f8 25             	cmp    $0x25,%eax
 70b:	0f 84 07 01 00 00    	je     818 <printf+0x178>
 711:	83 e8 63             	sub    $0x63,%eax
 714:	83 f8 15             	cmp    $0x15,%eax
 717:	77 17                	ja     730 <printf+0x90>
 719:	ff 24 85 b0 0c 00 00 	jmp    *0xcb0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 720:	8d 65 f4             	lea    -0xc(%ebp),%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
  write(fd, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 736:	6a 01                	push   $0x1
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 73e:	e8 00 fe ff ff       	call   543 <write>
        putc(fd, c);
 743:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 747:	83 c4 0c             	add    $0xc,%esp
 74a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 74d:	6a 01                	push   $0x1
 74f:	57                   	push   %edi
 750:	56                   	push   %esi
 751:	e8 ed fd ff ff       	call   543 <write>
        putc(fd, c);
 756:	83 c4 10             	add    $0x10,%esp
      state = 0;
 759:	31 c9                	xor    %ecx,%ecx
 75b:	eb 95                	jmp    6f2 <printf+0x52>
 75d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 760:	83 ec 0c             	sub    $0xc,%esp
 763:	b9 10 00 00 00       	mov    $0x10,%ecx
 768:	6a 00                	push   $0x0
 76a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 76d:	8b 10                	mov    (%eax),%edx
 76f:	89 f0                	mov    %esi,%eax
 771:	e8 7a fe ff ff       	call   5f0 <printint>
        ap++;
 776:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 77a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 77d:	31 c9                	xor    %ecx,%ecx
 77f:	e9 6e ff ff ff       	jmp    6f2 <printf+0x52>
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 788:	8b 45 d0             	mov    -0x30(%ebp),%eax
 78b:	8b 10                	mov    (%eax),%edx
        ap++;
 78d:	83 c0 04             	add    $0x4,%eax
 790:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 793:	85 d2                	test   %edx,%edx
 795:	0f 84 8d 00 00 00    	je     828 <printf+0x188>
        while(*s != 0){
 79b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 79e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 7a0:	84 c0                	test   %al,%al
 7a2:	0f 84 4a ff ff ff    	je     6f2 <printf+0x52>
 7a8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7ab:	89 d3                	mov    %edx,%ebx
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7b3:	83 c3 01             	add    $0x1,%ebx
 7b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7b9:	6a 01                	push   $0x1
 7bb:	57                   	push   %edi
 7bc:	56                   	push   %esi
 7bd:	e8 81 fd ff ff       	call   543 <write>
        while(*s != 0){
 7c2:	0f b6 03             	movzbl (%ebx),%eax
 7c5:	83 c4 10             	add    $0x10,%esp
 7c8:	84 c0                	test   %al,%al
 7ca:	75 e4                	jne    7b0 <printf+0x110>
      state = 0;
 7cc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 7cf:	31 c9                	xor    %ecx,%ecx
 7d1:	e9 1c ff ff ff       	jmp    6f2 <printf+0x52>
 7d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 7e0:	83 ec 0c             	sub    $0xc,%esp
 7e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7e8:	6a 01                	push   $0x1
 7ea:	e9 7b ff ff ff       	jmp    76a <printf+0xca>
 7ef:	90                   	nop
        putc(fd, *ap);
 7f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7f6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 7f8:	6a 01                	push   $0x1
 7fa:	57                   	push   %edi
 7fb:	56                   	push   %esi
        putc(fd, *ap);
 7fc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7ff:	e8 3f fd ff ff       	call   543 <write>
        ap++;
 804:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 808:	83 c4 10             	add    $0x10,%esp
      state = 0;
 80b:	31 c9                	xor    %ecx,%ecx
 80d:	e9 e0 fe ff ff       	jmp    6f2 <printf+0x52>
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 818:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 81b:	83 ec 04             	sub    $0x4,%esp
 81e:	e9 2a ff ff ff       	jmp    74d <printf+0xad>
 823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 827:	90                   	nop
          s = "(null)";
 828:	ba a9 0c 00 00       	mov    $0xca9,%edx
        while(*s != 0){
 82d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 830:	b8 28 00 00 00       	mov    $0x28,%eax
 835:	89 d3                	mov    %edx,%ebx
 837:	e9 74 ff ff ff       	jmp    7b0 <printf+0x110>
 83c:	66 90                	xchg   %ax,%ax
 83e:	66 90                	xchg   %ax,%ax

00000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	a1 00 17 00 00       	mov    0x1700,%eax
{
 846:	89 e5                	mov    %esp,%ebp
 848:	57                   	push   %edi
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
 84b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 84e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	89 c2                	mov    %eax,%edx
 85a:	8b 00                	mov    (%eax),%eax
 85c:	39 ca                	cmp    %ecx,%edx
 85e:	73 30                	jae    890 <free+0x50>
 860:	39 c1                	cmp    %eax,%ecx
 862:	72 04                	jb     868 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	39 c2                	cmp    %eax,%edx
 866:	72 f0                	jb     858 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 868:	8b 73 fc             	mov    -0x4(%ebx),%esi
 86b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 86e:	39 f8                	cmp    %edi,%eax
 870:	74 30                	je     8a2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 872:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 875:	8b 42 04             	mov    0x4(%edx),%eax
 878:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 87b:	39 f1                	cmp    %esi,%ecx
 87d:	74 3a                	je     8b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 87f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 881:	5b                   	pop    %ebx
  freep = p;
 882:	89 15 00 17 00 00    	mov    %edx,0x1700
}
 888:	5e                   	pop    %esi
 889:	5f                   	pop    %edi
 88a:	5d                   	pop    %ebp
 88b:	c3                   	ret    
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 890:	39 c2                	cmp    %eax,%edx
 892:	72 c4                	jb     858 <free+0x18>
 894:	39 c1                	cmp    %eax,%ecx
 896:	73 c0                	jae    858 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 898:	8b 73 fc             	mov    -0x4(%ebx),%esi
 89b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 89e:	39 f8                	cmp    %edi,%eax
 8a0:	75 d0                	jne    872 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 8a2:	03 70 04             	add    0x4(%eax),%esi
 8a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a8:	8b 02                	mov    (%edx),%eax
 8aa:	8b 00                	mov    (%eax),%eax
 8ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 8af:	8b 42 04             	mov    0x4(%edx),%eax
 8b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8b5:	39 f1                	cmp    %esi,%ecx
 8b7:	75 c6                	jne    87f <free+0x3f>
    p->s.size += bp->s.size;
 8b9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 8bc:	89 15 00 17 00 00    	mov    %edx,0x1700
    p->s.size += bp->s.size;
 8c2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 8c5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 8c8:	89 0a                	mov    %ecx,(%edx)
}
 8ca:	5b                   	pop    %ebx
 8cb:	5e                   	pop    %esi
 8cc:	5f                   	pop    %edi
 8cd:	5d                   	pop    %ebp
 8ce:	c3                   	ret    
 8cf:	90                   	nop

000008d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8dc:	8b 3d 00 17 00 00    	mov    0x1700,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e2:	8d 70 07             	lea    0x7(%eax),%esi
 8e5:	c1 ee 03             	shr    $0x3,%esi
 8e8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 8eb:	85 ff                	test   %edi,%edi
 8ed:	0f 84 9d 00 00 00    	je     990 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 8f5:	8b 4a 04             	mov    0x4(%edx),%ecx
 8f8:	39 f1                	cmp    %esi,%ecx
 8fa:	73 6a                	jae    966 <malloc+0x96>
 8fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 901:	39 de                	cmp    %ebx,%esi
 903:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 906:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 90d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 910:	eb 17                	jmp    929 <malloc+0x59>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 91a:	8b 48 04             	mov    0x4(%eax),%ecx
 91d:	39 f1                	cmp    %esi,%ecx
 91f:	73 4f                	jae    970 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 921:	8b 3d 00 17 00 00    	mov    0x1700,%edi
 927:	89 c2                	mov    %eax,%edx
 929:	39 d7                	cmp    %edx,%edi
 92b:	75 eb                	jne    918 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 92d:	83 ec 0c             	sub    $0xc,%esp
 930:	ff 75 e4             	push   -0x1c(%ebp)
 933:	e8 73 fc ff ff       	call   5ab <sbrk>
  if(p == (char*)-1)
 938:	83 c4 10             	add    $0x10,%esp
 93b:	83 f8 ff             	cmp    $0xffffffff,%eax
 93e:	74 1c                	je     95c <malloc+0x8c>
  hp->s.size = nu;
 940:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 943:	83 ec 0c             	sub    $0xc,%esp
 946:	83 c0 08             	add    $0x8,%eax
 949:	50                   	push   %eax
 94a:	e8 f1 fe ff ff       	call   840 <free>
  return freep;
 94f:	8b 15 00 17 00 00    	mov    0x1700,%edx
      if((p = morecore(nunits)) == 0)
 955:	83 c4 10             	add    $0x10,%esp
 958:	85 d2                	test   %edx,%edx
 95a:	75 bc                	jne    918 <malloc+0x48>
        return 0;
  }
}
 95c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 95f:	31 c0                	xor    %eax,%eax
}
 961:	5b                   	pop    %ebx
 962:	5e                   	pop    %esi
 963:	5f                   	pop    %edi
 964:	5d                   	pop    %ebp
 965:	c3                   	ret    
    if(p->s.size >= nunits){
 966:	89 d0                	mov    %edx,%eax
 968:	89 fa                	mov    %edi,%edx
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 970:	39 ce                	cmp    %ecx,%esi
 972:	74 4c                	je     9c0 <malloc+0xf0>
        p->s.size -= nunits;
 974:	29 f1                	sub    %esi,%ecx
 976:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 979:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 97c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 97f:	89 15 00 17 00 00    	mov    %edx,0x1700
}
 985:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 988:	83 c0 08             	add    $0x8,%eax
}
 98b:	5b                   	pop    %ebx
 98c:	5e                   	pop    %esi
 98d:	5f                   	pop    %edi
 98e:	5d                   	pop    %ebp
 98f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 990:	c7 05 00 17 00 00 04 	movl   $0x1704,0x1700
 997:	17 00 00 
    base.s.size = 0;
 99a:	bf 04 17 00 00       	mov    $0x1704,%edi
    base.s.ptr = freep = prevp = &base;
 99f:	c7 05 04 17 00 00 04 	movl   $0x1704,0x1704
 9a6:	17 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 9ab:	c7 05 08 17 00 00 00 	movl   $0x0,0x1708
 9b2:	00 00 00 
    if(p->s.size >= nunits){
 9b5:	e9 42 ff ff ff       	jmp    8fc <malloc+0x2c>
 9ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 9c0:	8b 08                	mov    (%eax),%ecx
 9c2:	89 0a                	mov    %ecx,(%edx)
 9c4:	eb b9                	jmp    97f <malloc+0xaf>
