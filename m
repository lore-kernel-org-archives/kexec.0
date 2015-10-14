Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmEaM-0001Kl-NU
 for kexec@lists.infradead.org; Wed, 14 Oct 2015 05:26:48 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] makedumpfile: Improve performance for parallel compression
 with zlib.
Date: Wed, 14 Oct 2015 05:24:07 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF3679@BPXM01GP.gisp.nec.co.jp>
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
Cc: "qiaonuohan@cn.fujitsu.com" <qiaonuohan@cn.fujitsu.com>, "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>

Hello,

I have improved the performance issue of parallel compression
which we faced in:

  http://lists.infradead.org/pipermail/kexec/2015-July/014137.html

The cause of the issue is that compress2() calls malloc() and free()
for a temp buffer in each call, it can cause many page faults since
makedumpfile has to call compress2() for each page.

It's easy to avoid the issue, just divide compress2() into three
functions as initialization part, compression part and finalization
part. Then we don't need to call the initialization function and the
finalization function for each page.

In order to benchmark, I measured the execution time and the number of
page faults by *perf stat -e page-faults* on the current devel branch(v1.5.8+).

The result is here:

  CPU:   Dual-Core AMD Opteron(tm) Processor 2218 @ 2.6GHz (4 cores)
  Memory:  5GB
  zlib:  1.2.3-29
  glibc: 2.12-1.132

        version      |  num-threads  |  time(sec)  |   page-faults
     ----------------+---------------+-------------+------------------
          devel      |       1       |   133.96    |    21,801,120
          devel      |       3       |    87.25    |    21,801,150
      + this patch   |       1       |    47.80    |     1,036,408
      + this patch   |       3       |    39.14    |     1,036,478


Thanks
Atsushi Kumagai


From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date: Thu, 8 Oct 2015 15:06:08 +0900
Subject: [PATCH] Improve performance for parallel compression with zlib.

compress2() allocates a buffer, compresses a input data and
deallocates the buffer in each call. makedumpfile has to call
compress2() for each page, it can cause big performance
degradation due to many page faults. This issue will be
especially apparent in the case of multi thread compression
since per-thread arena is easy to be grown and trimmed compared
with main arena.

Fortunately, the zlib functions called in compress2() are global,
it's easy to extract the allocation and deallocation part from
compress2().

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |  4 ++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 06c8baf..fa0b779 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -25,6 +25,7 @@
 #include <sys/time.h>
 #include <limits.h>
 #include <assert.h>
+#include <zlib.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -3538,6 +3539,11 @@ initial_for_parallel()
 		MMAP_CACHE_PARALLEL(i)->mmap_start_offset = 0;
 		MMAP_CACHE_PARALLEL(i)->mmap_end_offset = 0;
 
+		if (initialize_zlib(&ZLIB_STREAM_PARALLEL(i), Z_BEST_SPEED) == FALSE) {
+			ERRMSG("zlib initialization failed.\n");
+			return FALSE;
+		}
+
 #ifdef USELZO
 		if ((WRKMEM_PARALLEL(i) = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
 			MSG("Can't allocate memory for the working memory. %s\n",
@@ -3628,6 +3634,7 @@ free_for_parallel()
 
 				free(MMAP_CACHE_PARALLEL(i));
 			}
+			finalize_zlib(&ZLIB_STREAM_PARALLEL(i));
 #ifdef USELZO
 			if (WRKMEM_PARALLEL(i) != NULL)
 				free(WRKMEM_PARALLEL(i));
@@ -7017,6 +7024,53 @@ write_kdump_page(struct cache_data *cd_header, struct cache_data *cd_page,
 	return TRUE;
 }
 
+int initialize_zlib(z_stream *stream, int level)
+{
+	int err;
+
+	stream->zalloc = (alloc_func)Z_NULL;
+	stream->zfree = (free_func)Z_NULL;
+	stream->opaque = (voidpf)Z_NULL;
+
+	err = deflateInit(stream, level);
+	if (err != Z_OK) {
+		ERRMSG("deflateInit failed: %s\n", zError(err));
+		return FALSE;
+	}
+	return TRUE;
+}
+
+int compress_mdf (z_stream *stream, Bytef *dest, uLongf *destLen,
+		  const Bytef *source, uLong sourceLen, int level)
+{
+	int err;
+	stream->next_in = (Bytef*)source;
+	stream->avail_in = (uInt)sourceLen;
+	stream->next_out = dest;
+	stream->avail_out = (uInt)*destLen;
+	if ((uLong)stream->avail_out != *destLen)
+		return Z_BUF_ERROR;
+
+	err = deflate(stream, Z_FINISH);
+
+	if (err != Z_STREAM_END) {
+		deflateReset(stream);
+		return err == Z_OK ? Z_BUF_ERROR : err;
+	}
+	*destLen = stream->total_out;
+
+	err = deflateReset(stream);
+	return err;
+}
+
+int finalize_zlib(z_stream *stream)
+{
+	int err;
+	err = deflateEnd(stream);
+
+	return err;
+}
+
 void *
 kdump_thread_function_cyclic(void *arg) {
 	void *retval = PTHREAD_FAIL;
@@ -7035,6 +7089,7 @@ kdump_thread_function_cyclic(void *arg) {
 	struct mmap_cache *mmap_cache =
 			MMAP_CACHE_PARALLEL(kdump_thread_args->thread_num);
 	unsigned long size_out;
+	z_stream *stream = &ZLIB_STREAM_PARALLEL(kdump_thread_args->thread_num);
 #ifdef USELZO
 	lzo_bytep wrkmem = WRKMEM_PARALLEL(kdump_thread_args->thread_num);
 #endif
@@ -7135,7 +7190,7 @@ kdump_thread_function_cyclic(void *arg) {
 			size_out = kdump_thread_args->len_buf_out;
 			if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 			    && ((size_out = kdump_thread_args->len_buf_out),
-				compress2(buf_out, &size_out, buf,
+				compress_mdf(stream, buf_out, &size_out, buf,
 					  info->page_size,
 					  Z_BEST_SPEED) == Z_OK)
 			    && (size_out < info->page_size)) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 0bd6425..cb8f0f3 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -438,6 +438,7 @@ do { \
 #define BUF_PARALLEL(i)			info->parallel_info[i].buf
 #define BUF_OUT_PARALLEL(i)		info->parallel_info[i].buf_out
 #define MMAP_CACHE_PARALLEL(i)		info->parallel_info[i].mmap_cache
+#define ZLIB_STREAM_PARALLEL(i)		info->parallel_info[i].zlib_stream
 #ifdef USELZO
 #define WRKMEM_PARALLEL(i)		info->parallel_info[i].wrkmem
 #endif
@@ -1050,6 +1051,7 @@ struct parallel_info {
 	unsigned char		*buf;
 	unsigned char 		*buf_out;
 	struct mmap_cache	*mmap_cache;
+	z_stream		zlib_stream;
 #ifdef USELZO
 	lzo_bytep		wrkmem;
 #endif
@@ -2051,5 +2053,7 @@ int initial_xen(void);
 unsigned long long get_free_memory_size(void);
 int calculate_cyclic_buffer_size(void);
 int prepare_splitblock_table(void);
+int initialize_zlib(z_stream *stream, int level);
+int finalize_zlib(z_stream *stream);
 
 #endif /* MAKEDUMPFILE_H */
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
