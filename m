Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPTue-00049r-Ma
 for kexec@lists.infradead.org; Mon, 17 Mar 2014 09:32:53 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 05BFC3EE1C3
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 18:32:26 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E4AC945DEBE
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 18:32:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id CB68A45DEBC
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 18:32:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B822EE08005
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 18:32:25 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 615ED1DB8040
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 18:32:25 +0900 (JST)
Date: Mon, 17 Mar 2014 18:32:14 +0900 (JST)
Message-Id: <20140317.183214.300888078.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] makedumpfile: reduce unnecessary memory copy
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140317084318.13494.34955.stgit@k.asiapacific.hpqcorp.net>
References: <20140317084318.13494.34955.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: jingbai.ma@hp.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com

From: Jingbai Ma <jingbai.ma@hp.com>
Subject: [PATCH] makedumpfile: reduce unnecessary memory copy
Date: Mon, 17 Mar 2014 16:43:18 +0800

> This patch intends to reduce unnecessary memory copy in compressing memory
> blocks.
> 
> old logic like this:
>     compress(buf_out, &size_out, buf, size);
>     ...
>     memcpy(buf, buf_out, pd.size);
>     ...
>     write_cache(cd_page, buf, pd.size)
> 
> new logic:
>     compress(buf_out, &size_out, buf, size);
>     ...
>     if (compressed?)
>         write_cache(cd_page, buf_out, pd.size)
>     else
>         write_cache(cd_page, buf, pd.size)
> 
> This occurs for each single page, so by the new logic it can reduce a lot of
> unnecessary memcpy() on machines with huge memory.
> This patch wasn't expected to improve the kdump performance dramatically due to
> the memory copy operations on modern processors are pretty fast.
> 

Now /proc/vmcore has zero copy mechanism with mmap(), but now
makedumpfile still uses buffers some places in makedumpfile to keep
changes as less as possible for ease of maintainance. I think ease of
maintainance is important, so I don't think we should soon totally
remove copy in makedumpfile. We should first benchmark where can be
improved very much by just removing copy and then should decide where
to optimize.

OTOH, this patch also seems to be a kind of clean-up patch. Even if
amount of improvement is a little, I don't object this patch; of
course, then patch description should say it's rather cleanup patch
than optimization.

> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>  makedumpfile.c |   24 ++++++++++++++----------
>  1 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 23251a1..80f76cf 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6245,7 +6245,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>  		    && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #ifdef USELZO
>  		} else if (info->flag_lzo_support
>  			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
> @@ -6255,7 +6254,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>  			   && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_LZO;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #endif
>  #ifdef USESNAPPY
>  		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
> @@ -6267,7 +6265,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>  			   && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #endif
>  		} else {
>  			pd.flags = 0;
> @@ -6286,8 +6283,13 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>  		/*
>  		 * Write the page data.
>  		 */
> -		if (!write_cache(cd_page, buf, pd.size))
> -			goto out;
> +		if (pd.flags == 0) {
> +			if (!write_cache(cd_page, buf, pd.size))
> +				goto out;
> +		} else {
> +			if (!write_cache(cd_page, buf_out, pd.size))
> +				goto out;
> +		}
>  	}

if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
    goto out;

>  
>  	/*
> @@ -6424,7 +6426,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>  		    && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #ifdef USELZO
>  		} else if (info->flag_lzo_support
>  			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
> @@ -6434,7 +6435,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>  			   && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_LZO;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #endif
>  #ifdef USESNAPPY
>  		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
> @@ -6446,7 +6446,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>  			   && (size_out < info->page_size)) {
>  			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
>  			pd.size  = size_out;
> -			memcpy(buf, buf_out, pd.size);
>  #endif
>  		} else {
>  			pd.flags = 0;
> @@ -6465,8 +6464,13 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>                  /*
>                   * Write the page data.
>                   */
> -                if (!write_cache(cd_page, buf, pd.size))
> -                        goto out;
> +		if (pd.flags == 0) {
> +			if (!write_cache(cd_page, buf, pd.size))
> +				goto out;
> +		} else {
> +			if (!write_cache(cd_page, buf_out, pd.size))
> +				goto out;
> +		}
>          }

Similaly.

>  
>  	ret = TRUE;
> 

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
