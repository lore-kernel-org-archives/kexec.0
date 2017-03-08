Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 5/7] uImage: use 'char *' instead of 'unsigned char *' for
 uImage_probe()
Date: Wed,  8 Mar 2017 22:41:12 +0000
Message-Id: <20170308224114.49729-5-dwmw2@infradead.org>
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

... and friends. Again, PPC never cared about the difference, while
ARM had to add an explicit cast to work around it, which we can remove
now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/kexec-uImage.h            |  6 +++---
 kexec/arch/arm/kexec-uImage-arm.c |  3 +--
 kexec/kexec-uImage.c              | 10 +++++-----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/kexec-uImage.h b/include/kexec-uImage.h
index 483b578..983d63f 100644
--- a/include/kexec-uImage.h
+++ b/include/kexec-uImage.h
@@ -8,8 +8,8 @@ struct Image_info {
 	unsigned int ep;
 };
 
-int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch);
-int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch);
-int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch);
+int uImage_probe(const char *buf, off_t len, unsigned int arch);
+int uImage_probe_kernel(const char *buf, off_t len, unsigned int arch);
+int uImage_probe_ramdisk(const char *buf, off_t len, unsigned int arch);
 int uImage_load(const char *buf, off_t len, struct Image_info *info);
 #endif
diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 8e0a9ac..03c2f4d 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -11,8 +11,7 @@
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel((const unsigned char *)buf, len,
-				   IH_ARCH_ARM);
+	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 2740a26..eeee4be 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -24,7 +24,7 @@
  *
  * Returns 0 if this is not a uImage
  */
-int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
+int uImage_probe(const char *buf, off_t len, unsigned int arch)
 {
 	struct image_header header;
 #ifdef HAVE_LIBZ
@@ -109,7 +109,7 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
  *  1		- If the image is not a uImage.
  */
 
-int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch)
+int uImage_probe_kernel(const char *buf, off_t len, unsigned int arch)
 {
 	int type = uImage_probe(buf, len, arch);
 	if (type < 0)
@@ -118,7 +118,7 @@ int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch)
 	return !(type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD);
 }
 
-int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch)
+int uImage_probe_ramdisk(const char *buf, off_t len, unsigned int arch)
 {
 	int type = uImage_probe(buf, len, arch);
 
@@ -220,7 +220,7 @@ static int uImage_gz_load(const char *buf, off_t len,
 	} while (1);
 
 	inflateEnd(&strm);
-	image->buf = uncomp_buf;
+	image->buf = (char *)uncomp_buf;
 	image->len = mem_alloc - strm.avail_out;
 	return 0;
 }
@@ -235,7 +235,7 @@ static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),
 int uImage_load(const char *buf, off_t len, struct Image_info *image)
 {
 	const struct image_header *header = (const struct image_header *)buf;
-	const unsigned char *img_buf = buf + sizeof(struct image_header);
+	const char *img_buf = buf + sizeof(struct image_header);
 	off_t img_len = be32_to_cpu(header->ih_size);
 
 	/*
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
