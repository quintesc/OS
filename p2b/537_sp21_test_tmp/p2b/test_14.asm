
_test_14:     file format elf32-i386


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
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int mypid = getpid();
   f:	e8 bf 04 00 00       	call   4d3 <getpid>

  int sret = setslice(mypid, 3);
  14:	83 ec 08             	sub    $0x8,%esp
  17:	6a 03                	push   $0x3
  int mypid = getpid();
  19:	89 c3                	mov    %eax,%ebx
  int sret = setslice(mypid, 3);
  1b:	50                   	push   %eax
  1c:	e8 d2 04 00 00       	call   4f3 <setslice>
  if (sret != 0) {
  21:	83 c4 10             	add    $0x10,%esp
  24:	85 c0                	test   %eax,%eax
  26:	74 13                	je     3b <main+0x3b>
    printf(1, "XV6_SCHEDULER\t setslice(mypid, 3) failed\n");
  28:	50                   	push   %eax
  29:	50                   	push   %eax
  2a:	68 60 09 00 00       	push   $0x960
  2f:	6a 01                	push   $0x1
  31:	e8 9a 05 00 00       	call   5d0 <printf>
    exit();
  36:	e8 18 04 00 00       	call   453 <exit>
  }

  int pid_c = fork2(75);  // fork child with very large timeslice
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	6a 4b                	push   $0x4b
  40:	e8 be 04 00 00       	call   503 <fork2>
  if (pid_c < 0) {
  45:	83 c4 10             	add    $0x10,%esp
  48:	85 c0                	test   %eax,%eax
  4a:	78 28                	js     74 <main+0x74>
    printf(1, "XV6_SCHEDULER\t fork2(75) failed\n");
    exit();
  }

  if (pid_c == 0) {   // child
  4c:	75 39                	jne    87 <main+0x87>
  int i = 0, j = 0;
  4e:	31 d2                	xor    %edx,%edx
    j += i * j + 1;
  50:	89 d1                	mov    %edx,%ecx
    i++;
  52:	83 c2 01             	add    $0x1,%edx
    j += i * j + 1;
  55:	0f af c8             	imul   %eax,%ecx
  58:	8d 44 08 01          	lea    0x1(%eax,%ecx,1),%eax
  while (i < iters) {
  5c:	81 fa 00 e9 a4 35    	cmp    $0x35a4e900,%edx
  62:	75 ec                	jne    50 <main+0x50>
    int wc = workload(900000000);
    kill(-wc);  // an unelegant way of "using" the workload value to avoid optimized out
  64:	83 ec 0c             	sub    $0xc,%esp
  67:	f7 d8                	neg    %eax
  69:	50                   	push   %eax
  6a:	e8 14 04 00 00       	call   483 <kill>
    exit();
  6f:	e8 df 03 00 00       	call   453 <exit>
    printf(1, "XV6_SCHEDULER\t fork2(75) failed\n");
  74:	50                   	push   %eax
  75:	50                   	push   %eax
  76:	68 8c 09 00 00       	push   $0x98c
  7b:	6a 01                	push   $0x1
  7d:	e8 4e 05 00 00       	call   5d0 <printf>
    exit();
  82:	e8 cc 03 00 00       	call   453 <exit>

  } else {  // parent
    get_comp_info(mypid);
  87:	89 d8                	mov    %ebx,%eax
  89:	e8 f2 00 00 00       	call   180 <get_comp_info>
    if (compticks != 0 || sleepticks != 0) {
  8e:	a1 54 0e 00 00       	mov    0xe54,%eax
  93:	0b 05 50 0e 00 00    	or     0xe50,%eax
  99:	74 13                	je     ae <main+0xae>
      printf(1, "XV6_SCHEDULER\t sleepticks and compticks should start with 0\n");
  9b:	50                   	push   %eax
  9c:	50                   	push   %eax
  9d:	68 b0 09 00 00       	push   $0x9b0
  a2:	6a 01                	push   $0x1
  a4:	e8 27 05 00 00       	call   5d0 <printf>
      exit();
  a9:	e8 a5 03 00 00       	call   453 <exit>
    }

    // Sleep for several ticks, < child timeslice.
    // Depending on how students account for sleepticks, it might be +-1.
    sleep(15);
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	6a 0f                	push   $0xf
  b3:	e8 2b 04 00 00       	call   4e3 <sleep>

    get_comp_info(mypid);
  b8:	89 d8                	mov    %ebx,%eax
  ba:	e8 c1 00 00 00       	call   180 <get_comp_info>
    if (sleepticks < 14 || sleepticks > 16) {
  bf:	a1 50 0e 00 00       	mov    0xe50,%eax
  c4:	83 c4 10             	add    $0x10,%esp
  c7:	8d 50 f2             	lea    -0xe(%eax),%edx
  ca:	83 fa 02             	cmp    $0x2,%edx
  cd:	77 5e                	ja     12d <main+0x12d>
      printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
                " sleep(15) - before workload\n", sleepticks);
      exit();
    } else if (compticks != 0) {
  cf:	8b 15 54 0e 00 00    	mov    0xe54,%edx
  int i = 0, j = 0;
  d5:	31 c0                	xor    %eax,%eax
    } else if (compticks != 0) {
  d7:	85 d2                	test   %edx,%edx
  d9:	75 65                	jne    140 <main+0x140>
    j += i * j + 1;
  db:	89 c1                	mov    %eax,%ecx
    i++;
  dd:	83 c0 01             	add    $0x1,%eax
    j += i * j + 1;
  e0:	0f af ca             	imul   %edx,%ecx
  e3:	8d 54 0a 01          	lea    0x1(%edx,%ecx,1),%edx
  while (i < iters) {
  e7:	3d 3a 09 bb 29       	cmp    $0x29bb093a,%eax
  ec:	75 ed                	jne    db <main+0xdb>
      exit();
    }

    // Do a workload, expect all comp ticks to be used.
    int wp = workload(700123450);
    kill(-wp);  // an unelegant way of "using" the workload value to avoid optimized out
  ee:	83 ec 0c             	sub    $0xc,%esp
  f1:	f7 da                	neg    %edx
  f3:	52                   	push   %edx
  f4:	e8 8a 03 00 00       	call   483 <kill>

    get_comp_info(mypid);
  f9:	89 d8                	mov    %ebx,%eax
  fb:	e8 80 00 00 00       	call   180 <get_comp_info>
    if (sleepticks < 14 || sleepticks > 16) {
 100:	a1 50 0e 00 00       	mov    0xe50,%eax
 105:	83 c4 10             	add    $0x10,%esp
 108:	8d 50 f2             	lea    -0xe(%eax),%edx
 10b:	83 fa 02             	cmp    $0x2,%edx
 10e:	77 43                	ja     153 <main+0x153>
      printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
                " sleep(15) - after workload\n", sleepticks);
      exit();
    } else if (compticks != sleepticks) {
 110:	8b 15 54 0e 00 00    	mov    0xe54,%edx
 116:	39 d0                	cmp    %edx,%eax
 118:	74 4c                	je     166 <main+0x166>
      printf(1, "XV6_SCHEDULER\t compticks used %d does not equal"
 11a:	50                   	push   %eax
 11b:	52                   	push   %edx
 11c:	68 c4 0a 00 00       	push   $0xac4
 121:	6a 01                	push   $0x1
 123:	e8 a8 04 00 00       	call   5d0 <printf>
                " sleepticks %d\n", compticks, sleepticks);
      exit();
 128:	e8 26 03 00 00       	call   453 <exit>
      printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
 12d:	53                   	push   %ebx
 12e:	50                   	push   %eax
 12f:	68 f0 09 00 00       	push   $0x9f0
 134:	6a 01                	push   $0x1
 136:	e8 95 04 00 00       	call   5d0 <printf>
      exit();
 13b:	e8 13 03 00 00       	call   453 <exit>
      printf(1, "XV6_SCHEDULER\t compticks used %d should be 0 at this time\n", compticks);
 140:	51                   	push   %ecx
 141:	52                   	push   %edx
 142:	68 3c 0a 00 00       	push   $0xa3c
 147:	6a 01                	push   $0x1
 149:	e8 82 04 00 00       	call   5d0 <printf>
      exit();
 14e:	e8 00 03 00 00       	call   453 <exit>
      printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
 153:	52                   	push   %edx
 154:	50                   	push   %eax
 155:	68 78 0a 00 00       	push   $0xa78
 15a:	6a 01                	push   $0x1
 15c:	e8 6f 04 00 00       	call   5d0 <printf>
      exit();
 161:	e8 ed 02 00 00       	call   453 <exit>
    }
    
    wait();
 166:	e8 f0 02 00 00       	call   45b <wait>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
 16b:	50                   	push   %eax
 16c:	50                   	push   %eax
 16d:	68 03 0b 00 00       	push   $0xb03
 172:	6a 01                	push   $0x1
 174:	e8 57 04 00 00       	call   5d0 <printf>
  }

  exit();
 179:	e8 d5 02 00 00       	call   453 <exit>
 17e:	66 90                	xchg   %ax,%ax

