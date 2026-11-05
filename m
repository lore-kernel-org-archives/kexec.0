Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2D606A332
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kA0f6gP7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqLSjmTq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b6fUC6kkwZa6jGlElTDwWL2u3gjCO7plwWOIGlwpTiE=; b=kA0f6gP7xI+VAcPCTo4Sm3R/oH
	f0qpe1MXt1gUh+x54sPhB7v1Ib58j3auGAlt1Gy5mOodNnmEYuCRWrDXYYgwpWS1Q9bCOhY+RfacV
	MUEBgntT3cOw0v4tkV9J7vP23bbRWtMnGcFegpX2gQCKyhOTQI1XdnD67QlY7ujKxtQdFlzcuWz7s
	9uYvd7e7d2cr5Q2cIoPvq1yrHgzMCcmHxRvVQobktf/PpL+pKUOwATqj+fJmdwIbaE7XJYGmtGSCS
	L8J/1WVnSD1dGZLsxE8DS//oIf3xYPrVNaSDF8daNZ5vp1oaAQ0rD7O74+IpVSw6jU6+FnHjOe8eA
	fDGP6t8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BK-0000000ALCn-1f5L;
	Thu, 05 Nov 2026 19:31:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39Y-0000000AKQ8-0sMX
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F170240269;
	Thu,  5 Nov 2026 19:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759BC1F00A15;
	Thu,  5 Nov 2026 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906979;
	bh=b6fUC6kkwZa6jGlElTDwWL2u3gjCO7plwWOIGlwpTiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqLSjmTqIqsb3uOWNf5itle2+YYZN7QrWSpoAg2AznNJeMGlmfOcDv+I+qQC/PV4q
	 oM/ttZIktk3u2UEYRLi7imIYWeewjGd3g46pq6DVdFDvsmQYVdGsBKqCqZVdWS7N0i
	 tpm6VNMiWBiuscCgtZGDWjujl0tFlJwCL6trdEqlTYYAMvmUvXMpnGyxWVrHMwosBq
	 djqV34NaddaXWJ7uOvgZCHtGYdGCHAEcWmVpgX6aM+BtPqPLPWgB3dldmaWXncEaVj
	 WhGPLyMA3oP8jfMvyP0VXsBlKe1NFyI8lrBj+VpezDdETg3MRYQS3J8VE12drFITzt
	 Ytd9Y83ZFgpZw==
Message-ID: <sashiko-outbox-199888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 25/51] wifi: libipw: don't return 0 from
 writes to debug_level
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-25-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-25-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:38 +0000
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

> debug_level_proc_write() returns the length of the string it parsed. A
> write that starts with a NUL byte thus returns 0 and writers that use
> stdio retry it forever. Return the number of bytes that were written
> instead, which also stops writes longer than the 11 bytes it looks at
> from coming up short.
>=20
> Fixes: b453872c35cf ("[NET] ieee80211 subsystem")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D25


