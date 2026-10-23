Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FE606A31B
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jNt+emTN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuAJbYMr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GygIZUeQPDgjzcgayWtCyGqakcgizYpxe/r2dAOwyD8=; b=jNt+emTNUv0Wvopr6/xJT7+5jc
	vcsoRdj0scZgxBydjxscfEaTi1qwbfZqozDzX9z1bxKH7zOlGdtLm9vJsO3T5jFL+Wefs4MLePmaL
	hJ4/UJ+3Kx3GTN2hSGOnZ1UeqloLRJbQySsMvOdBkvYoC1U2VxZYIri5DCIj2NLEOGwQpmHkhFaeX
	COAyIVgR6z/Q07zfke0JyjfM2hap32NMuLmfyoCwl/FnbGJNBqT9PyGQfGJeY3NvArFzYVIuMK1Rf
	VZfzZmUe4+n9bH63tQIfpScNPhjOvloWTUUzhlqD2hmhFNFS0/RvobhkYqvpqcCaaMzpQPByNL3RN
	BGMz/LxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6u-0000000H4kv-3CeX;
	Fri, 23 Oct 2026 22:51:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6t-0000000H4jm-3iFv
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A08BF43DAD;
	Fri, 23 Oct 2026 22:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9E61F01825;
	Fri, 23 Oct 2026 22:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795899;
	bh=GygIZUeQPDgjzcgayWtCyGqakcgizYpxe/r2dAOwyD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuAJbYMrOFitokghd/i8WqShNvfHSVeplcNPAl2bRFES2mGns/4cnCzywolAeCVIc
	 UYgDYjPumQAVpF2UO6tjvz+MQeUUpQv3NrRV8AC+Iu1WW0HtG3Vvd8sLKGp6Uz4kaX
	 nmrbsMxaz0mKsPxvOQbsJOzfqCAQOuEFrbrJfG23xcOAxVT10xklAMdpZ99qk9dinq
	 Ni9IeToJrNd+vZ/XLQcLnzKDPdn7uGin9jDapQxFmJHhGnbF0H2VYEuNXAQH2MnzRi
	 J+3a4wVZtMpz64b9u//RMXAEYGw3TR3K7jUNFwIp8iiW0aJjaG/05p8bm0Xyrn+FXq
	 s5wUt6UkSYVsg==
Message-ID: <sashiko-outbox-183327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] mm/shmem_luo: Allow preserving tmpfs files
 that are still linked
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
In-Reply-To: <20261022225035.377445-9-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:38 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/shmem_luo: missing FMODE_READ and MAY_READ check in shmem_luo_m=
ay_preserve()
- [Medium] mm/shmem_luo: missing IS_APPEND() check in shmem_luo_may_preserv=
e()
--

commit c078673247a58afcd0e7d24e1253ad5aeb43414c
Author: David Matlack <dmatlack@google.com>

mm/shmem_luo: Allow preserving tmpfs files that are still linked

This commit allows preserving tmpfs files that still have links in the
filesystem by removing the !inode->i_nlink restriction in
shmem_luo_can_preserve(). Because preserving a file freezes its size for all
users, it adds shmem_luo_may_preserve() to require write permission (or
ownership when the file is immutable or on a read-only superblock) and
documents the new behavior.

> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index ecbeb37d33a8a..aba2bc1f18c52 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c

[ ... ]

