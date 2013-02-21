Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aFv-00068n-AL
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:48:42 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Date: Thu, 21 Feb 2013 17:48:11 +0000
Message-ID: <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

In the existing kexec hypercall, the load and unload ops depend on
internals of the Linux kernel (the page list and code page provided by
the kernel).  The code page is used to transition between Xen context
and the image so using kernel code doesn't make sense and will not
work for PVH guests.

Add replacement KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload ops
that no longer require a code page to be provided by the guest -- Xen
now provides the code for calling the image directly.

The new load op looks similar to the Linux kexec_load system call and
allows the guest to provide the image data to be loaded.  The guest
specifies the architecture of the image which may be a 32-bit subarch
of the hypervisor's architecture (i.e., an EM_386 image on an
EM_X86_64 hypervisor).

The toolstack can now load images without kernel involvement.  This is
required for supporting kexec when using a dom0 with an upstream
kernel.

Crash images are copied directly into the crash region on load.
Default images are copied into Xen heap pages and a list of source and
destination machine addresses is created.  This is list is used in
kexec_reloc() to relocate the image to its destination.

The old load and unload sub-ops are still available (as
KEXEC_CMD_load_v1 and KEXEC_CMD_unload_v1) and are implemented on top
of the new infrastructure.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/arch/x86/machine_kexec.c        |  261 ++++++++++++++++++-------
 xen/arch/x86/x86_64/Makefile        |    2 +-
 xen/arch/x86/x86_64/compat_kexec.S  |  187 -----------------
 xen/arch/x86/x86_64/kexec_reloc.S   |  229 +++++++++++++++++++++
 xen/common/kexec.c                  |  377 +++++++++++++++++++++++++++++------
 xen/include/asm-x86/fixmap.h        |    3 -
 xen/include/asm-x86/machine_kexec.h |   14 ++
 xen/include/xen/kexec.h             |   14 +-
 8 files changed, 755 insertions(+), 332 deletions(-)
 delete mode 100644 xen/arch/x86/x86_64/compat_kexec.S
 create mode 100644 xen/arch/x86/x86_64/kexec_reloc.S
 create mode 100644 xen/include/asm-x86/machine_kexec.h

diff --git a/xen/arch/x86/machine_kexec.c b/xen/arch/x86/machine_kexec.c
index 8191ef1..0ec8c56 100644
--- a/xen/arch/x86/machine_kexec.c
+++ b/xen/arch/x86/machine_kexec.c
@@ -1,9 +1,18 @@
 /******************************************************************************
  * machine_kexec.c
  *
+ * Copyright (C) 2013 Citrix Systems R&D Ltd.
+ *
+ * Portions derived from Linux's arch/x86/kernel/machine_kexec_64.c.
+ *
+ *   Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
+ *
  * Xen port written by:
  * - Simon 'Horms' Horman <horms@verge.net.au>
  * - Magnus Damm <magnus@valinux.co.jp>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
  */
 
 #include <xen/types.h>
@@ -11,63 +20,195 @@
 #include <xen/guest_access.h>
 #include <asm/fixmap.h>
 #include <asm/hpet.h>
+#include <asm/page.h>
+#include <asm/machine_kexec.h>
+
+static void init_level2_page(l2_pgentry_t *l2, unsigned long addr)
+{
+    unsigned long end_addr;
+
+    addr &= PAGE_MASK;
+    end_addr = addr + L2_PAGETABLE_ENTRIES * (1ul << L2_PAGETABLE_SHIFT);
+
+    while ( addr < end_addr )
+    {
+        l2e_write(l2++, l2e_from_paddr(addr, __PAGE_HYPERVISOR | _PAGE_PSE));
 
-typedef void (*relocate_new_kernel_t)(
-                unsigned long indirection_page,
-                unsigned long *page_list,
-                unsigned long start_address,
-                unsigned int preserve_context);
+        addr += 1ul << L2_PAGETABLE_SHIFT;
+    }
+}
 
-int machine_kexec_load(int type, int slot, xen_kexec_image_t *image)
+static int init_level3_page(struct kexec_image *image, l3_pgentry_t *l3,
+                            unsigned long addr, unsigned long last_addr)
 {
-    unsigned long prev_ma = 0;
-    int fix_base = FIX_KEXEC_BASE_0 + (slot * (KEXEC_XEN_NO_PAGES >> 1));
-    int k;
+    unsigned long end_addr;
 
-    /* setup fixmap to point to our pages and record the virtual address
-     * in every odd index in page_list[].
-     */
+    addr &= PAGE_MASK;
+    end_addr = addr + L3_PAGETABLE_ENTRIES * (1ul << L3_PAGETABLE_SHIFT);
+
+    while( (addr < last_addr) && (addr < end_addr) )
+    {
+        struct page_info *l2_page;
+        l2_pgentry_t *l2;
+
+        l2_page = kimage_alloc_control_page(image);
+        if ( !l2_page )
+            return -ENOMEM;
+        l2 = page_to_virt(l2_page);
+
+        init_level2_page(l2, addr);
+        l3e_write(l3++, l3e_from_page(l2_page, __PAGE_HYPERVISOR));
+
+        addr += 1ul << L3_PAGETABLE_SHIFT;
+    }
+
+    return 0;
+}
+
+/*
+ * Build a complete page table to identity map [addr, last_addr).
+ *
+ * Control pages are used so they do not overlap with the image source
+ * or destination.
+ */
+static int init_level4_page(struct kexec_image *image, l4_pgentry_t *l4,
+                            unsigned long addr, unsigned long last_addr)
+{
+    unsigned long end_addr;
+    int result;
+
+    addr &= PAGE_MASK;
+    end_addr = addr + L4_PAGETABLE_ENTRIES * (1ul << L4_PAGETABLE_SHIFT);
+
+    while ( (addr < last_addr) && (addr < end_addr) )
+    {
+        struct page_info *l3_page;
+        l3_pgentry_t *l3;
+
+        l3_page = kimage_alloc_control_page(image);
+        if ( !l3_page )
+            return -ENOMEM;
+        l3 = page_to_virt(l3_page);
+
+        result = init_level3_page(image, l3, addr, last_addr);
+        if (result)
+            return result;
+        l4e_write(l4++, l4e_from_page(l3_page, __PAGE_HYPERVISOR));
+
+        addr += 1ul << L4_PAGETABLE_SHIFT;
+    }
+
+    return 0;
+}
 
