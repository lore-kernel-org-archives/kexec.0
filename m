Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCEAD2E012
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQFFwyyrbmSQDwjSydErzLovNjSAb4Pxxp/akbzvISk=; b=DhCgj0j1aMbB/+miOV9Z6Ncc3B
	Z7oXQ30xOd9nLxtZXtQc9BVXgwAQxMnVWPXXtAXMWmG8hFYWberY17ki6YgEzNVchtzDuGD2UfD2n
	2sFgol52YfokQLtsQdZyWWp1C9QOAEDJ/m8x7fAwhBqmM6dmgQVFKj9+w0KgS5WSbdXbB36oa0DG8
	3T3EL4bYYxnb8nVw6dT08MQ1Z+nBjym+JTfGfvqmnDo/syFF0eU8tKU9jfTsKsPGGDE1XbNQnQS06
	RrerwDrzNydnWTHPL5Uwr8Y+iXnICf4upS1GW3lVcMdB0taU835h0PM2d9iqaBJWTeLwrgDClnis8
	3GtDNTMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQ1w-000000098aL-07t8;
	Fri, 05 Dec 2025 07:15:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQ1s-000000098ZZ-2EBv
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 07:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764918896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQFFwyyrbmSQDwjSydErzLovNjSAb4Pxxp/akbzvISk=;
	b=QhdAI/v5DL29B27aKkKW17njt2NXDUaj5zLRgQ9PnYjbelepEL9uBAOMeRl0+QZBCLqO0i
	FBWGA9Y4KtVNcC5PeCSA3psM+JAGkUXUKnNnIohtVJcTYPYZtJalja+6zf0d7N9IxRHvP0
	ky8s31nm1M/3dL1aEhtPlsD+DQeBIDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-U-7T_gsNNiuj00amjV2_Jg-1; Fri,
 05 Dec 2025 02:14:52 -0500
X-MC-Unique: U-7T_gsNNiuj00amjV2_Jg-1
X-Mimecast-MFC-AGG-ID: U-7T_gsNNiuj00amjV2_Jg_1764918890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2D2F1956095;
	Fri,  5 Dec 2025 07:14:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 988881800577;
	Fri,  5 Dec 2025 07:14:47 +0000 (UTC)
Date: Fri, 5 Dec 2025 15:14:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aTKGYzREbj/6Hwz6@fedora>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_231500_875711_4DBA5C02 
X-CRM114-Status: GOOD (  51.10  )
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

On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built.
> >
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > while in fact it's meaningless to have kasan in kdump kernel
> >
> > There are two parts of big amount of memory requiring for kasan enabed
> > kernel. One is the direct memory mapping shadow of kasan, which is 1/8
> > of system RAM in generic mode and 1/16 of system RAM in sw_tags mode;
> > the other is the shadow meomry for vmalloc which causes big meomry
> > usage in kdump kernel because of lazy vmap freeing. By introducing
> > "kasan=off|on", if we specify 'kasan=off', the former is avoided by skipping
> > the kasan_init(), and the latter is avoided by not building the vmalloc
> > shadow for vmalloc.
> >
> > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > kasan.
> >
> > Testing:
> > ========
> > - Testing on x86_64 and arm64 for generic mode passed when kasan=on or
> >   kasan=off.
> >
> > - Testing on arm64 with sw_tags mode passed when kasan=off is set. But
> >   when I tried to test sw_tags on arm64, the system bootup failed. It's
> >   not introduced by my patchset, the original code has the bug. I have
> >   reported it to upstream.
> >   - System is broken in KASAN sw_tags mode during bootup
> >     - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u
> 
> This will hopefully be fixed soon, so you'll be able to test.

Great news, thanks for telling. And thanks a lot for careful reviewing.

> 
> >
> > - Haven't found hardware to test hw_tags. If anybody has the system,
> >   please help take a test.
> 
> You don't need hardware to run the HW_TAGS mode, just pass -machine
> virt,mte=on to QEMU.

That's great, I will manage to test it in this way.

> 
> I also wonder if we should keep this kasan=off functionality
> conservative and limit it to x86 and arm64 (since these are the only
> two tested architectures).

We may not need to do that. I tested on arm64 because it has sw_tags and
hw_tags. And if x86_64 and arm64 works well with kasan=off in generic
mode, it should be fine on other architectures. I am a little more
familiar with operations on x86/arm64 than others.  I can manage to get
power system to test kasan=off in generic mode, if that is required.
From my side, I would like to see x86_64/arm64/s390/power to have
kasan=off because RHEL support these architectures. I need consult people
to make clear how to change in s390. Will post patch later or ask other
people to help do that.

While there seems to be no reason we don't let other arch-es have this
benefit if the underlying code has paved the way, the arch side only needs
two lines of judgement code. Personal opinion.

