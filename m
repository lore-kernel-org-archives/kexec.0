Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F452C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ordUloR4tkzjSO9c8EIpA4VajsXZhXheq1XH0wJbAg8=; b=042pdejlHRcDNWpx/gCOFYC045
	PgFm4azvuW4cJLmpx9BJtlqLqvZMaAoF+THm/Qp/ApiO1YTZEHB5cSG2ocODqbbbU2jlKcWFdvHXR
	qgw/GjUwFd4SZXrlKUZlfuyCIHK7zEgYIqkXFcbtlvPZbhn2Xr6zsYkO25kBW9/BhPZdE/CMNXHYu
	xlmn2j6hUAU+WiI4rUD8WVDNelmipmm1C4fquBYoqssbdAG/IclOa5ARo+ZhI8c5huOpTO+8XRfo/
	ETFvU4km21jgORKcVtGbOhr1Igr0inESe1CWQASsemByl5ModaYb9ep+fHynJRTxBwV10AIIHdMP6
	cUtDdK8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sr2-00000006ec4-2cdH;
	Tue, 15 Sep 2026 13:05:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sr0-00000006ebo-2rxH
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:05:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4955A42D96;
	Tue, 15 Sep 2026 13:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C919E1F000FF;
	Tue, 15 Sep 2026 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477542;
	bh=ordUloR4tkzjSO9c8EIpA4VajsXZhXheq1XH0wJbAg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AaWwXhlqxLtAa5qlsWLkRg/bwK7yuKnIL0MYjZ90S+6rgQdy2v7lDv6HG6lkhZtYY
	 23zmI+aO1DaJfwR21QNJYZjFaow5wDJ2UDYtmR+AB7oWsO+95ZAfx5htQPznuHY1Br
	 +8gWOaVLSq3ydNSGBSGAM4yCUoQynNoap33dmuxf97RTtGGFTRGMHtsBgX9xLyDC+n
	 1w02AyhfbIKLqA5b3fN0dTiDi6z7pCjNmRiX8xTSK86Al8POq9LjCHnnF98mSL0jLr
	 8q8VIkJ0yl7nt3TuB7KsNJMkaLxaV94rNmYWVvFE+QcKKO5ZDiZ7hvmzNgS2eBKrGi
	 RvLz2STvXrYeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
To: "Danilo Krummrich" <dakr@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Borislav Petkov" <bp@alien8.de>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Oscar Salvador" <osalvador@suse.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Breno
 Leitao" <leitao@debian.org>, kas@kernel.org, "Liam R. Howlett" <liam@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, x86@kernel.org, "Zi Yan" <ziy@nvidia.com>, "Suren
 Baghdasaryan" <surenb@google.com>, "H. Peter Anvin" <hpa@zytor.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.or, shakeel.butt@linux.dev, "Miaohe
 Lin" <linmiaohe@huawei.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com, riel@surriel.com, linux-cxl@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, harry@kernel.org, kexec@lists.infradead.org, linux-efi@vger.kernel.org
In-Reply-To: <20260915-hwpoison-kho-v5-2-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-2-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:05:40 +0000
Message-Id: <20260915130540.C919E1F000FF@smtp.kernel.org>
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

> Hardware-poisoned page frames are tracked only in the running kernel's
> data structures, so a kexec loses them and the next kernel doesn't have
> this information, thus, tripping into them again.
>=20
> Add an EFI configuration table to carry that information across kexec.
>=20
> It is a bitmap with one bit per EFI_POISON_UNIT_SIZE (2MiB) of physical
> memory starting at phys_base, modeled on the LINUX_EFI_UNACCEPTED_MEMORY
> table, and it rides the EFI system table to every kernel in the chain.
> Basing the bitmap keeps a machine whose RAM starts high from paying for
> the hole below it.
>=20
> List the table in the x86 efi_tables[] too, so an SME host maps it
> unencrypted like every other EFI table.
>=20
> [ ... ]
>=20
> This is a similar approach as used as unaccepted memory.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D2


