Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcrDi-0005Ry-5w
 for kexec@lists.infradead.org; Fri, 18 Sep 2015 08:40:39 +0000
Date: Fri, 18 Sep 2015 10:40:13 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] Load crash kernel high on x86
Message-ID: <20150918104013.6c3cc009@hananiah.suse.cz>
In-Reply-To: <20150918080324.69d7b9d5@hananiah.suse.cz>
References: <20150918080324.69d7b9d5@hananiah.suse.cz>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: Yinghai Lu <yinghai@kernel.org>

On Fri, 18 Sep 2015 08:03:24 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Hello,
> 
> There may be more than one crash kernel regions on x86. However, the kexec
> syscall checks that target address is within crashk_res boundaries. Looking
> at the logic in arch/x86/kernel/setup.c, there are only two possible layouts:
> 
>   1. crashk_res is below 4G, and there is only one region,
>   2. crashk_res is above 4G, and crashk_low_res is below 4G
> 
> In either case, kexec-tools must pick the highest region.
> 
> Currently, kexec-tools picks the largest region. If high reservation is
> smaller than low, kexec(2) returns -EADDRNOTAVAIL, and kexec prints out
> this error message:
> 
> kexec_load failed: Cannot assign requested address

I have just re-checked with kexec_file(2), and it is also affected. At
this point, you may think that it would be better to fix the check in
sanity_check_segment_list() instead.

I don't think so.

Low memory reservation is intended for swiotlb and DMA buffers, i.e. it
is somehow precious. The kernel can run above 4G, initrd can also be
located above 4G, so why should I place it in the _precious_ low memory?

If you agree, I'll also post a kernel patch for kexec_file(2).

Petr T

> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 63959b7..2710a9e 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -1034,16 +1034,8 @@ int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
>  	if (!crash_reserved_mem_nr)
>  		return -1;
>  
> -	for (i = crash_reserved_mem_nr - 1; i >= 0; i--) {
> -		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> -		if (sz <= sz_max)
> -			continue;
> -		sz_max = sz;
> -		idx = i;
> -	}
> -
> -	*start = crash_reserved_mem[idx].start;
> -	*end = crash_reserved_mem[idx].end;
> +	*start = crash_reserved_mem[crash_reserved_mem_nr - 1].start;
> +	*end = crash_reserved_mem[crash_reserved_mem_nr - 1].end;
>  
>  	return 0;
>  }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
