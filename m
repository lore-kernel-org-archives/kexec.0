Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54B7C3DA6E
	for <kexec@archiver.kernel.org>; Mon, 25 Dec 2023 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1aC6AtzZb2jTauLHhavxe2ShAx0ZAeafWIQSyCnJdck=; b=KfhNdJ3nWqIi1d
	jWo8DXTD+np/kfm+P4/NhZyLfa2AVvJSiaq65efUrBpCm501NLKJwhDEqt+bMbBqhkk+ZO6Lt0lpB
	isTGbWBsQ03FB1+WrrWLldLW8IgXqnLKzWp5D07IdSDAbZd25XVQLTA46YOV9M8BMbCdE2mcmXdSQ
	r99wkqHp2NIGJyNdtE9alWI8yCE+LiCm2p1b1i/76wReH7dxozBMT+jS9ejuoC35DceJjaqBlKDrp
	9Tjdk16+hqH5zFTF8+AfIqiSx4nnoN5r1Fa34LfW+RhoqGfbmO2qhXluP4jbaTZsnwxhqutLKKxZg
	7iBtcybmuyFm2Ev15EfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHfzC-00ANU9-1U;
	Mon, 25 Dec 2023 08:06:54 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHfz9-00ANTn-1O
	for kexec@lists.infradead.org;
	Mon, 25 Dec 2023 08:06:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703491611; x=1735027611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbhL8XxPds8sXmlf1stkNedv8XeK9UzxN+klgJ58pBg=;
  b=RJWsDi+t1FAn2HMYLa9zdp9dAWvmbFbgSY3+I1xirbIzKAsioT8hz6du
   YkjLHlH30CccoCrYQ6XBgKp6XBZnHZ1u73bXGPjL010JSqQBZT3401aXz
   Qfkeqqh2+VpYZpsxwNMSObbvcq66giRmsORhlb37ZWPlmwnORUvm50OAS
   /IAdK8YMGMA0rRviZRDTnwo2TKZTk0ujhkQ9RE9j98qzfs/831xke6qwi
   mQTwR8AzxXDzHGf2BsB4w35bkAGp2+9FmZYRVlchy6F0kvnZZJk3vJS1p
   M7K8w4iudxulzT5qYSSQ/G60UKIhrWgVshf3SBUzXkG6iiXGroJr5hKXr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399059649"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="399059649"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727474524"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="727474524"
Received: from flombard-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.50.77])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:05:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B7BB1109970; Mon, 25 Dec 2023 11:05:27 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: kirill.shutemov@linux.intel.com
Cc: adrian.hunter@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	elena.reshetova@intel.com,
	jun.nakajima@intel.com,
	kai.huang@intel.com,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	x86@kernel.org
Subject: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Mon, 25 Dec 2023 11:05:24 +0300
Message-ID: <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_000651_575740_E8830433 
X-CRM114-Status: GOOD (  13.83  )
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

 v5.1:
   - Fix build for !SMP;

---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/process.c  |  7 +++++++
 arch/x86/kernel/reboot.c   | 12 ++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

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
index b6f4e8399fca..ea4c812c7bf3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+#ifdef CONFIG_SMP
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+#endif
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
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
