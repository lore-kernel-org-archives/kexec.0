Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A188606A6C4
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tCo3b8nh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/w2E8Lv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y30rUmZBthh2E7w+0fysBQcYWUpkGcdPObgng4j+tIg=; b=tCo3b8nhNuXEAEkGDuDPE4wD4j
	LisHeyJ1q4mmT653LxqcEtcwLPGZmW9ifnFpKS9NaRtCUIK4UmM3CaARhhvE62HgW3QcYBKfAcVvk
	bMdV0LmVZ2oZszOrCqo/LYuSYnmuG72jkYZeaEZNW7eu57KnwqG80zG9LzQFYghDtrYXGyat4LcxM
	PUBfW3cf8TCZdH+TNJ8JRFOR4Ief2UM9x/iXcVNKJ83lwceYdywLcbCOHLoIyvv85jt6DnyZRDc4/
	O4RZ+RGSIgaq8XqoPRnIv530ro4dAfnKIChg5WV/WGJPSHZSa9F3z7bhoKSIdFsCFtWK5AynAHnAq
	2xnw/bjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3UH-0000000AQNO-1R8k;
	Thu, 05 Nov 2026 19:51:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sx-0000000APss-3OIT
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 441A360261;
	Thu,  5 Nov 2026 19:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748201F008A1;
	Thu,  5 Nov 2026 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908183;
	bh=y30rUmZBthh2E7w+0fysBQcYWUpkGcdPObgng4j+tIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/w2E8LvVx8iHqx7D9Ue0CrcEJDGjUmIXNOxnXqQGdQ8CRIytdZZV0C3FEoMsADj/
	 nJYY3Wvl7EF2S79oY2/r4412cFfniNBCO+blsAIXkdBnMSFelCv83eSKqxIwYS1DBa
	 FPl9MuYwM3scd8uuhT1rCemD0JfzZMYYMzmX1Z0qT2M0a2NUJGjRPdvuZLc4+h5oUx
	 +WIsia2dVnilP+Ymj37NjDa8uQIEaGtGt+DsnH3VmLYTfspWj4RkA0GcSkDRaFFEOH
	 YgWmHOGaCFnkKHRaeEP37l0Lf9NgIcgl4tZVX60AUyS0L+5dBRmBr414+nePdIbpxh
	 ylPy64WGp8cug==
Message-ID: <sashiko-outbox-200003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 17/26] fbdev: viafb: let procfs copy in writes
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
In-Reply-To: <20261104-work-procfs-drivers-v2-17-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-17-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:41 +0000
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

> Implement ->proc_write_buf() for the files in /proc/viafb so procfs
> copies in what is written before it pins the entry, and parse what was
> written from that copy. Writes larger than PAGE_SIZE - 1 bytes fail with
> -EINVAL now, the output device files refused anything over 63 bytes
> already. kstrtou8_from_user() looked at the first 10 bytes of what was
> written to dfph and dfpl, now the whole write is parsed.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D17


