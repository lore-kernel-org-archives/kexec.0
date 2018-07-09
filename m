Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fcS1z-0003dL-0P
 for kexec@lists.infradead.org; Mon, 09 Jul 2018 09:00:32 +0000
Received: by mail-pf0-x241.google.com with SMTP id y8-v6so13208051pfm.10
 for <kexec@lists.infradead.org>; Mon, 09 Jul 2018 02:00:16 -0700 (PDT)
Date: Mon, 9 Jul 2018 18:01:34 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v10 13/14] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20180709090133.GU28220@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-14-takahiro.akashi@linaro.org>
 <ff77f2d9-82c6-8fbb-3696-e1fcfd61c333@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff77f2d9-82c6-8fbb-3696-e1fcfd61c333@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Tue, Jul 03, 2018 at 06:47:38PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > With this patch, kernel verification can be done without IMA security
> > subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> > 
> > On x86, a signature is embedded into a PE file (Microsoft's format) header
> > of binary. Since arm64's "Image" can also be seen as a PE file as far as
> > CONFIG_EFI is enabled, we adopt this format for kernel signing.
> > 
> > You can create a signed kernel image with:
> >     $ sbsign --key ${KEY} --cert ${CERT} Image
> 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index f68318f61c85..5133c22a01ab 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -845,6 +845,30 @@ config KEXEC_FILE
> >  	  for kernel and initramfs as opposed to list of segments as
> >  	  accepted by previous system call.
> >  
> > +config KEXEC_VERIFY_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE
> > +	help
> > +	  Select this option to verify a signature with loaded kernel
> > +	  image. If configured, any attempt of loading a image without
> > +	  valid signature will fail.
> > +
> > +	  In addition to that option, you need to enable signature
> > +	  verification for the corresponding kernel image type being
> > +	  loaded in order for this to work.
> > +
> > +config KEXEC_IMAGE_VERIFY_SIG
> > +	bool "Enable Image signature verification support"
> > +	default y
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> > +	help
> > +	  Enable Image signature verification support.
> > +
> > +comment "Image signature verification is missing yet"
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> 
> 
> This comment thing is a good idea, but its also a bit confusing... it took me
> quite a while to work out what was missing. Could we phrase it something like:
> "Support for PE file signature verification disabled!"

OK.

> This tells us its about PE files, and its probably a missing config option
> somewhere, not some code that hasn't been written yet. (which was my first
> assumption!).
> 
> KEXEC_VERIFY_SIG presumably turns on just the IMA verification, which verifies
> the Image, but not in the same way as KEXEC_IMAGE_VERIFY_SIG.... (if I've
> understood it properly)

I'm afraid that I'm not clear at the cover letter.
Those two mechanisms, IMA verification and kexec-specific verification,
are totally different. The former is relatively new as well as generic,
and doesn't even require KEXEC_VERIFY_SIG at all as all the stuff is done
under IMA framework (via security hooks) with extended file attributes.

On the other hand, KEXEC_VERIFY_SIG is just an option that turns on
verification check in a kexec-specific (and more importantly arch-specific
and file-format-specific) manner through 'kexec_file_ops->verify interface.'

> Is there any reason to have these as separate enables?

If you are talking about KEXEC_VERIFY_SIG and KEXEC_IMAGE_VERIFY_SIG,
it is a leftover when "vmlinux" image was also supported in my
old versions of kexec_file patch set.
But please note that x86 also retains two separate configuration options,
KEXEC_VERIFY_SIG and KEXEC_BZIMAGE_VERIFY_SIG.
I simply followed that.

> Couldn't we 'select SIGNED_PE_FILE_VERIFICATION if EFI' in KEXEC_VERIFY_SIG?

I didn't "select" SIGNED_PE_FILE_VERIFICATION here following
"kbuild/kconfig-language.txt" which suggests, "use select only for
non-visible symbols (no prompts anywhere)."

> This would mean there is one option to verify signatures, instead of two...
> (does it really depend on EFI?)

Strictly speaking, SIGNED_PE_FILE_VERIFICATION depends on the fact
that a binary file is in PE format, which means that EFI is enabled
on arm64.
It is possible to support KEXEC_VERIFY_SIG for non-PE binaries, but
in that case, we will have to invent a new (arm64-specific) way of
verification.
(For instance, we might want to add a kexec-specific ELF segment to vmlinux.)

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
