Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85169C4167B
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NL+jthrpl/V6uh2MaSG0R1GQDjt1sGxPXY1VFWx9U1c=; b=b/E1x041kdpWg+
	sav3ELwapAbaPRpdc4E9jE91opA8dqNDa3fUUgUu01QoGNWwPOzKBmeVTUorJKJ3j5xd6bsUl5fVh
	djNXM0F5XW9Sqc7ts8t632GuJOapWt69FFfLtqLZB/iwTttpyOxia0P583NVwYj6Fji3j23Z/ZQhd
	uoIXdelcI6UGmc3DZwwYPrFFlu6cEnAbyH1FmKXef6Fjz5RxTfV01vva6GsCu3tnJ4g5IVzx5Pvye
	+gEp4oG19pbDUqoWTmG2B4PHxSaQb76K3hwU8mWTreeJF9t34G/5C6lMNT+TLnGq8M8AipQwUGeZp
	bWsW9Jw9xZj2CKc8Db3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbj1-004LpB-2E;
	Mon, 11 Dec 2023 08:33:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbis-004LlD-2l
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 08:33:10 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB8JjXr031638;
	Mon, 11 Dec 2023 08:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fZ9fCOXMmlNjlMNCmUX07g2d7SMmZ9TS1em8Ta/u3jk=;
 b=jEjfonmtmLjwgMYZcLVkzfqml2Y29p1t8c7LPNXyJnddiXe/d8pgW62zqHJlXGrxlNnK
 zNeMe2ByUzRRyf1BsPzaH6Lj1xOFQsq0agAEm9zxJNsuH/NGrIoRdlOD0vc5eg29dQkT
 TpYlVBsmRk5CD1wxAR8DfbC/igqBUechVbWppW4xmJmpf7yw9kbG3ICP6lIamCQaRaml
 T6Bt5ywc1GJ1TLai59Aap0CwXKJIyCFNVo4rfvlDEDT9rYTIimiJIjrXbfOfieRThSf8
 L7cI9ItDNEbxfeZGvlQCG74aJzU0vksYpCCSjiqD9yZmi0HWQwMLFA5TcQyv3kJ37q7L 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwfqtrcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:32:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB8KKHT001858;
	Mon, 11 Dec 2023 08:32:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwfqtrc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:32:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB81f89012620;
	Mon, 11 Dec 2023 08:32:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jng3j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:32:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB8WkEd14746330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 08:32:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4046120043;
	Mon, 11 Dec 2023 08:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C252004B;
	Mon, 11 Dec 2023 08:32:35 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.c4p-in.ibmmobiledemo.com (unknown [9.177.92.36])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Dec 2023 08:32:34 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v14 6/6] powerpc: add crash memory hotplug support
Date: Mon, 11 Dec 2023 14:00:56 +0530
Message-ID: <20231211083056.340404-7-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MxuZdFqzff54PjunWjTZ79k4H64ILF7h
X-Proofpoint-ORIG-GUID: xoNrIRmLLUug7bkudHdIUvucV7viRKqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_003307_854322_168B42C8 
X-CRM114-Status: GOOD (  45.61  )
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

Extend the arch crash hotplug handler, as introduced by the patch title
("powerpc: add crash CPU hotplug support"), to also support memory
add/remove events.

Elfcorehdr describes the memory of the crash kernel to capture the
kernel; hence, it needs to be updated if memory resources change due to
memory add/remove events. Therefore, arch_crash_handle_hotplug_event()
is updated to recreate the elfcorehdr and replace it with the previous
one on memory add/remove events.

The memblock list is used to prepare the elfcorehdr. In the case of
memory hot removal, the memblock list is updated after the arch crash
hotplug handler is triggered, as depicted in Figure 1. Thus, the
hot-removed memory is explicitly removed from the crash memory ranges
to ensure that the memory ranges added to elfcorehdr do not include the
hot-removed memory.

    Memory remove
          |
          v
    Offline pages
          |
          v
 Initiate memory notify call <----> crash hotplug handler
 chain for MEM_OFFLINE event
          |
          v
 Update memblock list

 	Figure 1

