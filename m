Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7398606E6F2
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mJ/N7RD2;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QzuU3YVM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0jU0FKXBVK1IwPB+pnplBif7xzGvyqeYd/rvs2r/ax0=; b=mJ/N7RD2oW6IrR
	TF5LckFjxYHXpGhsxoA0eIi5oA2fdk+iUNnLKJiICGvZAsrTuyY6ZWa69yLa8PKOewYpuS+/iZY7q
	0uWA4LVbS9ULKMtHc55ZqzyefFnvGgFuFZOWlK+o6OPJ+Tr7DDD0/MYJ83t+oEvkOUveDj3oMv8qv
	Nm3EFsAU/CZMLdPMR4qEsz8K1O1W7j/Hvyf3wIRrbbiMNdzC1vJKQyVraql8yU12Ia1zLVxDyeXia
	7ES2CTMZtGjkS1DolOnh3EUOd2h94eR9SEEpSo8WwomLIoYPD2gkkT9v7g7nO13nqXN7u8bW0EASi
	7K5LKiMTOJMSBd5zgCqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFpF-00000002mMb-2mOb;
	Tue, 03 Nov 2026 14:49:25 +0000
Received: from out-80.mta0.migadu.com ([2001:41d0:1004:224b::50] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFpB-00000002mKk-47Ci
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:49:24 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=dOHWqJbFAMJYJY9pYQ0G9QdWl3ff5fr4nC5HvUAG8+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717360; v=1; x=1794322160;
 b=QzuU3YVMkybToy3jCx589JuXk6v7arOjZKVMIuzVTtcNW67BI2N1Sv/tO1vpXZew6+OWlgh+
 BtzfOsvNi5KxLjRGGqGPhJtBN3VmFTvpgdWNR8NKH7Gp6SbMkzFQdncMIrRdzS1uk7Hz+9X+9N+
 g3oq2Ln4/BioZxzKZymYhmOg=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 632a76e6b0da1a08;
	Tue, 03 Nov 2026 14:49:18 +0000
X-Mizu-Trace-ID: 632a76e6b0da1a08
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
Subject: Re: [PATCH v3 42/47] mm/vma: call ->may_split() before a partial merge
Date: Tue,  3 Nov 2026 22:49:09 +0800
Message-ID: <20261103144909.6138-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-42-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-42-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_064922_506526_B6ED6CA7 
X-CRM114-Status: GOOD (  18.80  )
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


On Sat, Oct 31, 2026 at 10:40:11AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>A driver can use the ->may_split() hook to forbid a VMA boundary at
>certain addresses.
>
>A device-dax device is a character device that gives raw access to a
>range of memory through mmap(). device-dax refuses any address that is not
>a multiple of the device's alignment through vm_ops->may_split.
>
>vma_merge_existing_range() can move boundaries, but does not call
>vm_ops->may_split.
>
>If a range at the edge of a VMA gets the attributes of the adjacent VMA,
>the function moves only that range over to the neighbour: one VMA shrinks
>and the other grows. This is a partial merge, and vma_modify() tries it
>before any split.
>
>Take a device-dax VMA that lies next to another VMA of the same file.
>The user calls mprotect() on the one page of the first VMA that touches
>the second VMA, and asks for the protection that the second VMA already
>has. The result is a partial merge. It puts the boundary inside a 1 GiB
>mapping, which is a single leaf entry at the PUD level.
>
>As part of the merge, the kernel looks for a huge PMD to split at the
>new boundary. That code does not expect a PUD leaf:
>
>    vma_merge_existing_range()
>      commit_merge()
>        vma_adjust_trans_huge()
>          split_huge_pmd_address()
>            mm_find_pmd()
>              treats the PUD leaf as a pointer to a PMD table,
>              so the "table" is the device memory that the leaf maps
>            __split_huge_pmd()
>              reads a PMD that the user wrote to the device memory
>              folio_put() on the folio that this PMD names
>
>Bad. While the code must at some point be taught to split PUD entries as
>well, the issue here is that we move VMA boundaries such that they are
>incompatible with the driver.
>
>Fix this by calling ->may_split() on the address that a partial merge
>would move the boundary to, and by abandoning the merge if the driver
>refuses. vma_modify() then tries the split, which fails with -EINVAL.
>
>Factor out existing split handling into check_split() and reuse it.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: improve description; cleanup the code ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>

