Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19814CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=; b=Ine2bhOKQtw81MeE/jNsQEsxCm
	t+RJV3vGy1IVHouyAIcGTo6B2ECJ9May5xbrLb3Hou6jmLwzY16UVMs6Ls5HFKFpBKA+MCo7RiNm8
	9nY3mW5tR7gogPXYZPg9tPqec0v1oxpFbzVH4CmOpI1ZqT+pXt8+YTwYJeXJLwuJgeY7k3IjpfmaG
	+89/zkCX0PQMFx3/TrvG7k98EjWmrYspmbm6To2fZT7xBaxyQ4eq6QoqoIQUiaMuil0NH002GUkcg
	b6XyLFnApYJxmaA9bVnLPoeGHZjo2Jz9mmgBTJW7Lw58wFDRDF+0NxXbZPZsmpneXhzvq+1rTchPk
	3Ablh0PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsw-00000009UJR-3Ro6;
	Fri, 15 May 2026 21:15:54 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzss-00000009UFp-1dNP
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:53 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2f3c623322bso1046749eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879750; x=1779484550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=lT6mfF14gLxvFnQRKOnxtbNJK5XYMVEoG+3i+RXgVrCIlw1M/NSpJ4uf7cnkuNb6nv
         dxGcZ4X3qNRzr/dF7q7FSOR6a6MGlzWucdvdpfvNb13eW2P9pwjYzvUfuJFWT6g896ZR
         kC9dEJClUlmmFRi2b+j1I+V7nMxRDLi8g7FvB93kL/pW/FIayFrkUFioyKRHyWEIbHTd
         2kHyb3SjCv5euJwVsT8uiRQuOAdWxt3NyuE38p76RozUHnhQpVYlkvd99Td/Qqn5vd6I
         QuJFN3w5Y9ZH4dJGaPQz6/RXER3fpDd2rFQdvLafnofoLvd1McvVf/5iRf79STABSFZ3
         SZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879750; x=1779484550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=PFtDBr0Jq0PpTTo2L/57/J2ZYwm3eV6gZTalokY/HOv8ECae3lSnmnDKH0oC0p5VIb
         S3JRl80Zwuyvr3vYEhGYTssyH/OrZJQP4x083/M7YpPUIMbtFthR/ua0LjFzTrbB9/1w
         uHdxW8BQA7xAzHMeMWtGYGxUzUP0xov+F4mYY6G/v+lxW5vmYwA59YDmNEG1ZEvz5yt2
         DqZ+90ve27vweDZ7u72OtwR/KgMr4zFROp90lDhkXixnXV2iUywxAskCuuL2uCwBt4oN
         nqhGe6NEzlNaE/i6ZpbKV63U3+Haf3+nEq50F0rQxjjaSmkh6HM2EOaN7dlmTVY5H2i9
         B1NA==
X-Forwarded-Encrypted: i=1; AFNElJ+nnTZkMk3douSp2sle13ds4N8rzBgw9Z1NfTvQDsf2auVTGRVYyjzE0rl4SRSNX02Z9Bt5Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNY4OJ+7+F2Yf0KQC2nu8gYwdoQoH/5iV0iltoPbQB83Qckb7c
	1+bq3raz96PzFgX6z6E0Wm8hyWDeW0iRXbPszsFJiWImqypyrsXQIfe6
X-Gm-Gg: Acq92OHqFh+bIRTnKPtidyOjhinY9MDXIjjj+1VYJjaQPsoJU7wxPyq/D9z3FBHTYzN
	lSs1o3/3i3i6U7uzOkwSTBF9DtJxXowbDI3SBO3CEjFjnINI7plTxGrHHPLXg3cK70vPdefZXD6
	eFRC0l3cDgSxa0NBysRlMA7IfULjFiwMF6fPIdP4WEF0/BbYjPGthw/q8SFCD49myQbPvTWdFen
	ds6iU9bVzlloX8YLk6b9t/jiYBCJ+OFX6wjCz8+dc+Lsn16pOfzZNHQ93hu2pJF1T6DKRBMsahK
	YoRAwpceG+b5Q2wxGTWecIrSRvaWVMJvvBj86Kp5Pv4T9TEpAdFwpNh4ihiGerZFngYXzvBYQ3T
	SYLiBnxNVhtqVEF3hABYPx0AHsqWEagKScCJuCT7FtP79K2X0jbHVzEOAcBxoS2QS7ONd24kgxe
	Ga7mdz/TY0N+p4vegC6a9EhqYYyeD+sxs=
X-Received: by 2002:a05:7300:3252:b0:2ea:5057:a31d with SMTP id 5a478bee46e88-3039818a864mr3228730eec.1.1778879749634;
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9461192eec.5.2026.05.15.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 34/38] kexec/slaunch: Secure Launch kexec SEXIT support
Date: Fri, 15 May 2026 14:14:06 -0700
Message-ID: <20260515211410.31440-35-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141550_437696_04A6D3D2 
X-CRM114-Status: GOOD (  21.88  )
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

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally, effectively exiting the DRTM
environment.

The function slaunch_finalize() takes a boolean argument that controls
whether a GETSEC[SEXIT] can be issued. When true, the finalize code can
completely shutdown and exit the DRTM. This allows another kernel to
start normally and in turn can re-establish another DRTM session.

In cases where the machine has not been fully shutdown (e.g. when
machine_shutdown() was not called), the SEXIT step cannot be done
(SEXIT will fail if other processors are busy). In these cases SEXIT
is not attempted. This normally occurs on power off or reboot
operations where it doesn't really matter.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/slaunch.c | 80 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  8 ++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index f6e6f1b7e18c..b34997a5f541 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -537,3 +537,83 @@ void __init slaunch_fixup_ap_wake_vector(void)
 
 	pr_info("TXT AP startup vector address updated\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile ("getsec\n" : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+/*
+ * Used during kexec and on reboot paths to finalize the TXT state
+ * and do an SEXIT SMX operation, exiting the DRTM and disabling SMX mode.
+ */
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT private registers\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are skipped due to the system state this late in the
+	 * kexec process. Local IRQs are disabled and iounmap causes a TLB flush
+	 * which in turn causes a warning. Leaving these mappings is not an issue
+	 * since the next kernel is going to completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT public registers\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	/*
+	 * Mostly finalized but the system is still in SMX mode. At this point if the
+	 * system has been quiesced, the APs are halted and the current process is
+	 * running on the BSP, a final GETSEC(SEXIT) can be done exiting DRTM/SMX mode.
+	 * This cannot be done on certain boot paths where the system has not been quiesced
+	 * (e.g. where machine_shutdown() has not been called).
+	 */
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("TXT: SEXIT must be called on CPU 0\n");
+
+	/*
+	 * In case SMX mode was disabled, enable it for SEXIT. Clearing the bit
+	 * anytime during DRTM operation will not have an affect until the next
+	 * GETSEC() op is performed.
+	 */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2fea396d29b9..dd284e5043ab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -43,6 +43,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1201,6 +1202,13 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/*
+		 * If a Secure Launch is in progress and the current kernel is
+		 * running as a DRTM with TXT, finalize the Secure Launch state
+		 * and do the GETSEC(SEXIT) returning from SMX mode to do the KEXEC.
+		 */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
2.47.3


