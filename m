Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A2606D804
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oZNj4QCv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhwYqi2Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EJ5x6oSnf+RrWzbB6XOjg/oJy0lPZOuvIIJGGMYahYs=; b=oZNj4QCvOMzVHe+zM+W6YlH+3h
	ArvtOuCihP/HN8ul2WTsYbwSVS+hdGED4DNaGoun52jf+VfOFsmx0g53QThrAEgVof8dPfPrdq/eT
	15mqisHfgUGqYzZQOaSY3oMhD/czJB1nkD9hNdDzcExUNW9CuaQz9KoUJMsVXxgywbqbNxADdbnLG
	t6ue3a1YvJL3j5nLrgHDRhoqzCs5LvoWz5gbAivAmD+eUeUxfvD8AsXnNhP64000egnMUhRigpd20
	JjBN0kRParJ6QqomCfLVN3pLjNWcNxj3xcjFX1GOJeDvAWhhRsZ517pdYs2cVnvfE74acg9dytG+P
	DqGBH5SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39T-0000000AKNo-0qB2;
	Thu, 05 Nov 2026 19:29:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP390-0000000AKD6-39W7
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DF4B42E60;
	Thu,  5 Nov 2026 19:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3DA1F00A02;
	Thu,  5 Nov 2026 19:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906946;
	bh=EJ5x6oSnf+RrWzbB6XOjg/oJy0lPZOuvIIJGGMYahYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhwYqi2QU+5PCxcWnPTB3hxrvFDBanBpjqltnKnowdGwOrQnCfcILl/BCmwovaNzo
	 wp68GIO/nSzr/nY+0O2mYBFsgas/t8X9pDclsi8l3rtLr8f9yNbcTsGRq+iy4MJ65n
	 iPM2oWsFb0Z85B1qPfkhGzqkfncZWH+JeXHP4yd2t4cuJpVO4Y7yY85ohQIrqcGzeA
	 C7/bMiWsDMhTh5YJuMjMHWRP5Zy9sUTojv9oJFEyBgQPOPeojiiAhYUcSybcJI2n7t
	 19ML9X1uaSQk/DmhtxZof8n0vxdU5xWdxA5OrGQzUPOsV+PQEYss0Ieh46MVONkx2a
	 deUWye+6T8JuA==
Message-ID: <sashiko-outbox-199872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 09/51] profiling: report it when /proc/profile
 can't be created
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-9-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-9-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:04 +0000
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

> create_proc_profile() returns 0 whether proc_create() worked or not, so
> a write to /sys/kernel/profiling that turned profiling on but didn't
> get the file reports success and there is no file to read the profile
> from. Return -ENOMEM like the other failures of that write do.
>=20
> Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtim=
e")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D9


