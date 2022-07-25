	.file	"aes.c"
	.text
	.local	state
	.comm	state,8,8
	.local	RoundKey
	.comm	RoundKey,176,32
	.local	input_save
	.comm	input_save,16,16
	.local	Key
	.comm	Key,8,8
	.globl	sbox
	.data
	.align 32
	.type	sbox, @object
	.size	sbox, 256
sbox:
	.string	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321"
	.ascii	"\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002"
	.ascii	"\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363"
	.ascii	"\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220"
	.ascii	"\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221"
	.ascii	"\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034"
	.ascii	"\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5"
	.ascii	"W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207"
	.ascii	"\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.globl	rsbox
	.align 32
	.type	rsbox, @object
	.size	rsbox, 256
rsbox:
	.string	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253"
	.ascii	"\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017"
	.ascii	"\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362"
	.ascii	"\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034"
	.ascii	"u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V"
	.ascii	">K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\307"
	.ascii	"1\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311"
	.ascii	"\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004"
	.ascii	"~\272w\326&\341i\024cU!\f}"
	.globl	Rcon
	.align 8
	.type	Rcon, @object
	.size	Rcon, 11
Rcon:
	.ascii	"\215\001\002\004\b\020 @\200\0336"
	.text
	.type	getSBoxValue, @function
getSBoxValue:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	getSBoxValue, .-getSBoxValue
	.type	getSBoxInvert, @function
getSBoxInvert:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	cltq
	leaq	rsbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	getSBoxInvert, .-getSBoxInvert
	.type	KeyExpansion, @function
KeyExpansion:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -24(%rbp)
	jmp	.L6
.L7:
	movq	Key(%rip), %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	movl	%edx, %edx
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	movzbl	(%rax), %eax
	movl	%edx, %ecx
	leaq	RoundKey(%rip), %rdx
	movb	%al, (%rcx,%rdx)
	movq	Key(%rip), %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$1, %edx
	movl	%edx, %edx
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$1, %edx
	movzbl	(%rax), %eax
	movl	%edx, %ecx
	leaq	RoundKey(%rip), %rdx
	movb	%al, (%rcx,%rdx)
	movq	Key(%rip), %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$2, %edx
	movl	%edx, %edx
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$2, %edx
	movzbl	(%rax), %eax
	movl	%edx, %ecx
	leaq	RoundKey(%rip), %rdx
	movb	%al, (%rcx,%rdx)
	movq	Key(%rip), %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$3, %edx
	movl	%edx, %edx
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$3, %edx
	movzbl	(%rax), %eax
	movl	%edx, %ecx
	leaq	RoundKey(%rip), %rdx
	movb	%al, (%rcx,%rdx)
	addl	$1, -24(%rbp)
.L6:
	cmpl	$3, -24(%rbp)
	jbe	.L7
	jmp	.L8
.L12:
	movl	$0, -20(%rbp)
	jmp	.L9
.L10:
	movl	-24(%rbp), %eax
	subl	$1, %eax
	leal	0(,%rax,4), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movzbl	(%rdx,%rax), %edx
	movl	-20(%rbp), %eax
	movb	%dl, -12(%rbp,%rax)
	addl	$1, -20(%rbp)
