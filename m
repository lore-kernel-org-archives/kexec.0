Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB32C433EF
	for <kexec@archiver.kernel.org>; Tue, 14 Jun 2022 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YtBwiedOWvsffp2+HEeKFk0XHJAfz3cKbNPlw0immds=; b=A5fgDVQ28Dmbsh
	1w4sCEmW6IcrSaORobj71kPKx8oG5o8DsiFLVDSUH+zgBC8Lmk2j8WYTfWii1+x9J6PzqiwQhKjVH
	Y/Ga3ocad0s9ayJM7SXEpB8HrLHd06DmEBMe7/HbMZdc5yJ9N2Ev6y2V7Hq/zMTuDYLZMhzwL+2P8
	yCY1ZssxFS0VK/KMtUdweWM6k2Qnri38l6y1BrN6OP4ugClC13UH13+1gs6Ww8LmhQybikIT43sx6
	qoJ4HM+Dfwx+ZdYPPLYBuDNWvJG9+ol+QZ5FE9Sod9vxWcOh2+JZkxY37rgSQy4L9ccVXuChwy5CT
	HEMZw1nA0uVQFa5lumtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19AM-00AHZu-Nc; Tue, 14 Jun 2022 16:13:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19AG-00AHXt-9F
	for kexec@lists.infradead.org; Tue, 14 Jun 2022 16:13:14 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EFxfWh032611;
	Tue, 14 Jun 2022 16:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fcHbNxg8MFppptxSn9k+GEm21j6qaH/1jkV0B/SWzKE=;
 b=L6bVJgTonII/0BBGxhhDMjScGzrfKuSsd44tbVzQv409J06Ryb2vbPsI3hSV5kuqWpRx
 dkuQ/cK91aq9bACVyL6AMD+fRYyp5fse7WfnHByP990/hWFciK/+jEUzNJTqOUHE5J0L
 u1ZaQIXK/7Gpq6vH+ydFh3ISen7c3Le9H/9OverPQLHvx1OS7tlruOFZI7ZgYeJnBIeW
 jwwzFXNhtN6d85Sw0gM6dBKrjnEfqB3o89sWU8L3uwLBNW0vQ2tkIA8l+9ZDTal2En/Q
 s2rqNBgemnIYaBUIsDzzfNrMGMg4G/lkRu4XyXQuN1975NDCHFnbyiPek0OdGLFWO+BE VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppp4p5xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:07 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EG9lus029384;
	Tue, 14 Jun 2022 16:13:07 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppp4p5xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:07 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EG5kGs019823;
	Tue, 14 Jun 2022 16:13:06 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
	by ppma04wdc.us.ibm.com with ESMTP id 3gmjp9nfsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:06 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EGD4j434996644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jun 2022 16:13:04 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C14CB6E052;
	Tue, 14 Jun 2022 16:13:04 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E836E053;
	Tue, 14 Jun 2022 16:13:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jun 2022 16:13:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 1/3] of: kexec: Refactor IMA buffer related functions to make them reusable
Date: Tue, 14 Jun 2022 12:12:56 -0400
Message-Id: <20220614161258.1741427-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614161258.1741427-1-stefanb@linux.ibm.com>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wF-2xX1I5ctWfPhRGAajPqj5Ri0HPhoJ
X-Proofpoint-GUID: 7HjQPnl5UwFK-wiD9QAQh_xUx6YyIkAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_091312_626952_1ED2B51A 
X-CRM114-Status: GOOD (  21.52  )
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

Refactor IMA buffer related functions to make them reusable for carrying
TPM logs across kexec.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/kexec.c | 98 +++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 36 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..eef6f3b9939c 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -115,6 +115,18 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
+static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
+{
+	const void *prop;
+	int len;
+
+	prop = of_get_property(of_chosen, name, &len);
+	if (!prop)
+		return -ENOENT;
+
+	return do_get_kexec_buffer(prop, len, addr, size);
+}
+
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -124,19 +136,14 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  */
 int ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret, len;
+	int ret;
 	unsigned long tmp_addr;
 	size_t tmp_size;
-	const void *prop;
 
 	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
 		return -ENOTSUPP;
 
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
 	if (ret)
 		return ret;
 
@@ -174,6 +181,25 @@ int ima_free_kexec_buffer(void)
 	return memblock_phys_free(addr, size);
 }
 
+static int remove_buffer(void *fdt, int chosen_node, const char *name)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, name, &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, name);
+	if (ret)
+		return ret;
+
+	return fdt_find_and_del_mem_rsv(fdt, addr, size);
+}
+
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -185,29 +211,38 @@ int ima_free_kexec_buffer(void)
  */
 static void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	int ret, len;
-	unsigned long addr;
-	size_t size;
-	const void *prop;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
 		return;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return;
-
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
-	if (ret)
-		return;
-
-	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
+	ret = remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
 	if (!ret)
 		pr_debug("Removed old IMA buffer reservation.\n");
 }
 
 #ifdef CONFIG_IMA_KEXEC
+static int setup_buffer(void *fdt, int chosen_node, const char *name,
+			uint64_t addr, uint64_t size)
+{
+	int ret;
+
+	if (!size)
+		return 0;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				       name, addr, size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(fdt, addr, size);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+
+}
+
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -221,23 +256,14 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 {
 	int ret;
 
-	if (!image->ima_buffer_size)
-		return 0;
-
-	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				       "linux,ima-kexec-buffer",
-				       image->ima_buffer_addr,
-				       image->ima_buffer_size);
-	if (ret < 0)
-		return -EINVAL;
-
-	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
-			      image->ima_buffer_size);
+	ret = setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
+			   image->ima_buffer_addr, image->ima_buffer_size);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	if (image->ima_buffer_addr)
+		pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
+			 image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
