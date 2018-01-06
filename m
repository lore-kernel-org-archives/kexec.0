Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eXcqf-0004Qo-Rf
 for kexec@lists.infradead.org; Sat, 06 Jan 2018 01:00:35 +0000
Date: Sat, 6 Jan 2018 02:00:13 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20180106010013.73suskgxm7lox7g6@dwarf.suse.cz>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
 <20171218134736.GA4035@x1>
 <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
 <20171219015804.GC4035@x1>
 <20171219175827.oqfskuax6zzm2ljq@dwarf.suse.cz>
 <20171227074449.GA15255@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171227074449.GA15255@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Baoquan,

thank you very much for your review!

On Wed, Dec 27, 2017 at 03:44:49PM +0800, Baoquan He wrote:
> > > 1) If 'iommu=off' is specified in 1st kernel but not in kdump kernel, it
> > > will ignore the ram we need dump.
> > 
> > yes, instead of crashing the machine (because GART may be initialized in the
> > 2nd kernel, overlapping the 1st kernel memory, which the 2nd kernel with its
> > fake e820 map sees as unused).
> > 
> > I'd say this is an improvement.
> 
> I don't get what you said. If 'iommu=off' only specified in 1st kernel,
> kdump kernel will think the memory which GART bar pointed as a hole.
> This is incorrect. I don't see the improvement.

Without the patch, the kernel will crash/hang the machine, as it
will (correctly) try to dump the first kernel's memory that is
now mapped by the GART.

With the patch it will produce a dump with the data missing.
But this is just a corner case, I don't see why someone would
specify iommu=off in the first kernel and not the second.

So instead of crashing and producing no dump at all, we get a
dump with some data possibly missing.

> I understand you could get a bug report from other people, and have to
> fix it as an assignee. And this fix is located in aperture_64.c only,
> I am fine it's done like this. Maybe you can try the way I suggested
> that only removing the region from io resource, but not touching anything
> else, if you have interest.
> 
> So if have to, could you add some code comments around your fix to notice
> people why these code are introduced? Commit log can help to understand
> added code, while sometime file moving may make this checking very hard.

Sure, the full patch with comments added is below. Do the
comments make sense? Do you want me to re-post it as v3?:

---
On machines where the GART aperture is mapped over physical RAM
/proc/vmcore contains the remapped range and reading it may
cause hangs or reboots. 

In the past, the GART region was added into the resource map, implemented by
commit 56dd669a138c ("[PATCH] Insert GART region into resource map")

However, inserting the iomem_resource from the early GART code caused
resource conflicts with some AGP drivers (bko#72201), which got avoided by
reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). This revert introduced the /proc/vmcore bug.

The vmcore ELF header is either prepared by the kernel (when using the
kexec_file_load syscall) or by the kexec userspace (when using the kexec_load
syscall). Since we no longer have the GART iomem resource, the userspace
kexec has no way of knowing which region to exclude from the ELF header.

Changes from v1 of this patch:
Instead of excluding the aperture from the ELF header, this patch
makes /proc/vmcore return zeroes in the second kernel when attempting to
read the aperture region. This is done by reusing the
gart_oldmem_pfn_is_ram infrastructure originally intended to exclude XEN
balooned memory. This works for both, the kexec_file_load and kexec_load
syscalls.

[Note that the GART region is the same in the first and second kernels:
regardless whether the first kernel fixed up the northbridge/bios setting
and mapped the aperture over physical memory, the second kernel finds the
northbridge properly configured by the first kernel and the aperture
never overlaps with e820 memory because the second kernel has a fake e820
map created from the crashkernel memory regions. Thus, the second kernel
keeps the aperture address/size as configured by the first kernel.]

register_oldmem_pfn_is_ram can only register one callback and returns an error
if the callback has been registered already. Since XEN used to be the only user
of this function, it never checks the return value. Now that we have more than
one user, I added a WARN_ON just in case agp, XEN, or any other future user of
register_oldmem_pfn_is_ram were to step on each other's toes.


Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index f5d92bc3b884..2c4d5ece7456 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
 #include <asm/x86_init.h>
+#include <linux/crash_dump.h>
 
 /*
  * Using 512M as goal, in case kexec will load kernel_big
@@ -56,6 +57,33 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
+#ifdef CONFIG_PROC_VMCORE
+/*
+ * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
+ * use the same range because it will remain configured in the northbridge.
+ * Trying to dump this area via /proc/vmcore may crash the machine, so exclude
+ * it from vmcore.
+ */
+static unsigned long aperture_pfn_start, aperture_page_count;
+
+static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+{
+	return likely((pfn < aperture_pfn_start) ||
+		      (pfn >= aperture_pfn_start + aperture_page_count));
+}
+
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+	aperture_pfn_start = aper_base >> PAGE_SHIFT;
+	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+}
+#else
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+}
+#endif
+
 /* This code runs before the PCI subsystem is initialized, so just
    access the northbridge directly. */
 
@@ -435,8 +463,16 @@ int __init gart_iommu_hole_init(void)
 
 out:
 	if (!fix && !fallback_aper_force) {
-		if (last_aper_base)
+		if (last_aper_base) {
+			/*
+			 * If this is the kdump kernel, the first kernel
+			 * may have allocated the range over its e820 RAM
+			 * and fixed up the northbridge
+			 */
+			exclude_from_vmcore(last_aper_base, last_aper_order);
+
 			return 1;
+		}
 		return 0;
 	}
 
@@ -473,6 +509,14 @@ int __init gart_iommu_hole_init(void)
 		return 0;
 	}
 
+	/*
+	 * If this is the kdump kernel _and_ the first kernel did not
+	 * configure the aperture in the northbridge, this range may
+	 * overlap with the first kernel's memory. We can't access the
+	 * range through vmcore even though it should be part of the dump.
+	 */
+	exclude_from_vmcore(aper_alloc, aper_order);
+
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
 		int bus, dev_base, dev_limit;
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index 2cfcfe4f6b2a..dd2ad82eee80 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -75,6 +75,6 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
+	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
 }

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
