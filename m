Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ILyN1-0003VB-8W
	for kexec@lists.infradead.org; Fri, 17 Aug 2007 05:44:11 -0400
Date: Fri, 17 Aug 2007 11:44:07 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
Message-ID: <20070817094407.GA31095@suse.de>
References: <20070816042008.GB20860@in.ibm.com>
	<20070817154331oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070817154331oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, vgoyal@in.ibm.com, kexec-ml <kexec@lists.infradead.org>, Dan Aloni <da-x@monatomic.org>

Hi,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-08-17 08:43]:
> 
> Thank you for good comments.
> I updated the patch for applying your comments.

Instead of providing empty implementations of arch_save_vmcoreinfo()
for each architecture that doesn't need that hook, I'd suggest to use
one default implementation with __attribute((weak)) that gets
overwritten by architecture implementations. See my patch below:


Signed-off-by: Dan Aloni <da-x@monatomic.org>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/i386/kernel/machine_kexec.c   |   13 ++++
 arch/ia64/kernel/machine_kexec.c   |   22 +++++++
 arch/ia64/mm/discontig.c           |    2 
 arch/x86_64/kernel/machine_kexec.c |    9 +++
 include/asm-ia64/numa.h            |    1 
 include/linux/kexec.h              |   23 ++++++++
 kernel/kexec.c                     |  103 +++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c                    |   10 +++
 8 files changed, 182 insertions(+), 1 deletion(-)

--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/kexec.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/numa.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -169,3 +170,15 @@ static int __init parse_crashkernel(char
 	return 0;
 }
 early_param("crashkernel", parse_crashkernel);
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
+	SYMBOL(node_data);
+	LENGTH(node_data, MAX_NUMNODES);
+#endif
+#ifdef CONFIG_X86_PAE
+	CONFIG(X86_PAE);
+#endif
+}
+
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -15,10 +15,12 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 #include <linux/efi.h>
+#include <linux/numa.h>
 #include <asm/mmu_context.h>
 #include <asm/setup.h>
 #include <asm/delay.h>
 #include <asm/meminit.h>
+#include <asm/mmzone.h>
 
 typedef NORET_TYPE void (*relocate_new_kernel_t)(
 					unsigned long indirection_page,
@@ -125,3 +127,23 @@ void machine_kexec(struct kimage *image)
 	unw_init_running(ia64_machine_kexec, image);
 	for(;;);
 }
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
+	SYMBOL(pgdat_list);
+	LENGTH(pgdat_list, MAX_NUMNODES);
+
+	SYMBOL(node_memblk);
+	LENGTH(node_memblk, NR_NODE_MEMBLKS);
+	SIZE(node_memblk_s);
+	OFFSET(node_memblk_s, start_paddr);
+	OFFSET(node_memblk_s, size);
+#endif
+#ifdef CONFIG_PGTABLE_3
+	CONFIG(PGTABLE_3);
+#elif  CONFIG_PGTABLE_4
+	CONFIG(PGTABLE_4);
+#endif
+}
+
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -47,7 +47,7 @@ struct early_node_data {
 static struct early_node_data mem_data[MAX_NUMNODES] __initdata;
 static nodemask_t memory_less_mask __initdata;
 
-static pg_data_t *pgdat_list[MAX_NUMNODES];
+pg_data_t *pgdat_list[MAX_NUMNODES];
 
 /*
  * To prevent cache aliasing effects, align per-node structures so that they
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/kexec.h>
 #include <linux/string.h>
 #include <linux/reboot.h>
+#include <linux/numa.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -257,3 +258,11 @@ static int __init setup_crashkernel(char
 }
 early_param("crashkernel", setup_crashkernel);
 
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
+	SYMBOL(node_data);
+	LENGTH(node_data, MAX_NUMNODES);
+#endif
+}
+
--- a/include/asm-ia64/numa.h
+++ b/include/asm-ia64/numa.h
@@ -24,6 +24,7 @@
 
 extern u16 cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 extern cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
+extern pg_data_t *pgdat_list[MAX_NUMNODES];
 
 /* Stuff below this line could be architecture independent */
 
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -121,6 +121,21 @@ extern struct page *kimage_alloc_control
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
+void crash_save_vmcoreinfo(void);
+void arch_crash_save_vmcoreinfo(void);
+void vmcoreinfo_append_str(const char *fmt, ...);
+
+#define SYMBOL(name) \
+	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define SIZE(name) \
+	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
+#define OFFSET(name, field) \
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, &(((struct name *)0)->field))
+#define LENGTH(name, value) \
+	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
+#define CONFIG(name) \
+	vmcoreinfo_append_str("CONFIG_%s=%c\n", #name, CONFIG_##name)
+
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
@@ -148,11 +163,19 @@ extern struct kimage *kexec_crash_image;
 
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH)  /* List of defined/legal kexec flags */
 
