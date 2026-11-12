Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C75606A330
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KnoGDeij;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEOCs/+z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xlKJOxJwDcDpLQLhphR53KExe+VBxV3WdYySoxbnvIQ=; b=KnoGDeijw7hCjAlonfGlQIw4Cv
	1fgJb9ZFKsnE1DVz8mzUsljQH86Ss1E9vUvIi29oETx2l8p1dz/uCDd5zgFoE3s+0uiNijXzGYl01
	csmeFhYEDPwOYn2mXIYYiNWNqvbDo721lz0aepxGYUi03SC9iVIbuJbRaUKn2sHnj9yAImhJBURDV
	6m0h0aundqDj0hIq22D/Y7zdD9pYFdMtoS8At3DT+JxlS81/jeeIYk0JiwnMC60231T6nTCd0MwAO
	VShW8UWNhgaesze0KtIxYdZOLHv+GVQNW5IRfgUmjNolYEcoCA+GMfmqJS9vbIjQDcBJriXtHwxNB
	xFsq0OlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIib-00000008F29-3K7h;
	Thu, 12 Nov 2026 00:31:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIia-00000008F1S-2We0
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 271F060052;
	Thu, 12 Nov 2026 00:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC02F1F00A05;
	Thu, 12 Nov 2026 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443466;
	bh=xlKJOxJwDcDpLQLhphR53KExe+VBxV3WdYySoxbnvIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEOCs/+zFVM192K2WMD+q0DOyl/z//SCCLcXpZHm/s42i42mIs4YP1ZYIaZC4/m6U
	 DfO3fvbGCcuOehyg3lfbYjJ6pBeywejxOjQkjW1n1bSJnxeJSY2zOdx8sqODlembuG
	 wsnDSBUd2oWvLC7DIC5uFfDoDk1bs1gDjtm/o0v/SEfeOflti6+a8mDf6lnz/3KEP8
	 9PZMunPdzUuQW0uSJcbMD6Zxp1367PclMF37eEZ/l1W7rKEEXCWmgbAgsY/kL/4nC+
	 anBO2xOl3mcdvnQ8hByZ+Um972jprtoABszUYDazNHMOcU0I4tgBlG6MszAbLk+mIf
	 +MPO6LnJtzILg==
Message-ID: <sashiko-outbox-209934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/19] liveupdate: Pass user argument to file
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
In-Reply-To: <20261111002358.1842967-3-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] liveupdate: pass NULL instead of 0 for arg in
  liveupdate_get_file_incoming()
- [Low] liveupdate: initialize __free(kfree) karg at kmalloc() in
  luo_copy_user_arg()
--

commit ce30d6f92617722b3b0681f0c0fa88542091865b
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

liveupdate: Pass user argument to file preserve and retrieve

This commit extends liveupdate file preservation and retrieval ioctls to
accept a handler-specific user argument structure, validating and copying it
into struct liveupdate_file_op_args for the handler callbacks.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a42b60356d523..1437630d435e6 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
[ ... ]
> @@ -202,11 +203,43 @@ static bool luo_token_is_used(struct luo_file_set *=
file_set, u64 token)
>  	return false;
>  }
> =20
> +static int luo_copy_user_arg(const void __user *uptr, const void **argp,
> +			     const struct liveupdate_arg_spec *spec)
> +{
> +	void *karg __free(kfree) =3D NULL;
> +	u32 user_size;
> +	int err;
> +
> +	if (!uptr)
> +		return 0;
> +	if (!spec->size)
> +		return -EOPNOTSUPP;
> +
> +	if (get_user(user_size, (const u32 __user *)uptr))
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
Could karg be defined and initialized at the kmalloc() call instead of
being initialized to NULL at the top of luo_copy_user_arg(), following the
Cleanup API convention for __free() variables?

[ ... ]

> @@ -995,6 +1052,6 @@ int liveupdate_get_file_incoming(struct liveupdate_s=
ession *s, u64 token,
>  				 struct file **filep)
>  {
>  	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> -				 token, filep);
> +				 token, 0, filep);
>  }
>  EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);

[Severity: Low]
Should this pass NULL instead of 0 for the const void __user *arg
parameter to avoid a Sparse -Wnon-pointer-null warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D2

