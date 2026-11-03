Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6C606C853
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XJHerFBH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS/unFTJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CZitfjPRWrqbc1UugEpoY/pCdHKs/Ak0rSBgNQ6MBwQ=; b=XJHerFBHkVh1NUS37BfFoo+xQV
	OzTH0n+3h7n1M76avnDaecYNLR50mIS0+LQDd591Qtj4JTGbkYCsIXtdKI2Zxcp51s1PyawwTzUpX
	E0qwhJypyASbpF2+DbH3tsCNnz0HoUhkdFcSHdUdvHfS50HU+6KX+Edlrlcu0yaRuEadXCJsMKNZg
	YRbLV76LwUOKeSbGb2e2GAmh8xkexdh9TDcSp6E99KcLpQWFb6QAEyVVkQ9mWCvaD68YJCqjfI/r+
	ZX1EdxUXLanMifLytNuOwZUCOMyjo6C8gIMKfdbD0t6dGGLvhVS4jxBPPxgdLEbSHgcW0/63C5MlV
	D4xJ3VDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoS-00000002ljq-3iwf;
	Tue, 03 Nov 2026 14:48:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoJ-00000002lYl-2tG2
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FF83609F4;
	Tue,  3 Nov 2026 14:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7911F00A17;
	Tue,  3 Nov 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717306;
	bh=CZitfjPRWrqbc1UugEpoY/pCdHKs/Ak0rSBgNQ6MBwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BS/unFTJQBCgBdJJQEKrq3m4FFXM+1Tye2f6vDO2eS408GceaDi4Fta6UOVzoQLP4
	 zPuiIi740ueizm1BtHY/HHB7VqgikK8iTG9o8Y63KAWnNgIhl0L7fMcLj2NGI5IgNC
	 oINvup30ow3k7O9GL4AwA0eFFJfTKQRNqkKaQbf2gv/ikZr9Xx+V/SH0Empjc44JZt
	 2GySUS6y02hSvYHWLBEAjlLxTbDT6Ybn3oGw4xRi8bo6d4KF2eUQf8dpbJCu/dQFlw
	 CRpL8LrbCxYMDI2YOnG4mio8VO3TgsHCf+MaGYmj6SJlaVmu3CaHdhW9klBgICCnHW
	 5aUnXrTjG9RCg==
Message-ID: <sashiko-outbox-195501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 29/38] powerpc/pseries: bound the lengths in the
 ofdt property parser
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-29-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-29-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:24 +0000
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

> The commands for /proc/powerpc/ofdt that carry properties, "add_node",
> "add_property" and "update_property", can make the parser read past the
> buffer they were copied into:
>=20
> (1) do_update_property() computes the end of the buffer after
>     parse_node() moved buf past the phandle. So the end is off by the
>     length of the phandle string, which can be padded with zeroes, and
>     parse_next_property() accepts a value that reaches that far past
>     the command. new_property() then copies those bytes into the
>     property, which everyone can read in /proc/device-tree.
>=20
> (2) parse_next_property() parses the length with simple_strtoul() into
>     an int and only rejects -1. A length above INT_MAX turns negative,
>     tmp +=3D *length moves backwards and passes the check against the
>     end, so *tmp is read up to 2G in front of the buffer.
> [ ... ]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 610d91511f99 ("[PATCH] powerpc: Add support for changing propertie=
s from userspace")
> Fixes: 46db2f86a3b2 ("powerpc/pseries: Fix to handle slb resize across mi=
gration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D29


