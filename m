Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C91606A33E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uD37l0lE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf5VH4Lc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7KNGdpx2i/AmmS1+Byv0+ZgaBgPY2uq2xeQiT+keAU=; b=uD37l0lEarJIUejOSbuicR1HIP
	Um/vPAFfnUsbjGrsGyHaYbbRfebqtM6nMiizeRa2gvw0ysnbCTaZvHmD+la8ViD18G/Moj0rWT5Or
	6wSW7FEyvWJeXViuMACBs3yBH3VsZLKfC6qpq4MTRbhMEEHOKzTe4DGaYdyrInNAL8kxYO88nq3UZ
	0I/3Dx/Syi4YKAml88B2JfjvHHcTy6/mrkVFN3hPAYwJqgJiUuBNBXubabmCHnlVxDQCOKMXphrg3
	W4cm4aFr6TSfDkUERd5k6aqp/JdKvHEUL6A2qdJBXHjejPfp6WwzIiWDKzFno/WDnPapR2b0loVNC
	8k+K8A9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3UH-0000000AQNA-10FM;
	Thu, 05 Nov 2026 19:51:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3St-0000000APqr-3glm
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5547460221;
	Thu,  5 Nov 2026 19:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275921F008A2;
	Thu,  5 Nov 2026 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908179;
	bh=M7KNGdpx2i/AmmS1+Byv0+ZgaBgPY2uq2xeQiT+keAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kf5VH4LctFatk6QfTSC9l2Zq5DIdDxDbiocaT53RxB5PZgnwJbYXHqXYskqa15x55
	 ivaB3B3fv8jl6A7hAuWJ6iF9gZy7wwXbs5dz5rhFLKUam6nHeRCS7IMsZRh+8qJJWZ
	 3oTfWxO8O50TI8zaNLVLummUy2H+F+f3WhDwx0BKzaSLT/yVx3UmsGnVkYw5m8Y48/
	 C8wmhXX+V1RZQdDf6orNHcGku00f/860bMGYlu8Xt0LPq5cght5qJ9ZJmC+8K8KLX2
	 T/UjpIt/kXoaf7HlsGh4+lP+LcFRCHjTGoj5qQPEMgSxlZtw1N7WNE5HwXyLGDQKKc
	 QzqmZeKavsbhQ==
Message-ID: <sashiko-outbox-200001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 15/26] scsi: esas2r: let procfs copy the ioctl
 argument of the ATTONode file
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
In-Reply-To: <20261104-work-procfs-drivers-v2-15-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-15-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:36 +0000
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
- [Low] scsi: esas2r: split declaration and initialization of __free() vari=
able in esas2r_ioctl_handler()
--

commit 6197b49c6d17310202283a54ea188828c65f914a
Author: Christian Brauner <brauner@kernel.org>

scsi: esas2r: let procfs copy the ioctl argument of the ATTONode file

This commit factors the core ATTO ioctl handling out of esas2r_ioctl_handle=
r()
into esas2r_ioctl_buf() and wires up the procfs entry to use proc_ioctl_buf
with a table of supported commands so procfs handles copying the ioctl buff=
er
to and from userspace.

> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esa=
s2r_ioctl.c
> index 80ae5b9d45db1..901c5d40cda8c 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c

[ ... ]

> @@ -1516,19 +1502,43 @@ int esas2r_ioctl_handler(void *hostdata, unsigned=
 int cmd, void __user *arg)
> =20
>  	}
> =20
> +	return 0;
> +}
> +
> +int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *=
arg)
> +{
> +	struct atto_express_ioctl *ioctl __free(kfree) =3D NULL;
> +	int err;
> +
> +	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
> +
> +	if ((arg =3D=3D NULL)
> +	    || (cmd < EXPRESS_IOCTL_MIN)
> +	    || (cmd > EXPRESS_IOCTL_MAX))
> +		return -ENOTSUPP;
> +
> +	ioctl =3D memdup_user(arg, sizeof(struct atto_express_ioctl));

[Severity: Low]
As reported by Sashiko on RFC [1], this isn't a bug, but in
esas2r_ioctl_handler() in drivers/scsi/esas2r/esas2r_ioctl.c, the ioctl
pointer is declared with __free(kfree) =3D NULL at the top of the function
and then assigned via memdup_user() after the early validation check.

Per the cleanup.h conventions, could ioctl be defined and initialized in a
single statement at the memdup_user() call site instead of declaring it at
the top of the function?

[1] https://lore.kernel.org/r/20261102-work-procfs-drivers-v1-14-a994bd4d3b=
1a@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D15

