Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCaHv-00080Z-VB
	for kexec@lists.infradead.org; Thu, 13 May 2010 15:25:29 +0000
Date: Fri, 14 May 2010 00:25:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch] ppc: Fix gamecube build
Message-ID: <20100513152519.GA4143@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Cc: Maxim Uvarov <muvarov@gmail.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

This fixes the kexec-build on ppc32 when
the --game-cube option is supplied to ./configure.
It seems to have bit-rotted a little.

Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ppc/kexec-elf-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-elf-ppc.c	2010-05-14 00:18:25.000000000 +0900
+++ kexec-tools/kexec/arch/ppc/kexec-elf-ppc.c	2010-05-14 00:20:58.000000000 +0900
@@ -162,17 +162,9 @@ int elf_ppc_load(int argc, char **argv,
 	unsigned long max_addr, hole_addr;
 	struct mem_phdr *phdr;
 	size_t size;
-	unsigned long long *rsvmap_ptr;
-	struct bootblock *bb_ptr;
-	unsigned int nr_segments;
-	unsigned long my_kernel, my_dt_offset;
-	unsigned long my_stack, my_backup_start;
 #ifdef CONFIG_PPC64
 	unsigned long toc_addr;
 #endif
-	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
-	unsigned char *seg_buf = NULL;
-	off_t seg_size = 0;
 #ifdef WITH_GAMECUBE
 	int target_is_gamecube = 1;
 	char *arg_buf;
@@ -183,13 +175,21 @@ int elf_ppc_load(int argc, char **argv,
 	unsigned char *setup_start;
 	uint32_t setup_size;
 #else
+	unsigned long long *rsvmap_ptr;
+	struct bootblock *bb_ptr;
+	unsigned int nr_segments;
+	unsigned long my_kernel, my_dt_offset;
+	unsigned long my_stack, my_backup_start;
+	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
+	unsigned char *seg_buf = NULL;
+	off_t seg_size = 0;
 	int target_is_gamecube = 0;
 	unsigned int addr;
 	unsigned long dtb_addr;
+#endif
 #define FIXUP_ENTRYS	(20)
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
-#endif
 	int opt;
 
 	command_line = NULL;
Index: kexec-tools/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-ppc.c	2010-05-14 00:18:25.000000000 +0900
+++ kexec-tools/kexec/arch/ppc/kexec-ppc.c	2010-05-14 00:20:58.000000000 +0900
@@ -26,6 +26,11 @@
 
 #include "config.h"
 
+uint64_t rmo_top;
+unsigned long long crash_base, crash_size;
+unsigned int rtas_base, rtas_size;
+int max_memory_ranges;
+
 #ifdef WITH_GAMECUBE
 #define MAX_MEMORY_RANGES  64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
@@ -46,15 +51,11 @@ static int get_memory_ranges_gc(struct m
 }
 #else
 static int use_new_dtb;
-int max_memory_ranges;
 static int nr_memory_ranges, nr_exclude_ranges;
 static struct memory_range *exclude_range;
 static struct memory_range *memory_range;
 static struct memory_range *base_memory_range;
 static uint64_t memory_max;
-uint64_t rmo_top;
-unsigned long long crash_base, crash_size;
-unsigned int rtas_base, rtas_size;
 
 /*
  * Count the memory nodes under /proc/device-tree and populate the

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
