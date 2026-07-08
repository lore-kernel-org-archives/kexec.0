Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B5EC44501
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0rcxz3xIlmj9F6FAJyNtBM4J//L5BtHyiG09PcS+rH0=; b=qBWzeAiQnnEkYMLpDxLujdBRwa
	hkUhYBq1UCPN+4f8pa2QYwiDc0G8MQw+IPJHIEl+VZI9vI6LEU+1VIiiExl+suR7tDN5T6MIE0kIR
	8RDXlRenew82Fz5wzsWxm/lXL6XHRsEmnzdSFUsmX0GFrCabX2r2qaJHx7xQ0eTPDQ0MCoSWSZEXs
	0czPDgO1EX6U2ykwrerWIaWqu4TELho5m+jv360f32GBbbw0U/5g9h/1CEZkTUe38sjXfQ6q1Z3m+
	1uguXnsmb75lwV+UBsrerq9s17qpNzLTySWqt0KYvX/wjH/7YfyDQ6egiBUMMndHWqE2o0ZSg07BY
	LTKe4I2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVg1-000000002m2-05uM;
	Wed, 08 Jul 2026 17:03:13 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVfy-000000002lA-1mCO
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:03:11 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cb59f6ba26so2875ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783530189; x=1784134989; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rcxz3xIlmj9F6FAJyNtBM4J//L5BtHyiG09PcS+rH0=;
        b=Ut1W454Ngd3wGXPQPRk29SWOatEXhYDAkp2huNgE4UOUQE1fD85sDjGzIKou9DR6iT
         2YsECHSvpCN4R+vG8gvUu8N9YE60rSa8MkAP/oq8LYPDOyQjtX9XXVh2rwu+LHigfSeR
         CmHA+XgBulIE6Q5TauH/nSj68WnbaC7GCj5s3wRDGG/6XMzXzPB1tGeva97liQ5o46dw
         ZYOAmm7KbBMVIBmO10ciB4Cf61W8IaA85OetAf9rupsy4gyOLit82oSkxSFZMcTQCgPH
         du0jN13XOkh8iyRQFj1orKHpUomuZiepeQufdFReWm4ZAJPRwW0hKxb1XFDVcuNtiwOY
         SCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530189; x=1784134989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rcxz3xIlmj9F6FAJyNtBM4J//L5BtHyiG09PcS+rH0=;
        b=fAazo5jopkjrJ3j+JWsLeYreBuflLB/GU3k/1YPZyM1IokzAO+5kfGv0ouoezf+R5Q
         1ejaVnsoleY7y+UagQYYPm3eXBBGUOfPYGXqQqU62lARna5d6fnENZQQx3zxB76gVbis
         t+paq1ww0o7tIaUmvynAPk+a0iYEivW3o8NG4QSGHyFzvqmudsFBce845j4PrDeQZUb8
         8OGD9X2k8FIq7G1CJ/qV8PeZPovHZH1MBVODpVSbDLVD2H1j+8y+o71jq7NcmhtEZSvX
         sfpnqM3WSXhyTBoRrN7aaflQGe07Ph7aIXaWqUr83Q6yrH0ZHldPhbW1uC/jmJI1V40Q
         dwDw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1DsyiJ410rBCVVb7Y+mRrF36nwFGZ9ldOM9Xa0n8bSibUrCbwbmMQc/8X0zgMtK9zrrx3KA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCg5cMi4NgCukYFjFdjH11WtrYPs/WE56HodxFJud90SMJJysv
	qy5nLeV/i99lg/CLhEGZniv2EVi4Bj/Qmq44G4SiBmikP76S0i18+kX36+HpMKLItg==
X-Gm-Gg: AfdE7cnWQHDXwcOrE/7pOPi8YaJg9c3Kerji70oXTC9TYHCBLg48dE9t6YO/uAT/RxD
	TgSDS0ZtcsfCLoTgnC9/KfBoCmQ1k1dRHP3FMQVYreuiITf9UkAVyrXDUo78B01thz35G0jPwTV
	dmGanRu21mvE+ns1N2N25htoOlDYUzXdg+6y3+PFDQSFSnRYAlXDrF5M4O4TJp9Knga2fkYu4eM
	V0NdF8kX4fjpdvyp8fEL6RGpvqi5ou/FtCOwDTezXSQMYkQQ5Hyp4Q0vSXraRdl2gvN9+lGbpT7
	5AAh1/LqycRif3dX8S9w6Je73UX9LNi4+5JtTMPTNjKz8ZzV2/CRP6p9xJygK9I1btguCynBAMK
	+FgrQuRXLFR+vPoKSAiD9jAqK6J9KLgP+Njdoo2wiV7eLQ4iFFQvDU+qq4wSY45s5XEd6ClitXF
	hdR0RI9RtX20bRdgCo29BGTMd2tE/q35KbYpXn41Itlf2j2EA=
