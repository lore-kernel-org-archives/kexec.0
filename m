Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F16072C7E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UfTGOb/U;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXQczwRB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6cps/enMaPjoFeCDjt0OIcQqkD6lwpn3AaQg+KoH5MA=; b=UfTGOb/UVYcfF1FcCyF1OgA0+O
	n4BcI6S1BjDvREUYDKfE3OM6XvSZJKHxt5dRmlmifGo4VMEKLmICf15SGNKHvMVZCfOCmvWiKuP0S
	6OKmNNib1IGMJJ4m0k9bVQ35O+vlt68X6Kpj494bOV8phGPpBTgjpBPWmb5WOCbh+LUALlwMcoReV
	UWW3ZVlbMKx9g02KGH2t0KbqQ5abHgokLz7PSt59koGTDtQySYLaioPOw8XE5FjrNsIreTIJguG5S
	3lFQATLEFgARhMBWt7VroRwxI1ro5r24kIsF3k4vqths5MGJiv17zUm16qZbaXSkbmzOYok9M0tMM
	W1WprVaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sp-0000000APmA-2rSy;
	Thu, 05 Nov 2026 19:49:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3SV-0000000APgf-1FQT
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 857FF60210;
	Thu,  5 Nov 2026 19:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB71F008A2;
	Thu,  5 Nov 2026 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908154;
	bh=6cps/enMaPjoFeCDjt0OIcQqkD6lwpn3AaQg+KoH5MA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXQczwRBEXysSM7qtBjfJavsgQrZKTVx0yuwFzRJcumKzWmphnnHKjGfvN+N4Q8c7
	 0gnr8aWsZJTn6RiwGOM99KsCPRfdKnD2gmZGBa6cZyhsHOmKdk/p3t7dtqB+KkkxUK
	 Tqn73tuLhq8E4PhE8YiMnhhG/iRUbAbieCFh3X1HCoAC+PQOchL+wT/c0O+sZenray
	 0ieAhXUCsy5aAlLaGHYJVAZtCXM0DzFCzGPvlwOyZ0NDlB0Hk+CiPhmTvHt/WW6C/N
	 IJE4tr6U8LvpD2431eh4mGeuBUOnBIYyHAT+kFIsPzYQdWl956WMKsirJGDnRlKrLO
	 vYsd7v/OnW/Xw==
Message-ID: <sashiko-outbox-199990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 04/26] PCI/proc: let procfs copy out config
 space reads
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
In-Reply-To: <20261104-work-procfs-drivers-v2-4-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-4-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:12 +0000
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

> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry, and read the config space into procfs'
> buffer with put_unaligned_le16() and put_unaligned_le32() instead of
> put_user(). A read into a buffer that can't be written used to report
> success. It fails with -EFAULT now. A page holds all of the config
> space, so a single read of it still works, libpci treats a short read as
> an error.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D4


