Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE8F8A15E
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lKHwSeRo/ultSF+DvjG6BVyCb2GmqVTT5wmkO/QWglI=; b=nnfXJ1nNBc3dvLhqBj7YdRDvto
	/MSZ03HsqTehBVQ0LEtQiVTGUikgB7601629eRk8WgvPs3aiyQIwI7Pa4wlRztXKIQLtdZZ77KrWh
	LoDRzzaqXcNv899MRO25JbMdkA0XwbGQK/h7gBB0TRATR7+iYnExF7ybWkq/HK6tqI9308QJyEeeQ
	pvygtyOhibHJOkpSaOI/ATHlgAXw2Io0Go3CVeCtX8n4CeFiJR97mKhn2Cut485yCIEV4RPJ++zE3
	GhNyRLWEz5gTRs9lf+z4b13O0bwc1p/Zip4NRmabiP0I4MWLYnRw1c8glFrqWrJGCbRvvTx252h8R
	BTiMna9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYr-00000002LUQ-1YST;
	Thu, 16 Apr 2026 11:07:05 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYp-00000002LU0-01kX
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 11:07:04 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-66f103b3141so5134185a12.0
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776337620; x=1776942420; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKHwSeRo/ultSF+DvjG6BVyCb2GmqVTT5wmkO/QWglI=;
        b=Ji86zWOw77yxsCv8q1FXUXJbxBagwX7fuGUQdXHr3IcQnLxa6Pb6a7307YGg/Mumaj
         Vo0QOZi6s6g70+L6B5hE8bsDUXUmBfXjlLNHNz8QD/Z4bjf2vSlFLSoemWBK+KlT61eT
         6LFMx6Tz0M0b1+cMSolpU75jA8NN4++WZ+KVy6p1uQt2NXxU6dziC1WzZ3ec0m26cmhi
         NgU4m96xvvTcFm2H8nWXM8wmg71P/QI9/lnYeGZs4oBsD2Nx4h0BegB2mAQbxq2GY6Yz
         uZ0lV3UAeg8DbbyxbKzxGUx+RBGTxzt1NlyiG3cvzIIQbo3KrNLr42lNkovDLaKmA2Bd
         fm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337620; x=1776942420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKHwSeRo/ultSF+DvjG6BVyCb2GmqVTT5wmkO/QWglI=;
        b=QBYyuNfwUvu+9+MmQZqV33dvXggWgsgwTJOZbdp7Q8saE2reYrADgyTwi0dOik+DMw
         TU908NBv3Gp7ZQrcqaO2N8aTcv4VozIJrTdybnUwK67przfymqx32/2A6fKIIWQUq8nr
         DCb9UYWanKajA5PASuim05HWio+CTf1ANL9ivpq8ojgCi0JY1zAHaB8Vya3Z7cvyODHQ
         g6nD8gJkHvZb/e63wZh8/1IU7ogXlHI6SIpDWOqAKWIIYQvXrMLNzlppFbFSHNyFCD3D
         8GW0MQ7WCH+AguqPQiH5Y8jI2XOo10bGCW17hFmHYsWqogrzdxxIRD33BuyHcxF9zlBq
         HuHw==
X-Forwarded-Encrypted: i=1; AFNElJ/T4H2EsHZiDZCnqbPZuNPFdkp8T177d7ZdgdMygylVKp2vG3+zhlYPiEmtbFPW5y+MirrqRA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8mpg2mKA6ksuntzNeqVcVCY4a58zXXb2fmTWEpbtDprFEPH5M
	Al5/P30NrGWBZLqMMYfWlBJooTSSE9EL668RvQr+aulfjQGlZ2OfGn5fqCT+QAryJgWX1dw80LU
	ytCWSwmU2T0u59AZZ1IgPFQ==
X-Received: from educ13.prod.google.com ([2002:a05:6402:100d:b0:66e:cdad:9d95])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2b99:b0:671:bc46:1b93 with SMTP id 4fb4d7f45d1cf-671bc461f4dmr6398522a12.18.1776337620197;
 Thu, 16 Apr 2026 04:07:00 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:06:52 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260416110654.247398-1-mclapinski@google.com>
Subject: [PATCH v8 0/2] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_040703_061543_5B7D9114 
X-CRM114-Status: GOOD (  10.82  )
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

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
initialization is deferred to parallel kthreads that run later in
the boot process.

Currently, KHO is incompatible with DEFERRED.
This series fixes that incompatibility.
---
v8:
- moved overriding the migratetype from init_pageblock_migratetype
  to callsites
v7:
- reimplemented the initialization of kho scratch again
v6:
- reimplemented the initialization of kho scratch
v5:
- rebased
v4:
- added a new commit to fix deferred init of kho scratch
- switched to ulong when refering to pfn
v3:
- changed commit msg
- don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=n
v2:
- updated a comment

I took Evangelos's test code:
https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
and then modified it to this monster test that does 2 allocations:
at core_initcall (early) and at module_init (late). Then kexec, then
2 more allocations at these points, then restore the original 2, then
kexec, then restore the other 2. Basically I test preservation of early
and late allocation both on cold and on warm boot.
Tested it both with and without DEFERRED.

This patch probably doesn't apply onto anything currently.
It's based on mm-new with
"memblock: move reserve_bootmem_range() to memblock.c and make it static"
cherrypicked from rppt/memblock.

Evangelos Petrongonas (1):
  kho: make preserved pages compatible with deferred struct page init

Michal Clapinski (1):
  kho: fix deferred initialization of scratch areas

 include/linux/memblock.h           |  7 ++--
 kernel/liveupdate/Kconfig          |  2 --
 kernel/liveupdate/kexec_handover.c | 52 +++++++++++++++---------------
 mm/memblock.c                      | 41 +++++++++++------------
 mm/mm_init.c                       | 27 +++++++++++-----
 5 files changed, 69 insertions(+), 60 deletions(-)

-- 
2.54.0.rc1.555.g9c883467ad-goog


