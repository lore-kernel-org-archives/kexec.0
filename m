Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43506606D806
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sZ4GX+KX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iq9eyMHs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CcwQtKt8p98z3nZ6v7GVVoJYg9XQ/4wAmXztnPTRoMM=; b=sZ4GX+KX/nBcIy7e3XVV39fuAo
	BFD560U0RNrWHTsu4kdP0l8TrTsZ2ZomGqThZvXQy5X2x7ZynVQLeAuc2hHlq82cW4gsPrsF5d+BB
	3qenc1SocGjOCbQ2UUJLxPJcSbuSOHMdkfCCcKSKExH+bw08sjuPl/RuBQJMrM7PWA6f3b6Xl2Sn5
	rIhCnWyj76bj8/dBWPRnA0d/Qys4v9Dvzo21CkMQUGdvH0x76xpOG0wYgXv0gwhoEGj0xGi5LIUeE
	UKZv0dFuIGp/mATmUY+ERwUqPIQD8jUobT+m+j/8QIKy6dmR/LQbJohlXkR47gGgQqdmzJcgzwZFN
	2xkbsy8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnP-00000002kao-32o8;
	Tue, 03 Nov 2026 14:47:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnO-00000002kaS-1J9G
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6097405EB;
	Tue,  3 Nov 2026 14:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B51F000C1;
	Tue,  3 Nov 2026 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717249;
	bh=CcwQtKt8p98z3nZ6v7GVVoJYg9XQ/4wAmXztnPTRoMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iq9eyMHstCQbbT4lxVLStphZgJXCXZr1LD+8HR6zoL6SI3XDnTvNIL7/IDGpiWoGp
	 6LRT+Jf2/rw2ZagpH0lSWUv8gDqvFkOho1ggYUba4Zt/1LHRWciRdIZRjWztqUNVxr
	 Gy5Z8RmZ/iuH+xhZaiYaZPzNzQsw6jFgukUstj9zpOX3Xo50vy1HO6bgCkwskOaFTa
	 8furxKuxrl5c3bNBuHpiiGPAiANnExVG5tU1aQQd6AWUt1g45eCWa3KG+rhy8MieOn
	 t6P70wg04vvmSk1BoQp4Tq9a7jvOLdGxp0nvIUBUxQGtmJ/JQPHcuWhvMX3cPcoloy
	 y+Nze7fZpewzA==
Message-ID: <sashiko-outbox-195473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of
 config space accesses
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:27 +0000
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

> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative, the check against the
> size of the config space passes and the count it clamps to ends up
> larger than what was written. The loop then reads past the end of the
> caller's buffer and writes all of it into config space at negative
> offsets, which pci_user_write_config_*() pass on to the config
> accessors unchecked. The write also returns more than it was asked to
> write.
>=20
> An offset above 4G that truncates to a small positive value writes to
> the start of config space instead. proc_bus_pci_read() keeps the
> position in an unsigned int, so a read at such an offset returns the
> start of config space instead of hitting EOF.
>=20
> Check the position against the size of the config space before
> narrowing it.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D1


