Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vy8q6-0008Pc-Fs
 for kexec@lists.infradead.org; Tue, 31 Dec 2013 23:35:12 +0000
Date: Tue, 31 Dec 2013 17:34:48 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: [PATCH 1/2] makedumpfile: raw i/o and use of root device
Message-ID: <20131231233448.GA18522@sgi.com>
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
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
To: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

On Tue, Dec 31, 2013 at 05:30:01PM -0600, cpw wrote:

Use O_DIRECT (raw) i/o for the dump and for the bitmaps file, so that writing
to those files does not allocate kernel memory for page cache.

Use the root device for the bitmaps file so that kernel memory is not consumed
for tmpfs.

The pathname for the root device is derived from the path to the dump
directory.

Raw I/O requires well-formed reads and writes. Buffers are aligned on 512-byte
boundaries, lseek's are done to 4096-byte boundaries, and transfers are
multiples of 4096 bytes.

The kludge is to handle the boundary between the part of the file containing
the page descriptors and the last part of the file, containing the page
data.  The data for that boundary area must be assembled into a page buffer and
written with a single write.

This patch is not meant to work in conjunction with cyclic mode. Cyclic mode
is effectively disabled by it, as it is not needed when employing these
methods. The second scan of pages needed by cyclic mode is thus eliminated.

The patch adds -j and -J options to force raw i/o even if there is sufficient
crashkernel memory not to require it.  (see flag_rawdump and flag_rawbitmaps).

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 makedumpfile.c |  501 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 makedumpfile.h |   10 +
 print_info.c   |    8 
 3 files changed, 421 insertions(+), 98 deletions(-)

Index: makedumpfile-1.5.5/makedumpfile.c
===================================================================
--- makedumpfile-1.5.5.orig/makedumpfile.c
+++ makedumpfile-1.5.5/makedumpfile.c
@@ -49,6 +49,8 @@ unsigned long long pfn_free;
 unsigned long long pfn_hwpoison;
 
 unsigned long long num_dumped;
+long blocksize;
+static int plenty_of_memory(void);
 
 int retcd = FAILED;	/* return code */
 
