Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96286083606
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LtB7ubnw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0h9UMph
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZU3+k3TcIYO6YkcHmMmrwZXsUbYIYwH7UeAI7gyrJ3A=; b=LtB7ubnwo30IkQMioLBdVeTQGi
	ggphkGvxtmsHGemV14Ekg30s/8Ny5xmJGgDqaFviyXI6ejmDQIUIjzvKJRWFbETrQ0YMbQFcMHP0D
	SSWH5BnEfW/akl830OquhGYQ1t4yOsJ9fQvIn1uwma/F0mXuPpYRI6ri2n804ZufRMG4IxIcx4hUW
	T9XU0Kz3WjWDUtga70DoJo0/dPeqiZnhiOQV1yU+D0EwTwYcpd1Esu3sojyXfZfoXAm8SM8hY+6yd
	n4I56w8eZPT75aUd5NahdD0Y1uPM+G2CseMDfUtW78e8HlKHu8so/PLx3GV3wsjOtPJd/0h4UFx3c
	Tddu/QvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHp-00000002vGa-29Li;
	Tue, 03 Nov 2026 15:18:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHg-00000002v89-3wJ9
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 57086605CE;
	Tue,  3 Nov 2026 15:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046851F000C1;
	Tue,  3 Nov 2026 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719128;
	bh=ZU3+k3TcIYO6YkcHmMmrwZXsUbYIYwH7UeAI7gyrJ3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0h9UMphxrk1+mDnG0RzJJVioL/TjGuZE/m5lN4g//YG7ZBRhGM3XEQnayxkRQEtz
	 tba6IIRW7Hgbxp6euwMbzkpRpxx6lZ6mJG4Mm8FtFIdnmA1g/guNWt3PrDBwgPvIbH
	 k0wO/CWdhNQvXbaK7Lf//4AHfgVJNnRSqhFGoOYnKnxKwBPIqHIMPoXbYpog8RGwXx
	 4bP356yoryajWtdGcJRHNWblQsglDb2fE+3TkMWCf+62VKtpl6IVpsp0BiiR+VvRHs
	 CEv2c9NeeIaBjqzGREG/JV/GIiQXyAjR6LSQBpr5S3fOhe19V4s329MQ1rWhUQwDT7
	 ymXStWtbH9HnQ==
Message-ID: <sashiko-outbox-195590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/23] scsi: core: let procfs copy in writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-10-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-10-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:45 +0000
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

> Implement ->proc_write_buf() for /proc/scsi/scsi, /proc/scsi/device_info
> and the host files so procfs copies in what is written before it pins
> the entry, and parse what was written from that copy. /proc/scsi/scsi
> and device_info take up to PAGE_SIZE bytes like before. The host files
> pass the copy to ->write_info(), writes to them that are larger than
> PAGE_SIZE - 1 bytes fail with -EINVAL from procfs instead of -EOVERFLOW.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D10


