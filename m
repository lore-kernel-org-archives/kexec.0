Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo185.gate.nec.co.jp ([114.179.232.185])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMIJ3-0004ui-7c
 for kexec@lists.infradead.org; Mon, 12 Nov 2018 19:55:36 +0000
Received: from tyo162.gate.nec.co.jp (tyo162.gate.nec.co.jp [114.179.232.162])
 by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id
 wACJsCT9018448
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2018 04:54:12 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2 1/2] makedumpfile/arm64: Use VMCOREINFO inside
 '/proc/kcore' (if available)
Date: Mon, 12 Nov 2018 19:51:49 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355F6E9@BPXM09GP.gisp.nec.co.jp>
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355F237@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpNB9HZFfqgRC=sZCoKJ6YMvZkaPwBM=AAT_o3_t-+e5eQ@mail.gmail.com>
In-Reply-To: <CACi5LpNB9HZFfqgRC=sZCoKJ6YMvZkaPwBM=AAT_o3_t-+e5eQ@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Hi Bhupesh,

(I'm trying to send this again without the attached files
because the previous one looks being held by kexec list.
sorry for the duplication.)

Thank you for the information.

On 11/8/2018 4:58 PM, Bhupesh Sharma wrote:
> Hi Kazu,
> 
> On Wed, Nov 7, 2018 at 1:53 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
> >
> > On 11/2/2018 5:00 PM, Kazuhito Hagio wrote:
> > > Originally, info->page_offset (PAGE_OFFSET) is used in the following
> > > parts on arm64.
> > >
> > > arch/arm64.c:
> > > __pa(unsigned long vaddr)
> > > {
> > >         if (kimage_voffset == NOT_FOUND_NUMBER ||
> > >                         (vaddr >= PAGE_OFFSET))
> > >                 return (vaddr - PAGE_OFFSET + info->phys_base);
> > >         else
> > >                 return (vaddr - kimage_voffset);
> > > }
> > >
> > > elf_info.c:
> > >         kvstart = (ulong)start + PAGE_OFFSET;
> > >         kvend = (ulong)end + PAGE_OFFSET;
> > > --
> > >         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
> > >
> > > I'm wondering about its consistency.  Is it OK to set
> > > (virt_start - phys_start) to info->page_offset on arm64?
> > > In other words, on arm64 system with info->phys_base != 0, does it
> > > work correctly for both /proc/vmcore and --mem-usage /proc/kcore?
> >
> > I found an arm64 system available and (virt_start - phys_start)
> > tested OK for both /proc/vmcore and --mem-usage /proc/kcore,
> > because the __pa() function is used just only for swapper_pg_dir
> > and the "(vaddr - PAGE_OFFSET + info->phys_base)" line is not used.
> >
> > The definition of PAGE_OFFSET in kernel is:
> >
> >   #define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
> >           (UL(1) << (VA_BITS - 1)) + 1)
> >
> > The one in crash is:
> >
> >   #define ARM64_PAGE_OFFSET    ((0xffffffffffffffffUL) \
> >                                         << (machdep->machspec->VA_BITS - 1))
> >
> > So I think it would be better to use the same definition also in
> > makedumpfile to avoid confusion. In other words, I think the following
> > does not support arm64 now, and ideally should be fixed by introducing
> > something like phys_to_virt()..
> >
> > elf_info.c:
> >         kvstart = (ulong)start + PAGE_OFFSET;
> >         kvend = (ulong)end + PAGE_OFFSET;
> >         --
> >         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
> >
> > and then,
> >
> >   if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)
> >       va_bits = NUMBER(VA_BITS);
> >   else
> >       ... va_vits calculation ...
> >
> >   info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
> >
> > And also we will need to add get_phys_base() to show_mem_usage()
> > with some additional code for arm64 with old kernels.
> > I'm considering this approach.
> 
> Note that PAGE_OFFSET is not constant on KASLR enabled arm64 kernels
> as the start of the linear range gets randomized as well (as per the
> KASLR seed) which means that PAGE_OFFSET is no longer equal to the
> macro:
> #define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
>            (UL(1) << (VA_BITS - 1)) + 1)

