Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926E606FCE0
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dLKDyLV5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnXRLo8l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DJWMdpN/Mhm849XfylURVc3f+ehsUKnFgT6iodNIu2I=; b=dLKDyLV56qzNMc3WYM1J2HDrPp
	C82ri2hDGOqzAZjiaWWRaF1iactkjaJ4Hn2lgBpNhKszEdr6CCZEAQaMd+ZdxzcHjAiMYqtMnx+VB
	sVMmBCgOifFBw43dKpfSMNjxI0b2DzMi+b9MAzD+fJ/NmC5545+v3PNfSABCNHh1zxkPTW2rAH9RE
	Uolp3xe4iVmQK8o9fL8Z2lXcrjnDZBiVY4EPhjbj0ljuux2sRu2gF8F3zwodURWzdHDBv9PYtoMGe
	ZO62DRuWqPOuxQLnixLOr/ndNfC/fBxh89LzchzcbTZ09V9N1S66BneOUHq3LQKgMmmVq1F7XBFdS
	839Sv5zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHV-00000002uwS-2SyU;
	Tue, 03 Nov 2026 15:18:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHT-00000002ut4-3Odv
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 42DF0609F2;
	Tue,  3 Nov 2026 15:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5B1F00919;
	Tue,  3 Nov 2026 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719115;
	bh=DJWMdpN/Mhm849XfylURVc3f+ehsUKnFgT6iodNIu2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnXRLo8lld+/gqavjn9Dsw66ts+5YWypK0KuqK5iG9mI5UWXfSd0stxLTsOz2QcOw
	 VDQPZ3ScwlwC8ArGOiDqW1zYBC5/UxJTL1APdQsB/X0Tt6H7l++QO8xYyFS10kb0ud
	 e3oQeE2qhraAFmO+n1A6RS7j6ROSd7oXltgPL81WCyHyT6/tyeJ+gbwO5bYmUWLPuk
	 fTjj6Q3YEHbn5drVobbZZFg/j+nCNHLhMyRYPmStuLzP1pTOjwSF23CoDnAIi6o1ZL
	 YSYfKmCbkpYrGFdbTk2Ymk/2GWnXi2HYS6UZMoN6QTq2nVZ3hTdvcaHwRCBU+bmABN
	 LsJp0pWLY7VcQ==
Message-ID: <sashiko-outbox-195585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/23] PCI/proc: let procfs handle the ioctls
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
In-Reply-To: <20261102-work-procfs-drivers-v1-5-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-5-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:33 +0000
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

> The PCIIOC_* commands take and return plain values and don't touch
> userspace memory. Implement ->proc_ioctl_buf() and list them with
> nothing to copy. 32-bit tasks go through the same table, so the compat
> hook goes away. Unknown commands fail with -ENOTTY from procfs now
> instead of -EINVAL, and instead of -EPERM under lockdown, since they
> never reach the handler.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D5