00000180 <get_comp_info>:
static void get_comp_info(int pid) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	89 c3                	mov    %eax,%ebx
 186:	83 ec 10             	sub    $0x10,%esp
  int pret = getpinfo(&pstat);
 189:	68 60 0e 00 00       	push   $0xe60
 18e:	e8 78 03 00 00       	call   50b <getpinfo>
  if (pret != 0) {
 193:	83 c4 10             	add    $0x10,%esp
 196:	85 c0                	test   %eax,%eax
 198:	74 0e                	je     1a8 <get_comp_info+0x28>
 19a:	eb 50                	jmp    1ec <get_comp_info+0x6c>
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < NPROC; ++i) {
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	83 f8 40             	cmp    $0x40,%eax
 1a6:	74 31                	je     1d9 <get_comp_info+0x59>
    if (pstat.inuse[i] == 1 && pstat.pid[i] == pid) {
 1a8:	83 3c 85 60 0e 00 00 	cmpl   $0x1,0xe60(,%eax,4)
 1af:	01 
 1b0:	75 ee                	jne    1a0 <get_comp_info+0x20>
 1b2:	3b 1c 85 60 0f 00 00 	cmp    0xf60(,%eax,4),%ebx
 1b9:	75 e5                	jne    1a0 <get_comp_info+0x20>
      compticks = pstat.compticks[i];
 1bb:	8b 14 85 60 11 00 00 	mov    0x1160(,%eax,4),%edx
      sleepticks = pstat.sleepticks[i];
 1c2:	8b 04 85 60 13 00 00 	mov    0x1360(,%eax,4),%eax
}
 1c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      compticks = pstat.compticks[i];
 1cc:	89 15 54 0e 00 00    	mov    %edx,0xe54
      sleepticks = pstat.sleepticks[i];
 1d2:	a3 50 0e 00 00       	mov    %eax,0xe50
}
 1d7:	c9                   	leave  
 1d8:	c3                   	ret    
  printf(1, "XV6_SCHEDULER\t did not find process %d in the fetched pstat\n", pid);
 1d9:	50                   	push   %eax
 1da:	53                   	push   %ebx
 1db:	68 20 09 00 00       	push   $0x920
 1e0:	6a 01                	push   $0x1
 1e2:	e8 e9 03 00 00       	call   5d0 <printf>
  exit();
 1e7:	e8 67 02 00 00       	call   453 <exit>
    printf(1, "XV6_SCHEDULER\t getpinfo(&pstat) failed\n");
 1ec:	52                   	push   %edx
 1ed:	52                   	push   %edx
 1ee:	68 f8 08 00 00       	push   $0x8f8
 1f3:	6a 01                	push   $0x1
 1f5:	e8 d6 03 00 00       	call   5d0 <printf>
    exit();
 1fa:	e8 54 02 00 00       	call   453 <exit>
 1ff:	90                   	nop

