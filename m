Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9A606A31D
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FXTGxYGk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O56pynoB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XE9yWNlXsvGeGCWhIwmUN0zA/ByHkLoM4gSXGnB7k80=; b=FXTGxYGkR0/0qXJZq4+4m7oFvX
	flQeUukT5BUGSLUQ7qB6BttaSl660h//5V1d46veM/y1CjMXCB3vLaF2IU9MovVy/DlkbrJaUAMVF
	aeTBScM/U0htfJfJzONOxuVLAL1qNgt8KniGNUNIAAd3cm+YTzGaJpLbnlb9N6mSIYORjvuPf+wAf
	qWASyAlCV0k2Xv2vNcaYil4R3pxUbb0Hc97hz3Ok0l7EAQK0AStcADwtI72O9JnyDarRZbTfwlO0R
	TEFFmqQQSmOFLSqIbKBl9mTRUoDEqXw/SydDZmlMQyOKj+3Je5RFvdnB1ibFNuZusk7Cw20+iOeUw
	Zk2P2oDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugX-0000000EPEl-0SXk;
	Thu, 22 Oct 2026 15:26:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugP-0000000EPDN-3V4L
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 15:26:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 47FA260EED;
	Thu, 22 Oct 2026 15:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9442C1F01825;
	Thu, 22 Oct 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682781;
	bh=XE9yWNlXsvGeGCWhIwmUN0zA/ByHkLoM4gSXGnB7k80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O56pynoBI5KpalG2BPlOv25DBE/DEB5Jo16dwWZI1bKpSwVasiwoaBO1B+nBR3eOF
	 YrEtrKJrO9UkWi/jNc1BfYPdxje2j0uU60E6Pg+WdQaOrmL8g4EeCnA0KLeLbCb7i7
	 er3SvneVxCrxpHGAWPs5GmcYSwXSO7wtrEmLhMyWBHTUVOkYHN0NDjN9GUc9uO6oMY
	 cOzfWrc24kvsxvGG/LnXoNum4o0AxvpJVhyL5kv/WqiNeQ4T0zB4p8n5WLNGwhy2H9
	 0cVGOxksMK6cJDnWKS8W86VS2dru3kyz6Q+X1EdtUk/iRdG1ew7Tj9iyvnWzBcp+PF
	 84J3rrpwuU/ng==
Message-ID: <sashiko-outbox-181697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string
 with a 2-bit pair feature header
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:19 +0000
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

> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
>=20
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
>=20
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (465
> [ ... ]
> Future changes add new entries to enum luo_core_feature before
> LUO_CORE_FEAT_MAX.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D3


