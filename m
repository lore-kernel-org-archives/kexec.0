Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D152CDB474
	for <kexec@archiver.kernel.org>; Tue, 17 Oct 2023 02:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dAl5bSUQKgjfa6vedgRyC281cePkD/ngjxTKmTSIlKE=; b=uB2k0bM+Iv0pXU
	vxZr4qN1I/evxMjscKy8kX2fE6e7cgLPsnppk5d334fk07MzdWMDi8lDT2gKdxBFBkLV/2ekA71yp
	OGJnnMKFjEOj2DNeT7VVmTB1Ewq5AKHMAC0iy2rRhudpqDmW0fIIRr8kskHwdshQvW7SBMZ7RgsXS
	GhUBv0e5DPHZVlI/+XaAKabigq2EnxVkswzt60Qf4IP7yGpizDRietlMsNDJMYSYCXHkN9fRZqo0T
	aE/M8Z6rXe7mNC2HRP0FOK6G/3aZP2Fbc8mdYYhvfob8T1CvaG68qIg4T3EJ6LherufZNYKyYuTIU
	x6DSZtU9xdy2AoF7G1XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZpQ-00B4A3-2o;
	Tue, 17 Oct 2023 02:29:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZpO-00B48p-0s
	for kexec@lists.infradead.org;
	Tue, 17 Oct 2023 02:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697509741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTXa8q2/4KkDNAg/UihUszZIviPOK2aWJPqLddhEvQs=;
	b=NEzM1/3wLVeHRJL//fhK4KDKJod4TSRr8hrsdLIkI1Jk0KAVziGIW+y1ydb2NpUYhyrHVS
	yxFO5/RTRNAoAdgfvE6Uo+AYQcNcfyrX1LXnU+T0D7ZH6tPL5wBffr8aQOmdlUEiXOeWFT
	+NdsnncpFOF25b3tEt78f0fSFA6vbhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-HkPwqxLaO5ufrrjRmeNpkg-1; Mon, 16 Oct 2023 22:28:40 -0400
X-MC-Unique: HkPwqxLaO5ufrrjRmeNpkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85969101AA72;
	Tue, 17 Oct 2023 02:28:39 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 211F61C060B0;
	Tue, 17 Oct 2023 02:28:31 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org
Subject: [PATCHv9 2/2] powerpc/setup: Loosen the mapping between cpu logical id and its seq in dt
Date: Tue, 17 Oct 2023 10:28:06 +0800
Message-Id: <20231017022806.4523-3-piliu@redhat.com>
In-Reply-To: <20231017022806.4523-1-piliu@redhat.com>
References: <20231017022806.4523-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_192902_381260_8E29F8E9 
X-CRM114-Status: GOOD (  28.30  )
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

*** Idea ***
For kexec -p, the boot cpu can be not the cpu0, this causes the problem
of allocating memory for paca_ptrs[]. However, in theory, there is no
requirement to assign cpu's logical id as its present sequence in the
device tree. But there is something like cpu_first_thread_sibling(),
which makes assumption on the mapping inside a core. Hence partially
loosening the mapping, i.e. unbind the mapping of core while keep the
mapping inside a core.

*** Implement ***
At this early stage, there are plenty of memory to utilize. Hence, this
patch allocates interim memory to link the cpu info on a list, then
reorder cpus by changing the list head. As a result, there is a rotate
shift between the sequence number in dt and the cpu logical number.

*** Result ***
After this patch, a boot-cpu's logical id will always be mapped into the
range [0,threads_per_core).

Besides this, at this phase, all threads in the boot core are forced to
be onlined. This restriction will be lifted in a later patch with
extra effort.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/prom.c         | 25 +++++----
 arch/powerpc/kernel/setup-common.c | 84 +++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index ec82f5bda908..7ed9034912ca 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -76,7 +76,9 @@ u64 ppc64_rma_size;
 unsigned int boot_cpu_node_count __ro_after_init;
 #endif
 static phys_addr_t first_memblock_size;
+#ifdef CONFIG_SMP
 static int __initdata boot_cpu_count;
