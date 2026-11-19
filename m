Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FC606A336
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=INHESJGP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ss2TgbmD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dmbOu0PRJGj6hDkMcQKATvlyAfgzEvkD2jS5mDLKrcY=; b=INHESJGP7PCqM5799vEU9YS461
	/UUtlVwD46G1pThbf7x0G+xAxDG/NoI8Yph+hy1Sgj4N3NYwxQqQ1vXQ0XRiEJlLbFM+a8H31GBB/
	KZwKkqKn04Yrp+HanhlufAcRQkVxCelOmFPR2woEcuEafIISOGfhfkqr37WsAjShpTJ/ZNCCndemc
	m4j68Y8+b6tkBE8RYeP9hSOKVbh0wzIow3q6V1n+/jptxw+vGmi5qTg4Cx4JoWl4fe3LIvb0W4uXm
	ZkVu5/7bODpQsGq9/J7qSETS33ypE2JCdH2o98C15oPxUdj3luS8p/qAcXj+B5CRXFYqa42g4+D3J
	OHNhcfIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTz3U-0000000BUOv-0bu1;
	Thu, 19 Nov 2026 10:07:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTz3S-0000000BUOc-0swB
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 10:07:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F2E8B474AD;
	Thu, 19 Nov 2026 10:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6671F000CA;
	Thu, 19 Nov 2026 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082865;
	bh=dmbOu0PRJGj6hDkMcQKATvlyAfgzEvkD2jS5mDLKrcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ss2TgbmD5WEN8qdXzo/UNKQh5opIQVJ5FWS+8qFQTbJwDmg/0rN7RT0QLkyMFoc2l
	 UdWqAiCQa5TWBRjyqI0lhTN7LQ8He1BXxqWJ/I52Q2bT9u/3zkXRGCcuwoockySt3j
	 FNxM/l0s1blyqI8zh/DW0PYVw6DPm57/1U3Pv80KaN7joCbLKKdYajrd1lMOnJKTjB
	 cmoyiM9jmZw44AwVWjYQydi7L/8NlEanKvOHbHXrqIfL/eJzOm2JFgbf0YfTYOFANg
	 2Pa24mCd4SKAJH3x18nCpOnVF1BPxHE0ktTU+gCSN8XSqgqHjoT/w8SIa22D5ms4xd
	 J6h14ffPkmdxw==
Message-ID: <sashiko-outbox-222915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] kho: do not expose incoming sub-blob contents in
 debugfs
To: "Long Wei" <longwei27@huawei.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, leitao@debian.org, corbet@lwn.net, rdunlap@infradead.org, kexec@lists.infradead.org, hewenliang4@huawei.com
In-Reply-To: <20261119095937.826980-1-longwei27@huawei.com>
References: <20261119095937.826980-1-longwei27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:07:41 +0000
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
> added kho_restore_free()
>=20
> Fixes: d376e4b55c9a0 ("liveupdate: centralize state management into struc=
t luo_ser")
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Long Wei <longwei27@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119095937.8269=
80-1-longwei27@huawei.com?part=3D1


