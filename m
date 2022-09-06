Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72535ECAAA1
	for <kexec@archiver.kernel.org>; Tue,  6 Sep 2022 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ixFy/Jkwpz2dpWut9yxT0t3CE8BAheK/xFWtbGiY5VM=; b=K3FO0gMZYrJL9Z
	zn+0w5qAL5EEIbUzPO4iP4OApVK+imXVheNhHzyeBqGdyX+2TYQSFyWRb+Qy2mfsxMGuNGYHkdfMb
	PpEQImYNnan8jea2N4Yh9yK9/445zWsuZGiJY2LlrcvGdMKUdfhQIKHIkU52SiVGjtEtcOTJTQ8FZ
	kvnkZqm6Ev+SeKi8m5jCoYdOumpR2b6lhE25L2nOuKJA9qu3XGJBEQbISCXu19nspajhBk+iHrxCL
	kppAk+s0e+02mQFKNp/lW5zhPU7iRVaZw+KQ4cc2S+xFS+GCkXOqk0zrrPZsVKov3heXE7H/01V/q
	IU9TuNHmpNzC6MzubnZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYHP-00DazT-KJ; Tue, 06 Sep 2022 13:06:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYHM-00Davt-No; Tue, 06 Sep 2022 13:06:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6A4C261520;
	Tue,  6 Sep 2022 13:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF5FC43142;
	Tue,  6 Sep 2022 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662469570;
	bh=SpJwzV1xxdG6E2zoG7fCWE2FmuhYoDXFoduBgrxJB7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P9Jkwttt41HrjTVur3ZqETnRMvK58FTsAzgZLcpPZ35bdKjOGFvBScTvkOWJ1Eb3k
	 z8Hzmpt8jKHwnZGT57f204iRkETZPzKn+Qzp5hxVzwJNuXteKCXoBbx+NiPdfNXxMK
	 Z2UvStBU1e2LEKi5/rSBSEghkyxEpRxs9HAn44ESRK4QOj7BSXbkdRZKDg0NoqXE7V
	 d3jKY902T/Dyi+RoCalF93V8QRvjEOJK47uebGefSjC0tJ2BUmdkIsdoWMGG6ohzWy
	 hANxH2zRtxXNRNNgs4RNvXu26c80Nnn+2BYFVaeXa15L5GdGeLBzdjOAd68R34JivP
	 reC3sJxNLWdLg==
Received: by mail-lf1-f47.google.com with SMTP id q21so3062650lfo.0;
        Tue, 06 Sep 2022 06:06:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo1g8RVs5IlvXyC7TDvMRj6haXwPxsL4PSV/fSMGT2odfry0JVwu
	GRx29bt5xfBqPpAQTbB9BrgQshtD43QHDMtUE5A=
X-Google-Smtp-Source: AA6agR5KiKCBtGu2NBHkajuKIN42XAzBbIS0deO+9CVIZbXoRkhIM737KmO+1cMcIxjM/6nXhMP1jgMcKij1ryQ7XfE=
X-Received: by 2002:a19:9113:0:b0:494:ad39:7d03 with SMTP id
 t19-20020a199113000000b00494ad397d03mr5907458lfd.122.1662469568765; Tue, 06
 Sep 2022 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220828005545.94389-1-bhe@redhat.com> <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org> <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org> <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org> <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
In-Reply-To: <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 Sep 2022 15:05:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
Message-ID: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
To: Baoquan He <bhe@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	guanghuifeng@linux.alibaba.com, mark.rutland@arm.com, will@kernel.org, 
	linux-mm@kvack.org, thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com, 
	kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_060612_872100_4014AB4E 
X-CRM114-Status: GOOD (  23.10  )
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

On Mon, 5 Sept 2022 at 14:08, Baoquan He <bhe@redhat.com> wrote:
>
> On 09/05/22 at 01:28pm, Mike Rapoport wrote:
> > On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> > > On 09/01/22 at 10:24am, Mike Rapoport wrote:
> > >
> > > max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> > > the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> > > it like:
> > >
> > > static phys_addr_t __init crash_addr_low_max(void)
> > > {
> > >         phys_addr_t low_mem_mask = U32_MAX;
> > >         phys_addr_t phys_start = memblock_start_of_DRAM();
> > >
> > >         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > >              (phys_start > U32_MAX))
> > >                 low_mem_mask = PHYS_ADDR_MAX;
> > >
> > >         return low_mem_mast + 1;
> > > }
> > >
> > > or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> > > as you suggested. Which one do you like better?
> > >
> > > static phys_addr_t __init crash_addr_low_max(void)
> > > {
> > >         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> > >             return PHYS_ADDR_MAX + 1;
> > >
> > >         return max_zone_phys(32);
> > > }
> >
> > I like the second variant better.
>
> Sure, will change to use the 2nd one . Thanks.
>

While I appreciate the effort that has gone into solving this problem,
I don't think there is any consensus that an elaborate fix is required
to ensure that the crash kernel can be unmapped from the linear map at
all cost. In fact, I personally think we shouldn't bother, and IIRC,
Will made a remark along the same lines back when the Huawei engineers
were still driving this effort.

So perhaps we could align on that before doing yet another version of this?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
