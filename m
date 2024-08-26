Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B5EC5472C
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VjRTEv19Nw9oRmpaqgyoptZ5Jx33AUMPYoY9ov0kgIE=; b=gQ6ZiGsc0olbrv
	mtBu0gRxKjmwfKFZWpM+Tu7AUyDDxG4ptVsdG9PCf7wh7ZFPOScDsleCHZiH9hiGD2CsJYwOllTNW
	B5H9zCU4m88LMYg2bWF9pwCkEiC4tjo/sutpNptMSEretztd/FYyPUWn9LtyHHD2xGevgfWc9K7Fr
	e/2xrr72GUyjQ5YR37Vg6UsbF6m+W7hXucCGuPSFt2ehjVLUCUb+uHBDvPzxcmrDoBlTAYgrGhLro
	pZM4OG5fyscZ2p6o0E/YYIPhH910wT9AIJkACjwXxbwTOab1/FQZah00dKSx9BqO26Whq6Ba5DgfF
	/3rAqQEl6Ztix9dbVlXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siiQd-000000092Pa-2tKp;
	Mon, 26 Aug 2024 22:43:15 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siiQb-000000092O7-09MN
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 22:43:14 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtSVB007322;
	Mon, 26 Aug 2024 22:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=M
	XgmmaviLmfB89S+Rd6hUvTBFXvOuB0Ph1w3Sl4lhCw=; b=JN+eZ8ibA+MKe6VUw
	XEhea/22j6bfcpl5+1j573JHGZ3uVGNf5DUlA0Yi9bCKn7F0YGPEzojdrMCnlZTg
	2rjV+a6AQ+kj/boaENjnIy5wa8w3q/YCKgbgWVPmhF9Jl5n79T7MO4j31jzn91C8
	Qkor6ScuoKOcjUhTOv+CnuhUrM98wDIDo1uhRv+9s0lSuUV5IijmEcJ06cI9jieD
	LY0EezTMgQXoQtguQAwfP2Ry2YcKdmS0bUKTss+UDwll4fdMR33V63N3kNT60BiC
	PjGLOawgibUzD7r1bDdly7cYKhfUDASO0JNherIiiSxPYxZ+UG+Bfhaz0cpsknXk
	t5+dA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6mbe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 22:42:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QMZnqq017403;
	Mon, 26 Aug 2024 22:42:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5rmq42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:42:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QMgmvk028240;
	Mon, 26 Aug 2024 22:42:48 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5rmq2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:42:48 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v10 12/20] kexec: Secure Launch kexec SEXIT support
Date: Mon, 26 Aug 2024 15:38:27 -0700
Message-Id: <20240826223835.3928819-13-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240826223835.3928819-1-ross.philipson@oracle.com>
References: <20240826223835.3928819-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_16,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260174
X-Proofpoint-ORIG-GUID: 1ZNM1CxHqYKkTtVQqpgJKf1CFE9A_Nj2
X-Proofpoint-GUID: 1ZNM1CxHqYKkTtVQqpgJKf1CFE9A_Nj2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_154313_242706_423D2D2F 
X-CRM114-Status: GOOD (  18.16  )
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

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 72 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 76 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 9fbe96d1ec71..d9be68325ae1 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -522,3 +522,75 @@ void __init slaunch_setup_txt(void)
 
 	pr_info("Intel TXT setup complete\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile ("getsec\n"
+		      : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+/*
+ * Used during kexec and on reboot paths to finalize the TXT state
+ * and do an SEXIT exiting the DRTM and disabling SMX mode.
+ */
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
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
+	 * Calls to iounmap are not being done because of the state of the
+	 * system this late in the kexec process. Local IRQs are disabled and
+	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
+	 * thse mappings is not an issue since the next kernel is going to
+	 * completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("Error TXT SEXIT must be called on CPU 0\n");
+
+	/* In case SMX mode was disabled, enable it for SEXIT */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..53d5ae8326a3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1045,6 +1046,9 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/* Finalize TXT registers and do SEXIT */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
