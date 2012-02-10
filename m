Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RvnvJ-0001Jw-Oq
 for kexec@lists.infradead.org; Fri, 10 Feb 2012 10:41:53 +0000
Date: Fri, 10 Feb 2012 18:44:29 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 2/3][makedumpfile][ppc64] Rename the __powerpc__
 macro to __powerpc64__ for PPC64
Message-Id: <20120210184429.534aa570.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120118100921.29422.90156.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
 <20120118100921.29422.90156.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp

Hi, Suzuki

On Wed, 18 Jan 2012 15:39:44 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> Makedumpfile uses __powerpc__ as the value of ARCH to control the PPC64
> specfic definitions. Rename this to __powerpc64__ for a better readability
> of the code as the support for ppc32 will be introduced in the later series.
> We could use __powerpc32__ for PPC32.
> 
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> ---
> 
>  Makefile       |    5 +++--
>  makedumpfile.c |    2 +-
>  makedumpfile.h |   10 +++++-----
>  3 files changed, 9 insertions(+), 8 deletions(-)

I will make small changes to your patch:

--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -18,7 +18,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */

-#ifdef __powerpc__
+#ifdef __powerpc64__

 #include "../print_info.h"
 #include "../elf_info.h"
@@ -93,4 +93,4 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
        return NOT_PADDR;
 }

-#endif /* powerpc */
+#endif /* powerpc64 */


The other parts looks good.
I will merge this patch to makedumpfile-1.4.3.

Thanks
Atsushi Kumagai


> diff --git a/Makefile b/Makefile
> index 174a0d9..04e267f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -24,11 +24,12 @@ endif
>  ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>  			       -e s/arm.*/arm/ -e s/sa110/arm/ \
>  			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
> -			       -e s/ppc64/powerpc/ )
> +			       -e s/ppc64/powerpc64/ )
> +
>  CFLAGS += -D__$(ARCH)__
>  CFLAGS_ARCH += -D__$(ARCH)__
>  
> -ifeq ($(ARCH), powerpc)
> +ifeq ($(ARCH), powerpc64)
>  CFLAGS += -m64
>  CFLAGS_ARCH += -m64
>  endif
> diff --git a/makedumpfile.c b/makedumpfile.c
> index c51fda3..101f8b5 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5691,7 +5691,7 @@ initial_xen(void)
>  	off_t offset;
>  	unsigned long size;
>  
> -#ifdef __powerpc__
> +#ifdef __powerpc64__
>  	MSG("\n");
>  	MSG("ppc64 xen is not supported.\n");
>  	return FALSE;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 4b4a58b..efa325f 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -521,7 +521,7 @@ do { \
>  
>  #endif /* x86_64 */
>  
> -#ifdef __powerpc__
> +#ifdef __powerpc64__
>  #define __PAGE_OFFSET		(0xc000000000000000)
>  #define KERNELBASE		PAGE_OFFSET
>  #define VMALLOCBASE     	(0xD000000000000000)
> @@ -658,14 +658,14 @@ unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
>  #endif /* x86_64 */
>  
> -#ifdef __powerpc__ /* powerpc */
> +#ifdef __powerpc64__ /* powerpc64 */
>  int get_machdep_info_ppc64(void);
>  unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
>  #define get_phys_base()		TRUE
>  #define get_machdep_info()	get_machdep_info_ppc64()
>  #define get_versiondep_info()	TRUE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
> -#endif          /* powerpc */
> +#endif          /* powerpc64 */
>  
>  #ifdef __s390x__ /* s390x */
>  int get_machdep_info_s390x(void);
> @@ -1332,10 +1332,10 @@ int get_xen_info_ia64(void);
>  
>  #endif	/* __ia64 */
>  
> -#ifdef __powerpc__ /* powerpc */
> +#ifdef __powerpc64__ /* powerpc64 */
>  #define kvtop_xen(X)	FALSE
>  #define get_xen_info_arch(X) FALSE
> -#endif	/* powerpc */
> +#endif	/* powerpc64 */
>  
>  #ifdef __s390x__ /* s390x */
>  #define kvtop_xen(X)	FALSE
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
