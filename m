Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84123C369B7
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpBKVsyj4yO/W9TVJ7LuZCgYhuMgNgTy1M+co7OF+A0=; b=ouqEWLbjJL0C8HYzFfl6WZqHaF
	Q+TFdz9Vqriwp0kANx+ONWuaYZXxfNJjxg6nEMEqYiarfkML8h+gCmddV76j4VK9Xs8EInbVelz37
	QNeHaCCvzELXrHpc81uLaz+wb/hEm9iD756ZfU0vb4psw+e8JzaqCZJVwuYtTk3kCJSGS/AgX+b1g
	VqPDYP0LR2lo/pEwsQ/TYaETzxxd5SZ5ND7Ylz+khm2U5lnZKIyUA8GEiMGhYrWkct2P1tOD0jORQ
	DNdjI+CoGFAR98GvY+9vP0s1Lj9E95Jjs3BHd3BL8lF+KR7xrtApUVfXjzP27YxNbXpg3wr+ehSAv
	JJTCPrJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJR-000000017T5-0fHu;
	Mon, 14 Apr 2025 08:37:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pNv-00000001DaK-0hc8;
	Mon, 07 Apr 2025 16:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FpBKVsyj4yO/W9TVJ7LuZCgYhuMgNgTy1M+co7OF+A0=; b=ilfmgy1ub8ic+By7DUBBR6z0dL
	T45b6mcOLmKM5N/1XZWZaZER6UHQtrpZIsVddo7GhjoqfZlxSTrjktC8azJqKzsLvZSsUlWP98apC
	KAVolV6dO1etgFImcTdIlii271E8gqejBaL78Qlg2L7yswuNWpetSYekMZ22boNPl4lOGsFTjBRO+
	Ldq56ci1xk98Asvl14ieAaP7YrL4t/E/C9BCwcFkTf0t1yyKdrktKJNUodBHUiQ2AjQIRBTLuIydw
	NNPKI41atttIVyrj869DtqgekMGc+XvSCQI33lvtSl67E0EYyCJlfXeqevA6HcVGBm1Sq57kX3Zp9
	eDM+NpZA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pNr-000000083lf-3qxW;
	Mon, 07 Apr 2025 16:31:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A10435C056C;
	Mon,  7 Apr 2025 16:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58BC4CEE7;
	Mon,  7 Apr 2025 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744043496;
	bh=RSrEtdAd5F0XISIgryvTa6dXc7w7kiCKmtOkNhqhQY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emyn0LK28d026GSydKtLRNImtQcKaVGWuubapwQw0jgJSGeLE5R2eeOSv137XDl3d
	 CRE6SAkRmJJ6fuqdxPGsBEwpoGUyk2nJ+cCMro9SKEIpCuTV22Y4irttl8KmvnpW+t
	 ASgvQIJ+iHZ4T8QGM5ojHf64XQOwrwYleiDfDYDnKOTK9JEGxfONsvownLtzOuo3sQ
	 k6INQAfxDoqrAwvYTjxaakaCIMonB4iKTjRBeZqcF5nBamTvZ9KPNomR7kRXmWvd+P
	 v9dwmHgbbNKIWeWf2WLuU6ZGalf7SJ8/U9NcRa0+LmvbIG5Q8nGeTtztIne8hQDdkW
	 /RgKrAd25BcHg==
Date: Mon, 7 Apr 2025 19:31:21 +0300
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
Message-ID: <Z_P92UCbNCV0TbiA@kernel.org>
References: <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407141626.GB1557073@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_173140_296201_38014DAF 
X-CRM114-Status: GOOD (  34.72  )
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

On Mon, Apr 07, 2025 at 11:16:26AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 06, 2025 at 07:11:14PM +0300, Mike Rapoport wrote:
> > > > > We know what the future use case is for the folio preservation, all
> > > > > the drivers and the iommu are going to rely on this.
> > > > 
> > > > We don't know how much of the preservation will be based on folios.
> > > 
> > > I think almost all of it. Where else does memory come from for drivers?
> > 
> > alloc_pages()? vmalloc()?
> 
> alloc_pages is a 0 order "folio". vmalloc is an array of 0 order
> folios (?)

According to current Matthew's plan [1] vmalloc is misc memory :)
 
> > How about we find some less ambiguous term? Using "folio" for memory
> > returned from kmalloc is really confusing. And even alloc_pages() does not
> > treat all memory it returns as folios.
> > 
> > How about we call them ranges? ;-)
> 
> memdescs if you want to be forward looking. It is not ranges.
>
> The point very much is that they are well defined allocations from the
> buddy allocator that can be freed back to the buddy allocator. We
> provide an API sort of like alloc_pages/folio_alloc to get the pointer
> back out and that is the only way to use it.
> 
> KHO needs to provide a way to give back an allocated struct page/folio
> that can be freed back to the buddy alloactor, of the proper
> order. Whatever you call that function it belongs to KHO as it is
> KHO's primary responsibility to manage the buddy allocator and the
> struct pages.
> 
> Today initializing the folio is the work required to do that.
 
Ok, let's stick with memdesc then. Put aside the name it looks like we do
agree that KHO needs to provide a way to preserve memory allocated from
buddy along with some of the metadata describing that memory, like order
for multi-order allocations.

The issue I see with bitmaps is that there's nothing except the order that
we can save. And if sometime later we'd have to recreate memdesc for that
memory, that would mean allocating a correct data structure, i.e. struct
folio, struct slab, struct vmalloc maybe.

I'm not sure we are going to preserve slabs at least at the foreseeable
future, but vmalloc seems like something that we'd have to address.
  
> > I did and experiment with preserving 8G of memory allocated with randomly
> > chosen order. For each order (0 to 10) I've got roughly 1000 "folios". I
> > measured time kho_mem_deserialize() takes with xarrays + bitmaps vs maple
> > tree based implementation. The maple tree outperformed by factor of 10 and
> > it's serialized data used 6 times less memory.
> 
> That seems like it means most of your memory ended up contiguous and
> the maple tree didn't split nodes to preserve order. :\

I was cheating to some extent but not that much. I preserved order in
kho_mem_info_t and if the folios next to each other were of different
orders they were not merged into a single maple tree node. But in case all
memory is free and not fragmented my understanding is that buddy will
allocate folios of the same order next to each other and so they could be
merged in the maple tree.

> Also the bitmap scanning to optimize the memblock reserve isn't
> implemented for xarray.. I don't think this is representative..

I believe that even with optimization of bitmap scanning maple tree would
perform much better when the memory is not fragmented. And when it is
fragmented both will need to call memblock_reserve() similar number of
times and there won't be real difference. Of course maple tree will consume
much more memory in the worst case.

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs
 
> Jason
> 

-- 
Sincerely yours,
Mike.

