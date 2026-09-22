Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D73C982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cpSLdx5G86GAiYEa1KiKUdyGr9Hwx+hUdwakbZPe5c=; b=HbpElW17N8UAj/6gk2r1MFH5ae
	ApfaJKspKghOMOsplBfPYQBADCSXMjrXqlVTx/1bywHXkuFH7yIyrYuECyTU0LDuhxkzSs/m3LCNr
	obfahnFnKPPhn3NVYfat7iI4tTNGjeVg7YERenE6ORe2GAmsz+G99UAI9d0zA56hdif3JhV9TAr5B
	l7pwKzCJyI3SaM9goS73ZVHCBvwXWtq88JfBGTgvik9yRB/m+4rA2GtRNFsu1AYx8G1jdbdZzEzc1
	Ef53o5zcsw1qfQ5TlOohyLiZNRFeheAyOnyAtI28dlcr9ibmGKabN0BxHGbsdnFiQGBZPmtBaSY4i
	juDGaHmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wLz-00000004oHS-0u9Z;
	Tue, 22 Sep 2026 08:59:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wLy-00000004oGr-0utC;
	Tue, 22 Sep 2026 08:59:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 729CE60200;
	Tue, 22 Sep 2026 08:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB051F000FF;
	Tue, 22 Sep 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067593;
	bh=+cpSLdx5G86GAiYEa1KiKUdyGr9Hwx+hUdwakbZPe5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izvJYf3wx7OMx8dtyK2bPgV4goHzPpSwGkfqbgOp88Z2f384iep3os6cqHBe6ioCo
	 IipTl+Y06tX741Ho3LXMdE8qTZBy6i3kW/AG2fyAak47hFXgIbhMztEc/AjEfWJ3gO
	 tR/TutUOUAWlWalvbKQpWlAlEN8YL3e5y5N7pjthg/ab5xsU3bbMXVoOIgsjkQruj1
	 OyekninqCRr4y32dIPdT5Bd+44BDIJNM8eGAdEaSR4P5Xn3uC66ReBLFcE1ilJjyVa
	 Vp4PDuJDDdxPnmrmh8vGIIpx5tDJkTvYEYN2OU5Kmw3iEXQ1oXLsmHDVUD/8g0E2hX
	 zd2wbQtt6yspg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] riscv: build crash_mem ranges from memblock
 instead of resource tree
To: robh@kernel.org, rppt@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, baoquan.he@linux.dev, m.szyprowski@samsung.com
Cc: pasha.tatashin@soleen.com, aou@eecs.berkeley.edu, linux-mm@kvack.org, conor+dt@kernel.org, mark.rutland@arm.com, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, bp@alien8.de, catalin.marinas@arm.com, mingo@redhat.com, ruirui.yang@linux.dev, iommu@lists.linux.dev, kexec@lists.infradead.org, saravanak@kernel.org, pjw@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, alex@ghiti.fr, chenhuacai@kernel.org, x86@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kernel@xen0n.name, will@kernel.org, palmer@dabbelt.com, pratyush@kernel.org, tglx@kernel.org
In-Reply-To: <20260922084256.1515554-2-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:59:51 +0000
Message-Id: <20260922085951.DAB051F000FF@smtp.kernel.org>
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
>=20
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D1


