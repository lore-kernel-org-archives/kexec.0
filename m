Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEC6083622
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KdcGh2e+;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+3F0H5K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iYYDAQ4EAaFTojHj2S/IS/DlVIcz9P9xTbXP/dOtwJQ=; b=KdcGh2e+MSzhES9EPAyByaqy52
	Rwa56hhM0E05/GNYpd2mHmeMOJEefboQoZwoCEPXRRm3Ap81WUVRm07g1HVittCQI050f2HkfrPPx
	/Or98iRicjj0W+vFSuWNAcLpTSTnnTjLClyfyXgmeLmdnZHzZ4tJHCAcygPrRvTUXU0+1nnwgpy7K
	um9iNmp7XqV1XaPBGMTtybVQSg0Xc0TlLQ+/9EpM2yIme5ZFbFFhLmf7i6xOoZ1100JpqyHcp1ONf
	skdK0JiCFvMjClrXBnB/Z+ycdsnOEwgxkA/SOG8O8BBlWnp/Fa6aKF+Ruf4p7k0Qgkxz+/TEB6JCP
	90hrKjRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHq-00000002vIw-1vpv;
	Tue, 03 Nov 2026 15:18:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHn-00000002vCp-22yS
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E47EA60A54;
	Tue,  3 Nov 2026 15:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BC1F00A15;
	Tue,  3 Nov 2026 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719134;
	bh=iYYDAQ4EAaFTojHj2S/IS/DlVIcz9P9xTbXP/dOtwJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+3F0H5KbEJBZo1I24LPwaX+Na4LHasmV3v4LtadaUaTQD3umUuYdZ8ca+KGfkDAP
	 qNrBUn7y9LjD/oybvflZdkENEKMguqn2R1IipnoivrEj21pGQL6d8oVnm4Wp6n41QG
	 I1WY6ZGFPNQVGJvuZZ2fT+xSlwX5FrZygE0DGw1KiLlprDoSQ68MdVoXik0agD95Df
	 YT883GFnPCcBmGGBRCDtBQan08iKSCeJT9s0may3cbwXZTQ9qXWgpU3QOTOqeSphOQ
	 RLFiG9EFcDDjvp+V5Qc+pKgtdVL7R/TU5Ji0CHKr0CSHpBLxQSyDoBcXjRSt0XfCLc
	 ncHjXD9/H2xIA==
Message-ID: <sashiko-outbox-195593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/23] scsi: sg: let procfs copy in writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-13-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-13-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:52 +0000
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

> Implement ->proc_write_buf() for allow_dio and def_reserved_size so
> procfs copies in what is written before it pins the entry, and parse
> the number from that copy.
>=20
> kstrtoul_from_user() looked at the first 66 bytes of whatever was
> written. Now the whole write is parsed, and anything larger than
> PAGE_SIZE - 1 bytes fails with -EINVAL from procfs before the
> capability check.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D13


