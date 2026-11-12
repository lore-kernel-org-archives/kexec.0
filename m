Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17329606A32A
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zQdfuab3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7oworxH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sM9FfP0zyszmMrgXJ0phgeLchPzm+/kuKHgm7FbXyLo=; b=zQdfuab3y/E9b+1mWh6axQvZOM
	BpsEalHZFvf2ogHyTyjpdh1uZc1GjY0it87xjx2y3iZIRT7EUj/5N/Gh/x3Rhv+zXzZCuXEdUawRb
	5rYabZkASbstj/Sqlyz49DyQxp52n78P+KuneBt48E0EmbSK/hamychXdNl/f9vHowtgFHp+HH3xS
	lzieY9qfyS1K1r3qc9gP/JMd8lC7ItK/vApDNR4cs/hWL9Bgj1kcgNFS1a4AUhwESDNbiQb5pqDvn
	8WFqLWeFCDEmRcYhmc11xUWz4UctthgdUSIULKmpTDQ0jfRzVyNu90Zz4HHIYA9DONc+k+E82gmVg
	omdtc4NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIir-00000008FNM-3DNP;
	Thu, 12 Nov 2026 00:31:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIio-00000008FJL-2xPZ
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C05FA633BF;
	Thu, 12 Nov 2026 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869381F00A05;
	Thu, 12 Nov 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443481;
	bh=sM9FfP0zyszmMrgXJ0phgeLchPzm+/kuKHgm7FbXyLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7oworxHXPHYvhLTDqK5HshSAhlCDtckAZGdB75jVM/OF9eGX9G6zrrrYyUf6Oy+t
	 3XKp3COx88PfmVzzWKWPD+gfhSf6jxV5k4FvvbEqMhZzwK0g2VSSwg5UDxKqCaoNGM
	 83OXjt6jRpTVyaulUa3gd8+hSwmK6MXtGqarQBsLuaJmdggNAftWy49Y/Pl8dNpO8b
	 nP63N2JgqckUyHCBcYF6jLTiNkp3KEjdB+gu6zM/RPWwnDkZ3ztZG7Kvey3/QmlTUE
	 fvfQosLMUti2eINt52oxI0yi804ppbl6IMCM+F25mSiS3OXcG2Zx8EO+GXdlT80G61
	 Gsi4SjdY7+dIg==
Message-ID: <sashiko-outbox-209944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/19] mm/shmem_luo: Retrieve tmpfs files into a file
 created by userspace
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
In-Reply-To: <20261111002358.1842967-13-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:20 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mm/shmem_luo: tail pages dropped on folio split in
  shmem_luo_retrieve_into()
- [Medium] mm/shmem_luo: race with khugepaged/MADV_COLLAPSE in
  shmem_luo_retrieve_into()
--

commit 780f293994f8e014ce055385564e7193d31d8556
Author: David Matlack <dmatlack@google.com>

mm/shmem_luo: Retrieve tmpfs files into a file created by userspace

This commit adds support for retrieving preserved tmpfs files into a
userspace-created file on a tmpfs mount via LIVEUPDATE_SESSION_RETRIEVE_FD,
and adds SHMEM_LUO_FLAG_TMPFS to distinguish tmpfs files from memfds.

> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index bdf90aac5820f..7242664ee4aee 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
[ ... ]
> @@ -577,6 +603,86 @@ static int shmem_luo_restore_folios(struct file *fil=
e,
>  	return err;
>  }
> =20
> +/*
> + * Restore a preserved tmpfs file into the file that userspace passed in=
 the
> + * retrieve argument.
> + */
> +static int shmem_luo_retrieve_into(struct liveupdate_file_op_args *args,
> +				   struct shmem_luo_ser *ser)
> +{
> +	const struct liveupdate_shmem_retrieve_arg *arg =3D args->arg;
> +	struct inode *inode;
> +	struct file *file;
> +	int err;
> +
> +	if (!arg)
> +		return -EINVAL;
> +
> +	CLASS(fd, target)(arg->fd);
> +	if (fd_empty(target))
> +		return -EBADF;
> +
> +	file =3D fd_file(target);
> +	inode =3D file_inode(file);
> +
> +	/* Like the preserved file, the file must be on a tmpfs mount. */
> +	if (!shmem_file(file) || shmem_inode_on_internal_mount(inode))
> +		return -EINVAL;
> +
> +	if (!(file->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	/* Fill the file like a write, which also takes these locks. */
> +	file_start_write(file);
> +	inode_lock(inode);
> +
> +	err =3D -EPERM;
> +	if (IS_IMMUTABLE(inode))
> +		goto unlock;
> +
> +	err =3D -EINVAL;
> +	if (i_size_read(inode) || !mapping_empty(inode->i_mapping))
> +		goto unlock;
> +
> +	err =3D liveupdate_claim_file(args, file);
> +	if (err)
> +		goto unlock;
> +
> +	err =3D file_modified(file);
> +	if (err)
> +		goto unclaim;
> +
> +	/* The preserved state is consumed from here on. */
> +	args->retryable =3D false;
> +
> +	/*
> +	 * The folios are past the end of the file until i_size is set below,
> +	 * so reads, page faults and memfd_pin_folios() don't see them, and
> +	 * they can be removed again if adding one fails.
> +	 */
> +	err =3D shmem_luo_restore_folios(file, ser);

[Severity: Medium]
Can khugepaged or MADV_COLLAPSE race with shmem_luo_restore_folios() if the
target tmpfs file is mmap()ed?

shmem_mmap_prepare() does not take inode_lock(inode), and
shmem_luo_retrieve_into() checks mapping_empty() but not mapping_mapped().
Unlike shmem_fallocate(), which leaves newly allocated folios beyond i_size=
 as
!uptodate, shmem_luo_retrieve_folios() marks each restored folio uptodate
before unlocking it on the LRU:

CPU0                                  CPU1
shmem_luo_retrieve_into()
  inode_lock(inode)
  args->retryable =3D false
  shmem_luo_restore_folios()
    shmem_luo_retrieve_folios()
      /* restores folio at index 0 */
      shmem_add_to_page_cache()
      folio_mark_uptodate(folio)
      folio_unlock(folio)
                                      madvise(..., MADV_COLLAPSE)
                                        ...
                                          collapse_file()
                                            /* sees uptodate folio at 0,
                                             * treats indices 1..511 as
                                             * holes without checking
                                             * i_size, installs 2M folio */
      /* restores folio at index 1 */
      shmem_add_to_page_cache()
        --> returns -EEXIST           <-- permanent retrieve failure

Neither collapse_file() nor try_collapse_pte_mapped_thp() acquires
inode_lock(inode) or checks i_size_read(inode) when a shmem folio is already
uptodate:

mm/khugepaged.c:collapse_file() {
    ...
			if (xa_is_value(folio) || !folio_test_uptodate(folio)) {
				xas_unlock_irq(&xas);
				/* swap in or instantiate fallocated page */
				if (shmem_get_folio(mapping->host, index, 0,
						&folio, SGP_NOALLOC)) {
					result =3D SCAN_FAIL;
					goto xa_unlocked;
				}
				/* drain lru cache to help folio_isolate_lru() */
				lru_add_drain();
			} else if (folio_trylock(folio)) {
    ...
}

In addition to causing shmem_add_to_page_cache() to fail with -EEXIST after
args->retryable is set to false, try_collapse_pte_mapped_thp() can install a
huge PMD into userspace page tables while i_size is still 0, exposing folios
before the retrieve finishes.

> +	if (err) {
> +		shmem_truncate_range(inode, 0, (uoff_t)-1);
> +		goto unclaim;
> +	}
> +
> +	i_size_write(inode, ser->size);

[Severity: Medium]
Can a folio split during shmem_luo_restore_folios() drop the tail pages of a
restored large folio because both i_size and SHMEM_I(inode)->fallocend are =
0?

shmem_luo_retrieve_folios() unlocks each restored folio and places it on the
LRU while subsequent iterations allocate XArray nodes and charge memcg and
quotas with GFP_HIGHUSER_MOVABLE and GFP_KERNEL. If page reclaim or migrati=
on
splits an already-inserted large folio before i_size_write() runs,
__folio_freeze_split_file() computes the EOF index from i_size and
shmem_fallocend():

mm/huge_memory.c:__folio_freeze_split_file() {
    ...
	end =3D DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
	if (shmem_mapping(mapping))
		end =3D shmem_fallocend(mapping->host, end);
    ...
}

Because both i_size and info->fallocend are 0, end is 0, so every split
sub-folio with new_folio->index >=3D 1 is treated as beyond EOF, removed fr=
om
mapping->i_pages, and freed, silently corrupting the retrieved file. Setting
SHMEM_I(inode)->fallocend before shmem_luo_restore_folios() (as
shmem_fallocate() does) would prevent splits from discarding pages past
i_size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D12