> @@ -298,6 +315,34 @@ static void shmem_luo_unpreserve_folios(struct kho_v=
malloc *kho_vmalloc,
>  	vfree(folios_ser);
>  }
> =20
> +/*
> + * Check whether the caller may preserve @file. Preserving the file free=
zes its
> + * size until it is unpreserved, for all users of the file, so require
> + * permission to write to the file. Like FS_IOC_ENABLE_VERITY, don't req=
uire a
> + * file opened for writing, so that e.g. a binary that is being executed=
 can be
> + * preserved, nor a writable mount. If the size of the file can't change
> + * anyway, because it is on a read-only superblock or immutable, its own=
er may
> + * also preserve it. The size could only change again after the file is =
made
> + * writable, which is up to the owner or root.
> + *
> + * Preserving the file also fills its holes, but that doesn't need any
> + * permission: Anyone who can read the file can fill its holes by faulti=
ng
> + * them in through a read-only mapping.
> + */
> +static int shmem_luo_may_preserve(struct file *file)
> +{
> +	struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> +	struct inode *inode =3D file_inode(file);
> +	int err;
> +
> +	err =3D inode_permission(idmap, inode, MAY_WRITE);

[Severity: High]
Should shmem_luo_may_preserve() in mm/shmem_luo.c also verify that the file
is open for reading (file->f_mode & FMODE_READ) or that the caller has
MAY_READ permission?

The comment above notes that anyone who can read the file can fill its holes
through a read-only mapping, and models the check on FS_IOC_ENABLE_VERITY.
However, fsverity_ioctl_enable() in fs/verity/enable.c explicitly checks
FMODE_READ in addition to MAY_WRITE:

    err =3D file_permission(filp, MAY_WRITE);
    if (err)
        return err;
    if (!(filp->f_mode & FMODE_READ))
        return -EBADF;

Similarly, do_mmap() in mm/mmap.c rejects mapping a file when FMODE_READ is
not set:

    if (!(file->f_mode & FMODE_READ))
        return -EACCES;

Without a read check in shmem_luo_may_preserve(), a user who opens a
write-only tmpfs file (for example, mode 0622 or 0222 in /dev/shm owned by
another user) with O_WRONLY, or who holds an ioctl-only mode-3 file
descriptor lacking FMODE_READ, can pass it to LIVEUPDATE_SESSION_PRESERVE_F=
D:

    luo_preserve_file()
      -> shmem_luo_preserve()
        -> shmem_luo_may_preserve()
        -> shmem_luo_preserve_folios()
          -> memfd_pin_folios()

This faults in and pins folios for the entire file (including holes), and on
LIVEUPDATE_SESSION_RETRIEVE_FD, shmem_luo_retrieve() ->
shmem_luo_create_tmpfs_file() in mm/shmem_luo.c places those folios into a
new tmpfs file opened with caller-chosen flags (such as O_RDWR or O_RDONLY)
and mode:

    file =3D file_open_root(&fd_file(dir)->f_path, ".",
                          O_TMPFILE | O_LARGEFILE | arg->flags, arg->mode);

Wouldn't that allow a caller with only write access to read the file's
contents after retrieval?

> +	if (err && (sb_rdonly(inode->i_sb) || IS_IMMUTABLE(inode)) &&
> +	    inode_owner_or_capable(idmap, inode))
> +		return 0;
> +
> +	return err;
> +}

[Severity: Medium]
What happens if shmem_luo_may_preserve() in mm/shmem_luo.c is called on an
append-only (S_APPEND) tmpfs inode?

Tmpfs supports setting S_APPEND via FS_IOC_SETFLAGS in
shmem_fileattr_set() -> shmem_set_inode_flags() in mm/shmem.c:

    if (fsflags & FS_APPEND_FL)
        i_flags |=3D S_APPEND;

Unlike IS_IMMUTABLE(inode), inode_permission(idmap, inode, MAY_WRITE) does
not reject S_APPEND inodes. In fs/verity/enable.c, fsverity_ioctl_enable()
explicitly checks IS_APPEND(inode) after checking MAY_WRITE:

    if (IS_APPEND(inode))
        return -EPERM;

When a caller with MAY_WRITE permission on an S_APPEND tmpfs file preserves
it via LIVEUPDATE_SESSION_PRESERVE_FD -> luo_preserve_file() ->
shmem_luo_preserve(), shmem_freeze(inode, true) sets SHMEM_F_MAPPING_FROZEN.
Because all writes to an S_APPEND file extend past i_size,
shmem_write_begin() and shmem_fallocate() in mm/shmem.c will then fail with
-EPERM:

    if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
                 pos + len > inode->i_size))
        return -EPERM;

Should shmem_luo_may_preserve() also reject IS_APPEND(inode) with -EPERM so
an append-only writer cannot freeze the file and block future appends by all
users?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D8

