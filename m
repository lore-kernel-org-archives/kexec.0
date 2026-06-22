Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E89CDB476
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjrF+o9hEuaO+UUEMOJt16iyDU0kR4H9hbhRLV3+SRM=; b=rgAo2/wjSGviNZlbSuffD4JuEe
	YMRHJkGwVAJ31WGcSNLNiv9CMDxoDUbXPDRyaJ1pXxbykwY/k0uYt0X8ownylBUL3eVUCcLhyK7yM
	LjaPAXg8eOUh7aVxSGq4Y3qLRLVQ6yPk7459En4bIOBXHwT6wa3MnUY6m3/2YmaamSvH1IJik5JYl
	GPboSGv6I/SyyDvv5i45+fxSWlcfpR2i/odRukvW6vywZLdfo+fAZRL6O3/l93YSuQ2sqlyBIO2iX
	XJwfpHkjLNhv4SZ7Ao28J2FwJoEP51opmBZ4W5u0b+OPGbBjEzZnrB/YAC4iTCn/eLIyVa1npW/Un
	ZdwiD/cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblym-00000005OQs-0LWb;
	Mon, 22 Jun 2026 21:14:52 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyj-00000005OMj-16ts;
	Mon, 22 Jun 2026 21:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782162889; x=1813698889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzDP/Qf23/prJJNPPgsghEZJIH7cLqjLXgSqIcy81Tw=;
  b=YmRGZR8hVbTXRCoTHM0Fq4VUZ2XyhIqqFxTEKFQvnuILAJaBDDDussL0
   NqYHdu3hBFkQNOmz8E3XFWkQP3Y3/UkWvty/eRBWdJPq1UuMFs8pHvCiC
   L5J9ZoxtPt2vFE1kCUWsmQCYxPdaQfXq+2kFCoWAdXF9AXqpnURKhpY2h
   pi7YxTjQq07e3LNLiiXx3D+wNTP0pVK+tdVNLhu7++0dzSR4bff3jIdRl
   1+cE0sB8bi6MhR9c1SuG6MkeuFaIt/9XQO7/UGP+PXoufqvdeEPplpRzM
   AMy+ZgWIz8zry95Sarj6gtG/tUZ8Af7YP8fwPiBFIRLFynYCdNa+Vm7bZ
   Q==;
X-CSE-ConnectionGUID: E3XPM0NuRAKEIxjuTHlqnA==
X-CSE-MsgGUID: UC4caY+hSmC9DhVP0GPrJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:14:48 +0300
X-CSE-ConnectionGUID: PIZbsQHORw2HX0SvceFskA==
X-CSE-MsgGUID: G7hsW6c/S6ifmNGfrT+2Lg==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Jun 2026 00:19:57 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:14:46 +0300
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
Subject: [PATCH 4/4] mips: vmcore_info: export mips arch-specific struct offsets to vmcoreinfo
Date: Tue, 23 Jun 2026 00:14:30 +0300
Message-ID: <20260622211430.4008899-5-pnina.feder@mobileye.com>
In-Reply-To: <20260622211430.4008899-1-pnina.feder@mobileye.com>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_141449_581576_4407A6B7 
X-CRM114-Status: GOOD (  15.79  )
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

Export MIPS architecture-specific struct offsets needed by the
vmcore-tasks tool, including signal frame layouts and register
context structures used to reconstruct user-space register state
from a vmcore dump.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 34 +++++++++++++++++++
 arch/mips/kernel/Makefile                     |  1 +
 arch/mips/kernel/signal.c                     |  8 +++++
 arch/mips/kernel/vmcore_info.c                | 22 ++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 arch/mips/kernel/vmcore_info.c

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 3c364434b846..4af32ddf5615 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -494,6 +494,40 @@ Used to get the vmalloc_start address from the high_memory symbol.
 
 The maximum number of CPUs.
 
+MIPS
+====
+
+(rt_sigframe, rs_uc)
+--------------------
+
+Offset of the ucontext member within the MIPS rt_sigframe structure.
+Used to locate the signal context within a signal frame on the user
+stack.
+
+(sigcontext, sc_regs)
+---------------------
+
+Offset of the saved register array within struct sigcontext. Used to
+extract user-space register state from signal frames in a vmcore dump.
+
+PAGE_SHIFT
+----------
+
+The base-2 logarithm of the page size. Used for page frame number
+calculations during address translation.
+
+_PFN_MASK|_PAGE_PRESENT|_PAGE_VALID|_PAGE_GLOBAL
+-------------------------------------------------
+
+Page table entry bit masks and flags. Used for walking MIPS page tables
+and translating virtual to physical addresses in a vmcore dump.
+
+PTRS_PER_PGD|PTRS_PER_PMD|PTRS_PER_PTE
+---------------------------------------
+
+Number of entries per page table level. Used for page table walking
+during virtual-to-physical address translation.
+
 powerpc
 =======
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 95a1e674fd67..99f2961f6ee1 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -24,6 +24,7 @@ CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 4a10f18a8806..f2241f52fa17 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/resume_user_mode.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/abi.h>
 #include <asm/asm.h>
@@ -62,6 +63,13 @@ struct rt_sigframe {
 	struct ucontext rs_uc;
 };
 
+#ifdef CONFIG_VMCORE_INFO
+void mips_rt_signal_frame(void)
+{
+	VMCOREINFO_OFFSET(rt_sigframe, rs_uc);
+}
+#endif
+
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
 /*
diff --git a/arch/mips/kernel/vmcore_info.c b/arch/mips/kernel/vmcore_info.c
new file mode 100644
index 000000000000..5d7fdc662065
--- /dev/null
+++ b/arch/mips/kernel/vmcore_info.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmcore_info.h>
+
+#include <asm/pgtable.h>
+#include <asm/sigcontext.h>
+
+extern void mips_rt_signal_frame(void);
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	mips_rt_signal_frame();
+	VMCOREINFO_OFFSET(sigcontext, sc_regs);
+	VMCOREINFO_NUMBER(PAGE_SHIFT);
+	VMCOREINFO_NUMBER(_PFN_MASK);
+	VMCOREINFO_NUMBER(_PAGE_PRESENT);
+	VMCOREINFO_NUMBER(_PAGE_VALID);
+	VMCOREINFO_NUMBER(_PAGE_GLOBAL);
+	VMCOREINFO_NUMBER(PTRS_PER_PGD);
+	VMCOREINFO_NUMBER(PTRS_PER_PMD);
+	VMCOREINFO_NUMBER(PTRS_PER_PTE);
+}
-- 
2.43.0


