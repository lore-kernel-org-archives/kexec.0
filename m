Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4355C56205
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpaSVlP8u6Eid71P/qQX5dIH8P+evmO5hE0RAEwaHnU=; b=0xVxbPy3myWls/UhVta0AXdNfd
	QR01NmFLNapqgdUJmHks97Vj1J533AHUsWBsV+0bnoq0TnFu5weu7I/0C8VwelliBsmJ+k2ihQvpt
	r+Wh+Ca3ZzC53mjJZdFlglsjgPFExvq2qSXZZlYHiGTDOpxw/yDcNuIDnZArOt1YDczu8lZ4nfNIn
	54X93MDEu3b1stC6q0x89ew2rEB3d7k3DMMT2kQ2EhTnzUrEzkCOCbKi3ToXbvqZvXIOllCq1wLrd
	LFN0j38n/NcyJTnhf5cW5hr+Cj0RGimB3L4WKbxknhy7AWmUrpiiC27GiOFunG0UPPiLzdyiJwL+u
	HvWhNP1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrzZl-000000062sK-1RXE;
	Thu, 06 Aug 2026 15:00:05 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrzZh-000000062oM-1IUC
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 15:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HpaSVlP8u6Eid71P/qQX5dIH8P+evmO5hE0RAEwaHnU=; b=SufsmgqI764RRJwteT9oL3Drw0
	qswd/2rocMBe7UFvQpwBlNGHgbG5NvEq6ZkUyGGqxUW8Hsf9bIziGDlRHqVSShHMy0bec+kpWEUYg
	NGn3dslhLfHFI04xiGBz4phHYSay76I0irDAut5J5zg+0bgcgyuWC7ocLhnzcFwDawbA0Xdv1lhEh
	jQkNg13S7O+fZ4RGYIAue6tG4GTYVK85CCU5BNvZciVei7c9dVy3fb9aqyv1ZwZV5V7KWaM+W8eh7
	jHTXrMB1zyyict4nmV7MTx1g+1C5emG9Nva2wQ6cBrE8xkIq8eMAOUoTfKTKlQBkPKmFsSuIurmpx
	kIqITZXw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrzZ3-00ElzJ-04;
	Thu, 06 Aug 2026 14:59:21 +0000
Date: Thu, 6 Aug 2026 07:59:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anSg01PFfu7aaEJp@gmail.com>
References: <20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org>
 <anH1JdVtiM9VoXMH@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anH1JdVtiM9VoXMH@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_080001_349868_0FBBFCF2 
X-CRM114-Status: GOOD (  19.38  )
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

On Tue, Aug 04, 2026 at 03:36:47PM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 03, 2026 at 05:41:10AM -0700, Breno Leitao wrote:
> > @@ -504,6 +505,15 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
> >  			continue;
> >  		}
> >  
> > +		poison = range_last_hwpoison(temp_start, kbuf->memsz);
> > +		if (poison != PHYS_ADDR_MAX) {
> > +			/* we hit a poisoned page */
> > +			if (poison < kbuf->memsz)
> > +				return 0;
> > +			temp_start = poison - kbuf->memsz;
> > +			continue;
> > +		}
> > +
> 
> Hm. Don't we want range_first_hwpoison() for top-down walk? Otherwise
> the end of range would land on poison.

Sure, In this case would have both,  range_last_hwpoison() for
locate_mem_hole_bottom_up() and range_first_hwpoison() for
locate_mem_hole_top_down().

> > +	end_pfn = PHYS_PFN(start + size - 1);
> > +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> > +		struct page *page = pfn_to_online_page(pfn);
> > +
> > +		if (page && PageHWPoison(page))
> > +			poison = PFN_PHYS(pfn);
> 
> Oh... I think it will not work for hugetlb pages. It will give
> false-negative.
> 
> We cannot just set the bit hugetlb pages as we don't always have memory
> for tail page -- look at HugeTLB Vmemmap Optimization (HVO). Hugetlb
> uses a trick to encode poison page. See code that uses _hugetlb_hwpoison
> in struct folio.
> 
> I think we need special-case hugetlb here. (One more reminder why I hate
> HugeTLB).

Confirmed -- hugetlb_update_hwpoison() sets the flag on the folio and
keeps the bad subpages on the raw_hwp_list, so a per-pfn scan only sees
the head and misses the tails.

Let me add this special case for our beloved hugeTLB.

Thanks for the review,
--breno

