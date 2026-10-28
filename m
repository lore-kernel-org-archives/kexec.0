Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4229606A321
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y6/xfYRc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPJdSz9m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qIVvq/ZWrS8OHZoPkom4erM5knN+bWWJnYjFer9m7xM=; b=Y6/xfYRc2DVaxpC+dkzhCh8J68
	jjGk5WGaxdq5wD9jjzd6ng1zu4WhOIcRaEC41u80GtYGFqaGe3VgQ6pd4dxR5U6lt3X8tsmDbAdM5
	1YjV0pc946FzrrABSlaHsGww9h2xolXU67cm4OFks9Hspan1EZfRaJw2FEjo5UzoBuv/nHY9IyXEx
	8JJaTtUnvEJuMeRZFO3fME1nvxFX5mFe2rFwfHtmpD6a+veKN5UpGWQNRZNw7j43VqI+FEw5zYZHm
	sNfSR6cMO0/g4FWiz+1CBOsyVy1h2FuTx1zTgp9CiWCfaBFFW9CI1u9GghWWGfxI3IKZ3JtDXYGYX
	2YKTQskQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6E3-00000007Vi2-3gL4;
	Wed, 28 Oct 2026 16:10:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6E2-00000007Vhc-02Xw
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:10:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 71C784341D;
	Wed, 28 Oct 2026 16:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D01F01304;
	Wed, 28 Oct 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203805;
	bh=qIVvq/ZWrS8OHZoPkom4erM5knN+bWWJnYjFer9m7xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPJdSz9mscO0Y+jBQbJ5oP0QUm70aTGZAWcrT+jTuD6vdx/Qb8OPponNgTk8n4Y1d
	 p2sWMWzZgnUx1CpEIa36nSJs0ptmUy3v1PSY+5U7QZtaYyvgVFGdwrmV/idWeBz2b+
	 uL276y2gUD7+U0y4tGXaStraINA9ds/Tah7Ka3O7rBLgTknFhZ45biPDDkgr0fdjL3
	 tM225xap4ZjlZwwZKe2XhPo8eQzbkt6mh8HuOjdwnqp6ps34iSavqm/xazqa+GhB4Q
	 hkoX+iNqgpYCR0M88XiGHAOdpv6aKD7FRWwo6sDOs7dBia+zC8DeAuPlGgXZ6H/MrI
	 glPcSBR0Ss7hw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4AEF11980052;
	Wed, 28 Oct 2026 12:09:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 12:09:58 -0400
X-ME-Sender: <xms:Sx7iajNQ8kCiIPHs7NsgbcOc-5GiijoyiZmqOQUNtt7qSaz8hw8epw>
    <xme:Sx7iajQj06axGz4Ktgks11H8n88buOjM8aZ3zpB5v_ZfdEc4sVQ8AzJl67hPm-gns
    rWcqzWSZaeimaD5r-DzK1Sl0rKMap85IaUB2ZrgrrZgVX3oSkwPqok>
X-ME-Received: <xmr:Sx7iatb8i1YgECvk_z69s4iSEkm98SVsLZx9jjSlGoLxwvQ1w1B8SKwfc-M>
X-ME-Proxy-Cause: dmFkZTEFX6z6UhyyvpX4H7cx49/QxxO3VmgzZkIh+c3mPnpdkklpGc5/WJE8+p9mDInHA/
    ihdwrhdFqJNZFJ63o8zJrwjlQlbph6GhpkbE+h0iQImiKrOuOoavDT6SUFRbm6Mz5dy4o+
    QO4P7rlUx4zU3AvumYf0B3hS1zqghSAZUBPb0mJwudmM4AtaC71AWoiTCGmSQNrgxa58Z6
    ggIUGdqMsg661eTPKd+HvC3dPYGJs/18pFl173/9BPzIvg7fwpisCMG6shG9NwATmBzvpP
    VfX7QEfwcLulxxCkIwX8hPq6yYSpdGzDAUQTeX0RJ3ruyCzuMqbXKbul+VTqFGT0iPMVCR
    +mNoUlYXMEW3h0bSMeWJS0eleYwoFLQzWJ4kHpgQeEHi0bh83wm9mO6zcNmdeaLsGephK3
    qRARM3QyDwaOc1WL4nHInnn/Y0lmu6mZKJrx0FKFYzL/kkAdhj2lsfoNo+lm9P6Rmg7xud
    Cl1ZVleoAeTpFCEQgN70RGrVnMYJ55p1ehkHbVk6zxr7vKxKEJfr9VFRPYnyzGQr7lgHc5
    VXu8+5qh5ZVSAap/uBFq+HKj6xUlHktHs6pGcWvq9m2wtKX4kiE4SSYO46iWTztTwQi4q5
    EdIvNy5BU82W0yUTBIRfBuAKOsraR8UYCNRUPEARViWGEqZ358CyALQRUgEA
X-ME-Proxy: <xmx:Sx7iasynGZhI3aEsFrGOMXHaEHEdfniPQtim08Zgb8uk099CRJRelw>
    <xmx:Sx7iaoe14NnSZmoQ7v9cfQOv8a5sG0K8N3GSI6ZxlBl3PPjVKGVYcA>
    <xmx:Sx7iagQep8ZOnjKGyIamoFTDxPgul0UuEWeQlmcV9eMv-UmWdRkCKQ>
    <xmx:Sx7iauRlr5DTK8qcMUH6ozbcFvGt_bEb6Ai3yQipjH50fmr3RJMLUw>
    <xmx:Sx7iavUxCWu-ziRuNNw9fhDlb7okjuCuNvmZG3wzZl5CWXYuqLUF2IIg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:09:45 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:09:44 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
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
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <auIdjO7IV5UREfK_@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
> 
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
> 
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the PUD
> handling is required as well to handle folded page tables correctly in all
> cases.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

