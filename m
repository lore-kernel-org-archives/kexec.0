Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XifCm-0006RN-79
 for kexec@lists.infradead.org; Mon, 27 Oct 2014 07:59:09 +0000
Date: Mon, 27 Oct 2014 15:57:07 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141027075707.GB1558@dhcp-16-105.nay.redhat.com>
References: <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141016143753.726f63c0@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 10/23/14 at 06:56am, Atsushi Kumagai wrote:
> >On Tue, 14 Oct 2014 07:19:13 +0000
> >Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> >
> >[snip]
> >
> >>
> >> I understand why your patch works on s390x, so how about this way ?
> >>
> >>  1. Define "is_phys_addr()" for --mem-usage.
> >>  2. Implement is_phys_addr() using is_iomem_phys_addr() for s390x
> >>     while x86_64 uses is_vmalloc_addr_x86_64().
> >>  3. Use is_phys_addr() instead of is_vmalloc_addr() in get_kcore_dump_loads().
> >
> >Hello Atsushi,
> >
> >Great, so let's do that.
> >
> >@Baoquan:
> >If you want to use the is_iomem_phys_addr() function also for x86,
> >you could perhaps add an additional patch.
> 
> I noticed that is_vmalloc_addr_x86_64() can't be used as is_phys_addr()
> due to the "kaslr issue". I fixed it in the common path as below, but
> --mem-usage still has the same issue since initial() will be invoked
> after get_kcore_dump_loads().
> 
>   http://lists.infradead.org/pipermail/kexec/2014-October/012743.html
> 
> I know it's so late, but I began to think the current implementation
> that invokes vaddr_to_paddr_XXX() before initial() is bad:
> 
> show_mem_usage()
>   + get_kcore_dump_loads()
>     + process_dump_load()
>       + vaddr_to_paddr_XXX()
>   + initial()

This is a bug. Seems that get_kcore_dump_loads() has to be called in
initial(). Since dumped vmcore need contains kernel text segment.
Without setting correct value for MODULES_VADDR, it will be equal to
__START_KERNEL_map, then calling is_vmalloc_addr() will filter kernel
text mapping segment too.

Now it seems only one way to solve this, that is moving
get_kcore_dump_loads() into initial() just after
get_value_for_old_linux() is called.


