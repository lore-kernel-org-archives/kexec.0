Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZyJLZ-00074A-HY
 for kexec@lists.infradead.org; Mon, 16 Nov 2015 12:57:26 +0000
Received: by wmdw130 with SMTP id w130so109732701wmd.0
 for <kexec@lists.infradead.org>; Mon, 16 Nov 2015 04:57:03 -0800 (PST)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 1/2] kexex: arm: create ATAGS_MEM tag from devicetree memory
 node
Date: Mon, 16 Nov 2015 13:56:54 +0100
Message-Id: <1447678615-16987-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, Andreas Fenkart <afenkart@gmail.com>

From: Andreas Fenkart <afenkart@gmail.com>

booting a non-devicetree kernel from a devicetree kernel failed,
since the memory layout wasn't passed.

Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
---
 kexec/arch/arm/kexec-zImage-arm.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index ff4e38d..f460ba7 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -4,6 +4,7 @@
  */
 #define _GNU_SOURCE
 #define _XOPEN_SOURCE
+#include <assert.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -139,6 +140,42 @@ struct tag * atag_read_tags(void)
 	return (struct tag *) buf;
 }
 
+static
+int create_mem32_tag(struct tag_mem32 *tag_mem32)
+{
+	const char fn[]= "/proc/device-tree/memory/reg";
+	FILE *fp;
+	uint32_t tmp[2];
+	int ret = 0;
+
+	assert(tag_mem32);
+	fp = fopen(fn, "r");
+	if (!fp) {
+		ret = errno;
+		fprintf(stderr, "Cannot open %s: %m\n", fn);
+		return ret;
+	}
+
+	if (!fread(tmp, sizeof(tmp[0]), 2, fp)) {
+		ret = ENOENT;
+		fprintf(stderr, "Short read %s\n", fn);
+		goto out;
+	}
+
+	if (ferror(fp)) {
+		ret = errno;
+		fprintf(stderr, "Cannot read %s: %m\n", fn);
+		goto out;
+	}
+
+	/* atags_mem32 has base/size fields reversed! */
+	tag_mem32->size = be32_to_cpu(tmp[1]);
+	tag_mem32->start = be32_to_cpu(tmp[0]);
+
+out:
+	fclose(fp);
+	return ret;
+}
 
 static
 int atag_arm_load(struct kexec_info *info, unsigned long base,
@@ -182,6 +219,12 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 		params->hdr.size = 2;
 		params->hdr.tag = ATAG_CORE;
 		params = tag_next(params);
+
+		if (!create_mem32_tag(&params->u.mem)) {
+			params->hdr.size = 4;
+			params->hdr.tag = ATAG_MEM;
+			params = tag_next(params);
+		}
 	}
 
 	if (initrd) {
-- 
2.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