X-Received: by 2002:a17:902:e752:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2ccff969666mr193175ad.25.1783530187903;
        Wed, 08 Jul 2026 10:03:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b64819sm7622445b3a.12.2026.07.08.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:03:07 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:03:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6CxVty3O5Ib7q4@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz7bn5mv0n.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_100310_469543_9885B552 
X-CRM114-Status: GOOD (  40.24  )
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
> On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
> 
> > This series is required for the ongoing effort to preserve DMA allocations
> > across KHO [1]. It addresses a fundamental mismatch between the current KHO
> > restoration logic and adds support for high-order buddy allocations.
> >
> > The Problem
> > ===========
> > The current KHO restore implementation treats all multi-page blocks as 
> > split pages during restoration, i.e. kho_restore_pages() initializes 
> > every 4KB page with a refcount of 1.
> >
> > However, many kernel subsystems, most notably the DMA allocator (via
> > dma_alloc_coherent), frequently return high-order non-compound pages. 
> > In this unsplit state, only the head page carries a refcount of 1, 
> > while all tail pages have a reference count of 0.
> >
> > Consequently, when these contiguous but unsplit blocks are restored by 
> > KHO in the new kernel, the forced refcount of 1 on tail pages causes some 
> > trouble with the buddy allocator. Downstream of the eventual free path
> > the __free_pages_prepare() [2] ends up calling page_expected_state() [3] 
> > when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
> > debug_pagealloc=on).
> >
> > This detects the non-zero refcounts on tail pages [4] and incorrectly
> > taints the kernel while leaking the pages in question.
> >
> > Proposed Solution
> > =================
> > This series introduces a "Page Type" field to the KHO ABI to track the
> > refcount pattern of the preserved pages.
> >
> > 1. KHO detects the physical state (CONTIG vs SPLIT) during preservation
> >    by peeking at the refcount of the second page in each buddy block.
> >
> > 2. The type bit is preserved in the high bits of the KHO radix tree key
> >    (Bit 63) and stashed in page->private metadata during boot.
> 
> The KHO radix tree today only guarantees support for 53 bit wide keys.
> Although in practice, on 4k pages the math works out to support 60 bit
> wide keys in practice because we have 6 table levels.
> 
> Still, you can't preserve a key with the 63rd bit set. So how does your
> code even work?
> 
> Also, if you do this, it comes with a side effect. It will increase the
> memory usage of the radix tree, since now you have two branches of the
> tree, one with the high bit set, and one without it. So that is more
> intermediate table pages allocated.

I agree that this would increase the memory usage...

> 
> >
> > 3. kho_restore_page() applies the correct refcount pattern based on the
> >    preserved metadata.
> 
> Why do you need to save the type of pages in KHO metadata? For example,
> for pages or folios, we don't store any type information and leave it to
> the caller choose the right API. So reserve-mem and kho vmalloc need
> pages, they can call kho_{preserve,restore}_pages(), and memfd needs
> folios so it can call kho_{preserve,restore}_folio(). The radix tree
> itself does not hold the information. The caller knows what its memory
> is supposed to be so it calls the right restore API.
> 
> So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
> name; we can argue about the naming later)? Then your driver knows it is
> restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
> takes care of initializing the pages with the right refcounts.
> 
> You won't have to muck about with the ABI in that case.
> 

Ack. My goal was to keep the KHO API opaque to prevent every driver
from having to peak into MM refcount internals. However, if the 
preference is for explicit intent, I can simply introduce something 
like a kho_restore_pages_unsplit() helper (or similar) that drivers 
can call specifically for high-order non-compound DMA buffers.

> >
> > 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
> >    that may need to split memory after it has already been preserved.
> 
> Umm, that sounds scary... Why do you need to do that? What's the use
> case? Why is the driver reconfiguring its memory after preservation? I
> assume these are DMA buffers, so why do they suddenly look different?
> 
> And in either case, why does KHO need to do the split? Why can't the
> driver unpreserve old preservation, then split the pages, and then
> preserve the new ones?

Ack. I was trying to cover up an edge-case I guess but if we're simply
moving to an explicit restore API none on this would be needed.

Thanks,
Praan

