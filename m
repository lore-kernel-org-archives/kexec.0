Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8017DD5B874
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtnKmjWFK9d0fuXFQyjZVsu8W5ckdGS7kancwFSdeQ0=; b=PpyekHyK5QYG1l22QIIy4nYX6S
	t4fddkmYX2yOe46HN0k7+hPgF8/qIOulKuoIVNXRA/UL2bvSvKMvgC5ocRotyJfkVEgFjVtKMQzuX
	/npgqlfn6Q+orqD1XlZxMMaFlzdlaVcmoqDs9Br1/MyceLA4qGTjRBPtphfMvzC/Q745s/aKs/Rvq
	J5+44YFl0QTDuTElDjhR1dOlaIAPiPcgKeETHIghZi7cabj5KKFS0dVfrRxU4hVMvyRE7bYKydAxK
	HP1w7Qa/xgcvyokC6mH4KHONiqkMPXu9yulcyDwhUUV/492+JnHifsQ6Kl1WH8/DZrer4tTigJ/ZB
	Y+1WHOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBq-00000004Pe0-3v1o;
	Mon, 15 Dec 2025 23:41:18 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBk-00000004PcK-3op6
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 23:41:18 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCIiX2859372;
	Mon, 15 Dec 2025 23:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CtnKm
	jWFK9d0fuXFQyjZVsu8W5ckdGS7kancwFSdeQ0=; b=iWmZQ5wO4j6rj17QtiXfN
	fAosH/HMC5jypzQBOiEPUKY/JCcN+bRWKVsFmqjMvh87XbHuNaF/mhpTu5w8v7it
	Jlmdpo/kp2Ag0jCyuEtBB6DidA+so42p6W/7czbfXPboHdOM2fpCS2qfNL513AYH
	IlAUbvlpEZVw3dyKaQC+LvrBBFcR07j1Kem/NV9vi0i4YJHK4pDX3Il8zbfkYFKn
	2KWTOhVPxCvTUURqYeJx53cZe16AkPJwHA53CnoyaV6tGY9ggUnNMTmALDrJLlLC
	dk2MHK2B4NRALlEQfdhRhbNxtAHI0Y1kdr9VLtQhQjRscyzjj6tnPwQebIXCsVSI
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrujyxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMP3ui024537;
	Mon, 15 Dec 2025 23:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t8av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeaGf028457;
	Mon, 15 Dec 2025 23:40:36 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t89j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:36 +0000
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
Subject: [PATCH v15 11/28] tpm/sysfs: Show locality used by kernel
Date: Mon, 15 Dec 2025 15:32:59 -0800
Message-ID: <20251215233316.1076248-12-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXxUR+wT33/7GF
 mJ+1N5qej0hiPUSWQjNM6TKkYUUS2QQ1gFbaJSXjdf95qVkX3QiofJYKyplRfkZ1qGnltXVUhc8
 Ax86NJl5CWj8tCnXWdKX4B8bRHNDjP9p1YkdjZZmiH7MlKEyaQ3vFv7Ofxvvg2uxe0Xd/Qmjag6
 W+WsjSQqYBSy5xAF4Lq1RfJ2DVzDe/wXYVcg1QIVMManf7HuPgFH/WyA/1XZc5/cZY67FW3VK+l
 VDssQcExeL2oqBHtOU8i4CkSAwf9PFQHnhNKaTEL4jCA0G2D1VEoGoRu92PWXJwhvbOVB0bx76K
 ZivHsrpV5peM8g/BH4b3kAvSWh9qGQfZKnRw1u0swlrpFf1fsvUdWu0ux0vohilZrvEvWLddrHy
 2nX35etVWcH+VOPvGGiO+nDBPC4D1Q==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=69409c76 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=l4rzuocJ5qbfFBX_5RcA:9
X-Proofpoint-GUID: c-MKPKc_BhmYTE9HgVmHCstNqx3smh1Q
X-Proofpoint-ORIG-GUID: c-MKPKc_BhmYTE9HgVmHCstNqx3smh1Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_154117_004873_0285CD4E 
X-CRM114-Status: GOOD (  11.31  )
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

Expose the current locality used by the kernel TPM driver via
the sysfs interface.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 530037a3f4ba..375d487565c4 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%u\n", chip->kernel_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.43.7


