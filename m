Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94085606A333
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WShiBywh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQSr4R/D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gAVlktWGI4QeSuJoAwfYGMkH1PJUJetPfF4oCxqFFe0=; b=WShiBywhE1pLBF5u6uljriBVmq
	9uPgXKTKv02YJYvIJhvvtkM0qFUet1YVc4BTGeNkKnJJKt8jj9Y02lX6pCr1F33suyHE+d1W6KlLJ
	xMIWuSGayZ5hOVQ1cZxeCG8GaTsTa0PtGoOcH1XtyMpt2bsZKsUpamvtuKnsZr5tUt/bfPvGk4LEt
	8GUO4S506exbTwzFn19Kj02QDrcJ6zZIFjTI5gAfh/FghZZOZw5bx8jb+vSU6URD3A5TQsifdQ9ZO
	rfb/K8B+J40m8HXku96Hs7XTNeVgSQpYR/szf2nQ/VVRSIu4hUet3XyHj6vOVAxE4JAwkY+OdLkBB
	CU1AWh4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3HX-0000000ANlT-1fYL;
	Thu, 05 Nov 2026 19:37:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Fk-0000000AN6w-2jE0
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:36:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 680D2402A2;
	Thu,  5 Nov 2026 19:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C754B1F008A3;
	Thu,  5 Nov 2026 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907364;
	bh=gAVlktWGI4QeSuJoAwfYGMkH1PJUJetPfF4oCxqFFe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQSr4R/DNc1E/FXbeW6HC3m1wCeMgc9IIMGiHJaOK7TVm2g5ZgNiUoNKqCGvkMsls
	 e80ijNz9iXptJP1sPdMzJ3n9rcbsCelmZ++Z3uf8wNwjL0bFsRjGZ0W+orZm2yOGGT
	 MHWHtJwm9E+LGUV0XYeS7ZUb631YlqElIEwM1EGlELy4RjUHz608szz0/Q1TsxHjQC
	 sRQwE6PrOlK8doE+ZCiBF8WQRnKJ6xM7BYNVmcDVPI2Hr9/eJBOxU6R5y79dTXTIws
	 2IKZFX0+5DkFSsq4cZPsKn0DAwp99uEjMEyNObggujtHKxIXTeECXEcKidjU+y8LC6
	 gXxtrmCBTSTsA==
Message-ID: <sashiko-outbox-199953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 23/23] Documentation: seq_file: describe how a
 /proc file uses seq_file
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
In-Reply-To: <20261104-work-procfs-core-v2-23-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-23-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:36:02 +0000
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

> The example in seq_file.rst hands proc_create() file operations built
> from an open method that calls seq_open() and from seq_read(),
> seq_lseek() and seq_release(). procfs doesn't work that way anymore. It
> opens and releases the seq_file itself when the entry declares its
> seq_operations or its show function in struct proc_ops. Say so, and
> point the extra-simple version at ->proc_show() for /proc files.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D23


