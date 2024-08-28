Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C1EC636EA
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z3Z3gWjAjpPxb8iZRXGlpn1t5kMJ9hjbqy0oZwpiSjg=; b=eSFHY6UtxNOMV+
	OgmIO79h9m1QviotT2dPKTMLz20UH40Q55Yd/nVnF09E+6KLnasocaZ9pVd2/h/Lg82Znkxmv9L6V
	2Sg6638GbzNfPpHTQnwm4JixNaboMwl6koiJlaZhaXRFIl8uqaQqA+BBmGnzp8S2JzLFRdtisS89D
	AUEsZULDYC+YER5tOlgzJdvJJEJdASkjVVCrJC0zlbBEB/+5ltaAmSqBivsvHhMjCsVPbILb7XCzw
	ktfCicCa2aOwVh6gwkL0iFhRNMyCV/Cxq8dpGPG+BqtfIWsIB1hGOHAV8YDMGj1w7/u5yFIWm4AVO
	BZvccqAvg/0tZBJTvjzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjM9q-0000000GJ5c-06Z4;
	Wed, 28 Aug 2024 17:08:34 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjM9m-0000000GJ3s-0tge
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 17:08:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6E15FAE2CBA
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E8C4CEC5
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724864907;
	bh=JxsueSnSgpUq0E0aiVi/UwfMSleCE1Xyjsfg7oEDTFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BRH0EvcH+Vf2h2JQptTFfaqw70GB1v8ey3mn8+o4f5Dqn1PyHiWV3JWRz8Kq0Sfa+
	 KFAzysOwWiTLxF3Ydl/Vb1MmtBbiqJj6JCKJ1Wy5XE1oB41wLINGphF2skeD2r2p2k
	 owaaSBnevfNjd/ms0z56BpWo7VYpl7BNLEEANDzU2n6sHtdKSq1+C09+Sk/rlZch3P
	 q12nKu0699SoiP+IB4FTmO2nuLFWGip2VXP+z+nWrs3Ybx+RDYZmZSHGx1XWb/6mJQ
	 mdmt8ioIqBWcWU9UbvW+8cyTeG6unyZVpwEJrXaaky39YnKtoYt3Gd4YNHTmiz/fAj
	 Fv1ct9W49ZReg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334c018913so6719273e87.0
        for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 10:08:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOyGfv6xzMJLUFM/eHEzbfUG2pkomSlwK2x40DeKwrF/7PbBnSppiIwEMy3IDFLPKoFBThwA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyTotDf3fxY9VPol7CuEZoKpReyvIU1wC0HTXQrjRqd67T6Wbe1
	+Ub6B3LPg7CA/IYQ2kHA/N3YRwa51vveG0Df5E4Mrvrsjq6vuaqQwsiAmwfgSIBxWviuiJ3/UY3
	5Fx+QDIOHQyV1Sp6Jryoi6gaam2E=
X-Google-Smtp-Source: AGHT+IHL7Ap08nLbek7EV+lukGhBuzhm3LbdLGJwk2IXYMk/XLLc7Z1Z6xC/2CfmMMQQmBth0h1Tvc9Xpf4we8hI8PA=
X-Received: by 2002:a05:6512:6c8:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-5343886124bmr12461107e87.40.1724864905510; Wed, 28 Aug 2024
 10:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:08:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Message-ID: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_100830_556671_137085CE 
X-CRM114-Status: GOOD (  48.24  )
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

