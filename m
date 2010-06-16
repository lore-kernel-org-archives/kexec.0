Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OOslY-0007a3-Sa
	for kexec@lists.infradead.org; Wed, 16 Jun 2010 13:34:54 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 0DEAC8F80CD
	for <kexec@lists.infradead.org>; Wed, 16 Jun 2010 06:34:52 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id D6F64700193B
	for <kexec@lists.infradead.org>; Wed, 16 Jun 2010 08:34:51 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OOsmn-0001CG-Pk
	for kexec@lists.infradead.org; Wed, 16 Jun 2010 08:36:09 -0500
Subject: [PATCH] kexec: extend for large cpu count and memory
Message-Id: <E1OOsmn-0001CG-Pk@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 16 Jun 2010 08:36:09 -0500
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


Simon,
  per your reply to my first version
  > Could you provide a diff against the current git tree?
  done
  > In particular, I think that the temp_region fiddling has already been done.
  dropped from this patch

The MAX_MEMORY_RANGES of 64 is too small for a very large NUMA machine.
(A 512 processor SGI UV, for example.)

And fix a temporary workaround (hack) in load_crashdump_segments() that
assumes that 16k is sufficient for the size of the crashdump elf header.
This is too small for a machine with a large cpu count. A PT_NOTE is created
in the elf header for each cpu.

Diffed against git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 kexec/arch/i386/kexec-x86.h          |    2 +-
 kexec/arch/x86_64/crashdump-x86_64.c |   15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

Index: kexec-tools/kexec/arch/i386/kexec-x86.h
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-x86.h
+++ kexec-tools/kexec/arch/i386/kexec-x86.h
@@ -1,7 +1,7 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
-#define MAX_MEMORY_RANGES 64
+#define MAX_MEMORY_RANGES 1024
 
 enum coretype {
 	CORE_TYPE_UNDEF = 0,
Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.c
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
@@ -591,7 +591,7 @@ int load_crashdump_segments(struct kexec
 				unsigned long max_addr, unsigned long min_base)
 {
 	void *tmp;
-	unsigned long sz, elfcorehdr;
+	unsigned long sz, bufsz, memsz, elfcorehdr;
 	int nr_ranges, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 
@@ -637,9 +637,10 @@ int load_crashdump_segments(struct kexec
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
@@ -648,9 +649,15 @@ int load_crashdump_segments(struct kexec
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
