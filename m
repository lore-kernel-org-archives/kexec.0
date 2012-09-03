Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T8RIS-0005zT-8f
 for kexec@lists.infradead.org; Mon, 03 Sep 2012 07:42:14 +0000
Date: Mon, 3 Sep 2012 16:37:38 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 03/16] [PATCH v3 3/12] Change the function related to
 excluding unnecessary pages.
Message-Id: <20120903163738.729e012c56a4e23063214b47@mxc.nes.nec.co.jp>
In-Reply-To: <20120903.111335.108627870.d.hatayama@jp.fujitsu.com>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
 <20120830164701.b64acec40a0bc1bac9b3457e@mxc.nes.nec.co.jp>
 <20120903.111335.108627870.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Mon, 03 Sep 2012 11:13:35 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: [PATCH 03/16] [PATCH v3 3/12] Change the function related to excluding unnecessary pages.
> Date: Thu, 30 Aug 2012 16:47:01 +0900
> 
> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > Date: Thu, 23 Aug 2012 17:49:16 +0900
> > Subject: [PATCH 03/16] [PATCH v3 3/12] Change the function related to excluding unnecessary pages.
> <cut>
> > +int
> > +exclude_unnecessary_pages_cyclic(void)
> > +{
> > +	unsigned int mm;
> > +	struct mem_map_data *mmd;
> > +
> > +	/*
> > +	 * Copy 1st-bitmap to 2nd-bitmap.
> > +	 */
> > +	copy_bitmap_cyclic();
> > +
> > +	if (info->dump_level & DL_EXCLUDE_FREE)
> > +		if (!exclude_free_page())
> > +			return FALSE;
> > +
> > +	/*
> > +	 * Exclude cache pages, cache private pages, user data pages, and free pages.
> > +	 */
> > +	if (info->dump_level & DL_EXCLUDE_CACHE ||
> > +	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
> > +	    info->dump_level & DL_EXCLUDE_USER_DATA) {
> > +		for (mm = 0; mm < info->num_mem_map; mm++) {
> > +
> > +			mmd = &info->mem_map_data[mm];
> > +
> > +			if (mmd->mem_map == NOT_MEMMAP_ADDR)
> > +				continue;
> > +
> > +			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
> > +				if (!__exclude_unnecessary_pages(mmd->mem_map,
> > +								 mmd->pfn_start, mmd->pfn_end))
> > +					return FALSE;
> > +			}
> > +		}
> > +	}
> 
> This patch misses reporting the time consumed for excluding necessary
> pages. I noticed this during benchmarking. Here is the patch I used at
> the time, but I wrote this version over your patch set.
 
Thank you for pointing out my mistake.
I'll merge the fix below into [PATCH 03/16].


Thanks
Atsushi Kumagai

>     Report the time consumed for excluding unnecessary pages in cyclic mode
> 
>     Here is the example:
> 
>     [Before]
>     STEP [Excluding free pages       ] : 0.500269 seconds
>     STEP [Excluding free pages       ] : 0.002081 seconds
>     STEP [Copying data               ] : 2.115097 seconds
> 
>     [After]
> 
>     STEP [Excluding free pages       ] : 0.002148 seconds
>     STEP [Excluding unnecessary pages] : 0.015641 seconds
>     STEP [Excluding free pages       ] : 0.002130 seconds
>     STEP [Excluding unnecessary pages] : 0.024436 seconds
>     STEP [Copying data               ] : 0.211287 seconds
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 0a43181..caac37b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3882,6 +3882,7 @@ exclude_unnecessary_pages_cyclic(void)
>  {
>         unsigned int mm;
>         struct mem_map_data *mmd;
> +       struct timeval tv_start;
> 
>         /*
>          * Copy 1st-bitmap to 2nd-bitmap.
> @@ -3898,8 +3899,13 @@ exclude_unnecessary_pages_cyclic(void)
>         if (info->dump_level & DL_EXCLUDE_CACHE ||
>             info->dump_level & DL_EXCLUDE_CACHE_PRI ||
>             info->dump_level & DL_EXCLUDE_USER_DATA) {
> +
> +               gettimeofday(&tv_start, NULL);
> +
>                 for (mm = 0; mm < info->num_mem_map; mm++) {
> 
> +                       print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
> +
>                         mmd = &info->mem_map_data[mm];
> 
>                         if (mmd->mem_map == NOT_MEMMAP_ADDR)
> @@ -3911,6 +3917,12 @@ exclude_unnecessary_pages_cyclic(void)
>                                         return FALSE;
>                         }
>                 }
> +
> +               /*
> +                * print [100 %]
> +                */
> +               print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
> +               print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
>         }
> 
>         return TRUE;
> 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
