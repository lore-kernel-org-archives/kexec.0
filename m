Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357C606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wltN2woQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7HKWZpd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KYpEmlst2RMAqFXyOGI9xQrnSxV142QmlHBMWmUsiz8=; b=wltN2woQ5z8KVVz6p5ByMJQkaI
	tyNLFWnK4B0yuZR0uPtDumtpf/rGVyGek4nbQUH8xEo1IbXDc6VVpnEJg8pWL5j0nvNQjPnXxE4VM
	34TzHy9kZ0gkng6l6g5dwS5Mc/0Ll3gy07IbfVO7QdvR1W3QefZjYkbiy1lv8Q7j6LhpXhexpHBOr
	S+0PAN0MjhKAI1kJQrVgsLlWzeLHXW3Rgc826J//4PYF/25+rK7FTPR/BThxymaUbdnWavG+t2lOX
	0nkZK3L4sgwv1iqGrGqvYVPByQGU2UnTHZ0nD1ZUQoRI3VSL32oRB5TH2VZI2V/fMcBPhIRLuADa+
	ZJIpimzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FI-0000000AMuS-1G5c;
	Thu, 05 Nov 2026 19:35:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3F7-0000000AMoV-23v1
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EAE49601DC;
	Thu,  5 Nov 2026 19:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1833B1F0089E;
	Thu,  5 Nov 2026 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907324;
	bh=KYpEmlst2RMAqFXyOGI9xQrnSxV142QmlHBMWmUsiz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7HKWZpdJlBXoSwsMjTjzNPkVew6KHrh4fawwQ2ulEULxhqG9XivG3Fp1ISuAwQMs
	 Hbq/80xvcy5mK2zclNAv5UeDsWP9xoAeq/jUyUIkH4aln+AG0f8NlrzzD8Lp/NDA2z
	 asdv9M90m9ShsSX4Ou/gTVHerHVAH3lLWi5CocYCqRvM/6bWUqB04QX6LVAK7e1GKK
	 UzVX0OSOF7WsaBpjey4MAjogWboVvhDsYVxoh9AXfTdllPpwKgRpIWe53zpJYPr6YQ
	 eHh6pR2ZAvzxF2Dj6TA9K/8Ca7BrjKlLNX6M0uWnkQFqgU9vYgoQJLLUshku7SS+Fn
	 EUH1IEGMOTXBA==
Message-ID: <sashiko-outbox-199935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 05/23] proc: keep the open files of an entry
 in an open node
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
In-Reply-To: <20261104-work-procfs-core-v2-5-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-5-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:22 +0000
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

> procfs remembers the open files of an entry that has a ->proc_release(),
> so that it can call the release hook when the entry is removed while
> files are still open. The list head for that and the lock that protects
> it sit in every struct proc_dir_entry, for the few entries that need
> them, and the next patches want to keep more there, the vm_operations
> of an entry's mappings for a start.
>=20
> Move the list into a struct pde_open_node that only those entries get.
> It is allocated when the entry is registered, whether an entry needs
> one follows from its proc_ops, and freed with the entry. So ->open is
> constant for the life of an entry, nothing has to look it up or pin it,
> and the removal path stays what it is. kernfs allocates its
> kernfs_open_node on the first open instead, but there every attribute
> can be polled and so every one of them would need one. In procfs the
> entries that need the node are the exception. Permanent entries don't
> get one, they are never removed, so their release hook only ever runs
> when a file is closed.
>=20
> The spinlock stays in the entry and now protects what hangs off ->open.
> Moving it behind the gid fills a hole, so struct proc_dir_entry shrinks
> from 160 to 144 bytes on x86_64 here, and it ends up at 160 bytes at
> the end of this series instead of the 184 it would have grown to with
> the read and write limits and the vm_operations of its mappings in it.
> That keeps 32 bytes of inline name instead of 8. 34 of the 68 /proc/net
> names a network namespace gets are longer than 7 characters.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D5


