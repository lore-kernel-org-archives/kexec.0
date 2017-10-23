Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e6ZfM-0006cE-Me
 for kexec@lists.infradead.org; Mon, 23 Oct 2017 10:09:08 +0000
Date: Mon, 23 Oct 2017 11:08:34 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH 2/2] ARM: read kernel size from zImage
Message-ID: <20171023100834.GA5462@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Read the new extension data which tells the boot agent about the
requirements for booting the kernel image, such as how much RAM
will be consumed by the kernel through decompression and booting.
This is necessary to control the placement of the DTB and
compressed RAM disk to avoid these objects being corrupted.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 51 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index c6ecb04..a8c40cb 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -34,6 +34,15 @@ struct zimage_header {
 #define ZIMAGE_MAGIC cpu_to_le32(0x016f2818)
 	uint32_t start;
 	uint32_t end;
+	uint32_t endian;
+
+	/* Extension to the data passed to the boot agent.  The offset
+	 * points at a tagged table following a similar format to the
+	 * ATAGs.
+	 */
+	uint32_t magic2;
+#define ZIMAGE_MAGIC2 (0x45454545)
+	uint32_t extension_tag_offset;
 };
 
 struct android_image {
@@ -114,6 +123,17 @@ struct tag {
 #define byte_size(t)    ((t)->hdr.size << 2)
 #define tag_size(type)  ((sizeof(struct tag_header) + sizeof(struct type) + 3) >> 2)
 
+struct zimage_tag {
+	struct tag_header hdr;
+	union {
+#define ZIMAGE_TAG_KRNL_SIZE cpu_to_le32(0x5a534c4b)
+		struct zimage_krnl_size {
+			uint32_t size_ptr;
+			uint32_t bss_size;
+		} krnl_size;
+	} u;
+};
+
 int zImage_arm_probe(const char *UNUSED(buf), off_t UNUSED(len))
 {
 	/* 
@@ -434,7 +454,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (dtb_file)
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
 
-	if (len > 0x34) {
+	if (len > sizeof(struct zimage_header)) {
 		const struct zimage_header *hdr;
 		off_t size;
 
@@ -460,6 +480,35 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			if (size < len)
 				len = size;
 		}
+
+		/* Do we have an extension table? */
+		if (hdr->magic2 == ZIMAGE_MAGIC2 && !kexec_arm_image_size) {
+			uint32_t offset = hdr->extension_tag_offset;
+			uint32_t max = len - sizeof(struct tag_header);
+			struct zimage_tag *tag;
+
+			dbgprintf("zImage has tags\n");
+
+			for (offset = hdr->extension_tag_offset;
+			     (tag = (void *)(buf + offset)) != NULL &&
+			     offset < max && byte_size(tag) &&
+				offset + byte_size(tag) < len;
+			     offset += byte_size(tag)) {
+				dbgprintf("  offset 0x%08x tag 0x%08x size %u\n",
+					  offset, tag->hdr.tag, byte_size(tag));
+				if (tag->hdr.tag == ZIMAGE_TAG_KRNL_SIZE) {
+					uint32_t *p = (void *)buf +
+						tag->u.krnl_size.size_ptr;
+
+					kexec_arm_image_size =
+						get_unaligned(p) +
+						tag->u.krnl_size.bss_size;
+				}
+			}
+
+			dbgprintf("kernel image size: 0x%08x\n",
+				  kexec_arm_image_size);
+		}
 	}
 
 	/* Handle android images, 2048 is the minimum page size */
-- 
2.7.4


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
