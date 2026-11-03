Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745F60A262D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xCeQN3Ek;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLM25BCG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Jt8oSnDtjWT9Rc1lRRQoEdIpZQuLDAxwiZiNGREGvEU=; b=xCeQN3EkJgkNmjvDuszKYvV9jc
	Jfdkcmc2s/bKWvVykLzFDHpvnI2RdyZAZ0O4qL10NRkuLAsFatDcn2Or5FLg/EnQijc/3m5ypwMd2
	DBHtuIsmd4PO/rWYbnyWl8a7IJuPupzdMn2L+c+cGVHBv5WObeHsMqButh+TiJ1gN3HyXbCRNvAQn
	jErMCKDED2tA63oQ73Tsxhmv5neqN+XWuffVTMx98iw4Zgjfc2EnemPZT5KtpaNDUIIDcWOpVr2bR
	VmCsvZrttYtXwO5OSvNS4tgC18W+nAh65nfw5w8ujOOi3B11p8iJw4tqGrL4j3b5lrDlFUzlpFATK
	rWXYGxdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFo1-00000002lAe-0Pt5;
	Tue, 03 Nov 2026 14:48:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnu-00000002l0P-2yZe
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D69B60626;
	Tue,  3 Nov 2026 14:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D27A1F00919;
	Tue,  3 Nov 2026 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717281;
	bh=Jt8oSnDtjWT9Rc1lRRQoEdIpZQuLDAxwiZiNGREGvEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLM25BCGsWNuNmJ/K9N1vryFmClM5QGd+w1e7Y/oABSSzjVbQNzdV0AlPqiqT/BZz
	 gVjtej5uWjivTFNRb8niUA/AaCtVvzYTNAGV9gc6Mg8Q73DILuzBagqZP0YjlkS4ok
	 8a5PyM62d8H3SaSHls5JF7e6qN38DCKSnLe90TyyDShwSeDWLcnDwqx5NCFzJREoSZ
	 fYkFOlYBmIxCnw6DQBk3StfjM1WgHAjuKa+F5YHphYcUyb5by0bUB2nqkyvRC6EwmM
	 mLR9qu9/cElVYgf0F7Xq0FERhwAIiwGHNA/5lHothanOlSg0abydegRnPFqWsonMYV
	 SucZjZpZ0qt0Q==
Message-ID: <sashiko-outbox-195489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/38] net: pktgen: reject device names with a '/'
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-17-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-17-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:59 +0000
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

> "add_device" takes a name like eth0@1. Only the part in front of the
> '@' has to name a network device. The rest is free text and all of it
> becomes the name of a file in /proc/net/pktgen, where procfs takes a
> '/' as a directory separator. So "add_device lo@a/b" makes procfs look
> for a directory "lo@a" that doesn't exist and warn about it. Any user
> can do that in a network namespace of its own:
>=20
>   name 'lo@a/b'
>   WARNING: fs/proc/generic.c:174 at __xlate_proc_name+0xb1/0xf0, CPU#3: b=
ash/241
>   Call Trace:
>    __proc_create+0xd0/0x9b0
>    proc_create_reg+0x45/0xf0
>    proc_create_data+0x77/0xf0
>    pktgen_thread_write+0xd8d/0x1750
>=20
> With panic_on_warn that takes the machine down. And if "lo@a" exists
> because somebody added a device of that name, procfs used to register
> the new entry below that regular file, and removing "lo@a" freed both.
>=20
> Reject names with a '/'.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: e6fce5b916cd ("pktgen: multiqueue etc.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D17


