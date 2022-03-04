From: Coiby Xu <coiby.xu@gmail.com>
Date: Fri,  4 Mar 2022 10:03:41 +0800
Subject: [RESEND PATCH v3 3/3] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
In-Reply-To: <20220304020341.85583-1-coiby.xu@gmail.com>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
Message-ID: <20220304020341.85583-4-coiby.xu@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Coiby Xu <coxu@redhat.com>

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 arch/arm64/kernel/kexec_image.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..51af1c22d6da 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.34.1


