Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKUVr-00071n-Hz
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 08:38:58 +0100
Subject: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
In-reply-to: <20070813163212oomichi@mail.jp.nec.com>
Message-Id: <20070813163653oomichi@mail.jp.nec.com>
References: <20070813163212oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 13 Aug 2007 16:36:53 +0900
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
To: kexec-ml <kexec@lists.infradead.org>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>


Patches:
- [1/3] patch for linux-2.6.22.
  Changelog:
  * Rename "mkdfinfo" to "vmcoreinfo".
  * Multi memory models (FLATMEM, DISCONTIGMEM, and SPASEMEM) are
    supported.
  * The elf note typedef for vmcoreinfo is added because the original
    elf note size is limited to 1024.
  * The generation of the elf note is moved to boot time instead of
    crash time.

---
Signed-off-by: Dan Aloni <da-x@monatomic.org>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

---
diff -rpuN linux-2.6.22.org/arch/ia64/mm/discontig.c linux-2.6.22/arch/ia64/mm/discontig.c
--- linux-2.6.22.org/arch/ia64/mm/discontig.c	2007-08-04 00:22:33.000000000 +0900
+++ linux-2.6.22/arch/ia64/mm/discontig.c	2007-08-07 00:34:50.000000000 +0900
@@ -47,7 +47,7 @@ struct early_node_data {
 static struct early_node_data mem_data[MAX_NUMNODES] __initdata;
 static nodemask_t memory_less_mask __initdata;
 
-static pg_data_t *pgdat_list[MAX_NUMNODES];
+pg_data_t *pgdat_list[MAX_NUMNODES];
 
 /*
  * To prevent cache aliasing effects, align per-node structures so that they
diff -rpuN linux-2.6.22.org/include/linux/kexec.h linux-2.6.22/include/linux/kexec.h
--- linux-2.6.22.org/include/linux/kexec.h	2007-08-04 00:22:35.000000000 +0900
+++ linux-2.6.22/include/linux/kexec.h	2007-08-07 00:34:50.000000000 +0900
@@ -121,6 +121,8 @@ extern struct page *kimage_alloc_control
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
+void crash_save_vmcoreinfo(void);
+
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
@@ -148,11 +150,19 @@ extern struct kimage *kexec_crash_image;
 
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
diff -rpuN linux-2.6.22.org/kernel/kexec.c linux-2.6.22/kernel/kexec.c
--- linux-2.6.22.org/kernel/kexec.c	2007-08-04 00:22:33.000000000 +0900
+++ linux-2.6.22/kernel/kexec.c	2007-08-07 00:35:10.000000000 +0900
@@ -22,6 +22,10 @@
 #include <linux/hardirq.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/utsrelease.h>
+#include <linux/utsname.h> 
+#include <linux/mmzone.h>
+#include <linux/numa.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -32,6 +36,12 @@
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
@@ -1135,3 +1145,133 @@ static int __init crash_notes_memory_ini
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
+#define SYMBOL(name) \
+	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define SIZE(name) \
+	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
+#define OFFSET(name, field) \
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, &(((struct name *)0)->field))
+#define LENGTH(name, value) \
+	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
+
+static int __init crash_save_vmcoreinfo_init(void)
+{
+#ifndef CONFIG_X86_32
+	extern char _stext;
+#endif
+#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
+#ifdef CONFIG_IA64
+	extern pg_data_t *pgdat_list[MAX_NUMNODES];
+#endif
+#endif
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
+
+#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
+#ifdef CONFIG_IA64
+	SYMBOL(pgdat_list);
+	LENGTH(pgdat_list, MAX_NUMNODES);
+	SYMBOL(node_memblk);
+	LENGTH(node_memblk, NR_NODE_MEMBLKS);
+	SIZE(node_memblk_s);
+	OFFSET(node_memblk_s, start_paddr);
+	OFFSET(node_memblk_s, size);
+	OFFSET(node_memblk_s, nid);
+#else
+	SYMBOL(node_data);
+	LENGTH(node_data, MAX_NUMNODES);
+#endif
+#endif
+
+	SIZE(page);
+	SIZE(pglist_data);
+	SIZE(zone);
+	SIZE(free_area);
+	SIZE(list_head);
+
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
+#ifdef CONFIG_X86_PAE
+	vmcoreinfo_append_str("CONFIG_X86_PAE=y\n");
+#endif
+
+#ifdef CONFIG_IA64
+#ifdef CONFIG_PGTABLE_3
+	vmcoreinfo_append_str("CONFIG_PGTABLE_3=y\n");
+#elif CONFIG_PGTABLE_4
+	vmcoreinfo_append_str("CONFIG_PGTABLE_4=y\n");
+#endif
+#endif
+	crash_save_vmcoreinfo();
+
+	return 0;
+}
+
+module_init(crash_save_vmcoreinfo_init)
diff -rpuN linux-2.6.22.org/kernel/ksysfs.c linux-2.6.22/kernel/ksysfs.c
--- linux-2.6.22.org/kernel/ksysfs.c	2007-08-04 00:22:33.000000000 +0900
+++ linux-2.6.22/kernel/ksysfs.c	2007-08-07 00:34:50.000000000 +0900
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
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
