Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBC606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kYL1kiDX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nB2XodGr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6kdeb8slgi5Epc3AUJlZlnTJq9uw2LtJTfzJG8aoTok=; b=kYL1kiDXDG58nMy9IhhxZ4ka+v
	lT6Q0DcdaNEotFfOOhjiRHPcFCCl7QtJGSQ7k7OhecIwZ284WRRAnLWmoNOQN2CmEPkGqkg2ifmC8
	i9EKtGBvX1M0L1ZOw9dBKAf3y0vfBNpwAaDrvckDkhVQKrIZ8IIyQXOTFHqEbrcAr8O1IH6hphYxs
	t8+AnFA8C0mmxnulRP7wigS1/gNyb99moaEdIjNOafAlDD/9II0dYG0Jh4lMOoT9kC23sfDhVlOCO
	kKl2MHMjNiBrQ8mHrpq1/GR68utRsyE8f3d1v8T2Br349Dg2VlSzyvWEP0QS5kIOgU8S14b3ymJZr
	OZICuyTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FG-0000000AMrG-3TPO;
	Thu, 05 Nov 2026 19:35:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3F3-0000000AMl6-0Sgf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F70F6014C;
	Thu,  5 Nov 2026 19:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B61F0089E;
	Thu,  5 Nov 2026 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907320;
	bh=6kdeb8slgi5Epc3AUJlZlnTJq9uw2LtJTfzJG8aoTok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nB2XodGrsltbbE61/MY+yy8aN79qXnaMrW8LLWpZP+0dzW4JXJ0pwkuPXIFbqI8o+
	 aUuDiq/2IV6LrgueMm0fcGlLznRR27RNE+StoOyZgUUBrn113C9xbA5rh81VwXMVPK
	 VUjsVxMGM3JYpmYf1PTEDk/e5Uf7TRieH5oanj3YbSEWS4MEoLAes6OJHouq9acGzE
	 TUHH7dJOYKuCMwdG4wrNuNFJ7FHrzzaOQAVegH3vF65CM3UFN2gW35V1Z8zXxDuW+B
	 Eq7SEBOj2oNuM5B+HjWikWursJuaXfKRpHoFMZ/wvqpsIgG8z33e9DQBOwbZIzS+yU
	 fbyKBvVlkA2pA==
Message-ID: <sashiko-outbox-199933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 03/23] proc: share the readdir cursor with
 sysctl
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
In-Reply-To: <20261104-work-procfs-core-v2-3-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-3-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:17 +0000
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

> proc_readdir_de() and proc_sys_readdir() both resume a listing after
> the last entry it emitted and each remembers that entry in the open
> file with a cursor of its own: the same struct, the same way of
> setting it, the same release. Keep one in generic.c and let sysctl
> use it.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D3


