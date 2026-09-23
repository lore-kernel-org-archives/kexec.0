Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD524C9830D
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAVq8riAYpkFQqE3vtYLztepdMXLNV8rYLOj0yWRQXo=; b=DGuDhL9hmAZ3BoRF+MHJiVLuCQ
	TmTbyH+vaU6VyAuv6j2hV74fO75tyUaH2pi9Gh8jtchGQdGLIctWavX1sRGrZ4DsUqfIDbvbTPUAc
	VlvOBzMqIuHH3uweS6TU390DC4RnPZ9VPhJDFKZCGpOKLC6gGWx4TJivjE82nb2+8GXGx3qn8KCjQ
	0cn2pTwnY6HCc+f5F+on64k9nNSqvJbzOZZ6Iep9i9a1Hgm7gmL/v9b886AQeh6GrNnj2bU9D3I2f
	HoFwjw5xsf+7dIs0OskKV9JnBRucDR4M4a1Mkq2p2PXBOFrlmqowcEekBYNTofgT8KnIayBzW3rLQ
	47FNVcBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VyO-00000009gtG-0q7e;
	Wed, 23 Sep 2026 23:01:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VyM-00000009gtA-1uRX
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 23:01:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8672060008;
	Wed, 23 Sep 2026 23:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8160E1F000FF;
	Wed, 23 Sep 2026 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204513;
	bh=mAVq8riAYpkFQqE3vtYLztepdMXLNV8rYLOj0yWRQXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLUEIV05TiKc0C/byycgiDauYslTGWVbc+nJ1MUD9VUnqU25rGdqejVNIqBf3pKFJ
	 5vpamPJuuFs302pY7sKIbWnzJH32VnHKvul5fJk3jKvVr7Tc+RFWXj9/iGc6IbDVjl
	 jCkFhVX+S5jF61sHSBBZOd0TuT3bqST8wCP0BMs9ud2VQgDsc4+ALG3BZb2tvRbwc8
	 rD9T9C5cZmKTsNXBA80mNGwvnvY3UmL55JJqvuEJmNzO1rvzvBkuoryvD8WVHSieJo
	 2LInadbEVFU7SMGahlhm0imyS859rWt1Y/OvYWDYXJH3pd+0RiHs+LPs5X/QFonpeZ
	 Ws1Um62uUwtBg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] fs/namespace: Add vfs_open_detached_mount()
To: "Andrew Morton" <akpm@linux-foundation.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Mike Rapoport" <rppt@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Hugh Dickins" <hughd@google.com>, "David
 Matlack" <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923224408.3745689-4-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-4-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:01:52 +0000
Message-Id: <20260923230152.8160E1F000FF@smtp.kernel.org>
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
- [Medium] fs: mount reference leak in vfs_open_detached_mount() error path
--

commit 7bbd41a97d183f30490f0856f394037fd1846a6f
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

fs/namespace: Add vfs_open_detached_mount()

This commit factors out the creation of an anonymous mount namespace and an
O_PATH file for a detached mount into a new helper, vfs_open_detached_mount.
This allows in-kernel mount creators to hand a detached mount file to
userspace, similar to what fsmount does.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1ecd96c918b33..5e7ba2b61dd9a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> +/**
> + * vfs_open_detached_mount - Publish a new mount as a detached mount fil=
e.
> + * @mnt: The mount to publish. Must not be attached to a mount namespace=
. The
> + *       caller's reference is consumed on success.
[ ... ]
> + * Return: the new file, or an ERR_PTR. On failure the caller's referenc=
e to
> + *         @mnt is dropped, as the mount cannot be published.
> + */
> +struct file *vfs_open_detached_mount(struct vfsmount *mnt)
> +{
> +	struct path path __free(path_put) =3D {};
> +	struct mnt_namespace *ns;
> +	struct file *file;
> +
> +	if (WARN_ON_ONCE(real_mount(mnt)->mnt_ns))
> +		return ERR_PTR(-EINVAL);

[Severity: Medium]
Does this error path leak the vfsmount reference?

The function documentation explicitly guarantees that on failure, the
caller's reference to mnt is dropped. If a caller inadvertently passes a
mount already attached to a mount namespace, this WARN_ON_ONCE condition
evaluates to true and the function returns an error without dropping the
reference.

For comparison, the error path immediately below for alloc_mnt_ns
failure correctly calls mntput(mnt) before returning.

> +
> +	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> +	if (IS_ERR(ns)) {
> +		mntput(mnt);
> +		return ERR_CAST(ns);
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D3

