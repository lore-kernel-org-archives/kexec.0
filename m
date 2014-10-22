Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xgk37-0007El-MP
 for kexec@lists.infradead.org; Wed, 22 Oct 2014 00:45:15 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile-1.5.7: Compile warnings on archs without
 get_versiondep_info()
Date: Wed, 22 Oct 2014 00:43:59 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D5771C@BPXM01GP.gisp.nec.co.jp>
References: <20140926101619.56f90824@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D57383@BPXM01GP.gisp.nec.co.jp>
 <20141021133533.039f3243@holzheu>
In-Reply-To: <20141021133533.039f3243@holzheu>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Tue, 21 Oct 2014 05:13:37 +0000
>Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>
>> Hello Michael,
>>
>> >I just noticed that makedumpfile-1.5.7 produces warnings
>> >on s390x and probably all other archs that have not defined
>> >get_versiondep_info():
>>
>> Thanks for your reporting, does this patch help you ?
>
>Hello Atsushi,
>
>Sorry, the first note was sent by accident...
>
>I had problems applying the patch but after manually adding
>the changes I still get the following warning:
>
>elf_info.c: In function 'get_kcore_dump_loads':
>elf_info.c:855:27: warning: unused variable 'p' [-Wunused-variable]
>   struct pt_load_segment *p = &pt_loads[i];
>
>What about the following patch:

Good fix! I'll merge this into v1.5.8.


Thanks,
Atsushi Kumagai


>---
> makedumpfile.h |   30 ++++++++++++++++--------------
> 1 file changed, 16 insertions(+), 14 deletions(-)
>
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -759,26 +759,28 @@ do { \
> /*
>  * The function of dependence on machine
>  */
>+static inline int stub_true() { return TRUE; }
>+static inline int stub_true_ul(unsigned long x) { return TRUE; }
> #ifdef __arm__
> int get_phys_base_arm(void);
> int get_machdep_info_arm(void);
> unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
> #define get_phys_base()		get_phys_base_arm()
> #define get_machdep_info()	get_machdep_info_arm()
>-#define get_versiondep_info()	TRUE
>+#define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif /* arm */
>
> #ifdef __x86__
> int get_machdep_info_x86(void);
> int get_versiondep_info_x86(void);
> unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
>-#define get_phys_base()		TRUE
>+#define get_phys_base()		stub_true()
> #define get_machdep_info()	get_machdep_info_x86()
> #define get_versiondep_info()	get_versiondep_info_x86()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif /* x86 */
>
> #ifdef __x86_64__
>@@ -798,31 +800,31 @@ unsigned long long vaddr_to_paddr_x86_64
> int get_machdep_info_ppc64(void);
> int get_versiondep_info_ppc64(void);
> unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
>-#define get_phys_base()		TRUE
>+#define get_phys_base()		stub_true()
> #define get_machdep_info()	get_machdep_info_ppc64()
> #define get_versiondep_info()	get_versiondep_info_ppc64()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif          /* powerpc64 */
>
> #ifdef __powerpc32__ /* powerpc32 */
> int get_machdep_info_ppc(void);
> unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>-#define get_phys_base()		TRUE
>+#define get_phys_base()		stub_true()
> #define get_machdep_info()	get_machdep_info_ppc()
>-#define get_versiondep_info()	TRUE
>+#define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif          /* powerpc32 */
>
> #ifdef __s390x__ /* s390x */
> int get_machdep_info_s390x(void);
> unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
>-#define get_phys_base()		TRUE
>+#define get_phys_base()		stub_true()
> #define get_machdep_info()	get_machdep_info_s390x()
>-#define get_versiondep_info()	TRUE
>+#define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif          /* s390x */
>
> #ifdef __ia64__ /* ia64 */
>@@ -831,10 +833,10 @@ int get_machdep_info_ia64(void);
> unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
> #define get_machdep_info()	get_machdep_info_ia64()
> #define get_phys_base()		get_phys_base_ia64()
>-#define get_versiondep_info()	TRUE
>+#define get_versiondep_info()	stub_true()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
> #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
>-#define is_vmalloc_addr(X)	TRUE
>+#define is_vmalloc_addr(X)	stub_true_ul(X)
> #endif          /* ia64 */
>
> typedef unsigned long long mdf_pfn_t;
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
