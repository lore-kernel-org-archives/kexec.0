Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AF606A32C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3/p4EEjI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3K3MhGu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=exR4MwSWCJr6j3nDZscguxLY8qOox/tiNrn8/Duc6h4=; b=3/p4EEjIRzoV2ijDvgM17i3ZL3
	h/Le9CnJ90B1ltcMgXN+tsaGybtaY/yDYtnYjWH/pYRzDHUQ8Bj+UW8a6w0riGhLyaY4vBtTJEql5
	Az13xkUc+q8E0lKCnEyH8fCIud+s3DEGrOV+mVMYfnWNAxV2b1QPct4kH85QsC3rHjiDPL7cHX5hD
	WNTPlWaT0nIyi/FQqq22ZiuKFKwr5AekexKl8dSR5zEjZLsi2otVQxmrrChbvFKP02LQOQyvuEqPz
	tBP01/3k8eQJOrM7WeUSpbgmg3UtxZcAhjfnyUtX0cPigIKWDNuzTFLdTEa2i1SMpte38tUk8cudd
	CaXBR5qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIX-0000000AKfN-1g2f;
	Wed, 18 Nov 2026 21:34:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIV-0000000AKeu-3hvK
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:34:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98E08408B2;
	Wed, 18 Nov 2026 21:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F028E1F000C6;
	Wed, 18 Nov 2026 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037671;
	bh=exR4MwSWCJr6j3nDZscguxLY8qOox/tiNrn8/Duc6h4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=W3K3MhGuS8dH5N8bhT4I8v5qFCFcMIxMeRc4m8d2bxrX0PToF2tHRTisC3HAMUsGH
	 gPSLqH/EI5heLTz/z3579urhHqaHCYVjlZ6fyRoLVQPF//O9oHBNPJUKWFXYvqKf/G
	 VIG7W4FyE+F7vijb5mBpwXoU6ZYilVLArWXEPx8jM58UKt6kLPyxgw5EQcEYJRpWtx
	 +faW4BCFHwGxfiWNRF9G9wKBB0HiBnNI3fV2J/NFGaBOqN5XadEWPV9UP3G13P/QW3
	 9xg6mAX1HbxOvyJRr4IPnj8d267WKyl6ZiBVTtyfq6ok1ZtfK+eeT6yw3aFB07Q/+d
	 /VTx2ioeXJFyQ==
Message-ID: <sashiko-outbox-222007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] liveupdate: luo_flb: serialize outgoing FLBs
 incrementally
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-5-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:34:30 +0000
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

> Currently, outgoing FLB metadata is written in a single pass by
> luo_flb_serialize() during liveupdate_reboot(). When sessions are
> serialized ahead of reboot, any FLBs their files depend on must also
> be serialized at that time so the outgoing KHO state stays consistent.
>=20
> Serialize each file's FLB dependencies from luo_session_serialize_one(),
> appending new FLB entries or incrementing the serialized file count in
> place. Since every serialized session now updates its FLBs as it is
> serialized, drop the separate luo_flb_serialize() pass from
> liveupdate_reboot().
>=20
> Because serialized sessions never unpreserve their files, FLB
> serialization is one-way: once an FLB is serialized, its .unpreserve()
> callback will not run and its root handle from .preserve() remains
> fixed for the rest of the boot.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D4


