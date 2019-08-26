Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2Onp-0002cp-Fp
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 23:53:39 +0000
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A819985363
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 23:53:36 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id k13so24687139ioh.16
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 16:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190826044535.9646-1-kasong@redhat.com>
In-Reply-To: <20190826044535.9646-1-kasong@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 27 Aug 2019 07:53:23 +0800
Message-ID: <CACPcB9cULwH1B6Um9TXnbgu2GuYBQ9yZ0OKKu9yMdBmhDdNp8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
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
To: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Mon, Aug 26, 2019 at 12:46 PM Kairui Song <kasong@redhat.com> wrote:
>
> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> SWIOTLB will be enabled even if there is less than 4G of memory when SME
> is active, to support DMA of devices that not support address with the
> encrypt bit.
>
> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
>
> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> encryption") will always force SWIOTLB to be enabled when SEV is active
> in all cases.
>
> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> and this is also true for kdump kernel. As a result kdump kernel will
> run out of already scarce pre-reserved memory easily.
>
> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> is specified or any offset is used. As for the high reservation case, an
> extra low memory region will always be reserved and that is enough for
> SWIOTLB. Else if the offset format is used, user should be fully aware
> of any possible kdump kernel memory requirement and have to organize the
> memory usage carefully.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
>
> ---
> Update from V1:
> - Use mem_encrypt_active() instead of "sme_active() || sev_active()"
> - Don't reserve extra memory when ",high" or "@offset" is used, and
>   don't print redundant message.
> - Fix coding style problem
>
>  arch/x86/kernel/setup.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bbe35bf879f5..221beb10c55d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
>
>  static void __init reserve_crashkernel(void)
>  {
> -       unsigned long long crash_size, crash_base, total_mem;
> +       unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
>         bool high = false;
>         int ret;
>
> @@ -550,6 +550,15 @@ static void __init reserve_crashkernel(void)
>                 return;
>         }
>
> +       /*
> +        * When SME/SEV is active, it will always required an extra SWIOTLB
> +        * region.
> +        */
> +       if (mem_encrypt_active())
> +               mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +       else
> +               mem_enc_req = 0;
> +
>         /* 0 means: find the address automatically */
>         if (!crash_base) {
>                 /*
> @@ -563,11 +572,19 @@ static void __init reserve_crashkernel(void)
>                 if (!high)
>                         crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                 CRASH_ADDR_LOW_MAX,
> -                                               crash_size, CRASH_ALIGN);
> -               if (!crash_base)
> +                                               crash_size + mem_enc_req,
> +                                               CRASH_ALIGN);
> +               /*
> +                * For high reservation, an extra low memory for SWIOTLB will
> +                * always be reserved later, so no need to reserve extra
> +                * memory for memory encryption case here.
> +                */
> +               if (!crash_base) {
> +                       mem_enc_req = 0;
>                         crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                 CRASH_ADDR_HIGH_MAX,
>                                                 crash_size, CRASH_ALIGN);
> +               }
>                 if (!crash_base) {
>                         pr_info("crashkernel reservation failed - No suitable area found.\n");
>                         return;
> @@ -575,6 +592,7 @@ static void __init reserve_crashkernel(void)
>         } else {
>                 unsigned long long start;
>
> +               mem_enc_req = 0;
>                 start = memblock_find_in_range(crash_base,
>                                                crash_base + crash_size,
>                                                crash_size, 1 << 20);
> @@ -583,6 +601,13 @@ static void __init reserve_crashkernel(void)
>                         return;
>                 }
>         }
> +
> +       if (mem_enc_req) {
> +               pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +                       (unsigned long)(mem_enc_req >> 20));
> +               crash_size += mem_enc_req;
> +       }
> +
>         ret = memblock_reserve(crash_base, crash_size);
>         if (ret) {
>                 pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> --
> 2.21.0
>

Hi Tom, any comment about V2?

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
