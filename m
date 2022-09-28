Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52C1C04A95
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eTv+Gmh5BkjG0BaLPE0OL2cunwRvh0EAmMBDqu5wIHI=; b=ZHmyKHjmvI6PTq
	i+2Q4nVSofhDnSNCz5BnyEoU574GlRAL/jb6VsRR38PpNn8pRwixHow315pE4WvBuJ1OgPHy/0Pgw
	lSC/ap0xluVkib5Mmqxj2kUQMh9Xc5ElZDmxMox5EF5EICKnIlsHQTdot7zNg4hnDt2GB6uL7nQUM
	YnvlylXwBN1LLtKp8lfUqMmgoux8h+pG+8WdBLsAZtQ9XjM2xQWH8/a3TP+AFo4kU/11wk1Glqd9D
	WrScy3EYBKOOaZeRbCYXsHgqF9ESJ9kY2Tx9BOBgLvVpNe1C+zEj9CUSbDlTi3yhGnkQDkzGM2ES8
	KkLmXKt+IhVswkSxaKLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQtE-00EKVX-65; Wed, 28 Sep 2022 06:49:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQsU-00EK9s-Rh
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 06:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664347744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6zUQ1QeMABO48yK91yy+7BFQ5QVaCICeA10q23nqLI=;
	b=fl458RDdswT0vWHafvQEQgPnpAfFaPdRyf6fI3T9ObhOvtGYDZkAMxp5EUC37xcNvUFTRW
	47Gdfz8LJ7FrhffAEpKTy0ligtAfnP3gVIyAOgeBxSpSf+0ysupHsJXACFFJVSILTzBZOs
	exwd1aP96Tlr3TwzIIAct+EEMETdNwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-nxBisCmmNtS3aDH23RHAfw-1; Wed, 28 Sep 2022 02:48:58 -0400
X-MC-Unique: nxBisCmmNtS3aDH23RHAfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB28E85A5A6;
	Wed, 28 Sep 2022 06:48:57 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 961F82024CB7;
	Wed, 28 Sep 2022 06:48:56 +0000 (UTC)
Date: Wed, 28 Sep 2022 14:48:53 +0800
From: Baoquan He <bhe@redhat.com>
To: cgel.zte@gmail.com
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kexec: Remove the unneeded result variable
Message-ID: <YzPuVVm5TwOilkGW@MiWiFi-R3L-srv>
References: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_234907_021632_322C7983 
X-CRM114-Status: GOOD (  15.79  )
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

On 09/08/22 at 01:03am, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value kimage_add_entry() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/kexec_core.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ca2743f9c634..969e8f52f7da 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
>  static int kimage_set_destination(struct kimage *image,
>  				   unsigned long destination)
>  {
> -	int result;
> -
>  	destination &= PAGE_MASK;
> -	result = kimage_add_entry(image, destination | IND_DESTINATION);
>  
> -	return result;
> +	return kimage_add_entry(image, destination | IND_DESTINATION);
>  }
>  
>  
>  static int kimage_add_page(struct kimage *image, unsigned long page)
>  {
> -	int result;
> -
>  	page &= PAGE_MASK;
> -	result = kimage_add_entry(image, page | IND_SOURCE);
>  
> -	return result;
> +	return kimage_add_entry(image, page | IND_SOURCE);
>  }
>  
>  
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
