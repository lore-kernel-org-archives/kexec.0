Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837D8C25B75
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ANu5Av5C7pZseUE1vzMFuHkgX6G1ORk1eCoo5NU40jU=; b=Apim21Wv16WP9t
	+KX2UFd7rKZWEwtLGbwFJVATYTAezGsJvEcNRy9T/1PFiD1onQ9Hf+vKHbsqTR9tEEkSyQ+O6xR1x
	LL/eQAb3y1BBKA1NBFCkaLJ7AEOI8LuxbVtCk4O1fIc9FtEWiywwQAjXFNS3gOsKSWiMN13DfEPjA
	mYDZz5cDs5AWi6+qAe+L6YS0EC9VU/C9gR3JaAoRP9RqcAf1JzYIzFIKKBpWtucO3XeSxuw/8gjNh
	1R56bzHpzFB6fPJZ8dUuJaRO4BNEiXDh41AO3eLitlw0Gr9NXfnDJtlbuBpB9Zb5dKG+r9Libo7CF
	fX/UQg6ZUi8saUF/AvNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2rw-0000000ARUz-41PV;
	Fri, 31 May 2024 14:04:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2rs-0000000ARTN-3dSJ
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 14:04:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 18CE662CD6
	for <kexec@lists.infradead.org>; Fri, 31 May 2024 14:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FACFC4AF19
	for <kexec@lists.infradead.org>; Fri, 31 May 2024 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164267;
	bh=9KO90g1YRgzZkliYyKsRBxOej6caKIqECjM2eDwUb/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aJfP1ZyaZKB5UPBrL5Zs8M1idbCa5z6trvJLzLiHd38YEC88tnn5kClEcrt1s0rRu
	 UTIQXRoSSi6OzgNRZz1MjolNiQlZ9J8viwdRT7OywI6K6w/S49m0V8zizpBpRtKlWx
	 /g7fqYviHjGnvgaFzvJm5vvwcaZA4KC9ikicKjCCqk6QO6ONUPa4UQgsTEGVwRbtYF
	 F9x0amC7EYi9UvC0yRTGTdRpCfWpdDcmO+e4ZAtS59RkpQWuk/g6ESo6oOAFO/aHNc
	 UjBqSnXFWCW7H4MkFxHVYhv6EM2+q+xVS0TJGzsOfNLNjvx//99bg8XFjMjzPVCASN
	 I0+VsG3aHDcgg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so11221791fa.1
        for <kexec@lists.infradead.org>; Fri, 31 May 2024 07:04:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4z+oiSQktWuSYyZYeKSNUzYinZL8doE6DZgqeSLTRJMPctYgGu3eZKEpVXn8kbSle6hmSdPwJE3XjJZ39y4AM7mWNfd1FSjFf
X-Gm-Message-State: AOJu0Yzo1Tp1BdUZNp8VIxqfWiDgAAFsmR3ARLSgcHlgDjkf1QAHkHpO
	zfLXDzNX2j1Td6ercLZ9SwAzSyyHjW2ty/nsRpYCsWhIygtXtxceqEebu2VsgW0IwYmtzMWZxNE
	xumV9Yf+gW5QqSyC8FpC2ClHD8vo=
X-Google-Smtp-Source: AGHT+IFbP7OVn0ZNiY1Sts+anVAaa8RDVDPxkSqpiu2vgxx2AvOg9j2jGAYMn0LrlB2WLJt0hsrRkPoyyNw9Qy5thuo=
X-Received: by 2002:a2e:a7c5:0:b0:2e2:6dd9:dd8a with SMTP id
 38308e7fff4ca-2ea84b1a993mr18049101fa.0.1717164265060; Fri, 31 May 2024
 07:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com> <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
In-Reply-To: <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 May 2024 16:04:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
Message-ID: <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240531_070429_194804_CE10666A 
X-CRM114-Status: GOOD (  48.56  )
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

