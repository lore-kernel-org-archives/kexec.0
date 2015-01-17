Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
In-Reply-To: <cover.1421449714.git.geoff@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 7/8] arm64/kexec: Add checks for KVM
Date: Sat, 17 Jan 2015 00:23:34 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: marc.zyngier@arm.com, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

Add runtime checks that fail the arm64 kexec syscall for situations that would
result in system instability do to problems in the KVM kernel support.
These checks should be removed when the KVM problems are resolved fixed.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/machine_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 3d84759..a36459d 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -16,6 +16,9 @@
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 
+/* TODO: Remove this include when KVM can support a kexec reboot. */
+#include <asm/virt.h>
+
 /* Global variables for the relocate_kernel routine. */
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned long relocate_new_kernel_size;
@@ -100,6 +103,13 @@ int machine_kexec_prepare(struct kimage *image)
 
 	kexec_image_info(image);
 
+	/* TODO: Remove this message when KVM can support a kexec reboot. */
+	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
+		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
+			__func__);
+		return -ENOSYS;
+	}
+
 	return 0;
 }
 
-- 
2.1.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
