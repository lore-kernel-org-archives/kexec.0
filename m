Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F7606A332
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sdru9gqk;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=cK/QCDvS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=; b=sdru9gqkuqM/lv
	vCB3grALHXwJm/V/WvW5L/+nSu+FyS9qc8qjL/wAm81pNDis7Qhe2F7vNJ/SgfEqB3vomOcwXX91P
	gdAPdW6MqTnnKzxfNro4vafyqGo06pSWsW1mkhMI9eYI06MCMmS2eo+O/bMs3bRFqqF3h3GvKbbi6
	2txVNjhjQgVKRg73DLWZ0COVWM2MawslwLDm70Q3RlwrtHzWkEOK9kf9hmFchj5SXavAmV/dvTmWp
	tLYrwnOAlMZGO/O/f3JgQcD05LbaNKe3m18qATXKHfoKQfNS1Mb8jM59N01Smwen2a5vKNwPX3hnN
	CsUysJQQx5PkFBpF9Tzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCXC-000000082vb-3ECW;
	Wed, 28 Oct 2026 22:54:18 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCX9-000000082ua-47W7
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 22:54:17 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2253289a12.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793228053; x=1793832853; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=cK/QCDvSmdLrkWnSQ5wc+pSU2gXzdtbo/VovqIXwUTI+svh/6GH3DQZC4zMf3MXwWB
         cUK06EoFv10PQNdqH4TY08qITBpMkTm/nPpU5sFNUWesf71C4Ud/zSCNCj5nRohwqbJc
         GAfXfiHvxHkUQQZQAPc0+MMFqlMYMV+OnoXbJjShfQKYrPtalJQhrucUylktoH/ybQwe
         C5oM1ZSf2EkHvJcBF7T15U2ToLmGpwVpAIGhKUtwTsHN5nDjxRXXJQVpNOIB3QJKEEJo
         4C7G6g7sZcDMLt0ufayx9Jrzxup0kyhnm1oBRUa5b0/XPs77EdXmodycnNctO3jGRVEA
         kzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228053; x=1793832853;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=yerc0FsFPfecBxzAYqz4W/BvFCPG95zZB895FILq1I4I3OKMwBjdwaBJ6ooTGPrqW6
         Mq94UDxYNClk+FfRuMdrBpbt9GNXfKa+RcotJnGEfgQBkhf5WSa6iNOHQWhlbIxxylbQ
         eq+V7sWBSqav9gsRR171pa6XrM3dD6fL9bHKtZ4XP3nqTYCVATccGZJICP6CUvpUaF0m
         GSH/a4xaM1PvG2Dt5aZrV0+aSDJwcXh31ldk+bOjNaPEaQfo/DHxnvTIPLl/lXHWLOC7
         ouhLR6wO1UOIVkHWccUVQ8Qg70x9pub9qodwln5IgnU06oweIctt5d0Iu5JmZRl6YoE1
         pyHw==
X-Forwarded-Encrypted: i=1; AKwUvBz/olRcqhj2QryKlPfzRC+vF3audKDMQHIr78QQyAg7+m0bMjIDJLDLi6QuvllN2RDPx4/CXg==@lists.infradead.org
X-Gm-Message-State: AFq9FYL946bBUTRBeQ+Sdx2PlTiEg6o8ezcoUPC+DvEr5kr5hoAAcMGu
	ufJZCTsQaxx0ao4rNhWUgXGZ8NA49LcXS04fgpNT4LW/QcJIxvSTorvkLtXfFxi3AFU=
X-Gm-Gg: AYBFou3DYN5F/xNFnaPEiuYATR7Sv/D4yXNauDDjN7Lh986n+tUiH0qVn/ylDE7snjL
	QhpvVdhdIH4Jk6XB/GwWnZL82PNE2zAprhnPBfVfI5WqhEnZwJF7ODo1c2vVQjAb4qUP/C9w509
	J4LBOvn5/tn1+CDOaB/LNQrBnsEWk1QrXqiURu1TpgFur89dnc8ZvH+K2NH/vE83IhzBoVqXgS3
	n7Mba/KZ3JPJDH7XhKNE4DBRB4w3Qrgp+utKy6oVIwezo3ZV97rk3nbjukgTFjczeKXoyzBcaj1
	jGgtbpOBD1CN/ntXvKZydHgmwKUuMaoHxXOONzNpNBGglpRQ+AJtWAYa+ldTuil17pTfJVWWXYU
	3VZTIXp+kC8GN++qdBDTQNBQeqDEPGTlWOcxzy3fWj7D3Bd/1Z4Je+ffc+pu+l50obtSn5LA5XX
	EcY/dDnGLYrpvAkfv4cP1/HGeDX7LRKMnAer+5KjrNA1nm/SODTO+EyHCWtVxi1sKraQ8e/wVgs
	8kxCYtfYdbPCpgsn2obvs9BHAy5q5JNMbJXupzJVIBCsN/3bA3XM703JEQ3kRR4k+h1eQH/qUiM
	P9TqEJ/Qzij6K7FE8qOmcAhsi/0uLx908PpG37LpFyE=
X-Received: by 2002:aa7:d0d3:0:b0:6b4:78c3:b8bf with SMTP id 4fb4d7f45d1cf-6b49cbfe65cmr2043596a12.26.1793228053385;
        Wed, 28 Oct 2026 15:54:13 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm1991741a12.37.2026.10.28.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:54:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 45/46] mm/memory-tiers: unregister empty tiers outside
 memory_tier_lock
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
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 15:54:10 -0700
Message-Id: <179322805093.453251.8441529644965692562.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_155416_041979_C476CC51 
X-CRM114-Status: GOOD (  10.72  )
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

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> When offlining a node's last memory empties its tier,
> clear_node_memory_tier() calls device_unregister() while holding
> memory_tier_lock. A concurrent sysfs read can hold a kernfs active
> reference and block in nodelist_show() on that mutex. device_unregister()
> then waits in kernfs_drain() for the read to finish and release its active
> reference, while the reader waits for the offlining task to release the
> mutex.
> 
> Return the node's former tier from clear_node_memory_tier(), making the
> helper more similar to set_node_memory_tier(), which also returns a
> memory_tier pointer. Let the caller unlink an empty tier under
> memory_tier_lock before rebuilding demotion targets, then unregister its
> device after dropping the lock.
> 
> Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

