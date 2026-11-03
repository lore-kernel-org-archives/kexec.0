Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCA606D81A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iVCSyTLc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhGRax2D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QIotc9uipaRy1fYVILWJFOZjIjeNZQOV2tWEZh+pwRk=; b=iVCSyTLcOs0uXPEIIgX8gq8kTM
	4ZDVx8gGw2vClqkHFqTwb+o5gq4t5xhsC+FZXBXAt7oriN5EEN5XFqzCguWbp2lTXn9QLt0/10Id9
	bRQqLaah50alF+kQTtWZ2RdJn5arpagqhXcBONIIqp1QQuK3STe8wqq99MpYUop7Jp41Yfclhpz1G
	F6uMUqmooundKOGgNGHf9NrbS/HCZkv5Ihq2ofnVZoG9SAoffNiT5fdIutb3Zj5659lfnbmPWPoaf
	5EjkO3jh7jmK+JPtDNYvHLsdLCWXsc+pxIsDvjB3K36cLPjLKKbpUx6XJyPdcnD68k5/jmHotJUWC
	n6LnnPnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGIS-00000002vzs-2Hv1;
	Tue, 03 Nov 2026 15:19:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI6-00000002vdj-4Bs2
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 722B360A75;
	Tue,  3 Nov 2026 15:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E11F00A15;
	Tue,  3 Nov 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719154;
	bh=QIotc9uipaRy1fYVILWJFOZjIjeNZQOV2tWEZh+pwRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UhGRax2DDiXkSRlLYrZ6YprHE7VVwxA/XbrOJLCg12HZCsn4e0jikOJEn0tCq3YSq
	 VOw//CAS8p5tsReDM0FCdWFyEe8u1co+G6UNE3Dxza3JFT3TQ4o7dckveRjDK76vy2
	 tY2jrVJ2cfwVpnZf4WDSK4IobBt4sGg1BZyK3GVmeAq9oAaAjzUPT8hANCXRKvpqRN
	 l7ejjvhfOnKI+gxdoPhF5yz3jsMxIeuZUCiv2ifRbTblvbOeqt429RJIi2lN6DUha9
	 E8OxK8FB+CzBqgwGM9cRNOmo5L7Psxs2k0RoXIqxbHyIFhJ+4yEVw5VWuUAZw9sGTB
	 vMcRQv70kODkQ==
Message-ID: <sashiko-outbox-195602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 22/23] ALSA: info: let procfs copy out reads of data
 entries
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
In-Reply-To: <20261102-work-procfs-drivers-v1-22-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-22-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:19:12 +0000
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

> Implement ->proc_read_buf() for data entries so procfs copies what is
> read to userspace after it unpinned the entry. ->read() of struct
> snd_info_entry_ops fills procfs' buffer now. opl4 reads the sample
> memory into it without a vmalloc() buffer of its own, gus, cs46xx,
> emu10k1, scarlett2, cs4281 and mixart copy into it instead of to
> userspace. The driver guide still told raw callbacks to copy to and from
> userspace, so update its example as well. Data entries ask for
> PROC_ENTRY_FULL_READS so that reading all of an entry at once keeps
> working. A read that faults on its buffer in a later piece returns the
> pieces before it now instead of failing with -EFAULT.
>=20
> Unbinding a card then no longer waits for a reader that faults on its
> buffer.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D22


