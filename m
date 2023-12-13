Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF2C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lNS6ZtNcPTpW0obWMU6XZe5CMrfmZgvltsebS95C550=; b=nRgiOFVTv9XSpR
	MmlCjpk94hIHX2CMy5rvqYGqrNoi4L4k3qOostLjqxtlqD7KyrmIQafXKuce91sXvHwUJ6BYLEhcl
	vEfuOzpiJkloez1v/0zNEexKmKxpLb2HJfBgrKgracIxosUZvROQ5GSrBDHcImpHjCZDtHq66EDHa
	Z4U5YixSUibJ5fPxrjiKyhLgf525/Br6AIGhQcj8Lx2YAtLQgK/sy0C7M8vQ13WxxrOw9LC2eQWg6
	id2mODbFmXlJGe+rxkNH4wMgIY8PfDnwD/YkOaet9IPqiIcGgVJ5f11b3gf4AgEI34sJ7lYY89q0j
	MBQtDYhdtA3vCbAqTx6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFJJ-00DRYs-33;
	Wed, 13 Dec 2023 02:49:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFJH-00DRYL-0O
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 02:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702435756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coQ8pvaq2UkX5cEo9LeuOuQYxw7SGcKK+T3HPyA15No=;
	b=F7FbRF122HkJkrGhzIXOS88MTpupKmvGiHrFF7EPgAom/wDkQppJ3Z5DTnvUDzXPz471GJ
	/yksR+GocbGjiH6oYenLrygU1066+waP4SqOwAblH+3eAw1IvZBKoeYlMZHh/jJoTMtoHJ
	R3skccOI+cxmmlbKvXKi8UnKz/ZaIG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-n-aNT_MWPnmDeaWCx57W_A-1; Tue, 12 Dec 2023 21:49:13 -0500
X-MC-Unique: n-aNT_MWPnmDeaWCx57W_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC7A830F96;
	Wed, 13 Dec 2023 02:49:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA9D2026D66;
	Wed, 13 Dec 2023 02:49:11 +0000 (UTC)
Date: Wed, 13 Dec 2023 10:49:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: Use ALIGN macro instead of open-coding it
Message-ID: <ZXkbpNubH69pAjg1@MiWiFi-R3L-srv>
References: <20231212142706.25149-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231212142706.25149-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_184919_254232_038D00F4 
X-CRM114-Status: GOOD (  16.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/12/23 at 10:27pm, Yuntao Wang wrote:
> Use ALIGN macro instead of open-coding it to improve code readability.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/kexec_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..0113436e4a3a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -430,7 +430,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  
>  	pages = NULL;
>  	size = (1 << order) << PAGE_SHIFT;
> -	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
> +	hole_start = ALIGN(image->control_page, size);
>  	hole_end   = hole_start + size - 1;
>  	while (hole_end <= crashk_res.end) {
>  		unsigned long i;
> @@ -447,7 +447,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  			mend   = mstart + image->segment[i].memsz - 1;
>  			if ((hole_end >= mstart) && (hole_start <= mend)) {
>  				/* Advance the hole to the end of the segment */
> -				hole_start = (mend + (size - 1)) & ~(size - 1);
> +				hole_start = ALIGN(mend, size);
>  				hole_end   = hole_start + size - 1;
>  				break;
>  			}
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
