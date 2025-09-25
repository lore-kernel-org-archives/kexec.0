Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64042CAC5AA
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWVGs+PYKtMTbMr9CAqyDAMYWhTG9d/QRFnGi6Yteos=; b=Kxd6MLQEvWbQ1gKWzQc7EkkkeI
	2pAXHAVRfl/C6jrN9bsQeppdXT+2LZmNWk3ckpr3zhjsW2ls9Kk2CAEEklSQ6IyxV7Fb+gB3GVMSu
	hyPNLbKAKeOTyi0oiELEJk0fGnIt1n4tnHbGzehi3qnqxci3rfPJazOzrJtf2rfrXqmwSFkj1hSGW
	ISMAqxwF3IsahYnwFO4x74azYHZ/DM6j7+CQ5pbwHsyQHVuxRimkRwPJDNhUndF2gxRrnoLQkdimj
	9p6GMzHPCx5UjygKcr33nZjiEeaKJOisuIM4Br7XOZLucJPusHyNnPf/5t2v1/6l7mgpHFY8rh7ZZ
	xTZ4W6AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fLq-00000006ERK-3ptV;
	Thu, 25 Sep 2025 06:21:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fLk-00000006EQF-2kgJ
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 06:21:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758781262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWVGs+PYKtMTbMr9CAqyDAMYWhTG9d/QRFnGi6Yteos=;
	b=Ao3y4svZeOrpQYXP3YYH9BG+ihU92/AYUARP6cOalWWJ0xfFBn9JS7iExuO+wvDOlVHYMF
	HoS2Cj62HuORplkkzRRSqN3+8hJ4NjF/tSRk1dST4V1wsJAtLzT9KA6A/lSCOn3R7hwdhD
	eOkMpL0wbGKObxh/joGi03pZdHndXwU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-x8b2H0wSP5im0fP7tXEa7Q-1; Thu,
 25 Sep 2025 02:20:55 -0400
X-MC-Unique: x8b2H0wSP5im0fP7tXEa7Q-1
X-Mimecast-MFC-AGG-ID: x8b2H0wSP5im0fP7tXEa7Q_1758781253
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1E711955F45;
	Thu, 25 Sep 2025 06:20:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97CE19560B1;
	Thu, 25 Sep 2025 06:20:50 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:20:46 +0800
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
Message-ID: <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
 <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_232104_764731_E3E073DB 
X-CRM114-Status: GOOD (  21.10  )
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

On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> On Wed, Sep 24, 2025 at 5:35 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > > will be merged during the next merge window), just rebase your changes
> > > on top.
> >
> > That's fine, I will rebase.
> >
> > >
> > > But also note that Sabyrzhan is planning to move out the
> > > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > > I would have also asked you to do with the kasan=off patches), so
> > > maybe you should sync up with him wrt these changes.
> >
> > Hi Sabyrzhan,
> >
> > What's your thought? You want to do the cleanup after my rebasing on
> > your merged patches or you prefer to do it ahead of time? Please let me
> > know so that I can adjust my posting accordingly. Thanks.
> >
> 
> Hello,
> 
> I can make all necessary changes only next week. Currently, traveling.
> I will send the fix-up patch Andrey has described somewhere next week.
> Please let me know if it's ok.

Please take it easy, today is Thursday, I will wait for your clean up
patch next week and post. I can do some preparation work for rebasing on
your merged patches. Thanks.

> 
> > Thanks
> > Baoquan
> >
> 


