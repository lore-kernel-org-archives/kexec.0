Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14E606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UtjC8/wA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoSC0hLV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9v8pHQQjQUxQKmm0Gh73y9yEG8+GYEbFs0vOjTkOk8k=; b=UtjC8/wA+WcJQAjrNoQwUI9ciC
	6Ec5+LtRwJINE3AypDBdadxYgX4v6vG1DyE5sdPjnZtywMFsRR4NBAPaza/Jmm0Iaz9RYSMB/hlkA
	kAOZsPag+3w0SvWekDwelMOC63zN4HTTKWnuPptw/ZyjEY3k4B5KpZlf0xGsaWe8ZIugHucjHu1op
	TOOaxceCGv03JQvd1wJjNgoOx9gM6QI9idfyiWwcwfbfsZ60fTwdy50kFnHsaO/dMu97E8QDTkad6
	9BJWReDFnpURUHFZUPlCGKgLKXpeZTE/6lI7aG4Sg9qhwO7JzOfvTxm+UJ7WwLILRg4oTC52F5plT
	fEKm6JDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xME9N-000000086Iz-3kF2;
	Thu, 29 Oct 2026 00:37:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xME9M-000000086Iq-0Mu3
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:37:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E272640E52;
	Thu, 29 Oct 2026 00:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A81F01825;
	Thu, 29 Oct 2026 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234266;
	bh=9v8pHQQjQUxQKmm0Gh73y9yEG8+GYEbFs0vOjTkOk8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoSC0hLVO4n1WW9gRRdcU3hKQVaNefG/PlFyjeDS2BlH+XwuTxgGgcQGjtlzbV3aW
	 fbeBsCGhLZUgYT5ikgKoSvXAIeEVu3F9K7jYY/RP8Vu7TZhxK3xnJ0nOGHNTr3x033
	 rIx6tErnZOvdnLfG2P7XOLa1rQDN36uNgNENg/3sgEE/g196HX0b3awNJlYVlZ8jxH
	 9xE5vPL306rliyBEWROXGeVDTSvSPifHKTnJoydP1RBPLapA1jHJVhYD0fi4SBHBQF
	 ak4y+0HGW+HvjlW657X2Y6ybNiEyIneCS1T0h5g7P/gll/BssVcXDhkDhF7gIbXMeT
	 ToDqq4DtclpGA==
Message-ID: <sashiko-outbox-188573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: ipe: document the IPE keyring
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-3-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-3-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:37:45 +0000
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
> Document the .ipe policy-verification keyring with its additive use
> after the existing trust sources and the userspace's role in
> sustaining trust. Mention requirements for maintaining policy trust
> in kexec scenarios.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D3


