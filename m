Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1414606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t6yeKh1v;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICCbTdoW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W+LEOaUQbUL+JHSbe+QhToSeMirP6JQp6AWWXj4VvXk=; b=t6yeKh1vmpWfcishRbcC9zdq1o
	cOK7UyfwIfpBjmETHWu06CbBxsQ1SAX+7lR8Xhtfeh6DJ0bvknXlOJk27rL59+gjDlSfVzJYX/eAC
	PwsDs1jNdfkzRb0jNY46KR0fjd6NznYwEjOW7RxY5uZ2ANWTMe0mwKILAKUKX/tartM0+bCcxKyuv
	Q528dyhDxii4A3WPHdvO1kS01uX6x9n1DNC+QFAU25gz8cK1awzS/5dhueI2uHPCuKHeeX2CSGkgs
	20d1Pu+h5N2tsH3/igKiyMhfaCDHJNNB4vxThOWwTVaNNDwtsIIujXHe61Nz60MPVV36Gedo/GTdo
	X/ZTsRDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcnS-000000044ja-1tno;
	Tue, 27 Oct 2026 08:44:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcnQ-000000044jM-3A4W
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:44:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 31835437B9;
	Tue, 27 Oct 2026 08:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DD61F01825;
	Tue, 27 Oct 2026 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090680;
	bh=W+LEOaUQbUL+JHSbe+QhToSeMirP6JQp6AWWXj4VvXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICCbTdoW/j7vqJ21aKNf/Ed7op7mGrUCMSzQUb8CI9Wrhehz+xNzXORgvl1APqyYy
	 36Djhv9uRr8ibA5ZP/MXz9DGGy2YmD7yoOnrHShKNQ+NeGuxGeCDo7rr3bLeaLmD8S
	 Y6vaYvwfMvcfFhI6X25asa1qBukhNTx8j8CEt/wbHFjYyz6jqnGVxAbA5PciqivIvP
	 H1w3YA7zTBJBBFdxW3/ueobcnz6eECayjH8MEn59pysbYWJt7xD6EkLjBPY8Rz0cxN
	 yndkPIyJetYPEWfWxlUsoRHPsSpa3WU2QdMKXi2GMDbSeMhs4bt8OkMWTEjKTRKmBG
	 Cl5DzBeXFeqTA==
Date: Tue, 27 Oct 2026 08:44:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auBkQ-7IlOnZA4mm@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
 <179307206859.1171062.6841971971647864368.b4-reply@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179307206859.1171062.6841971971647864368.b4-reply@b4>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 08:34:28PM -0700, Gregory Price wrote:
> This one arguably should have at least a trivial selftest.

Generally, we don't include tests with fixes. So these things have to be a
follow up.

--
Cheers, Lorenzo

