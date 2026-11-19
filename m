Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322E606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DX3H9uGZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZpHTK+e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ecWj/XOU9U6zcn/RbRd/sfTmPGwO5ifXqtEWuZ6vaAc=; b=DX3H9uGZQw/8vqKO/1/yN0OuC9
	71lgkoFLNdWC8zRTFfa5K5+bETadjAAFjocpBKITkOiHllLKIkFC5igVffRTDkxtFLH1S6jnGcQZJ
	SDFXuOGDwgbmmtyL/gd/O06qriPwoyqg3ovt6c2a/apCizKmarVVitW2gqbOJ8O4Egg+FGiIYif+Y
	8//FDNFLkS8V3LDi9veLh8aj98mZUcSbHghkbyoU08RB21HMHVVWYOLkFxtt7T7RFtYhWKwN3Tp7y
	/31tPuntSGsIPjwO3jXM7+hRQFiRhpLO0P1sbNvXm09JJ8HE9By7VJpPLL9ynRMdzxaCNpwAQYAjp
	mHEHaLSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvws-0000000B1PO-0lJY;
	Thu, 19 Nov 2026 06:48:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvwr-0000000B1PB-00a4
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:48:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35E31611AA;
	Thu, 19 Nov 2026 06:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6283A1F000C4;
	Thu, 19 Nov 2026 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795070923;
	bh=ecWj/XOU9U6zcn/RbRd/sfTmPGwO5ifXqtEWuZ6vaAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZpHTK+eHUuep4RVdCsCqIa8v2/XeC73jWjEs3v3bwwksM2I7j9WQwByQb6qqaqPw
	 dTde3lNg5spGa0QKPBK8pnQiQTjXwy6e876VX1LLDftn1wk7thNlzrtIyRpbUo+yJO
	 Rz0vLfEQ0/sYjI1h7Fzl7Ft3QfkD/1AO7aurursUNKWpRoLhn3XeoHYd3XvPxtguwB
	 83AFnPBCnIwajEuF0mh2TFt9jiP2dh1kHxTFau1yV6fCnq1Lb1QSXXu5LryBaK76YN
	 6ArJwVTjkLL6LfbYYCf8wSrcf/wxnkmTPGLhZT9A2DQLcpUn74fTEuIp247ZvxDpXX
	 AMzZxwNK0yV7A==
Message-ID: <sashiko-outbox-222528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] kho: do not expose incoming sub-blob contents in
 debugfs
To: "Long Wei" <longwei27@huawei.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, leitao@debian.org, corbet@lwn.net, rdunlap@infradead.org, kexec@lists.infradead.org, hewenliang4@huawei.com
In-Reply-To: <20261119063800.698863-2-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
 <20261119063800.698863-2-longwei27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:48:42 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Incoming sub-blob pages are owned by their consumers and have independent
> lifetimes.  Some consumers, such as LUO, restore and free their state in
> early_initcall, i.e. before kho_init() (fs_initcall) builds the debugfs
> view:
>=20
>   early_initcall: luo_early_startup()
>                     -> kho_retrieve_subtree("LUO")
>                     -> kho_restore_free(luo_ser)   /* page is freed */
>=20
>   fs_initcall:    kho_init()
>                     -> kho_in_debugfs_init()
>                          -> phys_to_virt(luo_ser_phys)
>                          -> debugfs_create_blob("LUO", ...)
>=20
> debugfs therefore ends up pointing at a page that was already handed back
> [ ... ]
> all.  Drop the in/sub_fdts directory.  The incoming FDT is reserved by KHO
> and remains exposed as in/fdt, where the same metadata is available.
>=20
> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> Signed-off-by: Long Wei <longwei27@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119063800.6988=
63-1-longwei27@huawei.com?part=3D1


