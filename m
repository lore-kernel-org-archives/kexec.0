Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdKaN-0007XU-PU
 for kexec@lists.infradead.org; Thu, 12 Nov 2020 21:56:56 +0000
Received: by mail-pf1-x443.google.com with SMTP id a18so5810335pfl.3
 for <kexec@lists.infradead.org>; Thu, 12 Nov 2020 13:56:54 -0800 (PST)
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
Subject: [PATCH] arm64: kexec: disabled check if kaslr-seed dtb property was
 wiped
Date: Thu, 12 Nov 2020 13:56:43 -0800
Message-Id: <20201112215643.2970668-1-alexander.kamensky42@gmail.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: Alexander Kamensky <alexander.kamensky42@gmail.com>, Bhupesh Sharma <bhsharma@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Kexec when loading arm64 kernel checks if chosen/kaslr-seed dtb property is
wiped. It's a good assertion to verify proper behavior of kernel. However,
if bootloader creates and fills kaslr-seed property and kernel is not
configured with CONFIG_RANDOMIZE_BASE then logic of reading and wiping
kaslr-seed does not run. As a result kaslr-seed property is not zero and when
kexec tries to load secondary kernel it fails with the following message:

setup_2nd_dtb: kaslr-seed is not wiped to 0.
kexec: setup_2nd_dtb failed.
kexec: load failed.

This was observed on Yocto Project on qemuarm64 machine with 5.8 kernel,
qemu 5.1.0. Qemu created kaslr-seed property but kernel was not configured
with CONFIG_RANDOMIZE_BASE.

Although check has some value, there is a use-case where it breaks kexec,
this patch removes it.

Note in described use-case the fact that kaslr-seed is not wiped and user
readable through /sys/firmware/fdt or
/sys/firmware/devicetree/base/chosen/kaslr-seed is not a security problem
as kaslr is disabled anyway.

Signed-off-by: Alexander Kamensky <alexander.kamensky42@gmail.com>
---
 kexec/arch/arm64/kexec-arm64.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 6f572ed..4b9f2d5 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -493,7 +493,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 	int len, range_len;
 	int nodeoffset;
 	int new_size;
-	int result, kaslr_seed;
+	int result;
 
 	result = fdt_check_header(dtb->buf);
 
@@ -564,18 +564,6 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 			return result;
 		}
 	} else {
-		kaslr_seed = fdt64_to_cpu(*prop);
-
-		/* kaslr_seed must be wiped clean by primary
-		 * kernel during boot
-		 */
-		if (kaslr_seed != 0) {
-			dbgprintf("%s: kaslr-seed is not wiped to 0.\n",
-					__func__);
-			result = -EINVAL;
-			goto on_error;
-		}
-
 		/*
 		 * Invoke the getrandom system call with
 		 * GRND_NONBLOCK, to make sure we
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
