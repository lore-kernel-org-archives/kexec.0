Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzjG6-0003pr-U1
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 08:08:21 +0000
Date: Thu, 18 Jul 2013 17:03:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 1/7] xen: Improve calculation of beginning of virtual
 address space
Message-Id: <20130718170308.7c7484cbf12b9b80ae973fcb@mxc.nes.nec.co.jp>
In-Reply-To: <1373977929-4253-2-git-send-email-daniel.kiper@oracle.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-2-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: daniel.kiper@oracle.com
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Tue, 16 Jul 2013 14:32:03 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> Xen commit 4b28bf6ae90bd83fd1113d8bdc53c3266ffeb328 (x86: re-introduce
> map_domain_page() et al) once again altered virtual address space.
> Current algorithm calculating its start could not cope with that change.
> New version establishes this value on the base of domain_list placement
> and is more generic.
> 
> Similar patch was applied to crash tool.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

OK, I'll merge this patch into v1.5.5.


Thanks
Atsushi Kumagai

> ---
>  arch/x86_64.c  |   16 +++++++++++-----
>  makedumpfile.h |    2 --
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index 8e61b20..d864a06 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -372,14 +372,20 @@ int get_xen_basic_info_x86_64(void)
>  		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
>  	}
>  
> +	info->xen_virt_start = SYMBOL(domain_list);
> +
> +	/*
> +	 * Xen virtual mapping is aligned to 1 GiB boundary.
> +	 * domain_list lives in bss which sits no more than
> +	 * 1 GiB below beginning of virtual address space.
> +	 */
> +	info->xen_virt_start &= 0xffffffffc0000000;
> +
>  	if (info->xen_crash_info.com &&
> -	    info->xen_crash_info.com->xen_major_version >= 4) {
> -		info->xen_virt_start = XEN_VIRT_START_V4;
> +	    info->xen_crash_info.com->xen_major_version >= 4)
>  		info->directmap_virt_end = DIRECTMAP_VIRT_END_V4;
> -	} else {
> -		info->xen_virt_start = XEN_VIRT_START_V3;
> +	else
>  		info->directmap_virt_end = DIRECTMAP_VIRT_END_V3;
> -	}
>  
>  	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
>  		ERRMSG("Can't get pml4.\n");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index a5826e0..1a87500 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1473,8 +1473,6 @@ int get_xen_info_x86(void);
>  #define DIRECTMAP_VIRT_END_V3 (0xffff840000000000)
>  #define DIRECTMAP_VIRT_END_V4 (0xffff880000000000)
>  #define DIRECTMAP_VIRT_END    (info->directmap_virt_end)
> -#define XEN_VIRT_START_V3     (0xffff828c80000000)
> -#define XEN_VIRT_START_V4     (0xffff82c480000000)
>  #define XEN_VIRT_START        (info->xen_virt_start)
>  #define XEN_VIRT_END          (XEN_VIRT_START + (1UL << 30))
>  #define FRAMETABLE_VIRT_START 0xffff82f600000000
> -- 
> 1.7.10.4

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
