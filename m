Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB2606B9E2
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bJR5/dgC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH+i2+6U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xFHbGVRg6yrT3KlueEhkmvkVUBCbD/lh7sbmFSVtLTQ=; b=bJR5/dgCqzSejoHnWHinqeGjyx
	lJFTfrsMRUSrDsG1rR1vL0WSC7QpM5aswd8WKB4ZOnXrHgIKvzTFVKYAgHe2QtlnfhIIRcRuIPp8j
	GGkzFMvE78TJhNN39mQmqgshN3F4UHmxJAhdmFznV2k13m+ZKLZ2W9aUP4J7krufNZgORe+yvPs8I
	5XP0nY0i/pEgy2jBeNebW6eJKZGwLwizC3MQ2yz3u91yXm9b5b1VSnI87FTfkxfL+eUigkAEul39H
	BCJlQaRUZeOoIIx82toDmgfOmad6pwUvMdLNN/Orj8jr10JO9XBYp0EzsRNghsdSiJ4SMU3CxQroT
	tprKb4vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3ak-0000000ASUX-239e;
	Thu, 05 Nov 2026 19:57:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3aX-0000000ASQq-3t6t
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AB53D42A7D;
	Thu,  5 Nov 2026 19:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066011F008BE;
	Thu,  5 Nov 2026 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908653;
	bh=xFHbGVRg6yrT3KlueEhkmvkVUBCbD/lh7sbmFSVtLTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MH+i2+6U9jE27VRxSnmwAC1I+KZsyQYelc+SI0/arXlN1acPqvYicclIueaGmnw0S
	 7Vufmku32aU/0LTS0ZsEhPWcfV/nyEAphelMqVOOOUXzL7KizWCwGblpTFLBfRVOQ+
	 aRw3Xd1lLfS6Zlieesl7Sd7dG27m8Iqdo392aGzfQpYi9FKD9imCBtAkWRVDGlQ5yL
	 tyCoPN0YxGIGINh+RaRkYpaUWkADRL5JES4DnfjVlT3zfh7STaEF5tXVV/1aeg93IZ
	 vbsnaVOjzd37+164Zegh13k1Ov7WlOlHKfVz6T+tPlvgwuvjMPOhmpOl2Tm3RCKXke
	 hwokiwRFkoaZQ==
Message-ID: <sashiko-outbox-200037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 03/30] lockd: let procfs copy in writes to
 nlm_end_grace
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
In-Reply-To: <20261104-work-procfs-fs-v2-3-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-3-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:31 +0000
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

> Implement ->proc_write_buf() so procfs copies in what is written before
> it pins the entry. simple_transaction_get() was only used to get a copy
> of what was written, so look at procfs' copy instead and drop the
> transaction. A second write to the same file doesn't fail with -EBUSY
> anymore. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL from
> procfs instead of -EFBIG from simple_transaction_get(), which refused a
> few bytes less.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D3


