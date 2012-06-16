Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SfnmC-00031G-94
 for kexec@lists.infradead.org; Sat, 16 Jun 2012 07:50:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH] Support kernel_noload uImage type
Date: Sat, 16 Jun 2012 16:52:15 +0900
Message-ID: <1339833135-23978-1-git-send-email-acourbot@nvidia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Do not trigger an error when loading a uImage with the
IH_TYPE_KERNEL_NOLOAD type. These images do not need to be copied to
their load address before being executed.

All archs (excepted PPC) do not use the uImage load and entry point
parameters, so their current behavior needs not be changed further than
just accepting the image type.

Tested and validated on ARM.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 include/image.h      |    2 ++
 kexec/kexec-uImage.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index e52acbe..e742aae 100644
--- a/include/image.h
+++ b/include/image.h
@@ -129,6 +129,8 @@
 #define IH_TYPE_FILESYSTEM	7	/* Filesystem Image (any type)	*/
 #define IH_TYPE_FLATDT		8	/* Binary Flat Device Tree Blob	*/
 #define IH_TYPE_KWBIMAGE	9	/* Kirkwood Boot Image		*/
+#define IH_TYPE_KERNEL_NOLOAD	14	/* OS Kernel Image, can run     */
+					/* from any load address	*/
 
 /*
  * Compression Types
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 83e7910..3bc85c5 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -39,7 +39,11 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 		return -1;
 	}
 #endif
-	if (header.ih_type != IH_TYPE_KERNEL) {
+	switch (header.ih_type) {
+	case IH_TYPE_KERNEL:
+	case IH_TYPE_KERNEL_NOLOAD:
+		break;
+	default:
 		printf("uImage type %d unsupported\n", header.ih_type);
 		return -1;
 	}
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
