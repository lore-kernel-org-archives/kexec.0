Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849D606EEA4
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=weAfPm4o;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMSRzi2i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AHZE5U1/G8L/MKk7wGGr6FGK5Q6/1gif03quLsojNHQ=; b=weAfPm4odeV9x62Wl5qymzUUS9
	k5cPBJFkKpF2Su4ygx8j/AJWvy2owWAJo42W9Nk041NlzGxo4rYzbqVVaBUpwI/FDkEq/JR/AR2p+
	IwsN6H00r4NwHnfJry3aVO84dZOzUH0siF05YTnGd2gH1Mz32cv9x14i6ZKnUi7C3RipDYwz3Zsw5
	YuI7bBq+MhTbYzx9yXTL7mnqw4TK762VidDO/Go6ignV44JOIbku+lCoTbuTSgG9teezwQ/5Gu9Cd
	T9QF+j43JZJrZ1npdPGnueqT3KrtqHxroS0jEdY/QDPvhpJLFMRCTXAsR/9sduZsTaRpFnbShbQxi
	yaD3EFHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFna-00000002kh9-0VOD;
	Tue, 03 Nov 2026 14:47:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnX-00000002kgD-44W4
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B41B643CDA;
	Tue,  3 Nov 2026 14:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DDA1F00919;
	Tue,  3 Nov 2026 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717259;
	bh=AHZE5U1/G8L/MKk7wGGr6FGK5Q6/1gif03quLsojNHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMSRzi2iAFg28V5GkWAlM9QpBqGeZuRWtZTUm0WRq97ectI/p3rTRq3mnpNy7ngxS
	 UobvvqSTuRoo9QscSCN7Ayu69nZQ2kTxWUzR7HxT93yBXyY7WzAqTZdcWVI2zEAQ0Y
	 wqTqaA4cjw6oZ+WaCsoJFAWRYr0VGsPFK2+ApHxBe3UdltXRfdUBqr1CozJORTaIKE
	 Jgw4HsGMz1cEl/teFT45xpUxDv6vM2m9aCJlOtQfMTOAoxPRwRZc0ehArjp9mz3UJW
	 tgQf+8MJB+svNLyVTvanGS3UaTeuGomFgYbJOww1liMOiuGQbS1iPFbGiH199iIbXN
	 HucjPbCeRQYaw==
Message-ID: <sashiko-outbox-195478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/38] xtensa: simdisk: don't read the file name
 without the lock
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-6-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-6-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:37 +0000
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

> proc_read_simdisk() looks at dev->filename without holding dev->lock. A
> write to the same file detaches the disk and frees the name under the
> lock, so a concurrent reader can copy out freed memory. Copy the name
> with the lock held.
>=20
> Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D6


