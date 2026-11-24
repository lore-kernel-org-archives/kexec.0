Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C1606A321
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g7RlbivX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZVfiyHU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yrVF/aYtE984rnLlm5LPsstF/ABph3KbrqJASdwOlW8=; b=g7RlbivXVATT3Bs3+Ei1mzbZBE
	oAoEDRP3K61u8xydmtV/YCqiFtrZBOxPx5u/bjRMp6KnjO0hIdyuVg3Q7Qca1BKxtysdnoIe+rKyB
	hvzlQU6JVAanER/jPFPgp1IIFlnhT8U7fCTd2tTLHp6KdKLDysTxZ6AwXtlksKofzT3EcXbvbdivy
	gCrchO8UyifHahkkMK4kyB2Stc8mQ5E2dSCAfPGVac9XPhmsBBVGQRGZlW2LBcvvcD+FcPkw6X84A
	xIqVxVzPKdDE68nI6AUCicipomUhtoIwStO6MzCwLcn8aw4DYiI49s20U7IgktdnAfzDyQQg5aSPk
	PRg9mLPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVq9h-00000006ZD5-2FAy;
	Tue, 24 Nov 2026 13:01:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVq9f-00000006ZCf-24O0
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 13:01:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B10FA6264E;
	Tue, 24 Nov 2026 13:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B421F000C0;
	Tue, 24 Nov 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525310;
	bh=yrVF/aYtE984rnLlm5LPsstF/ABph3KbrqJASdwOlW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZVfiyHUfkEnnKG74BWeCUUeEu/TkNSRVX9xZcB0JUmbgNk3fbu7sfKy/58ffkr8v
	 7KM1gVu5PLXaGoSMcQLgzYVQ/Biv1kuoDjegDQtIzqr9UfI4dzI1IJfaI/Zp0Qf/rX
	 d7Suht0hKQgR3VnN5p+/Ewxw1lENjBXXbTYha/NivTyMFSKrXwCSrDeDKzIivk3Yl8
	 JCaFYcwMMwbjT1EYYnF3CwqKq3DbgnMB4oAi0KnOoT5fRJ2QLZIRlc1+QhI77Xtktb
	 PwJXF4O985uzpPykyMCYJ1zZTOEB+JFHORxL4c786ZA0PCAHML9WbcIuv6kN/4qFYE
	 CdHf5nF6CTjDQ==
Message-ID: <sashiko-outbox-231187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/memfd_luo: don't use memfd_pin_folios()
To: "Pratyush Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org
In-Reply-To: <20261123130115.4021199-1-pratyush@kernel.org>
References: <20261123130115.4021199-1-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:01:49 +0000
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
- [Medium] mm/memfd_luo: memfd_luo_get_folio() returns -EBUSY after last
  migration
--

commit 41c3599dbcd67e367dde6fcd9824d0c532431810
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm/memfd_luo: don't use memfd_pin_folios()

This commit replaces memfd_pin_folios() in memfd_luo with a direct page
cache walk using shmem_get_folio() and migrates folios that are not
longterm pinnable via memfd_luo_migrate_folio().

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 6b68220275ebe..c963bc3522e61 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -77,26 +77,161 @@

[ ... ]

> +/* How many times to try migrating a folio that is not longterm pinnable=
. */
> +#define MEMFD_LUO_MIGRATE_RETRIES	3

[ ... ]

> +static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
> +			       struct folio **foliop)
> +{
> +	struct folio *folio;
> +	int err, retry;
> +
> +	for (retry =3D 0; retry < MEMFD_LUO_MIGRATE_RETRIES; retry++) {
> +		err =3D shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
> +		if (err)
> +			return err;
> +
> +		if (likely(folio_is_longterm_pinnable(folio))) {
> +			*foliop =3D folio;
> +			return 0;
> +		}
> +
> +		folio_unlock(folio);
> +		err =3D memfd_luo_migrate_folio(folio);
> +		/* Someone else might have it isolated, retry a bit. */
> +		if (err && err !=3D -EBUSY)
> +			return err;
> +	}
> +
> +	return -EBUSY;
> +}

[Severity: Medium]
Does memfd_luo_get_folio() return -EBUSY even when
memfd_luo_migrate_folio() succeeds on the final iteration?

Because memfd_luo_migrate_folio() drops the reference to the old folio,
memfd_luo_get_folio() relies on the next iteration of the loop to call
shmem_get_folio() and look up the migrated folio.  If isolation fails with
-EBUSY on the first two attempts and migration succeeds on the third
(retry =3D=3D MEMFD_LUO_MIGRATE_RETRIES - 1), the loop terminates before
re-fetching the migrated folio and fails preservation with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123130115.4021=
199-1-pratyush@kernel.org?part=3D1

