Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C08C77B7E
	for <kexec@archiver.kernel.org>; Sun, 23 Apr 2023 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=So5UaRbYgf237RsfYjVsos6akcDa4xoiNNtprU+VowM=; b=TAEPmSB/QKEQre
	KSUM8TY7tS+UsNt0TFSHOI9nis81Vy/Sk/3CYqqDUmfhcJ21wh6GNiEztsTkhaAEPt1LE6C0Ia/eP
	D+gVKJxTM6HFSQ1xniLxRlQDs13Kx0U/urWgawe0JibeyxFkfgQVdCyuYWnVvAAIWRnn/Ab+Wcr93
	yJ//rVzZRLr8VsaXDIEtcm+EawkfH/X6nAS/Fc++zsxfa8yrYu9e8/0BKx8wsyDDcTBsyUEy7Aqr/
	ES203YnREfrJxaVxh7BWpG5XLvUIKaJhh6wPu7sDNAYSdKn8gMmcrC8SwnVMcNobQ1YowXp9F89Ir
	gZngt66h+PtycSx8GtPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKl-00EAvL-1O;
	Sun, 23 Apr 2023 10:52:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKi-00EAuJ-0M
	for kexec@lists.infradead.org;
	Sun, 23 Apr 2023 10:52:41 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33N99MJ7032585;
	Sun, 23 Apr 2023 10:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SwaMBBcqKFPgRLG0j6JBwWr51UUy8Q0ZicUindI5AQI=;
 b=GQFWMkv+QOoadyZKztjgu/DoHf51CWyRmnkpHlycpk5H/qsZw4OdhrCkrI4dZwQ6JvOU
 jjCY2Tl0tPMcuzlZ1QXt01dMBj5DZSlPCU0q9/v5WkAfvouPgwnKZ1n9cK8Gz/ZnsM3R
 4CqL8QmWt7AC1Nog4yqHph5my+s7AnKM0xiPHaZSLQvC3IQHomWAZYNks3Psn6DixXpJ
 V0kZkVU6WMkLvhirFJR7i0OcAnYnF6eVxK5JZFqJtc6j6ZR/8niGjKFokU+wvm/0h4zC
 x1XjCp4KpSrWp3qXtqbUuMVOb1sfs8vXkQH6zkoEJYf9ieal1l/nCJMW+z2KYZbfZTWQ 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r6f3ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33NAfQGN029636;
	Sun, 23 Apr 2023 10:52:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r6f3d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33N4Ckd5016432;
	Sun, 23 Apr 2023 10:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q47770j77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33NAqVST5636840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Apr 2023 10:52:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A9F20043;
	Sun, 23 Apr 2023 10:52:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8041620040;
	Sun, 23 Apr 2023 10:52:27 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.22.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Apr 2023 10:52:27 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v10 3/5] powerpc/crash: add crash CPU hotplug support
