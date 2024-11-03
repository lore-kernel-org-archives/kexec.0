Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB5D10C0F
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tvHqpgzAkwy0Y3r+Wo2YrNgkiFf7wobJpekGDQ3pEJs=; b=zAU+LOg2WhHEj0
	+FaQmB+0sy0siuzwz5/OctRHnHIfgJoHuDUURjqbzhQH8zVuc8zU5FdcgkKKuY60HMugavHD42rU7
	T+2m+Zjy6MGPIflou5PVFT2jJIYQLFwd6gcaTr70XAmZ4DSYjz9Ks9S6Ysvdv+Y8DITrSa4SSEG/n
	I1yrANkpV7OtzbNbbGoOLzDiwInbFwUzuzBQ+zCZBl19j4LyOUqTJYAGzqK8odurtmYZl5ZiauGtT
	Av7vnxYA5MK34mxIcXHp+g0CdkMvT4uB74FFEHbAwhYzknwCWwoW+5rU12sBTA0TJnIQsjeosaIua
	eQYCAgnUL50zk8nO6Vrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLj-0000000AzWL-1Kcx;
	Sun, 03 Nov 2024 05:40:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLe-0000000AzVi-2l5W
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jRI3DZMe9TgAyx+MV1am49R5haSFhnpyNVcm2C5PrAA=; b=FiIENKfbArtWxRSphJlRQI/Su/
	wG0CYZp3+Xq0Cgr125LEeVC4uV7kLzDm68Ny8EuwpeabS40vxeEeM1B1VXiptzWFYe3AkgFrTN+eN
	U2/qnPMaqRezocIJMZQTAicperZx62gW0fwCNGp/0cupnXni5dmLyV2htrJJzfPk6yEuxvSRwkNqT
	JSOcE78pO/xDEb0nLG5+VGP+xpneFSyaCCItwgfl9mfh8+RlyWKQtmr9f4OBtWndCw+2hacY22SMO
	Ea6zU3OC4N+vXdLEwlHQ0Zw5UERJdgJrIueNVm8NKzJ0k/feSUK+WeCCqW0FIiJwwwyK4/WWJf2eW
	HaONILMw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiP-2uPj;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLb-0000000FvLX-07z2;
	Sun, 03 Nov 2024 05:40:23 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 7/7] [DO NOT MERGE] x86/kexec: enable DEBUG
Date: Sun,  3 Nov 2024 05:35:32 +0000
Message-ID: <20241103054019.3795299-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1c18cffe5229..bba37db6d437 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -14,6 +14,8 @@
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 
+#define DEBUG
+
 /*
  * Must be relocatable PIC code callable as a C function, in particular
  * there must be a plain RET and not jump to return thunk.
@@ -195,6 +197,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	pushw	$0xff
 	lidt	(%rsp)
 	addq	$10, %rsp
+
+	int3
 #endif /* DEBUG */
 
 	/*
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
