Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866B606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xL+oUDn1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeuBgQaq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S86yJ+B5qGfSA192YZydUPkrd91cCUN2X40z9NmB8To=; b=xL+oUDn1/PRYEXZR+bFLrjQVD5
	6ui/3Dc+DV/SDoK52juqJ1EJUc383+nGpDV34DvCw9x7KTcYDRlGR5j0f2nTdVdGvSLcfFZEAptxd
	63+WD2JAzp3p4qhIIJbml5jn+0rZPLcjJjt0TrsYmoWE7i2tppqIa0KuakoSJOJ2z1ru+ni2Opq0b
	du8eTgWGs/4zWuu85FTIoMlt8p6scCGGApXkQpk0kJoqI1LKZZy1r4HGTqpvJAwXS3gmojkjaPKZ3
	Jg7a2Ips2N7YDuk9Ey+X40iSoVEM2mIUH8JbC7rISNKq4NBHfjQLmUYCBLTIWfSz7PEO2W5aBa2yw
	fMKb/vxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ay-0000000AKtI-08Tk;
	Thu, 05 Nov 2026 19:31:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39O-0000000AKJ8-3zMQ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2544432AF;
	Thu,  5 Nov 2026 19:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7321F00A02;
	Thu,  5 Nov 2026 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906970;
	bh=S86yJ+B5qGfSA192YZydUPkrd91cCUN2X40z9NmB8To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SeuBgQaqVWpGru3W9sij1Kx5fi/6U5rjetwB+P6G5tdeUO4escEUXQNsmkQ8RZJsR
	 N3ad0PsJzqTqBNUpF1Gq9bKq4Gs6PPnGr2kbOldzxfmsAxwk/I0ywFs+3s9dEovcpK
	 4fycBMvMdv+bDBbPSskelSCoXY5q3AokzQXZU4pI9d+YtuhY/MZRj5JY5FqeXz0QwH
	 wFVR7pturO91QWS5cokIA+tbR6398bzKWWYmaM6GJBXeAUZ84sKfMtfLgH3UqLIkJu
	 P5j0DmucSdoJn5dFSjExx6Tv1oP+zwkmPj0euNx6/FjN6JIUAcg6dGbM/GzyKStVRA
	 /FuSc7MXCNWwg==
Message-ID: <sashiko-outbox-199883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 20/51] powerpc/rtas_flash: don't read past the
 validate message
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-20-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-20-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:28 +0000
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

> get_validate_flash_msg() adds up what snprintf() returns, which is the
> length of the whole string and not what fit into msg. If the update
> results the firmware hands back don't fit into what is left of the 256
> bytes, the length ends up larger than msg and validate_flash_read()
> copies whatever follows it on the stack to userspace. Use scnprintf().
>=20
> Fixes: a94a14720eaf ("powerpc/rtas_flash: Fix validate_flash buffer overf=
low issue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D20


