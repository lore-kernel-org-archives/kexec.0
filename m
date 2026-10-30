Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE54606A32A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pN44718I;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JZqpmtFQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ey3vPsJ2dQFhz2BxI4N3mBDHBT7ectNl9BIu9ANR89g=; b=pN44718IMJSVdt
	uUTP/bZd4KMJOQ5RubfljH7Y7yRfC7tAy1j9G/whQO5ugwxla5FDeyF16fKiYjYrF85bLQAkWd7di
	npF7qolcf/2h2TeOQq2l//UWM9JMACTDT1EF2b3jMjhsD5M4hEJoIEykZdTFCadCnLuqppf543InB
	F+3tkFNTH/XBrKD+DbrAAXczNrrgENz70LnBI5+CG/TFn9KVI1J/Pqb0r/2ytFe5OUb7VoylAVeA9
	RHaHCIjp7RrvP/l+syDErTdKTfQn5QugD+2yWNomcwXUrKSjVJoLzjt5Abm9RG5U1a1tR2oKxqzvN
	/68PQ6aGepx4yare4ulg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdia-0000000Amdz-0RfV;
	Fri, 30 Oct 2026 03:55:52 +0000
Received: from out-195.mta1.migadu.com ([95.215.58.195] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdiW-0000000AmdH-1LAa
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:55:49 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=U6aEVcyx4cbsQT0ReFIAsX7642J2D1rQ7p5hav7hVYg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793332545; v=1; x=1793937345;
 b=JZqpmtFQ7Ohd/1LNlZcCz7DJxGmfw1W0QBIwKd81WGlQ+GCSScpslPKi5z61+nW3yuNQ2DfG
 qYpgDNHPL3GYEromeJ9ePTKmdga4oQNe9eAq94ZKZxJjP2u8k8hH0quzBvtjDNrpC+rFPoXIxuw
 UlDm22KbKQ+To97lJYUZVLqY=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 29251291072b5e95;
	Fri, 30 Oct 2026 03:55:20 +0000
X-Mizu-Trace-ID: 29251291072b5e95
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mason@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH 39/46] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Fri, 30 Oct 2026 11:54:47 +0800
Message-Id: <20261030035447.140856-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_205548_707123_F0CA74EB 
X-CRM114-Status: GOOD (  22.53  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> A folio read from a swap slot previously shared by KSM can remain in the
> swap cache after the process that first mapped it exits. Its anon_vma
> can then be freed, so ksm_might_need_to_copy() must not dereference it
> to compare roots.
> 
> Doing so can result in some false-positives, resulting in the reverse
> mapping missing the new folio mapping, preventing migration and reclaim.
> 
> SLAB_TYPESAFE_BY_RCU allows individual anon_vma objects to be reused
> immediately after freeing. A stale pointer can then refer to another
> anon_vma whose root matches, even though the target VMA is not linked
> to that anon_vma.
> 
> Move the anonymous rmap compatibility checks into
> folio_anon_rmap_compatible(). Keep the page-index check and compare the
> folio's anon_vma pointer against the VMA's own anon_vma and root first.
> 
> If neither matches, bite the bullet and walk the VMA's anon_vma_chain.
> The VMA keeps these anon_vmas alive, and finding a match guarantees that
> reverse mapping can find the new mapping.
> 
> Lorenzo Stoakes says in a private discussion:
> 
>   "This isn't quite equivalent to the existing check.
> 
>   Every anon_vma in an anon_vma_chain shares the same root, but if you
>   split a VMA then fork both of them like this:
> 
>                   VMA A
>                /        \         <split>
>             VMA B      VMA C
>                \        /
>         root <- anon_vma 1
>                ----^ ^----        <fork>
>               /   parent  \
>         anon_vma 2   anon_vma 3
>              |            |
>            VMA D        VMA E
> 
>   VMA's D and E both get their own new
>   anon_vma's such that:
> 
>   VMA D: anon_vma 2 -> anon_vma 1 -> root
>   VMA E: anon_vma 3 -> anon_vma 1 -> root
> 
>   And if you found a folio referencing anon_vma 2, the existing check:
> 
> 	anon_vma->root == vma->anon-vma->root
> 
>   Would be true for VMA's B, C, D & E.
> 
>   However after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain.
> 
>   Whether or not that could actually happen in practice... 🙂 I don't
>   know.
> 
>   [...] after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain. [...] I would [...] say that
>   you are making the test stricter but more correct.
> "
> 
> If this affects performance when KSM was never even involved, we could
> just track whether KSM ever merged anything and just skip these checks.
> 
> There isn't really a lot we can do otherwise: for mapped folios we might
> be able to use folio_get_anon_vma(), but for unmapped folios there really
> is no easy way to see if the anon_vma is still valid.
> 
> Document the (confusing) lifetime requirements of folio_anon_vma().
> 
> Fixes: ba6f0ff3981e ("ksm: fix ksm swapin time optimization")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c  | 36 +++++++++++++++++++++++++++++++-----
>  mm/util.c | 13 +++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)

Acked-by: Xu Xin <xu.xin@linux.dev>

