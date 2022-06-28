Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3454BC433EF
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RmxRIWK59Fglu/hpcQ3TjBE2bm9jCJ4LGhyE0gBt7CQ=; b=HQqLp67nL9D6lG
	jfUSlTR1boK9F5Bu77o05Y9ooHarFaBAbUvh1rLxpa7dcaGC0m/0ggN/orR/oZORZaysbUbHNCW76
	oQsPHw/QmDQb1t6o9mDV5UfDdwRIYYPq9d9i1Lf4RPInr9ASP7R240BX8XNNqIWOS5WZdYBRDS41R
	oSIAhdIHJ8GmG4sQN5UJo22yg7td7oE9hnQ58QBkjUUy8SSDby/iksw4NP/PTzU4HMX6Za6CF1byL
	NzAv0Py5c+rrhHMNmKgQaib9IbAtzpQddsl44Tq2/bh6pxD0EPraYOyPd9bLcYHUpmXhqlEL/KVAW
	GXN9/whOcPlYanhc0cmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6EXy-007IZn-MK; Tue, 28 Jun 2022 16:58:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6EXt-007IXf-4k
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 16:58:39 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SGk9KX023071;
	Tue, 28 Jun 2022 16:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jJLW91B7wzmiIM8pkoGBYzEOtxCKb/elmWaiVT1q+2Y=;
 b=HgwiT96Ha0TDJtAXdprmr2pcxokXej+As6kpV8B7zWhUaf30yy/KBli5trQPrJZcq5DV
 gY6grKlQNwMj4q929fr2QG+yIgNmViEHuThRlOPQ4thEhu/4N9JZdUphJecjCe8C2TOY
 AAV1I2HZSCQGaJw6Ykc8zYwlXRfX4kxuDT9Z+H9wnzJr3tlIwaxVGXXDne9GwdfL+PGD
 uWnTSwy/2Z4Ynp4rnUSQ5M4YseRcffJBlgQLFXEj0OduTXpB/Z9IqUQepG4X8uhzY0a2
 3DXeArseKkdBxSEuqi/fLfNkrPLCZwHZzni5BSIOf5b4Zx2Rknd8pVdW0C2Ezx9GplGZ yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h05f2r9dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 16:58:30 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SGtHYI003016;
	Tue, 28 Jun 2022 16:58:29 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h05f2r9d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 16:58:29 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SGoETN010068;
	Tue, 28 Jun 2022 16:58:28 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 3gwt0atxfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 16:58:28 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SGwQI424707536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jun 2022 16:58:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB8078064;
	Tue, 28 Jun 2022 16:58:26 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A96B7805F;
	Tue, 28 Jun 2022 16:58:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jun 2022 16:58:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 2/3] of: kexec: Refactor IMA buffer related functions to make them reusable
Date: Tue, 28 Jun 2022 12:58:19 -0400
Message-Id: <20220628165820.883222-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628165820.883222-1-stefanb@linux.ibm.com>
References: <20220628165820.883222-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RIlJOQAHslSYAvvUAzrtNCXxDnduiE6r
X-Proofpoint-ORIG-GUID: 9ikZvveMi0gBZ8P6YEJM80Y0gVVI12XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_095837_337127_C9575795 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/of/kexec.c | 99 +++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..601ea9727b0e 100644
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
 
@@ -174,6 +181,28 @@ int ima_free_kexec_buffer(void)
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
+	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Remove old %s buffer reserveration", name);
+	return ret;
+}
+
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -185,29 +214,34 @@ int ima_free_kexec_buffer(void)
  */
 static void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	int ret, len;
-	unsigned long addr;
-	size_t size;
-	const void *prop;
-
 	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
 		return;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return;
+	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
+}
 
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+#ifdef CONFIG_IMA_KEXEC
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
 	if (ret)
-		return;
+		return -EINVAL;
+
+	return 0;
 
-	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
-	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
 }
 
-#ifdef CONFIG_IMA_KEXEC
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -221,23 +255,14 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
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
