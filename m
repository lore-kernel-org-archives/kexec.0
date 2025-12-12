Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B5D44176
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5v7ScoAzTJp0ojIcceqScWlImfIgadynxxW600LvYPM=; b=fB+zYFrIgeBnJuELqsJXRH29WD
	+nWJupkYoyOUzTm3YwixObD3VQqKfpkZ+qz2H33kP6xaMYpjf98TvMu2Q5ZKadgd+gf1LEpKj8lCY
	foUF9GoFrpouLq6QD4jELbwxNiMv1+6tbhIdtwcfwloVUnT0MltkYGbXssKoj8t0B0f0oh+mozBdW
	KkC/PmWQl24L9tomvNE/KnCyHqtOWv6gLYV7XWMPHCUMBG/NzBcQ07y/MK02SjVqHB44bHR0JlhQa
	9jlynLNvZ4uqxT3e9ojc+z2CYCas7MWu/VmTlaSHxg7Fgt6r6ZNr/Osx8WtPiUtmThk2SZaofV1xo
	7IRje6nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU0mM-00000000Rru-0aP2;
	Fri, 12 Dec 2025 10:53:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU0mI-00000000RrV-1Q8J
	for kexec@lists.infradead.org;
	Fri, 12 Dec 2025 10:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765536815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5v7ScoAzTJp0ojIcceqScWlImfIgadynxxW600LvYPM=;
	b=AewPPMUcjUJ5vaottuiWfgUMIJZs3WC2ZAPoTaqbaHxw693YCSe2+J9Xp6kXZyF0ECjsoQ
	7A9CrD7l/304s7sUXCoAflA+SWAFueV7W2ceVKfguRDxkD/+WpvP3kHPGea6NIXoftctsY
	gGrpUxJ3Ul51YuZdb1n4v3NLxTqfFIE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-SJgf_IHlPpaBl5hoxhnWEQ-1; Fri,
 12 Dec 2025 05:53:30 -0500
X-MC-Unique: SJgf_IHlPpaBl5hoxhnWEQ-1
X-Mimecast-MFC-AGG-ID: SJgf_IHlPpaBl5hoxhnWEQ_1765536809
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC760180060D;
	Fri, 12 Dec 2025 10:53:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.161])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B66D30001A2;
	Fri, 12 Dec 2025 10:53:25 +0000 (UTC)
Date: Fri, 12 Dec 2025 18:53:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
Message-ID: <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
References: <20251212071656.834079-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212071656.834079-1-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_025338_450550_A3E27511 
X-CRM114-Status: GOOD (  16.12  )
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

On 12/12/25 at 03:16pm, Qiang Ma wrote:
> The image is initialized to NULL. Then, after calling kimage_alloc_init,
> we can directly goto 'out' because at this time, the kimage_free will
> determine whether image is a NULL pointer.

Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
allocated memory are all freed via out_free_control_pages and
out_free_image accordingly, any place missed? If no, I think the current
code is correctly handled.

> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  kernel/kexec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 28008e3d462e..9bb1f2b6b268 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	unsigned long i;
>  	int ret;
>  
> +	image = NULL;
> +
>  	/*
>  	 * Because we write directly to the reserved memory region when loading
>  	 * crash kernels we need a serialization here to prevent multiple crash
> @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
>  	if (ret)
> -		goto out_unlock;
> +		goto out;
>  
>  	if (flags & KEXEC_PRESERVE_CONTEXT)
>  		image->preserve_context = 1;
> -- 
> 2.20.1
> 


