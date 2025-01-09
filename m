Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6DFE77199
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VVE+d9HRCiUw5Gsyt81FEKKZcrEQhELhIN4TTfzz0EI=; b=wD4jKrT+jNBofzQ0TpRPM+oCqI
	bUgXY19AXE2has+fJ8LVwAV32sCmFN97KOgS0EuD5YpfeeKXpdPTMKSU5pZ7ymwnm6IlZaiOiOtBk
	VlW6c5KJJLVV2JrDWWZK/ZQ4jvIe4TrE5n39qLtVdK13JfzDGU0XUnc2t0y9keRvW1KphGA3vhrJT
	7YAcjPLH6lyza0XLsMdwS3K2KwEEPfJX3/n0WhAVuaL18z/D/4zZKo+rRFGH8GGJjgJgahkkfyxVr
	e9CChPthFlV28XDVFTU/tPihcDXVo/nMEmQnAvvWwstV9V9CM5zDUFaEP63XHYiGM1QRubgI+RrmD
	1QYM9CaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDs-0000000CAzt-1nvV;
	Thu, 09 Jan 2025 14:09:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCf-0000000CAdz-1GCx
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=VVE+d9HRCiUw5Gsyt81FEKKZcrEQhELhIN4TTfzz0EI=; b=Ue0IbLkC2r3iyYMn9RE/ADGrKh
	l8ZeSdSIhrzMBtk/TOqiXmmvf441QRFu7i3Ailv3DK/6axDmb2HHB0XvZI3pi2aCAvgHGKeIR/2fv
	3uZIokMC8e0bPKkPb52gou9yxmfFi3pGMOFjQMFG5JFzx1r0pNmD6CYXCw70ya+ShltDA2vMlhTWA
	lFutfvEpofpnfZARlWN2grExuOA79YmlHxwduZItT8Vkg/JEa8D6QFU5i2zpXdFCDxC3q09mvVZxl
	hqh1AsmIBoQWBIV6zIvSMZhfCmdI6fGyuBoeUg7J6As4O2o+UmkW2VWCGECaM5Abi4lvO5WaJKtYg
	qIhQrUJw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCZ-00000006IQF-2Doj;
	Thu, 09 Jan 2025 14:07:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx5q-2Hvq;
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
Subject: [PATCH v2 1/9] x86/kexec: Disable global pages before writing to control page
Date: Thu,  9 Jan 2025 14:04:13 +0000
Message-ID: <20250109140757.2841269-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109140757.2841269-1-dwmw2@infradead.org>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
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

base-commit: 893930143440eb5e3ea8f69cb51ab2e61e15c4e1
-- 
2.47.0