There are two system calls, `kexec_file_load` and `kexec_load`, used to
load the kdump image. A few changes have been made to ensure that the
kernel can safely update the elfcorehdr component of the kdump image for
both system calls.

For the kexec_file_load syscall, kdump image is prepared in the kernel.
To support an increasing number of memory regions, the elfcorehdr is
built with extra buffer space to ensure that it can accommodate
additional memory ranges in future.

For the kexec_load syscall, the elfcorehdr is updated only if both the
KEXEC_UPDATE_FDT and KEXEC_UPDATE_ELFCOREHDR kexec flags are passed to
the kernel by the kexec tool. Passing these flags to the kernel
indicates that the elfcorehdr is built to accommodate additional memory
ranges and the elfcorehdr segment is not considered for SHA calculation,
making it safe to update it.

Commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs attributes")
added a sysfs interface to indicate userspace (kdump udev rule) that
kernel will update the kdump image on memory hotplug events, so kdump
reload can be avoided. Implement arch specific function
`arch_crash_hotplug_memory_support()` to correctly advertise kernel
capability to update kdump image.

This feature is advertised to usersapce when following conditions are
met:

1. Kdump image is loaded using kexec_file_load system call.
2. Kdump image is loaded using kexec_load system and both
   KEXEC_UPATE_ELFCOREHDR and KEXEC_UPDATE_FDT kexec flags are passed
   to kernel.

The changes related to this feature are kept under the CRASH_HOTPLUG
config, and it is enabled by default.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Akhil Raj <lf32.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
---
 arch/powerpc/include/asm/kexec.h        |   8 ++
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/core_64.c            | 126 ++++++++++++++++++++++--
 arch/powerpc/kexec/file_load_64.c       |  34 ++++++-
 arch/powerpc/kexec/ranges.c             |  85 ++++++++++++++++
 5 files changed, 245 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 7823ab10d323..c8d6cfda523c 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -122,6 +122,14 @@ int arch_crash_hotplug_cpu_support(struct kimage *image);
 #define arch_crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(struct kimage *image);
+#define arch_crash_hotplug_memory_support arch_crash_hotplug_memory_support
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
+
 #endif /*CONFIG_CRASH_HOTPLUG */
 #endif /* CONFIG_PPC64 */
 
diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index f83866a19e87..802abf580cf0 100644
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
index 9932793cd64b..5be30659172f 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -19,8 +19,11 @@
 #include <linux/of.h>
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 
 #include <asm/page.h>
+#include <asm/drmem.h>
+#include <asm/mmzone.h>
 #include <asm/current.h>
 #include <asm/machdep.h>
 #include <asm/cacheflush.h>
