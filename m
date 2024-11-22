Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C2FE6ADCB
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JN/n6oVdrchdFC0rEj9EsgKyog6/YyewaWd3kp8GrwA=; b=w1mt5hiJNq+XjATiwFiSTjn0gD
	Y2hs9d9gKLimctOP1W942iGiprJmzjj9AeQput7XUYHVA8i25EQmlwUucWweBuOfnPTN9JJlkil4K
	KOeHATHT4Wo5MZR/zmo/IQWftSccGhSm7Rhs/HZNbgTRB7s9nRhsz346GIXPj3B/fWv9HyJHEfiTc
	9dP6QZf3Txq9AHb2aNOwpBma9BIc5SvkbjHFAUy+7SvVROy9VHZ9/cXAceg7pT4o9o4pSE6Oq1XTk
	KXY9+Dsyq3/LBvQU1/rxFcfQ/KtID02Kf5GFDqOmBvLeBtL5iPZOuO+Hq1S6PyzUK08jn89tYqJ4z
	C1xatsOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcRF-00000003Rf8-2aH9;
	Fri, 22 Nov 2024 22:47:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcRE-00000003Rcw-0Y0O
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JN/n6oVdrchdFC0rEj9EsgKyog6/YyewaWd3kp8GrwA=; b=eqPlq+8Pcnn9Wm6QN/urM3oJlU
	/8Z/I/qLC3p8juCl8bKwHxS0W35gQExd/FT0b4Zapz6vZSPgBm0RbBshNbgiHmqgRw5Tc9Rq32qHi
	r1e5SwhtUrCnrtShNKCXaV8WKRjP35ewfXGpTEmSjRgvxpFERgCqphf3MyBMAGDH5LFG15A+iMw2B
	jozuJMz8kyg5YqdfoKYSobRNEEXhSS8e1kqL6SVjR62MXrXuVZciFl9Y2X4u4YoAd7ojZJliOqOOZ
	t0KqIuTOdhSm4s3zSJK1Phemaew0ngdCyw6Z4VvT/giAySZYoZJNYbtBSemSQ8tbQnpTRGFlK1fq0
	M91XDnYw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000000maN-3CPb;
	Fri, 22 Nov 2024 22:47:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iim-2L1u;
	Fri, 22 Nov 2024 22:47:19 +0000
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
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Date: Fri, 22 Nov 2024 22:38:25 +0000
Message-ID: <20241122224715.171751-17-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 67f6853c7abe..ebbd76c9a3e9 100644
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
@@ -191,6 +193,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	pushw	$0xff
 	lidt	(%rsp)
 	addq	$10, %rsp
+
+	int3
 #endif /* DEBUG */
 
 	/*
-- 
2.47.0