00000200 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 200:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 201:	31 c0                	xor    %eax,%eax
{
 203:	89 e5                	mov    %esp,%ebp
 205:	53                   	push   %ebx
 206:	8b 4d 08             	mov    0x8(%ebp),%ecx
 209:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 210:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 214:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 217:	83 c0 01             	add    $0x1,%eax
 21a:	84 d2                	test   %dl,%dl
 21c:	75 f2                	jne    210 <strcpy+0x10>
    ;
  return os;
}
 21e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 221:	89 c8                	mov    %ecx,%eax
 223:	c9                   	leave  
 224:	c3                   	ret    
 225:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
 237:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23a:	0f b6 02             	movzbl (%edx),%eax
 23d:	84 c0                	test   %al,%al
 23f:	75 17                	jne    258 <strcmp+0x28>
 241:	eb 3a                	jmp    27d <strcmp+0x4d>
 243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 247:	90                   	nop
 248:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 24c:	83 c2 01             	add    $0x1,%edx
 24f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 252:	84 c0                	test   %al,%al
 254:	74 1a                	je     270 <strcmp+0x40>
    p++, q++;
 256:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 258:	0f b6 19             	movzbl (%ecx),%ebx
 25b:	38 c3                	cmp    %al,%bl
 25d:	74 e9                	je     248 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 25f:	29 d8                	sub    %ebx,%eax
}
 261:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 264:	c9                   	leave  
 265:	c3                   	ret    
 266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 270:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 274:	31 c0                	xor    %eax,%eax
 276:	29 d8                	sub    %ebx,%eax
}
 278:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 27b:	c9                   	leave  
 27c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 27d:	0f b6 19             	movzbl (%ecx),%ebx
 280:	31 c0                	xor    %eax,%eax
 282:	eb db                	jmp    25f <strcmp+0x2f>
 284:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 28f:	90                   	nop

