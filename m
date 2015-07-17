Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFz0n-0003hZ-UG
 for kexec@lists.infradead.org; Fri, 17 Jul 2015 06:20:47 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2] makedumpfile: Fix a bug in generating incomplete
 kdump core
Date: Fri, 17 Jul 2015 06:18:14 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCF7A9@BPXM01GP.gisp.nec.co.jp>
References: <1436949924-31027-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1436949924-31027-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Zhou,

>In current implementation, there is a bug in generating incomplete
>kdump core.
>The current implementation behaves as the following:
>
>1. Write page header into the buffer cd_header.
>2. If cd_header is full, flush the cd_header.
>3. Write page data into the buffer cd_page.
>4. If cd_page is full, flush the cd_page.
>
>When ENOSPC occurs in flushing cd_page, there's still data left in
>cd_header. We cannot read page data corresponding to the page
>headers in the cd_header even if the page data has been flushed into
>disk. The size of page data is 170 times larger than the size of
>page header per a single page frame. The difference becomes bigger
>if we use compression.
>
>The patch fixs the bug by changing the logic and the new logic is:
>
>1. Before writing page header and data into buffers, if either of the
>   buffers will be full, write the data of the buffer into file.
>2. When enospc occurs in writing the cd_header into file, fill the
>   cd_header with zero and re-write the cd_header.
>3. When enospc occurs in writing the cd_page into file, fill part
>   of the cd_header with zero according to how many pages in cd_page
>   have been written.
>4. Then, write the page header and data info buffers.

This version looks good to me, I'll merge it into v1.5.9.

Thanks
Atsushi Kumagai

>Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> makedumpfile.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 91 insertions(+), 11 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index cc71f20..b056528 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -6286,6 +6286,92 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> }
>
> int
>+write_cd_buf(struct cache_data *cd)
>+{
>+	if (cd->buf_size == 0)
>+		return TRUE;
>+
>+	if (!write_buffer(cd->fd, cd->offset, cd->buf,
>+			cd->buf_size, cd->file_name)) {
>+		return FALSE;
>+	}
>+
>+	return TRUE;
>+}
>+
>+/*
>+ * get_nr_pages is used for generating incomplete kdump core.
>+ * When enospac occurs in writing the buf cd_page, it can be used to
>+ * get how many pages have been written.
>+ */
>+int
>+get_nr_pages(void *buf, struct cache_data *cd_page){
>+	int size, file_end, nr_pages;
>+	page_desc_t *pd = buf;

I prefer to

+int
+get_nr_pages(struct cache_data *cd_header, struct cache_data *cd_page){
+	int size, file_end, nr_pages;
+	page_desc_t *pd = cd_header->buf;

>+
>+	file_end = lseek(cd_page->fd, 0, SEEK_END);
>+	if (file_end < 0) {
>+		ERRMSG("Can't seek end of the dump file(%s).\n", cd_page->file_name);
>+		return -1;
>+	}
>+
>+	size = pd->size;
>+	nr_pages = 0;
>+	while (size <= file_end - cd_page->offset) {
>+		nr_pages++;
>+		pd++;
>+		size += pd->size;
>+	}
>+
>+	return nr_pages;
>+}
>+
>+int
>+write_kdump_page(struct cache_data *cd_header, struct cache_data *cd_page,
>+		struct page_desc *pd, void *page_data)
>+{
>+	int written_headers_size;
>+
>+	/*
>+	 * If either cd_header or cd_page is nearly full,
>+	 * write the buffer cd_header into dumpfile and then write the cd_page.
>+	 * With that, when enospc occurs, we can save more useful information.
>+	 */
>+	if (cd_header->buf_size + sizeof(*pd) > cd_header->cache_size
>+		|| cd_page->buf_size + pd->size > cd_page->cache_size){
>+		if( !write_cd_buf(cd_header) ) {
>+			memset(cd_header->buf, 0, cd_header->cache_size);
>+			write_cd_buf(cd_header);
>+
>+			return FALSE;
>+		}
>+
>+		if( !write_cd_buf(cd_page) ) {
>+			written_headers_size = sizeof(page_desc_t) *
>+					get_nr_pages(cd_header->buf, cd_page);
>+			if (written_headers_size < 0)
>+				return FALSE;
>+
>+			memset(cd_header->buf, 0, cd_header->cache_size);
>+			cd_header->offset += written_headers_size;
>+			cd_header->buf_size -= written_headers_size;
>+			write_cd_buf(cd_header);
>+
>+			return FALSE;
>+		}
>+		cd_header->offset += cd_header->buf_size;
>+		cd_page->offset += cd_page->buf_size;
>+		cd_header->buf_size = 0;
>+		cd_page->buf_size = 0;
>+	}
>+
>+	write_cache(cd_header, pd, sizeof(page_desc_t));
>+	write_cache(cd_page, page_data, pd->size);
>+
>+	return TRUE;
>+}
>+
>+int
> write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
> 			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
> {
>@@ -6424,17 +6510,11 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
> 		pd.offset     = *offset_data;
> 		*offset_data  += pd.size;
>
>-                /*
>-                 * Write the page header.
>-                 */
>-                if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
>-                        goto out;
>-
>-                /*
>-                 * Write the page data.
>-                 */
>-		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
>-                        goto out;
>+               /*
>+                * Write the page header and the page data
>+                */
>+               if (!write_kdump_page(cd_header, cd_page, &pd, pd.flags ? buf_out : buf))
>+                       goto out;
>         }
>
> 	ret = TRUE;
>--
>1.8.3.1
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
