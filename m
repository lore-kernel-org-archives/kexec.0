Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD91606A33B
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YPS3TuJJ;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZXwx2S50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=; b=YPS3TuJJT59PQV
	d/+QZ8q8UI5qnmjOknkpS3dKv6+vrrVAxkxiKwII5PhqAcbxZo2m+dX9IzZUoeIjOyOxp9Qs+vd9+
	OzK23icAH7HKpltuvc/opxVG7rLUKeGylmHyQtS3GjTsz95dByrkcSwGm51RPbHGlp53pJYoVByKf
	pPHDPiiU1xCACsQDYgIKOtiBWfFA97P6B/m9y/nQ6+jJ7W6mWQF2gsItD9OJxULHAKQzmgGGoAx72
	sp1mq1d81CKvdCWoKjI0bglIMxjVGJ/iG0L2S43mcwaKFgOF1VdMA7z7dtcibj3hJk1Vk0oI2xYVT
	8MnrOxaR+GG/8vXDWjow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLY5Q-00000003hio-3kuI;
	Tue, 27 Oct 2026 03:42:56 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLY5O-00000003hhf-0MBt
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 03:42:55 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c40f29667e6so592043266b.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072572; x=1793677372; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=ZXwx2S50sdXST8g5IQcbEKqh2R97izkfYawGt6rPhXhZ6+CUOkxq1sRt0FkIhyLgI9
         JH8IkTjj/Kq65SYwaFagezOCNhqtOrme4VqQcxL2348D0xqvRCLdGRkptNlSOdjzOU3W
         wB0Gi/oM33RYj/zGpB3Aub2EUg+00heAfr8nCGCDo6TusvqAQhBOWP/KUOd6x3bghJV9
         T3EwrecMm0G1ekBMTjjdjdRz2wzpFAyCR+r6y+aXxEexMgYPMgnZKngNryQ2o/CINY4f
         jgS04FmVp2GSl/L+p8KySJ2mMDjtLVfZR/e1u/6VOP8qwgTLPrYwIuGAywY8SMXkDrkT
         zqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072572; x=1793677372;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=lo2jLUbFivTY79xkIOemM2DKsAq3gUp5cplFZIirMbKyuGfxyKeULbGmDFZcJWUXm0
         MUNXho1l8vybvVzlvX0y6qn69/2V4HlqwU8MhZd+PzrJC65IKvhacBpRBsvpFY617/9g
         KZ5+cIBPF3vQoTtC1dQhbc2gvSVVBZ9UdxSCT9HJLn2+gn7E2cR3l5NMzEXpAwPfApGU
         4KARhmTElXcDJs2jdCImgnoK+Z1N3qWl2uHUksTF1P3U0EzNa3+N+91BPnKR5vjB5iB8
         Jd/O3QSXbhLMYISaCPK/5HCztjTD/R/Jl8sU9pwgd7MCHyN2Hk8lZG5QnWshNUyc7WSM
         faIQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+ilYqk/lB7yAuR8rN0S4ebPDG+kMVm3s20KEliJMdy3MDwVPFQfiEZDMj0Vi/vCZaOzmHFQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLGzW8RQV9mcVO/RunVw5hUQpEBEkEEN4xlU4rGPE+RHGjvb+ip
	kdWIb7bLBNPpg6vLJHmgVjXTjnC022YmwDw99TBMUeMG30asbEgUd/IO3lSj0ZtQldQ=
X-Gm-Gg: AYBFou2Fyr72TOWBSx3JyoqYl17oai2fgCbL5uwHLk9wKUHIzxqP2v4xnevZ63vk3Dv
	QFvd/SgmzpCcDkhGKDY2YGgqC+AK/5m6/v/48reptraccbX0Ui5lDsqTQiW7mycgqGLULlzb9Sj
	URyRBKOyRCMqgXcF0o1kUjR4uPHLEh3cNz92eTMNTmJpJ9nVHB5pdF3q5pWP2q04lTpMtCUCRnV
	yGzp71wRFQXbc+2yLrR8hXXMX/5WF/0QG2v5RmiLaCexkn3kNUlto/UfBnpJ7HfZXP58ArpOb+Y
	tjB5UrKQNWumMnoMuk6kqveGtc3Tg9SYOhx/Gzol4szFlViVr814j4TfcrG+uutj4XV/SvDv5xU
	B2qXOv5WXDGyFS0i5lyrCU4WrlXhXyJRnBTwoTQ3NtGml/YkaaVlTOXGUTbITsSfkLtoFhifb+3
	WMAcWmZNfLFUul9bq4uOnPDEkgJPPofQ4BTY0ya2deA4uQChzSxFsN6DwJlXbssgfftTgTlaQbq
	ajkgHCvjLWBcdR43FUslAUfnjUh1oyQhdqQOfYVDL0WqvavLfBOA+h93Y0u6Y8B9AAz
X-Received: by 2002:a17:907:96a4:b0:c42:102f:15d7 with SMTP id a640c23a62f3a-c46bdbf000fmr901757066b.10.1793072572116;
        Mon, 26 Oct 2026 20:42:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649997sm382056866b.42.2026.10.26.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:42:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:42:49 -0700
Message-Id: <179307256988.1171062.17835586018092384558.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_204254_151260_1EC6BBE4 
X-CRM114-Status: GOOD (  12.66  )
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
> From: Chris Mason <mason@kernel.org>
> 
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
> 
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>

