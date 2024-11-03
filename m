Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F14CE67807
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WBldTtZRVS8nGFSwJR/hmTSj76ToqGspZQixArgsxGs=; b=aNmDBMx9JPuhhT
	mB9G5UHXOPz0VLQ/l2hoA+rojfSyoovdw5TsRzCdc0Sm9trrhGX9eZ7TdVORHPzf+gstBEa9e53R/
	rFSjqQtWOLMn9fK47sw8Rqbr/R41y+Vu25gPcvbgWopBKnsxHCCyDtyFsGDg+xRAfAZLyGjEy3dns
	hOlTonfIKZ4FK2sZPeRP6C0XdagcQwKLmm/9byJoL3mnuAx/HTf9fVDk9V1nqvDt9yfmATT4vcgMd
	qBL3g9KR6MOYm/MRU2tIxqO+Z9HBYpK5NekRCJQK5uVrsy5KfNW/FdfLHOh5AMZxJMCzxNPNxv8H8
	UwVTxZrozK7aYDpHrcGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLk-0000000AzWZ-0WbT;
	Sun, 03 Nov 2024 05:40:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLe-0000000AzVg-2l61
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EAnjyRllEKGF0bSHoHw2dKzQG9JAUcHgHIvCWu8G9Wg=; b=tzF/f4Z7GbwLXKV6nLIyILNUb3
	wCwGmvdvZCNmyTD4Jp7WHkgUt6nW0fnmcY/k4XiTBruK0dMYD/NnIn7w3rdr+90UVl8ylBycDzHEJ
	ck7p1ufEdGR470rfRe6oYAMc99X1eTt02mrFnm6KYf8TtLbCNluI+pnMhFRrZJmOCu1+TnWuVJVUQ
	ZaQF/8Y+29Fnd+LDJOszZZcb4a/LqGyjvHV8NZIfDVPCtbw6S02+K9XJ9xuIH2HJSOEyWIo+6RDNg
	8gwIqJLB9zqA5orFYN++RcfD55/z7pAqKMuIo2kAE/lGbfb/yLm6PaaYa8Em6/LpEZ3azKbd5+ndS
	awWJYTPA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiM-2Nhs;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvLH-3pEI;
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
Subject: [RFC PATCH 3/7] x86/kexec: Only swap pages for preserve_context mode
Date: Sun,  3 Nov 2024 05:35:28 +0000
Message-ID: <20241103054019.3795299-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e607c0b7d70b..9b6ed08e00ea 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -302,6 +302,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for preserve_context */
+	jnz .Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -316,6 +319,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
