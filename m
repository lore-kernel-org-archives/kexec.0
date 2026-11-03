Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716C606A795
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KwGCh2G9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkpfZkS7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l0X2QAFJot0IX2Q2/PWev3um4yqz8IITz7l9GjGkrL4=; b=KwGCh2G9NV4grt/EG1D27v3ebG
	lok7o4qmaxacdMJPLYiEcM7dSqe+BBdrYqf/sRDvijtYDVEOOcOBVnC7FSVTXjNLovdcolmoIeqNH
	Woj/QoOrfo0Lc13RcOoQ27OBewi2X4Z67I3ug9WZfdgjysmS6KVmbPJ/fkw4kMP25erPPUpgrAENo
	8Ic1uNPjBmAVdVYRGlJ+bFZlJPd6XAT/adCom7yk0duWthdGReHo8SleD7cDnpJ2C91tjODD0EN9k
	WpVZf+tp/519b6qhSus63Pm60cBxAxMRTtjcSsNhmCZhT+03eaLUpwWKEX2eZl6lB3gHZiqN8tIg6
	FkO5Frfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0W-00000002pU5-2zZS;
	Tue, 03 Nov 2026 15:01:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0U-00000002pTc-10Dj
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A1488609F3;
	Tue,  3 Nov 2026 15:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A043C1F00A1F;
	Tue,  3 Nov 2026 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718061;
	bh=l0X2QAFJot0IX2Q2/PWev3um4yqz8IITz7l9GjGkrL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkpfZkS7dZWvU26v0lWwGLaCaRutuB6NiB2HUX/uekFcZ6yPhi43CmkI0piScwXiG
	 XdmBl4Dct7JDxY3Oc7vA0poDAVacBGmgTZaVJ7ciP4PhbjXPYKY3rpzkHBOsWEuvfj
	 PJZNqUEfVII+aZ6SZHk3HybJGmkzh2Ta9HFLe/fuaYrlEEFMWJnDyneLI4ytXuGeYK
	 ilddlytumyI3zcVD0Jtpr/3wYGR4B7vu09t2E2PQFcbxIfr/kjBi78lHIMRodLZAan
	 +mf+PcsUlbGluhMP5X6y+JNOjw2mxyTW3Ila/ruuoWUTlbTJtmYRKX+yfPYzVC48+Q
	 X/ep1///7lR2g==
Message-ID: <sashiko-outbox-195528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/16] proc: drop the compat file operations
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
In-Reply-To: <20261102-work-procfs-core-v1-1-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-1-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:00:59 +0000
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

> procfs has both sets of file operations twice, with and without
> ->compat_ioctl(), and picks the one with it for entries that have
> ->proc_compat_ioctl(). That's from commit 778f3dd5a13c ("Fix procfs
> compat_ioctl regression") when a file without ->compat_ioctl() went
> through the translation tables in fs/compat_ioctl.c and one with it
> didn't. Those tables are gone since commit 77b9040195de ("compat_ioctl:
> simplify the implementation"). compat_sys_ioctl() answers -ENOTTY for a
> file without ->compat_ioctl() now, which is what
> proc_reg_compat_ioctl() answers for an entry without
> ->proc_compat_ioctl().
>=20
> So always set ->compat_ioctl() and drop the second set of file
> operations and the flag that picked it.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D1


