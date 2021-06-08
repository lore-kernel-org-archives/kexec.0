Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqSDD-006EKd-1e
 for kexec@lists.infradead.org; Tue, 08 Jun 2021 03:15:32 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] makedumpfile/arm64: get SECTIONS_SIZE_BITS from sysfs
Date: Tue,  8 Jun 2021 11:15:08 +0800
Message-Id: <20210608031508.12447-1-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>, Kazuhito Hagio <k-hagio-ab@nec.com>

On arm64, memory section size changes due to the kernel commit
f0b13ee23241 ("arm64/sparsemem: reduce SECTION_SIZE_BITS")

To tackle the compatibility, it is safe to read this info from sysfs
"/sys/devices/system/memory/block_size_bytes"

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>
To: kexec@lists.infradead.org
---
 arch/arm64.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 1072178..2f6f5cf 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -424,6 +424,11 @@ get_page_offset_arm64(void)
 int
 get_machdep_info_arm64(void)
 {
+	const char sys_path_section_sz[] = "/sys/devices/system/memory/block_size_bytes";
+	char memsection_sz_str[64] = { 0 };
+	unsigned long memsection_sz = 0;
+	FILE *fp;
+
 	/* Check if va_bits is still not initialized. If still 0, call
 	 * get_versiondep_info() to initialize the same.
 	 */
@@ -451,7 +456,21 @@ get_machdep_info_arm64(void)
 	}
 
 	kimage_voffset = NUMBER(kimage_voffset);
-	info->section_size_bits = SECTIONS_SIZE_BITS;
+
+	fp = fopen(sys_path_section_sz, "r");
+	if (fp) {
+		int i;
+
+		fread(&memsection_sz_str, 64, 1, fp);
+		fclose(fp);
+		memsection_sz = strtol(memsection_sz_str, NULL, 16);
+		for (i = -1; memsection_sz != 0; i++)
+			memsection_sz >>= 1;
+		info->section_size_bits = i;
+	}
+	else {
+		info->section_size_bits = SECTIONS_SIZE_BITS;
+	}
 
 	DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
 	DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
