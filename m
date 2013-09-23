Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VO6mH-0007Jb-OC
 for kexec@lists.infradead.org; Mon, 23 Sep 2013 14:06:18 +0000
Date: Mon, 23 Sep 2013 10:05:50 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 3/5] kexec/xen: use libxc to get location of
 crash notes
Message-ID: <20130923140550.GJ3175@phenom.dumpdata.com>
References: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
 <1379016042-22510-4-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379016042-22510-4-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Sep 12, 2013 at 09:00:40PM +0100, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Use xc_kexec_get_range(KEXEC_RANGE_MA_CPU) instead of parsing
> /proc/iomem (which is only populated by non-upstream ("classic") Xen
> kernels).
> 
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  kexec/crashdump-xen.c |   67 +++++++++++++++++++++++++++++-------------------
>  1 files changed, 40 insertions(+), 27 deletions(-)
> 
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index ff4706c..4a5cd8a 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -163,42 +163,55 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
>  	return machine;
>  }
>  
> -static int xen_crash_note_callback(void *UNUSED(data), int nr,
> -				   char *UNUSED(str),
> -				   unsigned long base,
> -				   unsigned long length)
> -{
> -	struct crash_note_info *note = xen_phys_notes + nr;
> -
> -	note->base = base;
> -	note->length = length;
> -
> -	return 0;
> -}
> -
> +#ifdef HAVE_LIBXENCTRL
>  int xen_get_nr_phys_cpus(void)
>  {
> -	char *match = "Crash note\n";
> -	int cpus, n;
> +	xc_interface *xc;
> +	int max_cpus;
> +	int cpu;
>  
>  	if (xen_phys_cpus)
>  		return xen_phys_cpus;
>  
> -	if ((cpus = kexec_iomem_for_each_line(match, NULL, NULL))) {
> -		n = sizeof(struct crash_note_info) * cpus;
> -		xen_phys_notes = malloc(n);
> -		if (!xen_phys_notes) {
> -			fprintf(stderr, "failed to allocate xen_phys_notes.\n");
> -			return -1;
> -		}
> -		memset(xen_phys_notes, 0, n);
> -		kexec_iomem_for_each_line(match,
> -					  xen_crash_note_callback, NULL);
> -		xen_phys_cpus = cpus;
> +	xc = xc_interface_open(NULL, NULL, 0);
> +	if (!xc) {
> +		fprintf(stderr, "failed to open xen control interface.\n");
> +		return -1;
> +	}
> +
> +	max_cpus = xc_get_max_cpus(xc);
> +	if (max_cpus <= 0)

Shouldn't you also call xc_interface_close ?

> +		return -1;
> +
> +	xen_phys_notes = calloc(max_cpus, sizeof(*xen_phys_notes));
> +	if (xen_phys_notes == NULL)
> +		return -1;

Ditto - call xc_interface_close?

> +
> +	for (cpu = 0; cpu < max_cpus; cpu++) {
> +		uint64_t size, start;
> +		int ret;
> +
> +		ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_CPU, cpu, &size, &start);
> +		if (ret < 0)
> +			break;
> +
> +		xen_phys_notes[cpu].base = start;
> +		xen_phys_notes[cpu].length = size;
>  	}
>  
> -	return cpus;
> +	xc_interface_close(xc);
> +
> +	xen_phys_cpus = cpu;
> +
> +	return cpu;
>  }
> +#else
> +int xen_get_nr_phys_cpus(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>  
>  int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
>  {
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
