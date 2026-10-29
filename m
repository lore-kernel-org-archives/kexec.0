Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE41606A327
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jzDk2eeR;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Y0CiRY6N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=; b=jzDk2eeRi38hoE
	oYfYjYzgKNT51poihCgKnLM+wkUBhF6aju+kt9Scz7LRnfHSyqW4rnonxNPRtekalOwe5QdOx8Im3
	OkwtBbveipADK7rXsXcmKzTAY0e+tDp4PQa1iW0hFMFLWtnLEUHjWXKWq0jSZcFSGpLvUTXr5LrsJ
	vCyjwDd+mt6TTTO/OYkN+hA8zYMrTJu3PO+XR2QncB20gVfp8RFjgo8J2o9jx+1LtrkUTmwO2T7v+
	OucSS2oT9yj2d2WgcbwQw5/3x0vS5U/wfcq+B3m/yjfukFDyh65QaZPooSgECK0RPjjJ19r061NNn
	z5luK91v9u+9NWibnStA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQtD-00000009Uw6-0xW1;
	Thu, 29 Oct 2026 14:13:59 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQtA-00000009UvT-0QR6
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 14:13:57 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso387773866b.2
        for <kexec@lists.infradead.org>; Thu, 29 Oct 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793283233; x=1793888033; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=Y0CiRY6NCXqzF7Llx6sqItlA23ASxNpIB5mEsITO+aDcegA6NXMr/sPGCw8A053H7e
         9PfstsN1atx84EfcFo1pTA1LGfmKxFc7AFDVx5qtAHTk6bEmk/tqtBxGCzB2LsWT6+G/
         j9qiNcuqKA9+Ja8xzy2LwqSrB2xCRBd5UbWbtnMixPtCterhnS6woJUZNWFnBAA1XqEw
         5lZtuss9+GPjPt6z38jk6KhsVBac785ZrfzR1Ac10O7CjQlPE3V7oJURwfeeSbOGOD4b
         KR2kC2/86xY6YKm1yrRRU85ckPQx2AR1zEwSE9btn1n5Cb4xRYDqR/vOiIWeU3C4tKJ7
         wdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283233; x=1793888033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=Ga8xRL+oqFQb5ihcRbWMNGtCPEe206oyddxFosouZQSrmQ/R++SssLDsLS82UIYTIF
         XqOk+nR6R3vkb1RhFvGjiEGgKGCg8LWDNzP/Pbua6xhYJ0IEM7hRkgLzf5Qo1tHS1hXc
         DRl3OXr7ILVL93mMzD1jS1MdieCSsSH8U5N7J4AscULNDCX++9Yy92TmKA7Tr53ez4Vy
         VoKkZHL4s9oN7MjRxeB6FgvflcnblGS+v7mioc+sr2iAp2S9hbwTpShEdiFerhqm3sXl
         aaF+H1N/RNQzpuP9xDd8Br3DPVrvb7j+eWOAxMLR3eMjsoYqYinZh3umqFHQBDR+xrOs
         mPig==
X-Forwarded-Encrypted: i=1; AKwUvBwOgJi4jBejn40BFwLxfQoD0jZpzoqeYnBCuCBX/YUvskcLqznvfuBtdy0e3FLsFgZ3HiEO4Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYJhZbuX9VWMfllX40TEY8y9syen8aqXwOZO2SHJEwAACkVImUk2
	EJdCOtdPjzsdCExtO3eig7LWOhMIUqpLNk4nNaS6c88p2gDjSBR2E++kG+VWpmS4FrM=
X-Gm-Gg: AYBFou2aNzXQ+gBg1fCRaSJoMYhu+qWW9grZwT9SkboCrS/FLhB/48EtAGboKX+XCns
	rH5bH2RT9Y0DY6wBCv+M1xSe0Hn4Z4ZPIAwgmLKNQ9ZmP171EfC9RnpDp72/assf9pq4GefpPLZ
	ylhFbT2GivZ+NLXgX12yyiVgrDcxohYLGJunVgH3muz2yMUPkEubR19xlKy6WicApQ2U4fl4OQ4
	mjPDvBhMGMQfR3fjWRhW3SmTZhU9x15wCtbZ6ZGh+hNd5FPxpf/8NHRxd7gWxZcEIVUBJlBe97N
	FpyiroUeqH5HmRUmSCbRTBZcSc/xrmRccmXxWI96UiFAH3tG+ENwQlEU0EMsKQjksyEAshfrUSl
	uVTFmRvj/g7KP30+ZGuqineQOVYd5RsSDey7KTKx/0/0dgpjZ1u80jVqw/eAo7IqqnD0QHpW2gd
	JP/zNyTkNmQOJvpRiSei3PJyo4GA5Fis4qpEFkTj3Sm8Ug1PPJXx/NVzpXLU5+RlY6glqpaeMcc
	SrcbzXR+gpDqjnk12zXb1+1tt1pRCkMThAGz9nVRB53iVdbVGzr7pv9qqww0I3bmVCOMtNuvQGx
	Nb0Z0xr7aetCIryp6kw=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id a640c23a62f3a-c49be03a73amr545832866b.41.1793283232717;
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm521507866b.60.2026.10.29.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
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
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
 <179323853182.453251.8510731747954180380.b4-reply@b4>
 <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
Date: Thu, 29 Oct 2026 07:13:51 -0700
Message-Id: <179328323124.453251.12177231963891458248.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_071356_320520_2051D500 
X-CRM114-Status: GOOD (  15.71  )
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

On 2026-10-29 12:01 +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 02:48, Gregory Price wrote:
> > On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> > 
> > I get that you want to avoid taking both locks while zapping, but
> > wouldn't it be simpler?  I suppose we don't know what kind of
> > regressions might pop up with that though, bah.
> 
> Exactly, that's the spirit of the original code. We would just block a 1GiB
> range of va space for the entire operation.
> 
> If you think there is a more elegant way of doing it (while minimizing holding
> the pmd lock), please shoot :)
> 

Elegant and this code do not appear to be compatible.

Another look, i think this is the preferred route.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

