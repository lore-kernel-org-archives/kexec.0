Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14798606A6DA
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sBdaf+FY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTDh6JUZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qvTECsoQq7diLH63c67HY1Y+MAl91kcvdxj3Yxdj/RM=; b=sBdaf+FYTmMvLLbqWsCZXEd1j9
	1StzU9+mJ855eGjtJXZfE0EffNTo2obdZuFYndS+/dL/iXhyeEvWuIR7a6mvNV7AwJdl6NMIEpc0M
	cgjTq85O3OY2TSE4bPHaknDK9AmDeEFPJ4ZdSHAd0RFgRHT2FRTY62+OiKGsVfnf97G5EAWnF5uuO
	lGNK/r5ovu8n7PK+ZcKVFe+DtVZ0zgK2F4crSHRj06EkBJnsBpTW/iHpjc4Hp+UH1wCpYB/b3UMQ8
	c1OfwIYx+XsAiaSmU8xFaegrtfEyzxrNNLq3OYywasbS00HcMe1gi/wCCnX0Qsun5ph73Q2FDE3yZ
	bvCdlvOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bL-0000000ASto-3EYf;
	Thu, 05 Nov 2026 19:58:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3b0-0000000ASf7-3kdO
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 397E760214;
	Thu,  5 Nov 2026 19:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E41F008A1;
	Thu,  5 Nov 2026 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908681;
	bh=qvTECsoQq7diLH63c67HY1Y+MAl91kcvdxj3Yxdj/RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTDh6JUZxiIl7ZAL6qlwQn5+v0vnKTderRK+PLsTJN/oQxZhqZs4NvItFQ/UwIiwR
	 0ytPs8j3lohSXxg5Q8nkA0JeEf4xX2VinKsIB9Lhkj7Pdi8C17PHoo2xrKN5CgnCGn
	 9OwnQMlu1+G9K1qePU+Nfoo7dqS27iNCPpwMb3Y4Z/FP4V0CJWTDOqo0NsI7MIrhKw
	 rw2IwQxBa/bBxkqIfSbS3xUMeJ17ekXV5ZO+XkfF/t8shPIX98nm88xOpyW2INzSGQ
	 wh+8Br1s5sA+ebYY9Mxdlw4rXa2kZ3od6LuqlR9YyuVfpjVwxJvXZJjwCXp4kzM+0V
	 6oTHvAm1wJb7A==
Message-ID: <sashiko-outbox-200050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 16/30] profiling: mark /proc/profile permanent
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
In-Reply-To: <20261104-work-procfs-fs-v2-16-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-16-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:59 +0000
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

> /proc/profile is created when profiling is turned on and never removed.
> Say so with PROC_ENTRY_PERMANENT, procfs then calls into it without
> pinning it.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D16


