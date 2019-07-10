Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlIfr-0006Jl-OV
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 19:54:47 +0000
Received: by mail-pg1-f193.google.com with SMTP id i18so1718835pgl.11
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 12:54:43 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/4] kexec-uImage-arm64.c: Fix return value of
 uImage_arm64_probe()
Date: Thu, 11 Jul 2019 01:24:27 +0530
Message-Id: <1562788469-22935-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
References: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, horms@verge.net.au, takahiro.akashi@linaro.org

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
