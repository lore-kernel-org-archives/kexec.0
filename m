Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B86606A31E
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SPYaXjwc;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b8CCq/Qj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3l2+EYB5IAhRg1PJ4Js44zono8mAKRvWJrn0noFOBos=; b=SPYaXjwcdjyP0W
	13eJ0PNmE5i+KthattMMd3rTXr1A1Xq+vvCB/x9L4CEaWFu9LlcsO4eOAuvCOW1XlMPL5A/AeaSqZ
	CCiyh09WhAS5CnXF/F96dxdG4GOdDu3EDeDpBybZnKs2fm576Im6kINuXf9bp4Z31nWj9k69jo/EF
	OX6cn1DuO7jx0HVEiMTcwqceIiv0H0yJzMJ029lRcfCE2K7VmQh/ksH51uWqcgmRKZkic7Xe5HE/R
	3Y3PYbus2wdmtd31MzaNkV2owxubDg3QYs/ya2gqO0AdQ0FUGpc05Q/S5Szcd8zAcIgxCUjztwQCj
	pnq2ZM45IXCIJClWwudw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPow-00000002c3S-2483;
	Mon, 23 Nov 2026 08:54:42 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPoi-00000002c0j-0A2t;
	Mon, 23 Nov 2026 08:54:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABFAD175D;
	Mon, 23 Nov 2026 00:54:20 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EDE83F882;
	Mon, 23 Nov 2026 00:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795424063; bh=ykI/c43VekHLh4s+DX69UMu73TIR/+eRfarVxHM0qgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b8CCq/QjFlgDBE/HQ51/le1Tvx6bIj3ok6U20/6tBMHepTzBZ0epejSL7lohPcGE5
	 TccmXxaTX1nOgvhWwz/yDQDmKLfY9hIOwx+ymd8SYuvACzj45XaT4fYDvGJ38LAJvQ
	 3Ws6uekPCDvBC0r165mQR+Op1SCVMfoJdRpjUC4I=
Message-ID: <d7dae0fd-a4bd-404b-954e-99236dfca560@arm.com>
Date: Mon, 23 Nov 2026 08:54:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: kasan: skip KASAN for GFP_HIGHUSER
To: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver
 <elver@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dev Jain <dev.jain@arm.com>, Ian Rickards <ian.rickards@arm.com>,
 Jann Horn <jannh@google.com>, Jeff Vander Stoep <jeffv@google.com>,
 Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <peter@pcc.me.uk>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Tomasz Figa <tfiga@chromium.org>, Will Deacon <will@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Allison Henderson
 <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, kexec@lists.infradead.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20261123033111.2349160-1-jeffxu@chromium.org>
 <20261123033111.2349160-2-jeffxu@chromium.org>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261123033111.2349160-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_005431_517199_D9D0B413 
X-CRM114-Status: GOOD (  19.66  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/2026 03:31, Jeff Xu wrote:
> Move __GFP_SKIP_KASAN from GFP_HIGHUSER_MOVABLE to GFP_HIGHUSER so
> non-movable userspace page allocations also skip KASAN tagging on
> allocation and poisoning on free under CONFIG_KASAN_HW_TAGS.
> 
> GFP_HIGHUSER_MOVABLE already skips KASAN because user pages do not hold
> kernel data structures and tagging every 16-byte MTE granule on
> allocation and free is expensive. GFP_HIGHUSER has the same contract and
> differs only in being non-movable, used mainly by DMA-BUF, DRM/GPU
> buffers, and non-movable HugeTLB.
> 
> On an Armv9.2-A device (6.12 kernel, kasan.mode=sync), this reduces
> 32 MB /dev/dma_heap/system alloc+free latency by ~80% (~59% alloc, ~98%
> close) and improves an app-loading OpenGL benchmark by 15-23%.
> 
> Callers that access GFP_HIGHUSER pages through kmap_local_page() or
> page_address() (such as ramfs, pipe/FUSE buffers, kexec, and RDS) lose
> HW_TAGS checking on those pages. None of them store kernel structs
> there; this matches the trade-off already made for GFP_HIGHUSER_MOVABLE.
> Generic and SW_TAGS KASAN are unaffected.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

LGTM; I agree with your assessment of the risk.

We have seen poisoning pages at free-time being a performance bottleneck because
the tags are kept inline with data in the cache, and setting the tags therefore
causes hot data to be evicted to bring in the cold data just to set the tags. We
had been experimenting with the concept of "elide poison on free" for "in-kernel
MTE enabled in production" use cases to solve this. But the security analysis is
a bit complex.

I anticipate that your change is probably solving most of the same performance
cost in a much more straightforward manner. I'm guessing these DMA/DRM/GPU
buffers are the largest in-kernel memory allocators for the Android app start
use case.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/gfp_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index c1331bf0b239..bb54c7abfb02 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -376,8 +376,8 @@ enum {
>  #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
>  #define GFP_DMA		__GFP_DMA
>  #define GFP_DMA32	__GFP_DMA32
> -#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
> -#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
> +#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM | __GFP_SKIP_KASAN)
> +#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
>  #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
> 
> base-commit: d12eccbcb79a4fa35c3aa588eb79056af62eb859


