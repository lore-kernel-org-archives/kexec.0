Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC91062897
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2Y9gskyCpeZiaybJRnS79bVzWhSmmn3pZfV0wtEdZDk=; b=hcSgYcYY58JQt5bI4AeM1Cv0Ik
	9HYDAsUbAWCybo2bw4IjHxUmgSRwy0ZFeps1wzpZRqEonb5FYkapkD9to7hha1RuXunp0Lv8dHPQe
	WvIwYbpLYJVSkZ4rZziSPW4GnxX1DA25c0sVZ5egSVVlPeDuUPZIiOCe08gyIybvWjHK1pWN/s/8S
	Wa2oG4M5YRuO8F/rWvCMpprt+sSPeQTALq290i3C6k5SFsCCggXC5JQovDqsmePIB/IWqew3Oz6RN
	vKq4kQ/zeD7/FESuJIQhKddBVCPLVjz1aUGHr+UYktCI4ZYxLw9p8nzlpr8QCm2T6RbJf8m0rasjN
	5ck7FbRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6U-0000000BbLv-32Mu;
	Wed, 11 Mar 2026 12:55:58 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6N-0000000BbLN-2pUS
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 12:55:53 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-662aa4b4000so2549348a12.0
        for <kexec@lists.infradead.org>; Wed, 11 Mar 2026 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773233749; x=1773838549; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Y9gskyCpeZiaybJRnS79bVzWhSmmn3pZfV0wtEdZDk=;
        b=wDLNQgj2CHueca1hHAyRpy3yCs3cY7ItoyaySdY2pt8kyO0AwA4oWWFWYOI91k4mSO
         iCIDCBYl4yc0LnJQLv/H95/GIvSD64wPT603jjuahik6SDBLoRZu1a8dJXD1szSFPYzk
         GBxRs/H4vvQ/s++b4Qxy7eNb1T+1lA5Dd4N8YAGg/kAxpBZn2JwjvkD0aQUFBIcu4FaP
         6ajfaE9mgKTW6uviie0JaQiVCPRvfh+ay1FeCmhpbdn/BlzalyQ01RArJqk0+QDxa/yA
         yz82OtLdiHOArNKYAxsNweaLsWfFwajuwKoqqCaKLUW8/QZ7KIB5xGzw8+uzf2Q0xeD4
         LP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233749; x=1773838549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Y9gskyCpeZiaybJRnS79bVzWhSmmn3pZfV0wtEdZDk=;
        b=iHtq1UUVqCLTzW32AtzI+9/9ZZyOG0FrCFwNPi0TfbnMYlwWRpaS93Ju8Kal45crXp
         IGmhMSqWvJ06tRS7Eo2dYyUM5DhF/HzXsvjCc+WIoL3y2d4s+eDNl80EjIrxca1SuiT6
         vZBlwltJsByn1h0m3Hr7tyK2ySuvVW54VNqBH2iNsbsL0bW34Xa8fjA8/MrDimaZBN2t
         9O8DpIv5prfzIEWV3GmCvyavCMebAXGYVaA9sz9Gy6j1s/SZm55q+vYkcE5iuorrn9W3
         Qb7d2jmp/699C1JxwiWpTDoE9bu8fAvV2L6EhNoeYsB/YUH2YzOMnXrLtqmw4+8d6/PM
         EMKg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2a6zUicaRymarfNwPZI5gBrLjc2d6GcC8a+rmtnM4uBAobP1Nw0NydeVrhPbLdgQTg6JMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzC0dQER6Pe4LL6VzMYYh038nN7/Th6leSD9cVXIjR0NOAc7Ww2
	bejxGmEn+QX3Lp+nlzwU/zvD2HQO1BlbVxUsy8vraUkxZhwcCV31gg8vxnjscJTNYEJQ43B6GjY
	cldMKfJlNbtCrAmCqF3m9QQ==
X-Received: from ejpi2.prod.google.com ([2002:a17:906:4442:b0:b93:57db:4eba])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:f495:b0:b93:62dd:a4a4 with SMTP id a640c23a62f3a-b972e6a5b85mr118824966b.51.1773233748733;
 Wed, 11 Mar 2026 05:55:48 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:55:37 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311125539.4123672-1-mclapinski@google.com>
Subject: [PATCH v6 0/2] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_055551_719861_8F76C85F 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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

Michal Clapinski (1):
  kho: fix deferred init of kho scratch

 include/linux/kexec_handover.h     |  6 +++
 include/linux/memblock.h           |  2 -
 kernel/liveupdate/Kconfig          |  2 -
 kernel/liveupdate/kexec_handover.c | 62 +++++++++++++++++++++++++++++-
 mm/memblock.c                      | 22 -----------
 mm/mm_init.c                       | 17 +++++---
 6 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