@@ -900,10 +902,17 @@ int
 open_dump_file(void)
 {
 	int fd;
-	int open_flags = O_RDWR|O_CREAT|O_TRUNC;
+	int open_flags;
 
+	if (info->flag_rawdump)
+		open_flags = O_RDWR|O_CREAT|O_TRUNC|O_DIRECT;
+	else
+		open_flags = O_RDWR|O_CREAT|O_TRUNC;
+
+#if 0
 	if (!info->flag_force)
 		open_flags |= O_EXCL;
+#endif
 
 	if (info->flag_flatten) {
 		fd = STDOUT_FILENO;
@@ -939,12 +948,35 @@ check_dump_file(const char *path)
 int
 open_dump_bitmap(void)
 {
-	int i, fd;
-	char *tmpname;
+	int i, fd, flags;
+	char *tmpname, *cp;
+	char prefix[100];
+	int len;
 
+	/* note that /tmp is tmpfs, so it uses crash kernel memory */
 	tmpname = getenv("TMPDIR");
-	if (!tmpname)
-		tmpname = "/tmp";
+	if (!tmpname) {
+		/* use the prefix of the dump name   e.g. /mnt//var/.... */
+		if (!strchr(info->name_dumpfile,'v')) {
+			printf("no /var found in name_dumpfile %s\n",
+				info->name_dumpfile);
+			exit(1);
+		} else {
+			cp = strchr(info->name_dumpfile,'v');
+			if (strncmp(cp-1, "/var", 4)) {
+				printf("no /var found in name_dumpfile %s\n",
+					info->name_dumpfile);
+				exit(1);
+			}
+		}
+		len = cp - info->name_dumpfile - 1;
+		strncpy(prefix, info->name_dumpfile, len);
+		if (*(prefix + len - 1) == '/')
+			len -= 1;
+		*(prefix + len) = '\0';
+		tmpname = prefix;
+		strcat(tmpname, "/");
+	}
 
 	if ((info->name_bitmap = (char *)malloc(sizeof(FILENAME_BITMAP) +
 						strlen(tmpname) + 1)) == NULL) {
@@ -953,9 +985,12 @@ open_dump_bitmap(void)
 		return FALSE;
 	}
 	strcpy(info->name_bitmap, tmpname);
-	strcat(info->name_bitmap, "/");
 	strcat(info->name_bitmap, FILENAME_BITMAP);
-	if ((fd = mkstemp(info->name_bitmap)) < 0) {
+	if (info->flag_rawbitmaps)
+		flags = O_RDWR|O_CREAT|O_TRUNC|O_DIRECT;
+	else
+		flags = O_RDWR|O_CREAT|O_TRUNC;
+	if ((fd = open(info->name_bitmap, flags)) < 0) {
 		ERRMSG("Can't open the bitmap file(%s). %s\n",
 		    info->name_bitmap, strerror(errno));
 		return FALSE;
@@ -2860,6 +2895,7 @@ initialize_bitmap_memory(void)
 	struct dump_bitmap *bmp;
 	off_t bitmap_offset;
 	off_t bitmap_len, max_sect_len;
+	char *cp;
 	unsigned long pfn;
 	int i, j;
 	long block_size;
@@ -2881,7 +2917,14 @@ initialize_bitmap_memory(void)
 	bmp->fd        = info->fd_memory;
 	bmp->file_name = info->name_memory;
 	bmp->no_block  = -1;
-	memset(bmp->buf, 0, BUFSIZE_BITMAP);
+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
+		    strerror(errno));
+		exit(1);
+	}
+	bmp->buf_malloced = cp;
+	bmp->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
+	memset(bmp->buf, 0, blocksize);
 	bmp->offset = bitmap_offset + bitmap_len / 2;
 	info->bitmap_memory = bmp;
 
@@ -2893,6 +2936,7 @@ initialize_bitmap_memory(void)
 	if (info->valid_pages == NULL) {
 		ERRMSG("Can't allocate memory for the valid_pages. %s\n",
 		    strerror(errno));
+		free(bmp->buf_malloced);
 		free(bmp);
 		return FALSE;
 	}
@@ -3075,9 +3119,9 @@ out:
 			unsigned long long free_memory;
 
 			/*
-                        * The buffer size is specified as Kbyte with
-                        * --cyclic-buffer <size> option.
-                        */
+			 * The buffer size is specified as Kbyte with
+			 * --cyclic-buffer <size> option.
+			 */
 			info->bufsize_cyclic <<= 10;
 
 			/*
@@ -3190,7 +3234,7 @@ out:
 		DEBUG_MSG("The kernel doesn't support mmap(),");
 		DEBUG_MSG("read() will be used instead.\n");
 		info->flag_usemmap = MMAP_DISABLE;
-        }
+	}
 
 	return TRUE;
 }
@@ -3198,9 +3242,18 @@ out:
 void
 initialize_bitmap(struct dump_bitmap *bitmap)
 {
+	char *cp;
+
 	bitmap->fd        = info->fd_bitmap;
 	bitmap->file_name = info->name_bitmap;
 	bitmap->no_block  = -1;
+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
+		    strerror(errno));
+		exit(1);
+	}
+	bitmap->buf_malloced = cp;
+	bitmap->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
 	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
 }
 
@@ -3266,9 +3319,9 @@ set_bitmap(struct dump_bitmap *bitmap, u
 	byte = (pfn%PFN_BUFBITMAP)>>3;
 	bit  = (pfn%PFN_BUFBITMAP) & 7;
 	if (val)
-		bitmap->buf[byte] |= 1<<bit;
+		*(bitmap->buf + byte) |= 1<<bit;
 	else
-		bitmap->buf[byte] &= ~(1<<bit);
+		*(bitmap->buf + byte) &= ~(1<<bit);
 
 	return TRUE;
 }
@@ -3444,6 +3497,29 @@ read_cache(struct cache_data *cd)
 	return TRUE;
 }
 
+void
+fill_to_offset(struct cache_data *cd, int blocksize)
+{
+	off_t current;
+	long num_blocks;
+	long i;
+
+	current = lseek(cd->fd, 0, SEEK_CUR);
+	if ((cd->offset - current) % blocksize) {
+		printf("ERROR: fill area is %#lx\n", cd->offset - current);
+		exit(1);
+	}
+	if (cd->cache_size < blocksize) {
+		printf("ERROR: cache buf is only %ld\n", cd->cache_size);
+		exit(1);
+	}
+	num_blocks = (cd->offset - current) / blocksize;
+	for (i = 0; i < num_blocks; i++) {
+		write(cd->fd, cd->buf, blocksize);
+	}
+	return;
+}
+
 int
 is_bigendian(void)
 {
@@ -3513,6 +3589,14 @@ write_buffer(int fd, off_t offset, void 
 int
 write_cache(struct cache_data *cd, void *buf, size_t size)
 {
+	/* sanity check; do not overflow this buffer */
+	/* (it is of cd->cache_size + info->page_size) */
+	if (size > ((cd->cache_size - cd->buf_size) + info->page_size)) {
+		fprintf(stderr, "write_cache buffer overflow! size %#lx\n",
+			size);
+		exit(1);
+	}
+
 	memcpy(cd->buf + cd->buf_size, buf, size);
 	cd->buf_size += size;
 
@@ -3524,7 +3608,8 @@ write_cache(struct cache_data *cd, void 
 		return FALSE;
 
 	cd->buf_size -= cd->cache_size;
-	memcpy(cd->buf, cd->buf + cd->cache_size, cd->buf_size);
+	if (cd->buf_size)
+		memcpy(cd->buf, cd->buf + cd->cache_size, cd->buf_size);
 	cd->offset += cd->cache_size;
 	return TRUE;
 }
@@ -3556,6 +3641,21 @@ write_cache_zero(struct cache_data *cd, 
 	return write_cache_bufsz(cd);
 }
 
+/* flush the full cache to the file */
+int
+write_cache_flush(struct cache_data *cd)
+{
+	if (cd->buf_size == 0)
+		return TRUE;
+	if (cd->buf_size < cd->cache_size) {
+		memset(cd->buf + cd->buf_size, 0, cd->cache_size - cd->buf_size);
+	}
+	cd->buf_size = cd->cache_size;
+	if (!write_cache_bufsz(cd))
+		return FALSE;
+	return TRUE;
+}
+
 int
 read_buf_from_stdin(void *buf, int buf_size)
 {
@@ -4332,11 +4432,19 @@ create_1st_bitmap(void)
 {
 	int i;
 	unsigned int num_pt_loads = get_num_pt_loads();
- 	char buf[info->page_size];
+	char *buf;
 	unsigned long long pfn, pfn_start, pfn_end, pfn_bitmap1;
 	unsigned long long phys_start, phys_end;
 	struct timeval tv_start;
 	off_t offset_page;
+	char *cp;
+
+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
+		    strerror(errno));
+		exit(1);
+	}
+	buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
 
 	if (info->flag_refiltering)
 		return copy_1st_bitmap_from_memory();
@@ -4347,7 +4455,7 @@ create_1st_bitmap(void)
 	/*
 	 * At first, clear all the bits on the 1st-bitmap.
 	 */
-	memset(buf, 0, sizeof(buf));
+	memset(buf, 0, blocksize);
 
 	if (lseek(info->bitmap1->fd, info->bitmap1->offset, SEEK_SET) < 0) {
 		ERRMSG("Can't seek the bitmap(%s). %s\n",
@@ -4796,8 +4904,16 @@ int
 copy_bitmap(void)
 {
 	off_t offset;
-	unsigned char buf[info->page_size];
- 	const off_t failed = (off_t)-1;
+	unsigned char *buf;
+	unsigned char *cp;
+	const off_t failed = (off_t)-1;
+
+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
+		    strerror(errno));
+		exit(1);
+	}
+	buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
 
 	offset = 0;
 	while (offset < (info->len_bitmap / 2)) {
@@ -4807,7 +4923,7 @@ copy_bitmap(void)
 			    info->name_bitmap, strerror(errno));
 			return FALSE;
 		}
-		if (read(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
+		if (read(info->bitmap1->fd, buf, blocksize) != blocksize) {
 			ERRMSG("Can't read the dump memory(%s). %s\n",
 			    info->name_memory, strerror(errno));
 			return FALSE;
@@ -4818,12 +4934,12 @@ copy_bitmap(void)
 			    info->name_bitmap, strerror(errno));
 			return FALSE;
 		}
-		if (write(info->bitmap2->fd, buf, sizeof(buf)) != sizeof(buf)) {
+		if (write(info->bitmap2->fd, buf, blocksize) != blocksize) {
 			ERRMSG("Can't write the bitmap(%s). %s\n",
 		    	info->name_bitmap, strerror(errno));
 			return FALSE;
 		}
-		offset += sizeof(buf);
+		offset += blocksize;
 	}
 
 	return TRUE;
@@ -5013,7 +5129,8 @@ void
 free_bitmap1_buffer(void)
 {
 	if (info->bitmap1) {
-		free(info->bitmap1);
+		if (info->bitmap1->buf_malloced)
+			free(info->bitmap1->buf_malloced);
 		info->bitmap1 = NULL;
 	}
 }
@@ -5022,7 +5139,8 @@ void
 free_bitmap2_buffer(void)
 {
 	if (info->bitmap2) {
-		free(info->bitmap2);
+		if (info->bitmap2->buf_malloced)
+			free(info->bitmap2->buf_malloced);
 		info->bitmap2 = NULL;
 	}
 }
@@ -5030,8 +5148,18 @@ free_bitmap2_buffer(void)
 void
 free_bitmap_buffer(void)
 {
-	free_bitmap1_buffer();
-	free_bitmap2_buffer();
+	if (info->bitmap1) {
+		if (info->bitmap1->buf_malloced)
+			free(info->bitmap1->buf_malloced);
+		free(info->bitmap1);
+		info->bitmap1 = NULL;
+	}
+	if (info->bitmap2) {
+		if (info->bitmap2->buf_malloced)
+			free(info->bitmap2->buf_malloced);
+		free(info->bitmap2);
+		info->bitmap2 = NULL;
+	}
 }
 
 int
@@ -5058,7 +5186,6 @@ create_dump_bitmap(void)
 	} else {
 		if (!prepare_bitmap_buffer())
 			goto out;
-
 		if (!create_1st_bitmap())
 			goto out;
 
@@ -5130,25 +5257,31 @@ get_loads_dumpfile(void)
 int
 prepare_cache_data(struct cache_data *cd)
 {
+	char *cp;
+
 	cd->fd         = info->fd_dumpfile;
 	cd->file_name  = info->name_dumpfile;
 	cd->cache_size = info->page_size << info->block_order;
 	cd->buf_size   = 0;
 	cd->buf        = NULL;
 
-	if ((cd->buf = malloc(cd->cache_size + info->page_size)) == NULL) {
+	if ((cp = malloc(cd->cache_size + info->page_size + DIRECT_ALIGN)) == NULL) {
 		ERRMSG("Can't allocate memory for the data buffer. %s\n",
 		    strerror(errno));
 		return FALSE;
 	}
+	cd->buf_malloced = cp;
+	cd->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
 	return TRUE;
 }
 
 void
 free_cache_data(struct cache_data *cd)
 {
-	free(cd->buf);
+	if (cd->buf_malloced)
+		free(cd->buf_malloced);
 	cd->buf = NULL;
+	cd->buf_malloced = NULL;
 }
 
 int
@@ -5397,19 +5530,21 @@ out:
 }
 
 int
-write_kdump_header(void)
+write_kdump_header(struct cache_data *cd)
 {
 	int ret = FALSE;
 	size_t size;
 	off_t offset_note, offset_vmcoreinfo;
-	unsigned long size_note, size_vmcoreinfo;
+	unsigned long size_note, size_vmcoreinfo, remaining_size_note;
+	unsigned long write_size, room;
 	struct disk_dump_header *dh = info->dump_header;
 	struct kdump_sub_header kh;
-	char *buf = NULL;
+	char *buf = NULL, *cp;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
 
+	/* uses reads of /proc/vmcore */
 	get_pt_note(&offset_note, &size_note);
 
 	/*
@@ -5426,6 +5561,7 @@ write_kdump_header(void)
 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
 	memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
+	blocksize = dh->block_size;
 	if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 		dh->status |= DUMP_DH_COMPRESSED_ZLIB;
 #ifdef USELZO
@@ -5438,7 +5574,7 @@ write_kdump_header(void)
 #endif
 
 	size = sizeof(struct disk_dump_header);
-	if (!write_buffer(info->fd_dumpfile, 0, dh, size, info->name_dumpfile))
+	if (!write_cache(cd, dh, size))
 		return FALSE;
 
 	/*
@@ -5494,9 +5630,21 @@ write_kdump_header(void)
 				goto out;
 		}
 
-		if (!write_buffer(info->fd_dumpfile, kh.offset_note, buf,
-		    kh.size_note, info->name_dumpfile))
-			goto out;
+		/* the note may be huge, so do this in a loop to not
+		   overflow the cache */
+		remaining_size_note = kh.size_note;
+		cp = buf;
+		do {
+			room = cd->cache_size - cd->buf_size;
+			if (remaining_size_note > room)
+				write_size = room;
+			else
+				write_size = remaining_size_note;
+			if (!write_cache(cd, cp, write_size))
+				goto out;
+			remaining_size_note -= write_size;
+			cp += write_size;
+		} while (remaining_size_note);
 
 		if (has_vmcoreinfo()) {
 			get_vmcoreinfo(&offset_vmcoreinfo, &size_vmcoreinfo);
@@ -5512,8 +5660,7 @@ write_kdump_header(void)
 			kh.size_vmcoreinfo = size_vmcoreinfo;
 		}
 	}
-	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
-	    size, info->name_dumpfile))
+	if (!write_cache(cd, &kh, size))
 		goto out;
 
 	info->sub_header = kh;
@@ -6110,13 +6257,15 @@ write_elf_pages_cyclic(struct cache_data
 }
 
 int
-write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
+write_kdump_pages(struct cache_data *cd_descs, struct cache_data *cd_page)
 {
- 	unsigned long long pfn, per, num_dumpable;
+	unsigned long long pfn, per, num_dumpable;
 	unsigned long long start_pfn, end_pfn;
 	unsigned long size_out;
+	long prefix;
 	struct page_desc pd, pd_zero;
 	off_t offset_data = 0;
+	off_t initial_offset_data;
 	struct disk_dump_header *dh = info->dump_header;
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
@@ -6124,8 +6273,12 @@ write_kdump_pages(struct cache_data *cd_
 	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
 	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
+	int saved_bytes = 0;
+	int cpysize;
+	char *save_block1, *save_block_cur, *save_block2;
 
 	int ret = FALSE;
+	int status;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
@@ -6166,13 +6319,41 @@ write_kdump_pages(struct cache_data *cd_
 	per = num_dumpable / 10000;
 
 	/*
-	 * Calculate the offset of the page data.
+	 * Calculate the offset of the page_desc's and page data.
 	 */
-	cd_header->offset
+	cd_descs->offset
 	    = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
 		* dh->block_size;
-	cd_page->offset = cd_header->offset + sizeof(page_desc_t)*num_dumpable;
-	offset_data  = cd_page->offset;
+	/* this is already a pagesize multiple, so well-formed for i/o */
+
+	cd_page->offset = cd_descs->offset + (sizeof(page_desc_t) * num_dumpable);
+	offset_data = cd_page->offset;
+
+	/* for i/o, round this page data offset down to a block boundary */
+	prefix = cd_page->offset % blocksize;
+	cd_page->offset -= prefix;
+	initial_offset_data = cd_page->offset;
+	cd_page->buf_size = prefix;
+	memset(cd_page->buf, 0, prefix);
+
+	fill_to_offset(cd_descs, blocksize);
+
+	if ((save_block1 = malloc(blocksize * 2)) == NULL) {
+		ERRMSG("Can't allocate memory for save block. %s\n",
+		       strerror(errno));
+		goto out;
+	}
+	/* put on block address boundary for well-rounded i/o */
+	save_block1 += (blocksize - (unsigned long)save_block1 % blocksize);
+	save_block_cur = save_block1 + prefix;
+	saved_bytes += prefix;
+	if ((save_block2 = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
+		ERRMSG("Can't allocate memory for save block2. %s\n",
+		       strerror(errno));
+		goto out;
+	}
+	/* put on block address boundary for well-rounded i/o */
+	save_block2 += (DIRECT_ALIGN - (unsigned long)save_block2 % DIRECT_ALIGN);
 
 	/*
 	 * Set a fileoffset of Physical Address 0x0.
@@ -6196,6 +6377,14 @@ write_kdump_pages(struct cache_data *cd_
 		memset(buf, 0, pd_zero.size);
 		if (!write_cache(cd_page, buf, pd_zero.size))
 			goto out;
+
+		cpysize = pd_zero.size;
+		if ((saved_bytes + cpysize) > blocksize)
+			cpysize = blocksize - saved_bytes;
+		memcpy(save_block_cur, buf, cpysize);
+		saved_bytes += cpysize;
+		save_block_cur += cpysize;
+
 		offset_data  += pd_zero.size;
 	}
 	if (info->flag_split) {
@@ -6229,7 +6418,7 @@ write_kdump_pages(struct cache_data *cd_
 		 */
 		if ((info->dump_level & DL_EXCLUDE_ZERO)
 		    && is_zero_page(buf, info->page_size)) {
-			if (!write_cache(cd_header, &pd_zero, sizeof(page_desc_t)))
+			if (!write_cache(cd_descs, &pd_zero, sizeof(page_desc_t)))
 				goto out;
 			pfn_zero++;
 			continue;
@@ -6280,24 +6469,70 @@ write_kdump_pages(struct cache_data *cd_
 		/*
 		 * Write the page header.
 		 */
-		if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
+		if (!write_cache(cd_descs, &pd, sizeof(page_desc_t))) {
+			PROGRESS_MSG(
+				"makedumpfile: write error on page header; dump incomplete\n");
 			goto out;
+		}
 
 		/*
 		 * Write the page data.
 		 */
+		/* kludge: save the partial block where page desc's and data overlap */
+		/* (this is the second part of the full block (save_block) where
+		    they overlap) */
+		if (saved_bytes < blocksize) {
+			memcpy(save_block_cur, buf, pd.size);
+			saved_bytes += pd.size;
+			save_block_cur += pd.size;
+		}
 		if (!write_cache(cd_page, buf, pd.size))
 			goto out;
 	}
 
 	/*
-	 * Write the remainder.
+	 * Write the remainder (well-formed blocks)
 	 */
-	if (!write_cache_bufsz(cd_page))
+	/* adjust the cd_descs to write out only full blocks beyond the
+	   data in the buffer */
+	if (cd_descs->buf_size % blocksize) {
+		cd_descs->buf_size +=
+			(blocksize - (cd_descs->buf_size % blocksize));
+		cd_descs->cache_size = cd_descs->buf_size;
+	}
+	if (!write_cache_flush(cd_descs))
 		goto out;
-	if (!write_cache_bufsz(cd_header))
+
+	/*
+	 * kludge: the page data will overwrite the last block of the page_desc's,
+	 * so re-construct a block from:
+	 *   the last block of the page_desc's (length 'prefix') (will read into
+	 *   save_block2) and the end (4096-prefix) of the page data we saved in
+	 *   save_block1.
+	 */
+	if (!write_cache_flush(cd_page))
 		goto out;
 
+	if (lseek(cd_page->fd, initial_offset_data, SEEK_SET) == failed) {
+		printf("kludge: seek to %#lx, fd %d failed errno %d\n",
+			initial_offset_data, cd_page->fd, errno);
+		exit(1);
+	}
+	if (read(cd_page->fd, save_block2, blocksize) != blocksize) {
+		printf("kludge: read block2 failed\n");
+		exit(1);
+	}
+	/* combine the overlapping parts into save_block1 */
+	memcpy(save_block1, save_block2, prefix);
+
+	if (lseek(cd_page->fd, initial_offset_data, SEEK_SET) == failed) {
+		printf("kludge: seek to %#lx, fd %d failed errno %d\n",
+			initial_offset_data, cd_page->fd, errno);
+		exit(1);
+	}
+	status = write(cd_page->fd, save_block1, blocksize);
+	/* end of kludged block */
+
 	/*
 	 * print [100 %]
 	 */
@@ -6307,8 +6542,6 @@ write_kdump_pages(struct cache_data *cd_
 
 	ret = TRUE;
 out:
-	if (buf_out != NULL)
-		free(buf_out);
 #ifdef USELZO
 	if (wrkmem != NULL)
 		free(wrkmem);
@@ -6456,18 +6689,18 @@ write_kdump_pages_cyclic(struct cache_da
 		pd.offset     = *offset_data;
 		*offset_data  += pd.size;
 
-                /*
-                 * Write the page header.
-                 */
-                if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
-                        goto out;
-
-                /*
-                 * Write the page data.
-                 */
-                if (!write_cache(cd_page, buf, pd.size))
-                        goto out;
-        }
+		/*
+		 * Write the page header.
+		 */
+		if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
+			goto out;
+
+		/*
+		 * Write the page data.
+		 */
+		if (!write_cache(cd_page, buf, pd.size))
+			goto out;
+	}
 
 	ret = TRUE;
 out:
@@ -6704,50 +6937,48 @@ write_kdump_eraseinfo(struct cache_data 
 }
 
 int
-write_kdump_bitmap(void)
+write_kdump_bitmap(struct cache_data *cd)
 {
 	struct cache_data bm;
 	long long buf_size;
-	off_t offset;
+	long write_size;
 
 	int ret = FALSE;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
 
+	/* set up to read bit map file in big blocks from the start */
 	bm.fd        = info->fd_bitmap;
 	bm.file_name = info->name_bitmap;
 	bm.offset    = 0;
-	bm.buf       = NULL;
-
-	if ((bm.buf = calloc(1, BUFSIZE_BITMAP)) == NULL) {
-		ERRMSG("Can't allocate memory for dump bitmap buffer. %s\n",
-		    strerror(errno));
-		goto out;
+	bm.cache_size = cd->cache_size;
+	bm.buf = cd->buf; /* use the bitmap cd */
+	/* using the dumpfile cd_bitmap buffer and fd */
+	if (lseek(cd->fd, info->offset_bitmap1, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the dump file(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
 	}
-	offset = info->offset_bitmap1;
 	buf_size = info->len_bitmap;
 
 	while (buf_size > 0) {
-		if (buf_size >= BUFSIZE_BITMAP)
-			bm.cache_size = BUFSIZE_BITMAP;
-		else
-			bm.cache_size = buf_size;
-
 		if(!read_cache(&bm))
 			goto out;
 
-		if (!write_buffer(info->fd_dumpfile, offset,
-		    bm.buf, bm.cache_size, info->name_dumpfile))
-			goto out;
-
-		offset += bm.cache_size;
-		buf_size -= BUFSIZE_BITMAP;
+		write_size = cd->cache_size;
+		if (buf_size < cd->cache_size) {
+			write_size = buf_size;
+		}
+		if (write(cd->fd, cd->buf, write_size) != write_size) {
+			ERRMSG("Can't write a destination file. %s\n",
+				strerror(errno));
+			exit(1);
+		}
+		buf_size -= bm.cache_size;
 	}
 	ret = TRUE;
 out:
-	if (bm.buf != NULL)
-		free(bm.buf);
 
 	return ret;
 }
@@ -6756,7 +6987,7 @@ int
 write_kdump_bitmap1_cyclic(void)
 {
 	off_t offset;
-        int increment;
+	int increment;
 	int ret = FALSE;
 
 	increment = divideup(info->cyclic_end_pfn - info->cyclic_start_pfn, BITPERBYTE);
@@ -6875,14 +7106,14 @@ write_kdump_pages_and_bitmap_cyclic(stru
 			continue;
 
 		if (!update_cyclic_region(pfn))
-                        return FALSE;
+			return FALSE;
 
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
 			return FALSE;
 
 		if (!write_kdump_bitmap2_cyclic())
 			return FALSE;
-        }
+	}
 
 	/*
 	 * Write the remainder.
@@ -7799,7 +8030,7 @@ int
 writeout_dumpfile(void)
 {
 	int ret = FALSE;
-	struct cache_data cd_header, cd_page;
+	struct cache_data cd_header, cd_page_descs, cd_page, cd_bitmap;
 
 	info->flag_nospace = FALSE;
 
@@ -7812,11 +8043,20 @@ writeout_dumpfile(void)
 	}
 	if (!prepare_cache_data(&cd_header))
 		return FALSE;
+	cd_header.offset = 0;
 
 	if (!prepare_cache_data(&cd_page)) {
 		free_cache_data(&cd_header);
 		return FALSE;
 	}
+	if (!prepare_cache_data(&cd_page_descs)) {
+		free_cache_data(&cd_header);
+		free_cache_data(&cd_page);
+		return FALSE;
+	}
+	if (!prepare_cache_data(&cd_bitmap))
+		return FALSE;
+
 	if (info->flag_elf_dumpfile) {
 		if (!write_elf_header(&cd_header))
 			goto out;
@@ -7830,20 +8070,35 @@ writeout_dumpfile(void)
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
 	} else if (info->flag_cyclic) {
-		if (!write_kdump_header())
+		if (!write_kdump_header(&cd_header))
 			goto out;
 		if (!write_kdump_pages_and_bitmap_cyclic(&cd_header, &cd_page))
 			goto out;
 		if (!write_kdump_eraseinfo(&cd_page))
 			goto out;
 	} else {
-		if (!write_kdump_header())
+
+		/*
+		 * Use cd_header for the caching operation up to the bit map.
+		 * Use cd_bitmap for 1-block (4096) operations on the bit map.
+		 * (it fits between the file header and page_desc's, both of
+		 *  which end and start on block boundaries)
+		 * Then use cd_page_descs and cd_page for page headers and
+		 * data (and eraseinfo).
+		 * Then back to cd_header to fill in the bitmap.
+		 */
+
+		if (!write_kdump_header(&cd_header))
 			goto out;
-		if (!write_kdump_pages(&cd_header, &cd_page))
+		write_cache_flush(&cd_header);
+
+		if (!write_kdump_pages(&cd_page_descs, &cd_page))
 			goto out;
 		if (!write_kdump_eraseinfo(&cd_page))
 			goto out;
-		if (!write_kdump_bitmap())
+
+		cd_bitmap.offset = info->offset_bitmap1;
+		if (!write_kdump_bitmap(&cd_bitmap))
 			goto out;
 	}
 	if (info->flag_flatten) {
@@ -7883,7 +8138,7 @@ setup_splitting(void)
 		}
 		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
 			SPLITTING_END_PFN(i-1) = info->max_mapnr;
-        } else {
+	} else {
 		initialize_2nd_bitmap(&bitmap2);
 
 		pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
@@ -8005,11 +8260,43 @@ create_dumpfile(void)
 		if (!get_elf_info(info->fd_memory, info->name_memory))
 			return FALSE;
 	}
+	blocksize = info->page_size;
+	if (!blocksize)
+		blocksize = sysconf(_SC_PAGE_SIZE);
 	if (!initial())
 		return FALSE;
 
 	print_vtop();
 
+	if (info->flag_rawdump)
+		PROGRESS_MSG("Using O_DIRECT i/o for dump.\n");
+	if (info->flag_rawbitmaps)
+		PROGRESS_MSG("Using O_DIRECT i/o for bitmap.\n");
+	if (plenty_of_memory()) {
+		PROGRESS_MSG("Plenty of memory.\n");
+		info->flag_cyclic = FALSE;
+		if (!info->flag_rawdump)
+			PROGRESS_MSG("Using page cache for bitmap file.\n");
+		if (!info->flag_rawbitmaps)
+			PROGRESS_MSG("Using page cache for dump file.\n");
+	} else {
+		/* memory is restricted; solution is direct i/o */
+		if (!info->flag_rawdump) {
+			info->flag_rawdump = 1;
+			PROGRESS_MSG(
+			"Restricted memory; switching to O_DIRECT i/o for dump.\n");
+		}
+		if (!info->flag_rawbitmaps) {
+			info->flag_rawbitmaps = 1;
+			PROGRESS_MSG(
+			"Restricted memory; switching to O_DIRECT i/o for bitmap.\n");
+		}
+	}
+
+	if (info->flag_cyclic == FALSE) {
+		PROGRESS_MSG("Using non-cyclic mode.\n");
+	}
+
 	num_retry = 0;
 retry:
 	if (info->flag_refiltering) {
@@ -8045,11 +8332,11 @@ retry:
 		 */
 		num_retry++;
 		if ((info->dump_level = get_next_dump_level(num_retry)) < 0)
- 			return FALSE;
+			return FALSE;
 		MSG("Retry to create a dumpfile by dump_level(%d).\n",
 		    info->dump_level);
 		if (!delete_dumpfile())
- 			return FALSE;
+			return FALSE;
 		goto retry;
 	}
 	print_report();
@@ -8911,6 +9198,22 @@ out:
 	return free_size;
 }
 
+/*
+ * Plenty of memory to do a non-cyclic dump.
+ * Default to non-cyclic in this case.
+ */
+static int
+plenty_of_memory(void)
+{
+	unsigned long free_size;
+	unsigned long needed_size;
+
+	free_size = get_free_memory_size();
+	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
+	if (free_size > (needed_size + (10*1024*1024)))
+		return 1;
+	return 0;
+}
 
 /*
  * Choose the lesser value of the two below as the size of cyclic buffer.
@@ -9041,6 +9344,12 @@ main(int argc, char *argv[])
 			info->flag_read_vmcoreinfo = 1;
 			info->name_vmcoreinfo = optarg;
 			break;
+		case OPT_RAWDUMP:
+			info->flag_rawdump = 1;
+			break;
+		case OPT_RAWBITMAPS:
+			info->flag_rawbitmaps = 1;
+			break;
 		case OPT_DISKSET:
 			if (!sadump_add_diskset_info(optarg))
 				goto out;
Index: makedumpfile-1.5.5/makedumpfile.h
===================================================================
--- makedumpfile-1.5.5.orig/makedumpfile.h
+++ makedumpfile-1.5.5/makedumpfile.h
@@ -18,6 +18,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#define __USE_GNU
 #include <fcntl.h>
 #include <gelf.h>
 #include <sys/stat.h>
@@ -215,6 +216,7 @@ isAnon(unsigned long mapping)
 #define FILENAME_BITMAP		"kdump_bitmapXXXXXX"
 #define FILENAME_STDOUT		"STDOUT"
 #define MAP_REGION		(4096*1024)
+#define DIRECT_ALIGN		(512)
 
 /*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
@@ -822,7 +824,8 @@ struct dump_bitmap {
 	int		fd;
 	int		no_block;
 	char		*file_name;
-	char		buf[BUFSIZE_BITMAP];
+	char		*buf;
+	char		*buf_malloced;
 	off_t		offset;
 };
 
@@ -830,6 +833,7 @@ struct cache_data {
 	int	fd;
 	char	*file_name;
 	char	*buf;
+	char	*buf_malloced;
 	size_t	buf_size;
 	size_t	cache_size;
 	off_t	offset;
@@ -911,6 +915,8 @@ struct DumpInfo {
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
+	int		flag_rawdump;        /* use raw i/o for the dump file */
+	int		flag_rawbitmaps;     /* use raw i/o for the bitmaps file */
 	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
 	long		page_size;           /* size of page */
 	long		page_shift;
@@ -1729,6 +1735,8 @@ struct elf_prstatus {
 #define OPT_GENERATE_VMCOREINFO 'g'
 #define OPT_HELP                'h'
 #define OPT_READ_VMCOREINFO     'i'
+#define OPT_RAWDUMP             'j'
+#define OPT_RAWBITMAPS          'J'
 #define OPT_COMPRESS_LZO        'l'
 #define OPT_COMPRESS_SNAPPY     'p'
 #define OPT_REARRANGE           'R'
Index: makedumpfile-1.5.5/print_info.c
===================================================================
--- makedumpfile-1.5.5.orig/print_info.c
+++ makedumpfile-1.5.5/print_info.c
@@ -48,7 +48,7 @@ print_usage(void)
 	MSG("\n");
 	MSG("Usage:\n");
 	MSG("  Creating DUMPFILE:\n");
-	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-j] [-J] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("    DUMPFILE\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
@@ -95,6 +95,12 @@ print_usage(void)
 	MSG("      -E option, because the ELF format does not support compressed data.\n");
 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
 	MSG("\n");
+	MSG("  [-j]:\n");
+	MSG("      Use raw (O_DIRECT) i/o on dump file to avoid expanding kernel pagecache.\n");
+	MSG("\n");
+	MSG("  [-J]:\n");
+	MSG("      Use raw (O_DIRECT) i/o on bitmap file to avoid expanding kernel pagecache.\n");
+	MSG("\n");
 	MSG("  [-d DL]:\n");
 	MSG("      Specify the type of unnecessary page for analysis.\n");
 	MSG("      Pages of the specified type are not copied to DUMPFILE. The page type\n");
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
