Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R47tD-0007d1-C7
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 09:05:48 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8F95iaF021917
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 09:05:44 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8F95iZA2289784
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 10:05:44 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8F95iFR004605
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 03:05:44 -0600
Message-Id: <20110915090543.690987017@linux.vnet.ibm.com>
Date: Thu, 15 Sep 2011 11:04:42 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 2/2] s390: Add architecture code for unmapping crashkernel
	memory
References: <20110915090440.063421605@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-crash_map_pages.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

This patch implements the crash_map_pages() function for s390.
KEXEC_CRASH_MEM_ALIGN is set to HPAGE_SIZE, in order to support
kernel mappings that use large pages. We also use HPAGE_SIZE alignment
for CONFIG_HUGETLB_PAGE=n in order to have the same 1 MiB alignment on
all s390 systems.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kexec.h    |    3 +++
 arch/s390/kernel/machine_kexec.c |   31 +++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c         |   10 ++++++----
 3 files changed, 40 insertions(+), 4 deletions(-)

--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -36,6 +36,9 @@
 /* Allocate one page for the pdp and the second for the code */
 #define KEXEC_CONTROL_PAGE_SIZE 4096
 
+/* Alignment of crashkernel memory */
+#define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE
+
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -243,6 +243,37 @@ static void __machine_kdump(void *image)
 #endif
 
 /*
+ * Map or unmap crashkernel memory
+ */
+static void crash_map_pages(int enable)
+{
+	unsigned long size = resource_size(&crashk_res);
+
+	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
+	       size % KEXEC_CRASH_MEM_ALIGN);
+	if (enable)
+		vmem_add_mapping(crashk_res.start, size);
+	else
+		vmem_remove_mapping(crashk_res.start, size);
+}
+
+/*
+ * Map crashkernel memory
+ */
+void crash_map_reserved_pages(void)
+{
+	crash_map_pages(1);
+}
+
+/*
+ * Unmap crashkernel memory
+ */
+void crash_unmap_reserved_pages(void)
+{
+	crash_map_pages(0);
+}
+
+/*
  * Give back memory to hypervisor before new kdump is loaded
  */
 static int machine_kexec_prepare_kdump(void)
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -446,6 +446,7 @@ static void __init setup_resources(void)
 		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
 		switch (memory_chunk[i].type) {
 		case CHUNK_READ_WRITE:
+		case CHUNK_CRASHK:
 			res->name = "System RAM";
 			break;
 		case CHUNK_READ_ONLY:
@@ -706,8 +707,8 @@ static void __init reserve_crashkernel(v
 			       &crash_base);
 	if (rc || crash_size == 0)
 		return;
-	crash_base = PAGE_ALIGN(crash_base);
-	crash_size = PAGE_ALIGN(crash_size);
+	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
+	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
 	if (register_memory_notifier(&kdump_mem_nb))
 		return;
 	if (!crash_base)
@@ -727,7 +728,7 @@ static void __init reserve_crashkernel(v
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
-	reserve_kdump_bootmem(crash_base, crash_size, CHUNK_READ_WRITE);
+	reserve_kdump_bootmem(crash_base, crash_size, CHUNK_CRASHK);
 	pr_info("Reserving %lluMB of memory at %lluMB "
 		"for crashkernel (System RAM: %luMB)\n",
 		crash_size >> 20, crash_base >> 20, memory_end >> 20);
@@ -802,7 +803,8 @@ setup_memory(void)
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
 		unsigned long start_chunk, end_chunk, pfn;
 
-		if (memory_chunk[i].type != CHUNK_READ_WRITE)
+		if (memory_chunk[i].type != CHUNK_READ_WRITE &&
+		    memory_chunk[i].type != CHUNK_CRASHK)
 			continue;
 		start_chunk = PFN_DOWN(memory_chunk[i].addr);
 		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
