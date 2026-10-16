Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274F1CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vac60GEX0bHyWQ+7amGjTohzU7GbGPnEGKAvGpVtnDU=; b=UK6e7hXTFzVx4xE5RqQkktZzW1
	EudSeFOBURiZz5jm1Lf8xw5krUHng5QUijFnnfXMMNb6pXI2gP1pO75kSOKSLKtP17pW2AdMyeiWF
	TAFdrBf5N7wDpeoaYkcdLuPdeFaeVSi4a9mMAe8JkZqJ9i1E4tuu7aJcpGMK4Px+mP7C83iEQt3X0
	d/WIF1tAYc1WD8lUwnOe60H0WjBEGkhfPLrtHCLwbhsFQqzsTiIiw43VRk3Rr+FeBcnYgekapzfA8
	YBbiSAXOiX0Pg1mAQQtwiK/s2cBRalb9VP5hjI6hOyurByngW6IHJclTICGsAq/lGMu+AmqPouDCi
	opCKKlgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgxf-00000002rTw-20Bd;
	Fri, 16 Oct 2026 12:22:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgxd-00000002rTP-43Cb
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:22:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BE93260018;
	Fri, 16 Oct 2026 12:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5151F000C4;
	Fri, 16 Oct 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153376;
	bh=vac60GEX0bHyWQ+7amGjTohzU7GbGPnEGKAvGpVtnDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLbhDq3Md0KXY78Wdy/JRlQO2FbGEDc4yGPFUZeLjyFYE8lFtyzKbRLtC46aiafVE
	 ZD5tRbKQTb2ny+8EpzScBt+/S591LdGn1fgKb5u8cZtnXO8skCsXeN/mcUchWeYBLc
	 nGpLF6bW2Odptq5jEgQmOZVzzW/ATNmaYbj1j5Pgi2NdizfMdKOpTp3WhNnJieRrRA
	 8f8Z5AcW5rt3A0dmq52YAsPArF1KdBjs0EahwcSebD9Qsc+hKe8LVV7Hzx8G5zxmS2
	 sl2OYUKfZrxi16EbCzG/Oxs1ohzV2X7m+jCbWAUD9LwnnsSyTgiBdutpyICP16Z7JT
	 hhdZpvXaCy3kg==
Message-ID: <sashiko-outbox-174289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
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
In-Reply-To: <20261016-hwpoison-kho-v6-1-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-1-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:22:54 +0000
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
> EFI_STUB && 64BIT is little-endian everywhere: arm64 turns EFI off under
> CPU_BIG_ENDIAN, and no other architecture with the stub is big-endian.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D1


