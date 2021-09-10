Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdu1-00CUNc-Sd
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:37:03 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 c6-20020a17090a020600b00198f4245224so1111550pjc.6
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:44 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 05/11] makedumpfile: Add single thread zstd compression
 processing
Date: Fri, 10 Sep 2021 18:33:12 +0800
Message-Id: <20210910103318.292017-6-ltao@redhat.com>
In-Reply-To: <20210910103318.292017-1-ltao@redhat.com>
References: <20210910103318.292017-1-ltao@redhat.com>
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
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>, Coiby Xu <coxu@redhat.com>

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 makedumpfile.c | 41 ++++++++++++++++++++++++++++++++++++-----
 makedumpfile.h |  3 +++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f3bf297..76a7a77 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -296,18 +296,20 @@ is_cache_page(unsigned long flags)
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
-	unsigned long zlib = compressBound(page_size);
-	unsigned long lzo = 0;
-	unsigned long snappy = 0;
+	unsigned long zlib, lzo, snappy, zstd;
+	zlib = lzo = snappy = zstd = 0;
 
+	zlib = compressBound(page_size);
 #ifdef USELZO
 	lzo = page_size + page_size / 16 + 64 + 3;
 #endif
 #ifdef USESNAPPY
 	snappy = snappy_max_compressed_length(page_size);
 #endif
-
-	return MAX(zlib, MAX(lzo, snappy));
+#ifdef USEZSTD
+	zstd = ZSTD_compressBound(page_size);
+#endif
+	return MAX(zlib, MAX(lzo, MAX(snappy, zstd)));
 }
 
 #define BITMAP_SECT_LEN 4096
@@ -7298,6 +7300,10 @@ write_kdump_header(void)
 	else if (info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
 		dh->status |= DUMP_DH_COMPRESSED_SNAPPY;
 #endif
+#ifdef USEZSTD
+	else if (info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
+		dh->status |= DUMP_DH_COMPRESSED_ZSTD;
+#endif
 
 	size = sizeof(struct disk_dump_header);
 	if (!write_buffer(info->fd_dumpfile, 0, dh, size, info->name_dumpfile))
@@ -8567,6 +8573,9 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 #ifdef USELZO
 	lzo_bytep wrkmem = NULL;
 #endif
+#ifdef USEZSTD
+	ZSTD_CCtx *cctx = NULL;
+#endif
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
@@ -8586,6 +8595,14 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		goto out;
 	}
 #endif
+#ifdef USEZSTD
+	if (info->flag_compress & DUMP_DH_COMPRESSED_ZSTD) {
+		if ((cctx = ZSTD_createCCtx()) == NULL) {
+			ERRMSG("Can't allocate ZSTD_CCtx.\n");
+			goto out;
+		}
+	}
+#endif
 
 	len_buf_out = calculate_len_buf_out(info->page_size);
 
@@ -8668,6 +8685,16 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
 			pd.size  = size_out;
+#endif
+#ifdef USEZSTD
+		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
+			    && (size_out = ZSTD_compressCCtx(cctx,
+						buf_out, len_buf_out,
+						buf, info->page_size, ZSTD_dfast))
+			    && (!ZSTD_isError(size_out))
+			    && (size_out < info->page_size)) {
+			pd.flags = DUMP_DH_COMPRESSED_ZSTD;
+			pd.size  = size_out;
 #endif
 		} else {
 			pd.flags = 0;
@@ -8688,6 +8715,10 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 out:
 	if (buf_out != NULL)
 		free(buf_out);
+#ifdef USEZSTD
+	if (cctx != NULL)
+		ZSTD_freeCCtx(cctx);
+#endif
 #ifdef USELZO
 	if (wrkmem != NULL)
 		free(wrkmem);
diff --git a/makedumpfile.h b/makedumpfile.h
index 46d77b0..a1a8cc2 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -38,6 +38,9 @@
 #ifdef USESNAPPY
 #include <snappy-c.h>
 #endif
+#ifdef USEZSTD
+#include <zstd.h>
+#endif
 #include "common.h"
 #include "dwarf_info.h"
 #include "diskdump_mod.h"
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
