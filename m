Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD343D7496A
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k/1A4ohyblOaTc0UavBxprXVoIV+K4VX6U5X1bS1U9U=; b=0OMKou0Sg6LqRRAlczYsnScXNY
	a0sdNaMtfs/iq4tOB2yWkWg5N+uuj8gF33HFuQmWaB/3a09E0QAMYs8mg3lcXmO7soV1RB9LuvZbn
	2TPvz3i7S4R3zndtHldB8Bo7Mfh8ukOQEAgpo01Tf/7/a7R/Okd4LzpTMJEfnxdO94BevVErFQrqL
	4LCeQRyAfa3mG5Z4JMVUS+63AlZNgX61nFKEJkuXkBYplMUeKcfJntZelgSgW+OaiyEvb29c3T9T9
	dMj3XMR0HnqYw89jV5JrhvXUfAqKeHXDg2r7CaZTk/N/Xe2VF5ufprtIknjgUhgx0NpbSyjR1t8Au
	NH8SCWVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWeF-00000009vq0-2mNQ;
	Fri, 19 Dec 2025 09:19:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWeE-00000009vpd-2RzQ
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 09:19:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADC2F600AA;
	Fri, 19 Dec 2025 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB0C4CEF1;
	Fri, 19 Dec 2025 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766135981;
	bh=PO6v/fWv1Mc8WnsslILLXQGaglGO94u1Qqdt6Qqrmfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGRZKEmBCsW1m5GIxZjWaZh9bzgvAtULm9UOSbnMH0muoSNjNpkZn2qEjD2VIMB1t
	 VJN04JQCI7MEjUfFHNCieyAFihZpXWzTTqnzV4zzOfrdgRBXchL0QtsDfygAeV9Zer
	 0eOB0sQNomMcB6Eki4Os2O4lzyVaY/ldcEAF40Jlu4bAgL0F5taqxBKSy/bbFK1Yoi
	 t5H7gdsY8GyZml2iSYhg9LdJ1Vrh8qS6IP7K7ou7AQbkg8o7sRzoj8eqjsYwVRoerS
	 h+I8QLbXGsT1+d71RygPScj38IKjgj1Pwbnh+vznbyRgkxMSXE09rB6J7b2EA4F6xQ
	 9P5Yb5hezZGhQ==
Date: Fri, 19 Dec 2025 11:19:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aUUYprAotKYMiEs0@kernel.org>
References: <20251216084913.86342-1-epetron@amazon.de>
 <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org>
 <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
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

On Tue, Dec 16, 2025 at 10:36:01AM -0500, Pasha Tatashin wrote:
> On Tue, Dec 16, 2025 at 10:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> > > > > +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> > > > > +                                               unsigned int order)
> > > > > +{
> > > > > +     unsigned long pfn = PHYS_PFN(phys);
> > > > > +     int nid = early_pfn_to_nid(pfn);
> > > > > +
> > > > > +     for (int i = 0; i < (1 << order); i++)
> > > > > +             init_deferred_page(pfn + i, nid);
> > > >
> > > > This will skip pages below node->first_deferred_pfn, we need to use
> > > > __init_page_from_nid() here.
> > >
> > > Mike, but those struct pages should be initialized early anyway. If
> > > they are not yet initialized we have a problem, as they are going to
> > > be re-initialized later.
> >
> > Can say I understand your point. Which pages should be initialized earlt?
> 
> All pages below node->first_deferred_pfn.
> 
> > And which pages will be reinitialized?
> 
> kho_memory_init() is called after free_area_init() (which calls
> memmap_init_range to initialize low memory struct pages). So, if we
> use __init_page_from_nid() as suggested, we would be blindly running
> __init_single_page() again on those low-memory pages that
> memmap_init_range() already set up. This would cause double
> initialization and corruptions due to losing the order information.
> 
> > > > > +
> > > > > +     return pfn_to_page(pfn);
> > > > > +}
> > > > > +
> > > > >  static void __init deserialize_bitmap(unsigned int order,
> > > > >                                     struct khoser_mem_bitmap_ptr *elm)
> > > > >  {
> > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
> > > > >               int sz = 1 << (order + PAGE_SHIFT);
> > > > >               phys_addr_t phys =
> > > > >                       elm->phys_start + (bit << (order + PAGE_SHIFT));
> > > > > -             struct page *page = phys_to_page(phys);
> > > > > +             struct page *page = kho_get_preserved_page(phys, order);
> > > >
> > > > I think it's better to initialize deferred struct pages later in
> > > > kho_restore_page. deserialize_bitmap() runs before SMP and it already does
> > >
> > > The KHO memory should still be accessible early in boot, right?
> >
> > The memory is accessible. And we anyway should not use struct page for
> > preserved memory before kho_restore_{folio,pages}.
> 
> This makes sense, what happens if someone calls kho_restore_folio()
> before deferred pages are initialized?

That's fine, because this memory is still memblock_reserve()ed and deferred
init skips reserved ranges.
There is a problem however with the calls to kho_restore_{pages,folio}()
after memblock is gone because we can't use early_pfn_to_nid() then.

I think we can start with Evangelos' approach that initializes struct pages
at deserialize time and then we'll see how to optimize it.

-- 
Sincerely yours,
Mike.

