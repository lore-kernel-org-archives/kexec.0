Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XsnxC-0006mS-1o
 for kexec@lists.infradead.org; Mon, 24 Nov 2014 07:20:58 +0000
Date: Mon, 24 Nov 2014 15:18:56 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V5 4/5] Add module of calculating start_pfn and end_pfn
 in each dumpfile
Message-ID: <20141124071856.GB3015@dhcp-16-105.nay.redhat.com>
References: <1415263768-15821-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1415263768-15821-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415263768-15821-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

On 11/06/14 at 04:49pm, Zhou Wenjian wrote:

> +#define CURRENT_SPLITBLOCK_PFN_NUM (*cur_splitblock_num * splitblock->page_per_splitblock)
> +mdf_pfn_t
> +calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
> +				 int *cur_splitblock_num)
> +{
> +	if (start_pfn >= info->max_mapnr)
> +		return info->max_mapnr;
> +
> +	mdf_pfn_t end_pfn;
> +	long long pfn_needed, offset;
> +	char *splitblock_value_offset;
> +
> +	pfn_needed = info->num_dumpable / info->num_dumpfile;
> +	offset = *cur_splitblock_num * splitblock->entry_size;
> +	splitblock_value_offset = splitblock->table + offset;
> +	end_pfn = start_pfn;
> +
> +	while (*cur_splitblock_num < splitblock->num && pfn_needed > 0) {
> +		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
> +		splitblock_value_offset += splitblock->entry_size;
> +		++*cur_splitblock_num;
> +	}

Hi Wenjian,

If splitblock->page_per_splitblock is 1G, and the system ram is 4G. Now
I set 8 dumpfiles to store the splitted vmcore, say dump0...7. Then
dump0/1/2/3 will store 1G of data, dump4/5/6/7 will be empty. So is it
OK?

Can we do anything to avoid this case or give some note to let people not
be panikked by empty dump files?

Thanks
Baoquan


> +
> +	end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
> +	if (end_pfn > info->max_mapnr)
> +		end_pfn = info->max_mapnr;
> +
> +	return end_pfn;
> +}
> +
> +/*
> + * calculate start_pfn and end_pfn in each output file.
> + */
> +static int setup_splitting_cyclic(void)
> +{
> +	int i;
> +	mdf_pfn_t start_pfn, end_pfn;
> +	int cur_splitblock_num = 0;
> +	start_pfn = end_pfn = 0;
> +
> +	for (i = 0; i < info->num_dumpfile - 1; i++) {
> +		start_pfn = end_pfn;
> +		end_pfn = calculate_end_pfn_by_splitblock(start_pfn,
> +							  &cur_splitblock_num);
> +		SPLITTING_START_PFN(i) = start_pfn;
> +		SPLITTING_END_PFN(i) = end_pfn;
> +	}
> +	SPLITTING_START_PFN(info->num_dumpfile - 1) = end_pfn;
> +	SPLITTING_END_PFN(info->num_dumpfile - 1) = info->max_mapnr;
> +
> +	return TRUE;
> +}
> +
>  int
>  setup_splitting(void)
>  {
> @@ -8230,12 +8289,16 @@ setup_splitting(void)
>  		return FALSE;
>  
>  	if (info->flag_cyclic) {
> -		for (i = 0; i < info->num_dumpfile; i++) {
> -			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
> -			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
> +		int ret = FALSE;
> +
> +		if(!prepare_bitmap2_buffer_cyclic()){
> +			free_bitmap_buffer();
> +			return ret;
>  		}
> -		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
> -			SPLITTING_END_PFN(i-1) = info->max_mapnr;
> +		ret = setup_splitting_cyclic();
> +		free_bitmap2_buffer_cyclic();
> +
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
