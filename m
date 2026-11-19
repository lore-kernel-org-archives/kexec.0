Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F6606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hAImBo28;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAUY3P6e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0J3pFxqa/P8DU1R/PxxMp0iDOj4BXpjd2BgQXRxkNsA=; b=hAImBo28Vn/2NJZqmF0hQgl1TN
	zWhEjB7AwKkhf6SCTf7mG5SpCOrUEm1dfgJpJbmY7JKQ/GfFqa3NmbWZ7qCDiqsvbQIdyCG4jtvaZ
	73Nk4AR3oH7oPxZYIhqV+/kbzWO6FT0UuscgVS11cwg1gOGrHV8WAFNwkrEA8ZaBbo8rVwxByjslK
	kNOZW2HDJW61Sd+Iq9mFwMPfEhCm2CHYFptIpGZxl32BW50NsieKR5cEPeAwBpDFtGQy3j7bvSntR
	sliKSHUrQsF8RClRsuGnu1ga7sUoyZnc1gF9+XDK8SVrwvhldVyvMy2aLzg+SfZfxy0e2fr6xuG2u
	N5uG69HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyjR-0000000BRKj-2vHQ;
	Thu, 19 Nov 2026 09:47:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyjQ-0000000BRK1-06SM
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 09:47:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7851B48B89;
	Thu, 19 Nov 2026 09:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4D61F000C4;
	Thu, 19 Nov 2026 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795081623;
	bh=0J3pFxqa/P8DU1R/PxxMp0iDOj4BXpjd2BgQXRxkNsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAUY3P6ezu6XrLVRZWp6/o0ujywyiSzu3De0OK9mXxuXp6twD6wjYSdX6Tz7RebT0
	 fPZYvQH/hJqVNWw6TQTLAxvFR3et1tkL/UGd7T+2S4jww7GbYXa1ZrS0OS3y1E/jRS
	 Avx304Klf3RTPnj+yN8IMm6VJM2/J7G86vnpAkA7XTMsrC2Y1Fo1P4+6SmHvR5RivQ
	 8FKn6gwpvsN6P/WyyLbFfhB8cbo3ZGBq+RjisMaj+aTxr7PrWIFQ/9ZHNnKuTLBMhc
	 SsoMTk7NOlAy/CBbbIxRTdMm/kaqgJPvSvj2pGZjncaZadPAFNHz5tCDpQA5mMSZK/
	 XrREnpAH0Xg/A==
Message-ID: <sashiko-outbox-222864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] crash: Fix crash memory reserve dead loop when low and
 high limits match
To: "Federico Parola" <fparola@amazon.de>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Zhen Lei" <thunder.leizhen@huawei.com>, kexec@lists.infradead.org
Cc: nh-open-source@amazon.com
In-Reply-To: <20261119093730.49471-1-fparola@amazon.de>
References: <20261119093730.49471-1-fparola@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:47:01 +0000
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

> On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
> arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
> CRASH_ADDR_HIGH_MAX. If the first crashkernel=3Dsize[KMG] attempt fails,
> reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
> CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
> search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
> forever. Boot stalls after the "Initmem setup" messages.
>=20
> The first attempt can fail on a kexec handover (KHO) boot, where early
> allocations are confined to the KHO scratch areas.
>=20
> Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
> loop") fixed the same loop for crashkernel=3Dsize[KMG],high. Skip the
> fallback to high memory when there is none, so the reservation fails
> with "cannot allocate crashkernel" and boot continues.
>=20
> Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
> CC: stable@vger.kernel.org
> Signed-off-by: Federico Parola <fparola@amazon.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119093730.4947=
1-1-fparola@amazon.de?part=3D1


