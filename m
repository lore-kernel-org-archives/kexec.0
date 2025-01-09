Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EAE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpLME9O4Hrgm0YpKuGQMslbI8cpLYo5TkEgKVoEpH/Y=; b=Y124EGnHty2l9GJV/l01DA/+Fx
	6zAe+wm4AdeSFqXmHXCrTbhdxYV1tQlR7sBpZyl3sUeHXriDZmVtxl0FMi6FJULbxTD4aUhFlOzFC
	NkJWNK8Vd2goIGHNh6NyWKbVUChckGDH5K2uu4KqJQDdFw+OMT3DAkOAn1oCKXkQUM04EyTYlDLU3
	K797UEYO/VEuFBpaZWc8VPDvaEbcbynq1wSFLZ0k+euPV/p4kDKp2/WD5vLwS3drhWSDZ4L5jMggA
	KyhDRJYpLXijDi/9vZJVIVB+yyWfNJqGLce9lmKwHilx+CWslIqRJccVEekZ+T9T6kTunpYwsWOVj
	A9GEyC2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDu-0000000CB2L-2Hae;
	Thu, 09 Jan 2025 14:09:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCf-0000000CAe2-1GRv
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=lpLME9O4Hrgm0YpKuGQMslbI8cpLYo5TkEgKVoEpH/Y=; b=Qg7ot0dXIkUrzgylpdi1LK+NTp
	4UQiZZu6ioGgls8rwTSSTJmJjZ6u5fqTryHrC+c0zH+aqinRTMxTU0nLmFMhrs6pCFCy8q1UxEc4q
	X2S2KTeijTnBan2P4L26rBVJM/VokS5Ap6i3OZ65qaSYYapabPf/x1b4bNgJVJf8M2/ifNklOKymF
	6J6atdSGWLL4LtAYJZKhpdJb6lHv0p9018qxP9jR38r0LulxMCaz960dr9FatHXgAQ7ra1kzITO10
	QhE0gWj4986pnc8tZwPrVZgbxYgNHLxyaMcREpHkLGc80HZxfgPuYsi7D7qFkBPOUuXtwdTTlrMng
	YE0vBURw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCZ-00000006IQI-3C1i;
	Thu, 09 Jan 2025 14:07:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx6F-3GY5;
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
Subject: [PATCH v2 5/9] x86/kexec: Fix location of relocate_kernel with -ffunction-sections
Date: Thu,  9 Jan 2025 14:04:17 +0000
Message-ID: <20250109140757.2841269-6-dwmw2@infradead.org>
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

From: Nathan Chancellor <nathan@kernel.org>

After commit cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel
.data section"), kernels configured with an option that uses
-ffunction-sections, such as CONFIG_LTO_CLANG, crash when kexecing
because the value of relocate_kernel does not match the value of
__relocate_kernel_start so incorrect code gets copied via
machine_kexec_prepare().

  $ llvm-nm good-vmlinux &| rg relocate_kernel
  ffffffff83280d41 T __relocate_kernel_end
  ffffffff83280b00 T __relocate_kernel_start
  ffffffff83280b00 T relocate_kernel

  $ llvm-nm bad-vmlinux &| rg relocate_kernel
  ffffffff83266100 D __relocate_kernel_end
  ffffffff83266100 D __relocate_kernel_start
  ffffffff8120b0d8 T relocate_kernel

When -ffunction-sections is enabled, TEXT_MAIN matches on
'.text.[0-9a-zA-Z_]*' to coalesce the function specific functions back
into .text during link time after they have been optimized. Due to the
placement of TEXT_TEXT before KEXEC_RELOCATE_KERNEL in the x86 linker
script, the .text.relocate_kernel section ends up in .text instead of
.data.

Use a second dot in the relocate_kernel section name to avoid matching
on TEXT_MAIN, which matches a similar situation that happened in
commit 79cd2a11224e ("x86/retpoline,kprobes: Fix position of thunk
sections with CONFIG_LTO_CLANG"), which allows kexec to function
properly.

While .data.relocate_kernel still ends up in the .data section via
DATA_MAIN -> DATA_DATA, ensure it is located with the
.text.relocate_kernel section as intended by performing the same
transformation.

Fixes: cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel .data section")
Fixes: 8dbec5c77bc3 ("x86/kexec: Add data section to relocate_kernel")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++---
 arch/x86/kernel/vmlinux.lds.S        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a95691b42c5c..14ed40b7f322 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -23,11 +23,11 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * The .text.relocate_kernel and .data.relocate_kernel sections are copied
+ * The .text..relocate_kernel and .data..relocate_kernel sections are copied
  * into the control page, and the remainder of the page is used as the stack.
  */
 
-	.section .data.relocate_kernel,"a";
+	.section .data..relocate_kernel,"a";
 /* Minimal CPU state */
 SYM_DATA_LOCAL(saved_rsp, .quad 0)
 SYM_DATA_LOCAL(saved_cr0, .quad 0)
@@ -39,7 +39,7 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
-	.section .text.relocate_kernel,"ax";
+	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0c893997f023..63ff60a11be5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,8 +100,8 @@ const_pcpu_hot = pcpu_hot;
 #define KEXEC_RELOCATE_KERNEL					\
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
-	*(.text.relocate_kernel);				\
-	*(.data.relocate_kernel);				\
+	*(.text..relocate_kernel);				\
+	*(.data..relocate_kernel);				\
 	__relocate_kernel_end = .;
 
 ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
-- 
2.47.0


