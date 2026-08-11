Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2EAC5CFC1
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+5L98aL3Gaq0Oa3J1h7rtYhrwqEXKEC4NPIDmDwKQQE=; b=fUxfwwbU02QTS1MeZmQ3nPU4iB
	Q8yclSxQmu8Rw0rOXRD/QTe3VyyS6xQE0Nz7lp855kaIbpxfPAgVvGGf5eq2lCETVZQxRAstHqVmb
	eApmJy3j49Uig/vhTEO15ueKurLbK2PwoU247YNoHTr2dYsXqpeQQ0mPsNV/6kKxa94wR3lhy6HVe
	yar9z8p13I5+9d9cvsXc8RodKnFo3V7/AYCd0odVem9Z1iXnynNCms2wbepg8funGZzaUEOB1vF2G
	qwax6kFYxfVo3TjkL630b2mq8rxDKSBNJEccXr376U4fUyA0Kx6kX7WGn1lNwqg54Jpwhd0Brg2m5
	1bSBlRQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkUp-0000000DuyX-187e;
	Tue, 11 Aug 2026 11:18:15 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkUm-0000000DuxU-2BB7
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 11:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+5L98aL3Gaq0Oa3J1h7rtYhrwqEXKEC4NPIDmDwKQQE=; b=m8UBuuRTXedkiO3V4fRfUD2kbt
	a/SkK1GFzjp95gHT40ScUNlBcaU814L3AdjJBTbHWkC5gWRRJ2if6KKMEZ8AVvkn5ZT/aGxkWkYf9
	xZG+IqWKsp4MwIqnczBmPDyt/nEiFhJn/JnypNDfJzgtZb8nPJY4XjtmvNgejzOYgqqxaTyZb6SjW
	hji09+ZiQiXSl12vNVnbcHzpU3c/qn65pOo1MFFZ92Z44WWrj6RehLL4/kTBWxkuKsCuy7RCJ0ixU
	b/qcVZvS7oYlFbATBAcJo1AGnoGpsubsaSlT9CKyqACjT5uAZab5EooNN97kq/Bresb6pTXTbGnDD
	/TubT9iw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtkUN-003Wad-2h;
	Tue, 11 Aug 2026 11:17:48 +0000
Date: Tue, 11 Aug 2026 04:17:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anr59P1ZCAuHxv6x@gmail.com>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
 <ann9Kcesyb4T9Z8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ann9Kcesyb4T9Z8b@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_041812_559402_713F0C8E 
X-CRM114-Status: GOOD (  33.73  )
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

On Mon, Aug 10, 2026 at 07:32:41PM +0300, Mike Rapoport wrote:
> Hi Breno,
> 
> On Mon, Aug 10, 2026 at 06:32:04AM -0700, Breno Leitao wrote:
> > Memory failures (such as unrecoverable ECCs errors) are getting more and
> > more common. The kernel knows how to handle it while running, marking it
> > as poisoned (and SIGBUS user tasks).
> > 
> > Poisoned memory is removed from the buddy allocator, but, not from
> > other places. A current problem is that kexec will load new kernel
> > on top of a bad/poisoned memory, which is undesirable.
> > 
> > If the next kernel's image, initrd or purgatory lands on poisoned frame,
> > the relocation copy writes to the bad memory and the machine checks
> 
> What does the machine check here? ;-)

Not sure I got your question right. Did you mean:

1) that there is no machine check exception when *writing* to poisoned
   memory, or

2) just that "the machine checks" is a lousy way to write it?

For 1) I think you are right, and I had not thought it through. The MCE
(or a recurrent multi-bit ECC) would come from consuming the error, so
a load or an instruction fetch, and a store may well pass silently and
leave the poison sitting there.

The read back is what gets us, though. 

So the sentence should hang on the read, not on the copy. Would
something like makes more sense?

        If the next kernel's image, initrd or purgatory lands on a
        poisoned frame, the relocation copy puts them on memory that is
        known bad.

	The error is consumed on the first read back, whether
        that is purgatory checksumming the segments or the new kernel
        running from them, and that is what we want to avoid.

> > Skip hardware-poisoned frames when placing segments: check them in the
> > kexec_file hole finder so it lays the next kernel down on good memory,
> > and reject a poisoned destination in sanity_check_segment_list() for
> > the kexec_load path, which cannot relocate.
> > 
> > The two hole finders walk in opposite directions, so each asks for the
> > end of the poison it has to clear: the top-down walk for the first
> > poisoned page in the window, the bottom-up walk for the last. A poisoned
> > hugetlb folio counts in full, as hugetlb keeps the flag on the folio and
> > the poisoned subpages on its raw hwpoison list.
> 
> I had hard time parsing these two paragraphs. Can you please add more human
> touch to them?

Sure, but that would cost more. :-) 

What about something like:

	Skip hardware-poisoned frames that were detected by machine
	failure subssytem earlier when placing kexec segments.

	To do so, add a helper that reports the first or the last poisoned page
	in a range: memory is walked top-down by locate_mem_hole_top_down() and
	bottom-up by locate_mem_hole_bottom_up(), so each direction needs a
	different answer to jump clear of the poison.

	kexec_load() gets its destinations from userspace and cannot move them,
	so there sanity_check_segment_list() just rejects
	a a segument/memory block that happens to have a posioned page.

	is_page_hwpoison() also covers hugetlb, where the flag sits on the folio
	and the bad subpages on its raw hwpoison list, so a poisoned hugetlb
	folio is skipped as a whole.

> > +		poison = range_first_hwpoison(temp_start, kbuf->memsz);
> > +		if (poison != PHYS_ADDR_MAX) {
> > +			/* we hit a poisoned page */
> > +			if (poison < kbuf->memsz)
> > +				return 0;
> 
> Won't we break out on the next iteration boundaries check? I.e.
> 
> 		if (temp_start < start || temp_start < kbuf->buf_min)
> 			return 0;

Kind-of.  Sashiko keeps raising this underflow in the function, on every
revision since v2.

It dismisses it on this hunk because of the check, but reports it as
a real one on the two "temp_start = temp_start - PAGE_SIZE" paths above,
which do the same subtraction with nothing guarding them. 

Happy to remove it from here and send that as a separate patch.

> > +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> > +
> > +		cond_resched();
> 
> cond_resched() for every pfn is too much, isn't it?

It is what the other pfn walkers do: the kpageflags read loop in
fs/proc/page.c and read_page_owner() in mm/page_owner.c both call it
once per pfn. 

But I honestly don't have a strong opinion here, though, happy to batch
it if you prefer. Would this one look better?:

	if (!(pfn % MAX_ORDER_NR_PAGES))
		cond_resched();

Thanks for the review,
--breno

