Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcRDU-0000uX-09
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:22:25 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 6/6] WIP: Remove the old logic of writing kdump pages.
Date: Mon, 30 Mar 2015 04:10:08 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CAD0@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "cpw@sgi.com" <cpw@sgi.com>

write_kdump_pages() is no longer used, remove it.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |  206 --------------------------------------------------------
 1 files changed, 0 insertions(+), 206 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 691d6a5..58ea007 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6617,212 +6617,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 }
 
 int
-write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
-{
-	mdf_pfn_t pfn, per, num_dumpable;
-	mdf_pfn_t start_pfn, end_pfn;
-	unsigned long size_out;
-	struct page_desc pd, pd_zero;
-	off_t offset_data = 0;
-	struct disk_dump_header *dh = info->dump_header;
-	unsigned char buf[info->page_size], *buf_out = NULL;
-	unsigned long len_buf_out;
-	struct dump_bitmap bitmap2;
-	struct timeval tv_start;
-	const off_t failed = (off_t)-1;
-	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
-
-	int ret = FALSE;
-
-	if (info->flag_elf_dumpfile)
-		return FALSE;
-
-	initialize_2nd_bitmap(&bitmap2);
-
-	len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = 0;
-
-#ifdef USELZO
-	lzo_bytep wrkmem;
-
-	if ((wrkmem = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
-		ERRMSG("Can't allocate memory for the working memory. %s\n",
-		       strerror(errno));
-		goto out;
-	}
-
-	len_buf_out_lzo = info->page_size + info->page_size / 16 + 64 + 3;
-#endif
-
-#ifdef USESNAPPY
-	len_buf_out_snappy = snappy_max_compressed_length(info->page_size);
-#endif
-
-	len_buf_out_zlib = compressBound(info->page_size);
-	
-	len_buf_out = MAX(len_buf_out_zlib,
-			  MAX(len_buf_out_lzo,
-			      len_buf_out_snappy));
-
-	if ((buf_out = malloc(len_buf_out)) == NULL) {
-		ERRMSG("Can't allocate memory for the compression buffer. %s\n",
-		    strerror(errno));
-		goto out;
-	}
-
-	num_dumpable = get_num_dumpable();
-	per = num_dumpable / 10000;
-	per = per ? per : 1;
-
-	/*
-	 * Calculate the offset of the page data.
-	 */
-	cd_header->offset
-	    = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
-		* dh->block_size;
-	cd_page->offset = cd_header->offset + sizeof(page_desc_t)*num_dumpable;
-	offset_data  = cd_page->offset;
-
-	/*
-	 * Set a fileoffset of Physical Address 0x0.
-	 */
-	if (lseek(info->fd_memory, get_offset_pt_load_memory(), SEEK_SET)
-	    == failed) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
-		goto out;
-	}
-
-	/*
-	 * Write the data of zero-filled page.
-	 */
-	gettimeofday(&tv_start, NULL);
-	if (info->dump_level & DL_EXCLUDE_ZERO) {
-		pd_zero.size = info->page_size;
-		pd_zero.flags = 0;
-		pd_zero.offset = offset_data;
-		pd_zero.page_flags = 0;
-		memset(buf, 0, pd_zero.size);
-		if (!write_cache(cd_page, buf, pd_zero.size))
-			goto out;
-		offset_data  += pd_zero.size;
-	}
-	if (info->flag_split) {
-		start_pfn = info->split_start_pfn;
-		end_pfn   = info->split_end_pfn;
-	}
-	else {
-		start_pfn = 0;
-		end_pfn   = info->max_mapnr;
-	}
-
-	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-
-		if ((num_dumped % per) == 0)
-			print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
-
-		/*
-		 * Check the excluded page.
-		 */
-		if (!is_dumpable(&bitmap2, pfn, NULL))
-			continue;
-
-		num_dumped++;
-
-		if (!read_pfn(pfn, buf))
-			goto out;
-		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
-
-		/*
-		 * Exclude the page filled with zeros.
-		 */
-		if ((info->dump_level & DL_EXCLUDE_ZERO)
-		    && is_zero_page(buf, info->page_size)) {
-			if (!write_cache(cd_header, &pd_zero, sizeof(page_desc_t)))
-				goto out;
-			pfn_zero++;
-			continue;
-		}
-		/*
-		 * Compress the page data.
-		 */
-		size_out = len_buf_out;
-		if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
-		    && ((size_out = len_buf_out),
-			compress2(buf_out, &size_out, buf, info->page_size,
-				  Z_BEST_SPEED) == Z_OK)
-		    && (size_out < info->page_size)) {
-			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
-			pd.size  = size_out;
-#ifdef USELZO
-		} else if (info->flag_lzo_support
-			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
-			   && ((size_out = info->page_size),
-			       lzo1x_1_compress(buf, info->page_size, buf_out,
-						&size_out, wrkmem) == LZO_E_OK)
-			   && (size_out < info->page_size)) {
-			pd.flags = DUMP_DH_COMPRESSED_LZO;
-			pd.size  = size_out;
-#endif
-#ifdef USESNAPPY
-		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
-			   && ((size_out = len_buf_out_snappy),
-			       snappy_compress((char *)buf, info->page_size,
-					       (char *)buf_out,
-					       (size_t *)&size_out)
-			       == SNAPPY_OK)
-			   && (size_out < info->page_size)) {
-			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
-			pd.size  = size_out;
-#endif
-		} else {
-			pd.flags = 0;
-			pd.size  = info->page_size;
-		}
-		pd.page_flags = 0;
-		pd.offset     = offset_data;
-		offset_data  += pd.size;
-
-		/*
-		 * Write the page header.
-		 */
-		if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
-			goto out;
-
-		/*
-		 * Write the page data.
-		 */
-		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
-			goto out;
-	}
-
-	/*
-	 * Write the remainder.
-	 */
-	if (!write_cache_bufsz(cd_page))
-		goto out;
-	if (!write_cache_bufsz(cd_header))
-		goto out;
-
-	/*
-	 * print [100 %]
-	 */
-	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
-	print_execution_time(PROGRESS_COPY, &tv_start);
-	PROGRESS_MSG("\n");
-
-	ret = TRUE;
-out:
-	if (buf_out != NULL)
-		free(buf_out);
-#ifdef USELZO
-	if (wrkmem != NULL)
-		free(wrkmem);
-#endif
-
-	return ret;
-}
-
-int
 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
 			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
 {
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
