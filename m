Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3154C87FCB
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 03:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9v/VfxV4WcSv8mLKBf97De83PUNubQY/hyRrkNkUdjA=; b=pB1Oyh2OtLQInzUYFHryXvw9Gm
	EU9NObG6FWfcf+es3mpm4Ik0h5dimG1bzRELvpygTCl8CiLXwMi+Byk/oTL53+l52yDNy7UPsO5N7
	fl/7H6O/zBhN1fnjhVDyq2pMK3oVVLSHzUuF0osbDTSqMv9LrUbH6wdxqghkkduMqB5sDWfNyX6QJ
	EQEegMU01VZDVBYE0CtQQlHRAXdnzN0QHdIKnhlA5WhpEcraAZgPJ96M4Rx9wZWt+s2txqBznGfI0
	ncj8D8NXoCicbzqecXUgAIewO7y6/fHDhAgalJap63tLWgfLYL6dZpZaetffg1y79gwMlWad5hI++
	l6k9dJ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukDgG-00000001umY-1UxL;
	Fri, 08 Aug 2025 03:22:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukDgE-00000001ulv-0z3E
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 03:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754623323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9v/VfxV4WcSv8mLKBf97De83PUNubQY/hyRrkNkUdjA=;
	b=hBeUB1A8AlxJwmV2IPATyHI+29DfY6PXbvZJsaaeJzbeNC1Sbq66WfL9KZ8St8NBccrDuC
	8VOc9JZxqenHYFXEPFTfO8/QFetaPF92+pa07t2hbSrhcrVAgYrDnylFe7DYn0vRppmYGP
	pG9XM+tcIbvWb8yZCsfzyMXJ3p+ubhA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-CQ50kHbEPO-N047aktSPjQ-1; Thu,
 07 Aug 2025 23:22:00 -0400
X-MC-Unique: CQ50kHbEPO-N047aktSPjQ-1
X-Mimecast-MFC-AGG-ID: CQ50kHbEPO-N047aktSPjQ_1754623318
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CBDA18004D4;
	Fri,  8 Aug 2025 03:21:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 699EB19560AD;
	Fri,  8 Aug 2025 03:21:55 +0000 (UTC)
Date: Fri, 8 Aug 2025 11:21:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
Message-ID: <aJVtTjRUXqWePva0@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_202206_354854_FF03CBB9 
X-CRM114-Status: GOOD (  34.68  )
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

On 08/06/25 at 09:16am, Marco Elver wrote:
> On Tue, 5 Aug 2025 at 08:23, 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built.
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > kernel.
> 
> Are you using KASAN generic or SW-tags is production?
> If in a test environment, is the overhead of the kdump kernel really
> unacceptable?

Thanks for checking this.

I don't use KASAN in production environment. But in Redhat, our CI will
run test cases on debug kernel with KASAN enabled by default. Then the
crashkernel setting will be uncertain. E.g usually crashkernel=256M is
enough for most of system. However, KASAN would make the crashkernel
reservation need to reach to 768M on one ampere arm64 system. This is
not the extra 1/8 of system ram as we expected because we have vmalloc
mapping to create shaddow too. In this case, QE or other kernel
developer who is not familiar with KASAN may need spend time to dig out
what's going on here. And they may need adjust crashkernel= value to get
an appropriate one to make system work. This is not good because we
don't need KASAN feature in kdump kernel at all while we need tackle the
unexpected crashkernel= setting.

This can be fixed with a very easy way, a knob to disable kasan in kdump
kernel can perfectly handle it.

> 
> > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > kasan.
> >
> > Test:
> > =====
> > I only took test on x86_64 for generic mode, and on arm64 for
> > generic, sw_tags and hw_tags mode. All of them works well.
> 
> Does it also work for CONFIG_KASAN_INLINE?

Yes, Andrey said in reply, I did investigation. You can see that
KASAN_INLINE will bloat vmlinux by ~30M. This is not a big problem of
kdump kernel.

CONFIG_KASAN_OUTLINE=y
[root@ampere-mtsnow-altra-08 linux]# ll vmlinux
-rwxr-xr-x. 1 root root 124859016 Aug  6 06:08 vmlinux
[root@ampere-mtsnow-altra-08 linux]# ll /boot/vmlinuz-*
-rwxr-xr-x. 1 root root 15938048 Aug  3 00:15 /boot/vmlinuz-0-rescue-f81ab6a509e444e3857153cfa3fc6497
-rwxr-xr-x. 1 root root 15938048 Jul 23 20:00 /boot/vmlinuz-6.15.8-200.fc42.aarch64
-rwxr-xr-x. 1 root root 20644352 Aug  6 06:11 /boot/vmlinuz-6.16.0+

CONFIG_KASAN_INLINE=y
[root@ampere-mtsnow-altra-08 linux]# ll vmlinux
-rwxr-xr-x. 1 root root 150483592 Aug  6 10:53 vmlinux
[root@ampere-mtsnow-altra-08 linux]# ll /boot/vmlinuz-* 
-rwxr-xr-x. 1 root root  15938048 Aug  3 00:15 /boot/vmlinuz-0-rescue-f81ab6a509e444e3857153cfa3fc6497
-rwxr-xr-x. 1 root root  15938048 Jul 23 20:00 /boot/vmlinuz-6.15.8-200.fc42.aarch64
-rwxr-xr-x. 1 root root  27779584 Aug  6 10:55 /boot/vmlinuz-6.16.0+

> 
> > However when I tested sw_tags on a HPE apollo arm64 machine, it always
> > breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug
> > can always be seen too.
> >
> > "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
> >
> > I haven't got root cause of the bug, will report the bug later in
> > another thread.
> > ====
> >
> > Baoquan He (4):
> >   mm/kasan: add conditional checks in functions to return directly if
> >     kasan is disabled
> >   mm/kasan: move kasan= code to common place
> >   mm/kasan: don't initialize kasan if it's disabled
> >   mm/kasan: make kasan=on|off take effect for all three modes
> >
> >  arch/arm/mm/kasan_init.c               |  6 +++++
> >  arch/arm64/mm/kasan_init.c             |  7 ++++++
> >  arch/loongarch/mm/kasan_init.c         |  5 ++++
> >  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
> >  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
> >  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
> >  arch/riscv/mm/kasan_init.c             |  6 +++++
> >  arch/um/kernel/mem.c                   |  6 +++++
> >  arch/x86/mm/kasan_init_64.c            |  6 +++++
> >  arch/xtensa/mm/kasan_init.c            |  6 +++++
> >  include/linux/kasan-enabled.h          | 11 ++------
> >  mm/kasan/common.c                      | 27 ++++++++++++++++++++
> >  mm/kasan/generic.c                     | 20 +++++++++++++--
> >  mm/kasan/hw_tags.c                     | 35 ++------------------------
> >  mm/kasan/init.c                        |  6 +++++
> >  mm/kasan/quarantine.c                  |  3 +++
> >  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
> >  mm/kasan/sw_tags.c                     |  9 +++++++
> >  18 files changed, 150 insertions(+), 46 deletions(-)
> >
> > --
> > 2.41.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250805062333.121553-1-bhe%40redhat.com.
> 


