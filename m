Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZziIg-00017L-Gd
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 09:48:15 +0000
Received: by wmvv187 with SMTP id v187so63838229wmv.1
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 01:47:52 -0800 (PST)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2] kexex: arm: create ATAGS_MEM tag from devicetree memory
 node
Date: Fri, 20 Nov 2015 10:47:47 +0100
Message-Id: <1448012867-10421-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

booting a non-devicetree kernel from a devicetree kernel failed,
since the memory layout wasn't passed.

Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
---
 kexec/arch/arm/kexec-zImage-arm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index ff4e38d..d5b8ab4 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -139,6 +139,38 @@ struct tag * atag_read_tags(void)
 	return (struct tag *) buf;
 }
 
+static
+int create_mem32_tag(struct tag_mem32 *tag_mem32)
+{
+	const char fn[]= "/proc/device-tree/memory/reg";
+	uint32_t tmp[2];
+	FILE *fp;
+
+	fp = fopen(fn, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %m\n", fn);
+		return -1;
+	}
+
+	if (fread(tmp, sizeof(tmp[0]), 2, fp) != 2) {
+		fprintf(stderr, "Short read %s\n", fn);
+		fclose(fp);
+		return -1;
+	}
+
+	if (ferror(fp)) {
+		fprintf(stderr, "Cannot read %s: %m\n", fn);
+		fclose(fp);
+		return -1;
+	}
+
+	/* atags_mem32 has base/size fields reversed! */
+	tag_mem32->size = be32_to_cpu(tmp[1]);
+	tag_mem32->start = be32_to_cpu(tmp[0]);
+
+	fclose(fp);
+	return 0;
+}
 
 static
 int atag_arm_load(struct kexec_info *info, unsigned long base,
@@ -182,6 +214,12 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
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
