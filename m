Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38125606EE93
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FuKFz25f;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecNUXxnh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q0d4FPmWtZwKMh/sPGL0i6hRLuYL8e+WwbXcE1bGJN4=; b=FuKFz25fH3tO59EUlyMmQdV8Xn
	6diu4K0CNUF24d8NgTY+BOWLj17UenUVzU/ya8zeOjltrxmSGJiHmVKgmhIyXGBQmg168Un/567we
	/lTGXCVc5m8na2MlvzJNfPSCg6AvBRt7RFPQYAM2Zupg/mOQO66tlmEGH6XONhhGj4qinVD+/x2gM
	C5x2gn3ffFbm4HdG1lN5e2NTBQ6N3kxqnLZgpaiG6ZGJ9/sBGys1cAb98KuVfsxR+TURYhAcB+7BN
	CZuT21MINNneqgvqqG9dw6yrhJdsQ5XdriKQZYKYtzoUIhR7qFsevahlDgcjTomN4pdd94E2AHdZT
	RbREoP4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnW-00000002kfF-3eyZ;
	Tue, 03 Nov 2026 14:47:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnT-00000002kcw-3Kzx
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C2E0417D7;
	Tue,  3 Nov 2026 14:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75901F00A16;
	Tue,  3 Nov 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717255;
	bh=q0d4FPmWtZwKMh/sPGL0i6hRLuYL8e+WwbXcE1bGJN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecNUXxnh2OcVVvSa0U3huTG0L9O+PzIB1xuXCxIUp/GZPPPzipCpRc1/qlsk4J6CA
	 x7U8X9eMczAWPO2ZaCpsl6YNtO0NoBu0+DXnA39JSuS9XY9AjGBFyXlc/Ccq4RTQY0
	 UAugm1HYHytJJ48gGhh5Ikw7HuDNMAn11k6igesT8J9xgHn79oAIaLwhkpwX1VrdQQ
	 +5bvleOIuzZz7sQeEwq2Hki4vo4gTrOnLMNutAIHZebuy2qBXQktzKVc8aWpJCw5wT
	 EMd2yrUC+CDD8BIHuYrdGWQwA/PwlqJVUVRxCdpabP9PdTkesHJyvmQoHa6OBE4VbX
	 e+c9Js8H66prA==
Message-ID: <sashiko-outbox-195476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/38] s390/dasd: don't look in front of the buffer
 on an empty write
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-4-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-4-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:33 +0000
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

> dasd_get_user_string() strips a trailing newline by looking at the last
> byte that was written. For an empty write that's the byte in front of
> the buffer it just allocated. Only look if something was written.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D4


