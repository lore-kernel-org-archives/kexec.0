Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FFC98304
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZdmhBqOMuKYNscPsuUbYi6tP3G80UEN5EI2cwEtmR8=; b=VUupCersVLWrk6hJLTyl3G84PO
	Es0bEAHyRisNJXW0H1+NkVZ/BP14CvRn0MwDb/8n6nGiVlTLTl36s7SFvEYEGJ2kH+Y5Kp8ii3RGA
	ZcNdaa+uen4b2m/kBS8R5vSSUr4CETOgL53htLZbi4L3KrcKpR3t9p6sgOfwxzmftM56o5FZu2r35
	FhBbmdymiJHKNi135OzTxTzix62OHObunt/CWQZJ8Wcz8w6g0nl2ixOSkecTN79cTFXFxUqXXxjuA
	Cdx4PabqvmjVRbM/gVYlzKyjuTaFYKif27t0+tGSoIZpUiKW8KJf4PEpxUjJ+oHbSHqZ1BLkFI4NJ
	XiYsHpsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9W35-00000009h9v-3mOs;
	Wed, 23 Sep 2026 23:06:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9W34-00000009h9p-1Xj3
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 23:06:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFEC340758;
	Wed, 23 Sep 2026 23:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E847A1F000FF;
	Wed, 23 Sep 2026 23:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204805;
	bh=WZdmhBqOMuKYNscPsuUbYi6tP3G80UEN5EI2cwEtmR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzuHD4GfgdAkX+OUfQZ6s7tIgAQjGqlqG7OhOna8OhvbMDSeHf6VeKfOHVcSh4/tm
	 8XIBmh7+Vx7lTluK+P8eFyYsACVvqdN4LsDY+JRyF+2WvXMocelVF+MBLGwxj3HUmE
	 tKi+7G74HzQEWKKQQ1Duf93OfrGeAiWU9A2MfKgNPir+AR/wFXQ1mwAF00nZpV7674
	 2tELmsn+Tn/7ooLIyS4NPUHqZwOaHCptdW68CGWV1EWC50i6yX7sjcech7zZY4Onpm
	 UfjrFl+wjzhmL5Kh261xy7QdpWy10OiAZ708xw1p9jqE5xAJ4nCdpAu9KWJry3mpRZ
	 tCaljRNJprcWg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] mm/memfd_luo: allow preserving a tmpfs mount
To: "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Hugh Dickins" <hughd@google.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Alexander Graf" <graf@amazon.com>, "David
 Matlack" <dmatlack@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923224408.3745689-5-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-5-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:06:44 +0000
Message-Id: <20260923230644.E847A1F000FF@smtp.kernel.org>
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
- [Medium] mm: tmpfs LUO drops group quotas due to incomplete USRQUOTA check
- [Medium] mm: TOCTOU race allows unsupported ID mappings and quotas to byp=
ass LUO validation
--

commit 20e62ff0b162f0ffc76cd0d972cc6c760a83d003
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm/memfd_luo: allow preserving a tmpfs mount

This commit adds support for preserving a tmpfs mount across a live update.
It preserves the filesystem block limit and root directory mode, while
resetting other options to default, identifying the mount via a file
pointing to it.

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
[ ... ]
> +static bool tmpfs_luo_mnt_can_preserve(struct liveupdate_file_handler *f=
h,
> +				       struct file *file)
> +{
[ ... ]
> +	/* These features are not supported. */
> +	if (SHMEM_SB(sb)->mpol || sb_has_quota_active(sb, USRQUOTA) ||
> +	    sb_has_encoding(sb) || is_idmapped_mnt(mnt))
> +		return false;

[Severity: Medium]
Does this condition improperly accept tmpfs mounts with group or project
quotas active?=20

The check only tests for USRQUOTA, which means mounts with grpquota or=20
prjquota will bypass this rejection and their quota state will be silently
lost across kexec.=20

Should this use sb_any_quota_loaded(sb) to properly detect all quota types?

[ ... ]
> +static int tmpfs_luo_mnt_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct super_block *sb =3D args->file->f_path.mnt->mnt_sb;
> +	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
> +	struct tmpfs_luo_mnt_ser *ser;
> +
> +	/*
> +	 * A remount can install a memory policy after can_preserve() accepted
> +	 * the mount.
> +	 */
> +	if (sbinfo->mpol)
> +		return -EOPNOTSUPP;

[Severity: Medium]
Does this leave a TOCTOU window for ID mappings and quotas?=20

While mpol is re-validated here to handle concurrent remounts, checks for
is_idmapped_mnt() and quotas are missing. If a user concurrently adds an ID
mapping via mount_setattr() or enables quotas via remount after the
tmpfs_luo_mnt_can_preserve() check passes, those unsupported properties will
bypass validation and be silently dropped across kexec.

Should this re-validate the ID mapping and quota state as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D4

