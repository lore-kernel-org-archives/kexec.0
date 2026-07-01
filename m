Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F175DC43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28GFcGlf5S/Wg6fceTzSn/krnl8/+QQ2NhLnruhBKdI=; b=KQanHeJX9vvL4iZo4XC88wpuGe
	h2z5Kwr8QPIkOckpvh5qWv4LFVh9RyrbJEtPQ2FifrIzbtXCRirSSxHt82yii4f+qqv2/r/11XFPe
	PuK538op1oXni+gheLQhnCMIUbZcT0Ds5U+5u8sm6B4f0/HuynTYFZkMBOfjClKmb9rgk7xnM1AiB
	VtBa+SXccoVwg2kyjgr88SV/VazfBDe6ZQZzWY796yBgKmwvYIMZOhixu0+Yw2mW9AMleVW4Zl/yN
	ftYNlX2foU8268gVyiawE+BH2e92cDSYQ5xfsQky9sql1I57WtAglsO2HdSiC7LrDXQ2eXyI5HuG4
	YfGS6/7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wewfL-00000002NrU-1wzn;
	Wed, 01 Jul 2026 15:15:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wewfJ-00000002NrC-2SDM
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 15:15:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D430601DE;
	Wed,  1 Jul 2026 15:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A811F000E9;
	Wed,  1 Jul 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782918952;
	bh=28GFcGlf5S/Wg6fceTzSn/krnl8/+QQ2NhLnruhBKdI=;
	h=From:To:Cc:Subject:Date;
	b=kzLh9YmFozSJwGrqR/2vdrlr2T7VPtgQDYQuCeMR/FRumugqwJhZk+iqtfugz9kWs
	 F8hb4fjEh8oomodtJg0xSpLHMRmQPU3423QNkHplmjRnlzlhGmTsNUPsT3SvtnQ+ah
	 4rztqX46tU1lO6ptR6DVRfVKOGWv7Vr0hfOEB4OmPSqRfYtwZ80474Pe+iY3d++8n5
	 qP8MmfN5sAP2WhWqxVy/6o1Fzu1dPJWgRJBqh2OQefCLCsh3YOnlkIu/s0s7ajwKI4
	 nKrIAp58cXHX9lq6iKinEfpQX+iqPbPyYOcs5jCoU3fPFlja2fz45ujT2m0wTsB/vD
	 +5iHJ5VPqsvBA==
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
Subject: [PATCH] x86/setup: do not include kexec_handover.h from asm/setup.h
Date: Wed,  1 Jul 2026 17:15:33 +0200
Message-ID: <20260701151536.3068791-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
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
compliation failures.

Nothing in setup.h anything from KHO. Remove the header from setup.h,
and directly include it in setup.c and kaslr.c, which do use things from
KHO. It should also help reduce files recompiled when kexec_handover.h
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

 arch/x86/boot/compressed/kaslr.c | 2 ++
 arch/x86/include/asm/setup.h     | 2 --
 arch/x86/kernel/setup.c          | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8e4bf5365ac6..db4afe1df738 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -32,6 +32,8 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#include <linux/kexec_handover.h>
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
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
-- 
2.55.0.rc0.799.gd6f94ed593-goog


