Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EC606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=luTbRvGy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkIp2rMW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zcV+i6POJg+RrsF6YRGTS13AdWK24kXKpMKXUTzyEiA=; b=luTbRvGyVlKcYSdiHTCg5v5JtI
	kADnBboMRb1O/OpbcKRA3J0+usmiBrw3wyc8PuTSoquTTbqmQxHPYR6iTvVHiByw1SLRnjrp0wrAR
	MXbMrlcezIMpqJ+ZpgswRqAaAJCWEBhgwNwHboMIpylrGHPKV+/Ith9L85e85o27v5DtlDHt2Hzse
	/xNP4OKj7vtdu0DnMDkWI8A5xW4soPJ3dlndbaRzqyWsyoTbStHxoYR6t2INoD8xF/pwA7DjXEs8b
	7haAZtRbEzCEPWrAxss1twN5jv09TVxoDECUFo0USjyYyWUfrrseowjOm9YBz06EmjySAVYcKYmN4
	fRL2Y8cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BS-0000000ALMl-28zy;
	Thu, 05 Nov 2026 19:31:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39p-0000000AKYd-0Mtv
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 883FF601D9;
	Thu,  5 Nov 2026 19:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E721F00A1A;
	Thu,  5 Nov 2026 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906996;
	bh=zcV+i6POJg+RrsF6YRGTS13AdWK24kXKpMKXUTzyEiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkIp2rMWDRL8aX8FKreCHiJ+F7j4BKfzXmJc6PZ0eOL44V9Bx9anECeImDIf3eWQZ
	 CQsJtA+hT+ZN+BsjMDC+4Myk7YdWXtDiWz3ec+ntbhm3ExMby94rd/l77DkKdkzhbp
	 M8ZtpbEVGaVz0Fx3Tr1w0TZ9yJ69+1Fn6/egkNAAHbcoKwUUjIp8R30wCoxDFTv9XV
	 Mj2kudWFsx5lEkvVc1J1kV40ftb635ECGnH4cjLmWAO2ghIVDG6bpdIpREJUYlfZPR
	 qAFtvcqf+3EGNnSIARNIkc7P/WD2CkFmNpfiuMmYjjTmUT9PU8swjMoXDeK1ufevJ/
	 yOPbsNDq5GkUw==
Message-ID: <sashiko-outbox-199896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 33/51] selftests/proc: check a /proc listing
 while entries come and go
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-33-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-33-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:54 +0000
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

> List /proc/net/dev_snmp6 of a new network namespace while a tun device
> comes and goes:
>=20
> - with a buffer that holds the dots and "lo", add a device whose name
>   sorts first, finish the listing: "lo" is listed once
>=20
> - with that device added and a buffer that holds the dots and it,
>   remove it, finish the listing: "lo" is still listed
>=20
> - with that device added, stall getdents64() on a userfaultfd page
>   while it writes the device's entry, remove the device, finish the
>   listing: "lo" is still listed
>=20
> All three fail without the fix, the first lists "lo" twice, the other
> two not at all.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D33


