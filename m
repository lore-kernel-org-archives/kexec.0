Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaUea-0004nQ-S0
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 16:57:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 19 Nov 2012 08:56:22 -0800
Message-ID: <87r4np4jm1.fsf@xmission.com>
MIME-Version: 1.0
Subject: [PATCH] kexec x86_64: Make purgatory relocatable anywhere in the
 64bit address space.
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
To: Simon Horman <horms@verge.net.au>
Cc: Yinghai Lu <yinghai@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>


Remove kexec/arch/i386/compat_x6_64.S
purgatory/arch/i386/linux-entry16.S and purgatory/arch/i386/entry16.S
Those were early attempts at entry32-16.S that should have been
deleted long ago.

Strip the purgatory code of debug symbols.  There is no need to carry
debug symbols we will never use around in /sbin/kexec.

On x86_64 use -mcmodel=large so that the code is built without
any 32bit assumptions.  -mcmodel=medium and -mcmodel=small
result int code that has 32bit relocations against variables
that can live anywhere in the address space

Modify the assembly in entry64.S and setup-x86_64.S to use %rip
relative addressing of variables so no relocates are emitted.

Modify entry64-32.S so that it does not have any relocations that can
not be processed when purgatory is loaded above 4G.  entry64-32.S
jumps to a 32bit entry point and can not itself be used above 4G so
these changes merely prevent it from being a problem in the other case.

eip is modifed to be a 64bit value of which only the low 32bits are
exported outside of entry64-32.S

The long mode exit code is modified to run with a %cs value whose
base address is the address of the symbol entry32.  From there
all of the 32bit code in entry64-32.S can read variables by reading
them through %cs.  Until the final jump to the the target address
which is made a far jump reloading %cs and the intstruction pointer.

Modify entry32-16.S and entry32-16-debug.S to be position independent
32bit code.  At their start make a short call to push the current value
of %eip on the stack and pop it off.  Allowing the calculation of the
address of entry16 which the code has always kept in %ebx.

Update the pointer to the gdt in the gdt so that lgdt will work.

Modify the instructions in entry32-16.S and entry32-16-debug.S so
that the 32bit code uses offsets from %ebx which points at entry16.

Tested-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kexec/arch/i386/compat_x86_64.S        |  131 -------
 purgatory/Makefile                     |    1 +
 purgatory/arch/i386/entry16.S          |  160 --------
 purgatory/arch/i386/entry32-16-debug.S |   25 +-
 purgatory/arch/i386/entry32-16.S       |   25 +-
 purgatory/arch/i386/linux-entry16.S    |  623 --------------------------------
 purgatory/arch/x86_64/Makefile         |    4 +-
 purgatory/arch/x86_64/entry64-32.S     |   68 +++-
 purgatory/arch/x86_64/entry64.S        |    5 +-
 purgatory/arch/x86_64/setup-x86_64.S   |    4 +-
 10 files changed, 88 insertions(+), 958 deletions(-)
 delete mode 100644 kexec/arch/i386/compat_x86_64.S
 delete mode 100644 purgatory/arch/i386/entry16.S
 delete mode 100644 purgatory/arch/i386/linux-entry16.S

