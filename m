Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48060A2619
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wGsY1QZO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbGzyk9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QXe+E+RdINfQkHY+Os5n/a14dX5ou5KZ8OJABuBnKpA=; b=wGsY1QZOWNglfNyq/ZbFsx3/w/
	Lw91AnlIQ4tBz15ssDt4N7qncINym1W7ltTfmVweweH5glImLDlDo4Z4C/nCmqSrScpPxMyjZrRUl
	U9BtsaXzBPrSROPfuaHdPm+ovStt/JBaarKFtSu2JC2EXrIJ5lvo2pq/w2Q7ZOOgjuzECmEGwhz1Z
	QPK7kI7aYGi0ASBost9u/G7kk7eGI/cOuGZw2Qkt5SQyIM9Q9d2FInlY9PRb9h3Uem0m/6XXXJ9mr
	Uq7HQautcl7js3st3LatsG02p7IdP/PHVASgCYQLzZIFugEa9zXmsY7nimW+yykls5zuB9oG1fLE3
	fs/+xnMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqAQ-0000000CD3W-3sRo;
	Fri, 30 Oct 2026 17:13:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqAO-0000000CD3O-1wxK
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 17:13:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D66DF42D77;
	Fri, 30 Oct 2026 17:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92A21F00A15;
	Fri, 30 Oct 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380402;
	bh=QXe+E+RdINfQkHY+Os5n/a14dX5ou5KZ8OJABuBnKpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DbGzyk9azvvZF4/Hf1MTiO384vuycPWTpofwisFowcjfo9WOO4kdW/wu1Ibqn+W6X
	 gy8qEeDON8gi/LmAcPUpHcAM6SwwMxcc1RI5XzFx+w/cR1PUoyu5jNOX856m5HUzj7
	 tsTPxHh6q4pXGm3Fqfla8pk7sbXX84pxQEyv/1GypbCyzauFS0gkv/BxU+qmfUzXCD
	 L1dr4R/iSkJQaZr/fenudyZudqY8PtXbSOyZT6+Ni/FYj4qE5UAS3UV68aVOaJWVIS
	 jhlY31zdemO/w2q32veNVndGy1v5j2Pb6YJI/wCOqHKqV5u+Dv2WXdDfvExfzK0IFu
	 hw9EktPxmvAJg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 044BE198003A;
	Fri, 30 Oct 2026 13:13:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 13:13:17 -0400
X-ME-Sender: <xms:ItDkaj6BqRTxPmXLqubigL9EIueGGMOYyDZJHCauOtMaJ3MgxX2GuA>
    <xme:ItDkauPmBiLS4zCQgI1ako_rkgN7gbD3xA4ARpouMkPkpq9O5bXLcGZwRmkNbUUut
    qyhhY_EPdfh927drDZvQyQeEArWzf_MyCtxvA8F_6kLpeF5_qBhFD4>
X-ME-Received: <xmr:ItDkalmIuXQCXobPHjON4pMwdG5tSr8ylF0JjGNRwZNDTm2lzJPWtHsCUV4>
X-ME-Proxy-Cause: dmFkZTErCCgqI31kxNLKTziv36fnXBEJjUhhbu5DiE4X/B+EDWlW7m/zWFNgj1YSweXkBU
    PolifZvSXcJFjYufRKMQCfH+Axb7faxt1OysaST/5q0uUjNM3zGxzIA3gFeFVcWBhKXbNW
    KPCqx0t+2ThS+g9I65B/SqyV4EvgT8RlcuSd8AYuiBPGNwT0icuK3QI4dKqmmyYnVc3+GT
    6sN2z26Z5vHbtaohVyhAiEzg5APh/ZsY1FhYWee3mGH8aF7tJkErXhZ/+GVhIa6n2uEJBH
    7u5P0K7Osx5Q9n4zMWIL1lmmrSHDOexahwyC1SzqtSVC6J0zZuS3gxQCWSSTutkbLvz9OL
    1G5B0tCBk3zs4PzBncyaLxYHanwinwdtaZCqpJ6ef6jJM2nPi2PwFlt5b0F/ITt4b0h9+N
    izzIHz2ibHZClHnL2/8tuTURhBG1Ba2FmvoP3NwOgzaF03d1urngRk50/UaHRkfb97cyRM
    IAGxj9UWlUuiLNDhLWj9LLzrJRJWBrIr3BO1pnJqvr5enhEZfEYeCVvf1npM4ODEAjt8pG
    ARm03c556YtFsMKqSFO8pTdHu2AOabc3nN1UdP3lNk3JPopre+kBHu8NM5sit83odXXixV
    jTndLM0PW/1LFe8x41sowgTYQrmlsDVv97xDfCdkdL1jfY+QRBa84fdZR4qA
X-ME-Proxy: <xmx:ItDkapPAmZPW4q4RAziPX67H4eU72Yrby8DdxcsuJnNo0pFZ-jDvCw>
    <xmx:ItDkakIMIm-_XrCHX4dmQFiWs9DlFcrikbwOcl3tkf5o1lepgl-B9w>
    <xmx:ItDkaqMNySXZj_L2GTHIklevHvfhnRQclkIEgZsWH22uE8K1My3IrA>
    <xmx:ItDkapdG_1eBWASKAWJm3tyiukEI-QLBZXWe1PqxLtyhat2Sm5uwiQ>
    <xmx:ItDkaiyw8GqfXS_d4RkLJK8Hj0Mla3U0nqXEpyEFV7uLsMI1u4YkQmrM>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:13:04 -0400 (EDT)
Date: Fri, 30 Oct 2026 17:13:03 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 05/47] mm/truncate: look again if a folio left the
 mapping
Message-ID: <auTQFEMJucBqFuzJ@thinkstation>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-5-a64ce7f83abb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-fixes_core-v2-5-a64ce7f83abb@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:33:00PM +0100, David Hildenbrand (Arm) wrote:
> invalidate_inode_pages2_range() skips a folio which no longer belongs to
> the mapping by the time it has got the folio lock, on the assumption
> that somebody else has removed it from the page cache. But the folio may
> have been replaced, and then there is a new folio with the same data at
> that index.
> 
> For most cases, like folio migration, that is impossible. However,
> collapse_file() only checks the refcount of the old folios, under the
> i_pages lock, and relies on their folio locks from there on. That works for
> users which repeat the lookup when they find folio->mapping changed.
> The following scenario is, however, possible:
> 
>   CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
>   kiocb_invalidate_pages()
>                                       read the folio (old data), lock it
>                                       refcount check
>   the write completes                 copy to new_folio
>   kiocb_invalidate_post_direct_write()
>     find_get_entries() -> old folio
>                                       xas_store(new_folio)
>                                       folio->mapping = NULL
>                                       folio_unlock(folio)
>     folio_lock()
>     folio->mapping != mapping
>       -> continue
> 
> In that scenario, the collapsed folio with the data from before the write
> stays in the page cache after the write has returned.
> 
> This used to be impossible, as khugepaged only collapsed files that nobody
> had open for writing.
> 
> Restart the lookup at that index, like shmem_undo_range() does. The same
> problem seems to exist in truncate_inode_pages_range() as well when
> truncate_inode_folio() fails, so handle it there as well, but slightly
> differently: simply check once more through find_get_entries().
> 
> Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

