Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F21606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pT/NFdWt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1XBvOeH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FD0zXeI/isP72fw/ayOidXLEWS0eS7g6u0vyIbhFYcI=; b=pT/NFdWtht7B6D3MR7sMW9nKQr
	RdmUebaBqKC++mw4x2C28IZe2VhkIQ48QwDbPQH8X0FUcA5zW2KaI2vHmFqdJ4puTg7nSm2K9VmJK
	GvS7Pd5IjJQ1SbCrc4TmnGgHXgxHJcAXsJSkSUFgCNTdzcD+HdlSAQm7mwwa0AgFPoOi9yeqXWLfe
	roQZyDeALOlkCa94H+W1KmaZs93x2R9iFBEWG2/YyoEYd2D9sZcXR0XcGXA4dGpoJjYcNJzaDt0tW
	OyXY2VPMutlyIP+LQ1DupSvn8nyo1+oK2QI4ZdCLZC98V4ClPlqIZZRD6auu8ITOnaWNqyKA3f/mU
	iwohSEUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BJ-0000000ALBd-0N9J;
	Thu, 05 Nov 2026 19:31:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39c-0000000AKQT-1XMi
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C9CC0601BE;
	Thu,  5 Nov 2026 19:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966B1F00A20;
	Thu,  5 Nov 2026 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906983;
	bh=FD0zXeI/isP72fw/ayOidXLEWS0eS7g6u0vyIbhFYcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1XBvOeHKHmEnMkDZUHXEyfUtxCM50iTgTdglUxQp7JDN+qlEWTIsqSpbnUlpXjRN
	 988hcRyCOI8UWFHz/f+qK5LDQHQXayVRQ3262j47Zn0Jqh760jpB+AGIZEjmyhHslx
	 Qqs2Y14lCac9UjAE5y2LlNmPZovL0mIlxziAqVpEYWF7VcSH/XugirGbUWyl+1JJad
	 +WoSrpl7AP1ruZ40/ApjycvpY+4AnxyaNTaAT+qJ2l5Ec76Lx2QiGxwb9aykDXG/Bj
	 ZE2WhLZrYRFfMMBbtAErBrjrpSX00IacUpKBWO3AqMz+Y2+flePrBdhMVItf47L5ux
	 lY1VLRG53p8sw==
Message-ID: <sashiko-outbox-199890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 27/51] um: NUL-terminate what is written to
 /proc/exitcode
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-27-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-27-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:41 +0000
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

> exitcode_proc_write() copies up to sizeof(buf) bytes of the write into
> buf and hands it to simple_strtol() without terminating it. So
> "echo -n 5" parses whatever the stack held after the '5', and a write of
> seven bytes or more reads past the end of buf. Terminate the copy.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D27


