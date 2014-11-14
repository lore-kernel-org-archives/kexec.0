Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1415989719.15847.121.camel@smoke>
Subject: [PATCH v2 7/8] arm64/kexec: Add checks for KVM and EFI
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 14 Nov 2014 10:28:39 -0800
In-Reply-To: <546614D7.8080401@cogentembedded.com>
References: <cover.1415926876.git.geoff@infradead.org>
 <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>
 <546614D7.8080401@cogentembedded.com>
Mime-Version: 1.0
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
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Add runtime checks that fail the arm64 kexec syscall for situations that would
result in system instability do to problems in the KVM and EFI kernel support.
These checks should be removed when the KVM and EFI problems are fixed.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
v2: Typo fixes.

 arch/arm64/kernel/machine_kexec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 775bcc3..faeb4f1 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -16,6 +16,12 @@
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 
+/* TODO: Remove this include when KVM can support a kexec reboot. */
+#include <asm/virt.h>
+
+/* TODO: Remove this include when EFI can support a kexec reboot. */
+#include <linux/efi.h>
+
 /* Global variables for the relocate_kernel routine. */
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned long relocate_new_kernel_size;
@@ -101,6 +107,22 @@ int machine_kexec_prepare(struct kimage *image)
 
 	kexec_image_info(image);
 
+	/* TODO: Remove this message when KVM can support a kexec reboot. */
+	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
+		pr_err("%s: Your kernel is configured with KVM support "
+			"(CONFIG_KVM=y) which currently does not allow for "
+			"kexec re-boot.\n", __func__);
+		return -ENOSYS;
+	}
+
+	/* TODO: Remove this message when EFI can support a kexec reboot. */
+	if (efi_enabled(EFI_BOOT)) {
+		pr_err("%s: Your kernel is using the Extensible Firmware "
+			"Interface (EFI) which currently does not allow for "
+			"kexec re-boot.\n", __func__);
+		return -ENOSYS;
+	}
+
 	return 0;
 }
 
-- 
1.9.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
