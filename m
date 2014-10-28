Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj1RO-00071R-K4
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 07:43:43 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E5DBB3EE0B6
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 16:43:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 24718AC0238
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 16:43:19 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AD4ABE08002
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 16:43:18 +0900 (JST)
Date: Tue, 28 Oct 2014 16:43:12 +0900 (JST)
Message-Id: <20141028.164312.91790949.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 4/5] Add module of calculating start_pfn and end_pfn
 in each dumpfile
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1413192866-28140-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1413192866-28140-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhouwj-fnst@cn.fujitsu.com
Cc: kexec@lists.infradead.org

From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2 4/5] Add module of calculating start_pfn and end_pfn in each dumpfile
Date: Mon, 13 Oct 2014 17:34:25 +0800

> When --split is specified in cyclic mode, start_pfn and end_pfn of each dumpfile
> will be calculated to make each dumpfile have the same size.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Please remove this Signed-off-by.

> Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a6f0be4..32c0919 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8190,6 +8190,103 @@ out:
>  		return ret;
>  }
>  
> +/*
> + * calculate end pfn in incomplete splitblock or memory not managed by splitblock
> + */
> +mdf_pfn_t
> +calculate_end_pfn_in_cycle(mdf_pfn_t start, mdf_pfn_t max,
> +			    mdf_pfn_t end_pfn, long long pfn_needed_by_per_dumpfile)
> +{
> +	struct cycle cycle;

Please add a line.

> +	for_each_cycle(start,max,&cycle) {
> +		if (!exclude_unnecessary_pages_cyclic(&cycle))
> +			return FALSE;
> +		while (end_pfn < cycle.end_pfn) {
> +			end_pfn++;
> +			if (is_dumpable_cyclic(info->partial_bitmap2, end_pfn, &cycle)){

This line exceeds 80 columns. It would be enough to add linebreaks in
each argument posision.

			if (is_dumpable_cyclic(info->partial_bitmap2,
                                               end_pfn,
                                               &cycle)) {

> +				if (--pfn_needed_by_per_dumpfile <= 0)
> +					return ++end_pfn;

				pfn_needed_by_per_dumpfile--;
				if (pfn_needed_by_per_dumpfile <= 0) {
					end_pfn++;
					return end_pfn;
				}


> +			}
> +		}
> +	}
> +	return ++end_pfn;
> +}
> +
> +/*
> + * calculate end_pfn of one dumpfile.
> + * try to make every output file have the same size.
> + * splitblock_table is used to reduce calculate time.
> + */
> +
> +#define CURRENT_SPLITBLOCK_PFN_NUM (*current_splitblock * splitblock->page_per_splitblock)
> +mdf_pfn_t
> +calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
> +			   int *current_splitblock,
> +			   long long *current_splitblock_pfns){

			   long long *current_splitblock_pfns)
{

> +	mdf_pfn_t end_pfn;
> +	long long pfn_needed_by_per_dumpfile,offset;

Please add a space:

	long long pfn_needed_by_per_dumpfile, offset;

Also, some variable names are too long: current_splitblock,
current_splitblock_pfns and pfn_needed_by_per_dumpfile.

From current_splitblock, I imagine a SplitBlock object, but this is in
fact an inter representing an index of splitblocks.

For current_splitblock_pfns, is this really neccesary? Please see a
comment that will occur in later part.

> +	pfn_needed_by_per_dumpfile = info->num_dumpable / info->num_dumpfile;
> +	offset = *current_splitblock * splitblock->entry_size;
> +	end_pfn = start_pfn;

This is not a declaration. Please move downwards.

> +	char *splitblock_inner = splitblock->table + offset;

Please add a line.

> +	//calculate the part containing complete splitblock

Please use /* */ style.

> +	while (*current_splitblock < splitblock->num && pfn_needed_by_per_dumpfile > 0) {
> +		if (*current_splitblock_pfns > 0) {
> +			pfn_needed_by_per_dumpfile -= *current_splitblock_pfns ;
> +			*current_splitblock_pfns = 0 ;
> +		}
> +		else
> +		pfn_needed_by_per_dumpfile -= read_value_from_splitblock_table(splitblock_inner);

Ah, this line exceeds 80 columns: Please:

		} else {
pfn_needed_by_per_dumpfile -= read_value_from_splitblock_table(splitblock_inner);
		}

Again, pfn_needed_by_per_dumpfile is too long.

> +		splitblock_inner += splitblock->entry_size;
> +		++*current_splitblock;
> +	}

