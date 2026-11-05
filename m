Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB0606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Omt+m9Pg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/lqti2w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XJ6642CpUbmT9faJdQPyT1x7rBQwlIa8jLjslbId/hM=; b=Omt+m9PgtrSPHF1KPSj4ByEldB
	lZ4hOV1Up1YpoYxywufi8kX+YTZzQfcSPdB6UKl7/KKtnhb/f9I6I0rav6TX/aL4IyNd5Y1FzWhTR
	EfWhyZvsMPL7FqZDgvZ/6+tskwK43YkqokSyVZO07+Q/0nt7HWxhG0aYxcum05i6fFJfb8woA8R3i
	VHWMZDWSz7hGmUJAhj7yhXQwZsk00EqneN8NLcgGfYgc4aCF0Hn/C7yeoLxYYvaRkhll+RRo1qLAO
	aqZjoxifroDM67rDzbLtkCCLM/6DqvvYvLe7vYGWIfskrPiTB0ty4WbpKHw9UNoe/6KPW+HyrR9Lv
	Laycz/5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cq-0000000AM2v-0reh;
	Thu, 05 Nov 2026 19:33:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AJ-0000000AKnN-2rsf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25162601C1;
	Thu,  5 Nov 2026 19:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6041A1F00A16;
	Thu,  5 Nov 2026 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907026;
	bh=XJ6642CpUbmT9faJdQPyT1x7rBQwlIa8jLjslbId/hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/lqti2w1OrQg4Z7Rh1XUrJV0Rjz7sHRa7GeKVhzsOuNNsupbAfab6BhPFMbRRQ6s
	 R8j5pjl35ymm8jhjHHKcL2Q4aHubkU8vyNWYsO5AmMbS2QDOO/DgRHsMLNj9TrxKe1
	 RLG6VHdhILTSjc66At8B4CNW4ugXE4mn1IgKnc09t9nIGlKrJzpXyj9W12pQoosTgz
	 Ui8sy5shZnv8JDmiwBsQgNMlMgNj3iPBOTCVS4CXbwShJnC18KKd0G7+F0OW8ooQud
	 39xpw8p1V6y27YXqhAEZFOk06bAwJKDYaY5zNC7nznc8A+Y2K4mOb6/4TJKIimOEX3
	 Yxvmf/b2YoZBw==
Message-ID: <sashiko-outbox-199910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 47/51] proc: sysctl: look at the table under
 sysctl_lock when creating an inode
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-47-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-47-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:25 +0000
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

> proc_sys_make_inode() checks under sysctl_lock that @head isn't being
> unregistered, lets go of the lock, and then reads the mode of @table
> and calls ->set_ownership() with @head. That's fine as long as the
> caller holds @head in use, which keeps unregistering from getting past
> that check. The next patch has a caller that only pins the memory of
> @head. For that one the table, and whatever the owner of the header
> keeps behind it, is only there for as long as nobody unregisters the
> header, which happens under sysctl_lock. So read the mode and set the
> ownership before letting go of the lock. The ->set_ownership()
> callbacks only look up ids in a user namespace.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D47


