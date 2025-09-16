Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9866CCAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ibGBgeNBvWY5S85vCt3WE69YwmMbn65Qdt6TTcBcO8=; b=u7Hug+BHupZCMtL2ehzpL09w1y
	KHDFOhDliyNmfnQBU9Psy6T1z0snWOjTsV9VrRKV4+W+3DC8dCrIsiUo972jAPct6NYf18z0nE5Aa
	YuaUCiUwe0BA40yg6okC/Lji+Kc7FStMcDJDdBKUY2INnfYH1ZoVKP52LicHKQR6SDyqWI9h453sK
	vNdlAjJGZTkH2ir8EavnmRD2Z3TN5VLjO2mfaMWGZKtJP57UbVvU0jYcxXUfaTTJwAoAZ/S+FVRaE
	QFnWIjsgLLa9OQfxQo1kpB/x47ciKcZ+AkcH/I1lmjC1+zkAfpwLMgibSz23VnVmNg8kYJT5XIdEm
	VNkHhGmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyX2U-00000008C34-0cI0;
	Tue, 16 Sep 2025 14:52:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyX2R-00000008C2N-3sww
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 14:52:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 19D5C447F2;
	Tue, 16 Sep 2025 14:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED19CC4CEEB;
	Tue, 16 Sep 2025 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034330;
	bh=i8NtzmKVeK0CBqBApTYTm3iAf9ez5i62j0SbReGfb7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t3jMv2cpq05jLr5mya8gnqY0LdWfZKH172NqGWZsUQV450OQ7MSecKK/BvQvPsF61
	 +wRfIMDMNu5N52JqAVHgKcJg+2qotenh8Q40u6DpJOiuUnYo86PyubV2WqMSegeBGj
	 /7EIp+/ORtdmETQpkePK3TluVJdEAbAnGdEnNUEoujU0XWKotd4E5E3BzaT5jVeLRq
	 q6m3409DAFi74aePUAzsstLsPnsK+X1OW8V6f3ZUuR0xqUr7IONdQTxe9jWgDC7QYY
	 i4xftMwQ9c57QB47kUCFlPqzeB9DyhXXjJvbEhIrpy8e9Z0pEWN0Zw4oGK9g15NxcR
	 PlII1l1WkPEiA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pratyush Yadav
 <me@yadavpratyush.com>,  Matthew Wilcox <willy@infradead.org>,  Alexander
 Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Chris Li <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <20250916132759.GC1086830@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
	<mafs08qimjoez.fsf@yadavpratyush.com> <20250910155546.GB922064@nvidia.com>
	<mafs0zfauh6to.fsf@kernel.org> <20250916132759.GC1086830@nvidia.com>
Date: Tue, 16 Sep 2025 16:52:06 +0200
Message-ID: <mafs0ldmeh2ll.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_075212_002123_ABBE85A6 
X-CRM114-Status: GOOD (  21.09  )
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

On Tue, Sep 16 2025, Jason Gunthorpe wrote:

> On Tue, Sep 16, 2025 at 03:20:51PM +0200, Pratyush Yadav wrote:
>> >> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>> >> >>  struct folio *kho_restore_folio(phys_addr_t phys)
>> >> >>  {
>> >> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> >> >> -	unsigned long order;
>> >> >> +	union kho_page_info info;
>> >> >>  
>> >> >>  	if (!page)
>> >> >>  		return NULL;
>> >> >>  
>> >> >> -	order = page->private;
>> >> >> -	if (order > MAX_PAGE_ORDER)
>> >> >> +	info.page_private = page->private;
>> >> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>> >
>> > All the impossible checks shoudl be WARN_ON()
>> 
>> The mental model I have is that the place that introduced the
>> "impossible" situation should get the WARN(). So for an incorrect phys
>> address (leading to magic mismatch) or incorrect order (say preserved
>> big range using kho_preserve_phys() and restoring it using
>> kho_restore_folio()), the caller is responsible so it should do the
>> WARN(). Does that make sense?
>
> Callers should not pass illegal phys here, WARN at this point is
> appropriate, and maybe under a debug #ifdef or something like that.
>
> This is to make it clear that "test and fail" is not an acceptable way
> to use this API.

Okay, makes sense. Will add.

>
>> Actually, on another look, this patch implicitly makes sure that
>> unaligned phys always fails. This is because deserialize_bitmap() only
>> sets the magic on the head page which is always aligned by the order.
>> For any unaligned phys, the magic will not match.
>
> Makes sense, maybe a comment?

Will do.

>
>> Makes sense. Do you suggest the magic and order checks to also be under
>> KHO_DEBUG, or should they always be done? I am of the opinion that it
>> makes sense to do them always, but I can also understand the argument
>> for disabling them in production for better performance.
>
> I'm ambivalent :)
>
> For now I'd do it always and leave some debug optimization to a future
> project.

Sounds good. Will add them as always for now.

-- 
Regards,
Pratyush Yadav