diff --git a/kexec/arch/i386/compat_x86_64.S b/kexec/arch/i386/compat_x86_64.S
deleted file mode 100644
index f8a04e9..0000000
--- a/kexec/arch/i386/compat_x86_64.S
+++ /dev/null
@@ -1,131 +0,0 @@
-/*
- * kexec: Linux boots Linux
- *
- * Copyright (C) 2003,2004,2005  Eric Biederman (ebiederm@xmission.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation (version 2 of the License).
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#define USE_LRET 0
-	
-.data
-	.equ	MSR_K6_EFER,   0xC0000080
-	.equ	EFER_LME,      0x00000100
-	.equ	X86_CR4_PAE,   0x00000020
-	.equ	CR0_PG,        0x80000000
-
-	.globl compat_x86_64, compat_x86_64_size, compat_x86_64_entry32
-	.code64
-	.balign 16	
-compat_x86_64:
-	/* Compute where I am running at */
-	leaq	compat_x86_64(%rip), %rbx
-
-	/* Relocate the code */
-	addq	%rbx, gdt_addr(%rip)
-#if !USE_LRET
-	addl	%ebx, lm_exit_addr(%rip)
-#endif	
-
-	/* Lookup the 32bit start address */
-	movl	compat_x86_64_entry32(%rip), %ebx
-	pushq	%rbx
-
-#if USE_LRET	
-	/* Push the 64bit start address */
-	pushq	$0x10
-	pushq	lm_exit(%rip)
-#endif	
-	
-	/* This also acts as a serializing instruction ensuring
-	 * my self modifying code works.
-	 */
-	lgdt	gdt(%rip)
-
-#if USE_LRET
-	lret
-#else				
-	/* Switch to 32bit compatiblity mode */
-	ljmp	*lm_exit_addr(%rip)
-#endif	
-lm_exit:
-	.code32
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	andl	$~CR0_PG, %eax
-	movl	%eax, %cr0
-
-	/* Disable long mode */
-	movl	$MSR_K6_EFER, %ecx
-	rdmsr
-	andl	$~EFER_LME, %eax
-	wrmsr
-
-	/* Disable PAE */
-	xorl	%eax, %eax
-	movl	%eax, %cr4
-
-	/* load the data segments */
-	movl	$0x18, %eax	/* data segment */
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
-	/* Remove the 32 bits of the 64 bit start address */
-	popl	%eax
-
-	/* set all of the registers to known values */
-	/* leave %esp alone */
-
-	xorl	%eax, %eax
-	xorl	%ebx, %ebx
-	xorl    %ecx, %ecx
-	xorl    %edx, %edx
-	xorl    %esi, %esi
-	xorl    %edi, %edi
-	xorl    %ebp, %ebp
-
-	ret
-
-	.balign 16
-gdt:	/* 0x00 unusable segment 
-	 * 0x08 unused
-	 * so use them as the gdt ptr
-	 */
-	.word	gdt_end - gdt - 1
-gdt_addr:	
-	.quad	gdt - compat_x86_64
-	.word	0, 0, 0
-
-	/* 0x10 4GB flat code segment */
-	.word	0xFFFF, 0x0000, 0x9A00, 0x00CF
-	/* 0x18 4GB flat data segment */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:	
-
-#if !USE_LRET	
-lm_exit_addr:
-	.long lm_exit - compat_x86_64
-	.long 0x10
-#endif	
-
-compat_x86_64_entry32:
-	.long 0  
-	     	
-compat_x86_64_end:
-compat_x86_64_size:
-	.long compat_x86_64_end - compat_x86_64
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
diff --git a/purgatory/arch/i386/entry16.S b/purgatory/arch/i386/entry16.S
deleted file mode 100644
index c4a3dad..0000000
--- a/purgatory/arch/i386/entry16.S
+++ /dev/null
@@ -1,160 +0,0 @@
-/*
- * kexec: Linux boots Linux
- *
- * Copyright (C) 2003,2004  Eric Biederman (ebiederm@xmission.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation (version 2 of the License).
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#undef i386	
-	.text
-	.globl entry16, entry16_regs
-	.arch i386
-	.balign 16
-entry16:
-	.code32
-	/* Compute where I am running at */
-	movl	$entry16, %ebx	
-
-	/* Fixup my real mode segment */
-	movl	%ebx, %eax
-	shrl	$4, %eax
-	movw	%ax, 2 + realptr
-
-	/* Fixup the gdt */
-	movl	%ebx, %eax
-	shll	$16, %eax
-	
-	movl	%ebx, %ecx
-	shrl	$16, %ecx
-	andl	$0xff, %ecx
-	
-	movl	%ebx, %edx
-	andl	$0xff000000, %edx
-	orl	%edx, %ecx
-
-	orl	%eax, 0x08 + gdt
-	orl	%ecx, 0x0c + gdt
-	orl	%eax, 0x10 + gdt
-	orl	%ecx, 0x14 + gdt	
-	
-	
-	/* Setup the classic BIOS interrupt table at 0x0 */
-	lidt	idtptr
-	
-	/* Provide us with 16bit segments that we can use */
-	lgdt	gdt
-
-	/* Note we don't disable the a20 line, (this shouldn't be required)
-	 * The code to do it is in kexec_test and it is a real pain.
-	 * I will worry about that when I need it.
-	 */
-	
-	/* Load 16bit data segments, to ensure the segment limits are set */
-	movl	$0x10, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
-	/* switch to 16bit mode */
-	ljmp	$0x08, $1f - entry16
-1:
-	.code16
-	/* Disable Paging and protected mode */
-	/* clear the PG & PE bits of CR0 */
-	movl	%cr0,%eax
-	andl	$~((1 << 31)|(1<<0)),%eax
-	movl	%eax,%cr0
-
-	/* make intersegment jmp to flush the processor pipeline
-	 * and reload %cs:%eip (to clear upper 16 bits of %eip).
-	 */
-	ljmp	*(realptr - entry16)
-3:
-	/* we are in real mode now
-	 * set up the real mode segment registers : %ds, $ss, %es
-	 */
-	/* Setup the data segment */
-	movw	%cs, %ax
-	movw	%ax, %ds
-
-	/* Load the registers */
-	movl	eax - entry16, %eax
-	movl	ebx - entry16, %ebx
-	movl	ecx - entry16, %ecx
-	movl	edx - entry16, %edx
-	movl	esi - entry16, %esi
-	movl	edi - entry16, %esi
-	movl	esp - entry16, %esp
-	movl	ebp - entry16, %ebp
-	movw	es  - entry16, %es
-	movw	ss  - entry16, %ss
-	movw	fs  - entry16, %fs
-	movw	gs  - entry16, %gs
-	movw	ds  - entry16, %ds
-
-	/* Jump to the kernel entrypoint */
-	ljmp	%cs:*(realdest - entry16)
-
-	.balign 4
-entry16_regs:	
-eax:	.long	0x00000000
-ebx:	.long	0x00000000
-ecx:	.long	0x00000000
-edx:	.long	0x00000000
-esi:	.long	0x00000000
-edi:	.long	0x00000000
-esp:	.long	0x00000000
-ebp:	.long	0x00000000
-ds:	.word	0x0000
-es:	.word	0x0000
-ss:	.word	0x0000
-fs:	.word	0x0000
-gs:	.word	0x0000
-realdest:
-ip:	.word	0x0000
-cs:	.word	0x0000
-pad:	.word	0x0000
-	.size entry16_regs, . - entry16_regs
-
-	.balign 16
-realptr:		
-	.word	3b - entry16
-	.word	0x0000
-	
-	.data
-	.balign 16
-
-idtptr:
-	/* 256 entry idt at 0 */
-	.word	0x400 - 1
-	.word	0, 0
-
-	.balign 16	
-gdt:
-	/* 0x00 unusable segment so used as the gdt ptr */
-	.word gdt_end - gdt - 1
-	.long gdt
-	.word 0
-
-	/* 0x08 16 bit real mode code segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x9b, 0x00, 0x00
-
-	/* 0x10 16 bit real mode data segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x93, 0x00, 0x00
-gdt_end:
diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
index 82b58ca..5167944 100644
--- a/purgatory/arch/i386/entry32-16-debug.S
+++ b/purgatory/arch/i386/entry32-16-debug.S
@@ -29,15 +29,20 @@
 	.balign 16
 entry16_debug:
 	.code32
-	/* Compute where I am running at */
-	movl	$entry16_debug, %ebx	
+	/* Compute where I am running at (assumes esp valid) */
+	call	1f
+1:	popl	%ebx
+	subl	$(1b - entry16_debug), %ebx
 
 	/* Fixup my real mode segment */
 	movl	%ebx, %eax
 	shrl	$4, %eax
