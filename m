Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE460A5BD0
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AVYrbFZl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmtyXin2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y9ivFE+8473vLZC4u44E0uCxK4vp/F+9XJkKNyMDnK4=; b=AVYrbFZlrCv+Y5AGySd0W2EiBS
	szniMymGjaa5yR1srsjdiFxMNyvGM/uZb2GkvkRgOSLul4oR/ppaYg+pK9lmOroV6JMi9ZMHtqz2i
	BdG3+BkPqyolSlCEYrF9r5wA7Ue2jOLut7zMwl5ePJSuH9Li4QCwAdUxaJtUVBvSardhdN1uIOwUQ
	ZduK3AIJRhWhPhuAH4t45zbpvn1oQCOaZs9wOGcr6TfZj3NIjtKmY9gFSCUv2O/CvOUmg3lwJUMAc
	3Oq5565rp3gPNhiClPV7U+N2u1JkpUz6N5D6nCZxgbNdG8g2soAXCHDlzrAvDSvShtWbGifPm5y4L
	b6mN52Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI4-00000002va0-0boB;
	Tue, 03 Nov 2026 15:19:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHr-00000002vLA-3gFU
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D6CC4394C;
	Tue,  3 Nov 2026 15:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A541F00A24;
	Tue,  3 Nov 2026 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719139;
	bh=y9ivFE+8473vLZC4u44E0uCxK4vp/F+9XJkKNyMDnK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmtyXin2yjAbPM31f4YaReEle+vN1wPD4L+slbEGaUF6hX4+kf+dRrnuROs6GNc6M
	 DRv8HDwijzmWY/67jIDFKq1BlkuwcODaUmGuLQwnpIvt9LjRoXP9PaI8gflmJ8i3wP
	 c86SuDRl9Wm977S+NSsKVjwbigdIWRtwQE8i9H86bD+J23omOL2nXMQrYU7YT8HPQP
	 GH2X2ncA/tHy+HPvYNSWnLpaZkCBCsb8oTwbY54v5R3heuFMWJyAAY4y1Iwt7Y5a72
	 oJfgpcEoXbI+/0/Hn7wyfvMmS2DTYmtRsWGQMfw5jCqWG1J8Z46CbdL/IgCX7u9auF
	 QiW2pizk1QYYQ==
Message-ID: <sashiko-outbox-195595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/23] hwmon: (dell-smm) let procfs copy the i8k
 ioctl arguments
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
In-Reply-To: <20261102-work-procfs-drivers-v1-15-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-15-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:57 +0000
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

> Implement ->proc_ioctl_buf() so procfs copies the arguments in before
> it pins the entry and back out after unpinning it. The command numbers
> in <uapi/linux/i8k.h> encode the wrong sizes, so the table lists what
> is really copied: an int or the 16 bytes of the machine id out, and one
> or two ints in.
>=20
> A NULL argument fails with -EFAULT now instead of -EINVAL, and so does
> a bad pointer to SET_FAN from an unprivileged task, which got -EPERM
> before, since procfs copies the argument in before the entry's own
> checks run. 32-bit tasks can use the commands whose numbers don't
> depend on the size of size_t.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D15


