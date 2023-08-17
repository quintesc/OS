
_test_13:     file format elf32-i386


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
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  int mypid = getpid();
  13:	e8 fb 04 00 00       	call   513 <getpid>

  int sret = setslice(mypid, 3);
  18:	83 ec 08             	sub    $0x8,%esp
  1b:	6a 03                	push   $0x3
  int mypid = getpid();
  1d:	89 c6                	mov    %eax,%esi
  int sret = setslice(mypid, 3);
  1f:	50                   	push   %eax
  20:	e8 0e 05 00 00       	call   533 <setslice>
  if (sret != 0) {
  25:	83 c4 10             	add    $0x10,%esp
  28:	85 c0                	test   %eax,%eax
  2a:	75 5f                	jne    8b <main+0x8b>
    printf(1, "XV6_SCHEDULER\t setslice(mypid, 3) failed\n");
    exit();
  }

  for (int i = 0; i < 2; ++i) {
    int pid_c = fork2(24);
  2c:	83 ec 0c             	sub    $0xc,%esp
  2f:	89 c3                	mov    %eax,%ebx
  31:	6a 18                	push   $0x18
  33:	e8 0b 05 00 00       	call   543 <fork2>
    if (pid_c < 0) {
  38:	83 c4 10             	add    $0x10,%esp
  3b:	85 c0                	test   %eax,%eax
  3d:	0f 88 03 01 00 00    	js     146 <main+0x146>
      printf(1, "XV6_SCHEDULER\t fork2(24) failed\n");
      exit();
    }

    if (pid_c == 0) {   // child
  43:	0f 84 10 01 00 00    	je     159 <main+0x159>
    int pid_c = fork2(24);
  49:	83 ec 0c             	sub    $0xc,%esp
  4c:	6a 18                	push   $0x18
  4e:	e8 f0 04 00 00       	call   543 <fork2>
    if (pid_c < 0) {
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	0f 88 e8 00 00 00    	js     146 <main+0x146>
    if (pid_c == 0) {   // child
  5e:	0f 84 f5 00 00 00    	je     159 <main+0x159>
      kill(-wc);  // an unelegant way of "using" the workload value to avoid optimized out
      exit();
    }
  }

  get_comp_info(mypid);
  64:	89 f0                	mov    %esi,%eax
  66:	e8 55 01 00 00       	call   1c0 <get_comp_info>
  if (compticks != 0 || sleepticks != 0) {
  6b:	a1 98 0e 00 00       	mov    0xe98,%eax
  70:	0b 05 94 0e 00 00    	or     0xe94,%eax
  76:	74 26                	je     9e <main+0x9e>
    printf(1, "XV6_SCHEDULER\t sleepticks and compticks should start with 0\n");
  78:	56                   	push   %esi
  79:	56                   	push   %esi
  7a:	68 f0 09 00 00       	push   $0x9f0
  7f:	6a 01                	push   $0x1
  81:	e8 8a 05 00 00       	call   610 <printf>
    exit();
  86:	e8 08 04 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t setslice(mypid, 3) failed\n");
  8b:	50                   	push   %eax
  8c:	50                   	push   %eax
  8d:	68 a0 09 00 00       	push   $0x9a0
  92:	6a 01                	push   $0x1
  94:	e8 77 05 00 00       	call   610 <printf>
    exit();
  99:	e8 f5 03 00 00       	call   493 <exit>
  }

  // Sleep for several ticks, > child timeslice, < 2 * child timeslice.
  // Depending on how students account for sleepticks, it might be +-1.
  sleep(30);
  9e:	83 ec 0c             	sub    $0xc,%esp
  a1:	6a 1e                	push   $0x1e
  a3:	e8 7b 04 00 00       	call   523 <sleep>

  get_comp_info(mypid);
  a8:	89 f0                	mov    %esi,%eax
  aa:	e8 11 01 00 00       	call   1c0 <get_comp_info>
  if (sleepticks < 29 || sleepticks > 31) {
  af:	a1 94 0e 00 00       	mov    0xe94,%eax
  b4:	83 c4 10             	add    $0x10,%esp
  b7:	8d 50 e3             	lea    -0x1d(%eax),%edx
  ba:	83 fa 02             	cmp    $0x2,%edx
  bd:	0f 87 bb 00 00 00    	ja     17e <main+0x17e>
    printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
              " sleep(30) - before workload\n", sleepticks);
    exit();
  } else if (compticks != 0) {
  c3:	8b 15 98 0e 00 00    	mov    0xe98,%edx
  int i = 0, j = 0;
  c9:	31 c0                	xor    %eax,%eax
  } else if (compticks != 0) {
  cb:	85 d2                	test   %edx,%edx
  cd:	0f 85 be 00 00 00    	jne    191 <main+0x191>
    j += i * j + 1;
  d3:	89 c1                	mov    %eax,%ecx
    i++;
  d5:	83 c0 01             	add    $0x1,%eax
    j += i * j + 1;
  d8:	0f af ca             	imul   %edx,%ecx
  db:	8d 54 0a 01          	lea    0x1(%edx,%ecx,1),%edx
  while (i < iters) {
  df:	3d 3a 09 bb 29       	cmp    $0x29bb093a,%eax
  e4:	75 ed                	jne    d3 <main+0xd3>
    exit();
  }

  // Do a workload, expect all comp ticks to be used.
  int wp = workload(700123450);
  kill(-wp);  // an unelegant way of "using" the workload value to avoid optimized out
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	f7 da                	neg    %edx
  eb:	52                   	push   %edx
  ec:	e8 d2 03 00 00       	call   4c3 <kill>

  get_comp_info(mypid);
  f1:	89 f0                	mov    %esi,%eax
  f3:	e8 c8 00 00 00       	call   1c0 <get_comp_info>
  if (sleepticks < 29 || sleepticks > 31) {
  f8:	a1 94 0e 00 00       	mov    0xe94,%eax
  fd:	83 c4 10             	add    $0x10,%esp
 100:	8d 50 e3             	lea    -0x1d(%eax),%edx
 103:	83 fa 02             	cmp    $0x2,%edx
 106:	77 2b                	ja     133 <main+0x133>
    printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
              " sleep(30) - after workload\n", sleepticks);
    exit();
  } else if (compticks != sleepticks) {
 108:	8b 15 98 0e 00 00    	mov    0xe98,%edx
 10e:	39 d0                	cmp    %edx,%eax
 110:	0f 85 8e 00 00 00    	jne    1a4 <main+0x1a4>
              " sleepticks %d\n", compticks, sleepticks);
    exit();
  }
  
  for (int i = 0; i < 2; ++i)
    wait();
 116:	e8 80 03 00 00       	call   49b <wait>
 11b:	e8 7b 03 00 00       	call   49b <wait>

  printf(1, "XV6_SCHEDULER\t SUCCESS\n");
 120:	50                   	push   %eax
 121:	50                   	push   %eax
 122:	68 43 0b 00 00       	push   $0xb43
 127:	6a 01                	push   $0x1
 129:	e8 e2 04 00 00       	call   610 <printf>
  exit();
 12e:	e8 60 03 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
 133:	52                   	push   %edx
 134:	50                   	push   %eax
 135:	68 b8 0a 00 00       	push   $0xab8
 13a:	6a 01                	push   $0x1
 13c:	e8 cf 04 00 00       	call   610 <printf>
    exit();
 141:	e8 4d 03 00 00       	call   493 <exit>
      printf(1, "XV6_SCHEDULER\t fork2(24) failed\n");
 146:	50                   	push   %eax
 147:	50                   	push   %eax
 148:	68 cc 09 00 00       	push   $0x9cc
 14d:	6a 01                	push   $0x1
 14f:	e8 bc 04 00 00       	call   610 <printf>
      exit();
 154:	e8 3a 03 00 00       	call   493 <exit>
  int i = 0, j = 0;
 159:	31 c0                	xor    %eax,%eax
    j += i * j + 1;
 15b:	89 c2                	mov    %eax,%edx
    i++;
 15d:	83 c0 01             	add    $0x1,%eax
    j += i * j + 1;
 160:	0f af d3             	imul   %ebx,%edx
 163:	8d 5c 13 01          	lea    0x1(%ebx,%edx,1),%ebx
  while (i < iters) {
 167:	3d 00 e9 a4 35       	cmp    $0x35a4e900,%eax
 16c:	75 ed                	jne    15b <main+0x15b>
      kill(-wc);  // an unelegant way of "using" the workload value to avoid optimized out
 16e:	83 ec 0c             	sub    $0xc,%esp
 171:	f7 db                	neg    %ebx
 173:	53                   	push   %ebx
 174:	e8 4a 03 00 00       	call   4c3 <kill>
      exit();
 179:	e8 15 03 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t sleepticks %d does not reflect"
 17e:	53                   	push   %ebx
 17f:	50                   	push   %eax
 180:	68 30 0a 00 00       	push   $0xa30
 185:	6a 01                	push   $0x1
 187:	e8 84 04 00 00       	call   610 <printf>
    exit();
 18c:	e8 02 03 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t compticks used %d should be 0 at this time\n", compticks);
 191:	51                   	push   %ecx
 192:	52                   	push   %edx
 193:	68 7c 0a 00 00       	push   $0xa7c
 198:	6a 01                	push   $0x1
 19a:	e8 71 04 00 00       	call   610 <printf>
    exit();
 19f:	e8 ef 02 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t compticks used %d does not equal"
 1a4:	50                   	push   %eax
 1a5:	52                   	push   %edx
 1a6:	68 04 0b 00 00       	push   $0xb04
 1ab:	6a 01                	push   $0x1
 1ad:	e8 5e 04 00 00       	call   610 <printf>
    exit();
 1b2:	e8 dc 02 00 00       	call   493 <exit>
 1b7:	66 90                	xchg   %ax,%ax
 1b9:	66 90                	xchg   %ax,%ax
 1bb:	66 90                	xchg   %ax,%ax
 1bd:	66 90                	xchg   %ax,%ax
 1bf:	90                   	nop

000001c0 <get_comp_info>:
static void get_comp_info(int pid) {
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	89 c3                	mov    %eax,%ebx
 1c6:	83 ec 10             	sub    $0x10,%esp
  int pret = getpinfo(&pstat);
 1c9:	68 a0 0e 00 00       	push   $0xea0
 1ce:	e8 78 03 00 00       	call   54b <getpinfo>
  if (pret != 0) {
 1d3:	83 c4 10             	add    $0x10,%esp
 1d6:	85 c0                	test   %eax,%eax
 1d8:	74 0e                	je     1e8 <get_comp_info+0x28>
 1da:	eb 50                	jmp    22c <get_comp_info+0x6c>
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = 0; i < NPROC; ++i) {
 1e0:	83 c0 01             	add    $0x1,%eax
 1e3:	83 f8 40             	cmp    $0x40,%eax
 1e6:	74 31                	je     219 <get_comp_info+0x59>
    if (pstat.inuse[i] == 1 && pstat.pid[i] == pid) {
 1e8:	83 3c 85 a0 0e 00 00 	cmpl   $0x1,0xea0(,%eax,4)
 1ef:	01 
 1f0:	75 ee                	jne    1e0 <get_comp_info+0x20>
 1f2:	3b 1c 85 a0 0f 00 00 	cmp    0xfa0(,%eax,4),%ebx
 1f9:	75 e5                	jne    1e0 <get_comp_info+0x20>
      compticks = pstat.compticks[i];
 1fb:	8b 14 85 a0 11 00 00 	mov    0x11a0(,%eax,4),%edx
      sleepticks = pstat.sleepticks[i];
 202:	8b 04 85 a0 13 00 00 	mov    0x13a0(,%eax,4),%eax
}
 209:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      compticks = pstat.compticks[i];
 20c:	89 15 98 0e 00 00    	mov    %edx,0xe98
      sleepticks = pstat.sleepticks[i];
 212:	a3 94 0e 00 00       	mov    %eax,0xe94
}
 217:	c9                   	leave  
 218:	c3                   	ret    
  printf(1, "XV6_SCHEDULER\t did not find process %d in the fetched pstat\n", pid);
 219:	50                   	push   %eax
 21a:	53                   	push   %ebx
 21b:	68 60 09 00 00       	push   $0x960
 220:	6a 01                	push   $0x1
 222:	e8 e9 03 00 00       	call   610 <printf>
  exit();
 227:	e8 67 02 00 00       	call   493 <exit>
    printf(1, "XV6_SCHEDULER\t getpinfo(&pstat) failed\n");
 22c:	52                   	push   %edx
 22d:	52                   	push   %edx
 22e:	68 38 09 00 00       	push   $0x938
 233:	6a 01                	push   $0x1
 235:	e8 d6 03 00 00       	call   610 <printf>
    exit();
 23a:	e8 54 02 00 00       	call   493 <exit>
 23f:	90                   	nop

00000240 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 240:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 241:	31 c0                	xor    %eax,%eax
{
 243:	89 e5                	mov    %esp,%ebp
 245:	53                   	push   %ebx
 246:	8b 4d 08             	mov    0x8(%ebp),%ecx
 249:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 250:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 254:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 257:	83 c0 01             	add    $0x1,%eax
 25a:	84 d2                	test   %dl,%dl
 25c:	75 f2                	jne    250 <strcpy+0x10>
    ;
  return os;
}
 25e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 261:	89 c8                	mov    %ecx,%eax
 263:	c9                   	leave  
 264:	c3                   	ret    
 265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 55 08             	mov    0x8(%ebp),%edx
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 27a:	0f b6 02             	movzbl (%edx),%eax
 27d:	84 c0                	test   %al,%al
 27f:	75 17                	jne    298 <strcmp+0x28>
 281:	eb 3a                	jmp    2bd <strcmp+0x4d>
 283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 287:	90                   	nop
 288:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 28c:	83 c2 01             	add    $0x1,%edx
 28f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 292:	84 c0                	test   %al,%al
 294:	74 1a                	je     2b0 <strcmp+0x40>
    p++, q++;
 296:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 298:	0f b6 19             	movzbl (%ecx),%ebx
 29b:	38 c3                	cmp    %al,%bl
 29d:	74 e9                	je     288 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 29f:	29 d8                	sub    %ebx,%eax
}
 2a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a4:	c9                   	leave  
 2a5:	c3                   	ret    
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 2b0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2b4:	31 c0                	xor    %eax,%eax
 2b6:	29 d8                	sub    %ebx,%eax
}
 2b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2bb:	c9                   	leave  
 2bc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 2bd:	0f b6 19             	movzbl (%ecx),%ebx
 2c0:	31 c0                	xor    %eax,%eax
 2c2:	eb db                	jmp    29f <strcmp+0x2f>
 2c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2cf:	90                   	nop

