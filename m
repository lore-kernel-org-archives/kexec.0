Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BB606C8A7
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LUpbRuqp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/IGA7VD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6hoRvIBjdvZcFdce6OvLL9wYKZneWoJGVeTND16Hg0g=; b=LUpbRuqpXvqbONB4JOnlDPeuac
	AKa+B+TKwDm2/5Hb5joBs+T424wrlO7kDHj3YkCnsvI5TZ515TFKyHAJSAxak4GCObFv1quZMkkXV
	Jv2x/R3WSaieHifd2coDJ4d0ZoApPvr4lZVbD4k6Y8Vv8gH7pFA+lI9AWQ8v7ietDY1xl5LnRCK4h
	MJpAOP/JGmw4qc0xlsSuk4PpBS9RNTjqB/Dko83wPBrNpquhap0TlfnWWgaBk6BFpe4vW2g/ZQl+4
	jEzRvgPLOEoNej3G07JqmXq7g/trsMG03CvqqjBxPVOdgy9CAce1irCOme2CSZaJt7Xv5L1LLvGyz
	995EDT2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3F0-0000000AMjN-41JJ;
	Thu, 05 Nov 2026 19:35:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ey-0000000AMhi-39M7
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E04F760148;
	Thu,  5 Nov 2026 19:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FE91F0089F;
	Thu,  5 Nov 2026 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907315;
	bh=6hoRvIBjdvZcFdce6OvLL9wYKZneWoJGVeTND16Hg0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/IGA7VDolTlFuDSzsR9PpNCLOc+MOL9Jlb497kin2aM9CsKSdGuinZsObzzhjKLu
	 vZB5+O9pGI8nVCo/32oLJsm4VfhHALYRw69cQLc/OwWudG08CrlbhwGxTj7hUqCvjm
	 zVfPAInrWuotxqB48n1/G7DlipPyNWJuwaJ2BWS/mluZe9QG+3hr62O+EHJHS7JbdH
	 R5EBZoDlSrf8ybUt+J6V3XvBz3x5hj9FNHwo4MzJlMjxhvX4Q3MmE7R6Wst9YwTNGO
	 WDDxetp3K1AY572xeDhT4SHRoltfwdfx2B4GtWjR4CUKwVTi5TNf8KO6vilhKxp27B
	 EnYkpbISY24IQ==
Message-ID: <sashiko-outbox-199931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 01/23] proc: drop the compat file operations
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
In-Reply-To: <20261104-work-procfs-core-v2-1-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-1-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:12 +0000
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

> procfs has both sets of file operations twice, with and without
> ->compat_ioctl(), and picks the one with it for entries that have
> ->proc_compat_ioctl(). That's from commit 778f3dd5a13c ("Fix procfs
> compat_ioctl regression") when a file without ->compat_ioctl() went
> through the translation tables in fs/compat_ioctl.c and one with it
> didn't. Those tables are gone since commit 77b9040195de ("compat_ioctl:
> simplify the implementation"). compat_sys_ioctl() answers -ENOTTY for a
> file without ->compat_ioctl() now, which is what
> proc_reg_compat_ioctl() answers for an entry without
> ->proc_compat_ioctl().
>=20
> So always set ->compat_ioctl() and drop the second set of file
> operations and the flag that picked it.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D1


