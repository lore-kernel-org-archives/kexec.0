Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22554606A795
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4CrZufRy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtKCljk1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O9ttEEMk5aMI0xnyyX9rHNq+bDAQQVwO4bXVwqZk5oM=; b=4CrZufRyfUm6UyjuCOY4wx/cLB
	WgIV+C00gECKCgdci28r1xgOwdA83RUEwiPQCCQ4+/gd6jEaIQbYDCoUAx2xj1WWkBhk7/DUACEI0
	x1puqe6fSJZevjhiI08VVOupWdf0B2JvOQ/YGg7A4w53i6gXleK2rUgeaOn9wo+mIT0KunvHUwjU8
	0TOgP0l8dMmikfgT6yjftNP1YGKyhZKioUDl0boZ/gaFSqkuk5LKca1icMJeuuC8/DMTLFjTdZjen
	QW4EdfD/VLOClQ9H1imnmAehXOwneKlunbltY5EhjSfKaw0ViSkcp97NkxqPqOL86VJmLAS8V8ls0
	tJvXRVBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0X-00000002pUi-3aMh;
	Tue, 03 Nov 2026 15:01:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0W-00000002pTp-0kzV
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E939244000;
	Tue,  3 Nov 2026 15:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A91F00919;
	Tue,  3 Nov 2026 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718063;
	bh=O9ttEEMk5aMI0xnyyX9rHNq+bDAQQVwO4bXVwqZk5oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtKCljk1LUvJX7KWDQjGj4wiHw+nMT87rtLCGJRTBYFOnVKhOBYNUS58KOesO+NiT
	 ER2HFmDawKCWeqirKD1bgeaaWLAsw7kaZahNvdMxcZ2A6tubEEU2b+KyISPnVnH3De
	 VlS8UWmQqfvhIjxe0gW/En7sarJ3yWhvP+J+F29JCEifzwOto5rP9bGZe97qhSS6Yi
	 xYFyCbF6HeTNA5fWxqAfDBvJNHBsNOuOBdzH4kWFRyOW2Q6tGuyciAiivU2E0CTx+4
	 6M2yffCJdgdXWLkNu3Ruz21vUDqhU/xAJMYjVWhf2ZqkxGJXsbg8JOCIzeTSiOCTh3
	 /uO8boCh8z46A==
Message-ID: <sashiko-outbox-195529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/16] proc: add pde_pin() and pde_unpin()
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
In-Reply-To: <20261102-work-procfs-core-v1-2-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-2-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:01 +0000
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

> Every call into an entry that can go away is wrapped in use_pde() and
> unuse_pde(), and a permanent entry is called straight away. The read,
> write, poll, ioctl, mmap and lseek methods all spell that out as the
> same if-else. The next patches add a few more callers. So put it into
> pde_pin() and pde_unpin() and use them everywhere.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D2


