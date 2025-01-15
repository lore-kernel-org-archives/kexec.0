Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA81C02188
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pca4Fxgeu9wcwmYhifyF3EzUvdR40CutdVjYdl24F4w=; b=tonz4didcXNa95wu0KYnruAhLQ
	QWzOBfw1qWXUQqUOPG+7UUQw+8bDQqdeWg2DykyISPBbmoY0NKMaU453rIoXzE3LCbzdaeQqIfZZs
	DJ7lSMaj8EerDv6YZzlNwNT3xJ8VKZMpRA63CNC9IIuTNsuwgWfc9yI9h+ml/S4YVuvL/cgn3AaGy
	EsDKkL36Mhg3poWcsJTDV95JU5e6tTrv9L5EvPSujakh1e12dXOT4VlW1/XoYPB03ci5J3lVRnmJy
	9sMSStEaFSa926dwKWasWTGx3ZL8HVDjDMTFxpZIPTLjp2k9zeaP0pcKi5rKG4arOXg+IOViHOk3r
	AJbead1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rM-0000000Cs97-1jQ9;
	Wed, 15 Jan 2025 19:15:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qT-0000000Crvc-3yAF
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pca4Fxgeu9wcwmYhifyF3EzUvdR40CutdVjYdl24F4w=; b=b7EvDy3lCmeeR/24rdaI88vQTk
	20hUAIupH5oYaod9Id99C6cGPmaYEQHN9cGo17x3iKUmZAHOZKnTELa6pPslYsBpjuMfuxOd6Tl3f
	NL80JohNxvSktbTS6tK9O1QNsveiI+KIvxcmremEAcEm7mo71OrVkU03r5Ax+R4G4XSXPzk1Uv+pn
	r0Yf+YcFKePS7cw141kREgAuarBYvUbXYyDx4bJILddWOSGZghOiSQc4a3Q26S8EfWTyGi1QbCqNH
	1jWq2DVvsrh+KxYiExgjv5AIxPyk6BmFOzaPdmIl7+9vXqrSdLUkZ4sRPVkkpZntcxFtJecQe4Vff
	zwOCkDMA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qQ-00000000X7y-3IOh;
	Wed, 15 Jan 2025 19:14:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qP-00000002UwM-0cha;
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
Subject: [PATCH v6 7/7] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Wed, 15 Jan 2025 19:09:36 +0000
Message-ID: <20250115191423.587774-8-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 493b378713e5..e4253102b234 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -156,7 +156,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
-- 
2.47.0