00000290 <strlen>:

uint
strlen(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 296:	80 3a 00             	cmpb   $0x0,(%edx)
 299:	74 15                	je     2b0 <strlen+0x20>
 29b:	31 c0                	xor    %eax,%eax
 29d:	8d 76 00             	lea    0x0(%esi),%esi
 2a0:	83 c0 01             	add    $0x1,%eax
 2a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2a7:	89 c1                	mov    %eax,%ecx
 2a9:	75 f5                	jne    2a0 <strlen+0x10>
    ;
  return n;
}
 2ab:	89 c8                	mov    %ecx,%eax
 2ad:	5d                   	pop    %ebp
 2ae:	c3                   	ret    
 2af:	90                   	nop
  for(n = 0; s[n]; n++)
 2b0:	31 c9                	xor    %ecx,%ecx
}
 2b2:	5d                   	pop    %ebp
 2b3:	89 c8                	mov    %ecx,%eax
 2b5:	c3                   	ret    
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cd:	89 d7                	mov    %edx,%edi
 2cf:	fc                   	cld    
 2d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2d5:	89 d0                	mov    %edx,%eax
 2d7:	c9                   	leave  
 2d8:	c3                   	ret    
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <strchr>:

char*
strchr(const char *s, char c)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ea:	0f b6 10             	movzbl (%eax),%edx
 2ed:	84 d2                	test   %dl,%dl
 2ef:	75 12                	jne    303 <strchr+0x23>
 2f1:	eb 1d                	jmp    310 <strchr+0x30>
 2f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f7:	90                   	nop
 2f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2fc:	83 c0 01             	add    $0x1,%eax
 2ff:	84 d2                	test   %dl,%dl
 301:	74 0d                	je     310 <strchr+0x30>
    if(*s == c)
 303:	38 d1                	cmp    %dl,%cl
 305:	75 f1                	jne    2f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 307:	5d                   	pop    %ebp
 308:	c3                   	ret    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 310:	31 c0                	xor    %eax,%eax
}
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 31f:	90                   	nop

00000320 <gets>:

char*
gets(char *buf, int max)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 325:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 328:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 329:	31 db                	xor    %ebx,%ebx
{
 32b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 32e:	eb 27                	jmp    357 <gets+0x37>
    cc = read(0, &c, 1);
 330:	83 ec 04             	sub    $0x4,%esp
 333:	6a 01                	push   $0x1
 335:	57                   	push   %edi
 336:	6a 00                	push   $0x0
 338:	e8 2e 01 00 00       	call   46b <read>
    if(cc < 1)
 33d:	83 c4 10             	add    $0x10,%esp
 340:	85 c0                	test   %eax,%eax
 342:	7e 1d                	jle    361 <gets+0x41>
      break;
    buf[i++] = c;
 344:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 348:	8b 55 08             	mov    0x8(%ebp),%edx
 34b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 34f:	3c 0a                	cmp    $0xa,%al
 351:	74 1d                	je     370 <gets+0x50>
 353:	3c 0d                	cmp    $0xd,%al
 355:	74 19                	je     370 <gets+0x50>
  for(i=0; i+1 < max; ){
 357:	89 de                	mov    %ebx,%esi
 359:	83 c3 01             	add    $0x1,%ebx
 35c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 35f:	7c cf                	jl     330 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 361:	8b 45 08             	mov    0x8(%ebp),%eax
 364:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 368:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36b:	5b                   	pop    %ebx
 36c:	5e                   	pop    %esi
 36d:	5f                   	pop    %edi
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    
  buf[i] = '\0';
 370:	8b 45 08             	mov    0x8(%ebp),%eax
 373:	89 de                	mov    %ebx,%esi
 375:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 379:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37c:	5b                   	pop    %ebx
 37d:	5e                   	pop    %esi
 37e:	5f                   	pop    %edi
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38f:	90                   	nop

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 395:	83 ec 08             	sub    $0x8,%esp
 398:	6a 00                	push   $0x0
 39a:	ff 75 08             	push   0x8(%ebp)
 39d:	e8 f1 00 00 00       	call   493 <open>
  if(fd < 0)
 3a2:	83 c4 10             	add    $0x10,%esp
 3a5:	85 c0                	test   %eax,%eax
 3a7:	78 27                	js     3d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3a9:	83 ec 08             	sub    $0x8,%esp
 3ac:	ff 75 0c             	push   0xc(%ebp)
 3af:	89 c3                	mov    %eax,%ebx
 3b1:	50                   	push   %eax
 3b2:	e8 f4 00 00 00       	call   4ab <fstat>
  close(fd);
 3b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3ba:	89 c6                	mov    %eax,%esi
  close(fd);
 3bc:	e8 ba 00 00 00       	call   47b <close>
  return r;
 3c1:	83 c4 10             	add    $0x10,%esp
}
 3c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3c7:	89 f0                	mov    %esi,%eax
 3c9:	5b                   	pop    %ebx
 3ca:	5e                   	pop    %esi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3d5:	eb ed                	jmp    3c4 <stat+0x34>
 3d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3de:	66 90                	xchg   %ax,%ax

000003e0 <atoi>:

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	0f be 02             	movsbl (%edx),%eax
 3ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3f5:	77 1e                	ja     415 <atoi+0x35>
 3f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 400:	83 c2 01             	add    $0x1,%edx
 403:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 406:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 40a:	0f be 02             	movsbl (%edx),%eax
 40d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 410:	80 fb 09             	cmp    $0x9,%bl
 413:	76 eb                	jbe    400 <atoi+0x20>
  return n;
}
 415:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 418:	89 c8                	mov    %ecx,%eax
 41a:	c9                   	leave  
 41b:	c3                   	ret    
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	8b 45 10             	mov    0x10(%ebp),%eax
 427:	8b 55 08             	mov    0x8(%ebp),%edx
 42a:	56                   	push   %esi
 42b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 42e:	85 c0                	test   %eax,%eax
 430:	7e 13                	jle    445 <memmove+0x25>
 432:	01 d0                	add    %edx,%eax
  dst = vdst;
 434:	89 d7                	mov    %edx,%edi
 436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 440:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 441:	39 f8                	cmp    %edi,%eax
 443:	75 fb                	jne    440 <memmove+0x20>
  return vdst;
}
 445:	5e                   	pop    %esi
 446:	89 d0                	mov    %edx,%eax
 448:	5f                   	pop    %edi
 449:	5d                   	pop    %ebp
 44a:	c3                   	ret    

