Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5A606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lLO6oWbo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOfP7Od+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cpvz9ZtguPBJKqyMAgbWcY7C2hCaojY5Py1Q5FojWTs=; b=lLO6oWboc4aKdFp3a+tSC7NC5w
	rf0ow9TXynLwisJx5dLMzTLTVh1Qw/dgH8cD/eJGX+xqHE7WDCF6+6YQ2P5tKODcJmM5APlWpC4j5
	uoHyLP28fmPYyd65/jILy5XXLD3N5FhnuE8e+JMeQ5ZE51/NEj2fe+pXlBtqf2+7+/CHrqEX0jyUK
	6SCeqi6DcvYjLxCdw8XUO0IbRI/SRmCi9RDd78uu7j6SxT0IuHgRgFYLcZ+Dm5w07RodcBiMEo7RA
	pxpH5sF+thRfqDcapDCgWTkVQFjE6AeCUhO5SD1Jc4dj2iJE+hnF/jXVlLFd12idCYwIbndKRwyb6
	06z0Mm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ay-0000000AKuR-1lkb;
	Thu, 05 Nov 2026 19:31:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39R-0000000AKJf-12Sj
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B181A601CB;
	Thu,  5 Nov 2026 19:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134461F000C1;
	Thu,  5 Nov 2026 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906972;
	bh=cpvz9ZtguPBJKqyMAgbWcY7C2hCaojY5Py1Q5FojWTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOfP7Od+3tLJPOZc6sJbk/iLsFM1pPigpKtu4EQBqXBmK4HkwMVGsC2uatKkm7neV
	 EZ4GcLTMhwZ+sdTg+l2zRyMfToDRW4O2bKOf7mCtsJMA51Ax7pZjywuAfUHV7l60zK
	 Sq/7GgR7KGam9IZjFxY6zw2jbOAXhkbhSEU2lGdOVZHC7JPVzuBeZnUlY5cQtQQYdl
	 iiukn37YQzkrqyS1hBEVPe7zdS+O4S3+0pn1wEE9gINxcvysTW1fGYhITb0tpHtKwa
	 cAg3ROO4tJ+Nh87XueHg8st2idaQa151qlYERsBEmm8rL/XGHPNW+Z4eSSH/K5f+18
	 l7+JcMjs+vnog==
Message-ID: <sashiko-outbox-199884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 21/51] powerpc/rtasd: zero the error log
 buffer
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-21-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-21-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:30 +0000
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

> rtas_log_read() hands out a whole slot of the error log but
> pSeries_log_error() only fills in the sequence number and the event,
> which is usually a lot shorter. The rest of the slot is whatever
> vmalloc() left there. Use vzalloc().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D21