The PAGE_OFFSET macro itself is still constant in arm64 kernel and used by
p2v/v2p calculation, and also used by the test whether a virtual address is
in linear kernel range (as VA_BITS):
---
extern s64                      memstart_addr;
/* PHYS_OFFSET - the physical address of the start of memory. */
#define PHYS_OFFSET             ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
...
/*
 * The linear kernel range starts in the middle of the virtual adddress
 * space. Testing the top bit for the start of the region is a
 * sufficient check.
 */
#define __is_lm_address(addr)   (!!((addr) & BIT(VA_BITS - 1)))

#define __lm_to_phys(addr)      (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
#define __kimg_to_phys(addr)    ((addr) - kimage_voffset)

#define __virt_to_phys_nodebug(x) ({                                    \
        phys_addr_t __x = (phys_addr_t)(x);                             \
        __is_lm_address(__x) ? __lm_to_phys(__x) :                      \
                               __kimg_to_phys(__x);                     \
})
...
#define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
---

I meant that I just would like to imitate these definitions also in
makedumpfile first, for better maintenance and future changes.

Of course, PAGE_OFFSET becomes constant (from VA_BITS only), but PHYS_OFFSET
(= memstart_addr) will be variable by some conditions including KASLR.
I think that this PAGE_OFFSET is a bit different from x86_64's one on its
meaning.

> Please have a look at my discussion with the arm64 maintainers which
> started the whole vmcoreinfo in kcore stuff rolling: ).
> It talks about PAGE_OFFSET and how it cannot be a constant macro for
> KASLR boot cases:
> [1]. https://www.spinics.net/lists/arm-kernel/msg655933.html
> [2]. https://www.spinics.net/lists/kexec/msg20842.html
> 
> Also implementing __pa() or __phys_to_virt(x) in user-space is not
> easy as reported earlier for kexec-tools as well. A typical arm64
> __phys_to_virt(x) looks like this (simplified):
> 
> | #define __phys_to_virt(x) \
> | ((unsigned long)((x) - memstart_addr) | PAGE_OFFSET)
> 
> Please have a look at the discussion with the arm64 maintainers
> regarding their views on the same here:
> [3]. https://www.spinics.net/lists/kexec/msg20867.html
> 
> As James, suggested in this thread, " If user-space needs this value
> to work with
> /proc/{kcore,vmcore} we should expose something like 'p2v_offset' as an elf-note
> on those files. (looks like they both have elf-headers).", something
> which I am working on already and plan to send upstream next week.
> 
> My only concern is regarding whether we are heading in a direction in
> user-land, which has been NAK'ed by arm64 kernel maintainers, which
> means that if we need to avoid the nasty rewrite of a 'p2v'
> implementation in the user-space we should probably stick to using the
> standard interfaces exposed by kernel space and add the missing ones
> in kernel and push the kernel community to consider accepting the same
> as a standard ABI between kernel and user space.

I agree to using standard interfaces and pushing it to kernel.
I'm thinking to add comments to your x86_64 'page_offset_base' patch.

Anyway, first I'd like to address the above definition change and the problem
on arm64 with kernels < 4.19 to simlify the situation.

I wrote the attached patches as the first step:

Patch 1 introduces paddr_to_vaddr() and replaces a few "paddr + PAGE_OFFSET"
lines, which is p2v calculation for x86_64, with it.  There is no behavior
change on all architectures, although some architectures may need a fix.

Patch 2 redefines PAGE_OFFSET on arm64 and implement paddr_to_vaddr_arm64().
The meaning of PAGE_OFFSET is changed, but the case that using (vaddr - paddr)
for p2v calculation is not changed.

I tested them on two arm64 systems (including KASLR enabled, because its
KERNELOFFSET=2eff90ae0000 in vmcoreinfo) and it tested OK,
but could you test them on your arm64 boards?

If it works correctly, then let's think about using vmcoreinfo in PT_NOTE in
/proc/kcore, which kernels >= 4.19 have.

