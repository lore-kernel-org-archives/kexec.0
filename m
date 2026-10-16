Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA9ECCA46C
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdtpyvUokzgfre+4lMtC5g6BRNdEv/1QUmblZUTSKrA=; b=tML20SkZYjuiSIAnPuEdlyWLb6
	xIGHtk/SctLw6+dfmzaVEvJiXpodDYjlhRTH3tA7uPNaaRpvTQZPqt5ksbkwEhJcaamuMRSvCIEbw
	iBF+AkGBSc2DM++NV8hxQcHd7Dj2G2MDf+bUrKJ3TWEhd6zLtXtVeTG8BYpSEjGDLW0WBa10+Wouk
	xTqZxTRI54rrEStI5S9oOowAdOi4E+nR/eMvI7wLa87xsEf2O/z+NSI8Axhmd3B+0U+olpMTC+Urh
	6kUL1i7/WEM4Hr4QWHydpZIjA7HqzG3/7SM20qJJRMmc8gwHsQBgj73pOf8MQ7IdPuHNawRNUI4Em
	nBCli0cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh3T-00000002sJM-3MLo;
	Fri, 16 Oct 2026 12:28:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh3S-00000002sIx-2Xca
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:28:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AA02860018;
	Fri, 16 Oct 2026 12:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2234C1F000C4;
	Fri, 16 Oct 2026 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153737;
	bh=sdtpyvUokzgfre+4lMtC5g6BRNdEv/1QUmblZUTSKrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7lqUXScK1xLJ2d5DFhiTe13aicVO1ebbaUedBw/6h56rkXnwcIh/UJb0xizzVv9V
	 Kp8s+rD0orq2y9BWx1Um+cw4WwqM+dT6Nli+QLUHKRf1BLrAbui2v2C1hB1+KWCvqn
	 tGRKpD2o2aWjhGnGP2DeCuO6pFa+WDKnciZtz3HKgjjgnzl9iQpniChNASsoopXMpR
	 uBtxnlmRr12QEWs4doncHjbp5uSkOKzOgilDUAW1GhEwtl4BwwXGsg32KokcJk6qGs
	 PDN+rm13vwMupltSTtaRdkPdEBd6jjUADHFezCC8/yJhFFiJbQgXN75iD/Zb5+tcwN
	 vzk/KJfPJ1H8A==
Message-ID: <sashiko-outbox-174294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
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
In-Reply-To: <20261016-hwpoison-kho-v6-7-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-7-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:28:55 +0000
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

> When memory_failure() reports the outcome of a hard offline, set the
> frame's bit in the LINUX_EFI_POISONED_MEMORY bitmap, so that the next
> kernel reserves its unit.
>=20
> Hook action_result() ahead of the statistics guard. A hard error on a
> frame that was soft-offlined earlier comes in as MF_MSG_ALREADY_POISONED,
> which skips the statistics, but it is a real failure and has to be
> recorded. MF_MSG_PFN_MAP is left out, as it is not System RAM.
>=20
> A bit is only ever set, never cleared (for now). Several frames share
> a bit, and an unpoison cannot tell whether the unit as a whole is good
> again. That is a known limitation.
>=20
> The table is mapped with memremap() from an early_initcall rather than
> through the direct map. On arm64, mem=3D and the usable memory range of a
> crash kernel trim memblock, which drops the table's pages from the direct
> map, and the first recorded error then faults.
>=20
> Recording is skipped on a host with SME active. The stub writes the table
> in the clear, so reading it back there needs a decrypted mapping. That is
> left for a follow up.
>=20
> memory_failure() has already taken the frame out of this kernel's
> allocator, so only the cross-kexec record happens here.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D7


