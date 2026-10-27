Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA2606A322
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mHDgfIQw;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=etyuZhJw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=; b=mHDgfIQwUwgh1u
	2Mf4cy57eJLnmjigW0PEWIB94Dt3uAQIUvksz1hlctS2FYVUNAsiNBFsHL1aFCbX4g/6+wZFH5llb
	eSfoW9a9u9BmV7h9HXE+TZd6Q4KAF/p4HHvwTKl2wIOlvXiSfARCyHUV0yqywQqy/6EsZtXAOIZFW
	QHwrZ1BuqOye3xxLD9kuPdRBInVaJxYeKBTpk3fT1DEgBhs4iSno6GLgXUqJQ1twTWnulRyGMs6Dp
	/h3d6a10nCtX7vmwMgX50VdP4lJKnUcUtmOVW3hGnEt9QxYQsCGHX+lCpN6H/TYPTDAx7TI0d0cSW
	LAZd736hhVu0CTuUCWqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLY3A-00000003hWs-28tz;
	Tue, 27 Oct 2026 03:40:36 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLY37-00000003hWT-3j1b
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 03:40:35 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c37b612635bso481546266b.3
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072432; x=1793677232; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=etyuZhJw5i3w2tdx75fNfVi2eEDzhstmqq65L3QAN9036IcU0ey3UlFSGJ63QjPl1V
         0L9O6P1HX2Vp/VVHcUDVPcR0hSr/OmmVoId4QvQ/TaOR4AXrrH47FsXTPbid+zOnjFUs
         2z0Ge0smemAKuI3Y7slGOTtmpkoeooVGpdVi7/6PRM9JuzQIjK0viYw50BmwmdaeFulW
         m8tkwgbh6M1FkNa3HugUUingm8D6rifMO+Aw6a/2URd7fThcc6znrE4qXz0r2ugp+wrO
         fMGLMETx/xHK0Vz1ZYAOio6o2c+zzHEGo/kgADiey3xeJWOrVAvgxI2BmxpcsOktNE5b
         Zkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072432; x=1793677232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=wF5u5zyVrmcDKJtNzESZZeBRT+6e81Y2I9vw75cJAo4f30N5rXVpv6pQLGOqt9EC+u
         OQ9rhjELZ61dJ+Crsaht8i7lynXXBWkOHjm8Chhr/MnM4XztUP5sAdPvxuAzjyy8IoGK
         iT4YtWZPib4Xmx63cHAkj8dmXOhtjUwMX5gqDKcunZ0evLY2upsN/sW86fd71cehSVUg
         rHxf8JP5awjPLNlka1JAgwndJV+OvNAykaAoUrexPBxXyar1mFJEQvTFQngqvEfVyP9v
         k/OmjF9dTp3EIxdP2UtChPRI12nn4ngfS+yNz2sYftdd7D79/GtrlyonXo7wCm3jXkB3
         oYVA==
X-Forwarded-Encrypted: i=1; AKwUvBwhOELlGtY744y02op0kaDpkPb+GMESHeDFjd8UFaOJ5xTJa54ZVJPioxtlH9AVrPwKpTD3ZQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIq7vkhu3aT6WNhSpds1CQt27aoqVg6vhavoaSx0CytOB54yMWO
	7ZK8wIdfwSjslvJRGhvI/x6+L4W48V0XipBfvOVpFbuX1eTShKJ4LWFCU0NVTcibXQE=
X-Gm-Gg: AYBFou039qE0wozeA9vB49WCcbPS07SlF30LJ83+LL/nEvtJ7i2j9Ttv/rhwo5XNtsc
	pw+92jOdLvTgGOCK7yQZiTFhCIBPvkiuv9HMHQtixEEqhT8m894zi49WFXhvlFg/5/TNHx5dbj+
	LRLFF3Ik2Q0hTP7+Tjs2hFtk/fFHEdFW4KZDyQkqx7ryHOKbW/ZVcBr1mw4aczFce7E8ICQVvKZ
	wvG99VX7ujiTvTOCo9BAO/TEmLSMWNZL4XI15232Tvr3GE0k8/Z+nMQwixqhbGQRCV1sysq47fK
	Zekmuzd7WBdmFy76LI/s0b3+E6pWT7ejIAZsAgQqB4D1DTgburszRvesSnMyyjLm9Rh3mw5jExI
	9+9JySSt1UmSmkPSYjBz3RsLVTDSZiu7KSYE5BEpOuDJ3/L+zVY4tTKYP6ktv1bIoiCA777VNAC
	wtznI7U5nDIxb3B09k/KDXBdm4BIbfiluC+Gbv++XRhYOfDril6t6Z8zME2E4HDolq0Bp9uiFkA
	i5qPtWIRpNgHyg4ptMRA3LmzXVkGZiSj4AukZc4BagMFA==
X-Received: by 2002:a17:907:971e:b0:c46:723d:600 with SMTP id a640c23a62f3a-c46bde9f783mr916491966b.41.1793072431944;
        Mon, 26 Oct 2026 20:40:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e784esm379153566b.19.2026.10.26.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:40:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
From: Gregory Price <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:40:28 -0700
Message-Id: <179307242835.1171062.11616590599815003560.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_204033_956116_43C52A79 
X-CRM114-Status: GOOD (  14.12  )
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>

