Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCF1D3E787
	for <kexec@archiver.kernel.org>; Sun, 14 Dec 2025 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJq4y3E9dGTIf4vZAfArLGlKhvp6jUao1b7lpRrCSXE=; b=H6sGg3xHhTERJ59foQjZuSrrZs
	qklxkyyP1Y97VzApREfsgXvp+Ghx54ECCitQWECcYGm4YwWF/UjkCZzgssHmXqywEEEqXlBRVaBpt
	HjVx9DN9PgYkUp1EfbOlQfgpj0jXwLWMwZP4kjnmGP7zgDzPzhcvPND5LK00AwnkvE88nnJJjomdw
	L1F7Np4zEx0z7+mhZspPciU1FkO7Z01k1ag6lSfYXYfcSLPB/1gyg2Awl65ZARLDP0YVwGVw0ttcO
	HNczKnLSAXgaCCiT4+Nbu/Ylmy+pc3xUknkxlptmmgUCgnnVOvPwmuRQyWYqGsPCVwP1IJa73hr3g
	qQxKwj5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUjGU-00000002LH5-13iM;
	Sun, 14 Dec 2025 10:23:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUjGQ-00000002LGg-2nYc
	for kexec@lists.infradead.org;
	Sun, 14 Dec 2025 10:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765707818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJq4y3E9dGTIf4vZAfArLGlKhvp6jUao1b7lpRrCSXE=;
	b=UNO4/VIGILlAr6bkmd153lS9u3QKML/XeqL4oqFPItzLNXw+alXIrdRZzWvJYLH/g9/01u
	Hlp4AR5tDfEPWYU0mWWof3/Yqvo9ayTPXKogRkqeunZCNGsIj8jMdV3HNhJghXJQWvN4HC
	7ANLE3f+gwsrkp/zKdHUqAvNLSKXJ5w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-QYNowiyPNtCbk28vVgKbkA-1; Sun,
 14 Dec 2025 05:23:34 -0500
X-MC-Unique: QYNowiyPNtCbk28vVgKbkA-1
X-Mimecast-MFC-AGG-ID: QYNowiyPNtCbk28vVgKbkA_1765707813
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5B4319560A5;
	Sun, 14 Dec 2025 10:23:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.161])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83DF930001A2;
	Sun, 14 Dec 2025 10:23:29 +0000 (UTC)
Date: Sun, 14 Dec 2025 18:23:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
Message-ID: <aT6QHHf+t1+fZh4n@MiWiFi-R3L-srv>
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_022342_782465_B04DD886 
X-CRM114-Status: GOOD (  18.82  )
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

On 12/12/25 at 06:53pm, Baoquan He wrote:
> On 12/12/25 at 03:16pm, Qiang Ma wrote:
> > The image is initialized to NULL. Then, after calling kimage_alloc_init,
> > we can directly goto 'out' because at this time, the kimage_free will
> > determine whether image is a NULL pointer.
> 
> Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
> allocated memory are all freed via out_free_control_pages and
> out_free_image accordingly, any place missed? If no, I think the current
> code is correctly handled.
> 
> > 
> > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > ---
> >  kernel/kexec.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Cancle this ACK till above question is answered.

> 
> > 
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 28008e3d462e..9bb1f2b6b268 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >  	unsigned long i;
> >  	int ret;
> >  
> > +	image = NULL;
> > +
> >  	/*
> >  	 * Because we write directly to the reserved memory region when loading
> >  	 * crash kernels we need a serialization here to prevent multiple crash
> > @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >  
> >  	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> >  	if (ret)
> > -		goto out_unlock;
> > +		goto out;
> >  
> >  	if (flags & KEXEC_PRESERVE_CONTEXT)
> >  		image->preserve_context = 1;
> > -- 
> > 2.20.1
> > 
> 


