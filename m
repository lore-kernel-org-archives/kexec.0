Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTS-0006UB-8D
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:26 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6CEFB3EE0B5
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:55 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 55D6A45DEAD
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F59F45DEA6
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 31C8B1DB803B
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:55 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E06371DB8038
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:54 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 5/8] Add compression processing
Date: Tue, 03 Jul 2012 12:07:54 +0900
Message-ID: <20120703030754.16633.16719.stgit@localhost6.localdomain6>
In-Reply-To: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
References: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
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

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   30 +++++++++++++++++++++++++-----
 makedumpfile.h |    3 +++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a47a3ec..1525b30 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4718,6 +4718,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	struct dump_bitmap bitmap2;
 	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
+	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
 
 	int ret = FALSE;
 
@@ -4726,8 +4727,9 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	initialize_2nd_bitmap(&bitmap2);
 
+	len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = 0;
+
 #ifdef USELZO
-	unsigned long len_buf_out_zlib, len_buf_out_lzo;
 	lzo_bytep wrkmem;
 
 	if ((wrkmem = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
@@ -4736,13 +4738,19 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		goto out;
 	}
 
-	len_buf_out_zlib = compressBound(info->page_size);
 	len_buf_out_lzo = info->page_size + info->page_size / 16 + 64 + 3;
-	len_buf_out = MAX(len_buf_out_zlib, len_buf_out_lzo);
-#else
-	len_buf_out = compressBound(info->page_size);
 #endif
 
+#ifdef USESNAPPY
+	len_buf_out_snappy = snappy_max_compressed_length(info->page_size);
+#endif
+
+	len_buf_out_zlib = compressBound(info->page_size);
+	
+	len_buf_out = MAX(len_buf_out_zlib,
+			  MAX(len_buf_out_lzo,
+			      len_buf_out_snappy));
+
 	if ((buf_out = malloc(len_buf_out)) == NULL) {
 		ERRMSG("Can't allocate memory for the compression buffer. %s\n",
 		    strerror(errno));
@@ -4843,6 +4851,18 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			pd.size  = size_out;
 			memcpy(buf, buf_out, pd.size);
 #endif
+#ifdef USESNAPPY
+		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
+			   && ((size_out = len_buf_out_snappy),
+			       snappy_compress((char *)buf, info->page_size,
+					       (char *)buf_out,
+					       (size_t *)&size_out)
+			       == SNAPPY_OK)
+			   && (size_out < info->page_size)) {
+			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
+			pd.size  = size_out;
+			memcpy(buf, buf_out, pd.size);
+#endif
 		} else {
 			pd.flags = 0;
 			pd.size  = info->page_size;
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..72d8327 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -34,6 +34,9 @@
 #ifdef USELZO
 #include <lzo/lzo1x.h>
 #endif
+#ifdef USESNAPPY
+#include <snappy-c.h>
+#endif
 #include "common.h"
 #include "dwarf_info.h"
 #include "diskdump_mod.h"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
