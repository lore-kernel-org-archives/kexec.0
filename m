Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D66CAC5AC
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8pUVu7ebrm0X4wJheoYfCWuw4PuHNLvghKI3Pai2MA=; b=wAWzBaTs6daeKwBAPTM6sZM4kb
	DnvZYIsq3HHLXZf1vtENBrXZyMxw+b0zIC1svHJdaR1Y2QE0Kl3VlJyK0npo/E0Dc8wrD8qwEDnBd
	jjDb/i+jcUkzd50i1/7kpUINMcVNuqnYf3qA8Bw/y47i+yLzaTP2St9zk5Wp/ofluVcy+GxsZxSWf
	28RIGuspLVRmULmNPaSXZpfk+O1p1U+nGZekm5WcEDMACwx20ZTgVNZ6B0XSjYCg8hx/iC7yoQvpj
	yK5cdRZXyCdS3Pc1VXMozaqaPVYSn+oDB2jzeMu4sDMzNlBWp3G0hzJi0qnowhK8krp9fBoOM2v/D
	TJXhsXjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1FLi-0000000FMwe-0v2A;
	Wed, 24 Sep 2025 02:35:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1FLe-0000000FMvJ-2UWP
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 02:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758681312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8pUVu7ebrm0X4wJheoYfCWuw4PuHNLvghKI3Pai2MA=;
	b=ZP+sWQyhdHKHqrGaSfTgbL4luXcf9QMqM+0yi95Oj2ONYvFqtWzs7Lfz9Or4+juQ8GwKNJ
	ajZrDIYEEhmM+Jq6aHKTIh8CeRmqMUDtS1l6IGLTJ8CUGnaGxRwRICXRLBgMQIaBFUVih6
	dnXit9gYj9NELhiTLTS6J65fDaD+djE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-MVxsJoxEMu6l8sCFbwGk7g-1; Tue,
 23 Sep 2025 22:35:09 -0400
X-MC-Unique: MVxsJoxEMu6l8sCFbwGk7g-1
X-Mimecast-MFC-AGG-ID: MVxsJoxEMu6l8sCFbwGk7g_1758681307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 006D61956096;
	Wed, 24 Sep 2025 02:35:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06F6B1800446;
	Wed, 24 Sep 2025 02:35:04 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:35:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>, snovitoll@gmail.com
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com,
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, sj@kernel.org,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_193514_724659_93349D54 
X-CRM114-Status: GOOD (  29.10  )
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

On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> On Mon, Sep 15, 2025 at 11:05 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > > physmap shadow and the slab redzones) is still unacceptable for your
> > > use case (noting that the performance overhead (and the constant
> > > silent detection of false-positive bugs) would still be there), I
> > > think you can proceed with your series (unless someone else is
> > > against).
> >
> > Yeah, that would be great if we can also avoid any not needed memory
> > consumption for kdump.
> 
> Ack. Let's add support for kasan=off then.

Thanks.
> 
> But please describe it in detail in the KASAN documentation.

Will do in next round.

> 
> [...]
> 
> > When I made patch and posted, I didn't see Sabyrzhan's patches because I
> > usually don't go through mm mailing list. If I saw his patch earlier, I
> > would have suggested him to solve this at the same time.
> >
> > About Sabyrzhan's patch sereis, I have picked up part of his patches and
> > credit the author to Sabyrzhan in below patchset.
> >
> > [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
> > https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u
> >
> > About reposting of this series, do you think which one is preferred:
> >
> > 1) Firstly merge Sabyrzhan's patch series, I reverted them and apply for
> >    my patchset.
> >
> > 2) Credit the author of patch 1,2,3 of this patch series to Sabyrzhan
> >    too as below, because Sabyrzhan do the unification of the static keys
> >    usage and the KASAN initialization calls earlier:
> 
> Since the Sabyrzhan's patches are already in mm-stable (and I assume
> will be merged during the next merge window), just rebase your changes
> on top.

That's fine, I will rebase.

> 
> But also note that Sabyrzhan is planning to move out the
> kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> I would have also asked you to do with the kasan=off patches), so
> maybe you should sync up with him wrt these changes.

Hi Sabyrzhan,

What's your thought? You want to do the cleanup after my rebasing on
your merged patches or you prefer to do it ahead of time? Please let me
know so that I can adjust my posting accordingly. Thanks.

Thanks
Baoquan


