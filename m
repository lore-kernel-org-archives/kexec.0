Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D3606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Sy9j1Ix;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m2LOL4sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nSvRu+DrKpZk9fhC33/WfqayjP5HLD0PEYNxYg/H2d4=; b=2Sy9j1IxB131nv
	lCuW5beCgWv0SKga2Sr5u+Qe+rysggdQZtxT9p4O6R3uS+FIvI8Iw7N2dDDh+JmqEtVhYR17NoV/1
	xjSes9F6YrUsDvv+yHEE4H1aUGyqk+J6/n6yMivr+gTt+7M2p9j27Gi2AjTF5rB0nC026TP2fmYwF
	WnfAdZM8zCJmbU+0sdU85rTxwpFYKKq+mCKtD1FtLT0ggSCqFyeD0MMZhGamxL7hMJgFiyp7sODqF
	dg9q0QLtWEi3/WiBbuNYGxUljstPCIRp7vGaIKPMbpAilDaaNoPLMllk2k8Jp0wozx/gOjUTf/woi
	f04fp4WkbaLFJxd5ClAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMI9B-00000008LSU-22g6;
	Thu, 29 Oct 2026 04:53:53 +0000
Received: from out-42.mta0.migadu.com ([2001:41d0:1004:224b::2a] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMI98-00000008LQF-1igf
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 04:53:51 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=i7u+rlmCh6Mr8ur+/yCWDheirhBIEcgUXzKbr5iYaLI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793249624; v=1; x=1793854424;
 b=m2LOL4skhDC/3jZh9t8W2M+84py0eyQoxIpGLCHeEuFHHSAx3bWbvg2K4CtoxrSVQJ1aTcbm
 vRZOUoaNYlBIvEPisG/b378RqyuE0Or3LIEAofP0XuKVQzLEXHbV74Y6E15LXb/Iep5UV9+3HRt
 HHxuEmB9/tcRKhEcNnE2uppA=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 06f3ecca37f8f8d0;
	Thu, 29 Oct 2026 04:53:44 +0000
X-Mizu-Trace-ID: 06f3ecca37f8f8d0
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
	josef@toxicpanda.com,
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
Subject: Re: [PATCH 33/46] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Thu, 29 Oct 2026 12:53:07 +0800
Message-Id: <20261029045307.131675-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_215350_587589_0AF9EF23 
X-CRM114-Status: GOOD (  19.52  )
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

> MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
> folio remains in the stable tree and can gain new mappings without being
> dirtied again. Once marked lazyfree, reclaim can discard data that those
> mappings still need.
> 
> KSM always marks a folio dirty when converting it to a KSM folio in
> try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
> but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
> PG_swapbacked instead of discarding the folio. This also protects folios
> that were already lazyfree when KSM converted them.
> 
> Skip KSM folios before clearing their dirty flag, checking under the
> folio lock to serialize with KSM conversion.
> 
> Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/madvise.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 75b409e97dbf2..a16e3cb256b7b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>  			if (!folio_trylock(folio))
>  				continue;
> +			/*
> +			 * KSM folios can gain new mappings at any time, so we must
> +			 * not clear their dirty flag.
> +			 */
> +			if (folio_test_ksm(folio)) {
> +				folio_unlock(folio);
> +				continue;
> +			}
> +
>  			/*
>  			 * If we have a large folio at this point, we know it is
>  			 * fully mapped so if its mapcount is the same as its
> 
> -- 
> 2.43.0

The fix looks correct to me: checking folio_test_ksm() under the
folio lock properly serializes with KSM conversion, and skipping
the folio avoids clearing PG_dirty on a KSM folio.

Reviewed-by: Xu Xin <xu.xin@linux.dev> 

