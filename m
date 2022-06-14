Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A7C433EF
	for <kexec@archiver.kernel.org>; Tue, 14 Jun 2022 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m1fhmswk+mUyCfhFoX8BKDQgPVBe/W9BgHx4zsZoCAA=; b=4aRGeqajC5ETnv
	9DVsIQQ27EkaEg38SDbTUyA94R9Pfnvj/EAo758qdqSc3rB4aGKc7SGnVlMFvVmlXDF17YL2Bov1Y
	WpF1o2EsZFpVrDQaYt7TfTpdCIkiz2ulVye+uLl+Gh9JYXHZjYl32yHpiodo35Wl7hPEVNYAdmaYI
	mQqoievyfiRwKi5leSgU8XD2+cFqJKtdZHivGUKcpf8LJuVc/Cz0v0K+kmfxYvp1EkDKKo3sqLFrR
	fy4EW0BR0JPQvHUgZKh1bsCNJ0in33XfG2xXMvXfCc7N57eH2vrUfmsrvwxlQpzaacG0LlhKmVvgo
	LaHko7TkxRfaALlAIPSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19AP-00AHab-F5; Tue, 14 Jun 2022 16:13:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19AI-00AHXr-Ek
	for kexec@lists.infradead.org; Tue, 14 Jun 2022 16:13:16 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EG0CiB023982;
	Tue, 14 Jun 2022 16:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L2Sg/oinUsfH3HHdPiOtFmPzIlLMDmW3qnyCB1oaFoA=;
 b=tS4+07OdQS2ZDCs/jni6F1f9Qj/kuUJcukz1Tk/Ero5w/dZWRPaRnhYLcBFz8JuvfRxT
 4kbMHpY9OAUxcfqIeWwMVHguWp1R1r9WeY8qhacrM0XbkBBEujhEO79HL0CV2pmDZZnL
 5/iBtSJSGFvDpvDnA3bKvdEbHTfVh0F1qkhbYHtU3gkbETz2xNlkP2jHFTRFQvztIrm+
 qpbFf87oxRFjq5yrBDC32XOn2xT0ri1jXoqYkTC6vYW4x6ANAUNh1L+RGvSyzKw/nlx5
 RJWKNtJzQS386YsAxYwLqAB72vm8Y9qwzAgkl0lKhiJSy8RfiIWKtnbv3jy1v4PMZVy9 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6hqbc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:08 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EG0f3U026477;
	Tue, 14 Jun 2022 16:13:07 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6hqbbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:07 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EG4sNv030726;
	Tue, 14 Jun 2022 16:13:06 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma02wdc.us.ibm.com with ESMTP id 3gmjp9de7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:13:06 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EGD5RT43254022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jun 2022 16:13:05 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60F5B6E050;
	Tue, 14 Jun 2022 16:13:05 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9EAA6E053;
	Tue, 14 Jun 2022 16:13:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jun 2022 16:13:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
Date: Tue, 14 Jun 2022 12:12:57 -0400
Message-Id: <20220614161258.1741427-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614161258.1741427-1-stefanb@linux.ibm.com>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qpUseKXVRm7tbcaS12Go_stFSzmxtQWC
X-Proofpoint-ORIG-GUID: 8QV1kA6KnkMfqukQOPEGh2grxEpmL796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_091314_571834_BF2A03B9 
X-CRM114-Status: GOOD (  41.48  )
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

The memory area of the TPM measurement log is currently not properly
duplicated for carrying it across kexec when an Open Firmware
Devicetree is used. Therefore, the contents of the log get corrupted.
Fix this for the kexec_file_load() syscall by allocating a buffer and
copying the contents of the existing log into it. The new buffer is
preserved across the kexec and a pointer to it is available when the new
kernel is started. To achieve this, store the allocated buffer's address
in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
and search for this entry early in the kernel startup before the TPM
subsystem starts up. Adjust the pointer in the of-tree stored under
linux,sml-base to point to this buffer holding the preserved log. The
TPM driver can then read the base address from this entry when making
the log available.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
---
 drivers/of/device.c       |  24 +++++
 drivers/of/kexec.c        | 190 +++++++++++++++++++++++++++++++++++++-
 include/linux/kexec.h     |   6 ++
 include/linux/of.h        |   5 +
 include/linux/of_device.h |   3 +
 kernel/kexec_file.c       |   6 ++
 6 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874f031442dc..0cbd47b1cabc 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -382,3 +382,27 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
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
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index eef6f3b9939c..db5441123a70 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_fdt.h>
 #include <linux/random.h>
 #include <linux/slab.h>
