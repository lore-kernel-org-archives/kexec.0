Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89277CCA481
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+NRlO56li2pSTxW0KW3zo/zWUg1z8Vfyms1OY0GVgw=; b=WQLkyGK7szL5SI
	xTMkCNcbxk8W5vJbehMLjLWTKqAr7RK3LKyqwT/O3GpP1cEBQUKmJJnSXFD7XN+kLK9cp+eXZLkNV
	svFI30VuDYid1Mb8M7DhT2gzOQaslKRHnnJ9EpOMcT/JlRP+ps9lVwbtUX3tn4ZUCvom4VZAL2rje
	Tdt3YTmm7489FNuK9VbXXyGILgy9YIfYlRSukkHUMdZBFMFSnJ6wMmILMG3jbdkCoNk4BxIW3dHiE
	1r8JaAdBCssJEpe9oDgxrQQuOzmkj7qsmUAn/ZQzNxBXrJpb9CASziZrCK9X4H8XdK9CIClSrzKgt
	nXPybjf0WJxxodwzrxhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rd1-003DJx-H4; Thu, 16 Jun 2022 15:41:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rcz-003DIk-5p
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 15:41:50 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GEU8J4029262;
	Thu, 16 Jun 2022 15:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=71qcG4wP4Kp4JAtloKlgtjTjDrTgeIEnFbbT/4u56lk=;
 b=ejU7v8E/XKNUOR7ObHkoExrBr8RcDhWtraueCE5/NPbvORlkB2qoGeNRPetO5BDiFIDG
 b9u4PJ9/E/XhF9A/v4xz7RMhjWQBE3Rfe/EliUivtsIb04++t2yOtY6Y6V60NP7OvmFX
 6+weU9oPyRZ/I9al1CouCFZR6Yhf/S1DO1kDYgSF8QRn2cJ1rJyA3rtP7Huc7ikjWKyT
 6/0nlrFOq/1L9+BW6Ck87JWdItikedFJzT969kcN2vHlfqW/9fgykUZH+EL7T2k7wXTo
 bRDMrl+eSlKkDnNNlrf8XMNyeD3HzqykvfwJDd8qxmgOlmMbota/2XYwc9YBhzX03Z2F SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqbn343s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jun 2022 15:41:35 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25GFUofk004188;
	Thu, 16 Jun 2022 15:41:35 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqbn343rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jun 2022 15:41:35 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25GFZh6v017731;
	Thu, 16 Jun 2022 15:41:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma04dal.us.ibm.com with ESMTP id 3gmjpak9xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jun 2022 15:41:34 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25GFfXnK42271030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jun 2022 15:41:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC75AC059;
	Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23025AC05E;
	Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm driver into of driver
Date: Thu, 16 Jun 2022 11:41:28 -0400
Message-Id: <20220616154130.2052541-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616154130.2052541-1-stefanb@linux.ibm.com>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8_nBKfWYOnMDD4idQ3bXvGXcuxGPA68V
X-Proofpoint-ORIG-GUID: z54LklF32lwVKP7UxvQWC55sAFVKV1ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_12,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_084149_376114_E00783DC 
X-CRM114-Status: GOOD (  29.97  )
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

Simplify tpm_read_log_of() by moving Openfirmware-specific code into
the Openfirmware driver to make the code reusable. Call the new
of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
 drivers/of/Makefile            |  2 +-
 drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
 include/linux/of_device_node.h |  9 +++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 drivers/of/device_node.c
 create mode 100644 include/linux/of_device_node.h

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..5b18f4333ad1 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device_node.h>
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
@@ -20,11 +21,10 @@
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
@@ -35,30 +35,9 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	if (of_property_read_bool(np, "powered-while-suspended"))
 		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
 
-	sizep = of_get_property(np, "linux,sml-size", NULL);
-	basep = of_get_property(np, "linux,sml-base", NULL);
-	if (sizep == NULL && basep == NULL)
-		return -ENODEV;
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
+	ret = of_tpm_get_sml_parameters(np, &base, &size);
+	if (ret < 0)
+		return ret;
 
 	if (size == 0) {
 		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..1c9feac450ad 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y = base.o device.o platform.o property.o
+obj-y = base.o device.o platform.o property.o device_node.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
diff --git a/drivers/of/device_node.c b/drivers/of/device_node.c
new file mode 100644
index 000000000000..71a19bc1bac2
--- /dev/null
+++ b/drivers/of/device_node.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/of_device_node.h>
+
+int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size)
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
+EXPORT_SYMBOL_GPL(of_tpm_get_sml_parameters);
diff --git a/include/linux/of_device_node.h b/include/linux/of_device_node.h
new file mode 100644
index 000000000000..ae3faf023aab
--- /dev/null
+++ b/include/linux/of_device_node.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OF_DEVICE_NODE_H
+#define _LINUX_OF_DEVICE_NODE_H
+
+#include <linux/of.h>
+
+int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size);
+
+#endif /* _LINUX_OF_DEVICE_NODE_H */
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
