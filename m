Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5E7C77B76
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xpjl7hN1yP3q66ePXSLaDeNPmw1KolVJ00Abj3VLKMU=; b=PUHMhvNzHWHHKV
	/6un1xPKjsuQQvYYa2lgCjtToPF+83qmuqABCfRTkttjwAPre9fFUI0/6spjpkH179F3GiGLaUuDD
	xiFf8RA7a0AMzcVJg+gssA4XHIByMgT1jJi7Bv9nRBiJ5cgZE5vqD1fIW/iWpVmT9FALT3HuOvWGK
	r95tnyOpHGz+aqRRqkFAjq4UkMxGu3vJTfLsLHEITFgtQXDdx4S2QSEXYNNwyFL7gNtaKaC7HwaC6
	d8rFVzw1S/gei1iGqiEI9SWISJ4iNXxguJsRRhIAMM8YoPMd/ic2XVm92SWKNAeHnTT3OzNVBT9a1
	ySUIEOO6sAT4JCrdhJKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poldJ-002J8y-27;
	Tue, 18 Apr 2023 13:44:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poldF-002J6y-39
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 13:44:31 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDQEB5014851;
	Tue, 18 Apr 2023 13:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TEGBONkyuog+F35viyuYWUr10yzGVlxA8iH4QwsmVSU=;
 b=QsYDnL4lS3xM5aT8KiHJbr7kZOK1ahu1Y7J00QkOimGxoPN2GKRL6vr7K0ubEJeMSx2O
 nyqlOQIPaSIR55ZeeZ6p/nVHMuU+i1HBkeJ36vLadtvATdVxTpFDIugeZmVj0MNwudtR
 4lIZ79fXWbnxxh4fUyRNZQXaIYN7gszfl7Fdd1IbvXPbfuvpa+YIhO5gvumL/yIvFTh0
 rgX7qAmaVEzvrbiiAs0pKTGMwXaJQ8PYEBEmgHZoXzs84vBro2ISdfBWWwy4FL9k1aSE
 fbkPsE+H2yPCUAvzpX7KQYpTeozCJUC54+9nSZCFlm4EY/GYl+J5BV+7kNSVjKpKz8e3 xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q529xx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33ICK4CU026346;
	Tue, 18 Apr 2023 13:44:17 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q529xwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:17 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ID0C8J003732;
	Tue, 18 Apr 2023 13:44:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pykj7weej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IDiEDE33620586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Apr 2023 13:44:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3EF058063;
	Tue, 18 Apr 2023 13:44:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F86958066;
	Tue, 18 Apr 2023 13:44:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Apr 2023 13:44:13 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
Subject: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly available
Date: Tue, 18 Apr 2023 09:44:07 -0400
Message-Id: <20230418134409.177485-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418134409.177485-1-stefanb@linux.ibm.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i92gmyUBa8RFw3E1tvHzitilikJ19_tg
X-Proofpoint-ORIG-GUID: BumNmB7KdGlnfVAk3Q2It202VDnZXF5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_064430_133987_22A32B5E 
X-CRM114-Status: GOOD (  25.99  )
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

Simplify tpm_read_log_of() by moving reusable parts of the code into
an inline function that makes it commonly available so it can be
used also for kexec support. Call the new of_tpm_get_sml_parameters()
function from the TPM Open Firmware driver.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Tested-by: Coiby Xu <coxu@redhat.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v9:
 - Rebased on 6.3-rc7; call tpm_read_log_memory_region if -ENODEV returned

v7:
 - Added original comment back into inlined function

v4:
 - converted to inline function
---
 drivers/char/tpm/eventlog/of.c | 30 +++++-----------------------
 include/linux/tpm.h            | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 930fe43d5daf..41688d9cbd3b 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -51,11 +51,10 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
-	const u32 *sizep;
-	const u64 *basep;
 	struct tpm_bios_log *log;
 	u32 size;
 	u64 base;
+	int ret;
 
 	log = &chip->log;
 	if (chip->dev.parent && chip->dev.parent->of_node)
@@ -66,30 +65,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	if (of_property_read_bool(np, "powered-while-suspended"))
 		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
 
-	sizep = of_get_property(np, "linux,sml-size", NULL);
-	basep = of_get_property(np, "linux,sml-base", NULL);
-	if (sizep == NULL && basep == NULL)
+	ret = of_tpm_get_sml_parameters(np, &base, &size);
+	if (ret == -ENODEV)
 		return tpm_read_log_memory_region(chip);
-	if (sizep == NULL || basep == NULL)
-		return -EIO;
-
-	/*
-	 * For both vtpm/tpm, firmware has log addr and log size in big
-	 * endian format. But in case of vtpm, there is a method called
-	 * sml-handover which is run during kernel init even before
-	 * device tree is setup. This sml-handover function takes care
-	 * of endianness and writes to sml-base and sml-size in little
-	 * endian format. For this reason, vtpm doesn't need conversion
-	 * but physical tpm needs the conversion.
-	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
-	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
-		size = be32_to_cpup((__force __be32 *)sizep);
-		base = be64_to_cpup((__force __be64 *)basep);
-	} else {
-		size = *sizep;
-		base = *basep;
-	}
+	if (ret < 0)
+		return ret;
 
 	if (size == 0) {
 		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4dc97b9f65fb..dd9a376a1dbb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -461,4 +461,40 @@ static inline struct tpm_chip *tpm_default_chip(void)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_OF
+static inline int of_tpm_get_sml_parameters(struct device_node *np,
+					    u64 *base, u32 *size)
+{
+	const u32 *sizep;
+	const u64 *basep;
+
+	sizep = of_get_property(np, "linux,sml-size", NULL);
+	basep = of_get_property(np, "linux,sml-base", NULL);
+	if (sizep == NULL && basep == NULL)
+		return -ENODEV;
+	if (sizep == NULL || basep == NULL)
+		return -EIO;
+
+	/*
+	 * For both vtpm/tpm, firmware has log addr and log size in big
+	 * endian format. But in case of vtpm, there is a method called
+	 * sml-handover which is run during kernel init even before
+	 * device tree is setup. This sml-handover function takes care
+	 * of endianness and writes to sml-base and sml-size in little
+	 * endian format. For this reason, vtpm doesn't need conversion
+	 * but physical tpm needs the conversion.
+	 */
+	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
+	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
+		*size = be32_to_cpup((__force __be32 *)sizep);
+		*base = be64_to_cpup((__force __be64 *)basep);
+	} else {
+		*size = *sizep;
+		*base = *basep;
+	}
+	return 0;
+}
+#endif
+
 #endif
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
