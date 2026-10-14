Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB4CC6B19
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 00:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvEKF9cNZOBTm9yAWIh6GxjcIBCC8+Ng5MvyR5xu1bs=; b=OXB98DYyjrsfFsfT21GcNQoHzD
	ngUtWdB6tAzxVCCwSDRafyZvWOWJwWMBRAJwNMuuxudFHsmDrf4GjlTjAqMaplJ/MRqM+gHrCyNpd
	/JIVphrTK9mrX/Mh6qa+/fFyiGQWr2rEv9vbrOPJQXntXBcKRSsXLrWN93YvdGo33BLEaJYtF2gim
	ie2CMX5jzJkwv8o4vNe1iTzT3MHjv6JbxwqLYDqHycuFC1j0vNY9U+xXI9G8o4D4/Hw9Qy8AP6B6z
	r/52VVH9ngzPHRsiV/dJjfCPB2ng15WYwOM9m1F0tlpwtToA0xINmxDaSBv+Jpnkv9C7u2sslHk68
	+d1i4I0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGnBK-0000000EIou-0RWe;
	Wed, 14 Oct 2026 00:49:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGnBH-0000000EIof-2uVk
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 00:49:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BC6B1600CB;
	Wed, 14 Oct 2026 00:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F3D1F000FF;
	Wed, 14 Oct 2026 00:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938958;
	bh=qvEKF9cNZOBTm9yAWIh6GxjcIBCC8+Ng5MvyR5xu1bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9VrKaTwGYctoMcRpPSIG17ZWOUc4lpcLzmZEEg/MMzNJL0QDe8BFZV+5gl3JPfVX
	 QEbDtNhb6Ch0/ziGyRK1IRZnmR2NYpCYK09aOHdx594Z7nnYSzCWBrDuzuQHAF1D+9
	 pb61axUxAk3KTNVH7cqhlWUOD9MyYn+nYa4jDMhXMoCcAp+HzD3YqpBL1rokOY/1qn
	 prkT1In88ZAiYxwnSWlz2558PPBEd2aIl6+z6mYTgvZdyNmFsRTkUORAGGzPRzI+2u
	 c3SDEvAtShWhkUKHRILPjcczJT2ovCajC7t5/9OMtC+MSrhA3+e482G57ibIoS5EBp
	 Ov8IMy/TM++lw==
Message-ID: <sashiko-outbox-170651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/memfd_luo: carry the exec-bit state in the preserved
 record
To: "Haolong Wang" <18766350203@163.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org
In-Reply-To: <20261014003558.357783-1-18766350203@163.com>
References: <20261014003558.357783-1-18766350203@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 00:49:17 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: TOCTOU race in memfd_luo_preserve loses fchmod and seals updat=
es
- [Medium] mm/memfd_luo: leak of preserved folios in memfd_luo_retrieve() e=
rror paths
--

commit b09cba94dd95aadc45f383b05eb9e6f205bf88e7
Author: Haolong Wang <18766350203@163.com>
Subject: mm/memfd_luo: carry the exec-bit state in the preserved record

This commit preserves the execution bits of a memfd during a KHO live
update. It records the exec-bit state in the memfd_luo_ser structure and
applies it to the fresh inode during restore before re-applying seals,
ensuring the W^X policy behaves correctly.

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -299,6 +299,17 @@ static int memfd_luo_preserve(struct liveupdate_file=
_op_args *args)
>  	ser->size =3D inode_size;
>  	ser->seals =3D seals;
> =20
> +	/*
> +	 * F_SEAL_EXEC freezes the exec bits as they are at sealing time, so
> +	 * the restore has to reproduce them.  Record whether the inode had
> +	 * exec bits here; the restore sets the mode of the fresh inode
> +	 * accordingly before re-applying the seals.  ser is zero-initialized,
> +	 * so a clear bit means the bits were clear (or the record predates
> +	 * this flag -- the safe reading for those is also "no exec bits").
> +	 */
> +	if (inode->i_mode & 0111)
> +		ser->flags |=3D MEMFD_LUO_FL_EXEC_BIT;
> +

[Severity: High]
Can a concurrent userspace modification race with this early caching?

The i_mode is read and cached here, before dropping the inode_lock. Shortly
after, shmem_freeze() is called. However, SHMEM_F_MAPPING_FROZEN ignores
ATTR_MODE in shmem_setattr() and is not checked in memfd_add_seals().

Because memfd_luo_freeze() blindly updates only f_pos without re-evaluating
the mode or seals:

mm/memfd_luo.c:memfd_luo_freeze() {
    ...
    ser->pos =3D args->file->f_pos;
    ...
}

Could userspace modify the mode via fchmod or add seals between the preserve
and freeze phases, causing the restore process to lose those updates and
break security policies like the W^X rule?

[ ... ]

> @@ -542,6 +556,19 @@ static int memfd_luo_retrieve(struct liveupdate_file=
_op_args *args)
>  		goto free_ser;
>  	}
> =20
> +	/*
> +	 * Reproduce the exec bits before the seals are re-applied: F_SEAL_EXEC
> +	 * freezes the bits as they were at sealing time, and the W^X rule in
> +	 * memfd_add_seals() looks at the mode when it decides whether to imply
> +	 * the write seals.  Setting the mode here, directly on the fresh
> +	 * anonymous inode, is safe -- the file has not been published and no
> +	 * other thread can reach it yet.
> +	 */
> +	if (ser->flags & MEMFD_LUO_FL_EXEC_BIT)
> +		file->f_inode->i_mode |=3D 0111;
> +	else
> +		file->f_inode->i_mode &=3D ~0111;
> +
>  	err =3D memfd_add_seals(file, ser->seals);
>  	if (err) {
>  		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
>  		goto put_file;
>  	}

[Severity: Medium]
Do these error paths leak the physical folios tracked by ser->folios?

When jumping to free_ser or put_file on failure, kho_restore_free(ser) is
called, but there is no call to restore the vmalloc metadata via
kho_restore_vmalloc() and free the physical folios.

Looking at memfd_luo_finish(), the driver explicitly expects retrieve() to
clean up its own folios on failure:

mm/memfd_luo.c:memfd_luo_finish() {
    /*
     * If retrieve was successful, nothing to do. If it failed, retrieve()
     * already cleaned up everything it could. So nothing to do there
     * either. Only need to clean up when retrieve was not called.
     */
    if (args->retrieve_status)
        return;
    ...
}

Will failing at memfd_alloc_file() or memfd_add_seals() leave these
KHO-preserved folios permanently reserved in memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014003558.3577=
83-1-18766350203@163.com?part=3D1

