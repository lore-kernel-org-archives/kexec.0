Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51015606F955
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=19klPtm6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2B1lxv/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5aGzsp5KdgMuXiH4cPLLqfuaFSwdYC0fVhuh3RxhPKI=; b=19klPtm6u8zMIX7eBvmSqUlaI4
	muYTBUaPG/tjODSbbd0NOSVuOCFXwXYy8m6pmOzKcH9o94aKExss6W1SvUUzhP7aNiSEZAHpzuqPV
	9hlGwMr5aIPEEdZ6JwYzUFTif8pcdBND3olaky+OsuMIIZQ0weBBaJRtrIBkwuGgslKkOP8AieqzY
	QVAdJNyHalv7wS1MEEcS8wNRFAzZUlA1mrbockMo8HnZW/9e6CDxT7piUYqp6JIx3fGoy80oH2Ow0
	O0qv8wjUgsvyKWIMyDrLnfupTo1UQ0gHDPbvuDa9O6b34ZM6eZBvsd6DDElYkJimajgKsLgaeHQlK
	88PzS6Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cs-0000000AM5k-0KMS;
	Thu, 05 Nov 2026 19:33:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AN-0000000AKnW-0ddD
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E26DD40E48;
	Thu,  5 Nov 2026 19:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F19C1F00A16;
	Thu,  5 Nov 2026 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907030;
	bh=5aGzsp5KdgMuXiH4cPLLqfuaFSwdYC0fVhuh3RxhPKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2B1lxv/jKFYgwMG1NDGekYrwHfux9B7Lr7YpeIbjYFC35OEbhjW8Gpq8v4zquLqB
	 Z4pB43t0ZFCbMfNEQFK14pwDCS+MJMSzNhKmk4jye3m4E8h1z5FlvpH2Ti6nWmlmXv
	 PD4sVjRltWsq+GUhSR8G+N2nMA8hfy3KQopKQglQ52iAbw6oo1rkFrb2wRdkx4DFbD
	 yAw1hWQRYtDcwJ1O5ly6RFK6tEeSZ1CDKnU+TKvYYEVsr5f+ntmDyz/BK/XOWfo5X+
	 SdsaxDQDu2u1NgohRkw33LgDeTvk29zCkDLG7cFajkOaw7uVHNhan/wbprVyf7LjAW
	 sAMrc6/lSDo7A==
Message-ID: <sashiko-outbox-199912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 49/51] selftests/proc: check that faulting
 sysctl accesses don't hold up removal
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-49-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-49-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:29 +0000
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

> Read, write and list /proc/sys/net/ipv6/conf/<dev>/ of a tun device
> with a buffer whose first page is backed by userfaultfd and remove the
> device while the task sleeps in its copy from or to userspace:
>=20
> - unregistering the table doesn't wait for a faulting read(), write()
>   or getdents64()
>=20
> - the read still gets the value that was produced before the removal
>   and the next read fails with -ENOENT
>=20
> - the write is copied in after the removal and fails with -ENOENT
>=20
> - getdents64() still lists what it looked up before the removal and
>   fails with -ENOENT afterwards
>=20
> The tables are unregistered under RTNL, so a regression stalls each
> test for five seconds before it fails.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D49


