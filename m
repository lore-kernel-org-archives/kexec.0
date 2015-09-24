Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZexEW-0001OQ-Ck
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 03:30:08 +0000
Date: Thu, 24 Sep 2015 11:29:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] Load crash kernel high on x86
Message-ID: <20150924032942.GC6217@dhcp-128-28.nay.redhat.com>
References: <20150923065655.3ecd3c1b@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150923065655.3ecd3c1b@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 09/23/15 at 06:56am, Petr Tesarik wrote:
>  kexec/arch/i386/crashdump-x86.c    | 21 +++++++--------------
>  kexec/arch/i386/kexec-x86-common.c |  4 ++--
>  kexec/kexec.h                      |  2 +-
>  3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 63959b7..9d866cc 100644
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
> +int get_crash_kernel_range(uint64_t *start, uint64_t *end)

How about get_crash_kernel_load_range? In kernel crashk_res and
crashk_low_res are all named as "Crash kernel", but only crashk_res is
used to load kernel/initrd stuffs.

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
> index 041c8ec..620c02d 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -371,9 +371,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  	    !(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
>  		uint64_t start, end;
>  
> -		ret = get_max_crash_kernel_limit(&start, &end);
> +		ret = get_crash_kernel_range(&start, &end);
>  		if (ret != 0) {
> -			fprintf(stderr, "get_max_crash_kernel_limit failed.\n");
> +			fprintf(stderr, "get_crash_kernel_range failed.\n");
>  			return -1;
>  		}
>  
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 0fa977f..5577d84 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -288,7 +288,7 @@ int arch_process_options(int argc, char **argv);
>  int arch_compat_trampoline(struct kexec_info *info);
>  void arch_update_purgatory(struct kexec_info *info);
>  int is_crashkernel_mem_reserved(void);
> -int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end);
> +int get_crash_kernel_range(uint64_t *start, uint64_t *end);
>  char *get_command_line(void);
>  
>  int kexec_iomem_for_each_line(char *match,
> -- 
> 2.1.4
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
