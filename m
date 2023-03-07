Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C0EC678D4
	for <kexec@archiver.kernel.org>; Tue,  7 Mar 2023 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hnU323V3AtwNKZMLtdnbFX2j5FQBcVGB4fyvz3ipGPs=; b=PfWs7UFKKAXvDr
	T9N7T2tAo2l2Pg8DG5buVhK7nbVZAowxjEpMNEfcQnsD82rg5pY2BxQ++VKTsHWd0Rhk8tgIJLaUT
	0T1UNwLDK1n7MHloVuvgGmRgJoJtX3EgHXD+SNU9QsV4MfEyCjFwSyzaChSzNqhsFtnMov4zK5ZHk
	NGRo4NbHsSrOHfcqPGcgyZv0UDItnZLCtBM8qWakrOiIv9et6wz3/J0URg3HX1rfdgmTYAc46LlGy
	ZOPaNNmA7pZmaoEY75nYLu+XBWN/ygXrN6P74q8skgtWkmzd1kYzcYMmH634A7IbOhINk5r94d7IV
	6uCs+LoT2hnVZN8Cz64A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZSOG-00GcVk-9P; Tue, 07 Mar 2023 08:09:44 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZSNb-00Gc5X-Va; Tue, 07 Mar 2023 08:09:05 +0000
Received: by mail-pl1-x633.google.com with SMTP id x11so8698112pln.12;
        Tue, 07 Mar 2023 00:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678176541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5zZrovIRs5zLJv0G+iS2mKyTpyGJ8bky1sIW7/neCY=;
        b=m8OxLTzPl5iPiawWVFI1+BNlPyv1wKgsXEbJBkslhBiY8dheVnaRyijBo9KRfTFDbi
         3U7n6UD3qANq8Z20nnwhlw65qmr7pZgXP/3UckK6C0K9jDL+sv4cBg1r8Al98rHprBtJ
         qo7D3GQvUCmNJRd4MJ/vmGiYLIYeku3p74VVfC/+LreVUNFlnRW+MJZIbY+pJRVhmoGx
         XbFYrkHyf+DedkljOOdxhPvgeFsjR5cKXybth7jwsyAmcBgRN5kIuAZ4TERj+j0fdzr3
         WxTesprLD0E+Tq2HDV0sk2cI3pBHiG7ih24DE0Oi6BgenAILg9t0e+5Ve0vGKp3zOl+2
         HbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5zZrovIRs5zLJv0G+iS2mKyTpyGJ8bky1sIW7/neCY=;
        b=nROfuOCQX2kOtCAGe/CwOF2Xe3AyHojcEL+xpJXZisvoPRlTcRERdmr7BROG8m6SOj
         lsMx51LMV+UgceiITJa5O7Qo/QEshAh/sz/9s54Vl3NG+gYhBCSxEp7Al6iFiUZK9iHt
         1g6X/w7+1GX9J3MOC5nRDboLMDG+Lr9YrgTant2GXT5EzYLrdsGKJQhjSQ3Hv1NUUwzE
         DVhP7Kw7M5x1RYihdNhf5i93ANysBWUo7NBdFc9Pi3Q1SKiYi7TuJeZEOplbGkaSMPGV
         gFzOio/kchi8HR8M5hb18rxIPwZOWSjvEg+VUHZZ+e5BURCVI3PX3t5gBP37LBbanmux
         I7wg==
X-Gm-Message-State: AO0yUKU/LEGJ7gSgQx2/eQy2vWJH8493axFG9zKrH5RMzhlH6HDcsfc9
	NHnw10HVY7hAdvLhbAFXrA==
X-Google-Smtp-Source: AK7set8Z+BUR8AwsCrasOZRglrMO4TGwh/SjdjgmzTf5p3052x3E2Cc9Q5pK4PgMa8K9mB8ivsTYQw==
X-Received: by 2002:a05:6a21:78a6:b0:cc:5f27:d003 with SMTP id bf38-20020a056a2178a600b000cc5f27d003mr14752364pzc.56.1678176541057;
        Tue, 07 Mar 2023 00:09:01 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e1-20020a631e01000000b004fb681ea0e1sm7290405pge.84.2023.03.07.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:09:00 -0800 (PST)
