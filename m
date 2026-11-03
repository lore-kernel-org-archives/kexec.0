Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44424606A32C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fSRpCbAi;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BrQ5Opza
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=89WHsBI4UooPN0e/fzWqgj/M9hLD/tFhYxvpr6aA8I0=; b=fSRpCbAiVgn6qa
	9/W+DMQl46VeIuFsH8ijc2YalhCfFy1KsY4doZFQ+wGHKquBOmDC/k+Xc0t8I7kmFNpJeYNGmqFnt
	cm6o/Mh7Mn+AwefDlgXy0Lx+BMsIYGENaI4Q2+Edk+FlC6gRCXDB0W8wyYOYdXFQPulXGlUfhXWOK
	kJFcXoAoe/91+YFr6j9pfdMtXAknx2lg3BheTIXYu4280ieVW/qOxmDo/LS3vSKPTPdF+4+MmqMMF
	3inzgMDU6KFaNlODWZ1jBR8m19NxzjpUZu3LlOFvVnqL3Ylz7EzsUVDY+CH0J9NNELn356P9mbtL0
	6bAO9vE6Nq+fvFU1ZKlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7yk-00000001F4x-3Sls;
	Tue, 03 Nov 2026 06:26:42 +0000
Received: from out-167.mta1.migadu.com ([95.215.58.167] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7yg-00000001F4O-1WZV
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 06:26:40 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=R4qncA5U596ba8pavgxH4k05FBMaxgAUsAOufRDPVI0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793687194; v=1; x=1794291994;
 b=BrQ5OpzasmaKN5c4rG+lUhIWYHYwU9Zu/yaL7ECDfW6bWPv8oJYd/xoJtaPXoBVLlimlpMUD
 hxMHJYVuqCPlSy9lE3cTmbFIqjIxFUJWVmK1PEWGFGvTx3eyIQsy580HKxs6eKEmRludRp7iNyI
 96WyFglyjScKawmHaqcOgHAs=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 650e1e2cc95fd22e;
	Tue, 03 Nov 2026 06:26:33 +0000
X-Mizu-Trace-ID: 650e1e2cc95fd22e
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
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 38/47] mm: fix deadlock of mremap() against UFFDIO_MOVE
Date: Tue,  3 Nov 2026 14:26:28 +0800
Message-ID: <20261103062628.92242-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-38-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-38-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_222638_690856_8E763EA0 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
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


On Sat, Oct 31, 2026 at 10:40:07AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
>on different VMAs in the same mm. Those VMAs can share page tables, so
>both operations can acquire the same pair of page-table locks.
>
>UFFDIO_MOVE orders the locks by address, while mremap() takes the source
>lock first. These conflicting orders can deadlock; mremap() holding
>mmap_lock for writing no longer helps.
>
>Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
>them for all page-table moves in mremap(). Preserve the source entry
>checks after acquiring both locks. Remove the comments claiming that
>exclusive mmap_lock makes lock ordering irrelevant.
>
>In move_ptes(), make sure to just recheck source and destination PMD
>after taking the locks and drop the overly-long comment.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>[ david: use new helpers consistently; simplify description and comments;
>         move_ptes() fixup ]
>
>Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd operations")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Acked-by: Muchun Song <muchun.song@linux.dev>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