@@ -547,9 +550,7 @@ int update_cpus_node(void *fdt)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
-#ifdef CONFIG_HOTPLUG_CPU
- /* Provides the value for the sysfs crash_hotplug nodes */
-int arch_crash_hotplug_cpu_support(struct kimage *image)
+static int crash_hotplug_support(struct kimage *image)
 {
 	if (image->file_mode)
 		return 1;
@@ -560,8 +561,118 @@ int arch_crash_hotplug_cpu_support(struct kimage *image)
 	 */
 	return image->update_elfcorehdr && image->update_fdt;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+ /* Provides the value for the sysfs crash_hotplug nodes */
+int arch_crash_hotplug_cpu_support(struct kimage *image)
+{
+	return crash_hotplug_support(image);
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+ /* Provides the value for the sysfs memory_hotplug nodes */
+int arch_crash_hotplug_memory_support(struct kimage *image)
+{
+	return crash_hotplug_support(image);
+}
 #endif
 
+/*
+ * Advertise preferred elfcorehdr size to userspace via
+ * /sys/kernel/crash_elfcorehdr_size sysfs interface.
+ */
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+	unsigned long elf_phdr_cnt;
+
+	/* Program header for CPU notes and vmcoreinfo */
+	elf_phdr_cnt = 2;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		/* In the worst case, a Phdr is needed for every other LMB to be
+		 * represented as an individual crash range.
+		 */
+		elf_phdr_cnt += memory_hotplug_max() / (2 * drmem_lmb_size());
+
+	/* Do not cross the max limit */
+	if (elf_phdr_cnt > PN_XNUM)
+		elf_phdr_cnt = PN_XNUM;
+
+	sz = sizeof(struct elfhdr) + (elf_phdr_cnt * sizeof(Elf64_Phdr));
+	return sz;
+}
+
+/**
+ * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
+ *			       elfcorehdr in the kexec segment array.
+ * @image: the active struct kimage
+ * @mn: struct memory_notify data handler
+ */
+static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *mn)
+{
+	int ret;
+	struct crash_mem *cmem = NULL;
+	struct kexec_segment *ksegment;
+	void *ptr, *mem, *elfbuf = NULL;
+	unsigned long elfsz, memsz, base_addr, size;
+
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = (void *) ksegment->mem;
+	memsz = ksegment->memsz;
+
+	ret = get_crash_memory_ranges(&cmem);
+	if (ret) {
+		pr_err("Failed to get crash mem range\n");
+		return;
+	}
+
+	/*
+	 * The hot unplugged memory is part of crash memory ranges,
+	 * remove it here.
+	 */
+	if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
+		base_addr = PFN_PHYS(mn->start_pfn);
+		size = mn->nr_pages * PAGE_SIZE;
+		ret = remove_mem_range(&cmem, base_addr, size);
+		if (ret) {
+			pr_err("Failed to remove hot-unplugged from crash memory ranges.\n");
+			return;
+		}
+	}
+
+	ret = crash_prepare_elf64_headers(cmem, false, &elfbuf, &elfsz);
+	if (ret) {
+		pr_err("Failed to prepare elf header\n");
+		return;
+	}
+
+	/*
+	 * It is unlikely that kernel hit this because elfcorehdr kexec
+	 * segment (memsz) is built with addition space to accommodate growing
+	 * number of crash memory ranges while loading the kdump kernel. It is
+	 * Just to avoid any unforeseen case.
+	 */
+	if (elfsz > memsz) {
+		pr_err("Updated crash elfcorehdr elfsz %lu > memsz %lu", elfsz, memsz);
+		goto out;
+	}
+
+	ptr = __va(mem);
+	if (ptr) {
+		/* Temporarily invalidate the crash image while it is replaced */
+		xchg(&kexec_crash_image, NULL);
+
+		/* Replace the old elfcorehdr with newly prepared elfcorehdr */
+		memcpy((void *)ptr, elfbuf, elfsz);
+
+		/* The crash image is now valid once again */
+		xchg(&kexec_crash_image, image);
+	}
+out:
+	vfree(elfbuf);
+}
+
 /**
  * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
  *				     necessary kexec segments based on the hotplug event.
@@ -572,7 +683,7 @@ int arch_crash_hotplug_cpu_support(struct kimage *image)
  * CPU addition: Update the FDT segment to include the newly added CPU.
  * CPU removal: No action is needed, with the assumption that it's okay to have offline CPUs
  *		as part of the FDT.
- * Memory addition/removal: No action is taken as this is not yet supported.
+ * Memory addition/removal: Recreate the elfcorehdr segment
  */
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
@@ -593,7 +704,6 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 		return;
 
 	} else if (hp_action == KEXEC_CRASH_HP_ADD_CPU) {
-
 		void *fdt, *ptr;
 		unsigned long mem;
 		int i, fdt_index = -1;
@@ -628,8 +738,10 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 
 	} else if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY ||
 		   hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
-		pr_info_once("Crash update is not supported for memory hotplug\n");
-		return;
+		struct memory_notify *mn;
+
+		mn = (struct memory_notify *)arg;
+		update_crash_elfcorehdr(image, mn);
 	}
 }
 #endif
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index e2148a009701..2457d7ec2075 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -21,6 +21,8 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/elf.h>
+
 #include <asm/setup.h>
 #include <asm/cputhreads.h>
 #include <asm/drmem.h>