Date: Sun, 23 Apr 2023 16:22:11 +0530
Message-Id: <20230423105213.70795-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VkYQQ4vLAeo0Koq3FeHi4r1qZUyaYjzr
X-Proofpoint-ORIG-GUID: AbxdMN5juGi89WmE-A0ml_4dwHgEVQur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-23_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304230097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_035240_163615_4B2E037B 
X-CRM114-Status: GOOD (  35.19  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, Laurent Dufour <laurent.dufour@fr.ibm.com>, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Introduce powerpc crash hotplug handler to update the necessary kexec
segments in the kernel on CPU/Memory hotplug events. Currently, these
updates are done by monitoring CPU/Memory hotplug events in userspace.

A common crash hotplug handler is triggered from generic infrastructure
for both CPU/Memory hotplug events. But in this patch, crash updates are
handled only for CPU hotplug events. Support for the crash update on
memory hotplug events is added in upcoming patches.

The elfcorehdr segment is used to exchange the CPU and other
dump-related information between the kernels. Ideally, the elfcorehdr
segment needs to be recreated on CPU hotplug events to reflect the
changes. But on powerpc, the elfcorehdr is built with possible CPUs
hence there is no need to update/recreate the elfcorehdr on CPU hotplug
events.

In addition to elfcorehdr, there is another kexec segment that holds CPU
data on powerpc is FDT (Flattened Device Tree). During the kdump kernel
boot, it is expected that the crashing CPU must be present in FDT, else
kdump kernel boot fails.

Now the only action needed on powerpc to handle the crash CPU hotplug
event is to add hot added CPUs in the kdump FDT segment to avoid kdump
kernel boot failure. So for the CPU hot add event, the FDT segment is
updated with hot added CPU and Since there is no need to remove the hot
unplugged CPUs from the FDT segment hence no action was taken for CPU
hot remove event.

To accommodate a growing number of CPUs, FDT is built with additional
buffer space to ensure that it can hold possible CPU nodes.

The changes done here will also work for the kexec_load system call
given that the kexec tool builds the FDT segment with additional space
to accommodate possible CPU nodes.

Since memory crash hotplug support is not there yet the crash hotplug
the handler simply warns the user and returns.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |  4 ++
 arch/powerpc/kexec/core_64.c      | 61 +++++++++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c       | 12 +++++-
 arch/powerpc/kexec/file_load_64.c | 14 +++++++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 8090ad7d97d9d..f01ba767af56e 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -103,6 +103,10 @@ void kexec_copy_flush(struct kimage *image);
 struct crash_mem;
 int update_cpus_node(void *fdt);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
+#if defined(CONFIG_CRASH_HOTPLUG)
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+#endif
 #endif
 
 #if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 0b292f93a74cc..611b89bcea2be 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -543,6 +543,67 @@ int update_cpus_node(void *fdt)
 	return ret;
 }
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_hotplug_handler() - Handle crash CPU/Memory hotplug events to update the
+ *                                necessary kexec segments based on the hotplug event.
+ * @image: the active struct kimage
+ *
+ * Update FDT segment to include newly added CPU. No action for CPU remove case.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *fdt, *ptr;
+	unsigned long mem;
+	int i, fdt_index = -1;
+	unsigned int hp_action = image->hp_action;
+
+	/*
+	 * Since the hot-unplugged CPU is already part of crash FDT,
+	 * no action is needed for CPU remove case.
+	 */
+	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		return;
+
+	/* crash update on memory hotplug events is not supported yet */
+	if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
+		pr_info_once("Crash update is not supported for memory hotplug\n");
+		return;
+	}
+
+	/* Find the FDT segment index in kexec segment array. */
+	for (i = 0; i < image->nr_segments; i++) {
+		mem = image->segment[i].mem;
+		ptr = __va(mem);
+
+		if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
+			fdt_index = i;
+			break;
+		}
+	}
+
+	if (fdt_index < 0) {
+		pr_err("Unable to locate FDT segment.\n");
+		return;
+	}
+
+	fdt = __va((void *)image->segment[fdt_index].mem);
+
+	/* Temporarily invalidate the crash image while it is replaced */
+	xchg(&kexec_crash_image, NULL);
+
+	/* update FDT to refelect changes in CPU resrouces */
+	if (update_cpus_node(fdt))
+		pr_err("Failed to update crash FDT");
+
+	/* The crash image is now valid once again */
+	xchg(&kexec_crash_image, image);
+}
+#endif
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e0..d8f6d967231e8 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -30,6 +30,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long cmdline_len)
 {
 	int ret;
+	bool do_pack_fdt = true;
 	unsigned long kernel_load_addr;
 	unsigned long initrd_load_addr = 0, fdt_load_addr;
 	void *fdt;
@@ -116,7 +117,16 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out_free_fdt;
 
-	fdt_pack(fdt);
+#if defined(CONFIG_CRASH_HOTPLUG)
+	/*
+	 * Do not pack FDT, additional space is reserved to accommodate
+	 * possible CPU nodes which are not yet present in the system.
+	 */
+	if (image->type == KEXEC_TYPE_CRASH)
+		do_pack_fdt = false;
+#endif
+	if (do_pack_fdt)
+		fdt_pack(fdt);
 
 	kbuf.buffer = fdt;
 	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 5b0b3f61e0e72..3554168687869 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -908,6 +908,9 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 	unsigned int cpu_nodes, extra_size = 0;
 	struct device_node *dn;
 	u64 usm_entries;
+#if defined(CONFIG_CRASH_HOTPLUG)
+	unsigned int possible_cpu_nodes;
+#endif
 
 	// Budget some space for the password blob. There's already extra space
 	// for the key name
@@ -940,6 +943,17 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 	if (cpu_nodes > boot_cpu_node_count)
 		extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+	/*
+	 * Make sure enough space is reserved to accommodate possible CPU nodes
+	 * in the crash FDT. This allows packing possible CPU nodes which are
+	 * not yet present in the system without regenerating the entire FDT.
+	 */
+	possible_cpu_nodes = num_possible_cpus() / threads_per_core;
+	if (image->type == KEXEC_TYPE_CRASH && possible_cpu_nodes > cpu_nodes)
+		extra_size += (possible_cpu_nodes - cpu_nodes) * cpu_node_size();
+#endif
+
 	return extra_size;
 }
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