0000044b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44b:	b8 01 00 00 00       	mov    $0x1,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <exit>:
SYSCALL(exit)
 453:	b8 02 00 00 00       	mov    $0x2,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <wait>:
SYSCALL(wait)
 45b:	b8 03 00 00 00       	mov    $0x3,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <pipe>:
SYSCALL(pipe)
 463:	b8 04 00 00 00       	mov    $0x4,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <read>:
SYSCALL(read)
 46b:	b8 05 00 00 00       	mov    $0x5,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <write>:
SYSCALL(write)
 473:	b8 10 00 00 00       	mov    $0x10,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <close>:
SYSCALL(close)
 47b:	b8 15 00 00 00       	mov    $0x15,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <kill>:
SYSCALL(kill)
 483:	b8 06 00 00 00       	mov    $0x6,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <exec>:
SYSCALL(exec)
 48b:	b8 07 00 00 00       	mov    $0x7,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <open>:
SYSCALL(open)
 493:	b8 0f 00 00 00       	mov    $0xf,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <mknod>:
SYSCALL(mknod)
 49b:	b8 11 00 00 00       	mov    $0x11,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <unlink>:
SYSCALL(unlink)
 4a3:	b8 12 00 00 00       	mov    $0x12,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <fstat>:
SYSCALL(fstat)
 4ab:	b8 08 00 00 00       	mov    $0x8,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <link>:
SYSCALL(link)
 4b3:	b8 13 00 00 00       	mov    $0x13,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <mkdir>:
SYSCALL(mkdir)
 4bb:	b8 14 00 00 00       	mov    $0x14,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <chdir>:
SYSCALL(chdir)
 4c3:	b8 09 00 00 00       	mov    $0x9,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <dup>:
SYSCALL(dup)
 4cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <getpid>:
SYSCALL(getpid)
 4d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <sbrk>:
SYSCALL(sbrk)
 4db:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <sleep>:
SYSCALL(sleep)
 4e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <uptime>:
SYSCALL(uptime)
 4eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <setslice>:
SYSCALL(setslice)
 4f3:	b8 16 00 00 00       	mov    $0x16,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <getslice>:
SYSCALL(getslice)
 4fb:	b8 17 00 00 00       	mov    $0x17,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <fork2>:
SYSCALL(fork2)
 503:	b8 18 00 00 00       	mov    $0x18,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <getpinfo>:
SYSCALL(getpinfo)
 50b:	b8 19 00 00 00       	mov    $0x19,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    
 513:	66 90                	xchg   %ax,%ax
 515:	66 90                	xchg   %ax,%ax
 517:	66 90                	xchg   %ax,%ax
 519:	66 90                	xchg   %ax,%ax
 51b:	66 90                	xchg   %ax,%ax
 51d:	66 90                	xchg   %ax,%ax
 51f:	90                   	nop

