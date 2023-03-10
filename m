Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0921BC6FA99
	for <kexec@archiver.kernel.org>; Fri, 10 Mar 2023 04:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16oG9ju2s5Vsvs4iBsxcbOBKhd3O6MUUyFHTkFu0Isc=; b=k4Sa6JoCPHD9GZ
	ASiUp6UdjIWs5bWoFqGC9z15FbUlmC3QBjlIHDZl1NDPQttlTV3eyZPger3pD3gxgR/hoE+rfRi8/
	i2zE4LU6ecUstZnjActFA1IZhRLigy6dfftbFUcC8ujSx7c0E4zu16aZQWtWc404E8yzPSfZw2Su9
	s6wUd6k3jzVDMNTRZulLluHUlLljHx/eGN/pcfEFt/B+xJ5VxBPzXmf0dxZsgKSytkK1gkhkEOZD/
	tQ0C8YKEyLYOwSfmmFkVYfn+a/L0E5PfDEz5Gt/L6OD4ZMPlEobIhMwcDf9QVGX90tDdb08sJkgQ7
	qU4eewGHS62YOTVgPyUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paUCN-00Cy29-EC; Fri, 10 Mar 2023 04:17:43 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paUCC-00Cy0F-JO; Fri, 10 Mar 2023 04:17:34 +0000
Received: by mail-pl1-x62f.google.com with SMTP id p6so4378432plf.0;
        Thu, 09 Mar 2023 20:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678421845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU4apqaTRhvF7Rao6hZgNCQ5bmYVq7gw3Mf+gBiqigE=;
        b=pYTx65/TDFzzGD3U9Ia1TQ/VM0xQnU2LBWqzSyUpfrXb0caFoymwlvwmeY7WJSEtTm
         F3Xt8ykXyCEENrlyj4sMYBFTkSB8VSpIxolDyGBdCOLkmMupjVWAQI4mTtdK74BE+PdX
         OvWg+ZWAca45zBzEcZmhI++JF7SykdducaZ8a2MFEfnIY5l8qA/BzsRIdfGblbl/6hZ/
         nf0FynJcElVc/F+gKz4TsiBBMZa5tMvL4E11qycBkT8nWjAnfLqZAP6VOlrls6XsURaj
         ro4d8NnNQpWXtoSV5MNNF0aGslduW4fhH6EKrv0H9g/c0mqK8LIFN51E0Ix/Bnu7ejhx
         RKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU4apqaTRhvF7Rao6hZgNCQ5bmYVq7gw3Mf+gBiqigE=;
        b=hBjQxgPRtFPGf9rlnisLXtLM82TjnhxXc1R0C0qJW1R4nWgi3tC4eEK98VjnOXfF+k
         cZV9IyOqcKBHUevVRyLjjtJp1qia7gG3aP68kXEFd0zHp3C2OcXgymPA8F4PqPDpTNIe
         qR2Qqa1CR+wbQH8LZ6Z42Ttrr2CpB0E1qT61M37G6arbncLkXvTa+pM4fklVQoCqFnUc
         Tb+fGj9zZuhZcrya9cqp7+I+f/4SWrOEDlipnSdsnYNXGBYDPB+2C2ar/hl15vVPFNAn
         pupLP3amtKWAe/neUTwEpsRSNZhlYC9PCAdeZKvnpatnVfoICz6yTW1fWwsZA3H89olV
         2TXw==
X-Gm-Message-State: AO0yUKW4Sos4vQlWuZ72ylzYj3J3XlEXMc9mgU0pvFopZBCfWECcJfYS
	I/8cw4GTy+hgfmn+LQc8opjZ9BnGpQ==
X-Google-Smtp-Source: AK7set/lC7bwOfFt1xEFfH4Q2bMEjvqYBbPhBM5Dm1RxGyhtvDximq8Rla8hJPopnXt92tvy5nxhBA==
X-Received: by 2002:a17:90b:1b4e:b0:23a:5f51:6ee5 with SMTP id nv14-20020a17090b1b4e00b0023a5f516ee5mr25386228pjb.12.1678421845114;
        Thu, 09 Mar 2023 20:17:25 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090a119000b002367325203fsm699285pja.50.2023.03.09.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:17:24 -0800 (PST)
Date: Fri, 10 Mar 2023 12:17:19 +0800
From: Pingfan Liu <kernelfans@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZAqvTyv3C+Hvl9cR@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
 <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_201732_682966_AE376AC6 
X-CRM114-Status: GOOD (  48.17  )
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

