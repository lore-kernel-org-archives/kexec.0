Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23F606A322
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GoZfFHcc;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bIPJgOc3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tTZpPE9gJn7s96098K7j6uvB27YaMf32yiUhWF9ATX4=; b=GoZfFHcczoTnKr
	wSj3gmaWN3x97dNNadql+D9AByxQRNRdNQR+rqgj4sReG+pw5jksbRAcQWE3dLSqbeKQMhO3O0yiy
	HDiULqgg2mGxC0M1zCZG6ySnkerogLb5PetWm385dFJJK1ES1B/IzKcHsktqCLe7jJLyDH+vhB0X1
	PrCybs7uyS+MrFb5kneuo+cxiXcnJN0BM6c0zQLbkAoA+LMxJGSpZvkkgQRFnrre+JPgFH/RJTqCz
	I9OCJ/2Kkk1M8/6aSujSJhdHqCkyF7o2Ez8ZszFLhu4qOKW+sHlyMKqiK9LMWlxRaD85M7SEb/r3q
	91RlQ8ayHCOpDF6WMIiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5yq-00000007TFR-2uLx;
	Wed, 28 Oct 2026 15:54:24 +0000
Received: from out-54.mta1.migadu.com ([95.215.58.54] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5yn-00000007TEW-3TTk
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 15:54:23 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=tTZpPE9gJn7s96098K7j6uvB27YaMf32yiUhWF9ATX4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793202859; v=1; x=1793807659;
 b=bIPJgOc3iPcKTa1DXojN+YH2KEJcCalwAlquT1K3q2vP78rezERhjcEiyPnYf3XJJi+zm40e
 VZ8Y7h0Sg0LHwZ3RIB6hSZlxVJqtHyTLtmTMwa/Q5NiV5ZlDRHprLtwNr+zvun7UOnbjrZLyZOI
 1EXHQla+Wo0nAnoYaUtKJ62U=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id f81f3d53b1ebb019;
	Wed, 28 Oct 2026 15:54:18 +0000
X-Mizu-Trace-ID: f81f3d53b1ebb019
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 13/46] mm/huge_memory: fix truncate racing with PMD zapping
Date: Wed, 28 Oct 2026 23:54:11 +0800
Message-ID: <20261028155411.50458-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_085422_008677_86F4DA17 
X-CRM114-Status: UNSURE (   6.87  )
X-CRM114-Notice: Please train this message.
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


On Tue, Oct 27, 2026 at 12:17:33AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
>If this was the last mapping, truncation can skip unmapping the folio
>and proceed without waiting for the PMD lock, racing with dirtying.
>
>ifs_set_range_dirty() can oops if MADV_DONTNEED races with
>ftruncate() on XFS, when we get the folio set dirty after it was found
>to not be mapped anymore.
>
>Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
>matching the PTE zap path. This keeps the folio mapped while updating
>its state, so truncation must wait for the page table lock.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify comment and description ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Good catch!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

