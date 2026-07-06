Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F3BC43602
	for <kexec@archiver.kernel.org>; Mon,  6 Jul 2026 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YQ9Hvr15QYl19jYxj1XsZwlcckoCKeNx5qunpqWNxow=; b=OmOXawiPK5ORaoCi4Lp+yAtHFa
	G0oR/CKFCc0pDEt6gAWF2ZJpSaXQ6dJ7pQtErH/cpQCR2mRfJaTtxWb49WJhVkA3vf47qqV8P8nFp
	Y3Yf5XX+U/OX4NH5wEyI5kvZualdAp0t4y96FYwDmSErFePUZNGFKnBAMEL+Mwz7LSZxEv+NkVt8h
	xQSaea/7TfRSwT3jm1eeON9KT3ojNfC/KNxWHqCMUkb6y/v81L0WyC9NykmwlG1RuqucJIbtH0Rah
	aTLLB0Lc4LasXzItdQ4UOoOJHfXTbFuNwunq1JOis2N4KsMF5U+j+0i1x28M/JjgHU4T9lioQjG33
	5PQF5PwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wglOh-0000000Cv0j-108M;
	Mon, 06 Jul 2026 15:38:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wglOX-0000000Curq-0Qdu
	for kexec@lists.infradead.org;
	Mon, 06 Jul 2026 15:38:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A5DB340944;
	Mon,  6 Jul 2026 15:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70121F000E9;
	Mon,  6 Jul 2026 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783352284;
	bh=YQ9Hvr15QYl19jYxj1XsZwlcckoCKeNx5qunpqWNxow=;
	h=From:To:Cc:Subject:Date;
	b=g3vcBRGSqUKuPD4I67beXNUHw1GYuxDim0yfH/UBLE/EAVBC7JrgR3tlezmCyWX86
	 iAU6ta4/p9kpNNSAAwTT8QTqr40ZVdUJBkidqTloae8V4oWTkegRptfgyPs1jn3D5S
	 BVmvkc2oaGNUqFtA2TI7kjwvV5tQ5setmDS98z9UON8P0+RnurRYVjiDEwpF5jtU8o
	 503SdCYVr2fBvN+xxsKzZt1NexU7P4mSe3BTmPuoU0rD7q3gKXs7UAQyyn783ii1tB
	 WnJ9hlnxaPIdFoHyMIUJExn49tAF6tLqwJbGl+yEOKE86bhnVP/b+0+bxaRPVMRHOX
	 vxKXSddkevR8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH v3] x86/setup: do not include kexec_handover.h from asm/setup.h
Date: Mon,  6 Jul 2026 17:37:49 +0200
Message-ID: <20260706153751.1166003-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
used by setup.c and kaslr.c. But this inclusion is problematic. The
header is included in many places, so it results in the KHO header being
propagated there. Also, the setup header is used by realmode code. If
KHO header includes things like mm.h, it causes a big dump of
compilation failures.

Nothing in setup.h uses anything from KHO. Remove the header from
setup.h, and directly include it in setup.c. which does use things from
KHO. Since kaslr.c is a part of the decompressor, avoid including linux
headers there directly. Instead, split out struct kho_scratch, which is
the only thing the kaslr.c uses, and move it to
include/asm-generic/kexec_handover.h.

This should also help reduce files recompiled when kexec_handover.h
changes.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    Thomas/Ingo/Borislav/Dave, is it okay if we take this patch through the
    live update tree? I have a patch series for KHO that depends on this,
    but it is 20 odd patches and I don't want to spam the x86 list with
    them. So I am sending this change out separately. It is an improvement
    on its own anyway since it reduces recompilation on kexec_handover.h
    changes.
    
    All the changed files see relatively low patch traffic so chances of
    conflicts should minimal I think. And if there are any, I imagine they
    will be relatively simple to resolve.
    
    Changes in v3:
    - Fix changelog nitpicks.
    - Add kexec_handover.h to generic-y and use asm/kexec_handover.h in
      kaslr.c
    
    Changes in v2:
    - Do not include linux/kexec_handover.h in kaslr.c. Instead, split out
      struct kho_scratch, which is the only thing kaslr uses. Move it to its
      own header in include/asm-generic/kexec_handover.h

 MAINTAINERS                          |  1 +
 arch/x86/boot/compressed/kaslr.c     |  2 ++
 arch/x86/include/asm/Kbuild          |  1 +
 arch/x86/include/asm/setup.h         |  2 --
 arch/x86/kernel/setup.c              |  1 +
 include/asm-generic/kexec_handover.h | 12 ++++++++++++
 include/linux/kexec_handover.h       |  6 +-----
 7 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/asm-generic/kexec_handover.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..a3ed337e827d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14334,6 +14334,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
+F:	include/asm-generic/kexec_handover.h
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
 F:	include/linux/kho_block.h
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8e4bf5365ac6..22267a83e064 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -32,6 +32,8 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#include <asm/kexec_handover.h>
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 078fd2c0d69d..47ef8cb482e3 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -15,3 +15,4 @@ generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += ring_buffer.h
+generic-y += kexec_handover.h
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 914eb32581c7..895d09faaf83 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -69,8 +69,6 @@ extern void x86_ce4100_early_setup(void);
 static inline void x86_ce4100_early_setup(void) { }
 #endif
 
-#include <linux/kexec_handover.h>
-
 #ifndef _SETUP
 
 #include <asm/espfix.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 46882ce79c3a..5ebb521e136d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -16,6 +16,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
+#include <linux/kexec_handover.h>
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
 #include <linux/pci.h>
diff --git a/include/asm-generic/kexec_handover.h b/include/asm-generic/kexec_handover.h
new file mode 100644
index 000000000000..50839fb5ee8e
--- /dev/null
+++ b/include/asm-generic/kexec_handover.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_KEXEC_HANDOVER_H
+#define __ASM_GENERIC_KEXEC_HANDOVER_H
+
+#include <linux/types.h>
+
+struct kho_scratch {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+#endif /* __ASM_GENERIC_KEXEC_HANDOVER_H */
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..48a9793c2b76 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -5,11 +5,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-
-struct kho_scratch {
-	phys_addr_t addr;
-	phys_addr_t size;
-};
+#include <asm-generic/kexec_handover.h>
 
 struct kho_vmalloc;
 
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


