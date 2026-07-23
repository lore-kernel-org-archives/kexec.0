Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EACC531D0
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Z8MgAmeNYWGY3DpjlolA+dV2ZqjTSZSJZ8lZiZVt5k=; b=yEi0xEkgyHV4bwlBlY/lU3Y51h
	jtwdvphE8YgTLBN68XlM9WUpeDK3UbTvWFo0FVeDhX0RuHKHeNZgIJFL6UbjzVE+gNQ7KVlG8NLmS
	uN6e0AC4B1Pau3bBlJ05YoucEGpPc51k4OL9T6BhEhszcd6JaOt4A8JQ4y+A8AWj6dlFTBNBymL14
	RA5HLp+5H/e+2d50aFPpu5dEmgb/6/9AmgMgP6eIE8o/m1/VZjZX79PRYycoYypo1H2XYTtUNOfXX
	OM/Q+3pNJI3TyE10a1ocf5keadI/O9OXbP0zb29nvcriuVWHFvH5qAm0nvdX2tSj3mkjT5BJ9v1we
	Mrxz+LVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0FA-0000000F3O6-0VTb;
	Thu, 23 Jul 2026 20:42:12 +0000
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0F7-0000000F3Nf-3RC7
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 20:42:11 +0000
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so1611373a91.0
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784839328; x=1785444128; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Z8MgAmeNYWGY3DpjlolA+dV2ZqjTSZSJZ8lZiZVt5k=;
        b=sZdwgl26hVhmpPv2O34NLhhUIHikDVwrBtV//aPk36AMaqCI6Nkqb/v2HAZ+TJEYPg
         s67NqPHeBwqq4d4eh8yEmZpUJpuACxw/W2vXLLC9BecmK/Mor9ep6YIG+422uXVklVyE
         az1shU/rQSMKaJbn1provSs9sM311P+b5Xj1vpakVV6YQmttzTvAurvEbGfBTsbeZuXl
         QqiqnvAPOZeyq4osHfbkrDg7VokmM/M+ft+WIbaHEFMQXHo5m52Ngyz/4oklx9pXGKby
         ZMAU++0jYaTjtoFjgkFlEHKonDcEEAwWcSvWz+Dk1KVwyqY/4yKQEEiRY0u6Ih6KNC6E
         PQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839328; x=1785444128;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Z8MgAmeNYWGY3DpjlolA+dV2ZqjTSZSJZ8lZiZVt5k=;
        b=iV3cltGYd22YfcLdTjujZmLa43iOzxgp/UwEY6BaDPqbaNcvfQhh98vXgJiKnKwkMf
         LVjoiIWE1MSxSXaFL3V2fLF5TuTOrlUsy7UkrgeYkMCrC1kgtGLj+GAZHpkvssz/7rt+
         pguGWOSymorsbyLt/JORI5w+fzA91oIU5nFH+aePmPrYP4Q6wKqOboLwSzxGOoTBkWbb
         gAjAsegeBFi0JnpZtQjsewIo/ioA3uyE2q6EtKSOwnM3uR7i9KXx2aX6jqIbqEv5xhm3
         XAFMpisq9Ca/mZyHtUH2wBydlytAzminYtCza6+7a7AdEh/9TxjIf3VA6+1ybR/Q8R3M
         n0Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpH5LEbDT8T4/ruHPlKAYnzWaJXXvaKIKYT2KEDZe02GF6DwG36jiF1MyrEUD68ueGV5nWt1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzuQqTJNMF+5eUmJvGMWucgUzas7Ecab2XluGkAVGT8rJwGn72C
	+4Warl7ryx+UdnmRzjfWYAjicA4CK6yIlRNDe8IyrOczFtOx78+HIua105ySeGSW/zcg3jboyV3
	EEA==
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:385:fa6c:f60e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfd0:b0:37f:9ce3:ca97
 with SMTP id 98e67ed59e1d1-38ec6617ea4mr4536874a91.32.1784839328071; Thu, 23
 Jul 2026 13:42:08 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:42:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723204203.2997395-1-praan@google.com>
Subject: [PATCH v3 0/2] kho: support preserving high-order non-compound pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134209_884853_54462C77 
X-CRM114-Status: GOOD (  11.43  )
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
In this state, only the head page carries a refcount of 1, while
all tail pages have a refcount of 0.

Consequently, when these contiguous blocks are restored by KHO in
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
high-order pages.

Callers now explicitly preserve these high-order blocks as a single unit by using
kho_preserve_page() and kho_restore_page(). These functions apply a refcount
of 1 to the head page while leaving tail pages at 0.

The existing APIs (kho_preserve_pages / kho_restore_pages) remain as is 
for ranges of independent 4KB pages, continuing to use the split refcount.

The internal initialization logic is refactored to provide a helper:
kho_init_high_order_page(), which is shared between folios and high-order page 
restore APIs. We also consolidate the common metadata validation and state
clearing into __kho_restore_page() to avoid duplication.

[v3]
 - Renamed "unsplit" terminology to "high-order".
 - Consolidated the common restoration code (magic checks, private 
   clearing etc.) into the internal __kho_restore_page() helper.

[v2]
 - https://lore.kernel.org/all/20260713204935.3069000-1-praan@google.com/
 - Dropped automatic type detection via higher bits in Radix key.
 - Introduced explicit kho_preserve_page and kho_restore_page helpers.
 - Refactored internal init logic to share code between folios & high-order pages.

[v1] https://lore.kernel.org/all/20260703020832.1731864-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260708234854.4044652-1-skhawaja@google.com/
[2] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1370
[3] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1027
[4] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1034


Pranjal Shrivastava (2):
  kho: Introduce a helper to init high order pages
  kho: Introduce preserve/restore APIs for high-order pages

 include/linux/kexec_handover.h     |  10 +++
 kernel/liveupdate/kexec_handover.c | 130 ++++++++++++++++++++++++-----
 2 files changed, 117 insertions(+), 23 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog


