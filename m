Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71639606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aGL0DbGd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUtTAD6Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IWCtaOnVvPzXp0wppDZYwWsDRynq4pP6trEYtOMYIPA=; b=aGL0DbGdgT9j7tCCrqItooREuZ
	KLfUqr2DDw8ZCN6HC0XpBpmuemuhYFAQusSoYBNJvvTF7Z3ew9MTNs1LSM/m3gxGjyAbvACe/NMvg
	pwDaiPGrzZaj6+nI74IeIPBkFabJqmhnmu+5l1x2+9JNeHo7RSKNnzeuFF0D89Z4CO1fzntu9RWRH
	Q675Eyb40Lie2dHlekT2P/jAmfWu4oxnH23XsNQjUgYBfDlThrUS4ZVJUOqB47IZfU/XeQGztTwXb
	J8Bh+5QSVzKsTQWmNHX4HIlAzDI7PFWOqLSJXoW4K5Q2hdwwqI246jEp93cc4FM+2bvi8AtkK/W+J
	QaZUU6WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtQ-000000031au-0fK6;
	Mon, 26 Oct 2026 17:53:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtP-000000031aP-0aEE
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:53:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9246060A6B;
	Mon, 26 Oct 2026 17:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4291B1F01825;
	Mon, 26 Oct 2026 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037234;
	bh=IWCtaOnVvPzXp0wppDZYwWsDRynq4pP6trEYtOMYIPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UUtTAD6YWjcnQMMWgPOoQlJF6dYZognm7qepdMXOSlMupr3AzgY9Hx0ghghZRH7nW
	 YaCa/bDer9orwLj6rxvDD7fuZryH9g0NyotK9OdyRJAwVJMatCbdk+XCcuHghS3Pji
	 yjZmFJdwDGzc5uSg0Q3l0SLuYzN1yUMaqlSD+/zCYeWsiEmCcV2CZr/hozTGqqAeIW
	 FOgpT1SV+Xb5XoJ9dsPh8PI8Kyo7oVZJWyMcOIwzqDY3qk2Tr2v0s8utbePT/uj1kK
	 ewg7mCVNK+/4NXJ53qWxDpFAWGsgfmhKgb3PQLWPvh4hwSjB1b6Oca4Mw7TA7Hk321
	 aalJmhn5YtUPw==
Message-ID: <sashiko-outbox-185599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/4] liveupdate: Add feature header for
 fine-grained ABI compatibility
To: "Tarun Sahu" <tarunsahu@google.com>, loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, seanjc@google.com, "Mike
 Rapoport" <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, jgg@nvidia.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, arnd@arndb.de, "Andrew Morton" <akpm@linux-foundation.org>, oupton@kernel.org, baolu.lu@linux.intel.com, "David
 Matlack" <dmatlack@google.com>, robin.murphy@arm.com, maz@kernel.org, "Alexander
 Graf" <graf@amazon.com>, joro@8bytes.org, "Bjorn Helgaas" <bhelgaas@google.com>, kevin.tian@intel.com, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261026174217.603114-3-tarunsahu@google.com>
References: <20261026174217.603114-1-tarunsahu@google.com>
 <20261026174217.603114-3-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:53:52 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> LUO and its file handlers currently rely solely on coarse-grained
> compatibility strings (such as luo-v5 and memfd-v2) to validate
> handed-over state across kexec. Because compatibility is checked only
> at the whole-structure level, any change to a serialized structure,
> even an optional additive field, requires bumping the compatibility
> string and breaks live update between adjacent kernels.
>=20
> Introduce a feature header (struct luo_ser_hdr) ahead of serialized LUO
> structures so subsystems can evolve their serialized state at
> per-feature granularity. Each subsystem groups the fields of its
> serialized structure under feature indices, starting with index 0 for the
> base fields. When a subsystem adds a new capability, it appends any new
> fields to the end of its payload structure under a new feature index.
> Retired fields are kept in place so existing field offsets never shift;
> if the type or format of a field needs to change, the existing field and
> [ ... ]
> Also, introduce the LUO_CORE_FEAT_CORE for LUO for the existing mechanism
> which is also a required feature.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174217.6031=
14-1-tarunsahu@google.com?part=3D2


