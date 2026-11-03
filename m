Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BC6082BF2
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qKZ6q3qO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM0tHmEK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DuUWXqjsSRZJqvPrRnnQUK8F6HwoSKU+vf+Jc0u1BP4=; b=qKZ6q3qO5IY4kPmBkHwJYJ+Czs
	5/9R80En4ZNjKUdR6XQUwt+Utg1Se10G5XytrMnyqmEbdzEcZp3V0+cLncBGedrwrsPjqam8ASqFB
	clIBhm5kOhj41P+pmBwrobCBHZ7DBDEtgxQV3TG0JX++GXWdKNKQ5aH93jO7VdhrJfKl/NqbQzwGa
	9Wnkw+Xs17F0nQqcXHEj+tfoS2ghruDM0wjWFKwBNhoORDS51njGeHrBXbRIuctVRDyKDvj8V1tSc
	NKwXjDmZXW9+MoO443aPbjQAy7uzu4INZFKyooux8QLwBtYYRqL8DQoyum9qI+mLK90BRcwNSFY17
	AbhVoDJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHm-00000002vC8-3Frj;
	Tue, 03 Nov 2026 15:18:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHb-00000002v4E-3MfM
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 830F243DE6;
	Tue,  3 Nov 2026 15:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34361F00A1A;
	Tue,  3 Nov 2026 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719123;
	bh=DuUWXqjsSRZJqvPrRnnQUK8F6HwoSKU+vf+Jc0u1BP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AM0tHmEKokixtZONwfAH9GtAY9t8XyE8EQqFABZ4jT/4JvAwevkMeQijwg3GGuI6b
	 +uRWlXfdEm1zAuo+7Xu83HaUoLhd7v44csfZ9YCQ9XFZDzwuUrIIJ5ZJSNbLwnlYGa
	 m75nZBJXugcWf9XdVH2eCRknX8RVMsoXlE0Be3ASTz8tvYz7mmfB2q97Rx+lmFR/d/
	 P3y+Pk1FjoR6TzepE4sGWFDJ+B5VBr3/cihd1PQ5ptIU6mTwzqamjpHrgXtwTmDqHD
	 SsBfs8TF14zsa35s0UdWhnaIUoaZqYvGdNLbwEdyaDdYpcyIPY7xkys8bbdug4fGgR
	 Z1HIudLH9yC6g==
Message-ID: <sashiko-outbox-195588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/23] s390/cio: let procfs copy in writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-8-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-8-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:40 +0000
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

> Implement ->proc_write_buf() for cio_ignore and cio_settle so procfs
> copies in what is written before it pins the entry. cio_ignore parses
> the list from that copy, up to the first NUL like strncpy_from_user()
> handed it to it before. Writes larger than 64k still come up short, now
> through PROC_ENTRY_SHORT_WRITES. Writes to cio_settle larger than
> PAGE_SIZE - 1 bytes fail with -EINVAL now, it never looked at what was
> written.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D8


