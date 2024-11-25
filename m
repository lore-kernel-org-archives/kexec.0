Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25231D3B7F5
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDB0B/y8BEIJAdSME/L53tegScvP1ehfXftaZ5ENwBE=; b=BgtoPqiP6BPa8Y7wDoNh1dvtNA
	k+bgzd/YcFsQPWnu3iXA4yKof/sSY4yvmy1Lg/hzxjZfGD+VjyrR+HSr6GKugB4v53BJeEYHU5ZL5
	AM/0sccerVJPMHBL28m+vShfkfD1wVk1DaOXBkDN8vLgLVzmMjOtrmGjQMEnrDN5t17b6ofJfD4NH
	FuUuxwHf3GWBncClrGn48WGwom9kqIXaHf8V9jTSEUToAZLW2M1fAAo2+U6epK1kZa8Yqm6YV6+k6
	hTt4I2p25K7XYnriRWYsLkB46VAI9gNbhNoBsj7km6nx0IqUU8kQBPVMI1aQqRGZVSMnAXrU8PJQh
	9cuhD2Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWB7-00000007jae-3PTH;
	Mon, 25 Nov 2024 10:18:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW13-00000007gGT-3YvF
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uDB0B/y8BEIJAdSME/L53tegScvP1ehfXftaZ5ENwBE=; b=EuNMYDjxVFZm3cJGRi/JveSTZc
	cx4LwuYqlNEM54DjLQZeqUrXoGCf88hyZnXU9TT1/tZgzlNdBd49i5KKYMCev/01LZn5GaFMfyA9D
	bGUlgFGZHc0aP1aDWulQ1XXz4fcbfuJvEwu8MOi5CJ7IP8E7ydZaPZLYjsHraCx8/Ao/klti6k2jG
	kB5fUDUIWeMs+hzdT3YQMIiLe5TgcOBIuBZ7RuRrNsth0FQJJxs5D2bCacD9L/fEt6qR0meC91gUE
	1LMixpgU/fDF6ggrwR0KQ6lNK7i3BvTMKT/8aQNyX2ttfOh0mD0N0atEzQMHQ1h9UxzPQONxzVuMY
	efxFGhbA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-000000014fA-16IG;
	Mon, 25 Nov 2024 10:08:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW10-000000000lq-08Pe;
	Mon, 25 Nov 2024 10:08:22 +0000
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
Subject: [RFC PATCH v3 19/20] x86/kexec: Add 8250 serial port output
Date: Mon, 25 Nov 2024 09:54:49 +0000
Message-ID: <20241125100815.2512-20-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

If a serial port was configured for early_printk, use it for debug output
from the relocate_kernel exception handler too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  6 +++++
 arch/x86/kernel/relocate_kernel_64.S | 37 +++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c14b0a2704c0..f37d2d9fda3f 100644
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
index 44f937015e1e..bf06866ee90a 100644
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
+#ifdef CONFIG_KEXEC_DEBUG
+	if (serial_in == io_serial_in)
+		kexec_debug_8250_port = early_serial_base;
+#endif
 }
 
 #define DEFAULT_BAUD 9600
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index cd349b6d34a7..01a31e4a0664 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,6 +38,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_port, .word 0)
 
 #ifdef CONFIG_KEXEC_DEBUG
 	.balign 16
@@ -364,23 +365,47 @@ SYM_CODE_END(swap_pages)
 
 #ifdef CONFIG_KEXEC_DEBUG
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
2.47.0


