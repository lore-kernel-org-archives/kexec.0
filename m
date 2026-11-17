Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E246606A32A
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4gv4V9VI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W47z3MsZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xc7Ird9sB7nxRnEk213qO5v/+WyIWKPksQW4TTEd2dA=; b=4gv4V9VIbh59ruacoIeoNmeekR
	qSWfYB9Jo5SmdYZx/vMikonE1D/g9Okty2dFLoico6eLWr+aCkPoUUf75tJkmTXPWuKJx0WrKMWk4
	fAkBGKKfpo287Ae7t8yQ1RjLAdgtckVveFQzgo9HhamOs7dqD3sBwxp/TqUSZPu73PS+zBIvC+/la
	qm1s5aBqIWJC2004sPwdH8YWVybk2sJdX8lKWJOAZaEfteOSwiFELzf5cStW810jwBiHhkEJjpBPu
	69LMEiXwqx7dEhbwpwlt3uXT4Coj1f0eXqlaU/hOjLcJ1nhvX9+tVEXhXB4VrUdDMbfECjfCRa0sK
	ZbvFMSEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFiJ-000000058c0-3KYB;
	Tue, 17 Nov 2026 09:42:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFiI-000000058bg-1f3q
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 09:42:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8944763367;
	Tue, 17 Nov 2026 09:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68031F000C4;
	Tue, 17 Nov 2026 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908573;
	bh=xc7Ird9sB7nxRnEk213qO5v/+WyIWKPksQW4TTEd2dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W47z3MsZPQkNLSyTP2dsHFmasldR0eKzGVkj3BabnbinonKAcN4IlvTATjd0FelQN
	 FyGml/RymWm5LJTpN29ZLrQhLMRbgneZttrE8xcQs9J6xWvndLWpkIL5BYtrGiO7fC
	 LWxxvAG/GC7RCmjgFWBOFz4Ii+I8AITU1vmdHWpoDeV0WBnEHScWCFHughBr6ecMWn
	 UMpNkyEiBICmC2BqwQWStDWyZMT6BZ4njsjFMG+W/jrYbGuZTNnvv5oB2W3ESYy1ve
	 OjwrC77Mo/J8YyaJa38PkQzSQMjYXNN49PJMFqpoZl9aTk48CQ9//zbonFSU76OLst
	 vyENBz6UrvSog==
Message-ID: <sashiko-outbox-218513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] kho: expose incoming sub-blob metadata instead of
 contents
To: "Long Wei" <longwei27@huawei.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, leitao@debian.org, corbet@lwn.net, rdunlap@infradead.org, kexec@lists.infradead.org, hewenliang4@huawei.com
In-Reply-To: <20261117092951.4017931-2-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261117092951.4017931-2-longwei27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:42:52 +0000
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
> size of every incoming sub-blob.  The FDT itself is reserved by KHO and is
> still exposed as in/fdt.
>=20
> Fixes: 062dd306d99c ("kho: fix kho_in_debugfs_init() to handle non-FDT bl=
obs")
> Signed-off-by: Long Wei <longwei27@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117092951.4017=
931-1-longwei27@huawei.com?part=3D1


