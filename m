Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1064EE77187
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CrhFZ3L2x07bub/40Vp59il27O/SizC8zFhP7HAHpi8=; b=DtgQHqU0XEp62dhQl9+M/u6v+i
	pqT6o6eky5QXJtVcx1ta6CWiDqJGmbJoPokyX3EdvOvkGEIXRx8InD4OPT2bU0dWp1yXSaHw8nfdN
	kutaIuwns8MHleIY70Ia7+ovblcEiDTCSdONSCnQHhiDCdRFKw1ukBBxLk6lA8ks3V7XnQndaPTLe
	CzhwpylF/TJR8r+aGkuscu9PhY8Bmt/A52yYqnPDyC02lMuuB/FBnjwAEeYjofeOYEhaY/Qs9rIlu
	jdXgd4q8E1S8MbtcTMYfjM9YKOsfcOZpdNIRBPYfm1RYVGXdxMvEGm39udHPpwxM498ic2XYn3zhe
	FR5IOZSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeK-0000000BesS-03UQ;
	Mon, 16 Dec 2024 23:37:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeI-0000000Berc-0bqo
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=CrhFZ3L2x07bub/40Vp59il27O/SizC8zFhP7HAHpi8=; b=vyMpdeUQOKLY34lxdul443TXiG
	SsMDdVpmb/GQZVDcjd8ZpZzYRiiaZy/H3uHDFcO/N+ZO9pYSVzqUDUMkCdfPv5vaADFjzdpBHrD4T
	J69AC1a41R3X6VWqPzkUEURqV6zbgPEIR0h5utxro0iKiHRxJ02vmxtSkrvm5J8MnYFU2vgflSgN7
	Oz5wxizXbR0DgaEHbku7Z5p0Rvt0ltgt+Wg5vXD2v1rJZ2MHUonMgtiQTwVdB40gQAAuhsu7NUNPA
	fRjhmyBKf9F3PrTqCT6MtUvAKXyrCxKpjfMQJgWMBaCbyH9aX/HZ+TA7uL1dENbB/lntQxAHroFm0
	eRvnKMrg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nW-1rMG;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW6-0Alp;
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
Subject: [PATCH 2/9] x86/kexec: Ensure preserve_context flag is set on return to kernel
Date: Mon, 16 Dec 2024 23:24:09 +0000
Message-ID: <20241216233704.3208607-3-dwmw2@infradead.org>
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
index 9bd601dd8659..1a52e4339c1d 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
+	movq	$1, %r11	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
-- 
2.47.0


