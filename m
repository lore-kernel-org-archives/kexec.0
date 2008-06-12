Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6i7Q-0003o6-R7
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 08:25:18 +0000
Date: Thu, 12 Jun 2008 17:23:10 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 1/2] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080612170202.16CE.ODA@valinux.co.jp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org

This patch is for xen-unstable.

- the machine address and the size of the vmcoreinfo area is returned
  via the kexec_op(get_range) hypercall
- fill the vmcoreinfo data when the kexec_op(crash load) hypercall 
  is called

Signed-off-by: Itsuro Oda <oda@valinux.co.jp>

diff -r a0561bcf9333 xen/arch/ia64/xen/machine_kexec.c
--- a/xen/arch/ia64/xen/machine_kexec.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/arch/ia64/xen/machine_kexec.c	Thu Jun 12 10:41:17 2008 +0900
@@ -193,6 +193,15 @@ int machine_kexec_get(xen_kexec_range_t 
 	return -EINVAL;
 }
 
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_SYMBOL(dom_xen);
+	VMCOREINFO_SYMBOL(dom_io);
+	VMCOREINFO_SYMBOL(xen_pstart);
+	VMCOREINFO_SYMBOL(frametable_pg_dir);
+	VMCOREINFO_SYMBOL_ALIAS(xen_heap_start, xen_pickle_offset);
+}
+
 /*
  * Local variables:
  * mode: C
diff -r a0561bcf9333 xen/arch/ia64/xen/mm.c
--- a/xen/arch/ia64/xen/mm.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/arch/ia64/xen/mm.c	Thu Jun 12 10:41:46 2008 +0900
@@ -189,7 +189,7 @@ static void domain_page_flush_and_put(st
 
 extern unsigned long ia64_iobase;
 
-static struct domain *dom_xen, *dom_io;
+struct domain *dom_xen, *dom_io;
 
 /*
  * This number is bigger than DOMID_SELF, DOMID_XEN and DOMID_IO.
diff -r a0561bcf9333 xen/arch/x86/machine_kexec.c
--- a/xen/arch/x86/machine_kexec.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/arch/x86/machine_kexec.c	Thu Jun 12 10:38:49 2008 +0900
@@ -145,6 +145,19 @@ int machine_kexec_get(xen_kexec_range_t 
 	return machine_kexec_get_xen(range);
 }
 
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_SYMBOL(dom_xen);
+	VMCOREINFO_SYMBOL(dom_io);
+
+#ifdef CONFIG_X86_PAE
+	VMCOREINFO_SYMBOL_ALIAS(pgd_l3, idle_pg_table);
+#endif
+#ifdef CONFIG_X86_64
+	VMCOREINFO_SYMBOL_ALIAS(pgd_l4, idle_pg_table);
+#endif
+}
+
 /*
  * Local variables:
  * mode: C
diff -r a0561bcf9333 xen/arch/x86/mm.c
--- a/xen/arch/x86/mm.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/arch/x86/mm.c	Thu Jun 12 10:39:17 2008 +0900
@@ -151,7 +151,7 @@ static DEFINE_PER_CPU(struct percpu_mm_i
 #define FOREIGNDOM (this_cpu(percpu_mm_info).foreign ?: current->domain)
 
 /* Private domain structs for DOMID_XEN and DOMID_IO. */
-static struct domain *dom_xen, *dom_io;
+struct domain *dom_xen, *dom_io;
 
 /* Frame table and its size in pages. */
 struct page_info *frame_table;
