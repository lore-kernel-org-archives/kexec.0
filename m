Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A5C98311
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U9YKFd/Hl7YhdOyAieKBjsie7xEHxxz4e55B/x6uzdo=; b=OHYEKsQY5G/nWSpCSuGd/rTrct
	4mhFQfJb4F+mZHpj+xcq91fyH/qc9U/ppnejb8fpBw/2K1icjAG9nLx8U5WWbrJa31VTQl4zlLgZI
	fPZ3Io48YEDfFGfupMPiYIQ/J0Badei21nA/jSya/6vVS/n5ssvqfPD0ROpX9ydZrYiYYACcnHx11
	PpqtWtF2FHAxiuqXjNYzDRo6zaBtGGpU6PJqyy2Ug+Xz3q2rymK7VdswXs7UiuAkAvLF5EmPqxcon
	Sxj61sBd9Zmih0/k16VdLl/8QzfNJLGS+lq9kqBHLIiuyCeviLJdqXO0J0J4e3qELpW2kqGeFbz8F
	QOdT+qgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9WKh-00000009hiq-2VqH;
	Wed, 23 Sep 2026 23:24:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9WKg-00000009hii-2Zq8
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 23:24:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B6BBE60008;
	Wed, 23 Sep 2026 23:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC0C1F000FF;
	Wed, 23 Sep 2026 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205897;
	bh=U9YKFd/Hl7YhdOyAieKBjsie7xEHxxz4e55B/x6uzdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMIRNr4OLiUixLKnhBolSnExmjDFWiRUOgWv20SvZaXjb2auAnjVO7paMjuqxwVUh
	 gAznIr7cxA8iwbMkmKDqKHfpe1TD8i+ljP6YUolouKAwsl4f7+f1rOlXQVB0XCdwbH
	 zyqskPgnBxQTHf32dDgeBvVOID2t7ytyP4gz5du6Is0yMc5oUiSqdo18GwgRg6AGe4
	 ExTY00SKLiY9HVRr3LlDd7XhgF4nLqikcaON2hjaUoR0iYwBwr+xjA1FfSfDhUATqS
	 W/bTglH0wjmNowS+kVve+Q8JaSPv3Vhw8YXbWFuO3I97nSsjIRd8+ETJemkQbLwLdK
	 92jaAVSIpl77A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] mm/memfd_luo: allow preserving a tmpfs file
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Hugh Dickins" <hughd@google.com>, "David
 Hildenbrand" <david@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander
 Graf" <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260923224408.3745689-6-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-6-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:24:56 +0000
Message-Id: <20260923232456.BCC0C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mm: restored file permission bits are corrupted by current_umask()
- [High] mm: TOCTOU race allows unprivileged userspace to disrupt tmpfs fil=
e retrieve
- [High] mm: memory leak of KHO folios on tmpfs_luo_file_retrieve failure
- [Medium] mm: potential double free / UAF of ser and folios on successful =
retrieve
--

commit 4087da995ba7fe7684120abaf9ec59deb366b97b
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm/memfd_luo: allow preserving a tmpfs file

This commit introduces tmpfs file preservation across kexec live updates.
It preserves regular files within a tmpfs mount by serializing their
properties and memory folios, and restores them when the mount is
retrieved.

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -1005,62 +1005,51 @@ static int tmpfs_luo_file_retrieve(struct liveupd=
ate_file_op_args *args)
[ ... ]
> 	err =3D liveupdate_get_file_incoming(args->session, ser->mnt_token,
> 					   &mnt_file);
> 	if (err) {
> 		pr_err("failed to retrieve tmpfs mount: %pe\n", ERR_PTR(err));
> 		goto free_ser;
> 	}

[Severity: High]
If this path jumps to the free_ser error label, does it permanently leak
the physical memory reserved for the KHO folios?

The free_ser error label frees the ser metadata, but does not discard
the physical folios or the ser->folios vmalloc region. Because the function
returns an error, tmpfs_luo_file_finish() may skip its cleanup logic if
args->retrieve_status is set to a non-zero error code. This would permanent=
ly
leak the memory of all files preserved inside that mount.

[ ... ]
> 	/*
> 	 * TODO: This is racy. This will link the file in the mount so after
> 	 * this call userspace can already open the file and write to it.
> 	 * Ideally we should first create the inode and set it up, and only
> 	 * then link it to the root.
> 	 */
> 	file =3D file_open_root(&mnt_file->f_path, ser->name,
> 			      O_RDWR | O_CREAT | O_EXCL | O_LARGEFILE,
> 			      ser->mode);

[Severity: High]
Does this code inadvertently strip the file permissions via the
orchestrator's umask?

VFS creation functions like file_open_root(O_CREAT) will apply
~current_umask() to the newly created file, which could alter the
preserved ser->mode. Since the kernel code lacks a subsequent chmod()
or vfs_setattr() step to enforce the exact preserved mode, the restored
file might have incorrect permission bits.

[Severity: High]
Does linking the file into the namespace here open a TOCTOU race window?

Since file_open_root() immediately links the restored file into the tmpfs
namespace, unprivileged userspace could potentially open and write or mmap
the file before memfd_luo_retrieve_folios() is called. This would instantia=
te
page cache folios, causing the subsequent shmem_add_to_page_cache() inside
memfd_luo_retrieve_folios() to hit an -EEXIST collision and permanently drop
the preserved data folios.

[ ... ]
> 	args->file =3D file;
> 	kho_restore_free(ser);
>=20
> 	return 0;

[Severity: Medium]
Could this lead to a double-free or use-after-free regression of the KHO
folios on a successful retrieve?

This code frees the ser object but leaves args->serialized_data as a
dangling pointer.

[ ... ]
> static void tmpfs_luo_file_finish(struct liveupdate_file_op_args *args)
> {
> 	struct memfd_luo_folio_ser *folios_ser;
> 	struct tmpfs_luo_file_ser *ser;
>=20
> 	/*
> 	 * A successful retrieve() already consumed the preserved memory, and a
> 	 * failed one cleaned up what it could. Only a file that was never
> 	 * retrieved is left to discard here.
> 	 */
> 	if (args->retrieve_status || !args->serialized_data)
> 		return;

[Severity: Medium]
If the LUO core framework sets args->retrieve_status to 0 upon a successful
return, tmpfs_luo_file_finish() might bypass this early return, dereference
the dangling args->serialized_data pointer, and mistakenly double-free the
folios. Could args->serialized_data be explicitly cleared after it is freed
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D5

