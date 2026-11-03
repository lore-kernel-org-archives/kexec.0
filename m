Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EE60A6F6D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ou0ltwkI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VraLAnBB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WfzPGb0Mse4d7j/Ua/7Hqcs84ZaSl689mor9HstQNz8=; b=ou0ltwkI3i7P8U8Tvaql5Lbveh
	JtjgBjoGtdVKzw7pGMFtX6JJcpIXRoshynjq05T0Idcbz92arC14wzL4yg71c9DJatrQbSByCpE72
	9NKlo1LQwOXueQXM5ufpIboGAP71r5oLhCfoI8xWbERImOlqDTqkaPB8p/cjlNEImwDp4DiFp0wmn
	2JhUWB8KTdflMdKKuN3MM21cKbWe8wB8+JeptiVWojEBPhZhAvKTp+lS2a49KEgaOubXf6+XEwbU6
	lLQjF8Zncf0ioMUsyXIeYxlKnhSE71HeCPsQnJAm+E4Dv9wCjXGGyFYZUEeKJ3pXzP3TJPva/cGn3
	+yExyjog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG13-00000002pt1-0ts2;
	Tue, 03 Nov 2026 15:01:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0w-00000002pou-3dBw
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C9BE40DC3;
	Tue,  3 Nov 2026 15:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A41F000C1;
	Tue,  3 Nov 2026 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718090;
	bh=WfzPGb0Mse4d7j/Ua/7Hqcs84ZaSl689mor9HstQNz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VraLAnBB8iEvmuoFb3nDU7FUs/OmRWlZd9pI9El7xtmvFcFjZ+qsTCFtm8qJ9xnTM
	 kZFFNDj4VyO1XZNaC3TdXCV7k2MHalKXAIfEl24qYuy3Q/kp4jATM2kbbUSYelPIDC
	 tyQNwhUsx40ck67Idycq/g4Mx0MXAM8L3yCIUU5aup1rNinI8ezvlj8cI9SIkBs2YI
	 YhTRb9/DSO2hApTFTlEyef8iIRyHggmy1jCTzzV2ScJbqWgWFlD6/4XdOY8PW+tzGA
	 rELCIcGBlWlXAgY4tOu8FssC4VZR00sq7XeG1Rh0Am+N2IMnn6IPB3We00OphZHjDm
	 jWEsDfW5tAAQg==
Message-ID: <sashiko-outbox-195539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/16] proc: copy in writes to the network namespace
 entries before pinning
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
In-Reply-To: <20261102-work-procfs-core-v1-12-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-12-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:28 +0000
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

> proc_simple_write() already hands ->write() a kernel copy of what was
> written but makes that copy with the entry pinned. Let procfs make it
> before it pins the entry instead. That covers everything created with
> proc_create_net_data_write() and proc_create_net_single_write(), the
> afs files and the rxrpc stats.
>=20
> So a write to a proc_create_net_single() file without ->write() can
> fail with -EINVAL or -EFAULT now before proc_simple_write() gets to
> refuse it with -EACCES.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D12


