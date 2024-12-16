Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B36E77184
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzCHIqIiQJDgySmzgmnKF8ZlcgBrOOsvhFm4kYphShs=; b=g3gvYzXmKgomo+IKzvGimSyoU/
	yx/V7XF1mcIVQ1HuGSxQdaZej+3WzPxeArehQ+4TDGKoG9HuLrlgieJKklazfuLJTZBkF+yFGGIfP
	IO8NUWz9Q+FFwljLQiGv9DWQzOuQs7XyxDdXCF+OfgFzIPwfCPlJGio3MdRGDPKZC086qGtjj0T8K
	p2HFXkRTTUZOnguacI3tMC13Re/5WbN2DEF+HsK1lHGuqgPa0fU2AwQvDsDztOZwgHBkp27z+io/O
	XfB9o1PKamZHcgKWE1+aUpB0hGecHS4bjPzjhz6AHuc98ZmUMVejVzaSbmr0Bqb/w26FiifBxALeA
	2RnBWCtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeK-0000000BetA-3Bur;
	Mon, 16 Dec 2024 23:37:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeI-0000000Bere-0boV
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zzCHIqIiQJDgySmzgmnKF8ZlcgBrOOsvhFm4kYphShs=; b=gY/TwmhMVrUX4ruTov+kQpAeXq
	vUof0P+v8tmNgZzieQgAPFNfKsdCHZ/fwo462vl2AG6mOxorwVgsneYQhjXjghSswbLIN6yyq2tG4
	MLM5EBtf9WXI43ph0N7ap72TpygIWsaBhtBU+fFNKjt/VY3Rpmjp1TLnWE0uLjvSh15dTjVNS0Zqq
	xsxKda+QdQW9Z/ITvj5zEnY921zH0MMyZEtqdA6/StFGUzAoRPMx0NaN6IQY4fANl3FpmUJQlxLGP
	TX9n2KDYVOHgvF5DsVSzF60WeTB/u/TkkLqwmClvBnb+T2Wv3wqAtEWxJKwwFM/tQCqlMGEFmxN56
	4l17Grwg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nX-25us;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW9-0Qg3;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 3/9] x86/kexec: Use correct swap page in swap_pages function
Date: Mon, 16 Dec 2024 23:24:10 +0000
Message-ID: <20241216233704.3208607-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
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

The swap_pages function expects the swap page to be in %r10, but there
was no documentation to that effect. Once upon a time the setup code
used to load its value from a kernel virtual address and save it to an
address which is accessible in the identity-mapped page tables, and
*happened* to use %r10 to do so, with no comment that it was left there
on *purpose* instead of just being a scratch register. Once that was no
longer necessary, %r10 just holds whatever the kernel happened to leave
in it.

Now that the original value passed by the kernel is accessible via
%rip-relative addressing, load directly from there instead of using %r10
for it. But document the other parameters that the swap_pages function
*does* expect in registers.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1a52e4339c1d..0d6fce1e0a32 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -264,6 +264,10 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi indirection page
+	 * %r11 preserve_context
+	 */
 	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -302,7 +306,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	jz	.Lnoswap
 
 	/* copy source page to swap page */
-	movq	%r10, %rdi
+	movq	kexec_pa_swap_page(%rip), %rdi
 	movl	$512, %ecx
 	rep ; movsq
 
@@ -314,7 +318,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
-	movq	%r10, %rsi
+	movq	kexec_pa_swap_page(%rip), %rsi
 .Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
-- 
2.47.0


