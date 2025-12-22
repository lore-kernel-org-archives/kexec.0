Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF9E674B5
	for <kexec@archiver.kernel.org>; Mon, 22 Dec 2025 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmNs3UwGZr7nK6ylT0yHv/l8DmNd4tuOSujZj63Dqws=; b=Vt6QNnomTDhuwrPftYbivjjpkY
	NzQvxGLz5JvbyUS8+ygJx7gvugESLfgc0SF8eAm7XR9LPI46amUiwAw4aQOkEqDhgMT9HJJLhoUbg
	EnFTZfG01HawXOffM1UATeAIgibLjV1dbgJLQJo0oOfHx78Q9cB36razusmnCENEJNIK8APaRvGkn
	g/1uwxOYafwkCVSOmrnsajdCDniWUOgYj422Fj2ba1IAqFTk8Imftyn9ESa71/Pi3Um+bMKcNlqoe
	injehK8iIS6rP8eMzpTPx46tkX8w45a1JeQZP0GVHA+NZsgy7Mr6txlGh6zB6ppqTvcqi9uljDoNB
	4r/8ZRIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXiGe-0000000DwLX-2rgk;
	Mon, 22 Dec 2025 15:56:16 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXiGc-0000000DwL6-150G
	for kexec@lists.infradead.org;
	Mon, 22 Dec 2025 15:56:15 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so1593860a12.1
        for <kexec@lists.infradead.org>; Mon, 22 Dec 2025 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766418971; x=1767023771; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nmNs3UwGZr7nK6ylT0yHv/l8DmNd4tuOSujZj63Dqws=;
        b=a+H7R/yf7dX/8jP0Gx7m1R5/ealDMrS4k4EAZ89BkRUwK+4UwAi66bgZtlQ9rvF3je
         BN92dhuAwrCVz+KURIKfZnTc8U6aUic9LK8OSggBgZDRKzhrmOi/ubdg5wjQ7Vg+Vmpt
         Qh4D854A8kpt5mPyFVQhPvbXE/xiUlB+YNMigTeQBzFiEiaQXRWavsXDBmh+W57MSCjk
         qDizEJnKrDIjTOtWm2BJxfXWnB9LKGFNDndjoRP+iGXB6KKcbT27QO8evpUJlkHsJW0u
         0YYa6WriZDU8yXGhoGaHKlVL8MilmQRKrk8ydV1qQsT+C09Oniv7TsDnCQXqknnfYefY
         q5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766418971; x=1767023771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmNs3UwGZr7nK6ylT0yHv/l8DmNd4tuOSujZj63Dqws=;
        b=N25s1a+JiStABTinEQ5+lndqYTPOEDaacL0eKk5+GtTqjT4GyJZ5eyaIg+eHKM7lGr
         QTGlZRxo37U8AKOgcopsUWac1WNpvbqiVaydxpURzir+7YYvQvCvKWA+DnDFyHXQRYvR
         TSPWP6f9h3GTfGsSd5IIjDT+hwOhzwzrUkAe7K5CTrZPrtg7k7LMZ8K8S6qJcTvurNkk
         lcFyzSLH5J+wP5WDfzBr6XwVX8rZUnfo29im2NmrXeI6EJa83BqL5DRuGvbPz7sxDmSQ
         uXgXtceztz2/2sGXwCQvYBZayfOd928t9/e+9o9ZJMsGEWwkA6nec1kj9eUk7GVgA7H7
         Vr7g==
X-Forwarded-Encrypted: i=1; AJvYcCWzimG0Ng9ZT5wsuwJ0+9SIaVZS6HHAtvRrA54OSvPbJrMoLhvTUeR7XqyVGrYRimKjc/m37Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZoUUZzn6WIBo9A2OE7lTH34cb8fltOqvX+anA5KCoSx547Pvb
	wRTWUucPHWYMmc6ehaozDJ+871qfujLi9xu2iFVO8cuyuFdKQ5GzK7UCNer2eH0yvXm4X0xmHIP
	RYkB6nF3kvMY+11KpD3IN8UqC30r50f0clQ7uuR4QIA==
X-Gm-Gg: AY/fxX7zcMNkaao0HLHMW54SPF9ojgfoKR1uboSQ+1MEwEEXrdvt9Xbbw9nk9f2llIq
	HLFo55viK3s2wq23WXhOsIA1cyYqZKzIajJvlPgBL/V/oH2NJW9fN8cqNyqedFc9FORL5oS8H/G
	RVTDBNX9os4l1cr5Jc89eaxroW7JzETXqqB/YA3exYc+a53nRWhFGrnUwxMf4esFyHGdP6Zlk+x
	gdyCD4AQd/75trTXPYGh2di22247doMDOTAL1nAWqSl17VOWKLYPeeiLfllTpASM5BJ0s24XEaP
	xslSN6fCFyGK4LVqeES8fovM
X-Google-Smtp-Source: AGHT+IFEBAeFCtUhSPTbc4A/9WLyV7z0M2uSHjsZD2E0OEjezgIA0DyueqQgo6GKqcyBRi3/5gblK0XZObEH+LeqhO8=
X-Received: by 2002:aa7:d0ce:0:b0:641:7cf4:552d with SMTP id
 4fb4d7f45d1cf-64b5833c86dmr10687656a12.0.1766418971102; Mon, 22 Dec 2025
 07:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org> <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org> <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org>