-    for ( k = 0; k < KEXEC_XEN_NO_PAGES; k++ )
+/*
+ * Add a mapping for the control code page to the same virtual address
+ * as kexec_reloc.  This allows us to keep running after these page
+ * tables are loaded in kexec_reloc.
+ * 
+ * We don't really need to allocate control pages here as these
+ * entries won't be used while the kexec image is being copied, but it
+ * makes clean-up easier.
+ */
+static int init_transition_pgtable(struct kexec_image *image, l4_pgentry_t *l4)
+{
+    struct page_info *l3_page;
+    struct page_info *l2_page;
+    struct page_info *l1_page;
+    unsigned long vaddr, paddr;
+    l3_pgentry_t *l3;
+    l2_pgentry_t *l2;
+    l1_pgentry_t *l1;
+
+    vaddr = (unsigned long)kexec_reloc;
+    paddr = page_to_maddr(image->control_code_page);
+
+    l4 += l4_table_offset(vaddr);
+    if ( !(l4e_get_flags(*l4) & _PAGE_PRESENT) )
+    {
+        l3_page = kimage_alloc_control_page(image);
+        if ( !l3_page )
+            return -ENOMEM;
+        l4e_write(l4, l4e_from_page(l3_page, __PAGE_HYPERVISOR));
+    }
+
+    l3 = l4e_to_l3e(*l4) + l3_table_offset(vaddr);
+    if ( !(l3e_get_flags(*l3) & _PAGE_PRESENT) )
+    {
+        l2_page = kimage_alloc_control_page(image);
+        if ( !l2_page )
+            return -ENOMEM;
+        l3e_write(l3, l3e_from_page(l2_page, __PAGE_HYPERVISOR));
+    }
+
+    l2 = l3e_to_l2e(*l3) + l2_table_offset(vaddr);
+    if ( !(l2e_get_flags(*l2) & _PAGE_PRESENT) )
+    {
+        l1_page = kimage_alloc_control_page(image);
+        if ( !l1_page )
+            return -ENOMEM;
+        l2e_write(l2, l2e_from_page(l1_page, __PAGE_HYPERVISOR));
+    }
+
+    l1 = l2e_to_l1e(*l2) + l1_table_offset(vaddr);
+    l1e_write(l1, l1e_from_pfn(paddr >> PAGE_SHIFT, __PAGE_HYPERVISOR));
+    return 0;
+}
+
+
+static int build_reloc_page_table(struct kexec_image *image)
+{
+    struct page_info *l4_page;
+    l4_pgentry_t *l4;
+    int result;
+
+    l4_page = kimage_alloc_control_page(image);
+    if ( !l4_page )
+        return -ENOMEM;
+
+    l4 = page_to_virt(l4_page);
+    result = init_level4_page(image, l4, 0, max_page << PAGE_SHIFT);
+    if ( result )
+        return result;
+
+    result = init_transition_pgtable(image, l4);
+    if ( result )
+        return result;
+
+    image->aux_page = l4_page;
+    return 0;
+}
+
+int machine_kexec_load(struct kexec_image *image)
+{
+    void *code_page;
+    int ret;
+
+    switch ( image->arch )
     {
-        if ( (k & 1) == 0 )
-        {
-            /* Even pages: machine address. */
-            prev_ma = image->page_list[k];
-        }
-        else
-        {
-            /* Odd pages: va for previous ma. */
-            if ( is_pv_32on64_domain(dom0) )
-            {
-                /*
-                 * The compatability bounce code sets up a page table
-                 * with a 1-1 mapping of the first 1G of memory so
-                 * VA==PA here.
-                 *
-                 * This Linux purgatory code still sets up separate
-                 * high and low mappings on the control page (entries
-                 * 0 and 1) but it is harmless if they are equal since
-                 * that PT is not live at the time.
-                 */
-                image->page_list[k] = prev_ma;
-            }
-            else
-            {
-                set_fixmap(fix_base + (k >> 1), prev_ma);
-                image->page_list[k] = fix_to_virt(fix_base + (k >> 1));
-            }
-        }
+    case EM_386:
+    case EM_X86_64:
+        break;
+    default:
+        return -EINVAL;
     }
 
+    code_page = page_to_virt(image->control_code_page);
+    memcpy(code_page, kexec_reloc, PAGE_SIZE);
+
+    ret = build_reloc_page_table(image);
+    if ( ret < 0 )
+        return ret;
+
     return 0;
 }
 
-void machine_kexec_unload(int type, int slot, xen_kexec_image_t *image)
+void machine_kexec_unload(struct kexec_image *image)
 {
+    /* no-op. kimage_free() frees all control pages. */
 }
 
-void machine_reboot_kexec(xen_kexec_image_t *image)
+void machine_reboot_kexec(struct kexec_image *image)
 {
     BUG_ON(smp_processor_id() != 0);
     smp_send_stop();
@@ -75,13 +216,10 @@ void machine_reboot_kexec(xen_kexec_image_t *image)
     BUG();
 }
 