-	movw	%ax, 2 + realptr
+	movw	%ax, (2 + realptr - entry16_debug)(%ebx)
 
 	/* Fixup the gdt */
+	leal	(gdt - entry16_debug)(%ebx), %eax
+	movl	%eax, (0x02 + gdt - entry16_debug)(%ebx)
+
 	movl	%ebx, %eax
 	shll	$16, %eax
 	
@@ -49,19 +54,19 @@ entry16_debug:
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
@@ -160,7 +165,7 @@ idtptr:
 gdt:
 	/* 0x00 unusable segment so used as the gdt ptr */
 	.word gdt_end - gdt - 1
-	.long gdt
+	.long 0 /* gdt */
 	.word 0
 
 	/* 0x08 16 bit real mode code segment */
diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
index aaf1273..c051aab 100644
--- a/purgatory/arch/i386/entry32-16.S
+++ b/purgatory/arch/i386/entry32-16.S
@@ -24,15 +24,20 @@
 	.balign 16
 entry16:
 	.code32
-	/* Compute where I am running at */
-	movl	$entry16, %ebx
+	/* Compute where I am running at (assumes esp valid) */
+	call	1f
+1:	popl	%ebx
+	subl	$(1b - entry16), %ebx
 
 	/* Fixup my real mode segment */
 	movl	%ebx, %eax
 	shrl	$4, %eax
