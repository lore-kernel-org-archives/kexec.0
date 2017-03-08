Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 4/7] uImage: use 'char *' instead of 'unsigned char *' for
 uImage_load()
Date: Wed,  8 Mar 2017 22:41:11 +0000
Message-Id: <20170308224114.49729-4-dwmw2@infradead.org>
In-Reply-To: <20170308224114.49729-1-dwmw2@infradead.org>
References: <20170308224114.49729-1-dwmw2@infradead.org>
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
Cc: David Woodhouse <dwmw@amazon.co.uk>

From: David Woodhouse <dwmw@amazon.co.uk>

This was only ever used on PPC, where they are equivalent and we
never saw the resulting -Wpointer-sign warnings.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/kexec-uImage.h            | 4 ++--
 kexec/arch/ppc/kexec-uImage-ppc.c | 2 +-
 kexec/kexec-uImage.c              | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/kexec-uImage.h b/include/kexec-uImage.h
index 4725157..483b578 100644
--- a/include/kexec-uImage.h
+++ b/include/kexec-uImage.h
@@ -2,7 +2,7 @@
 #define __KEXEC_UIMAGE_H__
 
 struct Image_info {
-	const unsigned char *buf;
+	const char *buf;
 	off_t len;
 	unsigned int base;
 	unsigned int ep;
@@ -11,5 +11,5 @@ struct Image_info {
 int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch);
 int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch);
 int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch);
-int uImage_load(const unsigned char *buf, off_t len, struct Image_info *info);
+int uImage_load(const char *buf, off_t len, struct Image_info *info);
 #endif
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index c89a1a7..5eec6e4 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -55,7 +55,7 @@ char *slurp_ramdisk_ppc(const char *filename, off_t *r_size)
 {
 	struct Image_info img;
 	off_t size;
-	const unsigned char *buf = slurp_file(filename, &size);
+	const char *buf = slurp_file(filename, &size);
 	int rc;
 
 	/* Check if this is a uImage RAMDisk */
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 49f266a..2740a26 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -136,7 +136,7 @@ int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch)
 #define COMMENT		0x10 /* bit 4 set: file comment present */
 #define RESERVED	0xE0 /* bits 5..7: reserved */
 
-static int uImage_gz_load(const unsigned char *buf, off_t len,
+static int uImage_gz_load(const char *buf, off_t len,
 		struct Image_info *image)
 {
 	int ret;
@@ -225,14 +225,14 @@ static int uImage_gz_load(const unsigned char *buf, off_t len,
 	return 0;
 }
 #else
-static int uImage_gz_load(const unsigned char *UNUSED(buf), off_t UNUSED(len),
+static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),
 		struct Image_info *UNUSED(image))
 {
 	return -1;
 }
 #endif
 
-int uImage_load(const unsigned char *buf, off_t len, struct Image_info *image)
+int uImage_load(const char *buf, off_t len, struct Image_info *image)
 {
 	const struct image_header *header = (const struct image_header *)buf;
 	const unsigned char *img_buf = buf + sizeof(struct image_header);
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
