Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AC606A320
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yQrbTiGO;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GMKN6vCQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=n3/QgCFjzvK6G73Tiampz5hPbLES3QQEgOsn43qeBn8=; b=yQrbTiGOJ5UNj15CDpBdZ0/yLY
	givassWfsTbcOl091CZe+ZB5EZ6UDGamX8Es+nNBi6TN1Ishau2YtQRYiEsnwsd+jMru5XlCqsBLf
	DKn2o3S0W0bNxyaFxOlKXM+AUWdjYr/vwiiWrOh2gQSbs0hZKUjLCi7hwn5Y7PDdI6fQvnToPmBgC
	WmpodjFb1QA5HIeCuuHAc3E0512/Z8RACf1jxxnuxiFzfRTgDUGw0AFPLG398ZwrzcngZUGsi+wzM
	DBqEQ8omLJ5462+8Cefceuw9y9XP6/KCrTvp4mOvFWxzvCofOuwFWal3bYAUEQWll40DaVVCHDxgP
	8YiyGk+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKmA-00000002D1K-3CN5;
	Mon, 23 Nov 2026 03:31:33 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKm1-00000002Czd-2au2
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 03:31:24 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8a052288e41so39099b3a.1
        for <kexec@lists.infradead.org>; Sun, 22 Nov 2026 19:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795404680; x=1796009480; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3/QgCFjzvK6G73Tiampz5hPbLES3QQEgOsn43qeBn8=;
        b=GMKN6vCQSYM4S5ufLwgfRVrRgkZ5mfgSVPPzhxdotdn1xdr6UgjHJpmRo6Ph7HB62+
         7Vwu07SqEJHGZ9yeM1A8G3gS0irCwcLdUCQJw2+RKgInuqIbdfX7S/Y4ezDt7hqrOUQb
         12zYWzhyGlMCEsE2uT/kD/Sb7m9Hsv00IN83U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795404680; x=1796009480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3/QgCFjzvK6G73Tiampz5hPbLES3QQEgOsn43qeBn8=;
        b=0Bw9pa6U5uCYXkcn6rVOmYkmlhFpRPekR5ZlumAr3JChsWZV7fRTaL1t0KlHJXgm66
         1SV1PBEv6Xejb42ZFncIscFNU+i2T/k7W+TWvYbE3IKIhGv2ZPBI9yTROsOCLbhdE8Jz
         29pFvJ2hpE63LFKRCCCbpFV4qNCROb6lEr24NM+NIc1FwaheODUvtGfuMxd7cmDveCf6
         ja8lTUr56IXIOFRmwJPoatD2LN4xTi/5re5tI7k9wlXbIfadFwy+hbB/tHe+KkxFVcJu
         zntIF9Xgvq2EArG+2AJ2Wxblmc5oG/mQi3oZvMlz2HTDH0ZCq0KawGHTJ6rc2YEE5mh+
         F9Fw==
X-Forwarded-Encrypted: i=1; AL+hErFMBoFBuH14Ga16AWuC9gQ7p90tr/MMc9zefM2T75Xdq6UieoZLcPgoxm6kNREbubJu9EmQQQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8xkfX5picmuYRQxibrO53B2S8M/NHpHU1kcX8S5asx4jK70LRQ
	OqkgLEw3CAHxD0AVD6NakW3DONjDupbNc+hpZJ7tTsCA0brIp7fIhD/jWdC8+E2cMw==
X-Gm-Gg: AZFdTZcG7/tJG3OjxW897ITCiaGwuMmBcHoEmbBecez018LhH9bBkeAjVkfBE/4MmRh
	8lZPnTop2T4tHgRh6m402KQYdTm3HSrOO6UXImxkyTFtHGrmuSV5YA59pSJr6xUNqbGZd8Ko4mv
	Lkw7PRSdB1SXo6VYW5igni27Qik6azrcFq/AzG846S+UfTss/qpU7TvsLa9y7GexDccO5o2zotl
	oMYUaG6jSJrgbYrTjzSQ0wivd6cd8SBEqer0iv461BYlYuD8RlcpT3k6VT/QRuUDih21EljOw2b
	MqPT+aGneMPyubcDnNVl6Lv95hWZLZqz6BtRCs6NkzM6O9j5M2EmW9QildjoVEjGXQtKcNGBe5z
	hCbPIBAONjIDY8Pi08oTmc1H4bpu4pD025Yz54zlK5QBTFdRh+okKooaMIXyByZx9ykNq7DwLsf
	tN9VUprngoIhJKa9Jgxs/wj5Zqcmw9b3fUGkSgj/745XYxso/rembAmZ7oEeljr8OOg88ZNgsU+
	SQIkE79gr7lqOkWC922TS/N+shs5SCMp/413jusPQTG8m5N64d5t6PAfxhvTaV1tmQaDmwJz0fI
	SIYalNRGiwKyjd/mHddaps/z9Jqj0wiGwXqm/F/lZVhTJxCwW2LdyhoBsO7UDzBXy93yuw==
