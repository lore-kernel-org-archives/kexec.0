Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474C606A31C
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q+1gqBSx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DduHRuPY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J6qvhedKX/gt9L39bpVgRBd7A0g16i9D1HZNiTvqkfw=; b=Q+1gqBSxT6WPtu
	C0TbNgKq7sl8SAXlQLnobNh+uJrDGsDzKOEbktFsl7g1hbWfANK0zC73f3qWKV4poGYkL5k7rpbHb
	X+nGtmSK5CZfphE7uZnppEptZPealy9D5GXdoUszAVR92evpZNbvhg3qvtw2RXmRFR60KZJRDlU9o
	UGOgVn65XUAVKH7RVVs9imTlzPKvE2wvStvcMkZWaj2wQUb4E81b7sbj9uNcygtGxFhP6Bw0g8ctK
	OVS+mgPbUtvKynTa3HBar7Wi9eFooHiJgm/U5VQI3nvdjrbqx3TBZsgJmSMPBiTzmb6dR3a/RPy8h
	TdIb40zPSilrAOEjksmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMaa3-0000000AZys-1MlB;
	Fri, 30 Oct 2026 00:34:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMaZw-0000000AZyf-1iRG
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 00:34:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F6AC438A6;
	Fri, 30 Oct 2026 00:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BF11F000C1;
	Fri, 30 Oct 2026 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793320483;
	bh=J6qvhedKX/gt9L39bpVgRBd7A0g16i9D1HZNiTvqkfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DduHRuPYmFLQVXIsNcNjApO97/T8X2q8UAfCyYP1FbDA55gYCiFqIxgKlBRMzDPCT
	 Eqs2Hx8NW5JNHHOwoaWAREmZ9P3g0DpqSD6ZIAALIBan8uNdEC7bloNBM6ojVGEYVk
	 FENFOG2Gdb/Pe7A0j+ozRR73EUaDH16qGjtXlvUo9kWAgkt1QHi+VdagnEw8C8T74j
	 Yr8bysC4D0OxTeYJFfW5QuO9Da+Ehdf3XvdtWlh8G5C0H/tFFCwNzQnltS9dLOayxj
	 OH44Anbtpxbx/w1SEQjMZhJc6+ynBnLLft0fXjVDgMDV3v73CICkPnVUjb7wRDMMx3
	 S8ms98yTtaxtw==
From: SJ Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 02/47] fork: take mmap_lock before copying mm_struct
Date: Thu, 29 Oct 2026 17:34:33 -0700
Message-ID: <20261030003434.154864-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029-fixes_core-v2-2-a64ce7f83abb@kernel.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 29 Oct 2026 21:32:57 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
> 
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> cause inconsistencies.
> 
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> exec_vm, stack_vm), as that is now no longer required.
> 
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
> 
> Move uprobe_start_dup_mmap() to preserve the lock ordering.

Looks good and makes sense to me.

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

