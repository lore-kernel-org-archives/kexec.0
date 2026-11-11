Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AB606A327
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tJoTukGv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyRy82Vv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V38D8Zzjhgp2B9wmXpv51p2+0Uz9/PgRrujbOQbcK2U=; b=tJoTukGvqe02d5MrS4zvIkX9Z1
	paT8lEgY0r+yLedWelLaFDd0RU40HrnFvsU383RKRkcmQjEbxH5YvthzX0QoajvTbW+3aa06XtLH6
	Fz+wMC3Qs5tgL1p9jfCWKhxPxHbUT5QSdAuT5iF0ezp+O7qqB/YxC99bTY0k7BD9hJ00zW/bQKgar
	WO3cJfu7oHxkeNZfa/xHb2j4nYMOtdaZncdILpM4asb0ebyJcgRAC7g2rQKvJfbUfExYa0g0Rdfnz
	6zYMOxCEzYKQTFnekSrgBTkeMa6cQ2My9B4bL4vAXR8mm3ZEM3FlmlnA5TD8GPqjjTdfGTuAG8As3
	MVM27AiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dJ-00000005ixJ-3K4i;
	Wed, 11 Nov 2026 06:16:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dH-00000005iwk-2spF
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 26C9361D3B;
	Wed, 11 Nov 2026 06:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0A1F00A07;
	Wed, 11 Nov 2026 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377790;
	bh=V38D8Zzjhgp2B9wmXpv51p2+0Uz9/PgRrujbOQbcK2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyRy82VvGymEHSlX2UujKZtj3TAKx4SdCgF0wU7SLG+5++Y0Gwd63UMAm7W1BfNZ+
	 w4AhvZAZOHkwws9Bzc2uLY22yQAGyc+t0mIjiw1DSJiJ5mc4yaOS3spFWnBrFIYCg7
	 3fphGrqq+kSm5+cmODm9pHjIzIoRHM1K6jGBsXEf/qTio16yEnwsb2iKvLPzQ6M1XE
	 C3Yp2Ey6QZDuigxpfmAeelDE/dVoKQtkn529xEVjmSqrQPmMOurl0/gU8cnsyw0IPP
	 AkYlrh3MgW6s8xM8tNKNZQHbx15XAEdMbj8C0q6lWz2ts1n/K6bOGRc9vQe4yGZVUO
	 8rLKSAutAHHIg==
Message-ID: <sashiko-outbox-208405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:29 +0000
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

> Subsystems using the KHO Serialization Blocks framework currently do
> not record the serialized entry size in the block header. The entry size
> is only known to individual callers, which must track and store it in an
> owning serialized data structure. If a newer source kernel adds fields
> to an entry, the changed entry size breaks the stride when an older
> target kernel iterates over blocks.
>=20
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,
> or one that differs between blocks of a set, is rejected during
> restoration.
>=20
> This change modifies the serialized layout of struct kho_block_header_ser
> and shifts the offset of serialized entries within preserved blocks.
> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> kernels cleanly reject mismatched handover state during boot. Also
> update the stale compatible string example in the documentation.
>=20
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D2


