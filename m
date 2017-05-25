Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDna3-000059-9W
 for kexec@lists.infradead.org; Thu, 25 May 2017 07:53:14 +0000
Received: by mail-pf0-f180.google.com with SMTP id n23so159893788pfb.2
 for <kexec@lists.infradead.org>; Thu, 25 May 2017 00:52:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] sadump: set info->page_size before cache_init()
References: <33710E6CAA200E4583255F4FB666C4E20D205BEE@G01JPEXMBYT03>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <b71ddf08-b21b-c75e-1028-2ea1fa3ceb28@redhat.com>
Date: Thu, 25 May 2017 13:22:43 +0530
MIME-Version: 1.0
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20D205BEE@G01JPEXMBYT03>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>, "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>



On Tuesday 23 May 2017 08:22 AM, Hatayama, Daisuke wrote:
> Currently, makedumpfile results in Segmentation fault on sadump dump
> files as follows:
>
>     # LANG=C makedumpfile -f --message-level=31 -ld31 -x vmlinux ./sadump_vmcore sadump_vmcore-ld31
>     sadump: read dump device as single partition
>     sadump: single partition configuration
>     page_size    : 4096
>     sadump: timezone information is missing
>     Segmentation fault
>
> By bisect, I found that this issue is caused by the following commit
> that moves invocation of cache_init() in initial() a bit early:
>
>     # git bisect bad
>     8e2834bac4f62da3894da297f083068431be6d80 is the first bad commit
>     commit 8e2834bac4f62da3894da297f083068431be6d80
>     Author: Pratyush Anand <panand@redhat.com>
>     Date:   Thu Mar 2 17:37:11 2017 +0900
>
>         [PATCH v3 2/7] initial(): call cache_init() a bit early
>
>         Call cache_init() before get_kcore_dump_loads(), because latter uses
>         cache_search().
>
>         Call path is like this :
>         get_kcore_dump_loads() -> process_dump_load() -> vaddr_to_paddr() ->
>         vtop4_x86_64() -> readmem() -> cache_search()
>
>         Signed-off-by: Pratyush Anand <panand@redhat.com>
>
>     :100644 100644 6942047199deb09dd1fff2121e264584dbb05587 3b8e9810468de26b0d8b73d456f0bd4f3d3aa2fe M      makedumpfile.c
>
> In this timing, on sadump vmcores, info->page_size has not been
> initialized yet so has 0. So, malloc() in cache_init() returns a chunk
> of 0 size. A bit later, info->page_size is initialized with 4096.
> Later processing on cache.c behaves assuming the chunk size is 8 *
> 4096. This destroys objects allocated after the chunk, resulting in
> the above Segmentation fault.
>
> To fix this issue, this commit moves setting info->page_size before
> cache_init().
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: Pratyush Anand <panand@redhat.com>

For 1/2
Reviewed-by: Pratyush Anand <panand@redhat.com>


> ---
>  makedumpfile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 301772a..f300b19 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3878,6 +3878,9 @@ initial(void)
>  	if (!get_value_for_old_linux())
>  		return FALSE;
>
> +	if (info->flag_sadump && !set_page_size(sadump_page_size()))
> +			return FALSE;
> +
>  	if (!is_xen_memory() && !cache_init())
>  		return FALSE;
>
> @@ -3906,9 +3909,6 @@ initial(void)
>  			return FALSE;
>  		}
>
> -		if (!set_page_size(sadump_page_size()))
> -			return FALSE;
> -
>  		if (!sadump_initialize_bitmap_memory())
>  			return FALSE;
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
