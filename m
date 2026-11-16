Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9D606A33A
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z8AbNffm;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jT9nl9sz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GHp/rfBUvBjHE1yqZXzAoWkqkfTsJ4axSlVmhZm3xoI=; b=Z8AbNffm7fNOba
	ksxSCXaMFYNdjaC0xsYUtg7rlWZKwFSJYW3nfR2Bb3XWBlFZJGTn2UNKapjuclN6GTi4E1O4Qnh+w
	JCOnrITlVt/sZYd11slwOBPwUnug4+yP6kSBQ216HATT+3Xd9T0+ZDWlOsb+SNbtAmMi6TBXR7p1T
	I9iYhEslb5CjxzNVl0pmDAwxwEA+A/IfPm9JykY6kIExUkK/J5J1Sq8+1vg/LepSagE2zYKDbKkTi
	UBOUojuyiVIS/cZNQchaqPWGZGc4vTQAPnC468UKsUb39YjJnXhJETq8hvSG2A+kBoprlMhsLIC1b
	2MrwkvFqmKVz8gxmokmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5n7-000000046u5-2sMd;
	Mon, 16 Nov 2026 23:07:13 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5mt-000000046io-1UX7
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:07:04 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cdb8c4233b8so234719a12.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870418; x=1795475218; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHp/rfBUvBjHE1yqZXzAoWkqkfTsJ4axSlVmhZm3xoI=;
        b=jT9nl9sz5Zgzg7qdxt+EVCRVIRrzybLUApYYvm3UHEvcMYXmb/h1/XJL2/9CqS9HWB
         iPrRBFChyzI/NH7isWUHGJUqeg5VItNebSi3CRa5SkgAmjGsNRbNwQZYM0XY4SP+EXYm
         e5slpqyW5jJNhCP8Nv3hgef6DE52MoROIUBSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870418; x=1795475218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GHp/rfBUvBjHE1yqZXzAoWkqkfTsJ4axSlVmhZm3xoI=;
        b=nTBmLFpUW1EioTSmV2qAvsGW9HWJQixCYMfcWN9wctPFoTHrJsdKDAQzFmcGHURU/W
         cH73xXRR1FLs3ShoZ0OmM5Y/aOF/pY3x0gk3uQavbMRvz/w5ZTurw6DpQ93TepCilOJu
         X4vZoZ2JBWfB+YZj48gvYIH0cHEASiaoKHmDyZh2Lv3pKRqF/oFmn5O5sqUig1d1Z2V9
         luKrVdUX/yGC16XF1XrMfY9qMrzvcuYuTjgW5j7E9DN9/wBV0Vdi+GQGdSTRmkZT59gv
         kVuSrzQM1twnicoRzQjE5zWHAuwGtIEHpXHwfCnkyBk6Uq6+bn2R/Kl6iyswy5+GC97+
         +xCA==
X-Forwarded-Encrypted: i=1; AL+hErE9AyPP0HD5iNMb0qkg+Je42J82iF+r4to2kLYugemszMlDYPAaHD5tu11j3Ymsm3NVfM7NQw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9p02d/J7/ATEv2vFkY+pEHGbybaqCNoPW8MgA8zUao9QOr1tFL
	fQvWmxDOmGo3LQEPobS9Rwvh8Gz81xlH0zF7r9X68bfvdzjxrPM1SPNtvSc7Obqywg==
X-Gm-Gg: AYBFou1uQ9b7e1AzaTbzD20GiUPcS/Fcqt6zj1oPCUU2dbzGjtdMzzqyQ3DGzB7jHqd
	g2UpVNMJadQgVMbaMlkoRoAOXdHf3y3Eyf8dDSV8d3yImugHhswUCZ841OvBzWaEY+4Q648ghO8
	4d2xLKPzzY67l2CEH8IPL/HYMU2nb82MlZ6+ObEJ140+f/L52mfMz39efml20VePczlaToZx/iR
	9GLgkGdGjH/0rIZ1A0EiyfhU2+PWGVlyZPXxZ2pbU372QCT35FAXPS8oieLl1HeP7enxJT1n34s
	7QYjxz6YuFMfzjQiG/DdvRLjpx8CW7RJbbj05/X8Pxds6kcZMhRUjW+NvTLi0CsQErYWpY0CZvM
	KFZUvINPCPYVDrDlflSPdFEGUfTcTaYXiSCAcNA5xqDLRwZHDMoXK/fAdaLdJkYkkn42zuprnUd
	RWkAWjNT9CzfCH0BqMsPu0JKiPaN8Vo/QK68AztKKeRuRFlD6QWErRA53TYKs72o/09Xu2r2Fc3
	YDZxntOUp1nxCpvj1tV0vgp+M6Ay9jSWN9eU0IcxoSWhQVPqs2+CfT7HiE7JcahUKDYBAL8mx/A
	bLSDKrzZydw76h7/v4nyWhPkTmqH9Mux3EYi4rGlfWWWemfNQgQAHeRaLt47m6cWNBUxszc84b8
	IYYCjApXqwcbuo6Syzw==
