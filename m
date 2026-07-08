Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C5DC44501
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jru2Xn1d/tBHCWGdcqrYsKFvTPIWXgg78WJpvLW47rw=; b=ksvfAZa0YIh7ukpDvdqRzbybRc
	LjNUMNFlizhSvkEIOZvU2UBNELuehDVX0+f1agt2AdlGg57zwtGubW+72mGEJdimaVzsP7aHy9Nnl
	CPeS3/9cP7yXq6+rPk3XJ9QbFsfKKqrnIdG7ygE9qZXGlQsIl0RIzfTRNen6og6sf351kYM+kOKgH
	jt7eTr159DnVE5TtviKZeGW7ji/rFAeGYxsbmn36bWJcrdnVfqjZBsCpT0CEPrwHBDy/paLwVmTGE
	pQLrew3Kj0GGYIxMhwMDEmCo/ZS2MQuZFt2d0vYcggeEhgJbjRnbSMa6pF0M0o7JQNp7kD8dxdXCH
	WhKpcW4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVGX-000000000PR-2MYI;
	Wed, 08 Jul 2026 16:36:53 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVGV-000000000Ok-0ch3
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 16:36:52 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ccdf36f63dso156855ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528610; x=1784133410; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jru2Xn1d/tBHCWGdcqrYsKFvTPIWXgg78WJpvLW47rw=;
        b=te+5gaVc3XOc4osjLZCVK1zCRmcVqFajDXEy7NEQhpQyySjPqL1D73x9+IicAldAH1
         yF6P7/r7hmafHszZbF9tv1Q/S44zMjRKC2EUcg8/OVqDjxhct6leo4CUp5lUyyM7ITc5
         Rnk92M6dUH/6UeeYyjU7eedQz8PGwh4oglvPk6d4/+3tR9o8NQU4+Fm0J5god7mwpGCY
         nIbFMxG1N4G7aJwvxBXSztDDMk/wtNA/K60Owy+I+v8eyCeYN6PheyplgPq6IkPTyMYo
         H9R+OkvrmpmnPYzUbyjN3ziNXzx+QUS7E+TgC/FOygYkyarlbwlSa4tE4NyGxqCP09j6
         eaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528610; x=1784133410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jru2Xn1d/tBHCWGdcqrYsKFvTPIWXgg78WJpvLW47rw=;
        b=DBw6ddP3GjRK9RFDSRBOTpsA+6Z0A2RBq5lfs7oZliZZf7uJF3cD7fSGTjUPAfA4oF
         w/LpB8+/xzgoLu89X3g9mzBkh1HOBMzCdc/er6+esJqycYeuvxwiE8kG8ObpTTd+xoR+
         7TS5SFBDjqqhW7xVZQmNoH2xifU3uRzJMH84nkIUMvZ+psl4pPehccZiZqEka7hER7bq
         HNHE5nvWMqRsU+fzawhD9yMLHpkyGHLN964XDALHQ18IeMLtht4oZBXEw2/tom1pJ711
         nzor3B6x7s//3gBjmjzT7Cy27ZXAtbrnpsJzkzg3s3kxfeRiw0vo4ubUBHM396Qw+yeB
         iTbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5uPmO4mvyjsdya0Ott1nv53ichilVLpArpXGtWjQX2RfetY5f9NDAwJl4BuQCCi5fgx7c/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCiMXtYmfmlUzhOF4WQXNS2k39R2ul39xGhHHXFDLxt/SVM3jl
	G4YuGLRmxOgU5AJ3Jftz6ZlDoaQ+NU2f6IJvVAfl9NeiDXMnWx9ivT3vZqTR5vXe2oqIt8UIqpd
	v4juYgQ==