On Fri, 31 May 2024 at 15:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Ross,
> >
> > On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> > >
> > > The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> > > later AMD SKINIT) to vector to during the late launch. The symbol
> > > sl_stub_entry is that entry point and its offset into the kernel is
> > > conveyed to the launching code using the MLE (Measured Launch
> > > Environment) header in the structure named mle_header. The offset of the
> > > MLE header is set in the kernel_info. The routine sl_stub contains the
> > > very early late launch setup code responsible for setting up the basic
> > > environment to allow the normal kernel startup_32 code to proceed. It is
> > > also responsible for properly waking and handling the APs on Intel
> > > platforms. The routine sl_main which runs after entering 64b mode is
> > > responsible for measuring configuration and module information before
> > > it is used like the boot params, the kernel command line, the TXT heap,
> > > an external initramfs, etc.
> > >
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > ---
> > >  Documentation/arch/x86/boot.rst        |  21 +
> > >  arch/x86/boot/compressed/Makefile      |   3 +-
> > >  arch/x86/boot/compressed/head_64.S     |  30 +
> > >  arch/x86/boot/compressed/kernel_info.S |  34 ++
> > >  arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
> > >  arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
> > >  arch/x86/include/asm/msr-index.h       |   5 +
> > >  arch/x86/include/uapi/asm/bootparam.h  |   1 +
> > >  arch/x86/kernel/asm-offsets.c          |  20 +
> > >  9 files changed, 1415 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/x86/boot/compressed/sl_main.c
> > >  create mode 100644 arch/x86/boot/compressed/sl_stub.S
> > >
> > > diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> > > index 4fd492cb4970..295cdf9bcbdb 100644
> > > --- a/Documentation/arch/x86/boot.rst
> > > +++ b/Documentation/arch/x86/boot.rst
> > > @@ -482,6 +482,14 @@ Protocol:  2.00+
> > >             - If 1, KASLR enabled.
> > >             - If 0, KASLR disabled.
> > >
> > > +  Bit 2 (kernel internal): SLAUNCH_FLAG
> > > +
> > > +       - Used internally by the setup kernel to communicate
> > > +         Secure Launch status to kernel proper.
> > > +
> > > +           - If 1, Secure Launch enabled.
> > > +           - If 0, Secure Launch disabled.
> > > +
> > >    Bit 5 (write): QUIET_FLAG
> > >
> > >         - If 0, print early messages.
> > > @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
> > >
> > >    This field contains maximal allowed type for setup_data and setup_indirect structs.
> > >
> > > +============   =================
> > > +Field name:    mle_header_offset
> > > +Offset/size:   0x0010/4
> > > +============   =================
> > > +
> > > +  This field contains the offset to the Secure Launch Measured Launch Environment
> > > +  (MLE) header. This offset is used to locate information needed during a secure
> > > +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> > > +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> > > +  following a success measured launch. The specific state of the processors is
> > > +  outlined in the TXT Software Development Guide, the latest can be found here:
> > > +  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> > > +
> > >
> >
> > Could we just repaint this field as the offset relative to the start
> > of kernel_info rather than relative to the start of the image? That
> > way, there is no need for patch #1, and given that the consumer of
> > this field accesses it via kernel_info, I wouldn't expect any issues
> > in applying this offset to obtain the actual address.
> >
> >
> > >  The Image Checksum
> > >  ==================
> > > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > > index 9189a0e28686..9076a248d4b4 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> > >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> > >  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > >
> > > -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> > > +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> > > +       $(obj)/sl_main.o $(obj)/sl_stub.o
> > >
> > >  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> > >         $(call if_changed,ld)
> > > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > > index 1dcb794c5479..803c9e2e6d85 100644
> > > --- a/arch/x86/boot/compressed/head_64.S
> > > +++ b/arch/x86/boot/compressed/head_64.S
> > > @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
> > >         pushq   $0
> > >         popfq
> > >
> > > +#ifdef CONFIG_SECURE_LAUNCH
> > > +       /* Ensure the relocation region is coverd by a PMR */
> >
> > covered
> >
> > > +       movq    %rbx, %rdi
> > > +       movl    $(_bss - startup_32), %esi
> > > +       callq   sl_check_region
> > > +#endif
> > > +
> > >  /*
> > >   * Copy the compressed kernel to the end of our buffer
> > >   * where decompression in place becomes safe.
> > > @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> > >         shrq    $3, %rcx
> > >         rep     stosq
> > >
> > > +#ifdef CONFIG_SECURE_LAUNCH
> > > +       /*
> > > +        * Have to do the final early sl stub work in 64b area.
> > > +        *
> > > +        * *********** NOTE ***********
> > > +        *
> > > +        * Several boot params get used before we get a chance to measure
> > > +        * them in this call. This is a known issue and we currently don't
> > > +        * have a solution. The scratch field doesn't matter. There is no
> > > +        * obvious way to do anything about the use of kernel_alignment or
> > > +        * init_size though these seem low risk with all the PMR and overlap
> > > +        * checks in place.
> > > +        */
> > > +       movq    %r15, %rdi
> > > +       callq   sl_main
> > > +
> > > +       /* Ensure the decompression location is covered by a PMR */
> > > +       movq    %rbp, %rdi
> > > +       movq    output_len(%rip), %rsi
> > > +       callq   sl_check_region
> > > +#endif
> > > +
> > > +       pushq   %rsi
> >
> > This looks like a rebase error.
> >
> > >         call    load_stage2_idt
> > >
> > >         /* Pass boot_params to initialize_identity_maps() */
> > > diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> > > index c18f07181dd5..e199b87764e9 100644
> > > --- a/arch/x86/boot/compressed/kernel_info.S
> > > +++ b/arch/x86/boot/compressed/kernel_info.S
> > > @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
> > >         /* Maximal allowed type for setup_data and setup_indirect structs. */
> > >         .long   SETUP_TYPE_MAX
> > >
> > > +       /* Offset to the MLE header structure */
> > > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > > +       .long   rva(mle_header)
> >
> > ... so this could just be mle_header - kernel_info, and the consumer
> > can do the math instead.
> >
> > > +#else
> > > +       .long   0
> > > +#endif
> > > +
> > >  kernel_info_var_len_data:
> > >         /* Empty for time being... */
> > >  SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > > +       /*
> > > +        * The MLE Header per the TXT Specification, section 2.1
> > > +        * MLE capabilities, see table 4. Capabilities set:
> > > +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> > > +        * bit 1: Support for RLP wakeup using MONITOR address
> > > +        * bit 2: The ECX register will contain the pointer to the MLE page table
> > > +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> > > +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> > > +        */
> > > +SYM_DATA_START(mle_header)
> > > +       .long   0x9082ac5a  /* UUID0 */
> > > +       .long   0x74a7476f  /* UUID1 */
> > > +       .long   0xa2555c0f  /* UUID2 */
> > > +       .long   0x42b651cb  /* UUID3 */
> > > +       .long   0x00000034  /* MLE header size */
> > > +       .long   0x00020002  /* MLE version 2.2 */
> > > +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
> >
> > and these should perhaps be relative to mle_header?
> >
> > > +       .long   0x00000000  /* First valid page of MLE */
> > > +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> > > +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
> >
> > and here
> >
>
> Ugh never mind - these are specified externally.

OK, so instead of patch #1, please use the linker script to generate
these constants.

I.e., add this to arch/x86/boot/compressed/vmlinux.lds.S

#ifdef CONFIG_SECURE_LAUNCH
PROVIDE(mle_header_offset       = mle_header - startup_32);
PROVIDE(sl_stub_entry_offset    = sl_stub_entry - startup_32);
PROVIDE(_edata_offset           = _edata - startup_32);
#endif

and use the symbols on the left hand side in the code.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
