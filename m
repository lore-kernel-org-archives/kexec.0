Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C93606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yCcUCgxk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJPRbspg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mQEVulUxsU61vokIx6jmHabvMPsxzjhVa8rHi8fRknI=; b=yCcUCgxkJjZxYbtXTT3GAb8yAM
	57lkBXDzQYtRmA8g0FmLj5I9PXmbEbvco/rhgu8ObdS1Gp+wW9gRaKNcoklPz8VB/1zAhpuUYHAaF
	DvWUG5Rdh9ERoT/j9bGQrX6wCs4NXvgVQCWjKbEjNCaSJRl9GbYngw5Xw6R54slhJ3iUO2Besgumv
	PK/LOyvdqmO/4dTf/jPeVaj7MPWO1GMIDfaQyQtXlGuhFXK4T5J/tG9DXmnd+nH4icd9cWZ0r/q9q
	AJvYwICwGMQv4PTZEEsLCDPHJ4zJ4hEKuDRUsOZkbkE8kFjgdO9aEQ1ab2LaE9MoImf+F/iqCkwnj
	zFksS2Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Fw-0000000ANAe-2DbJ;
	Thu, 05 Nov 2026 19:36:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FG-0000000AMrd-0DIm
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C7DF141ED4;
	Thu,  5 Nov 2026 19:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02E1F0089E;
	Thu,  5 Nov 2026 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907333;
	bh=mQEVulUxsU61vokIx6jmHabvMPsxzjhVa8rHi8fRknI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJPRbspgI9rk/ntnFT1Cz7ur8bIM5VssB3TQzm0TW2aoD1RFCmBj9VlLj4hJBQb4/
	 3/FDXpGt5pRBVYUQLnI6BUhnjhk0qTTW2X6mOTlAQFnrxBKc9wf8/43w9BURk4upJW
	 3VNEO+qgIAG0bqC5kDBUhoD0IF2gAAKd+DE2AwVQh6jvyFihiqkp2dzzMcl5jFJ5r0
	 i2c/y7bCjMI/F9vPg2NyoywBBItlJhG9YfDhWfHMm4cLjcGerM7HRyFf623GBrcyEz
	 CHLXwj/sU544msIsOKcRsTFRCBV/+2TizsDpFZX0Bbjbrdl++J4WiLF9eJNZcq1/bk
	 FneIVv4bPKAOw==
Message-ID: <sashiko-outbox-199939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 09/23] proc: let procfs own the seq_file of
 DEFINE_PROC_SHOW_ATTRIBUTE() files
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
In-Reply-To: <20261104-work-procfs-core-v2-9-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-9-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:31 +0000
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

> Declare the show function and let procfs open the seq_file.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D9


