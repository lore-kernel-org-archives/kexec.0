From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 25 Mar 2022 15:06:15 +0800
Subject: [PATCH] kexec-tools: Determine if the image is lzma commpressed
Message-ID: <20220325070615.2408455-1-lichliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently there are 2 functions for decompressing compressed image. The
zlib_decompress_file() will determine if the image is compressed by gzip
before read, but lzma_decompress_file() will not. This can cause misleading
information to be printed when the image is not compressed by lzma and
debug option is used:

]# kexec -d -s -l /boot/vmlinuz-5.14.10-300.fc35.x86_64 \
--initrd /boot/initramfs-5.14.10-300.fc35.x86_64.img \
--reuse-cmdline
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/vmlinuz-5.14.10-300.fc35.x86_64 of
65536 bytes failed

Add a helper function is_lzma_file() to help behave consistently.

Signed-off-by: Lichen Liu <lichliu@redhat.com>
---
 kexec/lzma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kexec/lzma.c b/kexec/lzma.c
index 5bfccb7..f27cfe2 100644
--- a/kexec/lzma.c
+++ b/kexec/lzma.c
@@ -155,6 +155,39 @@ ssize_t lzread(LZFILE *lzfile, void *buf, size_t len)
 	}
 }
 
+int is_lzma_file(const char *filename)
+{
+	FILE *fp;
+	int ret = 0;
+	uint8_t buf[13];
+
+	if (!filename)
+		return 0;
+
+	fp = fopen(filename, "r");
+	if (fp == NULL)
+		return 0;
+
+	const size_t size = fread(buf, 1, sizeof(buf), fp);
+
+	if (size != 13)
+		return 0;
+
+	lzma_filter filter = { .id = LZMA_FILTER_LZMA1 };
+
+	switch (lzma_properties_decode(&filter, NULL, buf, 5)) {
+	case LZMA_OK:
+		ret = 1;
+		break;
+	default:
+		/* It's not a lzma file */
+		ret = 0;
+	}
+
+	fclose(fp);
+	return ret;
+}
+
 char *lzma_decompress_file(const char *filename, off_t *r_size)
 {
 	LZFILE *fp;
@@ -168,6 +201,9 @@ char *lzma_decompress_file(const char *filename, off_t *r_size)
 	if (!filename)
 		return NULL;
 
+	if (!is_lzma_file(filename))
+		return NULL;
+
 	fp = lzopen(filename, "rb");
 	if (fp == 0) {
 		dbgprintf("Cannot open `%s'\n", filename);
-- 
2.27.0


