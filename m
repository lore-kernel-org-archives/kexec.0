Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIVGE-0005fu-DW
 for kexec@lists.infradead.org; Mon, 22 Apr 2019 09:29:15 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Date: Mon, 22 Apr 2019 17:28:04 +0800
Message-Id: <20190422092804.15534-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: "x86@kernel.org" <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

This is a fix needed for: "x86/boot: Use efi_setup_data for searching
RSDP on kexec-ed kernels", that patch cause kexec to reset the system
on some machines.

The reason is the systab region is not mapped by the identity mapping
provided by kexec. Currently kexec only create identity mapping for
mem regions, wihch won't cover the systab. So second kernel will be
accessing a not mapped memory region and cause fault.
But as kexec tend to pad the map region up to PUD size, the
systab could be included in the map by accident, so it worked on
some machines, but that will be broken easily and unstable.

To fix it just treat systab specially, always map the systab region
unconditionally on EFI systems as long as there is a valid systab
address.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..d5da54893f97 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include <linux/efi.h>
 
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -113,6 +114,37 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
+#ifdef CONFIG_EFI
+static int init_efi_systab_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
+{
+	unsigned long mstart, mend;
+
+	if (!efi_enabled(EFI_BOOT))
+		return 0;
+
+	mstart = (boot_params.efi_info.efi_systab |
+			((u64)boot_params.efi_info.efi_systab_hi<<32));
+
+	if (efi_enabled(EFI_64BIT))
+		mend = mstart + sizeof(efi_system_table_64_t);
+	else
+		mend = mstart + sizeof(efi_system_table_32_t);
+
+	if (mstart)
+		return kernel_ident_mapping_init(info,
+				level4p, mstart, mend);
+
+	return 0;
+}
+#else
+static inline int init_efi_systab_pgtable(struct x86_mapping_info *info,
+					  pgd_t *level4p)
+{
+	return 0;
+}
+#endif
+
 static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 {
 	struct x86_mapping_info info = {
@@ -159,6 +191,14 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 			return result;
 	}
 
+	/*
+	 * Prepare EFI systab mapping for kexec kernel, systab is not
+	 * covered by pfn_mapped.
+	 */
+	result = init_efi_systab_pgtable(&info, level4p);
+	if (result)
+		return result;
+
 	return init_transition_pgtable(image, level4p);
 }
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
