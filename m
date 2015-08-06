Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNEQo-00041W-6D
 for kexec@lists.infradead.org; Thu, 06 Aug 2015 06:13:35 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t766BABQ031097
 for <kexec@lists.infradead.org>; Thu, 6 Aug 2015 14:11:10 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v4 01/10] Add readpage_kdump_compressed_parallel
Date: Thu, 6 Aug 2015 14:08:02 +0800
Message-ID: <1438841291-30378-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1438841291-30378-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1438841291-30378-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

readpage_kdump_compressed_parallel is used to enable reading pages from
vmcore in kdump-compressed format parallel. fd_memory and bitmap_memory
should be initialized and offered to each thread individually to avoid
conflict.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index cc71f20..3657d4f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -251,6 +251,20 @@ pfn_to_pos(mdf_pfn_t pfn)
 	return desc_pos;
 }
 
+unsigned long
+pfn_to_pos_parallel(mdf_pfn_t pfn, struct dump_bitmap* bitmap_memory_parallel)
+{
+	unsigned long desc_pos;
+	mdf_pfn_t i;
+
+	desc_pos = info->valid_pages[pfn / BITMAP_SECT_LEN];
+	for (i = round(pfn, BITMAP_SECT_LEN); i < pfn; i++)
+		if (is_dumpable(bitmap_memory_parallel, i, NULL))
+			desc_pos++;
+
+	return desc_pos;
+}
+
 int
 read_page_desc(unsigned long long paddr, page_desc_t *pd)
 {
@@ -293,6 +307,50 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 	return TRUE;
 }
 
+int
+read_page_desc_parallel(int fd_memory, unsigned long long paddr,
+			page_desc_t *pd,
+			struct dump_bitmap* bitmap_memory_parallel)
+{
+	struct disk_dump_header *dh;
+	unsigned long desc_pos;
+	mdf_pfn_t pfn;
+	off_t offset;
+
+	/*
+	 * Find page descriptor
+	 */
+	dh = info->dh_memory;
+	offset
+	    = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
+		* dh->block_size;
+	pfn = paddr_to_pfn(paddr);
+	desc_pos = pfn_to_pos_parallel(pfn, bitmap_memory_parallel);
+	offset += (off_t)desc_pos * sizeof(page_desc_t);
+	if (lseek(fd_memory, offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek %s. %s\n",
+				 info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	/*
+	 * Read page descriptor
+	 */
+	if (read(fd_memory, pd, sizeof(*pd)) != sizeof(*pd)) {
+		ERRMSG("Can't read %s. %s\n",
+				info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	/*
+	 * Sanity check
+	 */
+	if (pd->size > dh->block_size)
+		return FALSE;
+
+	return TRUE;
+}
+
 static void
 unmap_cache(struct cache_entry *entry)
 {
@@ -589,6 +647,85 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 	return TRUE;
 }
 
+static int
+readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
+				   void *bufptr,
+				   struct dump_bitmap* bitmap_memory_parallel)
+{
+	page_desc_t pd;
+	char buf[info->page_size], *rdbuf;
+	int ret;
+	unsigned long retlen;
+
+	if (!is_dumpable(bitmap_memory_parallel, paddr_to_pfn(paddr), NULL)) {
+		ERRMSG("pfn(%llx) is excluded from %s.\n",
+				paddr_to_pfn(paddr), info->name_memory);
+		return FALSE;
+	}
+
+	if (!read_page_desc_parallel(fd_memory, paddr, &pd,
+						bitmap_memory_parallel)) {
+		ERRMSG("Can't read page_desc: %llx\n", paddr);
+		return FALSE;
+	}
+
+	if (lseek(fd_memory, pd.offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek %s. %s\n",
+				info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	/*
+	 * Read page data
+	 */
+	rdbuf = pd.flags & (DUMP_DH_COMPRESSED_ZLIB | DUMP_DH_COMPRESSED_LZO |
+		DUMP_DH_COMPRESSED_SNAPPY) ? buf : bufptr;
+	if (read(fd_memory, rdbuf, pd.size) != pd.size) {
+		ERRMSG("Can't read %s. %s\n",
+				info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	if (pd.flags & DUMP_DH_COMPRESSED_ZLIB) {
+		retlen = info->page_size;
+		ret = uncompress((unsigned char *)bufptr, &retlen,
+					(unsigned char *)buf, pd.size);
+		if ((ret != Z_OK) || (retlen != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			return FALSE;
+		}
+#ifdef USELZO
+	} else if (info->flag_lzo_support
+		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
+		retlen = info->page_size;
+		ret = lzo1x_decompress_safe((unsigned char *)buf, pd.size,
+					    (unsigned char *)bufptr, &retlen,
+					    LZO1X_MEM_DECOMPRESS);
+		if ((ret != LZO_E_OK) || (retlen != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			return FALSE;
+		}
+#endif
+#ifdef USESNAPPY
+	} else if ((pd.flags & DUMP_DH_COMPRESSED_SNAPPY)) {
+
+		ret = snappy_uncompressed_length(buf, pd.size, (size_t *)&retlen);
+		if (ret != SNAPPY_OK) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			return FALSE;
+		}
+
+		ret = snappy_uncompress(buf, pd.size, bufptr, (size_t *)&retlen);
+		if ((ret != SNAPPY_OK) || (retlen != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			return FALSE;
+		}
+#endif
+	}
+
+	return TRUE;
+}
+
 int
 readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
