Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC4606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=u9QSvaJn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=biBcQDj6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b0D2++zCZfvjhjRkeCHIgJAL0z7V717Ngy6s2m74N7A=; b=u9QSvaJnYF6XzSJQUVQuCpWlc+
	nJeR2x7hTQnaLNyMdSBlvc2b0QkbQ5zMf1W0/XTQsFLDilPtp2rJQ4QC+X6JDdvgsHX2kEEnT5qv+
	orBASqVQb/M85qkZtfxiS5OZ1rUIlWSG4qAfevNRowuf23mDpciGmz7daDlPQqb0dQuyRx/Hh2WcL
	93vy2HjMCgaU50FpGTZRRSjP8FPt3btNktk3FfEQPORzmWXPGsPoM2fTMzO/8uy9mdkR0Hq95619z
	hC7sZU/3B9y2pkzM181NqNPl5ICE/rYpEz5Ac1tc7cXbHPy7GJh66kpNBN1O8843bM7nL3xOc8KV2
	anGsSPnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Bh-0000000ALQl-06V4;
	Thu, 05 Nov 2026 19:31:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39t-0000000AKgm-2CrA
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DF957601C8;
	Thu,  5 Nov 2026 19:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDCB1F00A1B;
	Thu,  5 Nov 2026 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907000;
	bh=b0D2++zCZfvjhjRkeCHIgJAL0z7V717Ngy6s2m74N7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=biBcQDj6b5nEnEvvkhlM1t3pYvLEhlUmJZntrNj8PmC+/8S7e2GAV4U2nJtkIt6lm
	 w2reHjBlHUvRO7ufKHLU/cu9NIcrdZS/QNsjkkcCIQtudOdeNiZ4gnIuiWj1EUhsA0
	 wLwuee7OSv/L9MLY5Dk1FPdohxJpgBQjXWFtlVWYc/tV5I02GkwXABkE4xEQP+YsBd
	 SN1S/9tIP3nfP49YMFvAflaO2LH8vRaKR1oZ0flajKfd6e0qH53GoNxOVYF79PgSIk
	 +HT6s1etrrUyTiCOLvoDd6TEvKEM8PctNC/h2qlEO/MtHh12Lz0HvVTGM1t9FKNGsl
	 udtTbvU8PQXXg==
Message-ID: <sashiko-outbox-199898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 35/51] proc: warn about entries left in
 /proc/net of a dying namespace
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-35-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-35-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:58 +0000
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

> proc_net_ns_exit() runs after all the other pernet exits and frees
> net->proc_net right after removing "stat" from it. An entry that some
> pernet exit forgot to remove is left with a freed ->parent, and so
> PDE_NET() hands seq_open_net() and single_open_net() a freed struct net
> when the entry is opened through a file descriptor that someone kept.
>=20
> There is no such entry in the tree that we know of, but nothing would
> tell us about one either. So warn about it like remove_proc_entry()
> does for a directory that isn't empty.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (=
v3)")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D35


