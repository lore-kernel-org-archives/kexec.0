Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D4C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pqqx6qyZK7hDaGMfpM7ctme4msTknL0M/1U1XtnHr1M=; b=hObGnBj4Z88yB8t5gF4qzVBcok
	CfwSW3kZekl8OC/l7p7unykfmlON1R8QOQiEHBB90bW0Jiz0g/JtFxdI8CWbIhVqx+CuKgwjnHFZO
	/0Hlrl6Ex3v2e7HLf/8UvLwz8Dcrwy8N1gp7s/iVLSbmaqD0Ovb13D7dOhwKBXXAv/4xDgpGVcEcE
	qpToarAibG5fjsuuw7CbbEdXWdNXH0x4SZZD7M3hFLIz2OMEMVmhcIFQ17ybIYxcISbPprT+K1dBn
	6zGLhDgCp75WCuiiUt8M8kYRerBvsUJHY0gWjAPwys6lKbYqnaFpmwJpAUh+6H/rDi5GBFkToXtmb
	wQTvbDmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SSO-00000006ZJv-1Ikt;
	Tue, 15 Sep 2026 12:40:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SSI-00000006Z8L-3sjD
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 12:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Pqqx6qyZK7hDaGMfpM7ctme4msTknL0M/1U1XtnHr1M=; b=bUmgrfBWfLziT8CtR4wipdrnlQ
	kMiyijaoe9ugkN4z+LZkgvJxnTFjaxI8jgxtGw4p6tux5QPOL3wzJGjGcAjSqoe7LhYLwiHz19otV
	nT40gpQ9ksQo6lehovoUBwLE3o5qZB0zUELSelrt+eG55iUgB3O/PqV5EknY3lzEjfriwOzeolNWC
	GS8ECdMjflRcatdNREaAw0rSMRyp8wxyKCcyvcwSSg8uXLHwYvN+hauyWVKmBnuNj5VX0dpCZwq3R
	xF330a9TczNxRE17XAo34Wjc0niAq+aICkxji8Rt7AQAXQYgqyFAlnX0XGH9Lj0UtixT7IMcTbF8C
	UtKPQocA==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6SSF-00000006keA-3G4K
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=Pqqx6qyZK7hDaGMfpM7ctme4msTknL0M/1U1XtnHr1M=; b=huBfHert8ebhJsOV5HNhXjIL6i
	5hoDBf8pBN819FnWMjS07l+DapxPI5DgQs5AX8qKYVKDdOhXqpOC2FMR9E4k1ERdGl9gLRYa6uS7L
	29ZMZlV8O/OgrMSMPHHLn//ZifgJXlrn097+s/IzxtyrQ/x+0cTTCUE+CBjBIlTxVONVha3ghSzyU
	WbWX347JicsNYVyxS7O5iHBc5fdrfrnAA5+tFHy+mlF8v8LVSeJkNUDmq0F40jC7sd6Hp6tqBv7dB
	v/o0rxqmBw4kUMlPPOg5fHOhqQBLMlVAvYlYUIRvN2RhVwgBX90/49Nyn7l9HOVPICSYQFAbnlWwJ
	7dSC0UUg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6SS0-004Oba-0j;
	Tue, 15 Sep 2026 12:39:52 +0000
Date: Tue, 15 Sep 2026 05:39:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Harry Yoo <harry@kernel.org>
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
Message-ID: <aqk4NUnq92ftuUuJ@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
 <aqkIdVhoG2wwVBtb@gmail.com>
 <aqkyT0Ui9h5KWuzn@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqkyT0Ui9h5KWuzn@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_134007_908568_9D3CF169 
X-CRM114-Status: GOOD (  26.53  )
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

Hi Harry,

Thanks a lot for the feedback.

On Tue, Sep 15, 2026 at 01:12:54PM +0100, Harry Yoo wrote:
> On Tue, Sep 15, 2026 at 02:03:48AM -0700, Breno Leitao wrote:
> > On Thu, Sep 10, 2026 at 06:11:53AM -0700, Breno Leitao wrote:
> > > So I'd say we have two options:
> > >
> > > 1) Keep it similar to unaccepted memory, with 2M granularity.
> > >    - Pro : Similar mental model as unnacepted memory
> > >    - Cons: 2 MB might be a bit wasteful
> > >
> > > 2) Move to a linked list like the RFC, keeping it outside of the EFI
> > >    table.
> > >    - Pro: Reduce the memory granularities to page instead of 2M blocs.
> > >    - Cons: Another way of passing memory information between kexec
> > >      kernels.
> > >
> > > Any any other option or strong preference?
> >
> > Since nobody voiced a strong preference, I will stick with option (1),
> > the bitmap, for these reasons:
>
> Not sure if this was discussed already, but perhaps we need to have
> a chain of struct linux_efi_poisoned_memory rather than a single
> bitmap, to easily add support for hot-added memory later?

Agreed, that's a good point. We could extend linux_efi_poisoned_memory
with a ->next pointer, so that if we ever add hot-plug support later, we
can link in another linux_efi_poisoned_memory. 

That said, I'm not sure hot-plug memory is really relevant here. Hot-plug
is mostly used in VMs, while this feature is more host-side, so it doesn't
seem like a great fit. Maybe it would only matter for servers where
physical memory can be added while running (do those still exist? I
recall IBM offered that feature at some point, but I'm not sure there are
real customers for it).

> Also, I wonder if some architectures have a scattered set of pfn
> ranges so that the span from the start pfn to the end pfn being much
> larger than the actual physical memory size.
>
> If so it might make more sense to have a bitmap for each pfn range.

Agreed, having a ->next in linux_efi_poisoned_memory is a good idea that
we can lean on depending on whatever problem comes up down the road.

Very good point — let's keep this linux_efi_poisoned_memory chain idea in
mind for whenever we need to expand it.

