Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8D606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YLRiik8/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvMQyH0f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dMRlEbt6cHro/1IG77teEVtLiLDMtq9tpaJD/wmZeq8=; b=YLRiik8/NKrwJig9yNoP1wzHW9
	P6S8dLHqjWbl9jzeJIUgPb+Rg0AnC8sMBgNeVBbsY/URvDvkCuMN5j6xWUSJzTo+CprVnqrnDQ7Ja
	k9mqxJBt0syGofZl8Y3a8iIQm5YD6aQgGYDd2nuaBq666esvMuTWqBqDKXLaIJ83vy2mDSQKNM3ii
	aH5y0k/S9WqKItNUEvO3QYtSJzH7V7mSXZMwvH942/YtxNA+7yekhpcYwhCnyBihZOrZbAm+UnKi9
	XGFzygEX3H7R3K9cAkXfG7jLLk1UCVtMP9+vUcIp2UCw6wEVybcE5rlwrju6r9jTrJQhPR8VGl72U
	kjcQ2lpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe7c-000000063FA-0wsn;
	Wed, 04 Nov 2026 16:46:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe7b-000000063CQ-0OkM
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FAE760A6B;
	Wed,  4 Nov 2026 16:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6296E1F00A16;
	Wed,  4 Nov 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810758;
	bh=dMRlEbt6cHro/1IG77teEVtLiLDMtq9tpaJD/wmZeq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IvMQyH0fvGLwwH3rDmeWMLfCLYAGdIbnCG7AOu8FUrXpcI70IKaVwu29p1G8lxanC
	 qUOeAK2OnjpXBnv2US7vgM90DOjtp52wtMBTd3//9mHUWaamJQGkqBwlP2RBMYmki6
	 jf1VFR4XDyT+sYFzB9eEt1mMGb/7sXTdpPJoeALrFdo6tMxCoSpD0MGcMLBSF5Oskg
	 12jrVbegBjbo1u0Xoaa66/zOFOLBdGhyc6qv8S7xo6wIhvUCnvw91utT46e4QcgkAE
	 sDhLQVOM9U5RvpQ1scMUIV3w11TSDzscUg76rCdIH+1RbNg98eZkKIso3/Sw7tl5Nb
	 kLzFUfNWcGCug==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files
 that are still linked
In-Reply-To: <20261103010216.3447716-9-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:14 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-9-dmatlack@google.com>
Date: Wed, 04 Nov 2026 17:45:53 +0100
Message-ID: <2vxza4nok0ji.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Tue, Nov 03 2026, David Matlack wrote:

> Allow preserving tmpfs files that are still linked. To preserve any
> file, require permission to write to it and the file to be opened for
> reading, and reject append-only files.
>
> shmem_luo already accepts any shmem file without links, which includes
> unlinked tmpfs files and files created with O_TMPFILE. Accepting linked
> files means that userspace doesn't have to unlink files to preserve them
> and can keep using them by path until the live update.

No, no. As I wrote in the previous patch too, this is a *bug*, and not
"supported". Please don't treat it as such. Tell your LLM to also not
treat it as such ;-)

This patch doesn't do "Allow preserving tmpfs files that are still
linked", it does "Allow preserving tmpfs files".

>
> The path of the file isn't preserved. Like other files from tmpfs
> mounts, a linked file is retrieved onto a tmpfs mount chosen by
> userspace, which can then link it at the path it wants.
>
> While a file is preserved, its size is frozen, so truncating it,
> fallocate() and writes past its end fail with -EPERM. For a linked file,
> this affects everyone who opens the file by its path, so a caller that
> can only read the file, e.g. a world-readable file in /dev/shm, could
> use it to break the owner of the file. So require permission to write to
> the file to preserve it, for all files. Like FS_IOC_ENABLE_VERITY, don't

That makes sense, but can you do it for memfd as well please, as a
preparatory patch?

> require a file opened for writing, so that binaries that are being
> executed can still be preserved through read-only fds. Also don't
> require a writable mount, since preserving a file doesn't write to the
> filesystem. If the size of the file can't change anyway, because it is
> immutable or on a read-only superblock, also let its owner preserve it.
> Don't let others do that, since the size could change again once the
> file is made writable. Like FS_IOC_ENABLE_VERITY, reject append-only
> files, since their writers can only append to them, and freezing their
> size would stop all appends.
>
> Also like FS_IOC_ENABLE_VERITY, require the file to be opened for
> reading. The retrieved file can be read, so otherwise a caller that can
> only write to a file could preserve it to read its contents.

I've stopped reading it by this point. Sounds too LLM-ey. Please try
to make this easier to read for humans.

For example, why are we even talking about FS_IOC_ENABLE_VERITY? I
reckon you have it in your chat as an example to draw design from, but
then LLMs have a tendency to leak those information in patch logs. I
usually spawn a subagent with clean context and a high level description
of the goal to review the changes and changelogs, to clean up these
things, and then of course review everything manually.

