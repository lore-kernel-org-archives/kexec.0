Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEE606B07E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cmSzr2Z8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBygoTPe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JeUycd/X3QAMjGkbWRWLv0JHcDa8SO4ZWx3DOn9WWrY=; b=cmSzr2Z84APsc8Ys10uZ11Lw8u
	prX0gO087BpTzMjncJZwJCd2cZ6Q5B0Efj2nUfQghQ78AL2h+P2B0LiRgiSc0ijAAI/BmfCbzJzQg
	M9x2YJ/ZIA06endMUtl5GgP4PL96QofYBJThWAZiK/vItoMByZu5pKOnGTuTKK4Pp6LYZVQkZjm4t
	Ui868jeJeC2RzK+nvaXmQg+G6uMSODq9q9P1JXOzM+kb7/LbCkSur3AiOmi/k0PWF394y1isLyVQq
	962oL6rffH0TnYcXuhNp8Q/KYy153/FplRYlvVRJB4lsqzKMwWDedMLXJxQ6BCeOI16HOanp45jbR
	es29YsrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bL-0000000ASrr-07e3;
	Thu, 05 Nov 2026 19:58:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3as-0000000ASaG-17TX
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0339C43F93;
	Thu,  5 Nov 2026 19:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D81F0089F;
	Thu,  5 Nov 2026 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908673;
	bh=JeUycd/X3QAMjGkbWRWLv0JHcDa8SO4ZWx3DOn9WWrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KBygoTPeNolnWEgh8FZs5ViL8Ujmj1WIczSN75XrmLLh8kxMZe5FC5un7pt4khl8d
	 l4f6yhPiJz5zYJe6v+theCb/axVS5RhhYpA/nv5uABjed6cl1Mr8W6vE600aMtwosP
	 u4FzF41WO8SF/z4xVZPrPsrp6oS3edw1bsAa24GmArUDG/OmO3HWmGKoqxCRecln5T
	 w/jecDwFPd24gj+Adp9XEXQQ4nRKmS0imJl4W9dPNxrIMthUNIeVg2Mj4azykbTMn2
	 /UdBPkx9cGZLnkh5r61yrqDUrLdF3g7yYI/unhfTHGXckCblzOGUY+7vDs6k0zETDK
	 KyT+vTJP4O6UA==
Message-ID: <sashiko-outbox-200046@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 12/30] locking/lockdep: let procfs own the
 seq_file of /proc/lock_stat
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
In-Reply-To: <20261104-work-procfs-fs-v2-12-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-12-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:52 +0000
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

> Declare the seq_operations and let procfs open and free the seq_file.
> ->proc_open() only takes the snapshot of the statistics now and
> ->proc_release() frees it.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D12


