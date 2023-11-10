Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0357BC4167B
	for <kexec@archiver.kernel.org>; Fri, 10 Nov 2023 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d2wf/JswCxIOnE5sllMbHJ2DhoRW3SaxPbO6pVg9clg=; b=S6HZcoc7rfGtEH
	QLvb+ZV8DXd/4umRvRhpAoXjZgWYohlCyqhKu72OqPBNYAxgy/ZPwH/zfNQ4K4W43jukhLstx4pKg
	hRDA7Ot7pvlaX30wBvPG78urx85kj5wX+38wOGYe/dy+zuub6PZPKzIO28wInUUlb+xNPHfU0vUfQ
	9KASi6pyGertsO5iCVHpx+dr5UCyVpJBP+j0B0Vo2phowCGMD+nMmzL/PA0lWsLy1Al+CESYxPxPY
	sJUZgPVy02ziJ8WnbhHqKREdpSUqugMRasJJWTb5XmS2G6Hbty3CxGN6XXWHEoFCI+IyDAWKZQ1/g
	ycTphIOkJ6yS56eyh1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1ZzP-009YUf-2U;
	Fri, 10 Nov 2023 22:28:35 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1ZzI-009YQP-2J
	for kexec@lists.infradead.org;
	Fri, 10 Nov 2023 22:28:32 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHicQr030766;
	Fri, 10 Nov 2023 22:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gwoQSTFNy3RtIL8T+foWx21Moncd5kBk5OKc+70Uqks=;
 b=vj0hLftKmTueUFZnT7YbDXUV0ofTsfBjveVC0L+vy9cuqE6YSONESudmQYTsjBO1fpBt
 mAcKxOIQI+k1Lc7iufJsfjmhiOS9QsWXSZg6tWuqBp2cPuKqIyctK5d/1bB2lvBBcuMR
 g33y8j/NtsgSCAVzSug+aa9wbr+8F6O754fv80ZqY8y31OcU5CecewN7Y+HkShjXc1c0
 FPWKBJJMAcbdwLU36mPFpPsPmgNV+GOu/oAI47l0VwVhrPv/S+CuxnlcmTag3HOFrwCd
 Xi4Bu6Vm3i0Es1PodeEn60iTOPm64dtyF+QLSQDLJJDmFizvbcO0xdLoigwV9nrih796 ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23q0v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 22:28:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAK96dw023887;
	Fri, 10 Nov 2023 22:28:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:28:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAMRsaI039112;
	Fri, 10 Nov 2023 22:28:04 GMT
Received: from ovs113.us.oracle.com (ovs113.us.oracle.com [10.149.224.213])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nayh-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:28:04 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v7 10/13] kexec: Secure Launch kexec SEXIT support
Date: Fri, 10 Nov 2023 17:27:48 -0500
Message-Id: <20231110222751.219836-11-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110222751.219836-1-ross.philipson@oracle.com>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_20,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100187
X-Proofpoint-ORIG-GUID: 43ATF9mZ3V2tyDpoBPzgW1Mws0it0kPj
X-Proofpoint-GUID: 43ATF9mZ3V2tyDpoBPzgW1Mws0it0kPj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_142828_773674_B63A7F47 
X-CRM114-Status: GOOD (  22.62  )
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
 arch/x86/kernel/slaunch.c | 73 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 77 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index cd5aa34e395c..32b0c24a6484 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -523,3 +523,76 @@ void __init slaunch_setup_txt(void)
 
 	pr_info("Intel TXT setup complete\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile (".byte 0x0f,0x37\n"
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
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
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
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..98b2db21a952 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1264,6 +1265,9 @@ int kernel_kexec(void)
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
