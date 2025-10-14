Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA95CCD18E
	for <kexec@archiver.kernel.org>; Tue, 14 Oct 2025 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=84qLuulQEWfDvvAd6y1sTa13pyZb7pX9XGxQ88tYQoo=; b=x+eC9Fzs0FJfa9+sarENSGtyZr
	T63jUq8h6botTStG6zCARiSeHzm2CP3C3pklLyMR5v50srO4qJpKAjO9LxyQmHpv8DpjJBdOjVeGY
	VzB+uejd/we7Hd+vIZ0yOhjfsLt3FaFsw7BHPI7d78YDxWn7ENx/sTU96jOsS/C8NDvuCBD2mjMV0
	YsS6YG3LMBJ9Ez8o83ca89RSv0+45IizbWVyvfd9Meq7gCmDvVneXYgK4b0zemzsiX+6I0IWoAxi4
	AR2D+80HvV8YtT7471P8bxgiMPfTB9sRHpbAq9ATaeZ7PA/B2uowpv5PnfiVg06odbNyRGpYfM7fJ
	notBWzRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8b7g-0000000FitO-08MH;
	Tue, 14 Oct 2025 09:15:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8b7d-0000000Fiqi-1n7c
	for kexec@lists.infradead.org;
	Tue, 14 Oct 2025 09:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84qLuulQEWfDvvAd6y1sTa13pyZb7pX9XGxQ88tYQoo=;
	b=TZ79chb+YDm/geyWTHcokvn14TSlXvvKvXBKw3Ps/nppqUjblomhhZkGyIAPfOGMUH31AW
	dIpnpXSAg8WIAQALilFJajiZwE8eDMvWVz08oBYZUL3IsqCTQ5KfLwTUwhScRc6k9kIPkg
	tLpP3jnrJhG1VpevPba48ysW1dnQUms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-habP5WxuNy6IzIfoPvjpwQ-1; Tue,
 14 Oct 2025 05:15:03 -0400
X-MC-Unique: habP5WxuNy6IzIfoPvjpwQ-1
X-Mimecast-MFC-AGG-ID: habP5WxuNy6IzIfoPvjpwQ_1760433299
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08D5B18002CD;
	Tue, 14 Oct 2025 09:14:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DCFA1800283;
	Tue, 14 Oct 2025 09:14:57 +0000 (UTC)
Date: Tue, 14 Oct 2025 17:14:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com,
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, sj@kernel.org,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aO4UjVmGkYg5Nyf6@MiWiFi-R3L-srv>
References: <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
 <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
 <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
 <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_021509_536830_2A385F0A 
X-CRM114-Status: GOOD (  25.37  )
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

On 10/14/25 at 10:27am, Sabyrzhan Tasbolatov wrote:
> On Thu, Sep 25, 2025 at 11:21 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> > > On Wed, Sep 24, 2025 at 5:35 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > > > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > > > > will be merged during the next merge window), just rebase your changes
> > > > > on top.
> > > >
> > > > That's fine, I will rebase.
> > > >
> > > > >
> > > > > But also note that Sabyrzhan is planning to move out the
> > > > > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > > > > I would have also asked you to do with the kasan=off patches), so
> > > > > maybe you should sync up with him wrt these changes.
> > > >
> > > > Hi Sabyrzhan,
> > > >
> > > > What's your thought? You want to do the cleanup after my rebasing on
> > > > your merged patches or you prefer to do it ahead of time? Please let me
> > > > know so that I can adjust my posting accordingly. Thanks.
> > > >
> > >
> > > Hello,
> > >
> > > I can make all necessary changes only next week. Currently, traveling.
> > > I will send the fix-up patch Andrey has described somewhere next week.
> > > Please let me know if it's ok.
> >
> > Please take it easy, today is Thursday, I will wait for your clean up
> > patch next week and post. I can do some preparation work for rebasing on
> > your merged patches. Thanks.
> 
> Hello,
> 
> Just heads up that I've already sent cleanup patches [1] and
> Andrew has merged them into mm-new tree.
> Hopefully, one week's delay wasn't a problem.

Thanks for telling. I planned to rebase on top of that and repost in
one week or two weeks. I am doing some patch back porting for RHEL.

> 
> [1] https://lore.kernel.org/all/20251009155403.1379150-1-snovitoll@gmail.com/
> 


