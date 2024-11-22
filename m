Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68823E6ADD0
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLmOWyrmuAgxGhbmd1Cx2AL9gzQ7rBcfLnxnrcUkLFI=; b=qY8PQ88Vc6w/wZfpgQChbEI4gV
	oV1S5qku4RLsqTm0nJpkvQohHckYIMLcllXo8WFoUridSKhPio2Q5MZwMw2z0d+wJcQFF43/UJRjh
	W1Jadhg3X9vE4Mo1la9X9P1tx1v1iSd19hOZNaBkpCZx2/9YYn1XbS8jPb1z5VtwPEVNpLeY5zmum
	rBaGnECJxrXXFqxLdsHzi9b7cdCLFHWIO9WdiIT2AnTuCUR4llm9b9ChOzV7/S5wyR7kF+DsEJZ6s
	r0OxyKquTFCBLCcyZlpGWo4sMWsIOKuo3AiL64EFubLiLB//Itv7XteFSQFfFY0j6uDZXidHuPj5E
	8sWzy4fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQy-00000003RMr-0fBP;
	Fri, 22 Nov 2024 22:47:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000003RKz-3s0v
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sLmOWyrmuAgxGhbmd1Cx2AL9gzQ7rBcfLnxnrcUkLFI=; b=CZEHxI3qag6H7vBnQzDyG84huZ
	6QJ6owj1EX3+VI1h+UzfeQysyMxoa9CHS3YZfLFiQ+2fhmwV/ginQhEBpqB1b0AxDedvvD/kYpV2H
	jaFB0bXlJdSP0NFTO7UKSMgVIQetKhNWHawYDEZHKdOV7sNbKMZF5F/SKMKWlEd6zhkIEgQKxEILZ
	R6oUOzyCoN64mkI2D+nK9V/3FxC6ISvMvIduIBex7Y0bNMLVSU7r5rQAxfNNnEVzhnA8H2afkCtRM
	z53rRZIn6ppFhBO3Q4EMsyHwCLZsEn++faPY2fv5hxkk6pDRbZGOjel6/1MYbQpitZH1Odh3xf0Ey
	hu3/jr8w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI6-1TwR;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iia-1Wwr;
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
Subject: [RFC PATCH v2 12/16] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Date: Fri, 22 Nov 2024 22:38:21 +0000
Message-ID: <20241122224715.171751-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c653c2c22d63..2a294daeeb1a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -319,7 +319,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -329,6 +329,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }
-- 
2.47.0


