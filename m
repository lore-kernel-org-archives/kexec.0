Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F336C5DF93
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjevPVNDI3BMq67YKVjzwksfTaXW8pJVyyPC7ES6lEo=; b=x1pEeVKs92k0Eb8M9KkUpQ7qrG
	y/JCUwV2JjZcpGR8WMODYQa4xvAdNZCNU87bYgWfaW4TihNxuc2V5KWh/5tTORLzsVpLAjqWfb1SH
	eebi0unUuElcNWb6Et3MdK/cdL2aEjRh306povhlHEN8+CQLWM3ZaYdPXVtbqi3fcF/Qpu4sBRUTZ
	H7+DQnBSbrQLchQZb4qBQsXDgJQ9OLwH/O3IwVYk9Jeziwd89BiGYSsdVtSgBjGFxWXi9GGzDA0bs
	aT4fooIEQZyJBL2WvTDnrrSla6qlqpq3pAqVDYKvq+9zmAVMW0f3z8WNYQXc58aOo5YLzMJMDimKR
	WuZ56Zfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQcm-0000000Db1m-3puu;
	Fri, 21 Aug 2026 14:53:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQcl-0000000Db1c-1p03
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:53:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D5E9F43F01;
	Fri, 21 Aug 2026 14:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4501F000E9;
	Fri, 21 Aug 2026 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787324018;
	bh=gjevPVNDI3BMq67YKVjzwksfTaXW8pJVyyPC7ES6lEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEqLsZh8icemV6iCXLH8M1lwsuZIi3ppcJsoYkHbdgbhu48kCp/fzBVJmA+oO0f10
	 A3T8kuGkGfXWM3lFtPhlABSA/ZLi5QI1UlAez8YchNUOWf6MIbU+Sq4O/RMx+ddJzd
	 zX6mfViDwm9H4ky1grMR/7zMfO1HJVHZDI3kQdGakxl87mqdNfF2T069ytU4DpBR1R
	 uUfOlu07HhdXWSEZcB7TpoBFiRx5U3OuBGcOl/m1t38yanYpaMdnHgb6oRM9K+QoCP
	 Eur4/KYp8ziJXcXNbn3YRLL+yg8AgCvW4WKrQs5/fx9CGAIg6Vr6CfnI0j0QFnUrbm
	 1CtXL9ud/p8iw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 686B8198003A;
	Fri, 21 Aug 2026 10:53:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 21 Aug 2026 10:53:36 -0400
X-ME-Sender: <xms:bWaIahUo1Hb5TY7rwvXWZqiIQCsFm7HQZRTqnTRCmeUTDs2vDO3M7g>
    <xme:bWaIavA0jrACtIJfZNvxMZnB6LY5W3K6xw9sI5Oyjio_OXkiu-Rald-HEwNdcbwFs
    EFnhJ08yslj1tzcI-YdxlzsNHQDfk7etgZCI4hvkpXcYkXmd4O0sY1J>
X-ME-Received: <xmr:bWaIatXlrPt1A9pRHHG3TomUuLeZgaxqix4gL1TQUGJ1yocmnUjHoi5KShA>
X-ME-Proxy-Cause: dmFkZTEbg+VVSOlsbnGiy6K3W4JLvpYCkMXlScxQEGLLdOvOtuyrQIKV5vXx+5KSTZnied
    1BL05bKU0wpXElyHPT96soPhyznOA9yhQkJWdpXI71jCNZvHn/c8VAuX2g4/alGQJvz1qd
    B6T1tx9pKoO/3Xnvauupxnqq2zICVzTk4UBlHScruUUmAP9mnk/qzNvZQc+jf4jpBBOpED
    xE+2fgXCydrOnnCVlfS603l+zfBqCrVei/CtHb7spiwvo3P4OCFzG/j5TiRRMOyLcK4pgg
    ZSlRN9jwxfCyD9ZxG09NOzC4Ou0Dq8l4ppVyOBSA9VAPYEjjLuSug642uKL0/SMdJGusT8
    FyQeFVv5+gCq6v82m5C+dc3R+HvKciPH93C1bDuVeIW4IkUVggKfOTqwr4KKZy3emCTP+n
    DBukM1AbkGCTiOllFIoIrYoui9xfTNkWipsxWRgRoasgv7YwnRXH5aQZquW9snqERvi/Xs
    R0upe+kYPe/qNbREEIgpWHKovwhkbXElaYqKpMSBzNUq1tliCfVcEBRiTFlkTSmPwDqgrW
    ibYpBtd+fq2PrhOJ9Bklg/CSpV2hTOVcWUlpUl15BIC4Ze+TqxA907+2A7dBb9OARMk/T8
    nYgNX66kQKWXnHcaCI9pVHv1DteFjCk363spGtTWHEjy145SOc0yJlhjjcWg
X-ME-Proxy: <xmx:bWaIal_Su38VzUHm5aZb5ee-a0Xap4tAuQbnDctK1GAi4ze5g8Uy-Q>
    <xmx:bWaIarlEUp7XaB1sCVXjYocrfIRLRmUk01Zsvst5zTvva0SwLs4H5Q>
    <xmx:bWaIaoKqrww3YI_6W-VqhpR6EMrBfw132AL-VJxCcnDhIAw2aruieA>
    <xmx:bWaIaprOpW83gjEzL46Meqyz_1QQ8ZhkWmKqehA-02uQYv0Zk58lew>
    <xmx:bWaIatSyPscqY50xMTnar5di4kwbi2endQokP4zfKYafYoSxjsRuGgoR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 10:53:33 -0400 (EDT)
Date: Fri, 21 Aug 2026 15:53:32 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] efi: respect the poisoned pages coming from
 previous kernel
Message-ID: <aohldTtzE2GJ76md@thinkstation>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
 <aog_uH5fTsJzXjjx@thinkstation>
 <aohIF6MmjiQpbz5j@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohIF6MmjiQpbz5j@gmail.com>
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

On Fri, Aug 21, 2026 at 07:03:06AM -0700, Breno Leitao wrote:
> On Fri, Aug 21, 2026 at 01:13:55PM +0100, Kiryl Shutsemau wrote:
> > On Fri, Aug 21, 2026 at 03:06:06AM -0700, Breno Leitao wrote:
> > > +	/* Reserve the table itself so it survives a further kexec. */
> > > +	memblock_reserve(PAGE_ALIGN_DOWN(ppm),
> > > +			 PAGE_ALIGN(ppm + sizeof(*pm) + bitmap_size) -
> > > +			 PAGE_ALIGN_DOWN(ppm));
> > 
> > Hm. I don't think it is enough.
> > 
> > On x86, kernel doesn't keep memblock around after boot (see
> > CONFIG_ARCH_KEEP_MEMBLOCK). Reserving in memblock exclude the memory
> > from page allocator. But kexec can place the image there.
> 
> You mean the third kexec?
> 
> 1) Kernel A hits an ECC error and marks page X poisoned.
> 2) Kernel A kexecs into kernel B, which won't use that page since
>    it's in EFI_POISONED_PAGE and memblock-reserved.
> 3) Kernel B kexecs into kernel C, which doesn't respect
>    EFI_POISONED_PAGE.
> 
> Is this the scenario you mean?

No. I think nothing prevents kernel B from putting kernel C image into
the reserved space in !CONFIG_ARCH_KEEP_MEMBLOCK case.

Kernel B excludes poisoned memory from buddy allocator, but kexec
doesn't care about this when look for placement for the next image.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

