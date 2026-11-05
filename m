Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80977606A331
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IOowkR7t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BI6MttIY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P6jpmRzymPT4r1qFhmwUt7rLPG9nXrVikl3aWyHy3zY=; b=IOowkR7tx5mRmqgfc36xHjwFle
	BJqIzPj3Qtkm7hA9hpOYdta6SaM1zngFZEPPCXc8Jl8UQu2zJON0llTZNN7C47f1iPpYUuy+KM4FB
	Zi8SL5DTCST/fM2D1bmQ9QidsIuj4qaWjiJtPYw3XN8la1t6no62fqjiLu3nz+GDyxYWh4oVcMrEq
	KQz+PNkGjnY35DPUUolx83Td6UONKOb+rlQ3QCrdM3kGcpTwLYLDmxwj47+iDW5u58fQH6uFToMuu
	tXQ++LMF8JdeECdcwlPeVnxiiVmbmWatY6kGuEGIcFu3G6BpJjBMFfRmpArM4RHHaq0MpJ0+waK8p
	joplgsaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BJ-0000000ALCM-1px3;
	Thu, 05 Nov 2026 19:31:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39a-0000000AKQF-1d9c
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D3566601CC;
	Thu,  5 Nov 2026 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506931F00919;
	Thu,  5 Nov 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906981;
	bh=P6jpmRzymPT4r1qFhmwUt7rLPG9nXrVikl3aWyHy3zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BI6MttIYsBkE0g/vJZ+tIbuQi6n//HrvnT15RjmT0kcJcNcEhPSua8MjhEkmvdLBy
	 YJ4Cl9rhWrU2J4FNfrV5LG8LjKzdoOPXpIy3l02i150qUa6eO1W62hdcJOzlm/8UaO
	 8YRGUFIFXaZzA8K6X+GpP9ZjU4yKSbKfjjhUBmROBGXgTGgeHdxAb0ylhCvZ99pGHi
	 UTdy2yICxI8TI6rIlwVdpTX04WIt3mGVdeNnVRbumQIyZHqUl/9zhk34Qq091tX8nL
	 V7uPEQ77IY3Dtg208+RDdYXIh08xvxvfPijNAYM2aPAEKdPQWQJs9yilg/Hiqm9By0
	 dV7TqpBHd20kg==
Message-ID: <sashiko-outbox-199889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 26/51] scsi: core: NUL-terminate what is
 written to the host proc files
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-26-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-26-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:39 +0000
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

> proc_scsi_host_write() copies what is written into a page and hands it
> to ->write_info() without terminating it. ppa and imm parse it with
> strncmp() and simple_strtoul(), which read on past what was written into
> whatever the page held before. Terminate the copy. A write is at most
> PROC_BLOCK_SIZE bytes, so the page always has room for that.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D26


