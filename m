Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D6E9370D
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXHUsgU+Uq9AzbCGVMJk6EwGGV7VT5y+TDL/UkgRPJs=; b=ydh3IjRQsQmQdy
	whddjU/CcRTau9GixG32U8oH2pLPk60OSWs2ZnnfDXRw9r1Lw+KRFkccRywmzxzEDxcLW6Qo5q2zL
	c51lxFJBqMuBzak3pLSx3FA4qj54N+l6Xjhm1VN4LLB/1Wdz3mcCdu+eDmb4gU+7N+OqBcqK9xsj/
	sWdXFPAYexBnUMhHWUCOIT2UWiGeHUQCYMUUvU2yAS0dk375GAMzC8oonakCQuRt7znPGYMRsnp6X
	dRWawKRpaYEJQA35yxqavr+GanCgtwaWPahmuPLe99uQgqFuTL+VAi+o9db2zHEaS/RTo4+Z9Ug1u
	08VsITmgZrbh+KXC0GTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoOE2-003HC8-0l;
	Thu, 05 Oct 2023 13:17:10 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoODw-003H3r-0p
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 13:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696511824; x=1728047824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQGt0n5D7SP1i4kXyMIPUS/joI3SOgsexxI/o9/iCB0=;
  b=ER8FQPRt78Cbxnn9UprTxIX4f8V7Ps/J6teq3bv44ypy+UFvJi7+BkAC
   63jwe+992fR1HGR5oUEEmXUa8unVxkKRt5EWV7WNVMckbwRLsfdZTRFT6
   cgxfyc6QutxWSJJg9F65bOpQ6Rqt8rVOMal+Loanwx/Mnz5IBDLiumkgU
   r0+z956UWsHPkfJVce7EywEio9snGsDqwhxZ8gD6lQ2FyabZt6mAWfi8M
   KYlUCYMf2h1xykoV1aFrlRbP6OAKOwClBuoBcZTMbmA3+uu55mlzxRqOF
   GAXPLCKSICbO06kp3hod4INuq7tbtHA+9P/HWzz+oRinTgfIbfXHUCAkS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382357600"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382357600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817564325"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817564325"
Received: from skwasnia-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5CDA710A152; Thu,  5 Oct 2023 16:14:14 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 08/13] KVM: x86: Add config option to gate emergency virt callback support
Date: Thu,  5 Oct 2023 16:13:57 +0300
Message-ID: <20231005131402.14611-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_061704_487717_075517F2 
X-CRM114-Status: GOOD (  13.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

KVM uses emergency virt call back to shutdown virtualization extension
during crash, so the crash kernel can work correctly.

So far the virt callback is only supported if KVM_INTEL or KVM_AMD is
enabled. TDX guest has similar needs.

Add a config option to gate virt emergency callback support.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/reboot.h | 4 ++--
 arch/x86/kernel/reboot.c      | 4 ++--
 arch/x86/kvm/Kconfig          | 5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 6536873f8fc0..f72bdd4abbe8 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,14 +25,14 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
-#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
+#ifdef CONFIG_EMERGENCY_VIRT_CALLBACK
 typedef void (cpu_emergency_virt_cb)(void);
 void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_disable_virtualization(void);
 #else
 static inline void cpu_emergency_disable_virtualization(void) {}
-#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
+#endif /* CONFIG_EMERGENCY_VIRT_CALLBACK */
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 830425e6d38e..6a781f2f11c8 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -529,7 +529,7 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
+#ifdef CONFIG_EMERGENCY_VIRT_CALLBACK
 /* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
@@ -599,7 +599,7 @@ static void emergency_reboot_disable_virtualization(void)
 }
 #else
 static void emergency_reboot_disable_virtualization(void) { }
-#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
+#endif /* CONFIG_EMERGENCY_VIRT_CALLBACK */
 
 void __attribute__((weak)) mach_reboot_fixups(void)
 {
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ed90f148140d..7df3f0c45cfe 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -80,6 +80,7 @@ config KVM_WERROR
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
+	select EMERGENCY_VIRT_CALLBACK
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
@@ -102,6 +103,7 @@ config X86_SGX_KVM
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
+	select EMERGENCY_VIRT_CALLBACK
 	help
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
@@ -155,3 +157,6 @@ config KVM_EXTERNAL_WRITE_TRACKING
 	bool
 
 endif # VIRTUALIZATION
+
+config EMERGENCY_VIRT_CALLBACK
+	bool
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
