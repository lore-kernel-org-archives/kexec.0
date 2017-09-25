Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dwXvK-0004om-5R
 for kexec@lists.infradead.org; Mon, 25 Sep 2017 18:16:08 +0000
Received: by mail-pg0-x229.google.com with SMTP id 7so4428650pgd.13
 for <kexec@lists.infradead.org>; Mon, 25 Sep 2017 11:15:43 -0700 (PDT)
Date: Mon, 25 Sep 2017 11:15:30 -0700
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
Message-ID: <20170925181524.75sknpadahf5wcqa@dragonfly>
References: <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
 <20170922075807.GM17186@linaro.org>
 <20170925080313.GA5970@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170925080313.GA5970@dhcp-128-65.nay.redhat.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On Mon, Sep 25, 2017 at 04:03:13PM +0800, Dave Young wrote:
> HI AKASHI,
> On 09/22/17 at 04:58pm, AKASHI Takahiro wrote:
> > Hi Dave,
> > 
> [snip]
> 
> > > >  /*
> > > >   * Apply purgatory relocations.
> > > >   *
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index dd056fab9e35..4a2b24d94e04 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -134,6 +134,26 @@ struct kexec_file_ops {
> > > >  #endif
> > > >  };
> > > >  
> > > > +int kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > > +			     unsigned long buf_len);
> > > > +void *kexec_kernel_image_load(struct kimage *image);
> > > > +int kexec_kernel_post_load_cleanup(struct kimage *image);
> > > > +int kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > > +			    unsigned long buf_len);
> > > > +
> > > > +#ifndef arch_kexec_kernel_image_probe
> > > > +#define arch_kexec_kernel_image_probe kexec_kernel_image_probe
> > > > +#endif
> > > > +#ifndef arch_kexec_kernel_image_load
> > > > +#define arch_kexec_kernel_image_load kexec_kernel_image_load
> > > > +#endif
> > > > +#ifndef arch_kimage_file_post_load_cleanup
> > > > +#define arch_kimage_file_post_load_cleanup kexec_kernel_post_load_cleanup
> > > > +#endif
> > > > +#ifndef arch_kexec_kernel_verify_sig
> > > > +#define arch_kexec_kernel_verify_sig kexec_kernel_verify_sig
> > > > +#endif
> > > > +
> > > >  /**
> > > >   * struct kexec_buf - parameters for finding a place for a buffer in memory
> > > >   * @image:	kexec image in which memory to search.
> > > > @@ -276,12 +296,6 @@ int crash_shrink_memory(unsigned long new_size);
> > > >  size_t crash_get_memory_size(void);
> > > >  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
> > > >  
> > > > -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > > -					 unsigned long buf_len);
> > > > -void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> > > > -int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
> > > > -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > > -					unsigned long buf_len);
> > > 
> > > I thought we can keep using the __weak function in common code and drop
> > > the arch functions, no need the #ifndef arch_kexec_kernel_image_probe
> > > and the function renaming stuff.  But I did not notice the powerpc
> > > _probe function checks KEXEC_ON_CRASH, that should be checked earlier
> > > and we can fail out early if not supported, but I have no idea
> > > how to do it gracefully for now.
> > > 
> > > Also for x86 _load function it cleanups image->arch.elf_headers, it can
> > > not be dropped simply.
> > 
> > Yeah, arm64 post_load_cleanup function also has some extra stuff.
> > See my patch #7/8.
> 
> But the x86 cleanup was dropped silently, can you add it in x86
> post_load_cleanup as well?

Sure, I will do.

> > 
> > > Consider the above two issues, maybe you can keep the powerpc
> > > version of _probe() and x86 version of _load(), and still copy the common code
> > > to kexec_file.c weak functions.
> > 
> > It was exactly what I made before submitting v3, but I changed
> > my mind a bit. My intension is to prevent the code being duplicated
> > even though it has only a few lines of code.
> > 
> > I agree that '#ifndef arch_kexec_kernel_image_probe' in kexec.h would be
> > quite ugly, but similar usages can be spotted in the kernel source.
> > 
> > That said if you don't like it at all, I defer to you.
> 
> I understand your concern, maybe still use a weak function for 
> arch_kexec_kernel_image_*, and they call the kexec_kernel_image_* in
> kexec_file.c common code.
> 
> Like in general code:
> 
> int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>                                          unsigned long buf_len)
> {
> 	return kexec_kernel_image_probe(image, buf, buf_len);

as you suggested,
        "return _kexec_kernel_image_probe(...);

would be fine.

-Takahiro AKASHI


> }
> 
> In architechture code it can add other code and call
> kexec_kernel_image_*
> 
> It looks a bit better than the #ifdef way. 
> 
> [snip]
> 
> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
