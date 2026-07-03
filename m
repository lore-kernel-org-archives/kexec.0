Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E36C43327
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3ssAB+EsfecVy0nswhEr9TzBhCh5UgDVB8vvd9e3u/M=; b=FYWsxiveYQlVBSZQLuiciLS0pd
	PKA3YhS8i6Y1fIYuzRWvaEgHRQP1X+rGS9AhEWRc4W3kN7XeLppDCJKgh/ESIZ8wdcXR3LNhhnIRa
	tLOuHYgwjlojXYwBWCgfjt76UJoINoZLBNIMYJL/re0NI1hkdDgZZUhT0Z7ajlbMvPWCx9tORLl6K
	Zf+LbP/dREzvKdGN/xI2gD6oRZ/2PvBHmWcAHzBvxlXoWJ+XovTdVDcp/JC9p7qfl85EJHPmNP3nQ
	Jle0WUG9Taxb40f5WGjzG8lLvF9ymx9ABwQWqanzxHvsA9z2eMaOqbwUI9F7GGHLxvGyPf9g4lKg/
	5CpvBCrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKb-00000005rl3-0SZv;
	Fri, 03 Jul 2026 02:08:41 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKX-00000005rkN-1gEi
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 02:08:38 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8478a1ec69fso143605b3a.0
        for <kexec@lists.infradead.org>; Thu, 02 Jul 2026 19:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783044515; x=1783649315; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ssAB+EsfecVy0nswhEr9TzBhCh5UgDVB8vvd9e3u/M=;
        b=QG/gPz0pRJ/ZAE3Bcfn+VRSDAqeQBBfPUP9wZKcEl6h0YMi4afzP3TliAD91L2lPEF
         kH9RoubDb0SMYMgZ5w+pmvH6S0vtzfEfyvN9VClpj5Atds1eFLvXHaghksd9Rr7tOX1x
         SD5Hy9N4FygghQ0qteS3XjHYPHht9pm7XgpYxx9/K5HKd/4zvdrAShfPMDj1rHgmHOBh
         n088ys2JcPBL8iAm8piM+VB9gvIfTqpBJpyEGO2Ti79noawchoeKTtbFTV4AeMQ3gx5x
         LMgfWHinr5C+ujJzqdnl4w6gDgEwVm91vRSGp01O+atIqBM5xjDocHt3Gcj9e6KKCUcJ
         npNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044515; x=1783649315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ssAB+EsfecVy0nswhEr9TzBhCh5UgDVB8vvd9e3u/M=;
        b=Jo5inLUX1DeGCppbWHLvp5MaiWhkSNGChCRMaRgmlKp5jj9QVDdcyD+mzrhkTI6Kr/
         s/OQWNrK0Z9t5YouvQb1mpgp1ZaKKfkL8sMWiIGDA1cKfuQ2IsJGX10CrM+kDOJtzExQ
         5HIAKPQ7u4aHgV+t/9PWUh8NuYWC+RlIunb+EMDs8bC3LInU8qGyjhfQ6tvAwcd41M/x
         COnWWKFUhNgo/4cTGyYP5NAX+eKeJr0+85WufsmQ7YCobRQU3+Hj+l7aMRxF6uEj1X3I
         1zYP1rADdyV4UySbnPgKrEek+nPWI/5ia+Rat2PjOsVLKg/ZXXwdh2yx1U+krv3ZUARL
         5B4g==
X-Forwarded-Encrypted: i=1; AHgh+Roe0QYkc0lGFH82aQX95qzFTRP409pyxkyAI+wmrimlg01NaIsSkpG5/lnhvbpaglmLt8ri9g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhggtsTTTUwXXHZ/t6ZcUDmMfDfFUYS3pjGIRsU0HmVdyhVmsG
	krQTbBXlm8wFjYy4ct9M+i79VhpgsQITBq48c/WxO5SzwK/6xEvAAWNbZHJH0GdU5gtNSkDNsnO
	pSA==
X-Received: from pfblg25.prod.google.com ([2002:a05:6a00:7099:b0:847:80c0:ec04])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e08:b0:845:48be:b046
 with SMTP id d2e1a72fcca58-847c0854fcdmr8315059b3a.36.1783044514968; Thu, 02
 Jul 2026 19:08:34 -0700 (PDT)
Date: Fri,  3 Jul 2026 02:08:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703020832.1731864-1-praan@google.com>
Subject: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190837_475496_95D33C18 
X-CRM114-Status: GOOD (  13.00  )
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

This series is required for the ongoing effort to preserve DMA allocations
across KHO [1]. It addresses a fundamental mismatch between the current KHO
restoration logic and adds support for high-order buddy allocations.

The Problem
===========
The current KHO restore implementation treats all multi-page blocks as 
split pages during restoration, i.e. kho_restore_pages() initializes 
every 4KB page with a refcount of 1.

However, many kernel subsystems, most notably the DMA allocator (via
dma_alloc_coherent), frequently return high-order non-compound pages. 
In this unsplit state, only the head page carries a refcount of 1, 
while all tail pages have a reference count of 0.

Consequently, when these contiguous but unsplit blocks are restored by 
KHO in the new kernel, the forced refcount of 1 on tail pages causes some 
trouble with the buddy allocator. Downstream of the eventual free path
the __free_pages_prepare() [2] ends up calling page_expected_state() [3] 
when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
debug_pagealloc=on).

This detects the non-zero refcounts on tail pages [4] and incorrectly
taints the kernel while leaking the pages in question.

Proposed Solution
=================
This series introduces a "Page Type" field to the KHO ABI to track the
refcount pattern of the preserved pages.

1. KHO detects the physical state (CONTIG vs SPLIT) during preservation
   by peeking at the refcount of the second page in each buddy block.

2. The type bit is preserved in the high bits of the KHO radix tree key
   (Bit 63) and stashed in page->private metadata during boot.

3. kho_restore_page() applies the correct refcount pattern based on the
   preserved metadata.

4. A new helper, kho_split_preserved_pages(), is provided for subsystems
   that may need to split memory after it has already been preserved.

Considerations
==============

1. A primary goal of this approach is to prevent driver/subsystem code
   from peeking into MM internals. Drivers should not need to understand
   the distinction between head/tail pages or compound metadata. The KHO
   core handles this internally.

2. To handle rare cases where a caller might wish to split a high-order 
   block after preservation, we provide kho_split_preserved_pages().
 
3. The callers must ensure that the split_page() doesn't race with
   kho_preserve_pages for consistency.

4. Folios are always implicitly considered of the CONTIG type

Thanks,
Praan

[1] https://lore.kernel.org/all/20260505002737.2213734-1-skhawaja@google.com/
[2] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1370
[3] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1027
[4] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1034

Pranjal Shrivastava (4):
  kho: Introduce infrastructure to track preserved page types
  kho: Detect preserved page types
  kho: Implement page-aware refcount restoration
  kho: Introduce kho_split_preserved_pages() helper

 include/linux/kexec_handover.h     |   7 ++
 include/linux/kho_radix_tree.h     |  17 +++-
 kernel/liveupdate/kexec_handover.c | 144 +++++++++++++++++++++--------
 3 files changed, 124 insertions(+), 44 deletions(-)


base-commit: 87320be9f0d24fce67631b7eef919f0b79c3e45c
-- 
2.55.0.rc0.799.gd6f94ed593-goog


