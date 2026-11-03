Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92060A5BDA
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EcsjAKN2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh1dKt+S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Icn35Mi91pQ+tLfg0mCdB4U+ZmjGBtIaKsilMrrc5tY=; b=EcsjAKN2cVymBNv4bS6joz+PW5
	Qnh4bTQL0xAIG41B9W/f8myKCJcey7k4IsZ0FMoI200RyWv28shrIFJdA3dN1GqzxTegzfD7BFEDP
	S6T11FlZBsoZrshcobpk9cIV/aCYpjORqnm66X14yR4yUCKu2ppOTuCQtwnelZUJKasGt/wBE+77q
	RxYBhEPRiBsRnF3nywXXUvbxQczVGet70nGXlr/pOHA+S5XQydQnfpBGjaKBBaTraHKWeB1RiLtgr
	kxxj4u3JV5lZTjrW3DHtum2Z4zpRXkkp2VjJHrTvAJfJ1SKLoQYkdToZyY1oJ1qTWRtVvKafEUGFt
	LqPLSXSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFo1-00000002lBT-1dL3;
	Tue, 03 Nov 2026 14:48:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnz-00000002l8q-42bV
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B511B4381D;
	Tue,  3 Nov 2026 14:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441281F00A1E;
	Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717287;
	bh=Icn35Mi91pQ+tLfg0mCdB4U+ZmjGBtIaKsilMrrc5tY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dh1dKt+STUs/pEoLctpFFtQkyKCAxxWJoxXDNG9HNkYmLm1AdEmDmmdWV64Js6Az7
	 D7xeBzM6wvr24BHDVnxZNsmdK8y72d/Sc8fRWz9vjYY2X1n981YMEB3CvPmhvXhzoT
	 CdEliGimDf4eL7SpBrWs7GBDY9OjYAOjox1SovFaGTGUyI/vN6Vhs36589r0zEyUdi
	 mVeMd6wVewqD9lCD3HCijfRClz6bHq3RpQ/3lZQUAdmOC5lUq0F8u4W8MwAYT72JS1
	 NFUnHmQbjcLibYcuMjtBUE9DfbW903ryc3o/4VSRPIMZquWia85CdIpJWlxt1Ne+x1
	 8PIhBdEx8sqOA==
Message-ID: <sashiko-outbox-195492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 20/38] selftests/proc: check a /proc listing while
 entries come and go
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-20-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-20-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:05 +0000
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

> List /proc/net/dev_snmp6 of a new network namespace while a tun device
> comes and goes:
>=20
> - with a buffer that holds the dots and "lo", add a device whose name
>   sorts first, finish the listing: "lo" is listed once
>=20
> - with that device added and a buffer that holds the dots and it,
>   remove it, finish the listing: "lo" is still listed
>=20
> - with that device added, stall getdents64() on a userfaultfd page
>   while it writes the device's entry, remove the device, finish the
>   listing: "lo" is still listed
>=20
> All three fail without the fix, the first lists "lo" twice, the other
> two not at all.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D20


