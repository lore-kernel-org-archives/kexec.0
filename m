Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260EACC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2xM4sOGnuQ/Can5LkbytavW52pzOvPOfwcVmiuN/js=; b=DTxQzJNC1TGxX4f+NJAZoudFcu
	wwTL2UYZ9ZRsSQgztDREHBmh7sld8tPWbBqAXtLsXDZFKqHHUvPOOLYoHaolz7woTF91aj00Jgbhc
	slkgeticMRMS64Te+SZUzWc/kNwABmXt+sFFXhF3BGlz2Tk/I4m2Zg4BW45nCQ649MwWpx6Qnd73W
	5zl7xfICmsze2IPMRIZd8pNdMrSohz7U+QtSDz9qqhEf5TSYecTtz+jphPj5MK2scmpN0HrLZscB3
	VC6o+1VaCHi6Ap9GJkzXoowa0rtIBJWr+dcd6tqGTmW05XDsRqNLvfMT415aS7j8PjSbQLl5181Sg
	n6lUUi9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpdB-0000000EQne-3XEs;
	Wed, 14 Oct 2026 03:26:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpd7-0000000EQn0-3zmS
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:26:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0FC04600CB;
	Wed, 14 Oct 2026 03:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F21F000FF;
	Wed, 14 Oct 2026 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791948372;
	bh=V2xM4sOGnuQ/Can5LkbytavW52pzOvPOfwcVmiuN/js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOxaG/DHdPjU/P+AfbuUJ1djCjUY53Oa6LItMmNrwUoUu5l6xnobDCYDmR5le9epP
	 9d0DkE8KfgJafF0QTZ5a2FliU/NJ832ZeEP/RsYyrIHO95wgYoB4/B8o/vDXnlGjhX
	 yqbsXH9+fEjAu4cUqZHrdTNZAPZq0sos02neLCzUR5HHRKdT4hjsU6k/uODaqS0kNe
	 0VpraG4pTXHy4XMgRanZojsj4hCPeq2cmq+40n8pQ9O1IM0hb+fd3hgreepMsUxjT1
	 njtOScWvHR+ZF78GjtikmI3GbuKIvcgcWkpIjfsfavjQohLlhuBiWzdWrleE5NhW/5
	 z2TX9oMJZYZPw==
Message-ID: <sashiko-outbox-170776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/memfd_luo: carry the sealed exec-bit state in
 the preserved record
To: "Haolong Wang" <18766350203@163.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org
In-Reply-To: <20261014031254.432582-2-18766350203@163.com>
References: <20261014031254.432582-1-18766350203@163.com>
 <20261014031254.432582-2-18766350203@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 03:26:12 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: data race on SHMEM_I(inode)->flags via SysV SHM LUO preserva=
tion
--

commit e3ce8882f8b9c8b13e7c221a9ec8a0c481093c2f
Author: Haolong Wang <18766350203@163.com>

mm/memfd_luo: carry the sealed exec-bit state in the preserved record

This commit extends the memfd live update (LUO) preservation to record
the exact execute permission bits. This ensures that the restored memfd
retains its original execution state and seal protection, rather than
reverting to a default that might invert the W^X guarantee. It also adds
a compatibility layer for older record versions.

> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e729b9b0e38d4..40e1ce87c30e0 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
[ ... ]
> @@ -208,6 +214,20 @@ static inline void shmem_freeze(struct inode *inode,=
 bool freeze)
>  		SHMEM_I(inode)->flags &=3D ~SHMEM_F_MAPPING_FROZEN;
>  }
> =20
> +/* Must be called with inode lock taken exclusive. */
> +static inline void shmem_freeze_seal_state(struct inode *inode, bool fre=
eze)
> +{
> +	if (freeze)
> +		SHMEM_I(inode)->flags |=3D SHMEM_F_SEAL_STATE_FROZEN;
> +	else
> +		SHMEM_I(inode)->flags &=3D ~SHMEM_F_SEAL_STATE_FROZEN;
> +}

[Severity: Medium]
Is it possible for this non-atomic flag update to race with SysV SHM?

The LUO memfd handler's can_preserve check admits files if they are
shmem_file() and have no links. SysV SHM files are internally created
as unlinked shmem files, meaning a user can obtain a file descriptor
for an attached SysV SHM segment via /proc/self/map_files/ and pass it
to the LUO preservation ioctl.

If a SysV SHM file reaches this freeze path, shmem_freeze_seal_state()
modifies SHMEM_I(inode)->flags using non-atomic bitwise operations
under inode_lock. Concurrently, a user can call shmctl(SHM_LOCK) which
modifies the exact same flags field via shmem_lock() while holding only
the ipc_lock_object spinlock.

Could this concurrent read-modify-write cause lost flag updates,
potentially bypassing the LUO seal freeze state or corrupting the SysV
SHM locked state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014031254.4325=
82-1-18766350203@163.com?part=3D1

