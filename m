Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B60606D82B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T/wG0XkC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jS5u1c3K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Dl7+6TE3klHc2brN+bZbN2jvo5bJeOK9y0vggKbBQEw=; b=T/wG0XkCkWIbGYgny7smv90X+e
	Ghs4Z8B+5cc+60N+bLXd+KOQ2LTjVaUqAw5uqc6GPBQynQjOIFMVgltKdS/gT3qM+zyFkfTY1xyLV
	4nOD5ediMSajWKzojqsUPNYXtIC9A2nF95rT81cWHnigW+sL92hXa/MoHROz6wQ6DS5nGZCIV1hpI
	TvHU8hiRwNH3uytZ2LlIAJ37K3hnhegRbc+xbtyRd8n5WEb5HSkallxaWB8EgI6lx14b1DorJKc7Z
	Md0zqRZhnAZLye7NDu6hdgDyObNFWK7jR7qhKNDp7Bz/E9x/YKkTxCYML6atJjrL7yC0P3xksPb9N
	LWNcN1ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38p-0000000AK5L-4AJB;
	Thu, 05 Nov 2026 19:28:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38o-0000000AK4D-20CG
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:28:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 25F9A41643;
	Thu,  5 Nov 2026 19:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A841F00919;
	Thu,  5 Nov 2026 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906934;
	bh=Dl7+6TE3klHc2brN+bZbN2jvo5bJeOK9y0vggKbBQEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jS5u1c3K7ImMy0Crh/Iyk2SB/21MWY/WEpvgJVP8JqocmivL2vqyijNAqT7WiHjiW
	 6Ua6xCh3Ij5H7KLcgaQqR8ixyHADZco61udOB+jlfTExiv59U4z+85rPVir6KFx0I1
	 ObSC7TmsTyRLViUk/SGlKk2mUSVLDinXNea60PUpTBUb3+Z2hC3lUIZS8S2tOJbqUr
	 AKLtI1OGNz8Uwoag5jqRzukuHqTD25SiOWs27vYk4NAWf9jGI4TCW+iBo9EUmmHNnG
	 9mVPo4N3xUODMaacXqbONIqxB5Wjo2lV603RHlVY2XtZFGaIEcNZr1t9RV/1OvaXBn
	 v83WwqOK20reg==
Message-ID: <sashiko-outbox-199866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 03/51] ALSA: cs46xx: hand the region to the
 region proc files
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-3-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-3-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:28:52 +0000
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

> snd_cs46xx_proc_init() stores the chip in the private data of the five
> region entries, but snd_cs46xx_io_read() reads that back as the region,
> so a read of /proc/asound/cardN/CS46xx_BA0 and friends copies from
> whatever sits at the region's offset in struct snd_cs46xx instead of
> the mapped registers. Store the region.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D3


