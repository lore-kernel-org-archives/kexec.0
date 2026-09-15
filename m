Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D9C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szNMGe0DObGeR+SwRrUoeZsesJIvyvHlKuWjShKq/XM=; b=uDCSj1vvps8KYQyzb7ci9gpxQs
	zRIndlbo3+Ck3Bf5SoDoGCDjj0XSsdmeQj/qD0gSg8hvzInJ6U9TRyDRvh1X/uMrjK47fLG5Q7q/K
	iACjVywn/Y9l/JFlFsBHXZp8xbQgpPEKDwTGyy070D5jEwGfd7PI/UF2/ZPKvOtLSZ5y5Nle4oQr3
	DES0El2JXuMVjvUV3ZYdhbCF+fJ7xt357EqguLGTiqFSfg0ZcBxjiqTKbVQdqIiFGIypXeBAD5eEx
	R1qvStqrC7lU6xFZoX70abDyt4YeejbnA3wueR3QFUKDx5A1MXDZi3W3lgTHNHMoUOY9K854L2V2h
	pb9M6S0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TGA-00000006kE7-1Swp;
	Tue, 15 Sep 2026 13:31:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TG8-00000006kDe-3AWP
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:31:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 27A1C43C5C;
	Tue, 15 Sep 2026 13:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE8D1F000FF;
	Tue, 15 Sep 2026 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479100;
	bh=szNMGe0DObGeR+SwRrUoeZsesJIvyvHlKuWjShKq/XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bxgsy2BH8vB1k6x/MwDXjlbNVwjyZEYkY8k9e3PdVaD+xjsGtBcSM9mJabPOrJUzz
	 kd+tHYqRrKZEq87R5a8vsjCkYvifnJ8NtGCJawmHnVkZckYqaVj42qfBwQldxWKjGN
	 lGHVDHinmGCkNbzgPmoE22Y75nwCu0vz4nOwIRCQC+CkloWdVLGFpJuKkkt6yR3sjn
	 nFZNRopmz55BHRoMcDgESNpOC07YvQkifLyL9ERd9uVTHuFnJV5FTShXlo1wH1UfV3
	 opo03/Dn1lTUHe5SWpC77GI5+3vj4S6E08Us84DlyhteMV2n/GNLKKz3llO3ZNCFst
	 ILzESzN/1go0Q==
Date: Tue, 15 Sep 2026 14:31:38 +0100
From: Harry Yoo <harry@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqlFnuIIECOyaweo@thinkstation>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
 <aqkIdVhoG2wwVBtb@gmail.com>
 <aqkyT0Ui9h5KWuzn@thinkstation>
 <aqk4NUnq92ftuUuJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqk4NUnq92ftuUuJ@gmail.com>
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

On Tue, Sep 15, 2026 at 05:39:44AM -0700, Breno Leitao wrote:
> Hi Harry,
> 
> Thanks a lot for the feedback.

Hi Breno, no problem!

> On Tue, Sep 15, 2026 at 01:12:54PM +0100, Harry Yoo wrote:
> > On Tue, Sep 15, 2026 at 02:03:48AM -0700, Breno Leitao wrote:
> > > On Thu, Sep 10, 2026 at 06:11:53AM -0700, Breno Leitao wrote:
> > > > So I'd say we have two options:
> > > >
> > > > 1) Keep it similar to unaccepted memory, with 2M granularity.
> > > >    - Pro : Similar mental model as unnacepted memory
> > > >    - Cons: 2 MB might be a bit wasteful
> > > >
> > > > 2) Move to a linked list like the RFC, keeping it outside of the EFI
> > > >    table.
> > > >    - Pro: Reduce the memory granularities to page instead of 2M blocs.
> > > >    - Cons: Another way of passing memory information between kexec
> > > >      kernels.
> > > >
> > > > Any any other option or strong preference?
> > >
> > > Since nobody voiced a strong preference, I will stick with option (1),
> > > the bitmap, for these reasons:
> >
> > Not sure if this was discussed already, but perhaps we need to have
> > a chain of struct linux_efi_poisoned_memory rather than a single
> > bitmap, to easily add support for hot-added memory later?
> 
> Agreed, that's a good point. We could extend linux_efi_poisoned_memory
> with a ->next pointer, so that if we ever add hot-plug support later, we
> can link in another linux_efi_poisoned_memory. 
> 
> That said, I'm not sure hot-plug memory is really relevant here. Hot-plug
> is mostly used in VMs, while this feature is more host-side, so it doesn't
> seem like a great fit. Maybe it would only matter for servers where
> physical memory can be added while running (do those still exist? I
> recall IBM offered that feature at some point, but I'm not sure there are
> real customers for it).

IIRC CXL memory modules can be set up either by firmware or hot-plugged
after boot. Not sure how common the latter case is (or will be) in
practice, though.

> > Also, I wonder if some architectures have a scattered set of pfn
> > ranges so that the span from the start pfn to the end pfn being much
> > larger than the actual physical memory size.
> >
> > If so it might make more sense to have a bitmap for each pfn range.
> 
> Agreed, having a ->next in linux_efi_poisoned_memory is a good idea that
> we can lean on depending on whatever problem comes up down the road.
> 
> Very good point — let's keep this linux_efi_poisoned_memory chain idea in
> mind for whenever we need to expand it.

You mean 1) keeping the structure as-is for now (and expand later with
new EFI table version) or 2) adjusting the structure in the future
revision of this patchset?

-- 
Cheers,
Harry / Hyeonggon

