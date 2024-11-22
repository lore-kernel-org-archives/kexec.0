Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C66E6ADCB
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S0QVtAVD7M7pFpqYQRYpOlRlIpsQlWjl3XEa+4AG3hg=; b=xOBJ002VKSNHhUpVOYfQpBzgF3
	Bn08ydOBUTgt0xLLdwxl4tKISFqPZ+Mo+RPVy0EKL9M6YccAEBUAue2GhwimIMCEfC1CzKRpcjqBX
	a7G8jvMa20MY0Gvo6fMnVXv569CvjDXpGxS8jCs2AOnUhwreRgO7nnhJvX70hQ2RgWkGwp813ZBz/
	/7x3/UuNZBvYmbHTnZERt+3u9qlcA8pNlZO42hfe7tHboDo9Jyv+/9wnt1itPGpRoAZt3kgccEmfi
	HbAdz/zG/5MAjUk4bLy96w46PDoQB8QFPbZsC+qs3uHYlYdJri/82HgUuLMbSIfEnlSrI9Wc4jFfq
	ytwwFJTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQw-00000003RLs-3i85;
	Fri, 22 Nov 2024 22:47:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQu-00000003RKQ-3V1G
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S0QVtAVD7M7pFpqYQRYpOlRlIpsQlWjl3XEa+4AG3hg=; b=jCMm6BNVrfGOtot4P6MWH5QfVr
	Jaa98yGLe9SXtDBP7HNJm6Bj4EXEkUldoFDGZMjV2WsTkMKvcq0gEHh0kHy21FKLqaw7eb+munQpl
	9w74HhVDAg4eQ7bZIWrVhQB+i6StbGjDlrAcusy/A22QCVNYoMQvD6UN40lqeyLXZnqNPRjhgsg3g
	OkmpX88v3OdYPkk6JkOqugHeJ41SGbOUeNxH5HV6XD5SlUUvtoTeDtXVDP/WyDDgpUe8+AHvklQQK
	/dgiDEx+D7xjXKej74Nk/9ZwPiJZic6d+rNmOWfVbTGXt/2uXS2v3KFnIvnKR5stFjjLb/Uu2CLXq
	LC7y+aYQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHS-2CWY;
	Fri, 22 Nov 2024 22:47:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiC-034R;
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
Subject: [RFC PATCH v2 04/16] x86/kexec: Only swap pages for preserve_context mode
Date: Fri, 22 Nov 2024 22:38:13 +0000
Message-ID: <20241122224715.171751-5-dwmw2@infradead.org>
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

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ed2ae50535dd..92d5dbed3097 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -308,6 +308,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for preserve_context */
+	jnz .Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -322,6 +325,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 
-- 
2.47.0


