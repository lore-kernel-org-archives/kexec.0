Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41ABC88E5C
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQusxUCZOg61iBhz+gh2H7namnoGRC3noT9Nzn5HIqQ=; b=iz/5FpiKwA1VKKJ9QBJxLc2Y7V
	7R8zHLXcUjZram8Bk7338vSnnu/AqL6rZJTG48rzlNLTkB8J8MUxL5cDHmx/SmOeEFb315ppYcgTL
	4vKcfjX8tS4ZtVETmCDjSuJNSh0YhxZA5cooN92NN+mPTsL1q/xT2dnkQIzBY073988fCAZSL5jxF
	MPyhnchr54DF/A5y/SKcfXC3SC7dQ7JItooTeY0hFXkaHQDOjcUbDwt0zHiW3wY2P/jxdKZjs+HD2
	8rBL/JdAmSzmyzO34/J5aVXVkQldQNdb94AKf+7eLYHX8qZIzvrlxNQxFHEEdpgI/BfR7OPPIvFL2
	Hm/XWn2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6m3J-00000008r5P-3QsN;
	Wed, 16 Sep 2026 09:35:41 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6m3F-00000008r4W-0LNc
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 09:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lQusxUCZOg61iBhz+gh2H7namnoGRC3noT9Nzn5HIqQ=; b=FG+PhcCJdohk4nnU98iT/zoR5N
	BCgB6P043DOhKlGyArs7g31LKrnMGQt2zWbGrRVZDTebMTiVX0hrOpMLGDYK9SjK4Nbhr1XO9Z/oe
	9kYRquCRmoHMSfDt5RL9ZF+HqohR7f9iO3YfQb2nxLasS8aJC+6WBFFBZVtfu5594dMAJdGAlSEor
	T//McaeWE/JqURKCLjDalwcD9SxGNYRZ1Ndf6cU2qsZSXzppknaqswzTmRM1m9nMELechoHJ3sF6b
	SPpSFa5JtX7hBI+K/IGPBKSM0MEmySJV5UgazfmjiDgO8UjZf6aP6k+M7p32sRjJG2WLJIf/ZesHH
	AEqfN1nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6m2s-0054bo-2i;
	Wed, 16 Sep 2026 09:35:15 +0000
Date: Wed, 16 Sep 2026 02:35:06 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
	kexec@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, hannes@cmpxchg.or, 
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v5 7/9] drivers/base/memory: count inherited poisoned
 frames into the block
Message-ID: <aqpczrtIwSG948iv@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-7-3bc7a57bd503@debian.org>
 <de41b78a-8471-4832-be0c-35d410a4499a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de41b78a-8471-4832-be0c-35d410a4499a@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_023537_277734_07CDC564 
X-CRM114-Status: GOOD (  19.75  )
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

Hello David,

First of all, thanks for your time looking at this patchset.

On Wed, Sep 16, 2026 at 08:48:56AM +0200, David Hildenbrand (Arm) wrote:
> On 9/15/26 14:53, Breno Leitao wrote:
> > +static void memblk_nr_poison_init(struct memory_block *mem)
> > +{
> > +	unsigned long pfn = section_nr_to_pfn(mem->start_section_nr);
> > +	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> > +	unsigned long i, nr_poison = 0;
> > +
> > +	/* A hotplugged block is created before its pages are online. */
> > +	if (mem->state != MEM_ONLINE)
> > +		return;
> > +
> > +	if (!range_contains_poisoned_memory(PFN_PHYS(pfn),
> > +					    nr_pages << PAGE_SHIFT))
> > +		return;
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		struct page *page = pfn_to_online_page(pfn + i);
> > +
> > +		if (page && PageHWPoison(page))
> > +			nr_poison++;
> > +	}
> 
> That just slows down boot unnecessarily on 99.9999999999999999999% of all
> systems out there.

hmmm, I am not sure I see it that way.

The loop only runs for a block the bitmap marks. On a machine with nothing
recorded the bitmap is all zeros, the range_contains_poisoned_memory() check
right above it returns false, and the loop never executes.

What every boot does pay is that check, once per block. The stub installs
the table whether or not anything was ever recorded in it, so this is not a
NULL test: it is two 64-bit divisions by the unit size plus a
find_next_bit() over the single word a 128M block covers at one bit per 2M.

The real cost (that "for loop above"), comes when you kexec (not on cold
boot -- given the bitmap is empty), and you are trying to init
a memory block that has poisoned pages into it. Which seems the right
trade-off, no?

That said, can we do better? Yes. The silly win is to let the table say
whether anything was ever recorded in it, something like a
linux_efi_poisoned_memory->empty that the first recorded frame clears,
and return on that before the bitmap is reached at all.

Is this what you are looking for, or something more drastic?

Thanks for your review,
--breno

