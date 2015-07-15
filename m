Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFD5W-0002CV-Ic
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 03:10:27 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id DD89BAC02DA
 for <kexec@lists.infradead.org>; Wed, 15 Jul 2015 12:10:02 +0900 (JST)
Date: Wed, 15 Jul 2015 12:09:57 +0900 (JST)
Message-Id: <20150715.120957.106666381.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 3/4] Add write_kdump_page
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1436495333-22892-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1436495333-22892-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Subject: [PATCH v1 3/4] Add write_kdump_page
Date: Fri, 10 Jul 2015 10:28:52 +0800

> write_kdump_page is used to write page when generating kdump core.
> It mainly optimizes the way of generating incomplete core.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index e8b52f4..74bf83e 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6324,6 +6324,59 @@ get_pfn_offset(void *buf, struct cache_data *cd_page){
>  }
>  
>  int
> +write_kdump_page(struct cache_data *cd_header, struct cache_data *cd_page,
> +		struct page_desc *pd, void *page_data)
> +{
> +	int written_pfns_size;
> +
> +	/*
> +	 * if either cd_header or cd_page is nearly full,
> +	 * write the buffer cd_header into dumpfile and then write the cd_page.
> +	 */

Please begin comments by capital letter. They should be formal.

Also, please explain why. What currently this comment says is obvious
from the below.

> +	if ( cd_header->buf_size + sizeof(pd) > cd_header->cache_size

No space needed here.

Also, sizeof(pd) should have been sizeof(*pd), right?

if (cd_header->buf_size + sizeof(*pd) > cd_header->cache_size
 		|| cd_page->buf_size + pd->size > cd_page->cache_size){

> +		|| cd_page->buf_size + pd->size > cd_page->cache_size ){
> +
> +		if(!write_cd_buf(cd_header)) {

Space is needed here.

      	 	if (!write_cd_buf(cd_header)) {

> +			/*
> +			 * if enospc occurs in writing cd_header,
> +			 * fill the cd_header with zero and re-write it
> +			 * into the dumpfile.
> +			 */

Also, this comment is meangless, no additional information...

> +			memset(cd_header->buf, 0, cd_header->cache_size);
> +			write_cd_buf(cd_header);
> +
> +			return FALSE;
> +		}
> +
> +		if(!write_cd_buf(cd_page)) {
> +			/*
> +			 * if enospc occurs in writing cd_page,
> +			 * get how many pages having been written.
> +			 * and fill part of cd_header with zero according to it.
> +			 */
> +			written_pfns_size = sizeof(page_desc_t) *
> +					get_pfn_offset(cd_header->buf, cd_page);

Hmm, so get_pfn_offset() returns the number of pages? If so, this
function name of get_pfn_offset() is very confusing.

Is this variable name written_pfns_size good? That is, I associate
page frame with pfn, but this variable should represent size of page
headers.

> +
> +			memset(cd_header->buf, 0, cd_header->cache_size);
> +			cd_header->offset += written_pfns_size;
> +			cd_header->buf_size -= written_pfns_size;
> +			write_cd_buf(cd_header);
> +
> +			return FALSE;
> +		}
> +		cd_header->offset += cd_header->buf_size;
> +		cd_page->offset += cd_page->buf_size;
> +		cd_header->buf_size = 0;
> +		cd_page->buf_size = 0;
> +	}
> +
> +	write_cache(cd_header, pd, sizeof(page_desc_t));
> +	write_cache(cd_page, page_data, pd->size);
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
