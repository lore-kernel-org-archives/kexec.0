Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5502C369B6
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xh0jzWhIK2jUVVufVq9o55tcfWLrZrkAZaOHhOyKGPc=; b=rmZWkHm7JIjSkmr9AR07o47I3n
	oB6OKrEU9P2Z6nj6U06MairQQycPo70G1f4s8+jmUz6fMzBTNPrmMWBTrwcB1+TBM64Eg91KELasr
	iMVzqk6hggnKNrRS1tiqvZd+K0foeG4uJsca6d7AfOyrBzjUkUTjMfXzLwJBEvNCrIZ962EqscDsr
	soB9zS2FztgWSP8aXnd2yVoAj145UrvPSgubog7ZQAkEpBUAklND5bd0HC6Tpvns0tpzGqlf2XWjy
	wtJOpZEzxDGmaiPoFJGiquu8kYMjG5H1vwta4XdHpSfMAhIOGsCW0YJokRW9SbiE8JNwcvVgPZyK+
	+I1ianKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJU-000000017ZF-2T6m;
	Mon, 14 Apr 2025 08:37:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Vwm-00000007N0f-2Ol2;
	Wed, 09 Apr 2025 13:58:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 518EB43765;
	Wed,  9 Apr 2025 13:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3DC4CEE3;
	Wed,  9 Apr 2025 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744207112;
	bh=gIkLtXkAowaebWcKuGF3J/51U/7JSeR5c3yViLJLL4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1VeRjHXhAndr2FEdfdTBw7zDINMDJBNTNJsqgRB/P4dNoIRMJkjhIpi+Ndt+VKbl
	 5knulbs8t68ZJQHEp3hJv5wnnKxfXT2xpJgI4Y01LoSQ6J0O9ODJHFL+a6ZB2fD/7Y
	 XyYJQLnlRpI4+S5i695i7kjZgppq3h65TarholFW8Mm48fbw7ydwLNF5J0ihqwKrUw
	 MzbENnQOyp5QuEtSgrfp/kQGFSwq7IGGzquR7XDOt5FCpPnHUlRpXON38mlmlRyT5X
	 UlXxUCxhI1fUM5v/ElnapHBZclh8oC1FD4nKTc/xqaush+YDOdYrH0o/nPxRtcfmEZ
	 kywhG25Ha9vWQ==
Date: Wed, 9 Apr 2025 16:58:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z_Z8-BLWMkiWpaDY@kernel.org>
References: <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
 <Z_P92UCbNCV0TbiA@kernel.org>
 <20250407170305.GI1557073@nvidia.com>
 <Z_Y4k4rDO-BbMjqs@kernel.org>
 <20250409125630.GI1778492@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409125630.GI1778492@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_065832_650440_03E65947 
X-CRM114-Status: GOOD (  25.40  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Wed, Apr 09, 2025 at 09:56:30AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 09, 2025 at 12:06:27PM +0300, Mike Rapoport wrote:
> 
> > Now we've settled with terminology, and given that currently memdesc ==
> > struct page, I think we need kho_preserve_folio(struct *folio) for actual
> > struct folios and, apparently other high order allocations, and
> > kho_preserve_pages(struct page *, int nr) for memblock, vmalloc and
> > alloc_pages_exact.
> 
> I'm not sure that is consistent with what Matthew is trying to build,
> I think we are trying to remove 'struct page' usage, especially for
> compound pages. Right now, though it is confusing, folio is the right
> word to encompass both page cache memory and random memdescs from
> other subsystems.

A disagree about random memdescs, just take a look at struct folio.
 
> Maybe next year we will get a memdesc API that will clarify this
> substantially.
> 
> > On the restore path kho_restore_folio() will recreate multi-order thingy by
> > doing parts of what prep_new_page() does. And kho_restore_pages() will
> > recreate order-0 pages as if they were allocated from buddy.
> 
> I don't see we need two functions, folio should handle 0 order pages
> just fine, and callers should generally be either not using struct
> page at all or using their own memdesc/folio.

struct folio is 4 struct pages. I don't see it suitable for order-0 pages
at all. 
 
> If we need a second function it would be a void * function that is for
> things that need memory but have no interest in the memdesc. Arguably
> this should be slab preservation. There is a corner case of preserving
> slab allocations >= PAGE_SIZE that is much simpler than general slab
> preservation, maybe that would be interesting..
> 
> I think we still don't really know what will be needed, so I'd stick
> with folio only as that allows building the memfd and a potential slab
> preservation system.

void * seems to me much more reasonable than folio one as the starting
point because it allows preserving folios with the right order but it's not
limited to it. 

I don't mind having kho_preserve_folio() from day 1 and even stretching the
use case we have right now to use it to preserve FDT memory.

But kho_preserve_folio() does not make sense for reserve_mem and it won't
make sense for vmalloc.

The weird games slab does with casting back and forth to folio also seem to
me like transitional and there won't be that folios in slab later.
 
> Then we can see where we get to with further patches doing
> serialization of actual things.
> 
> Jason

-- 
Sincerely yours,
Mike.

