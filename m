Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A0FE7717E
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bu60bcDvZzloSAXCkbCegV/lwySuet3eE7e1Gl1k8gk=; b=J6i8rfVGjYwN7TMBwGP3OlurUp
	XBWl0W1hOJ3FEbpJu4LdZul4WZaTixPmAdqIOlMY3xOTK0Gie7xcffVyDnT79lrO+8qdh90aXfWGk
	n71hAyGcHOk+5oyXempI19c4aXcxmadso7nY+zJBnml3ggYz9XxJxVHWFLmFKUnckbZO4mVgAFcAU
	/1/BPbcWKoSQiuy/MLvuJmNWfFwGIs9VGCB+qtQ0X+9fIUZ2RuxDOMol5gqFoA2eGYUOuG+a9VhgK
	a08uWdLegszFnWqtoLXnFYvwFVDSMAPwnGwaMEQEx4RyPTZ0GYqoRNYrklvtQsCUoeacm8b6z5UMG
	n9I9mK6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsz-0000000GZ4c-212S;
	Thu, 05 Dec 2024 15:35:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrR-0000000GYRx-07Zo
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Bu60bcDvZzloSAXCkbCegV/lwySuet3eE7e1Gl1k8gk=; b=CkB6djfxb2i/nBcty/k29j9iYo
	05TH4F/vPDZ2oa8ty5fjQ6lL/1bwy/z4U9M+893zGXsW6fWWxwxxgD/uCJVBU/bgClKacjyispcQM
	J+KpPp2tUAssYeS3imPo3Y7A24JTLL3FVVnWtIkPvjsP74yek6XeJRSRu8TbJlFAMphNGLv50YVdZ
	8vxSAfD3SQPzmltzv4dkvPfJ7l0A/n5f3HjwtS0fpRBg0NhhG7+Jf5ocFInSXheOQi7BoDmeRXECN
	2ae/QhrNtX6sHObuZfwznprkF54TOM1jLnvj27s45yZjiRAWxYwcrRVsmFLlgPTVb1YQnFrKErnVS
	UOTi7mHw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wEy-0jg5;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyM3-319d;
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
Subject: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Date: Thu,  5 Dec 2024 15:05:19 +0000
Message-ID: <20241205153343.3275139-14-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c9fd60f8f806..9232ad1562c8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page);
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }
-- 
2.47.0


