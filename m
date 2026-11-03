Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40213606D2FA
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uXL8cks2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXLZhHtB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9VM4VycIJxG9B23kFs1jpcDVPOgTfnwXyJOXznUgmT0=; b=uXL8cks2IDxIXJ8i/KQ/43IPea
	gqzcZzjZpBd6KsJqVWqCXBn70AD38PajH/9RMPapL1X9ekCBZCbl5tNLt3baCCMYRaghYn9xCE6Hr
	cIrYHFMoixRWUypDPqICVoCM0ri/QfSZ0Q4/O6SZ65e5X6zLtR+BpYdePjiez5KpTu+qFaUa4F/tw
	SRe31UKdCwWSiP2y8HWGWhZsk0YKy+RgT/SKPOdOqSq6JtaltASqjVfFgLevZjnjd3KEP6uEuuJVR
	wW2Pmp6QnXNlq7uNGG9ZKJqzeWfW6s4YOEG8zQ4pY+/cZaDCSmSV5DLwd/BQZa6GFa0U+kCIuCajL
	h3dstTFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI5-00000002vbf-2BRe;
	Tue, 03 Nov 2026 15:19:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHy-00000002vS1-1kF1
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D930960A5E;
	Tue,  3 Nov 2026 15:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0E71F00A15;
	Tue,  3 Nov 2026 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719145;
	bh=9VM4VycIJxG9B23kFs1jpcDVPOgTfnwXyJOXznUgmT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TXLZhHtBBQ/MwOWloq1a719SQTAPon23w6JmMKZCt88Jd96TH83Ml+nM4Ur+GAwBf
	 HIGjyq9tA314fRNV+6HTEn7xJ5G+/lUkqqaajiwpVTla9zE2ZdMK9TN9R05B1lhMTL
	 gG7iev8TBAZ1R6LRWHTADcOV/KA8ODBmZ6NAAseQrwJ8cTF7zrs5wQjrg8m7amlIy2
	 a5D05LqkfrZGcwMdNoPisCJwwcI8ZAno6RdiJNlyxhj5f3WJeUVTRcW/XBb2wOgDBz
	 C1Qe+80yXKtcjrTSgvFLmh4nF9st0qRHA6dP8yeGfACHozhzWrcxJDaIto8ZtRYuHc
	 drplGlm4GLlUA==
Message-ID: <sashiko-outbox-195598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 18/23] wifi: ipw2x00: let procfs copy in writes to
 the debug level
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
In-Reply-To: <20261102-work-procfs-drivers-v1-18-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-18-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:19:03 +0000
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
> it pins the entry, and parse the level from that copy. Writes larger
> than PAGE_SIZE - 1 bytes fail with -EINVAL now, and a buffer that can't
> be read fails with -EFAULT instead of looking like it was written.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D18


