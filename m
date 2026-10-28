Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE291606A31C
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fuMmJ7cL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5ntfLO+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l0bSSM8FhTsNedWNt7lXmwJDLMiA0gbyOLiaRiVri7c=; b=fuMmJ7cLXn3g+iZNqs0epPMhBS
	hZKO773VEqtayFyperwRrco8EWgRMp5FKkYrMst8oEqtA8jqVdaueHxsaNHoKecOmFN8W8skIY9F5
	IR200aDDzp+iETCZq5WqQcS9QZLkulHbmGgXwjMAbee6k8g6bUOBAHkGpFXEdbeifYWFFVtSaraQH
	0wYINscu2ZjksVnkoAakWJKpe4c+col9zE7R7ZIw2EKTMmsW2IlYND4aIikPPuxLWNZ5MS8cTs5gR
	UcAg7hp/1ZNADF26s6NZfyk/Oe+PirZ7F+pItLH4Xa+JmtGO0lF8K6er/qALhTTZvZRHUcKMQV6ej
	/Ncs97Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Us-00000007fSY-2Xue;
	Wed, 28 Oct 2026 17:31:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Uj-00000007fMB-0wqy
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 17:31:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 070886021A;
	Wed, 28 Oct 2026 17:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3BC1F01825;
	Wed, 28 Oct 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208683;
	bh=l0bSSM8FhTsNedWNt7lXmwJDLMiA0gbyOLiaRiVri7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5ntfLO+h3Xj2oPj7TrcoswjoJMjKmwQR8qmTWwKE/f+5raVyVU5WoPEEi2/PUsV/
	 zCbqYib2iWN632LJp93qP5rFhqH5e8+o1wZtrqCtSf9MJGF1OKcLknwjxI6FLQvaXV
	 mKGQgoRVHmXk62ipiTJM2VT85lolGRQfrpWuQ57VfYQuc0mm2nY8AcU5GtSBrJvHtS
	 UBR0zq9ITIDa25Gs1JFwBQ9a0xLvuW5UmJY/wh5Iee5EZD8Jt09OkFOau03h06+vgH
	 jkyRmBrfcifU6X27nxszoOEIjfbYcAPW107pW+K4cZKlUrgZVAx0lX171l4yw2f1q5
	 Fgp3d0tBjRIZw==
Message-ID: <sashiko-outbox-188237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm: shmem: use mapping_set_frozen() for memfd
 preservation
To: "Pratyush Yadav" <pratyush@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, =?utf-8?b?TWF0?=
 =?utf-8?b?dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Zi
 Yan" <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Kairui Song" <kasong@tencent.com>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20261027173031.763213-4-pratyush@kernel.org>
References: <20261027173031.763213-1-pratyush@kernel.org>
 <20261027173031.763213-4-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 17:31:21 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: shmem: broken mapping_frozen() check ordering in shmem_setattr=
()
- [High] mm: shmem: shmem_write_begin() allows extending i_size on frozen m=
appings
--

commit f05d5b8fc61839cbb16ea914eab638cf83da5354
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm: shmem: use mapping_set_frozen() for memfd preservation

This commit replaces the shmem-specific SHMEM_F_MAPPING_FROZEN flag with
generic page cache mapping_set_frozen() and mapping_frozen() helpers for
memfd live update preservation. It also updates shmem_setattr(),
shmem_write_begin(), and shmem_fallocate() to rely on the frozen mapping
state.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6507b4246c8af..1c70fd306bec2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1570,8 +1570,6 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  			return -EPERM;
> =20
>  		if (newsize !=3D oldsize) {
> -			if (info->flags & SHMEM_F_MAPPING_FROZEN)
> -				return -EPERM;
>  			error =3D shmem_reacct_size(SHMEM_I(inode)->flags,
>  					oldsize, newsize);
>  			if (error)
> @@ -1583,6 +1581,11 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  		}
>  		if (newsize <=3D oldsize) {
>  			loff_t holebegin =3D round_up(newsize, PAGE_SIZE);
> +
> +			/* No truncation allowed on a frozen mapping. */
> +			if (mapping_frozen(inode->i_mapping))
> +				return -EBUSY;

[Severity: High]
Does moving the frozen check after the newsize !=3D oldsize block corrupt
inode->i_size and VM memory accounting on shrink, while allowing a frozen
memfd to grow via truncate()?

In mm/shmem.c:shmem_setattr(), when attr->ia_valid & ATTR_SIZE is set:

	if (newsize !=3D oldsize) {
		error =3D shmem_reacct_size(SHMEM_I(inode)->flags,
				oldsize, newsize);
		if (error)
			return error;
		i_size_write(inode, newsize);
		update_mtime =3D true;
	}

When shrinking a frozen file (newsize < oldsize), shmem_reacct_size()
unaccounts VM_ACCT(oldsize) - VM_ACCT(newsize) via vm_unacct_memory() and
i_size_write() updates inode->i_size before the newsize <=3D oldsize block
checks mapping_frozen(inode->i_mapping) and returns -EBUSY without rolling
back either change or truncating the pages past the new EOF.

When growing a frozen file (newsize > oldsize), the newsize <=3D oldsize
branch is not taken at all, so mapping_frozen() is never checked and
inode->i_size increases even though memfd_luo_preserve() already recorded
ser->size and memfd_luo_freeze() only updates ser->pos.

Should mapping_frozen(inode->i_mapping) be checked before the
newsize !=3D oldsize block so all ATTR_SIZE changes on frozen mappings are
rejected before modifying state?

> @@ -3482,10 +3485,6 @@ shmem_write_begin(const struct kiocb *iocb, struct=
 address_space *mapping,
>  			return -EPERM;
>  	}
> =20
> -	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
> -		     pos + len > inode->i_size))
> -		return -EPERM;
> -
>  	ret =3D shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
>  	if (ret)
>  		return ret;

[Severity: High]
Can removing this check allow buffered writes to extend inode->i_size on a
frozen mapping when a folio is already resident at index?

If a preserved memfd has an unaligned i_size, a large folio spanning past
i_size, or folios preallocated beyond i_size with FALLOC_FL_KEEP_SIZE,
shmem_get_folio() finds the existing folio in i_pages without allocating and
inserting a new folio, so the frozen mapping check in page cache insertion
is not triggered.

Then mm/shmem.c:shmem_write_end() extends inode->i_size:

	if (pos + copied > inode->i_size)
		i_size_write(inode, pos + copied);

Because mm/memfd_luo.c:memfd_luo_preserve() captures ser->size during
preservation and memfd_luo_freeze() only updates ser->pos, any size extensi=
on
and data written past the preserved size will be lost across kexec.

Should shmem_write_begin() still reject writes with pos + len > inode->i_si=
ze
when mapping_frozen(mapping) is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173031.7632=
13-1-pratyush@kernel.org?part=3D3

