Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D7C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8eKbt9gEj9x3/N+C3q8Wshr1zJkbweN4e5zR2wlGA0=; b=PIsxJuNDHg5xa9YKJIcBCFLDIn
	GJblvjxdVPai0gWiDA2zMZ5ETA4GhhmeY3mu5owuXCjzGB/B7a3UbHSIRLM4T3rjpcR0LMYKw3NkX
	NSHoF7X/bSNUbk6I9M9f34lP3c95uiUYvV4FwLtHv/3t/DZcBp8FIaMoAPV9dpm30B1Lzpn/Xp40O
	f4KkDBBd3MR3f5xT9MREXtTGH+PA9qMP9JPHw4cez2gvKSrRCRASq4tIR0CwMSv0Zi4qB56XHmREs
	T9r7hz3gNzTS5wGAHw6nhuJ+a0moF6CJahUOxPd2ciKEtmg69vzotsfmUl4QXzsm4/QLbxKogcSey
	GUyUq3fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rL-0000000Cs7x-0cMp;
	Wed, 15 Jan 2025 19:15:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qT-0000000Crve-3yVL
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E8eKbt9gEj9x3/N+C3q8Wshr1zJkbweN4e5zR2wlGA0=; b=LpRXIP8c28PZvESqVHpWbpi9zF
	wL5LZl+O7O2Pya3sLX5VwOj6kw/KLnS4cUkPElarW2Q0ROkTsRL8xXd3Phkrb40FvoHHvyBDn+9Qv
	Esd6eYuhkh/AqbjTgGIk1pkEryvOmPOyaTl8vu1h8ICFfAHPImkpvKh6iHUAOuSfxDV6lcJ9lKuD4
	DsSzH3at0vU7fE39swPNb5ClW3eHIyeCCfCEOXPFFaxB3FOfVa0Rviq6Ze1QdiaXcMSqhNEORH39f
	byOHtsqs3tC1o5xDU8v7q7zqoTYfJUGTTjKfO8jU+FXXDkpR4DVL47qTIgOShCaPdzfiFbXOeUD1U
	IY5lHKtQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qQ-00000000X7z-3L0i;
	Wed, 15 Jan 2025 19:14:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qP-00000002UwG-0NeT;
	Wed, 15 Jan 2025 19:14:25 +0000
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
Subject: [PATCH v6 6/7] x86/kexec: Add 8250 MMIO serial port output
Date: Wed, 15 Jan 2025 19:09:35 +0000
Message-ID: <20250115191423.587774-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115191423.587774-1-dwmw2@infradead.org>
References: <20250115191423.587774-1-dwmw2@infradead.org>
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

This supports the same 32-bit MMIO-mapped 8250 as the early_printk code.

It's not clear why the early_printk code supports this form and only this
form; the actual runtime 8250_pci doesn't seem to support it. But having
hacked up QEMU to expose such a device, early_printk does work with it,
and now so does the kexec debug code.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  3 +++
 arch/x86/kernel/machine_kexec_64.c   | 22 ++++++++++++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8cbdb6fd10c2..5081d0b9e290 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -64,6 +64,7 @@ extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
+extern unsigned long kexec_debug_8250_mmio32;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index bf06866ee90a..14f548e095c9 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -296,6 +296,9 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+#ifdef CONFIG_KEXEC_DEBUG
+		kexec_debug_8250_mmio32 = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+#endif
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 535438375568..d47ca1a06a4d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -76,6 +76,24 @@ map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
 #endif
 
+#ifdef CONFIG_KEXEC_DEBUG
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
+#else
+static int map_mmio_serial(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
+#endif
+
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -285,6 +303,10 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
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
index 9781a28c246a..493b378713e5 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,6 +38,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
 
 #ifdef CONFIG_KEXEC_DEBUG
@@ -418,6 +419,22 @@ pr_char_null:
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
@@ -428,6 +445,11 @@ SYM_CODE_END(pr_char_8250)
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
2.47.0


