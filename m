Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BF4C77B76
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dnsPRwOSqUUk+/7FIJpPRCA94KiwYmhf7RTxUpIoMNI=; b=B4QSjh4yboZi8t
	5ZCI8Cj5U4tbx1aPze1d/uhk8CRxs7Qprp0XEKWzQtx8bWErBVqxaUxIiNlP0+wFu5PppLnKCIrnG
	xvEBBUE8jibIMRWk4y94QOkQJ34a1nuv/hxwJaKIXz8srWUeQBZ4s5D2/nlAso35bBrFsaNuKj4IP
	nWk7LAQAB69si6CMUGDfs5x9AqvY2uKMVJBBnseo9eFNJG9cl7RAVywJKfJBZUM4oikKVPRYWhQVK
	XSTHzNjFCCmRXnbKJYWoDb4c5TsJzMhD/+RqHziQ2+BLP2ItDHsL1Cm5vdgFBg42GIftaqXFxRb9u
	+2xQWVej9Cuy/CSXTPrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poldC-002J5v-0g;
	Tue, 18 Apr 2023 13:44:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pold9-002J4c-0y
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 13:44:24 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDgC5r016772;
	Tue, 18 Apr 2023 13:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SxD4DHyfapu38S/pfPZj82NR2pRsC45c+glWfwy19i0=;
 b=jsQ0WgnsZDgshguk54ppm2VFX33zHYxMHH6iSQcBC9sJJEUyre/5kgBEFHkXwENDMDwe
 oOdUE13uTOC8tx/IrfiYc/2mYFa5CmwtlTVA0/SXDTpl5eCa1GpL28BDau0Bsn031d8o
 BQFnhD1Ytzhg78LQB/P3Lj2MeBCTVmYePXXsvQc1twEAyoRDGFbgDqjlo4L1BcJ0WNQY
 R8yY8Kq6EE1WXhaV/q6s+iCgz5Bve8OdIrtZIylw6v74+SkTzxbL5NmB6im9k0/fzRS6
 aykKZy2tJfLhhd2K5yn/+StWNSHf7rjweRyxTvYzfsEY433W6zXPKkhJJWYwfv4twKJ0 fA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pww294p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:16 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ID321E029453;
	Tue, 18 Apr 2023 13:44:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
	by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pykj7dct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IDiDpV47907224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Apr 2023 13:44:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2753F58063;
	Tue, 18 Apr 2023 13:44:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6EF58055;
	Tue, 18 Apr 2023 13:44:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Apr 2023 13:44:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Palmer Dabbelt <palmer@rivosinc.com>, Rob Herring <robh@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v9 1/4] drivers: of: kexec ima: Support 32-bit platforms
Date: Tue, 18 Apr 2023 09:44:06 -0400
Message-Id: <20230418134409.177485-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418134409.177485-1-stefanb@linux.ibm.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nSgQdJ3J38SBpT4xcRMRzP8gtAHBm_No
X-Proofpoint-ORIG-GUID: nSgQdJ3J38SBpT4xcRMRzP8gtAHBm_No
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_064423_344643_5D85E298 
X-CRM114-Status: GOOD (  18.03  )
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

From: Palmer Dabbelt <palmer@rivosinc.com>

RISC-V recently added kexec_file() support, which uses enables kexec
IMA.  We're the first 32-bit platform to support this, so we found a
build bug.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f26d2ba8a371..1373d7e0a9b3 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -250,8 +250,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
+		 &image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
