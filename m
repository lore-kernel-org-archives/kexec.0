Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F8606B26C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hkw0TJJ/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTW1oFOr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a8MklUW6PYR4NuTZFeyOULTC26VMv8Yp0HFaBobp5k0=; b=hkw0TJJ/QbC1cKgpJyrXAdcPU/
	lvKwoaqw9ZAC35YgGT9io2PuTZIwbeC9TQUtMgvDvzZzc2iCIQDfXE7Mm4POdU237fc7IJZr5ZdWv
	WlrLetJVEGgF/CjdlJoRzXgx2zSJfwlwgezy4gZMfo0GTLBs39RLDfwuedw/Ru8djWMNsVCYIb9J1
	v6dmgfy+0+cf2WhnY3brZ28zpPW+e2DRv4CG+KcQnTlFQOu2Zv9cft655496xJ+HtHnQeSI25IM78
	aB2d1NE+LGBflEVvImnGdS7Ao9ysRkoUkXoU3w91j776M375kAwlHy6odfvLo1lAWWnrVSJo/Q1rT
	mXd2jArg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoI-00000002lWU-37ly;
	Tue, 03 Nov 2026 14:48:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFo9-00000002lMX-29sa
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D2095605CB;
	Tue,  3 Nov 2026 14:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9DB1F00A1A;
	Tue,  3 Nov 2026 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717296;
	bh=a8MklUW6PYR4NuTZFeyOULTC26VMv8Yp0HFaBobp5k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTW1oFOrdzEOUPkrvvNahWHPbA0e0ufZdo6mO+cLvubWXkN1/MNhM4qfQsKcdl+Fo
	 1UwmK1ZZSf+5SRMSnemcp5A+D5jWw7205V0qOh4ixmwKW9lcVMSnynlE0ubQ/VVFJi
	 vxRny/8V9iZJ9ExkJe1Zb64JqIdngs34CEmUjkTlNHUYcB/2rTERNlv8IvRSCVxWkj
	 9ebpHdvYgFfFf7wQNgBo1bSmsBp+lLeElE2oJht2XJ26gE3MAd6LgY8lm3TBjwNy4G
	 RseVsiRDCBb06aK2dHOLefpoLHMiBjl5dg1pKc3epjazs3c6zyNP5qcXlhjNXaq4bA
	 92C480cHTH15w==
Message-ID: <sashiko-outbox-195496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 24/38] proc/vmcore: don't let vmcore_cleanup() run
 twice at once
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-24-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-24-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:14 +0000
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

> vmcore_cleanup() has a single caller, fadump's release_mem_store() on
> powerpc. That checks fw_dump.dump_active without a lock and calls
> vmcore_cleanup() without one, and kernfs only serializes the writers of
> one open file. So two tasks that write to
> /sys/kernel/fadump/release_mem through different files run
> vmcore_cleanup() at the same time.
>=20
> The first one removes /proc/vmcore and waits for its readers in
> proc_remove(). The second one finds the entry already unlinked, returns
> from proc_remove() right away and frees vmcore_list, the ELF headers
> and the device dumps while those readers still walk them. Or both of
> them free the same lists at once.
>=20
> Serialize vmcore_cleanup() with a mutex of its own. It can't be
> vmcore_mutex, removing /proc/vmcore calls release_vmcore() which takes
> it. The second caller then finds nothing left to free.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserve=
d memory for general use.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D24


