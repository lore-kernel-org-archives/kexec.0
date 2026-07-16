Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD54C44511
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESEHmQjCMBnGaENVOX4xB1tescWaluk9TL1CPIBeov4=; b=GTvbJZMtUmUToLhy/+VoeGhcmM
	dQvfHSQph1IpI/ZGdR+xL7bh4RUBoZcY02cAdrTzelyGQPXVc272VkCaY+gJyHG6STL/OO9lN3F/3
	sElXsEn0VcQeIEUcXX7Rsb8It2CUDcLIWNHMCxiMTp5J8HidKSy5wIXP+P/ZvKQJcCeOT/ZQvnUsE
	B9djt1GkrFUWp73pEDNRYVjN3ws5OFTHf7b20aTTJ7OUSTdopu0T30NTTXvc9DW8oyBR9eTOreuo9
	j30zS1UaYoXlgBYisq+a39fwXOtmWFyqn/SvmXysqff1du9gSo4Y2YQuYBVE1nluRAcs/mt8JTfDU
	KQOKIheA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNdd-0000000HaCW-3Pz0;
	Thu, 16 Jul 2026 15:04:37 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNdb-0000000HaBx-0FEo
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 15:04:36 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-81e851aebeeso76909217b3.0
        for <kexec@lists.infradead.org>; Thu, 16 Jul 2026 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784214274; x=1784819074; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ESEHmQjCMBnGaENVOX4xB1tescWaluk9TL1CPIBeov4=;
        b=W0RJxic1R8hYsbiYJa1rwjERRjvDO9Lqnf3hmSYAZAyxs6tZQ9m2Vy5srrNvBuDnSB
         5kPffvP8WsqUmacWnPpb679MRqyVSvdSN+QE01khmXA9lNRUNlI8UqIXt4d+7/0eBViP
         JW9Unss8rKNZGNRumvL/+BzUeNuOkfFWGTOHyrl6RwiZsFwfvfQwMQxjWqXMjqmp7wYM
         01Kv7bKOz4iWwqWdDgsd69K3XIQ9E6hwQFJ3ELvnuZyNMVsuSpMiyOnKsHJRVqgx5cHh
         4btK3TZo2zAZcqE9nSMifhB/RkEk2CnN1r8nt0xl4psGNFYrRSXsExRC/7U7hBeHAgrd
         jB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214274; x=1784819074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESEHmQjCMBnGaENVOX4xB1tescWaluk9TL1CPIBeov4=;
        b=MUoAPK0/DIKMAY6HM6X3tt2woxde9BT7w9kviBf36GmkYLs2sXnP8wvQtifDzP/+yM
         ZcY9fuuF0Bbuc4DeoZzmos89tVj/bofET0lmYwcYxhJJiR0FHzFBSMvg342feTNl0iNN
         mj/x/M8R4cQBtv5zITVeuUauf2fiS6ETKZ4cOUQHNl/SmJaeKH19FkdEqUyljX+h0jB3
         ecS+FvZR/RYRC/BQTF0nD2IyUZKVVB2TaUHpMZm++5Rgvo5FZFSCfZW5vB6CP3Cri4p1
         pjeUdBVdG4BLfjxrcQy+j9jaFBckOmTAI5SQFTzshJXEF8bw6MvpmLYA8W8Yzc7HTrin
         2Q7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr5moMEz5tqHJtkTIaGB8ptBVW+2reHi3xXHS7x92K3/I7/ClfWY6E++opu7tHJi3b90Nn8Aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGRSEldFa6nE2mNBp4P7HXzRSsnVU4sSsi9CzVPovcxJG71BRu
	xCo7a5spCyji/wgQ7/GjdM3g7KlP8KHofJhK+SUBuqmEKifLsciBhDHndE2PlF3GcMY=
X-Gm-Gg: AfdE7cla9m9El6vXYuaEObx4vWWfWmjJ278hEm8TT1YLbHdpEB3Ubvc2WN4nv8U9Cbm
	sM+iw3WaGw5c+f/xCqs7g1gS68VhMFhqgX0tEi467z2NYytB1LnF3BNAGhHfvP8wUSO3LpXKa7c
	jAk8EJ6Ym/qSWUvXPlf2gfLdyH5QbuRw5ns5IVdHywwvzcDWspCawbVlKLcledn0ePfR5nkC34t
	ZAmGhTV8ny6Jeo50XomOvv8r8vSPJFiTbGPHjLGixd6009FPLonACWNQA5zN3MXktDZCr3YOqiQ
	V6yXwj7qcdocibB2hrvN35rikj/gc+T7/WT6IwTQoLcs2xyWBu3FgNJ4B2gBaadgnTb6++EF/X6
	n8y64jgbZPb3fUhgVr0HRTF6ZGLiGs7Mrq10yWIbqj4GGcPSnVfNZppcYKq/LMZkgOkkTs4OHB3
	C/8fB3wb0Ox7nMVX4/7uTAW8uJXdK5+2Qx2GGVLqXNTFp202l7pKlWBgQ/uXCFBPOfuAnNWyIiN
	Qu/z6L4pCID
X-Received: by 2002:a05:690c:22c9:b0:7f8:7e50:6390 with SMTP id 00721157ae682-81ebb28d493mr96938907b3.50.1784214273078;
        Thu, 16 Jul 2026 08:04:33 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c23d1afsm198963407b3.47.2026.07.16.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:04:32 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:04:31 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <aljy_-Y7OT6s0kj0@google.com>
References: <20260714205111.2497151-1-mclapinski@google.com>
 <178409777790.255896.16691338963510282908.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178409777790.255896.16691338963510282908.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_080435_100905_A375BF54 
X-CRM114-Status: GOOD (  24.65  )
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

On 07-15 09:42, Mike Rapoport wrote:
> Hi Michal,
> 
> > I caught this crash:
> > BUG: unable to handle page fault for address: ff19164fffff8328
> > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > Call Trace:
> >  <TASK>
> >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > deferred_init_memmap_chunk() works fine without KHO because free
> > regions will never be neighbors. However, with KHO, free memory
> > will be split into (free && scratch) and (free && !scratch).
> > KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> > is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> > MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> > This sometimes crashes when one half of the neighborhood is being
> > initialized but the other part is yet to be initialized.
> > 
> > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> > 
> > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 4834a809985ab..50928aaa33710 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -38,6 +38,16 @@
> >  #include "../kexec_internal.h"
> >  #include "kexec_handover_internal.h"
> >  
> > +/*
> > + * This is the minimal alignment required by deferred struct page init.
> > + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> > + * struct pages, which can cause a crash.
> > + */
> > +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> > +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> 
> Maybe make it a variable and set it at runtime?
> We won't need to worry about different confugurations that override
> MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in

Do those architectures reduce MAX_ORDER when they override it? I would 
hope we could set the alignment once and make it large enough to work 
everywhere, rather than depending on dynamic changes even during boot...

> the future.
> 
> -- 
> Sincerely yours,
> Mike.
> 