Thanks,
Kazu

--
From 7888baf1386728c9c3132d3e24fc8fdf48f55f03 Mon Sep 17 00:00:00 2001
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Date: Thu, 8 Nov 2018 14:26:43 -0500
Subject: [PATCH 1/2] Prepare paddr_to_vaddr() for architectures other than
 x86_64 to support --mem-usage option

Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
---
 elf_info.c     |  7 ++++---
 makedumpfile.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 711601a..1d33e96 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -372,7 +372,7 @@ int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
 	off_t offset_desc;
 
 	offset = UNINITIALIZED;
-	kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
+	kvaddr = paddr_to_vaddr(vmcoreinfo_addr);
 
 	for (i = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
@@ -810,10 +810,11 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
 	int i, j, tidx = -1;
 	unsigned long long	vstart, vend, kvstart, kvend;
 	struct pt_load_segment temp_seg = {0};
-	kvstart = (ulong)start + PAGE_OFFSET;
-	kvend = (ulong)end + PAGE_OFFSET;
 	unsigned long size;
 
+	kvstart = paddr_to_vaddr(start);
+	kvend = paddr_to_vaddr(end);
+
 	for (i = 0; i < (*num_pt_loads); i++) {
 		vstart = (*pt_loads)[i].virt_start;
 		vend = (*pt_loads)[i].virt_end;
diff --git a/makedumpfile.h b/makedumpfile.h
index 46ebe2e..574a335 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -965,6 +965,8 @@ typedef unsigned long pgd_t;
 static inline int stub_true() { return TRUE; }
 static inline int stub_true_ul(unsigned long x) { return TRUE; }
 static inline int stub_false() { return FALSE; }
+#define paddr_to_vaddr_general(X) ((X) + PAGE_OFFSET)
+
 #ifdef __aarch64__
 int get_phys_base_arm64(void);
 int get_machdep_info_arm64(void);
@@ -975,6 +977,7 @@ int get_xen_info_arm64(void);
 unsigned long get_kaslr_offset_arm64(unsigned long vaddr);
 #define find_vmemmap()		stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define get_phys_base()		get_phys_base_arm64()
 #define get_machdep_info()	get_machdep_info_arm64()
 #define get_versiondep_info()	get_versiondep_info_arm64()
@@ -995,6 +998,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
 #define get_versiondep_info()	stub_true()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif /* arm */
@@ -1009,6 +1013,7 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
 #define get_versiondep_info()	get_versiondep_info_x86()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif /* x86 */
@@ -1026,6 +1031,7 @@ unsigned long long vtop4_x86_64_pagetable(unsigned long vaddr, unsigned long pag
 #define get_versiondep_info()	get_versiondep_info_x86_64()
 #define get_kaslr_offset(X)	get_kaslr_offset_x86_64(X)
 #define vaddr_to_paddr(X)	vtop4_x86_64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif /* x86_64 */
@@ -1041,6 +1047,7 @@ int arch_crashkernel_mem_size_ppc64(void);
 #define get_versiondep_info()	get_versiondep_info_ppc64()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	arch_crashkernel_mem_size_ppc64()
 #endif          /* powerpc64 */
@@ -1054,6 +1061,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 #define get_versiondep_info()	stub_true()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif          /* powerpc32 */
@@ -1068,6 +1076,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
 #define get_versiondep_info()	stub_true()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif          /* s390x */
@@ -1082,6 +1091,7 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
 #define get_versiondep_info()	stub_true()
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
@@ -1096,6 +1106,7 @@ unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
 #define get_phys_base()         get_phys_base_sparc64()
 #define get_versiondep_info()   get_versiondep_info_sparc64()
 #define vaddr_to_paddr(X)       vaddr_to_paddr_sparc64(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif		/* sparc64 */
-- 
2.18.1


From 2ce3e43db15e882e8b2746dc3d55a274d364a2f7 Mon Sep 17 00:00:00 2001
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Date: Thu, 8 Nov 2018 15:18:45 -0500
Subject: [PATCH 2/2] arm64: implement paddr_to_vaddr_arm64() to support
 --mem-usage option

Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
---
 arch/arm64.c   | 54 ++++++++++++++++++++++++++++----------------------
 makedumpfile.c |  4 ++++
 makedumpfile.h |  6 +++---
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 3626096..43c6b83 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -174,11 +174,35 @@ get_kvbase_arm64(void)
 int
 get_phys_base_arm64(void)
 {
-	info->phys_base = NUMBER(PHYS_OFFSET);
+	int i;
+	unsigned long long phys_start;
+	unsigned long long virt_start;
 
-	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
+	if (NUMBER(PHYS_OFFSET) != NOT_FOUND_NUMBER) {
+		info->phys_base = NUMBER(PHYS_OFFSET);
+		DEBUG_MSG("phys_base    : %lx (vmcoreinfo)\n",
+				info->phys_base);
+		return TRUE;
+	}
 
-	return TRUE;
+	if (get_num_pt_loads() && PAGE_OFFSET) {
+		for (i = 0;
+		    get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
+		    i++) {
+			if (virt_start != NOT_KV_ADDR
+			    && virt_start >= PAGE_OFFSET
+			    && phys_start != NOT_PADDR) {
+				info->phys_base = phys_start -
+					(virt_start & ~PAGE_OFFSET);
+				DEBUG_MSG("phys_base    : %lx (pt_load)\n",
+						info->phys_base);
+				return TRUE;
+			}
+		}
+	}
+
+	DEBUG_MSG("Cannot determine phys_base\n");
+	return FALSE;
 }
 
 unsigned long
@@ -306,9 +330,6 @@ get_xen_info_arm64(void)
 int
 get_versiondep_info_arm64(void)
 {
-	int i;
-	unsigned long long phys_start;
-	unsigned long long virt_start;
 	ulong _stext;
 
 	_stext = get_stext_symbol();
@@ -333,25 +354,10 @@ get_versiondep_info_arm64(void)
 		return FALSE;
 	}
 
-	if (get_num_pt_loads()) {
-		for (i = 0;
-		    get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
-		    i++) {
-			if (virt_start != NOT_KV_ADDR
-			    && virt_start < __START_KERNEL_map
-			    && phys_start != NOT_PADDR
-			    && phys_start != NOT_PADDR_ARM64) {
-				info->page_offset = virt_start - phys_start;
-				DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
-						info->page_offset, va_bits);
-				return TRUE;
-			}
-		}
-	}
-
 	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
-	DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
-			va_bits);
+
+	DEBUG_MSG("va_bits      : %d\n", va_bits);
+	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
 
 	return TRUE;
 }
