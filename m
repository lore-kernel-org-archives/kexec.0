Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DB606D804
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bbCWUtC2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hob1t0Fy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s2I1/DcyfONVmWbtskFJJxiXW4AP+/HerBsQu/u2rpU=; b=bbCWUtC2EZM8q4HeOX/hhcPHj1
	6j0ELNPbkQJWeNz9IAFH1hbVpnWcKhK+N4bM3OMSHI96h2e1kxsoTVBe7VZk+2LTD7UYzszH7c9P8
	7eJ+5Z4mqWw8KOzqYtaqf+zCM+TwrRWohhdt5pLwlgZvxOsW1ZKYZ61bTvO2JaOtFp+j3pfPvpBWZ
	JZ7NHNdza5lEUm4+U7TmnAanVPXouNzhhuaK/sODCndk32yLc7AmbNG0JiJv9GpZoU9rpNRyuXZgU
	j9ss4oH4OnYgIapjbMLRLIndm7fYfu8b5X6zVOd1scn/bMU6JtLzYGrpv47QiPE9MgnDw3GSSnQ7q
	MU61L/NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39S-0000000AKMD-2xny;
	Thu, 05 Nov 2026 19:29:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP396-0000000AKDI-0EkI
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AE0660181;
	Thu,  5 Nov 2026 19:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2771F000C1;
	Thu,  5 Nov 2026 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906951;
	bh=s2I1/DcyfONVmWbtskFJJxiXW4AP+/HerBsQu/u2rpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hob1t0FySRzo9Ad4NeX/wxJ636XvG0pYfHERcgRJc+Sg4Icctgz0x9vaAElTM9XlC
	 DeKuv9MiuNdLOq07xSluaDzV5JfNZv10Cdb4YpMe3kNCTfqfHICUGtyJeiRHHklAiG
	 o++YqHIytjB4pY2nCoSP0oV0ptT5uhCu20e3Yv4WPkXDuLDrzC8G5BMKr5LZKXdO/g
	 3o/pp7jpt539+SMQvv32EonKmKe+Ve9RvbbFiZGIicJZ9ffcoawscdTJSTVjbDcbdg
	 3IMhMWg4He6bnLDFELiozvAEzPh6t3NkjMUHVvLrqfosjL7JmUxVl7OEAfd/jNb3w5
	 bT+XCtkRbrOvQ==
Message-ID: <sashiko-outbox-199874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 11/51] sparc: led: consume the whole write
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-11-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-11-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:09 +0000
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

> led_proc_write() looks at the first eight bytes of a write and returns
> that many, so a writer that loops until everything is written, stdio
> does, sends the rest as a second command. That one is unknown and
> switches the LED off. Return the whole count, the rest is ignored.
>=20
> Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D11


