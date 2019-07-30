Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsPKW-0000Do-KX
 for kexec@lists.infradead.org; Tue, 30 Jul 2019 10:26:06 +0000
Received: by mail-lj1-f196.google.com with SMTP id t28so61538391lje.9
 for <kexec@lists.infradead.org>; Tue, 30 Jul 2019 03:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
In-Reply-To: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 30 Jul 2019 15:55:48 +0530
Message-ID: <CACi5LpNQ8bEC+2KE=DZaUjeSmA46U=3u8m2WQYJEexK7uE0L+A@mail.gmail.com>
Subject: Re: [PATCH] kexec: restore arch_kexec_kernel_image_probe declaration
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
Cc: kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

Hi Vasily,

On Mon, Jul 29, 2019 at 5:44 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> arch_kexec_kernel_image_probe function declaration has been removed by
> commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> functions"). Still this function is overridden by couple of architectures
> and proper prototype declaration is therefore important, so bring it
> back. This fixes the following sparse warning on s390:
> arch/s390/kernel/machine_kexec_file.c:333:5: warning: symbol 'arch_kexec_kernel_image_probe' was not declared. Should it be static?

May be it would be better to add a 'Fixes:' tag here (but may be it
can be added while picking it into the tree). With the above minor
nitpick:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

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
>                                    bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>
> +int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> +                                        unsigned long buf_len);
>  void * __weak arch_kexec_kernel_image_load(struct kimage *image);
>  int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>                                             Elf_Shdr *section,
> --
> 2.21.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
