Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A6606E43D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Qsa0996;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2ObnK8J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MzwEajn5EQQ0Ibuj4NNySLRm5jpl51Rmvl6LxJvcYPc=; b=2Qsa0996nX5fDLOhJ3+xaw59Cl
	SgnD7Y5tyDksNWUekthw59IXztl4itxbbocaQa4tdJoDWcjSw2N9aj3zZrqVCRRrA5ql3MpZIE/wR
	3JsIwhrjDIRvbB997EHEvoueFVLOfBeU5RseTgD+K1DtV1EmjyCnGrmHSJHuCOqAB4kXjVWYFYLA7
	waxpkTudwBmh+9QGl82YvnlJtHPToCvJV/zvGwIaMmhzkwDLY8LU9OZyC8iOpnHk5qFgMa5JOKJGL
	gQBds7UMTw4QfCfvVp6GEHldu0MXdQWUyIvaGyVYfTz/H/n9P2kLyXWrXMqamp4Ib0HlOLljjKRM/
	Ilp93JCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bI-0000000ASof-3ajJ;
	Thu, 05 Nov 2026 19:58:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3am-0000000ASVQ-2OoI
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 559A3404B6;
	Thu,  5 Nov 2026 19:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A547A1F0089F;
	Thu,  5 Nov 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908668;
	bh=MzwEajn5EQQ0Ibuj4NNySLRm5jpl51Rmvl6LxJvcYPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2ObnK8JRINAflJyKIXSK2w1/pSi8u0iSg/Cm9cXg/GKcCS3V5T3ETX6w/TXIgGXx
	 gdgVtIYSN2JEUxzaneOepIMQQZ7VLzsMP0Y7hbLLwupBmIcMyyElFV+gIO51zr4uMr
	 TQCPiuRqepME+qeBElkRBw7GR2h1SJgr4RWR5IqIOeRAzmyo1SoD3423ujzAceCZ+2
	 cJaFGGjw8nxcKkQ9Jlfoucsu0xvZpakmHDU5mBr8gpr8AFrjlZvWEbwak7GxPsVTvG
	 uel1QhMad+WBTXzIAKEerBzEA9SFbbSpWXd3k1aM3Lznnt4WSnG+vs9iYwjubuAZgu
	 1x7l6iw5jmWmw==
Message-ID: <sashiko-outbox-200043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 09/30] smb: client: let procfs copy in writes
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
In-Reply-To: <20261104-work-procfs-fs-v2-9-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-9-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:46 +0000
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

> Implement ->proc_write_buf() for the files in /proc/fs/cifs so procfs
> copies in what is written before it pins the entry, and parse what was
> written from that copy. Writes larger than PAGE_SIZE - 1 bytes fail with
> -EINVAL now, SecurityFlags never took more than 11 bytes. Empty writes
> to cifsFYI and dfscache fail with -EINVAL too, they looked at a byte
> that wasn't written before. kstrtoint_from_user() looked at the first
> 34 bytes of a write to cifs_debug_dirs and the smbdirect files, now the
> whole write is parsed.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D9


