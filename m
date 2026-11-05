Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDE606B04A
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b75HhZKI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kpy//3tm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r6gqpmqY5BSp77CPodMRuus+/wx5qTZqv4qw6w1Av2s=; b=b75HhZKIjTqFEglL9bZSekh3hk
	9w4/UXAxYFQgrc3lG+CceblLDiTcZVYSjcndqglgNsUghQJ/MvCiyPejE5sbmSm4FPycYBXcbvuFf
	JL0L3zAmNjuJu19rJz2HY00DM//atmZdfsZhAbsR9A2uPt7L1zVFZ8wUdpE41FHUw1IlNJqI9dbqv
	rGeUxy+KSTO3q0f3/j3JzB/dzL58WIfC3Ye7Q6bpQXVQpN6mUOlPwrcu/1Gciy5WJOp8ZSZhhiYCh
	VfVMgONn8IyRDRbjklGOsjgfJd9Jo21jgW16bBfdJf3igTot2ZdOdhUDQmz8GYqLoVzQDoy6TiaJI
	KEkIMqxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3d6-0000000ATnG-2pWR;
	Thu, 05 Nov 2026 20:00:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bQ-0000000ASux-1mCg
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D9ED860604;
	Thu,  5 Nov 2026 19:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340271F008A2;
	Thu,  5 Nov 2026 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908707;
	bh=r6gqpmqY5BSp77CPodMRuus+/wx5qTZqv4qw6w1Av2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kpy//3tmzK8eXSRlY2BVYW1b25fjRCsgzpCJrqlsfwpBGUD2IYvbKrdHAaEVVSbrP
	 ZyGjN+t2v8/6+kN4grUx8/k8tV4kPemyBoohf/uQEdB8FBgPexP77AP1PzYBRk+x+1
	 Ot3h6sMQiE4NMMpT1QzeiBj+PT0qvJYX9jyAUkb6979RVODyTZ2bBS062aZ32mIV57
	 Ta7miTInNQznua/cySRKD+tu4AAY4W0N6ubTXBL+/FTmqFpxsKPzsIc1C85dU2e0v9
	 SlsX2rGxgTHZ78bXsZrCdmy/paWzVAquAHRBJoTOEyhbJhiAaTQyPmsp2TaE5cxt7b
	 vkXXUU8xXA79Q==
Message-ID: <sashiko-outbox-200062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 28/30] mm/swapfile: let procfs own the wait
 queue of /proc/swaps
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
In-Reply-To: <20261104-work-procfs-fs-v2-28-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-28-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:25 +0000
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

> swaps_poll() sleeps the poller on a queue of its own. procfs owns the
> queue poll() uses now, so leave the poll_wait() to it and wake its
> pollers when a swap area comes or goes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D28


