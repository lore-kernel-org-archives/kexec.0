Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AF8C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gxahtXmGQfsOkcxLNMre8/jy8K6Ny97nuyg7rMT94yc=; b=uAb0ABEEdV3Jxt
	kha5r6tsW7H8qhpkWEUmziv7jrCIKrrZ79AIweQtWN224cjENeXF4GbAY6mk6oD37CA/HS5Y4b+UC
	76idIGcVks9CH96wz3LuInIW7hlF53ZA7JZ0x5i4L6Y3PjOWYl1xD8e6AeQBvliUpvlxoFR+eGwwR
	bxVAJHoqYh/u1I+5RIiIBeY/25qcbh9vv3Ed3sta1XrM+Wja9Ss4bZw0zIcdg2m3UMFhrC9pqIuYM
	7ZoBualdlSh20lFdgiwMA7hJdpX6jX/YlmLcUJE1HROtW1PJTO7XGXUHCOxBUMkisUpvTS5P6uCaV
	ktv29dxNZplc5oC41nIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbBJ-00000003lYq-2shr;
	Tue, 04 Jun 2024 20:54:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbBG-00000003lYA-2KKz
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:54:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C017614F4
	for <kexec@lists.infradead.org>; Tue,  4 Jun 2024 20:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFFC4AF15
	for <kexec@lists.infradead.org>; Tue,  4 Jun 2024 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534492;
	bh=jOW+1OdDSCmwWCebegpjQkPqvOoqBmesdA2lp4CRyvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHj/eJs6FDv+FP8Pp+EwPfjeHNiYP6KKDBJAPsvRfBDXawsFtjsLQDvVGbc96Rjcb
	 GR1d0d0orzMjAq+uk/3hWZkJxOeHMUBFxmyrD/u23Y4SUor4lC64HH2ErRSBpKyQzC
	 mQ1+WvazSBhmn6AL1cLr8gnHHZPVPksRplG8/8E8s2bgf21W8Tq6AUZ8B+xH5aYytz
	 QkaHnOrQbx3q87D6AJtJfDoOnZAU7T8Qc2XbqNu0I8rzVKBXpjyI9LQrcOuEvdpoUu
	 VIV4Ka7CtYk66kVcm7x32YUGa5dnhurvI73M0VDYZEDxWS1rWgrWA6E3dnQGa/ScJA
	 vTDmVdalAYgoQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so47656051fa.1
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 13:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeRIbe1NvlgS5RCUqDG6x7fCpJqNrIUBbNskS28vvpE8QyY6kY5VAtk4EPwPJhINdxAQdLdt8k7V8YCO9KIgotP9JwfjD8twO+
X-Gm-Message-State: AOJu0YzLhKLtURhBKiuUXUcBYtOJN2reIY6zl0VVxXaJ6dHNGjDQV+WX
	70e+WO8RB4GaUkrD4StjZPtGQaJ4Asp1Uk+MOjpSjOOQnsGuJwqeT7KP6hxeYKUfhj4mLFoNg4k
	dQtuFQi6PvbLsYJI2g65VWKJx7l4=
X-Google-Smtp-Source: AGHT+IHJDS7RbesWDkwWk7Ew2fQrx3H0XBYwx+Z4jx1MSnR1LYyQbaYNK9w0BYZBfeO823xz4XgpKZDKbAn9kgetWNo=
X-Received: by 2002:a2e:a7c9:0:b0:2e9:756f:cde0 with SMTP id
 38308e7fff4ca-2eac79ed71fmr2534751fa.23.1717534490810; Tue, 04 Jun 2024
 13:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com> <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
 <5bffa507-75e8-4cce-ac0c-fe13d6efd3bb@oracle.com> <CAMj1kXHLaqyPAw5Jjg91pqFbHoMT2jDqui4rosyerHVudRsq-w@mail.gmail.com>
 <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
In-Reply-To: <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Jun 2024 22:54:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Message-ID: <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_135454_730568_29CDA5B8 
X-CRM114-Status: GOOD (  48.32  )
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

