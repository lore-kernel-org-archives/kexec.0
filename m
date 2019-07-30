Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsOhr-00085I-N4
 for kexec@lists.infradead.org; Tue, 30 Jul 2019 09:46:09 +0000
Date: Tue, 30 Jul 2019 17:45:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: restore arch_kexec_kernel_image_probe declaration
Message-ID: <20190730094559.GA11557@dhcp-128-65.nay.redhat.com>
References: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
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
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On 07/29/19 at 02:14pm, Vasily Gorbik wrote:
> arch_kexec_kernel_image_probe function declaration has been removed by
> commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> functions"). Still this function is overridden by couple of architectures
> and proper prototype declaration is therefore important, so bring it
> back. This fixes the following sparse warning on s390:
> arch/s390/kernel/machine_kexec_file.c:333:5: warning: symbol 'arch_kexec_kernel_image_probe' was not declared. Should it be static?
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  include/linux/kexec.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 1740fe36b5b7..f7529d120920 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -183,6 +183,8 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>  
> +int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> +					 unsigned long buf_len);
>  void * __weak arch_kexec_kernel_image_load(struct kimage *image);
>  int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  					    Elf_Shdr *section,
> -- 
> 2.21.0
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
