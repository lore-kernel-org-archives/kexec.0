Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOS45-0006Ie-Im
 for kexec@lists.infradead.org; Tue, 24 Sep 2013 12:50:06 +0000
Subject: [PATCH] makedumpfile: fix max_mapnr issue on system has over 44-bit
 addressing
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Tue, 24 Sep 2013 20:49:31 +0800
Message-ID: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
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

This patch will add a new field in struct kdump_sub_header.
unsigned long   max_mapnr;

And the old "unsigned int max_mapnr" in struct disk_dump_header will
not be used anymore. But still be there for compatibility purpose.

This patch will change the header_version to 6.

The corresponding patch for crash utility will be sent out separately.

This patch doesn't change sadump_header.
Because of in sadump file, there is no any sub-header, it has to change
the sadump_header itself.
And if do so, will cause backwards-compatibility issue.
So it could be a separate patch if needed.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 IMPLEMENTATION |    1 +
 diskdump_mod.h |    5 ++++-
 makedumpfile.c |   28 ++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index f0f3135..d576811 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -77,6 +77,7 @@
 	unsigned long	size_note;        /* header_version 4 and later */
 	off_t		offset_eraseinfo; /* header_version 5 and later */
 	unsigned long	size_eraseinfo;   /* header_version 5 and later */
+	unsigned long	max_mapnr;        /* header_version 6 and later */
     };
 
   - 1st-bitmap
diff --git a/diskdump_mod.h b/diskdump_mod.h
index af060b6..30306a5 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -48,7 +48,9 @@ struct disk_dump_header {
 						   header in blocks */
 	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
 						   block */
-	unsigned int		max_mapnr;	/* = max_mapnr */
+	unsigned int		max_mapnr;	/* = max_mapnr, 32bit only,
+						   full 64bit in sub header.
+						   Do not use this anymore! */
 	unsigned int		total_ram_blocks;/* Number of blocks should be
 						   written */
 	unsigned int		device_blocks;	/* Number of total blocks in
@@ -75,6 +77,7 @@ struct kdump_sub_header {
 	unsigned long	size_note;        /* header_version 4 and later */
 	off_t		offset_eraseinfo; /* header_version 5 and later */
 	unsigned long	size_eraseinfo;   /* header_version 5 and later */
+	unsigned long	max_mapnr;        /* header_version 6 and later */
 };
 
 /* page flags */
diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..a444adf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -125,7 +125,7 @@ get_max_mapnr(void)
 	unsigned long long max_paddr;
 
 	if (info->flag_refiltering) {
-		info->max_mapnr = info->dh_memory->max_mapnr;
+		info->max_mapnr = info->kh_memory->max_mapnr;
 		return TRUE;
 	}
 
@@ -783,6 +783,10 @@ get_kdump_compressed_header_info(char *filename)
 		ERRMSG("header does not have dump_level member\n");
 		return FALSE;
 	}
+
+	if (dh.header_version < 6)
+		kh.max_mapnr = dh.max_mapnr;
+
 	DEBUG_MSG("diskdump main header\n");
 	DEBUG_MSG("  signature        : %s\n", dh.signature);
 	DEBUG_MSG("  header_version   : %d\n", dh.header_version);
@@ -790,7 +794,7 @@ get_kdump_compressed_header_info(char *filename)
 	DEBUG_MSG("  block_size       : %d\n", dh.block_size);
 	DEBUG_MSG("  sub_hdr_size     : %d\n", dh.sub_hdr_size);
 	DEBUG_MSG("  bitmap_blocks    : %d\n", dh.bitmap_blocks);
-	DEBUG_MSG("  max_mapnr        : 0x%x\n", dh.max_mapnr);
+	DEBUG_MSG("  max_mapnr(32bit) : 0x%x\n", dh.max_mapnr);
 	DEBUG_MSG("  total_ram_blocks : %d\n", dh.total_ram_blocks);
 	DEBUG_MSG("  device_blocks    : %d\n", dh.device_blocks);
 	DEBUG_MSG("  written_blocks   : %d\n", dh.written_blocks);
@@ -802,6 +806,7 @@ get_kdump_compressed_header_info(char *filename)
 	DEBUG_MSG("  split            : %d\n", kh.split);
 	DEBUG_MSG("  start_pfn        : 0x%lx\n", kh.start_pfn);
 	DEBUG_MSG("  end_pfn          : 0x%lx\n", kh.end_pfn);
+	DEBUG_MSG("  max_mapnr(64bit) : 0x%lx\n", kh.max_mapnr);
 
 	info->dh_memory = malloc(sizeof(dh));
 	if (info->dh_memory == NULL) {
@@ -2766,6 +2771,7 @@ int
 initialize_bitmap_memory(void)
 {
 	struct disk_dump_header	*dh;
+	struct kdump_sub_header *kh;
 	struct dump_bitmap *bmp;
 	off_t bitmap_offset;
 	int bitmap_len, max_sect_len;
@@ -2774,6 +2780,7 @@ initialize_bitmap_memory(void)
 	long block_size;
 
 	dh = info->dh_memory;
+	kh = info->kh_memory;
 	block_size = dh->block_size;
 
 	bitmap_offset
@@ -2793,7 +2800,7 @@ initialize_bitmap_memory(void)
 	bmp->offset = bitmap_offset + bitmap_len / 2;
 	info->bitmap_memory = bmp;
 
-	max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
+	max_sect_len = divideup(kh->max_mapnr, BITMAP_SECT_LEN);
 	info->valid_pages = calloc(sizeof(ulong), max_sect_len);
 	if (info->valid_pages == NULL) {
 		ERRMSG("Can't allocate memory for the valid_pages. %s\n",
@@ -5153,10 +5160,11 @@ write_kdump_header(void)
 	 * Write common header
 	 */
 	strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
-	dh->header_version = 5;
+	dh->header_version = 6;
 	dh->block_size     = info->page_size;
 	dh->sub_hdr_size   = sizeof(kh) + size_note;
 	dh->sub_hdr_size   = divideup(dh->sub_hdr_size, dh->block_size);
+	/* dh->max_mapnr may be truncated here, full 64bit in kh.max_mapnr */
 	dh->max_mapnr      = info->max_mapnr;
 	dh->nr_cpus        = get_nr_cpus();
 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
@@ -5172,6 +5180,7 @@ write_kdump_header(void)
 	 */
 	size = sizeof(struct kdump_sub_header);
 	memset(&kh, 0, size);
+	kh.max_mapnr = info->max_mapnr;
 	kh.phys_base  = info->phys_base;
 	kh.dump_level = info->dump_level;
 	if (info->flag_split) {
@@ -7796,10 +7805,8 @@ store_splitting_info(void)
 
 		if (i == 0) {
 			memcpy(&dh, &tmp_dh, sizeof(tmp_dh));
-			info->max_mapnr = dh.max_mapnr;
 			if (!set_page_size(dh.block_size))
 				return FALSE;
-			DEBUG_MSG("max_mapnr    : %llx\n", info->max_mapnr);
 			DEBUG_MSG("page_size    : %ld\n", info->page_size);
 		}
 
@@ -7816,6 +7823,15 @@ store_splitting_info(void)
 			return FALSE;
 
 		if (i == 0) {
+			if (dh.header_version >= 6)
+				info->max_mapnr = kh.max_mapnr;
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