> >
> > Changelog:
> > ====
> > v3->v4:
> > - Rebase code to the latest linux-next/master to make the whole patchset
> >   set on top of
> >   [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
> >   [PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
> 
> Note that are also:
> 
> [PATCH 1/2] kasan: remove __kasan_save_free_info wrapper
> [PATCH 2/2] kasan: cleanup of kasan_enabled() checks

Right, I saw these two patches, and have rebased code to sit on top of
them. There are some conflicts, I have handled them manually. I only
mentioned the cover-letter one to state the whole patchset.

Sabyrzhan Tasbola [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
Sabyrzhan Tasbola ├─>[PATCH 2/2] kasan: cleanup of kasan_enabled() checks
Sabyrzhan Tasbola └─>[PATCH 1/2] kasan: remove __kasan_save_free_info wrapper

Thanks
Baoquan

> 
> But I don't know if there will be any conflicts with these.
> 
> >
> > v2->v3:
> > - Fix a building error on UML ARCH when CONFIG_KASAN is not set. The
> >   change of fixing is appended into patch patch 11. This is reported
> >   by LKP, thanks to them.
> >
> > v1->v2:
> > - Add __ro_after_init for kasan_arg_disabled, and remove redundant blank
> >   lines in mm/kasan/common.c. Thanks to Marco.
> > - Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
> >   this is found out by SeongJae and Lorenzo, and also reported by LKP
> >   report, thanks to them.
> > - Add a missing kasan_enabled() checking in kasan_report(). This will
> >   cause below KASAN report info even though kasan=off is set:
> >      ==================================================================
> >      BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
> >      Read of size 4 at addr ffff00005f747778 by task swapper/0/1
> >
> >      CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(voluntary)
> >      Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
> >      Call trace:
> >       show_stack+0x30/0x90 (C)
> >       dump_stack_lvl+0x7c/0xa0
> >       print_address_description.constprop.0+0x90/0x310
> >       print_report+0x104/0x1f0
> >       kasan_report+0xc8/0x110
> >       __asan_report_load4_noabort+0x20/0x30
> >       tick_program_event+0x130/0x150
> >       ......snip...
> >      ==================================================================
> >
> > - Add jump_label_init() calling before kasan_init() in setup_arch() in these
> >   architectures: xtensa, arm. Because they currenly rely on
> >   jump_label_init() in main() which is a little late. Then the early static
> >   key kasan_flag_enabled in kasan_init() won't work.
> >
> > - In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
> >   because kasan_init() is enabled before main(), there's no chance to operate
> >   on static key in kasan_init().
> >
> > Baoquan He (12):
> >   mm/kasan: add conditional checks in functions to return directly if
> >     kasan is disabled
> >   mm/kasan: move kasan= code to common place
> >   mm/kasan/sw_tags: don't initialize kasan if it's disabled
> >   arch/arm: don't initialize kasan if it's disabled
> >   arch/arm64: don't initialize kasan if it's disabled
> >   arch/loongarch: don't initialize kasan if it's disabled
> >   arch/powerpc: don't initialize kasan if it's disabled
> >   arch/riscv: don't initialize kasan if it's disabled
> >   arch/x86: don't initialize kasan if it's disabled
> >   arch/xtensa: don't initialize kasan if it's disabled
> >   arch/um: don't initialize kasan if it's disabled
> >   mm/kasan: make kasan=on|off take effect for all three modes
> >
> >  arch/arm/kernel/setup.c                |  6 ++++++
> >  arch/arm/mm/kasan_init.c               |  2 ++
> >  arch/arm64/mm/kasan_init.c             |  6 ++++++
> >  arch/loongarch/mm/kasan_init.c         |  2 ++
> >  arch/powerpc/mm/kasan/init_32.c        |  5 ++++-
> >  arch/powerpc/mm/kasan/init_book3e_64.c |  3 +++
> >  arch/powerpc/mm/kasan/init_book3s_64.c |  3 +++
> >  arch/riscv/mm/kasan_init.c             |  3 +++
> >  arch/um/kernel/mem.c                   |  5 ++++-
> >  arch/x86/mm/kasan_init_64.c            |  3 +++
> >  arch/xtensa/kernel/setup.c             |  1 +
> >  arch/xtensa/mm/kasan_init.c            |  3 +++
> >  include/linux/kasan-enabled.h          |  6 ++++--
> >  mm/kasan/common.c                      | 20 ++++++++++++++++--
> >  mm/kasan/generic.c                     | 17 ++++++++++++++--
> >  mm/kasan/hw_tags.c                     | 28 ++------------------------
> >  mm/kasan/init.c                        |  6 ++++++
> >  mm/kasan/quarantine.c                  |  3 +++
> >  mm/kasan/report.c                      |  4 +++-
> >  mm/kasan/shadow.c                      | 11 +++++++++-
> >  mm/kasan/sw_tags.c                     |  6 ++++++
> >  21 files changed, 107 insertions(+), 36 deletions(-)
> 
> One part that's still missing is a Documentation change.
> 
> 
> >
> > --
> > 2.41.0
> >
> 


