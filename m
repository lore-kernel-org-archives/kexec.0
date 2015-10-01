Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhYG7-000491-Ev
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 07:26:32 +0000
Date: Thu, 1 Oct 2015 09:26:05 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v3] Load crash kernel high on x86
Message-ID: <20151001092605.04128db5@hananiah.suse.cz>
In-Reply-To: <20150924084852.7cc1dc86@hananiah.suse.cz>
References: <20150924084852.7cc1dc86@hananiah.suse.cz>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hello Simon,

what's up with this patch? Do you plan to apply it, or is there still
an issue?

Regards,
Petr Tesarik

On Thu, 24 Sep 2015 08:48:52 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> There may be more than one crash kernel regions on x86. Currently,
> kexec-tools picks the largest one. If high reservation is smaller
> than low, it will try to load panic kernel low. However, the kexec
> syscall checks that target address is within crashk_res boundaries,
> so attempts to load crash kernel low result in -EADDRNOTAVAIL, and
> kexec prints out this error message:
> 
> kexec_load failed: Cannot assign requested address
> 
> Looking at the logic in arch/x86/kernel/setup.c, there are only two
> possible layouts:
> 
>   1. crashk_res is below 4G, and there is only one region,
>   2. crashk_res is above 4G, and crashk_low_res is below 4G
> 
> In either case, kexec-tools must pick the highest region.
> 
> Changelog:
> 
>   * v3: rename function to get_crash_kernel_load_range
>   * v2: remove unnecessary local variables
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> 
> ---
>  kexec/arch/i386/crashdump-x86.c    | 21 +++++++--------------
>  kexec/arch/i386/kexec-x86-common.c |  4 ++--
>  kexec/kexec.h                      |  2 +-
>  3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 63959b7..d4969c5 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -1026,24 +1026,17 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	return 0;
>  }
>  
> -int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
> +/* On x86, the kernel may make a low reservation in addition to the
> + * normal reservation. However, the kernel refuses to load the panic
> + * kernel to low memory, so always choose the highest range.
> + */
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
>  {
> -	int i, idx = -1;
> -	unsigned long sz_max = 0, sz;
> -
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
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index 041c8ec..484d712 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -371,9 +371,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  	    !(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
>  		uint64_t start, end;
>  
> -		ret = get_max_crash_kernel_limit(&start, &end);
> +		ret = get_crash_kernel_load_range(&start, &end);
>  		if (ret != 0) {
> -			fprintf(stderr, "get_max_crash_kernel_limit failed.\n");
> +			fprintf(stderr, "get_crash_kernel_load_range failed.\n");
>  			return -1;
>  		}
>  
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 0fa977f..7c97b25 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -288,7 +288,7 @@ int arch_process_options(int argc, char **argv);
>  int arch_compat_trampoline(struct kexec_info *info);
>  void arch_update_purgatory(struct kexec_info *info);
>  int is_crashkernel_mem_reserved(void);
> -int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end);
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
>  char *get_command_line(void);
>  
>  int kexec_iomem_for_each_line(char *match,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
