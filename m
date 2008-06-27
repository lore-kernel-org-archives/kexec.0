Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KC2SZ-0000Jp-5P
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 01:09:07 +0000
Message-Id: <48643DAF.7080803@mxs.nes.nec.co.jp>
Date: Fri, 27 Jun 2008 10:09:03 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Fix compile warning
References: <20080626130911.GA29225@suse.de>
In-Reply-To: <20080626130911.GA29225@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1206831711=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============1206831711==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the patch.
I will apply the patch to the next release.


Thanks
Ken'ichi Ohmichi

Bernhard Walle wrote:
> This patch fixes following compile warning:
> 
>     makedumpfile.c: In function ‘readmem’:
>     makedumpfile.c:207: warning: call to function \
>             ‘vaddr_to_offset_x86_64’ without a real prototype
>     makedumpfile.h:603: note: ‘vaddr_to_offset_x86_64’ was declared here
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |    4 ++++
>  makedumpfile.h |   16 ++++++++--------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -30,6 +30,10 @@ struct DumpInfo		*info = NULL;
>  int message_level;
>  
>  /*
> + * Forward declarations
> + */
> +
> +/*
>   * The numbers of the excluded pages
>   */
>  unsigned long long pfn_zero;
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -591,32 +591,32 @@ do { \
>   * The function of dependence on machine
>   */
>  #ifdef __x86__
> -int get_machdep_info_x86();
> +int get_machdep_info_x86(void);
>  #define get_phys_base(X)	TRUE
>  #define get_machdep_info(X)	get_machdep_info_x86(X)
>  #define vaddr_to_offset(X)	vaddr_to_offset_general(X)
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> -int get_phys_base_x86_64();
> -int get_machdep_info_x86_64();
> -off_t vaddr_to_offset_x86_64();
> +int get_phys_base_x86_64(void);
> +int get_machdep_info_x86_64(void);
> +off_t vaddr_to_offset_x86_64(unsigned long vaddr);
>  #define get_phys_base(X)	get_phys_base_x86_64(X)
>  #define get_machdep_info(X)	get_machdep_info_x86_64(X)
>  #define vaddr_to_offset(X)	vaddr_to_offset_x86_64(X)
>  #endif /* x86_64 */
>  
>  #ifdef __powerpc__ /* powerpc */
> -int get_machdep_info_ppc64();
> +int get_machdep_info_ppc64(void);
>  #define get_machdep_info(X)	get_machdep_info_ppc64(X)
>  #define get_phys_base(X)	TRUE
>  #define vaddr_to_offset(X)	vaddr_to_offset_general(X)
>  #endif          /* powerpc */
>  
>  #ifdef __ia64__ /* ia64 */
> -int get_phys_base_ia64();
> -int get_machdep_info_ia64();
> -off_t vaddr_to_offset_ia64();
> +int get_phys_base_ia64(void);
> +int get_machdep_info_ia64(void);
> +off_t vaddr_to_offset_ia64(unsigned long vaddr);
>  #define get_machdep_info(X)	get_machdep_info_ia64(X)
>  #define get_phys_base(X)	get_phys_base_ia64(X)
>  #define vaddr_to_offset(X)	vaddr_to_offset_ia64(X)
> 




--===============1206831711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1206831711==--