diff --git a/makedumpfile.c b/makedumpfile.c
index 91c1ab4..8923538 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11214,6 +11214,10 @@ int show_mem_usage(void)
 	if (!get_page_offset())
 		return FALSE;
 
+	/* paddr_to_vaddr() on arm64 needs phys_base. */
+	if (!get_phys_base())
+		return FALSE;
+
 	if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
 		return FALSE;
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 574a335..a76b499 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -542,9 +542,7 @@ do { \
 #ifdef __aarch64__
 unsigned long get_kvbase_arm64(void);
 #define KVBASE			get_kvbase_arm64()
-
 #define __START_KERNEL_map	(0xffffffff80000000UL)
-#define NOT_PADDR_ARM64		(0x0000000010a80000UL)
 
 #endif /* aarch64 */
 
@@ -975,9 +973,11 @@ int get_versiondep_info_arm64(void);
 int get_xen_basic_info_arm64(void);
 int get_xen_info_arm64(void);
 unsigned long get_kaslr_offset_arm64(unsigned long vaddr);
+#define paddr_to_vaddr_arm64(X)	(((X) - info->phys_base) | PAGE_OFFSET)
+
 #define find_vmemmap()		stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm64(X)
-#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_arm64(X)
 #define get_phys_base()		get_phys_base_arm64()
 #define get_machdep_info()	get_machdep_info_arm64()
 #define get_versiondep_info()	get_versiondep_info_arm64()
-- 
2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
