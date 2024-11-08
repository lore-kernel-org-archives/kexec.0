Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ACDD5C0C3
	for <kexec@archiver.kernel.org>; Fri,  8 Nov 2024 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wM8HQZ51sHZFE+84PiFBEFaMDEQ58jdojOzEBspbzp4=; b=wnB4WB+mu4qi49
	IktB0bS/M5lwaKuNb+OvS4rLMk1N9hHgh3vABU0O5qCU9L6Q1ZcIJzh+VGoi5MkRhKyjli9N+Pqto
	FaqEnQsWzLqwZ5qKZ0WrcDT9ka/r3l1kBdvYYvFVTp4bv+aqPndAR5UPg4zUk539alibwkywDocwi
	Gcfc5vwfLHC9CkRO6yQQcQeAqTgxHm8fEkaVUKqZcgNU072+bX0yuMhzp2qlH7/5CcKJ/Qa2y6LQy
	9E2u/0ZtJN0PHDymdz6/Gw1ctJETW1xt9kMmR17ahTOBBJ1BNczPcBsHTmew1+xohBAtEpomp1OQj
	Bpjd/YvpN5Dig5iVvjNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9OCL-0000000AXlV-1Ah4;
	Fri, 08 Nov 2024 12:34:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O7R-0000000AWuz-0h0B
	for kexec@bombadil.infradead.org;
	Fri, 08 Nov 2024 12:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dh3hlFRHmKozODQqsjiGqNnVkm197eOaTOJbKmxZfsE=; b=YE+dpraO3cik2g5RcG6d6Re/RX
	mQact8UnwNjtYZ8lG0/n0k7fkpi9W/DM91zy0RwqhUa8pHHL7GicI4cqxkGrGjyazoypmFtb9wjlX
	TlfjSd+TGEU+45cvpH1dzSWxEaSko/iQKTeDCiqiVlGPgA2Q1mjtFzrwuegxqQ+wE6ati/zcgiIao
	96r4n0r07ttOkEAIow5f/Hd+G85i2tyVh+66OSP9FK+yOuQtQws4Z2pQ/6cGfAr9z2wxuhCmMLonc
	jM5GzPxflj4PKJGhjRQVGYNnCrnJ5YVlj5kHrwssDoFOXCc2+EYmqKrU8ugN93ZZj7ydLJnv0UxxP
	9FqzpFrQ==;
Received: from [74.85.93.57] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O7N-0000000CJ2X-13cm;
	Fri, 08 Nov 2024 12:29:38 +0000