On Tue, 4 Jun 2024 at 19:34, <ross.philipson@oracle.com> wrote:
>
> On 6/4/24 10:27 AM, Ard Biesheuvel wrote:
> > On Tue, 4 Jun 2024 at 19:24, <ross.philipson@oracle.com> wrote:
> >>
> >> On 5/31/24 6:33 AM, Ard Biesheuvel wrote:
> >>> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>
> >>>> Hello Ross,
> >>>>
> >>>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>>>>
> >>>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> >>>>> later AMD SKINIT) to vector to during the late launch. The symbol
> >>>>> sl_stub_entry is that entry point and its offset into the kernel is
> >>>>> conveyed to the launching code using the MLE (Measured Launch
> >>>>> Environment) header in the structure named mle_header. The offset of the
> >>>>> MLE header is set in the kernel_info. The routine sl_stub contains the
> >>>>> very early late launch setup code responsible for setting up the basic
> >>>>> environment to allow the normal kernel startup_32 code to proceed. It is
> >>>>> also responsible for properly waking and handling the APs on Intel
> >>>>> platforms. The routine sl_main which runs after entering 64b mode is
> >>>>> responsible for measuring configuration and module information before
> >>>>> it is used like the boot params, the kernel command line, the TXT heap,
> >>>>> an external initramfs, etc.
> >>>>>
> >>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>>> ---
> >>>>>    Documentation/arch/x86/boot.rst        |  21 +
> >>>>>    arch/x86/boot/compressed/Makefile      |   3 +-
> >>>>>    arch/x86/boot/compressed/head_64.S     |  30 +
> >>>>>    arch/x86/boot/compressed/kernel_info.S |  34 ++
> >>>>>    arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
> >>>>>    arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
> >>>>>    arch/x86/include/asm/msr-index.h       |   5 +
> >>>>>    arch/x86/include/uapi/asm/bootparam.h  |   1 +
> >>>>>    arch/x86/kernel/asm-offsets.c          |  20 +
> >>>>>    9 files changed, 1415 insertions(+), 1 deletion(-)
> >>>>>    create mode 100644 arch/x86/boot/compressed/sl_main.c
> >>>>>    create mode 100644 arch/x86/boot/compressed/sl_stub.S
> >>>>>
> >>>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> >>>>> index 4fd492cb4970..295cdf9bcbdb 100644
> >>>>> --- a/Documentation/arch/x86/boot.rst
> >>>>> +++ b/Documentation/arch/x86/boot.rst
> >>>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
> >>>>>               - If 1, KASLR enabled.
> >>>>>               - If 0, KASLR disabled.
> >>>>>
> >>>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
> >>>>> +
> >>>>> +       - Used internally by the setup kernel to communicate
> >>>>> +         Secure Launch status to kernel proper.
> >>>>> +
> >>>>> +           - If 1, Secure Launch enabled.
> >>>>> +           - If 0, Secure Launch disabled.
> >>>>> +
> >>>>>      Bit 5 (write): QUIET_FLAG
> >>>>>
> >>>>>           - If 0, print early messages.
> >>>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
> >>>>>
> >>>>>      This field contains maximal allowed type for setup_data and setup_indirect structs.
> >>>>>
> >>>>> +============   =================
> >>>>> +Field name:    mle_header_offset
> >>>>> +Offset/size:   0x0010/4
> >>>>> +============   =================
> >>>>> +
> >>>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
> >>>>> +  (MLE) header. This offset is used to locate information needed during a secure
> >>>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> >>>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> >>>>> +  following a success measured launch. The specific state of the processors is
> >>>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
> >>>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!Mng0gnPhOYZ8D02t1rYwQfY6U3uWaypJyd1T2rsWz3QNHr9GhIZ9ANB_-cgPExxX0e0KmCpda-3VX8Fj$
> >>>>> +
> >>>>>
> >>>>
> >>>> Could we just repaint this field as the offset relative to the start
> >>>> of kernel_info rather than relative to the start of the image? That
> >>>> way, there is no need for patch #1, and given that the consumer of
> >>>> this field accesses it via kernel_info, I wouldn't expect any issues
> >>>> in applying this offset to obtain the actual address.
> >>>>
> >>>>
> >>>>>    The Image Checksum
> >>>>>    ==================
> >>>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >>>>> index 9189a0e28686..9076a248d4b4 100644
> >>>>> --- a/arch/x86/boot/compressed/Makefile
> >>>>> +++ b/arch/x86/boot/compressed/Makefile
> >>>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >>>>>    vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> >>>>>    vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >>>>>
> >>>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> >>>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> >>>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
> >>>>>
> >>>>>    $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> >>>>>           $(call if_changed,ld)
> >>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> >>>>> index 1dcb794c5479..803c9e2e6d85 100644
> >>>>> --- a/arch/x86/boot/compressed/head_64.S
> >>>>> +++ b/arch/x86/boot/compressed/head_64.S
> >>>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
> >>>>>           pushq   $0
> >>>>>           popfq
> >>>>>
> >>>>> +#ifdef CONFIG_SECURE_LAUNCH
> >>>>> +       /* Ensure the relocation region is coverd by a PMR */
> >>>>
> >>>> covered
> >>>>
> >>>>> +       movq    %rbx, %rdi
> >>>>> +       movl    $(_bss - startup_32), %esi
> >>>>> +       callq   sl_check_region
> >>>>> +#endif
> >>>>> +
> >>>>>    /*
> >>>>>     * Copy the compressed kernel to the end of our buffer
> >>>>>     * where decompression in place becomes safe.
> >>>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >>>>>           shrq    $3, %rcx
> >>>>>           rep     stosq
> >>>>>
> >>>>> +#ifdef CONFIG_SECURE_LAUNCH
> >>>>> +       /*
> >>>>> +        * Have to do the final early sl stub work in 64b area.
> >>>>> +        *
> >>>>> +        * *********** NOTE ***********
> >>>>> +        *
> >>>>> +        * Several boot params get used before we get a chance to measure
> >>>>> +        * them in this call. This is a known issue and we currently don't
> >>>>> +        * have a solution. The scratch field doesn't matter. There is no
> >>>>> +        * obvious way to do anything about the use of kernel_alignment or
> >>>>> +        * init_size though these seem low risk with all the PMR and overlap
> >>>>> +        * checks in place.
> >>>>> +        */
> >>>>> +       movq    %r15, %rdi
> >>>>> +       callq   sl_main
> >>>>> +
> >>>>> +       /* Ensure the decompression location is covered by a PMR */
> >>>>> +       movq    %rbp, %rdi
> >>>>> +       movq    output_len(%rip), %rsi
> >>>>> +       callq   sl_check_region
> >>>>> +#endif
> >>>>> +
> >>>>> +       pushq   %rsi
> >>>>
> >>>> This looks like a rebase error.
> >>>>
> >>>>>           call    load_stage2_idt
> >>>>>
> >>>>>           /* Pass boot_params to initialize_identity_maps() */
> >>>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> >>>>> index c18f07181dd5..e199b87764e9 100644
> >>>>> --- a/arch/x86/boot/compressed/kernel_info.S
> >>>>> +++ b/arch/x86/boot/compressed/kernel_info.S
> >>>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
> >>>>>           /* Maximal allowed type for setup_data and setup_indirect structs. */
> >>>>>           .long   SETUP_TYPE_MAX
> >>>>>
> >>>>> +       /* Offset to the MLE header structure */
> >>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> >>>>> +       .long   rva(mle_header)
> >>>>
> >>>> ... so this could just be mle_header - kernel_info, and the consumer
> >>>> can do the math instead.
> >>>>
> >>>>> +#else
> >>>>> +       .long   0
> >>>>> +#endif
> >>>>> +
> >>>>>    kernel_info_var_len_data:
> >>>>>           /* Empty for time being... */
> >>>>>    SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> >>>>> +
> >>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> >>>>> +       /*
> >>>>> +        * The MLE Header per the TXT Specification, section 2.1
> >>>>> +        * MLE capabilities, see table 4. Capabilities set:
> >>>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> >>>>> +        * bit 1: Support for RLP wakeup using MONITOR address
> >>>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
> >>>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> >>>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> >>>>> +        */
> >>>>> +SYM_DATA_START(mle_header)
> >>>>> +       .long   0x9082ac5a  /* UUID0 */
> >>>>> +       .long   0x74a7476f  /* UUID1 */
> >>>>> +       .long   0xa2555c0f  /* UUID2 */
> >>>>> +       .long   0x42b651cb  /* UUID3 */
> >>>>> +       .long   0x00000034  /* MLE header size */
> >>>>> +       .long   0x00020002  /* MLE version 2.2 */
> >>>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
> >>>>
> >>>> and these should perhaps be relative to mle_header?
> >>>>
> >>>>> +       .long   0x00000000  /* First valid page of MLE */
> >>>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> >>>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
> >>>>
> >>>> and here
> >>>>
> >>>
> >>> Ugh never mind - these are specified externally.
> >>
> >> Can you clarify your follow on comment here?
> >>
> >
> > I noticed that -as you pointed out in your previous reply- these
> > fields cannot be repainted at will, as they are defined by an external
> > specification.
> >
> > I'll play a bit more with this code tomorrow - I would *really* like
> > to avoid the need for patch #1, as it adds another constraint on how
> > we construct the boot image, and this is already riddled with legacy
> > and other complications.
>
> Yea I should have read forward through all your replies before
> responding to the first one but I think it clarified things as you point
> out here. We appreciate you help and suggestions.
>

