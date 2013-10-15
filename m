Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VW1Vd-0002un-23
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 10:05:50 +0000
Subject: [PATCH v4] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Tue, 15 Oct 2013 18:05:22 +0800
Message-ID: <20131015100521.7868.62437.stgit@k.asiapacific.hpqcorp.net>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, jingbai.ma@hp.com, usui@mxm.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, ruyang@redhat.com, d.hatayama@jp.fujitsu.com, anderson@redhat.com, chaowang@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, vgoyal@redhat.com, crash-utility@redhat.com

This patch will fix a bug of makedumpfile doesn't work correctly on system
has over 44-bit addressing in compression dump mode.
This bug was posted here:
http://lists.infradead.org/pipermail/kexec/2013-September/009587.html

This patch will add 3 new fields in struct kdump_sub_header.
unsigned long long start_pfn_64;  /* header_version 6 and later */
unsigned long long end_pfn_64;    /* header_version 6 and later */
unsigned long long max_mapnr_64;  /* header_version 6 and later */

And the old "unsigned int max_mapnr" in struct disk_dump_header will
not be used anymore, but still be there for compatibility purpose.

The max_mapnr_64 only exists in strcut kdump_sub_header, and that only
for compressed kdump format, so for ELF format kdump files (non-compressed),
only the max_mapnr is available, so it still may be truncated for addresses
exceed 44bit (above 16TB).

This patch will change the header_version to 6.

The corresponding patch for crash utility can be found here:
http://lists.infradead.org/pipermail/kexec/2013-October/009750.html

This patch doesn't change sadump_header.

Changelog:
v4:
- Do not change max_mapnr_64 in kdump_sub_header in memory for old kernel.

v3:
- Change notes for max_mapnr, start_pfn and end_pfn as obsolete.
- Remove "(32bit)" from debug messages of max_mapnr, start_pfn and end_pfn.
- Set the 32bit start_pfn and end_pfn to UINT_MAX.
- Remove bitmap writting enhancement to another seperate patch.
- Change type of len_bitmap in struct DumpInfo back to unsigned long.

v2:
- Rename max_mapnr in struct kdump_sub_header to max_mapnr_64.
- Change type of max_mapnr_64 from unsigned long to unsigned long long.
  In x86 PAE mode on x86_32 kernel, the address may exceeds 44bit limit.
- Add start_pfn_64, end_pfn_64 for struct kdump_sub_header.
- Only print 64bit start_pfn_64, end_pfn_64 and max_mapnr_64
  debug messages for disk dump header version >= 6.
- Change type of bitmap_len in struct DumpInfo, from unsigned long to
  unsigned long long.
- Enhance bitmap writting function in reassemble_kdump_header().
  Prevent bitmap writting failure if the size of bitmap is too large to
  fit a sigle write.

v1:
- http://lists.infradead.org/pipermail/kexec/2013-September/009662.html


Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
Tested-by: Lisa Mitchell <lisa.mitchell@hp.com>
---
 IMPLEMENTATION |   15 ++++++++++--
 diskdump_mod.h |   15 ++++++++++--
 makedumpfile.c |   68 ++++++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index f0f3135..2f4cfd6 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -48,7 +48,9 @@
                                                    header in blocks */
         unsigned int            bitmap_blocks;  /* Size of Memory bitmap in
                                                    block */
-        unsigned int            max_mapnr;      /* = max_mapnr */
+        unsigned int            max_mapnr;      /* = max_mapnr, OBSOLETE!
+						   32bit only, full 64bit
+						   in sub header. */
         unsigned int            total_ram_blocks;/* Number of blocks should be
                                                    written */
         unsigned int            device_blocks;  /* Number of total blocks in
@@ -69,14 +71,21 @@
         unsigned long   phys_base;
         int             dump_level;     /* header_version 1 and later */
 	int		split;		/* header_version 2 and later */
-	unsigned long	start_pfn;	/* header_version 2 and later */
-	unsigned long	end_pfn;	/* header_version 2 and later */
+	unsigned long	start_pfn;	/* header_version 2 and later,
+					   OBSOLETE! 32bit only, full
+					   64bit in start_pfn_64. */
+	unsigned long	end_pfn;	/* header_version 2 and later,
+					   OBSOLETE! 32bit only, full
+					   64bit in end_pfn_64. */
 	off_t		offset_vmcoreinfo;/* header_version 3 and later */
 	unsigned long	size_vmcoreinfo;  /* header_version 3 and later */
 	off_t		offset_note;      /* header_version 4 and later */
 	unsigned long	size_note;        /* header_version 4 and later */
 	off_t		offset_eraseinfo; /* header_version 5 and later */
 	unsigned long	size_eraseinfo;   /* header_version 5 and later */
