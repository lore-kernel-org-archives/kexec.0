Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1F606D806
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pM9MgzKm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egO6F/of
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HJo7uhQ8siYxDw0RZS7+3aCaFL/z+RS5DWNp/kEBIgk=; b=pM9MgzKmKV62Y/pZq4BGUMo4A6
	KDK9L6I5sFPDpZOU1FzvzthhR0MUN24to3tsH4K7IWnS4Su04ZoJ3Je8aTfwqCXHKGnFBLbSjCayI
	wbT8aBWgBakhHUZhePM8T4Eok9hXJFd0Sjc7D3ta/plwWT3w5d3baov3sUL8XvH+pVWQzRZHUhAzM
	eVZwqY7ra6RbquSmbZlF0ifTQUlXc/OForfRbcf47wvhjyV+yG3t9HY6mdbfu1DqTTUTjv17Z3bR2
	uMJwvMpTvupZ5fXAxsadM2qkxImlt1dGUILovkjVr0EesK6V8zNk+My2L/VZWMk0u5YydCDwHMhH6
	w/LJezvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG13-00000002psg-0SQ6;
	Tue, 03 Nov 2026 15:01:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0v-00000002pny-13PH
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD1F160239;
	Tue,  3 Nov 2026 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CB1F0093A;
	Tue,  3 Nov 2026 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718088;
	bh=HJo7uhQ8siYxDw0RZS7+3aCaFL/z+RS5DWNp/kEBIgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egO6F/of7CpTd+PoLOWG9TxuNy/r0bVezlWWB3WedBTqIlqmwFVNqYhzt7VSoW8zF
	 L2Q3+erAo9JrU5hHInrg7k+kxzeqoaIrxxrLW7A1xtt/ncPtwSegLy4+TXN3HzG/hu
	 X8lQ7pFsFkuXEdqfkgkDg+lJrU+5qpItEyIjMQvlvx7yavCortIJIC3nuU0t33yVqs
	 dtJ+2iUHTvZB7QICHjQj8YsMjkOoP8NVFK47FEu6xrH8SbXS5x0lCNVOHCX5Bxz6mY
	 dkiORpDTzbslpgezRG4qDhAij5S0Pzc9kdghBEA/Lbr/FhFJu+yj3tH/1YEccJaQ7R
	 /D3PlZ2sc1PyQ==
Message-ID: <sashiko-outbox-195538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/16] proc: let procfs copy in writes before
 pinning the entry
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
In-Reply-To: <20261102-work-procfs-core-v1-11-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-11-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:26 +0000
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
- [Low] proc: split __free(kvfree) declaration and initialization in pde_wr=
ite_buf()
--

commit d672761b59bb5333b9344e6a78cc97135a5b70b1
Author: Christian Brauner <brauner@kernel.org>

proc: let procfs copy in writes before pinning the entry

This commit introduces ->proc_write_buf() in struct proc_ops so procfs can
copy user write buffers into a NUL-terminated kernel buffer before pinning
the proc_dir_entry, preventing page faults during user copies from blocking
remove_proc_entry().

> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 8425465aae5d7..c0bb40e7ff964 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -440,11 +440,44 @@ static ssize_t pde_write(struct proc_dir_entry *pde=
, struct file *file, const ch
>  	return -EIO;
>  }
> =20
> +/*
> + * procfs copies in what is written before it pins the entry. A writer t=
hat
> + * faults on its buffer then doesn't hold up remove_proc_entry().
> + */
> +static ssize_t pde_write_buf(struct proc_dir_entry *pde, struct file *fi=
le,
> +			     const char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	char *buf __free(kvfree) =3D NULL;
> +	size_t size;
> +	ssize_t rv;
> +
> +	size =3D pde->write_size;
> +	if (count > size) {
> +		if (!pde_has_short_writes(pde))
> +			return -EINVAL;
> +		count =3D size;
> +	}
> +	buf =3D kvmalloc(count + 1, GFP_KERNEL);

[Severity: Low]
This isn't a bug, but in pde_write_buf() (called via proc_reg_write()),
buf is declared with __free(kvfree) =3D NULL at the top of the function and
assigned later after the count > size check.

Per the Cleanup API conventions, could buf be defined and initialized in a
single statement at the point of allocation:

	char *buf __free(kvfree) =3D kvmalloc(count + 1, GFP_KERNEL);

after the size check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D11

