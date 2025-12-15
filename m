Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232DDD5B87A
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3El9eEYTPlcBOE49vryR46UAW9F6tGPhJ0Ib36+Xso=; b=3u3Zaeai0lT5QruuSVMpypsUvv
	cybKzlP9LfpewqvEP9MCzoGsjC1PMV7fl0r5pGj9IzY9h1877jOuo/bSVYNo9h+4HkDoEdk9H+hTo
	vC5qZnu9RQPVBTDlHVg112KFNl3CdNrwwD7BM0c0ckUvS1kTi5gjkddx2VK5Bf0Ufe3exBCFj5lyW
	7SJn5E+mS6eqD30HaIkncsShHZdpuwUF5c175uyT5qR9rtFXLN38l2coani3OtpaJXMe4NGtVkj5z
	wsiYIMNGPU98aRvxhoRaXSB2yMcDUTK3Je1Eal6pZnCo/4iuRYXR1b7j/IFm23gWfXplnjGDL7XjL
	xZGyXC/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBX-00000004PVh-35yH;
	Mon, 15 Dec 2025 23:40:59 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBR-00000004PSq-2mrm
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 23:40:56 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCC2E2788589;
	Mon, 15 Dec 2025 23:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=F3El9
	eEYTPlcBOE49vryR46UAW9F6tGPhJ0Ib36+Xso=; b=ShFMYjhmanZWZJTPIgBmB
	e8l7os0Vx1GwayaMjlJF33e91qfHZXqM3PAwxwGPy5lw7yRZxuhbXqyS+QBt6XzI
	M6LBcAycdrVRcSrSihtHBBC8TTGzu8apdx6Kxxv4Ng0G3ldKszHb4uHfKCpz1zuq
	EAS0mQ+gAgv0A6MADyvK7zR8t/y99E2eVE6fMIi+MSLJ0IOZf9Jq0DlL87J6E8D0
	/sn9KxZBv8F3/IST7WhrVy3rphuFJPYB4UpiiucZaJWPZBGRgonbI0W6PvgRFR82
	m8wQI3W1NxYrFyVVLly6hD5SCNVI/R8DGkYd38Eb4065OTepDm76WB5DDnLHaE48
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prk13t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLi3hR005916;
	Mon, 15 Dec 2025 23:40:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck910-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeNDp023641;
	Mon, 15 Dec 2025 23:40:23 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck902-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:23 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
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
Subject: [PATCH v15 08/28] tpm/tpm_tis: Close all localities
Date: Mon, 15 Dec 2025 15:32:56 -0800
Message-ID: <20251215233316.1076248-9-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX9Rg4k9A8kFZE
 XRtmqLNatUdy7Enu+RIzjTLuwwr7AfqbTCSKybW6bsuVSZDUlKL0kY08fEYg7IeDtzYQlZDjvK+
 YF8QxhPlqHrNU5+9FH0bYxpIGoJGVwqo+G0nVjAqhVwrFc9HvYu9/B66oOI0SQ2R5HAUunmzVVr
 sX44tjjYh965W+Ph4odUikD1Q8frKyWCaprVDuEdvT1T3DSM33J+wDWyl6wiMbjCL9yF3nJj90m
 d88vJVTHCwU7ORdjeG9B//MICgIo1bfZY4tVRjFDzS2crBvZ4J6w9JjNKMKZhlLyHClolSEoKry
 FLr+OFW0DYS4neim/07jpP+k+H8UDUQ10XDJgyX253AYVgobZ/c1BbCrFPJb6FUNB38xbJKGGem
 HGIzdPJUymgfeoeQaxmCSCgDTV8tCbHkggyDhOkAfWBADHe0Gj4=
X-Proofpoint-GUID: iZgAcDXqim0EeNPPQtLkaV3X0lQTH5Dj
X-Proofpoint-ORIG-GUID: iZgAcDXqim0EeNPPQtLkaV3X0lQTH5Dj
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69409c6a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=HtIUNwPdcKDEEbHmk8UA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf
 awl=host:12109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_154055_339222_87772D43 
X-CRM114-Status: GOOD (  15.78  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

There are environments, for example, those that comply with the TCG DRTM
specification that requires the TPM to be left in locality 2. Prepare
kernel for such environments by closing all the localities.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 include/linux/tpm.h             |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8954a8660ffc..12a2340dd5e0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1112,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1177,6 +1177,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * In order to comply with the TCG D-RTM specification, relinquish all
+	 * the localities.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4c02076a8c39..87978cc584ee 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -107,6 +107,12 @@ struct tpm_chip_seqops {
  */
 #define TPM2_MAX_CONTEXT_SIZE 4096
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
-- 
2.43.7


