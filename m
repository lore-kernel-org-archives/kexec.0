Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8B6083611
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Tuo9Iq+q;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKQjc6qe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=phsvqCB36HE5sELY0/rInYjEe9A+U+9Mkk9QZ5NX1/s=; b=Tuo9Iq+qcdjVASNoDDGbQBmwq2
	RC/QPCNf3/5DAkVp0MEgYPD5w8V6C54yPGuhBJEPbULiY1VwvmnCLqFfPlJGQQq/3PgkDpKzwrpNG
	iQExH5PD5rqRvBPcUMnMYCppaDsFprBFBCSBFNPDkoiZIbwnQLo/ABvHQxs3R6KRytuZ4H8a/jraQ
	5uHvxksLJ26veiwIjOVzHemrW+SHkmeEZefqfPEdcdqEToHBthDWAfII7WyTZGwt55h7QeimjSUAf
	kDxzsg5WjcOVW5pSKF1AUOgZo+0goEX/RB3HlDB4+0cruQwSM3gK9TfK2jYgfYyVT3L8U1syI7Q4G
	6lgMk77Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHp-00000002vGq-2sq1;
	Tue, 03 Nov 2026 15:18:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHe-00000002v6t-1fGM
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC01B60A57;
	Tue,  3 Nov 2026 15:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40131F00919;
	Tue,  3 Nov 2026 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719125;
	bh=phsvqCB36HE5sELY0/rInYjEe9A+U+9Mkk9QZ5NX1/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKQjc6qepO2gqHcvTGoXxHF9p03eElgXkZwT0gb4LHjb9cYDFkWKpIJ8NSAW1lYDz
	 1U8Y4y6QkittHdf9VZjS4lTWM80tTjz1K2bkIiHkjuXkA5Kgqh88q4lx3XaUch514o
	 cekfhMRcd4YGGXX817s9kANAvztbs421COqKGftvoBo7aA12GYDDBOkHN+un27PuXx
	 i2Da4XJX3H7JwBQzj7yO7BWJ6LssAsDzeZiJ1BsOlB9gCQYUO+RKL1cz8HQpUvjZfg
	 +AZ73h/Gv9kWy7Y/Bal112XWIHskhd/6B9QlxXjckC6nmYEyH8m7FiF4fw32DiHONs
	 RtW4Yxv7qH2Jw==
Message-ID: <sashiko-outbox-195589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/23] scsi: let procfs own the seq_file of the host
 files
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
In-Reply-To: <20261102-work-procfs-drivers-v1-9-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-9-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:43 +0000
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

> Declare the show function and let procfs open and free the seq_file of
> /proc/scsi/<driver>/<host>. ->proc_open() only preallocates the buffer
> now. Reading the file then no longer holds up its removal when the host
> goes away.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D9


