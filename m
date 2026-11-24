Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EB606A323
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XxPOblG2;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JcL/Jcvd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=; b=XxPOblG2j5SJJr
	zhHEI9VmtNtU/9/Z74D0FfNuFVdl5NrEG/56jRz0J2s948Zv3z/IjFKxqzNIcWeP47GcOCZlYt+cn
	AvWkb4nk3rlQ2I2MMETyCMHU3gW7Uq1I314wqqbezNNVWgIK3/HDAf1E/DpwKszMtItKpeS0c5L20
	MuQnPOW/thB52hcqEJdPgwFDyty9SaULvudixBoI+I1362UrndNkO7mnfOmELLSeymbQvkQU01VP2
	COLhdv7qdzglnhEEHoGG/irj2RZe58eMhpYJdE0R6djiffT5DudrwPs9FHTSrQIs3JdREyMNxiPd5
	UfK9ZyAYGLjfOeKP3vjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVwbY-00000007fvP-30Bm;
	Tue, 24 Nov 2026 19:55:04 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVwbV-00000007ft7-35j9
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 19:55:03 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8bed7a8c7a1so369572b3a.3
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795550100; x=1796154900; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=;
        b=JcL/Jcvd4uUXfOozIUSoml1rpmTmw44OzA+HpbEAy+prdsM7Vy8bkdXHG1fcCa882W
         1fwRex4QSSn59XgBLo6qaZsHp4UZUw4Qe31QsssHzgjFxfPLEAwCXlkpyYMWgE5vP4zN
         mdZzlibZZ7DYQBgTiuZE0S8offnwe+WpHCYi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550100; x=1796154900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=;
        b=v0N/A67UXTIs+CKAGVPcanDBf5gqZ6P9SoyE3feWmFm2LWqx6abqPL4u/HTigdS631
         0hsbyBAJD3+7skgj4V5BgN+A8MIzoYafD0jjNVnJ/KSS1GVndhks8I6PADOAC9nHrcJd
         ONdO4rweq4rjxAD5XvySNz8RLvZgn42fDm3fWEeLvQEDxTAy76LPnsLZsjJFoPnV5PCe
         CLY9xsjg6bMAIQAjmfNYSNVr1XBsD4bCUFmN82gTrKK1t0MgXof/bUSH0z36ljex0IYM
         r0sA4COACBaAui2vx/9g+5hhRRoRn6dd5uGr91QJxhXmOzh1ApFo89Wt1nL/Uq78LVHh
         Z6YQ==
X-Forwarded-Encrypted: i=1; AL+hErFtt0AGJeTazSWUPH5LTlKe66N+X5KgOehCOgUZcsaP8/rAgdNPDfjBDAroynoSG6PHpc88Qg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/vbssHeRmY/hhYVW6y/VgiOfzplFTONILfe6+1Vkh8fMRkvUUc
	4JKHSU8Jc356Ic/JqEyeo6K4xdMRCC+tXbhtSx6Z8JOLU8l7/M9FhoqwryfmDMzDag==
X-Gm-Gg: AZFdTZeEAGmWNZQ5iFATh2HYYFoI2IOREDZBYbtYrIcUtp9nEAIDFgQXJaQGmfbKE4z
	9bh75xBaZH9QGo8+B4Jp/gFVfpzaK5XYy4LX6tQ96SwgDzrfQbwXwoEQcmapKdyIbXlHpZQmjMq
	EHAqUz1yD8MD68Z81SuyNt2vF0x2UFLV44VdsezHcQwiv5jqwDE6BRuB9Ji7Pa6tdwr9kH1lDmu
	//40+wW9dcfjIeTWLvNAbSfSAUpGXVOwWytox2yojAtahJ+3WjrusGS/w6SFGkzcI8QLQBRRvD2
	JEaGut3g/jJLIHE0RULUTROQRxk8n7Nqap34WRv0dovMA4XA2N0dnF2BzWV/xGoa3Kkqm8Jiztj
	SpOXGQVIVunrnDHbLfpdDqy91QjiwAaD2zQdJEVT52aWr3JUsCPxXPhJ7IKdvXc3k/ie+YTrE50
	oT0AfhZrxBpoX+uxB/OryGus7xd4yCMaFY0osaTwdnYOVI6SVC6N34Cm9OLPvwv4hTSnUH2/WZF
	s5LHE3MmRiKBIph8JuB7GX87lr2OGwqiayMDH/FGBIsE0wfynVUwTjmWiMhAEmtpgfXdVNP1e4K
	A8ayEhhiNlYCk5hTLYrOvVQw9MmqpTVexdUO/WPKDypBqm/UrOMaO7cNEPWOai7sLQOjoA==
X-Received: by 2002:a17:903:4688:b0:2f0:7d6d:4a09 with SMTP id d9443c01a7336-2f07d6d4bc1mr137239435ad.1.1795550100419;
        Tue, 24 Nov 2026 11:55:00 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2f03f142b8bsm72335435ad.70.2026.11.24.11.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:55:00 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
Subject: Re: [PATCH v2 1/2] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 24 Nov 2026 11:54:55 -0800
Message-ID: <20261124195455.164425-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <7ed1f755-5759-4b5b-ae00-a814f16b7903@kernel.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org> <20261123033111.2349160-2-jeffxu@chromium.org> <7ed1f755-5759-4b5b-ae00-a814f16b7903@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_115501_812918_26BE9314 
X-CRM114-Status: GOOD (  12.15  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 09:10:53AM +0100, David Hildenbrand (Arm) wrote:
> On 11/23/26 04:31, Jeff Xu wrote:
> > -#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
> > -#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
> > +#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM | __GFP_SKIP_KASAN)
> > +#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
>
> Can we please add a big fat comment above GFP_HIGHUSER, explaining why we use
> __GFP_SKIP_KASAN and which security impact this has?

Sure, I'll add a comment above GFP_HIGHUSER in v3:

/*
 * GFP_HIGHUSER (and GFP_HIGHUSER_MOVABLE derived from it) sets
 * __GFP_SKIP_KASAN to skip HW_TAGS tagging on allocation and poisoning on
 * free. These pages are meant for userspace data (e.g. anonymous and page
 * cache pages, DMA-BUF, GPU/DRM buffers) rather than kernel data structures,
 * and tagging every granule on allocation and free is expensive.
 *
 * Security impact: under CONFIG_KASAN_HW_TAGS, these pages carry the
 * match-all tag (0xff), so kernel accesses via page_address() or
 * kmap_local_page() lose HW_TAGS out-of-bounds and use-after-free
 * detection. Callers that store kernel data structures in these pages
 * should not use GFP_HIGHUSER. Generic and SW_TAGS KASAN are unaffected.
 */

Thanks,
Jeff

