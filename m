Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD5C36008
	for <kexec@archiver.kernel.org>; Wed, 26 Mar 2025 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lz6XPpBXH8iej3/WgrxlG2rnOiOCqAJ7gVwocclShEE=; b=jHUGwAqCJ0tbaoFYVInX71Niw2
	xwYYBlL+fuuf5j5dXtXn67aBzY3wDup7Qg7jcHHpwFLJnCYKd4QQ9WwzOaMctlduRqdriNMwfTnc0
	SnU5olf+YPEEL0wDRt24qS5cAbo/ypzo7W3aHSHv/owvOv0b/Q6dpShqBgcGW17gkRorq2CxNSJPA
	SBXwqgSRAy0qI2e4UHk6b1boDUC37F6pryKc3OhyzLMJFbMf6iHMST6BF+zxkeS+pnNqwPB39Btgr
	DYYzgXlzKFj4MuPhUeTzKLnqZMCZA+BdGguIB7F9L6O3DP9mWosnhvgQ0i6VnyGQCLdRc+tfojxJY
	fXNwQxMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRhK-00000008gOM-1GOv;
	Wed, 26 Mar 2025 14:25:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfv-00000008gAx-1m42
	for kexec@bombadil.infradead.org;
	Wed, 26 Mar 2025 14:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lz6XPpBXH8iej3/WgrxlG2rnOiOCqAJ7gVwocclShEE=; b=DNxV/AiYpS+qI/WH+c1gJ7XHfF
	HRfbGvoKQiuATaWquOCTsoOObW+3xPMpF8USM1Bk7NaGrfGdGGZPDvWZ/taOUEFq+uF4c7tJhCc40
	eel7MsJSrzXkOO0C0DpSp/3OUoiWxj+lvMAwePJl7Cl8PB6Pa5yZF0xDOGXNvbg2MR3CyjC8ki7/i
	l+6AbMj0yDWOnknwzVKJpcf2Tcb/2B9/ej7Xmt6GwDCGUbeZlv6p0WpSFNJO1al7mE/cICaha/UST
	iGcJYzbyMkO/MLBdHLV9MdnoZrpv+PxijHKZTko53WpF31GY7hSF9q1VTaQlUTpuXfijmXsF81WqH
	7lLiQXwA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfr-00000005oeu-0VmV;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9L-29jp;
	Wed, 26 Mar 2025 14:24:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v9 2/4] x86/kexec: Add 8250 MMIO serial port output
Date: Wed, 26 Mar 2025 14:16:02 +0000
Message-ID: <20250326142404.256980-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326142404.256980-1-dwmw2@infradead.org>
References: <20250326142404.256980-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

This supports the same 32-bit MMIO-mapped 8250 as the early_printk code.

It's not clear why the early_printk code supports this form and only this
form; the actual runtime 8250_pci doesn't seem to support it. But having
hacked up QEMU to expose such a device, early_printk does work with it,
and now so does the kexec debug code.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  3 +++
 arch/x86/kernel/machine_kexec_64.c   | 17 +++++++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9601094ac0ba..f2ad77929d6e 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -65,6 +65,7 @@ extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
+extern unsigned long kexec_debug_8250_mmio32;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index b756ebcbd827..3ad085de1353 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -295,6 +295,9 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_X86_64)
+		kexec_debug_8250_mmio32 = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+#endif
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc73f9708464..ecb0da54abd1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -76,6 +76,19 @@ map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
 #endif
 
+static int map_mmio_serial(struct x86_mapping_info *info, pgd_t *level4p)
+{
+	unsigned long mstart, mend;
+
+	if (!kexec_debug_8250_mmio32)
+		return 0;
+
+	mstart = kexec_debug_8250_mmio32 & PAGE_MASK;
+	mend = (kexec_debug_8250_mmio32 + PAGE_SIZE + 23) & PAGE_MASK;
+	pr_info("Map PCI serial at %lx - %lx\n", mstart, mend);
+	return kernel_ident_mapping_init(info, level4p, mstart, mend);
+}
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -285,6 +298,10 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 	if (result)
 		return result;
 
+	result = map_mmio_serial(&info, image->arch.pgd);
+	if (result)
+		return result;
+
 	/*
 	 * This must be last because the intermediate page table pages it
 	 * allocates will not be control pages and may overlap the image.
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 21011cd19c48..8808cfca6322 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
@@ -413,6 +414,22 @@ pr_char_null:
 	ret
 SYM_CODE_END(pr_char_8250)
 
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+.Lxmtrdy_loop_mmio:
+	movb	(LSR*4)(%rdx), %ah
+	testb	$XMTRDY, %ah
+	jnz	.Lready_mmio
+	rep nop
+	jmp .Lxmtrdy_loop_mmio
+
+.Lready_mmio:
+	movb	%al, (%rdx)
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char_8250_mmio32)
+
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
@@ -423,6 +440,11 @@ SYM_CODE_END(pr_char_8250)
 	testw	%dx, %dx
 	jnz	1f
 
+	leaq	pr_char_8250_mmio32(%rip), %rsi
+	movq	kexec_debug_8250_mmio32(%rip), %rdx
+	testq	%rdx, %rdx
+	jnz	1f
+
 	leaq	pr_char_null(%rip), %rsi
 1:
 .endm
-- 
2.48.1


