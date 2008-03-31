Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgBaC-0005b3-Em
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 04:25:21 +0000
Date: Mon, 31 Mar 2008 13:25:19 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 1/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080331131512.DDCD.ODA@valinux.co.jp>
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

This patch is for xen-3.2.0.

--- common/kexec.c.org	2008-03-25 09:29:39.000000000 +0900
+++ common/kexec.c	2008-03-28 12:50:33.000000000 +0900
@@ -43,6 +43,9 @@
 
 static spinlock_t kexec_lock = SPIN_LOCK_UNLOCKED;
 
+static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
+static size_t vmcoreinfo_size = 0;
+
 xen_kexec_reserve_t kexec_crash_area;
 
 static void __init parse_crashkernel(const char *str)
@@ -223,6 +226,13 @@
     return 0;
 }
 
+static int kexec_get(vmcoreinfo)(xen_kexec_range_t *range)
+{
+    range->start = __pa((unsigned long)vmcoreinfo_data);
+    range->size = VMCOREINFO_BYTES;
+    return 0;
+}
+
 static int kexec_get(range)(XEN_GUEST_HANDLE(void) uarg)
 {
     xen_kexec_range_t range;
@@ -242,6 +252,9 @@
     case KEXEC_RANGE_MA_CPU:
         ret = kexec_get(cpu)(&range);
         break;
+    case KEXEC_RANGE_MA_VMCOREINFO:
+        ret = kexec_get(vmcoreinfo)(&range);
+        break;
     }
 
     if ( ret == 0 && unlikely(copy_to_guest(uarg, &range, 1)) )
@@ -270,6 +283,57 @@
     return 0;
 }
 
+void vmcoreinfo_append_str(const char *fmt, ...)
+{
+    va_list args;
+    char buf[0x50];
+    int r;
+    size_t note_size = sizeof(Elf_Note) + ELFNOTE_ALIGN(strlen(VMCOREINFO_NOTE_NAME) + 1);
+
+    va_start(args, fmt);
+    r = vsnprintf(buf, sizeof(buf), fmt, args);
+    va_end(args);
+
+    if (r + vmcoreinfo_size + note_size > VMCOREINFO_BYTES)
+	r = VMCOREINFO_BYTES - vmcoreinfo_size - note_size;
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
+    if (vmcoreinfo_size > 0)	/* already saved */
+	return;
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
+    VMCOREINFO_SYMBOL(xenheap_phys_start);
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
 #endif
 
 static int kexec_load_unload(unsigned long op, XEN_GUEST_HANDLE(void) uarg)
@@ -308,6 +372,9 @@
             /* Make new image the active one */
             change_bit(bit, &kexec_flags);
         }
+#ifndef COMPAT
+        crash_save_vmcoreinfo();
+#endif
     }
 
     /* Unload the old image if present and load successful */
--- include/public/kexec.h.org	2008-03-25 09:59:04.000000000 +0900
+++ include/public/kexec.h	2008-03-27 10:07:47.000000000 +0900
@@ -111,6 +111,7 @@
 #define KEXEC_RANGE_MA_CRASH 0   /* machine address and size of crash area */
 #define KEXEC_RANGE_MA_XEN   1   /* machine address and size of Xen itself */
 #define KEXEC_RANGE_MA_CPU   2   /* machine address and size of a CPU note */