-void machine_kexec(xen_kexec_image_t *image)
+void machine_kexec(struct kexec_image *image)
 {
-    struct desc_ptr gdt_desc = {
-        .base = (unsigned long)(boot_cpu_gdt_table - FIRST_RESERVED_GDT_ENTRY),
-        .limit = LAST_RESERVED_GDT_BYTE
-    };
     int i;
+    unsigned long reloc_flags = 0;
 
     /* We are about to permenantly jump out of the Xen context into the kexec
      * purgatory code.  We really dont want to be still servicing interupts.
@@ -109,29 +247,12 @@ void machine_kexec(xen_kexec_image_t *image)
      * not like running with NMIs disabled. */
     enable_nmis();
 
-    /*
-     * compat_machine_kexec() returns to idle pagetables, which requires us
-     * to be running on a static GDT mapping (idle pagetables have no GDT
-     * mappings in their per-domain mapping area).
-     */
-    asm volatile ( "lgdt %0" : : "m" (gdt_desc) );
+    if ( image->arch == EM_386 )
+        reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
 
-    if ( is_pv_32on64_domain(dom0) )
-    {
-        compat_machine_kexec(image->page_list[1],
-                             image->indirection_page,
-                             image->page_list,
-                             image->start_address);
-    }
-    else
-    {
-        relocate_new_kernel_t rnk;
-
-        rnk = (relocate_new_kernel_t) image->page_list[1];
-        (*rnk)(image->indirection_page, image->page_list,
-               image->start_address,
-               0 /* preserve_context */);
-    }
+    kexec_reloc(page_to_maddr(image->control_code_page), 
+                page_to_maddr(image->aux_page),
+                image->head, image->entry_maddr, reloc_flags);
 }
 
 int machine_kexec_get(xen_kexec_range_t *range)
diff --git a/xen/arch/x86/x86_64/Makefile b/xen/arch/x86/x86_64/Makefile
index d56e12d..7f8fb3d 100644
--- a/xen/arch/x86/x86_64/Makefile
+++ b/xen/arch/x86/x86_64/Makefile
@@ -11,11 +11,11 @@ obj-y += mmconf-fam10h.o
 obj-y += mmconfig_64.o
 obj-y += mmconfig-shared.o
 obj-y += compat.o
-obj-bin-y += compat_kexec.o
 obj-y += domain.o
 obj-y += physdev.o
 obj-y += platform_hypercall.o
 obj-y += cpu_idle.o
 obj-y += cpufreq.o
+obj-bin-y += kexec_reloc.o
 
 obj-$(crash_debug)   += gdbstub.o
