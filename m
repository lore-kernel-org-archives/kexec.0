Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29E606A6E4
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j7aSnqCY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an+GaGrP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7/aaKuldQgClq8ReLax1ykoSxafbF3ZgLD9HjMju1WU=; b=j7aSnqCYwLFuojiS7zORZAbyDR
	9kMzrZylLulSZw3peN7UNtRsbVZcYsnAmoXTUF2Aj8DfGU8GJxJddSI21+u9v02bm3OMUlxsiIW6u
	G3EiiiPNNabgpSpprdCmUK3XH4OssQaycvYlKbFZ/cQcGFHiXxy6MTK16VJWinvr/B9JyqnHqkmBI
	N50Bvt/S8P0R+Tz2WYKfkKXpxgFbiUKZVCFKE03BwQKmBsKpVX6PposIdp9M1/v7DUYYUBMZfRu/d
	8MOZ0V0OT6foHhtrm5n76jpOJfGRNDvxf8all+ujtYfM8osSgGr8F7jsD0ZzqdyYy6wdcbntdtsrR
	L4ZRCK8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3d0-0000000ATiE-3UK7;
	Thu, 05 Nov 2026 20:00:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bK-0000000ASpl-0Hdf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC40D40991;
	Thu,  5 Nov 2026 19:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3891F008A1;
	Thu,  5 Nov 2026 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908701;
	bh=7/aaKuldQgClq8ReLax1ykoSxafbF3ZgLD9HjMju1WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=an+GaGrP6TdrpWnLckWrPSepsWmHkQ5XptZk4tHL+HpcEfNPQTKp/wIE0YEjMyswu
	 OrhN9uEyMFoYjQkeHuikFpy3e0zddTttGDFkpuIaMkcA6eGsZ9PG+nZXuKxpHyCsrC
	 SNCEbh0wSxS6z/Jb7uu4cFZEto4+IHTnO2FVyeKD50/Tzzg7HbxicNYxazMsJsheZU
	 1/idVdBK3MZnCoSpbo06TdxRXrO5ag6849zDW70fe0dwn4m5M5QgW3y7jxda2zX6CR
	 doTY9qkj5Jd95Yv6hY1F0fz7SIzfsktjfoFB86+JK9Sn5qjY0BS4iz7RIoQ4TBqsQz
	 j9OtHEdlaVesA==
Message-ID: <sashiko-outbox-200059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 25/30] alloc_tag: let procfs own the seq_file
 of /proc/allocinfo
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
In-Reply-To: <20261104-work-procfs-fs-v2-25-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-25-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:19 +0000
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

> Declare the seq_operations and the size of the private state and let
> procfs open and free the seq_file. ->proc_open() and ->proc_release()
> only set up and destroy the ioctl lock now.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D25


