Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmu4t-0005rH-BP
 for kexec@lists.infradead.org; Mon, 15 Jul 2019 06:03:12 +0000
Received: by mail-pg1-f196.google.com with SMTP id n9so949944pgc.1
 for <kexec@lists.infradead.org>; Sun, 14 Jul 2019 23:03:10 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 2/4] kexec-uImage-arm64.c: Fix return value of
 uImage_arm64_probe()
Date: Mon, 15 Jul 2019 11:32:54 +0530
Message-Id: <1563170576-13134-3-git-send-email-bhsharma@redhat.com>
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

Commit bf06cf2095e1 ("kexec/uImage: probe to identify a corrupted image"),
defined the 'uImage_probe_kernel()' function return values and
correspondingly ;uImage_arm64_probe()' returns the same (0 -> If the
image is valid 'type' image, -1 -> If the image is corrupted and
1 -> If the image is not a uImage).

This causes issues because, in later patches we introduce zImage
support for arm64, and since it is probed after uImage, the return
values from 'uImage_arm64_probe()' needs to be fixed to make sure
that kexec will not return with an invalid error code.

Now, 'uImage_arm64_probe()' returns the following values instead:
  0 - valid uImage.
 -1 - uImage is corrupted.
  1 - image is not a uImage.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-uImage-arm64.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
index 126ea9c2555b..c4669131b667 100644
--- a/kexec/arch/arm64/kexec-uImage-arm64.c
+++ b/kexec/arch/arm64/kexec-uImage-arm64.c
@@ -11,7 +11,18 @@
 
 int uImage_arm64_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_ARM64);
+	int ret;
+
+	ret = uImage_probe_kernel(buf, len, IH_ARCH_ARM64);
+
+	/*  0 - valid uImage.
+	 * -1 - uImage is corrupted.
+	 *  1 - image is not a uImage.
+	 */
+	if (!ret)
+		return 0;
+	else
+		return -1;
 }
 
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
