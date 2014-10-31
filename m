Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xk4kG-0004ar-2M
 for kexec@lists.infradead.org; Fri, 31 Oct 2014 05:27:33 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: Enable --mem-usage for s390x
Date: Fri, 31 Oct 2014 05:25:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D639C8@BPXM01GP.gisp.nec.co.jp>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141016143753.726f63c0@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
 <20141023123007.282cb52e@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D63129@BPXM01GP.gisp.nec.co.jp>
 <20141030101446.2737beed@holzheu>
In-Reply-To: <20141030101446.2737beed@holzheu>
Content-Language: ja-JP
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
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

>Hello Atsushi,
>
>On Thu, 30 Oct 2014 01:29:18 +0000
>Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>
>[snip]
>
>> Now I don't plan to use is_iomem_phys_addr() for non s390x architectures,
>> I prefer putting is_iomem_phys_addr() into arch/s390x.c as Baoquan
>> commented before.
>>
>> Could you modify the patch ? or any questions ?
>
>I modified the patch and moved the is_iomem_phys_addr() function to
>s390x.c. I did not add __pa() because currently I don't see the
>need for it (?).

OK, but I'll add a memorandum in case we export this code to other
architectures like:

  int is_iomem_phys_addr_s390x(unsigned long addr)
  {
+         /* Implicit VtoP conversion will be performed for addr here. */
          struct addr_check addr_check = {addr, 0};

>The updated patch below applies on top of our "Compile warnings on
>archs without get_versiondep_info()" patch.

Thanks for your work, I'll merge it into v1.5.8.


Thanks,
Atsushi Kumagai

>Michael
>---
>[PATCH] makedumpfile: Enable --mem-usage for s390x
>
>Replace is_vmalloc_addr() by is_phys_addr() and implement is_phys_addr()
>on s390x using /proc/iommem parsing to enable the new makedumpfile
>option "--mem-usage".
>
>Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>---
> arch/s390x.c   |   26 ++++++++++++++++++++++++++
> elf_info.c     |    4 ++--
> makedumpfile.h |   20 +++++++++++++-------
> 3 files changed, 41 insertions(+), 9 deletions(-)
>
>--- a/arch/s390x.c
>+++ b/arch/s390x.c
>@@ -308,4 +308,30 @@ vaddr_to_paddr_s390x(unsigned long vaddr
> 	return paddr;
> }
>
>+struct addr_check {
>+	unsigned long addr;
>+	int found;
>+};
>+
>+static int phys_addr_callback(void *data, int nr, char *str,
>+			      unsigned long base, unsigned long length)
>+{
>+	struct addr_check *addr_check = data;
>+	unsigned long addr = addr_check->addr;
>+
>+	if (addr >= base && addr < base + length) {
>+		addr_check->found = 1;
>+		return -1;
>+	}
>+	return 0;
>+}
>+
>+int is_iomem_phys_addr_s390x(unsigned long addr)
>+{
>+	struct addr_check addr_check = {addr, 0};
>+
>+	iomem_for_each_line("System RAM\n", phys_addr_callback, &addr_check);
>+	return addr_check.found;
>+}
>+
> #endif /* __s390x__ */
>--- a/elf_info.c
>+++ b/elf_info.c
>@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
>
> 	for (i = 0; i < num_pt_loads; ++i) {
> 		struct pt_load_segment *p = &pt_loads[i];
>-		if (is_vmalloc_addr(p->virt_start))
>+		if (!is_phys_addr(p->virt_start))
> 			continue;
> 		loads++;
> 	}
>@@ -874,7 +874,7 @@ int get_kcore_dump_loads(void)
>
> 	for (i = 0, j = 0; i < num_pt_loads; ++i) {
> 		struct pt_load_segment *p = &pt_loads[i];
>-		if (is_vmalloc_addr(p->virt_start))
>+		if (!is_phys_addr(p->virt_start))
> 			continue;
> 		if (j >= loads)
> 			return FALSE;
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -767,7 +767,7 @@ unsigned long long vaddr_to_paddr_arm(un
> #define get_machdep_info()	get_machdep_info_arm()
> #define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
> #endif /* arm */
>
> #ifdef __x86__
>@@ -778,7 +778,7 @@ unsigned long long vaddr_to_paddr_x86(un
> #define get_machdep_info()	get_machdep_info_x86()
> #define get_versiondep_info()	get_versiondep_info_x86()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
> #endif /* x86 */
>
> #ifdef __x86_64__
>@@ -791,7 +791,7 @@ unsigned long long vaddr_to_paddr_x86_64
> #define get_machdep_info()	get_machdep_info_x86_64()
> #define get_versiondep_info()	get_versiondep_info_x86_64()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
>-#define is_vmalloc_addr(X)	is_vmalloc_addr_x86_64(X)
>+#define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X))
> #endif /* x86_64 */
>
> #ifdef __powerpc64__ /* powerpc64 */
>@@ -802,7 +802,7 @@ unsigned long long vaddr_to_paddr_ppc64(
> #define get_machdep_info()	get_machdep_info_ppc64()
> #define get_versiondep_info()	get_versiondep_info_ppc64()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
> #endif          /* powerpc64 */
>
> #ifdef __powerpc32__ /* powerpc32 */
>@@ -812,17 +812,18 @@ unsigned long long vaddr_to_paddr_ppc(un
> #define get_machdep_info()	get_machdep_info_ppc()
> #define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
> #endif          /* powerpc32 */
>
> #ifdef __s390x__ /* s390x */
> int get_machdep_info_s390x(void);
> unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
>+int is_iomem_phys_addr_s390x(unsigned long addr);
> #define get_phys_base()		stub_true()
> #define get_machdep_info()	get_machdep_info_s390x()
> #define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
> #endif          /* s390x */
>
> #ifdef __ia64__ /* ia64 */
>@@ -834,7 +835,7 @@ unsigned long long vaddr_to_paddr_ia64(u
> #define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
> #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
>-#define is_vmalloc_addr(X)	stub_true_ul(X)
>+#define is_phys_addr(X)		stub_true_ul(X)
> #endif          /* ia64 */
>
> typedef unsigned long long mdf_pfn_t;
>@@ -1569,6 +1570,11 @@ int read_disk_dump_header(struct disk_du
> int read_kdump_sub_header(struct kdump_sub_header *kh, char *filename);
> void close_vmcoreinfo(void);
> int close_files_for_creating_dumpfile(void);
>+int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
>+						     char *str,
>+						     unsigned long base,
>+						     unsigned long length),
>+			void *data);
>
>
> /*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
