Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Ta2H0-0002dq-KZ
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 10:38:48 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
 <CAE9FiQV=6qeBgzd3ekBRXh1jfv+_-s_UuQqRyMAYwK5E=S55fA@mail.gmail.com>
 <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
 <CAE9FiQWm=6yas4dRfbc+qLC7yEhbdt+pnRMwAYSQ1jjk5qOvBw@mail.gmail.com>
 <871ufrqw3d.fsf@xmission.com>
 <CAE9FiQXGy_mxMWpf+7Jr-xVmxy6-_BGE2Ys9FbDk9U3A-kBfew@mail.gmail.com>
 <87ehjrpfpr.fsf@xmission.com>
 <CAE9FiQWGmz0KBE6f2KSOesbvsRSZu--=K5=-uvfoUN_+NKphEA@mail.gmail.com>
 <CAE9FiQWOb3TqVyFM4ZNCOcdByK6ttrKkiz0gbYSgzxBtf34AJQ@mail.gmail.com>
Date: Sun, 18 Nov 2012 02:38:22 -0800
In-Reply-To: <CAE9FiQWOb3TqVyFM4ZNCOcdByK6ttrKkiz0gbYSgzxBtf34AJQ@mail.gmail.com>
 (Yinghai Lu's message of "Sat, 17 Nov 2012 23:18:24 -0800")
Message-ID: <878v9zp55t.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> On Sat, Nov 17, 2012 at 10:53 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Nov 17, 2012 at 10:50 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>>
>>>> so we should two purgatory for x86_64 ?
>>>> like one for 64bit and one for 32bit/16bit
>>>
>>> The problem is that the current 32bit assembly code is not possition
>>> independent.  If we can rewrite that assembly code to be position
>>> independent no relocs will be generated and we should be good.
>>>
>>> The 16bit entry point code was already written as position independent
>>> code so it should not cause problems.
>>>
>>> Just having one piece of code to deal with (if we can figure it out)
>>> looks to be the simpler and more maintainable solution.
>>
>> sure.
>
> just resent -v2 patches for kernel parts.
>
> attached are changes for kexec-tools without put 64 bit purgartory above 4g...
>
> hope you can work out 32bit position independent.

It looks like this is enough to fix purgatory.

I have tested this in so far as that it doesn't generate relocs, but I
haven't had a test to see if the code actually works.

YH can you verify this boots both 32bit and 64bit kernels for you?

Thanks,
Eric

diff --git a/purgatory/Makefile b/purgatory/Makefile
index ee1679c..e39adec 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -64,6 +64,7 @@ $(PURGATORY): $(PURGATORY_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
 
 #	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
+	$(STRIP) --strip-debug $@
 
 echo::
 	@echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
index 82b58ca..2f47607 100644
--- a/purgatory/arch/i386/entry32-16-debug.S
+++ b/purgatory/arch/i386/entry32-16-debug.S
@@ -29,15 +29,17 @@
 	.balign 16
 entry16_debug:
 	.code32
-	/* Compute where I am running at */
-	movl	$entry16_debug, %ebx	
+	/* Compute where I am running at (assumes esp valid) */
+	call	1f
+1:	popl	%ebx
 
 	/* Fixup my real mode segment */
 	movl	%ebx, %eax
 	shrl	$4, %eax
-	movw	%ax, 2 + realptr
+	movw	%ax, (2 + realptr - entry16_debug)(%ebx)
 
 	/* Fixup the gdt */
+	movl	%ebx, (0x02 + gdt - entry16_debug)(%ebx)
 	movl	%ebx, %eax
 	shll	$16, %eax
 	
@@ -49,19 +51,19 @@ entry16_debug:
 	andl	$0xff000000, %edx
 	orl	%edx, %ecx
 
-	orl	%eax, 0x08 + gdt
-	orl	%ecx, 0x0c + gdt
-	orl	%eax, 0x10 + gdt
-	orl	%ecx, 0x14 + gdt	
+	orl	%eax, (0x08 + gdt - entry16_debug)(%ebx)
+	orl	%ecx, (0x0c + gdt - entry16_debug)(%ebx)
+	orl	%eax, (0x10 + gdt - entry16_debug)(%ebx)
+	orl	%ecx, (0x14 + gdt - entry16_debug)(%ebx)
 	
 	
 DEBUG_CHAR('a')
 	/* Setup the classic BIOS interrupt table at 0x0 */
-	lidt	idtptr
+	lidt	(idtptr - entry16_debug)(%ebx)
 
 DEBUG_CHAR('b')
 	/* Provide us with 16bit segments that we can use */
-	lgdt	gdt
+	lgdt	(gdt - entry16_debug)(%ebx)
 
 DEBUG_CHAR('c')
 	/* Note we don't disable the a20 line, (this shouldn't be required)
@@ -160,7 +162,7 @@ idtptr:
 gdt:
 	/* 0x00 unusable segment so used as the gdt ptr */
 	.word gdt_end - gdt - 1
-	.long gdt
+	.long 0 /* gdt */
 	.word 0
 
 	/* 0x08 16 bit real mode code segment */
diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
index aaf1273..20a1ce6 100644
--- a/purgatory/arch/i386/entry32-16.S
+++ b/purgatory/arch/i386/entry32-16.S
@@ -24,15 +24,17 @@
 	.balign 16
 entry16:
 	.code32
-	/* Compute where I am running at */
-	movl	$entry16, %ebx
+	/* Compute where I am running at (assumes esp valid) */
+	call	1f
+1:	popl	%ebx
 
 	/* Fixup my real mode segment */
 	movl	%ebx, %eax
 	shrl	$4, %eax
-	movw	%ax, 2 + realptr
+	movw	%ax, (2 + realptr - entry16)(%ebx)
 
 	/* Fixup the gdt */
+	movl	%ebx, (0x02 + gdt - entry16)(%ebx)
 	movl	%ebx, %eax
 	shll	$16, %eax
 	
@@ -44,17 +46,17 @@ entry16:
 	andl	$0xff000000, %edx
 	orl	%edx, %ecx
 
-	orl	%eax, 0x08 + gdt
-	orl	%ecx, 0x0c + gdt
-	orl	%eax, 0x10 + gdt
-	orl	%ecx, 0x14 + gdt	
+	orl	%eax, (0x08 + gdt - entry16)(%ebx)
+	orl	%ecx, (0x0c + gdt - entry16)(%ebx)
+	orl	%eax, (0x10 + gdt - entry16)(%ebx)
+	orl	%ecx, (0x14 + gdt - entry16)(%ebx)
 	
 	
 	/* Setup the classic BIOS interrupt table at 0x0 */
-	lidt	idtptr
+	lidt	(idtptr - entry16)(%ebx)
 	
 	/* Provide us with 16bit segments that we can use */
-	lgdt	gdt
+	lgdt	(gdt - entry16)(%ebx)
 
 	/* Note we don't disable the a20 line, (this shouldn't be required)
 	 * The code to do it is in kexec_test and it is a real pain.
@@ -147,7 +149,7 @@ idtptr:
 gdt:
 	/* 0x00 unusable segment so used as the gdt ptr */
 	.word gdt_end - gdt - 1
-	.long gdt
+	.long 0 /* gdt */
 	.word 0
 
 	/* 0x08 16 bit real mode code segment */
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 22b4228..7300937 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -16,9 +16,11 @@ dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS_native) 	\
 	purgatory/arch/x86_64/purgatory-x86_64.h
 
 # Don't add sources in i386/ to dist, as i386/Makefile adds them
-x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
+x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/pic.c
+
+x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large
diff --git a/purgatory/arch/x86_64/entry64-32.S b/purgatory/arch/x86_64/entry64-32.S
index 66f8a85..0d394ad 100644
--- a/purgatory/arch/x86_64/entry64-32.S
+++ b/purgatory/arch/x86_64/entry64-32.S
@@ -24,13 +24,34 @@
 	.equ	CR0_PG,        0x80000000
 
 	.text
+	.balign 16
 	.globl entry32, entry32_regs
 entry32:
 	.code64
 
-	/* Setup a gdt that should that is generally usefully */
+	/* Setup the 4G offset of entry32 lm_exit code segment */
+	movq	$0x00CF9A000000ffff, %rax
+
+	leaq	entry32(%rip), %rbx	/* Low 24 bits */
+	andq	$0xffffff, %rbx
+	shlq	$16, %rbx
+	orq	%rbx, %rax
+
+	leaq	entry32(%rip), %rbx	/* High 8 bits */
+	movq	$0xff000000, %rdx
+	andq	%rdx, %rbx
+	shlq	$32, %rbx
+	orq	%rbx, %rax
+
+	movq	%rax, (gdt + 0x20)(%rip)
+
+	/* Setup a gdt that is generally usefully */
 	lgdt	gdt(%rip)
-		
+
+	/* Setup the far pointer to the entry point */
+	movl	eip(%rip), %eax
+	movl	%eax, entry32_addr(%rip)
+
 	/* Switch to 32bit compatiblity mode */
 	ljmp	*lm_exit_addr(%rip)
 lm_exit:
@@ -60,19 +81,19 @@ lm_exit:
 	movl	%eax, %gs
 
 	/* Load the registers */
-	movl	eax, %eax
-	movl	ecx, %ecx
-	movl	edx, %edx
-	movl	esi, %esi
-	movl	edi, %edi
-	movl	esp, %esp
-	movl	ebp, %ebp
-	movl	ebx, %ebx
+	movl	%cs:eax - entry32, %eax
+	movl	%cs:ecx - entry32, %ecx
+	movl	%cs:edx - entry32, %edx
+	movl	%cs:esi - entry32, %esi
+	movl	%cs:edi - entry32, %edi
+	movl	%cs:esp - entry32, %esp
+	movl	%cs:ebp - entry32, %ebp
+	movl	%cs:ebx - entry32, %ebx
 
 	/* Jump to the loaded image */
-	jmpl	*(eip)
+	jmpl	*%cs:entry32_addr - entry32
 
-	.section ".rodata"
+	.section ".data"
 	.balign 16
 gdt:	/* 0x00 unusable segment 
 	 * 0x08 unused
@@ -88,8 +109,8 @@ gdt:	/* 0x00 unusable segment
 	/* 0x18 4GB flat data segment */
 	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
 
-	/* 0x20 dummy */
-	.word	0x0000, 0x0000, 0x0000, 0x000
+	/* 0x20 4GB flat code segment base at entry32 */
+	.word	0xFFFF, 0x0000, 0x9A00, 0x0CF
 	/* 0x28 dummy */
 	.word	0x0000, 0x0000, 0x0000, 0x000
 	/* 0x30 dummy */
@@ -115,9 +136,15 @@ gdt_end:
 	.section ".rodata"
 	.balign 4
 lm_exit_addr:
-	.long lm_exit
-	.long 0x10		
-	
+	.long lm_exit - entry32
+	.long 0x20
+
+	.section ".data"
+	.balign 4
+entry32_addr:
+	.long 0x00000000
+	.long 0x10
+
 	.section ".rodata"
 	.balign 4
 entry32_regs:  
@@ -129,6 +156,9 @@ esi:	.long 0x00000000
 edi:	.long 0x00000000
 esp:	.long 0x00000000
 ebp:	.long 0x00000000
-eip:	.long entry16
-	.size entry32_regs, . - entry32_regs
+eip:	.quad entry16	/* low 32 bits address
+			 * high 32bits zeros
+			 * uses 64bit reloc
+			 */
+	.size entry32_regs, (. - 4) - entry32_regs
 
diff --git a/purgatory/arch/x86_64/entry64.S b/purgatory/arch/x86_64/entry64.S
index 666023c..e3223b7 100644
--- a/purgatory/arch/x86_64/entry64.S
+++ b/purgatory/arch/x86_64/entry64.S
@@ -37,9 +37,10 @@ entry64:
 	movl	%eax, %fs
 	movl	%eax, %gs
 
-	movq	$stack_init, %rsp
+	leaq	stack_init(%rip), %rsp
 	pushq	$0x10 /* CS */
-	pushq	$new_cs_exit
+	leaq	new_cs_exit(%rip), %rax
+	pushq	%rax
 	lretq
 new_cs_exit:
 
diff --git a/purgatory/arch/x86_64/setup-x86_64.S b/purgatory/arch/x86_64/setup-x86_64.S
index 74997fa..95572d8 100644
--- a/purgatory/arch/x86_64/setup-x86_64.S
+++ b/purgatory/arch/x86_64/setup-x86_64.S
@@ -42,10 +42,10 @@ purgatory_start:
 	/* In 64bit mode the code segment is meaningless */
 
 	movq	0(%rsp), %rax
-	movq	%rax, jump_back_entry
+	movq	%rax, jump_back_entry(%rip)
 
 	/* Setup a stack */
-	movq	$lstack_end, %rsp
+	leaq	lstack_end(%rip), %rsp
 
 	/* Call the C code */
 	call purgatory


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
