Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B430C28B2F
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qp5MUfxf+oIzYOLbQwnOjHsqB6Ar6RASj1HyEhE99qw=; b=UfboCHoAZUWzkw+tgjYiJ0d4dD
	HSQ9UlGerLOfrgLz9fEmPMKNCeBdn9uu6NGn8t7IkU2URS3W7lKhY8aFkGGvuPYyrUXmO3f6kRzO4
	MmjlClVUsqcxDKzoZNMRWKgAwMz+E4lSEcjC5vS1qVVlU7EHyC/qMHaDXHpQcgR4YH/c2ST0rhRuL
	4sgfZIWKilQrFaAaTl/sPGee4ja9/nAJh/vPOIDw7fhNOpYfkW44BqJktiq1PYYPRi3gpiiwLEDDQ
	xDXV9HEAOlEwRrYl4kbuP5UMG+xH6MMzoz4QGgQXMrbrQlJf87PM/6hI7ALDmWWNvo3ihITZag87A
	lrF9BIXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOM4-00000008viP-22Lx;
	Wed, 12 Mar 2025 15:50:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIU-00000008jRN-14g3
	for kexec@bombadil.infradead.org;
	Wed, 12 Mar 2025 14:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qp5MUfxf+oIzYOLbQwnOjHsqB6Ar6RASj1HyEhE99qw=; b=k49P0ETXliA0XX6kn82w6hNg23
	S9B/Jk3XcTx62r3X+AgrBf798mgnDOSJ4pY9B+bsXVdJSED7+AN6rFQL7LgSmq5t/ZNCZjy5Af/mk
	cngj6qFga/dUmCtw9+nHGNzmGjHrturGnr0hhpbVtrAP+kMliBAB6FSawqXVuzcRlbxFlEYsBfBPd
	ZFAOI6A6ykC6dJXjJLYk75V8czDygBUVeD2MipZVK0ewrhkdv3Zp33cCipKQSCKf1K8LAOoBQDDOQ
	+7cnGulWpjkgmel/JPYE4eQMfuH7bM84v+HnIUYbCUIJZnDov+vRM8MYyMrVvWgaL8uvzMmZYyJmE
	xp43lrpQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-0000000CxJG-3ivn;
	Wed, 12 Mar 2025 14:42:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUg-2mAN;
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
Subject: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Wed, 12 Mar 2025 14:34:19 +0000
Message-ID: <20250312144257.2348250-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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
index 17d41e6e1a4b..2b7fc59af373 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -158,7 +158,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
-- 
2.48.1


