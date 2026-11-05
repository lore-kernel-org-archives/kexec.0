Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2B606D813
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1PLLRCGG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+xOHoP2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cJix24xlgst9n1WrSlWeglZeAB5lHupKhKyXWNZp4cA=; b=1PLLRCGGdRPshMrXF/U9dBiTlR
	Z0hL44TR5NXSJTXIeRFRYr8VX7X4wWSzvdlfqJMnVSr1pM5oJIrJD/ceA0BCW0C/X/p0doam4blLI
	2FSprsqN4zOYcU5Chs/kqyWFGHBB1ekB7+c9Cb2ICsbA1xilkVqeSRm0dC+OZqXjTF8vf1jPE/GaZ
	BpqxHo5x8VHkUVpv5XuI4J93kNqubFnJBfNlXnkIU32wtjcBtNLUVn7n5mSK8dQu7m+xZEd2S15au
	oGUdlfjEk3T1QHV//eph4h9Ks1D/cRL1pwkIyZPugSl0CyfCkEbsfhNKUvJuzNJykFzgmHhB5YSSE
	NWThnNgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Gj-0000000ANSm-1jNB;
	Thu, 05 Nov 2026 19:37:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FN-0000000AMxt-37j0
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 809D643E8B;
	Thu,  5 Nov 2026 19:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9761F008A1;
	Thu,  5 Nov 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907341;
	bh=cJix24xlgst9n1WrSlWeglZeAB5lHupKhKyXWNZp4cA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+xOHoP2Qx5/9+jDvNfdYODhXjxiK8RqXCJAGAloJ6qzD7Elus2F01gxdiUGPSQLg
	 3hE59XNDGx3Za7IV7IDFhB9LofEWxPBNwNN/k2HxtiMoqi+Vht+upRCGoGgUOFkH3t
	 K7IF2X+TmYn4ZurNmoxh4WyCS1bWuRxOE2FTEP388C89fXUcunpJ8ImJUn3klOcRfi
	 1QcyMSKwSstZGjhnH3nI7Wpv2CbW+x291Woe+gaojDGoMmhzCTYy/uDNTr87TxD1Wq
	 B6dVO0t+pEqWn986xFrR6AlFJZfPthvQSSC5s4G8lgOL5oeFUjLAQkfCfoj1cM0Jd4
	 LCM5TqqMHZEYg==
Message-ID: <sashiko-outbox-199943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 13/23] proc: let procfs own the seq_file of
 /proc/stat
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
In-Reply-To: <20261104-work-procfs-core-v2-13-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-13-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:39 +0000
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

> Declare the show function and let procfs open and free the seq_file.
> ->proc_open() only preallocates the buffer now.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D13


