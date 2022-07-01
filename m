Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D437C43334
	for <kexec@archiver.kernel.org>; Fri,  1 Jul 2022 02:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ObaeukdrpZ441iFa63+8OnxMoUIuPIH2VofCNK320Ys=; b=uJU1w94M/pWoDy
	P0KSSiKsdxQ7kM/J7HenoUu2mCUG8X8CcvpNGxA0dF7+GV2tglqZO7taRhCFc2Ziq9KYI9tI+5dwm
	QnYcgNtBZjiQNCs1b10Dc1eaPurHId32i+ZbYxL5jm1KR+3ibQoPVlwUotnfGaNQM+UWylsXuGjxV
	/m0xHQR5oybLovTbv/poUJNpLAkNWh/X8FGE5h8+G33CSZ8aEHR3iF02RfrxuCreKl1oX96RarNht
	6ntUhEfeyjmIg+8/G5/4mr8BDGHkHHcoIgDW1+mf3M3h7nMQESKwJlwojvv1kWj4D4meesjcv3QHt
	z8SRLCGhD0nYgJ0/eZdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o76Mb-002PCF-Rk; Fri, 01 Jul 2022 02:26:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o76MS-002P8F-SQ
	for kexec@lists.infradead.org; Fri, 01 Jul 2022 02:26:28 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2612GU0d005414;
	Fri, 1 Jul 2022 02:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=un8OMuiPA3R1r/oDc+pBeWqvOsaQ4noOLtguMXqZ0xE=;
 b=gaTMgRZPseYoo8AP7d1lwOr09J+w7N7nvu8nI5hFIemmfnzcCWJ3La42k24bSOm1f7A0
 HdmPB1SJ53zx1ab05jvPnun9eiBpJY5iWEW38SyqZHFzDteLNsdguX9txZWKjGp4Rdjh
 l+HKKBjjLmK3+sq/azNna6HeQ1KjuFUR2Tyen3S4nsKI/Meoeswhd7Wva9tuQN1JDVOF
 qTAqDVqfwRPVsjIxubHsGuHqPUQkiwZsjWCT13gHotiDmES0wL8g7cdBJYbFaQftYQ+I
 8Jkk3lM1E47rKUcfeezpOj2yaQLKQZrITJ7dQ5AoRQbCdaYOZ+N/oXT8MNjQcA3I8dI+ 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1r06g659-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 02:26:16 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2612QF5n008014;
	Fri, 1 Jul 2022 02:26:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1r06g650-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 02:26:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2612KqqN023448;
	Fri, 1 Jul 2022 02:26:15 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma02wdc.us.ibm.com with ESMTP id 3gwt0af2ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 02:26:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2612QEav46203362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Jul 2022 02:26:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E7EB124052;
	Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63181124054;
	Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 4/5] of: kexec: Refactor IMA buffer related functions to make them reusable
Date: Thu, 30 Jun 2022 22:26:02 -0400
Message-Id: <20220701022603.31076-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701022603.31076-1-stefanb@linux.ibm.com>
References: <20220701022603.31076-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 145l7ArpsFBKTCbUoOMPH_SX4JDV82wq
X-Proofpoint-GUID: K8O5Kx5Grb0LNoK6feUOvMkfdW9RPRX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_01,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010003
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_192625_075716_C9AC7A2F 
X-CRM114-Status: GOOD (  27.58  )
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
v4:
 - Move debug output into setup_buffer()
---
 drivers/of/kexec.c | 131 ++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index c4f9b6655a2e..0710703acfb0 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -115,48 +115,59 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
+static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
 {
 	int ret, len;
-	unsigned long tmp_addr;
 	unsigned long start_pfn, end_pfn;
-	size_t tmp_size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
+	prop = of_get_property(of_chosen, name, &len);
 	if (!prop)
 		return -ENOENT;
 
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	ret = do_get_kexec_buffer(prop, len, addr, size);
 	if (ret)
 		return ret;
 
-	/* Do some sanity on the returned size for the ima-kexec buffer */
-	if (!tmp_size)
+	/* Do some sanity on the returned size for the kexec buffer */
+	if (!*size)
 		return -ENOENT;
 
 	/*
 	 * Calculate the PFNs for the buffer and ensure
 	 * they are with in addressable memory.
 	 */
-	start_pfn = PHYS_PFN(tmp_addr);
-	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
+	start_pfn = PHYS_PFN(*addr);
+	end_pfn = PHYS_PFN(*addr + *size - 1);
 	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
-		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
-			tmp_addr, tmp_size);
+		pr_warn("%s buffer at 0x%lx, size = 0x%zx beyond memory\n",
+			name, *addr, *size);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
 
@@ -191,72 +202,82 @@ int ima_free_kexec_buffer(void)
 	return memblock_phys_free(addr, size);
 }
 
-/**
- * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
- *
- * @fdt: Flattened Device Tree to update
- * @chosen_node: Offset to the chosen node in the device tree
- *
- * The IMA measurement buffer is of no use to a subsequent kernel, so we always
- * remove it from the device tree.
- */
-static void remove_ima_buffer(void *fdt, int chosen_node)
+static int remove_buffer(void *fdt, int chosen_node, const char *name)
 {
 	int ret, len;
 	unsigned long addr;
 	size_t size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return;
-
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	prop = fdt_getprop(fdt, chosen_node, name, &len);
 	if (!prop)
-		return;
+		return -ENOENT;
 
 	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	fdt_delprop(fdt, chosen_node, name);
 	if (ret)
-		return;
+		return ret;
 
 	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
 	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
+		pr_debug("Remove old %s buffer reserveration", name);
+	return ret;
 }
 
-#ifdef CONFIG_IMA_KEXEC
 /**
- * setup_ima_buffer - add IMA buffer information to the fdt
- * @image:		kexec image being loaded.
- * @fdt:		Flattened device tree for the next kernel.
- * @chosen_node:	Offset to the chosen node.
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
- * Return: 0 on success, or negative errno on error.
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
  */
-static int setup_ima_buffer(const struct kimage *image, void *fdt,
-			    int chosen_node)
+static void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return;
+
+	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
+}
+
+#ifdef CONFIG_IMA_KEXEC
+static int setup_buffer(void *fdt, int chosen_node, const char *name,
+			phys_addr_t addr, size_t size)
 {
 	int ret;
 
-	if (!image->ima_buffer_size)
+	if (!size)
 		return 0;
 
 	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				       "linux,ima-kexec-buffer",
-				       image->ima_buffer_addr,
-				       image->ima_buffer_size);
+				       name, addr, size);
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
-			      image->ima_buffer_size);
+	ret = fdt_add_mem_rsv(fdt, addr, size);
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
-		 &image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("%s at 0x%pa, size = 0x%zx\n", name, &addr, size);
 
 	return 0;
+
+}
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int setup_ima_buffer(const struct kimage *image, void *fdt,
+			    int chosen_node)
+{
+	return setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
+			    image->ima_buffer_addr, image->ima_buffer_size);
 }
 #else /* CONFIG_IMA_KEXEC */
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
