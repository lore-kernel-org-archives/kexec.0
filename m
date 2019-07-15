Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmu4w-0005s2-J4
 for kexec@lists.infradead.org; Mon, 15 Jul 2019 06:03:16 +0000
Received: by mail-pg1-f195.google.com with SMTP id l21so7175004pgm.3
 for <kexec@lists.infradead.org>; Sun, 14 Jul 2019 23:03:14 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 3/4] kexec/kexec-zlib.h: Add 'is_zlib_file()' helper
 function
Date: Mon, 15 Jul 2019 11:32:55 +0530
Message-Id: <1563170576-13134-4-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
References: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, horms@verge.net.au

This patch adds 'is_zlib_file()' helper function which can be
used to quickly determine with the passed kernel image is a zlib
compressed kernel image.

This is specifically useful for arm64 zImage (or Image.gz) support,
which is introduced by later patches in this patchset.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/kexec-zlib.h |  1 +
 kexec/zlib.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/kexec/kexec-zlib.h b/kexec/kexec-zlib.h
index 43c107bf4a72..16300f294759 100644
--- a/kexec/kexec-zlib.h
+++ b/kexec/kexec-zlib.h
@@ -6,5 +6,6 @@
 
 #include "config.h"
 
+int is_zlib_file(const char *filename, off_t *r_size);
 char *zlib_decompress_file(const char *filename, off_t *r_size);
 #endif /* __KEXEC_ZLIB_H */
diff --git a/kexec/zlib.c b/kexec/zlib.c
index 95b608059d41..9bc340d85001 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -23,6 +23,38 @@ static void _gzerror(gzFile fp, int *errnum, const char **errmsg)
 	}
 }
 
+int is_zlib_file(const char *filename, off_t *r_size)
+{
+	gzFile fp;
+	int errnum;
+	int is_zlib_file = 0; /* default: It's not in gzip format */
+	const char *msg;
+	ssize_t result;
+
+	if (!filename)
+		goto out;
+
+	fp = gzopen(filename, "rb");
+	if (fp == 0) {
+		_gzerror(fp, &errnum, &msg);
+		dbgprintf("Cannot open `%s': %s\n", filename, msg);
+		goto out;
+	}
+
+	if (!gzdirect(fp))
+		/* It's in gzip format */
+		is_zlib_file = 1;
+
+	result = gzclose(fp);
+	if (result != Z_OK) {
+		_gzerror(fp, &errnum, &msg);
+		dbgprintf(" Close of %s failed: %s\n", filename, msg);
+	}
+
+out:
+	return is_zlib_file;
+}
+
 char *zlib_decompress_file(const char *filename, off_t *r_size)
 {
 	gzFile fp;
@@ -84,6 +116,12 @@ fail:
 	return buf;
 }
 #else
+
+int is_zlib_file(const char *filename, off_t *r_size)
+{
+	return 0;
+}
+
 char *zlib_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
 {
 	return NULL;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
