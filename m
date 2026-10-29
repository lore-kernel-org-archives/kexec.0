Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A66606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y1WmZSaX;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=o3+AgQu4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=; b=Y1WmZSaXdXzYa5
	DgmPBwbHofjmP5MI4CmZft3A1EudlKr9S8fXqdQ8oTBAd3qVRIUQaxxJkM7VCWiNPCZK/ulRaC/Pl
	Ijrjo0W2tTXSDpbArAFjq91xWtd/kfjA8E1b0LXnpTtgiix8/kyo7QCxo0jgJTKrzj4lYLdEnOP5l
	1GAkNKksgXwQ7kg75CLlELej4mQJ9prKSXzODmL5SZhgAYpuqEiBHdRxH+Qoj729g7ESkaH1JqOHR
	yYrgLGANPBYuz5mbLEwiOW+3zzKrw9Ieh4A6B9yMbJsD4Dr9zdibrwKTaEhh045SjLlyQo+nqvK1m
	BWqzuk5ECs7KHCi6M5ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMYeA-0000000ATgn-1tFl;
	Thu, 29 Oct 2026 22:30:58 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMYe5-0000000ATgE-49NN
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 22:30:55 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-917a707f37eso1299736d6.0
        for <kexec@lists.infradead.org>; Thu, 29 Oct 2026 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313051; x=1793917851; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=o3+AgQu4xUIcv7RRIrjHTukuGuD+bQFPe31uhjdqVYXyvUGQXtoQb4rzc1/+lZFjzv
         9tUu9I4W/+THY+JQtrr2t2GtxSSF5OkrgJpfV5SnlHyJbxjuC6sohGh18cb87DCDG3tQ
         07DSOIRQAY8ucifYk1UfIO6U+TM10ID7IOc88e2G7rg7SeZXKLHi1WJttDCGIAo/SaRG
         sOVSfMS+4RCLXDaHaD3+59KVW0iWLtcpvixF5N8D1rFF8yscUHUfaC74YeIgeWGfL6Bs
         V8AxytDkiRzbTgt/PrpvSeREynW1/WP2gbt3jitSPfDNVgdVvUVX3ri+0yfScrxCQhRK
         5Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313051; x=1793917851;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=uyK0Exqtx5Rir3MI3EQTPAO2gCejOZX2xa91qGafASxiJVmrrSeiEhkSL2MFVxJAZx
         F0456LrXfTcV7kK2xt5kbc7KZGUlTGudV5TRCC8WbH/fQipDHUUUqjEG54eo2avqYrOF
         1YThtc583cehayLWPD/b9Cv7WhWvJaU3vYIpcE+OZyy4+nXg35MkQgK+Eco2619McUFD
         RbfxxoW6l4AaGQ70lroXEcOSDW65/M5UDW+4qz/JcNR7lGRhmsgujLjd8eKMK8J/lXic
         honG1MAP6D0q1agzMwmj32ZSyBOgwulP70Y14DLkuNOG4kQBQA3a05WL2RKG7rDIp9c4
         x3Lw==
X-Forwarded-Encrypted: i=1; AKwUvBy75uiHfLOquZ5mORuvkExCY/hIPxgzBp/JQlomV72haxDT5TtoEZI0pQwI1/p/LFlnd3p3wQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLbPNh5tfHp6R1dPVCJQlDKPS3NWnvQdEoE5E3aQFhQGcDHRV66
	HHvI3u5kPTXZfEuTEOqrF+Ovqfxej5jFJ+GlCZ5yLy257llZ2ColrFiapjBjubhTZTM=
X-Gm-Gg: AYBFou1TTQc98YyfowcFfCTnNDqCUF1xTmdvYs+2pGawwesyAXPV2fMhvWRbHDcKVbo
	uSo+eP6NuRlVXrnwrRE8m8WazqTSZ3OKBXv10x8xhOsxCCW8EsYyje1vUGTGbTVp7EfVrRfi7Kn
	x+4MSAB7LJmdkIp0xX0z6b7zrSpqmlOBPMRhI75Y0CdZ5cZRQko7KAbGvHzixqkXVCS8xmda7UA
	6Q+6sx2810fvdaRGQG2Bnc/p26AhpUbd97IKsUKqp19p9jseABmPGlEVXK4Cl9UuoXdC7APHzaM
	Oh8mlwBHGVmyw63tI3aN2Zgv3b4KdsbCJZDiV9nbhIgNINWCAwJ7jyPjZFme0OdYPPJ5NJC8ER0
	PkXFuDpVK9tHJXtEsTAQ1QDODJ6TJeDI64LxmPLrXY5x3f604w+A/ULD9U/te3ncv3lWGjXPkPC
	rVONrhQb+S3YC2oDY6LuBryXxcfxXU5K51RDjnNv6BoGj0fLwgYpSEZWR85nWMTxqyy7hA5A40b
	Z1BVLsWGqCbhYJC1gtKKUwyumkQA8BDwa8O5c95kCTYQ9tfE8tZUo3d7J4QBIj6Q15SSW7M8DEN
	NMJDAI5tS8UBcRyv91i9IcpD2xISyuxXwng2th3/OgVJOZdCtSz9Zlmrj5ce5FXyDTks4m9+e/1
	H
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr5824286d6.15.1793313051262;
        Thu, 29 Oct 2026 15:30:51 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca68e5f47sm398016d6.42.2026.10.29.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:30:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 14/47] mm/huge_memory: fix zapping migration entries
 for device-private THPs
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:30:48 -0400
Message-Id: <179331304801.2127828.6570375349219520262.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_153054_102484_56E516F4 
X-CRM114-Status: GOOD (  14.88  )
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

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A PMD migration entry can refer to a device-private folio.
> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
> 
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
> 
> Check the PMD entry type using pmd_is_device_private_entry().
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

One note below, but it's not a holdup.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> +	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);

pmd_is_device_private_entry() already returns false for a present
pmdval - so !is_present is redundant.  If there was a reason to open
code this, then keep it, but otherwise you could drop it.

-- 
~Gregory


