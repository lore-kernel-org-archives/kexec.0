Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40337606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mnjX/c8e;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3kwdHRL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=05kUs/NRp2VSsMxOprgec11bQQFPGMRlOicKgyHo5Kc=; b=mnjX/c8exQ6yASZlsPwCx27nwf
	fYEEJ+Vt7tDANJAeIM8nqGS40j1nacSHpZxr3RgretpX/wZF42/ydQR5Yu9Yh4emPiHeLyMpwMzC1
	ocwwdHhDn0GWYCvRm9nyBhq/2mzXVdSaA//4ge7aEtJOAl5PaFXiJyHjCMJ9h5e7UOd9SPb3hAtLU
	iGxMXUlQuCC6Pk4BrPDyVK7cqcZHVx9S8nhmXd1ytAlK8nDEecSpLLUBeafy4XGxMpUxlMJS92PX6
	/3TDzIZuNOK63Nbg9U5kpb4hBGE69nH6BX/oe2MymvZ5fIgiUOsJN2cXU5d29shBFVatioXUWhktl
	KBk2haBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPR-000000042Iw-1ucQ;
	Wed, 04 Nov 2026 01:03:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPQ-000000042Im-2QXY
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 71C9D60AAB;
	Wed,  4 Nov 2026 01:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B431F00919;
	Wed,  4 Nov 2026 01:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754203;
	bh=05kUs/NRp2VSsMxOprgec11bQQFPGMRlOicKgyHo5Kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3kwdHRLpV+iEc/E03asMe5aCNmofN4Hr5/IYx4FDhf1UsEPNPbihEcO1SsSF+CmW
	 1Bllf95+Wqlvx2UYRDu78CHv5ueV23ZudAww68y8u1udfRv/kaly8l5WGbFselmUNw
	 E8CKZbkmETEiLwlkMQJg5khkt7gepvBzJptVIetGhoil7dTEv6FeB4GwurKZI0yXEx
	 uAUDKSm4mfw2KK8p/4gqjRZZsLOkNQchg4K23fbS03J5Xx7QrZ1hnlyPG28gxaZkQx
	 /CZiMxPlzlItgyeBHzLVslGfEyZeFewgvbpIoHPSZzZPCCRUyNoPLgKSGBED1Kp8Yk
	 4VfmeRLRxio1w==
Message-ID: <sashiko-outbox-196332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] liveupdate: Pass user argument to file
 preserve and retrieve
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
In-Reply-To: <20261103010216.3447716-2-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:21 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] liveupdate: karg __free(kfree) declared as NULL at top of luo_copy_=
user_arg()
--

commit c4f18d427b088994ba26ccc665552744e8d63e5a
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

liveupdate: Pass user argument to file preserve and retrieve

This commit extends LIVEUPDATE_SESSION_PRESERVE_FD and
LIVEUPDATE_SESSION_RETRIEVE_FD with an optional user-space argument pointer,
allowing file handlers to specify and receive handler-specific argument
structures during file preservation and retrieval.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a39992da504fb..eeeb3b5ff2faa 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
[ ... ]
> @@ -202,11 +203,45 @@ static bool luo_token_is_used(struct luo_file_set *=
file_set, u64 token)
>  	return false;
>  }
> =20
> +static int luo_copy_user_arg(u64 user_arg, const void **argp,
> +			     const struct liveupdate_arg_spec *spec)
> +{
> +	void *karg __free(kfree) =3D NULL;
> +	void __user *uptr;
> +	u32 user_size;
> +	int err;
> +
> +	if (!user_arg)
> +		return 0;
> +	if (!spec->size)
> +		return -EOPNOTSUPP;
> +
> +	uptr =3D u64_to_user_ptr(user_arg);
> +	if (get_user(user_size, (u32 __user *)uptr))
> +		return -EFAULT;
> +	if (user_size < spec->min_size)
> +		return -EINVAL;
> +	if (user_size > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	karg =3D kmalloc(spec->size, GFP_KERNEL);
> +	if (!karg)
> +		return -ENOMEM;

[Severity: Low]
This isn't a bug, but in luo_copy_user_arg(), karg is declared with
__free(kfree) =3D NULL at the top of the function and assigned later after =
the
early validation checks.

Per the Cleanup API conventions in include/linux/cleanup.h, could karg be
defined and initialized in a single statement at the allocation site instea=
d:

	void *karg __free(kfree) =3D kmalloc(spec->size, GFP_KERNEL);
	if (!karg)
		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D1