Date: Fri, 08 Nov 2024 04:29:33 -0800
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org> <20241108052241.3972433-1-dwmw2@infradead.org> <20241108052241.3972433-2-dwmw2@infradead.org> <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
Message-ID: <1D279568-F296-40F1-9DFB-6AB3F3E589DD@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 8 November 2024 03:26:58 GMT-08:00, "H. Peter Anvin" <hpa@zytor.com> wrote:
>On November 8, 2024 6:22:41 AM GMT+01:00, David Woodhouse <dwmw2@infradead.org> wrote:
>>From: David Woodhouse <dwmw@amazon.co.uk>
>>
>>Now that it's handled sanely by a linker script we can have actual data,
>>and just use %rip-relative addressing to access it.
>>
>>If we could call the *copy* instead of the original relocate_kernel in
>>the kernel text, then we could use %rip-relative addressing everywhere.
>>
>>Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>>---
>> arch/x86/kernel/relocate_kernel_64.S | 58 ++++++++++++++++------------
>> arch/x86/kernel/vmlinux.lds.S        |  2 +-
>> 2 files changed, 35 insertions(+), 25 deletions(-)
>>
>>diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>>index 1efcbd340528..577aa1672349 100644
>>--- a/arch/x86/kernel/relocate_kernel_64.S
>>+++ b/arch/x86/kernel/relocate_kernel_64.S
>>@@ -27,18 +27,28 @@
>>  * ~ control_page + PAGE_SIZE are used as data storage and stack for
>>  * jumping back
>>  */
>>-#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
>> 
>>+	.section .data.relocate_kernel,"a";
>> /* Minimal CPU state */
>>-#define RSP			DATA(0x0)
>>-#define CR0			DATA(0x8)
>>-#define CR3			DATA(0x10)
>>-#define CR4			DATA(0x18)
>>-
>>+SYM_DATA_LOCAL(saved_rsp, .quad 0)
>>+SYM_DATA_LOCAL(saved_cr0, .quad 0)
>>+SYM_DATA_LOCAL(saved_cr3, .quad 0)
>>+SYM_DATA_LOCAL(saved_cr4, .quad 0)
>> /* other data */
>>-#define CP_PA_TABLE_PAGE	DATA(0x20)
>>-#define CP_PA_SWAP_PAGE		DATA(0x28)
>>-#define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
>>+SYM_DATA_LOCAL(pa_table_page, .quad 0)
>>+SYM_DATA_LOCAL(pa_swap_page, .quad 0)
>>+SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
>>+
>>+/*
>>+ * There are two physical copies of relocate_kernel(), one in the original
>>+ * Kernel text and the other copied to the control page. There is a virtual
>>+ * mapping of each, in the original kernel. It is the *original* which is
>>+ * called from machine_kexec(), largely becaose the copy isn't mapped as an
>>+ * executable page. Thus, this code cannot just use %rip-relative addressing
>>+ * until after the %cr3 change and the jump to identity_mapped(). Until
>>+ * then, some pointer arithmetic is required.
>>+ */
>>+#define DATA(x) (x - relocate_kernel)
>> 
>> 	.section .text.relocate_kernel,"ax";
>> 	.code64
>>@@ -63,13 +73,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>> 	pushf
>> 
>> 	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
>>-	movq	%rsp, RSP(%r11)
>>+	movq	%rsp, DATA(saved_rsp)(%r11)
>> 	movq	%cr0, %rax
>>-	movq	%rax, CR0(%r11)
>>+	movq	%rax, DATA(saved_cr0)(%r11)
>> 	movq	%cr3, %rax
>>-	movq	%rax, CR3(%r11)
>>+	movq	%rax, DATA(saved_cr3)(%r11)
>> 	movq	%cr4, %rax
>>-	movq	%rax, CR4(%r11)
>>+	movq	%rax, DATA(saved_cr4)(%r11)
>> 
>> 	/* Save CR4. Required to enable the right paging mode later. */
>> 	movq	%rax, %r13
>>@@ -94,9 +104,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>> 	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
>> 
>> 	/* save some information for jumping back */
>>-	movq	%r9, CP_PA_TABLE_PAGE(%r11)
>>-	movq	%r10, CP_PA_SWAP_PAGE(%r11)
>>-	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
>>+	movq	%r9, DATA(pa_table_page)(%r11)
>>+	movq	%r10, DATA(pa_swap_page)(%r11)
>>+	movq	%rdi, DATA(pa_backup_pages_map)(%r11)
>> 
>> 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
>> 	movq	%rcx, %r11
>>@@ -128,7 +138,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>> 	/* set return address to 0 if not preserving context */
>> 	pushq	$0
>> 	/* store the start address on the stack */
>>-	pushq   %rdx
>>+	pushq   start_address(%rip)
>> 
>> 	/*
>> 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
>>@@ -227,9 +237,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>> 	/* get the re-entry point of the peer system */
>> 	movq	0(%rsp), %rbp
>> 	leaq	relocate_kernel(%rip), %r8
>>-	movq	CP_PA_SWAP_PAGE(%r8), %r10
>>-	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
>>-	movq	CP_PA_TABLE_PAGE(%r8), %rax
>>+	movq	pa_swap_page(%rip), %r10
>>+	movq	pa_backup_pages_map(%rip), %rdi
>>+	movq	pa_table_page(%rip), %rax
>> 	movq	%rax, %cr3
>> 	lea	PAGE_SIZE(%r8), %rsp
>> 	call	swap_pages
>>@@ -243,11 +253,11 @@ SYM_CODE_END(identity_mapped)
>> SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
>> 	UNWIND_HINT_END_OF_STACK
>> 	ANNOTATE_NOENDBR // RET target, above
>>-	movq	RSP(%r8), %rsp
>>-	movq	CR4(%r8), %rax
>>+	movq	saved_rsp(%rip), %rsp
>>+	movq	saved_cr4(%rip), %rax
>> 	movq	%rax, %cr4
>>-	movq	CR3(%r8), %rax
>>-	movq	CR0(%r8), %r8
>>+	movq	saved_cr3(%rip), %rax
>>+	movq	saved_cr0(%r8), %r8
>> 	movq	%rax, %cr3
>> 	movq	%r8, %cr0
>> 	movq	%rbp, %rax
>>diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>>index ad451371e179..65f879b31a82 100644
>>--- a/arch/x86/kernel/vmlinux.lds.S
>>+++ b/arch/x86/kernel/vmlinux.lds.S
>>@@ -100,7 +100,7 @@ const_pcpu_hot = pcpu_hot;
>> 	. = ALIGN(PAGE_SIZE);					\
>> 	__relocate_kernel_start = .;				\
>> 	*(.text.relocate_kernel);				\
>>-	*(.rodata.relocate_kernel);				\
>>+	*(.data.relocate_kernel);				\
>> 	__relocate_kernel_end = .;
>> #else
>> #define KEXEC_RELOCATE_KERNEL_TEXT
>
>Looks good at first glance. I'm currently traveling so I haven't fully reviewed it though.

Ta. That's good enough for me to go ahead and port the rest over. 

Is there a selftest for the preserve-context mode somewhere, with a payload that just does a "ret"?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
