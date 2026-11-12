Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340F606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QQDVQiv2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCcCJ8x/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=srOQgDgWOAX6/I0jdHPGkFLTExl16V3iCD3iaXGFZbc=; b=QQDVQiv2aU5Fq1cZtUSDO0im7Y
	Q9b/lYxY+7E2JPOjnwEiaBafinfJoZNlHTdbL/WQKxpcPerMQ9PzcuV/ZCyDwMnraH2btVoeGJo52
	3+qhOJ8Pd10Eq8E+Rr4uU0kzYNfWuhEtCxCVQK9Ay2NfAgmYUV0inasQTe0XqY/490lwK6FUEIURZ
	OH4Rw6HWoCwH+6VkHaM6FqLGV4ezKp4DYQ8/AvYhFeXN5gzilWq2+UDpEdOhRPumtsQKIp0cFEDSo
	9WcpCYYftKMZ64ChIDjaoQ8kkio1vAxZO18z0l5a5tXdR7DO+7YfRyAhIRVyTXkzdh1r3Sgy0mo+s
	9a3Lc2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdQ-00000008ynj-3yVq;
	Thu, 12 Nov 2026 07:54:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdJ-00000008ylf-3QxD
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 91C8041FE2;
	Thu, 12 Nov 2026 07:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5741F00A05;
	Thu, 12 Nov 2026 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470049;
	bh=srOQgDgWOAX6/I0jdHPGkFLTExl16V3iCD3iaXGFZbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCcCJ8x/RCBqNneH4WLnogtIy8nJ+mADSpqmiS2iU2yt3Xw6Xs6MXkn82gym9ZfmP
	 SX1G7oQyisadY4glTOtkD1xYymXtm1VcBG5OxSLGm9kQvyKsLhKzECxIra+OnMFcnb
	 pT8kFGSjTdDi89bK1GGi4+LgTX4UTKdcCBZGnRzYKnNHKQlY8w5GLm6HNS56oY+Onk
	 dlXUpnsJiaJPethe3oXSPeKhUNGvEXwPrOJnuRZexggndWle5qryODtfXOcFqFiin0
	 uPZBR12WOn43THE4p+5sdS1b+WNVQwlAxsoZrAe3v+w29UgtSN7RODONuyfCSCRB7i
	 OMeEYVQtST4cQ==
Message-ID: <sashiko-outbox-210639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] liveupdate: Make failed retrieves distinguishable
 from dropped files
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, kernel-team@meta.com
In-Reply-To: <772c150d0a90139a327803cecf087f6865702753.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <772c150d0a90139a327803cecf087f6865702753.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:08 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] liveupdate: uninitialized file pointer in
  luo_session_retrieve_fd() [1]
- [High] liveupdate: pointer used as XArray index in luo_preserve_file()
  [2]
--

commit acd081aa3a5ef33bac09be5e151d1de15512ea3e
Author: Chris Down <chris@chrisdown.name>

liveupdate: Make failed retrieves distinguishable from dropped files

This commit exposes incoming live update deserialization state and session
and file retrieval counters under /sys/class/misc/liveupdate/incoming/.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a39992da504fb..3aac1afa05c09 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -543,6 +543,16 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
>  	memset(file_set_ser, 0, sizeof(*file_set_ser));
>  }
> =20
> +/* Record the first retrieve result. A negative status is permanent. */
> +static void luo_file_set_retrieve_status(struct luo_file *luo_file, int =
status)
> +{
> +	luo_file->retrieve_status =3D status;
> +	if (status > 0)
> +		atomic_long_inc(&luo_incoming_stats.files_retrieved);
> +	else
> +		atomic_long_inc(&luo_incoming_stats.files_failed);
> +}
> +
>  /**
>   * luo_retrieve_file - Restores a preserved file from a file_set by its =
token.
>   * @file_set: The file_set from which to retrieve the file.
> @@ -611,7 +621,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, =
u64 token,
>  	err =3D luo_file->fh->ops->retrieve(&args);
>  	if (err) {
>  		/* Keep the error code for later use. */
> -		luo_file->retrieve_status =3D err;
> +		luo_file_set_retrieve_status(luo_file, err);
>  		return err;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can a positive return from
fh->ops->retrieve() cause luo_session_retrieve_fd() to pass an uninitialized
struct file pointer to fd_install() [1]?

If fh->ops->retrieve() returns a positive value, luo_retrieve_file() returns
without initializing *filep (and luo_file_set_retrieve_status() records it =
as
a retrieved file with status > 0).  luo_session_retrieve_fd() only checks
for negative errors before installing the stack variable into the process
file descriptor table:

kernel/liveupdate/luo_session.c:luo_session_retrieve_fd() {
	...
	struct file *file;
	...
	err =3D luo_retrieve_file(&session->file_set, argp->token, &file);
	mutex_unlock(&session->mutex);
	if (err < 0)
		goto err_put_fd;

	err =3D luo_ucmd_respond(ucmd, sizeof(*argp));
	if (err)
		goto err_put_file;

	fd_install(argp->fd, file);
}

luo_ioctl_retrieve_session() has the same pattern with luo_session_retrieve=
().
Any subsequent syscall on the installed fd dereferences the uninitialized
stack pointer.

> @@ -624,7 +634,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, =
u64 token,
>  			  luo_file->file, GFP_KERNEL));
> =20
>  	*filep =3D luo_file->file;
> -	luo_file->retrieve_status =3D 1;
> +	luo_file_set_retrieve_status(luo_file, 1);
> =20
>  	return 0;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but why does
luo_preserved_files use raw kernel pointers from luo_get_id() as XArray
indices [2]?

kernel/liveupdate/luo_file.c:luo_get_id() {
	return fh->ops->get_id ? fh->ops->get_id(file) : (unsigned long)file;
}

Both luo_preserve_file() and luo_retrieve_file() pass luo_get_id() directly
as the index to xa_insert(&luo_preserved_files, ...).  Because XArray is a
radix tree designed for dense small integer indices, indexing it by sparse
64-bit pointer values forces the allocation of up to 11 levels of
intermediate tree nodes per entry, wasting memory and risking OOM.

[1] https://sashiko.dev/#/bug/linux-65e3446e-27d6-4415-82bb-0036dcc7aa0b
[2] https://sashiko.dev/#/bug/linux-80cdb953-2e71-4aca-9067-108b66f83aaa

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D3

