Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDF606A326
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gb1D4xe5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXAC+krf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L0nui5RoS2ttjlEXfgdf2FHBryPRYispg6KfdVODpUg=; b=Gb1D4xe5/hnH51KdZim9vQWOsa
	kuzU6teP36rDYd28LYdEG0UjFzEeBZXy8aSrXp/4RxhG5zdAg3qo6A0DT0C+4JGaD8D6wVEl8074f
	ZDy+elzVMfTFpYdC5rMaKjgmEm7Tm/+GqVUCfJGL1HKpg3AzHT/IYjK9NkwP6psVRaBxs73w0ZGZl
	U7ZRgDA4WgIvkQNgoY3dPRe2CXBKleAW8kLS/2Y3h+huAo2P1zqFsAkpH9qfTXtEkvZvXI3en/zOK
	HAaJQfNp5Kn0ZHQbikoQ8JgpSEiEJTbl3KeEJKaKm4SbHebQ/HiJ3Yr290H9H4R+RkUfYhEMuQCLi
	K7pFH4TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dV-00000005j8A-3AUh;
	Wed, 11 Nov 2026 06:16:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dU-00000005j6e-14A5
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC725612BF;
	Wed, 11 Nov 2026 06:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264AF1F00A08;
	Wed, 11 Nov 2026 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377803;
	bh=L0nui5RoS2ttjlEXfgdf2FHBryPRYispg6KfdVODpUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXAC+krf+Trv7+PS4HAGEVGxJ03mZokL/Vbm1gXYAWDZPzoyylYrFRTxaOK3f6HN0
	 PPAbIlzuFEsNPunbT3VxPFSSwKUKB0VLGVyKSdRAyiakqwo7dUGUAR5AKUy0GIjgf7
	 CRfz8UZCxBjI4u6CxrxFosCh5+76hzGfbdu+nKULjrnQHeoa1p7q/t3b3BXE+ovZoF
	 8JRnkoz54SUvVHYvWBDfR7tka2vIBsbUnh31yAuqH/brnu4fY2RrNPPcUrkGvRXbWC
	 p5GHqDi9kGDOFb2JMUXRI0J50cCEZvDWGZjCJtIrUqc1ECqyvaOdIBjUeSPygpW2d+
	 pQ9FsGCEamaKg==
Message-ID: <sashiko-outbox-208412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/19] liveupdate: Add feature header to struct
 luo_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-10-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-10-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:41 +0000
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

> LUO and its file handlers currently rely solely on coarse-grained
> compatibility strings (such as luo-v6 and memfd-v3) to validate
> handed-over state across kexec. Because compatibility is checked only
> at the whole-structure level, any change to a serialized structure,
> even an optional additive field, requires bumping the compatibility
> string and breaks live update between adjacent kernels.
>=20
> Precede the centralized struct luo_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Subsystems can now evolve their serialized state at
> per-feature granularity. Each subsystem groups the fields of its
> serialized structure under feature indices, starting with index 0 for the
> base fields. When a subsystem adds a new capability, it appends any new
> fields to the end of its payload structure under a new feature index.
> Retired fields are kept in place so existing field offsets never shift;
> if the type or format of a field needs to change, the existing field and
> feature are kept intact until retired and a new feature index with an
> appended field of the new type is added. Only when a change requires a
> complete break in the serialized layout or semantics that feature flags
> cannot handle, a new handler can be introduced with an incremented version
> number in its compatibility string.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D9


