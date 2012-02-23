Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0NZb-0000v5-Ev
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 01:34:20 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9605C3EE0B5
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:17 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BDF445DE58
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1B14F45DE54
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 039A91DB8038
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:17 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A05DF1DB8040
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:16 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH makedumpfile v2 4/4] Add build condition for LZO support
Date: Thu, 23 Feb 2012 10:34:15 +0900
Message-ID: <20120223013415.5041.53419.stgit@localhost6.localdomain6>
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

To enable lzo compression support, build makedumpfile as:

  $ make USELZO

To disable, as:

  $ make

In default, lzo compression support is disabled.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 Makefile       |    5 +++++
 makedumpfile.c |   18 ++++++++++++++++--
 makedumpfile.h |    2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e6b7b89..55082f7 100644
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,11 @@ ifneq ($(LINKTYPE), dynamic)
 LIBS := -static $(LIBS)
 endif
 
+ifeq ($(USELZO), on)
+LIBS := -llzo2 $(LIBS)
+CFLAGS += -DUSELZO
+endif
+
 all: makedumpfile
 
 $(OBJ_PART): $(SRC_PART)
diff --git a/makedumpfile.c b/makedumpfile.c
index e0079b8..717519a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -266,6 +266,7 @@ readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t size)
 			goto error;
 		}
 		memcpy(bufptr, buf2 + page_offset, size);
+#ifdef USELZO
 	} else if (info->flag_lzo_support
 		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
 		retlen = info->page_size;
@@ -277,6 +278,7 @@ readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t size)
 			goto error;
 		}
 		memcpy(bufptr, buf2 + page_offset, size);
+#endif
 	} else
 		memcpy(bufptr, buf + page_offset, size);
 
@@ -2509,8 +2511,10 @@ initial(void)
 	unsigned long size;
 	int debug_info = FALSE;
 
+#ifdef USELZO
 	if (lzo_init() == LZO_E_OK)
 		info->flag_lzo_support = TRUE;
+#endif
 
 	if (!is_xen_memory() && info->flag_exclude_xen_dom) {
 		MSG("'-X' option is disable,");
@@ -4679,11 +4683,10 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	off_t offset_data = 0;
 	struct disk_dump_header *dh = info->dump_header;
 	unsigned char buf[info->page_size], *buf_out = NULL;
-	unsigned long len_buf_out, len_buf_out_zlib, len_buf_out_lzo;
+	unsigned long len_buf_out;
 	struct dump_bitmap bitmap2;
 	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
-	lzo_bytep wrkmem = NULL;
 
 	int ret = FALSE;
 
@@ -4692,6 +4695,10 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	initialize_2nd_bitmap(&bitmap2);
 
+#ifdef USELZO
+	unsigned long len_buf_out_zlib, len_buf_out_lzo;
+	lzo_bytep wrkmem;
+
 	if ((wrkmem = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
 		ERRMSG("Can't allocate memory for the working memory. %s\n",
 		       strerror(errno));
@@ -4701,6 +4708,9 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	len_buf_out_zlib = compressBound(info->page_size);
 	len_buf_out_lzo = info->page_size + info->page_size / 16 + 64 + 3;
 	len_buf_out = MAX(len_buf_out_zlib, len_buf_out_lzo);
+#else
+	len_buf_out = compressBound(info->page_size);
+#endif
 
 	if ((buf_out = malloc(len_buf_out)) == NULL) {
 		ERRMSG("Can't allocate memory for the compression buffer. %s\n",
@@ -4791,6 +4801,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
 			memcpy(buf, buf_out, pd.size);
+#ifdef USELZO
 		} else if (info->flag_lzo_support
 			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
 			   && ((size_out = info->page_size),
@@ -4800,6 +4811,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			pd.flags = DUMP_DH_COMPRESSED_LZO;
 			pd.size  = size_out;
 			memcpy(buf, buf_out, pd.size);
+#endif
 		} else {
 			pd.flags = 0;
 			pd.size  = info->page_size;
@@ -4840,8 +4852,10 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 out:
 	if (buf_out != NULL)
 		free(buf_out);
+#ifdef USELZO
 	if (wrkmem != NULL)
 		free(wrkmem);
+#endif
 
 	return ret;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 9594ca7..170ac82 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -31,7 +31,9 @@
 #include <libelf.h>
 #include <byteswap.h>
 #include <getopt.h>
+#ifdef USELZO
 #include <lzo/lzo1x.h>
+#endif
 #include "common.h"
 #include "dwarf_info.h"
 #include "diskdump_mod.h"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