+	unsigned long long start_pfn_64;  /* header_version 6 and later */
+	unsigned long long end_pfn_64;	  /* header_version 6 and later */
+	unsigned long long max_mapnr_64;  /* header_version 6 and later */
     };
 
   - 1st-bitmap
diff --git a/diskdump_mod.h b/diskdump_mod.h
index af060b6..7306867 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -48,7 +48,9 @@ struct disk_dump_header {
 						   header in blocks */
 	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
 						   block */
-	unsigned int		max_mapnr;	/* = max_mapnr */
+	unsigned int		max_mapnr;	/* = max_mapnr, OBSOLETE!
+						   32bit only, full 64bit
+						   in sub header. */
 	unsigned int		total_ram_blocks;/* Number of blocks should be
 						   written */
 	unsigned int		device_blocks;	/* Number of total blocks in
@@ -67,14 +69,21 @@ struct kdump_sub_header {
 	unsigned long	phys_base;
 	int		dump_level;	/* header_version 1 and later */
 	int		split;		/* header_version 2 and later */
-	unsigned long	start_pfn;	/* header_version 2 and later */
-	unsigned long	end_pfn;	/* header_version 2 and later */
+	unsigned long	start_pfn;	/* header_version 2 and later,
+					   OBSOLETE! 32bit only, full
+					   64bit in start_pfn_64. */
+	unsigned long	end_pfn;	/* header_version 2 and later,
+					   OBSOLETE! 32bit only, full
+					   64bit in end_pfn_64. */
 	off_t		offset_vmcoreinfo;/* header_version 3 and later */
 	unsigned long	size_vmcoreinfo;  /* header_version 3 and later */
 	off_t		offset_note;      /* header_version 4 and later */
 	unsigned long	size_note;        /* header_version 4 and later */
 	off_t		offset_eraseinfo; /* header_version 5 and later */
 	unsigned long	size_eraseinfo;   /* header_version 5 and later */
+	unsigned long long start_pfn_64;  /* header_version 6 and later */
+	unsigned long long end_pfn_64;	  /* header_version 6 and later */
+	unsigned long long max_mapnr_64;  /* header_version 6 and later */
 };
 
 /* page flags */
diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..b41b1ad 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -23,6 +23,7 @@
 #include <stddef.h>
 #include <ctype.h>
 #include <sys/time.h>
+#include <limits.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -125,7 +126,10 @@ get_max_mapnr(void)
 	unsigned long long max_paddr;
 
 	if (info->flag_refiltering) {
-		info->max_mapnr = info->dh_memory->max_mapnr;
+		if (info->dh_memory->header_version >= 6)
+			info->max_mapnr = info->kh_memory->max_mapnr_64;
+		else
+			info->max_mapnr = info->dh_memory->max_mapnr;
 		return TRUE;
 	}
 
@@ -802,6 +806,12 @@ get_kdump_compressed_header_info(char *filename)
 	DEBUG_MSG("  split            : %d\n", kh.split);
 	DEBUG_MSG("  start_pfn        : 0x%lx\n", kh.start_pfn);
 	DEBUG_MSG("  end_pfn          : 0x%lx\n", kh.end_pfn);
