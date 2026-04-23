Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6124FF589AF
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fi9xSgYpoZ/qpCfid0/vii4Xij6h2WhXpELMzsBfSVU=; b=Dis/XjL7BuNo7OUOzAx9U3cKq6
	5CIThYRg9uLhodiAFG9xhAKbhRuoQja5WlCVOvbbu1lC+xWSlRLu91FyjV+4AIICY3jz00n3lMdMM
	zcf26fNCKln+tg4uyLpR8KStn6nxLRXRM5Ztpt7LIM/ZY/jJV4eM+khv2vPFKvzbkcA1H9gJdN5t/
	hRU86SDRQmpXGqMarGBOs0EO5lrP9ZhDqKhWW9my+bEBRUJ1y5U6VENF9Ec/A2ra1/h5IionajdvN
	AVUtFaXBNa2tQ/kYBAkSLvx+Z0cAEzyppPy04rcykz0jIIlvZJVrZNcYZX9nlTObkgvlXlC6RHXNC
	dZ5+ZG9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7u-0000000BbyI-0dMF;
	Thu, 23 Apr 2026 12:25:50 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7p-0000000Bbx4-1h4J
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 12:25:49 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-6771df2b5easo1036147a12.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776947143; x=1777551943; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fi9xSgYpoZ/qpCfid0/vii4Xij6h2WhXpELMzsBfSVU=;
        b=HqZbrM7e1WXbkN48WzrOP5lFslVsdkmuRNyzGHkWOXGiaml7gJ0PxQ6Ggt+/LWF14P
         jsFppZxQCzvXlJAs/UgK01bLAQaIeGOG5u4NB4iiQDmC4pjVK2VhffqJfuJaUkFJufnz
         ElcnCBOP38P7+xx5w52gs0adqcTbAEVIsSvUZEnwZDgWqFz6YgHL9b4yZwH4DY+1PIcu
         PHkUrhRchk2XUgG7HLJu9s2GFZNjI/L7SVf9htxB+MEiIfFvhtlEp+3AHy9h8pywyUpo
         FdoL20eNU0jydnvtOmVP6jlEcOyR/dKbAozJ9XHp1JhF4XnNpm9Y/XShVWi9cgpvUXnC
         0d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947143; x=1777551943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi9xSgYpoZ/qpCfid0/vii4Xij6h2WhXpELMzsBfSVU=;
        b=oPwBEIjkuMeGR4WuGNVzJ78jpz5sr+idC0ANeIoKfJJO42aGbRWsnAWWCMqx/NTiml
         fBjQpvE7I1j00k6IAbW40VUUWCv5y4GSFlN8zjFHtuDgmmXPTjEhjJr/UtE+uBSXN7U0
         fTgNBl9xUmCSo1VxRNvU1U5NQFGDCEe419fGe1uTRJGgONoPYMeD5TxPxOD5JCSjbxKm
         IawIetQB0EigBIrflOtOTIe5iqev8wngORimaVwLmBrOtYpR+gqXY2mbzFSzF+laY2Ra
         GVspQnfEBg5HG1+fILlH9M7fllu6+R+AiE3R74M2iSazzRUPmGOH2Ixxfatu/NRwEy2q
         y2AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ReaWoFDWvuoD/gmJASq5HiTawVjL0Av2aCcO002bY9lDB5e5/9DbHOevHWp9flYqb6vERRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+Q1/N7jfoQm2rjxWcy5uQidDhf6ikaXQa+CXhYgSBIckXNZ8K
	vd5gTC66cKduKlpAVcnitXDU1I6Cz594CXctpRTPeouFJ9u3QzOwLj874RBYxhJLphou3pPgUnn
	NND5PYhPGU+oKq5NSsAYSEA==
X-Received: from edev7-n1.prod.google.com ([2002:a05:6402:a2c7:10b0:676:9c94:9878])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1f01:b0:674:37b7:227c with SMTP id 4fb4d7f45d1cf-67437b722e4mr9379117a12.2.1776947142685;
 Thu, 23 Apr 2026 05:25:42 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:25:35 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423122538.140993-1-mclapinski@google.com>
Subject: [PATCH v9 0/3] kho: add support for deferred struct page init
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
X-CRM114-CacheID: sfid-20260423_052545_456954_E06D7517 
X-CRM114-Status: GOOD (  10.84  )
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
v9:
- moved init_pageblock_migratetype from memmap_init_reserved_range
  to __init_page_from_nid
- reduced number of ifdefs
- new commit to test this feature
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
https://github.com/mclapinski/linux/commits/deferred_test/

This patch probably doesn't apply onto anything currently.
It's based on mm-new with
"memblock: move reserve_bootmem_range() to memblock.c and make it static"
cherrypicked from rppt/memblock.

Evangelos Petrongonas (1):
  kho: make preserved pages compatible with deferred struct page init

Michal Clapinski (2):
  kho: fix deferred initialization of scratch areas
  selftests: kho: test with deferred struct page init

 include/linux/memblock.h              | 21 +++++++++-
 kernel/liveupdate/Kconfig             |  2 -
 kernel/liveupdate/kexec_handover.c    | 52 ++++++++++++-------------
 mm/memblock.c                         | 56 +++++++++++----------------
 mm/mm_init.c                          | 30 +++++++-------
 tools/testing/selftests/kho/vmtest.sh |  4 ++
 6 files changed, 88 insertions(+), 77 deletions(-)

-- 
2.54.0.rc2.533.g4f5dca5207-goog


