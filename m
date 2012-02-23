Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0NZL-0000th-Ri
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 01:34:05 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 09D513EE0BC
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:02 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BA8745DE59
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:01 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F090B45DE55
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D57ED1DB8043
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:00 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 862261DB803F
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH makedumpfile v2 1/4] Add LZO Support
Date: Thu, 23 Feb 2012 10:33:59 +0900
Message-ID: <20120223013359.5041.11030.stgit@localhost6.localdomain6>
In-Reply-To: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Add -l option as one of the command-line options users can specify. If
-l option is specified, then makedumpfile generates dumpfile in
kdump-compressed format with lzo compression by each page.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 diskdump_mod.h |    3 ++-
 makedumpfile.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++---------
 makedumpfile.h |    2 ++
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/diskdump_mod.h b/diskdump_mod.h
index c1de972..e672485 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -78,7 +78,8 @@ struct kdump_sub_header {
 };
 
 /* page flags */
-#define DUMP_DH_COMPRESSED	0x1	/* page is compressed               */
+#define DUMP_DH_COMPRESSED_ZLIB	0x1	/* page is compressed with zlib */
+#define DUMP_DH_COMPRESSED_LZO	0x2	/* paged is compressed with lzo */
 
 /* descriptor of each page for vmcore */
 typedef struct page_desc {
diff --git a/makedumpfile.c b/makedumpfile.c
index c51fda3..e0079b8 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -257,7 +257,7 @@ readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t size)
 		goto error;
 	}
 
-	if (pd.flags & DUMP_DH_COMPRESSED) {
+	if (pd.flags & DUMP_DH_COMPRESSED_ZLIB) {
 		retlen = info->page_size;
 		ret = uncompress((unsigned char *)buf2, &retlen,
 					(unsigned char *)buf, pd.size);
@@ -266,6 +266,17 @@ readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t size)
 			goto error;
 		}
 		memcpy(bufptr, buf2 + page_offset, size);
+	} else if (info->flag_lzo_support
+		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
+		retlen = info->page_size;
+		ret = lzo1x_decompress_safe((unsigned char *)buf, pd.size,
+					    (unsigned char *)buf2, &retlen,
+					    LZO1X_MEM_DECOMPRESS);
+		if ((ret != LZO_E_OK) || (retlen != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			goto error;
+		}
+		memcpy(bufptr, buf2 + page_offset, size);
 	} else
 		memcpy(bufptr, buf + page_offset, size);
 
@@ -2498,6 +2509,9 @@ initial(void)
 	unsigned long size;
 	int debug_info = FALSE;
 
+	if (lzo_init() == LZO_E_OK)
+		info->flag_lzo_support = TRUE;
+
 	if (!is_xen_memory() && info->flag_exclude_xen_dom) {
 		MSG("'-X' option is disable,");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
@@ -4665,10 +4679,11 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	off_t offset_data = 0;
 	struct disk_dump_header *dh = info->dump_header;
 	unsigned char buf[info->page_size], *buf_out = NULL;
-	unsigned long len_buf_out;
+	unsigned long len_buf_out, len_buf_out_zlib, len_buf_out_lzo;
 	struct dump_bitmap bitmap2;
 	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
+	lzo_bytep wrkmem = NULL;
 
 	int ret = FALSE;
 
@@ -4677,7 +4692,16 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	initialize_2nd_bitmap(&bitmap2);
 
-	len_buf_out = compressBound(info->page_size);
+	if ((wrkmem = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
+		ERRMSG("Can't allocate memory for the working memory. %s\n",
+		       strerror(errno));
+		goto out;
+	}
+
+	len_buf_out_zlib = compressBound(info->page_size);
+	len_buf_out_lzo = info->page_size + info->page_size / 16 + 64 + 3;
+	len_buf_out = MAX(len_buf_out_zlib, len_buf_out_lzo);
+
 	if ((buf_out = malloc(len_buf_out)) == NULL) {
 		ERRMSG("Can't allocate memory for the compression buffer. %s\n",
 		    strerror(errno));
@@ -4759,11 +4783,21 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		 * Compress the page data.
 		 */
 		size_out = len_buf_out;
-		if (info->flag_compress
-		    && (compress2(buf_out, &size_out, buf,
-		    info->page_size, Z_BEST_SPEED) == Z_OK)
+		if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
+		    && ((size_out = len_buf_out),
+			compress2(buf_out, &size_out, buf, info->page_size,
+				  Z_BEST_SPEED) == Z_OK)
 		    && (size_out < info->page_size)) {
-			pd.flags = 1;
+			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
+			pd.size  = size_out;
+			memcpy(buf, buf_out, pd.size);
+		} else if (info->flag_lzo_support
+			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
+			   && ((size_out = info->page_size),
+			       lzo1x_1_compress(buf, info->page_size, buf_out,
+						&size_out, wrkmem) == LZO_E_OK)
+			   && (size_out < info->page_size)) {
+			pd.flags = DUMP_DH_COMPRESSED_LZO;
 			pd.size  = size_out;
 			memcpy(buf, buf_out, pd.size);
 		} else {
@@ -4806,6 +4840,8 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 out:
 	if (buf_out != NULL)
 		free(buf_out);
+	if (wrkmem != NULL)
+		free(wrkmem);
 
 	return ret;
 }
@@ -6896,7 +6932,7 @@ main(int argc, char *argv[])
 
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:MRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMRrsvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -6906,7 +6942,7 @@ main(int argc, char *argv[])
 			info->name_filterconfig = optarg;
 			break;
 		case 'c':
-			info->flag_compress = 1;
+			info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
 			break;
 		case 'D':
 			flag_debug = TRUE;
@@ -6945,6 +6981,9 @@ main(int argc, char *argv[])
 				goto out;
 			info->flag_sadump_diskset = 1;
 			break;
+		case 'l':
+			info->flag_compress = DUMP_DH_COMPRESSED_LZO;
+			break;
 		case 'm':
 			message_level = atoi(optarg);
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index ebb8929..9594ca7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -31,6 +31,7 @@
 #include <libelf.h>
 #include <byteswap.h>
 #include <getopt.h>
+#include <lzo/lzo1x.h>
 #include "common.h"
 #include "dwarf_info.h"
 #include "diskdump_mod.h"
@@ -767,6 +768,7 @@ struct DumpInfo {
 	int		num_dump_level;      /* number of dump level */
 	int		array_dump_level[NUM_ARRAY_DUMP_LEVEL];
 	int		flag_compress;       /* flag of compression */
+	int		flag_lzo_support;    /* flag of LZO compression support */
 	int		flag_elf_dumpfile;   /* flag of creating ELF dumpfile */
 	int		flag_generate_vmcoreinfo;/* flag of generating vmcoreinfo file */
 	int		flag_read_vmcoreinfo;    /* flag of reading vmcoreinfo file */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
