Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D675E7719C
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GPX4uH5hPGTEsJKbCTX7Iw1UzlZ9qs8SxieW1Q8mSw=; b=iq7UmuiMsnXdhB5ItgyD1BJUHu
	nwpn/hfY7cg9wFrPNQ0mjyBc5io7ogsSJapUljp4kfCXQtEidL1dgtYx3KeTg1lrJTaYqZWIQJQnU
	4N8RXUKT52rhT8wwMujCOkyfODMSh9UFq7jG4uS+gfenK4InPwJcLk43HhCLgUaq/PDmd94ap5w6q
	WAfWNcjEkDy+0HwhzJ6IFIz6IFDg/7MOBAsauuv8x4baT7XSzEDKEHiCwB3dlMjp8mFJoHJr3P/Aw
	AI5wdGFIoUlzLebon0RS9EfWToSaJTkTLsz0dK9YI+RD+EMuMoFwz5ZNABXG14Dd2892NNuQYNiGa
	2X1ioZTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDt-0000000CB0X-1DC7;
	Thu, 09 Jan 2025 14:09:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCf-0000000CAdy-1GQS
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=4GPX4uH5hPGTEsJKbCTX7Iw1UzlZ9qs8SxieW1Q8mSw=; b=X10vdTEH3d8k/EovQ7NgJsE1gp
	/eYVbxf/SQQRz1A+vrsYn6w9+3KdWDJsWoZ3UbUl17CWnLRKk1AUfECnEo9/hWsD0L4CxBHoaQHiz
	Ooh7xWg0e7BAgsTKQXg3cCmMz7dl2xaeDxYSYNYJgS46pjdMw/eaaJ80+Kxt4YFM8w8Uh4+R9FBBQ
	wAcV08AjhrsBWj5E1+bvokq5Nke3q4hjHOxSbBRJpo5/HLGARwDXMV+qlozDq0U7pu7LnyNPceJCL
	Av6pBMgufuj8o2vg5svMeqVFOU+t5S0gPekQZ/JY02Zz3k6RjPhlkuoB3VTns9eNRPUQv0bFz53pf
	D29t6BpQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCZ-00000006IQG-2Uet;
	Thu, 09 Jan 2025 14:07:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx5x-2Ygt;
	Thu, 09 Jan 2025 14:07:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
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
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: [PATCH v2 2/9] x86/kexec: Ensure preserve_context flag is set on return to kernel
Date: Thu,  9 Jan 2025 14:04:14 +0000
Message-ID: <20250109140757.2841269-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109140757.2841269-1-dwmw2@infradead.org>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
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

The swap_pages function will only actually *swap*, as its name implies,
if the preserve_context flag in the %r11 register is non-zero. On the
way back from a ::preserve_context kexec, ensure that the %r11 register
is non-zero so that the pages get swapped back.

Fixes: 9e5683e2d0b5 ("x86/kexec: Only swap pages for ::preserve_context mode")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 9bd601dd8659..6fce4b459652 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
+	movl	$1, %r11d	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
-- 
2.47.0


