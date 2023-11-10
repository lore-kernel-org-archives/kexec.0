Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2588EC074FD
	for <kexec@archiver.kernel.org>; Fri, 10 Nov 2023 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J+eJ6zQDJoHjVMIiMLcCcu63ni5XJbPvtIehAwT/HbI=; b=DTxWm6zzUcsc7z
	kQzZZL4ms9nIx16tJdCCyzkb483jACL0RlOvzMRKFN9Vx8IcQ79t5VZ7JtPLArqiG3/qQxHYHz6k3
	0JFetKs093Z6+xHuLHzB3vxE3ezd8kzyakhi/PaDd9fsmWfjDafwZpHOx3SkPPI2egYNE5QzB6DeV
	xCWsYpc2mS5Rdq2fH5Thb+BUQFCsrs8dj99o/TmguA3EswTPMKFgST23SBY/TPzrYdjScQEQbo77t
	m//DkmN88iFtDZch6ml5PBbuZE1Atcl99GhysxtlBEMukk5DiHaA9SgSsq8NCgDffHqQZmKTriLMS
	vyHFAYcyQ5V8SFj3kBQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1ZzQ-009YUx-2c;
	Fri, 10 Nov 2023 22:28:36 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1ZzJ-009YRY-2J
	for kexec@lists.infradead.org;
	Fri, 10 Nov 2023 22:28:33 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiIst020588;
	Fri, 10 Nov 2023 22:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=GKauPTtNdSk3fkzWv10kdNJl8kVDWJLiFM0GZ5EYFVs=;
 b=ccsZ1ZwdERjPOTms27WSUyLPwC3u2weuulczZ9YCnwNnhjeslyOAFjGJ6a2QGDFccWqy
 kb4Qedsf7Z7uvw7avVNdgXQ/R1bsvwmhYF2pllLMaA5nI7M95OCIUicdpforwMMeErIZ
 hXZNTlk0d+lBB//sgnQT5sq1uwMwccOcrWcMFGTmEpCuVInhSBtOCANTJRn2eQZt699H
 irj2EVTR2EVII+5gcde9sQGeW+julk8fjmVPYfjnOjafW7Y9NSDIa13ik1bN3r8QQUAm
 Na2nc1Ofjm+qwc7UD8p8VVfqxglIHE+XPPUbdwwPBmc8gXPF0FV2S3IrbTmq95Vu9UiD Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23pysd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 22:28:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAK53Y6023844;
	Fri, 10 Nov 2023 22:28:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nb42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:28:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAMRsaO039112;
	Fri, 10 Nov 2023 22:28:07 GMT
Received: from ovs113.us.oracle.com (ovs113.us.oracle.com [10.149.224.213])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nayh-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:28:06 +0000
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
Subject: [PATCH v7 13/13] tpm: Allow locality 2 to be set when initializing the TPM for Secure Launch
Date: Fri, 10 Nov 2023 17:27:51 -0500
Message-Id: <20231110222751.219836-14-ross.philipson@oracle.com>
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
X-Proofpoint-GUID: EU4eaKX42DB7eE9dHiylfHKU3qY5XorR
X-Proofpoint-ORIG-GUID: EU4eaKX42DB7eE9dHiylfHKU3qY5XorR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_142829_758235_5FCBB177 
X-CRM114-Status: GOOD (  17.89  )
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

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..0217ceb96c42 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -39,12 +40,18 @@ dev_t tpm_devt;
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
+	int locality;
 	int rc;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		locality = 2;
+	else
+		locality = 0;
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
