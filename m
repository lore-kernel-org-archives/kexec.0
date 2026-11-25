Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFB606A321
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W0JHS6lL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQxlBums
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TGlsI6OTI1CFHMBkcP/qWZ/G4oskhIjaDCWDLF/i26w=; b=W0JHS6lLgALeAHAX9HiL1XYqiF
	uVS+8flot3Nm8/la+vLSwwexfiHhBibXqQgkL/bVK0kKeD66/t0gZhADoT3Qc51lbPYNoADu1+6sK
	uZ5QxHNhVjzgRyF+voVzCw4VkoohvjLV7pYeEKyxxwl4i2/+u8YU6RSNnVbgBkApfyXPtEwJch1aF
	4qKNoyvPX0e1Qi/yFXbLskPifp/Y/gcJUVUMsry9YsufPnHfoEV2zm6rWHZVeeKyfPtp+jY2Q5kQ6
	6ycS3n7mc7GsdExb8J75NRe0xrU6vtZEHn5ETfYXvEpKdpB/e8nGtyPp2a4WJn4jHZ0ABcIsmzW/c
	/fBt9KDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHvT-0000000B2Mt-0xC7;
	Wed, 25 Nov 2026 18:41:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHvP-0000000B2Mc-32Wz
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 18:40:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E7156620BC;
	Wed, 25 Nov 2026 18:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3CA1F000C4;
	Wed, 25 Nov 2026 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632058;
	bh=TGlsI6OTI1CFHMBkcP/qWZ/G4oskhIjaDCWDLF/i26w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQxlBumsUmxu+67BBjv8hE4X4wBL/qDaJOPp4JCZqblACdf2qSevYBxyvnLMLORaH
	 WgBMsdddC2vgCh03WOJFDRXWiizvsdOVGoQVvDgti1mj0O7dfYQQte5kTbxg1MCIPF
	 SaYN+kv8yxLl+zuYSYVwM/Q+oZbz3GHlj8SdyCe3ZV7uVkYEYHVYSqJzFExoVRDMxF
	 9jyfVu5kPiw8sp4JuhagvVhjeyuB01bT8OKKHKogQ0HLxj3L9Ug8Irpf4gQwZZGhZ4
	 0rVGiDcJXXktp62iMVudLLCM3cU+dKBSbN5pFl0S+82Onn1dFPMYnW/jtTnAzI/FNr
	 tUU1xB2RsPbrg==
Message-ID: <sashiko-outbox-234004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mm/memfd_luo: don't use memfd_pin_folios()
To: "Pratyush Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org
In-Reply-To: <20261124184042.1823277-1-pratyush@kernel.org>
References: <20261124184042.1823277-1-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:40:57 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/memfd_luo: unbatched migration and LRU drain in
  memfd_luo_migrate_folio()
--

commit 36bee618bf022031606488c041334f6b85cc82a9
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm/memfd_luo: don't use memfd_pin_folios()

This commit replaces memfd_pin_folios() with a direct page cache walk
using shmem_get_folio() and migrates folios out of movable or CMA
pageblocks individually via memfd_luo_migrate_folio().

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 6b68220275ebe..38584ecfa70be 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -77,26 +77,168 @@

[ ... ]

> +static int memfd_luo_migrate_folio(struct folio *folio)
> +{
> +	struct migration_target_control mtc =3D {
> +		.nid =3D NUMA_NO_NODE,
> +		/* Not movable, so the target is neither in ZONE_MOVABLE nor CMA. */
> +		.gfp_mask =3D GFP_USER | __GFP_NOWARN,
> +		.reason =3D MR_LONGTERM_PIN,
> +	};
> +	LIST_HEAD(source);
> +	bool isolated;
> +
> +	/* Flush per-CPU LRU batches holding the folio so isolation works. */
> +	lru_cache_drain_for_folio(folio, 1, NULL);
> +	isolated =3D isolate_folio_to_list(folio, &source);
> +	/* Isolation holds its own reference. */
> +	folio_put(folio);
> +	if (!isolated)
> +		return -EBUSY;
> +
> +	if (migrate_pages(&source, alloc_migration_target, NULL,
> +			  (unsigned long)&mtc, MIGRATE_SYNC, MR_LONGTERM_PIN,
> +			  NULL)) {
> +		putback_movable_pages(&source);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does migrating one folio at a time here regress preservation latency when
folios in the memfd already reside in ZONE_MOVABLE or MIGRATE_CMA
pageblocks?

Previously, memfd_pin_folios() called check_and_migrate_movable_folios(),
which shared a single enum lru_cache_drained state across the scan so
lru_add_drain() and lru_add_drain_all() ran at most once, and passed all
movable folios to a single migrate_pages() call so migrate_pages_batch()
could batch TLB shootdowns across up to NR_MAX_BATCHED_MIGRATION (512)
unmapped pages.

Calling memfd_luo_migrate_folio() per folio passes NULL for the drained
state to lru_cache_drain_for_folio(), which can trigger repeated local and
all-CPU LRU cache drains, and invokes migrate_pages() on a single-folio
list, forcing a cross-CPU TLB shootdown IPI for every mapped folio that
needs migration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184042.1823=
277-1-pratyush@kernel.org?part=3D1

