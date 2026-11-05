Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A11606A33C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dEHJEX2K;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nyw43+S2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R0jppsKfpO8c+Wfs9tyOHakvTx4OM727OOcLj9g2iGM=; b=dEHJEX2K+fVRx/20a9ETWhqm0M
	xtPwqJ6lYZd0c5yq3Ho93sZaumoV0NTA2F23J7yoOUFOjpFFDmnZhqA5WpaI1t4GoBtX9VwgH2C6Q
	ui8VImW+nM6ieGJfDdSTEhUKKmSAyAPAdwZnpcaAL5kmayTM9hcL4dL1JWNXqhWEeOxgOpbG4a3I7
	yKRz27SCwjJq2r2tUqCyjva/YflKuoMvcvA17ZhVDHjHYHIRjXSbzzAKHzkxn/xypJHcsJsp6l8En
	GJi6hmBUBMZL/RHvYwrO9TzuAoQJyVxLGX+8SLCIhL19pS+KxOwxOo7KubcwNiJQSoPBu/jWQo4vU
	qLAADStg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3VE-0000000AQmU-0zuY;
	Thu, 05 Nov 2026 19:52:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3TI-0000000AQAQ-2xvs
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:50:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7633443EC5;
	Thu,  5 Nov 2026 19:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A981C1F008A3;
	Thu,  5 Nov 2026 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908204;
	bh=R0jppsKfpO8c+Wfs9tyOHakvTx4OM727OOcLj9g2iGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nyw43+S2a/7VyDX8w6xahvn9ZApqn4TJ0kh3YRsaUxeU/PqvpCGltRfC1pm+S/RKN
	 0nLdp7uPjhnxLJrT4PEIRs99H7SQAAMyW5Dpkk6h/SVdZvIPpBfgtxl/1VwXucqMCF
	 OoxStV4jZM3fRilLNS/gPiJHRRMgCNmYxkJQFK62QUdzRl0BOMQxUyKfrlaAVb+wzL
	 8MBqjgPOLXXRGgYlOZpPHg6AXB4EGv8eXqVu+otJc/X3aF3UdhH2Sq2mQmlcePMx97
	 MQvhPaBzySigSxDPgMHxqO1ydd1YUYiYyo8odeK6rXwGa0X8QKpBySn/dsFO67X87C
	 imselCmGHpGHQ==
Message-ID: <sashiko-outbox-200012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 26/26] ALSA: info: drop the poll_table from
 the info entry poll op
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
In-Reply-To: <20261104-work-procfs-drivers-v2-26-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-26-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:50:02 +0000
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

> procfs owns the wait queue a /proc/asound file is polled on and wakes
> the pollers through proc_poll_notify(), so the poll op of an info entry
> has nothing to do with the poll_table anymore and only reports the
> mask. Nothing in the tree implements the op.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D26


