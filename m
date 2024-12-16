Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB0E77183
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2QdnXzG6oBq2pMrwUNHKRzdcvGBvqjVeazTvAuBzw50=; b=l4vkG7/mnqpNGD2SYgf/CtpOhM
	DS4r2NLBGDtsFc2f+AYwITE5Su7lYw3txbjErjWAwkfCWHxfMqB0DRVBcarSKByOLWS3GspRis5th
	z9G1jsY5yA1iLUWMMLs5cnvQpXukrBzvX4DcmVYWKf7LHsv1X57uh8fP3FMNWO4GSvtxvbObYI1py
	iIYKXwCZPc5V9gmA2X4DWLti+JeiXjLdTm4ZtliaKLEGcw17KQZlQghhgwJAOW1oY+PwraBsHtnGa
	9Nqc7wq8P8g0hjORrC2DldopPGUbr6d3zcALVwPDFSabN7NYOZkhVDMoyUI3jxxg7A3Wm+z8JmGVf
	sm53xH9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeO-0000000Bewe-3pHv;
	Mon, 16 Dec 2024 23:37:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeM-0000000Betf-2NsN
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=2QdnXzG6oBq2pMrwUNHKRzdcvGBvqjVeazTvAuBzw50=; b=YtrdpZV5q7RwJLVF+vAMRjX/iH
	svvl4giWUH2iMjCT5ixTY4kEOHrtcZbHf0sb7EjpmCJgmE/sGAbZE5/TzDdZp41nJPLVbK0OwDsxK
	7CRv9x10roEGFw+y3DjL/ybkPrACOs5l3dm3GetsvoZmvSWI9cVn2hEHt2XQqQnC9+/1zuG/pvOlh
	h8sKTArFfHWsPva6AJ2ueEWgthsJtT7pZtQuWLu7h916ye+6ENMw/Cy5CHBM85kTuKjE1/Qv2zxS7
	l+1YD1+ry43OOQg5tRoITUxi0CR0Hs2zxOI2dNwgK02GphYE/IqWU2Qk8pggCLFvwNc7Ssv1ZbqI6
	I8LqVnJQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiR-2Ak7;
	Mon, 16 Dec 2024 23:37:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWZ-1mhY;
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
Subject: [PATCH 9/9] x86/kexec: Use typedef for relocate_kernel_fn function prototype
Date: Mon, 16 Dec 2024 23:24:16 +0000
Message-ID: <20241216233704.3208607-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
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

Both i386 and x86_64 now copy the relocate_kernel function into the control
page and execute it from there, using an open-coded function pointer.

Use a typedef for it instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
 arch/x86/kernel/machine_kexec_32.c |  7 +------
 arch/x86/kernel/machine_kexec_64.c |  6 +-----
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 48e4f44f794f..8ad187462b68 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long control_page,
-		unsigned long start_address,
-		unsigned int has_pae,
-		unsigned int preserve_context);
+typedef asmlinkage unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long control_page,
+		   unsigned long start_address,
+		   unsigned int has_pae,
+		   unsigned int preserve_context);
 #else
-unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long pa_control_page,
-		unsigned long start_address,
-		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+typedef unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long pa_control_page,
+		   unsigned long start_address,
+		   unsigned int preserve_context,
+		   unsigned int host_mem_enc_active);
 #endif
-
+extern relocate_kernel_fn relocate_kernel;
 #define ARCH_HAS_KIMAGE_ARCH
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1b373d79cedc..80265162aeff 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -160,15 +160,10 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned long page_list[PAGES_NR];
 	void *control_page;
 	int save_ftrace_enabled;
-	asmlinkage unsigned long
-		(*relocate_kernel_ptr)(unsigned long indirection_page,
-				       unsigned long control_page,
-				       unsigned long start_address,
-				       unsigned int has_pae,
-				       unsigned int preserve_context);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1440f792a86d..dd75a51463a2 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -344,12 +344,8 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void __nocfi machine_kexec(struct kimage *image)
 {
-	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
-					     unsigned long pa_control_page,
-					     unsigned long start_address,
-					     unsigned int preserve_context,
-					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
-- 
2.47.0