diff --git a/xen/arch/x86/x86_64/compat_kexec.S b/xen/arch/x86/x86_64/compat_kexec.S
deleted file mode 100644
index fc92af9..0000000
--- a/xen/arch/x86/x86_64/compat_kexec.S
+++ /dev/null
@@ -1,187 +0,0 @@
-/*
- * Compatibility kexec handler.
- */
-
-/*
- * NOTE: We rely on Xen not relocating itself above the 4G boundary. This is
- * currently true but if it ever changes then compat_pg_table will
- * need to be moved back below 4G at run time.
- */
-
-#include <xen/config.h>
-
-#include <asm/asm_defns.h>
-#include <asm/msr.h>
-#include <asm/page.h>
-
-/* The unrelocated physical address of a symbol. */
-#define SYM_PHYS(sym)          ((sym) - __XEN_VIRT_START)
-
-/* Load physical address of symbol into register and relocate it. */
-#define RELOCATE_SYM(sym,reg)  mov $SYM_PHYS(sym), reg ; \
-                               add xen_phys_start(%rip), reg
-
-/*
- * Relocate a physical address in memory. Size of temporary register
- * determines size of the value to relocate.
- */
-#define RELOCATE_MEM(addr,reg) mov addr(%rip), reg ; \
-                               add xen_phys_start(%rip), reg ; \
-                               mov reg, addr(%rip)
-
-        .text
-
-        .code64
-
-ENTRY(compat_machine_kexec)
-        /* x86/64                        x86/32  */
-        /* %rdi - relocate_new_kernel_t  CALL    */
-        /* %rsi - indirection page       4(%esp) */
-        /* %rdx - page_list              8(%esp) */
-        /* %rcx - start address         12(%esp) */
-        /*        cpu has pae           16(%esp) */
-
-        /* Shim the 64 bit page_list into a 32 bit page_list. */
-        mov $12,%r9
-        lea compat_page_list(%rip), %rbx
-1:      dec %r9
-        movl (%rdx,%r9,8),%eax
-        movl %eax,(%rbx,%r9,4)
-        test %r9,%r9
-        jnz 1b
-
-        RELOCATE_SYM(compat_page_list,%rdx)
-
-        /* Relocate compatibility mode entry point address. */
-        RELOCATE_MEM(compatibility_mode_far,%eax)
-
-        /* Relocate compat_pg_table. */
-        RELOCATE_MEM(compat_pg_table,     %rax)
-        RELOCATE_MEM(compat_pg_table+0x8, %rax)
-        RELOCATE_MEM(compat_pg_table+0x10,%rax)
-        RELOCATE_MEM(compat_pg_table+0x18,%rax)
-
-        /*
-         * Setup an identity mapped region in PML4[0] of idle page
-         * table.
-         */
-        RELOCATE_SYM(l3_identmap,%rax)
-        or  $0x63,%rax
-        mov %rax, idle_pg_table(%rip)
-
-        /* Switch to idle page table. */
-        RELOCATE_SYM(idle_pg_table,%rax)
-        movq %rax, %cr3
-
-        /* Switch to identity mapped compatibility stack. */
-        RELOCATE_SYM(compat_stack,%rax)
-        movq %rax, %rsp
-
-        /* Save xen_phys_start for 32 bit code. */
-        movq xen_phys_start(%rip), %rbx
-
-        /* Jump to low identity mapping in compatibility mode. */
-        ljmp *compatibility_mode_far(%rip)
-        ud2
-
-compatibility_mode_far:
-        .long SYM_PHYS(compatibility_mode)
-        .long __HYPERVISOR_CS32
-
-        /*
-         * We use 5 words of stack for the arguments passed to the kernel. The
-         * kernel only uses 1 word before switching to its own stack. Allocate
-         * 16 words to give "plenty" of room.
-         */
-        .fill 16,4,0
-compat_stack:
-
-        .code32
-
-#undef RELOCATE_SYM
-#undef RELOCATE_MEM
-
-/*
- * Load physical address of symbol into register and relocate it. %rbx
- * contains xen_phys_start(%rip) saved before jump to compatibility
- * mode.
- */
-#define RELOCATE_SYM(sym,reg) mov $SYM_PHYS(sym), reg ; \
-                              add %ebx, reg
-
-compatibility_mode:
-        /* Setup some sane segments. */
-        movl $__HYPERVISOR_DS32, %eax
-        movl %eax, %ds
-        movl %eax, %es
-        movl %eax, %fs
-        movl %eax, %gs
-        movl %eax, %ss
-
-        /* Push arguments onto stack. */
-        pushl $0   /* 20(%esp) - preserve context */
-        pushl $1   /* 16(%esp) - cpu has pae */
-        pushl %ecx /* 12(%esp) - start address */
-        pushl %edx /*  8(%esp) - page list */
-        pushl %esi /*  4(%esp) - indirection page */
-        pushl %edi /*  0(%esp) - CALL */
-
-        /* Disable paging and therefore leave 64 bit mode. */
-        movl %cr0, %eax
-        andl $~X86_CR0_PG, %eax
-        movl %eax, %cr0
-
-        /* Switch to 32 bit page table. */
-        RELOCATE_SYM(compat_pg_table, %eax)
-        movl  %eax, %cr3
-
-        /* Clear MSR_EFER[LME], disabling long mode */
-        movl    $MSR_EFER,%ecx
-        rdmsr
-        btcl    $_EFER_LME,%eax
-        wrmsr
-
-        /* Re-enable paging, but only 32 bit mode now. */
-        movl %cr0, %eax
-        orl $X86_CR0_PG, %eax
-        movl %eax, %cr0
-        jmp 1f
-1:
-
-        popl %eax
-        call *%eax
-        ud2
-
-        .data
-        .align 4
-compat_page_list:
-        .fill 12,4,0
-
-        .align 32,0
-
-        /*
-         * These compat page tables contain an identity mapping of the
-         * first 4G of the physical address space.
-         */
-compat_pg_table:
-        .long SYM_PHYS(compat_pg_table_l2) + 0*PAGE_SIZE + 0x01, 0
-        .long SYM_PHYS(compat_pg_table_l2) + 1*PAGE_SIZE + 0x01, 0
-        .long SYM_PHYS(compat_pg_table_l2) + 2*PAGE_SIZE + 0x01, 0
-        .long SYM_PHYS(compat_pg_table_l2) + 3*PAGE_SIZE + 0x01, 0
-
-        .section .data.page_aligned, "aw", @progbits
-        .align PAGE_SIZE,0
-compat_pg_table_l2:
-        .macro identmap from=0, count=512
-        .if \count-1
-        identmap "(\from+0)","(\count/2)"
-        identmap "(\from+(0x200000*(\count/2)))","(\count/2)"
-        .else
-        .quad 0x00000000000000e3 + \from
-        .endif
-        .endm
-
-        identmap 0x00000000
-        identmap 0x40000000
-        identmap 0x80000000
-        identmap 0xc0000000
diff --git a/xen/arch/x86/x86_64/kexec_reloc.S b/xen/arch/x86/x86_64/kexec_reloc.S
new file mode 100644
index 0000000..e68842c
--- /dev/null
+++ b/xen/arch/x86/x86_64/kexec_reloc.S
@@ -0,0 +1,229 @@
+/*
+ * Relocate a kexec_image to its destination and call it.
+ *
+ * Copyright (C) 2013 Citrix Systems R&D Ltd.
+ *
+ * Portions derived from Linux's arch/x86/kernel/relocate_kernel_64.S.
+ * 
+ *   Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+#include <xen/config.h>
+
+#include <asm/asm_defns.h>
+#include <asm/msr.h>
+#include <asm/page.h>
+#include <asm/machine_kexec.h>
+
+/* The unrelocated physical address of a symbol. */
+#define SYM_PHYS(sym)          ((sym) - __XEN_VIRT_START)
+
+/* Load physical address of symbol into register and relocate it. */
+#define RELOCATE_SYM(sym,reg)  mov $SYM_PHYS(sym), reg ; \
+                               add xen_phys_start(%rip), reg
+
+#define DBG(c) \
+1:      mov     $0x3f8+5, %dx ; \
+        inb     %dx, %al     ; \
+        test    $0x20, %al   ; \
+        je      1b           ; \
+        mov     $0x3f8, %dx  ; \
+        mov     $c, %al      ; \
+        outb    %al, %dx     ;
+
+        .text
+	.align PAGE_SIZE
+        .code64
+
+ENTRY(kexec_reloc)
+        /* %rdi - code_page maddr */
+        /* %rsi - page table maddr */
+        /* %rdx - indirection page maddr */
+        /* %rcx - entry maddr */
+        /* %r8 - flags */
+
+        mov %rdx, %rbx
+
+        DBG('A')
+
+        /* Setup stack. */
+        RELOCATE_SYM(reloc_stack, %rax)
+        mov %rax, %rsp
+
+        DBG('B')
+
+        wbinvd
+        movq %cr4, %rax
+        andq $~(X86_CR4_PGE|X86_CR4_PCE|X86_CR4_MCE), %rax
+        movq %rax, %cr4
+
+        /* Load reloc page table. */
+        movq %rsi, %cr3
+
+        DBG('C')
+
+        /* Jump to identity mapped code. */
+        movq %rdi, %r9
+        addq $(identity_mapped - kexec_reloc), %r9
+
+        DBG('D')
+
+        jmp *%r9
+
+identity_mapped:
+        DBG('E')
+        
+        pushq %rcx
+        pushq %rbx
+        pushq %rsi
+        pushq %rdi
+
+        movq %rbx, %rdi
+        call swap_pages
+
+        popq %rdi
+        popq %rsi
+        popq %rbx
+        popq %rcx
+
+        DBG('F')
+
+        /* Need to switch to 32-bit mode? */
+        testq $KEXEC_RELOC_FLAG_COMPAT, %r8
+        jnz call_32_bit
+
+call_64_bit:
+        DBG('6')
+
+        /* Call the image entry point.  This should never return. */
+        call *%rcx
+        ud2
+
+call_32_bit:
+        DBG('3')
+
+        /* Relocate compatibility mode entry point address. */
+        movl %edi, %eax
+        addl $(compatibility_mode - kexec_reloc), %eax
+        movl %eax, compatibility_mode_far(%rip)
+
+        DBG('I')
+        
+        /* Load compat GDT. */
+        movq %rdi, %rax
+        addq $(compat_mode_gdt - kexec_reloc), %rax
+        movq %rax, (compat_mode_gdt_desc + 2)(%rip)
+        lgdt compat_mode_gdt_desc(%rip)
+
+        DBG('J')
+        
+        /* Enter compatibility mode. */
+        ljmp *compatibility_mode_far(%rip)
+
+swap_pages:
+        /* %rdi - indirection page maddr */
+        movq    %rdi, %rcx
+        xorq    %rdi, %rdi
+        xorq    %rsi, %rsi
+        jmp     1f
+
+0:      /* top, read another word for the indirection page */
+
+        movq    (%rbx), %rcx
+        addq    $8,     %rbx
+1:
+        testq   $0x1,   %rcx  /* is it a destination page? */
+        jz      2f
+        movq    %rcx,   %rdi
+        andq    $0xfffffffffffff000, %rdi
+        jmp     0b
+2:
+        testq   $0x2,   %rcx  /* is it an indirection page? */
+        jz      2f
+        movq    %rcx,   %rbx
+        andq    $0xfffffffffffff000, %rbx
+        jmp     0b
+2:
+        testq   $0x4,   %rcx  /* is it the done indicator? */
+        jz      2f
+        jmp     3f
+2:
+        testq   $0x8,   %rcx  /* is it the source indicator? */
+        jz      0b            /* Ignore it otherwise */
+        movq    %rcx,   %rsi  /* For ever source page do a copy */
+        andq    $0xfffffffffffff000, %rsi
+
+        movq    %rdi, %rdx
+        movq    %rsi, %rax
+
+        movq    %r10, %rdi
+        movq    $512,   %rcx
+        rep movsq
+
+        movq    %rax, %rdi
+        movq    %rdx, %rsi
+        movq    $512,   %rcx
+        rep movsq
+
+        movq    %rdx, %rdi
+        movq    %r10, %rsi
+        movq    $512,   %rcx
+        rep movsq
+
+        lea     PAGE_SIZE(%rax), %rsi
+        jmp     0b
+3:
+        ret
+
+        .code32
+
+compatibility_mode:
+        DBG('K')
+
+        /* Setup some sane segments. */
+        movl $0x0008, %eax
+        movl %eax, %ds
+        movl %eax, %es
+        movl %eax, %fs
+        movl %eax, %gs
+        movl %eax, %ss
+
+        DBG('L')
+        
+        /* Disable paging and therefore leave 64 bit mode. */
+        movl %cr0, %eax
+        andl $~X86_CR0_PG, %eax
+        movl %eax, %cr0
+
+        DBG('M')
+
+        /* Call the image entry point.  This should never return. */
+        call *%ecx
+        ud2
+
+        .align 16
+compatibility_mode_far:
+        .long SYM_PHYS(compatibility_mode)
+        .word 0x0010
+
+        .align 16
+compat_mode_gdt_desc:
+        .word (3*8)-1
+        .quad SYM_PHYS(compat_mode_gdt)
+
+        .align 16
+compat_mode_gdt:
+        .quad 0x0000000000000000     /* null                              */
+        .quad 0x00cf92000000ffff     /* 0x0008 ring 0 data                */
+        .quad 0x00cf9a000000ffff     /* 0x0010 ring 0 code, compatibility */
+
+        /*
+         * 16 words of stack are more than enough.
+         */
+        .fill 16,8,0
+reloc_stack:
+
+        .globl kexec_reloc_size
+        .set kexec_reloc_size, . - kexec_reloc
diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 2cbb62c..2926274 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -23,6 +23,7 @@
 #include <xen/version.h>
 #include <xen/console.h>
 #include <xen/kexec.h>