+#endif
 
 static int __init early_parse_mem(char *p)
 {
@@ -331,8 +333,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	const __be32 *intserv;
 	int i, nthreads;
 	int len;
-	int found = -1;
-	int found_thread = 0;
+	bool found = false;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -355,8 +356,15 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	for (i = 0; i < nthreads; i++) {
 		if (be32_to_cpu(intserv[i]) ==
 			fdt_boot_cpuid_phys(initial_boot_params)) {
-			found = boot_cpu_count;
-			found_thread = i;
+			/*
+			 * always map the boot-cpu logical id into the
+			 * range of [0, thread_per_core)
+			 */
+			boot_cpuid = i;
+			found = true;
+			/* This forces all threads in a core to be online */
+			if (nr_cpu_ids % nthreads != 0)
+				set_nr_cpu_ids(ALIGN(nr_cpu_ids, nthreads));
 		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
@@ -365,14 +373,13 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	}
 
 	/* Not the boot CPU */
-	if (found < 0)
+	if (!found)
 		return 0;
 
-	DBG("boot cpu: logical %d physical %d\n", found,
-	    be32_to_cpu(intserv[found_thread]));
-	boot_cpuid = found;
+	DBG("boot cpu: logical %d physical %d\n", boot_cpuid,
+	    be32_to_cpu(intserv[boot_cpuid]));
 
-	boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
+	boot_cpu_hwid = be32_to_cpu(intserv[boot_cpuid]);
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 707f0490639d..9802c7e5ee2f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -36,6 +36,7 @@
 #include <linux/of_irq.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/list.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
@@ -425,6 +426,13 @@ static void __init cpu_init_thread_core_maps(int tpc)
 
 u32 *cpu_to_phys_id = NULL;
 
+struct interrupt_server_node {
+	struct list_head node;
+	bool	avail;
+	int	len;
+	__be32 intserv[];
+};
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -446,11 +454,16 @@ u32 *cpu_to_phys_id = NULL;
 void __init smp_setup_cpu_maps(void)
 {
 	struct device_node *dn;
-	int cpu = 0;
-	int nthreads = 1;
+	int shift = 0, cpu = 0;
+	int j, nthreads = 1;
+	int len;
+	struct interrupt_server_node *intserv_node, *n;
+	struct list_head *bt_node, head;
+	bool avail, found_boot_cpu = false;
 
 	DBG("smp_setup_cpu_maps()\n");
 
+	INIT_LIST_HEAD(&head);
 	cpu_to_phys_id = memblock_alloc(nr_cpu_ids * sizeof(u32),
 					__alignof__(u32));
 	if (!cpu_to_phys_id)
@@ -460,7 +473,6 @@ void __init smp_setup_cpu_maps(void)
 	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
 		__be32 cpu_be;
-		int j, len;
 
 		DBG("  * %pOF...\n", dn);
 
@@ -480,29 +492,65 @@ void __init smp_setup_cpu_maps(void)
 			}
 		}
 
-		nthreads = len / sizeof(int);
+		avail = of_device_is_available(dn);
+		if (!avail)
+			avail = !of_property_match_string(dn,
+					"enable-method", "spin-table");
 
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
-			bool avail;
 
-			DBG("    thread %d -> cpu %d (hard id %d)\n",
-			    j, cpu, be32_to_cpu(intserv[j]));
-
-			avail = of_device_is_available(dn);
-			if (!avail)
-				avail = !of_property_match_string(dn,
-						"enable-method", "spin-table");
+		intserv_node = memblock_alloc(sizeof(struct interrupt_server_node) + len,
+					__alignof__(u32));
+		if (!intserv_node)
+			panic("%s: Failed to allocate %zu bytes align=0x%zx\n",
+				__func__,
+				sizeof(struct interrupt_server_node) + len,
+				__alignof__(u32));
+		intserv_node->len = len;
+		memcpy(intserv_node->intserv, intserv, len);
+		intserv_node->avail = avail;
+		list_add_tail(&intserv_node->node, &head);
+
+		if (!found_boot_cpu) {
+			nthreads = len / sizeof(int);
+			for (j = 0 ; j < nthreads; j++) {
+				if (be32_to_cpu(intserv[j]) == boot_cpu_hwid) {
+					bt_node = &intserv_node->node;
+					found_boot_cpu = true;
+					/*
+					 * Record the round-shift between dt
+					 * seq and cpu logical number
+					 */
+					shift = cpu - j;
+					break;
+				}
+
+				cpu++;
+			}
+		}
 
+	}
+	cpu = 0;
+	list_del_init(&head);
+	/* Select the primary thread, the boot cpu's slibing, as the logic 0 */
+	list_add_tail(&head, bt_node);
+	pr_info("the round shift between dt seq and the cpu logic number: %d\n", shift);
+	list_for_each_entry(intserv_node, &head, node) {
+
+		avail = intserv_node->avail;
+		nthreads = intserv_node->len / sizeof(int);
+		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			set_cpu_present(cpu, avail);
 			set_cpu_possible(cpu, true);
-			cpu_to_phys_id[cpu] = be32_to_cpu(intserv[j]);
+			cpu_to_phys_id[cpu] = be32_to_cpu(intserv_node->intserv[j]);
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    j, cpu, be32_to_cpu(intserv_node->intserv[j]));
 			cpu++;
 		}
+	}
 
-		if (cpu >= nr_cpu_ids) {
-			of_node_put(dn);
-			break;
-		}
+	list_for_each_entry_safe(intserv_node, n, &head, node) {
+		len = sizeof(struct interrupt_server_node) + intserv_node->len;
+		memblock_free(intserv_node, len);
 	}
 
 	/* If no SMT supported, nthreads is forced to 1 */
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
