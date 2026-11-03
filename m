Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D05606B27C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1calXRm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZQFVLsQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mDllQPiaDt7W9nUabOs1aaubEh71hf4xh0JVA1Ds0Qo=; b=F1calXRmfOEC4tdfHXIyBRy/qQ
	/mbl+O82tK7I4mL0JFZk/Fpx+K/AthlaTbh6Q/wHCiZHnCqxmKCxIZR8pXl3KlnlSS1EcCQABWYt1
	jIAV9uTujbCY+JmhD6QPtmoyM4Rih/SHEAkkCbgoqv6o5peiKzkxjS+sKtw7GuJcTSw4qGPYWeJHc
	Ht9AUbVk9uM6sQGf71Xi6dhDbJ9ErIJuA9wu2KEWs0mqWbcY2QlR9lzNlgNzUlk+TQauhvK3RCvpM
	ht9KrpTunToPxP6MYTWFYwaD5fShdnSvcRPT5Dbtf5YXqgQJrCA08eGDTt0YA5IxKpdW3o7/UOUi7
	2uYmIhNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoK-00000002lZw-2QsG;
	Tue, 03 Nov 2026 14:48:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoF-00000002lTs-0UAR
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B261609F1;
	Tue,  3 Nov 2026 14:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEA1F00A1D;
	Tue,  3 Nov 2026 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717302;
	bh=mDllQPiaDt7W9nUabOs1aaubEh71hf4xh0JVA1Ds0Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZQFVLsQSM/JJy7diD15+tL/x+/slfZHNsBHLgIYPNtPog62JjqylkMBb6gBJkiXN
	 8YNZ5GHXUCxbBxxVc34SjciIfhd9qd03FXJbglkmblnJZ+ktUmrSf9jT9is7H2wS2x
	 shULjdrAYy4v6TNHg87xWMouFG+YMuyhxCYuuodpdcLJxbVYVrIGw1sLPqhUrgPkqv
	 yicgUOsjrgp6LNPHnHnviDvzZPOwY9GU5O3HAIomWFab2PQNIpoE+CSFrgCNxrrUvW
	 hxLxx9Akzs2s93iXVT6Uyuw88VwCWCXGpW7OqZ8I+wEv0uBmmOA0DnKxLjt0OZKcWV
	 tZCMxMvtLkKwg==
Message-ID: <sashiko-outbox-195499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 27/38] sunrpc: make queue_wait a global wait queue
 again
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-27-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-27-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:20 +0000
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

> Since commit 552d0e17ea04 ("sunrpc: convert queue_wait from global to
> per-cache-detail waitqueue") poll() and epoll queue their waiters for a
> channel file on the queue_wait head in struct cache_detail. But the
> cache_detail can be freed while its channel file is still open and
> waited on.
>=20
> The procfs channel files of a network namespace are removed when the
> namespace goes away. Removing a procfs file waits for the callers that
> are in one of its methods right now and then calls ->release on every
> file that is still open (cf. close_pdeo()). The waiters that poll() and
> epoll left on the head stay queued until their file is really closed.
> So:
>=20
>   sunrpc_exit_net()
>   -> ip_map_cache_destroy()
> [ ... ]
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 552d0e17ea04 ("sunrpc: convert queue_wait from global to per-cache=
-detail waitqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D27


