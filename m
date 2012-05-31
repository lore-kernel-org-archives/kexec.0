Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZxYo-0000Wl-HC
 for kexec@lists.infradead.org; Thu, 31 May 2012 05:04:36 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V54SZJ009757
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:04:28 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4V54SO24910 for kexec@lists.infradead.org;
 Thu, 31 May 2012 14:04:28 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V54SPi016065
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:04:28 +0900 (JST)
Date: Thu, 31 May 2012 13:56:54 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 4/4] makedumpfile: Add main routine of cyclic processing.
Message-Id: <20120531135654.a26dd3fe.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Implement the function which write bitmap data, page header and page data
cyclically. The function is similar to current write_kdump_XXX().

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |  258 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index d6d4a43..f4b6f83 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5044,6 +5044,153 @@ out:
 	return ret;
 }
 
+int
+write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
+			    struct page_desc *pd_zero, off_t *offset_data)
+{
+ 	unsigned long long pfn, per;
+	unsigned long long start_pfn, end_pfn;
+	unsigned long size_out;
+	struct page_desc pd;
+	unsigned char buf[info->page_size], *buf_out = NULL;
+	unsigned long len_buf_out;
+	struct timeval tv_start;
+	const off_t failed = (off_t)-1;
+
+	int ret = FALSE;
+
+	if (info->flag_elf_dumpfile)
+		return FALSE;
+
+#ifdef USELZO
+	unsigned long len_buf_out_zlib, len_buf_out_lzo;
+	lzo_bytep wrkmem;
+
+	if ((wrkmem = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
+		ERRMSG("Can't allocate memory for the working memory. %s\n",
+		       strerror(errno));
+		goto out;
+	}
+
+	len_buf_out_zlib = compressBound(info->page_size);
+	len_buf_out_lzo = info->page_size + info->page_size / 16 + 64 + 3;
+	len_buf_out = MAX(len_buf_out_zlib, len_buf_out_lzo);
+#else
+	len_buf_out = compressBound(info->page_size);
+#endif
+
+	if ((buf_out = malloc(len_buf_out)) == NULL) {
+		ERRMSG("Can't allocate memory for the compression buffer. %s\n",
+		    strerror(errno));
+		goto out;
+	}
+
+	per = info->num_dumpable / 100;
+
+	/*
+	 * Set a fileoffset of Physical Address 0x0.
+	 */
+	if (lseek(info->fd_memory, get_offset_pt_load_memory(), SEEK_SET)
+	    == failed) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		goto out;
+	}
+
+	gettimeofday(&tv_start, NULL);
+
+	start_pfn = info->split_start_pfn;
+	end_pfn   = info->split_end_pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+
+		if ((num_dumped % per) == 0)
+			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
+
+		/*
+		 * Check the excluded page.
+		 */
+		if (!is_dumpable_cyclic(info->partial_bitmap2, pfn))
+			continue;
+
+		num_dumped++;
+	
+		if (!read_pfn(pfn, buf))
+			goto out;
+
+		/*
+		 * Exclude the page filled with zeros.
+		 */
+		if ((info->dump_level & DL_EXCLUDE_ZERO)
+		    && is_zero_page(buf, info->page_size)) {
+			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
+				goto out;
+			pfn_zero++;
+			continue;
+		}
+		/*
+		 * Compress the page data.
+		 */
+		size_out = len_buf_out;
+		if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
+		    && ((size_out = len_buf_out),
+			compress2(buf_out, &size_out, buf, info->page_size,
+				  Z_BEST_SPEED) == Z_OK)
+		    && (size_out < info->page_size)) {
+			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
+			pd.size  = size_out;
+			memcpy(buf, buf_out, pd.size);
+#ifdef USELZO
+		} else if (info->flag_lzo_support
+			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
+			   && ((size_out = info->page_size),
+			       lzo1x_1_compress(buf, info->page_size, buf_out,
+						&size_out, wrkmem) == LZO_E_OK)
+			   && (size_out < info->page_size)) {
+			pd.flags = DUMP_DH_COMPRESSED_LZO;
+			pd.size  = size_out;
+			memcpy(buf, buf_out, pd.size);
+#endif
+		} else {
+			pd.flags = 0;
+			pd.size  = info->page_size;
+		}
+		pd.page_flags = 0;
+		pd.offset     = *offset_data;
+		*offset_data  += pd.size;
+
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
+
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
+	print_execution_time(PROGRESS_COPY, &tv_start);
+	PROGRESS_MSG("\n");
+
+	ret = TRUE;
+out:
+	if (buf_out != NULL)
+		free(buf_out);
+#ifdef USELZO
+	if (wrkmem != NULL)
+		free(wrkmem);
+#endif
+
+	return ret;
+}
+
 /*
  * Copy eraseinfo from input dumpfile/vmcore to output dumpfile.
  */
