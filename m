Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCA9FD376A
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PrULVJVjUkqqWE6IcEaH9v85Dt36UVOcnshgCer74SI=; b=BLgi6mMCiK/B2W7kx2uW8R/hv+
	vvWU0b7lkhaobjzCWsoUryu8DBcuxoE2ZcfYL1V7HHZNIaCOqCBZeXcsUWXEvVkdOJf6yfuKVWkVO
	adFGCaPbA0iypB9rt57mvUOW62KbM/utay9mS9MO+11TATGGpvu//c4fqRzfUsmHsYhhq0ifncMtp
	wxH1dJdusOh2Wwyw0ttk6nP18WciBqpRKkWz8xBeM/x1YokDCgk/tphC853BP9dk66lN4zxNdoslG
	ZE1QxYB4V1BMcRsqAJUcTiDu3DZ6mhA+lBPETUondDLi3I1KV5Wc3H5Rnm+19SiUULtdpC6elf450
	zMhOZc6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzf-00000004Mme-35n5;
	Wed, 25 Feb 2026 15:40:07 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzd-00000004Mli-12Yj
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 15:40:06 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so72063655e9.3
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772034002; x=1772638802; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PrULVJVjUkqqWE6IcEaH9v85Dt36UVOcnshgCer74SI=;
        b=KzSEFUTdNZtOlITjAE3C973Wn/AKPMVz6356XuZcZu3K+K1aC6ujlGTzIfwfMz0PcA
         /wR8awCxpeoGXU5iC4bmQbu0G0v+9wqJSSt73lhnk3GU1mGL9n37xttQo7u+mgoHjCm3
         kqLRwWVj6KBeZ0zTrY6zE52YfrT3wK2hg8zq+Gvsk3ecsJzxWxKnYMYUsLl14DzTFKPu
         kmYvVxHhExLUL3tMi135OuO5LMqAKx9Iu1ooCwaNhG6pXOa8hnJ8WkDJjeWg+HNtWY+O
         6voJwxJb275EDOmXygY7XlMdKy5k9lOa4hwPz+PAF2x1ZX5CdbXpPMb9FKnrk7lUFbzI
         tyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034002; x=1772638802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrULVJVjUkqqWE6IcEaH9v85Dt36UVOcnshgCer74SI=;
        b=R+r8kyTm62hBg2fhMDQ23ILZXCBQE6I/XAfi+zZPIHy6iPf7OVsqPbUdOIr++X4+V6
         PMg4H7UpsIgLE5pQ7ajmOuR9GVMmUGDhDVueEL01e6A1XYPNMfhG6bOaGhOeIUl4ghTs
         lCveVKKHfExlvUbyulbwWfI6A5ssG01Zzvy7wTO5G3u+5lD68m/rursbE7uCif8CZPFm
         vVRIfleUo15MkaK7lbBeD80eoF82AQ7R3/yw6Rq2CSyBqO0/CFM9HoHgPJwV3CZT/i9e
         /zskCjNwqBMuthip0ReT6JkstkPzD6Zb0qThoTwHBLDQo6ODJnpL8M9Cpd27+FWO4sSQ
         wOPg==
X-Forwarded-Encrypted: i=1; AJvYcCU35nnlIgzn5FIWiD4MjW+eht6EaKcZOXrQerCQ7e5cSivOOZVWC15rEuRuY5o9WNu2Za7log==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz94ihwIXLw7bOHINyCgax3l1OhkY34Ax2b37+So8W8+qqpBb+7
	/POr+Zg853uueii2oiclN3pDdIKpd4nRHK/pyomxsIf3zCOpcoMeDmGYOMw7Du/YcwjOPwVODYH
	gsbcgyjYYm9zpC1QoUPBJmg==
X-Received: from wmer21.prod.google.com ([2002:a05:600c:4355:b0:483:6c98:3d2f])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c172:b0:483:aa2:6bce with SMTP id 5b1f17b1804b1-483c21a9f7dmr13544945e9.30.1772034002241;
 Wed, 25 Feb 2026 07:40:02 -0800 (PST)
Date: Wed, 25 Feb 2026 16:39:53 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225153955.1006649-1-mclapinski@google.com>
Subject: [PATCH v5 0/2] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_074005_322937_2CE88663 
X-CRM114-Status: UNSURE (   8.38  )
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

Evangelos Petrongonas (1):
  kho: make preserved pages compatible with deferred struct page init

Michal Clapinski (1):
  kho: fix deferred init of kho scratch

 include/linux/memblock.h           |  2 -
 kernel/liveupdate/Kconfig          |  2 -
 kernel/liveupdate/kexec_handover.c | 70 ++++++++++++++++--------------
 mm/memblock.c                      | 22 ----------
 4 files changed, 37 insertions(+), 59 deletions(-)

-- 
2.53.0.414.gf7e9f6c205-goog