Date: Tue, 7 Mar 2023 16:08:55 +0800
From: Pingfan Liu <kernelfans@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_000904_073187_009CD7B1 
X-CRM114-Status: GOOD (  38.71  )
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

Hi Ard,

Thanks for sharing your idea. Please see the comment.

On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> (cc Mark)
> 
> Hello Pingfan,
> 
> Thanks for working on this.
> 
> On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > After introducing zboot image, kexec_file can not load and jump to the
> > new style image. Hence it demands a method to load the new kernel.
> >
> > The crux of the problem lies in when and how to decompress the Image.gz.
> > There are three possible courses to take: -1. in user space, but hard to
> > achieve due to the signature verification inside the kernel.
> 
> That depends. The EFI zboot image encapsulates another PE/COFF image,
> which could be signed as well.
> 
> So there are at least three other options here:
> - sign the encapsulated image with the same key as the zboot image
> - sign the encapsulated image with a key that is only valid for kexec boot
> - sign the encapsulated image with an ephemeral key that is only valid
> for a kexec'ing an image that was produced by the same kernel build
> 
> >  -2. at the
> > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > EFI service should be provided to that entry, especially about how to be
> > aware of the memory layout.
> 
> This is actually an idea I intend to explore: with the EFI runtime
> services regions mapped 1:1, it wouldn't be too hard to implement a
> minimal environment that can run the zboot image under the previous

The idea of the minimal environment lools amazing. After digging
more deeply into it, I think it means to implement most of the function
members in efi_boot_services, besides that, some UEFI protocols due to
the reference of efi_call_proto(). So a clear boundary between zboot and
its dependent EFI service is demanded before the work.

> kernel up to the point where it call ExitBootServices(), after which
> kexec() would take over.
> 

IIUC, after kexec switches to efi_zboot_entry(), it will not return,
right?

> >  -3. in kernel space, during the file load
> > of the zboot image. At that point, the kernel masters the whole memory
> > information, and easily allocates a suitable memory for the decompressed
> > kernel image. (I think this is similar to what grub does today).
> >
> 
> GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> 

Ah, thanks for the correcting. I had made an wrong assumption of grub
based on [1], from which, I thought that grub is the case "For
compatibility with non-EFI loaders, the payload can be decompressed and
executed by the loader as well, provided that the loader implements the
decompression algorithm and that non-EFI boot is supported by the
encapsulated image" 


[1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot


Eager to find a solution to kexec a zboot image. Hope it will come soon.


Thanks,

	Pingfan
> > The core of this series is [5/6].  [3,6/6] handles the config option.
> > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > especially it can load kernel images compressed with different
> > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > decompression method should be included.
> >
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: kexec@lists.infradead.org
> > To: linux-arm-kernel@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> >
> > Pingfan Liu (6):
> >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> >   lib/decompress: Introduce decompress_method_by_name()
> >   arm64: Kconfig: Pick decompressing method for kexec file load
> >   lib/decompress: Keep decompress routines based on selection
> >   arm64: kexec: Introduce zboot image loader
> >   init/Kconfig: Select decompressing method if compressing kernel
> >
> >  arch/arm64/Kconfig                            |  59 ++++++
> >  arch/arm64/include/asm/kexec.h                |   4 +-
> >  arch/arm64/kernel/Makefile                    |   2 +-
> >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> >  arch/arm64/kernel/machine_kexec.c             |   1 +
> >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> >  include/linux/decompress/generic.h            |   2 +
> >  include/linux/decompress/mm.h                 |   9 +-
> >  include/linux/zboot.h                         |  26 +++
> >  init/Kconfig                                  |   7 +
> >  lib/Kconfig                                   |   3 +
> >  lib/decompress.c                              |  17 +-
> >  13 files changed, 314 insertions(+), 7 deletions(-)
> >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> >  create mode 100644 include/linux/zboot.h
> >
> > --
> > 2.31.1
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
