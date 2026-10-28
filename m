Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292C606A31C
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dVHXkjDi;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uW0yxWCj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7ohDeqYAoftxje+G2/ZUXITZjGtasxeCYee/Ib/dRfM=; b=dVHXkjDiBtEFI2
	SofDm5ELKr2dUEeVVdsFCPmIUbfPwHAmRfoVjISwpIV14c6sN3QiiA6iGDk04fF1KnQMzyV6D7uT3
	UTEl/LTjgsbrdlKVGTogASiiEv2lY5UvDsWKNPKMT8XVA00YsG20UbouhhJ996ZuxvXG4ylEu99wW
	NSj3OXeibjv7SRWYZQQrqMLgVe1RYtvf6Xyj8zOdPZRP9TFoFre1bVNASTM2upGfvGqDDx2+n5dya
	hb7jfx4PDeTyT3r6njomZIkJl9QgmtmPuNOLSeMHGUTEcepHevhEmXCq5X46v3H/I1p1xTBlZdGvI
	aARyN8ccQwF3IB6+RiTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM15s-00000006mUO-2m7c;
	Wed, 28 Oct 2026 10:41:20 +0000
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM15p-00000006mTW-2XBZ
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 10:41:19 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=da6hytzw+BnB+C5CyqKjthZJsFrZnHpNjbdkzPMyrmc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793184074; v=1; x=1793788874;
 b=uW0yxWCjiuY/QAk36l36xDIbaSJ/T96tA0HP6WqCEveTeJBUYemWYRj/4Kdrl9erGZEE7or5
 sUiXKW8oNGaHZWY2AFZKIRSJoe9vBiTzTCKv4/3aisN/9I/naSVMw40cQwofFWY2LRNiPMMzlhF
 fBex+2wJ8adqN7qch7lrDyRo=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id b2f499d91e478fa4;
	Wed, 28 Oct 2026 10:41:14 +0000
X-Mizu-Trace-ID: b2f499d91e478fa4
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
	stable@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
Date: Wed, 28 Oct 2026 18:41:07 +0800
Message-ID: <20261028104107.31470-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_034117_842803_2ACC78F1 
X-CRM114-Status: UNSURE (   9.72  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, Oct 27, 2026 at 12:17:30AM +0100, David Hildenbrand (Arm) wrote:
>Since the deferred split queue became a list_lru, the isolate callback
>moves the folios it took a reference on to an on-stack list, linked
>through folio->_deferred_list, and deferred_split_scan() takes them off
>that list with list_del_init() without holding the list_lru lock.
>
>deferred_split_folio() does not know about the on-stack list. It only
>holds the list_lru lock when it looks at the same list_head, and it can
>run for such a folio: a THP is queued when it is mapped, as a candidate
>for the underused check, and is queued "again" when a part of it gets
>unmapped:
>
>  CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>  list_del_init(&folio->_deferred_list)
>    next->prev = prev
>    prev->next = next
>    entry->next = entry
>                                      list_lru_lock_irqsave()
>                                      folio_set_partially_mapped()
>                                      __list_lru_add()
>                                        list_empty(item)  -> true
>                                        list_add_tail(item, &l->list)
>                                          item->next = &l->list
>                                          item->prev = tail
>    entry->prev = entry
>
>The folio now sits on the list_lru with ->prev pointing to itself. The
>next removal leaves the neighbours pointing to it, and they still do so
>after the folio has been freed. With CONFIG_DEBUG_LIST:
>
>  list_del corruption. prev->next should be ffd4000000270090, but was
>  ffd4000000278090. (prev=ffd4000000270090)
>
>Fix it by grabbing the lock around list_del_init() so
>deferred_split_folio() cannot race with it.
>
>Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
>Cc: stable@vger.kernel.org
>Reported-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

