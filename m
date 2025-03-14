Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB7EC35FF3
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCEBfgh97r1ZRaD9/vr5HcRSBvjPstuhIMv+FvxUqfo=; b=LTHWX4g31wEQqfjBSGmMjZS5F0
	D7TV2TArUvGK2D9vvJaOpQRS3t8liOTnnh19rrgzhPs22ZFrWdEfhI4zN71GwzuBjfRWFAjyql1Eb
	W/wppVNr8odpVWl96NRe4p57NTpx3IwseICXCRo1HjvzH5fGqHydQ10jvgE4UWCsMZ6KPqKeSGoCN
	lAlpO9btvU1EYDE1yQLlqP5/A9nXiQUcC3BDa32Qtbc3jC8gsPGoav0gBTLEr5jqDMdcY3OvkZS8x
	dCenpi2KU7Om/v/bKpo9VxkbANSE5Axe87PqvsWmKv8SgqQ9kTs108fCorZDLCxkyV/YmNwgQUp12
	qDeVpE6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8vw-0000000EtBS-1EEO;
	Fri, 14 Mar 2025 17:34:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8vD-0000000Et0C-3flc
	for kexec@bombadil.infradead.org;
	Fri, 14 Mar 2025 17:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uCEBfgh97r1ZRaD9/vr5HcRSBvjPstuhIMv+FvxUqfo=; b=SCemwOhKOdG1TiIcHIp/uPMkD1
	IfQc5tSzVMyRqG8K5tODkP0HZ/GP5yP3OxbAZCjb9p3MjCc1kMqtLo2nF6EkAPlJP1F1bHeGNkZf7
	eWDeVly2kq5x/hgtcYWH7qeG3AcFQBCTKIcHKl34VMAQcjXDemAE5gZcnfDQ4elUlb9E4ShogY5i8
	l1cbwi2qiovVCHeT6ul2LThuQ1uC0/FjR4VgTyF+iZOp25xMECZK/2X6glcSXVhfApfpIIg4vD24y
	5u/zFhg1saAgL7FWiGhTOZ7/MHc45edRI59rFcv040vRP3diA4199qTYeKKULaCef7TSBn1c+tD8N
	03DgWDWQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8ta-00000003tcq-2ro6;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tY-0000000CsVv-3rUi;
	Fri, 14 Mar 2025 17:32:28 +0000
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
Subject: [PATCH v8 3/7] x86/kexec: Add 8250 serial port output
Date: Fri, 14 Mar 2025 17:27:35 +0000
Message-ID: <20250314173226.3062535-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
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

If a serial port was configured for early_printk, use it for debug output
from the relocate_kernel exception handler too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  6 +++++
 arch/x86/kernel/relocate_kernel_64.S | 39 +++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ec7636f4f86a..8cbdb6fd10c2 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -63,6 +63,7 @@ extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
+extern uint16_t kexec_debug_8250_port;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 44f937015e1e..e98e064089cd 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/screen_info.h>
@@ -141,6 +142,11 @@ static __init void early_serial_hw_init(unsigned divisor)
 	serial_out(early_serial_base, DLL, divisor & 0xff);
 	serial_out(early_serial_base, DLH, (divisor >> 8) & 0xff);
 	serial_out(early_serial_base, LCR, c & ~DLAB);
+
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_X86_64)
+	if (serial_in == io_serial_in)
+		kexec_debug_8250_port = early_serial_base;
+#endif
 }
 
 #define DEFAULT_BAUD 9600
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c2f73998d1b6..1f8c8890798c 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
 SYM_DATA_START_LOCAL(kexec_debug_gdt)
@@ -380,24 +381,50 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 /*
- * Generic 'print character' routine (as yet unimplemented)
+ * Generic 'print character' routine
  *  - %al: Character to be printed (may clobber %rax)
  *  - %rdx: MMIO address or port.
  */
-SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+#define XMTRDY          0x20
+
+#define TXR             0       /*  Transmit register (WRITE) */
+#define LSR             5       /*  Line Status               */
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
+	addw	$LSR, %dx
+	xchg	%al, %ah
+.Lxmtrdy_loop:
+	inb	%dx, %al
+	testb	$XMTRDY, %al
+	jnz	.Lready
+	rep nop
+	jmp .Lxmtrdy_loop
+
+.Lready:
+	subw	$LSR, %dx
+	xchg	%al, %ah
+	outb	%al, %dx
+pr_char_null:
+	ANNOTATE_NOENDBR
+
 	ANNOTATE_UNRET_SAFE
 	ret
-SYM_CODE_END(pr_char)
+SYM_CODE_END(pr_char_8250)
 
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
  */
-.macro	pr_setup
-	/* No output; pr_char just returns */
-	leaq	pr_char(%rip), %rsi
+.macro pr_setup
+	leaq	pr_char_8250(%rip), %rsi
+	movw	kexec_debug_8250_port(%rip), %dx
+	testw	%dx, %dx
+	jnz	1f
+
+	leaq	pr_char_null(%rip), %rsi
+1:
 .endm
 
 /* Print the nybble in %bl, clobber %rax */
-- 
2.48.1


