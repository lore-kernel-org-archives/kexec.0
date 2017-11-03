Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eAflx-0005TT-1a
 for kexec@lists.infradead.org; Fri, 03 Nov 2017 17:28:51 +0000
Date: Fri, 3 Nov 2017 18:28:22 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
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
To: David Airlie <airlied@linux.ie>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hpe.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On machines where the GART aperture is mapped over physical RAM
/proc/vmcore contains the remapped range and reading it may
cause hangs or reboots. This range needs to be excluded from /proc/vmcore.

This has originally been implemented by commit dd5f726076cc ("kexec:
support for kexec on panic using new system call").

The implementation relied on the GART code adding an iomem_resource for
this range called "GART", as implemented by commit 56dd669a138c ("[PATCH]
Insert GART region into resource map")

However, inserting the iomem_resource from the early GART code caused
resource conflicts with some AGP drivers (bko#72201), which got avoided by
reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). This revert introduced the /proc/vmcore bug.

With the "GART" iomem_resource removed, the defunct code in crash.c has
been removed by commit f296f2634920 ("x86/kexec: Remove walk_iomem_res()
call with GART type")

The patch below stores the location of the GART region in two variables
(named gart_stolen_ram_start and gart_stolen_ram_end) and reverts/adapts
parts of f296f2634920 to exclude the region from /proc/vmcore.

Passing the information via an iomem_resource (or by reserving the range
in the e820, which would propagate into an iomem_resource) would
reintroduce bko#72201.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")

diff --git a/arch/x86/include/asm/gart.h b/arch/x86/include/asm/gart.h
index 1d268098ac2e..324a0a19d166 100644
--- a/arch/x86/include/asm/gart.h
+++ b/arch/x86/include/asm/gart.h
@@ -2,6 +2,7 @@
 #define _ASM_X86_GART_H
 
 #include <asm/e820/api.h>
+#include <linux/pci.h>
 
 extern void set_up_gart_resume(u32, u32);
 
@@ -33,6 +34,8 @@ extern int fix_aperture;
 extern int gart_iommu_aperture;
 extern int gart_iommu_aperture_allowed;
 extern int gart_iommu_aperture_disabled;
+extern u32 gart_stolen_ram_start;
+extern u32 gart_stolen_ram_end;
 
 extern void early_gart_iommu_check(void);
 extern int gart_iommu_init(void);
@@ -43,6 +46,8 @@ extern int gart_iommu_hole_init(void);
 #define gart_iommu_aperture            0
 #define gart_iommu_aperture_allowed    0
 #define gart_iommu_aperture_disabled   1
+#define gart_stolen_ram_start	       0
+#define gart_stolen_ram_end	       0
 
 static inline void early_gart_iommu_check(void)
 {
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index ef2859f9fcce..bc9a9b5b88e3 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -49,6 +49,8 @@
 int gart_iommu_aperture;
 int gart_iommu_aperture_disabled __initdata;
 int gart_iommu_aperture_allowed __initdata;
+u32 gart_stolen_ram_start;
+u32 gart_stolen_ram_end;
 
 int fallback_aper_order __initdata = 1; /* 64MB */
 int fallback_aper_force __initdata;
@@ -87,6 +89,9 @@ static u32 __init allocate_aperture(void)
 	register_nosave_region(addr >> PAGE_SHIFT,
 			       (addr+aper_size) >> PAGE_SHIFT);
 
+	gart_stolen_ram_start = (u32)addr;
+	gart_stolen_ram_end = (u32)addr + aper_size - 1;
+
 	return (u32)addr;
 }
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 44404e2307bb..ce065d72656d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -37,6 +37,7 @@
 #include <asm/reboot.h>
 #include <asm/virtext.h>
 #include <asm/intel_pt.h>
+#include <asm/gart.h>
 
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
@@ -58,7 +59,7 @@ struct crash_elf_data {
 	struct kimage *image;
 	/*
 	 * Total number of ram ranges we have after various adjustments for
-	 * crash reserved region, etc.
+	 * GART, crash reserved region etc.
 	 */
 	unsigned int max_nr_ranges;
 
@@ -217,7 +218,6 @@ static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
 	return 0;
 }
 
-
 /* Gather all the required information to prepare elf headers for ram regions */
 static void fill_up_crash_elf_data(struct crash_elf_data *ced,
 				   struct kimage *image)
@@ -231,6 +231,15 @@ static void fill_up_crash_elf_data(struct crash_elf_data *ced,
 
 	ced->max_nr_ranges = nr_ranges;
 
+	/*
+	 * We don't create ELF headers for GART aperture as an attempt
+	 * to dump this memory in second kernel leads to hang/crash.
+	 * If gart aperture is mapped over RAM, one needs to exclude that region
+	 * and that requires an extra phdr.
+	 */
+	if (gart_stolen_ram_start)
+		ced->max_nr_ranges++;
+
 	/* Exclusion of crash region could split memory ranges */
 	ced->max_nr_ranges++;
 
@@ -339,6 +348,14 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced,
 			return ret;
 	}
 
+	/* Exclude GART region */
+	if (gart_stolen_ram_start) {
+		ret = exclude_mem_range(cmem, gart_stolen_ram_start,
+					gart_stolen_ram_end);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
