Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083F606A32F
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GWBbt99w;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mSGioadF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CFUQc+7b;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mSGioadF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CFUQc+7b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4//c1y7R5iOay/1qB05dRfh80LMu6MjdD1lnRgqu534=; b=GWBbt99w82y6AutKD5RI86olN+
	28FoJbLEjqW2FqA4pPH2dSxLtVPpucXoH7uvZ+LLdcxPdIbwS5N/5vSz4oAVXvIb57At68OBRnnMt
	5bHEswpRUHdIVf+z6HKjtIti58BCZXtkYw8GwhTmlKc7Qd9m8RXEXJe42SBKp66FjaEFaVuiLV0We
	EDKn+x37ggq+i2p4w4quK7KNQjaW5mPSbvSEBaaKNqBkbebnSX93PesTrzlAlMfnY2XeQcc1P2M0l
	n0mEgDsK/gohqEUs47DfVi9PMBWo8yHvUMHkyv0KzeEXMYGrFqCzvTxT+akfT74iq5ZpVbleJpmfO
	lexfaJEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWzz9-0000000HJgf-2oVi;
	Fri, 27 Nov 2026 17:43:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWzz6-0000000HJfp-17Ly
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 17:43:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F22D01F7F2;
	Fri, 27 Nov 2026 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795801421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4//c1y7R5iOay/1qB05dRfh80LMu6MjdD1lnRgqu534=;
	b=mSGioadFgU4HHFtRiF7iKYor+d4NLBHh6LqlX5JJCk+ry6KRDZAw+V+GNj2B7aKWTJ//KG
	6o28tanc1pGxfauhC1xZ14SQcWAcf45nG9SRJCP2G4Evog/tc0WKSksKX+7/BoBJ1mj87o
	nYK4MhBvR78SIoeEOF3PUYlHJufmlCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795801421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4//c1y7R5iOay/1qB05dRfh80LMu6MjdD1lnRgqu534=;
	b=CFUQc+7bZAUwCAsOWXF0HebaP0jlbgM+a6julN35p2Pd+Zj3B9I26kWH6mAD5WNM86adCS
	42QW15I9Oha5ZUDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795801421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4//c1y7R5iOay/1qB05dRfh80LMu6MjdD1lnRgqu534=;
	b=mSGioadFgU4HHFtRiF7iKYor+d4NLBHh6LqlX5JJCk+ry6KRDZAw+V+GNj2B7aKWTJ//KG
	6o28tanc1pGxfauhC1xZ14SQcWAcf45nG9SRJCP2G4Evog/tc0WKSksKX+7/BoBJ1mj87o
	nYK4MhBvR78SIoeEOF3PUYlHJufmlCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795801421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4//c1y7R5iOay/1qB05dRfh80LMu6MjdD1lnRgqu534=;
	b=CFUQc+7bZAUwCAsOWXF0HebaP0jlbgM+a6julN35p2Pd+Zj3B9I26kWH6mAD5WNM86adCS
	42QW15I9Oha5ZUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8338134E8;
	Fri, 27 Nov 2026 17:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 13myKEzBCWsfHAAAD6G6ig
	(envelope-from <jbohac@suse.cz>); Fri, 27 Nov 2026 17:43:40 +0000
Date: Fri, 27 Nov 2026 18:43:40 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Usama Arif <usama.arif@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Frank van der Linden <fvdl@google.com>,
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] mm/cma: reject long-term pins of HugeTLB folios
 overlapping crashkernel CMA
Message-ID: <awnBTG3budAQqfSq@dwarf.suse.cz>
References: <20261125155108.24098-1-ekffu200098@gmail.com>
 <f79014e3-3c81-4b2b-87f6-df0c2d946357@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79014e3-3c81-4b2b-87f6-df0c2d946357@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,infradead.org,vger.kernel.org,kvack.org,suse.com,kernel.org,bytedance.com,linux.dev,suse.de,google.com,soleen.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_094344_603355_57B8958B 
X-CRM114-Status: GOOD (  16.21  )
X-Spam-Score: -4.4 (----)
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

On Wed, Nov 25, 2026 at 11:43:40PM +0100, David Hildenbrand (Arm) wrote:
> On 11/25/26 16:51, Sang-Heon Jeon wrote:
> > crashkernel=size,cma uses existing hugetlb_cma memory, so
> > crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocated
> > from hugetlb_cma can be long-term pinned without being migrated.
> > 
> > After a crash, the crash kernel uses the memory in crashk_cma_ranges[],
> > but a device can still write to a long-term pinned folio.
> > 
> > So reject long-term pins of HugeTLB folios overlapping
> > crashk_cma_ranges[].
> > 
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > The above scenario is only possible with the two patches below applied.
> > Currently only linux-next, which is targeting v7.5, has both of them.
> > 
> >   "mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory" (kexec-next)
> 
> I think that's a real problem with this thing.
> 
> The solution is not to disallow long-term pinning. :/

This patch does not disallow or break the long-term pinning. It just makes
sure the pages are migrated away from the CMA before get_user_pages pins them.

As has always been the case prior to 
  "mm: gup: allow long-term pins of CMA-allocated HugeTLB folios"
(in mm-unstable), which introduces an exception for hugetlb CMA
and allows the pinning without migration.

And this exception breaks the assumption that CMA does not
contain long-term pinned pages. The short delay prior to kexec
when CMA is used for crashkernel is there to wait for pending DMA
into short-term pinned pages, not long-term pinned ones.

Including 
  "mm: gup: allow long-term pins of CMA-allocated HugeTLB folios"
without this followup breaks this assumption, which we discussed
during the merge of the crashkernel CMA patchset.


-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