In-Reply-To: <86jyyecyzh.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Dec 2025 10:55:34 -0500
X-Gm-Features: AQt7F2rPWh34v3gLfcQrWbQB0eZHj1dwNG_vdzmClZfskwU3PjPqxiYRCVmv4Uo
Message-ID: <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_075614_346394_C60A5E4D 
X-CRM114-Status: GOOD (  46.90  )
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

> > NUMA node boundaries are SECTION_SIZE aligned. Since SECTION_SIZE is
> > larger than MAX_PAGE_ORDER it is mathematically impossible for a
> > single chunk to span multiple nodes.
>
> For folios, yes. The whole folio should only be in a single node. But we
> also have kho_preserve_pages() (formerly kho_preserve_phys()) which can
> be used to preserve an arbitrary size of memory and _that_ doesn't have
> to be in the same section. And if the memory is properly aligned, then
> it will end up being just one higher-order preservation in KHO.

Both restore pages and folios we use: kho_restore_page() which has the
following:

/*
* deserialize_bitmap() only sets the magic on the head page. This magic
* check also implicitly makes sure phys is order-aligned since for
* non-order-aligned phys addresses, magic will never be set.
*/
if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
return NULL;

My understanding the head page can never be more than MAX_PAGE_ORDER
hence why I am saying it will be less than SECTION_SIZE. With HugeTLB
the order can be more than MAX_PAGE_ORDER, but in that case it still
has to be within a single NID, since a huge page cannot be split
across multiple nodes.

> >> > This approach seems to give us the best of both worlds: It avoids the
> >> > memblock dependency during restoration. It keeps the serial work in
> >> > deserialize_bitmap() to a minimum (O(1)O(1) per region). It allows the
> >> > heavy lifting of tail page initialization to be done later in the boot
> >> > process, potentially in parallel, as you suggested.
> >>
> >> Here's another idea I have been thinking about, but never dug deep
> >> enough to figure out if it actually works.
> >>
> >> __init_page_from_nid() loops through all the zones for the node to find
> >> the zone id for the page. We can flip it the other way round and loop
> >> through all zones (on all nodes) to find out if the PFN spans that zone.
> >> Once we find the zone, we can directly call __init_single_page() on it.
> >> If a contiguous chunk of preserved memory lands in one zone, we can
> >> batch the init to save some time.
> >>
> >> Something like the below (completely untested):
> >>
> >>
> >>         static void kho_init_page(struct page *page)
> >>         {
> >>                 unsigned long pfn = page_to_pfn(page);
> >>                 struct zone *zone;
> >>
> >>                 for_each_zone(zone) {
> >>                         if (zone_spans_pfn(zone, pfn))
> >>                                 break;
> >>                 }
> >>
> >>                 __init_single_page(page, pfn, zone_idx(zone), zone_to_nid(zone));
> >>         }
> >>
> >> It doesn't do the batching I mentioned, but I think it at least gets the
> >> point across. And I think even this simple version would be a good first
> >> step.
> >>
> >> This lets us initialize the page from kho_restore_folio() without having
> >> to rely of memblock being alive, and saves us from doing work during
> >> early boot. We should only have a handful of zones and nodes in
> >> practice, so I think it should perform fairly well too.
> >>
> >> We would of course need to see how it performs in practice. If it works,
> >> I think it would be cleaner and simpler than splitting the
> >> initialization into two separate parts.
> >
> > I think your idea is clever and would work. However, consider the
> > cache efficiency: in deserialize_bitmap(), we must write to the head
> > struct page anyway to preserve the order. Since we are already
> > bringing that 64-byte cacheline in and dirtying it, and since memblock
> > is available and fast at this stage, it makes sense to fully
> > initialize the head page right then.
>
> You will also bring in the cache line and dirty it during
> kho_restore_folio() since you need to write the page refcounts. So I
> don't think the cache efficiency makes any difference between either
> approach.
>
> > If we do that, we get the nid for "free" (cache-wise) and we avoid the
> > overhead of iterating zones during the restore phase. We can then
> > simply inherit the nid from the head page when initializing the tail
> > pages later.
>
> To get the nid, you would need to call early_pfn_to_nid(). This takes a
> spinlock and searches through all memblock memory regions. I don't think
> it is too expensive, but it isn't free either. And all this would be
> done serially. With the zone search, you at least have some room for
> concurrency.
>
> I think either approach only makes a difference when we have a large
> number of low-order preservations. If we have a handful of high-order
> preservations, I suppose the overhead of nid search would be negligible.

We should be targeting a situation where the vast majority of the
preserved memory is HugeTLB, but I am still worried about lower order
preservation efficiency for IOMMU page tables, etc.

> Long term, I think we should hook this into page_alloc_init_late() so
> that all the KHO pages also get initalized along with all the other
> pages. This will result in better integration of KHO with rest of MM
> init, and also have more consistent page restore performance.

But we keep KHO as reserved memory, and hooking it up into
page_alloc_init_late() would make it very different, since that memory
is part of the buddy allocator memory...

> Jason's radix tree patches will make that a bit easier to do I think.
> The zone search will scale better I reckon.

It could, perhaps early in boot we should reserve the radix tree, and
use it as a source of truth look-ups later in boot?

