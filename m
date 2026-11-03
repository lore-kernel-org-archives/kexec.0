Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC16606D2F6
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BO8UAy1h;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsf1aJRJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GJCj7Kn00SbLJvTNolj473zurqrXw24NOUW+dVEOMrc=; b=BO8UAy1hrvGuiU6C+q0R5j5/5V
	cHkgNEFfp6FUfsPLy/3smWQkGeGU0609e8AS7SPGs6wmea9UhxUBifdvW6B2FGWDJj3ORQc6ew877
	3tfDbz2lAfncoPjwRz6X1dnRf0/Mi3Z26XooQ87v3Zl5YC0TdhBJt7qSCADSNe79nsthD5XlxX6yk
	s3v1ZcUinq6XkQ7ftnCafDz+guFplnlyvkQXgfldgh1Ta0PXxNLDvmesoNMDfgelFicwUrpw/EnRf
	BMJDDRQeVPuGJBBaRNjbzSw/Nf9TS+GuCZ9onkcPZDAwVyGxTyflTem01JERghBUEUNo2kulsea2R
	8ebIoBAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGIR-00000002vxp-2hen;
	Tue, 03 Nov 2026 15:19:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI2-00000002vXZ-2ZMq
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 086E060A7A;
	Tue,  3 Nov 2026 15:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288131F000C1;
	Tue,  3 Nov 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719149;
	bh=GJCj7Kn00SbLJvTNolj473zurqrXw24NOUW+dVEOMrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nsf1aJRJ1HwGj8H9IQrji7tMD3hRlznSbt7aZxlejvsSBUbWOOM4A56v1e7ylcWw7
	 yNjaD+1rmjfZxTXp4KbstaI/4dUC0ktxITysc9eOvhOCqvY1qUmFm7Sr9ZezYFcQF2
	 DaQ0Fv2TyzFXduotPcyFPlTCNxRa1UN+xZ9FXIJ9FdpOrONGlLSZJxcYjpvWQgIfFZ
	 SD9dz0XlX5yAdz7Dq7WZFDJnK+rruhN3iD7UoXeEeQXeIuL/GYaP8qPNP0ydJo/1hw
	 RrWedATwKabjI3pZZtfFnataKy5WrhF0JUQ86HiiatEOs4CwfaXAXaPYpFPSdjtEde
	 u8K5nHSnx2tLQ==
Message-ID: <sashiko-outbox-195600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 20/23] ALSA: info: let procfs own the seq_file of
 text entries
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
In-Reply-To: <20261102-work-procfs-drivers-v1-20-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-20-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:19:07 +0000
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

> Declare the show function and let procfs open and free the seq_file.
> ->proc_open() only sets up the private data and preallocates the buffer
> now and ->proc_release() no longer releases the seq_file. Reading an
> entry then no longer holds up its removal when the card goes away.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D20


