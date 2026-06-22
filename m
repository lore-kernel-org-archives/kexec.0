Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E46CDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kPINK0rjPWWTfCEGRTXMizy7xB1oahwHDAt0v4Yhjyc=; b=XaIQUWwj/XG4uxv+a7MDYNZIMu
	hK/S9Ts2HgcuEMvE4GiZcNPOU53Z6zjbk9mc3LJpbNN7DBaFMBOYb2sBpgLRLwnYHyo9ERcnIfh1X
	DcAq0g7I6zASpxV6D7KBlinZC3gJvLg0gURXJfkyGXloaudRkz4BKlwfBRZZG5JWx3mpQ3ES202fj
	5k+QMSQaBX+dWlfda9NDzRGmGifFyhD1fI7N9x5pwgSeKHcc1fv488HsH0aEVt70FOMURiv2cSQQR
	nvVK9aP9ZKrqy9q1AhObOwWhm2M2NAv1FeufLalRVGA+pRJdh4qx4EdZ9PhQdoijggWVN/PA5+SO9
	IAE5YOpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyl-00000005OQl-4AHH;
	Mon, 22 Jun 2026 21:14:51 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyi-00000005ONZ-48f1;
	Mon, 22 Jun 2026 21:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782162888; x=1813698888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTIF5cEmVnxxDW8vrLW8IxPoavSb7ayg0HJS7UNjj2U=;
  b=emYFwLEb+iEootMoZqjRhwlJ/EKQ12It8nqXmmyCl+SOi57B/Ps5nPEk
   RjtNkMlK7qn3pzat3MhLjpRguOnWf19uchRAQ+0/bfxsLr5aCO1n+7/jA
   poimk6piZUhQqB6ugBXtiDJX3q2MJiwAMinOoLI0HlkSwhYOEQV7RvQUm
   28KVSF6eLwMRXSADI78IIX3/aRDvCiBQ6Ku36PiJKR9ML3NqzmHr0cO86
   t8lp84Id8P9WzIIFenqbfh0PmQehaOND3fY2nS2qhzHLGTDeINqpoBJiF
   l+IJUOyqED8YP2ogIqCyIdyosZTvG4pG+gAkeWWN19kWwbaCHEHXZuWov
   g==;
X-CSE-ConnectionGUID: bAl2lNH0QQOIu5OyFwGuSQ==
X-CSE-MsgGUID: YFhyFMK7RWOZ5Iv6l/6Nzw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:14:46 +0300
X-CSE-ConnectionGUID: d2Mj9Z/LTAyQwRo8bu/WlA==
X-CSE-MsgGUID: awrFJsz0TTW7kTmYesvBUg==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 00:19:45 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:14:45 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 3/4] riscv: vmcore_info: export riscv arch-specific struct offsets to vmcoreinfo
Date: Tue, 23 Jun 2026 00:14:29 +0300
Message-ID: <20260622211430.4008899-4-pnina.feder@mobileye.com>
In-Reply-To: <20260622211430.4008899-1-pnina.feder@mobileye.com>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_141449_335780_C15AB159 
X-CRM114-Status: GOOD (  12.84  )
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

Export RISC-V architecture-specific struct offsets needed by the
vmcore-tasks tool, including signal frame layouts and register
context structures used to reconstruct user-space register state
from a vmcore dump.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 26 +++++++++++++++++++
 arch/riscv/kernel/signal.c                    |  8 ++++++
 arch/riscv/kernel/vmcore_info.c               | 11 ++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 36103b3cdc05..3c364434b846 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -595,6 +595,32 @@ va_kernel_pa_offset
 Indicates the offset between the kernel virtual and physical mappings.
 Used to translate virtual to physical addresses.
 
+STACK_ALIGN
+-----------
+
+Stack alignment requirement for the architecture. Used to locate signal
+frames on the user stack.
+
+(sigcontext, sc_regs)
+---------------------
+
+Offset of the saved register array within struct sigcontext. Used to
+extract user-space register state from signal frames in a vmcore dump.
+
+_PAGE_PFN_SHIFT
+---------------
+
+The bit shift to extract the PFN from a page table entry. Used for
+virtual-to-physical address translation when walking page tables from
+a vmcore dump.
+
+(rt_sigframe, uc)
+-----------------
+
+Offset of the ucontext member within the RISC-V rt_sigframe structure.
+Used to locate the signal context (and thus saved registers) within a
+signal frame on the user stack.
+
 Task and VMA metadata
 =====================
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 59784dc117e4..eb03c0ea6aae 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
 #include <linux/entry-common.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
@@ -40,6 +41,13 @@ struct rt_sigframe {
 #endif
 };
 
+#ifdef CONFIG_VMCORE_INFO
+void riscv_rt_signal_frame(void)
+{
+	VMCOREINFO_OFFSET(rt_sigframe, uc);
+}
+#endif
+
 #ifdef CONFIG_FPU
 static long restore_fp_state(struct pt_regs *regs,
 			     union __riscv_fp_state __user *sc_fpregs)
diff --git a/arch/riscv/kernel/vmcore_info.c b/arch/riscv/kernel/vmcore_info.c
index c27efceec3cc..dd174042dba3 100644
--- a/arch/riscv/kernel/vmcore_info.c
+++ b/arch/riscv/kernel/vmcore_info.c
@@ -3,6 +3,12 @@
 #include <linux/vmcore_info.h>
 #include <linux/pagemap.h>
 
+#include <asm/processor.h>
+#include <asm/pgtable-bits.h>
+#include <asm/sigcontext.h>
+
+extern void riscv_rt_signal_frame(void);
+
 static inline u64 get_satp_value(void)
 {
 	return csr_read(CSR_SATP);
@@ -28,4 +34,9 @@ void arch_crash_save_vmcoreinfo(void)
 						kernel_map.va_kernel_pa_offset);
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 	vmcoreinfo_append_str("NUMBER(satp)=0x%llx\n", get_satp_value());
+	riscv_rt_signal_frame();
+
+	VMCOREINFO_NUMBER(STACK_ALIGN);
+	VMCOREINFO_OFFSET(sigcontext, sc_regs);
+	VMCOREINFO_NUMBER(_PAGE_PFN_SHIFT);
 }
-- 
2.43.0