OK, so I have a solution that does not require kernel_info at a fixed offset:

- put this at the end of arch/x86/boot/compressed/vmlinux.lds.S

#ifdef CONFIG_SECURE_LAUNCH
PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
PROVIDE(mle_header_offset       = kernel_info_offset +
ABSOLUTE(mle_header - startup_32));
PROVIDE(sl_stub_entry_offset    = kernel_info_offset +
ABSOLUTE(sl_stub_entry - startup_32));
PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata
- startup_32));
#endif


and use this for the header fields:

        /* Offset to the MLE header structure */
#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
        .long   mle_header_offset - kernel_info
#else
        .long   0
#endif



SYM_DATA_START(mle_header)
        .long   0x9082ac5a  /* UUID0 */
        .long   0x74a7476f  /* UUID1 */
        .long   0xa2555c0f  /* UUID2 */
        .long   0x42b651cb  /* UUID3 */
        .long   0x00000034  /* MLE header size */
        .long   0x00020002  /* MLE version 2.2 */
        .long   sl_stub_entry_offset - kernel_info /* Linear entry
point of MLE (virt. address) */
        .long   0x00000000  /* First valid page of MLE */
        .long   0x00000000  /* Offset within binary of first byte of MLE */
        .long   _edata_offset - kernel_info /* Offset within binary of
last byte + 1 of MLE */
        .long   0x00000227  /* Bit vector of MLE-supported capabilities */
        .long   0x00000000  /* Starting linear address of command line
(unused) */
        .long   0x00000000  /* Ending linear address of command line (unused) */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