X-Received: by 2002:a05:6300:40d:b0:3f9:aef5:48 with SMTP id adf61e73a8af0-3f9aef5038fmr8109961637.1.1794870418391;
        Mon, 16 Nov 2026 15:06:58 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8bed1a6dbd9sm4131985b3a.27.2026.11.16.15.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:58 -0800 (PST)
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
	Evgenii Stepanov <eugenis@google.com>,
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
Subject: [PATCH v1 5/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Mon, 16 Nov 2026 15:06:25 -0800
Message-ID: <20261116230627.3537051-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_150659_443108_897C8DC1 
X-CRM114-Status: GOOD (  21.27  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move __GFP_SKIP_KASAN from GFP_HIGHUSER_MOVABLE to GFP_HIGHUSER so that
both GFP_HIGHUSER and GFP_HIGHUSER_MOVABLE allocations skip KASAN
unpoisoning on allocation and poisoning on free in HW_TAGS mode.

Previously, commit c275c5c6d50a ("kasan: disable freed user page
poisoning with HW tags"), commit 70c248aca9e7 ("mm: kasan: Skip
unpoisoning of user pages"), and commit 0a54864f8dfb ("kasan: remove
PG_skip_kasan_poison flag") added __GFP_SKIP_KASAN to
GFP_HIGHUSER_MOVABLE because user pages are not intended to be used as
directly addressable kernel data structures, and the lower likelihood of
catching a kernel linear-map bug on user payload pages does not justify
tagging all 256 16-byte MTE granules per 4 KB page on every allocation
and free.

GFP_HIGHUSER shares the same kernel-accessibility contract in
include/linux/gfp_types.h ("for userspace allocations that may be mapped
to userspace, do not need to be directly accessible by the kernel but
that cannot move once in use"). The only semantic difference between
GFP_HIGHUSER and GFP_HIGHUSER_MOVABLE is __GFP_MOVABLE.

For every 4 KB page without __GFP_SKIP_KASAN under CONFIG_KASAN_HW_TAGS,
mte_set_mem_tag_range() tags all 256 16-byte MTE granules (via STG/STZG
and DC GVA/GZVA) on allocation (__kasan_unpoison_pages) and again on
free (__kasan_poison_pages). For users of GFP_HIGHUSER, this can
significantly impact performance when allocating and freeing large
buffers. For example, in graphics and interactive UI workloads, large
DMA-BUF and DRM/GPU buffers are allocated with GFP_HIGHUSER: while
steady-state rendering reuses swapchain buffers, UI window resizes,
surface creation/teardown, and app or scene launches synchronously
allocate and release tens to hundreds of megabytes of DMA-BUF
framebuffers (~32 MB per 4K RGBA frame, or ~96 MB for a triple-buffered
surface) and GPU shmem pools directly on UI, compositor, and render
threads. Touching millions of 16-byte granules stalls these critical
threads for milliseconds per buffer, a significant share of the 8.3 ms
(120 Hz) / 16.7 ms (60 Hz) frame budget, while polluting CPU L1/L2 data
and MTE tag caches, evicting hot working-set cachelines, and saturating
DRAM bandwidth (especially on free when DMA pages are cold in the CPU
cache).

GFP_HIGHUSER is used by subsystems such as the DMA-BUF system heap, DRM
GEM shmem/TTM and non-movable HugeTLB. They use it instead of
GFP_HIGHUSER_MOVABLE only because their pages are pinned for DMA or
cannot migrate.

What skipping KASAN means for the kernel's own accesses to these pages:

- Through vmap(): nothing changes. With CONFIG_KASAN_HW_TAGS those
  pointers already carry the match-all tag, so the page tags never
  protected these accesses.
- Through kmap_local_page() or page_address() (for example ramfs):
  post_alloc_hook() now gives the pages the match-all tag, so these
  accesses are no longer checked. GFP_HIGHUSER_MOVABLE pages already
  behave this way. Callers that want to keep the checks use
  GFP_HIGHUSER_KASAN: the previous patches in this series converted
  pipe, FUSE, kexec and RDS, and backports of this patch should
  include them.

Slab allocations cannot use GFP_HIGHUSER, because they do not accept
__GFP_HIGHMEM. GFP_KERNEL, GFP_USER and vmalloc() allocations are not
affected.

This patch does not address the false-positive KASAN report after shmem
swap-in readahead with MTE that was reported on drm/panthor [1, 2].
There, swap_cluster_readahead() allocates swap-cache folios for
neighboring swap slots with the gfp mask of the shmem mapping being
swapped in. If such a slot holds a page that userspace maps with
PROT_MTE, the folio keeps a KASAN tag in page->flags that does not
match the userspace tags restored by arch_swap_restore().

This patch only removes one way to hit it: shmem mappings that use
GFP_HIGHUSER (such as drm_gem_shmem_helper or panthor) now pass
__GFP_SKIP_KASAN to readahead, so the neighboring folios no longer get
a KASAN tag. The readahead path itself is unchanged, and shmem mappings
with other gfp masks that lack __GFP_SKIP_KASAN can still trigger the
report. That issue should be followed up separately, for example in
[1].

On an Armv9.2-A device running a 6.12-based kernel with kasan.mode=sync,
this reduces the allocation + release time of a ~32 MB buffer from
/dev/dma_heap/system by ~80%: allocation is ~59% faster and release ~98%
faster. Poisoning on free accounted for ~55% of the total before. In an
application loading benchmark, the OpenGL score improves by 15-23%,
recovering 60-80% of the regression that enabling MTE causes.

Link: https://lore.kernel.org/r/20260519-panthor-kasan-v2-1-b7384458f076@gmail.com/ [1]
Link: https://lore.kernel.org/r/20260521105148.5497c281@fedora/ [2]
Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/gfp_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 567c93fc1cfb..bcc4827deb4c 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -386,9 +386,9 @@ enum {
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
-#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
+#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM | __GFP_SKIP_KASAN)
 #define GFP_HIGHUSER_KASAN	(GFP_USER | __GFP_HIGHMEM)
-#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
+#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
-- 
2.56.0.611.g1030f0b940-goog


