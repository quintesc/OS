
_test_fdcnt:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  test_fd_close(MAX_FD);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);
}

int main(int argc, char *argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  test();
   6:	e8 15 01 00 00       	call   120 <test>
  exit();
   b:	e8 43 07 00 00       	call   753 <exit>

00000010 <test_fd_open>:
void test_fd_open(int num_fd) {
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	56                   	push   %esi
  14:	8b 75 08             	mov    0x8(%ebp),%esi
  17:	53                   	push   %ebx
  for (i = 0; i < num_fd; i++) {
  18:	85 f6                	test   %esi,%esi
  1a:	7e 4f                	jle    6b <test_fd_open+0x5b>
  1c:	31 db                	xor    %ebx,%ebx
  1e:	eb 07                	jmp    27 <test_fd_open+0x17>
  20:	83 c3 01             	add    $0x1,%ebx
  23:	39 de                	cmp    %ebx,%esi
  25:	74 44                	je     6b <test_fd_open+0x5b>
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
  27:	a1 cc 0f 00 00       	mov    0xfcc,%eax
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
  2c:	83 ec 08             	sub    $0x8,%esp
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
  2f:	8d 53 30             	lea    0x30(%ebx),%edx
    fd_array[i] = -1;
  32:	c7 04 9d e0 0f 00 00 	movl   $0xffffffff,0xfe0(,%ebx,4)
  39:	ff ff ff ff 
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
  3d:	88 50 08             	mov    %dl,0x8(%eax)
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
  40:	68 02 02 00 00       	push   $0x202
  45:	50                   	push   %eax
  46:	e8 48 07 00 00       	call   793 <open>
    if (fd_array[i] < 0) {
  4b:	83 c4 10             	add    $0x10,%esp
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
  4e:	89 04 9d e0 0f 00 00 	mov    %eax,0xfe0(,%ebx,4)
    if (fd_array[i] < 0) {
  55:	85 c0                	test   %eax,%eax
  57:	79 c7                	jns    20 <test_fd_open+0x10>
      printf(1, "open failed\n");
  59:	83 ec 08             	sub    $0x8,%esp
  5c:	68 d8 0b 00 00       	push   $0xbd8
  61:	6a 01                	push   $0x1
  63:	e8 48 08 00 00       	call   8b0 <printf>
  68:	83 c4 10             	add    $0x10,%esp
}
  6b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  6e:	5b                   	pop    %ebx
  6f:	5e                   	pop    %esi
  70:	5d                   	pop    %ebp
  71:	c3                   	ret    
  72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000080 <test_fd_close>:
void test_fd_close(int num_fd) {
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	8b 75 08             	mov    0x8(%ebp),%esi
  87:	53                   	push   %ebx
  for (i = 0; i < num_fd; i++) {
  88:	85 f6                	test   %esi,%esi
  8a:	7e 46                	jle    d2 <test_fd_close+0x52>
  8c:	31 db                	xor    %ebx,%ebx
  8e:	eb 07                	jmp    97 <test_fd_close+0x17>
  90:	83 c3 01             	add    $0x1,%ebx
  93:	39 de                	cmp    %ebx,%esi
  95:	74 3b                	je     d2 <test_fd_close+0x52>
    if (fd_array[i] >= 0) {
  97:	8b 04 9d e0 0f 00 00 	mov    0xfe0(,%ebx,4),%eax
  9e:	85 c0                	test   %eax,%eax
  a0:	78 ee                	js     90 <test_fd_close+0x10>
      int ret = close(fd_array[i]);
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	50                   	push   %eax
  a6:	e8 d0 06 00 00       	call   77b <close>
      if (ret == 0)
  ab:	83 c4 10             	add    $0x10,%esp
  ae:	85 c0                	test   %eax,%eax
  b0:	75 2e                	jne    e0 <test_fd_close+0x60>
        printf(1, "close fd:%d success\n", fd_array[i]);
  b2:	83 ec 04             	sub    $0x4,%esp
  b5:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  for (i = 0; i < num_fd; i++) {
  bc:	83 c3 01             	add    $0x1,%ebx
        printf(1, "close fd:%d success\n", fd_array[i]);
  bf:	68 e5 0b 00 00       	push   $0xbe5
  c4:	6a 01                	push   $0x1
  c6:	e8 e5 07 00 00       	call   8b0 <printf>
  cb:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < num_fd; i++) {
  ce:	39 de                	cmp    %ebx,%esi
  d0:	75 c5                	jne    97 <test_fd_close+0x17>
}
  d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d5:	5b                   	pop    %ebx
  d6:	5e                   	pop    %esi
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "close fd:%d failed\n", fd_array[i]);
  e0:	83 ec 04             	sub    $0x4,%esp
  e3:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  ea:	68 fa 0b 00 00       	push   $0xbfa
  ef:	6a 01                	push   $0x1
  f1:	e8 ba 07 00 00       	call   8b0 <printf>
  f6:	83 c4 10             	add    $0x10,%esp
  f9:	eb 95                	jmp    90 <test_fd_close+0x10>
  fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop

00000100 <test_print>:
void test_print(int num_fd_open, int num_closed) {
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 08             	sub    $0x8,%esp
  printf(1, "%d %d\n", num_fd_open, num_closed);
 106:	ff 75 0c             	push   0xc(%ebp)
 109:	ff 75 08             	push   0x8(%ebp)
 10c:	68 0e 0c 00 00       	push   $0xc0e
 111:	6a 01                	push   $0x1
 113:	e8 98 07 00 00       	call   8b0 <printf>
}
 118:	83 c4 10             	add    $0x10,%esp
 11b:	c9                   	leave  
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <test>:
void test() {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
  int num_fd_open = getfdcount(&num_closed);
 125:	8d 75 e4             	lea    -0x1c(%ebp),%esi
void test() {
 128:	53                   	push   %ebx
  for (i = 0; i < num_fd; i++) {
 129:	31 db                	xor    %ebx,%ebx
void test() {
 12b:	83 ec 28             	sub    $0x28,%esp
  int num_closed = 0;
 12e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  int num_fd_open = getfdcount(&num_closed);
 135:	56                   	push   %esi
 136:	e8 b8 06 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 13b:	ff 75 e4             	push   -0x1c(%ebp)
 13e:	50                   	push   %eax
 13f:	68 0e 0c 00 00       	push   $0xc0e
 144:	6a 01                	push   $0x1
 146:	e8 65 07 00 00       	call   8b0 <printf>
 14b:	83 c4 20             	add    $0x20,%esp
 14e:	66 90                	xchg   %ax,%ax
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 150:	a1 cc 0f 00 00       	mov    0xfcc,%eax
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 155:	83 ec 08             	sub    $0x8,%esp
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 158:	8d 53 30             	lea    0x30(%ebx),%edx
    fd_array[i] = -1;
 15b:	c7 04 9d e0 0f 00 00 	movl   $0xffffffff,0xfe0(,%ebx,4)
 162:	ff ff ff ff 
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 166:	88 50 08             	mov    %dl,0x8(%eax)
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 169:	68 02 02 00 00       	push   $0x202
 16e:	50                   	push   %eax
 16f:	e8 1f 06 00 00       	call   793 <open>
    if (fd_array[i] < 0) {
 174:	83 c4 10             	add    $0x10,%esp
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 177:	89 04 9d e0 0f 00 00 	mov    %eax,0xfe0(,%ebx,4)
    if (fd_array[i] < 0) {
 17e:	85 c0                	test   %eax,%eax
 180:	0f 88 3a 03 00 00    	js     4c0 <test+0x3a0>
  for (i = 0; i < num_fd; i++) {
 186:	83 c3 01             	add    $0x1,%ebx
 189:	83 fb 05             	cmp    $0x5,%ebx
 18c:	75 c2                	jne    150 <test+0x30>
  num_fd_open = getfdcount(&num_closed);
 18e:	83 ec 0c             	sub    $0xc,%esp
  for (i = 0; i < num_fd; i++) {
 191:	31 db                	xor    %ebx,%ebx
  num_fd_open = getfdcount(&num_closed);
 193:	56                   	push   %esi
 194:	e8 5a 06 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 199:	ff 75 e4             	push   -0x1c(%ebp)
 19c:	50                   	push   %eax
 19d:	68 0e 0c 00 00       	push   $0xc0e
 1a2:	6a 01                	push   $0x1
 1a4:	e8 07 07 00 00       	call   8b0 <printf>
 1a9:	83 c4 20             	add    $0x20,%esp
 1ac:	eb 0a                	jmp    1b8 <test+0x98>
 1ae:	66 90                	xchg   %ax,%ax
  for (i = 0; i < num_fd; i++) {
 1b0:	83 c3 01             	add    $0x1,%ebx
 1b3:	83 fb 05             	cmp    $0x5,%ebx
 1b6:	74 40                	je     1f8 <test+0xd8>
    if (fd_array[i] >= 0) {
 1b8:	8b 04 9d e0 0f 00 00 	mov    0xfe0(,%ebx,4),%eax
 1bf:	85 c0                	test   %eax,%eax
 1c1:	78 ed                	js     1b0 <test+0x90>
      int ret = close(fd_array[i]);
 1c3:	83 ec 0c             	sub    $0xc,%esp
 1c6:	50                   	push   %eax
 1c7:	e8 af 05 00 00       	call   77b <close>
      if (ret == 0)
 1cc:	83 c4 10             	add    $0x10,%esp
 1cf:	85 c0                	test   %eax,%eax
 1d1:	0f 85 61 02 00 00    	jne    438 <test+0x318>
        printf(1, "close fd:%d success\n", fd_array[i]);
 1d7:	83 ec 04             	sub    $0x4,%esp
 1da:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  for (i = 0; i < num_fd; i++) {
 1e1:	83 c3 01             	add    $0x1,%ebx
        printf(1, "close fd:%d success\n", fd_array[i]);
 1e4:	68 e5 0b 00 00       	push   $0xbe5
 1e9:	6a 01                	push   $0x1
 1eb:	e8 c0 06 00 00       	call   8b0 <printf>
 1f0:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < num_fd; i++) {
 1f3:	83 fb 05             	cmp    $0x5,%ebx
 1f6:	75 c0                	jne    1b8 <test+0x98>
  num_fd_open = getfdcount(&num_closed);
 1f8:	83 ec 0c             	sub    $0xc,%esp
  for (i = 0; i < num_fd; i++) {
 1fb:	31 db                	xor    %ebx,%ebx
  num_fd_open = getfdcount(&num_closed);
 1fd:	56                   	push   %esi
 1fe:	e8 f0 05 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 203:	ff 75 e4             	push   -0x1c(%ebp)
 206:	50                   	push   %eax
  num_fd_open = getfdcount(&num_closed);
 207:	89 c7                	mov    %eax,%edi
  printf(1, "%d %d\n", num_fd_open, num_closed);
 209:	68 0e 0c 00 00       	push   $0xc0e
 20e:	6a 01                	push   $0x1
 210:	e8 9b 06 00 00       	call   8b0 <printf>
 215:	83 c4 20             	add    $0x20,%esp
 218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 220:	a1 cc 0f 00 00       	mov    0xfcc,%eax
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 225:	83 ec 08             	sub    $0x8,%esp
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 228:	8d 53 30             	lea    0x30(%ebx),%edx
    fd_array[i] = -1;
 22b:	c7 04 9d e0 0f 00 00 	movl   $0xffffffff,0xfe0(,%ebx,4)
 232:	ff ff ff ff 
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 236:	88 50 08             	mov    %dl,0x8(%eax)
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 239:	68 02 02 00 00       	push   $0x202
 23e:	50                   	push   %eax
 23f:	e8 4f 05 00 00       	call   793 <open>
    if (fd_array[i] < 0) {
 244:	83 c4 10             	add    $0x10,%esp
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 247:	89 04 9d e0 0f 00 00 	mov    %eax,0xfe0(,%ebx,4)
    if (fd_array[i] < 0) {
 24e:	85 c0                	test   %eax,%eax
 250:	0f 88 8a 02 00 00    	js     4e0 <test+0x3c0>
  for (i = 0; i < num_fd; i++) {
 256:	83 c3 01             	add    $0x1,%ebx
 259:	83 fb 05             	cmp    $0x5,%ebx
 25c:	75 c2                	jne    220 <test+0x100>
 25e:	31 db                	xor    %ebx,%ebx
 260:	eb 0e                	jmp    270 <test+0x150>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (i = 0; i < num_fd; i++) {
 268:	83 c3 01             	add    $0x1,%ebx
 26b:	83 fb 07             	cmp    $0x7,%ebx
 26e:	74 40                	je     2b0 <test+0x190>
    if (fd_array[i] >= 0) {
 270:	8b 04 9d e0 0f 00 00 	mov    0xfe0(,%ebx,4),%eax
 277:	85 c0                	test   %eax,%eax
 279:	78 ed                	js     268 <test+0x148>
      int ret = close(fd_array[i]);
 27b:	83 ec 0c             	sub    $0xc,%esp
 27e:	50                   	push   %eax
 27f:	e8 f7 04 00 00       	call   77b <close>
      if (ret == 0)
 284:	83 c4 10             	add    $0x10,%esp
 287:	85 c0                	test   %eax,%eax
 289:	0f 85 d1 01 00 00    	jne    460 <test+0x340>
        printf(1, "close fd:%d success\n", fd_array[i]);
 28f:	83 ec 04             	sub    $0x4,%esp
 292:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  for (i = 0; i < num_fd; i++) {
 299:	83 c3 01             	add    $0x1,%ebx
        printf(1, "close fd:%d success\n", fd_array[i]);
 29c:	68 e5 0b 00 00       	push   $0xbe5
 2a1:	6a 01                	push   $0x1
 2a3:	e8 08 06 00 00       	call   8b0 <printf>
 2a8:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < num_fd; i++) {
 2ab:	83 fb 07             	cmp    $0x7,%ebx
 2ae:	75 c0                	jne    270 <test+0x150>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 2b0:	ff 75 e4             	push   -0x1c(%ebp)
  for (i = 0; i < num_fd; i++) {
 2b3:	31 db                	xor    %ebx,%ebx
  printf(1, "%d %d\n", num_fd_open, num_closed);
 2b5:	57                   	push   %edi
 2b6:	68 0e 0c 00 00       	push   $0xc0e
 2bb:	6a 01                	push   $0x1
 2bd:	e8 ee 05 00 00       	call   8b0 <printf>
  test_fd_open(total_nums - num_fd_open);
 2c2:	b8 09 00 00 00       	mov    $0x9,%eax
 2c7:	29 f8                	sub    %edi,%eax
 2c9:	89 04 24             	mov    %eax,(%esp)
 2cc:	e8 3f fd ff ff       	call   10 <test_fd_open>
  num_fd_open = getfdcount(&num_closed);
 2d1:	89 34 24             	mov    %esi,(%esp)
 2d4:	e8 1a 05 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 2d9:	ff 75 e4             	push   -0x1c(%ebp)
 2dc:	50                   	push   %eax
 2dd:	68 0e 0c 00 00       	push   $0xc0e
 2e2:	6a 01                	push   $0x1
 2e4:	e8 c7 05 00 00       	call   8b0 <printf>
 2e9:	83 c4 20             	add    $0x20,%esp
 2ec:	eb 0a                	jmp    2f8 <test+0x1d8>
 2ee:	66 90                	xchg   %ax,%ax
  for (i = 0; i < num_fd; i++) {
 2f0:	83 c3 01             	add    $0x1,%ebx
 2f3:	83 fb 08             	cmp    $0x8,%ebx
 2f6:	74 40                	je     338 <test+0x218>
    if (fd_array[i] >= 0) {
 2f8:	8b 04 9d e0 0f 00 00 	mov    0xfe0(,%ebx,4),%eax
 2ff:	85 c0                	test   %eax,%eax
 301:	78 ed                	js     2f0 <test+0x1d0>
      int ret = close(fd_array[i]);
 303:	83 ec 0c             	sub    $0xc,%esp
 306:	50                   	push   %eax
 307:	e8 6f 04 00 00       	call   77b <close>
      if (ret == 0)
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	85 c0                	test   %eax,%eax
 311:	0f 85 69 01 00 00    	jne    480 <test+0x360>
        printf(1, "close fd:%d success\n", fd_array[i]);
 317:	83 ec 04             	sub    $0x4,%esp
 31a:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  for (i = 0; i < num_fd; i++) {
 321:	83 c3 01             	add    $0x1,%ebx
        printf(1, "close fd:%d success\n", fd_array[i]);
 324:	68 e5 0b 00 00       	push   $0xbe5
 329:	6a 01                	push   $0x1
 32b:	e8 80 05 00 00       	call   8b0 <printf>
 330:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < num_fd; i++) {
 333:	83 fb 08             	cmp    $0x8,%ebx
 336:	75 c0                	jne    2f8 <test+0x1d8>
  num_fd_open = getfdcount(&num_closed);
 338:	83 ec 0c             	sub    $0xc,%esp
  for (i = 0; i < num_fd; i++) {
 33b:	31 db                	xor    %ebx,%ebx
  num_fd_open = getfdcount(&num_closed);
 33d:	56                   	push   %esi
 33e:	e8 b0 04 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 343:	ff 75 e4             	push   -0x1c(%ebp)
 346:	50                   	push   %eax
 347:	68 0e 0c 00 00       	push   $0xc0e
 34c:	6a 01                	push   $0x1
 34e:	e8 5d 05 00 00       	call   8b0 <printf>
 353:	83 c4 20             	add    $0x20,%esp
 356:	eb 0b                	jmp    363 <test+0x243>
 358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
  for (i = 0; i < num_fd; i++) {
 360:	83 c3 01             	add    $0x1,%ebx
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 363:	a1 cc 0f 00 00       	mov    0xfcc,%eax
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 368:	83 ec 08             	sub    $0x8,%esp
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 36b:	8d 53 30             	lea    0x30(%ebx),%edx
    fd_array[i] = -1;
 36e:	c7 04 9d e0 0f 00 00 	movl   $0xffffffff,0xfe0(,%ebx,4)
 375:	ff ff ff ff 
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
 379:	88 50 08             	mov    %dl,0x8(%eax)
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 37c:	68 02 02 00 00       	push   $0x202
 381:	50                   	push   %eax
 382:	e8 0c 04 00 00       	call   793 <open>
    if (fd_array[i] < 0) {
 387:	83 c4 10             	add    $0x10,%esp
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
 38a:	89 04 9d e0 0f 00 00 	mov    %eax,0xfe0(,%ebx,4)
    if (fd_array[i] < 0) {
 391:	85 c0                	test   %eax,%eax
 393:	79 cb                	jns    360 <test+0x240>
      printf(1, "open failed\n");
 395:	83 ec 08             	sub    $0x8,%esp
  for (i = 0; i < num_fd; i++) {
 398:	31 db                	xor    %ebx,%ebx
      printf(1, "open failed\n");
 39a:	68 d8 0b 00 00       	push   $0xbd8
 39f:	6a 01                	push   $0x1
 3a1:	e8 0a 05 00 00       	call   8b0 <printf>
  num_fd_open = getfdcount(&num_closed);
 3a6:	89 34 24             	mov    %esi,(%esp)
 3a9:	e8 45 04 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 3ae:	ff 75 e4             	push   -0x1c(%ebp)
 3b1:	50                   	push   %eax
 3b2:	68 0e 0c 00 00       	push   $0xc0e
 3b7:	6a 01                	push   $0x1
 3b9:	e8 f2 04 00 00       	call   8b0 <printf>
 3be:	83 c4 20             	add    $0x20,%esp
 3c1:	eb 0d                	jmp    3d0 <test+0x2b0>
 3c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c7:	90                   	nop
  for (i = 0; i < num_fd; i++) {
 3c8:	83 c3 01             	add    $0x1,%ebx
 3cb:	83 fb 09             	cmp    $0x9,%ebx
 3ce:	74 40                	je     410 <test+0x2f0>
    if (fd_array[i] >= 0) {
 3d0:	8b 04 9d e0 0f 00 00 	mov    0xfe0(,%ebx,4),%eax
 3d7:	85 c0                	test   %eax,%eax
 3d9:	78 ed                	js     3c8 <test+0x2a8>
      int ret = close(fd_array[i]);
 3db:	83 ec 0c             	sub    $0xc,%esp
 3de:	50                   	push   %eax
 3df:	e8 97 03 00 00       	call   77b <close>
      if (ret == 0)
 3e4:	83 c4 10             	add    $0x10,%esp
 3e7:	85 c0                	test   %eax,%eax
 3e9:	0f 85 b1 00 00 00    	jne    4a0 <test+0x380>
        printf(1, "close fd:%d success\n", fd_array[i]);
 3ef:	83 ec 04             	sub    $0x4,%esp
 3f2:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
  for (i = 0; i < num_fd; i++) {
 3f9:	83 c3 01             	add    $0x1,%ebx
        printf(1, "close fd:%d success\n", fd_array[i]);
 3fc:	68 e5 0b 00 00       	push   $0xbe5
 401:	6a 01                	push   $0x1
 403:	e8 a8 04 00 00       	call   8b0 <printf>
 408:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < num_fd; i++) {
 40b:	83 fb 09             	cmp    $0x9,%ebx
 40e:	75 c0                	jne    3d0 <test+0x2b0>
  num_fd_open = getfdcount(&num_closed);
 410:	83 ec 0c             	sub    $0xc,%esp
 413:	56                   	push   %esi
 414:	e8 da 03 00 00       	call   7f3 <getfdcount>
  printf(1, "%d %d\n", num_fd_open, num_closed);
 419:	ff 75 e4             	push   -0x1c(%ebp)
 41c:	50                   	push   %eax
 41d:	68 0e 0c 00 00       	push   $0xc0e
 422:	6a 01                	push   $0x1
 424:	e8 87 04 00 00       	call   8b0 <printf>
}
 429:	83 c4 20             	add    $0x20,%esp
 42c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "close fd:%d failed\n", fd_array[i]);
 438:	83 ec 04             	sub    $0x4,%esp
 43b:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
 442:	68 fa 0b 00 00       	push   $0xbfa
 447:	6a 01                	push   $0x1
 449:	e8 62 04 00 00       	call   8b0 <printf>
 44e:	83 c4 10             	add    $0x10,%esp
 451:	e9 5a fd ff ff       	jmp    1b0 <test+0x90>
 456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45d:	8d 76 00             	lea    0x0(%esi),%esi
 460:	83 ec 04             	sub    $0x4,%esp
 463:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
 46a:	68 fa 0b 00 00       	push   $0xbfa
 46f:	6a 01                	push   $0x1
 471:	e8 3a 04 00 00       	call   8b0 <printf>
 476:	83 c4 10             	add    $0x10,%esp
 479:	e9 ea fd ff ff       	jmp    268 <test+0x148>
 47e:	66 90                	xchg   %ax,%ax
 480:	83 ec 04             	sub    $0x4,%esp
 483:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
 48a:	68 fa 0b 00 00       	push   $0xbfa
 48f:	6a 01                	push   $0x1
 491:	e8 1a 04 00 00       	call   8b0 <printf>
 496:	83 c4 10             	add    $0x10,%esp
 499:	e9 52 fe ff ff       	jmp    2f0 <test+0x1d0>
 49e:	66 90                	xchg   %ax,%ax
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	ff 34 9d e0 0f 00 00 	push   0xfe0(,%ebx,4)
 4aa:	68 fa 0b 00 00       	push   $0xbfa
 4af:	6a 01                	push   $0x1
 4b1:	e8 fa 03 00 00       	call   8b0 <printf>
 4b6:	83 c4 10             	add    $0x10,%esp
 4b9:	e9 0a ff ff ff       	jmp    3c8 <test+0x2a8>
 4be:	66 90                	xchg   %ax,%ax
      printf(1, "open failed\n");
 4c0:	83 ec 08             	sub    $0x8,%esp
 4c3:	68 d8 0b 00 00       	push   $0xbd8
 4c8:	6a 01                	push   $0x1
 4ca:	e8 e1 03 00 00       	call   8b0 <printf>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	e9 b7 fc ff ff       	jmp    18e <test+0x6e>
 4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4de:	66 90                	xchg   %ax,%ax
 4e0:	83 ec 08             	sub    $0x8,%esp
 4e3:	68 d8 0b 00 00       	push   $0xbd8
 4e8:	6a 01                	push   $0x1
 4ea:	e8 c1 03 00 00       	call   8b0 <printf>
 4ef:	83 c4 10             	add    $0x10,%esp
 4f2:	e9 67 fd ff ff       	jmp    25e <test+0x13e>
 4f7:	66 90                	xchg   %ax,%ax
 4f9:	66 90                	xchg   %ax,%ax
 4fb:	66 90                	xchg   %ax,%ax
 4fd:	66 90                	xchg   %ax,%ax
 4ff:	90                   	nop

00000500 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 500:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 501:	31 c0                	xor    %eax,%eax
{
 503:	89 e5                	mov    %esp,%ebp
 505:	53                   	push   %ebx
 506:	8b 4d 08             	mov    0x8(%ebp),%ecx
 509:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 510:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 514:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 517:	83 c0 01             	add    $0x1,%eax
 51a:	84 d2                	test   %dl,%dl
 51c:	75 f2                	jne    510 <strcpy+0x10>
    ;
  return os;
}
 51e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 521:	89 c8                	mov    %ecx,%eax
 523:	c9                   	leave  
 524:	c3                   	ret    
 525:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	53                   	push   %ebx
 534:	8b 55 08             	mov    0x8(%ebp),%edx
 537:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 53a:	0f b6 02             	movzbl (%edx),%eax
 53d:	84 c0                	test   %al,%al
 53f:	75 17                	jne    558 <strcmp+0x28>
 541:	eb 3a                	jmp    57d <strcmp+0x4d>
 543:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 547:	90                   	nop
 548:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 54c:	83 c2 01             	add    $0x1,%edx
 54f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 552:	84 c0                	test   %al,%al
 554:	74 1a                	je     570 <strcmp+0x40>
    p++, q++;
 556:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 558:	0f b6 19             	movzbl (%ecx),%ebx
 55b:	38 c3                	cmp    %al,%bl
 55d:	74 e9                	je     548 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 55f:	29 d8                	sub    %ebx,%eax
}
 561:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 564:	c9                   	leave  
 565:	c3                   	ret    
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 570:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 574:	31 c0                	xor    %eax,%eax
 576:	29 d8                	sub    %ebx,%eax
}
 578:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 57b:	c9                   	leave  
 57c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 57d:	0f b6 19             	movzbl (%ecx),%ebx
 580:	31 c0                	xor    %eax,%eax
 582:	eb db                	jmp    55f <strcmp+0x2f>
 584:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop

00000590 <strlen>:

uint
strlen(const char *s)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 596:	80 3a 00             	cmpb   $0x0,(%edx)
 599:	74 15                	je     5b0 <strlen+0x20>
 59b:	31 c0                	xor    %eax,%eax
 59d:	8d 76 00             	lea    0x0(%esi),%esi
 5a0:	83 c0 01             	add    $0x1,%eax
 5a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5a7:	89 c1                	mov    %eax,%ecx
 5a9:	75 f5                	jne    5a0 <strlen+0x10>
    ;
  return n;
}
 5ab:	89 c8                	mov    %ecx,%eax
 5ad:	5d                   	pop    %ebp
 5ae:	c3                   	ret    
 5af:	90                   	nop
  for(n = 0; s[n]; n++)
 5b0:	31 c9                	xor    %ecx,%ecx
}
 5b2:	5d                   	pop    %ebp
 5b3:	89 c8                	mov    %ecx,%eax
 5b5:	c3                   	ret    
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi

000005c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 5cd:	89 d7                	mov    %edx,%edi
 5cf:	fc                   	cld    
 5d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 5d5:	89 d0                	mov    %edx,%eax
 5d7:	c9                   	leave  
 5d8:	c3                   	ret    
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <strchr>:

char*
strchr(const char *s, char c)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5ea:	0f b6 10             	movzbl (%eax),%edx
 5ed:	84 d2                	test   %dl,%dl
 5ef:	75 12                	jne    603 <strchr+0x23>
 5f1:	eb 1d                	jmp    610 <strchr+0x30>
 5f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f7:	90                   	nop
 5f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 5fc:	83 c0 01             	add    $0x1,%eax
 5ff:	84 d2                	test   %dl,%dl
 601:	74 0d                	je     610 <strchr+0x30>
    if(*s == c)
 603:	38 d1                	cmp    %dl,%cl
 605:	75 f1                	jne    5f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 607:	5d                   	pop    %ebp
 608:	c3                   	ret    
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 610:	31 c0                	xor    %eax,%eax
}
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop

00000620 <gets>:

char*
gets(char *buf, int max)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 625:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 628:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 629:	31 db                	xor    %ebx,%ebx
{
 62b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 62e:	eb 27                	jmp    657 <gets+0x37>
    cc = read(0, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	6a 01                	push   $0x1
 635:	57                   	push   %edi
 636:	6a 00                	push   $0x0
 638:	e8 2e 01 00 00       	call   76b <read>
    if(cc < 1)
 63d:	83 c4 10             	add    $0x10,%esp
 640:	85 c0                	test   %eax,%eax
 642:	7e 1d                	jle    661 <gets+0x41>
      break;
    buf[i++] = c;
 644:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 648:	8b 55 08             	mov    0x8(%ebp),%edx
 64b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 64f:	3c 0a                	cmp    $0xa,%al
 651:	74 1d                	je     670 <gets+0x50>
 653:	3c 0d                	cmp    $0xd,%al
 655:	74 19                	je     670 <gets+0x50>
  for(i=0; i+1 < max; ){
 657:	89 de                	mov    %ebx,%esi
 659:	83 c3 01             	add    $0x1,%ebx
 65c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 65f:	7c cf                	jl     630 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 668:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66b:	5b                   	pop    %ebx
 66c:	5e                   	pop    %esi
 66d:	5f                   	pop    %edi
 66e:	5d                   	pop    %ebp
 66f:	c3                   	ret    
  buf[i] = '\0';
 670:	8b 45 08             	mov    0x8(%ebp),%eax
 673:	89 de                	mov    %ebx,%esi
 675:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 679:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67c:	5b                   	pop    %ebx
 67d:	5e                   	pop    %esi
 67e:	5f                   	pop    %edi
 67f:	5d                   	pop    %ebp
 680:	c3                   	ret    
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop

00000690 <stat>:

int
stat(const char *n, struct stat *st)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	56                   	push   %esi
 694:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 695:	83 ec 08             	sub    $0x8,%esp
 698:	6a 00                	push   $0x0
 69a:	ff 75 08             	push   0x8(%ebp)
 69d:	e8 f1 00 00 00       	call   793 <open>
  if(fd < 0)
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	85 c0                	test   %eax,%eax
 6a7:	78 27                	js     6d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6a9:	83 ec 08             	sub    $0x8,%esp
 6ac:	ff 75 0c             	push   0xc(%ebp)
 6af:	89 c3                	mov    %eax,%ebx
 6b1:	50                   	push   %eax
 6b2:	e8 f4 00 00 00       	call   7ab <fstat>
  close(fd);
 6b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ba:	89 c6                	mov    %eax,%esi
  close(fd);
 6bc:	e8 ba 00 00 00       	call   77b <close>
  return r;
 6c1:	83 c4 10             	add    $0x10,%esp
}
 6c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6c7:	89 f0                	mov    %esi,%eax
 6c9:	5b                   	pop    %ebx
 6ca:	5e                   	pop    %esi
 6cb:	5d                   	pop    %ebp
 6cc:	c3                   	ret    
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6d5:	eb ed                	jmp    6c4 <stat+0x34>
 6d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6de:	66 90                	xchg   %ax,%ax

000006e0 <atoi>:

int
atoi(const char *s)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e7:	0f be 02             	movsbl (%edx),%eax
 6ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 6f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 6f5:	77 1e                	ja     715 <atoi+0x35>
 6f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 700:	83 c2 01             	add    $0x1,%edx
 703:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 706:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 70a:	0f be 02             	movsbl (%edx),%eax
 70d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 710:	80 fb 09             	cmp    $0x9,%bl
 713:	76 eb                	jbe    700 <atoi+0x20>
  return n;
}
 715:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 718:	89 c8                	mov    %ecx,%eax
 71a:	c9                   	leave  
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	8b 45 10             	mov    0x10(%ebp),%eax
 727:	8b 55 08             	mov    0x8(%ebp),%edx
 72a:	56                   	push   %esi
 72b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 72e:	85 c0                	test   %eax,%eax
 730:	7e 13                	jle    745 <memmove+0x25>
 732:	01 d0                	add    %edx,%eax
  dst = vdst;
 734:	89 d7                	mov    %edx,%edi
 736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 740:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 741:	39 f8                	cmp    %edi,%eax
 743:	75 fb                	jne    740 <memmove+0x20>
  return vdst;
}
 745:	5e                   	pop    %esi
 746:	89 d0                	mov    %edx,%eax
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    

0000074b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 74b:	b8 01 00 00 00       	mov    $0x1,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <exit>:
SYSCALL(exit)
 753:	b8 02 00 00 00       	mov    $0x2,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <wait>:
SYSCALL(wait)
 75b:	b8 03 00 00 00       	mov    $0x3,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <pipe>:
SYSCALL(pipe)
 763:	b8 04 00 00 00       	mov    $0x4,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <read>:
SYSCALL(read)
 76b:	b8 05 00 00 00       	mov    $0x5,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <write>:
SYSCALL(write)
 773:	b8 10 00 00 00       	mov    $0x10,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <close>:
SYSCALL(close)
 77b:	b8 15 00 00 00       	mov    $0x15,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <kill>:
SYSCALL(kill)
 783:	b8 06 00 00 00       	mov    $0x6,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <exec>:
SYSCALL(exec)
 78b:	b8 07 00 00 00       	mov    $0x7,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <open>:
SYSCALL(open)
 793:	b8 0f 00 00 00       	mov    $0xf,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <mknod>:
SYSCALL(mknod)
 79b:	b8 11 00 00 00       	mov    $0x11,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <unlink>:
SYSCALL(unlink)
 7a3:	b8 12 00 00 00       	mov    $0x12,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <fstat>:
SYSCALL(fstat)
 7ab:	b8 08 00 00 00       	mov    $0x8,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <link>:
SYSCALL(link)
 7b3:	b8 13 00 00 00       	mov    $0x13,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <mkdir>:
SYSCALL(mkdir)
 7bb:	b8 14 00 00 00       	mov    $0x14,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <chdir>:
SYSCALL(chdir)
 7c3:	b8 09 00 00 00       	mov    $0x9,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <dup>:
SYSCALL(dup)
 7cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <getpid>:
SYSCALL(getpid)
 7d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <sbrk>:
SYSCALL(sbrk)
 7db:	b8 0c 00 00 00       	mov    $0xc,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <sleep>:
SYSCALL(sleep)
 7e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <uptime>:
SYSCALL(uptime)
 7eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <getfdcount>:
SYSCALL(getfdcount)
 7f3:	b8 16 00 00 00       	mov    $0x16,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    
 7fb:	66 90                	xchg   %ax,%ax
 7fd:	66 90                	xchg   %ax,%ax
 7ff:	90                   	nop

00000800 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 3c             	sub    $0x3c,%esp
 809:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 80c:	89 d1                	mov    %edx,%ecx
{
 80e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 811:	85 d2                	test   %edx,%edx
 813:	0f 89 7f 00 00 00    	jns    898 <printint+0x98>
 819:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 81d:	74 79                	je     898 <printint+0x98>
    neg = 1;
 81f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 826:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 828:	31 db                	xor    %ebx,%ebx
 82a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 830:	89 c8                	mov    %ecx,%eax
 832:	31 d2                	xor    %edx,%edx
 834:	89 cf                	mov    %ecx,%edi
 836:	f7 75 c4             	divl   -0x3c(%ebp)
 839:	0f b6 92 80 0c 00 00 	movzbl 0xc80(%edx),%edx
 840:	89 45 c0             	mov    %eax,-0x40(%ebp)
 843:	89 d8                	mov    %ebx,%eax
 845:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 848:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 84b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 84e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 851:	76 dd                	jbe    830 <printint+0x30>
  if(neg)
 853:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 856:	85 c9                	test   %ecx,%ecx
 858:	74 0c                	je     866 <printint+0x66>
    buf[i++] = '-';
 85a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 85f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 861:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 866:	8b 7d b8             	mov    -0x48(%ebp),%edi
 869:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 86d:	eb 07                	jmp    876 <printint+0x76>
 86f:	90                   	nop
    putc(fd, buf[i]);
 870:	0f b6 13             	movzbl (%ebx),%edx
 873:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 876:	83 ec 04             	sub    $0x4,%esp
 879:	88 55 d7             	mov    %dl,-0x29(%ebp)
 87c:	6a 01                	push   $0x1
 87e:	56                   	push   %esi
 87f:	57                   	push   %edi
 880:	e8 ee fe ff ff       	call   773 <write>
  while(--i >= 0)
 885:	83 c4 10             	add    $0x10,%esp
 888:	39 de                	cmp    %ebx,%esi
 88a:	75 e4                	jne    870 <printint+0x70>
}
 88c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88f:	5b                   	pop    %ebx
 890:	5e                   	pop    %esi
 891:	5f                   	pop    %edi
 892:	5d                   	pop    %ebp
 893:	c3                   	ret    
 894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 898:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 89f:	eb 87                	jmp    828 <printint+0x28>
 8a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8af:	90                   	nop

000008b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8bc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8bf:	0f b6 13             	movzbl (%ebx),%edx
 8c2:	84 d2                	test   %dl,%dl
 8c4:	74 6a                	je     930 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 8c6:	8d 45 10             	lea    0x10(%ebp),%eax
 8c9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8cc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8cf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 8d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8d4:	eb 36                	jmp    90c <printf+0x5c>
 8d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8dd:	8d 76 00             	lea    0x0(%esi),%esi
 8e0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 8e3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 8e8:	83 f8 25             	cmp    $0x25,%eax
 8eb:	74 15                	je     902 <printf+0x52>
  write(fd, &c, 1);
 8ed:	83 ec 04             	sub    $0x4,%esp
 8f0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8f3:	6a 01                	push   $0x1
 8f5:	57                   	push   %edi
 8f6:	56                   	push   %esi
 8f7:	e8 77 fe ff ff       	call   773 <write>
 8fc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 8ff:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 902:	0f b6 13             	movzbl (%ebx),%edx
 905:	83 c3 01             	add    $0x1,%ebx
 908:	84 d2                	test   %dl,%dl
 90a:	74 24                	je     930 <printf+0x80>
    c = fmt[i] & 0xff;
 90c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 90f:	85 c9                	test   %ecx,%ecx
 911:	74 cd                	je     8e0 <printf+0x30>
      }
    } else if(state == '%'){
 913:	83 f9 25             	cmp    $0x25,%ecx
 916:	75 ea                	jne    902 <printf+0x52>
      if(c == 'd'){
 918:	83 f8 25             	cmp    $0x25,%eax
 91b:	0f 84 07 01 00 00    	je     a28 <printf+0x178>
 921:	83 e8 63             	sub    $0x63,%eax
 924:	83 f8 15             	cmp    $0x15,%eax
 927:	77 17                	ja     940 <printf+0x90>
 929:	ff 24 85 28 0c 00 00 	jmp    *0xc28(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 930:	8d 65 f4             	lea    -0xc(%ebp),%esp
 933:	5b                   	pop    %ebx
 934:	5e                   	pop    %esi
 935:	5f                   	pop    %edi
 936:	5d                   	pop    %ebp
 937:	c3                   	ret    
 938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 93f:	90                   	nop
  write(fd, &c, 1);
 940:	83 ec 04             	sub    $0x4,%esp
 943:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 946:	6a 01                	push   $0x1
 948:	57                   	push   %edi
 949:	56                   	push   %esi
 94a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 94e:	e8 20 fe ff ff       	call   773 <write>
        putc(fd, c);
 953:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 957:	83 c4 0c             	add    $0xc,%esp
 95a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 95d:	6a 01                	push   $0x1
 95f:	57                   	push   %edi
 960:	56                   	push   %esi
 961:	e8 0d fe ff ff       	call   773 <write>
        putc(fd, c);
 966:	83 c4 10             	add    $0x10,%esp
      state = 0;
 969:	31 c9                	xor    %ecx,%ecx
 96b:	eb 95                	jmp    902 <printf+0x52>
 96d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 970:	83 ec 0c             	sub    $0xc,%esp
 973:	b9 10 00 00 00       	mov    $0x10,%ecx
 978:	6a 00                	push   $0x0
 97a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 97d:	8b 10                	mov    (%eax),%edx
 97f:	89 f0                	mov    %esi,%eax
 981:	e8 7a fe ff ff       	call   800 <printint>
        ap++;
 986:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 98a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 98d:	31 c9                	xor    %ecx,%ecx
 98f:	e9 6e ff ff ff       	jmp    902 <printf+0x52>
 994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 998:	8b 45 d0             	mov    -0x30(%ebp),%eax
 99b:	8b 10                	mov    (%eax),%edx
        ap++;
 99d:	83 c0 04             	add    $0x4,%eax
 9a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 9a3:	85 d2                	test   %edx,%edx
 9a5:	0f 84 8d 00 00 00    	je     a38 <printf+0x188>
        while(*s != 0){
 9ab:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 9ae:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9b0:	84 c0                	test   %al,%al
 9b2:	0f 84 4a ff ff ff    	je     902 <printf+0x52>
 9b8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9bb:	89 d3                	mov    %edx,%ebx
 9bd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9c0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9c3:	83 c3 01             	add    $0x1,%ebx
 9c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9c9:	6a 01                	push   $0x1
 9cb:	57                   	push   %edi
 9cc:	56                   	push   %esi
 9cd:	e8 a1 fd ff ff       	call   773 <write>
        while(*s != 0){
 9d2:	0f b6 03             	movzbl (%ebx),%eax
 9d5:	83 c4 10             	add    $0x10,%esp
 9d8:	84 c0                	test   %al,%al
 9da:	75 e4                	jne    9c0 <printf+0x110>
      state = 0;
 9dc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 9df:	31 c9                	xor    %ecx,%ecx
 9e1:	e9 1c ff ff ff       	jmp    902 <printf+0x52>
 9e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ed:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 9f0:	83 ec 0c             	sub    $0xc,%esp
 9f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9f8:	6a 01                	push   $0x1
 9fa:	e9 7b ff ff ff       	jmp    97a <printf+0xca>
 9ff:	90                   	nop
        putc(fd, *ap);
 a00:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 a03:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a06:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a08:	6a 01                	push   $0x1
 a0a:	57                   	push   %edi
 a0b:	56                   	push   %esi
        putc(fd, *ap);
 a0c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a0f:	e8 5f fd ff ff       	call   773 <write>
        ap++;
 a14:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a18:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a1b:	31 c9                	xor    %ecx,%ecx
 a1d:	e9 e0 fe ff ff       	jmp    902 <printf+0x52>
 a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a28:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a2b:	83 ec 04             	sub    $0x4,%esp
 a2e:	e9 2a ff ff ff       	jmp    95d <printf+0xad>
 a33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a37:	90                   	nop
          s = "(null)";
 a38:	ba 1f 0c 00 00       	mov    $0xc1f,%edx
        while(*s != 0){
 a3d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a40:	b8 28 00 00 00       	mov    $0x28,%eax
 a45:	89 d3                	mov    %edx,%ebx
 a47:	e9 74 ff ff ff       	jmp    9c0 <printf+0x110>
 a4c:	66 90                	xchg   %ax,%ax
 a4e:	66 90                	xchg   %ax,%ax

00000a50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a50:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a51:	a1 04 10 00 00       	mov    0x1004,%eax
{
 a56:	89 e5                	mov    %esp,%ebp
 a58:	57                   	push   %edi
 a59:	56                   	push   %esi
 a5a:	53                   	push   %ebx
 a5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a5e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a68:	89 c2                	mov    %eax,%edx
 a6a:	8b 00                	mov    (%eax),%eax
 a6c:	39 ca                	cmp    %ecx,%edx
 a6e:	73 30                	jae    aa0 <free+0x50>
 a70:	39 c1                	cmp    %eax,%ecx
 a72:	72 04                	jb     a78 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a74:	39 c2                	cmp    %eax,%edx
 a76:	72 f0                	jb     a68 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a78:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a7b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a7e:	39 f8                	cmp    %edi,%eax
 a80:	74 30                	je     ab2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a82:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a85:	8b 42 04             	mov    0x4(%edx),%eax
 a88:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a8b:	39 f1                	cmp    %esi,%ecx
 a8d:	74 3a                	je     ac9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a8f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a91:	5b                   	pop    %ebx
  freep = p;
 a92:	89 15 04 10 00 00    	mov    %edx,0x1004
}
 a98:	5e                   	pop    %esi
 a99:	5f                   	pop    %edi
 a9a:	5d                   	pop    %ebp
 a9b:	c3                   	ret    
 a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa0:	39 c2                	cmp    %eax,%edx
 aa2:	72 c4                	jb     a68 <free+0x18>
 aa4:	39 c1                	cmp    %eax,%ecx
 aa6:	73 c0                	jae    a68 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 aa8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aae:	39 f8                	cmp    %edi,%eax
 ab0:	75 d0                	jne    a82 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 ab2:	03 70 04             	add    0x4(%eax),%esi
 ab5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ab8:	8b 02                	mov    (%edx),%eax
 aba:	8b 00                	mov    (%eax),%eax
 abc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 abf:	8b 42 04             	mov    0x4(%edx),%eax
 ac2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ac5:	39 f1                	cmp    %esi,%ecx
 ac7:	75 c6                	jne    a8f <free+0x3f>
    p->s.size += bp->s.size;
 ac9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 acc:	89 15 04 10 00 00    	mov    %edx,0x1004
    p->s.size += bp->s.size;
 ad2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 ad5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 ad8:	89 0a                	mov    %ecx,(%edx)
}
 ada:	5b                   	pop    %ebx
 adb:	5e                   	pop    %esi
 adc:	5f                   	pop    %edi
 add:	5d                   	pop    %ebp
 ade:	c3                   	ret    
 adf:	90                   	nop

00000ae0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	57                   	push   %edi
 ae4:	56                   	push   %esi
 ae5:	53                   	push   %ebx
 ae6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 aec:	8b 3d 04 10 00 00    	mov    0x1004,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af2:	8d 70 07             	lea    0x7(%eax),%esi
 af5:	c1 ee 03             	shr    $0x3,%esi
 af8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 afb:	85 ff                	test   %edi,%edi
 afd:	0f 84 9d 00 00 00    	je     ba0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b03:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 b05:	8b 4a 04             	mov    0x4(%edx),%ecx
 b08:	39 f1                	cmp    %esi,%ecx
 b0a:	73 6a                	jae    b76 <malloc+0x96>
 b0c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b11:	39 de                	cmp    %ebx,%esi
 b13:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b16:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b20:	eb 17                	jmp    b39 <malloc+0x59>
 b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b2a:	8b 48 04             	mov    0x4(%eax),%ecx
 b2d:	39 f1                	cmp    %esi,%ecx
 b2f:	73 4f                	jae    b80 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b31:	8b 3d 04 10 00 00    	mov    0x1004,%edi
 b37:	89 c2                	mov    %eax,%edx
 b39:	39 d7                	cmp    %edx,%edi
 b3b:	75 eb                	jne    b28 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b3d:	83 ec 0c             	sub    $0xc,%esp
 b40:	ff 75 e4             	push   -0x1c(%ebp)
 b43:	e8 93 fc ff ff       	call   7db <sbrk>
  if(p == (char*)-1)
 b48:	83 c4 10             	add    $0x10,%esp
 b4b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b4e:	74 1c                	je     b6c <malloc+0x8c>
  hp->s.size = nu;
 b50:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b53:	83 ec 0c             	sub    $0xc,%esp
 b56:	83 c0 08             	add    $0x8,%eax
 b59:	50                   	push   %eax
 b5a:	e8 f1 fe ff ff       	call   a50 <free>
  return freep;
 b5f:	8b 15 04 10 00 00    	mov    0x1004,%edx
      if((p = morecore(nunits)) == 0)
 b65:	83 c4 10             	add    $0x10,%esp
 b68:	85 d2                	test   %edx,%edx
 b6a:	75 bc                	jne    b28 <malloc+0x48>
        return 0;
  }
}
 b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b6f:	31 c0                	xor    %eax,%eax
}
 b71:	5b                   	pop    %ebx
 b72:	5e                   	pop    %esi
 b73:	5f                   	pop    %edi
 b74:	5d                   	pop    %ebp
 b75:	c3                   	ret    
    if(p->s.size >= nunits){
 b76:	89 d0                	mov    %edx,%eax
 b78:	89 fa                	mov    %edi,%edx
 b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b80:	39 ce                	cmp    %ecx,%esi
 b82:	74 4c                	je     bd0 <malloc+0xf0>
        p->s.size -= nunits;
 b84:	29 f1                	sub    %esi,%ecx
 b86:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b89:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b8c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 b8f:	89 15 04 10 00 00    	mov    %edx,0x1004
}
 b95:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b98:	83 c0 08             	add    $0x8,%eax
}
 b9b:	5b                   	pop    %ebx
 b9c:	5e                   	pop    %esi
 b9d:	5f                   	pop    %edi
 b9e:	5d                   	pop    %ebp
 b9f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 ba0:	c7 05 04 10 00 00 08 	movl   $0x1008,0x1004
 ba7:	10 00 00 
    base.s.size = 0;
 baa:	bf 08 10 00 00       	mov    $0x1008,%edi
    base.s.ptr = freep = prevp = &base;
 baf:	c7 05 08 10 00 00 08 	movl   $0x1008,0x1008
 bb6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 bbb:	c7 05 0c 10 00 00 00 	movl   $0x0,0x100c
 bc2:	00 00 00 
    if(p->s.size >= nunits){
 bc5:	e9 42 ff ff ff       	jmp    b0c <malloc+0x2c>
 bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 bd0:	8b 08                	mov    (%eax),%ecx
 bd2:	89 0a                	mov    %ecx,(%edx)
 bd4:	eb b9                	jmp    b8f <malloc+0xaf>
