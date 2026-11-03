Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95234606A334
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zMIH1xl0;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y2iwApll
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TcMB+7TMi2bLazC/QSSJVb+dN6unmraBocObaaHDrh4=; b=zMIH1xl0tEb9mP
	3eqpJjnmwa2+IjOSraxbXSzOns67kiRFB/dolCp8JfXar5rjlgjfqrIv3UfB/FcXo86WTHBX+h/vY
	bFMKDtvhVX/Ygf6M81wqPlPsNDsRKLlAXN6A6SrE8+GMmOlnk+z5XFtdawvXw//PUJkLHK9AzTfZS
	TUgLswq8DHSKRG6zRG3zINarvrvSlM6b78yqNE/xZ4ldQ/yAvlKfFFptA1TT5LP7xc+93QNrsQhYv
	pmrxv4ALhugWg1ZJUts+Dy9wpC2o63MEd4nYsJJ8IkSFX3GVIUZvFEO9ZG3QmQBGo1Ngpg1RydCJn
	AXW3wLuhYcHNaqgk/eNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4t4-00000000vEP-2Itf;
	Tue, 03 Nov 2026 03:08:38 +0000
Received: from out-77.mta0.migadu.com ([2001:41d0:1004:224b::4d] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4t1-00000000vDz-0Peg
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 03:08:36 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=9TIi4e+jhWvSVLJqdtmuDmhXX3FHNuF+HLGG6Up3ljY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793675312; v=1; x=1794280112;
 b=Y2iwAplloUzu5bm58twpXtkXG9/CIrmyyFjmR4r0iZ7mcki0wVTD3/AcJHdq+jFn4PndzStX
 io6vtdlQDs6nSNxk8e+ryodh7MtiPa/Xh/QOKBFWs0SWrKpNhZ4OClnOc5QavHY8x0cvltw7H2d
 27+v3+F5MDZwhvhc2vc48Ozo=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 59608abf10f0d8e0;
	Tue, 03 Nov 2026 03:08:32 +0000
X-Mizu-Trace-ID: 59608abf10f0d8e0
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
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 32/47] mm/mremap: fix moving PUD leaves
Date: Tue,  3 Nov 2026 11:08:26 +0800
Message-ID: <20261103030826.79600-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_190835_370491_19AE128F 
X-CRM114-Status: GOOD (  13.83  )
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


On Sat, Oct 31, 2026 at 10:40:01AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>pud_none_or_clear_bad() only really works on page tables. PUD leaves
>confuse the check and make us clear the page table entry and print a
>warning.
>
>Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
>when mapping"), this also leaks device-DAX folio references, mapcounts
>and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
>
>Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
>whole or the move fails, split it. This unmaps it with proper accounting
>instead of treating the leaf entry as a PMD table.
>
>Keep using pud_trans_huge() for now, in the future this code should be
>cleaned up to just check for PUD leaves.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: fallthrough after splitting ]
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/mremap.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 91f0865f6aeea..1237718848f5c 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> 		return NULL;
> 
> 	pud = pud_offset(p4d, addr);
>-	if (pud_none_or_clear_bad(pud))
>+	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
> 		return NULL;
> 
> 	return pud;
>@@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
> 		if (!new_pud)
> 			break;
> 		if (pud_trans_huge(*old_pud)) {
>-			if (extent == HPAGE_PUD_SIZE) {
>-				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
>-				/* We ignore and continue on error? */
>+			if (extent == HPAGE_PUD_SIZE &&
>+			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
> 				continue;
>-			}
>+			split_huge_pud(pmc->old, old_pud, pmc->old_addr);

Right, copy_vma() already sets up the file and offset at the new address,
so we can let subsequent faults rebuild the mapping.

No need to build a PMD table just for the move ;)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
> 			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
> 				continue;
>
>-- 
>2.43.0
>
>

