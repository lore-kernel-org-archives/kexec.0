Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BFDCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUau9Qg7XfUkiJSESeezpyWgulEuLaQlN3TvYujPwt4=; b=BkoayZNvw5Q3qWz3roQkD8MHIQ
	218hdRZKz0aUW6wlvM0DTXOA54/i6Iankglqkui2vlGxXaE3Xgu04LrFMoMj5N8haKjq8CKzYMvGN
	YlONNUieTQLIENSNSMISCv0k3nMnvdVDdrkbJ2dXlyFl9UH1Q4LFvjfWvDHbYwGKv9BKL+CTIyXg2
	KS4DBDJ8oXn7lruJ/jSQGmcfz/Nd8Z8kG234v2GfC+WQRaLpVJLgWAutnPSXsSd5frw683X3O70SM
	3LmPMTC1HibS0E0zONikS4oxK83TWOUY9LzutNcXmzBmO2K5EkNWSAuytql3olWcCZByeWXWe7dVi
	p7qgkTGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh44-00000002sX7-3sNE;
	Fri, 16 Oct 2026 12:29:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh43-00000002sWq-42B6
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:29:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF1BB40889;
	Fri, 16 Oct 2026 12:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23561F000C4;
	Fri, 16 Oct 2026 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153775;
	bh=LUau9Qg7XfUkiJSESeezpyWgulEuLaQlN3TvYujPwt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dREFcFgdX7w6TCMlSuEa/4CK4L0poft57TihSYY/2p/sqFH4QGf5Ho0AIw1TgWjTI
	 236bi3HjivEOc/8tTEX0ohZcDzWKnO7y6RLjKzz0+li0D9TakIPNW0aenTlRaoNeG4
	 z4GPm/y+CpFDyRpxrCZLoLWZfxcgzO0gALMGaQpGfE1tcBZqUbB73HrLFXlgjlX31K
	 9yyZyTxGtxYizwRqPgJzQNaD9tgj06Dc2qwXk0+rCxKbvkGhu3h2fxmOfqSQj+AU7Q
	 /rxxdolYRIxkwrJQjtfDmrum1GNBxE0YlOigAYPNmFH/BtmdOApvyUGWK91gi6FewV
	 pNGbw+5VoUFvw==
Message-ID: <sashiko-outbox-174295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
To: "Breno Leitao" <leitao@debian.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, shakeel.butt@linux.dev
Cc: rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
In-Reply-To: <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:29:33 +0000
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

> A kernel that kexecs inherits the frames its predecessor found
> hardware-poisoned. It has to carry them as PG_hwpoison in its own memmap,
> so that everything that already understands the flag covers them,
> including the kexec segment placement check.
>=20
> Add a helper that sets the flag and counts the frame in
> num_poisoned_pages. It runs while the memmap is initialised, before
> memory_dev_init() has run. memblk_nr_poison_inc() divides by
> sections_per_block, which memory_dev_init() sets, so the helper
> increments num_poisoned_pages itself instead of calling
> num_poisoned_pages_inc().
>=20
> An inherited frame is a hardware failure like any other, so the helper
> sets hw_memory_failure. Without it, unpoison_memory() accepts the frame,
> clears the flag and drops the last reference, which frees a frame that
> is still bad.
>=20
> The helper also counts the frame as managed, as a frame that fails at
> run time stays counted. Memory offlining subtracts every frame of the
> block that is not PageOffline, so a frame that was never counted leaves
> the managed page count too low after an offline.
>=20
> The per-node memory failure statistics are not updated. This kernel
> handled no failure, it only inherited one.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D3


