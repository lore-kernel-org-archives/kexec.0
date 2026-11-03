Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADA60A2622
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hh6MNE2n;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXfOxjF1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kvVp6/NtD4O06uidDq3MP9X+fjlnBdRcW45/WP+WAys=; b=Hh6MNE2nob6ZilRL+CxgKJ6Viz
	S6DONRUFV+mWkUOxPOwb0phNO68CL6BzxmV6S4yxqVcPIkdEb1KfwlZoFw5lu0NKmsIa+fXBoRm1V
	Si3GtbcXIuu6b3fcqcm1dSnvIpza/MgZsD3cWOVyeWGbjFzu0houj5QcvZnqzYjd0mGcugos5hzvc
	XhHpxcDUq+Bv8BA07pT4Yel+KTPTxsuDW1sTVxbTJIaOf5zNIkJGM/BQJGzKjh5nmpY0XrUqfwUey
	KNW/h6tRUGxFRzhcXWIr5Cajd+P5/oiWuUo85ZAL/QsyFCgZivCkx7glmZn/oJwjJ4FpJiRm2J2og
	cdpE//2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0h-00000002pdp-1pkQ;
	Tue, 03 Nov 2026 15:01:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0g-00000002pbz-0hNX
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A270741383;
	Tue,  3 Nov 2026 15:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815491F00A16;
	Tue,  3 Nov 2026 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718073;
	bh=kvVp6/NtD4O06uidDq3MP9X+fjlnBdRcW45/WP+WAys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXfOxjF1cFFOFEeIWx2xBBnAGj77mnIVsvzVgjKhzgr0aqmFy/7m8mW9lEar+8Gjk
	 v8RY/QaM2uCeWfqdy34Mf/rBHgTDRvW5o7+chp43A26AiLXBmD/XfUpAxR/m6HPuvT
	 zJCtoefjleVPx/b6O0g6IeF1TPgVhPsueLpekkb/UkQuFbzbZeP3FdjzqUM056msL7
	 PbV9VDBEK5qU8KSuh9oEBnMpWE49gjG3At0fGXJWRjk6w00B3xBXGEvETcL9ykXr5t
	 A9zIdU4PQivKxdRrE/HP047xrSqTkkvO9699obHnimL7KMB7BxtBBEkHCbOPtxypsN
	 iBvlOP9dg5drg==
Message-ID: <sashiko-outbox-195533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/16] proc: let procfs own the seq_file of
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
In-Reply-To: <20261102-work-procfs-core-v1-6-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-6-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D6


