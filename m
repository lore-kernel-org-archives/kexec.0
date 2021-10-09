Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ97C-005OWu-JY
 for kexec@lists.infradead.org; Sat, 09 Oct 2021 09:58:03 +0000
Received: by mail-pg1-f198.google.com with SMTP id
 o10-20020a65614a000000b002850cb8c434so3267422pgv.13
 for <kexec@lists.infradead.org>; Sat, 09 Oct 2021 02:55:23 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
Subject: [PATCH v2 2/2] arm64: kexec_file: use more system keyrings to verify
 kernel image signature
Date: Sat,  9 Oct 2021 17:54:58 +0800
Message-Id: <20211009095458.297191-3-coxu@redhat.com>
In-Reply-To: <20211009095458.297191-1-coxu@redhat.com>
References: <20211009095458.297191-1-coxu@redhat.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, open list <linux-kernel@vger.kernel.org>

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..2357ee2f229a 100644
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
+	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
