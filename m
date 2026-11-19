Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE2606A332
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hlcxcAGe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEvEy+Zx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PdrhZ0ZFsQa7I1snTBf6hYpjeqJIpvbS8rtJD3JX0KU=; b=hlcxcAGeZzlsA+
	pFuluXL0h8slN7U4wfwYuJBibmzI+3Vl1+RaeV1Nc2cACD3w2pK1+8r9G08wO5yMmxMr4fg+lE8Dd
	etaKURs36YzMI2PLQQAVvTE/UJ3dgrzoSIgbKsLvH/qONE1ZPRxoeEVKlwnFvg/1Wxe7p35CLK3CE
	YGs8Z3SG4IDArFyW4V1krgNYQM+MC/yCu3oa5QGUykas6gMGCM/TG2VfjIsb6gtwsVkQBOn3BJr3G
	VGyIqGQeFwPKebEssvBFdvF/mQLw8XygOAsz9Z+78gw6WgInHwsjyGM0dpTKkIJzRXP36eQA/mf8W
	4CNKINcPokfYVmDRHCSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzvu-0000000BekK-2Nqb;
	Thu, 19 Nov 2026 11:04:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzvt-0000000BejW-0thA
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 11:04:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3A6843B37;
	Thu, 19 Nov 2026 11:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF111F000C4;
	Thu, 19 Nov 2026 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086240;
	bh=PdrhZ0ZFsQa7I1snTBf6hYpjeqJIpvbS8rtJD3JX0KU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JEvEy+ZxOHGHpptUbOqQ24Gn0XySdzQDS73WAhlCev/bRpaAyW+iZK0y8E8xcK7qr
	 hi5DDZqqTauBScUapz8LDM3wyXLPATQKb2MvZPneCwVGtmFsLYQmASqGq0Miq49Ttc
	 JEip4CjIuupZ8lK31OLiJeDLd4kSTzctKy3q9+BJptRRO/6vYJXROU8UaJL9nQIqIJ
	 cWyFuC7VDOJJW0tbThUx42h0poMigC2HGiyYPOi4Mh6flax/enQAMoNAjyLkltisQk
	 QOIXdN6Am6b+9bIwL2MIrjUmDG+XAbszHybnQ2dyDWOrKUKe9VnFMk+Zy0pXjo/gQ2
	 pVjFxCulrk7ZA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 4/7] liveupdate: luo_flb: serialize outgoing FLBs
 incrementally
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org, vipinsh@google.com, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-api@vger.kernel.org, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-5-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-5-pasha.tatashin@soleen.com>
Date: Thu, 19 Nov 2026 13:03:49 +0200
Message-Id: <179508622989.425130.18199233960609980187.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Currently, outgoing FLB metadata is written in a single pass by
> luo_flb_serialize() during liveupdate_reboot(). When sessions are
> serialized ahead of reboot, any FLBs their files depend on must also
> be serialized at that time so the outgoing KHO state stays consistent.
> 
> Serialize each file's FLB dependencies from luo_session_serialize_one(),
> appending new FLB entries or incrementing the serialized file count in
> place. Since every serialized session now updates its FLBs as it is
> serialized, drop the separate luo_flb_serialize() pass from
> liveupdate_reboot().
> 
> Because serialized sessions never unpreserve their files, FLB
> serialization is one-way: once an FLB is serialized, its .unpreserve()
> callback will not run and its root handle from .preserve() remains
> fixed for the rest of the boot.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_core.c     |  10 +--
>  kernel/liveupdate/luo_file.c     |  15 +++++
>  kernel/liveupdate/luo_flb.c      | 102 ++++++++++++++++++++-----------
>  kernel/liveupdate/luo_internal.h |   3 +-
>  kernel/liveupdate/luo_session.c  |   2 +
>  5 files changed, 85 insertions(+), 47 deletions(-)
>
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 1b2bda22902d2..9fef5161a1f3d 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -219,18 +219,10 @@ late_initcall(luo_late_startup);
>   */
>  int liveupdate_reboot(void)
>  {
> -	int err;
> -
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	err = luo_session_serialize();
> -	if (err)
> -		return err;
> -
> -	luo_flb_serialize();
> -
> -	return 0;
> +	return luo_session_serialize();
>  }
>  
>  /**
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 988eb313a135f..cdd3c466e5ac3 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -380,6 +380,21 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>  	kho_block_set_destroy(&file_set->block_set);
>  }
>  
> +/**
> + * luo_file_serialize_flbs - Serialize FLBs for all preserved files in a file_set.
> + * @file_set: The file_set being serialized.
> + *
> + * Iterates through all preserved files in @file_set and serializes their
> + * associated FLB metadata into the outgoing KHO FLB array.
> + */
> +void luo_file_serialize_flbs(struct luo_file_set *file_set)
> +{
> +	struct luo_file *luo_file;
> +
> +	list_for_each_entry(luo_file, &file_set->files_list, list)
> +		luo_flb_file_serialize(luo_file->fh);
> +}
> +
>  static int luo_file_freeze_one(struct luo_file_set *file_set,
>  			       struct luo_file *luo_file)
>  {
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index cd715a7c1d992..4ac534171d423 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -34,6 +34,12 @@
>   * This reference-counted approach ensures that shared state is saved exactly
>   * once and restored exactly once, regardless of how many files depend on it,
>   * and that its lifecycle is correctly managed across the kexec transition.
> + *
> + * Serialization: Outgoing FLB metadata is serialized into the KHO FLB array
> + * incrementally as sessions are serialized. Once serialized, the FLB's
> + * .unpreserve() callback is never invoked and its root KHO handle from
> + * .preserve() remains fixed, while later sessions may still update per-FD
> + * state in the shared live object under the FLB handler's own locking.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -72,6 +78,13 @@ static struct luo_flb_global luo_flb_global = {
>  	.list = LIST_HEAD_INIT(luo_flb_global.list),
>  };
>  
> +/*
> + * Serializes updates to luo_flb_global.outgoing.header_ser and .ser[].
> + * Lock hierarchy:
> + *   luo_register_rwlock -> private->outgoing.lock -> luo_flb_ser_lock
> + */
> +static DEFINE_MUTEX(luo_flb_ser_lock);

Why is this needed? luo_flb_file_serialize() is called only from
luo_session_serialize_one() and that runs with sh->rwsem held for write, so
all the writers to the outgoing FLB block set are already serialized.

I'd drop the mutex and add lockdep_assert_held_write() for the outer lock,
or at least mention sh->rwsem in the lock hierarchy comment above.
Currently it lists only the inner part of the hierarchy, which is confusing.

-- 
Sincerely yours,
Mike.


