Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A860A2608
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FdbKCiqR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCFaxZX/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aroUg095/6TmMJBeZjgIoSTvyvzHjk9A05ABR3Cu2L0=; b=FdbKCiqRQDHEIGcnZZyYGSjjpQ
	VeFRk8mLS9kdHkWvIY2jEDl66NYAf9cytD6rTW60x7W3kWL4R8/7zycdr2s/EFZp7re/t0oOrIoaL
	5vC+yXq0shXmPjRY2iM/jmuRt8FRxwF4/kdZrmpaq4VXPe/O8+VTMu2o80nuRwaKuSuM1s31NH5wr
	EPKKSwsMZEuAba/90PJTqW32/MTGFTKCOOBm3tGdQPBV2iu6vDi6wXJGextWFVYVDaTOWsYKswRI9
	I2nIzhclLADO1xqdKh07WvuJcYUICTkqK84BsRIzNO71bnLP6HKjKB4JSRrE4lxjisPOCnp6FCqZT
	30etaUdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3GO-0000000ANLi-0yGb;
	Thu, 05 Nov 2026 19:36:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FL-0000000AMw9-3SY8
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 93CC743DD9;
	Thu,  5 Nov 2026 19:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18721F0089F;
	Thu,  5 Nov 2026 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907339;
	bh=aroUg095/6TmMJBeZjgIoSTvyvzHjk9A05ABR3Cu2L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCFaxZX/pXJMPefHJpV09W2+w61KUBSGqPrg6CbRySAMTOMm4JaDr3tcTx2cKIuLk
	 JUa1MBKLWQC0ZETuEO66QAJpJgqhbjOyxojVM6ivSCYHHkGowBxttDYjM2eIGpwnEJ
	 APEOw5JcwA0jVhqdTOcM8vG9gm6Rdg56kD7z39j9iMGTnOcL8jgcdJyaHFK4JxakLN
	 DPKfZb5NAMv6q/AFJDp3292ogJxaCXKsP0BD31LNcI437rpmGwZLQz5zNGjx6DHRiH
	 nhsuxsTVQ4aM+It/sbt2s0keUKgj1g/u2y0gxfWVs6QUw26QAPF72OyrzpNfLCn3PY
	 1jEvLMm8/QQ/A==
Message-ID: <sashiko-outbox-199942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 12/23] seq_file: add seq_preallocate()
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
In-Reply-To: <20261104-work-procfs-core-v2-12-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-12-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D12


