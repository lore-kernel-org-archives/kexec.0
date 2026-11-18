Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506B606A32A
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Clt1Mft;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xykwd6eL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uAYwrg4goGgVVl9mYgxkOuffSEn8e+jCWVrM2u2OsaM=; b=2Clt1MftK3v2Mc1CEMIZ0CfpN1
	skCoDRDc9XRA3bVM5FxWqHW6hBDZKLpAlzkgyxASDxKm2y5L1bmaMN2jDWZCvqAZyuo4/9EeUhCPz
	NDB+L8+Heno7QrIDIpvi91dKakA9XesvwVKD0jNGOoAKj9hOPNVG+MGmbx2IE3bJbQVIMSgjyeupG
	r1UIM2Ni7tqlNEHFF+CqHnnbOjjIuXdgBo6Gx26KDwefjHmypsRXIsn3/bixMfi4dQGq7MBhPhLcz
	WjdvntVVh7LWJ32kntG7+iYAhcK6+N6LVftT5dwKpAiWQum7UDtAxtTtnBEhgnbaAyAjrLa1EslNF
	U8CfEpcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnGk-0000000AKMq-402b;
	Wed, 18 Nov 2026 21:32:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnGk-0000000AKMb-1kLN
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:32:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E817645A2C;
	Wed, 18 Nov 2026 21:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3056B1F000C4;
	Wed, 18 Nov 2026 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037561;
	bh=uAYwrg4goGgVVl9mYgxkOuffSEn8e+jCWVrM2u2OsaM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xykwd6eLcfuIQ0bpvSoZ1No4+kb1mm5MRPvOUjilq7byjmdv096lIiqC/t+1DD0pN
	 Hd2NR3B6Nd+0AC3L3Fp9IBKqpE1QYdtP3u4eP7fSKApvNNj1aexwdM1Y3WIpataF/e
	 hivx3xdF9QqyEEH8van1qsgA+YeuNSpW2SM/q/wlYI6o4mXU2iQ8AbWLroUW7W0zCV
	 PY6Mvh6OlsnpQzN6kzLU3nI12OphzTDXSfiq/x3FN6GAXnQ6Ir2NN4wObnZ3bYJWKA
	 y0w7A/+yTOohw7ABvqr3LHNRdKVxmId4RqRyhLlQwm/N888NQM0hkLiTJbUd+yhU5l
	 7G7MNoAfbZQxA==
Message-ID: <sashiko-outbox-222003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] liveupdate: Move file_set_ser handling to
 luo_session_serialize()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-2-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:32:40 +0000
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

> In preparation for allowing userspace to freeze a session explicitly
> before kexec reboot, luo_file_freeze() and luo_file_unfreeze() need to
> be called on session->file_set before any struct luo_session_ser entry
> is reserved in luo_session_serialize().
>=20
> Currently, struct luo_session_ser is populated and cleared across two
> layers: luo_session_serialize() writes and clears ser->name, while
> luo_file_freeze() and luo_file_unfreeze() write and clear
> ser->file_set_ser.
>=20
> Drop the struct luo_file_set_ser pointer parameter from
> luo_file_freeze() and luo_file_unfreeze() (and struct luo_session_ser
> from luo_session_freeze_one() and luo_session_unfreeze_one()), and
> populate and clear all fields of struct luo_session_ser in
> luo_session_serialize().
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D1


