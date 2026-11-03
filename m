Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F5606D80A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YErimGH0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcKAfBX5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1o/qScwOY5OW3AcPfET/LwYcniW1dmaX0ZfM6e2VYhw=; b=YErimGH0xYIXw4nTZZ8wTxMGOk
	WOYlIvm7rfhssVkCLaTRA1P8JUyK8gKGRfMmtrxvD5S0ffkJXHNrgM81oxLS+07NXKaiEwKUlywI9
	ILaY4msYef72FA5ulZquqHL7Kg51SlPl4Wd8Y/JF8TR+wJEvI0HdEcsehoXda8VLyjBvb70P55GKQ
	gpjNJy2m6p3o8jfJ8LpxS7REoE/ne/0EXPy01H927q3aSUnp54BeVhWPLA4QgnuTLYC4xvr/IbxHy
	1Q3qFDgNOwW5NWZG7Ie8iz1MEQv+cNDVec2jIbnwII5nb3zuUwB4w+KahVhvLMt3q4/UHXGn2RsJt
	5qigzDJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHR-00000002upV-33gG;
	Tue, 03 Nov 2026 15:18:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHO-00000002um5-2qE4
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 139B66061C;
	Tue,  3 Nov 2026 15:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD71F00A21;
	Tue,  3 Nov 2026 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719109;
	bh=1o/qScwOY5OW3AcPfET/LwYcniW1dmaX0ZfM6e2VYhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcKAfBX5e1XdhXILhg5rfmKhO4PgyKlj3eq0azh6XrZ1+WfufOQSJYBqlzejziYAx
	 Sb6DYr+s5coWPEgX6S1IM5k/YDXX0pvL98XkLLvnJPLg+EsxjLIhB2wgm3VZi561Cb
	 8VKdmJiB++oOsCK3xY9w9+lVosNEzmPZWtLYnjt53FuUOKgldLtg9kEklxZmPmHwiC
	 jqUerjRhuYVQxDyrizw2H6TVQG1rnSfyfBTRMuR5mGl44VbCc7aPIqfk47+B5n5uQ0
	 IMubBM/eIpHoA5BVhQqZFtR6QEgZWVeYz13eEPN4NA/t98KWQGF4Uaf2N1yKfid9Eh
	 8QFXLM1gS14JA==
Message-ID: <sashiko-outbox-195583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/23] PCI/proc: let procfs copy in config space
 writes
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
In-Reply-To: <20261102-work-procfs-drivers-v1-3-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-3-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:27 +0000
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
> it pins the entry, and write the config space from that copy with
> get_unaligned_le16() and get_unaligned_le32() instead of get_user().
>=20
> The copy holds at most PCI_CFG_SPACE_EXP_SIZE bytes. Larger writes come
> up short with PROC_ENTRY_SHORT_WRITES, like they did before because
> they were cut at the end of the config space.
>=20
> A buffer that can't be read used to write zeroes to the config space and
> report success. It fails with -EFAULT now and nothing is written.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D3


