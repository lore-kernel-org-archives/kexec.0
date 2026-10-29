Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D3606A320
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=464AvX8W;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BAHOAO51
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=; b=464AvX8WAsIjwa
	gjahCbcj9JUkAWLALede1q14WKCxL2gJzbukFVWfXiwvLtHFvqWtGB6h7fSOs/KCLu7UZFzjLJo0F
	un5IZNvRkI8uBPdR+x0QLQa3GTlDmdYwbDgAWuwB9flQAc0PFj66GssL3zPEhaXKfKfgP4xkck9EI
	zQP/gkgRCteUzoDxdJLUloT7o93mLdFh/mtu5tQM9YC7QVGOOaDqmlddOvXOrWZR8MTviXOvUML+e
	kMC55gqtR+2Zx/o1o5Zr46nHaTLp8xkl4fPnet0ZDBknBkCqDuYZQJuf7jdyuCQo1O5Abd36Rr+WK
	rTM/1WKjX/IxknoJqN4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEom-000000088Vx-3j6K;
	Thu, 29 Oct 2026 01:20:36 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEoi-000000088VH-3yhs
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 01:20:35 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b4a13789b0so328112a12.0
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793236830; x=1793841630; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=BAHOAO51jfPFZ295OuH833D3Q1adnpCpVjTWylNPU8HY9VrljM++/chQKQA1RpSxkd
         buLtju41nB6WYswE1wd80NiXv4TpWDacZD8ueFsP20WdtgOceSMHgokkuurc/YFl9zQv
         3RcnOuxKwu004wL3OwM+I652oue8dkjITvXHU2V24YdrRXZko2YRq1jsmsDTd79fp2Vt
         4LS9P5lLZ4qtUZOe8vTo6hvZnSP36jOQSOryAZ/yq8UGaqth3O5OTXDEkT8sjPGfd2aa
         7eCRNQeL+9fVWoFTdGK549m7NRZ/zSSkg0ux0U+xg7+QLjJTEooVxnmdE7tqUCDr2dsZ
         SLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236830; x=1793841630;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=zU8/XEafAIWAfJaBfPVIvcCwjlRLi2eoVVDYWmb0sWv0105udEFB1ijt10DvB1t5FZ
         2lkgW/SOoVoDhWAKcCy1foQk4e+2kyHMv+HiDenzQ0A6DMBTmiwR7k7Q8yqAcL1+28iR
         UfFUXaHnop0nPMrkh/1v83R6PePOFtW4aHgWQFZg3N1TWxuIpcj89z8VajZVcpbn0tmo
         1k4kXA6O7J8O9wyWrmR/22oznagYj0uxSMNviaNBbVv3nqq+R8uunAso/K0LHb56BtUw
         KloOwOr++BGSTjTuOiEMJap+cxCIuM+kmhM0XnzFDJEd0+ELKWRo5VtosRF9oDsGxUQ7
         wl9g==
X-Forwarded-Encrypted: i=1; AKwUvBw+cdMdujs/H0iQ/zax0BKDTjN7oH3oVDTiQQ5kWioC3861QVw3g3VT40udfI1C/7YDNobmpQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLPc/SNJW2ffFQizxz883I1Zw7XQDCZJpHBzzGtRHzvqcOMqUKc
	JhFuqg6S4v9O5KC0jaWpr9Wid4C1WdT+StKp25EA3VHsDRLH+Pbr+PtmgR+nFRPFOMA=
X-Gm-Gg: AYBFou2f5sxH46M83s4tJCG7dyV8StmkdNWKuqXNRxwgUvYRaxykeLsksK88M9e1TzH
	uoVhs/cDia9NOMeNGbDJ3Gb4itYGiuRFXYXkAFd7XbuF6MRQgMDqS9k0sD8VOirTfmET32rW95X
	t4rLfjY9Xwd92kW86Vc1tfg1i9YWL+WgBytNXRw/HYAuTmulqjZIAlatfGbezV1qt+nDRpJPnHX
	qw+bZlwzNOrdGyg23EDAiA9c8OCm9ifJdU61GaloUgX8O+V9cZE6IpPs9gL5Ps3hQ8Ts8fUiSAp
	nSi4Hn7R7uVaZJM7H58NaNC6brJD1yWmO/CBW2IjdwYJf5+fFqRNt7MdEPNs2zFYL7mVuIJyRrJ
	n4NXXpOXVoIZelRoXNVkJAIm2wSHsrR+lyFa7ivE+Kyl3DpYH2Gz35qMKPFq/l/nAWt9/MpkauI
	V2PguJ9uyD53j972gSv1InAaqbCQ3r8sC/R5/KHbzHd5IEo1wjh9wk6MYUcbZ+pqXhqMzCBm2RS
	N+m9GCOWJkuzq7TTws7aa6Qi87cV73HeWVDdeh5MxwEBEl42ZnZo/IA1TrApaXcheLsJhZWyVSX
	+66j2FK6CoMZYEuCka4H
X-Received: by 2002:a05:6402:c507:10b0:6b4:8d8e:c5c9 with SMTP id 4fb4d7f45d1cf-6b4b0b82678mr569270a12.4.1793236830233;
        Wed, 28 Oct 2026 18:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm671275666b.43.2026.10.28.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
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
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:20:27 -0700
Message-Id: <179323682749.453251.17316394789253085295.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_182033_224397_59B33039 
X-CRM114-Status: GOOD (  12.87  )
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
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
> 
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
> 
> Fix it by performing the check unconditionally.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