+#include <xen/kimage.h>
 #include <public/elfnote.h>
 #include <xsm/xsm.h>
 #include <xen/cpu.h>
@@ -45,7 +46,7 @@ static Elf_Note *xen_crash_note;
 
 static cpumask_t crash_saved_cpus;
 
-static xen_kexec_image_t kexec_image[KEXEC_IMAGE_NR];
+static struct kexec_image *kexec_image[KEXEC_IMAGE_NR];
 
 #define KEXEC_FLAG_DEFAULT_POS   (KEXEC_IMAGE_NR + 0)
 #define KEXEC_FLAG_CRASH_POS     (KEXEC_IMAGE_NR + 1)
@@ -309,14 +310,14 @@ void kexec_crash(void)
     kexec_common_shutdown();
     kexec_crash_save_cpu();
     machine_crash_shutdown();
-    machine_kexec(&kexec_image[KEXEC_IMAGE_CRASH_BASE + pos]);
+    machine_kexec(kexec_image[KEXEC_IMAGE_CRASH_BASE + pos]);
 
     BUG();
 }
 
 static long kexec_reboot(void *_image)
 {
-    xen_kexec_image_t *image = _image;
+    struct kexec_image *image = _image;
 
     kexecing = TRUE;
 
@@ -732,63 +733,245 @@ static void crash_save_vmcoreinfo(void)
 #endif
 }
 
