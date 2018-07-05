Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vi1eur04on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::717]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fb3ni-0005oG-W2
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 12:56:02 +0000
From: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Subject: [PATCH 1/3] kexec: Move zlib buffer decompression function
Date: Thu,  5 Jul 2018 14:55:33 +0200
Message-Id: <1530795335-20867-2-git-send-email-arnaud.ferraris.external@sigfox.com>
In-Reply-To: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
References: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

In order to be able to use this feature throughout kexec-tools,
the uImage_gz_load function is renamed zlib_decompress_buffer and
moved to kexec/zlib.c

Signed-off-by: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
---
 kexec/kexec-uImage.c | 100 ++-------------------------------------------------
 kexec/kexec-zlib.h   |   1 +
 kexec/zlib.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 97 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index eeee4be..51ae486 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -7,6 +7,7 @@
 #include <getopt.h>
 #include <arch/options.h>
 #include "kexec.h"
+#include "kexec-zlib.h"
 #include <kexec-uImage.h>
 
 #ifdef HAVE_LIBZ
@@ -127,110 +128,15 @@ int uImage_probe_ramdisk(const char *buf, off_t len, unsigned int arch)
 	return !(type == IH_TYPE_RAMDISK);
 }
 
-#ifdef HAVE_LIBZ
-/* gzip flag byte */
-#define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
-#define HEAD_CRC	0x02 /* bit 1 set: header CRC present */
-#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
-#define COMMENT		0x10 /* bit 4 set: file comment present */
-#define RESERVED	0xE0 /* bits 5..7: reserved */
-
 static int uImage_gz_load(const char *buf, off_t len,
 		struct Image_info *image)
 {
-	int ret;
-	z_stream strm;
-	unsigned int skip;
-	unsigned int flags;
-	unsigned char *uncomp_buf;
-	unsigned int mem_alloc;
-
-	mem_alloc = 10 * 1024 * 1024;
-	uncomp_buf = malloc(mem_alloc);
-	if (!uncomp_buf)
-		return -1;
-
-	memset(&strm, 0, sizeof(strm));
-
-	/* Skip magic, method, time, flags, os code ... */
-	skip = 10;
-
-	/* check GZ magic */
-	if (buf[0] != 0x1f || buf[1] != 0x8b)
+	image->buf = zlib_decompress_buffer(buf, len, &image->len);
+	if (!image->buf)
 		return -1;
 
-	flags = buf[3];
-	if (buf[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
-		puts ("Error: Bad gzipped data\n");
-		return -1;
-	}
-
-	if (flags & EXTRA_FIELD) {
-		skip += 2;
-		skip += buf[10];
-		skip += buf[11] << 8;
-	}
-	if (flags & ORIG_NAME) {
-		while (buf[skip++])
-			;
-	}
-	if (flags & COMMENT) {
-		while (buf[skip++])
-			;
-	}
-	if (flags & HEAD_CRC)
-		skip += 2;
-
-	strm.avail_in = len - skip;
-	strm.next_in = (void *)buf + skip;
-
-	/* - activates parsing gz headers */
-	ret = inflateInit2(&strm, -MAX_WBITS);
-	if (ret != Z_OK)
-		return -1;
-
-	strm.next_out = uncomp_buf;
-	strm.avail_out = mem_alloc;
-
-	do {
-		ret = inflate(&strm, Z_FINISH);
-		if (ret == Z_STREAM_END)
-			break;
-
-		if (ret == Z_OK || ret == Z_BUF_ERROR) {
-			void *new_buf;
-			int inc_buf = 5 * 1024 * 1024;
-
-			mem_alloc += inc_buf;
-			new_buf = realloc(uncomp_buf, mem_alloc);
-			if (!new_buf) {
-				inflateEnd(&strm);
-				free(uncomp_buf);
-				return -1;
-			}
-
-			uncomp_buf = new_buf;
-			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
-			strm.avail_out = inc_buf;
-		} else {
-			printf("Error during decompression %d\n", ret);
-			return -1;
-		}
-	} while (1);
-
-	inflateEnd(&strm);
-	image->buf = (char *)uncomp_buf;
-	image->len = mem_alloc - strm.avail_out;
 	return 0;
 }
-#else
-static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),
-		struct Image_info *UNUSED(image))
-{
-	return -1;
-}
-#endif
 
 int uImage_load(const char *buf, off_t len, struct Image_info *image)
 {
diff --git a/kexec/kexec-zlib.h b/kexec/kexec-zlib.h
index 43c107b..ebb1cae 100644
--- a/kexec/kexec-zlib.h
+++ b/kexec/kexec-zlib.h
@@ -7,4 +7,5 @@
 #include "config.h"
 
 char *zlib_decompress_file(const char *filename, off_t *r_size);
+char *zlib_decompress_buffer(const char *buffer, off_t len, off_t *r_size);
 #endif /* __KEXEC_ZLIB_H */
diff --git a/kexec/zlib.c b/kexec/zlib.c
index 95b6080..9b58f2a 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -15,6 +15,14 @@
 #include <ctype.h>
 #include <zlib.h>
 
+/* gzip flag byte */
+#define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
+#define HEAD_CRC	0x02 /* bit 1 set: header CRC present */
+#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
+#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
+#define COMMENT		0x10 /* bit 4 set: file comment present */
+#define RESERVED	0xE0 /* bits 5..7: reserved */
+
 static void _gzerror(gzFile fp, int *errnum, const char **errmsg)
 {
 	*errmsg = gzerror(fp, errnum);
@@ -83,9 +91,101 @@ fail:
 	}
 	return buf;
 }
