Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41161606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v/w8HC9h;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onDgyYuJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fkFNkK9waQrr04LqwebhOzpt6VfUKvnie5m0HgQWrUo=; b=v/w8HC9hHVDNP6bBTepEo9qKcn
	EK6FxyJ9Z86+5ENWSh2eyYD4+rnRDiMcrsjXeLsNrUmNBH17uB4EYk7Z4bIx6B0PwROF59k1n50Cd
	U/CO2K7QgGW6Nm4PUyaO+fjVHOYUWwZxcPNW1GtgL57NF36TYYqiCxBL/YHp4GAgpgUW8LhJWSAt9
	dsdxfLlGG4Mlc2kC42ZWcIIpHZjqGdLCzBGiP2x0KnSym5ClQ0jP24wuKLzl4gCQR745HjdEKjFCh
	Mb3RComlAaydmhwmmleK0S6a6Z6qGa4UuJTyqSFHt8PrpR4LNBBYbl0biRwHf5UH5rACqZlTHDKL/
	OE5y/WCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT3Q-00000009k2s-44O7;
	Thu, 12 Nov 2026 11:33:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT3O-00000009k2P-2tFt
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:33:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25E8161918;
	Thu, 12 Nov 2026 11:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8511F00A05;
	Thu, 12 Nov 2026 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483197;
	bh=fkFNkK9waQrr04LqwebhOzpt6VfUKvnie5m0HgQWrUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onDgyYuJKgV44zugwU9gGwPzSAFyEAxTs/scsFiB0tU8kRJbXb2A3jG8IdykKNp2a
	 6zPxM0dPoTwCGGvxOZ6L/z3kL0BzkcEyREoh7k3n+otLvhLnxWcy6EDRvxrYzKOnei
	 pbfH2+bz6mqvNyuTwv+igEJfT1jrvHfD5cyQWfg/qIhCrgVTz11baOAxOQ/ZCsKFlI
	 v2CQGk+TuMgbV7PIVpo402NA6MWbw1y3+vG3NorVAg/o7Jz34JKpBJLofuMbBxMhbS
	 0jT1Es9hS8e2HE1WKQM/cfcJBAJtXrHgc4bBX0hlzElDzSAEuV3P1UHNzc+r7BUIlu
	 W5xAOXdZJoAJw==
Message-ID: <sashiko-outbox-211025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] s390/boot: Allow additional usable memory ranges
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-5-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-5-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:33:16 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> All online memory above the usable limit is left unused. A kdump kernel
> will need a few ranges above that limit for the crashkernel CMA memory
> of the crashed kernel.
>=20
> Add physmem_add_usable_range() to register usable memory ranges. Clip
> them to ident_map_size and merge overlapping or adjacent ranges.
> for_each_physmem_usable_range() walks their intersection with the
> online memory ranges.
>=20
> Use the same ranges for boot allocations, identity mappings, KASAN
> shadow and memblock. Keep the allocation position separate from the
> usable ranges.
>=20
> When no extra ranges are added, nothing changes.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D4


