Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB49EE57FA
	for <kexec@archiver.kernel.org>; Wed, 31 Dec 2025 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puWMIkCqzvcukNc6entSGSZYTJ90NDZmrdy+34MYr64=; b=iIOmk6MAMujt6oQVEIwMR80oYi
	wtd/MWIC+3er/V9KcYwEzvAAkwqMKdXA7Y4czC2TLMSphlzWrZ+qT7hwJ3+jKhET5E2qOPkHVBJsY
	SkKP5Vl3jtPFyjHTj9A+8WcKD3Bx3q7rTfR1So5UWRZR9wdV2mgQw13UtnqR21kR2K7B2RGgjMKOZ
	xvX+eZqVxlFZQRJnqXKXRfbeNZPa860ch+/obz+vrNJfvV0LUfTLkeL+qWfaBDJQi1J2kuLTev+Pn
	v6PoYzrs0VxDXksteVGsYFiwimwoa59rQGxRGgXaaFLXVbEiA6NEpPxAbtAZWulpZPdT9eIj0QKOc
	mGH7rQWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vasn6-00000005qOE-2ST5;
	Wed, 31 Dec 2025 09:46:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vasn1-00000005qNs-3LSx
	for kexec@lists.infradead.org;
	Wed, 31 Dec 2025 09:46:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 90D0C40289;
	Wed, 31 Dec 2025 09:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05723C113D0;
	Wed, 31 Dec 2025 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767174406;
	bh=Js4gGVpGtn7C+f3YQhPLQtxd+Rpk3HniIelYKQQwOw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSe/zxSDWx34KjwRibmxVhaeoXwJc7vuj1CDNSJId3c2TQLzK6sKsUapbmCiuwwvR
	 fyJpfMDnR8SDywH+tRLlataLTsKEeSz8BqXp8Jaw+nWFiWCqO415Jjvm1xnRncfgaf
	 suBdOV+DX3COyxwr9fW360XBr/n01Hd3E4ULQoykp4RHuEc9JGdjsLPI3rd2pdLnGB
	 7z24kT3OG3AkMlWMQJPEOL9Zmxlhh7CPMXOhnGTc2E+E7t1OL2gL0l5lAKuE/pt2/y
	 kvg9uD40StmRSVnI1EfCiqw2nWitUEvF9Rh8kjXV9/2/TXGZMPXUtPzaAW80yIhbkt
	 DYSG5Henp/leQ==
Date: Wed, 31 Dec 2025 11:46:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aVTw_08W7zXR7Y0F@kernel.org>
References: <86jyyecyzh.fsf@kernel.org>
 <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org>
 <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org>
 <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
 <aVP6wBYoHJQsplIl@kernel.org>
 <CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
 <aVQJUPOn85WlJaM9@kernel.org>
 <CA+CK2bCm=AGDSLTbs6etbqveFUHU80okE-bCT2zg20nrHXgHRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCm=AGDSLTbs6etbqveFUHU80okE-bCT2zg20nrHXgHRQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_014647_895516_30E542BB 
X-CRM114-Status: GOOD (  31.48  )
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

On Tue, Dec 30, 2025 at 01:21:31PM -0500, Pasha Tatashin wrote:
> On Tue, Dec 30, 2025 at 12:18 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Dec 30, 2025 at 11:18:12AM -0500, Pasha Tatashin wrote:
> > > On Tue, Dec 30, 2025 at 11:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
> > > > > On Mon, Dec 29, 2025 at 4:03 PM Pratyush Yadav <pratyush@kernel.org> wrote:
> > > > > >
> > > > > > The magic is purely sanity checking. It is not used to decide anything
> > > > > > other than to make sure this is actually a KHO page. I don't intend to
> > > > > > change that. My point is, if we make sure the KHO pages are properly
> > > > > > initialized during MM init, then restoring can actually be a very cheap
> > > > > > operation, where you only do the sanity checking. You can even put the
> > > > > > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
> > > > > > it is useful enough to keep in production systems too.
> > > > >
> > > > > It is part of a critical hotpath during blackout, should really be
> > > > > behind CONFIG_KEXEC_HANDOVER_DEBUG
> > > >
> > > > Do you have the numbers? ;-)
> > >
> > > The fastest reboot we can achieve is ~0.4s on ARM
> >
> > I meant the difference between assigning info.magic and skipping it.
> 
> It is proportional to the amount of preserved memory. Extra assignment
> for each page. In our fleet we have observed IOMMU page tables to be
> 20G in size. So, let's just assume it is 20G. That is: 20 * 1024^3 /

Do you see 400ms reboot times on machines that have 20G of IOMMU page
tables? That's impressive presuming the overall size of those machines. 

> 4096 = 5.24 million pages. If we access "struct page" only for the
> magic purpose, we fetch full 64-byte cacheline, which is 5.24 million
> * 64 bytes = 335 M, that is ~13ms with ~25G/s DRAM; and also each TLB
> miss will add some latency, 5.2M * 10ns = ~50ms. In total we can get
> 15ms ~ 50ms regression compared to 400ms, that is 4-12%. It will be
> less if we also access "struct page" for another reason at the same
> time, but still it adds up.

Your overhead calculations are based on the assumption that we don't
access struct page, but we do. We assign page->private during
deserialization and then initialize struct page during restore.
We get the hit of cache fetches and TLB misses anyway.

It would be interesting to see the difference *measured* on those large
systems.

> > > (shutdown+purgatory+boot), let's not add anything to regress, as every
> > > microsecond counts during blackout.
> >
> > Any added functionality adds cycles, this is inevitable. And neither KHO
> > nor LUO are near the completion, so we'll have to add functionality to both
> > of them. And the added functionality should be correct first and foremost.
> > And magic sanity check seems pretty useful and presumably cheap enough to
> > always keep it unless you see a real slowdown because of it.
> 
> Magic check is proportional to the amount of preserved memory. It is
> not a required functionality, only a sanity checking. I really do not
> see a reason to enable it in production. All other sanity struct page,
> and pg_flags related sanity checking are usually enabled with
> CONFIG_DEBUG_VM, so enabling it only with CONFIG_KEXEC_HANDOVER_DEBUG
> is better.

Having sanity checks in production could be useful because some errors
could be hard to reproduce in controlled environment with debug kernel.

Just last cycle there was commit 83c8f7b5e194 ("mm/mm_init: Introduce a
boot parameter for check_pages") that allows enabling page sanity checks in
production.

So my take is to keep the magic check until KHO/LUO mature at least.

-- 
Sincerely yours,
Mike.

