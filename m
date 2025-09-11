Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA9CA1016
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESVr/PCO5mj3Euf7na2oraMPrefSP5rEhizD9JtmFJg=; b=KybsqQ43p09LyT5a9PWIJBY1+s
	qLJA1LCxlS6MyhuUNNjuUTrxGrGQXNnqI5XzR1argGyCX6JZQKdntBcORKgOZh6bdLfetL6+RVAzj
	U0WTeVLZQUABj/U6JuyqhgYme1DRJ5U4TnT2EYwzWtBRCiVOblkFKDdqBt4a375LgqyLAETq58hoz
	IxZjhQ094EeCjb82fGFhXyjZTWRWt/yJHRhllqqLjWfCHoEHVpj/ncYSu8D5oBeTvrjwrlPG2dMP0
	cPdw3hH1mCNqRuQjkBg97AYKjO5FZwdx0RPfIWGalsyNvRkYoEArz5n+/DCK5rH8GvePiHGeLgHE6
	am9shpJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdoT-00000002BFD-29eu;
	Thu, 11 Sep 2025 09:41:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdoP-00000002BDO-0hlX
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 09:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757583710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESVr/PCO5mj3Euf7na2oraMPrefSP5rEhizD9JtmFJg=;
	b=auR0wkXT/RpshyyfTBec36ht3is5LRaUFFI/391zaf4kWe/3OkJrUWc/ATu2Fsyp5Uplzf
	hyfn1sN40oEP4OCnaxkvLHSqKiXFU1dJKrWkuSImEbuKKB0t5fa1+7exxD38jbAMapZhmw
	c9cF6nT5trIzXAG/uf0jsDl339XMVS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Iz-BNOapM1ycJmmJ9f-N4g-1; Thu,
 11 Sep 2025 05:41:46 -0400
X-MC-Unique: Iz-BNOapM1ycJmmJ9f-N4g-1
X-Mimecast-MFC-AGG-ID: Iz-BNOapM1ycJmmJ9f-N4g_1757583705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC3AC1800378;
	Thu, 11 Sep 2025 09:41:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 378AE19560BB;
	Thu, 11 Sep 2025 09:41:42 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:41:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-ID: <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910163116.49148-1-jbouron@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_024153_277645_1FC757F4 
X-CRM114-Status: GOOD (  18.49  )
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

On 09/10/25 at 09:31am, Justinien Bouron wrote:
> Kexec does not accept segments for which the destination address is not
> page aligned. Therefore there is no need for page offset handling when
> loading segments.

Do you mean we will adjust the memsz and buf_align to PAGE_SIZE aligned
in kexec_add_buffer()? That better be explained in log.

int kexec_add_buffer(struct kexec_buf *kbuf)
{
	......
	/* Ensure minimum alignment needed for segments. */
        kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
        kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
        kbuf->cma = NULL;
	......
}

> 
> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
>  kernel/kexec_core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 31203f0bacaf..7d4c9eebea79 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	while (mbytes) {
>  		size_t uchunk, mchunk;
>  
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);

I am not so eager to remove it as keeping it makes a little sense on
defensive programming. Surely, I am not opposing it as it's truly not
necessary for now.

>  		uchunk = min(ubytes, mchunk);
>  
>  		if (uchunk) {
> @@ -815,6 +813,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
>  	mbytes = segment->memsz;
>  	maddr = segment->mem;
>  
> +
>  	if (image->segment_cma[idx])
>  		return kimage_load_cma_segment(image, idx);
>  
> @@ -840,9 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
>  		ptr = kmap_local_page(page);
>  		/* Start with a clear page */
>  		clear_page(ptr);
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
>  		uchunk = min(ubytes, mchunk);
>  
>  		if (uchunk) {
> @@ -905,9 +902,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
>  		}
>  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>  		ptr = kmap_local_page(page);
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
>  		uchunk = min(ubytes, mchunk);
>  		if (mchunk > uchunk) {
>  			/* Zero the trailing part of the page */
> -- 
> 2.43.0
> 
> 


