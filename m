Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758E606B064
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lyxOHIk1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KynCzb93
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0Y90+62nmTyWN8rDu95xmVr4WrW08UQZKP5u1iiw3Yc=; b=lyxOHIk1prIG1F/rnGvLz0oSwv
	qkPIgLxYfxeZQE+iV7WAxyacIaurLuD06oYeWADsap2QPNGOvIksiZvn5TRrIOVuA18VUfKDkQpAb
	CHI7ejDibP1wpyqojkbwMlOGSSvX2hwV8uPbsIgkfS++/2XLgPFKO/wx340bGql6q3B/6HbBlG3sh
	SnJUf0QXWYCCPdwKJHTR+O1JuqcHQJnm2J1GlDgNjvdBCqaE4xD6GA8ayUG7wVf0/rsSl7QHJb6+0
	2+WQxRWlyD9r052Sv6wBV3pUm9m6WWIPUKqlnTObrWGiTNnBvLYlQIrM5J2r2OUgQJ4ldrQas9SKg
	fx/bIWBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bL-0000000ASsT-1TGX;
	Thu, 05 Nov 2026 19:58:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3au-0000000AScW-0ZtK
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE3EE42DD9;
	Thu,  5 Nov 2026 19:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653031F008A2;
	Thu,  5 Nov 2026 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908675;
	bh=0Y90+62nmTyWN8rDu95xmVr4WrW08UQZKP5u1iiw3Yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KynCzb93jkCBa5XgAWl3yl9M0MTpo3fxH9GGhodXmsFvHVjoHrH7fC+ss62AYBxh3
	 I2L0c2a5NWJkrTtaMLAFCb0YpREbRTcfJDOpJGBwIDXewFn9Z8ZiqtEhC4P6mcbj6m
	 SFTFzfvvToOSL3d4M0WtVj0ToBnc19Pvn5LF4z5IE5o4EMjoAHnxFEXg5Kkx0Ds3Os
	 12N+atsPV+EcqCPQBvgkEGTq6zB8hfUcnsT60L+cAHou3s3B6ZpTb9Oexwi673zZ6g
	 PA+M8lzFtMydtOAITauMFceBvtdRNHvZWcaRerMdas+D0BM3yOmBnUicVq3olC4LSn
	 dmNJYcXoE/eyg==
Message-ID: <sashiko-outbox-200047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 13/30] locking/lockdep: let procfs copy in
 writes to /proc/lock_stat
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
In-Reply-To: <20261104-work-procfs-fs-v2-13-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-13-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:54 +0000
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

> Implement ->proc_write_buf() so procfs copies in what is written before
> it pins the entry, and look at the first character of that copy. Writes
> larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D13


