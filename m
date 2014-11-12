Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoWgY-0000r1-Go
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 12:06:07 +0000
Date: Wed, 12 Nov 2014 20:05:35 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] makedumpfile: Fix the variable pfn_needed leaking
Message-ID: <20141112120535.GB3334@dhcp-17-108.nay.redhat.com>
References: <1415696079-29701-1-git-send-email-mhuang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415696079-29701-1-git-send-email-mhuang@redhat.com>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On 11/11/14 at 04:54pm, Minfei Huang wrote:
> If the page pfn calculated by read_from_splitblock_table is bigger than
> pfn_needed, the variable pfn_needed will leak.
> 
> makedumpfile cannot assign the pfn averagely bacause of condition
> pfn_needed invalid.
> 
> Signed-off-by: Minfei Huang <mhuang@redhat.com>
> ---
>  makedumpfile.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 59c4952..8807a90 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8415,7 +8415,7 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>  		return info->max_mapnr;
>  
>  	mdf_pfn_t end_pfn;
> -	long long pfn_needed, offset;
> +	long long pfn_needed, offset, per_splitblock_pfn;
>  	char *splitblock_value_offset;
>  
>  	pfn_needed = info->num_dumpable / info->num_dumpfile;
> @@ -8424,7 +8424,8 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>  	end_pfn = start_pfn;
>  
>  	while (*cur_splitblock_num < splitblock->num && pfn_needed > 0) {
> -		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
> +		per_splitblock_pfn = read_from_splitblock_table(splitblock_value_offset); 
> +		pfn_needed = pfn_needed < per_splitblock_pfn ? 0 : pfn_needed - per_splitblock_pfn;
Hi, Wenjiang!

Sorry, my emall client didnot receive the mail by you, so I reply it
here.

The split->table is an array to record the pfn count which we need dump.
And the memory is divided by the size of info->splitblock_size, the pfn
count in each entry will be stored in the entry of split->table.

For the purpose, we want to average allocation to the pfns.

Here is a case:
There are 5 entries in the split->table, and the value is 4, 6, 4, 5, 5.
We want to split four pieces to write to four files, and every file will
be write 6 pfns.
Using the function calculate_end_pfn_by_splitblock, the first file will
be assigned all of the pfns(24 pfns).

pfn_needed is 6((4+6+4+5+5) / 4) when entry the function.
By the end of first loop, the variable pfn_needed = 2(6 - 4).
Then move on, the variable will leak to become huge number by the end of
second loop, because the return value of function read_from_splitblock_table
is 6. The variable pfn_needed is ~4(2 - 6), it is huge.
And the loop will break util *cur_splitblock_num == splitblock->num.

For above case, it is no sense to use split function, so we should add
the condition whether pfn_needed is bigger than the value of
read_from_splitblock_table.

Thanks
Minfei
>  		splitblock_value_offset += splitblock->entry_size;
>  		++*cur_splitblock_num;
>  	}
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