X-Gm-Gg: AfdE7cle01Td41rRR64PG/V0O+DZpiG3O66S2pOjbzqekNMNa25T9YHs/l5MJbcmBnz
	phHnClBGCtTpGQY0kHP3efleeXzOfHOWoZrIBzUFh+IvceXCjBkPkNCvM0/yTwHPu6C+LJyNnJn
	rQHo9Fhzt5kdJVmtDDf1eMTXyMgRZ8n62g5pFhxWfCjM0Ru5FpXYxOU+FSO/JtJXI0RHCu9XQQv
	IyWPeu30Tb01sWpEL0jkdkucUZmAs/qQ4JxcBOUhQNtjOnlQO8UfYwDTPAnUbOa9U5xPC7zugw1
	D6xinqaYRj0utgqA18e0yzfxwa7+sK7tquIcfjExHjJq/MMzHtS2GCeUs6gtqm94EBg3BSj5Kev
	lT2enMt4UOerSdao3nTfsnpxA96kfX2SmW2cSTLiZXvC648VWrWhpE4LZW1kHbQj08E2M5LuGvV
	/977pg3EQbP/1BlcjNmUhDuUPWP5zuXL2hYtlRTAbo32GVqx07v9OX7gzfhsTE5cLL/t8CZ9spY
	jzYC4reu3CInTxCmgKOmw==
X-Received: by 2002:a17:902:d4cd:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2ccff76d125mr137455ad.10.1783528609731;
        Wed, 08 Jul 2026 09:36:49 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84854bf8c9asm66186b3a.41.2026.07.08.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:36:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:36:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak57VeunO8qd4wEh@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2vxz7bn5mv0n.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_093651_192589_64B9B877 
X-CRM114-Status: GOOD (  23.01  )
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

On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
>On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
>

[snip]
>>
>> 3. kho_restore_page() applies the correct refcount pattern based on the
>>    preserved metadata.
>
>Why do you need to save the type of pages in KHO metadata? For example,
>for pages or folios, we don't store any type information and leave it to
>the caller choose the right API. So reserve-mem and kho vmalloc need
>pages, they can call kho_{preserve,restore}_pages(), and memfd needs
>folios so it can call kho_{preserve,restore}_folio(). The radix tree
>itself does not hold the information. The caller knows what its memory
>is supposed to be so it calls the right restore API.
>
>So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
>name; we can argue about the naming later)? Then your driver knows it is
>restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
>takes care of initializing the pages with the right refcounts.
>
>You won't have to muck about with the ABI in that case.

+1

I think this makes sense. The mm already relies on the allocator to
track the type of pages it has and expectes it to use free_pages or
put_page() or free_page(), so it is natural for KHO to rely on the
caller to call the right restore API.

Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
preservation can use the appropriate one during restore.
>
>>
>> 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
>>    that may need to split memory after it has already been preserved.
>
>Umm, that sounds scary... Why do you need to do that? What's the use
>case? Why is the driver reconfiguring its memory after preservation? I
>assume these are DMA buffers, so why do they suddenly look different?
>
>And in either case, why does KHO need to do the split? Why can't the
>driver unpreserve old preservation, then split the pages, and then
>preserve the new ones?
>
>>
>> Considerations
>> ==============
>>
>> 1. A primary goal of this approach is to prevent driver/subsystem code
>>    from peeking into MM internals. Drivers should not need to understand
>>    the distinction between head/tail pages or compound metadata. The KHO
>>    core handles this internally.
>>
>> 2. To handle rare cases where a caller might wish to split a high-order
>>    block after preservation, we provide kho_split_preserved_pages().
>>
>> 3. The callers must ensure that the split_page() doesn't race with
>>    kho_preserve_pages for consistency.
>>
>> 4. Folios are always implicitly considered of the CONTIG type
>>
>> Thanks,
>> Praan
>>
>> [1] https://lore.kernel.org/all/20260505002737.2213734-1-skhawaja@google.com/
>> [2] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1370
>> [3] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1027
>> [4] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1034
>>
>> Pranjal Shrivastava (4):
>>   kho: Introduce infrastructure to track preserved page types
>>   kho: Detect preserved page types
>>   kho: Implement page-aware refcount restoration
>>   kho: Introduce kho_split_preserved_pages() helper
>>
>>  include/linux/kexec_handover.h     |   7 ++
>>  include/linux/kho_radix_tree.h     |  17 +++-
>>  kernel/liveupdate/kexec_handover.c | 144 +++++++++++++++++++++--------
>>  3 files changed, 124 insertions(+), 44 deletions(-)
>>
>>
>> base-commit: 87320be9f0d24fce67631b7eef919f0b79c3e45c
>
>-- 
>Regards,
>Pratyush Yadav

Sami

