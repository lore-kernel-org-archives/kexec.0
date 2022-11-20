Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA5CC433FE
	for <kexec@archiver.kernel.org>; Sun, 20 Nov 2022 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IQlFBKmecNj2FBVB8cm3lExTLXPC0XkhCDlVMAG/m6o=; b=N1A6LBbjPDcLwt
	Ctb50Do0BtNXxnPwd+zO40WZYxr6/1bdMH+nUklW4Dk7+DtpeayFOvv+j2QucNeXOYmKqRPnczjds
	ZIloK582+UGadBevbq4L+GyV5JBWiy6OMzA0qo+lhs+9FaLuyJOPaXQmHBZ9VZZJAbXl8f8LOwUGu
	HHP9l7gYyo2x1uw6l0m6UJXSKo3cUOZyipPaCxcNGowv279u5XnQyLeoUe3NA3W0IwRCaxi8+Is4s
	O81SIq2xogzmAqy7Mg1JJEB0AmiWznuUyOE4X0YN+NIwtf4oP0TCpjz9rBHsDG7EPnA8/lpNtb2Fe
	E+ZcRAVjS5yIUTI58HGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owtgw-007aJe-5E; Sun, 20 Nov 2022 23:25:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owtgt-007aHq-13
	for kexec@lists.infradead.org; Sun, 20 Nov 2022 23:25:36 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKIWfrR001592;
	Sun, 20 Nov 2022 23:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4iZYDjFJ8eB8+gui9attAVoULERmOfGuq6MMDAZ9VuQ=;
 b=ib7ggXp2uCniT4UnTefSS3B/y1npwwrN1i+/A2k3maciSlA3N6XoYglpPaNUg/+cQ4+5
 FuPCJ7RJdJf1jUYWNMzuRr8n0lRAwxUczL2/RNJxTth0vyOYKsS2FKD8zsWU/AHLOpNK
 1Q729T/+kmjavferu9BAbunqT/sY1HZ+mnitQjwadJIOnbWIrROtRUf8CF24ZhoAesXc
 TbKUUBdtJn4h8T+fJ5ZARk/oHcUt1Qi73d8hn+wgNDT0KG7f6n+l/LuJ8oee5win1jAv
 g2DLeeLdDz10pD3kQhDu9JBOzbu++bBjAYklM+Bo3eZR/6QHKhmCDM1+3hhbOQieGekZ 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8khj6ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:32 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKNKkPs008474;
	Sun, 20 Nov 2022 23:25:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8khj6jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKNL7lt022173;
	Sun, 20 Nov 2022 23:25:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhste5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AKNPR122032300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Nov 2022 23:25:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9226AE051;
	Sun, 20 Nov 2022 23:25:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00109AE04D;
	Sun, 20 Nov 2022 23:25:24 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.9.248])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Sun, 20 Nov 2022 23:25:24 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v5 6/6] powerpc/kexec: add crash memory hotplug support
Date: Mon, 21 Nov 2022 04:55:08 +0530
Message-Id: <20221120232508.327554-7-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221120232508.327554-1-sourabhjain@linux.ibm.com>
References: <20221120232508.327554-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nxSIpvb_7iSs_EJ5UO4YpaIjI-bF5AgG
X-Proofpoint-ORIG-GUID: XS8Q5X8GrFaECTKtLUOTGcgd-UPSeFKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211200194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_152535_097459_3A536CC5 
X-CRM114-Status: GOOD (  34.95  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Extend PowerPC arch crash hotplug handler to support memory hotplug
events. Since elfcorehdr is used to exchange the memory info between the
kernels hence it needs to be recreated to reflect the changes due to
memory hotplug events.

The way memory hotplug events are handled on PowerPC and the notifier call
chain used in generic code to trigger the arch crash handler, the process
to recreate the elfcorehdr is different for memory add and remove events.

In the hot remove case, the memory region is first marked offline then the
notifier call chain is triggered (same is used to initiate arch crash
hotplug handler) and at last the memblock structure is updated. Whereas
in the hot add case, memblock structure is updated before the notifier
call chain is triggered.

On PowerPC, memblock structure is used to identify the memory ranges for
elfcorehdr. In case of memory hot remove the memblock structure is updated
after the arch crash hotplug handler is triggered, hence an additional
step is taken to ensure that memory ranges used to build elfcorehdr do
not include hot removed memory. Whereas no such extra steps are needed
for the hot add case because memblock structure is updated before the
arch crash hotplug handler is triggered.

The hot removed memory is explicitly removed from the memory ranges list
before creating elfcorehdr for the hot remove case.

To accommodate a growing number of memory regions, elfcorehdr is built
with additional buffer space to hold max memory regions.

The changes done here will also work for the kexec_load system call given
that the kexec tool builds the elfcoredhr with additional space to
accommodate future memory regions as it is done for kexec_file_load
system call.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec_ranges.h |  1 +
 arch/powerpc/kexec/core_64.c            | 62 +++++++++++++++++++++++--
 arch/powerpc/kexec/file_load_64.c       | 12 ++++-
 arch/powerpc/kexec/ranges.c             | 60 ++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index f83866a19e870..802abf580cf0f 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -7,6 +7,7 @@
 void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
 struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
+int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
 int add_tce_mem_ranges(struct crash_mem **mem_ranges);
 int add_initrd_mem_range(struct crash_mem **mem_ranges);
 #ifdef CONFIG_PPC_64S_HASH_MMU
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6803d7e352a96..638b99dbf45b5 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -570,7 +571,62 @@ int update_cpus_node(void *fdt)
 	return ret;
 }
 
