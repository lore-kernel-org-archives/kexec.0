Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gerard.telenet-ops.be ([195.130.132.48])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VW8mH-0008Cl-FS
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 17:51:30 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] kexec: Extract slurp_fd()
Date: Tue, 15 Oct 2013 19:50:59 +0200
Message-Id: <1381859460-13645-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

Factor out the common part of slurp_file() and slurp_file_len() into
a new helper function slurp_fd().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Young <dyoung@redhat.com>
---
 kexec/kexec.c |   92 +++++++++++++++++++++++++++------------------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 185c85bef342..583a35a24a70 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -469,14 +469,46 @@ static int add_backup_segments(struct kexec_info *info,
 	return 0;
 }
 
+static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
+{
+	char *buf;
+	off_t progress;
+	ssize_t result;
+
+	buf = xmalloc(size);
+	progress = 0;
+	while (progress < size) {
+		result = read(fd, buf + progress, size - progress);
+		if (result < 0) {
+			if ((errno == EINTR) ||	(errno == EAGAIN))
+				continue;
+			fprintf(stderr, "Read on %s failed: %s\n", filename,
+				strerror(errno));
+			free(buf);
+			close(fd);
+			return NULL;
+		}
+		if (result == 0)
+			/* EOF */
+			break;
+		progress += result;
+	}
+	result = close(fd);
+	if (result < 0)
+		die("Close of %s failed: %s\n", filename, strerror(errno));
+
+	if (nread)
+		*nread = progress;
+	return buf;
+}
+
 char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
 	char *buf;
-	off_t size, progress, err;
+	off_t size, err, nread;
 	ssize_t result;
 	struct stat stats;
-	
 
 	if (!filename) {
 		*r_size = 0;
@@ -512,25 +544,14 @@ char *slurp_file(const char *filename, off_t *r_size)
 		size = stats.st_size;
 	}
 
+	buf = slurp_fd(fd, filename, size, &nread);
+	if (!buf)
+		die("Cannot read %s", filename);
+
+	if (nread != size)
+		die("Read on %s ended before stat said it should\n", filename);
+
 	*r_size = size;
-	buf = xmalloc(size);
-	progress = 0;
-	while(progress < size) {
-		result = read(fd, buf + progress, size - progress);
-		if (result < 0) {
-			if ((errno == EINTR) ||	(errno == EAGAIN))
-				continue;
-			die("read on %s of %ld bytes failed: %s\n", filename,
-			    (size - progress)+ 0UL, strerror(errno));
-		}
-		if (result == 0)
-			die("read on %s ended before stat said it should\n", filename);
-		progress += result;
-	}
-	result = close(fd);
-	if (result < 0) {
-		die("Close of %s failed: %s\n", filename, strerror(errno));
-	}
 	return buf;
 }
 
@@ -540,9 +561,6 @@ char *slurp_file(const char *filename, off_t *r_size)
 char *slurp_file_len(const char *filename, off_t size, off_t *nread)
 {
 	int fd;
-	char *buf;
-	off_t progress;
-	ssize_t result;
 
 	if (!filename)
 		return 0;
@@ -552,32 +570,8 @@ char *slurp_file_len(const char *filename, off_t size, off_t *nread)
 				strerror(errno));
 		return 0;
 	}
-	buf = xmalloc(size);
-	progress = 0;
-	while(progress < size) {
-		result = read(fd, buf + progress, size - progress);
-		if (result < 0) {
-			if ((errno == EINTR) ||	(errno == EAGAIN))
-				continue;
-			fprintf(stderr, "read on %s of %ld bytes failed: %s\n",
-					filename, (size - progress)+ 0UL,
-					strerror(errno));
-			free(buf);
-			return 0;
-		}
-		if (result == 0)
-			/* EOF */
-			break;
-		progress += result;
-	}
-	result = close(fd);
-	if (result < 0) {
-		die("Close of %s failed: %s\n",
-			filename, strerror(errno));
-	}
-	if (nread)
-		*nread = progress;
-	return buf;
+
+	return slurp_fd(fd, filename, size, nread);
 }
 
 char *slurp_decompress_file(const char *filename, off_t *r_size)
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
