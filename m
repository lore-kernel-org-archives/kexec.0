Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFBC35FF2
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oInsi2D7axo2egqLTm6zsJ7BfqLAvSOVJG6AQYZo6i4=; b=ysb0nfm+inwKVmLGJbpRJvWA9+
	iHwHi1rpFZFUTJEdwUACDrgltyDaIIwrbEWc33GPeLkmbGjqV7O8xsRqRRam14NmcFubOmNSs4SZ9
	OdafkqLpaEVPzwLe4vF9CbHmYLYi7n33BDKqNHcvxhHg61uRXkiO+zL71+uZLAW5ulZwN9Myi4BPk
	awW/zxdZK7TWQ3IUP7yXpd3UxDIIUC3flTXY039DcxIJHIefrlXAGplJE26KpiGoPGG8BmtTgQYd9
	Yyew6QIz1I75U3wg90X/aEcJIvHLD6f9Yw+8f+VfNKHRF552TJuvayHmIS+AJGowS8ZYOMSC/+pZK
	NEL6NCwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOM5-00000008vj8-37ZV;
	Wed, 12 Mar 2025 15:50:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIV-00000008jRp-1LMb
	for kexec@bombadil.infradead.org;
	Wed, 12 Mar 2025 14:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oInsi2D7axo2egqLTm6zsJ7BfqLAvSOVJG6AQYZo6i4=; b=K6NXXWypJEHl+g3kj4kkSGqGfu
	up08gClhXsMJsUWf5e5D2727V1MfG1Tr+1UtL6FsLLem+iaWKM26oRNeTGwR2LLoHVsYi1sxIsRF3
	3molZPfDWGwrRfXIUvYO/Wvz6q4qBSten06E2YlZJD1dhmQrzoJYt0EsWCESGiVFN3/zILYKtwKtN
	qgLa8hWEO437Ljep2PIxBIN04pXPaGzweCVkFpR5KtlW4QleFhTzAQ/+MH33XIjiIJubAxVdUQyjk
	YFbUgTGdCFZ1PYPin3HOLhlICQcvnk2WezL79kLIQr2FYteEmyZTkncyVN8dtSujygRibdr7IYJlA
	rRtF6k0Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEt-2cM2;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUn-31Yp;
	Wed, 12 Mar 2025 14:42:59 +0000
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
Subject: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
Date: Wed, 12 Mar 2025 14:34:20 +0000
Message-ID: <20250312144257.2348250-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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

A previous commit added __nocfi to machine_kexec() because it makes an
indirect call to relocate_kernel() which lacked CFI type information,
and caused the system to crash.

Use SYM_TYPED_FUNC_START() to ensure that the type information is
present, and remove the __nocfi tag.

I still can't make objtool happy with this in both GCC and Clang builds
at the same time, so not yet for merging; only included in this series
to nerd-snipe the objtool maintainers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 2 +-
 arch/x86/kernel/relocate_kernel_64.S | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7abc7aa0261b..84f59f18dcb6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -380,7 +380,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void __nocfi machine_kexec(struct kimage *image)
+void machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 2b7fc59af373..999aca909803 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/page_types.h>
@@ -59,8 +60,9 @@ SYM_DATA_END(kexec_debug_idt)
 
 	.section .text..relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_TYPED_FUNC_START(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
+	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
-- 
2.48.1


