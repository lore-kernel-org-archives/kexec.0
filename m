Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD2AE77186
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KF9I8gMwuVGDi5vu6drdRG3X3dHP+mrVfyO8mKUOGvk=; b=KSQJ4GQHGWUnDfNhPgondMMz3y
	vZ0Yz0VGuW2RVGsGacnXvr+pF9cCUb9YvHFKFs8zEiUfRZKv59KI9OWBA4PdlhxbBaAYfJIuGECWF
	QbRi7fMwj8T1dF7wQs4enL7hvztnjCzVnJ7rhSy3sijojhyXOzVuoaXpqiMrlXJ0VLmFECo6gso9f
	Jz7UWqvuqpAREQxqZFSBiEBvVK13pwKlzn14M9/tnh3+UwPV+ZFZdy3iHxIGyFJEgz25nVgotLw+p
	Essl61CtKEfP8NaVQcOXHzf4g82gvz/IRLxj4Izsmgq+ijOWTB14cn1AEBvJyZ+NwligeRzLqQRG5
	7TiPU5UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeK-0000000BesY-1cMR;
	Mon, 16 Dec 2024 23:37:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeI-0000000Berd-0c7O
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=KF9I8gMwuVGDi5vu6drdRG3X3dHP+mrVfyO8mKUOGvk=; b=m94t7MaEEu9OBNPTDHoiuf70Fq
	Tp+6Tautcgn9+y4v+iOpPpRA7dlOW5BExNEZlyaWF6c5MembvO9E+FFAn0uqXpg5K1RzSXcq4jav2
	0bPZNV6y+IFYVMhUtDQZqYbSCItpaxpTV1ihMtfL8DxE6H6VkEvxzqAqu4H8t5WnoBViQ3X5Z1Jra
	KCkt6QMGdR3bdWpiBS2RER03GULc8H1xzIA+fy/pEXdzwv5vxGdcmVMSrO6KJSnfRCNFZl5s+xqv7
	W9sQtfqIFJO3Yz2pT5PTiGNtw22ueBKpuEkj9w2CSSaof8josM9C5BZT6ffocA8+uiijHgK8XXaqU
	YCQ/yO3w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nY-2fG0;
	Mon, 16 Dec 2024 23:37:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWN-17Kz;
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
Subject: [PATCH 6/9] x86/kexec: Mark machine_kexec() with __nocfi
Date: Mon, 16 Dec 2024 23:24:13 +0000
Message-ID: <20241216233704.3208607-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A recent commit caused the relocate_kernel() function to be invoked
through a function pointer, but it does not have CFI information. The
resulting trap occurs after the IDT and GDT have been invalidated,
leading to a triple-fault if CONFIG_CFI_CLANG is enabled.

Using SYM_TYPED_FUNC_START() to provide the CFI information looks like
it will require a prolonged battle with objtool. And is fairly pointless
anyway, as the actual signature comes from a __kcfi_typeid_… symbol
emitted from the C code based on the function prototype it thinks that
relocate_kernel has, rendering the check somewhat tautological.

The simple fix is just to mark machine_kexec() with __nocfi.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: eeebbde57113 ("x86/kexec: Invoke copy of relocate_kernel() instead of
the original")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9232ad1562c8..1440f792a86d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -342,7 +342,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void machine_kexec(struct kimage *image)
+void __nocfi machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
 					     unsigned long pa_control_page,
-- 
2.47.0


