Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI2A-0004IL-SX
 for kexec@lists.infradead.org; Fri, 07 Dec 2018 15:27:21 +0000
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so3888636ljh.6
 for <kexec@lists.infradead.org>; Fri, 07 Dec 2018 07:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20181207101439.190918-1-james.morse@arm.com>
In-Reply-To: <20181207101439.190918-1-james.morse@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 7 Dec 2018 20:56:53 +0530
Message-ID: <CACi5LpM9_bQnx+YqBcFqFbMWAmZoYtDwopuSq+NpOaX8tjak=g@mail.gmail.com>
Subject: Re: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via
 kexec_file_load()
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
Cc: devicetree@vger.kernel.org, herbert@gondor.apana.org.au, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec mailing list <kexec@lists.infradead.org>, frowand.list@gmail.com, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, heiko.carstens@de.ibm.com, dhowells@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, robh+dt@kernel.org, arnd@arndb.de, Vivek Goyal <vgoyal@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, schwidefsky@de.ibm.com, prudo@linux.ibm.com, Dave Young <dyoung@redhat.com>, davem@davemloft.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi James,

On Fri, Dec 7, 2018 at 3:44 PM James Morse <james.morse@arm.com> wrote:
>
> Now that kexec_walk_memblock() can do the crash-kernel placement itself
> architectures that don't support kdump via kexe_file_load() need to
> explicitly forbid it.
>
> We don't support this on arm64 until the kernel can add the elfcorehdr
> and usable-memory-range fields to the DT. Without these the crash-kernel
> overwrites the previous kernel's memory during startup.
>
> Add a check to refuse crash image loading.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>
> Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com
>
>  arch/arm64/kernel/kexec_image.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 1ad1d5f8f024..07bf740bea91 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
>         struct kexec_segment *kernel_segment;
>         int ret;
>
> +       /* We don't support crash kernels yet. */
> +       if (image->type == KEXEC_TYPE_CRASH)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
>         /*
>          * We require a kernel with an unambiguous Image header. Per
>          * Documentation/booting.txt, this is the case when image_size
> --
> 2.19.2
>

TBH, I would have loved the complete 'kexec_file_load' support to have
made way upstream for arm64 as well, but I understand that it is stuck
till we have an agreement on the DT side of things. So, refusing a
crash image loading in such a case makes sense for now.

So, please feel free to add:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
