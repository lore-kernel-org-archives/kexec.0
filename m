Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF86C35FF1
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqwZ/H/FVUiSZsArJsLCTQnCYNemua1WIXyd2bx7EII=; b=3JEVZ9mRUIXsSdS/bJhRgSkSIm
	p0kINs6VGmmNl5PxV6k08r9Ysdh6D1ZuHyk5WozvR/O/TdSEE2yURYRJLNwTeHaq5MYfafyBANX67
	qtcFkPPZl358XhoEb4SO7I2bGrXJXUR4ptDjF7PuN9CwKsyq4TaXDoidF7E7xEETspAFSGsULyo4a
	cwEOJIsMnv5MBYm4A0V85k3mgMvvmnleRuLx2fN42lSf3m3mN2CZR6h7qyKFU3XMJl9SqmjeHw173
	cXYb4aHLX6u0r8yFghsfa1cR161y7JjlKgHIbpS3lKYXufFL4An9IWAyBZEPZnypyWeD7OYzpEELF
	xePEspMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8vw-0000000EtBs-2wBW;
	Fri, 14 Mar 2025 17:34:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8vD-0000000Et0B-3fWv
	for kexec@bombadil.infradead.org;
	Fri, 14 Mar 2025 17:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cqwZ/H/FVUiSZsArJsLCTQnCYNemua1WIXyd2bx7EII=; b=diV4G5/IEhJa8Q+vOrcbuKfaWR
	IHIuwgnvh8u5e1wr06gVYGwT3/CARtlqM2HGhbWNscS9xs2uFnzpjjRzKAuVxAgTWzlXWIklsDQWP
	lmcLnZGJnqRimalPkLl2g/bzS1hWe5WMvsSXfdTP16JX1g6OlJPPtvcBLtZsxwtsBaNDKyDxNTILL
	P3yUge1q1Jw+i1p+gr+4/oWNUz++hOPqhEnRUYciGwKsmoO3f/JkJMbM7e5OqIuEwLORT+xe6NrEx
	vY2wKo9KVH5SR5SPBK2kxwyQAqHgWRKYCTasm+RJzXLhTOJI1siUs7CnDEmfXkVSti3kMz9Jk+yp5
	cNjzFTig==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8ta-00000003tcr-2nQ2;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsWE-0VrL;
	Fri, 14 Mar 2025 17:32:29 +0000
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
Subject: [PATCH v8 6/7] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Fri, 14 Mar 2025 17:27:38 +0000
Message-ID: <20250314173226.3062535-7-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4f8b7d318025..228301ac66e9 100644
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


