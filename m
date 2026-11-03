Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269A606D81A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M2Vo3vJQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cs0xmh0H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IE8V4iOQ7iI3noML0i5KQeIyzNJfUBdSgWgy06IridI=; b=M2Vo3vJQRp+ZEmdP961Q2OAD0t
	1rz2CPyUly+LvWfA1zdSkQenUGeWXp5AQLVOeRVMitQdkhcdC/2ChJoqWCtrNQIb+U+ITiXhgMlp6
	FSobD0hdyhUGRPKRiaRd7cxwt5nAs9pWpIA/Hzk5CC5qRc/GOCBwWCy0i32yN3f1sYKwgTgDy4Fau
	3bbxfFnqxunve5L2NkX7Rfo++XWP5K0cM5tHPupXWSznmbhLU0C0P6Wh8TFQ0v5KnaZORGwOvWSDt
	NJ0V2sBRz8ZtVtmyX97Bm5LuHzmfiauHQ2pmVDi77QeN8+rx2bU4Mf6wZxU9nnKvXM6VtlLbKHmLQ
	hYApH2ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGIR-00000002vy3-3DYd;
	Tue, 03 Nov 2026 15:19:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI4-00000002va2-21ES
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05F404040A;
	Tue,  3 Nov 2026 15:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9221F00A15;
	Tue,  3 Nov 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719151;
	bh=IE8V4iOQ7iI3noML0i5KQeIyzNJfUBdSgWgy06IridI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cs0xmh0HG7ocfJncY6yGq152uWyliT7jK3rRJJRKtLfkqNGd4BuVAJlOcb+TB+c0Y
	 m0Zz6URXX9JFhDTjvz0btUBc2CWv7FjEi3y6D5tXMrKmYkp9oyNuzqetMapTf/+0DR
	 2nMRuZTjUqzUKSfEQTPamTNPXOGtTI1lOCkmiX322AlBF+9FPWIY7SJfqsYtgr3yOl
	 xnDfFDDLRRbH0BOzQbHQ8WOunVlJVuUeRtZ+RcN0G0MEnwurIY+Un6kGJOKkXOmJn/
	 cVi3EVheLLtxmmdwiWpSBGXkZu1R/PXVQuUD6eJ2mFWhwzkWYnZksSTusi17FIGRdl
	 JTP7AxeqzaokQ==
Message-ID: <sashiko-outbox-195601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 21/23] ALSA: info: let procfs copy in writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-21-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-21-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:19:09 +0000
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

> Implement ->proc_write_buf() for data and text entries so procfs copies
> in what is written before it pins the entry.
>=20
> Data entries take writes a page at a time with PROC_ENTRY_SHORT_WRITES.
> They used to get the whole write at once. ->write() of struct
> snd_info_entry_ops gets the kernel copy and opl4, its only user, writes
> it to the sample memory without bouncing it through a vmalloc() buffer
> of its own.
>=20
> Text entries take up to SND_INFO_TEXT_WRITE_MAX bytes at once like
> before. A single write that is larger fails with -EINVAL from procfs
> instead of -EIO now.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D21