Please add a line.

> +	//deal with complete splitblock

Please use /* */ style.

What does "complete" mean?

> +	if (pfn_needed_by_per_dumpfile == 0)
> +		end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;

Please add a line.

> +	//deal with incomplete splitblock

Please use /* */ style.

What does "incomplete" mean?

> +	if (pfn_needed_by_per_dumpfile < 0) {

Just as I've already commented in another mail, I think filtering here
is unnecessary. Is it enough to add this splitblock into a current
dumpfile, not next dumpfile? Then, this code is unecessary, and also
current_splitblock_pfns is unnecessary.

> +		--*current_splitblock;
> +		splitblock_inner -= splitblock->entry_size;
> +		end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
> +		*current_splitblock_pfns = (-1) * pfn_needed_by_per_dumpfile;
> +		pfn_needed_by_per_dumpfile += read_value_from_splitblock_table(splitblock_inner);
> +		end_pfn = calculate_end_pfn_in_cycle(CURRENT_SPLITBLOCK_PFN_NUM,
> +						     CURRENT_SPLITBLOCK_PFN_NUM+splitblock->page_per_splitblock,
> +						     end_pfn,pfn_needed_by_per_dumpfile);
> +	}

Please add a line.

> +	//deal with memory not managed by splitblock

Please use /* */ style.

> +	if (pfn_needed_by_per_dumpfile > 0 && *current_splitblock >= splitblock->num) {
> +		mdf_pfn_t cycle_start_pfn = MAX(CURRENT_SPLITBLOCK_PFN_NUM,end_pfn);
> +		end_pfn=calculate_end_pfn_in_cycle(cycle_start_pfn,
> +						   info->max_mapnr,
> +						   end_pfn,
> +						   pfn_needed_by_per_dumpfile);
> +	}
> +	return end_pfn;
> +}

Please add a line.

> +/*
> + * calculate start_pfn and end_pfn in each output file.
> + */
> +static int setup_splitting_cyclic(void)
> +{
> +	int i;
> +	mdf_pfn_t start_pfn, end_pfn;
> +	long long current_splitblock_pfns = 0;
> +	int current_splitblock = 0;

Please add a line.

> +	start_pfn = end_pfn = 0;
> +	for (i = 0; i < info->num_dumpfile - 1; i++) {
> +		start_pfn = end_pfn;
> +		end_pfn = calculate_end_pfn_by_splitblock(start_pfn,
> +							  &current_splitblock,
> +							  &current_splitblock_pfns);
> +		SPLITTING_START_PFN(i) = start_pfn;
> +		SPLITTING_END_PFN(i) = end_pfn;
> +	}
> +	SPLITTING_START_PFN(info->num_dumpfile - 1) = end_pfn;
> +	SPLITTING_END_PFN(info->num_dumpfile - 1) = info->max_mapnr;
> +	return TRUE;
> +}
> +
>  int
>  setup_splitting(void)
>  {
> @@ -8203,12 +8300,14 @@ setup_splitting(void)
>  		return FALSE;
>  
>  	if (info->flag_cyclic) {
> -		for (i = 0; i < info->num_dumpfile; i++) {
> -			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
> -			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
> +		int ret = FALSE;

Please add a line.

> +		if(!prepare_bitmap2_buffer_cyclic()){
> +			free_bitmap_buffer();
> +			return ret;
>  		}
> -		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
> -			SPLITTING_END_PFN(i-1) = info->max_mapnr;
> +		ret = setup_splitting_cyclic();
> +		free_bitmap2_buffer_cyclic();
> +		return ret;
>          } else {
>  		initialize_2nd_bitmap(&bitmap2);
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
