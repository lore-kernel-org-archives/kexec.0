Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650A60A5BDA
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Phn2nK8J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jROEVxEx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=odwwA5dfKcUGiw60p2ABSqsoXHD3TJfwohDjWQjtLjY=; b=Phn2nK8Jgxp2h7WcvK7SIxjeQx
	Ia9UKlSITjJUtePlDWDvFMpEEQfYq4PlCmkbey796/jonBJSZubKo+V69jD30KYL0f0USMDE8ukz7
	50hohe0Ds8nP80aOlGRK4RDAE7Pa6gvIvbgdGs2vTbfPa+FhceQzLupuOFSqdWmQ7EpritsVjEfcd
	xd5CW5PxlwW60nAj6p52TqunUWPnicYI81URpqe6KovXL2O/D2/p+KlB/S5Aw9DW0K97fz+U74wcG
	QKZMzRg016C/Nln5g8umXAG3blYF3kIHWnjEMUopOUPHXPb7fHzOdHHjqkP+ki3V8CzmpjFyYPOwY
	yNCOPkdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI4-00000002vag-2GRf;
	Tue, 03 Nov 2026 15:19:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHt-00000002vMP-48vC
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA6AB43FBA;
	Tue,  3 Nov 2026 15:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56581F00A16;
	Tue,  3 Nov 2026 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719141;
	bh=odwwA5dfKcUGiw60p2ABSqsoXHD3TJfwohDjWQjtLjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jROEVxExIThFpbsqA5xAGqUr9cswA8n2qHqo/aORqRE3FqTOEu/Om15ERmPiYGlIu
	 7g8q1aer7mGKtPa4BqJW1SZkElmqfbsX5POPH2ZXnXV8g7aCzKJTWAAN/zeDNaVUwi
	 kOyemUyjCavVCYeryJNauavuuGZorazBlwZhrNEkZ71VuyzAeAKZS7rSdw1kZNZ28p
	 oTmkBcf0kJ37lxjbSjKNMU9ItQ3w+BlCooP4cmHM0J5+lHMYE5pCxdn7eLYdpg+45U
	 WKo06U7ovfEEyFZ2fAApo+ge7BawSBRBymU5M7v3K7NHSLfSZkLVc/EQaw+9hkcs1y
	 +QDI9KvU2B7Jg==
Message-ID: <sashiko-outbox-195596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/23] fbdev: viafb: let procfs copy in writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-16-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-16-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:59 +0000
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

> Implement ->proc_write_buf() for the files in /proc/viafb so procfs
> copies in what is written before it pins the entry, and parse what was
> written from that copy. Writes larger than PAGE_SIZE - 1 bytes fail with
> -EINVAL now, the output device files refused anything over 63 bytes
> already. kstrtou8_from_user() looked at the first 10 bytes of what was
> written to dfph and dfpl, now the whole write is parsed.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D16


