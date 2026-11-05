Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42A606A6C3
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fC6He1Z8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj1T0ugz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kmHJbewKimZexXI7BH61QhHVq1nSYkHQpCykfrWP8B0=; b=fC6He1Z8HjhoJhHdar32SGHBf0
	UHLAgpyOoD5xHJSv7uRp6MdujQlm9B5CK1PYp1XgmEVX0wEUPS9kW8jR1rpieZwR0zrcVqgO10Joi
	+P4C69fgu2F8QkKjFK4uD74nsmGr012UeGkt+CXeNT+ZwKmMYkBhFBH9a75Rf+gIPMdWMNdMzCi3k
	XVMs1cVoP86WteLrIUmG/8MWikMgOsPkA3bwtRVV85/BtJkHpyI/P/7aj4M+6Zygw13SvPYl/5R4P
	1OHJnOn18DDp5ilOMr/EFuDxluVbAMTsL+SozwASwrAWcO5SS+64s2VxgZb4ZMbvPzAvW/Ufhv0nS
	iYFfvjqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Uo-0000000AQhR-0DOu;
	Thu, 05 Nov 2026 19:51:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3TG-0000000AQ8k-2FLU
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:50:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C365406F7;
	Thu,  5 Nov 2026 19:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715111F008A2;
	Thu,  5 Nov 2026 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908202;
	bh=kmHJbewKimZexXI7BH61QhHVq1nSYkHQpCykfrWP8B0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yj1T0ugzNifTsvf+LRAo6+kTszK1EniN9dz6kA/nDqLCRZF2Fj1Zd7rJFSGBEbQ+X
	 o/5NfGjv+8aOBHVfX8oSOHfQ+Gz59qMKbXPRS2+BZBLCXy/7kFLBmE+QT3SmH4FAJ4
	 wPQvsR/Sik9KmFbNWPMtyeQunJpC6DisUVgMzC5SuOgY1oz8179bClmAx/xBMh4q2P
	 TrxmpaxUEYPEEnDTC+tl87U7YaJYsKqr9QH+yTEa/K2OfqI7BOn3gluSDHOOvJ2PUF
	 dgYEv6jHD8p9iv+S1FUedwISadA75xm6wTiLQLiLH63DyUtVuZfEv4oraoEUVwZ4+7
	 CXIteZ1K8OvIA==
Message-ID: <sashiko-outbox-200011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 25/26] ALSA: info: drop the ioctl hook of data
 entries
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
In-Reply-To: <20261104-work-procfs-drivers-v2-25-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-25-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:59 +0000
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

> No driver implements ->ioctl() of struct snd_info_entry_ops.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D25


