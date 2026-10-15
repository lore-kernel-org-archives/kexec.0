Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39674CC6B34
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwF7qMRvUs/aGLzXJDofOjX9Pjph2gGhbITBTTJ9FNc=; b=IFJjz483MuthlXwj0Nz+KqF4W+
	sQVBRFzfthe6EuAS3V9gdftHwjkWi8GAQJIN2lvONB9NLv2HYrpqMSWZHIxdYuQI2mSppb5FG2UPa
	WGeCHZ5T3mIheGzU/HeFEF6nrGLvoXpm+eqaMMoiIeBisyubsrZj8lNg7BfE66oD5QiXd2oyBtRQd
	ldtFJU4UzlIoUUzXn9oEsqKHUGbcNmV07i+JG+TRmH8geOoJ4HfEhU7kt4eAR0OK8Bf7R3Zb6LV3i
	9ipbfzCqq2RfaWWo+mP/fN0Y3EhTmRv2SLlt0R7tCFRm2XERheOKSSsf1UwdfGp2VzgJ17OtO6IA1
	/qF76JNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHIAA-0000000HLo1-0Ury;
	Thu, 15 Oct 2026 09:54:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHIA5-0000000HLnJ-3er8
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:54:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 612FF4082A;
	Thu, 15 Oct 2026 09:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E092F1F000C4;
	Thu, 15 Oct 2026 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058049;
	bh=iwF7qMRvUs/aGLzXJDofOjX9Pjph2gGhbITBTTJ9FNc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CJOOFm7PaQMvAR57nn02bMXeahBXZFgd7IygUGVcn4kM5Z8s6NdQt/RYUmh5pri2e
	 l8Lul2Lntcloc7y4WZ0LbdlYTAOorvk3YGS5LuBe6YkAnZ7rmOoBWMfBpX2yUIvR8K
	 dO0HDdW51MtYFfm6qMtqHBs6nDmEBXHOlyM8/oHzRuP7fvfc2iphS/sLBwBDQpB/Sz
	 TJcEfpydFS9yoRljz/oBxFg/14xWdlZCshJmH9LkmCFQcjuDxvX88qRlqWkHLF7nLe
	 qhqlo0pRE3r0adO8tK7Tgljo7khScdWfvlGm5OzXNwaYEYbg9lwqOI34wg5dcAK7Hz
	 LnsAcU+PEOcEg==
Message-ID: <sashiko-outbox-172604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] mm/memfd_luo: Support tmpfs preservation and
 retrieval
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-7-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:54:08 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm: memfd_luo_retrieve drops file seals on tmpfs retrieval causing=
 security bypass
- [High] mm: memfd_luo_retrieve ABBA deadlock between inode lock and f_pos_=
lock
- [High] mm: permanent leak of KHO folios on early memfd_luo_retrieve errors
--

commit 54190d07831630c2e724ceea33310f62bf42a6dd
Author: David Matlack <dmatlack@google.com>

mm/memfd_luo: Support tmpfs preservation and retrieval

