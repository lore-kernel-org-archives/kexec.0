Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWalY-0000Hb-7b
 for kexec@lists.infradead.org; Tue, 11 Dec 2018 05:39:37 +0000
Received: by mail-pg1-x543.google.com with SMTP id w6so6111801pgl.6
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2018 21:39:21 -0800 (PST)
Date: Tue, 11 Dec 2018 14:42:33 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20181211054231.GD21466@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-16-takahiro.akashi@linaro.org>
 <20181130132113.GE9000@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130132113.GE9000@arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Fri, Nov 30, 2018 at 01:21:14PM +0000, Will Deacon wrote:
> On Thu, Nov 15, 2018 at 02:52:54PM +0900, AKASHI Takahiro wrote:
> > With this patch, kernel verification can be done without IMA security
> > subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> > 
> > On x86, a signature is embedded into a PE file (Microsoft's format) header
> > of binary. Since arm64's "Image" can also be seen as a PE file as far as
> > CONFIG_EFI is enabled, we adopt this format for kernel signing.
> > 
> > You can create a signed kernel image with:
> >     $ sbsign --key ${KEY} --cert ${CERT} Image
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
> >  arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 93dc4d36d6db..11f3e1a00588 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -867,6 +867,30 @@ config KEXEC_FILE
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
> > +comment "Support for PE file signature verification disabled"
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> > +
> >  config CRASH_DUMP
> >  	bool "Build kdump crash kernel"
> >  	help
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > index 9f0d8b5d62d3..d1c6c54c22e3 100644
> > --- a/arch/arm64/kernel/kexec_image.c
> > +++ b/arch/arm64/kernel/kexec_image.c
> > @@ -12,7 +12,9 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kexec.h>
> > +#include <linux/pe.h>
> >  #include <linux/string.h>
> > +#include <linux/verification.h>
> >  #include <asm/byteorder.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/image.h>
> > @@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> >  				sizeof(h->magic)))
> >  		return -EINVAL;
> >  
> > +	pr_debug("PE format: %s\n",
> > +			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
> > +							"no" : "yes");
> > 
> 
> Is this hunk really necessary? I'd prefer not to commit pr_debug()
> invocations.

This line comes from kexec-tools' code, but I don't mind removing it.
(as lots of lines diverge now from kexec-tools.)

-Takahiro Akashi


> Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
