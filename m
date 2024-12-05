Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF71E7716C
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0nLJBUlnC0lJdbTn9E+DJez294BNmSeUZNgs1SMEfHk=; b=T4047wQOCjIFeAhFCJE6azw6xM
	+6i11FJPVzopQfnr2cVt+cikEfZmGj+dbg1RtUV4VQJt1lRXUmC1T0FVRCk+koAem3paO1s3/D1TX
	uT1IjTFnfYZc/AY9ZzJBdJ/3KBD/mbvUPYnke5Uhiu7gGWsCQfKr9IKv26pzxqw5iTbzlffJUeYgu
	z6yfv2h61z6E+p3+lC62gSeQMdzv3BEH+e3QOaTBQm5OPQfibueIVXJmXHee45b3DZNhAH2dydlan
	a8HuVBg2ZmkvvEwDXl5Za465HqNodo33fOvrrQ6uXJlzuRJQTL3XxJlx3MDsZCjmrn7Dg2hcpIy08
	e07P6dZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsu-0000000GYy1-3W98;
	Thu, 05 Dec 2024 15:35:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrQ-0000000GYRm-2aZx
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0nLJBUlnC0lJdbTn9E+DJez294BNmSeUZNgs1SMEfHk=; b=lweXdCswCNPW2EfnfW6TaV1ko0
	cTHHM8cRL4S4SDShxpwDTUd2ZRWm2VZRr8jJF8OcndyMxCxjLP3bzSjj6JJSnYF3S1JbGX+4/9sqg
	s3i22oE03WbqTko+X1uLRLmvZFHmoDoAbXVdo+yytEeSgcBSVGnUwGSH3LbRIit1V0Mrvd57dK+KR
	WXc0/YqYHciV5MsOCGBpXnX36zqpefrf+FVCLBbOWJFVS6+6OFWdztWsx4E2UzS5SMRKT8AspwfmB
	sF1jrbEJf1MUTi/nDKGN/m8dkdKYLzyELfZO3EtgPpNToE7HgkIqCOIJJMdag35fVThsIbRmwZkmA
	yyDoCFdw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDp0-1cQ3;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLX-1p5X;
	Thu, 05 Dec 2024 15:33:45 +0000
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
Subject: [PATCH v5 06/20] x86/kexec: Copy control page into place in machine_kexec_prepare()
Date: Thu,  5 Dec 2024 15:05:12 +0000
Message-ID: <20241205153343.3275139-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

There's no need for this to wait until the actual machine_kexec() invocation;
future changes will need to make the control page read-only and executable,
so all writes should be completed before machine_kexec_prepare() returns.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7223c38a8708..3a4cbac1a0c6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -301,17 +301,16 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long control_page;
+	void *control_page = page_address(image->control_code_page);
 	int result;
 
-	/* Calculate the offsets */
-	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, control_page);
+	result = init_pgtable(image, __pa(control_page));
 	if (result)
 		return result;
 
+	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+
 	return 0;
 }
 
@@ -363,7 +362,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page);
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-- 
2.47.0


