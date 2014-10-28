Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj0Up-0007g9-UH
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 06:43:12 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 983593EE112
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:42:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id A10A4AC01E6
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:42:49 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4572F1DB8041
 for <kexec@lists.infradead.org>; Tue, 28 Oct 2014 15:42:49 +0900 (JST)
Date: Tue, 28 Oct 2014 15:42:41 +0900 (JST)
Message-Id: <20141028.154241.113095525.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/5] Add tools for reading and writing from
 splitblock table
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1413192866-28140-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1413192866-28140-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v2 2/5] Add tools for reading and writing from splitblock table
Date: Mon, 13 Oct 2014 17:34:23 +0800

> The function added in this patch, is used for writing and reading value
> from the char array in struct SplitBlock.
> 
> Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 95d553c..a8d86f6 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5708,6 +5708,29 @@ calculate_entry_size(void){
>  	return entry_size;
>  }
>  
> +void
> +write_value_into_splitblock_table(char *splitblock_inner, unsigned long long content)

This line exceeds 80 characters. The cause would be the name of
function arguments are too long.

How about this?

void
write_value_into_splitblock_table(char *entry, unsigned long long value)


> +{
> +	char temp;
> +	int i=0;

Please add linebreak.

Please add spaces between assignment operator.

int i = 0;

> +	while (i++ < splitblock->entry_size) {
> +		temp = content & 0xff;
> +		content = content >> BITPERBYTE;
> +		*splitblock_inner++ = temp;

Please write increment operator in a separate line.

                *splitblock_inner = temp;
                *splitblock_inner++;

> +	}
> +}
> +unsigned long long
> +read_value_from_splitblock_table(char *splitblock_inner)
> +{
> +	unsigned long long ret = 0;

How about value instead of ret? In addition to the above comment, this
also leads to contrasting consistency between the two helper
functions.

> +	int i;

Please add a linebreak.

> +	for (i = splitblock->entry_size; i > 0; i--) {
> +		ret = ret << BITPERBYTE;
> +		ret += *(splitblock_inner + i - 1) & 0xff;

The & 0xff is necessary? because splitblock_inner is of type char *.

> +	}
> +	return ret;
> +}
> +
>  mdf_pfn_t
>  get_num_dumpable(void)
>  {
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
