Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x232.google.com ([2607:f8b0:400e:c03::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YHane-00045L-Fw
 for kexec@lists.infradead.org; Sat, 31 Jan 2015 16:21:35 +0000
Received: by mail-pa0-f50.google.com with SMTP id rd3so64344707pab.9
 for <kexec@lists.infradead.org>; Sat, 31 Jan 2015 08:21:13 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 2/3] Fix zlib/lzma decompression.
Date: Sun,  1 Feb 2015 00:10:07 +0800
Message-Id: <1422720608-28700-2-git-send-email-yszhou4tech@gmail.com>
In-Reply-To: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
References: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au

Let {zlib,lzma}_decompress_file() return NULL if anything wrong happened
to allow the other method to have a chance to run.

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 kexec/lzma.c |   33 ++++++++++++++++++++++-----------
 kexec/zlib.c |   57 +++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/kexec/lzma.c b/kexec/lzma.c
index 939aeb3..5bfccb7 100644
--- a/kexec/lzma.c
+++ b/kexec/lzma.c
@@ -162,13 +162,16 @@ char *lzma_decompress_file(const char *filename, off_t *r_size)
 	off_t size, allocated;
 	ssize_t result;
 
-	if (!filename) {
-		*r_size = 0;
-		return 0;
-	}
+	dbgprintf("Try LZMA decompression.\n");
+
+	*r_size = 0;
+	if (!filename)
+		return NULL;
+
 	fp = lzopen(filename, "rb");
 	if (fp == 0) {
-		die("Cannot open `%s'\n", filename);
+		dbgprintf("Cannot open `%s'\n", filename);
+		return NULL;
 	}
 	size = 0;
 	allocated = 65536;
@@ -183,17 +186,25 @@ char *lzma_decompress_file(const char *filename, off_t *r_size)
 			if ((errno == EINTR) || (errno == EAGAIN))
 				continue;
 
-			die ("read on %s of %ld bytes failed\n",
-				filename, (allocated - size) + 0UL);
+			dbgprintf("%s: read on %s of %ld bytes failed\n",
+				__func__, filename, (allocated - size) + 0UL);
+			break;
 		}
 		size += result;
-	} while(result > 0);
-	result = lzclose(fp);
-	if (result != LZMA_OK) {
-		die ("Close of %s failed\n", filename);
+	} while (result > 0);
+
+	if (lzclose(fp) != LZMA_OK) {
+		dbgprintf("%s: Close of %s failed\n", __func__, filename);
+		goto fail;
 	}
+	if (result < 0)
+		goto fail;
+
 	*r_size =  size;
 	return buf;
+fail:
+	free(buf);
+	return NULL;
 }
 #else
 char *lzma_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
diff --git a/kexec/zlib.c b/kexec/zlib.c
index d44df12..7170ac3 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -15,29 +15,39 @@
 #include <ctype.h>
 #include <zlib.h>
 
+static void _gzerror(gzFile fp, int *errnum, const char **errmsg)
+{
+	*errmsg = gzerror(fp, errnum);
+	if (*errnum == Z_ERRNO) {
+		*errmsg = strerror(*errnum);
+	}
+}
+
 char *zlib_decompress_file(const char *filename, off_t *r_size)
 {
 	gzFile fp;
 	int errnum;
 	const char *msg;
 	char *buf;
-	off_t size, allocated;
+	off_t size = 0, allocated;
 	ssize_t result;
 
+	dbgprintf("Try gzip decompression.\n");
+
+	*r_size = 0;
 	if (!filename) {
-		*r_size = 0;
-		return 0;
+		return NULL;
 	}
 	fp = gzopen(filename, "rb");
 	if (fp == 0) {
-		msg = gzerror(fp, &errnum);
-		if (errnum == Z_ERRNO) {
-			msg = strerror(errno);
-		}
-		fprintf(stderr, "Cannot open `%s': %s\n", filename, msg);
+		_gzerror(fp, &errnum, &msg);
+		dbgprintf("Cannot open `%s': %s\n", filename, msg);
+		return NULL;
+	}
+	if (gzdirect(fp)) {
+		/* It's not in gzip format */
 		return NULL;
 	}
-	size = 0;
 	allocated = 65536;
 	buf = xmalloc(allocated);
 	do {
@@ -49,25 +59,28 @@ char *zlib_decompress_file(const char *filename, off_t *r_size)
 		if (result < 0) {
 			if ((errno == EINTR) || (errno == EAGAIN))
 				continue;
-
-			msg = gzerror(fp, &errnum);
-			if (errnum == Z_ERRNO) {
-				msg = strerror(errno);
-			}
-			die ("read on %s of %ld bytes failed: %s\n",
-				filename, (allocated - size) + 0UL, msg);
+			_gzerror(fp, &errnum, &msg);
+			dbgprintf("Read on %s of %ld bytes failed: %s\n",
+					filename, (allocated - size) + 0UL, msg);
+			size = 0;
+			goto fail;
 		}
 		size += result;
 	} while(result > 0);
+
+fail:
 	result = gzclose(fp);
 	if (result != Z_OK) {
-		msg = gzerror(fp, &errnum);
-		if (errnum == Z_ERRNO) {
-			msg = strerror(errno);
-		}
-		die ("Close of %s failed: %s\n", filename, msg);
+		_gzerror(fp, &errnum, &msg);
+		dbgprintf(" Close of %s failed: %s\n", filename, msg);
+	}
+
+	if (size > 0) {
+		*r_size = size;
+	} else {
+		free(buf);
+		buf = NULL;
 	}
-	*r_size =  size;
 	return buf;
 }
 #else
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