On Tue, Mar 07, 2023 at 04:08:55PM +0800, Pingfan Liu wrote:
> Hi Ard,
> 
> Thanks for sharing your idea. Please see the comment.
> 
> On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> > (cc Mark)
> > 
> > Hello Pingfan,
> > 
> > Thanks for working on this.
> > 
> > On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > After introducing zboot image, kexec_file can not load and jump to the
> > > new style image. Hence it demands a method to load the new kernel.
> > >
> > > The crux of the problem lies in when and how to decompress the Image.gz.
> > > There are three possible courses to take: -1. in user space, but hard to
> > > achieve due to the signature verification inside the kernel.
> > 
> > That depends. The EFI zboot image encapsulates another PE/COFF image,
> > which could be signed as well.
> > 
> > So there are at least three other options here:
> > - sign the encapsulated image with the same key as the zboot image
> > - sign the encapsulated image with a key that is only valid for kexec boot
> > - sign the encapsulated image with an ephemeral key that is only valid
> > for a kexec'ing an image that was produced by the same kernel build
> > 
> > >  -2. at the
> > > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > > EFI service should be provided to that entry, especially about how to be
> > > aware of the memory layout.
> > 
> > This is actually an idea I intend to explore: with the EFI runtime
> > services regions mapped 1:1, it wouldn't be too hard to implement a
> > minimal environment that can run the zboot image under the previous
> 
> The idea of the minimal environment lools amazing. After digging
> more deeply into it, I think it means to implement most of the function
> members in efi_boot_services, besides that, some UEFI protocols due to
> the reference of efi_call_proto(). So a clear boundary between zboot and
> its dependent EFI service is demanded before the work.
> 

Looking deeper into it. This approach may be splitted into the following
chunks:
-1. Estimation the memory demanded by the decompression of zboot, which
roughly includes the size of Image, the size of the emulated service and
the stack used by zboot. Finally we need a kexec_add_buffer() for this
range.

-2. The emulated EFI services and some initial data such as the physical
address of dtb, the usable memory start address and size should be set
by kexec_purgatory_get_set_symbol()

-3. Set up an identity mapping of the usable memory by zboot, prepare
stack and turn on MMU at the last point just before 'br efi_zboot_entry'
in relocate_kernel.S, which means relocate_kernel.S should support two
kinds of payload.

-4. For efi_zboot_entry(), if jumping from kexec, limit its requirement
to only a few boot services: e.g. allocate_pages, allocate_pool. So the
emulated services can be deduced.

> > kernel up to the point where it call ExitBootServices(), after which
> > kexec() would take over.
> > 
> 
> IIUC, after kexec switches to efi_zboot_entry(), it will not return,
> right?
> 

I have this assumption because letting the control path switch between
kernel and non-kernel code is not a good idea.


Thanks,

Pingfan

> > >  -3. in kernel space, during the file load
> > > of the zboot image. At that point, the kernel masters the whole memory
> > > information, and easily allocates a suitable memory for the decompressed
> > > kernel image. (I think this is similar to what grub does today).
> > >
> > 
> > GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> > 
> 
> Ah, thanks for the correcting. I had made an wrong assumption of grub
> based on [1], from which, I thought that grub is the case "For
> compatibility with non-EFI loaders, the payload can be decompressed and
> executed by the loader as well, provided that the loader implements the
> decompression algorithm and that non-EFI boot is supported by the
> encapsulated image" 
> 
> 
> [1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot
> 
> 
> Eager to find a solution to kexec a zboot image. Hope it will come soon.
> 
> 
> Thanks,
> 
> 	Pingfan
> > > The core of this series is [5/6].  [3,6/6] handles the config option.
> > > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > > especially it can load kernel images compressed with different
> > > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > > decompression method should be included.
> > >
> > >
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: kexec@lists.infradead.org
> > > To: linux-arm-kernel@lists.infradead.org
> > > To: linux-kernel@vger.kernel.org
> > >
> > > Pingfan Liu (6):
> > >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> > >   lib/decompress: Introduce decompress_method_by_name()
> > >   arm64: Kconfig: Pick decompressing method for kexec file load
> > >   lib/decompress: Keep decompress routines based on selection
> > >   arm64: kexec: Introduce zboot image loader
> > >   init/Kconfig: Select decompressing method if compressing kernel
> > >
> > >  arch/arm64/Kconfig                            |  59 ++++++
> > >  arch/arm64/include/asm/kexec.h                |   4 +-
> > >  arch/arm64/kernel/Makefile                    |   2 +-
> > >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> > >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> > >  arch/arm64/kernel/machine_kexec.c             |   1 +
> > >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> > >  include/linux/decompress/generic.h            |   2 +
> > >  include/linux/decompress/mm.h                 |   9 +-
> > >  include/linux/zboot.h                         |  26 +++
> > >  init/Kconfig                                  |   7 +
> > >  lib/Kconfig                                   |   3 +
> > >  lib/decompress.c                              |  17 +-
> > >  13 files changed, 314 insertions(+), 7 deletions(-)
> > >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> > >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> > >  create mode 100644 include/linux/zboot.h
> > >
> > > --
> > > 2.31.1
> > >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
