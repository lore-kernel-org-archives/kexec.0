Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ozheu-0006kS-Fo
	for kexec@lists.infradead.org; Sun, 26 Sep 2010 03:12:15 +0000
Date: Sat, 25 Sep 2010 23:11:31 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <1041998395.1991851285470691262.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1614106428.1991831285470588200.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: kexec load failure introduced by "x86, memblock: Replace
	e820_/_early string with memblock_"
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-next <linux-next@vger.kernel.org>, kexec <kexec@lists.infradead.org>

# /sbin/kexec -p '--command-line=ro root=/dev/mapper/VolGroup-lv_root rd_LVM_LV=VolGroup/lv_root rd_LVM_LV=VolGroup/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rhgb quiet console=tty0 console=ttyS0,115200 crashkernel=128M irqpoll maxcpus=1 reset_devices cgroup_disable=memory ' --initrd=/boot/initrd-2.6.36-rc3+kdump.img /boot/vmlinuz-2.6.36-rc3+

BUG: unable to handle kernel paging request at ffff8800dfffe400
IP: [<ffffffff8113376b>] per_cpu_ptr_to_phys+0x3b/0x120
PGD 1a26063 PUD 1fffc067 PMD 1fffd067 PTE 0
Oops: 0000 [#1] SMP 
last sysfs file: /sys/devices/system/cpu/cpu0/crash_notes
CPU 3 
Modules linked in: ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_conntrack_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ipv6 virtio_balloon pcspkr 8139too 8139cp mii snd_intel8x0 snd_ac97_codec ac97_bus snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc sg i2c_piix4 i2c_core ext4 mbcache jbd2 floppy sd_mod crc_t10dif virtio_pci virtio_ring virtio pata_acpi ata_generic ata_piix dm_mod [last unloaded: scsi_wait_scan]

Pid: 5671, comm: kexec Not tainted 2.6.35+ #11 /KVM
RIP: 0010:[<ffffffff8113376b>]  [<ffffffff8113376b>] per_cpu_ptr_to_phys+0x3b/0x120
RSP: 0018:ffff88064567fe38  EFLAGS: 00010286
RAX: ffff8800df440000 RBX: ffff8800df41d990 RCX: ffff8800df400000
RDX: ffff8800dfff6400 RSI: 0000000000001000 RDI: ffff8800df41d990
RBP: ffff88064567fe58 R08: ffffffff81651f20 R09: ffff8800df40cb38
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88083dcd18e0
R13: ffff88064567ff48 R14: 0000000000001000 R15: 00007f969401b000
FS:  00007f96952e4700(0000) GS:ffff8800df4c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800dfffe400 CR3: 0000000818130000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process kexec (pid: 5671, threadinfo ffff88064567e000, task ffff8808ddba0180)
Stack:
 ffff88064567fe68 ffff88083d4f8000 ffff88083dcd18e0 ffff88064567ff48
<0> ffff88064567fe78 ffffffff812ea28b ffff88064567fe78 ffff88083dcd18c0
<0> ffff88064567fe88 ffffffff812e4f0f ffff88064567fee8 ffffffff811a5d11
Call Trace:
 [<ffffffff812ea28b>] show_crash_notes+0x2b/0x50
 [<ffffffff812e4f0f>] sysdev_show+0x1f/0x30
 [<ffffffff811a5d11>] sysfs_read_file+0x111/0x1f0
 [<ffffffff8113e7e5>] vfs_read+0xb5/0x1a0
 [<ffffffff810b5952>] ? audit_syscall_entry+0x252/0x280
 [<ffffffff8113e921>] sys_read+0x51/0x90
 [<ffffffff8100b072>] system_call_fastpath+0x16/0x1b
Code: 00 00 48 8b 05 bf 81 e2 00 8b 35 dd 46 9c 00 48 8b 15 0a 47 9c 00 48 89 fb 48 8b 48 18 8b 05 a5 46 9c 00 c1 e0 0c 48 98 48 01 c8 <48> 03 04 f2 48 39 c7 0f 83 a0 00 00 00 8b 05 aa 46 9c 00 48 03 
RIP  [<ffffffff8113376b>] per_cpu_ptr_to_phys+0x3b/0x120
 RSP <ffff88064567fe38>
CR2: ffff8800dfffe400
---[ end trace 1f847047fea7430c ]---

It was discovered that this commit introduced the regression,

commit a9ce6bc15100023b411f8117e53a016d61889800
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Wed Aug 25 13:39:17 2010 -0700

    x86, memblock: Replace e820_/_early string with memblock_
    
    1.include linux/memblock.h directly. so later could reduce e820.h reference.
    2 this patch is done by sed scripts mainly
    
    -v2: use MEMBLOCK_ERROR instead of -1ULL or -1UL
    
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: H. Peter Anvin <hpa@zytor.com>

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8406ed7..8e4a165 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -90,7 +90,7 @@ extern void __iomem *efi_ioremap(unsigned long addr, unsigned long size,
 #endif /* CONFIG_X86_32 */
 
 extern int add_efi_memmap;
-extern void efi_reserve_early(void);
+extern void efi_memblock_x86_reserve_range(void);
 extern void efi_call_phys_prelog(void);
 extern void efi_call_phys_epilog(void);
 
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index fcc3c61..d829e75 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/dmi.h>
 #include <linux/cpumask.h>
 #include <asm/segment.h>
@@ -125,7 +126,7 @@ void acpi_restore_state_mem(void)
  */
 void __init acpi_reserve_wakeup_memory(void)
 {
-	unsigned long mem;
+	phys_addr_t mem;
 
 	if ((&wakeup_code_end - &wakeup_code_start) > WAKEUP_SIZE) {
 		printk(KERN_ERR
@@ -133,15 +134,15 @@ void __init acpi_reserve_wakeup_memory(void)
 		return;
 	}
 
-	mem = find_e820_area(0, 1<<20, WAKEUP_SIZE, PAGE_SIZE);
+	mem = memblock_find_in_range(0, 1<<20, WAKEUP_SIZE, PAGE_SIZE);
 
-	if (mem == -1L) {
+	if (mem == MEMBLOCK_ERROR) {
 		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
 		return;
 	}
 	acpi_realmode = (unsigned long) phys_to_virt(mem);
 	acpi_wakeup_address = mem;
-	reserve_early(mem, mem + WAKEUP_SIZE, "ACPI WAKEUP");
+	memblock_x86_reserve_range(mem, mem + WAKEUP_SIZE, "ACPI WAKEUP");
 }
 
 
diff --git a/arch/x86/kernel/apic/numaq_32.c b/arch/x86/kernel/apic/numaq_32.c
index 3e28401..960f26a 100644
--- a/arch/x86/kernel/apic/numaq_32.c
+++ b/arch/x86/kernel/apic/numaq_32.c
@@ -26,6 +26,7 @@
 #include <linux/nodemask.h>
 #include <linux/topology.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
@@ -88,7 +89,7 @@ static inline void numaq_register_node(int node, struct sys_cfg_data *scd)
 	node_end_pfn[node] =
 		 MB_TO_PAGES(eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
 
-	e820_register_active_regions(node, node_start_pfn[node],
+	memblock_x86_register_active_regions(node, node_start_pfn[node],
 						node_end_pfn[node]);
 
 	memory_present(node, node_start_pfn[node], node_end_pfn[node]);
diff --git a/arch/x86/kernel/efi.c b/arch/x86/kernel/efi.c
index c2fa9b8..0fe27d7 100644
--- a/arch/x86/kernel/efi.c
+++ b/arch/x86/kernel/efi.c
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/efi.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include <linux/time.h>
@@ -275,7 +276,7 @@ static void __init do_add_efi_memmap(void)
 	sanitize_e820_map(e820.map, ARRAY_SIZE(e820.map), &e820.nr_map);
 }
 
-void __init efi_reserve_early(void)
+void __init efi_memblock_x86_reserve_range(void)
 {
 	unsigned long pmap;
 
@@ -290,7 +291,7 @@ void __init efi_reserve_early(void)
 		boot_params.efi_info.efi_memdesc_size;
 	memmap.desc_version = boot_params.efi_info.efi_memdesc_version;
 	memmap.desc_size = boot_params.efi_info.efi_memdesc_size;
-	reserve_early(pmap, pmap + memmap.nr_map * memmap.desc_size,
+	memblock_x86_reserve_range(pmap, pmap + memmap.nr_map * memmap.desc_size,
 		      "EFI memmap");
 }
 
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index da60aa8..74e4cf6 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -42,7 +42,7 @@ void __init i386_start_kernel(void)
 	memblock_x86_reserve_range(PAGE_SIZE, PAGE_SIZE + PAGE_SIZE, "EX TRAMPOLINE");
 #endif
 
-	reserve_early(__pa_symbol(&_text), __pa_symbol(&__bss_stop), "TEXT DATA BSS");
+	memblock_x86_reserve_range(__pa_symbol(&_text), __pa_symbol(&__bss_stop), "TEXT DATA BSS");
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Reserve INITRD */
@@ -51,7 +51,7 @@ void __init i386_start_kernel(void)
 		u64 ramdisk_image = boot_params.hdr.ramdisk_image;
 		u64 ramdisk_size  = boot_params.hdr.ramdisk_size;
 		u64 ramdisk_end   = PAGE_ALIGN(ramdisk_image + ramdisk_size);
-		reserve_early(ramdisk_image, ramdisk_end, "RAMDISK");
+		memblock_x86_reserve_range(ramdisk_image, ramdisk_end, "RAMDISK");
 	}
 #endif
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8ee930f..97adf98 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -101,7 +101,7 @@ void __init x86_64_start_reservations(char *real_mode_data)
 
 	memblock_init();
 
-	reserve_early(__pa_symbol(&_text), __pa_symbol(&__bss_stop), "TEXT DATA BSS");
+	memblock_x86_reserve_range(__pa_symbol(&_text), __pa_symbol(&__bss_stop), "TEXT DATA BSS");
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Reserve INITRD */
@@ -110,7 +110,7 @@ void __init x86_64_start_reservations(char *real_mode_data)
 		unsigned long ramdisk_image = boot_params.hdr.ramdisk_image;
 		unsigned long ramdisk_size  = boot_params.hdr.ramdisk_size;
 		unsigned long ramdisk_end   = PAGE_ALIGN(ramdisk_image + ramdisk_size);
-		reserve_early(ramdisk_image, ramdisk_end, "RAMDISK");
+		memblock_x86_reserve_range(ramdisk_image, ramdisk_end, "RAMDISK");
 	}
 #endif
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe0aaf..a4f0173 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -302,7 +302,7 @@ static inline void init_gbpages(void)
 static void __init reserve_brk(void)
 {
 	if (_brk_end > _brk_start)
-		reserve_early(__pa(_brk_start), __pa(_brk_end), "BRK");
+		memblock_x86_reserve_range(__pa(_brk_start), __pa(_brk_end), "BRK");
 
 	/* Mark brk area as locked down and no longer taking any
 	   new allocations */
@@ -324,17 +324,16 @@ static void __init relocate_initrd(void)
 	char *p, *q;
 
 	/* We need to move the initrd down into lowmem */
-	ramdisk_here = find_e820_area(0, end_of_lowmem, area_size,
+	ramdisk_here = memblock_find_in_range(0, end_of_lowmem, area_size,
 					 PAGE_SIZE);
 
-	if (ramdisk_here == -1ULL)
+	if (ramdisk_here == MEMBLOCK_ERROR)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
 			 ramdisk_size);
 
 	/* Note: this includes all the lowmem currently occupied by
 	   the initrd, we rely on that fact to keep the data intact. */
-	reserve_early(ramdisk_here, ramdisk_here + area_size,
-			 "NEW RAMDISK");
+	memblock_x86_reserve_range(ramdisk_here, ramdisk_here + area_size, "NEW RAMDISK");
 	initrd_start = ramdisk_here + PAGE_OFFSET;
 	initrd_end   = initrd_start + ramdisk_size;
 	printk(KERN_INFO "Allocated new RAMDISK: %08llx - %08llx\n",
@@ -390,7 +389,7 @@ static void __init reserve_initrd(void)
 	initrd_start = 0;
 
 	if (ramdisk_size >= (end_of_lowmem>>1)) {
-		free_early(ramdisk_image, ramdisk_end);
+		memblock_x86_free_range(ramdisk_image, ramdisk_end);
 		printk(KERN_ERR "initrd too large to handle, "
 		       "disabling initrd\n");
 		return;
@@ -413,7 +412,7 @@ static void __init reserve_initrd(void)
 
 	relocate_initrd();
 
-	free_early(ramdisk_image, ramdisk_end);
+	memblock_x86_free_range(ramdisk_image, ramdisk_end);
 }
 #else
 static void __init reserve_initrd(void)
@@ -469,7 +468,7 @@ static void __init e820_reserve_setup_data(void)
 	e820_print_map("reserve setup_data");
 }
 
-static void __init reserve_early_setup_data(void)
+static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_data *data;
 	u64 pa_data;
@@ -481,7 +480,7 @@ static void __init reserve_early_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		sprintf(buf, "setup data %x", data->type);
-		reserve_early(pa_data, pa_data+sizeof(*data)+data->len, buf);
+		memblock_x86_reserve_range(pa_data, pa_data+sizeof(*data)+data->len, buf);
 		pa_data = data->next;
 		early_iounmap(data, sizeof(*data));
 	}
@@ -519,23 +518,23 @@ static void __init reserve_crashkernel(void)
 	if (crash_base <= 0) {
 		const unsigned long long alignment = 16<<20;	/* 16M */
 
-		crash_base = find_e820_area(alignment, ULONG_MAX, crash_size,
+		crash_base = memblock_find_in_range(alignment, ULONG_MAX, crash_size,
 				 alignment);
-		if (crash_base == -1ULL) {
+		if (crash_base == MEMBLOCK_ERROR) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
 		}
 	} else {
 		unsigned long long start;
 
-		start = find_e820_area(crash_base, ULONG_MAX, crash_size,
+		start = memblock_find_in_range(crash_base, ULONG_MAX, crash_size,
 				 1<<20);
 		if (start != crash_base) {
 			pr_info("crashkernel reservation failed - memory is in use.\n");
 			return;
 		}
 	}
-	reserve_early(crash_base, crash_base + crash_size, "CRASH KERNEL");
+	memblock_x86_reserve_range(crash_base, crash_base + crash_size, "CRASH KERNEL");
 
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
 			"for crashkernel (System RAM: %ldMB)\n",
@@ -786,7 +785,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	 4)) {
 		efi_enabled = 1;
-		efi_reserve_early();
+		efi_memblock_x86_reserve_range();
 	}
 #endif
 
@@ -846,7 +845,7 @@ void __init setup_arch(char **cmdline_p)
 	vmi_activate();
 
 	/* after early param, so could get panic from serial */
-	reserve_early_setup_data();
+	memblock_x86_reserve_range_setup_data();
 
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/kernel/trampoline.c b/arch/x86/kernel/trampoline.c
index c652ef6..7c2102c 100644
--- a/arch/x86/kernel/trampoline.c
+++ b/arch/x86/kernel/trampoline.c
@@ -1,7 +1,7 @@
 #include <linux/io.h>
+#include <linux/memblock.h>
 
 #include <asm/trampoline.h>
-#include <asm/e820.h>
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_ACPI_SLEEP)
 #define __trampinit
@@ -16,15 +16,15 @@ unsigned char *__trampinitdata trampoline_base;
 
 void __init reserve_trampoline_memory(void)
 {
-	unsigned long mem;
+	phys_addr_t mem;
 
 	/* Has to be in very low memory so we can execute real-mode AP code. */
-	mem = find_e820_area(0, 1<<20, TRAMPOLINE_SIZE, PAGE_SIZE);
-	if (mem == -1L)
+	mem = memblock_find_in_range(0, 1<<20, TRAMPOLINE_SIZE, PAGE_SIZE);
+	if (mem == MEMBLOCK_ERROR)
 		panic("Cannot allocate trampoline\n");
 
 	trampoline_base = __va(mem);
-	reserve_early(mem, mem + TRAMPOLINE_SIZE, "TRAMPOLINE");
+	memblock_x86_reserve_range(mem, mem + TRAMPOLINE_SIZE, "TRAMPOLINE");
 }
 
 /*
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index b278535..c0e28a1 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -2,6 +2,7 @@
 #include <linux/initrd.h>
 #include <linux/ioport.h>
 #include <linux/swap.h>
+#include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
 #include <asm/e820.h>
@@ -33,6 +34,7 @@ static void __init find_early_table_space(unsigned long end, int use_pse,
 					  int use_gbpages)
 {
 	unsigned long puds, pmds, ptes, tables, start;
+	phys_addr_t base;
 
 	puds = (end + PUD_SIZE - 1) >> PUD_SHIFT;
 	tables = roundup(puds * sizeof(pud_t), PAGE_SIZE);
@@ -75,12 +77,12 @@ static void __init find_early_table_space(unsigned long end, int use_pse,
 #else
 	start = 0x8000;
 #endif
-	e820_table_start = find_e820_area(start, max_pfn_mapped<<PAGE_SHIFT,
+	base = memblock_find_in_range(start, max_pfn_mapped<<PAGE_SHIFT,
 					tables, PAGE_SIZE);
-	if (e820_table_start == -1UL)
+	if (base == MEMBLOCK_ERROR)
 		panic("Cannot find space for the kernel page tables");
 
-	e820_table_start >>= PAGE_SHIFT;
+	e820_table_start = base >> PAGE_SHIFT;
 	e820_table_end = e820_table_start;
 	e820_table_top = e820_table_start + (tables >> PAGE_SHIFT);
 
@@ -299,7 +301,7 @@ unsigned long __init_refok init_memory_mapping(unsigned long start,
 	__flush_tlb_all();
 
 	if (!after_bootmem && e820_table_end > e820_table_start)
-		reserve_early(e820_table_start << PAGE_SHIFT,
+		memblock_x86_reserve_range(e820_table_start << PAGE_SHIFT,
 				 e820_table_end << PAGE_SHIFT, "PGTABLE");
 
 	if (!after_bootmem)
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 90e0545..63b09ba 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -25,6 +25,7 @@
 #include <linux/pfn.h>
 #include <linux/poison.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/proc_fs.h>
 #include <linux/memory_hotplug.h>
 #include <linux/initrd.h>
@@ -712,14 +713,14 @@ void __init initmem_init(unsigned long start_pfn, unsigned long end_pfn,
 	highstart_pfn = highend_pfn = max_pfn;
 	if (max_pfn > max_low_pfn)
 		highstart_pfn = max_low_pfn;
-	e820_register_active_regions(0, 0, highend_pfn);
+	memblock_x86_register_active_regions(0, 0, highend_pfn);
 	sparse_memory_present_with_active_regions(0);
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		pages_to_mb(highend_pfn - highstart_pfn));
 	num_physpages = highend_pfn;
 	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
 #else
-	e820_register_active_regions(0, 0, max_low_pfn);
+	memblock_x86_register_active_regions(0, 0, max_low_pfn);
 	sparse_memory_present_with_active_regions(0);
 	num_physpages = max_low_pfn;
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
@@ -776,16 +777,16 @@ void __init setup_bootmem_allocator(void)
 {
 #ifndef CONFIG_NO_BOOTMEM
 	int nodeid;
-	unsigned long bootmap_size, bootmap;
+	phys_addr_t bootmap_size, bootmap;
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
 	bootmap_size = bootmem_bootmap_pages(max_low_pfn)<<PAGE_SHIFT;
-	bootmap = find_e820_area(0, max_pfn_mapped<<PAGE_SHIFT, bootmap_size,
+	bootmap = memblock_find_in_range(0, max_pfn_mapped<<PAGE_SHIFT, bootmap_size,
 				 PAGE_SIZE);
-	if (bootmap == -1L)
+	if (bootmap == MEMBLOCK_ERROR)
 		panic("Cannot find bootmem map of size %ld\n", bootmap_size);
-	reserve_early(bootmap, bootmap + bootmap_size, "BOOTMAP");
+	memblock_x86_reserve_range(bootmap, bootmap + bootmap_size, "BOOTMAP");
 #endif
 
 	printk(KERN_INFO "  mapped low ram: 0 - %08lx\n",
@@ -1069,3 +1070,4 @@ void mark_rodata_ro(void)
 #endif
 }
 #endif
+
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 634fa08..592b236 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -21,6 +21,7 @@
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
 #include <linux/pfn.h>
@@ -577,18 +578,18 @@ void __init initmem_init(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long bootmap_size, bootmap;
 
 	bootmap_size = bootmem_bootmap_pages(end_pfn)<<PAGE_SHIFT;
-	bootmap = find_e820_area(0, end_pfn<<PAGE_SHIFT, bootmap_size,
+	bootmap = memblock_find_in_range(0, end_pfn<<PAGE_SHIFT, bootmap_size,
 				 PAGE_SIZE);
-	if (bootmap == -1L)
+	if (bootmap == MEMBLOCK_ERROR)
 		panic("Cannot find bootmem map of size %ld\n", bootmap_size);
-	reserve_early(bootmap, bootmap + bootmap_size, "BOOTMAP");
+	memblock_x86_reserve_range(bootmap, bootmap + bootmap_size, "BOOTMAP");
 	/* don't touch min_low_pfn */
 	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap >> PAGE_SHIFT,
 					 0, end_pfn);
-	e820_register_active_regions(0, start_pfn, end_pfn);
+	memblock_x86_register_active_regions(0, start_pfn, end_pfn);
 	free_bootmem_with_active_regions(0, end_pfn);
 #else
-	e820_register_active_regions(0, start_pfn, end_pfn);
+	memblock_x86_register_active_regions(0, start_pfn, end_pfn);
 #endif
 }
 #endif
diff --git a/arch/x86/mm/k8topology_64.c b/arch/x86/mm/k8topology_64.c
index 970ed57..966de93 100644
--- a/arch/x86/mm/k8topology_64.c
+++ b/arch/x86/mm/k8topology_64.c
@@ -11,6 +11,8 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/nodemask.h>
+#include <linux/memblock.h>
+
 #include <asm/io.h>
 #include <linux/pci_ids.h>
 #include <linux/acpi.h>
@@ -222,7 +224,7 @@ int __init k8_scan_nodes(void)
 	for_each_node_mask(i, node_possible_map) {
 		int j;
 
-		e820_register_active_regions(i,
+		memblock_x86_register_active_regions(i,
 				nodes[i].start >> PAGE_SHIFT,
 				nodes[i].end >> PAGE_SHIFT);
 		for (j = apicid_base; j < cores + apicid_base; j++)
diff --git a/arch/x86/mm/memtest.c b/arch/x86/mm/memtest.c
index 18d244f..92faf3a 100644
--- a/arch/x86/mm/memtest.c
+++ b/arch/x86/mm/memtest.c
@@ -6,8 +6,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/pfn.h>
-
-#include <asm/e820.h>
+#include <linux/memblock.h>
 
 static u64 patterns[] __initdata = {
 	0,
@@ -35,7 +34,7 @@ static void __init reserve_bad_mem(u64 pattern, u64 start_bad, u64 end_bad)
 	       (unsigned long long) pattern,
 	       (unsigned long long) start_bad,
 	       (unsigned long long) end_bad);
-	reserve_early(start_bad, end_bad, "BAD RAM");
+	memblock_x86_reserve_range(start_bad, end_bad, "BAD RAM");
 }
 
 static void __init memtest(u64 pattern, u64 start_phys, u64 size)
@@ -74,7 +73,7 @@ static void __init do_one_pass(u64 pattern, u64 start, u64 end)
 	u64 size = 0;
 
 	while (start < end) {
-		start = find_e820_area_size(start, &size, 1);
+		start = memblock_x86_find_in_range_size(start, &size, 1);
 
 		/* done ? */
 		if (start >= end)
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 809baaa..ddf9730 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -24,6 +24,7 @@
 
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/mmzone.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
@@ -120,7 +121,7 @@ int __init get_memcfg_numa_flat(void)
 
 	node_start_pfn[0] = 0;
 	node_end_pfn[0] = max_pfn;
-	e820_register_active_regions(0, 0, max_pfn);
+	memblock_x86_register_active_regions(0, 0, max_pfn);
 	memory_present(0, 0, max_pfn);
 	node_remap_size[0] = node_memmap_size_bytes(0, 0, max_pfn);
 
@@ -161,14 +162,14 @@ static void __init allocate_pgdat(int nid)
 		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
 	else {
 		unsigned long pgdat_phys;
-		pgdat_phys = find_e820_area(min_low_pfn<<PAGE_SHIFT,
+		pgdat_phys = memblock_find_in_range(min_low_pfn<<PAGE_SHIFT,
 				 max_pfn_mapped<<PAGE_SHIFT,
 				 sizeof(pg_data_t),
 				 PAGE_SIZE);
 		NODE_DATA(nid) = (pg_data_t *)(pfn_to_kaddr(pgdat_phys>>PAGE_SHIFT));
 		memset(buf, 0, sizeof(buf));
 		sprintf(buf, "NODE_DATA %d",  nid);
-		reserve_early(pgdat_phys, pgdat_phys + sizeof(pg_data_t), buf);
+		memblock_x86_reserve_range(pgdat_phys, pgdat_phys + sizeof(pg_data_t), buf);
 	}
 	printk(KERN_DEBUG "allocate_pgdat: node %d NODE_DATA %08lx\n",
 		nid, (unsigned long)NODE_DATA(nid));
@@ -291,15 +292,15 @@ static __init unsigned long calculate_numa_remap_pages(void)
 						 PTRS_PER_PTE);
 		node_kva_target <<= PAGE_SHIFT;
 		do {
-			node_kva_final = find_e820_area(node_kva_target,
+			node_kva_final = memblock_find_in_range(node_kva_target,
 					((u64)node_end_pfn[nid])<<PAGE_SHIFT,
 						((u64)size)<<PAGE_SHIFT,
 						LARGE_PAGE_BYTES);
 			node_kva_target -= LARGE_PAGE_BYTES;
-		} while (node_kva_final == -1ULL &&
+		} while (node_kva_final == MEMBLOCK_ERROR &&
 			 (node_kva_target>>PAGE_SHIFT) > (node_start_pfn[nid]));
 
-		if (node_kva_final == -1ULL)
+		if (node_kva_final == MEMBLOCK_ERROR)
 			panic("Can not get kva ram\n");
 
 		node_remap_size[nid] = size;
@@ -318,9 +319,9 @@ static __init unsigned long calculate_numa_remap_pages(void)
 		 *  but we could have some hole in high memory, and it will only
 		 *  check page_is_ram(pfn) && !page_is_reserved_early(pfn) to decide
 		 *  to use it as free.
-		 *  So reserve_early here, hope we don't run out of that array
+		 *  So memblock_x86_reserve_range here, hope we don't run out of that array
 		 */
-		reserve_early(node_kva_final,
+		memblock_x86_reserve_range(node_kva_final,
 			      node_kva_final+(((u64)size)<<PAGE_SHIFT),
 			      "KVA RAM");
 
@@ -367,14 +368,14 @@ void __init initmem_init(unsigned long start_pfn, unsigned long end_pfn,
 
 	kva_target_pfn = round_down(max_low_pfn - kva_pages, PTRS_PER_PTE);
 	do {
-		kva_start_pfn = find_e820_area(kva_target_pfn<<PAGE_SHIFT,
+		kva_start_pfn = memblock_find_in_range(kva_target_pfn<<PAGE_SHIFT,
 					max_low_pfn<<PAGE_SHIFT,
 					kva_pages<<PAGE_SHIFT,
 					PTRS_PER_PTE<<PAGE_SHIFT) >> PAGE_SHIFT;
 		kva_target_pfn -= PTRS_PER_PTE;
-	} while (kva_start_pfn == -1UL && kva_target_pfn > min_low_pfn);
+	} while (kva_start_pfn == MEMBLOCK_ERROR && kva_target_pfn > min_low_pfn);
 
-	if (kva_start_pfn == -1UL)
+	if (kva_start_pfn == MEMBLOCK_ERROR)
 		panic("Can not get kva space\n");
 
 	printk(KERN_INFO "kva_start_pfn ~ %lx max_low_pfn ~ %lx\n",
@@ -382,7 +383,7 @@ void __init initmem_init(unsigned long start_pfn, unsigned long end_pfn,
 	printk(KERN_INFO "max_pfn = %lx\n", max_pfn);
 
 	/* avoid clash with initrd */
-	reserve_early(kva_start_pfn<<PAGE_SHIFT,
+	memblock_x86_reserve_range(kva_start_pfn<<PAGE_SHIFT,
 		      (kva_start_pfn + kva_pages)<<PAGE_SHIFT,
 		     "KVA PG");
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/x86/mm/numa_64.c b/arch/x86/mm/numa_64.c
index 3d54f9f..984b1ff 100644
--- a/arch/x86/mm/numa_64.c
+++ b/arch/x86/mm/numa_64.c
@@ -87,16 +87,16 @@ static int __init allocate_cachealigned_memnodemap(void)
 
 	addr = 0x8000;
 	nodemap_size = roundup(sizeof(s16) * memnodemapsize, L1_CACHE_BYTES);
-	nodemap_addr = find_e820_area(addr, max_pfn<<PAGE_SHIFT,
+	nodemap_addr = memblock_find_in_range(addr, max_pfn<<PAGE_SHIFT,
 				      nodemap_size, L1_CACHE_BYTES);
-	if (nodemap_addr == -1UL) {
+	if (nodemap_addr == MEMBLOCK_ERROR) {
 		printk(KERN_ERR
 		       "NUMA: Unable to allocate Memory to Node hash map\n");
 		nodemap_addr = nodemap_size = 0;
 		return -1;
 	}
 	memnodemap = phys_to_virt(nodemap_addr);
-	reserve_early(nodemap_addr, nodemap_addr + nodemap_size, "MEMNODEMAP");
+	memblock_x86_reserve_range(nodemap_addr, nodemap_addr + nodemap_size, "MEMNODEMAP");
 
 	printk(KERN_DEBUG "NUMA: Allocated memnodemap from %lx - %lx\n",
 	       nodemap_addr, nodemap_addr + nodemap_size);
@@ -227,7 +227,7 @@ setup_node_bootmem(int nodeid, unsigned long start, unsigned long end)
 	if (node_data[nodeid] == NULL)
 		return;
 	nodedata_phys = __pa(node_data[nodeid]);
-	reserve_early(nodedata_phys, nodedata_phys + pgdat_size, "NODE_DATA");
+	memblock_x86_reserve_range(nodedata_phys, nodedata_phys + pgdat_size, "NODE_DATA");
 	printk(KERN_INFO "  NODE_DATA [%016lx - %016lx]\n", nodedata_phys,
 		nodedata_phys + pgdat_size - 1);
 	nid = phys_to_nid(nodedata_phys);
@@ -246,7 +246,7 @@ setup_node_bootmem(int nodeid, unsigned long start, unsigned long end)
 	 * Find a place for the bootmem map
 	 * nodedata_phys could be on other nodes by alloc_bootmem,
 	 * so need to sure bootmap_start not to be small, otherwise
-	 * early_node_mem will get that with find_e820_area instead
+	 * early_node_mem will get that with memblock_find_in_range instead
 	 * of alloc_bootmem, that could clash with reserved range
 	 */
 	bootmap_pages = bootmem_bootmap_pages(last_pfn - start_pfn);
@@ -258,12 +258,12 @@ setup_node_bootmem(int nodeid, unsigned long start, unsigned long end)
 	bootmap = early_node_mem(nodeid, bootmap_start, end,
 				 bootmap_pages<<PAGE_SHIFT, PAGE_SIZE);
 	if (bootmap == NULL)  {
-		free_early(nodedata_phys, nodedata_phys + pgdat_size);
+		memblock_x86_free_range(nodedata_phys, nodedata_phys + pgdat_size);
 		node_data[nodeid] = NULL;
 		return;
 	}
 	bootmap_start = __pa(bootmap);
-	reserve_early(bootmap_start, bootmap_start+(bootmap_pages<<PAGE_SHIFT),
+	memblock_x86_reserve_range(bootmap_start, bootmap_start+(bootmap_pages<<PAGE_SHIFT),
 			"BOOTMAP");
 
 	bootmap_size = init_bootmem_node(NODE_DATA(nodeid),
@@ -417,7 +417,7 @@ static int __init split_nodes_interleave(u64 addr, u64 max_addr,
 		nr_nodes = MAX_NUMNODES;
 	}
 
-	size = (max_addr - addr - e820_hole_size(addr, max_addr)) / nr_nodes;
+	size = (max_addr - addr - memblock_x86_hole_size(addr, max_addr)) / nr_nodes;
 	/*
 	 * Calculate the number of big nodes that can be allocated as a result
 	 * of consolidating the remainder.
@@ -453,7 +453,7 @@ static int __init split_nodes_interleave(u64 addr, u64 max_addr,
 			 * non-reserved memory is less than the per-node size.
 			 */
 			while (end - physnodes[i].start -
-				e820_hole_size(physnodes[i].start, end) < size) {
+				memblock_x86_hole_size(physnodes[i].start, end) < size) {
 				end += FAKE_NODE_MIN_SIZE;
 				if (end > physnodes[i].end) {
 					end = physnodes[i].end;
@@ -467,7 +467,7 @@ static int __init split_nodes_interleave(u64 addr, u64 max_addr,
 			 * this one must extend to the boundary.
 			 */
 			if (end < dma32_end && dma32_end - end -
-			    e820_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
+			    memblock_x86_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
 				end = dma32_end;
 
 			/*
@@ -476,7 +476,7 @@ static int __init split_nodes_interleave(u64 addr, u64 max_addr,
 			 * physical node.
 			 */
 			if (physnodes[i].end - end -
-			    e820_hole_size(end, physnodes[i].end) < size)
+			    memblock_x86_hole_size(end, physnodes[i].end) < size)
 				end = physnodes[i].end;
 
 			/*
@@ -504,7 +504,7 @@ static u64 __init find_end_of_node(u64 start, u64 max_addr, u64 size)
 {
 	u64 end = start + size;
 
-	while (end - start - e820_hole_size(start, end) < size) {
+	while (end - start - memblock_x86_hole_size(start, end) < size) {
 		end += FAKE_NODE_MIN_SIZE;
 		if (end > max_addr) {
 			end = max_addr;
@@ -533,7 +533,7 @@ static int __init split_nodes_size_interleave(u64 addr, u64 max_addr, u64 size)
 	 * creates a uniform distribution of node sizes across the entire
 	 * machine (but not necessarily over physical nodes).
 	 */
-	min_size = (max_addr - addr - e820_hole_size(addr, max_addr)) /
+	min_size = (max_addr - addr - memblock_x86_hole_size(addr, max_addr)) /
 						MAX_NUMNODES;
 	min_size = max(min_size, FAKE_NODE_MIN_SIZE);
 	if ((min_size & FAKE_NODE_MIN_HASH_MASK) < min_size)
@@ -566,7 +566,7 @@ static int __init split_nodes_size_interleave(u64 addr, u64 max_addr, u64 size)
 			 * this one must extend to the boundary.
 			 */
 			if (end < dma32_end && dma32_end - end -
-			    e820_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
+			    memblock_x86_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
 				end = dma32_end;
 
 			/*
@@ -575,7 +575,7 @@ static int __init split_nodes_size_interleave(u64 addr, u64 max_addr, u64 size)
 			 * physical node.
 			 */
 			if (physnodes[i].end - end -
-			    e820_hole_size(end, physnodes[i].end) < size)
+			    memblock_x86_hole_size(end, physnodes[i].end) < size)
 				end = physnodes[i].end;
 
 			/*
@@ -639,7 +639,7 @@ static int __init numa_emulation(unsigned long start_pfn,
 	 */
 	remove_all_active_ranges();
 	for_each_node_mask(i, node_possible_map) {
-		e820_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
+		memblock_x86_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
 						nodes[i].end >> PAGE_SHIFT);
 		setup_node_bootmem(i, nodes[i].start, nodes[i].end);
 	}
@@ -692,7 +692,7 @@ void __init initmem_init(unsigned long start_pfn, unsigned long last_pfn,
 	node_set(0, node_possible_map);
 	for (i = 0; i < nr_cpu_ids; i++)
 		numa_set_node(i, 0);
-	e820_register_active_regions(0, start_pfn, last_pfn);
+	memblock_x86_register_active_regions(0, start_pfn, last_pfn);
 	setup_node_bootmem(0, start_pfn << PAGE_SHIFT, last_pfn << PAGE_SHIFT);
 }
 
diff --git a/arch/x86/mm/srat_32.c b/arch/x86/mm/srat_32.c
index 9324f13..a17dffd 100644
--- a/arch/x86/mm/srat_32.c
+++ b/arch/x86/mm/srat_32.c
@@ -25,6 +25,7 @@
  */
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/mmzone.h>
 #include <linux/acpi.h>
 #include <linux/nodemask.h>
@@ -264,7 +265,7 @@ int __init get_memcfg_from_srat(void)
 		if (node_read_chunk(chunk->nid, chunk))
 			continue;
 
-		e820_register_active_regions(chunk->nid, chunk->start_pfn,
+		memblock_x86_register_active_regions(chunk->nid, chunk->start_pfn,
 					     min(chunk->end_pfn, max_pfn));
 	}
 	/* for out of order entries in SRAT */
diff --git a/arch/x86/mm/srat_64.c b/arch/x86/mm/srat_64.c
index f9897f7..7f44eb6 100644
--- a/arch/x86/mm/srat_64.c
+++ b/arch/x86/mm/srat_64.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/topology.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <asm/proto.h>
 #include <asm/numa.h>
@@ -98,15 +99,15 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 	unsigned long phys;
 
 	length = slit->header.length;
-	phys = find_e820_area(0, max_pfn_mapped<<PAGE_SHIFT, length,
+	phys = memblock_find_in_range(0, max_pfn_mapped<<PAGE_SHIFT, length,
 		 PAGE_SIZE);
 
-	if (phys == -1L)
+	if (phys == MEMBLOCK_ERROR)
 		panic(" Can not save slit!\n");
 
 	acpi_slit = __va(phys);
 	memcpy(acpi_slit, slit, length);
-	reserve_early(phys, phys + length, "ACPI SLIT");
+	memblock_x86_reserve_range(phys, phys + length, "ACPI SLIT");
 }
 
 /* Callback for Proximity Domain -> x2APIC mapping */
@@ -324,7 +325,7 @@ static int __init nodes_cover_memory(const struct bootnode *nodes)
 			pxmram = 0;
 	}
 
-	e820ram = max_pfn - (e820_hole_size(0, max_pfn<<PAGE_SHIFT)>>PAGE_SHIFT);
+	e820ram = max_pfn - (memblock_x86_hole_size(0, max_pfn<<PAGE_SHIFT)>>PAGE_SHIFT);
 	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
 	if ((long)(e820ram - pxmram) >= (1<<(20 - PAGE_SHIFT))) {
 		printk(KERN_ERR
@@ -421,7 +422,7 @@ int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 	}
 
 	for_each_node_mask(i, nodes_parsed)
-		e820_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
+		memblock_x86_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
 						nodes[i].end >> PAGE_SHIFT);
 	/* for out of order entries in SRAT */
 	sort_node_map();
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 914f046..b511f19 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -44,6 +44,7 @@
 #include <linux/bug.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/memblock.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -1735,7 +1736,7 @@ __init pgd_t *xen_setup_kernel_pagetable(pgd_t *pgd,
 	__xen_write_cr3(true, __pa(pgd));
 	xen_mc_issue(PARAVIRT_LAZY_CPU);
 
-	reserve_early(__pa(xen_start_info->pt_base),
+	memblock_x86_reserve_range(__pa(xen_start_info->pt_base),
 		      __pa(xen_start_info->pt_base +
 			   xen_start_info->nr_pt_frames * PAGE_SIZE),
 		      "XEN PAGETABLES");
@@ -1773,7 +1774,7 @@ __init pgd_t *xen_setup_kernel_pagetable(pgd_t *pgd,
 
 	pin_pagetable_pfn(MMUEXT_PIN_L3_TABLE, PFN_DOWN(__pa(swapper_pg_dir)));
 
-	reserve_early(__pa(xen_start_info->pt_base),
+	memblock_x86_reserve_range(__pa(xen_start_info->pt_base),
 		      __pa(xen_start_info->pt_base +
 			   xen_start_info->nr_pt_frames * PAGE_SIZE),
 		      "XEN PAGETABLES");
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index ad0047f..2ac8f29 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
+#include <linux/memblock.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
@@ -61,7 +62,7 @@ char * __init xen_memory_setup(void)
 	 *  - xen_start_info
 	 * See comment above "struct start_info" in <xen/interface/xen.h>
 	 */
-	reserve_early(__pa(xen_start_info->mfn_list),
+	memblock_x86_reserve_range(__pa(xen_start_info->mfn_list),
 		      __pa(xen_start_info->pt_base),
 			"XEN START INFO");
 
diff --git a/mm/bootmem.c b/mm/bootmem.c
index fda01a2..13b0caa 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -436,7 +436,7 @@ void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 {
 #ifdef CONFIG_NO_BOOTMEM
 	kmemleak_free_part(__va(physaddr), size);
-	free_early(physaddr, physaddr + size);
+	memblock_x86_free_range(physaddr, physaddr + size);
 #else
 	unsigned long start, end;
 
@@ -462,7 +462,7 @@ void __init free_bootmem(unsigned long addr, unsigned long size)
 {
 #ifdef CONFIG_NO_BOOTMEM
 	kmemleak_free_part(__va(addr), size);
-	free_early(addr, addr + size);
+	memblock_x86_free_range(addr, addr + size);
 #else
 	unsigned long start, end;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
