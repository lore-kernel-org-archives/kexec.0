Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45088606D833
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wvI7WCbi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jajaKVz5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ID7LC75za88M69BElGmlUwzZxk8blr2d/qu4Qw48pXo=; b=wvI7WCbi3am/0e/w6pmS7WY+6l
	E5g9aXzRiF0m+m5PqkasUOf2S6omcA3pNyYGhqF+sUND7gNKRzvFR8ohilhLqW79QSDajilB7oDSA
	60a0VoAkxLcWuOu0QOu/U6w8qCuRfOItvl1hkRlXUztb9yFJJ7bhJ/2ahzErHdVIAJW+Tzdm1+ZaO
	LalHOXA4YxhhoQ07GEynU25My4aRKb5xz+MM0caOlYK43ajdBVq58gLuts6cTQasb7GkUE/tD2Sw/
	x9rxFk7KjcbBSMUOIdEQpvpVM1UqYWJOvv0dAOKxnvaccBZtluPcKnrehqY2AgAFrumGKtNnJU+GO
	2VKBv6Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0a-00000002pWt-3tio;
	Tue, 03 Nov 2026 15:01:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0Z-00000002pVh-2Jh3
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BB34609FC;
	Tue,  3 Nov 2026 15:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5311F00A1E;
	Tue,  3 Nov 2026 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718066;
	bh=ID7LC75za88M69BElGmlUwzZxk8blr2d/qu4Qw48pXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jajaKVz5uF5jV8KNkaRZ9jm2p4d6qjnBibcW+RdQG415ddsGl+0d3bo5j0mleaLxm
	 RwN0oymilT3njGexXy56725ypD8aMhBv35E9z3nBKq7iYYj1uGr0z2x1vioz+IJ0zr
	 CIMhu6ko7LsevcSiGh6ht2M3uptrpuTNi8xCLl9RYAGb2JQIB1dYpM4tY3O3Yj0v1Q
	 i6wOkRWSaCouWbczxv6hLshYtafnWa40AAByma6d3JjyufxRbPRcUODDXJFJzDRzTt
	 QFQvvpET6EoFeMBD9/m6afIrzXxj97ddDjVi2YA1OzWzbIgGVogylw7h1FKknnweMl
	 qgPPLhzd74S9A==
Message-ID: <sashiko-outbox-195530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/16] proc: make room for more entry flags
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
In-Reply-To: <20261102-work-procfs-core-v1-3-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-3-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:04 +0000
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

> ->flags of struct proc_dir_entry is a u8 and the next patches need more
> flags than it has room for, so make it a u16. Bit 6 stays free,
> vfs-7.5.mount takes it for PROC_ENTRY_CANT_MOUNT.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D3