@@ -221,7 +222,6 @@ static void remove_ima_buffer(void *fdt, int chosen_node)
 		pr_debug("Removed old IMA buffer reservation.\n");
 }
 
-#ifdef CONFIG_IMA_KEXEC
 static int setup_buffer(void *fdt, int chosen_node, const char *name,
 			uint64_t addr, uint64_t size)
 {
@@ -243,6 +243,7 @@ static int setup_buffer(void *fdt, int chosen_node, const char *name,
 
 }
 
+#ifdef CONFIG_IMA_KEXEC
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -275,6 +276,190 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 }
 #endif /* CONFIG_IMA_KEXEC */
 
+/**
+ * tpm_get_kexec_buffer - get TPM log buffer from the previous kernel
+ * @phyaddr:	On successful return, set to physical address of buffer
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int tpm_get_kexec_buffer(void **phyaddr, size_t *size)
+{
+	int ret;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+
+	ret = get_kexec_buffer("linux,tpm-kexec-buffer", &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*phyaddr = (void *)tmp_addr;
+	*size = tmp_size;
+
+	return 0;
+}
+
+/**
+ * tpm_free_kexec_buffer - free memory used by the IMA buffer
+ */
+static int tpm_of_remove_kexec_buffer(void)
+{
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, "linux,tpm-kexec-buffer", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	return of_remove_property(of_chosen, prop);
+}
+
+/**
+ * remove_tpm_buffer - remove the TPM log buffer property and reservation from @fdt
+ *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The TPM log measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+static void remove_tpm_buffer(void *fdt, int chosen_node)
+{
+	int ret;
+
+	ret = remove_buffer(fdt, chosen_node, "linux,tpm-kexec-buffer");
+	if (!ret)
+		pr_debug("Removed old TPM log buffer reservation.\n");
+}
+
+/**
+ * setup_tpm_buffer - add TPM measurement log buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int setup_tpm_buffer(const struct kimage *image, void *fdt,
+			    int chosen_node)
+{
+	return setup_buffer(fdt, chosen_node, "linux,tpm-kexec-buffer",
+			    image->tpm_buffer_addr, image->tpm_buffer_size);
+}
+
+void tpm_add_kexec_buffer(struct kimage *image)
+{
+	struct kexec_buf kbuf = { .image = image, .buf_align = 1,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	struct device_node *np;
+	void *buffer;
+	u32 size;
+	u64 base;
+	int ret;
+
+	np = of_find_node_by_name(NULL, "vtpm");
+	if (!np)
+		return;
+
+	if (of_tpm_get_sml_parameters(np, &base, &size) < 0)
+		return;
+
+	buffer = vmalloc(size);
+	if (!buffer)
+		return;
+	memcpy(buffer, __va(base), size);
+
+	kbuf.buffer = buffer;
+	kbuf.bufsz = size;
+	kbuf.memsz = size;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		pr_err("Error passing over kexec TPM measurement log buffer: %d\n",
+		       ret);
+		return;
+	}
+
+	image->tpm_buffer = buffer;
+	image->tpm_buffer_addr = kbuf.mem;
+	image->tpm_buffer_size = size;
+}
+
+/**
+ * tpm_post_kexec - Make stored TPM log buffer available in of-tree
+ */
+static int __init tpm_post_kexec(void)
+{
+	struct property *newprop;
+	struct device_node *np;
+	void *phyaddr;
+	size_t size;
+	u32 oflogsize;
+	u64 unused;
+	int ret;
+
+	ret = tpm_get_kexec_buffer(&phyaddr, &size);
+	if (ret)
+		return 0;
+
+	/*
+	 * If any one of the following steps fails then the next kexec will
+	 * cause issues due to linux,sml-base pointing to a stale buffer.
+	 */
+	np = of_find_node_by_name(NULL, "vtpm");
+	if (!np)
+		goto err_free_memblock;
+
+	/* logsize must not have changed */
+	if (of_tpm_get_sml_parameters(np, &unused, &oflogsize) < 0)
+		goto err_free_memblock;
+	if (oflogsize != size)
+		goto err_free_memblock;
+
+	/* replace linux,sml-base with new physical address of buffer */
+	ret = -ENOMEM;
+	newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
+	if (!newprop)
+		goto err_free_memblock;
+
+	newprop->name = kstrdup("linux,sml-base", GFP_KERNEL);
+	if (!newprop->name)
+		goto err_free_newprop;
+
+	newprop->length = sizeof(phyaddr);
+
+	newprop->value = kmalloc(sizeof(u64), GFP_KERNEL);
+	if (!newprop->value)
+		goto err_free_newprop_struct;
+
+	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
+	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
+		ret = -ENODEV;
+		goto err_free_newprop_struct;
+	} else {
+		*(u64 *)newprop->value = (u64)phyaddr;
+	}
+
+	ret = of_update_property(np, newprop);
+	if (ret) {
+		pr_err("Could not update linux,sml-base with new address");
+		goto err_free_newprop_struct;
+	}
+
+	goto exit;
+
+err_free_newprop_struct:
+	kfree(newprop->name);
+err_free_newprop:
+	kfree(newprop);
+err_free_memblock:
+	memblock_phys_free((phys_addr_t)phyaddr, size);
+exit:
+	tpm_of_remove_kexec_buffer();
+
+	return ret;
+}
+postcore_initcall(tpm_post_kexec);
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
@@ -464,6 +649,9 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 	remove_ima_buffer(fdt, chosen_node);
 	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
 