000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 2d6:	80 3a 00             	cmpb   $0x0,(%edx)
 2d9:	74 15                	je     2f0 <strlen+0x20>
 2db:	31 c0                	xor    %eax,%eax
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
 2e0:	83 c0 01             	add    $0x1,%eax
 2e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2e7:	89 c1                	mov    %eax,%ecx
 2e9:	75 f5                	jne    2e0 <strlen+0x10>
    ;
  return n;
}
 2eb:	89 c8                	mov    %ecx,%eax
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
 2ef:	90                   	nop
  for(n = 0; s[n]; n++)
 2f0:	31 c9                	xor    %ecx,%ecx
}
 2f2:	5d                   	pop    %ebp
 2f3:	89 c8                	mov    %ecx,%eax
 2f5:	c3                   	ret    
 2f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fd:	8d 76 00             	lea    0x0(%esi),%esi

00000300 <memset>:

void*
memset(void *dst, int c, uint n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 307:	8b 4d 10             	mov    0x10(%ebp),%ecx
 30a:	8b 45 0c             	mov    0xc(%ebp),%eax
 30d:	89 d7                	mov    %edx,%edi
 30f:	fc                   	cld    
 310:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 312:	8b 7d fc             	mov    -0x4(%ebp),%edi
 315:	89 d0                	mov    %edx,%eax
 317:	c9                   	leave  
 318:	c3                   	ret    
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <strchr>:

char*
strchr(const char *s, char c)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 32a:	0f b6 10             	movzbl (%eax),%edx
 32d:	84 d2                	test   %dl,%dl
 32f:	75 12                	jne    343 <strchr+0x23>
 331:	eb 1d                	jmp    350 <strchr+0x30>
 333:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 337:	90                   	nop
 338:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 33c:	83 c0 01             	add    $0x1,%eax
 33f:	84 d2                	test   %dl,%dl
 341:	74 0d                	je     350 <strchr+0x30>
    if(*s == c)
 343:	38 d1                	cmp    %dl,%cl
 345:	75 f1                	jne    338 <strchr+0x18>
      return (char*)s;
  return 0;
}
 347:	5d                   	pop    %ebp
 348:	c3                   	ret    
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 350:	31 c0                	xor    %eax,%eax
}
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop

