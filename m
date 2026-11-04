Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8E60BE2D9
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=APxqzXZm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASwnm6fD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QSRnjp/0rnoDmXn15a3UnEZghiwDbvR/Tytx1Mp0bYU=; b=APxqzXZmJHykFgu2TNYgznEe5q
	WxPI+reKaJq6Xc0xzLXIH8OYFfhVQ0sZq5W5k3WlnfoJky3QXg+amN+/5jhHrnJxu2cHTiCrkV4wU
	/DzSf3rGj8iZc6W9z/1x7vFmOSSmiA23WpQWqKd1kqxWFZooJ0hGvI2tgy/vU4ZfFER5mMmGf26Ce
	1aThAUnWQzaSWBUlTDMcI9W73luUF4auWCPOQjqK0kI3lQbIfgAYlfT8RFeZQ5bjS00GZJRNipxwi
	qu1bRdMbk6NgyS+Nf/F//cIB19ElLpQiyjJ//ESHo2USfBKharudBemA8yUhs08WcG5AYqasFl/Fl
	RO8AdZvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgsi-00000006iog-1KXQ;
	Wed, 04 Nov 2026 19:42:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgsh-00000006inM-1bB1
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 19:42:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7759D60D83;
	Wed,  4 Nov 2026 19:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E367E1F000C1;
	Wed,  4 Nov 2026 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821366;
	bh=QSRnjp/0rnoDmXn15a3UnEZghiwDbvR/Tytx1Mp0bYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASwnm6fDYIYqujJhujIxd2aiYOQNgdLPmE0+JMDFiVZe/Kx7lkfnuwT2o+IPViML8
	 r64TVW8PvoTN0KJapcp40g+soG9o0mudLh/aq5H1VadTxGy49E6jZ+TBi6H/TwkPPZ
	 V6ev2TOQ8JLvXA77GOaBUD90ATlfMNsUkcIS9j2AmeXY04I8SofdSd9OB7piD25VFr
	 cwFEcq+XeiRtA2HhBb69TTDRPU2h4w0QmtQm2ddgnZ0+k63WQJnST20ByIid+OBfCT
	 hEjjjRfqTa6jQ3xxzR/vTgNDVjplQTWQ8E9bb9keywPYY8+dHS/hbwq1GNMjy5yOym
	 CXzFSL+wvmqug==
Message-ID: <sashiko-outbox-197974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/kexec: don't fail the build on other
 architectures
To: "Sasha Levin" <sashal@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Cc: "Baoquan He" <baoquan.he@linux.dev>, kexec@lists.infradead.org
In-Reply-To: <20261104193637.333158-1-sashal@kernel.org>
References: <20261104193637.333158-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:42:45 +0000
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

> The kexec tests are only built for x86 and ppc64le. On other
> architectures the Makefile defines no rules, so building or installing
> the suite fails:
>=20
>   make[1]: *** No targets.  Stop.
>=20
> Give the Makefile empty targets there, as sparc64 and
> drivers/s390x/uvdevice do, so that the suite builds and installs
> nothing.
>=20
> Fixes: a802ed0dd9c2 ("selftests/ima: kexec_load syscall test")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104193637.3331=
58-1-sashal@kernel.org?part=3D1