-#if defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+
+int update_crash_elfcorehdr(struct kimage *image, unsigned int hp_action, void *arg)
+{
+	int ret;
+	struct crash_mem *cmem = NULL;
+	struct kexec_segment *ksegment;
+	unsigned long elfsz;
+	void *elfbuf = NULL;
+	void *mem;
+	unsigned long memsz;
+	char *ptr;
+	struct memory_notify *mn = (struct memory_notify *) arg;
+	unsigned long base_addr;
+	unsigned long size;
+
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = (void *) ksegment->mem;
+	memsz = ksegment->memsz;
+
+	ret = get_crash_memory_ranges(&cmem);
+	if (ret) {
+		pr_err("crash hp: failed to get crash mem range\n");
+		return -1;
+	}
+
+	if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
+		base_addr = PFN_PHYS(mn->start_pfn);
+		size = mn->nr_pages * PAGE_SIZE;
+		ret = remove_mem_range(&cmem, base_addr, size);
+		if (ret)
+			return -1;
+	}
+
+	ret = crash_prepare_elf64_headers(image, cmem, false, &elfbuf, &elfsz);
+	if (ret) {
+		pr_err("crash hp: failed to prepare elf header\n");
+		return -1;
+	}
+
+	if (elfsz > memsz) {
+		pr_err("crash hp: updated crash elfcorehdr elfsz %lu > memsz %lu", elfsz, memsz);
+		return -1;
+	}
+
+	ptr = __va(mem);
+	if (ptr) {
+		xchg(&kexec_crash_image, NULL);
+		memcpy((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+
+	vfree(elfbuf);
+	return 0;
+}
+
 /**
  * arch_crash_hotplug_handler() - Handle hotplug kexec segements changes FDT, elfcorehdr
  * @image: the active struct kimage
@@ -590,8 +646,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_actio
 
 	/* crash update on memory hotplug is not support yet */
 	if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
-		pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
-		return;
+		if (update_crash_elfcorehdr(image, hp_action, arg))
+			return;
 	}
 
 	/* Must have valid FDT index */
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 87de3fc59159a..efa423752a601 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -21,6 +21,8 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/elf.h>
+
 #include <asm/setup.h>
 #include <asm/drmem.h>
 #include <asm/firmware.h>
@@ -734,7 +736,13 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 
 	kbuf->buffer = headers;
 	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
-	kbuf->bufsz = kbuf->memsz = headers_sz;
+	kbuf->bufsz = headers_sz;
+/* Additional buffer space to accommodate future memory ranges */
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	kbuf->memsz = PN_XNUM * sizeof(Elf64_Phdr);
+#else
+	kbuf->memsz = headers_sz;
+#endif
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
@@ -744,7 +752,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	}
 
 	image->elf_load_addr = kbuf->mem;
-	image->elf_headers_sz = headers_sz;
+	image->elf_headers_sz = kbuf->memsz;
 	image->elf_headers = headers;
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 563e9989a5bf0..d0d0094711b8e 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -234,6 +234,66 @@ int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
 	return __add_mem_range(mem_ranges, base, size);
 }
 
+/**
+ * remove_mem_range - Removes the given memory range from the range list.
+ * @mem_ranges:    Range list to remove the memory range to.
+ * @base:          Base address of the range to remove.
+ * @size:          Size of the memory range to remove.
+ *
+ * (Re)allocates memory, if needed.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
+{
+	int ret = 0;
+	unsigned int i;
+	struct crash_mem *mem_rngs = *mem_ranges;
+	u64 mstart, mend;
+	u64 range_start, range_end;
+
+	if (!size)
+		return 0;
+
+	range_start = base;
+	range_end = base + size - 1;
+
+	for (i = 0; i < mem_rngs->nr_ranges; i++) {
+		mstart = mem_rngs->ranges[i].start;
+		mend = mem_rngs->ranges[i].end;
+
+		if (!(range_start >= mstart && range_end <= mend))
+			continue;
+
+		if (range_start == mstart) {
+			if (range_end == mend) {
+				for (; i < mem_rngs->nr_ranges - 1; i++) {
+					mem_rngs->ranges[i].start = mem_rngs->ranges[i+1].start;
+					mem_rngs->ranges[i].end = mem_rngs->ranges[i+1].end;
+				}
+				mem_rngs->nr_ranges--;
+				goto out;
+			}
+			mem_rngs->ranges[i].start = range_end + 1;
+			goto out;
+		} else if (range_end == mend)  {
+			mem_rngs->ranges[i].end = range_start - 1;
+			goto out;
+		} else {
+			size = mem_rngs->ranges[i].end - range_end;
+			mem_rngs->ranges[i].end = range_start - 1;
+			if (add_mem_range(mem_ranges, range_end + 1, size))
+				goto error;
+			goto out;
+		}
+	}
+error:
+	return -1;
+
+out:
+	return ret;
+}
+
 /**
  * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
  * @mem_ranges:         Range list to add the memory range(s) to.
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
