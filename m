Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E31606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HthU2TK7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFkFtso3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bT7cdtBA3g4ZjNdxCADmBOubkwzRkbH+TQ0hoqO6tiY=; b=HthU2TK7suDXErz2OI9F1zvhPd
	HIxxqS3szPXqTWV/O1hvCiTZ1gB5zJCtFIXavdMW8IDNs+YPOYsoS7LEikKBPah9y0bpCgCK1VTgq
	amMI32XHhrNWNsLVVxFdcT4h6nMuyJiBwwMdWkr7jvoGNFGb6hWVQ7PlfeOF+3xBMsGoM1PfW3x5x
	9jkk3hwj46561wnYSsqRUWyQvaUndBzWK1mkOvQ19tdixDxZtu+96gIZwuz9t3dBxGoECHvOQYDrk
	oIeohToCYCLh6+WxjqimnJwwnLB19zXPlzlsEH13DicRPqsmIXWT16t6tC2F8YSm6URhPPh9LAh37
	K/AOG4aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Bj-0000000ALTK-0Fmr;
	Thu, 05 Nov 2026 19:31:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39w-0000000AKhM-0KcN
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86072601C5;
	Thu,  5 Nov 2026 19:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551AC1F00A17;
	Thu,  5 Nov 2026 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907003;
	bh=bT7cdtBA3g4ZjNdxCADmBOubkwzRkbH+TQ0hoqO6tiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFkFtso3C96AnTUnqfat70nSvPWig/+mlWw5M0UhnuCp5QJxgxNGQrORhQlrQkJ/y
	 hC3IYuBkO3IUK23KYNgrztoNyDYmU4MR+D9gL2C8VjvK7vkMSvevOunoGmfWD0JNml
	 vsF9OIiPC1HM3aRMk6Mbu6p74Dq5+9CvuKroZEovRvm/WILib1QicWaO1x2FWXQ/Gh
	 4URR7CizufYYPnmywgHmy0LbSoLzZeP9pgnBeUiBSkH3rjb0o92yRGCn9Np6O+kLCX
	 Go0H2HcVBVV+M9zicMMj4k9ffVIUnGBdI26ePeddA9J3Se+pxAShijM1YnU9ctvKg+
	 O8G91Qj2o2VRQ==
Message-ID: <sashiko-outbox-199899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 36/51] proc: don't let NOMMU map procfs files
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-36-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-36-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:00 +0000
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

> Every procfs file has a ->mmap since commit 786d7e1612f0 ("Fix
> rmmod/read/write races in /proc entries"), whether the entry has a
> ->proc_mmap or not. On NOMMU validate_mmap_request() takes that to mean
> the file can be mapped. procfs has no ->mmap_capabilities so a regular
> file gets NOMMU_MAP_COPY, and a private mapping never calls ->mmap at
> all. Instead do_mmap() takes nommu_region_sem for writing and
> do_mmap_private() reads the file into the copy with kernel_read().
>=20
> Reading /proc/maps takes nommu_region_sem as well:
>=20
>   mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, open("/proc/maps", O_RDONLY), =
0)
>=20
>   do_mmap()                          // down_write(&nommu_region_sem)
>   -> do_mmap_private()
>      -> kernel_read()
> [ ... ]
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 786d7e1612f0 ("Fix rmmod/read/write races in /proc entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D36


