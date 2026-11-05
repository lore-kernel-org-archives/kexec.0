Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD00606D501
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FCL/IKUJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzU5PbQN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dJAkA5QDVeK6/YrZazgsLWvhYslgluIDFpPpO5CO/k4=; b=FCL/IKUJ7kyjWPpyjOTrVSQjUI
	7sPp+VIyspgk/dW04ZH3VKRyLJDcESjFg2mCRUJF5jrLEnkII0Qan2IHQ/Hu1Xq9rY+VmNxgEnPaU
	9OUt2GBLsbsUowGPms9xSfjje7BPS/yQLt1g4sstewir2R0WzWbl2Ri1bVRSbnzSmTfeDOyP+fFK+
	zPglwZ7BWpcStxwwWr+vyBXL3MWErgMc0qQeA+HmX9CI39sHMGBJV2EUT0E+W97MSuFteU40K1xQE
	RZwlJFrbd96plGSrJXpgUhd9p+BJHhcp26IIKkexlZQVZmjHLgUH2ZQniHTo+VnBsNh60LvsYnnqN
	fjTP12DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3at-0000000ASbe-04v8;
	Thu, 05 Nov 2026 19:57:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3aj-0000000ASSa-0d3x
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96399605C5;
	Thu,  5 Nov 2026 19:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA38E1F008A3;
	Thu,  5 Nov 2026 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908664;
	bh=dJAkA5QDVeK6/YrZazgsLWvhYslgluIDFpPpO5CO/k4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XzU5PbQNrgnaDApRx90DQ4kjNwEFjalsK/Ugt8C3EjiB3qmFHbzDPVH7p+aVkSROK
	 LArRAsXDJ22x/485+7lEAYVBvHAqiC4NExeROUMJ/8LBcNjwuhOeXyTiEI5ODKItgz
	 1bMQyP8cSPHUevmn7qRnsiSuoNi4fuWHl2zoJnC4Bs0UvAx5WHpS5jtBM6XE9CTLaO
	 j5RO97FP06ylY1GxZsrhdwk+ZF7ItucHGlLlkHWa+hzQl/cVo2nlpvqWJVWEQt9jY3
	 FMBU3XpGo3NVyebaz9pnGaoAmod+c0f+r+TtQy5pQYpdK8w0ADpee5Gqfe4XRpus4m
	 rcvgDpQhA1u5Q==
Message-ID: <sashiko-outbox-200041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 07/30] ntfs3: let procfs copy in writes to the
 label file
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
In-Reply-To: <20261104-work-procfs-fs-v2-7-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-7-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:42 +0000
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

> Implement ->proc_write_buf() so procfs copies in what is written before
> it pins the entry, and set the label from that copy. Writes larger than
> PAGE_SIZE - 1 bytes fail with -EINVAL from procfs now. A write that
> large only ever worked when most of it was trailing newlines or came
> after a NUL, ntfs_set_label() refused a label that long with
> -ENAMETOOLONG or -EFBIG.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D7


