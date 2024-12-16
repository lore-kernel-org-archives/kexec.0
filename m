Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA21EE77183
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=siK05iL8Sl6AWnRvb8/748kKl/nChwb5EZxS4049r5c=; b=z85wGZPtLPOyj6x21XNxyi6Ohq
	ImZcY9xHfctrX7w4HvMkYQlZCwxJ/V527y5dbTnbsZWu1VH7yDovgsP5Oq+r1y6vaJA6adCcLughX
	SXrIyUAeWJWByl1wBbR/fVJ5d5McGY1V8Z14jNr67OckOFOSwKBQA6Xf8yLI7cHUCqC/hvRsc6fYe
	A+LRPFrGTV1sdOhsSxaO5mgaGkj+t5WPfZSfNUG9oVfj682ZOCWdPVoZiNSm6IcAPRASq7k8O7S/7
	XU+KHq/aB89/jLKnsxzO5bX1yTllE39fB4kmXlVqkgQTtC/qVL4joY4cUWaFihQDkWWRHdbhq63OP
	roihIEPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeJ-0000000BesJ-2jWW;
	Mon, 16 Dec 2024 23:37:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeI-0000000Berb-0bqo
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=siK05iL8Sl6AWnRvb8/748kKl/nChwb5EZxS4049r5c=; b=qvaNRGwUFC5FsBbeIs6VVrSnBe
	WbdfBwGzFPGSuxtAJlPzlK3kEAsmjb3fbEYVnEQPt0u2zYf9NRL/ttY09zBY2hMIHU4u3m6aGDKII
	jkkzC7rJlMsFboQaNYUbNnRpJmg5RWJZKBwCxmSqjXkpjFmLcDTAAWAV4JllqeMO6JJCh7ASYUMtE
	ezZGQz/5KZZeKbL2Rdr8m8AsmR4b/oAng2yu1xaUfCKil0/pWZ1qi/Dm1yb5IPeiiJP+eeiesmw82
	/xpgrD+l9ZN+m0Y3mvxYmmArGtoVytSqpPNVbulOqP+Y0OpE5O98zHpUfoJbXBZBWYgJc78/fyGGn
	q9pBrmJA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nU-1cjU;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW3-00b8;
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
Subject: [PATCH 1/9] x86/kexec: Disable global pages before writing to control page
Date: Mon, 16 Dec 2024 23:24:08 +0000
Message-ID: <20241216233704.3208607-2-dwmw2@infradead.org>
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

The kernel switches to a new set of page tables during kexec. The global
mappings (_PAGE_GLOBAL==1) can remain in the TLB after this switch. This
is generally not a problem because the new page tables use a different
portion of the virtual address space than the normal kernel mappings.

The critical exception to that generalisation (and the only mapping
which isn't an identity mapping) is the kexec control page itself —
which was ROX in the original kernel mapping, but should be RWX in the
new page tables. If there is a global TLB entry for that in its prior
read-only state, it definitely needs to be flushed before attempting to
write through that virtual mapping.

It would be possible to just avoid writing to the virtual address of the
page and defer all writes until they can be done through the identity
mapping. But there's no good reason to keep the old TLB entries around,
as they can cause nothing but trouble.

Clear the PGE bit in %cr4 early, before storing data in the control page.

Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of RWX")
Co-authored-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219592
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8bc86a1e056a..9bd601dd8659 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -70,14 +70,20 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
 
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+
+	/* Disable global pages immediately to ensure this mapping is RWX */
+	movq	%r13, %r12
+	andq	$~(X86_CR4_PGE), %r12
+	movq	%r12, %cr4
+
 	/* Save %rsp and CRs. */
+	movq	%r13, saved_cr4(%rip)
 	movq    %rsp, saved_rsp(%rip)
 	movq	%rax, saved_cr3(%rip)
 	movq	%cr0, %rax
 	movq	%rax, saved_cr0(%rip)
-	/* Leave CR4 in %r13 to enable the right paging mode later. */
-	movq	%cr4, %r13
-	movq	%r13, saved_cr4(%rip)
 
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)

base-commit: 35aafa1d41cee0d3d50164561bca34befc1d9ce3
-- 
2.47.0


