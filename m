Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D1606BA02
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ARxUIn/f;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpJXKwG4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iYkrqCMK4sFn+IzKtXYQ/U5EAsE/ebvjSwDe60Rgl0E=; b=ARxUIn/fCoanpQ5F0GGgzYk1IA
	XfaTC7Y5TDk/VVybDxjyTBZyDl36w1uV11KC2uhs3mNjgGKWNRm6tjvT7Y3+Chr+1+xulZzcD/gkb
	OXUmxGFgbb9O/POJJHNmcYBxqKR70QyYRLJORrKFgqmRNqqWFx1FTWE0aQ1S09wwzAvbBw3aYB13m
	5NXuZWDlkdTWh2CdOol41EdN6m16h2i0my6DSb0+PgrlsLuVGGXpBASYoz2/ljaX0boLwHJrgxjYH
	mShvFqxdyyg+3rPbXMEIgQBlVEMTh6WR2x0MHiu5o3FqkonDVK6eUXcgTdHOBX4HRTCMDSAXCDbt1
	XcHmdQ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHZ-00000002v2l-3yOJ;
	Tue, 03 Nov 2026 15:18:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHX-00000002uyd-1Swe
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D83B4037F;
	Tue,  3 Nov 2026 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805A1F000C1;
	Tue,  3 Nov 2026 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719119;
	bh=iYkrqCMK4sFn+IzKtXYQ/U5EAsE/ebvjSwDe60Rgl0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HpJXKwG4c83h/WlMOPfbG+pXRjut25QP4ALof5n4perASl+pG0+XdnLAbH2pMqjWu
	 ZpqwtUvq+pwD25biFv2DLmaWL7DlQpG3/qb8VpBOvxd5wqf/4VNn1Juy6IsBSymW7g
	 LtxumV7l/CDvPksMz+J/phWUSoo1dPWSJ9E/KVqcESkpZHFoXwDV2h/RTh/BVVsupo
	 ywpSTGwrOlS88G9c7TocjGL//IsVNc+C80+riS0EcI8W467Qh9hACT4HrtUR2laHK7
	 s3CQWjYxjczoY5WJryXtrQuJdT8nqogkMRxvjIzU1yLUca1vgAib4Yyq8AR2OjsCdV
	 hQ9tAaJMXUQbA==
Message-ID: <sashiko-outbox-195587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/23] s390/dasd: let procfs copy in writes to
 /proc/dasd/statistics
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
In-Reply-To: <20261102-work-procfs-drivers-v1-7-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-7-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:37 +0000
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
> it pins the entry, and parse the command from that copy. Commands longer
> than PAGE_SIZE - 1 bytes are rejected now instead of cut at 64k.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D7


