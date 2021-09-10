Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdt6-00CU36-Kr
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:36:06 +0000
Received: by mail-pg1-f197.google.com with SMTP id
 z7-20020a63c047000000b0026b13e40309so1012127pgi.19
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:42 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 06/11] makedumpfile: Add parallel threads zstd compression
 processing
Date: Fri, 10 Sep 2021 18:33:13 +0800
Message-Id: <20210910103318.292017-7-ltao@redhat.com>
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
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 makedumpfile.c | 26 ++++++++++++++++++++++++++
 makedumpfile.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 76a7a77..af21a84 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3892,6 +3892,12 @@ initial_for_parallel()
 					strerror(errno));
 			return FALSE;
 		}
+#endif
+#ifdef USEZSTD
+		if ((ZSTD_CCTX_PARALLEL(i) = ZSTD_createCCtx()) == NULL) {
+			MSG("Can't allocate ZSTD_CCtx.\n");
+			return FALSE;
+		}
 #endif
 	}
 
@@ -4000,6 +4006,10 @@ free_for_parallel()
 			if (WRKMEM_PARALLEL(i) != NULL)
 				free(WRKMEM_PARALLEL(i));
 #endif
+#ifdef USEZSTD
+			if (ZSTD_CCTX_PARALLEL(i) != NULL)
+				ZSTD_freeCCtx(ZSTD_CCTX_PARALLEL(i));
+#endif
 
 		}
 		free(info->threads);
@@ -8166,6 +8176,9 @@ kdump_thread_function_cyclic(void *arg) {
 #ifdef USELZO
 	lzo_bytep wrkmem = WRKMEM_PARALLEL(kdump_thread_args->thread_num);
 #endif
+#ifdef USEZSTD
+	ZSTD_CCtx *cctx = ZSTD_CCTX_PARALLEL(kdump_thread_args->thread_num);
+#endif
 
 	buf = BUF_PARALLEL(kdump_thread_args->thread_num);
 	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->thread_num);
@@ -8298,6 +8311,19 @@ kdump_thread_function_cyclic(void *arg) {
 						DUMP_DH_COMPRESSED_SNAPPY;
 				page_data_buf[index].size  = size_out;
 				memcpy(page_data_buf[index].buf, buf_out, size_out);
+#endif
+#ifdef USEZSTD
+			} else if ((info->flag_compress
+				    & DUMP_DH_COMPRESSED_ZSTD)
+				   && (size_out = ZSTD_compressCCtx(cctx,
+						buf_out, kdump_thread_args->len_buf_out,
+						buf, info->page_size, ZSTD_dfast))
+				   && (!ZSTD_isError(size_out))
+				   && (size_out < info->page_size)) {
+				page_data_buf[index].flags =
+						DUMP_DH_COMPRESSED_ZSTD;
+				page_data_buf[index].size  = size_out;
+				memcpy(page_data_buf[index].buf, buf_out, size_out);
 #endif
 			} else {
 				page_data_buf[index].flags = 0;
diff --git a/makedumpfile.h b/makedumpfile.h
index a1a8cc2..d583249 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -484,6 +484,9 @@ do { \
 #ifdef USELZO
 #define WRKMEM_PARALLEL(i)		info->parallel_info[i].wrkmem
 #endif
+#ifdef USEZSTD
+#define ZSTD_CCTX_PARALLEL(i)		info->parallel_info[i].zstd_cctx
+#endif
 /*
  * kernel version
  *
@@ -1328,6 +1331,9 @@ struct parallel_info {
 #ifdef USELZO
 	lzo_bytep		wrkmem;
 #endif
+#ifdef USEZSTD
+	ZSTD_CCtx		*zstd_cctx;
+#endif
 };
 
 struct ppc64_vmemmap {
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