diff -r a0561bcf9333 xen/common/kexec.c
--- a/xen/common/kexec.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/common/kexec.c	Thu Jun 12 10:30:06 2008 +0900
@@ -43,6 +43,9 @@ static unsigned long kexec_flags = 0; /*
 
 static spinlock_t kexec_lock = SPIN_LOCK_UNLOCKED;
 
+static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
+static size_t vmcoreinfo_size = 0;
+
 xen_kexec_reserve_t kexec_crash_area;
 
 static void __init parse_crashkernel(const char *str)
@@ -208,6 +211,13 @@ static int kexec_get_cpu(xen_kexec_range
     return 0;
 }
 
+static int kexec_get_vmcoreinfo(xen_kexec_range_t *range)
+{
+    range->start = __pa((unsigned long)vmcoreinfo_data);
+    range->size = VMCOREINFO_BYTES;
+    return 0;
+}
+
 static int kexec_get_range_internal(xen_kexec_range_t *range)
 {
     int ret = -EINVAL;
@@ -219,6 +229,9 @@ static int kexec_get_range_internal(xen_
         break;
     case KEXEC_RANGE_MA_CPU:
         ret = kexec_get_cpu(range);
+        break;
+    case KEXEC_RANGE_MA_VMCOREINFO:
+        ret = kexec_get_vmcoreinfo(range);
         break;
     default:
         ret = machine_kexec_get(range);
@@ -288,6 +301,56 @@ static int kexec_load_get_bits(int type,
     return 0;
 }
 
+void vmcoreinfo_append_str(const char *fmt, ...)
+{
+    va_list args;
+    char buf[0x50];
+    int r;
+    size_t note_size = sizeof(Elf_Note) + ELFNOTE_ALIGN(strlen(VMCOREINFO_NOTE_NAME) + 1);
+
+    if (vmcoreinfo_size + note_size + sizeof(buf) > VMCOREINFO_BYTES)
+        return;
+
+    va_start(args, fmt);
+    r = vsnprintf(buf, sizeof(buf), fmt, args);
+    va_end(args);
+
+    memcpy(&vmcoreinfo_data[note_size + vmcoreinfo_size], buf, r);
+
+    vmcoreinfo_size += r;
+}
+
+static void crash_save_vmcoreinfo(void)
+{
+    size_t data_size;
+
+    if (vmcoreinfo_size > 0)    /* already saved */
+        return;
+
+    data_size = VMCOREINFO_BYTES - (sizeof(Elf_Note) + ELFNOTE_ALIGN(strlen(VMCOREINFO_NOTE_NAME) + 1));
+    setup_note((Elf_Note *)vmcoreinfo_data, VMCOREINFO_NOTE_NAME, 0, data_size);
+
+    VMCOREINFO_PAGESIZE(PAGE_SIZE);
+
+    VMCOREINFO_SYMBOL(domain_list);
+    VMCOREINFO_SYMBOL(frame_table);
+    VMCOREINFO_SYMBOL(alloc_bitmap);
+    VMCOREINFO_SYMBOL(max_page);
+    VMCOREINFO_SYMBOL(xenheap_phys_end);
+
+    VMCOREINFO_STRUCT_SIZE(page_info);
+    VMCOREINFO_STRUCT_SIZE(domain);
+
+    VMCOREINFO_OFFSET(page_info, count_info);
+    VMCOREINFO_OFFSET_ALIAS(page_info, u, _domain);
+    VMCOREINFO_OFFSET(domain, domain_id);
+    VMCOREINFO_OFFSET(domain, next_in_list);
+
+#ifdef ARCH_CRASH_SAVE_VMCOREINFO
+    arch_crash_save_vmcoreinfo();
+#endif
+}
+
 static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
 {
     xen_kexec_image_t *image;
@@ -316,6 +379,8 @@ static int kexec_load_unload_internal(un
             /* Make new image the active one */
             change_bit(bit, &kexec_flags);
         }
+
+        crash_save_vmcoreinfo();
     }
 
     /* Unload the old image if present and load successful */
diff -r a0561bcf9333 xen/common/page_alloc.c
--- a/xen/common/page_alloc.c	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/common/page_alloc.c	Thu Jun 12 10:36:11 2008 +0900
@@ -102,7 +102,7 @@ static unsigned long scrub_pages;
  *  One bit per page of memory. Bit set => page is allocated.
  */
 
-static unsigned long *alloc_bitmap;
+unsigned long *alloc_bitmap;
 #define PAGES_PER_MAPWORD (sizeof(unsigned long) * 8)
 
 #define allocated_in_map(_pn)                       \
diff -r a0561bcf9333 xen/include/asm-ia64/config.h
--- a/xen/include/asm-ia64/config.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/asm-ia64/config.h	Thu Jun 12 10:46:15 2008 +0900
@@ -294,4 +294,6 @@ struct screen_info { };
 
 #define CONFIG_XENCOMM_MARK_DIRTY 1
 
+#define ARCH_CRASH_SAVE_VMCOREINFO
+
 #endif	/* _IA64_CONFIG_H_ */