Same thing in your comments.

Please clean them up.

>
> Preserving a file also fills its holes, but don't require any permission
> for that. Anyone who can read a tmpfs file can already fill its holes by
> faulting them in through a read-only mapping, also on read-only mounts
> and for immutable files.
>
> Document the frozen size and the permission requirements.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  mm/shmem_luo.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index ecbeb37d33a8..0c012f242fc5 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
> @@ -28,6 +28,24 @@
>   * the file are preserved. All others are reset to default. The preserved
>   * properties are described below.
>   *
> + * A tmpfs file can be preserved even if it is linked, but its path is not
> + * preserved. Userspace chooses where to put the file when retrieving it, as
> + * described in "Retrieving Tmpfs Files" below.
> + *
> + * Preserving a file requires it to be opened for reading, since the retrieved
> + * file can be read. It also requires permission to write to the file, since
> + * preserving it affects all of its users, as described below. But the file
> + * doesn't need to be opened for writing. For example, a binary that is being
> + * executed can be preserved through a read-only file descriptor. The owner of

Why are you talking about preserving binaries being executed? Seems
oddly specific. I didn't know that was a use case we cared about.

> + * a file whose size can't change anyway, because it is immutable or on a
> + * read-only superblock, may also preserve it. The file can be preserved
> + * through a read-only mount. Append-only files can't be preserved.
> + *
> + * While a file is preserved, its size can't change and no holes can be punched
> + * into it. Truncating the file, ``fallocate()`` and writes past the end of the
> + * file fail with ``-EPERM``. This applies to all users of the file, including
> + * users that open it by its path.
> + *
>   * .. note::
>   *    The LUO API is not stabilized yet, so the preserved properties of a memfd
>   *    or tmpfs file are also not stable and are subject to backwards
> @@ -298,6 +316,45 @@ static void shmem_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
>  	vfree(folios_ser);
>  }
>  
> +/*
> + * Check whether the caller may preserve @file. The retrieved file can be read,
> + * so require @file to be opened for reading, like FS_IOC_ENABLE_VERITY does.
> + *
> + * Preserving the file freezes its size until it is unpreserved, for all users
> + * of the file, so require permission to write to the file. Like
> + * FS_IOC_ENABLE_VERITY, don't require a file opened for writing, so that e.g.
> + * a binary that is being executed can be preserved. Also don't require a
> + * writable mount, since preserving the file doesn't write to the filesystem.
> + * If the size of the file can't change anyway, because it is on a read-only
> + * superblock or immutable, its owner may also preserve it. The size could only
> + * change again after the file is made writable, which is up to the owner or
> + * root. Reject append-only files: Their writers can only append to them, and
> + * freezing the size would stop all appends.
> + *
> + * Preserving the file also fills its holes, but that doesn't need any more
> + * permission: Anyone who can read the file can fill its holes by faulting
> + * them in through a read-only mapping.

Please rework this whole block, it's unreadable.

> + */
> +static int shmem_luo_may_preserve(struct file *file)
> +{
> +	struct mnt_idmap *idmap = file_mnt_idmap(file);
> +	struct inode *inode = file_inode(file);
> +	int err;
> +
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> +	if (IS_APPEND(inode))
> +		return -EPERM;
> +
> +	err = inode_permission(idmap, inode, MAY_WRITE);
> +	if (err && (sb_rdonly(inode->i_sb) || IS_IMMUTABLE(inode)) &&
> +	    inode_owner_or_capable(idmap, inode))

Nit: can you move these conditions up, and directly return 0 there? Much
more readable.

> +		return 0;
> +
> +	return err;
> +}
> +
>  static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
>  {
>  	struct inode *inode = file_inode(args->file);
> @@ -307,6 +364,11 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
>  	int err = 0, seals;
>  
>  	inode_lock(inode);
> +
> +	err = shmem_luo_may_preserve(args->file);
> +	if (err)
> +		goto err_unlock_inode;
> +
>  	shmem_freeze(inode, true);
>  
>  	/* Allocate the main serialization structure in preserved memory */
> @@ -362,6 +424,7 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
>  	kho_unpreserve_free(ser);
>  err_unlock:
>  	shmem_freeze(inode, false);
> +err_unlock_inode:
>  	inode_unlock(inode);
>  	return err;
>  }
> @@ -710,9 +773,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
>  static bool shmem_luo_can_preserve(struct liveupdate_file_handler *handler,
>  				   struct file *file)
>  {
> -	struct inode *inode = file_inode(file);
> -
> -	return shmem_file(file) && !inode->i_nlink;
> +	return shmem_file(file);
>  }
>  
>  static unsigned long shmem_luo_get_id(struct file *file)

-- 
Regards,
Pratyush Yadav

