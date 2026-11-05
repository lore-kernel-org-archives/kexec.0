Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEA606A326
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xw2sYZQb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1pRV84z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hsy7qPadddcHp1yz4RskpjuPCs9z+iyUZQjRxWR0tno=; b=Xw2sYZQbaDuuNYZhdarL7SLIQ6
	kVq37yT5t8xakRxklpqM24aWbBRjU5p9zbYw4+pxpIp+JbDm7W8XGuask9wvWzVzEcTeNO87UToop
	BF/rQ0PSIt0PW0Ebp+LYU/m9Ud/0aw62+ll2gm8WzBTW89LRYk+UQt+T6RTjWN7koYF75onfvzTNy
	CZfKsJ5dPNfybIYNGiX+q1KoKmeH4Dp5qsVsNGumTzD/8crfmsfufjh6MAV6wYXYjMZV5H3OPC5S0
	ddTo3JAVscg+3+2yzqBaJPVyyWvLjqdtG/cmHvDIKKWKVb6nJnOBwVYxhYcjc9hR8/MvHRUt8yAUb
	llHwLbPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Bm-0000000ALVR-1ykK;
	Thu, 05 Nov 2026 19:31:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39y-0000000AKjK-1Uue
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8743601DD;
	Thu,  5 Nov 2026 19:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D006D1F000C1;
	Thu,  5 Nov 2026 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907005;
	bh=hsy7qPadddcHp1yz4RskpjuPCs9z+iyUZQjRxWR0tno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n1pRV84zJKUUtgUv1TYLImkQPkvmaqLjvwYZrx2oyTCwObzhdrQFqivFQJG2KSTyQ
	 eTIbvYnu/am2gKJ0v2gg99xx3HGgCRhK3jtKYYV/hEN32FiOkUwOd5qfCd1EvNlRbU
	 /wDWKpQlTW9sg368vKkBt979aVtHTwB7aqgs1lZ3cZ7yuOwpmH/5K72S+3ZXzvHDZJ
	 zCVaJA/NGoQ3f5O/ZIg5OD8CZV38pYz/7PwHfRkFO2BSCEBpwk5KemMFv7yST4FY/7
	 ke1edsHonMb+SJ+aejvls7v7xGnvSnNsG3bwmscXuAXx4DTCqwdtiudcPMpO6x6AMq
	 QMz7+TNSVPVMQ==
Message-ID: <sashiko-outbox-199900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 37/51] proc/vmcore: don't let vmcore_cleanup()
 run twice at once
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-37-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-37-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D37


