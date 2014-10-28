Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj0J3-0003oi-3U
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 06:31:02 +0000
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 055A23EE112
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:30:37 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id EE182AC03FE
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:30:35 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8E00A1DB8032
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:30:35 +0900 (JST)
Date: Tue, 28 Oct 2014 15:30:28 +0900 (JST)
Message-Id: <20141028.153028.271204634.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 1/5] Add support for splitblock
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1413192866-28140-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1413192866-28140-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v2 1/5] Add support for splitblock
Date: Mon, 13 Oct 2014 17:34:22 +0800

> When --split option is specified, fair I/O workloads shoud be assigned
> for each process. So the start and end pfn of each dumpfile should be
> calculated with excluding unnecessary pages. However, it costs a lot of
> time to execute excluding for the whole memory. That is why struct
> SplitBlock exists. Struct SplitBlock is designed to manage memory, mainly
> for recording the number of dumpable pages. We can use the number of
> dumpable pages to calculate start and end pfn instead of execute excluding
> for the whole memory.
> 
> The char array *table in struct SplitBlock is used to record the number of
> dumpable pages.
> The table entry size is calculated as
> 			divideup(log2(splitblock_size / page_size), 8) bytes
> The table entry size is calculated, so that the
> space table taken will be small enough. And the code will also have a
> good performence when the number of pages in one splitblock is big enough.
> 
> Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c |   23 +++++++++++++++++++++++
>  makedumpfile.h |   14 ++++++++++++++
>  2 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b4d43d8..95d553c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -34,6 +34,7 @@ struct srcfile_table	srcfile_table;
>  
>  struct vm_table		vt = { 0 };
>  struct DumpInfo		*info = NULL;
> +struct SplitBlock		*splitblock = NULL;
>  
>  char filename_stdout[] = FILENAME_STDOUT;
>  
> @@ -5685,6 +5686,28 @@ out:
>  	return ret;
>  }
>  
> +/*
> + * cyclic_split mode:
> + *	manage memory by splitblocks,
> + *	divide memory into splitblocks
> + *	use splitblock_table to record numbers of dumpable pages in each splitblock
> + */
> +
> +//calculate entry size based on the amount of pages in one splitblock

Please use /* */ style in comment just as other parts of makedumpfile
source codes.

> +int
> +calculate_entry_size(void){

Please add linebreak.

calculate_entry_size(void)
{

> +	int entry_num = 1, count = 1;
> +	int entry_size;

Please add linebreak.

> +	while (entry_num < splitblock->page_per_splitblock){
> +		entry_num = entry_num << 1;
> +		count++;
> +	}
> +	entry_size = count/BITPERBYTE;
> +	if (count %BITPERBYTE)
> +		entry_size++;
> +	return entry_size;
> +}
> +
>  mdf_pfn_t
>  get_num_dumpable(void)
>  {
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 96830b0..98b8404 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1168,10 +1168,24 @@ struct DumpInfo {
>  	 */
>  	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
>  			     unsigned long private, unsigned int _count);
> +	/*
> +	 *for cyclic_splitting mode, setup splitblock_size
> +	 */
> +	long long splitblock_size;
>  };
>  extern struct DumpInfo		*info;
>  
>  /*
> + *for cyclic_splitting mode,Manage memory by splitblock
> + */
> +struct SplitBlock{
> +        char *table;
> +        long long num;
> +        long long page_per_splitblock;
> +        int entry_size;                 //counted by byte

Please use /* */.

> +};
> +
> +/*
>   * kernel VM-related data
>   */
>  struct vm_table {
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
