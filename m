Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB44C47072
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSKD6liL0lktNMZXDK8yCQuzA68/hkthkDP93CjVNqI=; b=zV8ZdBJUQewEX8
	S9Pb2c43VZl0yNCMHvhjuSK4QEJW4Wcaq5mhCjUasMI0S+cgun8e2RfnYu7UD9V/QEq0qfcG2hG7x
	e+EZLzNhwCinZsj9buaeAr7UH6eJZ+LeRbaIA5VATGnMRto7WM/FVifUGAHce08ewOSA70cZVgYEU
	BnssW86JOqHARwiN4gGuGA7zYXngcPNEUJINI3uP6B38JgPTWbtA1AmQ3KDtO5E1lHcvyMj+U9m2X
	kFTvN1AMsUrU73x8RTqRtr+mJM2U9WK52pcSmlYyKnwd2tMQoQ7IvJadg5vl7I3IBQ27SkkYEt1Hv
	pQoWlBe0ArOe1gsPuP3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJq-00731e-2c;
	Fri, 22 Dec 2023 23:52:42 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJi-0072mS-1x
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 23:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289154; x=1734825154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RhnEAsovR1/on/ST7snqUo3geUenPPWRU+fc0vbg0rk=;
  b=f5zLPZxeGi1IXxIHxFzEnp5ECL1p+XeXIkioFR6AwiDbpBL/f6a5tjO0
   LbjNq51YlboaONN0n2d/0qDzKHNErujlGB7bvJPNXFbwPs/plzegQ73T/
   YjOwks/y0BzS8HUC+yaZvfSDMylEKAD/h+SrKwAovVTe8DhmP8bRysBMg
   OEvET6Au7B8bCWLlaz5yWNNR2J7J5k3MG25Ojjb+yK7ihfIdkqw9BpbH1
   2xtYgjHzsJLqrIguG/n1Yp+QYPqOhghcrvff42RJBB0bCS5pDif+r/jMr
   u5tjpv49ERauuzoBV2CM4Y/Ze5OgpC5ijc9BV/z1exn8FiZep1ZCKFRnG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395063350"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395063350"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="900623014"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="900623014"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.35.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:22 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 69FCD10A4E0; Sat, 23 Dec 2023 02:52:12 +0300 (+03)
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
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Sat, 23 Dec 2023 02:52:06 +0300
Message-ID: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_155234_699412_C5A83421 
X-CRM114-Status: GOOD (  14.74  )
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

If the helper is defined, it is called instead of halt() to stop the CPU
at the end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able
to wake it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/process.c  | 20 +++++++++++++-------
 arch/x86/kernel/reboot.c   | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..390d53fd34f9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..65c7971defd2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,13 +835,19 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
-	for (;;) {
-		/*
-		 * Use native_halt() so that memory contents don't change
-		 * (stack usage and variables) after possibly issuing the
-		 * native_wbinvd() above.
-		 */
-		native_halt();
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	} else {
+
+		for (;;) {
+			/*
+			 * Use native_halt() so that memory contents don't
+			 * change (stack usage and variables) after possibly
+			 * issuing the native_wbinvd() above.
+			 */
+			native_halt();
+		}
 	}
 }
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 16dde83df49a..738b3e810196 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -881,10 +881,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
-	/* Assume hlt works */
-	halt();
-	for (;;)
-		cpu_relax();
+
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+	} else {
+		halt();
+		for (;;)
+			cpu_relax();
+	}
 
 	return NMI_HANDLED;
 }
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