+	if (dh.header_version >= 6) {
+		/* A dumpfile contains full 64bit values. */
+		DEBUG_MSG("  start_pfn_64 : 0x%llx\n", kh.start_pfn_64);
+		DEBUG_MSG("  end_pfn_64 : 0x%llx\n", kh.end_pfn_64);
+		DEBUG_MSG("  max_mapnr_64 : 0x%llx\n", kh.max_mapnr_64);
+	}
 
 	info->dh_memory = malloc(sizeof(dh));
 	if (info->dh_memory == NULL) {
@@ -2766,14 +2776,16 @@ int
 initialize_bitmap_memory(void)
 {
 	struct disk_dump_header	*dh;
+	struct kdump_sub_header *kh;
 	struct dump_bitmap *bmp;
 	off_t bitmap_offset;
-	int bitmap_len, max_sect_len;
+	off_t bitmap_len, max_sect_len;
 	unsigned long pfn;
 	int i, j;
 	long block_size;
 
 	dh = info->dh_memory;
+	kh = info->kh_memory;
 	block_size = dh->block_size;
 
 	bitmap_offset
@@ -2793,7 +2805,10 @@ initialize_bitmap_memory(void)
 	bmp->offset = bitmap_offset + bitmap_len / 2;
 	info->bitmap_memory = bmp;
 
-	max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
+	if (dh->header_version >= 6)
+		max_sect_len = divideup(kh->max_mapnr_64, BITMAP_SECT_LEN);
+	else
+		max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
 	info->valid_pages = calloc(sizeof(ulong), max_sect_len);
 	if (info->valid_pages == NULL) {
 		ERRMSG("Can't allocate memory for the valid_pages. %s\n",
@@ -4705,7 +4720,7 @@ create_2nd_bitmap(void)
 int
 prepare_bitmap_buffer(void)
 {
-	unsigned long tmp;
+	unsigned long long tmp;
 
 	/*
 	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
@@ -4737,7 +4752,7 @@ prepare_bitmap_buffer(void)
 int
 prepare_bitmap_buffer_cyclic(void)
 {
-	unsigned long tmp;
+	unsigned long long tmp;
 
 	/*
 	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
@@ -5153,11 +5168,12 @@ write_kdump_header(void)
 	 * Write common header
 	 */
 	strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
-	dh->header_version = 5;
+	dh->header_version = 6;
 	dh->block_size     = info->page_size;
 	dh->sub_hdr_size   = sizeof(kh) + size_note;
 	dh->sub_hdr_size   = divideup(dh->sub_hdr_size, dh->block_size);
-	dh->max_mapnr      = info->max_mapnr;
+	/* dh->max_mapnr may be truncated, full 64bit in kh.max_mapnr_64 */
+	dh->max_mapnr      = MIN(info->max_mapnr, UINT_MAX);
 	dh->nr_cpus        = get_nr_cpus();
 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
@@ -5172,12 +5188,21 @@ write_kdump_header(void)
 	 */
 	size = sizeof(struct kdump_sub_header);
 	memset(&kh, 0, size);
+	/* 64bit max_mapnr_64 */
+	kh.max_mapnr_64 = info->max_mapnr;
 	kh.phys_base  = info->phys_base;
 	kh.dump_level = info->dump_level;
 	if (info->flag_split) {
 		kh.split = 1;
-		kh.start_pfn = info->split_start_pfn;
-		kh.end_pfn   = info->split_end_pfn;
+		/* start_pfn and end_pfn may be truncated,
+		 * only for compatibility purpose
+		 */
+		kh.start_pfn = MIN(info->split_start_pfn, UINT_MAX);
+		kh.end_pfn   = MIN(info->split_end_pfn, UINT_MAX);
+
+		/* 64bit start_pfn_64 and end_pfn_64 */
+		kh.start_pfn_64 = info->split_start_pfn;
+		kh.end_pfn_64   = info->split_end_pfn;
 	}
 	if (has_pt_note()) {
 		/*
@@ -6421,7 +6446,7 @@ int
 write_kdump_bitmap(void)
 {
 	struct cache_data bm;
-	long buf_size;
+	long long buf_size;
 	off_t offset;
 
 	int ret = FALSE;
@@ -7796,10 +7821,8 @@ store_splitting_info(void)
 
 		if (i == 0) {
 			memcpy(&dh, &tmp_dh, sizeof(tmp_dh));
-			info->max_mapnr = dh.max_mapnr;
 			if (!set_page_size(dh.block_size))
 				return FALSE;
-			DEBUG_MSG("max_mapnr    : %llx\n", info->max_mapnr);
 			DEBUG_MSG("page_size    : %ld\n", info->page_size);
 		}
 
@@ -7816,11 +7839,26 @@ store_splitting_info(void)
 			return FALSE;
 
 		if (i == 0) {
+			if (dh.header_version >= 6)
+				info->max_mapnr = kh.max_mapnr_64;
+			else
+				info->max_mapnr = dh.max_mapnr;
+
+			DEBUG_MSG("max_mapnr    : %llx\n", info->max_mapnr);
+		}
+
+		if (i == 0) {
 			info->dump_level = kh.dump_level;
 			DEBUG_MSG("dump_level   : %d\n", info->dump_level);
 		}
-		SPLITTING_START_PFN(i) = kh.start_pfn;
-		SPLITTING_END_PFN(i)   = kh.end_pfn;
+
+		if (dh.header_version >= 6) {
+			SPLITTING_START_PFN(i) = kh.start_pfn_64;
+			SPLITTING_END_PFN(i)   = kh.end_pfn_64;
+		} else {
+			SPLITTING_START_PFN(i) = kh.start_pfn;
+			SPLITTING_END_PFN(i)   = kh.end_pfn;
+		}
 		SPLITTING_OFFSET_EI(i) = kh.offset_eraseinfo;
 		SPLITTING_SIZE_EI(i)   = kh.size_eraseinfo;
 	}
@@ -7981,6 +8019,8 @@ reassemble_kdump_header(void)
 	kh.split = 0;
 	kh.start_pfn = 0;
 	kh.end_pfn   = 0;
+	kh.start_pfn_64 = 0;
+	kh.end_pfn_64 = 0;
 
 	if (lseek(info->fd_dumpfile, info->page_size, SEEK_SET) < 0) {
 		ERRMSG("Can't seek a file(%s). %s\n",


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
