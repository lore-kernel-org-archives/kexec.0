Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FC606C85A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LYfIk6AL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh72y6aD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YPSq1R8mvv3m/ZWA/l/xhrxB9LISO8x35dE2LzyDV9A=; b=LYfIk6ALMoX9BPyZDFkuqOdd9d
	U7T/MmFYvrZZxRzD8BoB3YWH7E4WkmTrYMIWfwbnldlIh+m6SvkwffU5cmB8+bB32It3zTuNkcCLV
	4g834mvQVDNzItNYwSLInFgJVqxeHv+aJEtoDllEE1FYomFiCekjlAkhOE+gMMLh20u3L6kakny8l
	2iazv7QEbmws50+FNOwJtjl8igpc1eIHTIBVCQHPC2eHXeptP5YdGAgXnGl/KI5bopkbdvaLyAB/w
	EUXe3oytqYxk0pP/naaDgiOsGtMIOCwsF+Hsoq1u8lawEIxHb1JghPUgOMHYW1Hgadv+Slk0CyVsY
	VX8qm7PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoT-00000002lkv-1ePo;
	Tue, 03 Nov 2026 14:48:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoO-00000002le6-1E0l
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8BCD609F7;
	Tue,  3 Nov 2026 14:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FC31F00A15;
	Tue,  3 Nov 2026 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717311;
	bh=YPSq1R8mvv3m/ZWA/l/xhrxB9LISO8x35dE2LzyDV9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oh72y6aDbLhFaPXdBI2yRygfRhwg2WDjGU9Aug43O88w0qr0cxbFG4trwNS0j/8Ev
	 r3EdnMEC8dYVFGPL3Wcol2YUeQfOLab3n/En1SWiK+eGFj7nW7qcJjXcKvZwh0bzbV
	 RNoz4+GhaJ8KyC0GD8TuMTV2UnfppqTuBq2YabUDkZgm0/NdhEq9hKM9qswXM7cQIV
	 3840K5dlCFENAoaul71/Ny6o5tT8/kxIu/OwJtSVoult59fuGjHPNvvwTaeLvVLhWe
	 WiVKYH1JDAxg78SUefAwd/eYv47zsNpa3fqoONjQuFAGyobDs9zKSbT6KgrEXQYbJS
	 oTCDW/6YY7CWA==
Message-ID: <sashiko-outbox-195503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 31/38] proc: sysctl: resume readdir after the last
 name it returned
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-31-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-31-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:29 +0000
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

> proc_sys_readdir() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is registered or unregistered in between shifts
> everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
> buffer that holds ".", ".." and "all" and registering a device whose
> name sorts before "all" makes the next call return "all" a second time.
> Unregistering one that sorted before the position makes it skip an
> entry instead. So a listing that takes more than one call shows a name
> twice, or not at all. Even the 64k buffer of ls needs a second call to
> find the end of the directory, so a device that comes up right then
> repeats the last entry.
>=20
> So remember the name of the last entry a call emitted in the file and
> resume at the first usable entry after it, like kernfs resumes after
> the node it stopped at. The entry itself can't be pinned across calls,
> unregistering waits for that. If the position was moved by a seek in
> between the listing counts from the start like before, seeking to an
> arbitrary position has never been better than that.
>=20
> That also takes one walk down the tree to resume instead of a walk over
> every entry in front of the position with a round trip through
> sysctl_lock for each of them.
>=20
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D31


