Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB19D3B7F5
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kRNwMlvi/Q0U2ObjRznPAi0eKAWL0TLaUoagER3O75M=; b=DQ6dI1V0zMorYlweamiPXOllEY
	HB0qXlgU9ZZFlYU1IlOOpPXzgQ1rhXVtHrtJ4nAL+6jYiDeoa9i6PyDmQm3lQmPSFph/xLs2E4dlE
	2EfNxHASNtQUbBpZFchqpDHFqgKUzLgs40WNmGN+bDzwKDowDA/rAoUh3yTlTnYk8MmUn9975ZuWt
	aHShApNKCEDcKXLTxLfjpy+FgO4CNIk21w2j+t8kZEGqSsUuOPOagcgh+Ijl86bxm4YF4CdzhUOZ5
	aT5qNf9pxkHGoZGvSMgHXV36lPr543AOvF63ifQ6yW4BWIBIkn6x6n3BgNWNffGmJIO+6+kQwj7K2
	W/ZNzaQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWAS-00000007icR-0Hf2;
	Mon, 25 Nov 2024 10:18:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-00000007gFb-2huw
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kRNwMlvi/Q0U2ObjRznPAi0eKAWL0TLaUoagER3O75M=; b=MJt0zpAKeIFg21TTp5dxDMRdv6
	Kb0+PFeeb4YjK78IgvKuU9F1YJRbmRu1xXgK2XMwfY173I0XdsPSMmzdkLUVzYcmK0Y1xzlgX6tV4
	VrMlIs035DDatGI9KKHId4+R0q6mT5o+Io0r62+zJ6CuphUdfslcZhXzJT4q4hjGTe/QCFALhS/zp
	GM3Hoebj4hnN2TxYVne1nCdfA6N3tCCGsX/xTFXvkkz2V35+KbiK6mUKZZ1knsGsnz0tqFS8Gr8e9
	4H8cpiGQyd/nK/j35SXddQ+CvWKvz1KEZb3NSa8t8m3oR0HY7WZHfokXXYIXYYe9D1qvBqeWtbary
	rHJqt7Aw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-0000000Biqz-0J7b;
	Mon, 25 Nov 2024 10:08:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lE-2cyN;
	Mon, 25 Nov 2024 10:08:21 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v3 09/20] x86/kexec: Move relocate_kernel to kernel .data section
Date: Mon, 25 Nov 2024 09:54:39 +0000
Message-ID: <20241125100815.2512-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

Now that the copy is executed instead of the original, the relocate_kernel
page can live in the kernel's .text section. This will allow subsequent
commits to actually add real data to it and clean up the code somewhat as
well as making the control page ROX.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/sections.h      |  1 +
 arch/x86/kernel/callthunks.c         |  6 ++++++
 arch/x86/kernel/machine_kexec_64.c   |  4 +++-
 arch/x86/kernel/relocate_kernel_64.S |  7 +------
 arch/x86/kernel/vmlinux.lds.S        | 15 ++++++++++++++-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 3fa87e5e11ab..30e8ee7006f9 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -5,6 +5,7 @@
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
+extern char __relocate_kernel_start[], __relocate_kernel_end[];
 extern char __brk_base[], __brk_limit[];
 extern char __end_rodata_aligned[];
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 465647456753..51c3e0049152 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -139,9 +139,15 @@ static bool skip_addr(void *dest)
 		return true;
 #endif
 #ifdef CONFIG_KEXEC_CORE
+# ifdef CONFIG_X86_64
+	if (dest >= (void *)__relocate_kernel_start &&
+	    dest < (void *)__relocate_kernel_end)
+		return true;
+# else
 	if (dest >= (void *)relocate_kernel &&
 	    dest < (void*)relocate_kernel + KEXEC_CONTROL_CODE_MAX_SIZE)
 		return true;
+# endif
 #endif
 #ifdef CONFIG_XEN
 	if (dest >= (void *)hypercall_page &&
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 6fcf54e87d44..76a45a76e0fe 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -313,6 +313,8 @@ static void load_segments(void)
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
 	/* Setup the identity mapped 64bit page table */
@@ -320,7 +322,7 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_x((unsigned long)control_page, 1);
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b48bd82843fd..01138f862c59 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -41,10 +41,8 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 #define CP_VA_CONTROL_PAGE	DATA(0x38)
 
-	.text
-	.align PAGE_SIZE
+	.section .text.relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_range)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -341,6 +339,3 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
-
-	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
-SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb4..1ff23a4bbf03 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -28,6 +28,7 @@
 #include <asm/orc_lookup.h>
 #include <asm/cache.h>
 #include <asm/boot.h>
+#include <asm/kexec.h>
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
@@ -95,7 +96,18 @@ const_pcpu_hot = pcpu_hot;
 #define BSS_DECRYPTED
 
 #endif
-
+#if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
+#define KEXEC_RELOCATE_KERNEL					\
+	. = ALIGN(0x100);					\
+	__relocate_kernel_start = .;				\
+	*(.text.relocate_kernel);				\
+	__relocate_kernel_end = .;
+
+ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
+	"relocate_kernel code too large!")
+#else
+#define KEXEC_RELOCATE_KERNEL
+#endif
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
@@ -181,6 +193,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		KEXEC_RELOCATE_KERNEL
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
-- 
2.47.0


