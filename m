Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FDCC6FD1C
	for <kexec@archiver.kernel.org>; Thu, 23 Mar 2023 03:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eFendHR4aJcMMqyYKRcLGePY8TLW0BoCr8DLoZeaGOI=; b=s+/RCvrR3OsPgl
	YPmF4deVhiN9K8UNrEAF5F1ihopAXsltBupVy8H2xXcUuCysISeoQ/m75rtXfRhTV21gEilH4q7/X
	UGrw8svgpPeh6gIdX4bAe/X7MgYUeMO24RIvu0SwCNvQU+AiNW9KSsNAGO6L6g4FdKXE6vLGlN2GO
	/qSWZV8EI2r3J9arcKoLSGhfM0mhaJ/31VUjxoFQaFLb2U5TU9/wptl0oKtRTUxZwAHHpqNHQU+iT
	nAE+UgwoCY2dZlkp3hBdDL/13ppjj01MzFPGb5GdGXo92x+krsvPrZV5FJTYCKvmfbRQj1E+xXzmA
	f2xGrZry7rzR170KyEjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBpC-000fWG-0w;
	Thu, 23 Mar 2023 03:41:14 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBp7-000fU0-2N;
	Thu, 23 Mar 2023 03:41:11 +0000
Received: by mail-pj1-x1033.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so679007pjt.2;
        Wed, 22 Mar 2023 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679542866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoyT5WlWMHPRnswjhmL4+i1o/+q9y1wOVS+eAYJgyU8=;
        b=iG23NtLktGlCuK8yLrt2HgdI2u9Xjrn1xIHRMMQ3pBMV1xVKNHeNmgZxutv9V593Kh
         BcqktDsp/tktwDAfdnh9Lt32isrrQCH1uKy6X2AtUa6g11DsaHb0nrSrhphqQqfr/EAZ
         BD7TgkX9/OdcfUKsCCV1+bNNIFnRBXts4MDszZdP8Mfj/h4qB1jB97D9f5f6zS6Pato1
         /ptfVhFtBq4viZfKfa7ULtZKK1LSNrmzL+nzXB4MYMm9i3Z++7wQ6f4ubqg8ihpk+sk5
         TaR4/zWVHzJ1KB2MQL+f5UPnE2DFWBX1qoKi1ZvxKuh38OjWbwHS/zx8OwemuEGtO/qy
         LU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679542866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoyT5WlWMHPRnswjhmL4+i1o/+q9y1wOVS+eAYJgyU8=;
        b=HfVMUwj24RDrdKN2RWvGPARWCOsNgGEHD3iy4qo5RRhZvKrV1DB+DqRseM0mhoC6oh
         4cpLDXjmHXyGCVqbeXtm0ErZ26VIkHFrdcyZXHjYLq23KSCc6XImQypehy1tviWd7nTr
         CKNRgoMhUdk8jhLt7CrMiOKlm+YUIeJts98bhZOl6L8XcOHTvcCHdaOuyIGeHUtesjIQ
         nxQ9WpWNoqlUIGqrO9/8zOlIa1m/SO3MwDKKMZhdL1Zvq/d3HPs5Xm0u2WdiBxyNcYh9
         QC5BKOa6TkK+GIU4DlMsmYO/I41GLN2kuGSLOys5ks/DJbsA2YR94+Ssz+ES1/vjvEUo
         eIoQ==
X-Gm-Message-State: AO0yUKVN0Ewzz4NZ+2qtNJGWY/ssU/8tCUkriQnOmSngNq+z+VC6dnXn
	7JUb71CMaroQFcBPOwSF8TXwK9dyTA==
X-Google-Smtp-Source: AK7set+QUfnUhnpJEqKH7UfWBlBlehf/TeZPU8cuBJxgygXSi8hJBqupZKgwu+4OSJFCj0Tc/ZBVww==
X-Received: by 2002:a17:90b:3b4f:b0:23f:86c2:54e2 with SMTP id ot15-20020a17090b3b4f00b0023f86c254e2mr6077157pjb.16.1679542866516;
        Wed, 22 Mar 2023 20:41:06 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id fu2-20020a17090ad18200b002376d85844dsm254024pjb.51.2023.03.22.20.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 20:41:05 -0700 (PDT)
