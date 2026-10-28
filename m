Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C4606A322
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xohpMx5E;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=BxUepWxa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EKOJSvQCyvmegciiDSA3qkq54znl6sRsTPqc7BTTnKg=; b=xohpMx5Efoti10BfvOZXK6FZXA
	2tVZgU2rvB5lI/aW47Uj+UV0m3FMGjptyLd76yG0Xp2EWiRouOV4a9cFGJjZKBcIMx+1jgkN5rBBl
	9Wcf/UEMrC6P/XVIpBFvv8iCT8lSwBCQgue40cp1fmBdd3qNuUB1lOeBDNcsFa+eKP7qhHH6w7tl2
	9WuvG8wYOGkl1pQPYTAwjuPDFQNSbKL10ZOhyk+xE1RW/CebggtyFiJ89vBAr//QOkSttE0hwdnAb
	T5Wys79aiyeFBIiSOqFVQVk0nor8evIDniygjGm3htNZF4Lh/VGbi2XV+P8x7bOATacsFsVElNoW7
	MisF1kEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM42a-000000077GR-3yAV;
	Wed, 28 Oct 2026 13:50:08 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM42Z-000000077Fp-12gV;
	Wed, 28 Oct 2026 13:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EKOJSvQCyvmegciiDSA3qkq54znl6sRsTPqc7BTTnKg=; b=BxUepWxaQM94nl47RKcbqrBwZ7
	kKjKjVjHXt+ZcHaBoC9nDp4oSN9ak/TO/XSgZcZWwNyUes07CsiuLocLH66v0bHNVj9IKB35ZiIBf
	fXcJPdkUhdzi3eVA3yYx2Wb11fbpqdcML3ik3qmNvo9oHUT+1pIV40JNfxDMJ/wmX9eR2jxICexSE
	ad3Hc1No0hfI+y0IgWiVtZAg0BshCR6qLOZqqp16nouHynXTJ9IQB4qiaP3+hFCWqYSQ+ZvQao6uQ
	gtgCbH3J+tJpJRCI+onTodJWcxHXBKOxtmizI01tTt3GIKNO4zPmrK05hh4otiSxEU/f4XlZ4mWb4
	KFvceyFg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xM41u-002Ho4-0T;
	Wed, 28 Oct 2026 13:49:26 +0000
Date: Wed, 28 Oct 2026 06:49:18 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 4/7] mm/memblock: add a reserved-region flag for
 poisoned frames
Message-ID: <auH6WT5zR1RM1lpA@gmail.com>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-4-f304255147da@debian.org>
 <ato62palTbNjLwN7@kernel.org>
 <524ee7d9-790d-48b6-8613-841da042c32a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524ee7d9-790d-48b6-8613-841da042c32a@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_065007_293820_1B28BE9A 
X-CRM114-Status: GOOD (  19.70  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 09:39:42AM +0100, David Hildenbrand (Arm) wrote:
> On 10/22/26 18:33, Mike Rapoport wrote:
> > Hi Breno,
> > 
> > On Fri, Oct 16, 2026 at 05:15:44AM -0700, Breno Leitao wrote:
> >> memblock allocates from and frees to buddy whatever is not reserved, and
> >> knows nothing about frames an earlier kernel found hardware-poisoned.
> >> Such a frame can back the memmap, a page table or a percpu area before
> >> any hwpoison code runs, and otherwise reaches the buddy allocator like
> >> any other free frame.
> >>
> >> Add MEMBLOCK_RSRV_HWPOISON for a reserved range holding those frames.
> > 
> > How much this would fragment memblock.reserved?
> > 
> > memblock is not very scalable, to say the least, and each new flag
> > increases the size of memblock arrays which obviously hurts performance.
> 
> I assume that if you have too many regions there, you have different problems
> than scalability problems.
> 
> We should cut out larger chunks, and if they are all over your address space you
> should scrap that machine.

Ack, that is what the 2M unit does. A DRAM row fault shows up as many 4K
pages but lands in one or two units, and adjacent units share one
memblock.reserved region.

Mike, on the statistics you asked for: across the Meta hosts that logged
a hard memory failure in the last 28 days, these are the
memblock.reserved regions each host would need:

             p50   p90   p99
     x86      1     4    41
     arm64    1     5    27

Thanks,
--breno

