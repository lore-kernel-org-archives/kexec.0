Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EEBE67806
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aUkJi39GwyVNF9StiVnMJaWqDvPGCIzWSM9GsxVyM2o=; b=p0yz14twhBS3zY
	FuxsWdlczTF+j05cmFBnHxWZt5nwMODk5BBANVhRsHrVHMLTDqJ6dhKWEGoUOloGovyH59UlKVCUS
	qTZQ3b7pDJ+tQyHMpqO7CpTRf/JDpkJvAlaIClsj89DKjfqBjH+LvxmePCTIdOzD9bwn30Gxy4TqR
	/o4kl08mCscs7gwIQyGi9MfxYJrhwQn6TAdP+6koZ4tmpp/adw5KfsHttFSBfJuMb2T+j7s+aEttZ
	b443MLcRci22nK7nw9uZZMo0zG5HQ82N6Dhs+GNlQZ5rG+/Gjs/5iKm6RiSNaT4jEGbq4KmBwOymw
	RS9zWqdgBwomV2sEYgwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLt-0000000Azc8-3efk;
	Sun, 03 Nov 2024 05:40:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLs-0000000Azb8-3W0Z
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZdZ+nlAayZckzp2Spz6rpIxa9MO+4/e+5j0I1vjYVzw=; b=C7uD+miHpdzhuY8kUB3Jx01O1r
	yAObd9yToflETXCD8JZVihND7D94qZx3ypGkLw4xgVPaICWvF5pfN3Wlf7ASg+NPiQDmO6N0QDplJ
	+WYz2QC1k+JQLhsKeCx1L78DSaHCbcBfvE9LjFDESocunEi68Lm3u6dPit8ZRsm6q+8K3tvefWxQC
	RzCTbUSDTB9TErCocvuHGJ3Oo7vc43UbVExPx++YTG25Lc/7nICWtIRIoRlgugRRszoBSSEJ7f9bJ
	e8/3pSQNIX2ULMdzcc8F0sydMW/q/c/j3HS51E8hp1pAtzOrbK+yd1SV7hpvQW9DTPRk+/pUcmXVA
	qHmfjxCA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NU-46Mw;
	Sun, 03 Nov 2024 05:40:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvL9-3Dh7;
	Sun, 03 Nov 2024 05:40:22 +0000
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
Subject: [RFC PATCH 1/7] x86/kexec: Clean up and document register use in relocate_kernel_64.S
Date: Sun,  3 Nov 2024 05:35:26 +0000
Message-ID: <20241103054019.3795299-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

Add more comments explaining what each register contains, and save the
preserve_context flag to a non-clobbered register sooner, to keep things
simpler.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c342f75..c065806884f8 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -100,6 +100,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r10, CP_PA_SWAP_PAGE(%r11)
 	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
+	movq	%rcx, %r11
+
 	/* Switch to the identity mapped page tables */
 	movq	%r9, %cr3
 
@@ -116,6 +119,13 @@ SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi	indirection page
+	 * %rdx start address
+	 * %r11 preserve_context
+	 * %r12 host_mem_enc_active
+	 */
+
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -170,8 +180,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
-	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
-	movq	%rcx, %r11
 	call	swap_pages
 
 	/*
@@ -183,13 +191,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%cr3, %rax
 	movq	%rax, %cr3
 
+	testq	%r11, %r11	/* preserve_context */
+	jnz .Lrelocate
+
 	/*
 	 * set all of the registers to known values
 	 * leave %rsp alone
 	 */
 
-	testq	%r11, %r11
-	jnz .Lrelocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
