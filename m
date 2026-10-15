Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83961CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylk/VLFPtIfSzkzwK71wH+CPYX+E2Ku+EJH0Pl9qaRI=; b=kkWod0Q+zMbPbz4plxxlXFQ0Gk
	C0jgglrixvBgYZPp3I5n16HVLEdwAfvARKWqDnwxeVzFVhlwphfNTSkyAmjdrigtKnbu7Zj1zKWaO
	JYzQU5KGDseLsrkSkTXirp5AjqumFuvXyqbrmaI2/tXwox5cFIwrv63lhU4DkkD3uxRdzNoxc2tU6
	Gy8Gih6+IwgATmnxDXbVb1TSchbzb3IajZcPosoHE4i+66lFQo0D5iZyDf9WWQ09C2/whvhnjMUbu
	sUgKo7mCivdnIVx/+7Bgw/BTtfHztBO319VcW+H575FZM+Y+JBHsCcybs7yoOhvEKYkeHsq7K8cTC
	a9q5ocmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI5P-0000000HKp9-3lrE;
	Thu, 15 Oct 2026 09:49:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI5O-0000000HKo4-2Shz
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:49:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F082860120;
	Thu, 15 Oct 2026 09:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331761F000C4;
	Thu, 15 Oct 2026 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057757;
	bh=ylk/VLFPtIfSzkzwK71wH+CPYX+E2Ku+EJH0Pl9qaRI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SnUqaTtL66eAZsTU7UV80nwGk9Ip7PC2i5Z4WXfLsOeXjr2Cs775eYer9gKnjHwBq
	 8xrjM2AFai+ePgnDRFlwWvt4H33ivdgFtELtSRBxSTHU+NNcXiiOEnqPDqB7FKyaNV
	 umzOs9VVX+ffGdETgrZm/7ZkznR7lsJkJ7nCqUu8u6Jh+NvNRrt01JXsFWo3vVLbFQ
	 e5K+WEIrNoo2wF+ZgK61Cy6HieTxb1fCfoVzsf74U+PcfylRxFe9jxGDuUIwirJhzI
	 qOSBMOli16HIre6HQ/HvqEvQpOwp9mAIh+6M3F3sncEdF16ykLep2PEcn8ixGaC+5e
	 aQbR1ZDM8euXA==
Message-ID: <sashiko-outbox-172598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] liveupdate: Pass user argument to file preserve
 and retrieve
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-4-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:49:16 +0000
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
- [Medium] core: user-triggerable WARN_ON() crash due to xa_insert allocati=
on failure
--

commit 9f9574a189615ae795011fae912d53ecfd69c013
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

liveupdate: Pass user argument to file preserve and retrieve

This commit allows userspace to pass a file-handler-specific argument struc=
ture
when preserving or retrieving an FD via LUO. It extends the preserve and
retrieve structures with a 64-bit arg field, while maintaining compatibility
with older callers. Handlers can now claim files in the preserved files tab=
le
before modifying them.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 3c1c86ff14d69..e3bfdbc6baedc 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -176,6 +177,36 @@ static unsigned long luo_get_id(struct liveupdate_fi=
le_handler *fh,
>  	return fh->ops->get_id ? fh->ops->get_id(file) : (unsigned long)file;
>  }
> =20
> +/**
> + * liveupdate_claim_file - Claim a file in the LUO preserved files table.
> + * @fh:   The file handler claiming @file.
> + * @file: The file to claim.
> + *
> + * File handlers whose .retrieve() callback restores state into an exist=
ing
> + * user-supplied &struct file (rather than allocating a new one) should =
call
> + * this before modifying @file to ensure @file is not already managed by=
 LUO.
> + *
> + * Return: 0 on success, -EBUSY if @file is already managed by LUO, or a
> + *         negative errno on allocation failure.
> + */
> +int liveupdate_claim_file(struct liveupdate_file_handler *fh,
> +			  struct file *file)
> +{
> +	return xa_insert(&luo_preserved_files, luo_get_id(fh, file),
> +			 file, GFP_KERNEL);
> +}

[ ... ]

> @@ -604,9 +687,9 @@ int luo_retrieve_file(struct luo_file_set *file_set, =
u64 token,
>  	/* Get reference so we can keep this file in LUO until finish */
>  	get_file(luo_file->file);
> =20
> -	WARN_ON(xa_insert(&luo_preserved_files,
> -			  luo_get_id(luo_file->fh, luo_file->file),
> -			  luo_file->file, GFP_KERNEL));
> +	if (xa_load(&luo_preserved_files,
> +		    luo_get_id(luo_file->fh, luo_file->file)) !=3D luo_file->file)
> +		WARN_ON(liveupdate_claim_file(luo_file->fh, luo_file->file));

[Severity: Medium]
Is it structurally safe to wrap liveupdate_claim_file() in a WARN_ON() macr=
o?

Because liveupdate_claim_file() uses xa_insert() with GFP_KERNEL, it can
legitimately return -ENOMEM under memory pressure. The WARN_ON() macro will
evaluate this non-zero error code as true and trigger a kernel warning.

Since luo_retrieve_file() is reachable via the LIVEUPDATE_SESSION_RETRIEVE_=
FD
ioctl, an unprivileged user can trigger this allocation under memory pressu=
re.
On systems with panic_on_warn enabled, this could lead to a user-triggerable
system crash.

> =20
>  	*filep =3D luo_file->file;
>  	luo_file->retrieve_status =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D3

