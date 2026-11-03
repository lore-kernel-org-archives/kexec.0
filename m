Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23B606FCDD
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kbrk31yn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfXbUGlb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nuG+HoslXVqgC4BtSCGH4CAYwdyBqlwjqRu8aNivsSg=; b=kbrk31yn09BeNwKNCuQpKIhGcc
	T5VPeknG615At5HpalwmiiS5e2qjBl1L94wsQmffFUTYvxiFl2CNYWWKGxWo4/+X4lOaTTZnx6euO
	zdj4FGpkeAO8+BOJcoQ/soPWOhIVnv/2ptABGLOPAR3ACaUi1qKd1buS27e3donvEThUZ4oRqC7Ci
	xELnq8e8MkbLtaJxjNeQL3gfvmdFKxVYzAaXOGjdcvdTrDGWcvdmQmw9ebqfxnYlKBJsTsATyRsdz
	3pTm9ydgR5P0wGo09eLZSnKRdPQWsIb/nKcaI5q62LQ+Z9QLWj5qtMLZV8Nud4VwIgFm9p2lYfn7/
	iQypEWNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHV-00000002uvk-1DMx;
	Tue, 03 Nov 2026 15:18:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHR-00000002uoy-1WWq
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E52C42AB8;
	Tue,  3 Nov 2026 15:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A371F00A15;
	Tue,  3 Nov 2026 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719113;
	bh=nuG+HoslXVqgC4BtSCGH4CAYwdyBqlwjqRu8aNivsSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfXbUGlbvISf8zKQVvmPeH7ogBauIaWPB+eTLP4FmHFU2NwqFU4DKL8ypk7Ux6mf0
	 gWh03iGMVC4HC0spyzQoLzUAhOUm1D8aZBt0IEBTrp1vzV/eyz2ttWkBahOXZ1jdDM
	 bF7l8JbcCU4WdpekYFK5RkGFPYb06/MtBCIdfY5wL6E9B972eWQ4Jt8sqM73HWB744
	 FRmkQPByZErjf4SpqiFbdtppIJezhzfc6o4zUlNKVldgtxJJ0F2xJrpbqDKUhS9g+O
	 aCCXO1MJqJ0Usnfho11AdOJXIk9MakMNQl6YJ71siIXnfOPILI08yBzL9lAyQ8T9HM
	 fvUE2tPgCHfig==
Message-ID: <sashiko-outbox-195584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/23] PCI/proc: let procfs copy out config space
 reads
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
In-Reply-To: <20261102-work-procfs-drivers-v1-4-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-4-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:29 +0000
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

> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry, and read the config space into procfs'
> buffer with put_unaligned_le16() and put_unaligned_le32() instead of
> put_user(). A read into a buffer that can't be written used to report
> success. It fails with -EFAULT now. A page holds all of the config
> space, so a single read of it still works, libpci treats a short read as
> an error.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D4


