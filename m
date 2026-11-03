Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BF60A2639
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v6cgn3iO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRLhN+oY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uVu79v5qeIUT2DHIeaxbzu36E3QvgQth4DXw9asgaKs=; b=v6cgn3iOEliCSFgL90sKeFb5zx
	Nh8VCREPCkUkgODikXUOxGCqGT9uiS4umIVDgN6y+1G+LpcxW6OaetGj0yVAvPVy8pgbY6BOJ6Tj6
	fBZQAd+0QIQq92Gnvv2pBarG6IzcdYnCGV6cwt/mFHt5Dg6JRAuiDQACLXis00UIUmZDr9/fhVor9
	3NnQsOiB/2QbeiphfxlEjTrJN24aAvVwa9/slU2SU2HbhV5vTMeNVzX95YiPH8pvMZjbwf5a1aK6W
	uHCzUEwQyYh7Sqa40otB6JPjxuYPqYgQvYvudkxX+icM80qohadG8AY6MQqwckMFRWubNhbPLolXJ
	BhzmKfpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnv-00000002l39-3Fva;
	Tue, 03 Nov 2026 14:48:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFno-00000002kw6-0GgI
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA387416D6;
	Tue,  3 Nov 2026 14:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF591F000C1;
	Tue,  3 Nov 2026 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717275;
	bh=uVu79v5qeIUT2DHIeaxbzu36E3QvgQth4DXw9asgaKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRLhN+oY2Yw9kIhUHybbJ0e+ZZSuOHGWuij+w15WuF1xIJSabw1wFMsLCqzDlmojy
	 TK03FrNF7bc7zoE1WvrzzaLmFvKEPPVLc1TPn5UU0/4/KYZ9h51Izc+12sOuXBzSSC
	 vvh8TIDoCAV3mG7NT03ZLOxqjAMKpkvDrBg2IEpsZg+kl1A4hzw/X7tZX8NCniQfle
	 ECsWaxAIfPq6+Q29V0SJTrPcv6uvKP2PxFaYrSLlpfU5Pt/3I1A8ccLjocNj2c6E7u
	 gB9WuCPj5W1+G/AadYSeW6R0FUQdierHCujXWq9jSS10EgcsXeZFeIAePUVh8txQO6
	 oGOGMufc7irOA==
Message-ID: <sashiko-outbox-195486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/38] um: NUL-terminate what is written to
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-14-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-14-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:53 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D14


