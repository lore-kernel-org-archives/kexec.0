Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F42BD6D227
	for <kexec@archiver.kernel.org>; Wed, 27 Nov 2024 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbThuJMqNCEqi5OCJ2hHO8LahRmj/ISCryb2ADbdx9M=; b=DkkMQKRpB8JrLf9rn/DJKGiBTr
	rfGcfGwAY6vPoWM97wGcJ+9x1zgL8lWfS2mGT8ukZZznkD4ZfF2w+iMzZDQxyWwyiVShRArgrpx3B
	4MxuOTVGpjwpQMFHsvIjLXJTUkbkcfIyiMgDyf33SBc95/juzr/HUaJkVqvY2wwvuE+cWrovFb0VD
	gC3KLvUJB3tiwkn6SAY2lWIB8lLyYKVu8kfqkXg3bvKhS2Duri4UBbdobDnbyRcUALX6weCBBgu3N
	Qhr2HS72FMUyg+sURWsg3mWDFJIomcm+IcujLVJlt6LMZeDtcvQYwx9nyf+2yyeXOvOnbkg9HHt19
	yVOB/6IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKN-0000000Dt5P-0961;
	Wed, 27 Nov 2024 19:03:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKJ-0000000Dt0u-33dG
	for kexec@bombadil.infradead.org;
	Wed, 27 Nov 2024 19:03:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AbThuJMqNCEqi5OCJ2hHO8LahRmj/ISCryb2ADbdx9M=; b=ah2JlbFUdHK5RQ1AnFOXYqBoiM
	tXKSBRgBzcq16hLM8IfYjNoRPIMC90FYEnffspwc3822yDnFXeAP8s7HfB90kVpEgg1Wr3VSX+hGC
	W7qZZPUcbEuGr1HoATjsjOT3fy/ppfYZk97D4+Xcc0cJ6AjeRxctXO/5zTxHwGEcRb9g37BWk5xjk
	pA9NnhXAR0SLiT0Y/SveMSlviSlpvRnxTFhjLft2fBR+KmrKJxPl2BiBJxOh9llUCmOTaWWSAEKnz
	+Rriu2nSpH4Fy+Uiu+7BwV/eRZalbMkyiC1MFOSpzDDsagkWf8LKrsX9D827x/15pxM/1gpL11FV4
	b9H90kWg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sud-188j;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000000BiM-47rP;
	Wed, 27 Nov 2024 19:03:46 +0000
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
Subject: [RFC PATCH v4 04/20] x86/kexec: Only swap pages for preserve_context mode
Date: Wed, 27 Nov 2024 19:00:18 +0000
Message-ID: <20241127190343.44916-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index fea650f92606..50cc33f2ecb7 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -310,6 +310,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for preserve_context */
+	jz	.Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -324,6 +327,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 
-- 
2.47.0


