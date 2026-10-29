Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A245606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nFItXSAk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPUCLkDO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7aW3SNhSUSIi1ysctDRGtYGQ7IkOUSC5skS7sMS7T+E=; b=nFItXSAkxSmr3iKKz78GcKv2aD
	s6ReUcuWOYD5mtxpfmE+o4VXLU3LoecDquMneSzSSYR/0f6Wba2RdPIeJsfJHl8WEcms/RqWIIZVY
	SKiy5W9xap+yNfAlN6NS3fugCtyZsu4+1Og+itmgZOndmOHWqbSdDK+1IHvA9eqjmviJa+A4tpDb6
	tWJ/fIRKfT7CXs74eMdEn2KiNH3+FqzDxkR0f5x/34pEJiAwiSLlgs0Pi/XaZ/nvab+MqoPLbdfcj
	sPlIi6qK9g412N4Xzact1qxIq4fJw/TZH5pTZvwfse//T6umdUbsW6NbZBoPMuu0LPLHTdOmoKVeZ
	4O8fqWxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMELP-000000087K5-3fti;
	Thu, 29 Oct 2026 00:50:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMELP-000000087Jv-0MCp
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:50:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 53D2943BA0;
	Thu, 29 Oct 2026 00:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837811F01825;
	Thu, 29 Oct 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235014;
	bh=7aW3SNhSUSIi1ysctDRGtYGQ7IkOUSC5skS7sMS7T+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPUCLkDOxtS+/1irc2z9r7ZSkBhm/ASMPZZZ4gKwIP6wE3LVm7ncUxswU5jlj4hFH
	 rAlXrA4XmXpdFFSWWYUMDDxLuzQN1HolVZ4Uo0w3rPxYV5SyGDHCRm0BOt4wxu5hki
	 BAwnEVDQ5UrcFR+XiMmM5Ee//Ao1bnP1M1ncTo9s2fFoHw+rsD72KRldwrvIxLtZ5q
	 pJtk64N6wHBX81IkOmZwTSFan787hjmkWRqrFCz8TpMuqOs+XgzCOac3yqJsVkKK6I
	 LPrL6bHo8MhzzokG8xSZ7BKuk49XHaSc+AOjzSUC7w4wdjh5dqltmXsYnzv4sF7pUR
	 TT0NFtt4nnQ+A==
Message-ID: <sashiko-outbox-188578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:50:13 +0000
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

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>=20
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
>=20
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> [ ... ]
> build artifacts. Making it possible to use an ephemeral,
> userspace-provided key avoids shipping a static policy-signing private
> key with the guest rootfs.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D1