+#define KEXEC_RANGE_MA_VMCOREINFO   3   /* machine address and size of vmcoreinfo */
 
 /*
  * Find the address and size of certain memory areas
@@ -127,6 +128,37 @@
     unsigned long start;
 } xen_kexec_range_t;
 
+/* vmcoreinfo stuff */
+#define VMCOREINFO_BYTES           (4096)
+#define VMCOREINFO_NOTE_NAME       "VMCOREINFO_XEN"
+void arch_crash_save_vmcoreinfo(void);
+void vmcoreinfo_append_str(const char *fmt, ...)
+       __attribute__ ((format (printf, 1, 2)));
+#define VMCOREINFO_OSRELEASE(name) \
+       vmcoreinfo_append_str("OSRELEASE=%s\n", #name)
+#define VMCOREINFO_PAGESIZE(value) \
+       vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
+#define VMCOREINFO_SYMBOL(name) \
+       vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define VMCOREINFO_SYMBOL_ALIAS(alias, name) \
+       vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #alias, (unsigned long)&name)
+#define VMCOREINFO_SIZE(name) \
+       vmcoreinfo_append_str("SIZE(%s)=%zu\n", #name, sizeof(name))
+#define VMCOREINFO_STRUCT_SIZE(name) \
+       vmcoreinfo_append_str("SIZE(%s)=%zu\n", #name, sizeof(struct name))
+#define VMCOREINFO_OFFSET(name, field) \
+       vmcoreinfo_append_str("OFFSET(%s.%s)=%zu\n", #name, #field, \
+                             offsetof(struct name, field))
+#define VMCOREINFO_OFFSET_ALIAS(name, field, alias) \
+       vmcoreinfo_append_str("OFFSET(%s.%s)=%zu\n", #name, #alias, \
+                             offsetof(struct name, field))
+#define VMCOREINFO_LENGTH(name, value) \
+       vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
+#define VMCOREINFO_NUMBER(name) \
+       vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
+#define VMCOREINFO_CONFIG(name) \
+       vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
+
 #endif /* _XEN_PUBLIC_KEXEC_H */
 
 /*
--- common/page_alloc.c.org	2008-03-25 09:56:37.000000000 +0900
+++ common/page_alloc.c	2008-03-25 09:55:39.000000000 +0900
@@ -101,7 +101,7 @@
  *  One bit per page of memory. Bit set => page is allocated.
  */
 
-static unsigned long *alloc_bitmap;
+unsigned long *alloc_bitmap;
 #define PAGES_PER_MAPWORD (sizeof(unsigned long) * 8)
 
 #define allocated_in_map(_pn)                       \
--- arch/x86/machine_kexec.c.org	2008-03-27 08:24:11.000000000 +0900
+++ arch/x86/machine_kexec.c	2008-03-27 08:33:00.000000000 +0900
@@ -135,6 +135,19 @@
     }
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
--- arch/x86/mm.c.org	2008-03-25 09:57:32.000000000 +0900
+++ arch/x86/mm.c	2008-03-25 09:54:25.000000000 +0900
@@ -142,7 +142,7 @@
 #define FOREIGNDOM (this_cpu(percpu_mm_info).foreign ?: current->domain)
 
 /* Private domain structs for DOMID_XEN and DOMID_IO. */
-static struct domain *dom_xen, *dom_io;
+struct domain *dom_xen, *dom_io;
 
 /* Frame table and its size in pages. */
 struct page_info *frame_table;
--- arch/ia64/xen/machine_kexec.c.org	2008-03-27 09:39:57.000000000 +0900
+++ arch/ia64/xen/machine_kexec.c	2008-03-27 10:45:55.000000000 +0900
@@ -165,6 +165,15 @@
 	machine_kexec(image);
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
--- arch/ia64/xen/mm.c.org	2008-03-27 09:44:18.000000000 +0900
+++ arch/ia64/xen/mm.c	2008-03-27 09:44:39.000000000 +0900
@@ -189,7 +189,7 @@
 
 extern unsigned long ia64_iobase;
 
-static struct domain *dom_xen, *dom_io;
+struct domain *dom_xen, *dom_io;
 
 /*
  * This number is bigger than DOMID_SELF, DOMID_XEN and DOMID_IO.
--- include/xen/mm.h.org	2008-03-27 10:04:18.000000000 +0900
+++ include/xen/mm.h	2008-03-27 10:05:12.000000000 +0900
@@ -105,4 +105,5 @@
 /* Returns TRUE if the memory at address @p is ordinary RAM. */
 int memory_is_conventional_ram(paddr_t p);
 
+extern unsigned long *alloc_bitmap;
 #endif /* __XEN_MM_H__ */
--- include/asm-x86/mm.h.org	2008-03-27 10:06:17.000000000 +0900
+++ include/asm-x86/mm.h	2008-03-27 10:06:36.000000000 +0900
@@ -356,4 +356,5 @@
 
 unsigned long domain_get_maximum_gpfn(struct domain *d);
 
+extern struct domain *dom_xen, *dom_io;
 #endif /* __ASM_X86_MM_H__ */
--- include/asm-ia64/mm.h.org	2008-03-27 10:06:50.000000000 +0900
+++ include/asm-ia64/mm.h	2008-03-27 10:07:34.000000000 +0900
@@ -523,4 +523,5 @@
 
 unsigned long domain_get_maximum_gpfn(struct domain *d);
 
+extern struct domain *dom_xen, *dom_io;
 #endif /* __ASM_IA64_MM_H__ */
--- include/asm-x86/config.h.org	2008-03-28 12:43:46.000000000 +0900
+++ include/asm-x86/config.h	2008-03-28 12:43:57.000000000 +0900
@@ -388,4 +388,6 @@
 #define ELFSIZE 32
 #endif
 
+#define ARCH_CRASH_SAVE_VMCOREINFO
+
 #endif /* __X86_CONFIG_H__ */
--- include/asm-ia64/config.h.org	2008-03-28 12:46:21.000000000 +0900
+++ include/asm-ia64/config.h	2008-03-28 12:46:45.000000000 +0900
@@ -287,4 +287,6 @@
 /* Define CONFIG_PRIVIFY to support privified OS (deprecated).  */
 #undef CONFIG_PRIVIFY
 
+#define ARCH_CRASH_SAVE_VMCOREINFO
+
 #endif	/* _IA64_CONFIG_H_ */
--- include/xen/elfcore.h.org	2008-03-31 08:58:28.000000000 +0900
+++ include/xen/elfcore.h	2008-03-31 09:00:19.000000000 +0900
@@ -66,6 +66,7 @@
     unsigned long xen_compile_time;
     unsigned long tainted;
 #if defined(__i386__) || defined(__x86_64__)
+    unsigned long xen_phys_start_mfn;
     unsigned long dom0_pfn_to_mfn_frame_list_list;
 #endif
 #if defined(__ia64__)
--- arch/x86/crash.c.org	2008-03-31 09:00:38.000000000 +0900
+++ arch/x86/crash.c	2008-03-31 09:03:21.000000000 +0900
@@ -102,6 +102,7 @@
     hvm_cpu_down();
 
     info = kexec_crash_save_info();
+    info->xen_phys_start_mfn = xen_phys_start >> PAGE_SHIFT;
     info->dom0_pfn_to_mfn_frame_list_list =
         arch_get_pfn_to_mfn_frame_list_list(dom0);
 }

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
