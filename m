Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C12C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5l/3IP2HFVsa8eAqLOCa4UVEPVokMRetreMKGr2fkq8=; b=NcOEIcLP5SZN51oW5Kp6oir0vi
	MnlK8pcjSN2t3Gvof1+oWA2aPhcd/sFl/QPwaU6ygsU91+yqWWmZ8sctYC6I8nOYxMQVMtFxgB+Fp
	lwy8L4HFMUn7hin2bDTwGY95xtbmTv/71Yal6jo43pszmvFsk3hAMZeMBvpTpzMS5Xv0yeQoz/ASu
	Sbz9y2FUF/3PqKbMknw3KXZBdYj1Vx6QAeLNvBT2WNvpcnBPhUYZi1cmBNTKFnwKfpmKO12kzh3fE
	glAfV+7HKxcNh3ve8uFHGDusVObK9rK6tNp7tawo7kFYmrk/lk8gZpavELGSOhR9Wo01XkZ2Hq+nh
	q3HaazQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp7SF-00000008cTE-0uBl;
	Wed, 29 Jul 2026 16:48:27 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp7SC-00000008cSA-32Hf
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 16:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5l/3IP2HFVsa8eAqLOCa4UVEPVokMRetreMKGr2fkq8=; b=RURRz7s4klLVjJ1u0nsrHmmDI2
	6huTDWCqNbHC3TPf0/VNEPWfxkndui6XU+JXSJ5DpiG9Qi+EUKSg4YlxYA6+5HjOpyF2NxbmdCB3I
	IfR83VyRoPifX3SADc9MenUDDOtKZw0lYlmnfHMJPbb1HIJIqxoT5aXFs92TE9vl49F6zdifEni7a
	blLi764oJSrTG//yH0piQUMUN/oQIEgokEdkEQvvL2j8jVreJm3kJfX93CpYZFqCRfPDQUmSTN50+
	cLtQzbV2968XW4fGsJqnxrmj9Ybh5aB+R6HC3JPwKPRFxS1e0CN75gFL78YRohH6HKxwQxxhtu/96
	5xvXvn6Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp7Rj-008amb-2s;
	Wed, 29 Jul 2026 16:47:56 +0000
Date: Wed, 29 Jul 2026 09:47:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] kexec: keep the next kernel off hardware-poisoned pages
Message-ID: <amogZHzDyp8lvrQG@gmail.com>
References: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
 <2vxz7bme80vm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz7bme80vm.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_094824_767038_794917E7 
X-CRM114-Status: GOOD (  31.42  )
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

On Wed, Jul 29, 2026 at 01:57:01PM +0200, Pratyush Yadav wrote:
> On Tue, Jul 28 2026, Breno Leitao wrote:
> 
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
> > during the kexec.
> >
> > Skip hardware-poisoned frames when placing segments: check them in the
> > kexec_file hole finder so it lays the next kernel down on good memory,
> > and reject a poisoned destination in sanity_check_segment_list() for
> > the kexec_load path, which cannot relocate.
> 
> kexec_locate_mem_hole() uses kexec_alloc_contig() to try to find a
> contiguous range from CMA. If found, it uses that and skips relocation.
> Do you know if CMA tracks poisoned pages and skips allocating them?
> 
> sanity_check_segment_list() will catch these anyway and error out, but
> would be nice if CMA can track poisoned pages in the first place.
> Anyway, that is out of scope for this patch, but something you might
> want to look into.

Good point, I understand CMA already avoids them: alloc_contig_range()
runs in PB_ISOLATE_MODE_CMA_ALLOC, where a HWPoison page counts as
unmovable, so isolation returns -EBUSY and cma_alloc() routes around it,
no?

> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -504,6 +504,13 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
> >  			continue;
> >  		}
> >  
> > +		/* Avoid placing the next kernel on hardware-poisoned memory */
> > +		if (range_contains_hwpoison(temp_start,
> > +					    temp_end - temp_start + 1)) {
> > +			temp_start = temp_start - PAGE_SIZE;
> 
> Sashiko complains about this
> https://sashiko.dev/#/patchset/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org:
> 
>     If we find a hardware-poisoned page within a large segment, does this loop in
>     locate_mem_hole_top_down() cause a CPU soft lockup?
> 
>     Since temp_start is shifted by only PAGE_SIZE, the next iteration will call
>     range_contains_hwpoison() again. As seen in mm/memory-failure.c, that
>     function does a linear scan from the new start address:
> 
>     	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
>     		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))
>     			return true;
>     	}
> 
>     This means we could rescan almost the entire segment over and over until it
>     finally moves past the poisoned page. For a very large segment like a 512MB
>     initrd, this would iterate billions of times without yielding.
> 
>     Could range_contains_hwpoison() return the address of the poisoned page so
>     the hole finder can skip past it efficiently?
> 
> Which does seem to make sense. Same problem below.

Agreed, that could be a real problem. Returning the poisoned page
address from range_contains_hwpoison() would work but feels awkward
for a predicate function.

Let me think through a cleaner approach.

Thanks for the review,
--breno