-static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_v1_t *load)
+static void kexec_unload_image(struct kexec_image *image)
+{
+    if ( !image )
+        return;
+
+    machine_kexec_unload(image);
+}
+
+static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+    xen_kexec_exec_t exec;
+    struct kexec_image *image;
+    int base, bit, pos, ret = -EINVAL;
+
+    if ( unlikely(copy_from_guest(&exec, uarg, 1)) )
+        return -EFAULT;
+
+    if ( kexec_load_get_bits(exec.type, &base, &bit) )
+        return -EINVAL;
+
+    pos = (test_bit(bit, &kexec_flags) != 0);
+
+    /* Only allow kexec/kdump into loaded images */
+    if ( !test_bit(base + pos, &kexec_flags) )
+        return -ENOENT;
+
+    switch (exec.type)
+    {
+    case KEXEC_TYPE_DEFAULT:
+        image = kexec_image[base + pos];
+        ret = continue_hypercall_on_cpu(0, kexec_reboot, image);
+        break;
+    case KEXEC_TYPE_CRASH:
+        kexec_crash(); /* Does not return */
+        break;
+    }
+
+    return -EINVAL; /* never reached */
+}
+
+static int kexec_swap_images(int type, struct kexec_image *new,
+                             struct kexec_image **old)
 {
-    xen_kexec_image_t *image;
     int base, bit, pos;
-    int ret = 0;
+    int new_slot, old_slot;
+
+    *old = NULL;
+
+    spin_lock(&kexec_lock);
+
+    if ( test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
+    {
+        spin_unlock(&kexec_lock);
+        return -EBUSY;
+    }
 
-    if ( kexec_load_get_bits(load->type, &base, &bit) )
+    if ( kexec_load_get_bits(type, &base, &bit) )
         return -EINVAL;
 
     pos = (test_bit(bit, &kexec_flags) != 0);
+    old_slot = base + pos;
+    new_slot = base + !pos;
 
-    /* Load the user data into an unused image */
-    if ( op == KEXEC_CMD_kexec_load )
+    if ( new )
     {
-        image = &kexec_image[base + !pos];
+        kexec_image[new_slot] = new;
+        set_bit(new_slot, &kexec_flags);
+    }
+    change_bit(bit, &kexec_flags);
 
-        BUG_ON(test_bit((base + !pos), &kexec_flags)); /* must be free */
+    clear_bit(old_slot, &kexec_flags);
+    *old = kexec_image[old_slot];
 
-        memcpy(image, &load->image, sizeof(*image));
+    spin_unlock(&kexec_lock);
 
-        if ( !(ret = machine_kexec_load(load->type, base + !pos, image)) )
-        {
-            /* Set image present bit */
-            set_bit((base + !pos), &kexec_flags);
+    return 0;
+}
 
-            /* Make new image the active one */
-            change_bit(bit, &kexec_flags);
-        }
+static int kexec_load_slot(struct kexec_image *kimage)
+{
+    struct kexec_image *old_kimage;
+    int ret = -ENOMEM;
+
+    ret = machine_kexec_load(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    crash_save_vmcoreinfo();
 
-        crash_save_vmcoreinfo();
+    ret = kexec_swap_images(kimage->type, kimage, &old_kimage);
+    if ( ret < 0 )
+        goto error;
+
+    kexec_unload_image(old_kimage);
+    
+    return 0;
+
+error:
+    kimage_free(kimage);
+    return ret;
+}
+
+static uint16_t kexec_load_v1_arch(void)
+{
+#ifdef CONFIG_X86
+    return is_pv_32on64_domain(dom0) ? EM_386 : EM_X86_64;
+#else
+    return EM_NONE;
+#endif
+}
+
+static int kexec_segments_add_page(unsigned *nr_segments,
+                                   xen_kexec_segment_t *segments,
+                                   unsigned long mfn)
+{
+    unsigned long maddr = mfn << PAGE_SHIFT;
+    int n = *nr_segments;
+
+    /* Need a new segment? */
+    if ( n == 0
+         || segments[n-1].dest_maddr + segments[n-1].dest_size != maddr )
+    {
+        n++;
+        if ( n == KEXEC_SEGMENT_MAX )
+            return -EINVAL;
+        *nr_segments = n;
+
+        set_xen_guest_handle(segments[n-1].buf, NULL);
+        segments[n-1].buf_size = 0;
+        segments[n-1].dest_maddr = maddr;
+        segments[n-1].dest_size = 0;
     }
 
-    /* Unload the old image if present and load successful */
-    if ( ret == 0 && !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
+    segments[n-1].dest_size += PAGE_SIZE;
+
+    return 0;
+}
+
+static int kexec_segments_from_ind_page(unsigned long mfn,
+                                        unsigned *nr_segments,
+                                        xen_kexec_segment_t *segments)
+{
+    void *page;
+    unsigned long *entry;
+    int ret;
+
+    page = vmap(&mfn, 1);
+    if ( page == NULL )
+        return -ENOMEM;
+
+    /*
+     * Walk the indirection page list, adding destination pages to the
+     * segments.
+     */
+    for ( entry = page; ; entry++ )
     {
-        if ( test_and_clear_bit((base + pos), &kexec_flags) )
+        unsigned long ind;
+
+        ind = (*entry) & 0xf;
+        mfn = (*entry) >> PAGE_SHIFT;
+
+        switch ( ind )
         {
-            image = &kexec_image[base + pos];
-            machine_kexec_unload(load->type, base + pos, image);
+        case IND_DESTINATION:
+            ret = kexec_segments_add_page(nr_segments, segments, mfn);
+            if ( ret < 0 )
+                return ret;
+            break;
+        case IND_INDIRECTION:
+            vunmap(page);
+            page = vmap(&mfn, 1);
+            if ( page == NULL )
+                return -ENOMEM;
+            entry = page;
+            break;
+        case IND_DONE:
+            goto done;
+        case IND_SOURCE:
+            break;
         }
     }
+done:
+    return 0;
+}
+
+static int kexec_do_load_v1(xen_kexec_load_v1_t *load)
+{
+    struct kexec_image *kimage = NULL;
+    xen_kexec_segment_t *segments;
+    uint16_t arch;
+    unsigned nr_segments = 0;
+    int ret;
+
+    arch = kexec_load_v1_arch();
+    if ( arch == EM_NONE )
+        return -ENOSYS;
+
+    segments = xmalloc_array(xen_kexec_segment_t, KEXEC_SEGMENT_MAX);
+    if ( segments == NULL )
+        return -ENOMEM;
+
+    ret = kexec_segments_from_ind_page(load->image.indirection_page >> PAGE_SHIFT,
+                                       &nr_segments, segments);
+    if ( ret < 0 )
+        goto error;
+
+    ret = kimage_alloc(&kimage, load->type, arch, load->image.start_address,
+                       nr_segments, segments);
+    if ( ret < 0 )
+        goto error;
+
+    /* kexec_reloc() uses the same format for the indirection pages so
+       reuse the provided ones. */
+    kimage->head = load->image.indirection_page;
+
+    ret = kexec_load_slot(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    return 0;
 
+error:
+    if ( !kimage )
+        xfree(segments);
+    kimage_free(kimage);
     return ret;
 }
 
-static int kexec_load_unload(unsigned long op, XEN_GUEST_HANDLE_PARAM(void) uarg)
+static int kexec_load_v1(XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
     xen_kexec_load_v1_t load;
 
     if ( unlikely(copy_from_guest(&load, uarg, 1)) )
         return -EFAULT;
 
-    return kexec_load_unload_internal(op, &load);
+    return kexec_do_load_v1(&load);
 }
 
-static int kexec_load_unload_compat(unsigned long op,
-                                    XEN_GUEST_HANDLE_PARAM(void) uarg)
+static int kexec_load_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
 #ifdef CONFIG_COMPAT
     compat_kexec_load_v1_t compat_load;
@@ -807,49 +990,113 @@ static int kexec_load_unload_compat(unsigned long op,
     load.type = compat_load.type;
     XLAT_kexec_image(&load.image, &compat_load.image);
 
-    return kexec_load_unload_internal(op, &load);
-#else /* CONFIG_COMPAT */
+    return kexec_do_load_v1(&load);
+#else
     return 0;
-#endif /* CONFIG_COMPAT */
+#endif
 }
 
-static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
+static int kexec_load(XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
-    xen_kexec_exec_t exec;
-    xen_kexec_image_t *image;
-    int base, bit, pos, ret = -EINVAL;
+    xen_kexec_load_t load;
+    xen_kexec_segment_t *segments;
+    struct kexec_image *kimage = NULL;
+    int ret;
 
-    if ( unlikely(copy_from_guest(&exec, uarg, 1)) )
+    if ( copy_from_guest(&load, uarg, 1) )
         return -EFAULT;
 
-    if ( kexec_load_get_bits(exec.type, &base, &bit) )
+    if ( load.nr_segments >= KEXEC_SEGMENT_MAX )
         return -EINVAL;
 
-    pos = (test_bit(bit, &kexec_flags) != 0);
-
-    /* Only allow kexec/kdump into loaded images */
-    if ( !test_bit(base + pos, &kexec_flags) )
-        return -ENOENT;
+    segments = xmalloc_array(xen_kexec_segment_t, load.nr_segments);
+    if ( segments == NULL )
+        return -ENOMEM;
 
-    switch (exec.type)
+    if ( copy_from_guest(segments, load.segments, load.nr_segments) )
     {
-    case KEXEC_TYPE_DEFAULT:
-        image = &kexec_image[base + pos];
-        ret = continue_hypercall_on_cpu(0, kexec_reboot, image);
-        break;
-    case KEXEC_TYPE_CRASH:
-        kexec_crash(); /* Does not return */
-        break;
+        ret = -EFAULT;
+        goto error;
     }
 
-    return -EINVAL; /* never reached */
+    ret = kimage_alloc(&kimage, load.type, load.arch, load.entry_maddr,
+                       load.nr_segments, segments);
+    if ( ret < 0 )
+        goto error;
+
+    ret = kimage_load_segments(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    ret = kexec_load_slot(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    return 0;
+
+error:
+    if ( ! kimage )
+        xfree(segments);
+    kimage_free(kimage);
+    return ret;
+}
+
+static int kexec_do_unload(xen_kexec_unload_t *unload)
+{
+    struct kexec_image *old_kimage;
+    int ret;
+
+    ret = kexec_swap_images(unload->type, NULL, &old_kimage);
+    if ( ret < 0 )
+        return ret;
+
+    kexec_unload_image(old_kimage);
+
+    return 0;
+}
+
+static int kexec_unload_v1(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+    xen_kexec_load_v1_t load;
+    xen_kexec_unload_t unload;
+
+    if ( copy_from_guest(&load, uarg, 1) )
+        return -EFAULT;
+
+    unload.type = load.type;
+    return kexec_do_unload(&unload);
+}
+
+static int kexec_unload_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+#ifdef CONFIG_COMPAT
+    compat_kexec_load_v1_t compat_load;
+    xen_kexec_unload_t unload;
+
+    if ( copy_from_guest(&compat_load, uarg, 1) )
+        return -EFAULT;
+
+    unload.type = compat_load.type;
+    return kexec_do_unload(&unload);
+#else
+    return 0;
+#endif
+}
+
+static int kexec_unload(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+    xen_kexec_unload_t unload;
+
+    if ( unlikely(copy_from_guest(&unload, uarg, 1)) )
+        return -EFAULT;
+
+    return kexec_do_unload(&unload);
 }
 
 static int do_kexec_op_internal(unsigned long op,
                                 XEN_GUEST_HANDLE_PARAM(void) uarg,
                                 bool_t compat)
 {
-    unsigned long flags;
     int ret = -EINVAL;
 
     ret = xsm_kexec(XSM_PRIV);
@@ -865,20 +1112,26 @@ static int do_kexec_op_internal(unsigned long op,
                 ret = kexec_get_range(uarg);
         break;
     case KEXEC_CMD_kexec_load_v1:
+        if ( compat )
+            ret = kexec_load_v1_compat(uarg);
+        else
+            ret = kexec_load_v1(uarg);
+        break;
     case KEXEC_CMD_kexec_unload_v1:
-        spin_lock_irqsave(&kexec_lock, flags);
-        if (!test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags))
-        {
-                if (compat)
-                        ret = kexec_load_unload_compat(op, uarg);
-                else
-                        ret = kexec_load_unload(op, uarg);
-        }
-        spin_unlock_irqrestore(&kexec_lock, flags);
+        if ( compat )
+            ret = kexec_unload_v1_compat(uarg);
+        else
+            ret = kexec_unload_v1(uarg);
         break;
     case KEXEC_CMD_kexec:
         ret = kexec_exec(uarg);
         break;
+    case KEXEC_CMD_kexec_load:
+        ret = kexec_load(uarg);
+        break;
+    case KEXEC_CMD_kexec_unload:
+        ret = kexec_unload(uarg);
+        break;
     }
 
     return ret;
diff --git a/xen/include/asm-x86/fixmap.h b/xen/include/asm-x86/fixmap.h
index 2eefcf4..1695228 100644
--- a/xen/include/asm-x86/fixmap.h
+++ b/xen/include/asm-x86/fixmap.h
@@ -57,9 +57,6 @@ enum fixed_addresses {
     FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
     FIX_HPET_BASE,
     FIX_CYCLONE_TIMER,
-    FIX_KEXEC_BASE_0,
-    FIX_KEXEC_BASE_END = FIX_KEXEC_BASE_0 \
-      + ((KEXEC_XEN_NO_PAGES >> 1) * KEXEC_IMAGE_NR) - 1,
     FIX_IOMMU_REGS_BASE_0,
     FIX_IOMMU_REGS_END = FIX_IOMMU_REGS_BASE_0 + MAX_IOMMUS-1,
     FIX_IOMMU_MMIO_BASE_0,
diff --git a/xen/include/asm-x86/machine_kexec.h b/xen/include/asm-x86/machine_kexec.h
new file mode 100644
index 0000000..ec41099
--- /dev/null
+++ b/xen/include/asm-x86/machine_kexec.h
@@ -0,0 +1,14 @@
+#ifndef __X86_MACHINE_KEXEC_H__
+#define __X86_MACHINE_KEXEC_H__
+
+#define KEXEC_RELOC_FLAG_COMPAT 0x1 /* 32-bit image */
+
+#ifndef __ASSEMBLY__
+
+extern void kexec_reloc(unsigned long reloc_code, unsigned long reloc_pt,
+                        unsigned long ind_maddr, unsigned long entry_maddr,
+                        unsigned long flags);
+
+#endif
+
+#endif /* __X86_MACHINE_KEXEC_H__ */
diff --git a/xen/include/xen/kexec.h b/xen/include/xen/kexec.h
index b3ca8b0..b1177d8 100644
--- a/xen/include/xen/kexec.h
+++ b/xen/include/xen/kexec.h
@@ -6,6 +6,7 @@
 #include <public/kexec.h>
 #include <asm/percpu.h>
 #include <xen/elfcore.h>
+#include <xen/kimage.h>
 
 typedef struct xen_kexec_reserve {
     unsigned long size;
@@ -40,11 +41,11 @@ extern enum low_crashinfo low_crashinfo_mode;
 extern paddr_t crashinfo_maxaddr_bits;
 void kexec_early_calculations(void);
 
-int machine_kexec_load(int type, int slot, xen_kexec_image_t *image);
-void machine_kexec_unload(int type, int slot, xen_kexec_image_t *image);
+int machine_kexec_load(struct kexec_image *image);
+void machine_kexec_unload(struct kexec_image *image);
 void machine_kexec_reserved(xen_kexec_reserve_t *reservation);
-void machine_reboot_kexec(xen_kexec_image_t *image);
-void machine_kexec(xen_kexec_image_t *image);
+void machine_reboot_kexec(struct kexec_image *image);
+void machine_kexec(struct kexec_image *image);
 void kexec_crash(void);
 void kexec_crash_save_cpu(void);
 crash_xen_info_t *kexec_crash_save_info(void);
@@ -52,11 +53,6 @@ void machine_crash_shutdown(void);
 int machine_kexec_get(xen_kexec_range_t *range);
 int machine_kexec_get_xen(xen_kexec_range_t *range);
 
-void compat_machine_kexec(unsigned long rnk,
-                          unsigned long indirection_page,
-                          unsigned long *page_list,
-                          unsigned long start_address);
-
 /* vmcoreinfo stuff */
 #define VMCOREINFO_BYTES           (4096)
 #define VMCOREINFO_NOTE_NAME       "VMCOREINFO_XEN"
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
