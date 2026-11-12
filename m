Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD2606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gl5JF5/P;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9ljRIUP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AocDLMBbpZNZ5sJAdcXv8oijHd5rXik7WltaX6p9uk0=; b=gl5JF5/P0AX5YPLDgG6aCWV7/4
	4BPJSsuwHyjLSyTvT90KZuReY3iys5HkQb9sdl7i8K1s2IkU2KAgioyF3YlHscC4IP15uzO8hO43+
	BYv7+FCpq7/DYlVn9qj8WeG4fUZqQjPK7ZJvyzFf6PBsX4r9ONLlNaH7Wwm3CVQ6rI0RFC+XaX0CY
	66gwFiiTPkoYopaVCjkXMGQd4j2VlG74mF8G/5W0wvbec5Km5G9O8MeM3/QT5qgCkJCm2NcXjjOEF
	i+ZHrW5pcPing7zpUlayfTLRv/TUee16BOlcUxTqm/2vll+3JUParurQ7MQ90KYEuvuT7OVq3Cs1h
	qWUrLIKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIin-00000008FIC-2MEK;
	Thu, 12 Nov 2026 00:31:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIij-00000008FBT-1nd1
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E92740415;
	Thu, 12 Nov 2026 00:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1352F1F00A06;
	Thu, 12 Nov 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443477;
	bh=AocDLMBbpZNZ5sJAdcXv8oijHd5rXik7WltaX6p9uk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9ljRIUPjChz5ZGTorTsDpLvyGckMV2DlshZHj8md3qzN6r2NwbFI1JlQHFCQmpGk
	 jhTq98y0IrpAJIwlbI/J2ta5GMnFABF7G6lYU3Ob2Z7Lf83NIOU1Y64NTYGlbgH3WC
	 l/DkLq2Dm9J5dYU8Hliz+B/yh/QDRP8pKLoOAC0HMYcipyD/Q2fDu7xJ1t8i3/ITUD
	 v84aPOIO7yLxvTgT5vbkiW2ZgngLHgr6NJnVS/K1FJngVUCad+o99E/qsUvf9ZW0HI
	 tqQvJ9ISc18SpG9Od78orZ19ie5u0WPg5yRwKjXlZweV/1ShAy3lq+Aum2H3ulVnj/
	 x5IuMaVPpGUaA==
Message-ID: <sashiko-outbox-209941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/19] mm/shmem_luo: Leave freeing the preserved
 state to finish()
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
In-Reply-To: <20261111002358.1842967-10-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:15 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/shmem_luo: preserved folios freed before finish() if
  retrieve_folios() fails
--

commit 07031901f696f6bb10658c21e386ae0237da0633
Author: David Matlack <dmatlack@google.com>

mm/shmem_luo: Leave freeing the preserved state to finish()

This commit defers freeing the serialized shmem state from
shmem_luo_retrieve() to shmem_luo_finish() so that preserved folios are not
leaked or freed prematurely when retrieve fails.

> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index e747a04422954..b48d7f460493d 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
> @@ -390,13 +390,10 @@ static void shmem_luo_finish(struct liveupdate_file=
_op_args *args)
>  	struct shmem_luo_ser *ser;
> =20
>  	/*
> -	 * If retrieve was successful, nothing to do. If it failed, retrieve()
> -	 * already cleaned up everything it could. So nothing to do there
> -	 * either. Only need to clean up when retrieve was not called.
> +	 * Preserved folios may be in use until the session is finished, so
> +	 * retrieve() leaves freeing the preserved state to finish(), whether it
> +	 * succeeds or not.
>  	 */
> -	if (args->retrieve_status)
> -		return;
> -
>  	ser =3D phys_to_virt(args->serialized_data);
>  	if (!ser)
>  		return;
> @@ -515,9 +512,34 @@ static int shmem_luo_retrieve_folios(struct file *fi=
le,
>  	return err;
>  }
> =20
> -static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
> +/*
> + * Restore the preserved folios into @file. This consumes them even if i=
t fails,
> + * since they are then either in @file or freed, so make sure finish() d=
oesn't
> + * free them again.
> + */
> +static int shmem_luo_restore_folios(struct file *file,
> +				    struct shmem_luo_ser *ser)
>  {
>  	struct shmem_luo_folio_ser *folios_ser;
> +	u64 nr_folios =3D ser->nr_folios;
> +	int err;
> +
> +	if (!nr_folios)
> +		return 0;
> +
> +	ser->nr_folios =3D 0;
> +
> +	folios_ser =3D kho_restore_vmalloc(&ser->folios);
> +	if (!folios_ser)
> +		return -EINVAL;
> +
> +	err =3D shmem_luo_retrieve_folios(file, folios_ser, nr_folios);
> +	vfree(folios_ser);
> +	return err;
> +}

[ ... ]

> @@ -552,28 +571,15 @@ static int shmem_luo_retrieve(struct liveupdate_fil=
e_op_args *args)
>  	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
>  	i_size_write(file_inode(file), ser->size);
> =20
> -	if (ser->nr_folios) {
> -		folios_ser =3D kho_restore_vmalloc(&ser->folios);
> -		if (!folios_ser) {
> -			err =3D -EINVAL;
> -			goto put_file;
> -		}
> -
> -		err =3D shmem_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
> -		vfree(folios_ser);
> -		if (err)
> -			goto put_file;
> -	}
> +	err =3D shmem_luo_restore_folios(file, ser);
> +	if (err)
> +		goto put_file;
> =20
>  	args->file =3D file;
> -	kho_restore_free(ser);
> -
>  	return 0;
> =20
>  put_file:
>  	fput(file);
> -free_ser:
> -	kho_restore_free(ser);
>  	return err;
>  }

[Severity: Medium]
Does shmem_luo_retrieve() still free all preserved folios before
shmem_luo_finish() if shmem_luo_retrieve_folios() fails?

When shmem_luo_retrieve_folios() fails mid-loop (for example, if
mem_cgroup_charge() fails), its error path restores and puts the remaining
folios, and the jump to put_file in shmem_luo_retrieve() calls fput(file),
which evicts the inode and frees the folios already added to the page cache:

mm/shmem_luo.c:shmem_luo_retrieve_folios() {
	...
unlock_folio:
	folio_unlock(folio);
	folio_put(folio);
put_folios:
	...
	for (long j =3D i + 1; j < nr_folios; j++) {
		...
		folio =3D kho_restore_folio(phys);
		if (folio)
			folio_put(folio);
	}
}

If a preserved device still holds DMA mappings to those folios until the
session finishes, freeing them during retrieve() allows the pages to be
reallocated while still in use.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D9

