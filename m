Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88560A263E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=um8cpop2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKfmSIG1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nyk6A7Xm43ba6GqhnkPuqyLDv4V2ioid2McoXcJIDec=; b=um8cpop2RqPA4rc6lLHYm31EPj
	nBEjzPQL7azX9vIQkJTl0CtF6x2CIpsLb7M98XoUuXqZk4Sg83h7wSuKrQWryaF0qAsIo6LoRioi0
	izZEIkccOsBCTpCqZFchpR39ZcqXEHbyS/MNJ9vQvF4gki/c/fhc32Zoz72MmrOvHFkuTi71j+QIG
	fEaiwU1A3OBQ7wgAx3TuI1uny44OAxU3O0mCYleXmHfxEZfTvLdyVKEeDuxfh+dKhPaExzWa5Iqrf
	l6fUHl+h47DyX6fIYJ9oyrfvBA/Tbhkoas82wHridFcv6qSZtA5/IvYdwQ0eWgkGb6wSQDGyv7KfV
	yy2Qjiiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39g-0000000AKUp-3XaS;
	Thu, 05 Nov 2026 19:29:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39A-0000000AKG1-2mtA
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B600410BD;
	Thu,  5 Nov 2026 19:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB75C1F000C1;
	Thu,  5 Nov 2026 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906956;
	bh=Nyk6A7Xm43ba6GqhnkPuqyLDv4V2ioid2McoXcJIDec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKfmSIG1UN/LwBVQXjOkvO7J6MY6CD67myw1qrW+OIpPGU2VpRAVBUgr+00ywjUWT
	 wLAm/Bi+zzx7OZ9FQjICLzYsmc1028tuWSIQeurLxH8ygiIABX308i+7xPLywURc/W
	 7ILU32xExlaMpEA2rjZnORa7iwKiD+dh6YvkbgZ7JZXLtf1bwIEbU7n8vEFRB7/ma6
	 Tswhvw73a0gcOElR+tDfQALqyP4oqfrfBTv8JnT2i6bX4N7GoCW5irT/YJ10btLD9v
	 GZ/E7p4fjablgkPiTgV19jmiyQHA7eshOJIpKb/a+kzle33JJ/83PDvWIIc14A1u69
	 eI/S8mKdJSVKA==
Message-ID: <sashiko-outbox-199876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 13/51] sched/psi: don't drop the last byte of
 a trigger write
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-13-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-13-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:13 +0000
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

> psi_write() copies at most 32 bytes of the write into its buffer and
> terminates the buffer by overwriting its last byte. For a write shorter
> than 32 bytes that is the last byte the writer sent. A trigger written
> without a trailing newline loses its last digit then, "some 150000
> 1000000" turns into "some 150000 100000", and a shorter one like
> "some 150 10000" fails with -EINVAL because the window doesn't fit
> anymore. Only writes that end in a newline parse as intended.
>=20
> Copy at most 31 bytes and terminate behind them.
>=20
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D13


