Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 11 Sep 2017 16:25:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 6/9] arm64: kexec_file: load initrd, device-tree and
 purgatory segments
Message-ID: <20170911082517.GA25352@dhcp-128-65.nay.redhat.com>
References: <20170908031616.17916-1-takahiro.akashi@linaro.org>
 <20170908031616.17916-7-takahiro.akashi@linaro.org>
 <20170911064754.GA7332@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170911064754.GA7332@dhcp-128-65.nay.redhat.com>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb_buf);
> > +	image->arch.dtb_buf = NULL;
> > +
> > +	vfree(image->arch.elf_headers);
> > +	image->arch.elf_headers = NULL;
> > +	image->arch.elf_headers_sz = 0;
> > +
> > +	if (!image->fops || !image->fops->cleanup)
> > +		return 0;
> > +
> > +	return image->fops->cleanup(image->image_loader_data);
> > +}
> > +
> > +#ifdef CONFIG_KEXEC_VERIFY_SIG
> > +int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
> > +				 unsigned long kernel_len)
> > +{
> > +	if (!image->fops || !image->fops->verify_sig) {
> > +		pr_debug("kernel loader does not support signature verification.\n");
> > +		return -EKEYREJECTED;
> > +	}
> > +
> > +	return image->fops->verify_sig(kernel, kernel_len);
> > +}
> 
> 
> arch_kexec_kernel_verify_sig now be duplicated so it can be put in the
> general function in kexec_file.c
> 
> Also the probe and load function are also duplicated, they can be moved
> to common code as well.
> 
> The x86 load function can be cleaned up with removing the vfree
> callback.
> 
> ---
>  arch/x86/kernel/machine_kexec_64.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- linux-x86.orig/arch/x86/kernel/machine_kexec_64.c
> +++ linux-x86/arch/x86/kernel/machine_kexec_64.c
> @@ -384,9 +384,6 @@ int arch_kexec_kernel_image_probe(struct
>  
>  void *arch_kexec_kernel_image_load(struct kimage *image)
>  {
> -	vfree(image->arch.elf_headers);
> -	image->arch.elf_headers = NULL;
> -

Hmm, should move above to arch_kimage_file_post_load_cleanup instead.. 

>  	if (!image->fops || !image->fops->load)
>  		return ERR_PTR(-ENOEXEC);
>  
> 


Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
