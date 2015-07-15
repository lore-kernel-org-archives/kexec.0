Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFCYM-0003ha-Lt
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 02:36:11 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id CE935AC0114
 for <kexec@lists.infradead.org>; Wed, 15 Jul 2015 11:35:47 +0900 (JST)
Date: Wed, 15 Jul 2015 11:35:41 +0900 (JST)
Message-Id: <20150715.113541.237189974.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 1/4] Add write_cd_buf
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1436495333-22892-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1436495333-22892-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v1 1/4] Add write_cd_buf
Date: Fri, 10 Jul 2015 10:28:50 +0800

> write_cd_buf is used to write the data of cache_data into file.
> 

I think this patch should be merged into 3/4.

> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index cc71f20..5a53246 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6286,6 +6286,20 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  }
>  
>  int
> +write_cd_buf(struct cache_data *cd)
> +{
> +	if (cd->buf_size == 0)
> +		return TRUE;
> +
> +	if (!write_buffer(cd->fd, cd->offset, cd->buf,
> +			cd->buf_size, cd->file_name)) {
> +		return FALSE;
> +	}
> +
> +	return TRUE;
> +}
> +
> +int
>  write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
>  			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
>  {
> -- 
> 1.8.3.1
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
