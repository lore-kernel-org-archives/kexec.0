Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD38606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IsFYFv20;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjJEPh8p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Mq2TZRho3g/6dJEkd3aM2nJWP3IUjUSQ0d76Sv96NJo=; b=IsFYFv20YRja+oScsUHdvqoUrC
	CzJ/QphOeRxjILj2J6km/Zt98nfQ/9rRbfqMHw9AUngpqXtOgvGe3a2AKeCpcG+/WDBCMGULOFl+2
	fHarVmB+ckoXsClcyDXMLZjJ/d7TLZjKSbh/zisE2zdGfzr64U7g1r94UrYybV5sGv+qrDo6Fdlg4
	D7aqFUpj8/IlZ+BMHdUqz3kc9pe1e30EbABbHz3pjJ868b0Ou/gW3czzlcGEo3bHAQBeloqZcw6/D
	fwqIhq+yS1BBWE7X//fgI3qaSVwwrStlzLSjaz8nsCH8Jn1XXZYAEk6TxwdyiXjLvnS2m1agpBXW5
	jrRQxuRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BS-0000000ALLh-1FhR;
	Thu, 05 Nov 2026 19:31:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39n-0000000AKYE-0GOc
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81189601CF;
	Thu,  5 Nov 2026 19:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBACC1F000C1;
	Thu,  5 Nov 2026 19:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906994;
	bh=Mq2TZRho3g/6dJEkd3aM2nJWP3IUjUSQ0d76Sv96NJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjJEPh8pDtseuVUQk4qwZA9aci3gac063ZokyebNlvHp2beWZHvvSUeYQeiXMVXvr
	 gorR7o8d0SaoLeOi9bKNyUy3h6vHu09hw27HReSQrpP5tbdq5gCz3B6gixX9La77ez
	 A3GDPdSDz2e83FWBMhFysd0uKqafdxTW2wlSO3wrIC47SZJJWU00KVW3tU8R/XZoDc
	 l2HWNRW/SEC3nlzdu96mPwurJuhISd5di7F3WA+6g/riaXNTCLrXNXhDRDwZUn89Ok
	 0Dcu6L25OUIAO131EMpgW4+6XspNy4+EDu3YAgYrAOfY0ko3kC83F2cPBr48QIfDJY
	 xKWD9ZPaIbjkw==
Message-ID: <sashiko-outbox-199895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 32/51] proc: resume readdir after the last
 name it returned
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-32-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-32-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:51 +0000
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
- [High] proc: proc_readdir_de() returns 1 at EOF, breaking old_readdir()
--

commit 6510b1c4f87c45306294a13ba8447b50990db356
Author: Christian Brauner <brauner@kernel.org>

proc: resume readdir after the last name it returned

This commit records the name of the last emitted directory entry in a
cursor stored in file->private_data so that subsequent readdir calls can
resume after that entry by name rather than by numeric index. It also
continues after an entry's name if the entry is removed while being
emitted, and returns 1 when no entries remain at the start of
proc_readdir_de().

> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 9e59796349e15..588999058e66d 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c

[ ... ]

> @@ -290,23 +346,26 @@ struct dentry *proc_lookup(struct inode *dir, struc=
t dentry *dentry,
>  int proc_readdir_de(struct file *file, struct dir_context *ctx,
>  		    struct proc_dir_entry *de)
>  {
> +	struct proc_dir_cursor *cursor =3D file->private_data;
> +	struct proc_dir_entry *dir =3D de;
>  	int i;
> =20
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
> =20
> -	i =3D ctx->pos - 2;
>  	read_lock(&proc_subdir_lock);
> -	de =3D pde_subdir_first(de);
> -	for (;;) {
> -		if (!de) {
> -			read_unlock(&proc_subdir_lock);
> -			return 0;
> -		}
> -		if (!i)
> -			break;
> -		de =3D pde_subdir_next(de);
> -		i--;
> +	if (cursor && cursor->pos =3D=3D ctx->pos) {
> +		/* Resume after the last entry emitted, wherever it is now. */
> +		de =3D pde_subdir_after(dir, cursor->name, cursor->len);
> +	} else {
> +		/* Moved by a seek, count from the start like always. */
> +		de =3D pde_subdir_first(dir);
> +		for (i =3D ctx->pos - 2; de && i; i--)
> +			de =3D pde_subdir_next(de);
> +	}
> +	if (!de) {
> +		read_unlock(&proc_subdir_lock);
> +		return 1;
>  	}

[Severity: High]
Does returning 1 here when !de cause old_readdir() and compat_old_readdir()
to return 1 instead of 0 at end-of-directory on non-root /proc directories?

While proc_root_readdir() checks for a positive return value from
proc_readdir_de() to advance to the PID entries, proc_readdir() (for
proc_dir_operations) and proc_tgid_net_readdir() (for proc_net_operations)
return the result of proc_readdir_de() directly as their .iterate_shared
return value:

fs/proc/generic.c:proc_readdir() {
	...
	return proc_readdir_de(file, ctx, PDE(inode));
}

fs/proc/proc_net.c:proc_tgid_net_readdir() {
	...
	ret =3D proc_readdir_de(file, ctx, net->proc_net);
	put_net(net);
	return ret;
}

Previously, proc_readdir_de() only returned 1 after completing the do-while
loop (where dir_emit() had succeeded at least once and set buf.result =3D 1
in fillonedir()), and returned 0 when !de at the start of the call.

In fs/readdir.c, old_readdir() and compat_old_readdir() do:

	error =3D iterate_dir(fd_file(f), &buf.ctx);
	if (buf.result)
		error =3D buf.result;

	return error;

When old_readdir() or compat_old_readdir() is called at EOF (ctx->pos >=3D 2
and !de), dir_emit_dots() returns true without invoking ctx->actor, so
buf.result remains 0 and iterate_dir() returns 1 from proc_readdir_de().
Wouldn't old_readdir() and compat_old_readdir() then return 1 to userspace
without writing to the dirent buffer or advancing file->f_pos, causing
callers to read uninitialized or stale dirent memory in an infinite loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D32

