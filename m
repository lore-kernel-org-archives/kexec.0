Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D7606A6C6
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tgM9Gqmk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R49qB2P0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VJM1TPMHTJ5mBUuyXhBiQ3F6ibJxzxb1q4lJPp3RzWY=; b=tgM9GqmkYyGPMUCMT5VD2QzD1V
	iy7JwC7HQwj0zWr+z8zBFHZiIb6mtQ0xrzNG/uzdSgaYq+TShSUTn5QNtCG+6HIan7BA2I1qLUdHZ
	XtPQSyH7h6tmizq7VqyKWjn8+ESyN4uYWzAyFMsBwEoQ9VZZbyj+PecjPzi18svh89KOpBre6dEOX
	qP9lVtcFi7Oek/iAr5ZhcDU8FTkDqjYZm49LJkZp2foT/BnczSNmgZ6/3r0yHA3lTDrT/TO6LKFyJ
	ZlCS/EntNCb9CB8g5HBEemdv3c3yt5na/5smkIuvUy/MeSSR5730vwTuSAUO8YKTOJcTcLIrsuiOF
	jMMite7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bo-0000000ATAA-34hG;
	Thu, 05 Nov 2026 19:58:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3b9-0000000ASlZ-3qzd
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F13F602C3;
	Thu,  5 Nov 2026 19:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19A41F008A4;
	Thu,  5 Nov 2026 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908691;
	bh=VJM1TPMHTJ5mBUuyXhBiQ3F6ibJxzxb1q4lJPp3RzWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R49qB2P0qXLUlPstwwn/cwYKqB7OFfz4cOrfsP1tHpUFMXL/az8OchsolUY+GEzN8
	 qPorB5vIYuDFFbNWXZE4dER721Q9iHKmNr9gTXfDYm5AJvXye0eCPOLB5v3lQH3wnt
	 lPQrL8L7KfQOJJHq7nla/3TPNFRoqsbYIXYWjsoCrXCJKCIXzvkbiOVXSwuJWI0CoY
	 O1TU2YPeucS7sioJZWTFApiz83C+NIGiwdWch89cqPQW8+W+41Rn/7BQvAoF14Rwa5
	 cS6JRLtxWDf46VmERQg3QZMBNyOybQruZCkAsYR0VLJVVC6hEyS2CEDKwXXOsQKShk
	 bBlenIqZvFSoQ==
Message-ID: <sashiko-outbox-200054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 20/30] sched/psi: let procfs own the wait
 queue of the pressure files
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
In-Reply-To: <20261104-work-procfs-fs-v2-20-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-20-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:09 +0000
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

> A trigger on one of the /proc/pressure files has a wait queue of its
> own for its poller, the cgroup pressure files use the queue of their
> kernfs node through kernfs_generic_poll() and kernfs_notify(). procfs
> owns the queue of its pressure files now, so use it the same way: the
> poll_wait() is procfs', and a trigger that fires wakes the pollers of
> its file with proc_poll_notify(). Like for the cgroup files every
> poller of the file is woken when any trigger on it fires, and each
> reports the state of its own trigger. psi_trigger_poll() doesn't need
> the file anymore.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D20