Date: Thu, 23 Mar 2023 11:40:58 +0800
From: Pingfan Liu <kernelfans@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
 <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
 <ZAqvTyv3C+Hvl9cR@piliu.users.ipa.redhat.com>
 <CALu+AoS86mKmeeTxSQyaA70=-5bCC3g3iO4i=A6HTZ-ewdHh=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoS86mKmeeTxSQyaA70=-5bCC3g3iO4i=A6HTZ-ewdHh=w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_204109_792367_D8078485 
X-CRM114-Status: GOOD (  65.84  )
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

Hi Dave,

Thanks for your suggestion. Please see the comment inlined.

On Wed, Mar 22, 2023 at 11:44:52AM +0800, Dave Young wrote:
> On Fri, 10 Mar 2023 at 12:18, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 04:08:55PM +0800, Pingfan Liu wrote:
> > > Hi Ard,
> > >
> > > Thanks for sharing your idea. Please see the comment.
> > >
> > > On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> > > > (cc Mark)
> > > >
> > > > Hello Pingfan,
> > > >
> > > > Thanks for working on this.
> > > >
> > > > On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > >
> > > > > After introducing zboot image, kexec_file can not load and jump to the
> > > > > new style image. Hence it demands a method to load the new kernel.
> > > > >
> > > > > The crux of the problem lies in when and how to decompress the Image.gz.
> > > > > There are three possible courses to take: -1. in user space, but hard to
> > > > > achieve due to the signature verification inside the kernel.
> > > >
> > > > That depends. The EFI zboot image encapsulates another PE/COFF image,
> > > > which could be signed as well.
> > > >
> > > > So there are at least three other options here:
> > > > - sign the encapsulated image with the same key as the zboot image
> > > > - sign the encapsulated image with a key that is only valid for kexec boot
> > > > - sign the encapsulated image with an ephemeral key that is only valid
> > > > for a kexec'ing an image that was produced by the same kernel build
> > > >
> > > > >  -2. at the
> > > > > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > > > > EFI service should be provided to that entry, especially about how to be
> > > > > aware of the memory layout.
> > > >
> > > > This is actually an idea I intend to explore: with the EFI runtime
> > > > services regions mapped 1:1, it wouldn't be too hard to implement a
> > > > minimal environment that can run the zboot image under the previous
> > >
> > > The idea of the minimal environment lools amazing. After digging
> > > more deeply into it, I think it means to implement most of the function
> > > members in efi_boot_services, besides that, some UEFI protocols due to
> > > the reference of efi_call_proto(). So a clear boundary between zboot and
> > > its dependent EFI service is demanded before the work.
> > >
> >
> > Looking deeper into it. This approach may be splitted into the following
> > chunks:
> > -1. Estimation the memory demanded by the decompression of zboot, which
> > roughly includes the size of Image, the size of the emulated service and
> > the stack used by zboot. Finally we need a kexec_add_buffer() for this
> > range.
> >
> > -2. The emulated EFI services and some initial data such as the physical
> > address of dtb, the usable memory start address and size should be set
> > by kexec_purgatory_get_set_symbol()
> >
> > -3. Set up an identity mapping of the usable memory by zboot, prepare
> > stack and turn on MMU at the last point just before 'br efi_zboot_entry'
> > in relocate_kernel.S, which means relocate_kernel.S should support two
> > kinds of payload.
> >
> > -4. For efi_zboot_entry(), if jumping from kexec, limit its requirement
> > to only a few boot services: e.g. allocate_pages, allocate_pool. So the
> > emulated services can be deduced.
> 
> Hi Pingfan,
> 
> I'm not sure how hard it will be although Ard thinks it could be
> doable.  If it is not easy I suspect it is not worth the effort.
> 