+	remove_tpm_buffer(fdt, chosen_node);
+	ret = setup_tpm_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
+
 out:
 	if (ret) {
 		kvfree(fdt);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..a0fd7ac0398c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -319,6 +319,12 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* Virtual address of TPM log buffer for kexec syscall */
+	void *tpm_buffer;
+
+	phys_addr_t tpm_buffer_addr;
+	size_t tpm_buffer_size;
 };
 
 /* kexec interface functions */
diff --git a/include/linux/of.h b/include/linux/of.h
index 04971e85fbc9..922f51c2c072 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -443,6 +443,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   const char *cmdline, size_t extra_fdt_size);
 int ima_get_kexec_buffer(void **addr, size_t *size);
 int ima_free_kexec_buffer(void);
+void tpm_add_kexec_buffer(struct kimage *image);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -844,6 +845,10 @@ static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 	return PHYS_ADDR_MAX;
 }
 
+static inline void tpm_add_kexec_buffer(struct kimage *image)
+{
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 1d7992a02e36..bac04b0b9c48 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -56,6 +56,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return of_dma_configure_id(dev, np, force_dma, NULL);
 }
+
+int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size);
+
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..27661eb6112d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/fs.h>
 #include <linux/ima.h>
+#include <linux/tpm.h>
 #include <crypto/hash.h>
 #include <crypto/sha2.h>
 #include <linux/elf.h>
@@ -171,6 +172,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->ima_buffer = NULL;
 #endif /* CONFIG_IMA_KEXEC */
 
+	vfree(image->tpm_buffer);
+	image->tpm_buffer = NULL;
+
 	/* See if architecture has anything to cleanup post load */
 	arch_kimage_file_post_load_cleanup(image);
 
@@ -277,6 +281,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
+	/* Pass the TPM measurement log to next kernel */
+	tpm_add_kexec_buffer(image);
 
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