00000520 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 3c             	sub    $0x3c,%esp
 529:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 52c:	89 d1                	mov    %edx,%ecx
{
 52e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 531:	85 d2                	test   %edx,%edx
 533:	0f 89 7f 00 00 00    	jns    5b8 <printint+0x98>
 539:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 53d:	74 79                	je     5b8 <printint+0x98>
    neg = 1;
 53f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 546:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 548:	31 db                	xor    %ebx,%ebx
 54a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 54d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 550:	89 c8                	mov    %ecx,%eax
 552:	31 d2                	xor    %edx,%edx
 554:	89 cf                	mov    %ecx,%edi
 556:	f7 75 c4             	divl   -0x3c(%ebp)
 559:	0f b6 92 7c 0b 00 00 	movzbl 0xb7c(%edx),%edx
 560:	89 45 c0             	mov    %eax,-0x40(%ebp)
 563:	89 d8                	mov    %ebx,%eax
 565:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 568:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 56b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 56e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 571:	76 dd                	jbe    550 <printint+0x30>
  if(neg)
 573:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 576:	85 c9                	test   %ecx,%ecx
 578:	74 0c                	je     586 <printint+0x66>
    buf[i++] = '-';
 57a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 57f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 581:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 586:	8b 7d b8             	mov    -0x48(%ebp),%edi
 589:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 58d:	eb 07                	jmp    596 <printint+0x76>
 58f:	90                   	nop
    putc(fd, buf[i]);
 590:	0f b6 13             	movzbl (%ebx),%edx
 593:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 596:	83 ec 04             	sub    $0x4,%esp
 599:	88 55 d7             	mov    %dl,-0x29(%ebp)
 59c:	6a 01                	push   $0x1
 59e:	56                   	push   %esi
 59f:	57                   	push   %edi
 5a0:	e8 ce fe ff ff       	call   473 <write>
  while(--i >= 0)
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	39 de                	cmp    %ebx,%esi
 5aa:	75 e4                	jne    590 <printint+0x70>
}
 5ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 5bf:	eb 87                	jmp    548 <printint+0x28>
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 5dc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 13             	movzbl (%ebx),%edx
 5e2:	84 d2                	test   %dl,%dl
 5e4:	74 6a                	je     650 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 5e6:	8d 45 10             	lea    0x10(%ebp),%eax
 5e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5ec:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5ef:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 5f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f4:	eb 36                	jmp    62c <printf+0x5c>
 5f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 603:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 608:	83 f8 25             	cmp    $0x25,%eax
 60b:	74 15                	je     622 <printf+0x52>
  write(fd, &c, 1);
 60d:	83 ec 04             	sub    $0x4,%esp
 610:	88 55 e7             	mov    %dl,-0x19(%ebp)
 613:	6a 01                	push   $0x1
 615:	57                   	push   %edi
 616:	56                   	push   %esi
 617:	e8 57 fe ff ff       	call   473 <write>
 61c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 61f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 622:	0f b6 13             	movzbl (%ebx),%edx
 625:	83 c3 01             	add    $0x1,%ebx
 628:	84 d2                	test   %dl,%dl
 62a:	74 24                	je     650 <printf+0x80>
    c = fmt[i] & 0xff;
 62c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 62f:	85 c9                	test   %ecx,%ecx
 631:	74 cd                	je     600 <printf+0x30>
      }
    } else if(state == '%'){
 633:	83 f9 25             	cmp    $0x25,%ecx
 636:	75 ea                	jne    622 <printf+0x52>
      if(c == 'd'){
 638:	83 f8 25             	cmp    $0x25,%eax
 63b:	0f 84 07 01 00 00    	je     748 <printf+0x178>
 641:	83 e8 63             	sub    $0x63,%eax
 644:	83 f8 15             	cmp    $0x15,%eax
 647:	77 17                	ja     660 <printf+0x90>
 649:	ff 24 85 24 0b 00 00 	jmp    *0xb24(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 650:	8d 65 f4             	lea    -0xc(%ebp),%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 666:	6a 01                	push   $0x1
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66e:	e8 00 fe ff ff       	call   473 <write>
        putc(fd, c);
 673:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 677:	83 c4 0c             	add    $0xc,%esp
 67a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 67d:	6a 01                	push   $0x1
 67f:	57                   	push   %edi
 680:	56                   	push   %esi
 681:	e8 ed fd ff ff       	call   473 <write>
        putc(fd, c);
 686:	83 c4 10             	add    $0x10,%esp
      state = 0;
 689:	31 c9                	xor    %ecx,%ecx
 68b:	eb 95                	jmp    622 <printf+0x52>
 68d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 10 00 00 00       	mov    $0x10,%ecx
 698:	6a 00                	push   $0x0
 69a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 69d:	8b 10                	mov    (%eax),%edx
 69f:	89 f0                	mov    %esi,%eax
 6a1:	e8 7a fe ff ff       	call   520 <printint>
        ap++;
 6a6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6aa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ad:	31 c9                	xor    %ecx,%ecx
 6af:	e9 6e ff ff ff       	jmp    622 <printf+0x52>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6bb:	8b 10                	mov    (%eax),%edx
        ap++;
 6bd:	83 c0 04             	add    $0x4,%eax
 6c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6c3:	85 d2                	test   %edx,%edx
 6c5:	0f 84 8d 00 00 00    	je     758 <printf+0x188>
        while(*s != 0){
 6cb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 6ce:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 6d0:	84 c0                	test   %al,%al
 6d2:	0f 84 4a ff ff ff    	je     622 <printf+0x52>
 6d8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6db:	89 d3                	mov    %edx,%ebx
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6e3:	83 c3 01             	add    $0x1,%ebx
 6e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	57                   	push   %edi
 6ec:	56                   	push   %esi
 6ed:	e8 81 fd ff ff       	call   473 <write>
        while(*s != 0){
 6f2:	0f b6 03             	movzbl (%ebx),%eax
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	84 c0                	test   %al,%al
 6fa:	75 e4                	jne    6e0 <printf+0x110>
      state = 0;
 6fc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 6ff:	31 c9                	xor    %ecx,%ecx
 701:	e9 1c ff ff ff       	jmp    622 <printf+0x52>
 706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 0a 00 00 00       	mov    $0xa,%ecx
 718:	6a 01                	push   $0x1
 71a:	e9 7b ff ff ff       	jmp    69a <printf+0xca>
 71f:	90                   	nop
        putc(fd, *ap);
 720:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 723:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 726:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 728:	6a 01                	push   $0x1
 72a:	57                   	push   %edi
 72b:	56                   	push   %esi
        putc(fd, *ap);
 72c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 72f:	e8 3f fd ff ff       	call   473 <write>
        ap++;
 734:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 738:	83 c4 10             	add    $0x10,%esp
      state = 0;
 73b:	31 c9                	xor    %ecx,%ecx
 73d:	e9 e0 fe ff ff       	jmp    622 <printf+0x52>
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 748:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 74b:	83 ec 04             	sub    $0x4,%esp
 74e:	e9 2a ff ff ff       	jmp    67d <printf+0xad>
 753:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 757:	90                   	nop
          s = "(null)";
 758:	ba 1b 0b 00 00       	mov    $0xb1b,%edx
        while(*s != 0){
 75d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 760:	b8 28 00 00 00       	mov    $0x28,%eax
 765:	89 d3                	mov    %edx,%ebx
 767:	e9 74 ff ff ff       	jmp    6e0 <printf+0x110>
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

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
 771:	a1 60 15 00 00       	mov    0x1560,%eax
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 77e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 788:	89 c2                	mov    %eax,%edx
 78a:	8b 00                	mov    (%eax),%eax
 78c:	39 ca                	cmp    %ecx,%edx
 78e:	73 30                	jae    7c0 <free+0x50>
 790:	39 c1                	cmp    %eax,%ecx
 792:	72 04                	jb     798 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	39 c2                	cmp    %eax,%edx
 796:	72 f0                	jb     788 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 798:	8b 73 fc             	mov    -0x4(%ebx),%esi
 79b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 79e:	39 f8                	cmp    %edi,%eax
 7a0:	74 30                	je     7d2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7a5:	8b 42 04             	mov    0x4(%edx),%eax
 7a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7ab:	39 f1                	cmp    %esi,%ecx
 7ad:	74 3a                	je     7e9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7b1:	5b                   	pop    %ebx
  freep = p;
 7b2:	89 15 60 15 00 00    	mov    %edx,0x1560
}
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret    
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c0:	39 c2                	cmp    %eax,%edx
 7c2:	72 c4                	jb     788 <free+0x18>
 7c4:	39 c1                	cmp    %eax,%ecx
 7c6:	73 c0                	jae    788 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 7c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ce:	39 f8                	cmp    %edi,%eax
 7d0:	75 d0                	jne    7a2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 7d2:	03 70 04             	add    0x4(%eax),%esi
 7d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	8b 02                	mov    (%edx),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7df:	8b 42 04             	mov    0x4(%edx),%eax
 7e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7e5:	39 f1                	cmp    %esi,%ecx
 7e7:	75 c6                	jne    7af <free+0x3f>
    p->s.size += bp->s.size;
 7e9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7ec:	89 15 60 15 00 00    	mov    %edx,0x1560
    p->s.size += bp->s.size;
 7f2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7f5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7f8:	89 0a                	mov    %ecx,(%edx)
}
 7fa:	5b                   	pop    %ebx
 7fb:	5e                   	pop    %esi
 7fc:	5f                   	pop    %edi
 7fd:	5d                   	pop    %ebp
 7fe:	c3                   	ret    
 7ff:	90                   	nop

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 3d 60 15 00 00    	mov    0x1560,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 70 07             	lea    0x7(%eax),%esi
 815:	c1 ee 03             	shr    $0x3,%esi
 818:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 81b:	85 ff                	test   %edi,%edi
 81d:	0f 84 9d 00 00 00    	je     8c0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 823:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 825:	8b 4a 04             	mov    0x4(%edx),%ecx
 828:	39 f1                	cmp    %esi,%ecx
 82a:	73 6a                	jae    896 <malloc+0x96>
 82c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 831:	39 de                	cmp    %ebx,%esi
 833:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 836:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 83d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 840:	eb 17                	jmp    859 <malloc+0x59>
 842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 848:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 84a:	8b 48 04             	mov    0x4(%eax),%ecx
 84d:	39 f1                	cmp    %esi,%ecx
 84f:	73 4f                	jae    8a0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 851:	8b 3d 60 15 00 00    	mov    0x1560,%edi
 857:	89 c2                	mov    %eax,%edx
 859:	39 d7                	cmp    %edx,%edi
 85b:	75 eb                	jne    848 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 85d:	83 ec 0c             	sub    $0xc,%esp
 860:	ff 75 e4             	push   -0x1c(%ebp)
 863:	e8 73 fc ff ff       	call   4db <sbrk>
  if(p == (char*)-1)
 868:	83 c4 10             	add    $0x10,%esp
 86b:	83 f8 ff             	cmp    $0xffffffff,%eax
 86e:	74 1c                	je     88c <malloc+0x8c>
  hp->s.size = nu;
 870:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 873:	83 ec 0c             	sub    $0xc,%esp
 876:	83 c0 08             	add    $0x8,%eax
 879:	50                   	push   %eax
 87a:	e8 f1 fe ff ff       	call   770 <free>
  return freep;
 87f:	8b 15 60 15 00 00    	mov    0x1560,%edx
      if((p = morecore(nunits)) == 0)
 885:	83 c4 10             	add    $0x10,%esp
 888:	85 d2                	test   %edx,%edx
 88a:	75 bc                	jne    848 <malloc+0x48>
        return 0;
  }
}
 88c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 88f:	31 c0                	xor    %eax,%eax
}
 891:	5b                   	pop    %ebx
 892:	5e                   	pop    %esi
 893:	5f                   	pop    %edi
 894:	5d                   	pop    %ebp
 895:	c3                   	ret    
    if(p->s.size >= nunits){
 896:	89 d0                	mov    %edx,%eax
 898:	89 fa                	mov    %edi,%edx
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8a0:	39 ce                	cmp    %ecx,%esi
 8a2:	74 4c                	je     8f0 <malloc+0xf0>
        p->s.size -= nunits;
 8a4:	29 f1                	sub    %esi,%ecx
 8a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8ac:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8af:	89 15 60 15 00 00    	mov    %edx,0x1560
}
 8b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8b8:	83 c0 08             	add    $0x8,%eax
}
 8bb:	5b                   	pop    %ebx
 8bc:	5e                   	pop    %esi
 8bd:	5f                   	pop    %edi
 8be:	5d                   	pop    %ebp
 8bf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 8c0:	c7 05 60 15 00 00 64 	movl   $0x1564,0x1560
 8c7:	15 00 00 
    base.s.size = 0;
 8ca:	bf 64 15 00 00       	mov    $0x1564,%edi
    base.s.ptr = freep = prevp = &base;
 8cf:	c7 05 64 15 00 00 64 	movl   $0x1564,0x1564
 8d6:	15 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 8db:	c7 05 68 15 00 00 00 	movl   $0x0,0x1568
 8e2:	00 00 00 
    if(p->s.size >= nunits){
 8e5:	e9 42 ff ff ff       	jmp    82c <malloc+0x2c>
 8ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb b9                	jmp    8af <malloc+0xaf>
