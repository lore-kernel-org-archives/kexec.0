Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZWOP-0000Oj-Qs
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 02:13:06 +0000
Date: Mon, 14 Apr 2014 11:12:42 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND v5 03/10] x86, cleanup: add other types of memory
 range for 2nd kernel boot to memmap_p
Message-ID: <20140414021242.GJ22411@verge.net.au>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-4-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397183011-1526-4-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On Fri, Apr 11, 2014 at 10:23:24AM +0800, WANG Chao wrote:
> Now memmap_p contains all the memory range for 2nd kernel boot.

Could you please include a fuller explanation of what this patch
achieves and the motivation for it.

> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index e695eaf..43eb8f7 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -1006,12 +1006,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  
>  	/* Inform second kernel about the presence of ACPI tables. */
>  	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
> -		unsigned long start, end;
> +		unsigned long start, end, size, type;
>  		if ( !( mem_range[i].type == RANGE_ACPI
>  			|| mem_range[i].type == RANGE_ACPI_NVS) )
>  			continue;
>  		start = mem_range[i].start;
>  		end = mem_range[i].end;
> +		type = mem_range[i].type;
> +		size = end - start;
> +		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
>  		cmdline_add_memmap_acpi(mod_cmdline, start, end);
>  	}
>  	return 0;
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
