Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHswF-0007pX-Nd
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 10:39:08 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v2 0/4] kexec-tools, x86: E820 memmap pass for kdump
Date: Mon, 24 Feb 2014 11:38:38 +0100
Message-ID: <2680313.u921kQOFS9@skinner>
In-Reply-To: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, vgoyal@redhat.com

On Thursday, February 20, 2014 05:28:28 PM WANG Chao wrote:
> Hi, All
> 
> When kaslr comes in and kdump is broken, it seems about the right time to
> use E820 instead of memmap=exactmap to pass memmap for kdump for the
> default memmap passing mechanism:
> http://lists.infradead.org/pipermail/kexec/2014-February/011048.html
> 
> Unfortunately, saved_max_pfn still got its user out there (calgry pci, it
> looks like the only one). So for backward compatibility, I'm introducing a
> new option --pass-memmap-cmdline to force kexec-tools to pass
> memmap=exactmap, the old way.
The saved_max_pfn usage is calgary pci looks bad/wrong and I wonder:
  - whether this is still worth touching, so that the old mechanism:
    --pass-memmap-cmdline could vanish in the one or other year and need
    not to be carried forever
I tried to find such a machine, but couldn't find anything mentioning calgary
in quite some machines' dmesg.

Approaches to avoid saved_max_pfn in calgary case:
  1) If done correctly from the beginning, the TCE table size would have
     been exposed via /sys and kexec-tools could simply add:
     calgary="128k|512K...|8M" which is already caught by pci-calgary and
     saved_max_pfn is not needed/touched anymore.
     -> Disadvantage: needs a new sysfs entry
  2) When finding max_pfn for calgary table size usage, we could try in 
     kdump case to use the highest memory (RAM or RESERVED) showing up
     in e820 map.

Please find below a patch which would eleminate the last saved_max_pfn
user. Unfortunately I could not find a calgary system to test this on.

Be aware: I could not test this.
If someone tells me for what kind of machine (and BIOS stuff enabled?)
I should look for, I can try to search for such a platform.

Something else: There is quite some duplicate code in kexec-tools when it
is about retrieving the e820 table info (normal kexec vs kdump).
Did you see my cleanups I posted long ago? Do you plan to still clean up
a bit after this series?

        Thomas



X86: Eliminate saved_max_pfn user in pci-calgary and remove the unused variable

Searching for the highest value of RAM and RESERVED memory in kdump case
should be the same as max_pfn of the original kernel.
At least this is always the case as long as type usable RAM is the highest
entry in original e820 map.

Signed-off-by: Thomas Renninger <trenn@suse.de>

diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index 779c2ef..712173e 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -49,6 +49,7 @@ static inline void early_memtest(unsigned long start, unsigned long end)
 #endif
 
 extern unsigned long e820_end_of_ram_pfn(void);
+extern unsigned long e820_end_of_e820_pfn(void);
 extern unsigned long e820_end_of_low_ram_pfn(void);
 extern u64 early_reserve_e820(u64 sizet, u64 align);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 988c00a..699e8fe 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -757,7 +757,7 @@ u64 __init early_reserve_e820(u64 size, u64 align)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820_end_pfn(unsigned long limit_pfn, unsigned type)
+unsigned long __init e820_end_pfn(unsigned long limit_pfn, unsigned type)
 {
 	int i;
 	unsigned long last_pfn = 0;
@@ -796,6 +796,12 @@ unsigned long __init e820_end_of_ram_pfn(void)
 	return e820_end_pfn(MAX_ARCH_PFN, E820_RAM);
 }
 
+unsigned long __init e820_end_of_e820_pfn(void)
+{
+	return max(e820_end_pfn(MAX_ARCH_PFN, E820_RAM),
+		   e820_end_pfn(MAX_ARCH_PFN, E820_RESERVED);
+}
+
 unsigned long __init e820_end_of_low_ram_pfn(void)
 {
 	return e820_end_pfn(1UL<<(32 - PAGE_SHIFT), E820_RAM);
@@ -847,14 +853,6 @@ static int __init parse_memmap_one(char *p)
 		return -EINVAL;
 
 	if (!strncmp(p, "exactmap", 8)) {
-#ifdef CONFIG_CRASH_DUMP
-		/*
-		 * If we are doing a crash dump, we still need to know
-		 * the real mem size before original memory map is
-		 * reset.
-		 */
-		saved_max_pfn = e820_end_of_ram_pfn();
-#endif
 		e820.nr_map = 0;
 		userdef = 1;
 		return 0;
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 299d493..89ae766 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -1371,6 +1371,7 @@ int __init detect_calgary(void)
 	unsigned long ptr;
 	unsigned int offset, prev_offset;
 	int ret;
+	unsigned long orig_max_pfn = max_pfn;
 
 	/*
 	 * if the user specified iommu=off or iommu=soft or we found
@@ -1418,8 +1419,10 @@ int __init detect_calgary(void)
 		return -ENOMEM;
 	}
 
-	specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
-					saved_max_pfn : max_pfn) * PAGE_SIZE);
+	if (is_kdump_kernel())
+		orig_max_pfn = e820_end_of_e820_pfn();
+	specified_table_size = determine_tce_table_size(orig_max_pfn
+							* PAGE_SIZE);
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
 		struct calgary_bus_info *info = &bus_info[bus];
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 7032518..bce4d97 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -87,5 +87,4 @@ extern void unregister_oldmem_pfn_is_ram(void);
 static inline int is_kdump_kernel(void) { return 0; }
 #endif /* CONFIG_CRASH_DUMP */
 
-extern unsigned long saved_max_pfn;
 #endif /* LINUX_CRASHDUMP_H */
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index c766ee5..9d50486 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -5,12 +5,6 @@
 #include <linux/export.h>
 
 /*
- * If we have booted due to a crash, max_pfn will be a very low value. We need
- * to know the amount of memory that the previous kernel used.
- */
-unsigned long saved_max_pfn;
-
-/*
  * stores the physical address of elf header of crash image
  *
  * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
