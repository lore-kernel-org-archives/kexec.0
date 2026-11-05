Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F7606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TPE384OC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRVwl1Yw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eiSLs4tpW5+ooQETfUAsv7SD2u+8vxBZSNTA/E9JPSA=; b=TPE384OCQ+oAUJpEJZE0gXipR1
	ajYG3mClNeMLrXixKhBC4J0nPmCRITXaGF9BQnqpw/MoRaFbZTB6A/5iAwiHM++tPXOuoiiYHWaXt
	tSbgX0Hs+bz08pTE36nx/JQEv10jt3wWytgPx5BPxN6E6ST7ZCowORhN7lkX+fpNXPNykb+mkaijh
	k2Tc3rlkH9y5EEL7oemUsqGl0P2FVr0cnbbYBd6cX+Bu+yD6+GT2VldwzW7TGN2zmACr+ATLBdMi2
	lZ8FvXMxBTcSFNiSQN0qDbgJhX8NFp9+QLnMKh9TEFHJ5HCilB5jZhvq/kLU1PNV40EXM9aUcn8ro
	FWG7GN1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3HW-0000000ANkH-3nHE;
	Thu, 05 Nov 2026 19:37:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3FZ-0000000AN4n-2exk
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:35:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 17EF56014B;
	Thu,  5 Nov 2026 19:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24731F008A1;
	Thu,  5 Nov 2026 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907352;
	bh=eiSLs4tpW5+ooQETfUAsv7SD2u+8vxBZSNTA/E9JPSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRVwl1Ywon7MS2C+OemnpnnRZyhhY3OqsfkA0hDxdTc+rduK6mkVEdlJDGNIGqSYy
	 a1NLTQZZqowxlMpgmKyOfh8BBgOzgFAHydYWKlFfry5yNMxiI/UD8ldqZYx8WMm7ez
	 QNVP0ICID7Qj8TKSjz1zNuhOdyu+/wENB2Pe+KXsAcn/SDnE1f4VadXGr2TU1yn/I4
	 kSqEUN6UAmPa8USnYhqhq+djAtPsBeI0nhvEXQeRMsO17pEiCgKx17axw4dL2BiiBh
	 F88Gi+dRDEKECFbv6g4fiHem3PZPjp3QB2HUifdGFOqWgr8pWyiCoUmeRakhBgXvWb
	 R9lZgeMwuUEfw==
Message-ID: <sashiko-outbox-199948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 18/23] proc: let procfs copy ioctl arguments
 in and out
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, tytso@mit.edu, dmitry.torokhov@gmail.com, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Anna Schumaker" <anna@kernel.org>, yukuai@fygo.io, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-core-v2-18-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-18-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:50 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] proc: __free() variable buf declared at top of pde_ioctl_buf()
--

commit 56830294f9ddc9f5679014810e7198455a39f42c
Author: Christian Brauner <brauner@kernel.org>

proc: let procfs copy ioctl arguments in and out

This commit adds support for ->proc_ioctl_buf() and ->proc_ioctl_args in
struct proc_ops so that procfs can copy ioctl arguments from and to
userspace without holding the proc_dir_entry pinned across user copies.

> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index caa47933c233d..717cbaad65df2 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c

[ ... ]

> @@ -548,11 +549,66 @@ static long pde_ioctl(struct proc_dir_entry *pde, s=
truct file *file, unsigned in
>  	return -ENOTTY;
>  }
> =20

[ ... ]

> +static long pde_ioctl_buf(struct proc_dir_entry *pde, struct file *file,
> +			  unsigned int cmd, void __user *uarg, unsigned long arg)
> +{
> +	void *buf __free(kvfree) =3D NULL;
> +	struct proc_ioctl_arg a;
> +	size_t size;
> +	long rv;
> +
> +	if (!pde_ioctl_arg(pde, cmd, &a))
> +		return -ENOTTY;
> +	size =3D max(a.in, a.out);
> +	if (size) {
> +		buf =3D kvzalloc(size, GFP_KERNEL);

[Severity: Low]
As reported by Sashiko on RFC [1], this isn't a bug, but in
pde_ioctl_buf() in fs/proc/inode.c, buf is declared with
__free(kvfree) =3D NULL at the top of the function and assigned later when
size is non-zero.

Since the cleanup API convention prefers defining and initializing __free()
variables in a single statement rather than initializing them to NULL at
the top of the function and assigning them later, could buf be defined and
initialized once size is known (for example via size ? kvzalloc(size,
GFP_KERNEL) : NULL)?

[1] https://lore.kernel.org/r/sashiko-outbox-195542@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D18

