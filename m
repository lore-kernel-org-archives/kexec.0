Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEB606A333
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YnAGq0ok;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ikc01+Yw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H67vUejc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ikc01+Yw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H67vUejc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eP4c7kBh4vXoea1Jno5pzeNfYitw/HO5XidJB0zRVa4=; b=YnAGq0okbcgQDN1Noc2ZCrsKrh
	/Fqe8jFFJlxV4WhjkQQxTTI5gp06YiflqoCL8M+fhUQK83csMZPkSsSsNFcokyj1DM/vKFkJoQHOt
	AZ4NIpNukro26U/P/O7jJOJBaEEeztJ0B1UJhl3cLZsi2S560IvVD40lPP0pLclkX5NAp+lg5b2mP
	sK2pPQnMHboWi9iX7tGpP9Zt1mqBJBgFVTGpXkL+waOHrsl5QBEHeo3WFiqm4EWJ9rOdjbqLAfr4E
	UnNqVlF0YGNNIlx6zjuu3sJbGqT5wIM0adk+0WKmQXsQOW7Dzu5O663HorUhaUt9AQUTN5YLCuvQN
	0PzAAnbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM3Zz-000000072d1-1acq;
	Wed, 28 Oct 2026 13:20:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM3Zw-000000072cc-2qPp
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 13:20:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D1A51F7AF;
	Wed, 28 Oct 2026 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793193630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP4c7kBh4vXoea1Jno5pzeNfYitw/HO5XidJB0zRVa4=;
	b=ikc01+YwkeOjP5cK4KAg7kIoSfmaM/gDbSvjS1fyX9g7tvuFqqvq/YRInE2SmYquyKuV4D
	aHYXced9O69IJ7RGfVG5LE7kLChiFHEqnyrGiFwspHb5MLam260d4LDSYXFyhX2+5Sy8BS
	5hXUItxzlNghQKEUiaIz3NO+Xfi6ZEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793193630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP4c7kBh4vXoea1Jno5pzeNfYitw/HO5XidJB0zRVa4=;
	b=H67vUejcCsq2/G2lrDpyvijucebSJxY4S+sD6pv2UhwuYbNF8k8aRG0jrgVpf3dy0w6evT
	+N2yNvzlHwnULBDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ikc01+Yw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H67vUejc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793193630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP4c7kBh4vXoea1Jno5pzeNfYitw/HO5XidJB0zRVa4=;
	b=ikc01+YwkeOjP5cK4KAg7kIoSfmaM/gDbSvjS1fyX9g7tvuFqqvq/YRInE2SmYquyKuV4D
	aHYXced9O69IJ7RGfVG5LE7kLChiFHEqnyrGiFwspHb5MLam260d4LDSYXFyhX2+5Sy8BS
	5hXUItxzlNghQKEUiaIz3NO+Xfi6ZEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793193630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP4c7kBh4vXoea1Jno5pzeNfYitw/HO5XidJB0zRVa4=;
	b=H67vUejcCsq2/G2lrDpyvijucebSJxY4S+sD6pv2UhwuYbNF8k8aRG0jrgVpf3dy0w6evT
	+N2yNvzlHwnULBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5339213419;
	Wed, 28 Oct 2026 13:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UXF+CJr24Wr9MAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 13:20:26 +0000
Date: Wed, 28 Oct 2026 13:20:24 +0000
From: Pedro Falcato <pfalcato@suse.de>
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
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 31/46] mm/mremap: fix moving PUD leaves
Message-ID: <auH0bgdchd6DyCbU@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-31-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-31-6f74bec9a5bb@kernel.org>
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org,toxicpanda.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_GT_50(0.00)[65];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,toxicpanda.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 5D1A51F7AF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_062033_010324_B79BC38A 
X-CRM114-Status: GOOD (  24.79  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:51AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> pud_none_or_clear_bad() only really works on page tables. PUD leaves
> confuse the check and make us clear the page table entry and print a
> warning.
> 
> Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
> when mapping"), this also leaks device-DAX folio references, mapcounts
> and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
> 
> Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
> whole or the move fails, split it. This unmaps it with proper accounting
> instead of treating the leaf entry as a PMD table.
> 
> Keep using pud_trans_huge() for now, in the future this code should be
> cleaned up to just check for PUD leaves.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: fallthrough after splitting ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  mm/mremap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 91f0865f6aeea..1237718848f5c 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
>  		return NULL;
>  
>  	pud = pud_offset(p4d, addr);
> -	if (pud_none_or_clear_bad(pud))
> +	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
>  		return NULL;
>  
>  	return pud;
> @@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
>  		if (!new_pud)
>  			break;
>  		if (pud_trans_huge(*old_pud)) {
> -			if (extent == HPAGE_PUD_SIZE) {
> -				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
> -				/* We ignore and continue on error? */
> +			if (extent == HPAGE_PUD_SIZE &&
> +			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
>  				continue;
> -			}
> +			split_huge_pud(pmc->old, old_pud, pmc->old_addr);

Note that, if the HPAGE_PUD move fails, we split but miss the opportunity to
move at the PUD level (right below). Is this on purpose? Am I missing
something?

... I say, realizing I am missing something, because split_huge_pmd (and
consequently split_huge_pud) just decide to zap if the VMA isn't anonymous,
and split_huge_pud() just hardcoded it to "of course it's not anonymous, lol",
and just zaps. So there's no point in moving what isn't there.

Lord help us.

-- 
Pedro

