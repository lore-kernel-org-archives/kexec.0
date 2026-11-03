Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49631606FCE9
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UV6P6M6j;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POgogA4c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/loBqHfb9xyTXY5jVvnLeUezXneNMR139AeDEeuZehA=; b=UV6P6M6jn+L9Tmiy9goeDBBgev
	iGtC3/HqM2nrkl+1HpG9EEmyEo47/MZog5tO0Vb/yjbgw2gZEh1EZwwMR5OqT5GvWWNFFvKwhxgNn
	9P6w5W+aXMPURf8ost9v8wjdfOz4fabViod/jqSa1UmGQ42/RTCTBWDd82nQXGKRF/eMyc0C0NLgp
	Ibt221ekOPU1We+8pGysGVtCWUkefpAvkavwY4emp1w6ixGLQUeWD6nqX/AZBiJI2lPV6XuEolH66
	Bs9ZMHjIsoiNhrpLoczwpBzQEgTbttKwLizGYbDLWPBtqeOYHWXeaC/F2YifqrFZK6Dj2jwYKNieS
	Aw/glsNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG19-00000002q3M-4B42;
	Tue, 03 Nov 2026 15:01:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG16-00000002pym-3hED
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FCD84400C;
	Tue,  3 Nov 2026 15:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B61F00A17;
	Tue,  3 Nov 2026 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718100;
	bh=/loBqHfb9xyTXY5jVvnLeUezXneNMR139AeDEeuZehA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=POgogA4cI5wWOeMz1/cd+H4XvoMVMIqL2V+G+9Xb8VwCCRW83BzcmpLvxyFEpcbxe
	 /mCmUg5eXDwuaxyPwlwAvbKSw9zAx9Xa82K09Vni06bzfAy7YLvu6siA/ipSvBj2rh
	 qF1ewX3Ll1Mq4U/1lE3GqVU9xpuJunXOk7qadUPJ7/+1WlPF9/quSAmT+Y6x/gL7C5
	 3liOSC/FI9jN7BDbCH+iEIkaGanVOlPqZzbv9g0LZ0T+zR7LlVVDb8k8ypBMeF0A0o
	 YrstH3zBltw7mcoX5EIv/3z5moFT7qEVZnlXcgdb6E08qa2zhuTeeC8xgwd0aDyljl
	 khtjX69PBXsaw==
Message-ID: <sashiko-outbox-195543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/16] Documentation: seq_file: describe how a /proc
 file uses seq_file
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
In-Reply-To: <20261102-work-procfs-core-v1-16-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-16-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:38 +0000
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

> The example in seq_file.rst hands proc_create() file operations built
> from an open method that calls seq_open() and from seq_read(),
> seq_lseek() and seq_release(). procfs doesn't work that way anymore. It
> opens and releases the seq_file itself when the entry declares its
> seq_operations or its show function in struct proc_ops. Say so, and
> point the extra-simple version at ->proc_show() for /proc files.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D16


