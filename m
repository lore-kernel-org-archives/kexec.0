Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XP6k5-00051B-Eq
 for kexec@lists.infradead.org; Wed, 03 Sep 2014 09:20:41 +0000
Date: Wed, 3 Sep 2014 17:20:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] message printing cleanup for option --mem-usage
Message-ID: <20140903092014.GG31855@dhcp-16-116.nay.redhat.com>
References: <1409735588-2430-1-git-send-email-bhe@redhat.com>
 <1409735588-2430-2-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409735588-2430-2-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, vgoyal@redhat.com

Hi,

So the output is like below now:

~$ ./makedumpfile --mem-usage /proc/kcore 
The kernel version is not supported.
The makedumpfile operation may be incomplete.

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		28247           	yes		Pages filled
with zero
CACHE		240114          	yes		Cache pages
CACHE_PRIVATE	17902           	yes		Cache pages +
private
USER		19713           	yes		User process
pages
FREE		3639969         	yes		Free pages
KERN_DATA	103723          	no		Dumpable kernel
data 

page size:		4096            
Total pages on system:	4049668

That warning won't occur on kernel which makedumpfile declares to
support,  Just notice user the kernel they are using is not tested
yet on compatibility. So it should not be a problem.

Thanks
Baoquan


On 09/03/14 at 05:13pm, Baoquan He wrote:
> Adjust the message printing when specify option --mem-usage. Try to
> avoid the unrelated printing.
> 
> And add the page size info.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  makedumpfile.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index c965745..f804079 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4939,7 +4939,8 @@ exclude_unnecessary_pages_cyclic(struct cycle *cycle)
>  
>  		for (mm = 0; mm < info->num_mem_map; mm++) {
>  
> -			print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
> +			if (!info->flag_mem_usage)
> +				print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
>  
>  			mmd = &info->mem_map_data[mm];
>  
> @@ -4957,8 +4958,10 @@ exclude_unnecessary_pages_cyclic(struct cycle *cycle)
>  		/*
>  		 * print [100 %]
>  		 */
> -		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
> -		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
> +		if (!info->flag_mem_usage) {
> +			print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
> +			print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
> +		}
>  	}
>  
>  	return TRUE;
> @@ -7960,9 +7963,8 @@ print_mem_usage(void)
>  	shrinking = shrinking / pfn_original;
>  
>  	MSG("\n");
> -	MSG("\n");
> -	MSG("----------------------------------------------------------------------\n");
>  	MSG("TYPE		PAGES			EXCLUDABLE	DESCRIPTION\n");
> +	MSG("----------------------------------------------------------------------\n");
>  
>  	MSG("ZERO		%-16llu	yes		Pages filled with zero\n", pfn_zero);
>  	MSG("CACHE		%-16llu	yes		Cache pages\n", pfn_cache);
> @@ -7975,6 +7977,7 @@ print_mem_usage(void)
>  
>  	MSG("\n");
>  
> +	MSG("page size:		%-16ld\n", info->page_size);
>  	MSG("Total pages on system:	%-16llu\n", pfn_original);
>  }
>  
> @@ -9614,10 +9617,10 @@ main(int argc, char *argv[])
>  	retcd = COMPLETED;
>  out:
>  	MSG("\n");
> -	if (retcd == COMPLETED)
> -		MSG("makedumpfile Completed.\n");
> -	else
> +	if (retcd != COMPLETED)
>  		MSG("makedumpfile Failed.\n");
> +	else if (!info->flag_mem_usage)
> +		MSG("makedumpfile Completed.\n");
>  
>  	if (info) {
>  		if (info->dh_memory)
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
