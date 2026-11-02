Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1F606A330
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W61i/wkW;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QiYgY6HB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HKrmzfM/lfs87w6cnTmZ3Teou0HRxUok6ugK+JqAXis=; b=W61i/wkWgtXi1l
	OFHkqy5vaU1ybY+i8n8ItJL6dUZsfOAdvEQBZegEXZLgaX3hKotqxCMv9hGp7R4xe+0UQXDxibnxM
	ayvG70qFgQyin7tVE+4799raXSOMNUmIhu9dhusIvw7cE50WMLf6iZzG1uE0yJ1344Xlep9t2KVx0
	jfkA5lXkP84sNhI5Kgjc9jsRDyhnP5Svia5EAdTVLqmniRRreb3Y8R2fzDKgMD3amqwJTGFetpDub
	r59tMX3Cb/fRxP3k+LeBqoPVS+KZS3zZvNSeE3Tv+XRFRg/8EsiIuygRETuerJiHUIFqp+Mjumn4R
	oeMeN+o7zUdWdIryyz1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNm5x-0000000FiKf-2mNQ;
	Mon, 02 Nov 2026 07:04:41 +0000
Received: from out-71.mta0.migadu.com ([2001:41d0:1004:224b::47] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNm5u-0000000FiKG-0XEJ
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 07:04:40 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=HKrmzfM/lfs87w6cnTmZ3Teou0HRxUok6ugK+JqAXis=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793603076; v=1; x=1794207876;
 b=QiYgY6HB1mW5E+FEecHdTmLFOegmRB/0Kx7ma4l5h/2qjPvozuRb5Nl7U8kxuJgGo8EsEZWR
 S5bpb779UuW1wWS0WUl/cAtINpj6P6ikL5UuxKgEg2su2eVSGCz8y+cgiDg7di06ITDFb3kKKxx
 BUsNdjRhR6pc39oxlYQF3xEk=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 4b82456d18ca3934;
	Mon, 02 Nov 2026 07:04:35 +0000
X-Mizu-Trace-ID: 4b82456d18ca3934
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
	usama.anjum@arm.com
Subject: Re: [PATCH v3 18/47] mm/khugepaged: check if PTE table is empty in try_collapse_pte_mapped_thp()
Date: Mon,  2 Nov 2026 15:04:26 +0800
Message-ID: <20261102070426.45406-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_230438_298933_7A194C14 
X-CRM114-Status: UNSURE (   8.67  )
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


On Sat, Oct 31, 2026 at 10:39:47AM +0100, David Hildenbrand (Arm) wrote:
>The existing code is rather horrible and already resulted in bugs in the
>past: we special-case UFFD inserting anonymous folios by grabbing the PMD
>lock early, but ignore any other markers (guard, poison through uffd) that
>could have been inserted into the page table in the meantime, effectively
>dropping them.
>
>Let's just unify and simplify the locking: try to grab the PMD table
>lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
>the right order and check if the page table is still empty.

Yep ;)

Taking the PMD lock up front would make the locking easier to follow, though
we'd hold it across all the PTE zapping ;)

>We still perform the heavy lifting (zapping the folio ptes) under PTE table
>lock only.
>
>Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
>depends on hugetlb helpers. This dependency needs a separate cleanup.
>
>Both issues this fixes are rather corner cases. Let's not CC stable for
>now.
>
>Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
>Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

