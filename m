Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C38606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TTaXWYiw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPVXEORV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AriJadNSG2kNLT0g5wkctcMWz1vv7s2SwXN26U9rybA=; b=TTaXWYiwAXDbKMpv31qWkLn55K
	2lJrRAks5JcXCeEhNIS5/FMc6V99Hx/JxaIwyejCxEjJrAjckzbGri8Mp7DoUKknDL2U+bwOCD+Im
	T6WVL9dpjujizT9fUzwBpVLGj+D1llVqa1a057IwS9q78bi5g3Cjk4xveCLN6j1Xw72oLqVozkL6o
	0GtcGqwf6VzWMiO1qO21nb5ktEU1yOxZ0VkCFEZ/trN/ce+KkQWFCBBgxf24JHg/LouhSctCUAPhr
	tnU14hImypVcuegzBB9Js6NhVQMjKVsAyqOmA/cSLqbE0B/9MNz7GKFW5HLrGSxhhyOGqxkh52Uah
	sum74DDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvWf-0000000AzM4-2UFS;
	Thu, 19 Nov 2026 06:21:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvWe-0000000AzLP-30pg
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:21:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7405F4392F;
	Thu, 19 Nov 2026 06:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701831F000C4;
	Thu, 19 Nov 2026 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069300;
	bh=AriJadNSG2kNLT0g5wkctcMWz1vv7s2SwXN26U9rybA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPVXEORVfoKfE4hqfzqMZ5/v6aVOKnkqC9RQU2F6G8V1zWVCVXzIHG5dUYo0ZmZg9
	 XjICuQcxUWyfXx9igNhR9lYp2xcNv1nFkOzaKbdxNWu3mS5KF+IAxbcBKoSYlcLvV9
	 R2uHTrqBbN1Zf/ro2J0cVS+sSd2y85b0uvG0x8O4m2x98cjJkV+Xxi/WTY92ACuFNQ
	 Nb2D6cDqkMjwrk1+E4DKVk+ckIIdPZkgjXDk7sWj1axvGL60xbZXLgQV8DgXSWaXA0
	 NJbhBiYrHxFvGHfRiT5pMy/nsRxqUznrEyE9brA58EKFW2vXMumyRabBuAJpa+EM2o
	 yo/LHncp7L1Fw==
Message-ID: <sashiko-outbox-222519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Borislav
 Petkov" <bp@alien8.de>, "Catalin Marinas" <catalin.marinas@arm.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Helge Deller" <deller@gmx.de>, "Huacai Chen" <chenhuacai@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "John
 Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Rich
 Felker" <dalias@libc.org>, "Russell King" <linux@armlinux.org.uk>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas Gleixner" <tglx@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Will Deacon" <will@kernel.org>, "Yoshinori
 Sato" <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1MgR1JPVVAp?= <chleroy@kernel.org>, "Cong
 Wang" <cwang@multikernel.io>, "Mark Rutland" <mark.rutland@arm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "H.
 Peter Anvin" <hpa@zytor.com>, =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "WANG
 Xuerui" <kernel@xen0n.name>, kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:21:38 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] riscv: missing ARCH_KEEP_MEMBLOCK and HOTPLUG_CPU selects for
  KEXEC_FILE [1]
--

commit 72fcff7ceb4b8dc27b8490a2ed5edc55973e96f8
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

arch, kexec: declare kexec and crash capabilities in Kconfig.kexec

This commit moves the architecture capability options for kexec and crash
dumps into kernel/Kconfig.kexec and updates each architecture to select
them.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da6..3fc73c99d06f1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
[ ... ]
> @@ -65,9 +67,14 @@ config RISCV
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_CFI
> +	select ARCH_SUPPORTS_CRASH_DUMP
> +	select ARCH_SUPPORTS_CRASH_HOTPLUG
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
> +	select ARCH_SUPPORTS_KEXEC
> +	select ARCH_SUPPORTS_KEXEC_FILE		if 64BIT
> +	select ARCH_SUPPORTS_KEXEC_PURGATORY	if 64BIT
>  	select ARCH_SUPPORTS_LTO_CLANG if CMODEL_MEDANY
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
> @@ -1105,38 +1112,17 @@ config RISCV_BOOT_SPINWAIT
> =20
>  	  If unsure what to do here, say N.
> =20
> -config ARCH_SUPPORTS_KEXEC
> -	def_bool y
> -
>  config ARCH_SELECTS_KEXEC
>  	def_bool y
>  	depends on KEXEC
>  	select HOTPLUG_CPU if SMP
> =20
> -config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool 64BIT
> -
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
>  	select KEXEC_ELF

[Severity: High]
This problem wasn't introduced by this patch, but should KEXEC_FILE (or
KEXEC_CORE) also select ARCH_KEEP_MEMBLOCK and HOTPLUG_CPU if SMP
[1]?

config RISCV only has "select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC", and
only ARCH_SELECTS_KEXEC selects HOTPLUG_CPU if SMP.  When KEXEC_FILE=3Dy and
KEXEC=3Dn:

- Without ACPI, memblock_discard() frees the reserved regions array before
  reserve_memblock_reserved_regions() registers them in iomem_resource, so
  kexec_file_load() can place kexec segments over reserved memory.

- On SMP without another option enabling HOTPLUG_CPU,
  smp_shutdown_nonboot_cpus() in machine_shutdown() and
  cpu_ops_sbi.cpu_stop are compiled out, leaving secondary harts running
  in the old kernel during kernel_kexec().

[1] https://sashiko.dev/#/bug/linux-78e86ad1-8753-462c-a044-1d3b3f2cab21

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-arch-kconf=
ig-v1-0-37c276fe4d26@kernel.org?part=3D2

