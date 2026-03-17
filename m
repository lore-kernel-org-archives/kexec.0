Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A18BFD8770
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lm1/04AucX09o7Vc1s8OzOzNp6FWCOos1z+TBuLIodY=; b=Li+0jIIBNKyModNIpNydiV2zyf
	Mj+H1/hPs69ahOXw+pBHjgmq2LgNT4x+R0VDgyuX/2hMAMV3BF6Ey9nEkCOCnhbSJeqDTNaKBLis1
	ERpF3C8ZRVbZJemWL1V0Q39YV2rzj0//TDMhm6sow/vz6FCuVt+K+Ns3/xz7fvJlk4xROdgt6PQvo
	pINevQk1bAhuJl9OJ/qnWVZWMfdIoPTLRXPZKetQaUfo+uzcZek2XEHWAL9isTG3UVIwo1b8iGnc9
	CVx3ijBnmF8wYWWA3VjQo7Np3FjFxOCSuoVeEyqarzPsPbSIsW8myzZ9iGDdsXi364l+ylJ0OM1RK
	+yen7deg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD0-00000006XwX-2zLf;
	Tue, 17 Mar 2026 14:15:46 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VCx-00000006Xuq-3Pwf
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 14:15:45 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-6676eeba186so514158a12.2
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756941; x=1774361741; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lm1/04AucX09o7Vc1s8OzOzNp6FWCOos1z+TBuLIodY=;
        b=RKsU7deotbqFZh1WXiCVx84jIGojmqlxsOHIBs5kGQzYAi14yuiEzb1BydGGdaMghh
         y1+/tajoiod71Kh52PYR7VgSWKfVdbJDI4bI9T1C8JE3ROHjaZoeiGP+Jx1hxaFSzyPp
         U7qnPskRA/aWeUYln7qbn/yqaiIRbndSoWnO1Pd4qbmWAL+nPDQIFEy3xr1xrytV7PSm
         d1ZfZnzjCNCt1x/q5L6uSASGG+YqA1/5iSRpm/6QXOENPJgVqFK+t27hxZTnRGf0miND
         4xs3yBt8/oh73ugS/ftmGSDNbWs8XOFGmHb2ESVXXsDeInQx6JlRYjxRQShu9Ytka9Cs
         WkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756941; x=1774361741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lm1/04AucX09o7Vc1s8OzOzNp6FWCOos1z+TBuLIodY=;
        b=gB50ck0ilAv43/naiFaKawkRtYbnvo3vPdbL9YJ5gKy+m5guhaYZkJDww8CN8Qrwx5
         JNqO9HCokDfhbintAEodiqVGdjDtmHcJdoNcK/lB5zeEdYmpQ28gM/Pf56y9ljMyjdfg
         A/b3JAvy50pyBWyTY6R97ntwM130s/JYhU8sKJHumuz4Ze8T9W/VrFQcnwjjSUxfimXW
         /gfNffEO1YSbM6Ek8jkMkuZ7dPlCWUXGxpBY33BUYcw93d9839KrrklaNZFD1iiSDTPU
         3hEEHeG8ey08LjyqlQ2bDX8V0Mjtn+PubISY7qL/f7gGGLGbz6u2n1xy0zeqxpYC3Qz1
         aMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUW1TQFKslfvDZWuaUZoKYmkpmR6MM6r+XmtUucQxrYRzu9rhEmNGGxOhJLHZPE9mDRNlP7JA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywx077u7jtqFvpT9vFPvQpUpfyWDLOTJNy8m58zsLf1FH6pPv1g
	UdgjjWkuLgtoh8E5NAuvuwQ56GrgMTnRMFHeAHEQpNt3uCy9Ybafb3FdYAnV7sQuEQ3nhmyShjP
	FWkhzwu02nPiFBUL4pdq9LA==
X-Received: from edya2.prod.google.com ([2002:aa7:cf02:0:b0:667:8c6d:ee30])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2809:b0:662:f12c:257b with SMTP id 4fb4d7f45d1cf-663babc560emr10556033a12.12.1773756940594;
 Tue, 17 Mar 2026 07:15:40 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:15:31 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317141534.815634-1-mclapinski@google.com>
Subject: [PATCH v7 0/3] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071543_857868_06DB85BD 
X-CRM114-Status: GOOD (  11.19  )
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

When CONFIG_DEFERRED_STRUCT_PAGE_INIT (hereinafter DEFERRED) is
enabled, struct page initialization is deferred to parallel kthreads
that run later in the boot process.

Currently, KHO is incompatible with DEFERRED.
This series fixes that incompatibility.
---
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

Evangelos Petrongonas (1):
  kho: make preserved pages compatible with deferred struct page init

Michal Clapinski (2):
  kho: make kho_scratch_overlap usable outside debugging
  kho: fix deferred init of kho scratch

 include/linux/kexec_handover.h              |  6 ++
 include/linux/memblock.h                    |  2 -
 kernel/liveupdate/Kconfig                   |  2 -
 kernel/liveupdate/Makefile                  |  1 -
 kernel/liveupdate/kexec_handover.c          | 65 ++++++++++++++++++---
 kernel/liveupdate/kexec_handover_debug.c    | 25 --------
 kernel/liveupdate/kexec_handover_internal.h |  7 ++-
 mm/memblock.c                               | 22 -------
 mm/page_alloc.c                             |  7 +++
 9 files changed, 74 insertions(+), 63 deletions(-)
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c

-- 
2.53.0.851.ga537e3e6e9-goog


