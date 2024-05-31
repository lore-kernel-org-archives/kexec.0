Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441D9C25B7E
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=428zxm4b7sDcqinAVtc73U//qJ8TYrw7jmX7kpzoreQ=; b=0w7HwG+ojq9SYx
	z8iJF5eaMRPQI3Iy/vv3YkkDHBnjP7Yzd5+vSqNaZ3rMMjYgEhF9Z9Kl0Z5WLEPVQ87E/oh/MWiKS
	lfalzNkz4fAkttCPR+fZyxCcNwE9bDcoKpeOaJn0/3BEd1smGUkLECrCzdWGSU4tUUndWGDZDcUt5
	IW5kmyWxXyIdSdK00V2ieRzW/bhlalQs9m2Bohm+KiPj5RjMN7ismiaR6Swa8ChwRrsiX/IAN89dO
	Z9BTfQM20Lv1W0Ouah9f31uzTzgClsE1Gky/hTJ/rp27L6FyDAw6ePkif5xuKJyqARE+OZbTnyXoC
	xpr29PK/OqqCd/3lQsOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2OR-0000000AM4y-2jBA;
	Fri, 31 May 2024 13:34:03 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2OM-0000000AM2s-2VUw
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 13:34:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CC95FCE1C62
	for <kexec@lists.infradead.org>; Fri, 31 May 2024 13:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67CFC32781
	for <kexec@lists.infradead.org>; Fri, 31 May 2024 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717162434;
	bh=RNo32SrIe3HmggtXYp5QRYuepbRArSiMzCD3RGnmxc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MZz/xjDZ96WgM7RyXP0SlgkmfENJG0BI+6V4Ek8IKIpDS8sGC/gOEAty1bmHtOx6O
	 9wAI2SJvYS69vplofuAvOyB4/1KVFvtGCbY+lpM2OpQmCc103Z0M9rYdRiZMfLUYCi
	 J668pWS5nvq/BewjlHeVjiYnQ7dfEE9Rrz/bLVSXvP3XFAjXhQnq0fUq20rFc1N0dg
	 rTDJa76XBPFXPvkHhMv3hHj50H+WYLGDM668cbCNE7T9QWli08aWKbd8TovzW1a8rs
	 kejAHHRs/uvx/A/Gthb6ELpYbAy3vHH0mZvtWFr/lKMnfj+I4RWMrN/Yk9KtoEzlv7
	 cQ9uJVKOSiGew==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so12785431fa.0
        for <kexec@lists.infradead.org>; Fri, 31 May 2024 06:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5x37flhwKTHQQPvehNLk1J/0OYSnMjkyTIr5JM+JwCQE0KbT3UYDqKT6ZEMIKn78fJECY2zarpMJ0Xr8cQIWiSJAxsU6ytt13
X-Gm-Message-State: AOJu0YxciKJsF9oY7HQ4TgYXnE2G08qmMTNpznj2ZLDnLZ9ABKs1DkBc
	V1zBSAV0NQm0y+MbaJoqodDqj6z2qxnFn5eBBsn4mhszld/Y3NDTiWZkNqhFWDaisn8RsTS3mdp
	feeCnagk7Z8Z1PlmSEFxp6IfB+q8=
X-Google-Smtp-Source: AGHT+IGlqK6NPM1u+Eyko2YTmOtbIDS7IcY/uRtynxr79vdeKHLi3qCI4AcIHpcHBsOx+R/wgFPEJHaZF4/iw6knwsM=
X-Received: by 2002:a2e:a983:0:b0:2ea:91e1:666f with SMTP id
 38308e7fff4ca-2ea950ef73dmr14989881fa.21.1717162433048; Fri, 31 May 2024
 06:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com> <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
In-Reply-To: <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 May 2024 15:33:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
Message-ID: <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: Ross Philipson <ross.philipson@oracle.com>
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
X-CRM114-CacheID: sfid-20240531_063359_949848_5DC9B957 
X-CRM114-Status: GOOD (  44.89  )
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

On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Ross,
>
> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> >
> > The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> > later AMD SKINIT) to vector to during the late launch. The symbol
> > sl_stub_entry is that entry point and its offset into the kernel is
> > conveyed to the launching code using the MLE (Measured Launch
> > Environment) header in the structure named mle_header. The offset of the
> > MLE header is set in the kernel_info. The routine sl_stub contains the
> > very early late launch setup code responsible for setting up the basic
> > environment to allow the normal kernel startup_32 code to proceed. It is
> > also responsible for properly waking and handling the APs on Intel
> > platforms. The routine sl_main which runs after entering 64b mode is
> > responsible for measuring configuration and module information before
> > it is used like the boot params, the kernel command line, the TXT heap,
> > an external initramfs, etc.
> >
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > ---
> >  Documentation/arch/x86/boot.rst        |  21 +
> >  arch/x86/boot/compressed/Makefile      |   3 +-
> >  arch/x86/boot/compressed/head_64.S     |  30 +
> >  arch/x86/boot/compressed/kernel_info.S |  34 ++
> >  arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
> >  arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
> >  arch/x86/include/asm/msr-index.h       |   5 +
> >  arch/x86/include/uapi/asm/bootparam.h  |   1 +
> >  arch/x86/kernel/asm-offsets.c          |  20 +
> >  9 files changed, 1415 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/x86/boot/compressed/sl_main.c
> >  create mode 100644 arch/x86/boot/compressed/sl_stub.S
> >
> > diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> > index 4fd492cb4970..295cdf9bcbdb 100644
> > --- a/Documentation/arch/x86/boot.rst
> > +++ b/Documentation/arch/x86/boot.rst
> > @@ -482,6 +482,14 @@ Protocol:  2.00+
> >             - If 1, KASLR enabled.
> >             - If 0, KASLR disabled.
> >
> > +  Bit 2 (kernel internal): SLAUNCH_FLAG
> > +
> > +       - Used internally by the setup kernel to communicate
> > +         Secure Launch status to kernel proper.
> > +
> > +           - If 1, Secure Launch enabled.
> > +           - If 0, Secure Launch disabled.
> > +
> >    Bit 5 (write): QUIET_FLAG
> >
> >         - If 0, print early messages.
> > @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
> >
> >    This field contains maximal allowed type for setup_data and setup_indirect structs.
> >
> > +============   =================
> > +Field name:    mle_header_offset
> > +Offset/size:   0x0010/4
> > +============   =================
> > +
> > +  This field contains the offset to the Secure Launch Measured Launch Environment
> > +  (MLE) header. This offset is used to locate information needed during a secure
> > +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> > +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> > +  following a success measured launch. The specific state of the processors is
> > +  outlined in the TXT Software Development Guide, the latest can be found here:
> > +  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> > +
> >
>
> Could we just repaint this field as the offset relative to the start
> of kernel_info rather than relative to the start of the image? That
> way, there is no need for patch #1, and given that the consumer of
> this field accesses it via kernel_info, I wouldn't expect any issues
> in applying this offset to obtain the actual address.
>
>
> >  The Image Checksum
> >  ==================
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 9189a0e28686..9076a248d4b4 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> >  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> > -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> > +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> > +       $(obj)/sl_main.o $(obj)/sl_stub.o
> >
> >  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> >         $(call if_changed,ld)
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 1dcb794c5479..803c9e2e6d85 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
> >         pushq   $0
> >         popfq
> >
> > +#ifdef CONFIG_SECURE_LAUNCH
> > +       /* Ensure the relocation region is coverd by a PMR */
>
> covered
>
> > +       movq    %rbx, %rdi
> > +       movl    $(_bss - startup_32), %esi
> > +       callq   sl_check_region
> > +#endif
> > +
> >  /*
> >   * Copy the compressed kernel to the end of our buffer
> >   * where decompression in place becomes safe.
> > @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >         shrq    $3, %rcx
> >         rep     stosq
> >
> > +#ifdef CONFIG_SECURE_LAUNCH
> > +       /*
> > +        * Have to do the final early sl stub work in 64b area.
> > +        *
> > +        * *********** NOTE ***********
> > +        *
> > +        * Several boot params get used before we get a chance to measure
> > +        * them in this call. This is a known issue and we currently don't
> > +        * have a solution. The scratch field doesn't matter. There is no
> > +        * obvious way to do anything about the use of kernel_alignment or
> > +        * init_size though these seem low risk with all the PMR and overlap
> > +        * checks in place.
> > +        */
> > +       movq    %r15, %rdi
> > +       callq   sl_main
> > +
> > +       /* Ensure the decompression location is covered by a PMR */
> > +       movq    %rbp, %rdi
> > +       movq    output_len(%rip), %rsi
> > +       callq   sl_check_region
> > +#endif
> > +
> > +       pushq   %rsi
>
> This looks like a rebase error.
>
> >         call    load_stage2_idt
> >
> >         /* Pass boot_params to initialize_identity_maps() */
> > diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> > index c18f07181dd5..e199b87764e9 100644
> > --- a/arch/x86/boot/compressed/kernel_info.S
> > +++ b/arch/x86/boot/compressed/kernel_info.S
> > @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
> >         /* Maximal allowed type for setup_data and setup_indirect structs. */
> >         .long   SETUP_TYPE_MAX
> >
> > +       /* Offset to the MLE header structure */
> > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > +       .long   rva(mle_header)
>
> ... so this could just be mle_header - kernel_info, and the consumer
> can do the math instead.
>
> > +#else
> > +       .long   0
> > +#endif
> > +
> >  kernel_info_var_len_data:
> >         /* Empty for time being... */
> >  SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> > +
> > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > +       /*
> > +        * The MLE Header per the TXT Specification, section 2.1
> > +        * MLE capabilities, see table 4. Capabilities set:
> > +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> > +        * bit 1: Support for RLP wakeup using MONITOR address
> > +        * bit 2: The ECX register will contain the pointer to the MLE page table
> > +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> > +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> > +        */
> > +SYM_DATA_START(mle_header)
> > +       .long   0x9082ac5a  /* UUID0 */
> > +       .long   0x74a7476f  /* UUID1 */
> > +       .long   0xa2555c0f  /* UUID2 */
> > +       .long   0x42b651cb  /* UUID3 */
> > +       .long   0x00000034  /* MLE header size */
> > +       .long   0x00020002  /* MLE version 2.2 */
> > +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
>
> and these should perhaps be relative to mle_header?
>
> > +       .long   0x00000000  /* First valid page of MLE */
> > +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> > +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
>
> and here
>

Ugh never mind - these are specified externally.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
