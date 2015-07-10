Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDSIY-0006Ko-TR
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 07:00:42 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] use raw i/o and root device to use less memory
Date: Fri, 10 Jul 2015 06:59:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCDBE9@BPXM01GP.gisp.nec.co.jp>
References: <20150629215921.2A9D9826075@asylum.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DCC9C8@BPXM01GP.gisp.nec.co.jp>
 <20150708225430.GA14035@sgi.com>
In-Reply-To: <20150708225430.GA14035@sgi.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "cpw@sgi.com" <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Hello Kumagai-san,
>
>I had not seen your mail of 5/21 (that you refer to below).  I don't know how
>I missed it.  It was just a coincidence that I decided to fit my patches into
>your current version shortly after that (6/29).

OK, I see.

>I've been testing.  And you have done a nice job of constant memory usage when
>in cyclic mode.  By 'reclaimable' I assume that you mean that you re-use the
>same regions of the same files so that the page cache is not expanded.

No, I meant the direct reclaim mechanism like try_to_free_pages().
When free pages are exhausted, then some 'reclaimable' pages (e.g. page cache)
are reclaimed by kernel to be free. So page cache will consume free pages
temporarily, but it can be used when necessary.

>And indeed I saw no OOM conditions when using cyclic mode within a 450M crashkernel
>region while dumping a 2TB memory.  I haven't had access to a bigger memory yet for
>further tests.
>
>In cyclic mode it writes a 3.5G dump in about 480 seconds.
>
>If I use my proposed -e option (exclude unused page structs) I put makedumpfile
>into non-cyclic mode and immediately get killed by OOM.

It sounds like just the -e option requires additional memory so that OOM
happened. Did you estimate or measure the memory consumption for the -e option ?

>If I use my proposed -j option (use direct i/o for the dump and bit maps) I put
>makedumpfile into non-cyclic mode but do not run out of memory because I'm not
>using page cache or a tmpfs.

I expect that OOM will not happen even if you use page cache in the same condition.
128MB bitmaps are created for 2TB memory, so 450M crash kernel sounds enough
to store the whole bitmaps unless there is another stuff consuming large amounts
of memory.

I don't think page cache is closely related to OOM, I suspect the -e option
as the cause of OOM.

>It writes a 3.5G dump in about 800 seconds.
>So there is definitely a big advantage to cached i/o and cyclic mode.
>
>If I use both -e and -j it writes a 440M dump in 430 seconds.
>This is therefore the fastest way to dump a large memory, even though it is
>using direct i/o.  The -e is causing it to drop 7M unneeded pages from the dump.
>
>What would be really nice is to have a -e option in cyclic mode -- the best
>of both.
>
>It's not very easy to do, however.  I need some pointers to the proper place to
>implement this in cyclic mode.
>If you look at the patch that implements -e
>  [PATCH 2/2] exclude page structures of non-dumped pages
>you will see that find_unused_vmemmap_pages() is comparing the entire map of
>existing pages (bitmap1) and dumpable pages (bitmap2).  From that it derives
>the vmemmap pages that do not really need to be dumped.
>
>I assume that this could be done using the equivalent 2 bit maps at each cycle.
>Do you agree?

Ummm, the buffer size for the -e option looks to be scaled to the number of pfn
in spite of multi cycle processing (cyclic mode), it doesn't match the concept
of cyclic mode. cyclic mode must work on the limited memory space.
 
So I think it would be better to enable the -e option only if there is enough
memory space or --work-dir is specified. Now, in the devel branch, you can
distinguish it by info->flag_cyclic. If info->flag_cyclic is false, it means
the whole bitmaps can be held at one time like old non-cyclic mode.


Thanks
Atsushi Kumagai

