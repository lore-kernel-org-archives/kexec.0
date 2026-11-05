Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6FD606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=u2rocRpF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw/WUc87
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VSHZyt2HX6jrf2329Ijyz/9CIcWqtdZcAyFYcq/4Bq8=; b=u2rocRpF0Gprbwgg0O3FjxqrOp
	QeH7nrXn2czzeZn6tqRD9RP3wC5/dV7pg23oMMz81sz9lMqIoR1Nl6gOSsPPvfndjCcdj5DbugsO0
	7oX/GHoH6Wz77LlW5PI0dzhw4gOGz1CUUbRjFvfhZb10KfOuUXskYvK8ljGR/9Ug0NiUU59P7tWw9
	qs4B2cayNmj/Z70v1nxwyHAMmK75JS7z/SIuZixclqylnTCb5knPoJ5aTDuhv5goQPGhsX7H8uB+T
	wmp1KjLhQ2i5vUhA8uxQTVPQhHX6RB/k8W+WUlt6KUy/EJJQ1A7dTvFubQGW074CG3Zzz9EuiefOv
	U8TL9j2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38o-0000000AK4V-3mME;
	Thu, 05 Nov 2026 19:28:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38m-0000000AK3M-3kYN
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:28:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 40E8C6017D;
	Thu,  5 Nov 2026 19:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BD71F00A1A;
	Thu,  5 Nov 2026 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906932;
	bh=VSHZyt2HX6jrf2329Ijyz/9CIcWqtdZcAyFYcq/4Bq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw/WUc87dAK9OgwLDerM/G7Pe9RKageq/S7vyIMIV+dxKfDT/6+AqyOaZ6Fy24Sf5
	 xZ0+NlTB1ife40KhyEO8/2i3RZt4uYwfQUof6r8FI5lnRq/LcyHfWASkm3/MjWrdRi
	 BgQ8a/ZYKTrhKL/NQvAtS4X8/cdEouDrtzAKSt2JTd0adgchhl1YlumOBJltoAEeGN
	 vYbB+LfXceHt3UW6QGLdXHtaAnZDe7rNdeXAjPjeo8fIdhcgFV0G7rwEhhGvDXSfkE
	 wVgK162apTb1SAAInG0qnJMlwH5s5bUi5ICww4nLneNlWhcy3veuvsSne6hkFWvg7u
	 jpKMdfeHfDQsw==
Message-ID: <sashiko-outbox-199865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 02/51] scsi: esas2r: don't copy kernel
 pointers out in EXPRESS_IOCTL_GET_MOD_INFO
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-2-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-2-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:28:50 +0000
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

> EXPRESS_IOCTL_GET_MOD_INFO fills in the addresses of the adapter, its
> pci_dev and its Scsi_Host and copies the whole struct back to userspace.
> Nothing in userspace can do anything with those addresses, and the
> ioctl is reachable through /proc/scsi/esas2r/ATTONode, which is created
> with mode 0444. Only pass the host number.
>=20
> Fixes: 26780d9e12ed ("[SCSI] esas2r: ATTO Technology ExpressSAS 6G SAS/SA=
TA RAID Adapter Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D2


