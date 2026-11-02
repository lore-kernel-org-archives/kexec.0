Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D3606A326
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EwaeOfAJ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zb1GeGbo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=who8ZKKpx/jTygdDf46XygrUGTNQ5Ti9QGrea7MK2kQ=; b=EwaeOfAJ+So4wb
	76zHbAMgHxNbysgCFjbwvHDa4Vs1yfSAWI0PlpmIcL125uzVXiawgbaAufhQ+hXmQfutpsxx50z2Y
	NqKiigcSf8oN5SJXeL2DZywW2ujeVccioDlZ11g16LipoSUET0FNWda09dgCCoN9HXyKUWQFCMlpH
	59SlPyNin+fepY1IDSNLIHT2Nn3aNPtqg1Z7THGomKrC6QhdxakHhWxksFtWqFR1Gx7oSD7CN1Pc2
	tTn6vLrMia/MHx3nV4fE+5uBMWgktg7LimS55sc6fO4Hq4BH2o1zV8Y3Uvwa/aVt6Th1qIci/G2WY
	QcEl5Oo34A+FJaybU+lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNqTA-0000000GNf1-2uzz;
	Mon, 02 Nov 2026 11:44:56 +0000
Received: from out-143.mta1.migadu.com ([2001:41d0:203:375::8f] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNqT8-0000000GNdW-0soa
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 11:44:55 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=fgRhZQDSEmJFZyIgGkSRYKnhjZ4Z1l5m8LV8w/ZXnHw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793619890; v=1; x=1794224690;
 b=Zb1GeGbojxXveT3cZxDPn//4R8A7h+RMO72HLl435m67FVvM9SHf44yaVVp55n3SAPWWoirq
 Hz8XE56QJlzs5IpeJmF7MvIRESwEWtyXzDq/oA5mLYy34SDIJOr+HdZ4EG3OGTtz9aHGD3cJfWY
 yqj/TBZodxsUUHX+M5Y8plAE=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 6ed161f8dd0a3c59;
	Mon, 02 Nov 2026 11:44:49 +0000
X-Mizu-Trace-ID: 6ed161f8dd0a3c59
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
	usama.anjum@arm.com
Subject: Re: [PATCH v3 30/47] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Mon,  2 Nov 2026 19:44:42 +0800
Message-ID: <20261102114442.65682-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-30-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-30-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_034454_386814_D7FE0FBC 
X-CRM114-Status: UNSURE (   9.71  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Oct 31, 2026 at 10:39:59AM +0100, David Hildenbrand (Arm) wrote:
>move_huge_pud() reads the old PUD and clears it in separate operations.
>Hardware accessed or dirty updates between those operations can be lost
>when the saved entry is installed at the new address.

Yep. HW can still update the A/D bits while the PUD lock is held :)

>The raw pud_clear() also bypasses page_table_check_pud_clear(), while
>set_pud_at() accounts for the destination mapping. This leaves the
>checker counts unbalanced for mappings tracked by page table checking.
>
>To fix it, simply use pudp_huge_get_and_clear().
>
>Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
>Cc: stable@vger.kernel.org
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/mremap.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 0d06d7f37f19a..16e736c72d9cb 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
> 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> 
> 	/* Clear the pud */
>-	pud = *old_pud;
>-	pud_clear(old_pud);
>+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 
> 	VM_BUG_ON(!pud_none(*new_pud));
> 
>
>-- 
>2.43.0
>
>

