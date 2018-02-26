Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqFxL-000148-UE
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 10:24:31 +0000
Received: by mail-io0-x242.google.com with SMTP id e30so6159864ioc.3
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 02:24:16 -0800 (PST)
Date: Mon, 26 Feb 2018 19:24:19 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v8 02/13] kexec_file: make an use of purgatory optional
Message-ID: <20180226102418.GD6019@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-3-takahiro.akashi@linaro.org>
 <20180223084934.GB4433@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180223084934.GB4433@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On Fri, Feb 23, 2018 at 04:49:34PM +0800, Dave Young wrote:
> Hi AKASHI,
> 
> On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > On arm64, no trampline code between old kernel and new kernel will be
> > required in kexec_file implementation. This patch introduces a new
> > configuration, ARCH_HAS_KEXEC_PURGATORY, and allows related code to be
> > compiled in only if necessary.
> 
> Here also need the explanation about why no purgatory is needed, it would be
> required for kexec if no strong reason.

OK, I will add the reason:
On arm64, crash dump kernel's usable memory is protected by
*unmapping* it from kernel virtual space unlike other architectures
where the region is just made read-only.
So our key developers think that it is highly unlikely that the region
is accidentally corrupted and this rationalizes that digest check code
be also dropped from purgatory.
This greatly simplifies our purgatory without any need for a bit ugly
relocation stuff, i.e. arch_kexec_apply_relocations_add().

Please see:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
to find out how simple our purgatory was. All that it does is
to shuffle arguments and jump into a new kernel.

Without this patch, we would have to have purgatory with a space for
a hash value (purgatory_sha256_digest) which is never checked against.

Do you think it makes sense?

Thanks,
-Takahiro AKASHI


> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/powerpc/Kconfig | 3 +++
> >  arch/x86/Kconfig     | 3 +++
> >  kernel/kexec_file.c  | 6 ++++++
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 73ce5dd07642..c32a181a7cbb 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -552,6 +552,9 @@ config KEXEC_FILE
> >  	  for kernel and initramfs as opposed to a list of segments as is the
> >  	  case for the older kexec call.
> >  
> > +config ARCH_HAS_KEXEC_PURGATORY
> > +	def_bool KEXEC_FILE
> > +
> >  config RELOCATABLE
> >  	bool "Build a relocatable kernel"
> >  	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c1236b187824..f031c3efe47e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2019,6 +2019,9 @@ config KEXEC_FILE
> >  	  for kernel and initramfs as opposed to list of segments as
> >  	  accepted by previous system call.
> >  
> > +config ARCH_HAS_KEXEC_PURGATORY
> > +	def_bool KEXEC_FILE
> > +
> >  config KEXEC_VERIFY_SIG
> >  	bool "Verify kernel signature during kexec_file_load() syscall"
> >  	depends on KEXEC_FILE
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index e5bcd94c1efb..990adae52151 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -26,7 +26,11 @@
> >  #include <linux/vmalloc.h>
> >  #include "kexec_internal.h"
> >  
> > +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >  static int kexec_calculate_store_digests(struct kimage *image);
> > +#else
> > +static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> > +#endif
> >  
> >  /* Architectures can provide this probe function */
> >  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > @@ -520,6 +524,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >  /* Calculate and store the digest of segments */
> >  static int kexec_calculate_store_digests(struct kimage *image)
> >  {
> > @@ -1022,3 +1027,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
> >  
> >  	return 0;
> >  }
> > +#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> > -- 
> > 2.16.2
> > 
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
