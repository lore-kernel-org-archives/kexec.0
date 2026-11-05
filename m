Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43060741D2
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hPgFUrOd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDNZQIwt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DJ2FuCOZ25WP9BjL5sqJhCN93sGmznOaPNO9Soy3liA=; b=hPgFUrOdaLcLs2rM98evoCe4Z4
	lFn672d8+BWGnE67WXCGi8f3fVXkYxqkkzyvTopE5H3EBNYzLXdeY1X7XTA5R2kka71eqqCTN/wrO
	vjX1i8iW9ZsAl/b+kMDO8ii3+cW/Jl5hGYlEiy7+oZ6sBQoP9TJtg0//9EFhmtCwcJGe6Z3DZ7LD3
	ZzWUGvTKRldf70TYXLmqvzjTjHndVfAWzSBKqB/wdshRdFAEHRmxYO3asjeiec905XSMlZ+ngkQoP
	ZR617i18tBKh4rEa5EFMfR7ClBV3wCfWE0he9O1wiVvejAYKQiz3hVVydGKPGRZlOmLAuzb4uOyEK
	bsylbt6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sq-0000000APmw-03fX;
	Thu, 05 Nov 2026 19:49:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3SX-0000000APhK-0Uvl
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9158A60219;
	Thu,  5 Nov 2026 19:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EAD1F008A3;
	Thu,  5 Nov 2026 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908156;
	bh=DJ2FuCOZ25WP9BjL5sqJhCN93sGmznOaPNO9Soy3liA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDNZQIwt0cb0jQc+O6KdhC9zGQbMi6UO/u3vkRuj84S6NYwrCMMgKBWk2lRKtl1Bm
	 OMrKDFZ/N4us3R1WBxlEVOdXmKsUNMG2/ZYOeQAqTuOvpoCgTsf0y/DWEkXqwq/4eP
	 ytp8wA84Xuc/o5GwBeATfwVp82Kdq+coa5UqQgN3VvWZXc6I3jIJeSoD7B8c/yuc/E
	 VlL5c2FH4+UVDbMt0zECtukiTyAx5nk+qywTyLYhvke6cK68jQDWL9UPhYFWTSw3bC
	 qvZIYjyJXKKaplWXlLHQZ4QPeH6F86BG0T4n4bJy18hD0f1D4RaWPvbu6T8rmjlJDH
	 J7pTsAzwsxqVg==
Message-ID: <sashiko-outbox-199991@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 05/26] PCI/proc: let procfs handle the ioctls
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
In-Reply-To: <20261104-work-procfs-drivers-v2-5-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-5-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:14 +0000
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

> The PCIIOC_* commands take and return plain values and don't touch
> userspace memory. Implement ->proc_ioctl_buf() and list them with
> nothing to copy. 32-bit tasks go through the same table, so the compat
> hook goes away. Unknown commands fail with -ENOTTY from procfs now
> instead of -EINVAL, and instead of -EPERM under lockdown, since they
> never reach the handler.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D5


