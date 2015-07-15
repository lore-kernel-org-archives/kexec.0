Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFCYo-0003yn-H9
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 02:36:39 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A402AC01C1
 for <kexec@lists.infradead.org>; Wed, 15 Jul 2015 11:36:15 +0900 (JST)
Date: Wed, 15 Jul 2015 11:36:10 +0900 (JST)
Message-Id: <20150715.113610.113046576.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 4/4] Use write_kdump_page instead of write_cache in
 write_kdump_pages_cyclic
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1436495333-22892-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1436495333-22892-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v1 4/4] Use write_kdump_page instead of write_cache in write_kdump_pages_cyclic
Date: Fri, 10 Jul 2015 10:28:53 +0800

I think this patch should be merged into 3/4.

> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 74bf83e..0f1aa94 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6515,17 +6515,11 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>  		pd.offset     = *offset_data;
>  		*offset_data  += pd.size;
>  
> -                /*
> -                 * Write the page header.
> -                 */
> -                if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
> -                        goto out;
> -
> -                /*
> -                 * Write the page data.
> -                 */
> -		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
> -                        goto out;
> +               /*
> +                * Write the page header and the page data
> +                */
> +               if (!write_kdump_page(cd_header, cd_page, &pd, pd.flags ? buf_out : buf))
> +                       goto out;
>          }
>  
>  	ret = TRUE;
> -- 
> 1.8.3.1
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