Yes, it is a little hard comparing to the original patch. But I am also
trying in that direction.

> For your current series,  my suggestion is you can try to move the
> major code in the generic code path in kernel/kexec_file.c and keep
> the arch code minimum so that in the future other arches can avoid
> redundant code.
> 

OK. I will do it.

> Otherwise a fallback solution could be using the same key to sign both
> the zboot image and the internal kernel image like below:
> 1. sign the kernel with the same key twice (kernel image and zboot
> image) in distro kernel
> 2. introduce a kconfig in mainline to sign the kernel image with an
> ephemeral key same to kernel modules.  Distro can disable the config
> option. (in this way kexec can only load the same kernel, it is not
> useful if people want to load older/newer kernels)
> 3. patch kexec-tools to decompress the zboot image and load the kernel image
> 

Yes, this is also a doable way. I will try it if more votes for it.

Thanks,

	Pingfan
> >
> > > > kernel up to the point where it call ExitBootServices(), after which
> > > > kexec() would take over.
> > > >
> > >
> > > IIUC, after kexec switches to efi_zboot_entry(), it will not return,
> > > right?
> > >
> >
> > I have this assumption because letting the control path switch between
> > kernel and non-kernel code is not a good idea.
> >
> >
> > Thanks,
> >
> > Pingfan
> >
> > > > >  -3. in kernel space, during the file load
> > > > > of the zboot image. At that point, the kernel masters the whole memory
> > > > > information, and easily allocates a suitable memory for the decompressed
> > > > > kernel image. (I think this is similar to what grub does today).
> > > > >
> > > >
> > > > GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> > > >
> > >
> > > Ah, thanks for the correcting. I had made an wrong assumption of grub
> > > based on [1], from which, I thought that grub is the case "For
> > > compatibility with non-EFI loaders, the payload can be decompressed and
> > > executed by the loader as well, provided that the loader implements the
> > > decompression algorithm and that non-EFI boot is supported by the
> > > encapsulated image"
> > >
> > >
> > > [1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot
> > >
> > >
> > > Eager to find a solution to kexec a zboot image. Hope it will come soon.
> > >
> > >
> > > Thanks,
> > >
> > >       Pingfan
> > > > > The core of this series is [5/6].  [3,6/6] handles the config option.
> > > > > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > > > > especially it can load kernel images compressed with different
> > > > > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > > > > decompression method should be included.
> > > > >
> > > > >
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > Cc: kexec@lists.infradead.org
> > > > > To: linux-arm-kernel@lists.infradead.org
> > > > > To: linux-kernel@vger.kernel.org
> > > > >
> > > > > Pingfan Liu (6):
> > > > >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> > > > >   lib/decompress: Introduce decompress_method_by_name()
> > > > >   arm64: Kconfig: Pick decompressing method for kexec file load
> > > > >   lib/decompress: Keep decompress routines based on selection
> > > > >   arm64: kexec: Introduce zboot image loader
> > > > >   init/Kconfig: Select decompressing method if compressing kernel
> > > > >
> > > > >  arch/arm64/Kconfig                            |  59 ++++++
> > > > >  arch/arm64/include/asm/kexec.h                |   4 +-
> > > > >  arch/arm64/kernel/Makefile                    |   2 +-
> > > > >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> > > > >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> > > > >  arch/arm64/kernel/machine_kexec.c             |   1 +
> > > > >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> > > > >  include/linux/decompress/generic.h            |   2 +
> > > > >  include/linux/decompress/mm.h                 |   9 +-
> > > > >  include/linux/zboot.h                         |  26 +++
> > > > >  init/Kconfig                                  |   7 +
> > > > >  lib/Kconfig                                   |   3 +
> > > > >  lib/decompress.c                              |  17 +-
> > > > >  13 files changed, 314 insertions(+), 7 deletions(-)
> > > > >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> > > > >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> > > > >  create mode 100644 include/linux/zboot.h
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
