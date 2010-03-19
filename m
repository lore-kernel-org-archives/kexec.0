Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nscgc-0006bg-N8
	for kexec@lists.infradead.org; Fri, 19 Mar 2010 13:56:31 +0000
From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] kexec-tools: Fix unused return value warning for fread
Date: Fri, 19 Mar 2010 15:55:04 +0200
Message-Id: <78968d16b4ea65b185019732d0af5888ef070358.1269006846.git.ameya.palande@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 kexec/arch/arm/kexec-zImage-arm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 3bb49a7..72fcdd8 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -110,7 +110,11 @@ struct tag * atag_read_tags(void)
 		return NULL;
 	}
 
-	fread(buf, sizeof(buf[1]), BOOT_PARAMS_SIZE, fp);
+	if (!fread(buf, sizeof(buf[1]), BOOT_PARAMS_SIZE, fp)) {
+		fclose(fp);
+		return NULL;
+	}
+
 	if (ferror(fp)) {
 		fprintf(stderr, "Cannot read %s: %s\n",
 			fn, strerror(errno));
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