@@ -740,7 +742,35 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 
 	kbuf->buffer = headers;
 	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
-	kbuf->bufsz = kbuf->memsz = headers_sz;
+	kbuf->bufsz = headers_sz;
+#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
+	/* Adjust the elfcorehdr segment size to accommodate
+	 * future crash memory ranges.
+	 */
+	int max_lmb;
+	unsigned long pnum;
+
+	/* In the worst case, a Phdr is needed for every other LMB to be
+	 * represented as an individual crash range.
+	 */
+	max_lmb = memory_hotplug_max() / (2 * drmem_lmb_size());
+
+	/* Do not cross the Phdr max limit of the elf header.
+	 * Avoid counting Phdr for crash ranges (cmem->nr_ranges)
+	 * which are already part of elfcorehdr.
+	 */
+	if (max_lmb > PN_XNUM)
+		pnum = PN_XNUM - cmem->nr_ranges;
+	else
+		pnum = max_lmb - cmem->nr_ranges;
+
+	/* Additional buffer space for elfcorehdr to accommodate
+	 * future memory ranges.
+	 */
+	kbuf->memsz = headers_sz + pnum * sizeof(Elf64_Phdr);
+#else
+	kbuf->memsz = headers_sz;
+#endif
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
@@ -750,7 +780,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	}
 
 	image->elf_load_addr = kbuf->mem;
-	image->elf_headers_sz = headers_sz;
+	image->elf_headers_sz = kbuf->memsz;
 	image->elf_headers = headers;
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index fb3e12f15214..4fd0c5d5607b 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -234,6 +234,91 @@ int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
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
+	u64 end;
+	int ret = 0;
+	unsigned int i;
+	u64 mstart, mend;
+	struct crash_mem *mem_rngs = *mem_ranges;
+
+	if (!size)
+		return 0;
+
+	/*
+	 * Memory range are stored as start and end address, use
+	 * the same format to do remove operation.
+	 */
+	end = base + size - 1;
+
+	for (i = 0; i < mem_rngs->nr_ranges; i++) {
+		mstart = mem_rngs->ranges[i].start;
+		mend = mem_rngs->ranges[i].end;
+
+		/*
+		 * Memory range to remove is not part of this range entry
+		 * in the memory range list
+		 */
+		if (!(base >= mstart && end <= mend))
+			continue;
+
+		/*
+		 * Memory range to remove is equivalent to this entry in the
+		 * memory range list. Remove the range entry from the list.
+		 */
+		if (base == mstart && end == mend) {
+			for (; i < mem_rngs->nr_ranges - 1; i++) {
+				mem_rngs->ranges[i].start = mem_rngs->ranges[i+1].start;
+				mem_rngs->ranges[i].end = mem_rngs->ranges[i+1].end;
+			}
+			mem_rngs->nr_ranges--;
+			goto out;
+		}
+		/*
+		 * Start address of the memory range to remove and the
+		 * current memory range entry in the list is same. Just
+		 * move the start address of the current memory range
+		 * entry in the list to end + 1.
+		 */
+		else if (base == mstart) {
+			mem_rngs->ranges[i].start = end + 1;
+			goto out;
+		}
+		/*
+		 * End address of the memory range to remove and the
+		 * current memory range entry in the list is same.
+		 * Just move the end address of the current memory
+		 * range entry in the list to base - 1.
+		 */
+		else if (end == mend)  {
+			mem_rngs->ranges[i].end = base - 1;
+			goto out;
+		}
+		/*
+		 * Memory range to remove is not at the edge of current
+		 * memory range entry. Split the current memory entry into
+		 * two half.
+		 */
+		else {
+			mem_rngs->ranges[i].end = base - 1;
+			size = mem_rngs->ranges[i].end - end;
+			ret = add_mem_range(mem_ranges, end + 1, size);
+		}
+	}
+out:
+	return ret;
+}
+
 /**
  * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
  * @mem_ranges:         Range list to add the memory range(s) to.
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