diff -r a0561bcf9333 xen/include/asm-ia64/mm.h
--- a/xen/include/asm-ia64/mm.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/asm-ia64/mm.h	Thu Jun 12 10:45:59 2008 +0900
@@ -503,4 +503,6 @@ int steal_page(
 
 unsigned long domain_get_maximum_gpfn(struct domain *d);
 
+extern struct domain *dom_xen, *dom_io;	/* for vmcoreinfo */
+
 #endif /* __ASM_IA64_MM_H__ */
diff -r a0561bcf9333 xen/include/asm-x86/config.h
--- a/xen/include/asm-x86/config.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/asm-x86/config.h	Thu Jun 12 10:46:42 2008 +0900
@@ -379,4 +379,6 @@ extern unsigned long xen_phys_start, xen
 #define ELFSIZE 32
 #endif
 
+#define ARCH_CRASH_SAVE_VMCOREINFO
+
 #endif /* __X86_CONFIG_H__ */
diff -r a0561bcf9333 xen/include/asm-x86/mm.h
--- a/xen/include/asm-x86/mm.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/asm-x86/mm.h	Thu Jun 12 10:45:00 2008 +0900
@@ -351,4 +351,6 @@ unsigned int domain_clamp_alloc_bitsize(
 
 unsigned long domain_get_maximum_gpfn(struct domain *d);
 
+extern struct domain *dom_xen, *dom_io;	/* for vmcoreinfo */
+
 #endif /* __ASM_X86_MM_H__ */
diff -r a0561bcf9333 xen/include/public/kexec.h
--- a/xen/include/public/kexec.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/public/kexec.h	Thu Jun 12 10:35:05 2008 +0900
@@ -138,6 +138,7 @@ typedef struct xen_kexec_load {
                                      * the ia64_boot_param */
 #define KEXEC_RANGE_MA_EFI_MEMMAP 5 /* machine address and size of
                                      * of the EFI Memory Map */
+#define KEXEC_RANGE_MA_VMCOREINFO 6 /* machine address and size of vmcoreinfo */
 
 /*
  * Find the address and size of certain memory areas
@@ -154,6 +155,27 @@ typedef struct xen_kexec_range {
     unsigned long start;
 } xen_kexec_range_t;
 
+/* vmcoreinfo stuff */
+#define VMCOREINFO_BYTES           (4096)
+#define VMCOREINFO_NOTE_NAME       "VMCOREINFO_XEN"
+void arch_crash_save_vmcoreinfo(void);
+void vmcoreinfo_append_str(const char *fmt, ...)
+       __attribute__ ((format (printf, 1, 2)));
+#define VMCOREINFO_PAGESIZE(value) \
+       vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
+#define VMCOREINFO_SYMBOL(name) \
+       vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define VMCOREINFO_SYMBOL_ALIAS(alias, name) \
+       vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #alias, (unsigned long)&name)
+#define VMCOREINFO_STRUCT_SIZE(name) \
+       vmcoreinfo_append_str("SIZE(%s)=%zu\n", #name, sizeof(struct name))
+#define VMCOREINFO_OFFSET(name, field) \
+       vmcoreinfo_append_str("OFFSET(%s.%s)=%zu\n", #name, #field, \
+                             offsetof(struct name, field))
+#define VMCOREINFO_OFFSET_ALIAS(name, field, alias) \
+       vmcoreinfo_append_str("OFFSET(%s.%s)=%zu\n", #name, #alias, \
+                             offsetof(struct name, field))
+
 #endif /* _XEN_PUBLIC_KEXEC_H */
 
 /*
diff -r a0561bcf9333 xen/include/xen/mm.h
--- a/xen/include/xen/mm.h	Wed Jun 11 16:38:02 2008 +0100
+++ b/xen/include/xen/mm.h	Thu Jun 12 10:45:22 2008 +0900
@@ -104,4 +104,6 @@ int guest_remove_page(struct domain *d, 
 /* Returns TRUE if the memory at address @p is ordinary RAM. */
 int memory_is_conventional_ram(paddr_t p);
 
+extern unsigned long *alloc_bitmap;	/* for vmcoreinfo */
+
 #endif /* __XEN_MM_H__ */

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
