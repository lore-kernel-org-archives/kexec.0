Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA33CAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EM3YSkqrS+wD1DSZ8rxCwrnJyCPkgkPjNIyUR3FKILQ=; b=mmCELEnnD/umWUFRIvK+Iv6ULQ
	RIzIYmx5H3ZHqyeRDOEoy9VajbiTlwHxk0Y50hLl9l/AqS2ipAWESjohSj7yNuWnrRshTjQqnowSx
	hnj2+6ryKGyfxRl75GZXVBf6xsbfaeDYXdkbVInFTwKJZNfSD6YMnvqRUV0IZvceDeZkQnEAYgTtd
	cSwVSGynEpFN22kWoubr3hZf1mYspXMmEOZQN3ZznzWmWIiBieTFJW/pajLmeUzPqYvRV7JbFP8+K
	A0WtZuYDi2sW2fvljEydYir8iUbgneH1nBNx1hJjwkqIeJ5VkbM3cRHQ3sAEQqWwlbSlIUwXOWgnT
	HJY7ub2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVc9-00000007uiX-1oZl;
	Tue, 16 Sep 2025 13:20:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVc7-00000007uiM-2wQ1
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 13:20:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 114E8601DF;
	Tue, 16 Sep 2025 13:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E2EC4CEEB;
	Tue, 16 Sep 2025 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028854;
	bh=NkEqYgbQHqBRppulOAwQLkXQ/kR/tGJDaQ28SAU/ZbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H7OhipGoDJaVVg75Xy37xy/Gb3iNzhFXsIZqgKxxxy99QyXG14oqvwpdXzjYB6oOB
	 Pz0Ho367YOVHIksobf0Fxb4ZsK60vbtto3ZzcXGgUjpOegEmLGYTKfR6zvX5IjCkd9
	 +tC4O4jsuvaMlEQFuqv+ByjyZyCQFXOWFNhqDza+bRlT125FRjJ7uKyQn5HSMP5DAo
	 b/dhH2ac393YhcPbCsP+ya3oU1SARvXXSUcAJK7L8L68mer45+vP+YZbuNVoJ7X+TZ
	 9f4CvU+15dVkWB1BOrKADvt9Hkr7LyZIVSmneOlNsis/TIKe3K10+EKR11q58Ud2ek
	 e315dV4Chy44w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Matthew Wilcox
 <willy@infradead.org>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander
 Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Chris Li <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <20250910155546.GB922064@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
	<mafs08qimjoez.fsf@yadavpratyush.com> <20250910155546.GB922064@nvidia.com>
Date: Tue, 16 Sep 2025 15:20:51 +0200
Message-ID: <mafs0zfauh6to.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Sep 10 2025, Jason Gunthorpe wrote:

> On Wed, Sep 10, 2025 at 05:52:04PM +0200, Pratyush Yadav wrote:
>> On Wed, Sep 10 2025, Matthew Wilcox wrote:
>> 
>> > On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> >> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> >> +
>> >> +/*
>> >> + * KHO uses page->private, which is an unsigned long, to store page metadata.
>> >> + * Use it to store both the magic and the order.
>> >> + */
>> >> +union kho_page_info {
>> >> +	unsigned long page_private;
>> >> +	struct {
>> >> +		unsigned int order;
>> >> +		unsigned int magic;
>> >> +	};
>> >
>> > KHO is only supported on 64-bit?
>> 
>> Yes. Currently only x86_64 and ARM64. It is mainly for hypervisor live
>> update so there isn't much reason to support it on 32-bit platforms.
>
> Presumably this will eventually change to use some special coding on the memdesc
> pointer?

Maybe. I didn't think that through yet.

>
>> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>> >>  struct folio *kho_restore_folio(phys_addr_t phys)
>> >>  {
>> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> >> -	unsigned long order;
>> >> +	union kho_page_info info;
>> >>  
>> >>  	if (!page)
>> >>  		return NULL;
>> >>  
>> >> -	order = page->private;
>> >> -	if (order > MAX_PAGE_ORDER)
>> >> +	info.page_private = page->private;
>> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>
> All the impossible checks shoudl be WARN_ON()

The mental model I have is that the place that introduced the
"impossible" situation should get the WARN(). So for an incorrect phys
address (leading to magic mismatch) or incorrect order (say preserved
big range using kho_preserve_phys() and restoring it using
kho_restore_folio()), the caller is responsible so it should do the
WARN(). Does that make sense?

>
>> >>  		return NULL;
>> >>  
>> >> -	kho_restore_page(page, order);
>> >> +	kho_restore_page(page, info.order);
>> >>  	return page_folio(page);
>> >
>> > This all looks very confused.  Before your patch as well as after it.
>> > I don't see anything in the current KHO code that requires the
>> > phys_addr_t to be order-aligned.
>> 
>> Right, good point. I can send that as a follow up patch. But I think
>> this patch stands on its own without that fix too.

Actually, on another look, this patch implicitly makes sure that
unaligned phys always fails. This is because deserialize_bitmap() only
sets the magic on the head page which is always aligned by the order.
For any unaligned phys, the magic will not match.

Still, would be a good idea to do a KHO_DEBUG check for alignment if
this implicit thing ever changes.

>
> Maybe it is worth adding some KHO_DEBUG kconfig to protect some of
> these extra checks?
>
> phys should be pfn_valid, phys should be aligned, the page should be
> in the right state, order should be valid, etc. All worth checking.

Makes sense. Do you suggest the magic and order checks to also be under
KHO_DEBUG, or should they always be done? I am of the opinion that it
makes sense to do them always, but I can also understand the argument
for disabling them in production for better performance.

-- 
Regards,
Pratyush Yadav

