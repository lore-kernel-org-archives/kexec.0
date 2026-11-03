Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9786606F62D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pBETMSyg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ1rFM7f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Syy1LgUFNYfSx87H66aCq59eQL5QmobeRV7Tv8sgLNY=; b=pBETMSyg5bSdx5wYS96KIarwO/
	gd71968kL15ONKQlF3BCman3y/6LG/jkldAfR4tp9SubA1ihnUNRQ1defl4CiFZn5TqEPS5kJpDI1
	kPgES/3awKvxZh8EQDnKm/DbqoF4PnBdV9NQ841trbHR+72lGCNnZrkcdT800h+6e4pCqE5OAdBTW
	gEm2JNEpNIB3UimpZzTzQF0sYFC3SUsZW0fxcJWxvtYYpJQnXFeDxP6EXY9Mpvq9RXp2+Q/gFd4iU
	mgb72s6oFUEVjhEx6Ga9Qf84Id8c73Jr8iBxHu9mYtviR7IKDIP23Nruxz4FC87N3luoAlFowAapD
	1esabfsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0p-00000002plN-2oDh;
	Tue, 03 Nov 2026 15:01:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0o-00000002pkG-31oo
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A5D260A03;
	Tue,  3 Nov 2026 15:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443D51F00919;
	Tue,  3 Nov 2026 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718081;
	bh=Syy1LgUFNYfSx87H66aCq59eQL5QmobeRV7Tv8sgLNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQ1rFM7fpR8B7CuMfEAfO0MPeFB7bviklzJDC9drMf0sVFPBUxtSxRBwsAET6uLuq
	 86A/lVnXs2ElYSj4vKDjmBCYKvJP458x5hONgHu5bQd7fbGpMj/t34dciWXfi7wqDJ
	 fFU+zJ2crZV7Xpsjn+tHMvlBjozine7jdlnmk5SGbQsExLyqTK/2RbNWtbH4IIfczT
	 j+/yszVdEI2WEGpOCFfohvzHDpftk4H2/o8Xj1NATPp/4Sz/Frs7Oa+VUWRBUk8Fne
	 yAUJyeEi14LhQD6cE/FmxhetOv8CXAF3q6i2fz2LXak81erXq8XJdvZZpFYfJ57Z0O
	 KP55d1fdx2dfA==
Message-ID: <sashiko-outbox-195536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/16] seq_file: add seq_preallocate()
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
In-Reply-To: <20261102-work-procfs-core-v1-9-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-9-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:19 +0000
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

> single_open_size() allocates the buffer itself because it does the
> single_open() too. A file whose seq_file is opened by somebody else,
> like procfs does now, needs to do that after the fact. Add
> seq_preallocate() for that and use it in single_open_size().
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D9


