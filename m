Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6EE606A32E
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EaCx9OnA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fg02mM+P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hu2ezbFXEyhvzPYipLaNmuX98BEqOJW5J/R/m8RSLb0=; b=EaCx9OnAvUEZvCdqpVPvXW24js
	cl3HDr2V15BoZp0ipneG29N6t8gJ3aRFneJs2SackJvAFN5bI8DhcicObt17iZFfXKz6ysGkRBgbf
	1TBZEUkhlmk8GfJR9OtGDOZynYvoHbLhs97i9LiVSbA4Pz1ZP3W9qhSBj360JEesutQ9/wkr5QBmx
	3Vf/zoUWCNJqc4Zld9A6KM3HJyJCL2ihuWmPX0gNADnZcnrcRhBM9zFLRS1z6PMelrlGULq0rQVYU
	v8snCXEWQPBiEvYbfVDNk1ekAh12mvnYBC4uK5tfiU2Ol/i+7efmsNOryboBzt+o0abyDZ6rnntTM
	hoOyeXfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlkC-0000000BgPf-3VGl;
	Fri, 30 Oct 2026 12:30:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlkB-0000000BgPG-3Ovy
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 12:30:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 94CE0605C6;
	Fri, 30 Oct 2026 12:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAFB1F0093A;
	Fri, 30 Oct 2026 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363401;
	bh=hu2ezbFXEyhvzPYipLaNmuX98BEqOJW5J/R/m8RSLb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Fg02mM+PuPWrmf4vwct0jXlFZMeQuDiAYwpOteG7E7NWa+rawXxJHLQ+rxU4Iu/5z
	 dHaD/qCLNflG2BY/40J/PeIywGZto9P+aeKoiWOq/eodjFYgtozCCQFl3rLGILjOiV
	 3HHfhk/RO/H/KYZNcFXeCCK+EfX/j9cvHdm/z+qHK5mDR1L5VK045z+oAJrsEXFCaP
	 KeX4rkPy3RyQL3Si1NZqQBPwfcJQWAokQKDGDXyXdbxJOr6KUgY3agb0Xxb8NCVo0B
	 P0j1yAnu8mVQI+43vEWX38ucFx0bgxYGgKKtDx2aBrcL4oT+myqJLRltwHCl+UthTe
	 L8U/RBFarIVow==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Qi Zheng <qi.zheng@linux.dev>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo Stoakes <ljs@kernel.org>,
  Kairui Song <kasong@tencent.com>,  Barry Song <baohua@kernel.org>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Kees Cook <kees@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Jann Horn <jannh@google.com>,  Pedro Falcato
 <pfalcato@suse.de>,  Hugh Dickins <hughd@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Lance Yang <lance.yang@linux.dev>,  Rik van Riel <riel@surriel.com>,
  Harry Yoo <harry@kernel.org>,  Alistair Popple <apopple@nvidia.com>,
  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Matthew Brost <matthew.brost@intel.com>,
  John Hubbard <jhubbard@nvidia.com>,  Peter Xu <peterx@redhat.com>,  Will
 Deacon <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
  Nick Piggin <npiggin@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Minchan Kim <minchan@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  Xu Xin <xu.xin@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Chris Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Youngjun Park <youngjun.park@lge.com>,
  Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Jason Gunthorpe <jgg@ziepe.ca>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-cxl@vger.kernel.org,
  stable@vger.kernel.org,  Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v2 03/47] mm/memfd: check for real shmem inodes before
 accessing shmem state
In-Reply-To: <297adf4c-1792-4dff-a7c8-2694dc2b1446@kernel.org> (David
	Hildenbrand's message of "Fri, 30 Oct 2026 13:06:45 +0100")
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
	<20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
	<2vxzmrrvmnil.fsf@kernel.org>
	<297adf4c-1792-4dff-a7c8-2694dc2b1446@kernel.org>
Date: Fri, 30 Oct 2026 13:29:50 +0100
Message-ID: <2vxzik2jmkw1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30 2026, David Hildenbrand (Arm) wrote:

> On 10/30/26 12:33, Pratyush Yadav wrote:
>> Hi David,
>> 
>> On Thu, Oct 29 2026, David Hildenbrand (Arm) wrote:
[...]
>> Both want to only look at "proper" shmem
>> files, and should not do any work on a Coda file with a shmem mapping.
>> Plus, someone later down the line might use shmem_file() without knowing
>> this subtle problem, and we probably would miss it in review.
>> 
>> For callers that only care about the mapping should then use
>> shmem_mapping(). I am not sure if there are any. Perhaps that would be
>> collapse_file()? But TBH I don't really understand khugepaged all that
>> much. All other callers of shmem_file() seem to care about the actual
>> inode.
>
> Looks like collapse_file() would then use shmem_mapping() for the time
> being. God this is confusing.

Yes...

>
> What about the following replacement:
>
>
> From 6e3c4f92a651e36ed1ae8d7659d2ca08543fa430 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Sat, 24 Oct 2026 21:08:33 +0200
> Subject: [PATCH] mm/shmem: make shmem_file() check the file's inode
>
> shmem_file() only checks if file->f_mapping is a shmem mapping. This
> mapping can belong to another file, however, as with a Coda file backed
> by a tmpfs container after mmap().
>
> So it does not guarantee that the file inode is an actual shmem inode.
>
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
>
> Let's make shmem_file() check the inode's file operations instead, to
> identify shmem inodes reliably. This will identify regular shmem inodes,
> including memfds and ordinary tmpfs files, independently of wrapper file
> operations.
>
> Use shmem_mapping() in collapse_file() instead to not change the behavior
> of collapse_file(): it operates on the page cache and uses mapping->host
> for shmem inode operations. Focusing on the file does not seem relevant.
>
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Looks great, thanks!

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

