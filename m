Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241F606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WewhOsGK;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fXjOzohu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5cAqrwEG4tJIMReOWfjqK8hyBrP8PRADznX2SjMD38Q=; b=WewhOsGKeFCLWePLc3d4fP3MzR
	oQXFDAGRtaMj33on0uYAr3pPiHSb9E+2V8ytMvuGheKIXGEln7esinpJfFbTmXWMqDNv2GDuNiKgJ
	IuSNxzJ7lW8tNKXVhP3KN2cjdHr8e3eE2M2JkjmTFfw0AuLH9NSav80Iw/cYTh54DQIUj6xSb4onZ
	MmVkFcQsSoMiyePbxH3QkCcxqfo/MRL6bfSG7z01v7CeksAf2r6IjFVDHgM4H9EH1Ym9hrOXuj6De
	16tNog119F80cmHyzG1z06eCs4d9YNlrYGo1vGv04W/yxfDj3rVP4MdVOmOxI9J2MAUZPvtCmglVW
	ETAH4dSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsaO-0000000CVtB-0xWQ;
	Fri, 30 Oct 2026 19:48:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsaJ-0000000CVsZ-2jN8;
	Fri, 30 Oct 2026 19:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cAqrwEG4tJIMReOWfjqK8hyBrP8PRADznX2SjMD38Q=; b=fXjOzohuKhVw0dSm7kurhSEjMx
	6ncivLeUVzuEuljHndk6KFMsr0Gp5XJxpEaViT0PKxjF1DxJfKVZD6Q9Al06C0cKCR263e2//KE/9
	BhqcqOXfNHTNAU8tqbvd360LrmpIB7/G6QybSUdbCUP+XIVqT+B4wc0s+jHx/u/oZmUGjxHOSgHuD
	ij8KyKAVJ4xrVQoXVUEhC4MyuFwAz5abZibH9qw/n8SJv12+1cg+iQN2+0QVbJrsVhozc2r2JDydh
	94x47YWl3uDla8PHV/FnwU3PocKKFJUVUdCMHBvxmzPrP1wVloEWX1Va5n3rsEpyB+qYG+JdCSjcj
	2hxJXohQ==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsa2-0000000Abtz-11sU;
	Fri, 30 Oct 2026 19:48:02 +0000
Date: Fri, 30 Oct 2026 19:48:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/46] mm/filemap: read mapping->a_ops->free_folio under
 i_lock
Message-ID: <auT0csDIJwvwfDqb@casper.infradead.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-6-6f74bec9a5bb@kernel.org>
 <auDG-5bYh2tSQem8@pedro-suse.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDG-5bYh2tSQem8@pedro-suse.lan>
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
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:47:35PM +0000, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 12:17:26AM +0100, David Hildenbrand (Arm) wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
> > after the inode has been freed. Once the folio is deleted from the
> > pagecache it no longer pins the mapping, so after i_lock is dropped
> > e.g., a concurrent final iput() can evict and free the inode before
> > filemap_free_folio() looks up mapping->a_ops->free_folio.
> 
> Ok, but after iput() then nothing also pins the filesystem, and thus the
> module. So we can be calling into total garbage. So what gives?
> 
> You can't just take the pointer, you need to make sure the filesystem
> is also still alive.

I hate the existance of ->free_folio().  It'd be lovely to get rid of
it, but I think that's outside the scope of this patch series.

This patch narrows down the race (and removing modules is a CONFIG
option anywaysoit actually fixes it for some users).  I think this
patch is a significant enough improvement that it's worth applying and
perhaps we can work on removing ->free_folio in the near future?  There
are only four implementations of it today:

fs/nfs/dir.c:   .free_folio = nfs_readdir_clear_array,
fs/orangefs/inode.c:    .free_folio = orangefs_free_folio,
mm/secretmem.c: .free_folio     = secretmem_free_folio,
virt/kvm/guest_memfd.c: .free_folio = kvm_gmem_free_folio,


