Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XgXcN-0001lZ-8Y
 for kexec@lists.infradead.org; Tue, 21 Oct 2014 11:28:48 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 21 Oct 2014 12:28:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4F86D2190046
 for <kexec@lists.infradead.org>; Tue, 21 Oct 2014 12:27:57 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9LBSLoQ59179024
 for <kexec@lists.infradead.org>; Tue, 21 Oct 2014 11:28:21 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9LBSKwp008481
 for <kexec@lists.infradead.org>; Tue, 21 Oct 2014 05:28:20 -0600
Date: Tue, 21 Oct 2014 13:28:18 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile-1.5.7: Compile warnings on archs without
 get_versiondep_info()
Message-ID: <20141021132818.3731f6a2@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D57383@BPXM01GP.gisp.nec.co.jp>
References: <20140926101619.56f90824@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D57383@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, 21 Oct 2014 05:13:37 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Michael,
> 
> >I just noticed that makedumpfile-1.5.7 produces warnings
> >on s390x and probably all other archs that have not defined
> >get_versiondep_info():
> 
> Thanks for your reporting, does this patch help you ?

Hello Atsushi,

I had problems applying the patch but after manually adding
the changes I still get the following warning:


> 
> Thanks,
> Atsushi Kumagai
> 
> 
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Tue, 21 Oct 2014 11:11:46 +0900
> Subject: [PATCH] Introduce stub method for machine dependent parts.
> 
> Some machine dependent methods are implemented as the literal "1"
> since there is no need to do anything in their architectures.
> 
> It's polite to replace them into an empty method, this will solve
> some compile warnings.
> 
> Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
>  makedumpfile.h | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index a3342b5..5fda575 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -759,26 +759,27 @@ do { \
>  /*
>   * The function of dependence on machine
>   */
> +static inline int stub_true() { return TRUE; }
>  #ifdef __arm__
>  int get_phys_base_arm(void);
>  int get_machdep_info_arm(void);
>  unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
>  #define get_phys_base()		get_phys_base_arm()
>  #define get_machdep_info()	get_machdep_info_arm()
> -#define get_versiondep_info()	TRUE
> +#define get_versiondep_info()	stub_true()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif /* arm */
>  
>  #ifdef __x86__
>  int get_machdep_info_x86(void);
>  int get_versiondep_info_x86(void);
>  unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
> -#define get_phys_base()		TRUE
> +#define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_x86()
>  #define get_versiondep_info()	get_versiondep_info_x86()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> @@ -798,31 +799,31 @@ unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
>  int get_machdep_info_ppc64(void);
>  int get_versiondep_info_ppc64(void);
>  unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
> -#define get_phys_base()		TRUE
> +#define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_ppc64()
>  #define get_versiondep_info()	get_versiondep_info_ppc64()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif          /* powerpc64 */
>  
>  #ifdef __powerpc32__ /* powerpc32 */
>  int get_machdep_info_ppc(void);
>  unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
> -#define get_phys_base()		TRUE
> +#define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_ppc()
> -#define get_versiondep_info()	TRUE
> +#define get_versiondep_info()	stub_true()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif          /* powerpc32 */
>  
>  #ifdef __s390x__ /* s390x */
>  int get_machdep_info_s390x(void);
>  unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
> -#define get_phys_base()		TRUE
> +#define get_phys_base()		stub_true()
>  #define get_machdep_info()	get_machdep_info_s390x()
> -#define get_versiondep_info()	TRUE
> +#define get_versiondep_info()	stub_true()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif          /* s390x */
>  
>  #ifdef __ia64__ /* ia64 */
> @@ -831,10 +832,10 @@ int get_machdep_info_ia64(void);
>  unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
>  #define get_machdep_info()	get_machdep_info_ia64()
>  #define get_phys_base()		get_phys_base_ia64()
> -#define get_versiondep_info()	TRUE
> +#define get_versiondep_info()	stub_true()
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
>  #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	stub_true(X)
>  #endif          /* ia64 */
>  
>  typedef unsigned long long mdf_pfn_t;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
