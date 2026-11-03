Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB960A2627
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YWv7L4bL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXQpWkc3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LtZqKTI362maYNzVac7eehRAzsprmajrL5qhala3VHA=; b=YWv7L4bLZOkytj/TGHUkZxin2o
	9s0Uj2cQ/ABQmu0x0tmSpNT2MpVnF+b09n3S+6Xxow6CjBVubOntXk92zNI8MF1EdeWLZy57r+DVY
	iI/LHskTaY9ugW4NYXCI7ozUubXTzEZOA+3L1ZVQNwA3aZIIaNb4qpmXeVRhVn/lQHtzlnCSw9z8S
	Vy4n6Heszx7VeetPM96D+ca9pYK22ofOR3VNUsj1B2CYKTNJukr6JqfU9/L6qzD62XVYtSvCHgWnk
	x/Y+/epn0cdGSF/1yyzoDK6/f4RhrtnG2Bs95Uh0IwNDvD2kHZqCURD+WN4jHxSF5CWtQGqyCFsje
	3OEvfMUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0k-00000002pfv-2AfH;
	Tue, 03 Nov 2026 15:01:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0j-00000002pfY-2bSd
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 60BB4432BA;
	Tue,  3 Nov 2026 15:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55DF1F00A18;
	Tue,  3 Nov 2026 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718077;
	bh=LtZqKTI362maYNzVac7eehRAzsprmajrL5qhala3VHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXQpWkc3uOcqQ5JnVG8GDwDONMut840YqiKHt70+ZChrT9F/gAuTzrJ1MgF+EtTiI
	 pIHnFVjjMPCDE4zUdFv+KrsHUA+gcjSot3YPwOmRUGnBpAxlYE54E4N3J6Y7uuyugZ
	 +n59+5WkWJ15XUosDXPVIaRrh1gNIRU9QWFK1gVFuit7QU1S9OQHEsu0qNCk4nqsd6
	 0O4K8YNuO6zhFE7kHEwN6K8N/CGGW619TSA/cOokl6UTRnf7OmZioRbUlPVGsC7EcF
	 v8E8ffn9nYk0ynAGCilOHRhHf4IJen3hNNMOl3BDkuvr7hr4jJt1eND9Pac/6Y2uUb
	 Iuhk8b32INjKQ==
Message-ID: <sashiko-outbox-195534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/16] treewide: let procfs own the seq_file of
 simple proc entries
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
In-Reply-To: <20261102-work-procfs-core-v1-7-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-7-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:15 +0000
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

> Most proc entries that bring their own struct proc_ops only call
> single_open(), seq_open() or seq_open_private() in ->proc_open() and
> free the seq_file with the matching helper. Declare the show function
> or the seq_operations instead and let procfs open and free the
> seq_file. Reading these files then no longer holds up their removal.
>=20
> Done with the following semantic patch. The new initializers were
> aligned like their neighbours afterwards:
>=20
>   // SPDX-License-Identifier: GPL-2.0-only
>   /// Let procfs open the seq_file of proc entries whose ->proc_open() on=
ly
>   /// calls single_open(), seq_open() or seq_open_private().
>   //
>   // Confidence: High
>   // Options: --no-includes --include-headers
> [ ... ]
>   identifier open_fn =3D {single.open_fn, seq.open_fn, priv.open_fn};
>   @@
>   - static int open_fn(...) { ... }
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D7