+#define VMCOREINFO_BYTES           (4096)
+#define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
+#define VMCOREINFO_NOTE_NAME_BYTES ALIGN(sizeof(VMCOREINFO_NOTE_NAME), 4)
+#define VMCOREINFO_NOTE_SIZE       (KEXEC_NOTE_HEAD_BYTES*2 + VMCOREINFO_BYTES \
+				    + VMCOREINFO_NOTE_NAME_BYTES)
+
 /* Location of a reserved region to hold the crash kernel.
  */
 extern struct resource crashk_res;
 typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
 extern note_buf_t *crash_notes;
+extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
+extern unsigned int vmcoreinfo_size;
 
 
 #else /* !CONFIG_KEXEC */
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -22,16 +22,26 @@
 #include <linux/hardirq.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/utsrelease.h>
+#include <linux/utsname.h>
+#include <linux/numa.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/semaphore.h>
+#include <asm/sections.h>
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t* crash_notes;
 
+/* vmcoreinfo stuff */
+unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
+u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
+unsigned int vmcoreinfo_size = 0;
+unsigned int vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
+
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
 	.name  = "Crash kernel",
@@ -1135,3 +1145,96 @@ static int __init crash_notes_memory_ini
 	return 0;
 }
 module_init(crash_notes_memory_init)
+
+void crash_save_vmcoreinfo(void)
+{
+	u32 *buf;
+
+	if (!vmcoreinfo_size)
+		return;
+
+	buf = (u32 *)vmcoreinfo_note;
+
+	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
+			      vmcoreinfo_size);
+
+	final_note(buf);
+}
+
+void vmcoreinfo_append_str(const char *fmt, ...)
+{
+	va_list args;
+	char buf[0x50];
+	int r;
+
+	va_start(args, fmt);
+	r = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	if (r + vmcoreinfo_size > vmcoreinfo_max_size)
+		r = vmcoreinfo_max_size - vmcoreinfo_size;
+
+	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
+
+	vmcoreinfo_size += r;
+}
+
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __attribute__ ((weak)) arch_crash_save_vmcoreinfo(void)
+{}
+
+static int __init crash_save_vmcoreinfo_init(void)
+{
+	vmcoreinfo_append_str("OSRELEASE=%s\n", UTS_RELEASE);
+	vmcoreinfo_append_str("PAGESIZE=%d\n", PAGE_SIZE);
+
+	SYMBOL(init_uts_ns);
+	SYMBOL(node_online_map);
+	SYMBOL(swapper_pg_dir);
+	SYMBOL(_stext);
+
+#ifndef CONFIG_NEED_MULTIPLE_NODES
+	SYMBOL(mem_map);
+	SYMBOL(contig_page_data);
+#endif
+#ifdef CONFIG_SPARSEMEM
+	SYMBOL(mem_section);
+	LENGTH(mem_section, NR_SECTION_ROOTS);
+	SIZE(mem_section);
+	OFFSET(mem_section, section_mem_map);
+#endif
+	SIZE(page);
+	SIZE(pglist_data);
+	SIZE(zone);
+	SIZE(free_area);
+	SIZE(list_head);
+	OFFSET(page, flags);
+	OFFSET(page, _count);
+	OFFSET(page, mapping);
+	OFFSET(page, lru);
+	OFFSET(pglist_data, node_zones);
+	OFFSET(pglist_data, nr_zones);
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
+	OFFSET(pglist_data, node_mem_map);
+#endif
+	OFFSET(pglist_data, node_start_pfn);
+	OFFSET(pglist_data, node_spanned_pages);
+	OFFSET(pglist_data, node_id);
+	OFFSET(zone, free_area);
+	OFFSET(zone, vm_stat);
+	OFFSET(zone, spanned_pages);
+	OFFSET(free_area, free_list);
+	OFFSET(list_head, next);
+	OFFSET(list_head, prev);
+	LENGTH(zone.free_area, MAX_ORDER);
+
+	arch_crash_save_vmcoreinfo();
+	crash_save_vmcoreinfo();
+
+	return 0;
+}
+
+module_init(crash_save_vmcoreinfo_init)
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -60,6 +60,15 @@ static ssize_t kexec_crash_loaded_show(s
 	return sprintf(page, "%d\n", !!kexec_crash_image);
 }
 KERNEL_ATTR_RO(kexec_crash_loaded);
+
+static ssize_t vmcoreinfo_show(struct kset *kset, char *page)
+{
+	return sprintf(page, "%lx %x\n",
+		       __pa((unsigned long)(char *)&vmcoreinfo_note),
+		       vmcoreinfo_size);
+}
+KERNEL_ATTR_RO(vmcoreinfo);
+
 #endif /* CONFIG_KEXEC */
 
 decl_subsys(kernel, NULL, NULL);
@@ -73,6 +82,7 @@ static struct attribute * kernel_attrs[]
 #ifdef CONFIG_KEXEC
 	&kexec_loaded_attr.attr,
 	&kexec_crash_loaded_attr.attr,
+	&vmcoreinfo_attr.attr,
 #endif
 	NULL
 };

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
