Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66D606D811
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wE5irvBu;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A468O/vZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qAOPaMWfnZdlwVSHYL+9rw86rJbtw6B991RXjr/ZT6w=; b=wE5irvBuIB/ukHvnwQrtTfTSgg
	MK6p8opDRoT8i5E8SVVy2AoGxgtg/GdguKXlu6iGvNfo6Sej+zlqY5ye0mloYTSSYtXc2EqWjfYEx
	h2jGkeYo903cvg2D26wz5SPmxBzR3AoqfXSdQI0A8Z5aQPAXOP6lu/3/U28yURD5MzhTqfXJN7dBQ
	vdeH3VVp9m+eGkbpoCeaVVOIUYuyTzifbfB+4qRbtAQ3gm0tChTxQZOf9DoJUzOpsNtFMGx9X0yr8
	Emwfzq5hYb0wlmHsrKBim5WfjwD4wBILH5UD1gudvbOX+gLLp/kDAKPGuAteof6bGIVWob5PSW8+F
	WhxqY/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnc-00000002kjP-0xzd;
	Tue, 03 Nov 2026 14:47:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFna-00000002kh3-26OV
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B95866057A;
	Tue,  3 Nov 2026 14:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B431F0093A;
	Tue,  3 Nov 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717261;
	bh=qAOPaMWfnZdlwVSHYL+9rw86rJbtw6B991RXjr/ZT6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A468O/vZdHBCD7UZ8UlB4cSW6Wo1lS1VWajhi1pTgPoFKYre1RGq69cqrrhcrxsuF
	 k422eyUGzdP7ofPMeyLy6mjVTMbhvybiUdIWqaAx7URHqDYYBVQn6dZGzbDmUfE6un
	 qzuotRGPVzOaL405ACUuj2CaDtKcaw8pCw0kTqtzCJN67C+LtIgWy3OieZgcrwMx2t
	 zcaPbLjrTJ+q8VGMuwdq9ud2hPp8483QXmk3XHJSNg2Z2p61qNJyklOPHI9wXFujkU
	 I6veXuBMM5qIzCu924WMLvJ6+BN/lGnAxoVA5YXv2Dy7ECUP/Z98JhXC/AIwYDtl6B
	 3k+Ju+9+jEFyA==
Message-ID: <sashiko-outbox-195479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/38] powerpc/rtas_flash: don't read past the
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-7-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-7-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D7


