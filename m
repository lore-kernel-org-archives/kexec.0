Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF91DCA101F
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 05:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rR4nvuLB68PWeoEq6OrLbNMctFC5H6hheeaS39RYv7Q=; b=fdwAE0Dwgz9z6T3eMrBOpAw00j
	VGNk5r/hQzw8+DyjSvHqnR8JxpRly4ff7Dv2qoeHzytnswBNjVRSMAPKqxJLviF5LmTVeABi5F3GA
	MporegoJcqIAOW0GkQEIs6U3IS3QP5rrovnQbW86o7Qk/THvzAhEBsXFUNY8bNE88HYeUEfo40IC+
	e9hOwxgDjgi9/974AIt9w76oTZQV0ArWp7voP6PGi0sabk/YBk/HzACXoIGHCL/zsK+gE5xtEb0i/
	tEGaCnmoOiaSgUL9/tY7n+5vdacQQsga3sD+csg0WZpFWFPets927zCNSdSx5cI3kGmlZ3dT8NmGC
	rZutFtrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy1uM-00000002qux-1QaS;
	Mon, 15 Sep 2025 05:37:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy1uG-00000002quT-2PlV
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 05:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757914658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4nvuLB68PWeoEq6OrLbNMctFC5H6hheeaS39RYv7Q=;
	b=FfZYjYkrYJa9rito3bV+9Z+JVNM5hiVoLtHRNt7kD5j2htro7rIThQBVp9RyKxR6hOZ8/q
	Qnbd5O8NO2HS6Y1E+zQmCDKSzVzHRDjdaPjC7TkMmORLKWWh19IhqXMPqEU1KWtPYxGmNK
	S1P3S4WMgBFY98RY/uaBcwMmCQk6LD0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-j2IEoyyDO9S2fP4RaYfzeA-1; Mon,
 15 Sep 2025 01:37:32 -0400
X-MC-Unique: j2IEoyyDO9S2fP4RaYfzeA-1
X-Mimecast-MFC-AGG-ID: j2IEoyyDO9S2fP4RaYfzeA_1757914650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52736195609F;
	Mon, 15 Sep 2025 05:37:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8901800446;
	Mon, 15 Sep 2025 05:37:28 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:37:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: glider@google.com, dvyukov@google.com, elver@google.com,
	linux-mm@kvack.org, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aMemFIM+T7PBrx1G@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_223740_687948_96E8B7BF 
X-CRM114-Status: GOOD (  19.78  )
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

On 09/06/25 at 03:25pm, Andrey Konovalov wrote:
> On Fri, Sep 5, 2025 at 10:34 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > Baoquan, I'd be in favor of implementing kasan.vmalloc=off instead of
> > kasan=off. This seems to both (almost) solve the RAM overhead problem
> > you're having (AFAIU) and also seems like a useful feature on its own
> > (similar to CONFIG_KASAN_VMALLOC=n but via command-line). The patches
> > to support kasan.vmalloc=off should also be orthogonal to the
> > Sabyrzhan's series.
> >
> > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > physmap shadow and the slab redzones) is still unacceptable for your
> > use case (noting that the performance overhead (and the constant
> > silent detection of false-positive bugs) would still be there), I
> > think you can proceed with your series (unless someone else is
> > against).
> 
> Hm, just realized that kasan.vmalloc=off would probably break if
> CONFIG_VMAP_STACK is enabled: read-only shadow for vmalloc =>
> read-only shadow for stacks => stack instrumentation will try writing
> into read-only shadow and crash.
> 
> So I wonder if there's a way to avoid the lazy vmap freeing to deal
> with the RAM overhead.

That's a very key feature of vmalloc, lazy vmap freeing not only
integrate the virtual area freeing on one cpu at one time, but also
merge the areas and flush tlb at one time too. Please see
__purge_vmap_area_lazy() for the details. This can avoid performance
degradation when many vfree() are called.


