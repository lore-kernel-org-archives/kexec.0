Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD9C55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=93Zcj2NXzxZtscFdS8APS888IZfB2IV9unzK92NNaNs=; b=qG3924L+t3iJBdEbeXD3Crf7gk
	ShIBL6baClwJvsbixDpLtcSGkzQbz5i4JPMUpb8bZAiaJpvjVOwGk73XPVfzoFDj0wHDTqVN0WgPl
	4elXHZawLl951ak8+IXJFdNlbSqeqrPPWBqbMpqBgyFUa8ChNN8ETFptX0N430T5Wc0WOPCYlAGCZ
	nAOEorZ+o7WRt0SSTH2Ui+myRXLUH/fcl4W+P/w9Rm8wPGkZvUBegzDQr1Z9XbyNDPe7ScvLbNuvj
	34gkiYilMbqn/1JBP5fB+LwPFNbW2Q4Mifwn42gHyYG69ZBuBbxo0qzqOtgfV14jLZTrT80dYK69D
	bPpwRVOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqr1K-0000000GxRH-36n8;
	Mon, 03 Aug 2026 11:39:50 +0000
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqr1I-0000000GxQr-0NHi
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 11:39:49 +0000
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso4109488a12.0
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785757186; x=1786361986; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=93Zcj2NXzxZtscFdS8APS888IZfB2IV9unzK92NNaNs=;
        b=tm4G+dxGlRUDlZhBLiYib8Colj9L4Tpe+k+juKK/S4GggDGJli7cEpjnv8nt5LbhlW
         5WZXFuuQRL7FZ4iwKo8VrxcLb1JuWIdVUDdEqgaGTESQOCJ9BLn4UUa0Ekl8xoRu93mz
         ZpVEjW1+yg+2wdlkYl6ZRIHF6OxpMgrq+sgJ2ovdkxCRs5Vj2dPPCtqJPTtIp/SrqDMq
         ZJUembEZdE/CZ5ja7dW1oZBGVCZpJMQ1jysZ725d9b23a2CzJ3fH9hA0SL8GvqgNE0Ze
         2snOpQI2Wst/hxoVlH4KGCaxAcEjqXGsxHnU+x6Og6m9Y0qlshigvX97Rcxd4pFjZvOT
         iy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757186; x=1786361986;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93Zcj2NXzxZtscFdS8APS888IZfB2IV9unzK92NNaNs=;
        b=s66QFmtcXsrC7ORU0lEEjF0Knvt6VX8oyBqeVMObyXGpegA95sEPzxkzIyt8DMc0cO
         37SmOR4tEBZfgNu6Qsc2MZfbyYUkGZlaPnIJbkx3iUpI9Q8BLZiuYGPbjevN+QxJiID+
         r1E5gi+XXmD3Ft/OcbYCWrWM9Wj3epaQbkPtK/FA09y1yYFROqwNDaA0sleecL3m+Yrj
         8QIVMuHjhulTrr9NT1upcyGOsIWL+6FeFRqXD2XjYUq/FF9Jik8IwVLYweW9u2WjwPbd
         jbR9PV2qirp8BpcKensfszwuesZ0hvN6SNZ3prB61O2VVl1UyDLWULef0D7Yqix92Rae
         T4fA==
X-Forwarded-Encrypted: i=1; AHgh+RpCxC3zFNOJIFTSzHjEsKSgtWiv+AkpOIgE31lVCZ3ob9R66Uh+ux910Mv/oKR98jtYmwYNvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxN+1/OBYcKft7RqfRrlbloxFRyDlHfBJP2+Irs/w/r1nWi2Mm
	A/l86OWjzubjEBk3psK8OJp31gKTgx7L/blfBXSdx8TebwxJfHG7weF97JBLBmH8tj7zdfCTPsM
	hFg==
X-Received: from pgmn11.prod.google.com ([2002:a63:5c4b:0:b0:c8c:68c0:9240])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:114c:b0:3c9:1c8:2b60
 with SMTP id adf61e73a8af0-3c92a94eed9mr9848362637.65.1785757186070; Mon, 03
 Aug 2026 04:39:46 -0700 (PDT)
Date: Mon,  3 Aug 2026 11:39:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260803113944.3694290-1-praan@google.com>
Subject: [PATCH v4 0/2] kho: support preserving high-order non-compound pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_043948_130378_07403DCC 
X-CRM114-Status: GOOD (  11.60  )
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
restore APIs. We also consolidate the common metadata validation, state
clearing, and managed page accounting into __kho_restore_page() to avoid duplication.

[v4]
 - Consolidated adjust_managed_page_count() within __kho_restore_page()

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
 kernel/liveupdate/kexec_handover.c | 127 ++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 22 deletions(-)

base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.55.0.508.g3f0d502094-goog