00000360 <gets>:

char*
gets(char *buf, int max)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 365:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 368:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 369:	31 db                	xor    %ebx,%ebx
{
 36b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 36e:	eb 27                	jmp    397 <gets+0x37>
    cc = read(0, &c, 1);
 370:	83 ec 04             	sub    $0x4,%esp
 373:	6a 01                	push   $0x1
 375:	57                   	push   %edi
 376:	6a 00                	push   $0x0
 378:	e8 2e 01 00 00       	call   4ab <read>
    if(cc < 1)
 37d:	83 c4 10             	add    $0x10,%esp
 380:	85 c0                	test   %eax,%eax
 382:	7e 1d                	jle    3a1 <gets+0x41>
      break;
    buf[i++] = c;
 384:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 388:	8b 55 08             	mov    0x8(%ebp),%edx
 38b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 38f:	3c 0a                	cmp    $0xa,%al
 391:	74 1d                	je     3b0 <gets+0x50>
 393:	3c 0d                	cmp    $0xd,%al
 395:	74 19                	je     3b0 <gets+0x50>
  for(i=0; i+1 < max; ){
 397:	89 de                	mov    %ebx,%esi
 399:	83 c3 01             	add    $0x1,%ebx
 39c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 39f:	7c cf                	jl     370 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ab:	5b                   	pop    %ebx
 3ac:	5e                   	pop    %esi
 3ad:	5f                   	pop    %edi
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    
  buf[i] = '\0';
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
 3b3:	89 de                	mov    %ebx,%esi
 3b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 3b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bc:	5b                   	pop    %ebx
 3bd:	5e                   	pop    %esi
 3be:	5f                   	pop    %edi
 3bf:	5d                   	pop    %ebp
 3c0:	c3                   	ret    
 3c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3cf:	90                   	nop

000003d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d5:	83 ec 08             	sub    $0x8,%esp
 3d8:	6a 00                	push   $0x0
 3da:	ff 75 08             	push   0x8(%ebp)
 3dd:	e8 f1 00 00 00       	call   4d3 <open>
  if(fd < 0)
 3e2:	83 c4 10             	add    $0x10,%esp
 3e5:	85 c0                	test   %eax,%eax
 3e7:	78 27                	js     410 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3e9:	83 ec 08             	sub    $0x8,%esp
 3ec:	ff 75 0c             	push   0xc(%ebp)
 3ef:	89 c3                	mov    %eax,%ebx
 3f1:	50                   	push   %eax
 3f2:	e8 f4 00 00 00       	call   4eb <fstat>
  close(fd);
 3f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3fa:	89 c6                	mov    %eax,%esi
  close(fd);
 3fc:	e8 ba 00 00 00       	call   4bb <close>
  return r;
 401:	83 c4 10             	add    $0x10,%esp
}
 404:	8d 65 f8             	lea    -0x8(%ebp),%esp
 407:	89 f0                	mov    %esi,%eax
 409:	5b                   	pop    %ebx
 40a:	5e                   	pop    %esi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 410:	be ff ff ff ff       	mov    $0xffffffff,%esi
 415:	eb ed                	jmp    404 <stat+0x34>
 417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41e:	66 90                	xchg   %ax,%ax

00000420 <atoi>:

int
atoi(const char *s)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	53                   	push   %ebx
 424:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 427:	0f be 02             	movsbl (%edx),%eax
 42a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 42d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 430:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 435:	77 1e                	ja     455 <atoi+0x35>
 437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 440:	83 c2 01             	add    $0x1,%edx
 443:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 446:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 44a:	0f be 02             	movsbl (%edx),%eax
 44d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 450:	80 fb 09             	cmp    $0x9,%bl
 453:	76 eb                	jbe    440 <atoi+0x20>
  return n;
}
 455:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 458:	89 c8                	mov    %ecx,%eax
 45a:	c9                   	leave  
 45b:	c3                   	ret    
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	8b 45 10             	mov    0x10(%ebp),%eax
 467:	8b 55 08             	mov    0x8(%ebp),%edx
 46a:	56                   	push   %esi
 46b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 46e:	85 c0                	test   %eax,%eax
 470:	7e 13                	jle    485 <memmove+0x25>
 472:	01 d0                	add    %edx,%eax
  dst = vdst;
 474:	89 d7                	mov    %edx,%edi
 476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 480:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 481:	39 f8                	cmp    %edi,%eax
 483:	75 fb                	jne    480 <memmove+0x20>
  return vdst;
}
 485:	5e                   	pop    %esi
 486:	89 d0                	mov    %edx,%eax
 488:	5f                   	pop    %edi
 489:	5d                   	pop    %ebp
 48a:	c3                   	ret    

0000048b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 48b:	b8 01 00 00 00       	mov    $0x1,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <exit>:
SYSCALL(exit)
 493:	b8 02 00 00 00       	mov    $0x2,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <wait>:
SYSCALL(wait)
 49b:	b8 03 00 00 00       	mov    $0x3,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <pipe>:
SYSCALL(pipe)
 4a3:	b8 04 00 00 00       	mov    $0x4,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <read>:
SYSCALL(read)
 4ab:	b8 05 00 00 00       	mov    $0x5,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <write>:
SYSCALL(write)
 4b3:	b8 10 00 00 00       	mov    $0x10,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <close>:
SYSCALL(close)
 4bb:	b8 15 00 00 00       	mov    $0x15,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <kill>:
SYSCALL(kill)
 4c3:	b8 06 00 00 00       	mov    $0x6,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <exec>:
SYSCALL(exec)
 4cb:	b8 07 00 00 00       	mov    $0x7,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <open>:
SYSCALL(open)
 4d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <mknod>:
SYSCALL(mknod)
 4db:	b8 11 00 00 00       	mov    $0x11,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <unlink>:
SYSCALL(unlink)
 4e3:	b8 12 00 00 00       	mov    $0x12,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <fstat>:
SYSCALL(fstat)
 4eb:	b8 08 00 00 00       	mov    $0x8,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <link>:
SYSCALL(link)
 4f3:	b8 13 00 00 00       	mov    $0x13,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <mkdir>:
SYSCALL(mkdir)
 4fb:	b8 14 00 00 00       	mov    $0x14,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <chdir>:
SYSCALL(chdir)
 503:	b8 09 00 00 00       	mov    $0x9,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <dup>:
SYSCALL(dup)
 50b:	b8 0a 00 00 00       	mov    $0xa,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <getpid>:
SYSCALL(getpid)
 513:	b8 0b 00 00 00       	mov    $0xb,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <sbrk>:
SYSCALL(sbrk)
 51b:	b8 0c 00 00 00       	mov    $0xc,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <sleep>:
SYSCALL(sleep)
 523:	b8 0d 00 00 00       	mov    $0xd,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <uptime>:
SYSCALL(uptime)
 52b:	b8 0e 00 00 00       	mov    $0xe,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <setslice>:
SYSCALL(setslice)
 533:	b8 16 00 00 00       	mov    $0x16,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <getslice>:
SYSCALL(getslice)
 53b:	b8 17 00 00 00       	mov    $0x17,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <fork2>:
SYSCALL(fork2)
 543:	b8 18 00 00 00       	mov    $0x18,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <getpinfo>:
SYSCALL(getpinfo)
 54b:	b8 19 00 00 00       	mov    $0x19,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    
 553:	66 90                	xchg   %ax,%ax
 555:	66 90                	xchg   %ax,%ax
 557:	66 90                	xchg   %ax,%ax
 559:	66 90                	xchg   %ax,%ax
 55b:	66 90                	xchg   %ax,%ax
 55d:	66 90                	xchg   %ax,%ax
 55f:	90                   	nop

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 3c             	sub    $0x3c,%esp
 569:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 56c:	89 d1                	mov    %edx,%ecx
{
 56e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 571:	85 d2                	test   %edx,%edx
 573:	0f 89 7f 00 00 00    	jns    5f8 <printint+0x98>
 579:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 57d:	74 79                	je     5f8 <printint+0x98>
    neg = 1;
 57f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 586:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 588:	31 db                	xor    %ebx,%ebx
 58a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 58d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 590:	89 c8                	mov    %ecx,%eax
 592:	31 d2                	xor    %edx,%edx
 594:	89 cf                	mov    %ecx,%edi
 596:	f7 75 c4             	divl   -0x3c(%ebp)
 599:	0f b6 92 bc 0b 00 00 	movzbl 0xbbc(%edx),%edx
 5a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 5a3:	89 d8                	mov    %ebx,%eax
 5a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 5a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 5ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 5ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 5b1:	76 dd                	jbe    590 <printint+0x30>
  if(neg)
 5b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 5b6:	85 c9                	test   %ecx,%ecx
 5b8:	74 0c                	je     5c6 <printint+0x66>
    buf[i++] = '-';
 5ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 5bf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 5c1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 5c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 5c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 5cd:	eb 07                	jmp    5d6 <printint+0x76>
 5cf:	90                   	nop
    putc(fd, buf[i]);
 5d0:	0f b6 13             	movzbl (%ebx),%edx
 5d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 5d6:	83 ec 04             	sub    $0x4,%esp
 5d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 5dc:	6a 01                	push   $0x1
 5de:	56                   	push   %esi
 5df:	57                   	push   %edi
 5e0:	e8 ce fe ff ff       	call   4b3 <write>
  while(--i >= 0)
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	39 de                	cmp    %ebx,%esi
 5ea:	75 e4                	jne    5d0 <printint+0x70>
}
 5ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
 5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 5ff:	eb 87                	jmp    588 <printint+0x28>
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop

00000610 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
 616:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 619:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 61c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 61f:	0f b6 13             	movzbl (%ebx),%edx
 622:	84 d2                	test   %dl,%dl
 624:	74 6a                	je     690 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 626:	8d 45 10             	lea    0x10(%ebp),%eax
 629:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 62c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 62f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 631:	89 45 d0             	mov    %eax,-0x30(%ebp)
 634:	eb 36                	jmp    66c <printf+0x5c>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
 640:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 643:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 648:	83 f8 25             	cmp    $0x25,%eax
 64b:	74 15                	je     662 <printf+0x52>
  write(fd, &c, 1);
 64d:	83 ec 04             	sub    $0x4,%esp
 650:	88 55 e7             	mov    %dl,-0x19(%ebp)
 653:	6a 01                	push   $0x1
 655:	57                   	push   %edi
 656:	56                   	push   %esi
 657:	e8 57 fe ff ff       	call   4b3 <write>
 65c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 65f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 662:	0f b6 13             	movzbl (%ebx),%edx
 665:	83 c3 01             	add    $0x1,%ebx
 668:	84 d2                	test   %dl,%dl
 66a:	74 24                	je     690 <printf+0x80>
    c = fmt[i] & 0xff;
 66c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 66f:	85 c9                	test   %ecx,%ecx
 671:	74 cd                	je     640 <printf+0x30>
      }
    } else if(state == '%'){
 673:	83 f9 25             	cmp    $0x25,%ecx
 676:	75 ea                	jne    662 <printf+0x52>
      if(c == 'd'){
 678:	83 f8 25             	cmp    $0x25,%eax
 67b:	0f 84 07 01 00 00    	je     788 <printf+0x178>
 681:	83 e8 63             	sub    $0x63,%eax
 684:	83 f8 15             	cmp    $0x15,%eax
 687:	77 17                	ja     6a0 <printf+0x90>
 689:	ff 24 85 64 0b 00 00 	jmp    *0xb64(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 690:	8d 65 f4             	lea    -0xc(%ebp),%esp
 693:	5b                   	pop    %ebx
 694:	5e                   	pop    %esi
 695:	5f                   	pop    %edi
 696:	5d                   	pop    %ebp
 697:	c3                   	ret    
 698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 6a6:	6a 01                	push   $0x1
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6ae:	e8 00 fe ff ff       	call   4b3 <write>
        putc(fd, c);
 6b3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 6b7:	83 c4 0c             	add    $0xc,%esp
 6ba:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6bd:	6a 01                	push   $0x1
 6bf:	57                   	push   %edi
 6c0:	56                   	push   %esi
 6c1:	e8 ed fd ff ff       	call   4b3 <write>
        putc(fd, c);
 6c6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6c9:	31 c9                	xor    %ecx,%ecx
 6cb:	eb 95                	jmp    662 <printf+0x52>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6d8:	6a 00                	push   $0x0
 6da:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	89 f0                	mov    %esi,%eax
 6e1:	e8 7a fe ff ff       	call   560 <printint>
        ap++;
 6e6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6ea:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ed:	31 c9                	xor    %ecx,%ecx
 6ef:	e9 6e ff ff ff       	jmp    662 <printf+0x52>
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6fb:	8b 10                	mov    (%eax),%edx
        ap++;
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 703:	85 d2                	test   %edx,%edx
 705:	0f 84 8d 00 00 00    	je     798 <printf+0x188>
        while(*s != 0){
 70b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 70e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 710:	84 c0                	test   %al,%al
 712:	0f 84 4a ff ff ff    	je     662 <printf+0x52>
 718:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 71b:	89 d3                	mov    %edx,%ebx
 71d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
          s++;
 723:	83 c3 01             	add    $0x1,%ebx
 726:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 729:	6a 01                	push   $0x1
 72b:	57                   	push   %edi
 72c:	56                   	push   %esi
 72d:	e8 81 fd ff ff       	call   4b3 <write>
        while(*s != 0){
 732:	0f b6 03             	movzbl (%ebx),%eax
 735:	83 c4 10             	add    $0x10,%esp
 738:	84 c0                	test   %al,%al
 73a:	75 e4                	jne    720 <printf+0x110>
      state = 0;
 73c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 73f:	31 c9                	xor    %ecx,%ecx
 741:	e9 1c ff ff ff       	jmp    662 <printf+0x52>
 746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 0a 00 00 00       	mov    $0xa,%ecx
 758:	6a 01                	push   $0x1
 75a:	e9 7b ff ff ff       	jmp    6da <printf+0xca>
 75f:	90                   	nop
        putc(fd, *ap);
 760:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 763:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 766:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 768:	6a 01                	push   $0x1
 76a:	57                   	push   %edi
 76b:	56                   	push   %esi
        putc(fd, *ap);
 76c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 76f:	e8 3f fd ff ff       	call   4b3 <write>
        ap++;
 774:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 778:	83 c4 10             	add    $0x10,%esp
      state = 0;
 77b:	31 c9                	xor    %ecx,%ecx
 77d:	e9 e0 fe ff ff       	jmp    662 <printf+0x52>
 782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 788:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 78b:	83 ec 04             	sub    $0x4,%esp
 78e:	e9 2a ff ff ff       	jmp    6bd <printf+0xad>
 793:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 797:	90                   	nop
          s = "(null)";
 798:	ba 5b 0b 00 00       	mov    $0xb5b,%edx
        while(*s != 0){
 79d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7a0:	b8 28 00 00 00       	mov    $0x28,%eax
 7a5:	89 d3                	mov    %edx,%ebx
 7a7:	e9 74 ff ff ff       	jmp    720 <printf+0x110>
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 a0 15 00 00       	mov    0x15a0,%eax
{
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	57                   	push   %edi
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c8:	89 c2                	mov    %eax,%edx
 7ca:	8b 00                	mov    (%eax),%eax
 7cc:	39 ca                	cmp    %ecx,%edx
 7ce:	73 30                	jae    800 <free+0x50>
 7d0:	39 c1                	cmp    %eax,%ecx
 7d2:	72 04                	jb     7d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	39 c2                	cmp    %eax,%edx
 7d6:	72 f0                	jb     7c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7de:	39 f8                	cmp    %edi,%eax
 7e0:	74 30                	je     812 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7e5:	8b 42 04             	mov    0x4(%edx),%eax
 7e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7eb:	39 f1                	cmp    %esi,%ecx
 7ed:	74 3a                	je     829 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7ef:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7f1:	5b                   	pop    %ebx
  freep = p;
 7f2:	89 15 a0 15 00 00    	mov    %edx,0x15a0
}
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	39 c2                	cmp    %eax,%edx
 802:	72 c4                	jb     7c8 <free+0x18>
 804:	39 c1                	cmp    %eax,%ecx
 806:	73 c0                	jae    7c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 808:	8b 73 fc             	mov    -0x4(%ebx),%esi
 80b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 80e:	39 f8                	cmp    %edi,%eax
 810:	75 d0                	jne    7e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 812:	03 70 04             	add    0x4(%eax),%esi
 815:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 818:	8b 02                	mov    (%edx),%eax
 81a:	8b 00                	mov    (%eax),%eax
 81c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 81f:	8b 42 04             	mov    0x4(%edx),%eax
 822:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 825:	39 f1                	cmp    %esi,%ecx
 827:	75 c6                	jne    7ef <free+0x3f>
    p->s.size += bp->s.size;
 829:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 82c:	89 15 a0 15 00 00    	mov    %edx,0x15a0
    p->s.size += bp->s.size;
 832:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 835:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 838:	89 0a                	mov    %ecx,(%edx)
}
 83a:	5b                   	pop    %ebx
 83b:	5e                   	pop    %esi
 83c:	5f                   	pop    %edi
 83d:	5d                   	pop    %ebp
 83e:	c3                   	ret    
 83f:	90                   	nop

00000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 84c:	8b 3d a0 15 00 00    	mov    0x15a0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 852:	8d 70 07             	lea    0x7(%eax),%esi
 855:	c1 ee 03             	shr    $0x3,%esi
 858:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 85b:	85 ff                	test   %edi,%edi
 85d:	0f 84 9d 00 00 00    	je     900 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 863:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 865:	8b 4a 04             	mov    0x4(%edx),%ecx
 868:	39 f1                	cmp    %esi,%ecx
 86a:	73 6a                	jae    8d6 <malloc+0x96>
 86c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 871:	39 de                	cmp    %ebx,%esi
 873:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 876:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 87d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 880:	eb 17                	jmp    899 <malloc+0x59>
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 88a:	8b 48 04             	mov    0x4(%eax),%ecx
 88d:	39 f1                	cmp    %esi,%ecx
 88f:	73 4f                	jae    8e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	8b 3d a0 15 00 00    	mov    0x15a0,%edi
 897:	89 c2                	mov    %eax,%edx
 899:	39 d7                	cmp    %edx,%edi
 89b:	75 eb                	jne    888 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 89d:	83 ec 0c             	sub    $0xc,%esp
 8a0:	ff 75 e4             	push   -0x1c(%ebp)
 8a3:	e8 73 fc ff ff       	call   51b <sbrk>
  if(p == (char*)-1)
 8a8:	83 c4 10             	add    $0x10,%esp
 8ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ae:	74 1c                	je     8cc <malloc+0x8c>
  hp->s.size = nu;
 8b0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8b3:	83 ec 0c             	sub    $0xc,%esp
 8b6:	83 c0 08             	add    $0x8,%eax
 8b9:	50                   	push   %eax
 8ba:	e8 f1 fe ff ff       	call   7b0 <free>
  return freep;
 8bf:	8b 15 a0 15 00 00    	mov    0x15a0,%edx
      if((p = morecore(nunits)) == 0)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	85 d2                	test   %edx,%edx
 8ca:	75 bc                	jne    888 <malloc+0x48>
        return 0;
  }
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8cf:	31 c0                	xor    %eax,%eax
}
 8d1:	5b                   	pop    %ebx
 8d2:	5e                   	pop    %esi
 8d3:	5f                   	pop    %edi
 8d4:	5d                   	pop    %ebp
 8d5:	c3                   	ret    
    if(p->s.size >= nunits){
 8d6:	89 d0                	mov    %edx,%eax
 8d8:	89 fa                	mov    %edi,%edx
 8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8e0:	39 ce                	cmp    %ecx,%esi
 8e2:	74 4c                	je     930 <malloc+0xf0>
        p->s.size -= nunits;
 8e4:	29 f1                	sub    %esi,%ecx
 8e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8ec:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8ef:	89 15 a0 15 00 00    	mov    %edx,0x15a0
}
 8f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8f8:	83 c0 08             	add    $0x8,%eax
}
 8fb:	5b                   	pop    %ebx
 8fc:	5e                   	pop    %esi
 8fd:	5f                   	pop    %edi
 8fe:	5d                   	pop    %ebp
 8ff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 900:	c7 05 a0 15 00 00 a4 	movl   $0x15a4,0x15a0
 907:	15 00 00 
    base.s.size = 0;
 90a:	bf a4 15 00 00       	mov    $0x15a4,%edi
    base.s.ptr = freep = prevp = &base;
 90f:	c7 05 a4 15 00 00 a4 	movl   $0x15a4,0x15a4
 916:	15 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 919:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 91b:	c7 05 a8 15 00 00 00 	movl   $0x0,0x15a8
 922:	00 00 00 
    if(p->s.size >= nunits){
 925:	e9 42 ff ff ff       	jmp    86c <malloc+0x2c>
 92a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 930:	8b 08                	mov    (%eax),%ecx
 932:	89 0a                	mov    %ecx,(%edx)
 934:	eb b9                	jmp    8ef <malloc+0xaf>
