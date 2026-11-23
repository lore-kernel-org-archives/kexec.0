Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C211606A32A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vO9pcm+Q;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W36SsExZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u+VJkDmgbhhT238e3Khqv+7tnUuWga3+yY83FP/NeKA=; b=vO9pcm+QPA/HxV
	RkjAc9VsfTgh0Io8RuMEJo50D/oQxvHmndj/hpa/n5aTQV9PAQxKw30IqfEInh2r9XqMp6tdQyUpK
	mxyW2Vu5WGm6D+TNn2p9TVsEt2JyNi8ctxqBb5MQou9q2upVoZjBRVeNZ4GaOnsLDGF8F7KrbFnmz
	xFm57mjcA2Og5Jqj9kYSWnb7Lq0kSgqxn2eVvf+zpptQYcTW7eHBRAMB8cBTDFFDfGCUdsgzgLmLx
	0msnqH13wHS4AKCrJUk8P4q8uAehhaZXpPt6vxfXs+llodwiiHula8Jv0yTiPi00C6ccQ35LDSmn5
	luGrasdsnnwjb0XbwNgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKmD-00000002D42-2xWz;
	Mon, 23 Nov 2026 03:31:33 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKm3-00000002D00-2Th0
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 03:31:25 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3b43d6c3485so278249a91.1
        for <kexec@lists.infradead.org>; Sun, 22 Nov 2026 19:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795404683; x=1796009483; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+VJkDmgbhhT238e3Khqv+7tnUuWga3+yY83FP/NeKA=;
        b=W36SsExZyt8iNQGH0Jv5rNG8Z85MGrFp/PEFyQcP1EgPWwE+rLnSBowLDG6HlfOkrd
         Vnn6i0aGLICaYErGWpALNeyMkr/9O6XOIB1uYsq/kdFX7VcYVKlJITzQU+i3CFJTo0/0
         bN09SDeeUnBPvyR+ZhkqurO3xDxli/l6s6PaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795404683; x=1796009483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+VJkDmgbhhT238e3Khqv+7tnUuWga3+yY83FP/NeKA=;
        b=essayc9HdPuP5O8K1Kl5/vCEVtGdFkOdpuFfBXrhrVHS1tIWNMjHXYt4e4yOlkkVzp
         4k31PLoVrDfOd94E2dUqK2dk3q0yE4sA755fwHZbSP5UVGBBAvfEGOlPin3FWzZzg1iG
         rg3AySN9b/wB2JjvupZxTz8JzheQ54x12DoM4CpB13LVW/VJGQdkM1YYuRlCU75JH8wx
         1/IvQRV7qEBdo8AYg/js7rZqo2JpkRff7Lbkb34zkqfBUKuSyXw7JkLymQd882NzLFED
         t2E146woaoVMuj3H8IUJW2gnqh81JnmBjxTUgnF+s1eN3hd58VTdhPvJEfKuFmLhqx1g
         Bk8Q==
X-Forwarded-Encrypted: i=1; AL+hErEDG20+6lY4/0p+oJ/MKvIp+5PJAS9AnVXk3sWTU0WnxS/JxVmtIAZoduvUYjvTlOSuhmFdrA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/ySzyPGSU1fcHM4nPJRoSBQ/MmA33tnqikdTLf3UGZUGjZMgOb
	2snTYPeMres93R7nsVj1iEKs4G/TFcxvDWN9QQWq6/9SWmBb/GkPuNGmX34NLLc4qg==
X-Gm-Gg: AZFdTZfDoM9wIrvnuzFX4BVIIU6x+xxS/o5/teWCYu/Uta8suSiWcbz8ZrEqEo+vpop
	zHAJ/8NzCzwCyGljWN5upv/5WC2TljtSC5NMR7JKob9v07UgjjogGXvbDH91WNmD28O8W51SbfJ
	ycRzhVqicT7C1Drm0gPrHETK7LASzcjUJe8bAAe9fwcd5KarLCH2NW7DaaxDEM5+qPfO2LKl6ht
	OZlLTnbHPYUN+eW0x3LiSPBDYYGpg/wuN6/Rv340a86u8jKh3FovldufIUeWQq0EP3tmybXup1e
	R2K9YmvEA0K80eqqdDajbVsVsxEv5n6IdN8x6YEmszZCofFioclMnvrlS1ng7xnzQL00VAe9IFN
	W9KsuJ0bk4vQzGrfMhmUPRzgt2zV/6/KDI5i1AHpb6tiUBi6H9nBWYowj4IqP8wRPjzFk0J+4mV
	Sbsjq5ZAnQZUGdftJHrSF9zDQwQPu+QN2ltkF1oOuyBzgaJQlKshcxsXY3WlCZuYLfkX8v+VDLu
	H6Hv+8RO7ZMEXP2+v3egNk9XLnQ6rkZS5TxSgi+TBBDOxS3obBXrMgxpBo0xUuHh1Flj8wDnPCs
	48zfojz06QeKBwGEQa5sRFjprNNHhdePHnRatTDOTRhuhusp7DoqssuM8coGS9BzTGcaLQ==
X-Received: by 2002:a17:90a:e70c:b0:3a0:c1b1:45fb with SMTP id 98e67ed59e1d1-3b41c58aebdmr15663729a91.0.1795404682704;
        Sun, 22 Nov 2026 19:31:22 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b41ad48786sm15745736a91.9.2026.11.22.19.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:31:22 -0800 (PST)
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
Subject: [PATCH v2 1/2] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Sun, 22 Nov 2026 19:31:10 -0800
Message-ID: <20261123033111.2349160-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123033111.2349160-1-jeffxu@chromium.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_193124_276132_74E37CAA 
X-CRM114-Status: GOOD (  12.51  )
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

Move __GFP_SKIP_KASAN from GFP_HIGHUSER_MOVABLE to GFP_HIGHUSER so
non-movable userspace page allocations also skip KASAN tagging on
allocation and poisoning on free under CONFIG_KASAN_HW_TAGS.

GFP_HIGHUSER_MOVABLE already skips KASAN because user pages do not hold
kernel data structures and tagging every 16-byte MTE granule on
allocation and free is expensive. GFP_HIGHUSER has the same contract and
differs only in being non-movable, used mainly by DMA-BUF, DRM/GPU
buffers, and non-movable HugeTLB.

On an Armv9.2-A device (6.12 kernel, kasan.mode=sync), this reduces
32 MB /dev/dma_heap/system alloc+free latency by ~80% (~59% alloc, ~98%
close) and improves an app-loading OpenGL benchmark by 15-23%.

Callers that access GFP_HIGHUSER pages through kmap_local_page() or
page_address() (such as ramfs, pipe/FUSE buffers, kexec, and RDS) lose
HW_TAGS checking on those pages. None of them store kernel structs
there; this matches the trade-off already made for GFP_HIGHUSER_MOVABLE.
Generic and SW_TAGS KASAN are unaffected.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/gfp_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index c1331bf0b239..bb54c7abfb02 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -376,8 +376,8 @@ enum {
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
-#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
-#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
+#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM | __GFP_SKIP_KASAN)
+#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)

base-commit: d12eccbcb79a4fa35c3aa588eb79056af62eb859
-- 
2.56.1.750.gf70dc682cf-goog


