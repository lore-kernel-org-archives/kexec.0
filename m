Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EB606A33E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RY6xOWaE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlcRruvS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MrI+rqDmwsTpRPF5ki5piP+HFeRyIsPNHlEWXQTT5Es=; b=RY6xOWaEYb627qiXZ47dChuocc
	aaPp6UMD6kwApVIysPL+cUaRmlS8SC3MkEOKiBwwkbnZxDuP65Y9yhdHt0O+Q3Y/z0RHrkBGnGRHQ
	GebkGhxVJvGNwoV/VVpnZTZlEIdQC+GwXuc98uq5aapaFaqNckkqiiOHkchikz734oyjPSPEi0Fgl
	4kNak6mICaLZtHPSppQRUnvHqrWshFt/NOGnvyv67UNBpqCTjbJslC64qwpojJolOTU0yh/nM7vOu
	behlY9R06hHBdRkiZYS4l0VJ9ot3RKXDeO2yLfM4SJGJ0PHL2QUYn4mLpgmOsF+ayD1lU/zzE4USc
	Jjj1M7mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3UL-0000000AQQo-1Jks;
	Thu, 05 Nov 2026 19:51:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3T3-0000000APwo-2Hcf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F17741AB7;
	Thu,  5 Nov 2026 19:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE61B1F008A4;
	Thu,  5 Nov 2026 19:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908189;
	bh=MrI+rqDmwsTpRPF5ki5piP+HFeRyIsPNHlEWXQTT5Es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JlcRruvSXXeF/yHdh8XDwJYbseLZZhFUomx7pyjMpu12GzMnmomelySb2GLdLrQLW
	 qc+ay3RTgqdwdbRkwuHHf/OceJtNxU8NY7lTsvjpgfk7E8wPyCdcCBqzjjWDcqC9n+
	 9E/0cDjv+DLLsL2Ke+qV12ttQoFjDSveLdOwbsYYzRvbQOGaiRo1gmfBu+8rc7Vc1F
	 HvwL7WWrnl/AvCyXWk1WhgKMXHhJpBfKgN/rm6KIY2DOOCwIlXcps1JhhMIyAxL0bG
	 ObpyCzcd0ERlP7sTZXQ4Jn/DqI3IfyN9LEdC5d7h/YR67QqngtLQOk8I1Sym4fpsYm
	 OX5d+yBtndmGQ==
Message-ID: <sashiko-outbox-200005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 19/26] wifi: ipw2x00: let procfs copy in
 writes to the debug level
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
In-Reply-To: <20261104-work-procfs-drivers-v2-19-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-19-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:45 +0000
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

> Implement ->proc_write_buf() so procfs copies in what is written before
> it pins the entry, and parse the level from that copy. Writes larger
> than PAGE_SIZE - 1 bytes fail with -EINVAL now, and a buffer that can't
> be read fails with -EFAULT instead of looking like it was written.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D19


