Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24968606A31E
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FRGtRKDH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqYKCbF0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x3MJzrZxWtNJBKkoxKkXdy3LcJvsbWutGHSCpDKZ3ao=; b=FRGtRKDHtmsBujsKANokl/c/Hm
	MqELxFh6bzyV2SMmD7LxMmu5Iqi7KalxPC722SoNuxxVJ7Z1XaizKad+t22QdsIMou1fYDP67lND1
	KSpC+V8gpM8DcHFwoBBwFLhGxW2Y8uIWTMix6sr6p9mW0P25Df58kzOryU5i9EQuqb+KuMNkaTpft
	XwKHpEUpUr2xUB65OUGJAxLvHx0UVM5auwTfyakF5kMJIoPAoHKQj7OYqDDVbqX5/1Fwc27fbbM7X
	5vzhKxSpLngKqYE96aJM1GZtrvnmEIMHd/36TTT2AKGEBCnfOt7+rh9iejNvuL4GeK7zFjAv40YHL
	5KXnDR3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0FC-000000085yX-2p0o;
	Tue, 24 Nov 2026 23:48:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0FB-000000085yP-19TG
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 23:48:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9F0D4234F;
	Tue, 24 Nov 2026 23:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D01F000CF;
	Tue, 24 Nov 2026 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564092;
	bh=x3MJzrZxWtNJBKkoxKkXdy3LcJvsbWutGHSCpDKZ3ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqYKCbF0PlRw+T183XyiDDeQMA9gFsm27TU/hnB+mfFhD/ScjiVDSVz8ZxGwCKTDV
	 3Og4OsE8htv87a5B8mziTQyVeRy8bPs5s6AKgtkH7+FQ5iRU0aWia7cCX2ApP+2WNV
	 AeDYvei6ciqwheb3PPso4jefNDmopqbrIJVSILIMglPhOMDbr7MXJoJocTcjpl+jJo
	 bV4qQJZXM/dWa/k36SehNVn72Eobpr9vF2rhuJpg5fsjkMlHELjR+a9dIp1Do6JPZ3
	 VJ3TGBh3BipG5kn4wMYJXN1RfuwVRpiXXuzQEqODE8kZ4zfZqBwMFz1w/2ajBdqiHj
	 RFxMHePyK+Y0g==
Message-ID: <sashiko-outbox-232248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/18] mm/shmem_luo: Retrieve tmpfs files into a file
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
In-Reply-To: <20261123233924.3970932-12-dmatlack@google.com>
References: <20261123233924.3970932-1-dmatlack@google.com>
 <20261123233924.3970932-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 23:48:10 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mm/shmem_luo: leak of preserved folios on error in
  shmem_luo_retrieve()
- [Medium] mm/shmem_luo: race between resetting fallocend and
  __folio_split() drops pages
--

commit a56e31ee7bf0ce9b4eb0f3ed9175bc42d7abd83d
Author: David Matlack <dmatlack@google.com>

mm/shmem_luo: Retrieve tmpfs files into a file created by userspace

This commit adds support for retrieving preserved tmpfs files into a
userspace-created tmpfs file passed via struct
liveupdate_shmem_retrieve_arg, and marks tmpfs files with
SHMEM_LUO_FLAG_TMPFS during preservation.

> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index 854a49cd0aaa5..2ea161fb00fc1 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
[ ... ]
> @@ -554,6 +580,108 @@ static int shmem_luo_retrieve_folios(struct file *f=
ile,
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
[ ... ]
> +	fallocend =3D info->fallocend;
> +	if (ser->nr_folios) {
> +		folios_ser =3D kho_restore_vmalloc(&ser->folios);
> +		if (!folios_ser) {
> +			err =3D -EINVAL;
> +			goto free_ser;
> +		}
> +
> +		/*
> +		 * The folios are past the end of the file until i_size is set
> +		 * below, so reads, page faults and memfd_pin_folios() don't see
> +		 * them, and they can be removed again if adding one fails. Like
> +		 * fallocate(), raise fallocend meanwhile, so that splitting a
> +		 * large folio doesn't drop its pages past i_size.
> +		 */
> +		info->fallocend =3D ULONG_MAX;
> +		err =3D shmem_luo_retrieve_folios(file, folios_ser,
> +						ser->nr_folios);
> +		vfree(folios_ser);
> +		if (err)
> +			goto truncate;
> +	}
> +
> +	i_size_write(inode, ser->size);
> +	info->fallocend =3D fallocend;

[Severity: Medium]
Can a concurrent folio split observe both i_size =3D=3D 0 and info->falloce=
nd
=3D=3D 0 here and drop restored pages from the page cache?

shmem_luo_retrieve_folios() adds each folio to the LRU and unlocks it, so
reclaim or migration can split a restored large folio without holding
inode->i_rwsem.  __folio_freeze_split_file() reads i_size before
info->fallocend:

CPU0                                  CPU1
shmem_luo_retrieve_into()
  info->fallocend =3D ULONG_MAX;
  shmem_luo_retrieve_folios()
    folio_add_lru(folio)
    folio_unlock(folio)
                                      split_folio_to_list()
                                        ...
                                        __folio_freeze_split_file()
                                          end =3D DIV_ROUND_UP(
                                            i_size_read(inode), PAGE_SIZE);
                                            // reads 0
  i_size_write(inode, ser->size);
  info->fallocend =3D fallocend; // 0
                                          end =3D shmem_fallocend(inode, en=
d);
                                            // reads 0, end =3D 0
                                          // drops sub-folios with index >=
=3D 0

In addition, on 64-bit kernels smp_store_release() in i_size_write() does
not prevent the plain store to info->fallocend from reordering before the
i_size update.

[ ... ]

> @@ -565,6 +693,18 @@ static int shmem_luo_retrieve(struct liveupdate_file=
_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
> =20
> +	/* Make sure the file only has flags this version supports. */
> +	if (ser->flags & ~SHMEM_LUO_ALL_FLAGS) {
> +		err =3D -EOPNOTSUPP;
> +		goto free_ser;
> +	}
> +
> +	/* Files on tmpfs mounts can only have F_SEAL_SEAL. */
> +	if ((ser->flags & SHMEM_LUO_FLAG_TMPFS) && ser->seals !=3D F_SEAL_SEAL)=
 {
> +		err =3D -EINVAL;
> +		goto free_ser;
> +	}
> +
>  	/* Make sure the file only has seals supported by this version. */
>  	if (ser->seals & ~SHMEM_LUO_ALL_SEALS) {
>  		err =3D -EOPNOTSUPP;

[Severity: Medium]
As reported by Pratyush Yadav on v4 [1], do these validation failures leak
ser->folios and all preserved data folios?

Jumping to free_ser while args->retryable is false only calls
kho_restore_free(ser) and records a non-zero retrieve_status on the file.
When the session finishes, shmem_luo_finish() returns early because
args->retrieve_status is non-zero, so the KHO vmalloc array in ser->folios
and the ser->nr_folios preserved data folios are never restored and freed.

[1] https://lore.kernel.org/r/2vxz33sv3ef3.fsf@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123233924.3970=
932-1-dmatlack@google.com?part=3D11