-	movw	%ax, 2 + realptr
+	movw	%ax, (2 + realptr - entry16)(%ebx)
 
 	/* Fixup the gdt */
+	leal	(gdt - entry16)(%ebx), %eax
+	movl	%eax, (0x02 + gdt - entry16)(%ebx)
+
 	movl	%ebx, %eax
 	shll	$16, %eax
 	
@@ -44,17 +49,17 @@ entry16:
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
@@ -147,7 +152,7 @@ idtptr:
 gdt:
 	/* 0x00 unusable segment so used as the gdt ptr */
 	.word gdt_end - gdt - 1
-	.long gdt
+	.long 0 /* gdt */
 	.word 0
 
 	/* 0x08 16 bit real mode code segment */
diff --git a/purgatory/arch/i386/linux-entry16.S b/purgatory/arch/i386/linux-entry16.S
deleted file mode 100644
index 7ab0b2a..0000000
--- a/purgatory/arch/i386/linux-entry16.S
+++ /dev/null
@@ -1,623 +0,0 @@
-/*
- * kexec: Linux boots Linux
- *
- * Copyright (C) 2003,2004  Eric Biederman (ebiederm@xmission.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation (version 2 of the License).
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#if 1
-#define TTYS0_BASE	0x3f8
-#define TTYS0_RBR (TTYS0_BASE+0x00)
-#define TTYS0_TBR TTYS0_RBR
-#define TTYS0_LSR (TTYS0_BASE+0x05)
-
-	
-	/* uses:	ax, dx */
-#define TTYS0_TX_AL		\
-	mov	%al, %ah	; \
-9:	mov	$TTYS0_LSR, %dx	; \
-	inb	%dx, %al	; \
-	test	$0x20, %al	; \
-	je	9b		; \
-	mov	$TTYS0_TBR, %dx	; \
-	mov	%ah, %al	; \
-	outb	%al, %dx	; \
-9:	mov	$TTYS0_LSR, %dx	; \
-	inb	%dx, %al	; \
-	test	$0x40, %al	; \
-	jz	9b
-	
-
-
-	/* uses:	ax, dx */
-#define TTYS0_TX_CHAR(byte)	\
-	mov	byte, %al	; \
-	TTYS0_TX_AL
-
-	/* uses:	ax, dx */
-#define TTYS0_TX_HEX32(lword)	\
-	mov	lword, %eax	; \
-	shr	$28, %eax	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$24, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$20, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$16, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$12, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$8, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$4, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL
-
-
-#define DEBUG_CHAR(x) TTYS0_TX_CHAR($x) ;  TTYS0_TX_CHAR($'\r') ;  TTYS0_TX_CHAR($'\n')
-#define DEBUG_TX_HEX32(x) TTYS0_TX_HEX32(x) ;  TTYS0_TX_CHAR($'\r') ;  TTYS0_TX_CHAR($'\n')
-#else
-#define DEBUG_CHAR(x)
-#define DEBUG_TX_HEX32(x)
-#endif
-	
-#undef i386	
-	.text
-	.globl entry16, entry16_regs
-	.arch i386
-	.balign 16
-entry16:
-	.code32
-
-DEBUG_CHAR('a')
-	/* Setup the classic BIOS interrupt table at 0x0 */
-	lidt	idtptr
-
-DEBUG_CHAR('b')
-	/* Provide us with 16bit segments that we can use */
-	lgdt	gdt
-
-DEBUG_CHAR('c')
-	/* Note we don't disable the a20 line, (this shouldn't be required)
-	 * The code to do it is in kexec_test and it is a real pain.
-	 * I will worry about that when I need it.
-	 */
-	
-	/* Load 16bit data segments, to ensure the segment limits are set */
-	movl	$0x10, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
-DEBUG_CHAR('d')
-
-	/* switch to 16bit mode */
-	ljmp	$0x08, $1f - entry16
-1:
-	.code16
-DEBUG_CHAR('e')
-	/* Disable Paging and protected mode */
-	/* clear the PG & PE bits of CR0 */
-	movl	%cr0,%eax
-	andl	$~((1 << 31)|(1<<0)),%eax
-	movl	%eax,%cr0
-
-DEBUG_CHAR('f')
-	/* make intersegment jmp to flush the processor pipeline
-	 * and reload %cs:%eip (to clear upper 16 bits of %eip).
-	 */
-	ljmp	*(realptr - entry16)
-3:
-DEBUG_CHAR('g')
-	/* we are in real mode now
-	 * set up the real mode segment registers : %ds, $ss, %es
-	 */
-	/* Setup the data segment */
-	movw	%cs, %ax
-	movw	%ax, %ds
-
-DEBUG_CHAR('h')
-	/* Load the registers */
-	movl	eax - entry16, %eax
-	movl	ebx - entry16, %ebx
-	movl	ecx - entry16, %ecx
-	movl	edx - entry16, %edx
-	movl	esi - entry16, %esi
-	movl	edi - entry16, %esi
-	movl	esp - entry16, %esp
-	movl	ebp - entry16, %ebp
-	movw	es  - entry16, %es
-	movw	ss  - entry16, %ss
-	movw	fs  - entry16, %fs
-	movw	gs  - entry16, %gs
-	movw	ds  - entry16, %ds
-
-	/* Jump to the kernel entrypoint */
-	ljmp	%cs:*(realdest - entry16)
-
-	.balign 4
-entry16_regs:	
-eax:	.long	0x00000000
-ebx:	.long	0x00000000
-ecx:	.long	0x00000000
-edx:	.long	0x00000000
-esi:	.long	0x00000000
-edi:	.long	0x00000000
-esp:	.long	0x00000000
-ebp:	.long	0x00000000
-ds:	.word	0x0000
-es:	.word	0x0000
-ss:	.word	0x0000
-fs:	.word	0x0000
-gs:	.word	0x0000
-realdest:
-ip:	.word	0x0000
-cs:	.word	0x0000
-	.size entry16_regs, . - entry16_regs	
-
-	.balign 16
-realptr:		
-	.word	3b - entry16
-	.word	0x0000
-	
-	.data
-	.balign 4
-
-idtptr:
-	/* 256 entry idt at 0 */
-	.word	0x400 - 1
-	.word	0, 0
-
-gdt:
-	/* 0x00 unusable segment so used as the gdt ptr */
-	.word gdt_end - gdt - 1
-	.long gdt
-	.word 0
-
-	/* 0x08 16 bit real mode code segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x9b, 0x00, 0x00
-
-	/* 0x10 16 bit real mode data segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x93, 0x00, 0x00
-gdt_end:
-/*
- * kexec: Linux boots Linux
- *
- * Copyright (C) 2003,2004  Eric Biederman (ebiederm@xmission.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation (version 2 of the License).
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#if 1
-#define TTYS0_BASE	0x3f8
-#define TTYS0_RBR (TTYS0_BASE+0x00)
-#define TTYS0_TBR TTYS0_RBR
-#define TTYS0_LSR (TTYS0_BASE+0x05)
-
-	
-	/* uses:	ax, dx */
-#define TTYS0_TX_AL		\
-	mov	%al, %ah	; \
-9:	mov	$TTYS0_LSR, %dx	; \
-	inb	%dx, %al	; \
-	test	$0x20, %al	; \
-	je	9b		; \
-	mov	$TTYS0_TBR, %dx	; \
-	mov	%ah, %al	; \
-	outb	%al, %dx	; \
-9:	mov	$TTYS0_LSR, %dx	; \
-	inb	%dx, %al	; \
-	test	$0x40, %al	; \
-	jz	9b
-	
-
-
-	/* uses:	ax, dx */
-#define TTYS0_TX_CHAR(byte)	\
-	mov	byte, %al	; \
-	TTYS0_TX_AL
-
-	/* uses:	ax, dx */
-#define TTYS0_TX_HEX32(lword)	\
-	mov	lword, %eax	; \
-	shr	$28, %eax	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$24, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$20, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$16, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$12, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$8, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	shr	$4, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL		; \
-				; \
-	mov	lword, %eax	; \
-	and	$0x0f, %al	; \
-	add	$'0', %al	; \
-	cmp	$'9', %al	; \
-	jle	9f		; \
-	add	$39, %al	; \
-9:				; \
-	TTYS0_TX_AL
-
-
-#define DEBUG_CHAR(x) TTYS0_TX_CHAR($x) ;  TTYS0_TX_CHAR($'\r') ;  TTYS0_TX_CHAR($'\n')
-#define DEBUG_TX_HEX32(x) TTYS0_TX_HEX32(x) ;  TTYS0_TX_CHAR($'\r') ;  TTYS0_TX_CHAR($'\n')
-#else
-#define DEBUG_CHAR(x)
-#define DEBUG_TX_HEX32(x)
-#endif
-
-.data
-	.globl setup16_debug_start, setup16_debug_end, setup16_debug_size, setup16_debug_align
-	.globl setup16_debug_regs
-	.globl setup16_debug_kernel_pre_protected
-	.globl setup16_debug_first_code32
-	.globl setup16_debug_old_code32
-setup16_debug_start:
-_reloc = .
-	.balign 16
-	.code32
-DEBUG_CHAR('a')
-	/* Compute where I am running at */
-	call	1f
-1:	popl	%ebx
-	subl	$(1b - _reloc), %ebx
-
-	/* Remember where I am running at */
-	movl	%ebx, location - _reloc(%ebx)
-	
-DEBUG_CHAR('b')
-	/* Fixup my real mode segment */
-	movl	%ebx, %eax
-	shrl	$4, %eax
-	movw	%ax, 2 + realptr - _reloc(%ebx)
-
-DEBUG_CHAR('c')
-	/* Fixup the gdt */
-	movl	%ebx, %eax
-	shll	$16, %eax
-	
-	movl	%ebx, %ecx
-	shrl	$16, %ecx
-	andl	$0xff, %ecx
-
-	movl	%ebx, %edx
-	andl	$0xff000000, %edx
-	orl	%edx, %ecx
-	
-	addl	%ebx, gdtaddr - _reloc(%ebx)
-	addl	%ebx, debug_gdtaddr - _reloc(%ebx)
-	orl	%eax, 0x08 + gdt - _reloc(%ebx)
-	orl	%ecx, 0x0c + gdt - _reloc(%ebx)
-	orl	%eax, 0x10 + gdt - _reloc(%ebx)
-	orl	%ecx, 0x14 + gdt - _reloc(%ebx)
-
-
-	
-DEBUG_CHAR('d')
-	/* Setup the classic BIOS interrupt table at 0x0 */
-	lidt	idtptr - _reloc(%ebx)
-	
-	/* Provide us with 16bit segments that we can use */
-	lgdt	gdtptr - _reloc(%ebx)
-
-	/* Note we don't disable the a20 line, (this shouldn't be required)
-	 * The code to do it is in kexec_test and it is a real pain.
-	 * I will worry about that when I need it.
-	 */
-	
-	/* Load 16bit data segments, to ensure the segment limits are set */
-	movl	$0x10, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
-	/* switch to 16bit mode */
-	
-	ljmp	$0x08, $2f - _reloc
-2:
-	.code16
-DEBUG_CHAR('e')
-	/* Disable Paging and protected mode */
-	/* clear the PG & PE bits of CR0 */
-	movl	%cr0,%eax
-	andl	$~((1 << 31)|(1<<0)),%eax
-	movl	%eax,%cr0
-
-DEBUG_CHAR('f')
-	/* make intersegment jmp to flush the processor pipeline
-	 * and reload %cs:%eip (to clear upper 16 bits of %eip).
-	 */
-	ljmp	*(realptr - _reloc)
-3:
-DEBUG_CHAR('g')
-	/* we are in real mode now
-	 * set up the real mode segment registers : %ds, $ss, %es
-	 */
-	/* Setup the data segment */
-	movw	%cs, %ax
-	movw	%ax, %ds
-
-DEBUG_CHAR('h')
-	/* Load the registers */
-	movl	eax - _reloc, %eax
-	movl	ebx - _reloc, %ebx
-	movl	ecx - _reloc, %ecx
-	movl	edx - _reloc, %edx
-	movl	esi - _reloc, %esi
-	movl	edi - _reloc, %esi
-	movl	esp - _reloc, %esp
-	movl	ebp - _reloc, %ebp
-	movw	es - _reloc, %es
-	movw	ss - _reloc, %ss
-	movw	fs - _reloc, %fs
-	movw	gs - _reloc, %gs
-	movw	ds - _reloc, %ds
-
-	/* Jump to the kernel entrypoint */
-	ljmp	%cs:*(realdest - _reloc)
-
-setup16_debug_regs:	
-eax:	.long	0x00000000
-ebx:	.long	0x00000000
-ecx:	.long	0x00000000
-edx:	.long	0x00000000
-esi:	.long	0x00000000
-edi:	.long	0x00000000
-esp:	.long	0x00000000
-ebp:	.long	0x00000000
-ds:	.word	0x0000
-es:	.word	0x0000
-ss:	.word	0x0000
-fs:	.word	0x0000
-gs:	.word	0x0000
-realdest:
-ip:	.word	0x0000
-cs:	.word	0x0000
-
-	.balign 16
-realptr:		
-	.word	3b - _reloc
-	.word	0x0000
-	
-idtptr:
-	/* 256 entry idt at 0 */
-	.word	0x400 - 1
-	.word	0, 0
-
-gdtptr:
-	.word	gdt_end - gdt - 1
-gdtaddr:
-	.long	gdt - _reloc
-
-gdt:
-	/* dummy */
-	.word 0, 0, 0, 0
-
-	/* 16 bit real mode code segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x9b, 0x00, 0x00
-
-	/* 16 bit real mode data segment */
-	.word	0xffff, 0x0000
-	.byte	0x00, 0x93, 0x00, 0x00
-gdt_end:
-
-debug_gdt:
-	/* 0x00 */
-	.word	debug_gdt_end - debug_gdt - 1
-debug_gdtaddr:	
-	.long	debug_gdt - _reloc
-	.word 0
-
-	/* 0x08 */
-	.word	0, 0, 0, 0	/* Nothing in the first gdt entry */
-
-	/* 0x10 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x18 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-
-
-	/* 0x20 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x28 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-
-	
-	/* 0x30 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x38 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-
-	
-	/* 0x40 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x48 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-
-	
-	/* 0x50 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x58 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-
-	
-	/* 0x60 4Gb - (0x100000*0x1000 = 4Gb), base address = 0, code read/exec, granularity = 4096, 386 */
-	.word	0xFFFF,	0x00, 0x9A00, 0x00CF
-	/* 0x68 4Gb - (0x100000*0x1000 = 4Gb*), base address = 0, data read/write, granularity = 4096, 386 */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-debug_gdt_end:
-	
-		
-setup16_debug_kernel_pre_protected:
-	.code16
-	DEBUG_CHAR('i')
-	cli					# no interrupts allowed !
-	movb	$0x80, %al			# disable NMI for bootup
-						# sequence
-	outb	%al, $0x70
-	lret
-setup16_debug_first_code32:
-	.code32
-	.byte	0xbf	/* movl $0x12345678, %edi */
-location:
-	.long	0x12345678
-	DEBUG_CHAR('j')
-	.byte	0xb8	/* movl $0x10000, %eax */
-setup16_debug_old_code32:
-	.long	0x10000
-	jmp	%eax
-setup16_debug_end:
-setup16_debug_size:
-	.long setup16_debug_end - setup16_debug_start
-setup16_debug_align:
-	.long 16
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
index 66f8a85..f2b6377 100644
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
+	ljmp	*%cs:entry32_addr - entry32
 
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
-- 
1.7.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
