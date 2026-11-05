Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EA606C893
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nwHtbWok;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTpjODs1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qyGxYG8j9RHg2vyof7KTGe46hg815xlN1LVcZ72aA7U=; b=nwHtbWokFo35RBDNGxCpXL1khr
	LolSOjhtsEN5ycyA/BJHa+JW0XMMAEIeOxepxTUozak37osHC4Ejy3cCxKT9hUXyeVxolE7eV9jZT
	OFOTXVp/jOr8cIsw3AFgqftKrGvEthPvWxMIYHT+SOexfgjg1188wrphQo754bBJCVsIU05DAqiPx
	AY5nrNb7IR6yasC3avSXuJQynDxoWRsVnmP7jystuBUwZ7jx3Xk0h059nSAIsin+LOTx9oCjAeBmA
	11nxtH4k3pSTgClu+La4Lbou0rN9phZGJGfV9n6Sn/Xhah6W5MQ+5wqJKm3U6HA2+xDwS8YMxEtEG
	jyLAT1mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bn-0000000AT8T-3hEg;
	Thu, 05 Nov 2026 19:58:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3b8-0000000ASl1-0mq5
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73ECE605D2;
	Thu,  5 Nov 2026 19:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5791F0089F;
	Thu,  5 Nov 2026 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908689;
	bh=qyGxYG8j9RHg2vyof7KTGe46hg815xlN1LVcZ72aA7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTpjODs1yFu6YRN5fmCYLdyRvgUUVxxbu846Aeqw4iGqXmWrXiCiCnYZPXasoab4i
	 WJUixvU6EfxiEGSTH8p5m6geOsF2FwabLkl8QCKrLRihS90PkxPQvXsImqBoq6fFpI
	 zXPjdUBvvvwz66/+OxS1xiVA7RcTezVhvc4GfvsAwAc8LsSQy1bEWSsOcEBB4lRmfo
	 ocuNeivszTUjoQ2nmvR7p2FOnQgUPyilwusfSiwQhItw9JJ51vQ6W5SqV4sXQcDH2n
	 B5Og2Tn/U2epxnQVrz5GgRaNh5DnwOIPoDojQJuxrNePqy32coheNJG3FyfeA33AJQ
	 zsiW5uI6//0Dw==
Message-ID: <sashiko-outbox-200053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 19/30] sched/psi: mark the pressure files
 permanent
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
In-Reply-To: <20261104-work-procfs-fs-v2-19-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-19-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:05 +0000
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

> /proc/pressure/* are created when psi initializes and never removed.
> Say so with PROC_ENTRY_PERMANENT, procfs then calls into them without
> pinning them, like it does for /proc/profile.
>=20
> That also takes care of a rule the files bent. psi_write() takes the
> seq_file's lock to serialize the triggers. A reader holds that lock
> while it copies to userspace, and now that procfs owns the seq_file it
> does that with the entry unpinned. So nothing that runs with the entry
> pinned may wait for that lock, and psi_write() ran pinned. Nothing ever
> waited for it since the files are never removed, but with the files
> permanent nothing runs pinned at all.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D19