This commit relaxes memfd_luo_can_preserve() to support general shmem-backed
files, allowing userspace to preserve standard tmpfs files across kexec. It
introduces a new MEMFD_LUO_FLAG_TMPFS flag and a new UAPI struct
liveupdate_memfd_retrieve_arg to support restoring preserved tmpfs folios
to a newly created tmpfs file.

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -516,10 +519,60 @@ static int memfd_luo_retrieve_folios(struct file *f=
ile,
>  	return err;
>  }
> =20
> +static struct file *memfd_luo_get_tmpfs_file(struct liveupdate_file_op_a=
rgs *args)
> +{
> +	const struct liveupdate_memfd_retrieve_arg *rarg =3D args->arg;

[ ... ]

> +	inode =3D file_inode(file);
> +	inode_lock(inode);
> +	if (!inode->i_nlink) {
> +		err =3D -EINVAL;
> +		goto unlock_inode;
> +	}

[ ... ]

> +	return file;
> +
> +unlock_inode:
> +	inode_unlock(inode);
> +put_file:
> +	fput(file);
> +	return ERR_PTR(err);
> +}
> +
>  static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  {
>  	struct memfd_luo_folio_ser *folios_ser;
>  	struct memfd_luo_ser *ser;
> +	struct inode *inode;
>  	struct file *file;
>  	int err;
> =20
> @@ -527,50 +580,75 @@ static int memfd_luo_retrieve(struct liveupdate_fil=
e_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
> =20
> -	/* Make sure the file only has seals supported by this version. */
> -	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
> +	/* Make sure the file only has seals and flags supported by this versio=
n. */
> +	if ((ser->seals & ~MEMFD_LUO_ALL_SEALS) ||
> +	    (ser->flags & ~MEMFD_LUO_ALL_FLAGS)) {
>  		err =3D -EOPNOTSUPP;
>  		goto free_ser;
>  	}

[Severity: High]
Does this error path permanently leak the KHO memory?

If memfd_luo_retrieve() encounters a permanent error here (like unsupported
seals), it jumps to free_ser and returns an error without setting
args->retryable =3D true. The LUO core then records this negative error code
in luo_file->retrieve_status.=20

When memfd_luo_finish() is later called:

	if (args->retrieve_status)
		return;

It returns early because args->retrieve_status !=3D 0, never attempting to
discard the ser->folios vmalloc array or the underlying physical data
folios. Those folios would remain permanently reserved in memblock.

> +	if (ser->flags & MEMFD_LUO_FLAG_TMPFS) {
> +		file =3D memfd_luo_get_tmpfs_file(args);
> +		if (IS_ERR(file)) {
> +			args->retryable =3D true;
> +			return PTR_ERR(file);
> +		}
> +		inode =3D file_inode(file);
> +	} else {
> +		if (args->arg) {
> +			args->retryable =3D true;
> +			return -EINVAL;
> +		}
> =20
> -		/*
> -		 * The seals are preserved. Allow sealing here so they can be added
> -		 * later.
> -		 */
> -		file =3D memfd_alloc_file("", MFD_ALLOW_SEALING);
> -		if (IS_ERR(file)) {
> -			pr_err("failed to setup file: %pe\n", file);
> -			err =3D PTR_ERR(file);
> -			goto free_ser;
> -		}
> +		/*
> +		 * The seals are preserved. Allow sealing here so they can be
> +		 * added later.
> +		 */
> +		file =3D memfd_alloc_file("", MFD_ALLOW_SEALING);
> +		if (IS_ERR(file)) {
> +			pr_err("failed to setup file: %pe\n", file);
> +			err =3D PTR_ERR(file);
> +			goto free_ser;
> +		}
> =20
> -	err =3D memfd_add_seals(file, ser->seals);
> -	if (err) {
> -		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
> -		goto put_file;
> -	}
> +		err =3D memfd_add_seals(file, ser->seals);
> +		if (err) {
> +			pr_err("failed to add seals: %pe\n", ERR_PTR(err));
> +			goto put_file;
> +		}
> +
> +		inode =3D file_inode(file);
> +		inode_lock(inode);
> +	}

[Severity: High]
Does this bypass security seals on retrieved tmpfs files?

memfd_luo_preserve() records seals in ser->seals for all files. However,
the tmpfs branch above entirely skips calling memfd_add_seals(). If an
immutable or write-sealed memfd was linked to the filesystem prior to kexec,
it appears it will be restored into the user's empty tmpfs file without any
seals applied, resulting in a fully writable and modifiable file.

>  	if (ser->nr_folios) {
>  		folios_ser =3D kho_restore_vmalloc(&ser->folios);
>  		if (!folios_ser) {
>  			err =3D -EINVAL;
> -			goto put_file;
> +			goto unclaim_file;
>  		}
> =20
>  		err =3D memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
>  		vfree(folios_ser);
>  		if (err)
> -			goto put_file;
> +			goto unclaim_file;
>  	}
> =20
> +	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);

[Severity: High]
Can this create an ABBA deadlock between inode_lock and f_pos_lock?

For tmpfs files, memfd_luo_get_tmpfs_file() acquires and returns with
inode_lock(inode) held. Later, vfs_setpos() is called here, which acquires
mutex_lock(&file->f_pos_lock) while inode_lock is still held.

Since the file is a normal file descriptor passed by userspace, the standard
VFS write path acquires file->f_pos_lock first via fdget_pos(), and then
acquires inode_lock(inode) inside the filesystem's write iterator. A
concurrent write() on the provided file descriptor could trigger a deadlock.

> +	i_size_write(inode, ser->size);
> +	inode_unlock(inode);
> +
>  	args->file =3D file;
>  	kho_restore_free(ser);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D6