.L9:
	cmpl	$3, -20(%rbp)
	jbe	.L10
	movl	-24(%rbp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L11
	movzbl	-12(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, -16(%rbp)
	movzbl	-11(%rbp), %eax
	movb	%al, -12(%rbp)
	movzbl	-10(%rbp), %eax
	movb	%al, -11(%rbp)
	movzbl	-9(%rbp), %eax
	movb	%al, -10(%rbp)
	movl	-16(%rbp), %eax
	movb	%al, -9(%rbp)
	movzbl	-12(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	getSBoxValue
	movb	%al, -12(%rbp)
	movzbl	-11(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	getSBoxValue
	movb	%al, -11(%rbp)
	movzbl	-10(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	getSBoxValue
	movb	%al, -10(%rbp)
	movzbl	-9(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	getSBoxValue
	movb	%al, -9(%rbp)
	movzbl	-12(%rbp), %edx
	movl	-24(%rbp), %eax
	shrl	$2, %eax
	movl	%eax, %ecx
	leaq	Rcon(%rip), %rax
	movzbl	(%rcx,%rax), %eax
	xorl	%edx, %eax
	movb	%al, -12(%rbp)
.L11:
	movl	-24(%rbp), %eax
	subl	$4, %eax
	sall	$2, %eax
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movzbl	(%rdx,%rax), %ecx
	movzbl	-12(%rbp), %edx
	movl	-24(%rbp), %eax
	sall	$2, %eax
	xorl	%edx, %ecx
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movb	%cl, (%rdx,%rax)
	movl	-24(%rbp), %eax
	subl	$4, %eax
	sall	$2, %eax
	addl	$1, %eax
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movzbl	(%rdx,%rax), %ecx
	movzbl	-11(%rbp), %edx
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$1, %eax
	xorl	%edx, %ecx
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movb	%cl, (%rdx,%rax)
	movl	-24(%rbp), %eax
	subl	$4, %eax
	sall	$2, %eax
	addl	$2, %eax
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movzbl	(%rdx,%rax), %ecx
	movzbl	-10(%rbp), %edx
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$2, %eax
	xorl	%edx, %ecx
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movb	%cl, (%rdx,%rax)
	movl	-24(%rbp), %eax
	subl	$4, %eax
	sall	$2, %eax
	addl	$3, %eax
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movzbl	(%rdx,%rax), %ecx
	movzbl	-9(%rbp), %edx
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$3, %eax
	xorl	%edx, %ecx
	movl	%eax, %edx
	leaq	RoundKey(%rip), %rax
	movb	%cl, (%rdx,%rax)
	addl	$1, -24(%rbp)
.L8:
	cmpl	$43, -24(%rbp)
	jbe	.L12
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	KeyExpansion, .-KeyExpansion
	.type	AddRoundKey, @function
AddRoundKey:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -20(%rbp)
	movb	$0, -2(%rbp)
	jmp	.L15
.L18:
	movb	$0, -1(%rbp)
	jmp	.L16
.L17:
	movq	state(%rip), %rcx
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %edx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edi
	movzbl	-20(%rbp), %eax
	leal	0(,%rax,4), %edx
	movzbl	-2(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,4), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	RoundKey(%rip), %rdx
	movzbl	(%rax,%rdx), %esi
	movq	state(%rip), %rcx
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %edx
	xorl	%edi, %esi
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movb	%sil, (%rax)
	addb	$1, -1(%rbp)
.L16:
	cmpb	$3, -1(%rbp)
	jbe	.L17
	addb	$1, -2(%rbp)
.L15:
	cmpb	$3, -2(%rbp)
	jbe	.L18
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	AddRoundKey, .-AddRoundKey
	.type	SubBytes, @function
SubBytes:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movb	$0, -26(%rbp)
	jmp	.L20
.L23:
	movb	$0, -25(%rbp)
	jmp	.L21
.L22:
	movq	state(%rip), %rcx
	movzbl	-25(%rbp), %eax
	movzbl	-26(%rbp), %edx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movq	state(%rip), %rbx
	movzbl	-25(%rbp), %r12d
	movzbl	-26(%rbp), %r13d
	movl	%eax, %edi
	call	getSBoxValue
	movl	%eax, %edx
	movslq	%r13d, %rcx
	movslq	%r12d, %rax
	salq	$2, %rax
	addq	%rbx, %rax
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addb	$1, -25(%rbp)
.L21:
	cmpb	$3, -25(%rbp)
	jbe	.L22
	addb	$1, -26(%rbp)
.L20:
	cmpb	$3, -26(%rbp)
	jbe	.L23
	nop
	nop
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	SubBytes, .-SubBytes
	.type	ShiftRows, @function
ShiftRows:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	state(%rip), %rax
	movzbl	1(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	5(%rdx), %edx
	movb	%dl, 1(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	9(%rdx), %edx
	movb	%dl, 5(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	13(%rdx), %edx
	movb	%dl, 9(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 13(%rax)
	movq	state(%rip), %rax
	movzbl	2(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	10(%rdx), %edx
	movb	%dl, 2(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 10(%rax)
	movq	state(%rip), %rax
	movzbl	6(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	14(%rdx), %edx
	movb	%dl, 6(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 14(%rax)
	movq	state(%rip), %rax
	movzbl	3(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	15(%rdx), %edx
	movb	%dl, 3(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	11(%rdx), %edx
	movb	%dl, 15(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	7(%rdx), %edx
	movb	%dl, 11(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 7(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	ShiftRows, .-ShiftRows
	.type	xtime, @function
xtime:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, %ecx
	movzbl	-4(%rbp), %eax
	shrb	$7, %al
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	addl	%edx, %eax
	xorl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	xtime, .-xtime
	.type	MixColumns, @function
MixColumns:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movb	$0, -4(%rbp)
	jmp	.L28
.L29:
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %eax
	movb	%al, -3(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	xorl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	xorl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -2(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %esi
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	xorl	%esi, %ecx
	movslq	%edx, %rdx
	movb	%cl, (%rax,%rdx,4)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %esi
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	xorl	%esi, %ecx
	movslq	%edx, %rdx
	movb	%cl, 1(%rax,%rdx,4)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %esi
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	xorl	%esi, %ecx
	movslq	%edx, %rdx
	movb	%cl, 2(%rax,%rdx,4)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorb	-3(%rbp), %al
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %esi
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movl	%eax, %ecx
	movq	state(%rip), %rax
	movzbl	-4(%rbp), %edx
	xorl	%esi, %ecx
	movslq	%edx, %rdx
	movb	%cl, 3(%rax,%rdx,4)
	addb	$1, -4(%rbp)
.L28:
	cmpb	$3, -4(%rbp)
	jbe	.L29
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	MixColumns, .-MixColumns
	.type	InvMixColumns, @function
InvMixColumns:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movl	$0, -20(%rbp)
	jmp	.L31
.L32:
	movq	state(%rip), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %eax
	movb	%al, -24(%rbp)
	movq	state(%rip), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	movb	%al, -23(%rbp)
	movq	state(%rip), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	movb	%al, -22(%rbp)
	movq	state(%rip), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	movb	%al, -21(%rbp)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ebx
	xorl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%eax, %edx
	movq	state(%rip), %rax
	movl	%ebx, %ecx
	xorl	%edx, %ecx
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, (%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movl	%ebx, %edx
	xorl	%eax, %edx
	movq	state(%rip), %rax
	movl	%r12d, %ecx
	xorl	%edx, %ecx
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 1(%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movl	%ebx, %edx
	xorl	%eax, %edx
	movq	state(%rip), %rax
	movl	%r12d, %ecx
	xorl	%edx, %ecx
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 2(%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ebx
	xorl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movl	%ebx, %edx
	xorl	%eax, %edx
	movq	state(%rip), %rax
	movl	%r12d, %ecx
	xorl	%edx, %ecx
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 3(%rax,%rdx,4)
	addl	$1, -20(%rbp)
.L31:
	cmpl	$3, -20(%rbp)
	jle	.L32
	nop
	nop
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	InvMixColumns, .-InvMixColumns
	.type	InvSubBytes, @function
InvSubBytes:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movb	$0, -26(%rbp)
	jmp	.L34
.L37:
	movb	$0, -25(%rbp)
	jmp	.L35
.L36:
	movq	state(%rip), %rcx
	movzbl	-25(%rbp), %eax
	movzbl	-26(%rbp), %edx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movq	state(%rip), %rbx
	movzbl	-25(%rbp), %r12d
	movzbl	-26(%rbp), %r13d
	movl	%eax, %edi
	call	getSBoxInvert
	movl	%eax, %edx
	movslq	%r13d, %rcx
	movslq	%r12d, %rax
	salq	$2, %rax
	addq	%rbx, %rax
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addb	$1, -25(%rbp)
.L35:
	cmpb	$3, -25(%rbp)
	jbe	.L36
	addb	$1, -26(%rbp)
.L34:
	cmpb	$3, -26(%rbp)
	jbe	.L37
	nop
	nop
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	InvSubBytes, .-InvSubBytes
	.type	InvShiftRows, @function
InvShiftRows:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	state(%rip), %rax
	movzbl	13(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	9(%rdx), %edx
	movb	%dl, 13(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	5(%rdx), %edx
	movb	%dl, 9(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	1(%rdx), %edx
	movb	%dl, 5(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 1(%rax)
	movq	state(%rip), %rax
	movzbl	2(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	10(%rdx), %edx
	movb	%dl, 2(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 10(%rax)
	movq	state(%rip), %rax
	movzbl	6(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	14(%rdx), %edx
	movb	%dl, 6(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 14(%rax)
	movq	state(%rip), %rax
	movzbl	3(%rax), %eax
	movb	%al, -1(%rbp)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	7(%rdx), %edx
	movb	%dl, 3(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	11(%rdx), %edx
	movb	%dl, 7(%rax)
	movq	state(%rip), %rdx
	movq	state(%rip), %rax
	movzbl	15(%rdx), %edx
	movb	%dl, 11(%rax)
	movq	state(%rip), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 15(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	InvShiftRows, .-InvShiftRows
	.type	Cipher, @function
Cipher:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movb	$0, -1(%rbp)
	movl	$0, %edi
	call	AddRoundKey
	movb	$1, -1(%rbp)
	jmp	.L40
.L41:
	call	SubBytes
	call	ShiftRows
	call	MixColumns
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	AddRoundKey
	addb	$1, -1(%rbp)
.L40:
	cmpb	$9, -1(%rbp)
	jbe	.L41
	call	SubBytes
	call	ShiftRows
	movl	$10, %edi
	call	AddRoundKey
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	Cipher, .-Cipher
	.type	InvCipher, @function
InvCipher:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movb	$0, -1(%rbp)
	movl	$10, %edi
	call	AddRoundKey
	movb	$9, -1(%rbp)
	jmp	.L43
.L44:
	call	InvShiftRows
	call	InvSubBytes
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	AddRoundKey
	call	InvMixColumns
	movzbl	-1(%rbp), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
.L43:
	cmpb	$0, -1(%rbp)
	jne	.L44
	call	InvShiftRows
	call	InvSubBytes
	movl	$0, %edi
	call	AddRoundKey
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	InvCipher, .-InvCipher
	.type	BlockCopy, @function
BlockCopy:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L46
.L47:
	movzbl	-1(%rbp), %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	-1(%rbp), %ecx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	addb	$1, -1(%rbp)
.L46:
	cmpb	$15, -1(%rbp)
	jbe	.L47
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	BlockCopy, .-BlockCopy
	.globl	AES128_ECB_indp_setkey
	.type	AES128_ECB_indp_setkey, @function
AES128_ECB_indp_setkey:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, Key(%rip)
	call	KeyExpansion
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	AES128_ECB_indp_setkey, .-AES128_ECB_indp_setkey
	.globl	AES128_ECB_indp_crypto
	.type	AES128_ECB_indp_crypto, @function
AES128_ECB_indp_crypto:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, state(%rip)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	input_save(%rip), %rdi
	call	BlockCopy
	call	Cipher
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	AES128_ECB_indp_crypto, .-AES128_ECB_indp_crypto
	.globl	AES128_ECB_encrypt
	.type	AES128_ECB_encrypt, @function
AES128_ECB_encrypt:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	BlockCopy
	movq	-24(%rbp), %rax
	movq	%rax, state(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, Key(%rip)
	call	KeyExpansion
	call	Cipher
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	AES128_ECB_encrypt, .-AES128_ECB_encrypt
	.globl	AES128_ECB_decrypt
	.type	AES128_ECB_decrypt, @function
AES128_ECB_decrypt:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	BlockCopy
	movq	-24(%rbp), %rax
	movq	%rax, state(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, Key(%rip)
	call	KeyExpansion
	call	InvCipher
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	AES128_ECB_decrypt, .-AES128_ECB_decrypt
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