On Mon, 19 Aug 2024 at 16:55, Pingfan Liu <piliu@redhat.com> wrote:
>
> *** Background ***
>
> As more PE format kernel images are introduced, it post challenge to kexec to
> cope with the new format.
>
> In my attempt to add support for arm64 zboot image in the kernel [1],
> Ard suggested using an emulator to tackle this issue.  Last year, when
> Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> emulator approach again [3]
>
> After discussion, Ard's approach seems to be a more promising solution
> to handle PE format kernels once and for all.  This series follows that
> approach and implements an emulator to emulate EFI boot time services,
> allowing the efistub kernel to self-extract and boot.
>
> Another year has passed, and UKI kernel is more and more frequently used
> in product. I think it is time to pay effort to resolve this issue.
>
>
> *** Overview of implement ***
> The whole model consits of three parts:
>
> -1. The emulator
> It is a self-relocatable PIC code, which is finally linked into kernel, but not
> export any internal symbol to kernel.  It mainly contains: a PE file parser,
> which loads PE format kernel, a group of functions to emulate efi boot service.
>
> -2. inside kernel, PE-format loader
> Its main task is to set up two extra kexec_segment, one for emulator, the other
> for passing information from the first kernel to emulator.
>
> -3. set up identity mapping only for the memory used by the emulator.
> Here it relies on kimage_alloc_control_pages() to get pages, which will not
> stamped during the process of kexec relocate (cp from src to dst). And since the
> mapping only covers a small range of memory, it cost small amount memory.
>
>
> *** To do ***
>
> Currently, it only works on arm64 virt machine. For x86, it needs some slightly
> changes. (I plan to do it in the next version)
>
> Also, this series does not implement a memory allocator, which I plan to
> implement with the help of bitmap.
>
> About console, currently it hard code for arm64 virt machine, later it should
> extract the information through ACPI table.
>
> For kdump code, it is not implmented yet. But it should share the majority of
> this series.
>
>
> *** Test of this series ***
> I have tested this series on arm64 virt machine. There I booted the vmlinuz.efi
> and kexec_file_load a UKI image, then switch to the second kernel.
>
> I used a modified kexec-tools [4], which just skips the check of the file format and passes the file directly to kernel.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> [2]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/
> [3]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985
> [4]: https://github.com/pfliu/kexec-tools.git branch: kexec_uefi_emulator
>
>
> RFCv1 -> RFCv2:
> -1.Support to run UKI kernel by: add LoadImage() and StartImage(), add
>    PE file relocation support, add InstallMultiProtocol()
> -2.Also set up idmap for EFI runtime memory descriptor since UKI's
>    systemd-stub calls runtime service
> -3.Move kexec_pe_image.c from arch/arm64/kernel to kernel/, since it
>    aims to provide a more general architecture support.
>
> RFCv1: https://lore.kernel.org/linux-efi/20240718085759.13247-1-piliu@redhat.com/
> RFCv2: https://github.com/pfliu/linux.git  branch kexec_uefi_emulator_RFCv2
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
>
>
> Pingfan Liu (9):
>   efi/libstub: Ask efi_random_alloc() to skip unusable memory
>   efi/libstub: Complete efi_simple_text_output_protocol
>   efi/emulator: Initial rountines to emulate EFI boot time service
>   efi/emulator: Turn on mmu for arm64
>   kexec: Introduce kexec_pe_image to parse and load PE file
>   arm64: kexec: Introduce a new member param_mem to kimage_arch
>   arm64: mm: Change to prototype of
>   arm64: kexec: Prepare page table for emulator
>   arm64: kexec: Enable kexec_pe_image
>

Thanks for putting this RFC together. This is useful work, and gives
us food for thought and discussion.

There are a few problems that become apparent when going through these changes.

1. Implementing UEFI entirely is intractable, and unnecessary.
Implementing the subset of UEFI that is actually needed to boot Linux
*is* tractable, though, but we need to work together to write this
down somewhere.
  - the EFI stub needs the boot services for the EFI memory map and
the allocation routines
  - GRUB needs block I/O
  - systemd-stub/UKI needs file I/O to look for sidecars
  - etc etc

I implemented a Rust 'efiloader' crate a while ago that encapsulates
most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
user space **). Adding file I/O to this should be straight-forward -
as Lennart points out, we only need the protocol, it doesn't need to
be backed by an actual file system, it just needs to be able to expose
other files in the right way.

2. Running the UEFI emulator on bare metal is not going to scale.
Cloning UART driver code and MMU code etc is a can of worms that you
want to leave closed. And as Lennart points out, there is other
hardware (TPM) that needs to be accessible as well. Providing a
separate set of drivers for all hardware that the EFI emulator may
need to access is not a tractable problem either.

The fix for this, as I see it, is to run the EFI emulator in user
space, to the point where the payload calls ExitBootServices(). This
will allow all I/O and memory protocol to be implemented trivially,
using C library routines. I have a crude prototype** of this running
to the point where ExitBootServices() is called (and then it crashes).
The tricky yet interesting bit here is how we migrate a chunk of user
space memory to the bare metal context that will be created by the
kexec syscall later (in which the call to ExitBootServices() would
return and proceed with the boot). But the principle is rather
straight-forward, and would permit us, e.g., to kexec an OS installer
too.

3. We need to figure out how to support TPM and PCRs in the context of
kexec. This is a fundamental issue with verified boot, given that the
kexec PCR state is necessarily different from the boot state, and so
we cannot reuse the TPM directly if we want to pretend that we are
doing an ordinary boot in kexec. The alternative is to leave the TPM
in a state where the kexec kernel can access its sealed secrets, and
mock up the TCG2 EFI protocols using a shim that sits between the TPM
hardware (as the real TCG2 protocols will be long gone) and the EFI
payload. But as I said, this is a fundamental issue, as the ability to
pretend that a kexec boot is a pristine boot would mean that verified
boot is broken.


As future work, I'd like to propose to collaborate on some alignment
regarding a UEFI baseline for Linux, i.e., the parts that we actually
need to boot Linux.

For this series in particular, I don't see a way forward where we
adopt this approach, and carry all this code inside the kernel.

Thanks.
Ard.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
