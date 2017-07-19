Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dXn2T-0005hQ-Vn
 for kexec@lists.infradead.org; Wed, 19 Jul 2017 11:21:11 +0000
Received: by mail-pg0-f50.google.com with SMTP id s4so727647pgr.5
 for <kexec@lists.infradead.org>; Wed, 19 Jul 2017 04:20:48 -0700 (PDT)
Subject: Re: [Makedumpfile Patch v3 2/7] initial(): call cach_init() a bit
 early
References: <cover.1488443170.git.panand@redhat.com>
 <5121b3b3857e3f5710195b4983d7261549ef7fac.1488443170.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF24AA@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <1d801fe9-bc5e-3783-1dca-40a47ddeccc9@redhat.com>
Date: Wed, 19 Jul 2017 16:50:42 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EF24AA@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "HATAYAMA Daisuke (d.hatayama@jp.fujitsu.com)" <d.hatayama@jp.fujitsu.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

Hi Atsushi,

On Wednesday 19 July 2017 01:16 PM, Atsushi Kumagai wrote:
> Hello Pratyush,
>
>> Call cach_init() before get_kcore_dump_loads(), because latter uses
>> cache_search().
>>
>> Call path is like this :
>> get_kcore_dump_loads() -> process_dump_load() -> vaddr_to_paddr() ->
>> vtop4_x86_64() -> readmem() -> cache_search()
>
> I found that the current cach_init() is too early, cache_init() should be
> called after fallback_to_current_page_size() for older kernel
> which doesn't have VMCOREINFO.
> Could you confirm that the patch below is fine with you ?

Its fine and works.

>
> Thanks,
> Atsushi Kumagai
>
> From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
> Date: Wed, 19 Jul 2017 15:05:58 +0900
> Subject: [PATCH] Fix the regression caused by moving cache_init() earlier
>
> info->page_size should be set before calling cache_init() since it
> allocates some buffers based on info->page_size. However, cache_init()
> was moved before fallback_to_current_page_size() while it set
> info->page_size for older kernel which doesn't have VMCOREINFO.
>
> This patch moves cache_init() after fallback_to_current_page_size()
> and reverts the commit: b98e6e0d2a(sadump: set info->page_size before cache_init())
>
> Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
> ---
>  makedumpfile.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a3f0697..f85003a 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3905,15 +3905,6 @@ initial(void)
>  	if (!get_value_for_old_linux())
>  		return FALSE;
>
> -	if (info->flag_sadump && !set_page_size(sadump_page_size()))
> -			return FALSE;
> -
> -	if (!is_xen_memory() && !cache_init())
> -		return FALSE;
> -
> -	if (info->flag_mem_usage && !get_kcore_dump_loads())
> -		return FALSE;
> -
>  	if (info->flag_refiltering) {
>  		if (info->flag_elf_dumpfile) {
>  			MSG("'-E' option is disable, ");
> @@ -3936,6 +3927,9 @@ initial(void)
>  			return FALSE;
>  		}
>
> +		if (!set_page_size(sadump_page_size()))
> +			return FALSE;
> +
>  		if (!sadump_initialize_bitmap_memory())
>  			return FALSE;
>
> @@ -3949,9 +3943,7 @@ initial(void)
>  		 * postponed until debug information becomes
>  		 * available.
>  		 */
> -
> -	} else if (!get_phys_base())
> -		return FALSE;
> +	}
>
>  out:
>  	if (!info->page_size) {
> @@ -3962,6 +3954,18 @@ out:
>  		if (!fallback_to_current_page_size())
>  			return FALSE;
>  	}
> +
> +	if (!is_xen_memory() && !cache_init())
> +		return FALSE;
> +
> +	if (info->flag_mem_usage && !get_kcore_dump_loads())
> +		return FALSE;
> +
> +	if (!info->flag_refiltering && !info->flag_sadump) {
> +		if (!get_phys_base())
> +			return FALSE;
> +	}
> +
>  	if (!get_max_mapnr())
>  		return FALSE;
>
>

-- 
Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