>   ...
> 
> vaddr_to_paddr_XXX() does VtoP translation *properly*, so it needs
> several symbols. This design is OK since it's a general method.
> OTOH, we need a kludge which can be used under any situations and
> should use it for --mem-usage:
> 
>   VtoP_kludge_s390x(unsigned long vaddr) 
>   {
> 	/* s390 has 1:1 VtoP mapping that starts with zero. */
>   	return vaddr;
>   }
> 
> also x86_64's can be implemented like below:
> 
>   VtoP_kludge_x86_64(unsigned long vaddr) 
>   {
> 	/* if the address is direct mapped, it's easy to translate. */
> 	unsigned long paddr = vaddr - PAGE_OFFSET;
> 	return paddr;
>   }
> 
> >Here the updated patch:
> >---
> >[PATCH] makedumpfile: Enable --mem-usage for s390x
> >
> >Replace is_vmalloc_addr() by is_phys_addr() and implement is_phys_addr()
> >using /proc/iommem parsing to enable the new makedumpfile option "--mem-usage"
> >on s390x.
> >
> >Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >---
> > elf_info.c     |    4 ++--
> > makedumpfile.c |   26 ++++++++++++++++++++++++++
> > makedumpfile.h |   15 ++++++++-------
> > 3 files changed, 36 insertions(+), 9 deletions(-)
> >
> >--- a/elf_info.c
> >+++ b/elf_info.c
> >@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
> >
> > 	for (i = 0; i < num_pt_loads; ++i) {
> > 		struct pt_load_segment *p = &pt_loads[i];
> >-		if (is_vmalloc_addr(p->virt_start))
> >+		if (!is_phys_addr(p->virt_start))
> 
> This part implicitly does VtoP translation.
> Actually it works for s390x but it's not suitable as a general code,
> so we should use VtoP_kludge(should be better name!) too.
> Then we can use is_iomem_phys_addr() also for other architecture.
> 
> 
> Thanks,
> Atsushi Kumagai
> 
> > 			continue;
> > 		loads++;
> > 	}
> >@@ -874,7 +874,7 @@ int get_kcore_dump_loads(void)
> >
> > 	for (i = 0, j = 0; i < num_pt_loads; ++i) {
> > 		struct pt_load_segment *p = &pt_loads[i];
> >-		if (is_vmalloc_addr(p->virt_start))
> >+		if (!is_phys_addr(p->virt_start))
> > 			continue;
> > 		if (j >= loads)
> > 			return FALSE;
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -9227,6 +9227,32 @@ int is_crashkernel_mem_reserved(void)
> > 	return !!crash_reserved_mem_nr;
> > }
> >
> >+struct addr_check {
> >+	unsigned long addr;
> >+	int found;
> >+};
> >+
> >+static int phys_addr_callback(void *data, int nr, char *str,
> >+			      unsigned long base, unsigned long length)
> >+{
> >+	struct addr_check *addr_check = data;
> >+	unsigned long addr = addr_check->addr;
> >+
> >+	if (addr >= base && addr < base + length) {
> >+		addr_check->found = 1;
> >+		return -1;
> >+	}
> >+	return 0;
> >+}
> >+
> >+int is_iomem_phys_addr(unsigned long addr)
> >+{
> >+	struct addr_check addr_check = {addr, 0};
> >+
> >+	iomem_for_each_line("System RAM\n", phys_addr_callback, &addr_check);
> >+	return addr_check.found;
> >+}
> >+
> > static int get_page_offset(void)
> > {
> > 	struct utsname utsname;
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -765,7 +765,7 @@ unsigned long long vaddr_to_paddr_arm(un
> > #define get_machdep_info()	get_machdep_info_arm()
> > #define get_versiondep_info()	TRUE
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		TRUE
> > #endif /* arm */
> >
> > #ifdef __x86__
> >@@ -776,7 +776,7 @@ unsigned long long vaddr_to_paddr_x86(un
> > #define get_machdep_info()	get_machdep_info_x86()
> > #define get_versiondep_info()	get_versiondep_info_x86()
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		TRUE
> > #endif /* x86 */
> >
> > #ifdef __x86_64__
> >@@ -789,7 +789,7 @@ unsigned long long vaddr_to_paddr_x86_64
> > #define get_machdep_info()	get_machdep_info_x86_64()
> > #define get_versiondep_info()	get_versiondep_info_x86_64()
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
> >-#define is_vmalloc_addr(X)	is_vmalloc_addr_x86_64(X)
> >+#define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X)
> > #endif /* x86_64 */
> >
> > #ifdef __powerpc64__ /* powerpc64 */
> >@@ -800,7 +800,7 @@ unsigned long long vaddr_to_paddr_ppc64(
> > #define get_machdep_info()	get_machdep_info_ppc64()
> > #define get_versiondep_info()	get_versiondep_info_ppc64()
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		TRUE
> > #endif          /* powerpc64 */
> >
> > #ifdef __powerpc32__ /* powerpc32 */
> >@@ -810,7 +810,7 @@ unsigned long long vaddr_to_paddr_ppc(un
> > #define get_machdep_info()	get_machdep_info_ppc()
> > #define get_versiondep_info()	TRUE
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		TRUE
> > #endif          /* powerpc32 */
> >
> > #ifdef __s390x__ /* s390x */
> >@@ -820,7 +820,7 @@ unsigned long long vaddr_to_paddr_s390x(
> > #define get_machdep_info()	get_machdep_info_s390x()
> > #define get_versiondep_info()	TRUE
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		is_iomem_phys_addr(X)
> > #endif          /* s390x */
> >
> > #ifdef __ia64__ /* ia64 */
> >@@ -832,7 +832,7 @@ unsigned long long vaddr_to_paddr_ia64(u
> > #define get_versiondep_info()	TRUE
> > #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
> > #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
> >-#define is_vmalloc_addr(X)	TRUE
> >+#define is_phys_addr(X)		TRUE
> > #endif          /* ia64 */
> >
> > typedef unsigned long long mdf_pfn_t;
> >@@ -1567,6 +1567,7 @@ int read_disk_dump_header(struct disk_du
> > int read_kdump_sub_header(struct kdump_sub_header *kh, char *filename);
> > void close_vmcoreinfo(void);
> > int close_files_for_creating_dumpfile(void);
> >+int is_iomem_phys_addr(unsigned long addr);
> >
> >
> > /*
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
