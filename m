Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7554EC5CFCF
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 02:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrojsVhz+sqWLFbg6kCfsroAXMas41ZTsdfB5kkX7qU=; b=Eh+A4NBnyauyfphKHpykirGpQl
	oftD2RAIJL9+0UnhiMkxlEnEu+iSo1iAMVjSbWV8kXWCmtxdpjjxlxH9mGzwbuLAMt+ejJf24/DZX
	wEjHjLsS+WoZuQCvXz9hO8Gq8H4o9FMmGAi/rPqkDHtFN7M8VOaE74KznzJg6r0UCQZUp9X+q5JxT
	Laj+xiYzYQQho7caMJm3VtQiIVdnbAomEW3QILJkTGefkXBAoKHavC0hF1/g4q1K2WF2fZay0iS7j
	oHDvHz2VOqPy4q5JMizhAjyzDxVqp9940IntMtLXrTRhBn0hn+ejn/6wzLzYIHZrn0Sjp45EwYbLM
	5oDVtWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKyX-0000000HGdl-0IyQ;
	Thu, 13 Aug 2026 02:15:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKyT-0000000HGdE-3nU6
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 02:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786587315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrojsVhz+sqWLFbg6kCfsroAXMas41ZTsdfB5kkX7qU=;
	b=ZrJUgnLGZc3zbXshUwFEnf/Tq/7nUltfo7mQmQ/L2zHjjSx0+H0HONUg9H2IqdPlBdU3zU
	+JJ2cJIQYCRN9RxivgUMC069N2cbJS/9Ck59CWyd0lFecV4sOOGkzUXxzYHSvxQIkXpqm7
	KbmAhZWY2xe+4sT87+yMP6Nlsj+gZeI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-OgRWzLugO-GAqPyuNHRnGw-1; Wed, 12 Aug 2026 22:15:13 -0400
X-MC-Unique: OgRWzLugO-GAqPyuNHRnGw-1
X-Mimecast-MFC-AGG-ID: OgRWzLugO-GAqPyuNHRnGw_1786587312
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso1313305a12.1
        for <kexec@lists.infradead.org>; Wed, 12 Aug 2026 19:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786587312; x=1787192112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrojsVhz+sqWLFbg6kCfsroAXMas41ZTsdfB5kkX7qU=;
        b=bgyq5Gdeww/VZB53QwdnpbX3VrggKi2W5mkzr1rz5MOtZ14G/l5MRAejoxRiqA/h7D
         dbDwLoSAjWCugHTt+j1RhLxOXunTNKrEmA6l4MRF1cp/GTTSYrge9CHVIQ47sb3B6qw2
         8hnLxAjg7biAkupqN1K79yrhv9naJlFWJZzwC/YJ8oksbAzwYmSl2NZXnBt8MlHq6dK9
         Saycnz2dA3Le0AUY1tAEtNrhRtBF66NFQvRZ3KMKX6rsfntbW43fLYIhFxYKZx8RUP8T
         uNRmyKqvIREVzvWGsdRP1PtS9+09ap3J8dJMa49USyR13iUNn499Z21ZTeZ3HUcawPQX
         keVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Q3g9xu6KnkI6uA4gbDHbtY9LtRfU58515Byx0stfhiPRprPO3gkKxUgxkVOhhzJrCZBZFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkR17MEmaKg0vJSKRq9Ky2xwrLzZYSsyfMDBioefpjHILmT6We
	A7H4s2S5p0VJBbdKRBSd9IXz9ypimJ0S8HikeashETC55MH8sNK3k3eIlRGcjozalEGxq5i+8mA
	HBMicsFur/nOySJ4CkGSbwrrba4DvUYkkLnbMeLOuEYQHKg175R/SAhx3GaW1Xw==
X-Gm-Gg: AR+sD11jPUh7spPnaUsMBB9pl7RYDyzTu+pzgNsDzmwWBJKR1LNynrmm02Yqi3ZzH3a
	6lywDQPx5ssN6GrK8GVAAKcmEKmKmJTmr7uM37ZQc5erxIabBcHah0x+pFolRVb7EBQpvP4M6De
	2ENXCE9g5P1sYhN8ucRc3C03/r004tdszJRTXzKLs7FuvHM7tZYfuDnedS8snpQC2w/9eF64wUX
	QdssuH1vc+Kf93bi31cymiuBEK0VXWghC+kyLN9+e5FhqXWUvySqgJ59DKnoiptBp8caN81yPbg
	/rN++s2dByULuxi7lgctGUlUsaJfTTXqobW473h7T+WT6k2pH8w/DFQcivCHzYIKkyXDKV89VTg
	QLnT3XYDslbqTPsxeNmrPdptDaoLTm9D80fmRsxc=
