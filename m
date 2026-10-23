Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37599606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tbZ81OUj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLyWoM0h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pYSp2c5otvQVKlsDqkCmWYdFvd1mbuUyoJ7Y+WxC2N4=; b=tbZ81OUjb2GmpL1ku8Lt1xMt6j
	u3SuANc8oQd6kiGnkQNNRzfkgAR0IdIL7zt7zXmCwRWLyNPjhiUWXDDdcFIrX/vxLKMWgPCOQTFy/
	l4rKm6+BtrZP5BdgdS94FtsiphsVb5wglWk+luuMfVPkne+fjBHKNRaS5YWEKwmLzJHQf8VCGe8if
	UbOdFz+a6uQK53NA5W83v/VDH+dwPx6RYjjJ+U15kvYdZLyG2Pniynk0Tz9jXrNow7ki9lilO54EP
	UzACsMK8TAWXKJJ06B+6y2pBWniruYVtdzeEdocnXL7PI0+e4j8fzxvSV4LG0bjMLQDPByQavWYl3
	X4bXWiug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6w-0000000H4ox-3mOc;
	Fri, 23 Oct 2026 22:51:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6v-0000000H4mJ-3Y5s
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2ECE56022B;
	Fri, 23 Oct 2026 22:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034841F01829;
	Fri, 23 Oct 2026 22:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795900;
	bh=pYSp2c5otvQVKlsDqkCmWYdFvd1mbuUyoJ7Y+WxC2N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLyWoM0hycKXz03W3ktmcZtB/2Qv8F+pJD3BgZOgUuE7HMl3adGV7L4jNniZeZycn
	 tGZrN/dN7JBjneaErv/0SctPf/Q3RW2rZqrzxokpc3yLvdVU3CT6J9HCCSDRHj59U9
	 JuDwuubQprNLM8c7UYK+wgY+4m6T6xRRPkQdsK7izcrNnGcAavG/2KCPy5g2naT6NM
	 HswQj1PWWoq1FjYapWeVJw7d5D+PUqKGmssqYXXQAO8NIEmH6PQQn8z5j42HOAOi53
	 7PVToV3ougoNDe5+gOw6ZMPJDoOrtISLjLjL9vHXwMqEvCnGZJIIkB0OEJxYzuHBSo
	 Cf9N51nA419/Q==
Message-ID: <sashiko-outbox-183328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] mm/shmem_luo: Allow retrieving tmpfs files
 with O_RDONLY
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>
In-Reply-To: <20261022225035.377445-10-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:39 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/shmem_luo: unnormalized flags passed to dentry_open() on O_RD=
ONLY reopen
--

commit 18d00c8fbd0dd510d3e12bc0fbf7c761642eaf15
Author: David Matlack <dmatlack@google.com>

mm/shmem_luo: Allow retrieving tmpfs files with O_RDONLY

This commit allows userspace to retrieve preserved tmpfs files read-only by
passing O_RDONLY in struct liveupdate_shmem_retrieve_arg. It creates the
temporary file as writable via file_open_root() and then reopens it read-on=
ly
with dentry_open().

> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index aba2bc1f18c52..0b4a9d6e2968c 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
[ ... ]
> @@ -649,7 +650,9 @@ static struct file *shmem_luo_create_memfd(const stru=
ct liveupdate_shmem_retriev
>  static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_=
shmem_retrieve_arg *arg,
>  						unsigned int seals)
>  {
> -	struct file *file;
> +	struct file *file, *ro_file;
> +	bool rdonly;
> +	int flags;
>  	int err;
> =20
>  	if (!arg)
> @@ -673,10 +676,16 @@ static struct file *shmem_luo_create_tmpfs_file(con=
st struct liveupdate_shmem_re
> =20
>  	/*
>  	 * Create the file like open(O_TMPFILE) does, so that it gets the same
> -	 * flag checks, permission checks, owner and security labels.
> +	 * flag checks, permission checks, owner and security labels. open()
> +	 * requires write access for O_TMPFILE, so create the file writable and
> +	 * reopen it read-only below if that is what userspace asked for. LUO
> +	 * keeps the file until the session is finished, and a file opened for
> +	 * writing couldn't be executed until then.
>  	 */
> +	flags =3D O_TMPFILE | O_LARGEFILE | arg->flags;
> +	rdonly =3D (flags & O_ACCMODE) =3D=3D O_RDONLY;
>  	file =3D file_open_root(&fd_file(dir)->f_path, ".",
> -			      O_TMPFILE | O_LARGEFILE | arg->flags, arg->mode);
> +			      flags | (rdonly ? O_RDWR : 0), arg->mode);
>  	if (IS_ERR(file))
>  		return file;
> =20
> @@ -694,7 +703,12 @@ static struct file *shmem_luo_create_tmpfs_file(cons=
t struct liveupdate_shmem_re
>  	}
>  	SHMEM_I(file_inode(file))->seals =3D seals;
> =20
> -	return file;
> +	if (!rdonly)
> +		return file;
> +
> +	ro_file =3D dentry_open(&file->f_path, flags, current_cred());
> +	fput(file);
> +	return ro_file;
>  }
> =20
>  static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)

[Severity: Medium]
When userspace retrieves a tmpfs file via LIVEUPDATE_SESSION_RETRIEVE_FD wi=
th
O_RDONLY in arg->flags, does passing the raw flags variable to dentry_open()
in shmem_luo_create_tmpfs_file() in mm/shmem_luo.c bypass the flag
normalization performed by file_open_root() -> build_open_flags()?

In fs/open.c, build_open_flags() strips O_CLOEXEC and ensures O_DSYNC is set
when __O_SYNC is present:

    u64 flags =3D how->flags;
    u64 strip =3D O_CLOEXEC;
    ...
    flags &=3D ~strip;
    ...
    if (flags & __O_SYNC)
        flags |=3D O_DSYNC;

Because dentry_open() -> alloc_empty_file() -> init_file() initializes
ro_file->f_flags directly from the passed flags and do_dentry_open() only
clears:

    f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | __O_REGULAR);
    f->f_iocb_flags =3D iocb_flags(f);

passing O_RDONLY | O_CLOEXEC in arg->flags leaves O_CLOEXEC in
ro_file->f_flags (visible via fcntl(fd, F_GETFL) and /proc/<pid>/fdinfo/<fd=
>),
and passing O_RDONLY | __O_SYNC without O_DSYNC leaves O_DSYNC and IOCB_DSY=
NC
unset on ro_file.

Should dentry_open() be passed (file->f_flags & ~O_ACCMODE) | O_RDONLY inst=
ead
of flags so that ro_file uses the normalized flags from file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D9

