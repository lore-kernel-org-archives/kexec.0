Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hub021-nj-2.exch021.serverdata.net ([206.225.164.217])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1UAKyi-0004z2-2D
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 13:53:56 +0000
Message-ID: <512CBE70.2000902@CloudSwitch.com>
Date: Tue, 26 Feb 2013 08:53:52 -0500
From: Don Slutz <Don@CloudSwitch.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/4] kexec/xen: use libxc to get location
 of crash notes
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
 <1361469460-18771-4-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361469460-18771-4-git-send-email-david.vrabel@citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On 02/21/13 12:57, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Use xc_kexec_get_range(KEXEC_RANGE_MA_CPU) instead of parsing
> /proc/iomem (which is only populated by non-upstream ("classic") Xen
> kernels).
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>   kexec/crashdump-xen.c |   61 ++++++++++++++++++++++++++++---------------------
>   1 files changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index ff4706c..13335a5 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -163,42 +163,51 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
>   	return machine;
>   }
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
>   int xen_get_nr_phys_cpus(void)
>   {
> -	char *match = "Crash note\n";
> -	int cpus, n;
> +	xc_interface *xc;
> +	int cpu;
>   
>   	if (xen_phys_cpus)
>   		return xen_phys_cpus;
>   
> -	if ((cpus = kexec_iomem_for_each_line(match, NULL, NULL))) {
> -		n = sizeof(struct crash_note_info) * cpus;
> -		xen_phys_notes = malloc(n);
> -		if (!xen_phys_notes) {
> -			fprintf(stderr, "failed to allocate xen_phys_notes.\n");
> +	xc = xc_interface_open(NULL, NULL, 0);
> +	if ( !xc ) {
> +		fprintf(stderr, "failed to open xen control interface.\n");
> +		return -1;
> +	}
> +
> +	for (cpu = 0;; cpu++) {
This code does work.  Not sure why you did not use xc_physinfo() to get 
the number of cpus that there is data for and remove the need for 
calling realloc.
> +		uint64_t size, start;
> +		int ret;
> +
> +		ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_CPU, cpu, &size, &start);
> +		if (ret < 0)
> +			break;
> +
> +		xen_phys_notes = realloc(xen_phys_notes,
> +					 sizeof(*xen_phys_notes) * (cpu + 1));
> +		if (xen_phys_notes == NULL)
>   			return -1;
> -		}
> -		memset(xen_phys_notes, 0, n);
> -		kexec_iomem_for_each_line(match,
> -					  xen_crash_note_callback, NULL);
> -		xen_phys_cpus = cpus;
> +
> +		xen_phys_notes[cpu].base = start;
> +		xen_phys_notes[cpu].length = size;
>   	}
>   
> -	return cpus;
> +	xc_interface_close(xc);
> +
> +	xen_phys_cpus = cpu;
> +
> +	return cpu;
>   }
> +#else
> +int xen_get_nr_phys_cpus(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>   
>   int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
>   {
    -Don Slutz

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
