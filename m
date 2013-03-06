Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD8hR-0006xZ-1H
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 07:23:43 +0000
Date: Wed, 6 Mar 2013 15:48:04 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC] makedumpfile: Improve reading speed with mmap()
Message-Id: <20130306154804.00650801c5973637e6a5c82d@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, lisa.mitchell@hp.com, cpw@sgi.com, vgoyal@redhat.com

Hello,

I made the prototype patch to use mmap() on /proc/vmcore for
benchmarking.

This patch simply replaces read(2) with mmap(2), I think we can see
the pure performance improvement by reducing the number of map/unmap.

  - When /proc/vmcore supports mmap(), readmem() calls read_with_mmap() 
    to read /proc/vmcore with mmap() instead of read().

  - Introduce --map-size <Kbyte> option to specify the map size.
    This option is necessary to use mmap() in this patch, but just for
    benchmarking. I'll remove this option in release version and change
    the map size into suitable constant size to get enough performance
    improvement.

  - This patch is based on devel branch:
    http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/devel

Unfortunately, I haven't done test and benchmarking in 2nd kernel yet
because I can't start up newer kernel as 2nd kernel on my machine.
(It seems just my environment issue.) 

At least, this patch works for vmcores saved on local disk,
so it will work in 2nd kernel too.

If anyone helps to do benchmarking, it's very helpful for me.
And any comments for this patch are welcome.


Thanks
Atsushi Kumagai


From f981fdf73cdcdef42831b655548e284eae21a4f9 Mon Sep 17 00:00:00 2001
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Tue, 26 Feb 2013 14:56:26 +0900
Subject: [PATCH] [RFC] Improve reading speed with mmap().

If /proc/vmcore supports mmap(2), then makedumpfile reads it
with mmap(2). Otherwise, read /proc/vmcore with read(2) as usual.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 makedumpfile.h |  10 +++++
 2 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 14e8773..3351158 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -232,6 +232,83 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 }
 
 static int
+update_mmap_range(off_t offset) {
+	off_t start_offset;
+	off_t map_size;
+	off_t max_offset = info->max_mapnr * info->page_size;
+
+	munmap(info->mmap_buf,
+	       info->mmap_end_offset - info->mmap_start_offset);
+
+	/*
+	 * offset for mmap() must be page aligned.
+	 */
+	start_offset = round(offset, info->page_size);
+
+	map_size = MIN(max_offset - start_offset, info->mmap_region_size);
+
+	info->mmap_buf = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE,
+				     info->fd_memory, start_offset);
+
+	if (info->mmap_buf == MAP_FAILED) {
+		ERRMSG("Can't map [%llx-%llx] with mmap()\n %s",
+		       (ulonglong)start_offset,
+		       (ulonglong)(start_offset + map_size),
+		       strerror(errno));
+		return FALSE;
+	}
+
+	info->mmap_start_offset = start_offset;
+	info->mmap_end_offset = start_offset + map_size;
+
+	return TRUE;
+}
+
+static int
+is_mapped_with_mmap(off_t offset) {
+
+	if (info->flag_usemmap
+	    && offset >= info->mmap_start_offset
+	    && offset < info->mmap_end_offset)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+int
+initialize_mmap(void) {
+	info->mmap_buf = MAP_FAILED;
+	if (!update_mmap_range(0))
+		return FALSE;
+
+	return TRUE;
+}
+
+static int
+read_with_mmap(off_t offset, void *bufptr, unsigned long size) {
+	size_t read_size;
+
+next_region:
+
+	if (!is_mapped_with_mmap(offset))
+		update_mmap_range(offset);
+
+	read_size = MIN(info->mmap_end_offset - offset, size);
+
+	memcpy(bufptr, info->mmap_buf +
+	       (offset - info->mmap_start_offset), read_size);
+
+	offset += read_size;
+	bufptr += read_size;
+	size -= read_size;
+
+	if (size > 0)
+		goto next_region;
+
+	return TRUE;
+}
+
+static int
 readpage_elf(unsigned long long paddr, void *bufptr)
 {
 	const off_t failed = (off_t)-1;
@@ -243,16 +320,20 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 		return FALSE;
 	}
 
-	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
-		       info->name_memory, (unsigned long long)offset, strerror(errno));
-		return FALSE;
-	}
+	if (info->flag_usemmap)
+		read_with_mmap(offset, bufptr, info->page_size);
+	else {
+		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+			ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
+			       info->name_memory, (unsigned long long)offset, strerror(errno));
+			return FALSE;
+		}
 
-	if (read(info->fd_memory, bufptr, info->page_size) != info->page_size) {
-		ERRMSG("Can't read the dump memory(%s). %s\n",
-		       info->name_memory, strerror(errno));
-		return FALSE;
+		if (read(info->fd_memory, bufptr, info->page_size) != info->page_size) {
+			ERRMSG("Can't read the dump memory(%s). %s\n",
+			       info->name_memory, strerror(errno));
+			return FALSE;
+		}
 	}
 
 	return TRUE;
@@ -2875,6 +2956,19 @@ out:
 	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
 		setup_page_is_buddy();
 
+	if (info->mmap_region_size > 0 && initialize_mmap()) {
+		/*
+		 * The map size is specified as Kbyte with
+		 * --map-size <size> option.
+		 */
+		info->mmap_region_size <<= 10;
+		info->flag_usemmap = TRUE;
+		DEBUG_MSG("read %s with mmap()\n", info->name_memory);
+	} else {
+		info->flag_usemmap = FALSE;
+		DEBUG_MSG("read %s with read()\n", info->name_memory);
+	}
+
 	return TRUE;
 }
 
@@ -8423,6 +8517,7 @@ static struct option longopts[] = {
 	{"non-cyclic", no_argument, NULL, 'Y'},
 	{"cyclic-buffer", required_argument, NULL, 'Z'},
 	{"eppic", required_argument, NULL, 'S'},
+	{"map-size", required_argument, NULL, 'A'},
 	{0, 0, 0, 0}
 };
 
@@ -8454,6 +8549,9 @@ main(int argc, char *argv[])
 	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
+		case 'A':
+			info->mmap_region_size = atoi(optarg);
+			break;
 		case 'b':
 			info->block_order = atoi(optarg);
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index de329f3..25a6439 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -31,6 +31,7 @@
 #include <libelf.h>
 #include <byteswap.h>
 #include <getopt.h>
+#include <sys/mman.h>
 #ifdef USELZO
 #include <lzo/lzo1x.h>
 #endif
@@ -886,6 +887,7 @@ struct DumpInfo {
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
   	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
+	int		flag_usemmap;	     /* /proc/vmcore supports mmap(2) */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
 	int		flag_force;	     /* overwrite existing stuff */
@@ -1041,6 +1043,14 @@ struct DumpInfo {
 	unsigned long      pfn_cyclic;
 
 	/*
+	 * for mmap
+	 */
+	char	*mmap_buf;
+	off_t	mmap_start_offset;
+	off_t	mmap_end_offset;
+	off_t	mmap_region_size;
+
+	/*
 	 * sadump info:
 	 */
 	int flag_sadump_diskset;
-- 
1.8.1.4

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
