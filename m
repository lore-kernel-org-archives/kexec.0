Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99FC44507
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eBZnUR39vw6RjG/0+G3LAv2Ug55ZNjpQuLX/y4dLZaU=; b=Slqo6g59uT1ZR1JGgq6OffT0/T
	DTTWG53FDme6vRmFJmRqG4FY3h7BJfegjdgqfZdexLQZ+RE5O7iBllM6tUBq94mBr9CnF++vS4se4
	sEH6JCrSzQPDK5ssqhgLSXM+4ILqU1Cs4GQ63fzngtkqnjj8drctW3OrPP0LdmNl7JMvfV0PW+mdL
	34eXVtacUhnSpASPIbHfNv5hHSQ2gLAqGt7Xsw2zBhF8jDp9jgZ6oPF0x7vnUbruewcw6dbFoYoP0
	Eg2ZWxO8oY5BDXA+8f9COIKMCZHHdHtSu/NQx1Qrse/yZS1xyCXOT5W6F7tO9225oQBuS0QR7ueO4
	m+k0QHYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNax-0000000APSg-03OT;
	Mon, 13 Jul 2026 20:49:43 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNau-0000000APS0-0OqG
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 20:49:41 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-ca860baea9fso482760a12.2
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783975778; x=1784580578; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBZnUR39vw6RjG/0+G3LAv2Ug55ZNjpQuLX/y4dLZaU=;
        b=klhBdUf5xXT/AxjS4r472uPNsxOcSdLsF4SoMJ2NzGiV63R0bc+jU0HRC6xuUDyY4/
         pjyzFPYHMg1iJkxoac8cpIfanzpmm52JuOgrmlX3WO6MNrhXdbN4NHhIfurXYjbi/s7Y
         /v/G1/8pXmtOWiL1bUUlJG11RPO6sTvashkHM5EFKI/IKRD9PL1jUNgG+NpMmWGxfndu
         ckAn+9cjW3aq0Xu/GRZtQ3g3Vfr9pLYE4K5/utxC9UaI7LfZnJMWwXsWgMaB6YOBDAnF
         tdLaN5IsAzM8PZLNEA8v60ZVdqBvRNYlrnFYoWUES5Lzk0l122cRGvFSt+Nwh3SlIf4l
         mSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975778; x=1784580578;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBZnUR39vw6RjG/0+G3LAv2Ug55ZNjpQuLX/y4dLZaU=;
        b=JxH2mK6Igsz20Ndmk2BpcsR2uWpWuZFautg5MJNNbVlSSppEwWL8Aa0/iLyUVqBtCw
         /N8PG6d9ZeUkqGo765CztXExl+45im6r98WS5oHzEtV5R8u3SLe0HP8NDVG2uoSg4jZM
         f+4m4eS8XxmSfzrnn+2jKOKUEd2sG2cqCSWwrIdWqdmxOkA/umuWXs5ebsF6sEC7JN6j
         8wxsntZoixYE/MUYNbpieMYALXax05tOsABVbVNrUY7+rqMl4GaJUQq8UjahBE9W/TWG
         7VuTjQt72Bnl9rFkrx0mMEAliCHWIYfptHsVxN/LTbxw+rU3TYBLxnHByncYMaw5+GAT
         7SZw==
X-Forwarded-Encrypted: i=1; AHgh+RpeHOVIweCkRUoDNG6sMAUADN/yKZ6e631DT40sCqYnT7djbmIszZ2utHdwe9gkIb5y8nmavA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXMi3OGNGQ8yJ7MOIkO5fjWB8DvwJPKH4Arc2HQSfJC69WtDiH
	3ed0oqePEcGRpiJRl7IOBJp8sYqZAovy0T6VHau+ZfKVG6EY5BrT+VV2bD5PNbRWeA5TYe7WG49
	A5A==
X-Received: from pfbha14.prod.google.com ([2002:a05:6a00:850e:b0:847:9540:3064])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22ce:b0:847:8f0d:cc09
 with SMTP id d2e1a72fcca58-8488970ab05mr9541989b3a.44.1783975778163; Mon, 13
 Jul 2026 13:49:38 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:49:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260713204935.3069000-1-praan@google.com>
Subject: [RFC PATCH v2 0/2] kho: support preserving unsplit high-order pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_134940_167982_A5078DDC 
X-CRM114-Status: GOOD (  11.21  )
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

Introduction
============
This series is required for the ongoing effort to preserve DMA allocations
across KHO [1]. It addresses a fundamental mismatch between the current KHO
restoration logic and the physical reality of high-order buddy allocations.

The Problem
===========
The current KHO restore implementation treats all multi-page blocks as
split pages during restoration. Specifically, kho_restore_pages()
initializes every 4KB sub-page with a refcount of 1.

However, many kernel subsystems, most notably the DMA allocator (via
dma_alloc_coherent), frequently return high-order non-compound pages.
In this unsplit state, only the head page carries a refcount of 1, while
all tail pages have a refcount of 0.

Consequently, when these contiguous but unsplit blocks are restored by KHO in
the new kernel, the forced reference count of 1 on tail pages causes some 
trouble with the buddy allocator. Downstream of the eventual free path,
__free_pages_prepare() [2] ends up calling page_expected_state() [3]
when is_check_pages_enabled() returns true (triggered when CONFIG_DEBUG_VM
is enabled or debug_pagealloc=on).

This detects the unexpected non-zero reference counts on tail pages [4] and
incorrectly taints the kernel while leaking the physical pages in question.

Proposed Solution
=================
Following feedback on the v1 RFC, this series moves away from auto type 
detection and instead introduces explicit preserve / restore APIs for 
high-order unsplit pages.

Callers are now explicitly specify if a block is unsplit & preserve it by using
kho_preserve_page() and kho_restore_page(). These functions apply a refcount
of 1 to the head page while leaving tail pages at 0.

The existing APIs (kho_preserve_pages / kho_restore_pages) remain as is 
for ranges of independent 4KB pages, continuing to use the split refcount.

The internal initialization logic is refactored to provide a helper:
kho_init_unsplit_pages(), which is shared between folios and unsplit page 
restore APIs.

[v2]
 - Dropped automatic type detection via higher bits in Radix key.
 - Introduced explicit kho_preserve_page and kho_restore_page helpers.
 - Refactored internal init logic to share code between folios & unsplit pages.

[v1] https://lore.kernel.org/all/20260703020832.1731864-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260708234854.4044652-1-skhawaja@google.com/
[2] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1370
[3] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1027
[4] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1034


Pranjal Shrivastava (2):
  kho: Introduce a helper to init unsplit pages
  kho: Introduce preserve/restore APIs for unsplit pages

 include/linux/kexec_handover.h     |  10 +++
 kernel/liveupdate/kexec_handover.c | 115 +++++++++++++++++++++++++----
 2 files changed, 111 insertions(+), 14 deletions(-)


base-commit: 0f26556c5eeea62cc934fa8938b148aa5844a6b6
-- 
2.55.0.141.g00534a21ce-goog


