Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98320606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=np8Swkpe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WP5zysBl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Qw513NKzixnVetQs2aPch799inLwFwvqjGlTZsHFgHc=; b=np8Swkpe3xWt1m1cn+eVc47O/h
	fcQuJB2IOJMkaa4+pdRRGxUzQxgu42lkTeoQkLvc/X0W5130nP1J/PoBKAEpEQBjhNdi7BlUqeVVp
	gwEgXjOUiP09tBEdOmxhGUWIkQyVJzjVZMcMDumpXH9PwiJk0fZCnaYLL10xH9sGd4VHZfk5ZxJfs
	KViJdFH/CCvtUncVRrK0i3LDEM75o2PfXDid0XTGcI0lAQNHOO6ZNaE46MCRgYUM+DypPZmq6j+D9
	Zuhgl5hkJGzZ89m5ggxXLO4X6GFdO/vn3QREhdmziGnkKRcnszo6lZE++W98l2TmW4Dx1PUz7HuuJ
	HmA3+ymQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ax-0000000AKro-1SQ7;
	Thu, 05 Nov 2026 19:31:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39F-0000000AKI0-196W
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B405F60154;
	Thu,  5 Nov 2026 19:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F21F000C1;
	Thu,  5 Nov 2026 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906960;
	bh=Qw513NKzixnVetQs2aPch799inLwFwvqjGlTZsHFgHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WP5zysBlV6QoE+ebdO994NPOQCHtVK69BSl7GA0TkgCejzw4yv+Qi/dIb/BiTtwJI
	 CtwiPcppWeOxu8qxGDLb2NNs4muOnWOkbdTfgMZetnT6EYIraiEzVZgwrSfKYuy20p
	 lq1YQ+ODYgN/fNYKxtV+Y3MBG2phtgSlbN/PnX4DhhLfO11dC92+odtKZZNAdRC5BY
	 cOK2uw6yB5xGSlQ2pqLEJNTrF9NrssiHaYNsRIIVDX79TmltA0T6xLv6ahSmhYnicd
	 7xH40xuqXjCm2XXdHJHYyElfh7nUle5CnSYYX4imcJF/N71eKI1RK/06V3FFapNV/j
	 F1VfvpFqH1/NA==
Message-ID: <sashiko-outbox-199878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 15/51] PCI/proc: don't truncate the position
 of config space accesses
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-15-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-15-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:18 +0000
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

> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative, the check against the
> size of the config space passes and the count it clamps to ends up
> larger than what was written. The loop then reads past the end of the
> caller's buffer and writes all of it into config space at negative
> offsets, which pci_user_write_config_*() pass on to the config
> accessors unchecked. The write also returns more than it was asked to
> write.
>=20
> An offset above 4G that truncates to a small positive value writes to
> the start of config space instead. proc_bus_pci_read() keeps the
> position in an unsigned int, so a read at such an offset returns the
> start of config space instead of hitting EOF.
>=20
> Check the position against the size of the config space before
> narrowing it.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D15


