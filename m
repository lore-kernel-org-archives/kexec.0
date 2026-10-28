Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCB606A327
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bWxL654Q;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=oZBgIlqj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=; b=bWxL654QsKUDbF
	fVVvcCDHe5Qw2G9zRhpiwDzMR3b8W0slITln/L53dLg9e40BAGVLZCQqJnEKuS60mVpSmm0rj93kN
	JISAY/C0Mip2ll2NaBZ9A2USbcOhqbDB5eRrQgIbB/WiDiWh9G0vAF6LGqvmb31Ky7ljH/wn4USRB
	e46IHsrlFJc2CNiGXE+we4m1h3+mgR13a+nkqy6cB+zNSxq30t7txnzDqWf7B0gAoqONySegPmT5A
	ATG4MQ8aSxyBlv3m9xGlUi/v78XGITu3aY306SnscN/MZJp1gCptZICglMElkukfR2MoErnkSC7kp
	0T2Y+bKzixgv2Pp7Kf3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMBgK-000000080Wx-2k7s;
	Wed, 28 Oct 2026 21:59:40 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMBgH-000000080Wb-2rD9
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 21:59:39 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-93e7ad9f78dso161457485a.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793224775; x=1793829575; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=oZBgIlqjX2NYz3MYpXgiezBxT6MfRgF/LrkCHRS8+jnLcomdqQdD+eXj8OfjlZMm3s
         bUGJ3gT/m86s3ekyBKWsWm7PhXfOfqfcTh5SfEGIhYV76uUpFFovN9k3gohvaJ3+nQUa
         te1tmM/9Ja7XA5BZqvDSz9YbiWzSjPrnudNOyGDv+F/1LenOomg+6m6H6lplvO61HnrQ
         XfrHd9xlGtXrWOcHZgKP4R0S6RshlQh8MZeNUZ84iCTwozcIcEQgK6qkt+Of79Ty5ajJ
         GsTn8/+CeLItuoXFengwQutgCAD+QMFW1HfX31s3KPdoBOa5rmWgUCgZ2/i0eb8P8AXL
         MShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224775; x=1793829575;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=tEsDmpWKParZmfZpDIIvV4gXJqzTKu3fl+7yzs7gyoSWCS3bRNhBkRuI32JfYtY+p/
         GlSPE0aUygkZFSqBKsPMrMSZ55RWs3eg5CkCcIzXeuUqWvoxgDUDav19JpFaq/FoQPc6
         sCYz83+GYykIK/kpbUdbrxvviKF0EwRPMpEtemGa6cKjeM3aublHCIIPdfqO/QVGnH56
         1vaaDlW0Ko4Yp5Nu/V1IRkcg4SBC+El4/nd5ZJOYNKUnS7Yj+9jAFB5vXAc56eqazHmL
         HT1BaNVon8c1btdWHfMFEp/41MJlHXbvKVb+kQAIHA77vd0E3ETrtNc7KMgXA+SDhvgK
         TNkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbu7sLSGkiBSsGbi2uejj634gqcA39wKil18/2uJU5XcEVWcRsuA/J2jF5HVDngYYZ4Na+Pg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ5lUQFGkR6Xnaem68BGtyuXgrUMFZJpTM8JLjNgbMh1AWEd3bE
	VcFTT6Jvie4T6V0YtXfPGY+zp0Mw2D9zqP2Xe7PqrVRX49Ql9LRkvSOivN6qmhl4+VU=
X-Gm-Gg: AYBFou01XW2hW7GWdmL0/61P2I4A4tO+H3wdAu1TpUuPwr6HjM94XaJyqf88pnYa9HB
	EOI9Yy9O6mYZMob7P76mpAHA3Ur2MjH0l8dN/OWzM7pgbrNhlngPWBmjbWzV4kaP5pltBqbCxl+
	UPOOXjM4VW6n5f7PQlSNf86ItVkRQLY1LQD1GKkAuVa4EQhrI7PprlMLFWyQJACKHZJfcb1RFAU
	lxxvDpGinJbehTZ+Eyzxrs6sC0XDPeaOF345pFLPNTeNp9kd0GmqJ24V2AZl1Zzc9asGhrTTn4H
	AC8QlEk60qu8tKJpEy+qSVzpIRgb42nmW7ZzblQ+sOZwmLhv4vnZa2DXFu+/mnx3EoZcuPdIBcd
	LPJVyd/s3HgLt1Z758ALMQ8LL9b9f2j9cWWuZepNejgLtcM3rfCb7WoeLHfnNYSwHnfmD+rZZ7K
	zI813J+SxNk82WCundP/WKCKXtrxehATD/wq7Hh4mCm6qNBpF+usJAbqUCvknyMdNRP9zA5uqdS
	VcOJ3RtqVscMeHpNtys5S8JaUTJK4y6DbcivAwL3yzw4TU5vLKLSpSi/8KJx2g09aYvdby21eJT
	b23nXbpWjXDsdxP/potwDG/286HqH1moK9t9fZ6nUYeId9SM+AUBW11zS2I+0MItcWqUeuiG1z1
	H
X-Received: by 2002:a05:620a:460f:b0:93e:ce12:aadd with SMTP id af79cd13be357-94408db358bmr587757585a.58.1793224775119;
        Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm1374978985a.32.2026.10.28.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:59:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 17:59:33 -0400
Message-Id: <179322477323.1935969.10540673116963281867.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_145937_742252_04C44306 
X-CRM114-Status: GOOD (  15.35  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> If ZONE_DEVICE memory shares a memory section with ordinary memory, the
> section is online and the pfns of the device are valid.
> pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
> the pfn belongs to a dev_pagemap.
> 
> get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
> memunmap_pages() kills the reference first, waits until all pages are
> idle, and then removes the memmap. During all that time the function
> finds nothing, and pfn_to_online_page() hands out the struct pages of the
> device as if they were online memory. A pfn walker reads them while they
> are poisoned and freed.
> 
> The entry in pgmap_array is only deleted after the pages have been
> removed. Look at that instead of trying to get a reference.
> 
> This is probably not worth CCing stable.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

More zone device pfn-walk brittleness :\

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


