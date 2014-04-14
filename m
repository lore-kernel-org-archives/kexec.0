Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZaHA-00075n-2t
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 06:21:53 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] makedumpfile: code cleanup: set_bitmap
Date: Mon, 14 Apr 2014 14:15:26 +0800
Message-ID: <1397456126-81299-1-git-send-email-wangnan0@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Wang Nan <wangnan0@huawei.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

This patch makes set_bitmap() to call sync_bitmap() instead rewrite
identical code to do same thing.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
---
 makedumpfile.c | 70 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 75092a8..8e6ddce 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3309,6 +3309,34 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
 }
 
 int
+sync_bitmap(struct dump_bitmap *bitmap)
+{
+	off_t offset;
+	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
+
+	/*
+	 * The bitmap buffer is not dirty, and it is not necessary
+	 * to write out it.
+	 */
+	if (bitmap->no_block < 0)
+		return TRUE;
+
+	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
+		ERRMSG("Can't seek the bitmap(%s). %s\n",
+		    bitmap->file_name, strerror(errno));
+		return FALSE;
+	}
+	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
+	    != BUFSIZE_BITMAP) {
+		ERRMSG("Can't write the bitmap(%s). %s\n",
+		    bitmap->file_name, strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
+
+int
 set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
     int val)
 {
@@ -3317,20 +3345,11 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
 	old_offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
 	new_offset = bitmap->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
 
-	if (0 <= bitmap->no_block && old_offset != new_offset) {
-		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
-			ERRMSG("Can't seek the bitmap(%s). %s\n",
-			    bitmap->file_name, strerror(errno));
-			return FALSE;
-		}
-		if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
-		    != BUFSIZE_BITMAP) {
-			ERRMSG("Can't write the bitmap(%s). %s\n",
-			    bitmap->file_name, strerror(errno));
+	if (old_offset != new_offset) {
+		if (sync_bitmap(bitmap)) {
+			ERRMSG("Can't sync bitmap\n");
 			return FALSE;
 		}
-	}
-	if (old_offset != new_offset) {
 		if (lseek(bitmap->fd, new_offset, SEEK_SET) < 0 ) {
 			ERRMSG("Can't seek the bitmap(%s). %s\n",
 			    bitmap->file_name, strerror(errno));
@@ -3379,33 +3398,6 @@ set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *c
 }
 
 int
-sync_bitmap(struct dump_bitmap *bitmap)
-{
-	off_t offset;
-	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
-
-	/*
-	 * The bitmap buffer is not dirty, and it is not necessary
-	 * to write out it.
-	 */
-	if (bitmap->no_block < 0)
-		return TRUE;
-
-	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
-		ERRMSG("Can't seek the bitmap(%s). %s\n",
-		    bitmap->file_name, strerror(errno));
-		return FALSE;
-	}
-	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
-	    != BUFSIZE_BITMAP) {
-		ERRMSG("Can't write the bitmap(%s). %s\n",
-		    bitmap->file_name, strerror(errno));
-		return FALSE;
-	}
-	return TRUE;
-}
-
-int
 sync_1st_bitmap(void)
 {
 	return sync_bitmap(info->bitmap1);
-- 
1.8.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