X-Received: by 2002:a05:6a00:c1ca:20b0:8b0:4ee8:10b7 with SMTP id d2e1a72fcca58-8c8792b617bmr11211724b3a.1.1795404680238;
        Sun, 22 Nov 2026 19:31:20 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8c87285c14fsm4712022b3a.15.2026.11.22.19.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:31:19 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Sun, 22 Nov 2026 19:31:09 -0800
Message-ID: <20261123033111.2349160-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_193121_690354_779E1432 
X-CRM114-Status: GOOD (  12.23  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This series moves __GFP_SKIP_KASAN from GFP_HIGHUSER_MOVABLE to
GFP_HIGHUSER (patch 1) and adds a KUnit test for __GFP_SKIP_KASAN
(patch 2).

GFP_HIGHUSER_MOVABLE already skips KASAN tagging under
CONFIG_KASAN_HW_TAGS, whereas GFP_HIGHUSER does not despite sharing the
same userspace-allocation contract. On an Armv9.2-A device (6.12 kernel,
kasan.mode=sync), skipping KASAN on GFP_HIGHUSER cuts 32 MB
/dev/dma_heap/system alloc+free latency by ~80% and improves an
app-loading OpenGL benchmark by 15-23%. As a side effect, GFP_HIGHUSER
shmem mappings (such as drm_gem_shmem_helper / panthor [1, 2]) stop
hitting the swap-in readahead PROT_MTE tag mismatch, though the general
readahead issue for other gfp masks remains separate.

Changes since v1 [3]:
- Dropped GFP_HIGHUSER_KASAN, the pipe/FUSE/kexec/RDS conversions, and
  page_alloc_highuser_kasan (v1 patches 1-4 and 7) following David
  Hildenbrand's and Tomasz Figa's feedback; kept those callers on
  GFP_HIGHUSER (2 patches instead of 7).
- Rewrote patch 1's commit message concisely (Lorenzo Stoakes).
- Dropped Assisted-by: trailers from the patches, keeping tool
  disclosure here (Lorenzo Stoakes).
- Rebased onto mm-unstable (d12eccbcb79a).
- Kept the fs/kexec/RDS maintainers from v1 on Cc for visibility since
  those patches were dropped.

Testing: built and booted both commits on arm64 with
CONFIG_KASAN_HW_TAGS under QEMU (virt,mte=on) across kasan.mode=sync,
async, and asymm (9/9 runs passed for page_alloc_skip_kasan; 3/3 failed
as expected when patch 1 was reverted, with the next test still
passing). Verified W=1 builds with 0 warnings across arm64 (HW_TAGS,
generic, SW_TAGS, no KASAN) and x86_64 (generic, no KASAN). KUnit tests
were not run on real hardware.

Tooling: an AI coding assistant was used under the author's direction to
audit GFP_HIGHUSER callers, draft the KUnit test helper and changelog
revisions, and run the QEMU/KUnit build and test matrix.

Link: https://lore.kernel.org/r/20260519-panthor-kasan-v2-1-b7384458f076@gmail.com/ [1]
Link: https://lore.kernel.org/r/20260521105148.5497c281@fedora/ [2]
Link: https://lore.kernel.org/all/20261116230627.3537051-1-jeffxu@chromium.org/ [3]

Jeff Xu (2):
  mm: kasan: skip KASAN for GFP_HIGHUSER
  mm/kasan/kunit: add page_alloc_skip_kasan test

 include/linux/gfp_types.h |  4 ++--
 mm/kasan/kasan_test_c.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

base-commit: d12eccbcb79a4fa35c3aa588eb79056af62eb859
-- 
2.56.1.750.gf70dc682cf-goog

