Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837A6083604
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3mFxz0J3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=necGus7b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r1ycZKD70M2O9nWABnZxAo0Y7x59PNQr/eG96uelaDQ=; b=3mFxz0J3ETAj5SiJ5vXq1DvHPm
	wpi6QMgNu5OgeaXKXM327WwM8+iySm0NPTpWZD0QknH5fmKspfldHlEw3Wq5ik4sPlEPU8OBPdu2D
	/yH1ITmhQzS1KnY7EygqYPQm4+TJTllwtpCJfdDuGM1uY9LjYcWA7BsM3Mnua6v6AlDP2WEpiUXQY
	InE8XuZFnDjXCFO1DqXPDq4VLCwNETE5gcOYAxMBpNVOiUiYI6yW2haRsvfVPZ1qE+LSjHmPlfPH/
	Mw83SihVO1+YPsMkgOJ5u6qdbNOdVYIoUY7cnFa9hLh8AtEhYSRckqq52j+Km3FXigzkbK/B4g2j+
	Od6BWYsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39S-0000000AKLr-1e0Y;
	Thu, 05 Nov 2026 19:29:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38y-0000000AKCB-371i
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F98940222;
	Thu,  5 Nov 2026 19:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA70D1F00919;
	Thu,  5 Nov 2026 19:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906944;
	bh=r1ycZKD70M2O9nWABnZxAo0Y7x59PNQr/eG96uelaDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=necGus7bPU63UQk4B7+jV3XV3fUR+Vt0nlBwWy50VqFwECBf1aibdVwEQjnZEn+Ny
	 Nk1eietSenvm5xqR/gzPNGNzZbvkkvnODaOzH7V35V/oaIZYKDA69EZlf4qtIWl0+y
	 CLJx1JYEb1VEmZX7/x/KIzKFm4AvmAQYSTJwVI3oNBp4hYilo3LyLI/24/DmSHB0xR
	 KeFmM+pyBdtCJHSurwLaWys6yP1tn08WuWeskCI8YOyZaldAhv0TS5sXvEaDm8Qah0
	 JT7nN2+bgKA94sYD+FKbGDigc0ESaJpkTtOL2xP5JtOlGB9U35VVcN7RlPkTRv1UsF
	 KJpyB6HzUFV7w==
Message-ID: <sashiko-outbox-199871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 08/51] powerpc/pseries/lparcfg: don't drop the
 last byte of a write
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-8-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-8-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:02 +0000
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

> lparcfg_write() terminates its copy of the write by overwriting the
> last byte, so a write without a trailing newline loses its last
> character: "partition_entitled_capacity=3D5" is parsed as an empty value
> and fails with -EINVAL. Terminate behind the copy instead, and refuse a
> write that fills the whole buffer, which can't be terminated.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D8


