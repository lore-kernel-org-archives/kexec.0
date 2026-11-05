Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC36606A33D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X8IOlDzj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ej+uoOdy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7NQAKY8HY4DbdjDd6x8DZF/XgVJse33xFSaScTuQDsM=; b=X8IOlDzjWH7YgkAzJN/iQnX/dH
	nO2c9CnC709kFCwJhuwFrSIUUM2cRp5n8lxDh9VT+beKI3/J29hA9ZBZRRdyPQo1LhApTY3fpWwRG
	u/PQ+G11Ab55nbyHjI0lsgUBqcM07mNFU4G2uXZB6ArHgWzbdF3c3j445ZizYscsS53Khk5+LDtPn
	l2XnxWodeJCwJwTnD89udMfUyNsRSYi3pkewKOckt+9BD9pjIBGGRU3J51LC9AzACbzOKA0DGyHyR
	Cc81xR4CizhwHRf7+7+L4e7O+cZa5vBxTWh8E72nIRZvG/ZYnApBZPZzpXvNYhDt4w3FYPkFvm67U
	vfcMpLOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cb-0000000ALro-2pAL;
	Thu, 05 Nov 2026 19:32:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3A7-0000000AKlO-00c2
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD698414C3;
	Thu,  5 Nov 2026 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F3A1F0093A;
	Thu,  5 Nov 2026 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907014;
	bh=7NQAKY8HY4DbdjDd6x8DZF/XgVJse33xFSaScTuQDsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ej+uoOdyy0zraix1fQ7r25PJRrh/4Y9jENiNfRHcNQYKQbamB19zOZWAIYTZP936k
	 525AiogVEAMXoo8f3U/2wtiLHom345+woamQXZG812Wqw1iTBWxzB4lfrEhY0L2dNa
	 EJvLiN1GfSZ7KXDdLY1rJb97KQOIpQcpSkmrSySn132O264dcPg7eLs6XEwEHRR2Jx
	 kAAmy8CviFoouXet9NS4WJJqFN+2BooXsbNYrMheRfZVdZNv+l80ODw7nu/l90jVkJ
	 HWjhC78V1gjM0l/DaNa2Rbj7gbXnQcngNdr12ijFwDhs3Ny03+eY9pKEJ0LhfAJkZh
	 SgFF9W+xXiDtw==
Message-ID: <sashiko-outbox-199904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 41/51] scsi: esas2r: bound the lengths of the
 HBA, SMP and firmware ioctls
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-41-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-41-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:12 +0000
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
- [High] scsi: esas2r: double fetch of data_length in handle_hba_ioctl()
--

commit a2397b86d116881b0f288e71fe8885d678578a5f
Author: Christian Brauner <brauner@kernel.org>

scsi: esas2r: bound the lengths of the HBA, SMP and firmware ioctls

This commit bounds the lengths of the HBA, SMP, and firmware ioctls in
esas2r against the remaining room in struct atto_express_ioctl (or
sizeof(struct atto_ioctl) for read_hw()) to prevent out-of-bounds DMA buffer
reads and writes.

> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esa=
s2r_ioctl.c
> index c93d9265e1008..80ae5b9d45db1 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c

[ ... ]

> @@ -1221,11 +1231,16 @@ static void hba_ioctl_done_callback(struct esas2r=
_adapter *a,
>  	}
>  }
> =20
> +/* @room is the size of the buffer that starts with @ioctl_hba. */
>  u8 handle_hba_ioctl(struct esas2r_adapter *a,
> -		    struct atto_ioctl *ioctl_hba)
> +		    struct atto_ioctl *ioctl_hba, size_t room)
>  {
>  	struct esas2r_buffered_ioctl bi;
> =20
> +	/* The data follows @ioctl_hba in the same buffer. */
> +	if (ioctl_hba->data_length > room - sizeof(struct atto_ioctl))
> +		return IOCTL_INVALID_PARAM;
> +
>  	memset(&bi, 0, sizeof(bi));
> =20
>  	bi.a =3D a;
>  	bi.ioctl =3D ioctl_hba;
>  	bi.length =3D sizeof(struct atto_ioctl) + ioctl_hba->data_length;

[Severity: High]
As reported by Sashiko on RFC [1], in drivers/scsi/esas2r/esas2r_main.c,
read_hw() and write_hw() access the shared a->local_atto_ioctl buffer
(allocated as sizeof(struct atto_ioctl)) without any driver lock:

drivers/scsi/esas2r/esas2r_main.c:read_hw() {
	...
	if (handle_hba_ioctl(a, a->local_atto_ioctl,
			     sizeof(struct atto_ioctl)) !=3D IOCTL_SUCCESS)
		return -ENOMEM;
	...
}

drivers/scsi/esas2r/esas2r_main.c:write_hw() {
	...
	memset(a->local_atto_ioctl, 0, sizeof(struct atto_ioctl));
	memcpy(a->local_atto_ioctl, buf, length);
	...
}

Because kernfs only serializes sysfs bin_attribute operations per open file
description, concurrent read_hw() and write_hw() calls on two separate open
file descriptors for the sysfs hw attribute can race on a->local_atto_ioctl.

In handle_hba_ioctl(), ioctl_hba->data_length is read once for the bounds
check against room - sizeof(struct atto_ioctl) and read a second time when
computing bi.length. If a concurrent write_hw() overwrites
a->local_atto_ioctl->data_length from 0 to a non-zero value between those t=
wo
reads, wouldn't handle_buffered_ioctl() still read and write bi.length bytes
past the end of a->local_atto_ioctl?

[1] https://lore.kernel.org/r/sashiko-outbox-195500@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D41

