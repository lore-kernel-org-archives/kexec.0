Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fyBjD-0003JG-CN
 for kexec@lists.infradead.org; Fri, 07 Sep 2018 08:02:57 +0000
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so6645976pfn.0
 for <kexec@lists.infradead.org>; Fri, 07 Sep 2018 01:02:45 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 15/16] arm64: kexec_file: add kernel signature
 verification support
Date: Fri,  7 Sep 2018 17:00:39 +0900
Message-Id: <20180907080040.4967-10-takahiro.akashi@linaro.org>
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

With this patch, kernel verification can be done without IMA security
subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.

You can create a signed kernel image with:
    $ sbsign --key ${KEY} --cert ${CERT} Image

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5eb18d0cb513..e7de9500bf0b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -852,6 +852,30 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
+config KEXEC_IMAGE_VERIFY_SIG
+	bool "Enable Image signature verification support"
+	default y
+	depends on KEXEC_VERIFY_SIG
+	depends on EFI && SIGNED_PE_FILE_VERIFICATION
+	help
+	  Enable Image signature verification support.
+
+comment "Support for PE file signature verification disabled"
+	depends on KEXEC_VERIFY_SIG
+	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index d64f5e9f9d22..578d358632d0 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/string.h>
+#include <linux/verification.h>
 #include <asm/boot.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
@@ -28,6 +29,9 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&h->mz_magic, "MZ", 2) ?  "no" : "yes");
+
 	return 0;
 }
 
@@ -102,7 +106,18 @@ static void *image_load(struct kimage *image,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+static int image_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	return verify_pefile_signature(kernel, kernel_len, NULL,
+				       VERIFYING_KEXEC_PE_SIGNATURE);
+}
+#endif
+
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
 };
-- 
2.18.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
