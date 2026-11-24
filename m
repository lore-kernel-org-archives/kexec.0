Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AE606A331
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=raBWsMta;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6LU+EVk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DQc8iAXrOWCo5dkpL4sta6QbqPzTZAceFHRxm6U10hQ=; b=raBWsMta1qIOFXcGXxblhjtlf3
	I6CpdLEU1K4r76zHNEhEYbcnAJ2zaZHMLLErEhRK4djBq3esU8td7wMHLO/ETo80hDris2jaCoTF9
	5lq1OTNpMY8sKdswFEwgR6XZlDX0CYiMG6FAvmHdaJ+mFIk01jyi27WvE4wxLsb2RqPPd1Oc//3oc
	MoCnFbIZOwFHeHTJt7n1tDlFlEZMLEkhXap7e8B85ZvTdMEjV4u56wyn2T4OmvnI8GTKOuVbky3lc
	ZE4IS+65uagIQ8wVskvSJqOhrLY4SLRVUEDtR4m30MC9UkeqnpxvEw30o2jF9t8orWl1Ta11tedDC
	TV2WQLTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVtpE-00000007En5-0gd2;
	Tue, 24 Nov 2026 16:57:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVtp8-00000007El1-2pOy
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 16:56:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECA0C627BC;
	Tue, 24 Nov 2026 16:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1931F000CA;
	Tue, 24 Nov 2026 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539413;
	bh=DQc8iAXrOWCo5dkpL4sta6QbqPzTZAceFHRxm6U10hQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U6LU+EVkaQDm+64Z4ftbA66Y+KAU40+11CYgmER/NhuyjebuKqOtatstiSlFMbxvk
	 ru9xT3H0k1Gu+cMFsfPhFm+ActlHtUasCBeW+7Z7eL3bFiXpDJtFhPvHm5tQWfdsKy
	 FzaIyfukq7U7dBfP6JKM4YAIC6fBR/AcxaK+2iH4XYRR9bDch5ELsgeW5p3ZLCRVsd
	 +hGbnGmsGcJ05hItJZlSsz1pmQVi8rhf/7GXUY1ewWbnIL5sgo5MxoOa8YsIlBAvKv
	 Zmcj43Pn0m9Kd9zXIux0waf1D9EUhwqlW9KkBfbT9/ZWFAYd6e2NBd2rxuTgBJzZQ0
	 OnNU6BGRJGZFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <awWx1YnA0PcB2RaB@kernel.org> (Mike Rapoport's message of "Tue,
	24 Nov 2026 17:48:37 +0200")
References: <20261123130115.4021199-1-pratyush@kernel.org>
	<179546369651.425130.14155931836758567682.b4-review@b4>
	<2vxzo6bez3hs.fsf@kernel.org> <awWx1YnA0PcB2RaB@kernel.org>
Date: Tue, 24 Nov 2026 16:56:50 +0000
Message-ID: <2vxztsl6xj59.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24 2026, Mike Rapoport wrote:

> On Tue, Nov 24, 2026 at 02:51:59PM +0000, Pratyush Yadav wrote:
>> On Mon, Nov 23 2026, Mike Rapoport wrote:
[...]
> v2 was better I think, but it still had that
>
> 		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
> 			continue;
> 		if (err)
> 			return err;
>
> which I don't really like.
>
> I came up with a variant below that IMHO makes things more explicit:
>
> static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
> 			       struct folio **foliop)
> {
> 	int err, retries = 0;
> 	struct folio *folio;
>
> 	for (;;) {
> 		if (retries > MEMFD_LUO_MIGRATE_RETRIES)
> 			return -EBUSY;
>
> 		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
> 		if (err)
> 			return err;
>
> 		if (likely(folio_is_longterm_pinnable(folio)))
> 			break;
>
> 		folio_unlock(folio);
> 		err = memfd_luo_migrate_folio(folio);
> 		if (err) {
> 			if (err != -EBUSY)
> 				return err;
> 			retries++;
> 		}
> 	}

This has a super theoretical corner case where the migration can
succeed, then the folio can migrate back to CMA by the time we do
shmem_get_folio(). So we can loop infinitely.

I think the if (retries > MEMFD_LUO_MIGRATE_RETRIES) should be after the
folio_is_longterm_pinnable() check and retries should increment after
every migration, not only failed ones.

Apart from that, your variant looks nicer.

Does that sound good?

>
> 	*foliop = folio;
> 	return 0;
> }
>
> It does an iteration more than v2 with the same MEMFD_LUO_MIGRATE_RETRIES,
> but that's not really important.
>
> Your call really, I can live with either of them.

-- 
Regards,
Pratyush Yadav

