Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBA606D81C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CyEVIEXi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOZbcgp7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6+3rBZSpmL6AwycDiybym7wulbxgrmRFLRhclCECa3Y=; b=CyEVIEXiBQLyXnUBfpdhc70QgG
	WYD4aTjMpi6FJLNrYhuVI6YSjNffqWj427taxAuXLMOCRvmPIqp2uv56fqq0cpj0ILKWCtncEKBJL
	kPOwEqLn5PF0YhBH4OD6hxWx/DlXLoUdrhxRWMyELanfI3xZc5JJBkfLo0vIWpJ3JEiay0yYgGMJE
	4uzlnLATuHlrHinA1H0sAzSOF0evX6H2kmSBMkm6shPE/HkFcoO1OcoSWlxPGHV6+sPhCB3L+SpVr
	u+CWKm4TIXKRxnGFysEVtXGx8N8C6w+tRaF6/aIG9Kl5g5SGIa41hhXMjVetzWZyjvWFM/lkvTElK
	nsUvob8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FH-0000000AMsz-27Gc;
	Thu, 05 Nov 2026 19:35:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FB-0000000AMok-1T4s
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FD5342ACF;
	Thu,  5 Nov 2026 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0871F0089E;
	Thu,  5 Nov 2026 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907329;
	bh=6+3rBZSpmL6AwycDiybym7wulbxgrmRFLRhclCECa3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AOZbcgp7KiL117k9ZomLZgNAYCqNPQoGYDGu7VInBnlWN2ACci5GdQGHH77Td5fl0
	 PMqHuG9PSJ1eIcSmO4aE/jRhciTEEC+kaCXQzAkbjSAbEmqIqcFbZPKSNSF+Dz8T5g
	 YNFTdQpoP5CWmhjRyUKESuR+HN1YN/5/HAbEbhU6EhzWiOxUQMENP1CQBZlkoEyGB/
	 kvCg4HTLMHqDXXlApPNo3yFstryquziH9LGxCkx8CbvvTATNAM/9L15zEUZlS5NclP
	 lcEIpX6mHh0IBDkqZ7elF8XDMRhP8BOx6XbMw7DhMmLmu7mHjpMwm0/m66xJ9XieZX
	 C64c3NTX5BZ5A==
Message-ID: <sashiko-outbox-199937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 07/23] proc: let procfs own the seq_file of
 seq_file entries
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
In-Reply-To: <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:27 +0000
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

> remove_proc_entry() waits until every call into the entry has returned.
> For a seq_file entry that's all of seq_read_iter(), including the copy
> to userspace. A page fault in that copy can be made to take as long as
> the reader wants, e.g. with userfaultfd or by punching holes into a
> memfd over and over. And callers of remove_proc_entry() like to hold
> locks while they wait. xt_hashlimit holds hashlimit_mutex, which all
> network namespaces share, and addrconf holds RTNL.
>=20
> But the entry's code only runs between ->start() and ->stop() and the
> copies to userspace happen outside of that. So let procfs own the
> seq_file the way kernfs does. An entry declares its seq_operations, or
> just a show function, and the size of its private state in struct
> proc_ops. procfs then opens the seq_file with seq_operations it builds
> for the entry when it is registered: the entry's own ->next() and
> ->show() with a ->start() and ->stop() of procfs around them that pin
> [ ... ]
>=20
> No users yet.
>=20
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D7


