Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFBCC61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Idl0CdtqKlMtz547yFC1SP5Z9bC9rIuPrnkrEDceyBA=; b=pi+KfMJbhiT5bE
	JnqugUvuSZVz2LXGIJXKGSy3Ut6Af5f1z/NZt9EtFk8s18UI8wtiGnR94EN/CnGpcNmyJ1YU7qBpP
	vKZ+EdHXt3usLliK6ypfvJ640obc+GSco4ou2BY+0hw3Hu37yI62925sdYjY1BqTCfMUtNr02jiEA
	BGRD9J9DTS2uB3DAOHoFSQmtEW0H29uPyZoH6IqFK1QsGhFyU48MSznVfSoY9XVN+QCqN1j7yXpNs
	YPopHOxE7j8RL3gPcUzJB85MFbn1CSNrLGAv68kdK0OM2mjWBDQHGT2S/HwOvi8grk0FTXgsopU/B
	Yh+8IK6lra/Za0sD8mZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ5zS-00BoxP-0I; Mon, 06 Mar 2023 08:14:38 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ5tM-00BmPB-ES; Mon, 06 Mar 2023 08:08:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3EB28B80CA6;
	Mon,  6 Mar 2023 08:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CBBC433EF;
	Mon,  6 Mar 2023 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678090096;
	bh=InTHjoY7IHjYGOge2xtjXx++Yn/E+Bilz80BtlawvMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j2RPowZFjt3/lAmnPiLqbIXbp05Tb0FwtEvABvGSQXlfRJs2Qrom9TtNneGlYy+6p
	 JJGce8ulZ5uhDmVvOtOpZoFNFIVDCf0vqgdvw75Izi5rZLCSHdNtNt5TFKv9UDgDRv
	 2q/ctsnREW0ueRQT+NNXgoAWPbnOJETWZ7Fto4ghQuN9KJ/p31yvmoyc0o/Q+yOTEj
	 ftKWIBLxDYQyq42CV7lvKEfOZDXFV1VYJWB79Jtd/ReG4ZenkaasFiJxY7rE74XTLw
	 x59d6cuccSzVYR9VOnG0M8BsLAHT9NuetancbtR1cDj3zcqyx7g8hjqCKIc8MCBIGd
	 lgmJT++ZbJnUg==
Received: by mail-lj1-f173.google.com with SMTP id a32so8682709ljr.9;
        Mon, 06 Mar 2023 00:08:16 -0800 (PST)
X-Gm-Message-State: AO0yUKX0+2c7vqk3fOhlznssC7Que+HtPgGlIVV1IX4Psv0S1FAcWKlx
	B2hKZ006QtxC7U4Ep6S+nlJKwmhJ8wZZwiAM2Bs=
X-Google-Smtp-Source: AK7set/u2iI2GmPpi74ma3lbh9gCKEtqWTLFne3S0kGYtghedVx/axHU4rUI/K3IRXkDs2jwtzKDYRytPptbGrlkDII=
X-Received: by 2002:a05:651c:1725:b0:295:8ef2:8707 with SMTP id
 be37-20020a05651c172500b002958ef28707mr2846606ljb.2.1678090094989; Mon, 06
 Mar 2023 00:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20230306030305.15595-1-kernelfans@gmail.com>
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Mar 2023 09:08:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
Message-ID: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
To: Pingfan Liu <kernelfans@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_000821_075180_A23FF7D2 
X-CRM114-Status: GOOD (  27.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

(cc Mark)

Hello Pingfan,

Thanks for working on this.

On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> After introducing zboot image, kexec_file can not load and jump to the
> new style image. Hence it demands a method to load the new kernel.
>
> The crux of the problem lies in when and how to decompress the Image.gz.
> There are three possible courses to take: -1. in user space, but hard to
> achieve due to the signature verification inside the kernel.

That depends. The EFI zboot image encapsulates another PE/COFF image,
which could be signed as well.

So there are at least three other options here:
- sign the encapsulated image with the same key as the zboot image
- sign the encapsulated image with a key that is only valid for kexec boot
- sign the encapsulated image with an ephemeral key that is only valid
for a kexec'ing an image that was produced by the same kernel build

>  -2. at the
> boot time, let the efi_zboot_entry() handles it, which means a simulated
> EFI service should be provided to that entry, especially about how to be
> aware of the memory layout.

This is actually an idea I intend to explore: with the EFI runtime
services regions mapped 1:1, it wouldn't be too hard to implement a
minimal environment that can run the zboot image under the previous
kernel up to the point where it call ExitBootServices(), after which
kexec() would take over.

>  -3. in kernel space, during the file load
> of the zboot image. At that point, the kernel masters the whole memory
> information, and easily allocates a suitable memory for the decompressed
> kernel image. (I think this is similar to what grub does today).
>

GRUB just calls LoadImage(), and the decompression code runs in the EFI context.

> The core of this series is [5/6].  [3,6/6] handles the config option.
> The assumption of [3/6] is kexec_file_load is independent of zboot,
> especially it can load kernel images compressed with different
> compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> decompression method should be included.
>
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: kexec@lists.infradead.org
> To: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
>
> Pingfan Liu (6):
>   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
>   lib/decompress: Introduce decompress_method_by_name()
>   arm64: Kconfig: Pick decompressing method for kexec file load
>   lib/decompress: Keep decompress routines based on selection
>   arm64: kexec: Introduce zboot image loader
>   init/Kconfig: Select decompressing method if compressing kernel
>
>  arch/arm64/Kconfig                            |  59 ++++++
>  arch/arm64/include/asm/kexec.h                |   4 +-
>  arch/arm64/kernel/Makefile                    |   2 +-
>  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
>  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
>  arch/arm64/kernel/machine_kexec.c             |   1 +
>  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
>  include/linux/decompress/generic.h            |   2 +
>  include/linux/decompress/mm.h                 |   9 +-
>  include/linux/zboot.h                         |  26 +++
>  init/Kconfig                                  |   7 +
>  lib/Kconfig                                   |   3 +
>  lib/decompress.c                              |  17 +-
>  13 files changed, 314 insertions(+), 7 deletions(-)
>  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
>  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
>  create mode 100644 include/linux/zboot.h
>
> --
> 2.31.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
