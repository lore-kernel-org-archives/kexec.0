Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <c8cb4aba4b6b58e96340e99e4b117e8a65731447.1464974516.git.geoff@infradead.org>
In-Reply-To: <cover.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v17 04/13] arm64/kexec: Add pr_debug output
Date: Fri, 03 Jun 2016 18:13:41 +0000
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

To aid in debugging kexec problems or when adding new functionality to kexec add
a new routine kexec_image_info() and several inline pr_debug statements.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/machine_kexec.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bb05529..f232bca 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -11,6 +11,7 @@
 
 #include <linux/highmem.h>
 #include <linux/kexec.h>
+#include <linux/libfdt_env.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -29,6 +30,47 @@ extern const unsigned long arm64_relocate_new_kernel_size;
 
 static unsigned long kimage_start;
 
+/**
+ * kexec_is_dtb - Helper routine to check the device tree header signature.
+ */
+static bool kexec_is_dtb(const void *dtb)
+{
+	__be32 magic;
+
+	if (get_user(magic, (__be32 *)dtb))
+		return false;
+
+	return fdt32_to_cpu(magic) == OF_DT_HEADER;
+}
+
+/**
+ * kexec_image_info - For debugging output.
+ */
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("%s:%d:\n", func, line);
+	pr_debug("  kexec kimage info:\n");
+	pr_debug("    type:        %d\n", kimage->type);
+	pr_debug("    start:       %lx\n", kimage->start);
+	pr_debug("    head:        %lx\n", kimage->head);
+	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages%s\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE,
+			(kexec_is_dtb(kimage->segment[i].buf) ?
+				", dtb segment" : ""));
+	}
+}
+
 void machine_kexec_cleanup(struct kimage *kimage)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -65,6 +107,8 @@ int machine_kexec_prepare(struct kimage *kimage)
 		}
 	}
 
+	kexec_image_info(kimage);
+
 	return 0;
 }
 
@@ -140,6 +184,25 @@ void machine_kexec(struct kimage *kimage)
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = kmap(kimage->control_code_page);
 
+	kexec_image_info(kimage);
+
+	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
+		kimage->control_code_page);
+	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
+		&reboot_code_buffer_phys);
+	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
+		reboot_code_buffer);
+	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
+		arm64_relocate_new_kernel);
+	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
+		__func__, __LINE__, arm64_relocate_new_kernel_size,
+		arm64_relocate_new_kernel_size);
+
+	pr_debug("%s:%d: kimage_head:              %lx\n", __func__, __LINE__,
+		kimage->head);
+	pr_debug("%s:%d: kimage_start:             %lx\n", __func__, __LINE__,
+		kimage_start);
+
 	/*
 	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
