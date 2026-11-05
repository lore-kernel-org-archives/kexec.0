Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1C606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kxiuu7pC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzE5K//c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TUEa7eIRLkYlG50VJyzFVsWpbL0zjSyXV5JMm1JJ87k=; b=Kxiuu7pCFIhW8o5tnVKeC0dw10
	8RuyuBZc4YUw62jrGrJRTnFYzqgZIIslET4+NLdXy3DpmF/POUU+2QPeuY3Tr+60cW6Q5ZilRhUSO
	Qc2vh0fNsufsfGnwA7zKl/aIp4rAxEtbtlEy/IAtaCSEKJcIISZMTf9I4ZAVrHc2TCVzQxwBolL5s
	poFzd9sV8lA42dCw9TX43mqczvcHN3JMwmXT9j5lbxAK3GDrnnElLyVD593LY77KFH6G1Ohblj8Pi
	oYFTJmZYCK8Y+NA6CA8BoWP0QgvsUqeH2hiI33RrHQ7hT6SL/gJxXPBwaTYl7pw591K3/1c2VQil7
	Rm74lvsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cr-0000000AM4z-1e2p;
	Thu, 05 Nov 2026 19:33:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AL-0000000AKnS-31kG
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2ECEF601C2;
	Thu,  5 Nov 2026 19:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F291F00A02;
	Thu,  5 Nov 2026 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907028;
	bh=TUEa7eIRLkYlG50VJyzFVsWpbL0zjSyXV5JMm1JJ87k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EzE5K//cJCfees6tq1n/aL2ZXIFBE5phY+UQOmHq0vN8UPvYS/t9kkzR12V91SBSS
	 mhS7JX+wWb8SSFsgjQLGWb/WG0xY7lURsW1aoepv/YNSVEiw0q1fXhrM33YsC2iYcX
	 Y+waIrwUG/i8Vo4xsrxYyrlh/w1ZXi6PT5QOp69R3v0bZCzhRKgl7jMf/20Nx+KlzW
	 0im/yzY5zXpuAl+QtNTMGdrxcjVY3ep9xLEZXfFos47R/RaVosKingXECZ1lFQe2/a
	 3/8aSX9eI5PmGSLMxslCDj4GFhqROFpYezwD6KMYwTFTCdln5UIo/LVBxVD2dGdOQo
	 DMN8N2/pVc/WQ==
Message-ID: <sashiko-outbox-199911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 48/51] proc: sysctl: don't hold the tables
 while readdir copies to userspace
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-48-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-48-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:26 +0000
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

> proc_sys_readdir() holds the directory's table for the whole readdir
> and the table of each entry while dir_emit() copies its name to
> userspace. Unregistering a table waits until nobody uses it anymore. So
> a getdents64() whose buffer faults for as long as it wants keeps
> unregister_sysctl_table() waiting, just like a stalled read() does.
> Listing /proc/sys/net/ipv6/conf/<dev>/ that way holds up the removal of
> the device under RTNL.
>=20
> So don't take any table into use for a listing. A header counts what
> refers to its memory, the inodes made for it, and unregistering doesn't
> wait for those. readdir takes one of those references on the entry it is
> at instead, which keeps the header around and nothing else. Under
> sysctl_lock, where unregistering erases an entry, it finds the entry,
> copies its name, follows a link to the entry it stands for and pins
> that. Then it looks the dentry up, creates the inode if there is none,
> [ ... ]
> directory was done.
>=20
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D48