@@ -5313,6 +5460,110 @@ out:
 	return ret;
 }
 
+int
+write_kdump_bitmap_cyclic(void)
+{
+	off_t offset;
+
+	int ret = FALSE;
+
+	if (info->flag_elf_dumpfile)
+		return FALSE;
+
+	offset = info->offset_bitmap1;
+	if (!write_buffer(info->fd_dumpfile, offset,
+			  info->partial_bitmap1, BUFSIZE_CYCLIC, info->name_dumpfile))
+		goto out;
+
+	offset += info->len_bitmap / 2;
+	if (!write_buffer(info->fd_dumpfile, offset,
+			  info->partial_bitmap2, BUFSIZE_CYCLIC, info->name_dumpfile))
+		goto out;
+
+	info->offset_bitmap1 += BUFSIZE_CYCLIC;
+
+	ret = TRUE;
+out:
+
+	return ret;
+}
+
+
+int
+write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
+{
+	struct page_desc pd_zero;
+        off_t offset_data=0;
+	struct disk_dump_header *dh = info->dump_header;
+	unsigned char buf[info->page_size];
+
+	/*
+	 * Get number of dumpable pages.
+	 */
+	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
+	     info->split_end_pfn <= info->max_mapnr;
+	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
+
+		info->num_dumpable += get_num_dumpable_cyclic();
+	}
+
+	/*
+	 * Reset counter for debug message.
+	 */
+	pfn_zero =  pfn_cache = pfn_cache_private = pfn_user = pfn_free = 0;
+	pfn_memhole = info->max_mapnr;
+
+	cd_header->offset
+		= (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
+		* dh->block_size;
+	cd_page->offset = cd_header->offset + sizeof(page_desc_t)*info->num_dumpable;
+	offset_data = cd_page->offset;
+
+	/*
+	 * Write the data of zero-filled page.
+	 */
+	if (info->dump_level & DL_EXCLUDE_ZERO) {
+		pd_zero.size = info->page_size;
+		pd_zero.flags = 0;
+		pd_zero.offset = offset_data;
+		pd_zero.page_flags = 0;
+		memset(buf, 0, pd_zero.size);
+		if (!write_cache(cd_page, buf, pd_zero.size))
+			return FALSE;
+		offset_data += pd_zero.size;
+	}
+
+	/*
+	 * Write pages and bitmap cyclically.
+	 */
+	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
+	     info->split_end_pfn <= info->max_mapnr;
+	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
+
+		if (!create_1st_bitmap_cyclic())
+			return FALSE;
+
+		if (!exclude_unnecessary_pages_cyclic())
+			return FALSE;
+
+		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
+			return FALSE;
+
+		if (!write_kdump_bitmap_cyclic())
+			return FALSE;
+	}
+
+	/*
+	 * Write the remainder.
+	 */
+	if (!write_cache_bufsz(cd_page))
+		return FALSE;
+	if (!write_cache_bufsz(cd_header))
+		return FALSE;
+
+	return TRUE;
+}
+
 void
 close_vmcoreinfo(void)
 {
@@ -6090,6 +6341,13 @@ writeout_dumpfile(void)
 			goto out;
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
+	} else if (info->flag_cyclic) {
+		if (!write_kdump_header())
+			goto out;
+		if (!write_kdump_pages_and_bitmap_cyclic(&cd_header, &cd_page))
+			goto out;
+		if (!write_kdump_eraseinfo(&cd_page))
+			goto out;
 	} else {
 		if (!write_kdump_header())
 			goto out;
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
