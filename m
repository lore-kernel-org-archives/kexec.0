Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C73D59D99
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEhx54QjWtv58WgbpuaBuTx0YRc6rn3nDVdHrytc9s8=; b=nt3rJ7bNLHipHX4wJPZPuS3gI+
	QIWNbSxphmub2V5MIbLI1OayF/Uy0HTLryhkgKU6eo5B1UT+sJ+0VlCbFek3OgnCGOVRFtNqhlFRS
	pY1quqinvSBy0HFU+hRUM6Ipyc2KLVO9lEtEEG/JWjPmMHWy8YUjNu7s7SEQUGYthT2fG9Yhd57FL
	8yquKVhbi/bxorXwutim8ihZIwkemu8NT/qpN9FtpG6PASL2gHX4mtBvd0pr/Ho8sN4zKkCf7C3vW
	mjKN/ej8oemor7KxfzQwhzB11+3OlFJKng+E+4dcBaREYW1XuASXxWc06dqm3KX/tdbKQUHXkn02N
	RISKVv1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUxEb-00000002tyK-32nV;
	Mon, 15 Dec 2025 01:18:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUxEY-00000002txm-0zBp
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 01:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765761520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEhx54QjWtv58WgbpuaBuTx0YRc6rn3nDVdHrytc9s8=;
	b=J9txpwMxmrsKobqG8fo5UJa58wdvIQbuC1oqBQp9zEhRSylF0068pa4mO944fDQ5STT4r/
	e5UqZ202qVehPJXOJEck0zhUVStiTID7bOaJoz70f8R4FDaIuvwfuJJFGYrK0lmfhvALbl
	VQthtBJsmJbBEKR6o0b3dLGnXviq8kE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-90lOy28QMGugOTAm-pb25Q-1; Sun,
 14 Dec 2025 20:18:38 -0500
X-MC-Unique: 90lOy28QMGugOTAm-pb25Q-1
X-Mimecast-MFC-AGG-ID: 90lOy28QMGugOTAm-pb25Q_1765761517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAF5D1956050;
	Mon, 15 Dec 2025 01:18:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A4A61800367;
	Mon, 15 Dec 2025 01:18:34 +0000 (UTC)
Date: Mon, 15 Dec 2025 09:18:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
Message-ID: <aT9h54lX3J+cO0gf@MiWiFi-R3L-srv>
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
 <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_171842_356639_2736AA56 
X-CRM114-Status: GOOD (  20.52  )
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

On 12/14/25 at 07:35pm, Qiang Ma wrote:
> 
> 在 2025/12/12 18:53, Baoquan He 写道:
> > On 12/12/25 at 03:16pm, Qiang Ma wrote:
> > > The image is initialized to NULL. Then, after calling kimage_alloc_init,
> > > we can directly goto 'out' because at this time, the kimage_free will
> > > determine whether image is a NULL pointer.
> > Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
> > allocated memory are all freed via out_free_control_pages and
> > out_free_image accordingly, any place missed? If no, I think the current
> > code is correctly handled.
> I rechecked the code and found no omissions.

Hmm, my bad, I didn't say my question clearly. I checked code, didn't
find anything wrong in the current code. In kimage_alloc_init(), the
allocated memory are all freed on failure, no memory leaked. Means you
are fixing correct code.

> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > ---
> > >   kernel/kexec.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index 28008e3d462e..9bb1f2b6b268 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	unsigned long i;
> > >   	int ret;
> > > +	image = NULL;
> > > +
> > >   	/*
> > >   	 * Because we write directly to the reserved memory region when loading
> > >   	 * crash kernels we need a serialization here to prevent multiple crash
> > > @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> > >   	if (ret)
> > > -		goto out_unlock;
> > > +		goto out;
> > >   	if (flags & KEXEC_PRESERVE_CONTEXT)
> > >   		image->preserve_context = 1;
> > > -- 
> > > 2.20.1
> > > 
> > 
> 