>-Cliff
>
>On Tue, Jul 07, 2015 at 07:42:26AM +0000, Atsushi Kumagai wrote:
>> Hello Cliff,
>>
>> Did you overlook my comment below ?
>>
>>  - http://lists.infradead.org/pipermail/kexec/2015-May/013823.html
>>     I understood that you suggested direct I/O to reduce the memory
>>     consumption without multi cycle processing, but I don't understand
>>     the actual benefit yet because page cache is reclaimable and it's
>>     generally usable. Does it practically affect the minimum size of
>>     crashkernel= which makedumpfile can work on ?
>>
>>     Instead, if you say frequent page cache reclaiming will cause performance
>>     regression, it sounds reasonable. However, even from the view point of
>>     performance, page cached I/O is better than direct I/O according to your
>>     test results.
>>
>> Please explain the practical benefit of Direct I/O, otherwise I can't
>> decide to accept this.
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>> >From: Cliff Wickman <cpw@sgi.com>
>> >
>> >Applies to version 1.5.8
>> >
>> >This patch adds a -j to makedumpfile. With this option it uses direct i/o on the dump
>> >file and the bitmap file, thus enabling makedumpfile to run mode in a fairly small
>> >crashkernel area without using cyclic mode. It can dump a system with many terabytes
>> >of memory using crashkernel=450M.
>> >
>> >Without direct i/o the crash kernel will use kernel page cache for the writes.  This
>> >will use up a great deal of the crash kernel's alloted memory.
>> >
>> >The -j option will also implicitly avoid cyclic mode.  Cyclic mode is slower, and
>> >is not needed if we use direct i/o.
>> >Direct i/o is of course a bit slower, but not significantly slower when used in this
>> >almost-entirely sequential fashion.
>> >
>> >---
>> > makedumpfile.c |  419 ++++++++++++++++++++++++++++++++++++++++++++++-----------
>> > makedumpfile.h |    7
>> > print_info.c   |    7
>> > 3 files changed, 352 insertions(+), 81 deletions(-)
>> >
>> >Index: makedumpfile/makedumpfile.h
>> >===================================================================
>> >--- makedumpfile.orig/makedumpfile.h
>> >+++ makedumpfile/makedumpfile.h
>> >@@ -18,6 +18,7 @@
>> >
>> > #include <stdio.h>
>> > #include <stdlib.h>
>> >+#define __USE_GNU
>> > #include <fcntl.h>
>> > #include <gelf.h>
>> > #include <sys/stat.h>
>> >@@ -222,6 +223,7 @@ isAnon(unsigned long mapping)
>> > #define FILENAME_BITMAP		"kdump_bitmapXXXXXX"
>> > #define FILENAME_STDOUT		"STDOUT"
>> > #define MAP_REGION		(4096*1024)
>> >+#define DIRECT_ALIGN		(512)
>> >
>> > /*
>> >  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
>> >@@ -897,7 +899,8 @@ struct dump_bitmap {
>> > 	int		fd;
>> > 	int		no_block;
>> > 	char		*file_name;
>> >-	char		buf[BUFSIZE_BITMAP];
>> >+	char		*buf;
>> >+	char		*buf_malloced;
>> > 	off_t		offset;
>> > };
>> >
>> >@@ -905,6 +908,7 @@ struct cache_data {
>> > 	int	fd;
>> > 	char	*file_name;
>> > 	char	*buf;
>> >+	char    *buf_malloced;
>> > 	size_t	buf_size;
>> > 	size_t	cache_size;
>> > 	off_t	offset;
>> >@@ -1874,6 +1878,7 @@ struct elf_prstatus {
>> > #define OPT_GENERATE_VMCOREINFO 'g'
>> > #define OPT_HELP                'h'
>> > #define OPT_READ_VMCOREINFO     'i'
>> >+#define OPT_DIRECT_IO		'j'
>> > #define OPT_COMPRESS_LZO        'l'
>> > #define OPT_COMPRESS_SNAPPY     'p'
>> > #define OPT_REARRANGE           'R'
>> >Index: makedumpfile/print_info.c
>> >===================================================================
>> >--- makedumpfile.orig/print_info.c
>> >+++ makedumpfile/print_info.c
>> >@@ -58,7 +58,7 @@ print_usage(void)
>> > 	MSG("\n");
>> > 	MSG("Usage:\n");
>> > 	MSG("  Creating DUMPFILE:\n");
>> >-	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
>> >+	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-j] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
>> > 	MSG("    DUMPFILE\n");
>> > 	MSG("\n");
>> > 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
>> >@@ -108,6 +108,11 @@ print_usage(void)
>> > 	MSG("      -E option, because the ELF format does not support compressed data.\n");
>> > 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
>> > 	MSG("\n");
>> >+	MSG("  [-j]:\n");
>> >+	MSG("      Use raw (O_DIRECT) i/o on dump and bitmap files to avoid expanding kernel pagecache.\n");
>> >+	MSG("      This allows the dump of a very large memory within a constricted\n");
>> >+	MSG("      (e.g. 450M) crashkernel space.\n");
>> >+	MSG("\n");
>> > 	MSG("  [-d DL]:\n");
>> > 	MSG("      Specify the type of unnecessary page for analysis.\n");
>> > 	MSG("      Pages of the specified type are not copied to DUMPFILE. The page type\n");
>> >Index: makedumpfile/makedumpfile.c
>> >===================================================================
>> >--- makedumpfile.orig/makedumpfile.c
>> >+++ makedumpfile/makedumpfile.c
>> >@@ -85,8 +85,11 @@ mdf_pfn_t pfn_free;
>> > mdf_pfn_t pfn_hwpoison;
>> >
>> > mdf_pfn_t num_dumped;
>> >+long blocksize;
>> >
>> > int retcd = FAILED;	/* return code */
>> >+// directioflag is rawio on the dumpfile and bitmap file
>> >+int directioflag = 0;
>> >
>> > #define INITIALIZE_LONG_TABLE(table, value) \
>> > do { \
>> >@@ -991,10 +994,17 @@ int
>> > open_dump_file(void)
>> > {
>> > 	int fd;
>> >-	int open_flags = O_RDWR|O_CREAT|O_TRUNC;
>> >+	int open_flags;
>> >
>> >+	if (directioflag)
>> >+		open_flags = O_RDWR|O_CREAT|O_TRUNC|O_DIRECT;
>> >+	else
>> >+		open_flags = O_RDWR|O_CREAT|O_TRUNC;
>> >+
>> >+#if 0
>> > 	if (!info->flag_force)
>> > 		open_flags |= O_EXCL;
>> >+#endif
>> >
>> > 	if (info->flag_flatten) {
>> > 		fd = STDOUT_FILENO;
>> >@@ -1030,12 +1040,40 @@ check_dump_file(const char *path)
>> > int
>> > open_dump_bitmap(void)
>> > {
>> >-	int i, fd;
>> >-	char *tmpname;
>> >-
>> >-	tmpname = getenv("TMPDIR");
>> >-	if (!tmpname)
>> >-		tmpname = "/tmp";
>> >+	int i, fd, flags;
>> >+	char *tmpname, *cp;
>> >+	char prefix[100];
>> >+	int len;
>> >+
>> >+	/* -j: saving memory by doing direct i/o, so also avoid /tmp for the bit map files
>> >+	 *     because /tmp is using tmpfs */
>> >+	if (!directioflag) {
>> >+		tmpname = getenv("TMPDIR");
>> >+		if (!tmpname)
>> >+			tmpname = "/tmp";
>> >+	} else {
>> >+		/* for the crash kernel environment use the prefix of
>> >+ 		   the dump name   e.g. /mnt//var/.... */
>> >+		if (!strchr(info->name_dumpfile,'v')) {
>> >+			printf("no /var found in name_dumpfile %s\n",
>> >+			info->name_dumpfile);
>> >+			exit(1);
>> >+		} else {
>> >+			cp = strchr(info->name_dumpfile,'v');
>> >+			if (strncmp(cp-1, "/var", 4)) {
>> >+				printf("no /var found in name_dumpfile %s\n",
>> >+					info->name_dumpfile);
>> >+				exit(1);
>> >+			}
>> >+		}
>> >+		len = cp - info->name_dumpfile - 1;
>> >+		strncpy(prefix, info->name_dumpfile, len);
>> >+		if (*(prefix + len - 1) == '/')
>> >+			len -= 1;
>> >+		*(prefix + len) = '\0';
>> >+		tmpname = prefix;
>> >+		strcat(tmpname, "/");
>> >+ 	}
>> >
>> > 	if ((info->name_bitmap = (char *)malloc(sizeof(FILENAME_BITMAP) +
>> > 						strlen(tmpname) + 1)) == NULL) {
>> >@@ -1044,9 +1082,12 @@ open_dump_bitmap(void)
>> > 		return FALSE;
>> > 	}
>> > 	strcpy(info->name_bitmap, tmpname);
>> >-	strcat(info->name_bitmap, "/");
>> > 	strcat(info->name_bitmap, FILENAME_BITMAP);
>> >-	if ((fd = mkstemp(info->name_bitmap)) < 0) {
>> >+	if (directioflag)
>> >+		flags = O_RDWR|O_CREAT|O_TRUNC|O_DIRECT;
>> >+	else
>> >+		flags = O_RDWR|O_CREAT|O_TRUNC;
>> >+	if ((fd = open(info->name_bitmap, flags)) < 0) {
>> > 		ERRMSG("Can't open the bitmap file(%s). %s\n",
>> > 		    info->name_bitmap, strerror(errno));
>> > 		return FALSE;
>> >@@ -3020,6 +3061,7 @@ initialize_bitmap_memory(void)
>> > 	struct dump_bitmap *bmp;
>> > 	off_t bitmap_offset;
>> > 	off_t bitmap_len, max_sect_len;
>> >+	char *cp;
>> > 	mdf_pfn_t pfn;
>> > 	int i, j;
>> > 	long block_size;
>> >@@ -3041,7 +3083,14 @@ initialize_bitmap_memory(void)
>> > 	bmp->fd        = info->fd_memory;
>> > 	bmp->file_name = info->name_memory;
>> > 	bmp->no_block  = -1;
>> >-	memset(bmp->buf, 0, BUFSIZE_BITMAP);
>> >+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
>> >+		    strerror(errno));
>> >+		exit(1);
>> >+	}
>> >+	bmp->buf_malloced = cp;
>> >+	bmp->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
>> >+	memset(bmp->buf, 0, blocksize);
>> > 	bmp->offset = bitmap_offset + bitmap_len / 2;
>> > 	info->bitmap_memory = bmp;
>> >
>> >@@ -3053,6 +3102,7 @@ initialize_bitmap_memory(void)
>> > 	if (info->valid_pages == NULL) {
>> > 		ERRMSG("Can't allocate memory for the valid_pages. %s\n",
>> > 		    strerror(errno));
>> >+		free(bmp->buf_malloced);
>> > 		free(bmp);
>> > 		return FALSE;
>> > 	}
>> >@@ -3355,9 +3405,18 @@ out:
>> > void
>> > initialize_bitmap(struct dump_bitmap *bitmap)
>> > {
>> >+	char *cp;
>> >+
>> > 	bitmap->fd        = info->fd_bitmap;
>> > 	bitmap->file_name = info->name_bitmap;
>> > 	bitmap->no_block  = -1;
>> >+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
>> >+		    strerror(errno));
>> >+		exit(1);
>> >+	}
>> >+	bitmap->buf_malloced = cp;
>> >+	bitmap->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
>> > 	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
>> > }
>> >
>> >@@ -3422,9 +3481,9 @@ set_bitmap(struct dump_bitmap *bitmap, m
>> > 	byte = (pfn%PFN_BUFBITMAP)>>3;
>> > 	bit  = (pfn%PFN_BUFBITMAP) & 7;
>> > 	if (val)
>> >-		bitmap->buf[byte] |= 1<<bit;
>> >+		*(bitmap->buf + byte) |= 1<<bit;
>> > 	else
>> >-		bitmap->buf[byte] &= ~(1<<bit);
>> >+		*(bitmap->buf + byte) &= ~(1<<bit);
>> >
>> > 	return TRUE;
>> > }
>> >@@ -3607,6 +3666,29 @@ read_cache(struct cache_data *cd)
>> > 	return TRUE;
>> > }
>> >
>> >+void
>> >+fill_to_offset(struct cache_data *cd, int blocksize)
>> >+{
>> >+	off_t current;
>> >+	long num_blocks;
>> >+	long i;
>> >+
>> >+	current = lseek(cd->fd, 0, SEEK_CUR);
>> >+	if ((cd->offset - current) % blocksize) {
>> >+		printf("ERROR: fill area is %#lx\n", cd->offset - current);
>> >+		exit(1);
>> >+	}
>> >+	if (cd->cache_size < blocksize) {
>> >+		printf("ERROR: cache buf is only %ld\n", cd->cache_size);
>> >+		exit(1);
>> >+	}
>> >+	num_blocks = (cd->offset - current) / blocksize;
>> >+	for (i = 0; i < num_blocks; i++) {
>> >+		write(cd->fd, cd->buf, blocksize);
>> >+	}
>> >+	return;
>> >+}
>> >+
>> > int
>> > is_bigendian(void)
>> > {
>> >@@ -3676,6 +3758,14 @@ write_buffer(int fd, off_t offset, void
>> > int
>> > write_cache(struct cache_data *cd, void *buf, size_t size)
>> > {
>> >+	/* sanity check; do not overflow this buffer */
>> >+	/* (it is of cd->cache_size + info->page_size) */
>> >+	if (size > ((cd->cache_size - cd->buf_size) + info->page_size)) {
>> >+		fprintf(stderr, "write_cache buffer overflow! size %#lx\n",
>> >+			size);
>> >+		exit(1);
>> >+	}
>> >+
>> > 	memcpy(cd->buf + cd->buf_size, buf, size);
>> > 	cd->buf_size += size;
>> >
>> >@@ -3688,6 +3778,8 @@ write_cache(struct cache_data *cd, void
>> >
>> > 	cd->buf_size -= cd->cache_size;
>> > 	memcpy(cd->buf, cd->buf + cd->cache_size, cd->buf_size);
>> >+	if (cd->buf_size)
>> >+		memcpy(cd->buf, cd->buf + cd->cache_size, cd->buf_size);
>> > 	cd->offset += cd->cache_size;
>> > 	return TRUE;
>> > }
>> >@@ -3719,6 +3811,21 @@ write_cache_zero(struct cache_data *cd,
>> > 	return write_cache_bufsz(cd);
>> > }
>> >
>> >+/* flush the full cache to the file */
>> >+int
>> >+write_cache_flush(struct cache_data *cd)
>> >+{
>> >+	if (cd->buf_size == 0)
>> >+		return TRUE;
>> >+	if (cd->buf_size < cd->cache_size) {
>> >+		memset(cd->buf + cd->buf_size, 0, cd->cache_size - cd->buf_size);
>> >+	}
>> >+	cd->buf_size = cd->cache_size;
>> >+	if (!write_cache_bufsz(cd))
>> >+		return FALSE;
>> >+	return TRUE;
>> >+}
>> >+
>> > int
>> > read_buf_from_stdin(void *buf, int buf_size)
>> > {
>> >@@ -4608,11 +4715,19 @@ create_1st_bitmap(void)
>> > {
>> > 	int i;
>> > 	unsigned int num_pt_loads = get_num_pt_loads();
>> >- 	char buf[info->page_size];
>> >+ 	char *buf;
>> > 	mdf_pfn_t pfn, pfn_start, pfn_end, pfn_bitmap1;
>> > 	unsigned long long phys_start, phys_end;
>> > 	struct timeval tv_start;
>> > 	off_t offset_page;
>> >+	char *cp;
>> >+
>> >+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
>> >+		    strerror(errno));
>> >+		exit(1);
>> >+	}
>> >+	buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
>> >
>> > 	if (info->flag_refiltering)
>> > 		return copy_1st_bitmap_from_memory();
>> >@@ -4623,7 +4738,7 @@ create_1st_bitmap(void)
>> > 	/*
>> > 	 * At first, clear all the bits on the 1st-bitmap.
>> > 	 */
>> >-	memset(buf, 0, sizeof(buf));
>> >+	memset(buf, 0, blocksize);
>> >
>> > 	if (lseek(info->bitmap1->fd, info->bitmap1->offset, SEEK_SET) < 0) {
>> > 		ERRMSG("Can't seek the bitmap(%s). %s\n",
>> >@@ -5172,9 +5287,17 @@ int
>> > copy_bitmap(void)
>> > {
>> > 	off_t offset;
>> >-	unsigned char buf[info->page_size];
>> >+	unsigned char *buf;
>> >+	unsigned char *cp;
>> >  	const off_t failed = (off_t)-1;
>> >
>> >+	if ((cp = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
>> >+		    strerror(errno));
>> >+		exit(1);
>> >+	}
>> >+	buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
>> >+
>> > 	offset = 0;
>> > 	while (offset < (info->len_bitmap / 2)) {
>> > 		if (lseek(info->bitmap1->fd, info->bitmap1->offset + offset,
>> >@@ -5183,7 +5306,7 @@ copy_bitmap(void)
>> > 			    info->name_bitmap, strerror(errno));
>> > 			return FALSE;
>> > 		}
>> >-		if (read(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
>> >+		if (read(info->bitmap1->fd, buf, blocksize) != blocksize) {
>> > 			ERRMSG("Can't read the dump memory(%s). %s\n",
>> > 			    info->name_memory, strerror(errno));
>> > 			return FALSE;
>> >@@ -5194,12 +5317,12 @@ copy_bitmap(void)
>> > 			    info->name_bitmap, strerror(errno));
>> > 			return FALSE;
>> > 		}
>> >-		if (write(info->bitmap2->fd, buf, sizeof(buf)) != sizeof(buf)) {
>> >+		if (write(info->bitmap2->fd, buf, blocksize) != blocksize) {
>> > 			ERRMSG("Can't write the bitmap(%s). %s\n",
>> > 		    	info->name_bitmap, strerror(errno));
>> > 			return FALSE;
>> > 		}
>> >-		offset += sizeof(buf);
>> >+		offset += blocksize;
>> > 	}
>> >
>> > 	return TRUE;
>> >@@ -5357,6 +5480,8 @@ void
>> > free_bitmap1_buffer(void)
>> > {
>> > 	if (info->bitmap1) {
>> >+		if (info->bitmap1->buf_malloced)
>> >+			free(info->bitmap1->buf_malloced);
>> > 		free(info->bitmap1);
>> > 		info->bitmap1 = NULL;
>> > 	}
>> >@@ -5366,6 +5491,8 @@ void
>> > free_bitmap2_buffer(void)
>> > {
>> > 	if (info->bitmap2) {
>> >+		if (info->bitmap2->buf_malloced)
>> >+			free(info->bitmap2->buf_malloced);
>> > 		free(info->bitmap2);
>> > 		info->bitmap2 = NULL;
>> > 	}
>> >@@ -5491,25 +5618,31 @@ get_loads_dumpfile(void)
>> > int
>> > prepare_cache_data(struct cache_data *cd)
>> > {
>> >+	char *cp;
>> >+
>> > 	cd->fd         = info->fd_dumpfile;
>> > 	cd->file_name  = info->name_dumpfile;
>> > 	cd->cache_size = info->page_size << info->block_order;
>> > 	cd->buf_size   = 0;
>> > 	cd->buf        = NULL;
>> >
>> >-	if ((cd->buf = malloc(cd->cache_size + info->page_size)) == NULL) {
>> >+	if ((cp = malloc(cd->cache_size + info->page_size + DIRECT_ALIGN)) == NULL) {
>> > 		ERRMSG("Can't allocate memory for the data buffer. %s\n",
>> > 		    strerror(errno));
>> > 		return FALSE;
>> > 	}
>> >+	cd->buf_malloced = cp;
>> >+	cd->buf = cp - ((unsigned long)cp % DIRECT_ALIGN) + DIRECT_ALIGN;
>> > 	return TRUE;
>> > }
>> >
>> > void
>> > free_cache_data(struct cache_data *cd)
>> > {
>> >-	free(cd->buf);
>> >+	if (cd->buf_malloced)
>> >+		free(cd->buf_malloced);
>> > 	cd->buf = NULL;
>> >+	cd->buf_malloced = NULL;
>> > }
>> >
>> > int
>> >@@ -5765,19 +5898,21 @@ out:
>> > }
>> >
>> > int
>> >-write_kdump_header(void)
>> >+write_kdump_header(struct cache_data *cd)
>> > {
>> > 	int ret = FALSE;
>> > 	size_t size;
>> > 	off_t offset_note, offset_vmcoreinfo;
>> >-	unsigned long size_note, size_vmcoreinfo;
>> >+	unsigned long size_note, size_vmcoreinfo, remaining_size_note;
>> >+	unsigned long write_size, room;
>> > 	struct disk_dump_header *dh = info->dump_header;
>> > 	struct kdump_sub_header kh;
>> >-	char *buf = NULL;
>> >+	char *buf = NULL, *cp;
>> >
>> > 	if (info->flag_elf_dumpfile)
>> > 		return FALSE;
>> >
>> >+	/* uses reads of /proc/vmcore */
>> > 	get_pt_note(&offset_note, &size_note);
>> >
>> > 	/*
>> >@@ -5794,6 +5929,7 @@ write_kdump_header(void)
>> > 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
>> > 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
>> > 	memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
>> >+	blocksize = dh->block_size;
>> > 	if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
>> > 		dh->status |= DUMP_DH_COMPRESSED_ZLIB;
>> > #ifdef USELZO
>> >@@ -5806,7 +5942,7 @@ write_kdump_header(void)
>> > #endif
>> >
>> > 	size = sizeof(struct disk_dump_header);
>> >-	if (!write_buffer(info->fd_dumpfile, 0, dh, size, info->name_dumpfile))
>> >+	if (!write_cache(cd, dh, size))
>> > 		return FALSE;
>> >
>> > 	/*
>> >@@ -5862,9 +5998,21 @@ write_kdump_header(void)
>> > 				goto out;
>> > 		}
>> >
>> >-		if (!write_buffer(info->fd_dumpfile, kh.offset_note, buf,
>> >-		    kh.size_note, info->name_dumpfile))
>> >-			goto out;
>> >+		/* the note may be huge, so do this in a loop to not
>> >+		   overflow the cache */
>> >+		remaining_size_note = kh.size_note;
>> >+		cp = buf;
>> >+		do {
>> >+			room = cd->cache_size - cd->buf_size;
>> >+			if (remaining_size_note > room)
>> >+				write_size = room;
>> >+			else
>> >+				write_size = remaining_size_note;
>> >+			if (!write_cache(cd, cp, write_size))
>> >+				goto out;
>> >+			remaining_size_note -= write_size;
>> >+			cp += write_size;
>> >+		} while (remaining_size_note);
>> >
>> > 		if (has_vmcoreinfo()) {
>> > 			get_vmcoreinfo(&offset_vmcoreinfo, &size_vmcoreinfo);
>> >@@ -5880,8 +6028,7 @@ write_kdump_header(void)
>> > 			kh.size_vmcoreinfo = size_vmcoreinfo;
>> > 		}
>> > 	}
>> >-	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
>> >-	    size, info->name_dumpfile))
>> >+	if (!write_cache(cd, &kh, size))
>> > 		goto out;
>> >
>> > 	info->sub_header = kh;
>> >@@ -6631,13 +6778,15 @@ write_elf_pages_cyclic(struct cache_data
>> > }
>> >
>> > int
>> >-write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>> >+write_kdump_pages(struct cache_data *cd_descs, struct cache_data *cd_page)
>> > {
>> > 	mdf_pfn_t pfn, per, num_dumpable;
>> > 	mdf_pfn_t start_pfn, end_pfn;
>> > 	unsigned long size_out;
>> >+	long prefix;
>> > 	struct page_desc pd, pd_zero;
>> > 	off_t offset_data = 0;
>> >+	off_t initial_offset_data;
>> > 	struct disk_dump_header *dh = info->dump_header;
>> > 	unsigned char buf[info->page_size], *buf_out = NULL;
>> > 	unsigned long len_buf_out;
>> >@@ -6645,8 +6794,12 @@ write_kdump_pages(struct cache_data *cd_
>> > 	struct timeval tv_start;
>> > 	const off_t failed = (off_t)-1;
>> > 	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
>> >+	int saved_bytes = 0;
>> >+	int cpysize;
>> >+	char *save_block1, *save_block_cur, *save_block2;
>> >
>> > 	int ret = FALSE;
>> >+	int status;
>> >
>> > 	if (info->flag_elf_dumpfile)
>> > 		return FALSE;
>> >@@ -6688,13 +6841,42 @@ write_kdump_pages(struct cache_data *cd_
>> > 	per = per ? per : 1;
>> >
>> > 	/*
>> >-	 * Calculate the offset of the page data.
>> >+	 * Calculate the offset of the page_desc's and page data.
>> > 	 */
>> >-	cd_header->offset
>> >+	cd_descs->offset
>> > 	    = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
>> > 		* dh->block_size;
>> >-	cd_page->offset = cd_header->offset + sizeof(page_desc_t)*num_dumpable;
>> >-	offset_data  = cd_page->offset;
>> >+
>> >+	/* this is already a pagesize multiple, so well-formed for i/o */
>> >+
>> >+	cd_page->offset = cd_descs->offset + (sizeof(page_desc_t) * num_dumpable);
>> >+	offset_data = cd_page->offset;
>> >+
>> >+	/* for i/o, round this page data offset down to a block boundary */
>> >+	prefix = cd_page->offset % blocksize;
>> >+	cd_page->offset -= prefix;
>> >+	initial_offset_data = cd_page->offset;
>> >+	cd_page->buf_size = prefix;
>> >+	memset(cd_page->buf, 0, prefix);
>> >+
>> >+	fill_to_offset(cd_descs, blocksize);
>> >+
>> >+	if ((save_block1 = malloc(blocksize * 2)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for save block. %s\n",
>> >+		       strerror(errno));
>> >+		goto out;
>> >+	}
>> >+	/* put on block address boundary for well-rounded i/o */
>> >+	save_block1 += (blocksize - (unsigned long)save_block1 % blocksize);
>> >+	save_block_cur = save_block1 + prefix;
>> >+	saved_bytes += prefix;
>> >+	if ((save_block2 = malloc(blocksize + DIRECT_ALIGN)) == NULL) {
>> >+		ERRMSG("Can't allocate memory for save block2. %s\n",
>> >+		       strerror(errno));
>> >+		goto out;
>> >+	}
>> >+	/* put on block address boundary for well-rounded i/o */
>> >+	save_block2 += (DIRECT_ALIGN - (unsigned long)save_block2 % DIRECT_ALIGN);
>> >
>> > 	/*
>> > 	 * Set a fileoffset of Physical Address 0x0.
>> >@@ -6718,6 +6900,14 @@ write_kdump_pages(struct cache_data *cd_
>> > 		memset(buf, 0, pd_zero.size);
>> > 		if (!write_cache(cd_page, buf, pd_zero.size))
>> > 			goto out;
>> >+
>> >+		cpysize = pd_zero.size;
>> >+		if ((saved_bytes + cpysize) > blocksize)
>> >+			cpysize = blocksize - saved_bytes;
>> >+		memcpy(save_block_cur, buf, cpysize);
>> >+		saved_bytes += cpysize;
>> >+		save_block_cur += cpysize;
>> >+
>> > 		offset_data  += pd_zero.size;
>> > 	}
>> > 	if (info->flag_split) {
>> >@@ -6751,7 +6941,7 @@ write_kdump_pages(struct cache_data *cd_
>> > 		 */
>> > 		if ((info->dump_level & DL_EXCLUDE_ZERO)
>> > 		    && is_zero_page(buf, info->page_size)) {
>> >-			if (!write_cache(cd_header, &pd_zero, sizeof(page_desc_t)))
>> >+			if (!write_cache(cd_descs, &pd_zero, sizeof(page_desc_t)))
>> > 				goto out;
>> > 			pfn_zero++;
>> > 			continue;
>> >@@ -6799,25 +6989,68 @@ write_kdump_pages(struct cache_data *cd_
>> > 		/*
>> > 		 * Write the page header.
>> > 		 */
>> >-		if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
>> >+		if (!write_cache(cd_descs, &pd, sizeof(page_desc_t)))
>> > 			goto out;
>> >
>> > 		/*
>> > 		 * Write the page data.
>> > 		 */
>> >+		/* kludge: save the partial block where page desc's and data overlap */
>> >+		/* (this is the second part of the full block (save_block) where
>> >+		    they overlap) */
>> >+		if (saved_bytes < blocksize) {
>> >+			memcpy(save_block_cur, buf, pd.size);
>> >+			saved_bytes += pd.size;
>> >+			save_block_cur += pd.size;
>> >+		}
>> > 		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
>> > 			goto out;
>> > 	}
>> >
>> > 	/*
>> >-	 * Write the remainder.
>> >+	 * Write the remainder (well-formed blocks)
>> > 	 */
>> >-	if (!write_cache_bufsz(cd_page))
>> >-		goto out;
>> >-	if (!write_cache_bufsz(cd_header))
>> >+	/* adjust the cd_descs to write out only full blocks beyond the
>> >+	   data in the buffer */
>> >+	if (cd_descs->buf_size % blocksize) {
>> >+		cd_descs->buf_size +=
>> >+			(blocksize - (cd_descs->buf_size % blocksize));
>> >+		cd_descs->cache_size = cd_descs->buf_size;
>> >+	}
>> >+	if (!write_cache_flush(cd_descs))
>> > 		goto out;
>> >
>> > 	/*
>> >+	 * kludge: the page data will overwrite the last block of the page_desc's,
>> >+	 * so re-construct a block from:
>> >+	 *   the last block of the page_desc's (length 'prefix') (will read into
>> >+	 *   save_block2) and the end (4096-prefix) of the page data we saved in
>> >+	 *   save_block1.
>> >+	 */
>> >+	if (!write_cache_flush(cd_page))
>> >+ 		goto out;
>> >+
>> >+	if (lseek(cd_page->fd, initial_offset_data, SEEK_SET) == failed) {
>> >+		printf("kludge: seek to %#lx, fd %d failed errno %d\n",
>> >+			initial_offset_data, cd_page->fd, errno);
>> >+		exit(1);
>> >+	}
>> >+	if (read(cd_page->fd, save_block2, blocksize) != blocksize) {
>> >+		printf("kludge: read block2 failed\n");
>> >+		exit(1);
>> >+	}
>> >+	/* combine the overlapping parts into save_block1 */
>> >+	memcpy(save_block1, save_block2, prefix);
>> >+
>> >+	if (lseek(cd_page->fd, initial_offset_data, SEEK_SET) == failed) {
>> >+		printf("kludge: seek to %#lx, fd %d failed errno %d\n",
>> >+			initial_offset_data, cd_page->fd, errno);
>> >+		exit(1);
>> >+	}
>> >+	status = write(cd_page->fd, save_block1, blocksize);
>> >+	/* end of kludged block */
>> >+
>> >+	/*
>> > 	 * print [100 %]
>> > 	 */
>> > 	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
>> >@@ -6826,8 +7059,6 @@ write_kdump_pages(struct cache_data *cd_
>> >
>> > 	ret = TRUE;
>> > out:
>> >-	if (buf_out != NULL)
>> >-		free(buf_out);
>> > #ifdef USELZO
>> > 	if (wrkmem != NULL)
>> > 		free(wrkmem);
>> >@@ -7227,51 +7458,47 @@ write_kdump_eraseinfo(struct cache_data
>> > }
>> >
>> > int
>> >-write_kdump_bitmap(void)
>> >+write_kdump_bitmap(struct cache_data *cd)
>> > {
>> > 	struct cache_data bm;
>> > 	long long buf_size;
>> >-	off_t offset;
>> >+	long write_size;
>> >
>> > 	int ret = FALSE;
>> >
>> > 	if (info->flag_elf_dumpfile)
>> > 		return FALSE;
>> >
>> >+	/* set up to read bit map file in big blocks from the start */
>> > 	bm.fd        = info->fd_bitmap;
>> > 	bm.file_name = info->name_bitmap;
>> > 	bm.offset    = 0;
>> > 	bm.buf       = NULL;
>> >-
>> >-	if ((bm.buf = calloc(1, BUFSIZE_BITMAP)) == NULL) {
>> >-		ERRMSG("Can't allocate memory for dump bitmap buffer. %s\n",
>> >-		    strerror(errno));
>> >-		goto out;
>> >+	bm.cache_size = cd->cache_size;
>> >+	bm.buf = cd->buf; /* use the bitmap cd */
>> >+	/* using the dumpfile cd_bitmap buffer and fd */
>> >+	if (lseek(cd->fd, info->offset_bitmap1, SEEK_SET) < 0) {
>> >+		ERRMSG("Can't seek the dump file(%s). %s\n",
>> >+		       info->name_memory, strerror(errno));
>> >+		return FALSE;
>> > 	}
>> >-	offset = info->offset_bitmap1;
>> > 	buf_size = info->len_bitmap;
>> >-
>> > 	while (buf_size > 0) {
>> >-		if (buf_size >= BUFSIZE_BITMAP)
>> >-			bm.cache_size = BUFSIZE_BITMAP;
>> >-		else
>> >-			bm.cache_size = buf_size;
>> >-
>> > 		if(!read_cache(&bm))
>> > 			goto out;
>> >-
>> >-		if (!write_buffer(info->fd_dumpfile, offset,
>> >-		    bm.buf, bm.cache_size, info->name_dumpfile))
>> >-			goto out;
>> >-
>> >-		offset += bm.cache_size;
>> >-		buf_size -= BUFSIZE_BITMAP;
>> >+		write_size = cd->cache_size;
>> >+		if (buf_size < cd->cache_size) {
>> >+			write_size = buf_size;
>> >+		}
>> >+		if (write(cd->fd, cd->buf, write_size) != write_size) {
>> >+			ERRMSG("Can't write a destination file. %s\n",
>> >+				strerror(errno));
>> >+			exit(1);
>> >+		}
>> >+		buf_size -= bm.cache_size;
>> > 	}
>> > 	ret = TRUE;
>> > out:
>> >-	if (bm.buf != NULL)
>> >-		free(bm.buf);
>> >-
>> > 	return ret;
>> > }
>> >
>> >@@ -8362,7 +8589,7 @@ int
>> > writeout_dumpfile(void)
>> > {
>> > 	int ret = FALSE;
>> >-	struct cache_data cd_header, cd_page;
>> >+	struct cache_data cd_header, cd_page_descs, cd_page, cd_bitmap;
>> >
>> > 	info->flag_nospace = FALSE;
>> >
>> >@@ -8375,11 +8602,20 @@ writeout_dumpfile(void)
>> > 	}
>> > 	if (!prepare_cache_data(&cd_header))
>> > 		return FALSE;
>> >+	cd_header.offset = 0;
>> >
>> > 	if (!prepare_cache_data(&cd_page)) {
>> > 		free_cache_data(&cd_header);
>> > 		return FALSE;
>> > 	}
>> >+	if (!prepare_cache_data(&cd_page_descs)) {
>> >+		free_cache_data(&cd_header);
>> >+		free_cache_data(&cd_page);
>> >+		return FALSE;
>> >+	}
>> >+	if (!prepare_cache_data(&cd_bitmap))
>> >+		return FALSE;
>> >+
>> > 	if (info->flag_elf_dumpfile) {
>> > 		if (!write_elf_header(&cd_header))
>> > 			goto out;
>> >@@ -8393,22 +8629,37 @@ writeout_dumpfile(void)
>> > 		if (!write_elf_eraseinfo(&cd_header))
>> > 			goto out;
>> > 	} else if (info->flag_cyclic) {
>> >-		if (!write_kdump_header())
>> >+		if (!write_kdump_header(&cd_header))
>> > 			goto out;
>> >+		write_cache_flush(&cd_header);
>> > 		if (!write_kdump_pages_and_bitmap_cyclic(&cd_header, &cd_page))
>> > 			goto out;
>> > 		if (!write_kdump_eraseinfo(&cd_page))
>> > 			goto out;
>> > 	} else {
>> >-		if (!write_kdump_header())
>> >-			goto out;
>> >-		if (!write_kdump_bitmap())
>> >-			goto out;
>> >-		if (!write_kdump_pages(&cd_header, &cd_page))
>> >-			goto out;
>> >-		if (!write_kdump_eraseinfo(&cd_page))
>> >-			goto out;
>> >-	}
>> >+		/*
>> >+		 * Use cd_header for the caching operation up to the bit map.
>> >+		 * Use cd_bitmap for 1-block (4096) operations on the bit map.
>> >+		 * (it fits between the file header and page_desc's, both of
>> >+		 *  which end and start on block boundaries)
>> >+		 * Then use cd_page_descs and cd_page for page headers and
>> >+		 * data (and eraseinfo).
>> >+		 * Then back to cd_header to fill in the bitmap.
>> >+		 */
>> >+
>> >+		if (!write_kdump_header(&cd_header))
>> >+			goto out;
>> >+		write_cache_flush(&cd_header);
>> >+
>> >+		if (!write_kdump_pages(&cd_page_descs, &cd_page))
>> >+ 			goto out;
>> >+ 		if (!write_kdump_eraseinfo(&cd_page))
>> >+ 			goto out;
>> >+
>> >+		cd_bitmap.offset = info->offset_bitmap1;
>> >+		if (!write_kdump_bitmap(&cd_bitmap))
>> >+ 			goto out;
>> >+ 	}
>> > 	if (info->flag_flatten) {
>> > 		if (!write_end_flat_header())
>> > 			goto out;
>> >@@ -8636,11 +8887,17 @@ create_dumpfile(void)
>> > 		if (!get_elf_info(info->fd_memory, info->name_memory))
>> > 			return FALSE;
>> > 	}
>> >+	blocksize = info->page_size;
>> >+	if (!blocksize)
>> >+		blocksize = sysconf(_SC_PAGE_SIZE);
>> > 	if (!initial())
>> > 		return FALSE;
>> >
>> > 	print_vtop();
>> >
>> >+	if (directioflag)
>> >+		PROGRESS_MSG("Using O_DIRECT i/o for dump and bitmap.\n");
>> >+
>> > 	num_retry = 0;
>> > retry:
>> > 	if (info->flag_refiltering) {
>> >@@ -9736,7 +9993,6 @@ int show_mem_usage(void)
>> > 		return FALSE;
>> > 	}
>> >
>> >-
>> > 	if (!info->flag_cyclic)
>> > 		info->flag_cyclic = TRUE;
>> >
>> >@@ -9795,6 +10051,7 @@ static struct option longopts[] = {
>> > 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
>> > 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
>> > 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
>> >+	{"directio", no_argument, NULL, OPT_DIRECT_IO},
>> > 	{0, 0, 0, 0}
>> > };
>> >
>> >@@ -9828,7 +10085,7 @@ main(int argc, char *argv[])
>> >
>> > 	info->block_order = DEFAULT_ORDER;
>> > 	message_level = DEFAULT_MSG_LEVEL;
>> >-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lpRvXx:", longopts,
>> >+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:jlpRvXx:", longopts,
>> > 	    NULL)) != -1) {
>> > 		switch (opt) {
>> > 		case OPT_BLOCK_ORDER:
>> >@@ -9872,6 +10129,10 @@ main(int argc, char *argv[])
>> > 			info->flag_read_vmcoreinfo = 1;
>> > 			info->name_vmcoreinfo = optarg;
>> > 			break;
>> >+		case OPT_DIRECT_IO:
>> >+			directioflag = 1;
>> >+			info->flag_cyclic = FALSE; // saving memory to avoid cyclic
>> >+			break;
>> > 		case OPT_DISKSET:
>> > 			if (!sadump_add_diskset_info(optarg))
>> > 				goto out;
>> >
>> >_______________________________________________
>> >kexec mailing list
>> >kexec@lists.infradead.org
>> >http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
>--
>Cliff Wickman
>SGI
>cpw@sgi.com
>(651)683-7524 vnet 207524
>(651)482-9347 home

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