+
+char *zlib_decompress_buffer(const char *buffer, off_t len, off_t *r_size)
+{
+	int ret;
+	z_stream strm;
+	unsigned int skip;
+	unsigned int flags;
+	unsigned char *uncomp_buf;
+	unsigned int mem_alloc;
+
+	mem_alloc = 10 * 1024 * 1024;
+	uncomp_buf = malloc(mem_alloc);
+	if (!uncomp_buf)
+		return NULL;
+
+	memset(&strm, 0, sizeof(strm));
+
+	/* Skip magic, method, time, flags, os code ... */
+	skip = 10;
+
+	/* check GZ magic */
+	if (buffer[0] != 0x1f || buffer[1] != 0x8b)
+		return NULL;
+
+	flags = buffer[3];
+	if (buffer[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
+		puts ("Error: Bad gzipped data\n");
+		return NULL;
+	}
+
+	if (flags & EXTRA_FIELD) {
+		skip += 2;
+		skip += buffer[10];
+		skip += buffer[11] << 8;
+	}
+	if (flags & ORIG_NAME) {
+		while (buffer[skip++])
+			;
+	}
+	if (flags & COMMENT) {
+		while (buffer[skip++])
+			;
+	}
+	if (flags & HEAD_CRC)
+		skip += 2;
+
+	strm.avail_in = len - skip;
+	strm.next_in = (void *)buffer + skip;
+
+	/* - activates parsing gz headers */
+	ret = inflateInit2(&strm, -MAX_WBITS);
+	if (ret != Z_OK)
+		return NULL;
+
+	strm.next_out = uncomp_buf;
+	strm.avail_out = mem_alloc;
+
+	do {
+		ret = inflate(&strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+
+		if (ret == Z_OK || ret == Z_BUF_ERROR) {
+			void *new_buf;
+			int inc_buf = 5 * 1024 * 1024;
+
+			mem_alloc += inc_buf;
+			new_buf = realloc(uncomp_buf, mem_alloc);
+			if (!new_buf) {
+				inflateEnd(&strm);
+				free(uncomp_buf);
+				return NULL;
+			}
+
+			uncomp_buf = new_buf;
+			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
+			strm.avail_out = inc_buf;
+		} else {
+			printf("Error during decompression %d\n", ret);
+			return NULL;
+		}
+	} while (1);
+
+	inflateEnd(&strm);
+	*r_size = mem_alloc - strm.avail_out;
+	return (char *)uncomp_buf;
+}
 #else
 char *zlib_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
 {
 	return NULL;
 }
+
+char *zlib_decompress_buffer(const char *UNUSED(buffer), off_t UNUSED(len), off_t *UNUSED(r_size))
+{
+	return NULL;
+}
 #endif /* HAVE_ZLIB */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
