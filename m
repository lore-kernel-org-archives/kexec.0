Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFCsf-0005vb-B2
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 02:57:09 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 3028DAC01FD
 for <kexec@lists.infradead.org>;
 Wed, 15 Jul 2015 11:56:46 +0900 (JST)
Date: Wed, 15 Jul 2015 11:56:39 +0900 (JST)
Message-Id: <20150715.115639.164279461.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 2/4] Add get_pfn_offset
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1436495333-22892-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1436495333-22892-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v1 2/4] Add get_pfn_offset
Date: Fri, 10 Jul 2015 10:28:51 +0800

> get_pfn_offset is used for generating incomplete kdump core.
> When enospac occurs in writing the buf cd_page, it can be used to
> get how many pages have been written.
> 

This patch should be merged into 3/4. This patch description is an
expalnation of get_pfn_offset(). This should be just above
get_pfn_offset() as a comment.

> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 5a53246..e8b52f4 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6300,6 +6300,30 @@ write_cd_buf(struct cache_data *cd)
>  }
>  
>  int
> +get_pfn_offset(void *buf, struct cache_data *cd_page){
> +	int size, file_end, offset;
> +	page_desc_t *pd;
> +
> +	size = 0;
> +	offset = 0;

Put these initialization just before the while loop below.

Is this really offset? This looks to me the number of pages.

> +	file_end = lseek(cd_page->fd, 0, SEEK_END);
> +	if (file_end < 0)
> +		ERRMSG("Can't seek end of the dump file(%s).\n", cd_page->file_name);
> +
> +	while (TRUE) {
> +		pd = (page_desc_t *)buf;
> +		size += pd->size;
> +		if (size > file_end - cd_page->offset)
> +			break;
> +
> +		offset++;
> +		buf += sizeof(page_desc_t);
> +	}

How about like this? I use nr_pages not offset.

page_desc_t *pd = buf;

...<skip>...

size = pd->size;
nr_pages = 0;
while (size <= file_end - cd_page->offset) {
    nr_pages++;
    pd++;
    size += pd->size;
}

Please rename get_pfn_offset(), too.

> +
> +	return offset;
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
