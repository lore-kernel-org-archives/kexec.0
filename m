Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BE606A6C5
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Pl9DAHtg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OumfSaDw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fu3D7KbVL0XALbxpOg/99/chjuCyMPlpg1MAOjhFXPQ=; b=Pl9DAHtgF9ymYw0PuhicrDU0ym
	0+JLP/5BQEnXhWF2hx/xPJzxLhAPSv9vPEg+wyCEgQIRp8ffB53Rj7VppO7O4SxOJpF4KX7wIw/AH
	IBpOU0Kh6GZ01ZNpBP/Ux/qOf5mx84WhTRWlMU7DOLepplZq+YRBjcTc6qVwpWMWxrdr0YjRfr5qe
	9xGIhgGDl2LRCRGVfCnwkJDFld4nQzdkMQcJaw9mjFf6PgkhpQ0udaID9lvUtPWLk+5l8Nj8Oe0kG
	NkFFp9Et4rCnIqTeTKmCREHjdH+4fReuhLOMOUnzTV6qWq4VGZfZ1HNisxmw0vnl/GTw+4JfCRIOf
	11sGs6QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3dJ-0000000ATr3-27hZ;
	Thu, 05 Nov 2026 20:00:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bV-0000000ASzE-3eu1
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55894605EE;
	Thu,  5 Nov 2026 19:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA431F008A1;
	Thu,  5 Nov 2026 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908713;
	bh=Fu3D7KbVL0XALbxpOg/99/chjuCyMPlpg1MAOjhFXPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OumfSaDwTNZBpGJOWzIaiT6pjsiHCqCuEdUaz66yitHN1nNu5txd4yS9N4qziqeuA
	 jKo6oOvNVnrmW1Ld/SRNRJlyIoYW+xi575vQWaVzSfKh4Q6aHkYPJ0bu4ianMe/ryp
	 FY85+WivxPFkJEXo69NxZ98f5CWKvFEwF7vR5O7X1Ds9ii4+w6KQI6rHKutuqKTC/5
	 PJGugGwCCkbyMgPLbKXpkZegV1ou950ZWOzXqy4ZhzEAo//gqm2NGT/LmV6GGVGIFw
	 GkRGt05JBCoUhdhRlgBNsfNUA/ok0dXb29KIdwCOoyz5PlaaZL7x/S1TIIAEL/3HQI
	 uTDOX6NycFX8g==
Message-ID: <sashiko-outbox-200064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 30/30] selftests/proc: check that unloading
 configs doesn't wait for a reader
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
In-Reply-To: <20261104-work-procfs-fs-v2-30-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-30-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:29 +0000
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

> Read /proc/config.gz into a buffer whose first page is backed by
> userfaultfd and unload configs.ko while procfs copies what was read to
> userspace:
>=20
> - removing the entry doesn't wait for the reader
>=20
> - the reader still gets the page that was read before the removal, and
>   nothing more
>=20
> - and the next read fails with -EIO
>=20
> The test loads configs.ko if it isn't there, skips if configs is built
> in or can't be unloaded, and loads it again afterwards. It needs
> CONFIG_IKCONFIG=3Dm. kselftest-merge keeps the =3Dy that other fragments
> ask for, so it skips there.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D30


