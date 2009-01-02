Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LIkhn-0008Ix-RB
	for kexec@lists.infradead.org; Fri, 02 Jan 2009 14:08:52 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n02E7Lbm006314
	for <kexec@lists.infradead.org>; Fri, 2 Jan 2009 07:07:21 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n02E8g6M206648
	for <kexec@lists.infradead.org>; Fri, 2 Jan 2009 07:08:42 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n02E8gYk000839
	for <kexec@lists.infradead.org>; Fri, 2 Jan 2009 07:08:42 -0700
Date: Fri, 2 Jan 2009 19:38:42 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: [PATCH] ppc64: Support for relocatable kernel in kexec-tools
Message-ID: <20090102140842.GA24775@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Cc: Simon Horman <horms@verge.net.au>, Milton Miller <miltonm@bga.com>

Support for relocatable kernel in kexec-tools

This patch is based on the  patch sent by Milton Miller with the subject [PATCH 1/2
 kexec-tools] ppc64: new relocatble kernel activation ABI

http://patchwork.ozlabs.org/patch/5378/

Even with the above patch, the relocatable kernel always move to physical
address 0 (ie PHYSICAL_START). Following patch fixes this problem by marking
a local variable to 1 in purgatory during kdump kernel load time (kexec -p).
After a crash, purgatory sets __run_at_load variable location in the kernel
to 1 if the local variable is set to 1. So that the kernel will be running
as a relocatable kernel.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
Signed-off-by: Milton Miller <miltonm@bga.com>
---
 kexec/arch/ppc64/crashdump-ppc64.h |    2 ++
 kexec/arch/ppc64/kexec-elf-ppc64.c |   17 +++++++++++++++++
 purgatory/arch/ppc64/v2wrap.S      |   25 ++++++++++++-------------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index 9608782..be02213 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -23,6 +23,8 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
+#define KERNEL_RUN_AT_ZERO_MAGIC 0x72756e30	/* "run0" */
+
 extern uint64_t crash_base;
 extern uint64_t crash_size;
 extern unsigned int rtas_base;
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index d72550d..870315e 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -93,6 +93,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t my_stack, my_backup_start;
 	uint64_t toc_addr;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
+	unsigned int run_at_load;
 
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
 #define OPT_RAMDISK     (OPT_ARCH_MAX+1)
@@ -307,6 +308,18 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		my_backup_start = info->backup_start;
 		elf_rel_set_symbol(&info->rhdr, "backup_start",
 				&my_backup_start, sizeof(my_backup_start));
+
+		/* Tell relocatable kernel to run at load address
+		 * via word before slave code in purgatory
+		 */
+
+		elf_rel_get_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
+		if (run_at_load == KERNEL_RUN_AT_ZERO_MAGIC)
+			run_at_load = 1;
+			/* else it should be a fixed offset image */
+		elf_rel_set_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
 	}
 
 	/* Set stack address */
@@ -325,10 +338,13 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	my_backup_start = 0;
 	my_stack = 0;
 	toc_addr = 0;
+	run_at_load = 0;
 
 	elf_rel_get_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 	elf_rel_get_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
+	elf_rel_get_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
 	elf_rel_get_symbol(&info->rhdr, "panic_kernel", &my_panic_kernel,
 				sizeof(my_panic_kernel));
 	elf_rel_get_symbol(&info->rhdr, "backup_start", &my_backup_start,
@@ -341,6 +357,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
 	fprintf(stderr, "dt_offset is %llx\n",
 		(unsigned long long)my_dt_offset);
+	fprintf(stderr, "run_at_load flag is %x\n", run_at_load);
 	fprintf(stderr, "panic_kernel is %x\n", my_panic_kernel);
 	fprintf(stderr, "backup_start is %llx\n",
 		(unsigned long long)my_backup_start);
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index f69dad2..78b6eec 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -45,11 +45,14 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
-#define KDUMP_SIGNATURE 0xfeed1234
-
 	.machine ppc64
 	.globl purgatory_start
 purgatory_start:	b	master
+	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c
+run_at_load:
+	.globl run_at_load
+	.long 0
+	.size run_at_load, . - run_at_load
 	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
 slave:	b $
 	.org purgatory_start + 0x100    # ABI: end of copied region
@@ -65,7 +68,6 @@ master:
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
-	mr      18,6            # save kdump flag in reg18
 
 	LOADADDR(6,my_toc)
 	ld      2,0(6)          #setup toc
@@ -96,14 +98,11 @@ master:
 	mtctr	4		# prepare branch too
 	mr      3,16            # restore dt address
 
-	LOADADDR(6,KDUMP_SIGNATURE)
-	cmpd	18,6
-	bne	regular
-	li	7,1
-	std	7,24(4)		# mark kdump flag at kernel
-regular:
-	lwz	7,0(4)		# get the first instruction that we stole
-	stw	7,0(0)		# and put it in the slave loop at 0
-				# skip cache flush, do we care?
-
+	LOADADDR(6,run_at_load) # load the run_at_load address
+	lwz     18,0(6)		# it will be 1 for kdump kernel
+	cmpwi	18,1
+	bne	skip
+	li	7,1		# if its kdump kernel, mark it
+	stw	7,92(4)		# in kernel
+skip:
 	bctr			# start kernel
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
