Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OOc7D-0001T6-K3
	for kexec@lists.infradead.org; Tue, 15 Jun 2010 19:48:08 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 8B6D78F8084
	for <kexec@lists.infradead.org>; Tue, 15 Jun 2010 12:48:04 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id 6150F7001ADC
	for <kexec@lists.infradead.org>; Tue, 15 Jun 2010 14:48:04 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OOc8N-0005VR-Ki
	for kexec@lists.infradead.org; Tue, 15 Jun 2010 14:49:19 -0500
Subject: [PATCH] kexec: extend for large cpu count and memory
Message-Id: <E1OOc8N-0005VR-Ki@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Tue, 15 Jun 2010 14:49:19 -0500
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


The MAX_MEMORY_RANGES of 64 is too small for a very large NUMA machine.
(A 512 processor SGI UV, for example.)
 Gentlemen,
  You may judge increasing MAX_MEMORY_RANGES to 1024 may be excessive
  and I will not argue against setting it to maybe half of that.  But a large
  number is the easy cure, in lieu of sizing memory_range[] and
  crash_memory_range[] dynamically.

And fix a temporary workaround (hack) in load_crashdump_segments() that
assumes that 16k is sufficient for the size of the crashdump elf header.
This is too small for a machine with a large cpu count. A PT_NOTE is created
in the elf header for each cpu.

And the below fiddling with temp_region is just to prevent compiler warnings.

Diffed against kexec-tools-2.0.1

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 kexec/arch/i386/kexec-x86.h          |    2 +-
 kexec/arch/x86_64/crashdump-x86_64.c |   19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

Index: kexec-tools-2.0.1/kexec/arch/i386/kexec-x86.h
===================================================================
--- kexec-tools-2.0.1.orig/kexec/arch/i386/kexec-x86.h
+++ kexec-tools-2.0.1/kexec/arch/i386/kexec-x86.h
@@ -1,7 +1,7 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
-#define MAX_MEMORY_RANGES 64
+#define MAX_MEMORY_RANGES 1024
 
 enum coretype {
 	CORE_TYPE_UNDEF = 0,
Index: kexec-tools-2.0.1/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools-2.0.1.orig/kexec/arch/x86_64/crashdump-x86_64.c
+++ kexec-tools-2.0.1/kexec/arch/x86_64/crashdump-x86_64.c
@@ -268,6 +268,9 @@ static int exclude_region(int *nr_ranges
 {
 	int i, j, tidx = -1;
 	struct memory_range temp_region;
+	temp_region.start = 0;
+	temp_region.end = 0;
+	temp_region.type = 0;
 
 	for (i = 0; i < (*nr_ranges); i++) {
 		unsigned long long mstart, mend;
@@ -403,6 +406,7 @@ static int delete_memmap(struct memory_r
 				memmap_p[i].end = addr - 1;
 				temp_region.start = addr + size;
 				temp_region.end = mend;
+				temp_region.type = memmap_p[i].type;
 				operation = 1;
 				tidx = i;
 				break;
@@ -580,7 +584,7 @@ int load_crashdump_segments(struct kexec
 				unsigned long max_addr, unsigned long min_base)
 {
 	void *tmp;
-	unsigned long sz, elfcorehdr;
+	unsigned long sz, bufsz, memsz, elfcorehdr;
 	int nr_ranges, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 
@@ -613,9 +617,10 @@ int load_crashdump_segments(struct kexec
 	/* Create elf header segment and store crash image data. */
 	if (crash_create_elf64_headers(info, &elf_info,
 				       crash_memory_range, nr_ranges,
-				       &tmp, &sz,
+				       &tmp, &bufsz,
 				       ELF_CORE_HEADER_ALIGN) < 0)
 		return -1;
+	/* the size of the elf headers allocated is returned in 'bufsz' */
 
 	/* Hack: With some ld versions (GNU ld version 2.14.90.0.4 20030523),
 	 * vmlinux program headers show a gap of two pages between bss segment
@@ -624,9 +629,15 @@ int load_crashdump_segments(struct kexec
 	 * elf core header segment to 16K to avoid being placed in such gaps.
 	 * This is a makeshift solution until it is fixed in kernel.
 	 */
-	elfcorehdr = add_buffer(info, tmp, sz, 16*1024, align, min_base,
+	if (bufsz < (16*1024))
+		/* bufsize is big enough for all the PT_NOTE's and PT_LOAD's */
+		memsz = 16*1024;
+		/* memsz will be the size of the memory hole we look for */
+	else
+		memsz = bufsz;
+	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
-	if (delete_memmap(memmap_p, elfcorehdr, sz) < 0)
+	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
