Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F6606D802
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C3fGYMNx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMc4cr4T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4+bnBfQZju8fpAB/8X14BeZjZQCkdXf0D+qDeon2Ak4=; b=C3fGYMNx17yuujNcKB3biae0eU
	B3YV1Ka+WgmxnBa8StaHhoOZZW6CzyVepE0wfJVbSFogiKBDygwZu6IiK1j3a/c/q/lpuoV2w4enx
	9Bb2r30+2+SA9okAOmvdVorp0L+5wIM2kIQ20oWhXoZfik7tFvW05AjHGIVd4v30XiB9tGH41Fsgo
	OylyYMFF9Jjj/VfOO0R7IS70pIv/D5jvQfVZZhaWVYPqAcz5dyQwyBQukzneGPBtG43Sxax6Laa3r
	uihnUmBxqk9O8uWBU6A7UyadL5Xj3gpLnyXnbLihI05tJPhUQkSTTunSGkWiYZr6tNdxhpHXSJkTw
	rKrg6rpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnV-00000002kcx-2yXj;
	Tue, 03 Nov 2026 14:47:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnR-00000002kbd-3KeV
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A2A343C3D;
	Tue,  3 Nov 2026 14:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E0F1F000C1;
	Tue,  3 Nov 2026 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717253;
	bh=4+bnBfQZju8fpAB/8X14BeZjZQCkdXf0D+qDeon2Ak4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMc4cr4TMiothzZr1gQV3jJQjTeueKFUXv5zwuxzcbh5/HdxeLC2IglsSlv1VEwFv
	 Ur/LQ/eR3wSsqQbS8ZUk0SCD2Jx4kztRhXfrHkH4Xo77UmXiqjwaE6vDGM+mgmJYHJ
	 tuYlF3IhQZw5QVy6DfHtL2C9tEk+v13TCjTgx+HnNYr8+fPG6IYPcoxzaksDgA2jAp
	 31qr2fSSwX5A2grnozzQ2Af9r57Tn+8pY9j8ePIL8X9VbUZE1bN2J7wgKWw8Wgp+BQ
	 6U7CHQuUZsauwLE/6W1MtHqTP42XyAHvVqnScnEzcPB+Ebjn8acd6ZXDg8/h4mKSSS
	 gUZdMs5bhS6lA==
Message-ID: <sashiko-outbox-195475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/38] netfilter: xt_recent: don't remove the proc
 entries under a spinlock
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:31 +0000
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

> recent_proc_net_exit() removes the proc entries of all tables with
> recent_lock held. remove_proc_entry() waits until nobody calls into the
> entry anymore, and reading one of them takes recent_lock in
> recent_seq_start() while procfs has the entry pinned. So when a reader
> gets there while the network namespace goes away, the exit path sleeps
> with a spinlock held and bh disabled, waiting for a reader that spins
> on that very lock:
>=20
>   BUG: sleeping function called from invalid context at kernel/sched/comp=
letion.c:116
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworke=
r/u16:0
>   locks held by kworker/u16:0/12: 4, last CPU#2:
>    #2: (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xbf/0x860
>    #3: (recent_lock){+...}-{3:3}, at: recent_net_exit+0x3d/0x170 [xt_rece=
nt]
>   Workqueue: netns cleanup_net
>   Call Trace:
> [ ... ]
> with a proc entry pinned takes it. So take recent_mutex instead.
>=20
> Fixes: 665e205c16c1 ("netfilter: xt_recent: fix namespace destroy path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D3