X-Received: by 2002:a05:6a21:b86:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cc551facebmr3315362637.20.1786587312205;
        Wed, 12 Aug 2026 19:15:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:b86:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cc551facebmr3315284637.20.1786587311714;
        Wed, 12 Aug 2026 19:15:11 -0700 (PDT)
Received: from localhost.localdomain (122-63-68-18.mobile.spark.co.nz. [122.63.68.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d8d0c3esm3643128c88.6.2026.08.12.19.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:15:10 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:15:03 +1200
From: Tao Liu <ltao@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Subject: Re: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by
 extension
Message-ID: <an0opyG2YuUD-Gez@localhost.localdomain>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HiCRP1tReg04uZXz-4btpqYAP_DrODg_dnkZywUCTl4_1786587312
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_191518_025121_E0A14B0E 
X-CRM114-Status: GOOD (  26.93  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Mon, Jul 13, 2026 at 05:45:37PM -0700, Stephen Brennan wrote:
> Extensions can mark pages to be excluded, but those pages may already be
> excluded due to the dump level. We have a statistic to count pages
> excluded by extensions. It counts only pages which were excluded because
> no other criteria excluded them.
> 
> Extensions can mark pages to be retained, but there is no statistic to
> count them. Adding a counter to the code as-is would not give us the
> value that we care about. Just as above, pages marked for inclusion may
> have been included anyway due to the dump-level configuration. The most
> useful statistic is the one that tells us how many pages were included
> by the extension, which would not have been included otherwise.
> 
> Introduce a statistic that counts this amount.  To do so, we have to
> skip the short-circuit evaluation when PG_INCLUDE is returned. This
> seems like a worthwhile trade-off, since the dump-level checks are all
> reasonably efficient.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  makedumpfile.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a4c9bbf..cf6a38f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
>  mdf_pfn_t pfn_extension;
>  
>  mdf_pfn_t num_dumped;
> +mdf_pfn_t num_extension_retained;
>  
>  int retcd = FAILED;	/* return code */
>  
> @@ -6638,8 +6639,6 @@ check_order:
>  		 * makedumpfile extensions
>  		 */
>  		filter_pg = run_extension_callback(pfn, pcache, &i);
> -		if (filter_pg == PG_INCLUDE)
> -			continue;
>  
>  		/*
>  		 * Exclude the free page managed by a buddy
> @@ -6722,6 +6721,13 @@ check_order:
>  		else
>  			continue;
>  
> +		if (filter_pg == PG_INCLUDE) {
> +			/* Account pages which would have been excluded, but were
> +			 * retained by an extension. */
> +			num_extension_retained += nr_pages;
> +			continue;

Maybe I'm wrong, from the code we are trying to retain nr_pages, don't
we need to do
			pfn += nr_pages
to update the pfn of the next for-loop?

> +		}
> +
>  		/*
>  		 * Execute exclusion
>  		 */
> @@ -8265,6 +8271,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  	if (info->flag_cyclic) {
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
>  		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
> +		num_extension_retained = 0;
>  		pfn_memhole = info->max_mapnr;
>  	}
>  
> @@ -9610,6 +9617,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  		 */
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
>  		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
> +		num_extension_retained = 0;
>  		pfn_memhole = info->max_mapnr;
>  
>  		/*
> @@ -10575,6 +10583,7 @@ print_report(void)
>  	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
>  	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
>  	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
> +	REPORT_MSG("  Retained by extension     : 0x%016llx\n", num_extension_retained);
>  	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>  	    pfn_original - pfn_excluded);
> 
I suggest to reorder the "print_report" as follows:

Original pages  :
  Excluded pages   :
    Pages filled with zero  :
    Non-private cache pages :
    Private cache pages     :
    User process data pages :
    Free pages              :
    Hwpoison pages          :
    Offline pages           :
    Extension filter pages  :
  Remaining pages  :
    Extension retain pages  :

IMHO, this is clearer to represent "Original pages" == "Excluded pages" + "Remaining pages";
and "Extension retained pages" is a subset of "Remaining pages".

Thanks,
Tao Liu
> -- 
> 2.47.3
> 


