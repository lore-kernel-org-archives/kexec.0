Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD6606A33C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iOETz2xa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lowCxpM8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gJEjJHr+63DkRgcn2DucJbOp2pD2WNeYTaMSKLiQVEU=; b=iOETz2xaXY86rmQHDpHrUUd6OX
	7ct8OSs5GjN5qPn3bnWeehF0EijBgbV1YmT9SckwH/gefUlrQwwQNPJvHQog1xjddOvIABTsGI8DZ
	dCYkS2Hu4+6Tjz6KP3Yeb6+3GMC9dAWfV9yV27TX6K8BTS/dD9WehZ+SleAj+/vmGpZUIeFZDocOF
	jTK5yV+fDi01DWZg1TZ4beGZtUmml+lc031nvy+0Dfusa06vo6bIZNmkoxGGTUA0//cYQKmzUTW7F
	V8J2Qw2BrbaFxvRjRTH8g+OEkrrBB8Cok4vXOmLVZEPyQaC5HgMhVJP9Q7lNqe9BBxe9tY0is8sxc
	K8LJ64MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3GY-0000000ANNC-1I6T;
	Thu, 05 Nov 2026 19:36:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FS-0000000AMyG-1oSw
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DAAFD601EB;
	Thu,  5 Nov 2026 19:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A151F008A3;
	Thu,  5 Nov 2026 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907345;
	bh=gJEjJHr+63DkRgcn2DucJbOp2pD2WNeYTaMSKLiQVEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lowCxpM80XbQiSSCcFv25ROY9iPwr8AIjymBRSEeCKy3QRBb1FptmRHlNq0Wjq1/k
	 K8/iyufGkzQLPaSJrtMq7r0Q59oLYpv7F1FIe+/GUzbkWybOWjrwtgx6MUmauz5Wt4
	 oV10UyRGTXNAt7W7iafOiQPj3dtAFzUh5XC4pmHZNFWGPa3YcQCFuCi93JRRZ+uDtH
	 jVMDhvp+8GKhMC9jEJ2uzOHXpPQBE2ukBHORlZ+DaGIimf+CjVuQPWP5HCJVMkLor/
	 vhFuj9C4hZBYSNwdm7GtQwF9416SSchhrxNZmyQgRKmmww+fsBfmslktFGiW+AZaab
	 bv76fZfTqneZQ==
Message-ID: <sashiko-outbox-199945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 15/23] proc: copy in writes to the network
 namespace entries before pinning
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
In-Reply-To: <20261104-work-procfs-core-v2-15-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-15-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:43 +0000
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

> proc_simple_write() already hands ->write() a kernel copy of what was
> written but makes that copy with the entry pinned. Let procfs make it
> before it pins the entry instead. That covers everything created with
> proc_create_net_data_write() and proc_create_net_single_write(), the
> afs files and the rxrpc stats.
>=20
> So a write to a proc_create_net_single() file without ->write() can
> fail with -EINVAL or -EFAULT now before proc_simple_write() gets to
> refuse it with -EACCES.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D15


