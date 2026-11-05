Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB8606A32C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wo+iYWtv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckZU7d4Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GA0+/owkDdniY30l313rN8euuBjyhEchmg5u4LglfRs=; b=wo+iYWtv/bjWqKjRcynbrPlW8T
	nQRMJQVhi+iLP4uYb3txRYk7KWWzNMNmPc9Av0HtZ2yuGvrI3bKo4WOaUkv8peJFmaLsS1WcU8T8t
	SGgMIvJ72ijHZieq2tD9yd3WV5MWLou8fG6XY4fdbX70Ey9Vx6D2p2CgBVc7caceL8jPoi9volyeR
	shIMUIpJ4x/f5I6zFFTZfWh4QhhhtFQV+5VRzfOVZyfBHwWOodVbVDK4th93A0HRrdPrRJHlbLUfp
	tZ5x7e7nzzPZaRO5wxZu6xb4n/T/hWIv7liY60S5yJHs8L5QXKplUuL9Vxujdk9ndHKtdzvUfYbW9
	Cp562Rkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cr-0000000AM4P-0Kwr;
	Thu, 05 Nov 2026 19:33:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AP-0000000AKnY-2hXy
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B40E601DF;
	Thu,  5 Nov 2026 19:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472581F000C1;
	Thu,  5 Nov 2026 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907032;
	bh=GA0+/owkDdniY30l313rN8euuBjyhEchmg5u4LglfRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckZU7d4QUH1rI3q+4mXcCPdzjI6S3s0l6AJ0++PpkI/VthC4KY9jc1TUbXEy7w09a
	 QS42jHvzTWmhpuR4sNrCVakO0luPXYf1Pep1PJq3hRlnM+G5j7LV9MiNuMbPYmYvh8
	 szoCOMpIPlXI4pmYgqd4WZv3emt2hKmkx/g4Acbw06/hy66OKKSy4eyXseR+7sXoS4
	 h0IZpdjtLDWYruhg3kAkHHame5PmfbBbyj3BLPwhrZvYj7hO9dMH7e37xj2nGdqfxY
	 8c7pfm36HFDGPa1muEyl/868i4Nqv0yBIOEge1rhlL08kefXVk1eQWlAc5aoAoUcje
	 mrqw0O6Z+CNMQ==
Message-ID: <sashiko-outbox-199913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 50/51] proc: don't pin a symlink's entry while
 readlink() copies it out
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-50-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-50-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:30 +0000
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

> proc_get_link() pins the entry with use_pde() and the delayed call
> unpins it. vfs_readlink() copies the link to userspace in between. So a
> page fault in that copy holds up remove_proc_entry() just like the
> copies of reads and writes do, and the callers hold locks while they
> wait. /proc/asound/<id> is removed with snd_card_mutex and info_mutex
> held when a card changes its id.
>=20
> The pin doesn't keep anything alive. proc_symlink() copies the target
> and pde_free() frees it with the entry, and the inode holds a reference
> to the entry. What the pin does is keep a removed symlink from being
> followed. So check ->in_use instead and drop the delayed call. That
> also takes an atomic pair off every traversal of /proc/net and
> /proc/mounts.
>=20
> Fixes: 7e0e953bb0cf ("procfs: fix race between symlink removals and trave=
rsals")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D50


