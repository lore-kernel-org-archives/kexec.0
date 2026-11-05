Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3393606D802
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OPwXIs4L;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKTd/AG4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3aycYEBDbjdfc7/kYe/T64Q9jvyJ2iWA9tEfOPLcA+E=; b=OPwXIs4Lr6s+Vg7jJ9uo3ioZpf
	RHjH4bB4z0OmuABPurwD14giQRLpHOqiJ2/rW3lhCJ5zfMGzefLsDFLo8IGfEAlNTFmiNvweqKX7W
	+V/Ka6jpyczOn3gVzyssJSk7Kzpf/h4JW7OsOXjr+5MX54uBWGw8mi1Fd3ANASvRgzTV/rR4TVtqL
	FUs5MREUn9RMNCJ5TGB/dJ/yjFDPeyy5IgWoAuwt8ZbGsvd/0MTJUfcT1Gg14ncqQ2tIj+5dbh+Dg
	KReuz8tObe0IthAmhsohbZnUQYNP+VBfXR9/t0IEgx/uJeU9yyFhqbkUb6eFEeKtx5GWen05g3Ddb
	CXT/rOnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ax-0000000AKsj-35Tw;
	Thu, 05 Nov 2026 19:31:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39G-0000000AKIQ-2yNd
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 75BD0437D5;
	Thu,  5 Nov 2026 19:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10DE1F000C1;
	Thu,  5 Nov 2026 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906962;
	bh=3aycYEBDbjdfc7/kYe/T64Q9jvyJ2iWA9tEfOPLcA+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKTd/AG4bVwkR+b2GF208LnMZfWrUlqFbm1pMBbSDD3WYnbXwqUy5VQ+lWyM6SNJu
	 lz/dclSSpegfq5SEGEfBf6625Y4g8OyF4QW4OLSTxiOfTue470fGd1TPQdSpTqnj43
	 ICV2RKLESKaBxJNaibArgn3ldui1C2dpKkNatkQarCY+t3PhxnSOeaKuRbWfL6/xAE
	 ZShLGqZSqpc+z4DdGoHy5h26wpa023m96jQ73G3zVSjOVmGegLWzLyUhy4LNOhpUwH
	 uKO6G2AHPC0IQqrlvprv/L1ZgqClTdg3drPRJPRNRieMLhpDrh7lJjuN+buWWBl5ZP
	 SWx5hlboXGHTA==
Message-ID: <sashiko-outbox-199879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 16/51] PNP: isapnp: don't read past the end of
 the buffer on a large pread()
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>,
 =?utf-8?b?UmFmYWVsIEouIFd5c29ja2kgKEludGVsKQ==?= <rafael@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-16-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-16-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:20 +0000
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

> isapnp_proc_bus_read() truncates the position to an int. A pread() at
> an offset like 0xfffffc00 turns it negative, the check against the size
> of the configuration space passes, and the loop then puts everything
> from that position up to byte 256 into the reader's buffer, no matter
> how few bytes were asked for.
>=20
> Keep the position as a loff_t and clamp the count against what is left
> of the configuration space.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D16


