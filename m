From: Baoquan He <bhe@redhat.com>
Date: Tue, 22 Mar 2022 11:13:20 +0800
Subject: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
In-Reply-To: <20220322025912.r2ahc2ztx3npt7av@Rk>
References: <20220318094101.274950-1-coxu@redhat.com>
 <20220318094101.274950-2-coxu@redhat.com>
 <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
 <20220322025912.r2ahc2ztx3npt7av@Rk>
Message-ID: <Yjk+0IiTXbTRC6LT@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/22/22 at 10:59am, Coiby Xu wrote:
> On Mon, Mar 21, 2022 at 12:21:33PM +0800, Baoquan He wrote:
> > On 03/18/22 at 05:40pm, Coiby Xu wrote:
> > > Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> > > functions") allows implementing the arch-specific implementation of kernel
> > > image verification in kexec_file_ops->verify_sig. Currently, there is no
> > 
> > Looking back at the old commit 9ec4ecef0af7, it mistakenly added a
> > generic arch_kexec_kernel_verify_sig() which is marked as __weak,
> > and expects any architecture will add a arch specified version if needed.
> > In fact those arch specified difference has been removed by wrapping
> > them into each architecture's own struct kexec_file_ops methods. Means
> > in the commit, the generic arch_kexec_kernel_verify_sig() is unnecessary
> > at all.
> 
> Thanks for looking at commit 9ec4ecef0af7 for me!
> 
> Although commit 9ec4ecef0af7 added some code in arch_kexec_kernel_verify_sig
> so kexec_file_ops->verify_sig can be called, this commit doesn't add __weak
> arch_kexec_kernel_verify_sig itself. And kexec_file_ops isn't supposed
> to replace arch-specific implementation using __weak considering s390 and x86
> still make use of __weak to implement its own version of
> arch_kexec_apply_relocations_add. How about the commit message as
> follows?

Yes, arch_kexec_apply_relocations_add has its different version on
arches. But arch_kexec_kernel_verify_sig() is different. There's a
specific method for that, ->verify_sig().

struct kexec_file_ops {
        kexec_probe_t *probe;         
        kexec_load_t *load;
        kexec_cleanup_t *cleanup;
#ifdef CONFIG_KEXEC_SIG
        kexec_verify_sig_t *verify_sig;
#endif
};

> 
>   Currently this no arch-specific implementation of
>   arch_kexec_kernel_verify_sig. Even if we want to add an implementation
>   for an architecture in the future, we can simply use "(struct
>   kexec_file_ops*)->verify_sig". So clean it up.

That is also fine. I think it's better to put the above in if we have
checked the old commit. Anyway, please take the sentences which comforts
you more. And there's grammer mistake, please use 'Currently there is
not' to replace.

> > 
> > Now, you clean up that uncessary function with code change.
> > 
> > I think description telling above analysis could be clearer.
> > 
> > > arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
> > > up.
> > > 
> > > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > >  include/linux/kexec.h |  4 ----
> > >  kernel/kexec_file.c   | 34 +++++++++++++---------------------
> > >  2 files changed, 13 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 0c994ae37729..755fed183224 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
> > >  				 const Elf_Shdr *relsec,
> > >  				 const Elf_Shdr *symtab);
> > >  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> > > -#ifdef CONFIG_KEXEC_SIG
> > > -int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > -				 unsigned long buf_len);
> > > -#endif
> > >  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
> > > 
> > >  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 8347fc158d2b..3720435807eb 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >  	return kexec_image_post_load_cleanup_default(image);
> > >  }
> > > 
> > > -#ifdef CONFIG_KEXEC_SIG
> > > -static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
> > > -					  unsigned long buf_len)
> > > -{
> > > -	if (!image->fops || !image->fops->verify_sig) {
> > > -		pr_debug("kernel loader does not support signature verification.\n");
> > > -		return -EKEYREJECTED;
> > > -	}
> > > -
> > > -	return image->fops->verify_sig(buf, buf_len);
> > > -}
> > > -
> > > -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > -					unsigned long buf_len)
> > > -{
> > > -	return kexec_image_verify_sig_default(image, buf, buf_len);
> > > -}
> > > -#endif
> > > -
> > >  /*
> > >   * arch_kexec_apply_relocations_add - apply relocations of type RELA
> > >   * @pi:		Purgatory to be relocated.
> > > @@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
> > >  }
> > > 
> > >  #ifdef CONFIG_KEXEC_SIG
> > > +static int kexec_image_verify_sig(struct kimage *image, void *buf,
> > > +		unsigned long buf_len)
> > > +{
> > > +	if (!image->fops || !image->fops->verify_sig) {
> > > +		pr_debug("kernel loader does not support signature verification.\n");
> > > +		return -EKEYREJECTED;
> > > +	}
> > > +
> > > +	return image->fops->verify_sig(buf, buf_len);
> > > +}
> > > +
> > >  static int
> > >  kimage_validate_signature(struct kimage *image)
> > >  {
> > >  	int ret;
> > > 
> > > -	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
> > > -					   image->kernel_buf_len);
> > > +	ret = kexec_image_verify_sig(image, image->kernel_buf,
> > > +			image->kernel_buf_len);
> > >  	if (ret) {
> > > 
> > >  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> > > --
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Best regards,
> Coiby
> 


