Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49CC02185
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zf2GiuF4uGIVUxzkVkUG6Og3XO9L1Q3ObwgFc7LbRWg=; b=088gUsEZ8RqXYiRijG7WAVPowo
	HyPJmdN2hGq5lMrA5NUB3Qt8Q9Ji6k8c+ZJ68pZR9HQah7BKupz9G/yXtIBvgYhzdIPutNpfTwJLP
	1nNbpvmnJfKfT5D+gdih4+pj8FlMVpybarIS+d8dGZeDIjJysTUrb6TyAoHh3PD1yub0xROHYkyus
	T+5gN3JKUSlPK/gvLbaEVz2bnMYAFG9zly3cEnZ/E+rM2V9a+I80nb8MHLrosAs1mf2+MytXP4Ypo
	5s7zuuLab2gUqCZXR3ziCMF/L3exsSmEIEMhYu0tmMGpnl3JKX/dfNaUjLznXKfltE/VIzzqgqT1T
	lo2tgflQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rN-0000000Cs9f-0VS7;
	Wed, 15 Jan 2025 19:15:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qT-0000000Crvd-3y8C
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zf2GiuF4uGIVUxzkVkUG6Og3XO9L1Q3ObwgFc7LbRWg=; b=Ohvp7AhOn/kgth3HVKcG15a/dZ
	cqzMDWli/JuSB28oYTi7TAsW3FrXa6yS/U39APw5GlB/nrs/OYi7N+tjsI2crhcYH49jTRf+DLy1o
	4fhAosBHkgSXBy1XQSOK6UUvwsCvnv72q2MJHeXM9EMdIatABO3xQFU4fPUY9OnHybF2zZSJkMb0V
	q7K7u4skgXzHI9bxsHfmLdd9p/EYpaqMQhLyk8z5tk1TWT+JELpC28dRAlgEiCO3PpSSWqUouzl0K
	WoZaiOnxeYr/yhbb3HhWTXb2veD2vKC6TEqVMQMiALbMMQW6eJUUs/POiDVSeH/2bLiRvH2lSfea1
	EL5Bc8sw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qQ-00000000X7x-3IZr;
	Wed, 15 Jan 2025 19:14:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qO-00000002Uvr-3g2F;
	Wed, 15 Jan 2025 19:14:24 +0000
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
Subject: [PATCH v6 1/7] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Wed, 15 Jan 2025 19:09:30 +0000
Message-ID: <20250115191423.587774-2-dwmw2@infradead.org>
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

This does nothing yet. Support for x86_64 will follow in subsequent
commits, and an Arm64 version is also being worked on.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/Kconfig.debug |  1 +
 kernel/Kconfig.kexec   | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 74777a97e394..c54cbd36c710 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -13,6 +13,7 @@ config X86_VERBOSE_BOOTUP
 
 config EARLY_PRINTK
 	bool "Early printk" if EXPERT
+	select HAVE_KEXEC_DEBUG if X86_64
 	default y
 	help
 	  Write kernel log output directly into the VGA buffer or to a serial
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f871951..a65b49c083c9 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -17,6 +17,9 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config HAVE_KEXEC_DEBUG
+	bool
+
 config KEXEC
 	bool "Enable kexec system call"
 	depends on ARCH_SUPPORTS_KEXEC
@@ -95,6 +98,14 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_DEBUG
+	bool "Debug kexec transition"
+	depends on HAVE_KEXEC_DEBUG
+	help
+	  Faults during kexec can be difficult to debug. This installs exception
+	  handlers and attempts to report faults. On x86_64 this would use the
+	  serial port configured for earlyprintk.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
-- 
2.47.0


