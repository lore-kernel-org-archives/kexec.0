Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from andromeda.dapyr.net ([206.212.254.10])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvLi0-0007Yc-Il
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 04:01:57 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/4] xen: Take into account Xen control interface changes
	since Xen Ver. 4.1
Date: Sun, 21 Aug 2011 23:56:50 -0400
References: <20110821135139.GB17323@router-fw-old.local.net-space.pl>
In-Reply-To: <20110821135139.GB17323@router-fw-old.local.net-space.pl>
MIME-Version: 1.0
Message-Id: <201108212356.50589.konrad.wilk@oracle.com>
Reply-To: konrad.wilk@oracle.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, vgoyal@redhat.com

> xc_interface_open() receive three arguments instead of void and returns
> pointer to xc_interface type instead of int since Xen Ver. 4.1. Take into
> account that and allow kexec-tools compilation with all versions of Xen.
> 
> Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
> ---
>  kexec/crashdump-xen.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index b347764..9dfabf8 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -126,19 +126,32 @@ unsigned long xen_architecture(struct crash_elf_info 
*elf_info)
>  {
>  	unsigned long machine = elf_info->machine;
>  #ifdef HAVE_LIBXENCTRL
> -	int xc, rc;
> +	int rc;
>  	xen_capabilities_info_t capabilities;
> +#ifdef XENCTRL_HAS_XC_INTERFACE
> +	xc_interface *xc;
> +#else
> +	int xc;
> +#endif

Where is the #endif for HAVE_LIBXENCTRL?

>  
>  	if (!xen_present())
>  		goto out;
>  
>  	memset(capabilities, '0', XEN_CAPABILITIES_INFO_LEN);
>  
> +#ifdef XENCTRL_HAS_XC_INTERFACE
> +	xc = xc_interface_open(NULL, NULL, 0);
> +	if ( !xc ) {
> +		fprintf(stderr, "failed to open xen control interface.\n");
> +		goto out;
> +	}
> +#else
>  	xc = xc_interface_open();
>  	if ( xc == -1 ) {
>  		fprintf(stderr, "failed to open xen control interface.\n");
>  		goto out;
>  	}
> +#endif
>  
>  	rc = xc_version(xc, XENVER_capabilities, &capabilities[0]);
>  	if ( rc == -1 ) {
> -- 
> 1.5.6.5
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
