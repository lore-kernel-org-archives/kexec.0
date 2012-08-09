Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzUvV-00029T-NT
 for kexec@lists.infradead.org; Thu, 09 Aug 2012 15:45:35 +0000
From: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
Date: Thu, 9 Aug 2012 17:45:21 +0200
Subject: RE: [PATCH 6/8] Handle Xen4 heap pages
Message-ID: <0E9227E8EFCFF54EA493F6C0399C015D3995EE8260@ABGEX70E.FSC.NET>
References: <20120723113244.751777873@suse.cz>
 <20120723113255.195911521@suse.cz>
In-Reply-To: <20120723113255.195911521@suse.cz>
Content-Language: de-DE
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr et al,

When trying out your patches I noticed that the size of
the produced file with xen and dom0 pages was larger
than when using my own patches. When adding counters
for the different page types to your patches it turned
out that the free pages and the xen heap pages were
not recognized. The reason seems to be that the count_info
variable in the Xen page_info structure is of size unsigned long
for Xen4. Yeah, it was already unsigned long for Xen3.4, but
before that it was unsigned int. And the Xen4 PGC_... symbols
seem to expect unsigned long variables. So the count_info
variable in exclude_xen_user_domain should be of size
unsigned long for Xen4 and so on, shouldn't it?

With kind regards
Norbert

> -----Original Message-----
> From: kexec-bounces@lists.infradead.org [mailto:kexec-bounces@lists.infra=
dead.org] On Behalf Of ptesarik@suse.cz
> Sent: Monday, July 23, 2012 1:33 PM
> To: kexec@lists.infradead.org
> Cc: Petr Tesarik
> Subject: [PATCH 6/8] Handle Xen4 heap pages
> =

> In Xen3, heap pages were allocated in a fixed range, so they could be
> recognized by their address. This is no longer the case with Xen4. Instea=
d, we
> have to look at the page flags and check if PGC_xen_heap is set.
> =

> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> =

> ---
>  arch/ia64.c    |   36 +++++++++++++++++-------------------
>  arch/x86_64.c  |   18 ++++++++----------
>  makedumpfile.c |    6 +++++-
>  makedumpfile.h |    1 +
>  4 files changed, 31 insertions(+), 30 deletions(-)
> =

> --- a/arch/ia64.c
> +++ b/arch/ia64.c
> @@ -335,26 +335,24 @@ get_xen_basic_info_ia64(void)
> =

>  	info->frame_table_vaddr =3D VIRT_FRAME_TABLE_ADDR; /* "frame_table" is =
same value */
> =

> -	if (SYMBOL(xenheap_phys_end) =3D=3D NOT_FOUND_SYMBOL) {
> -		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
> -		return FALSE;
> +	if (SYMBOL(xenheap_phys_end) !=3D NOT_FOUND_SYMBOL) {
> +		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
> +		      sizeof(xen_end))) {
> +			ERRMSG("Can't get the value of xenheap_phys_end.\n");
> +			return FALSE;
> +		}
> +		if (SYMBOL(xen_pstart) =3D=3D NOT_FOUND_SYMBOL) {
> +			ERRMSG("Can't get the symbol of xen_pstart.\n");
> +			return FALSE;
> +		}
> +		if (!readmem(VADDR_XEN, SYMBOL(xen_pstart), &xen_start,
> +		    sizeof(xen_start))) {
> +			ERRMSG("Can't get the value of xen_pstart.\n");
> +			return FALSE;
> +		}
> +		info->xen_heap_start =3D paddr_to_pfn(xen_start);
> +		info->xen_heap_end   =3D paddr_to_pfn(xen_end);
>  	}
> -	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
> -	      sizeof(xen_end))) {
> -		ERRMSG("Can't get the value of xenheap_phys_end.\n");
> -		return FALSE;
> -	}
> -	if (SYMBOL(xen_pstart) =3D=3D NOT_FOUND_SYMBOL) {
> -		ERRMSG("Can't get the symbol of xen_pstart.\n");
> -		return FALSE;
> -	}
> -	if (!readmem(VADDR_XEN, SYMBOL(xen_pstart), &xen_start,
> -	    sizeof(xen_start))) {
> -		ERRMSG("Can't get the value of xen_pstart.\n");
> -		return FALSE;
> -	}
> -	info->xen_heap_start =3D paddr_to_pfn(xen_start);
> -	info->xen_heap_end   =3D paddr_to_pfn(xen_end);
> =

>  	return TRUE;
>  }
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -385,17 +385,15 @@ int get_xen_basic_info_x86_64(void)
>  	}
>  	info->frame_table_vaddr =3D frame_table_vaddr;
> =

> -	if (SYMBOL(xenheap_phys_end) =3D=3D NOT_FOUND_SYMBOL) {
> -		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
> -		return FALSE;
> +	if (SYMBOL(xenheap_phys_end) !=3D NOT_FOUND_SYMBOL) {
> +		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
> +		    sizeof(xen_end))) {
> +			ERRMSG("Can't get the value of xenheap_phys_end.\n");
> +			return FALSE;
> +		}
> +		info->xen_heap_start =3D 0;
> +		info->xen_heap_end   =3D paddr_to_pfn(xen_end);
>  	}
> -	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
> -	    sizeof(xen_end))) {
> -		ERRMSG("Can't get the value of xenheap_phys_end.\n");
> -		return FALSE;
> -	}
> -	info->xen_heap_start =3D 0;
> -	info->xen_heap_end   =3D paddr_to_pfn(xen_end);
> =

>  	return TRUE;
>  }
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5715,7 +5715,11 @@ exclude_xen_user_domain(void)
>  			 */
>  			if (_domain =3D=3D 0)
>  				continue;
> -			if (info->xen_heap_start <=3D pfn && pfn < info->xen_heap_end)
> +			if (!info->xen_heap_end) {
> +				if (count_info & PGC_xen_heap)
> +					continue;
> +			} else if (info->xen_heap_start <=3D pfn &&
> +				   pfn < info->xen_heap_end)
>  				continue;
>  			if ((count_info & 0xffff) && is_select_domain(_domain))
>  				continue;
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -82,6 +82,7 @@ int get_mem_type(void);
>   */
>  #define PG_shift(idx)	(BITS_PER_LONG - (idx))
>  #define PG_mask(x, idx)	(x ## UL << PG_shift(idx))
> +#define PGC_xen_heap        PG_mask(1, 2)
> =

>  /*
>   * Memory flags
> =

> =

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Norbert Trapp
PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstra=DFe 28, D-80807 M=FCnchen, Germany
E-mail: Norbert.Trapp@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
Please be advised that neither Fujitsu, its affiliates, its employees or ag=
ents accept liability for any errors, omissions or damages caused by delays=
 of receipt or by any virus infection in this message or its attachments, o=
r which may otherwise arise as a result of this e-mail transmission.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
