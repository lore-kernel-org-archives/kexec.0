Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csnpq-0006LE-OO
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 09:54:44 +0000
Received: by mail-it0-x233.google.com with SMTP id y18so12468659itc.1
 for <kexec@lists.infradead.org>; Tue, 28 Mar 2017 02:54:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328065130.16019-3-takahiro.akashi@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-3-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Mar 2017 10:54:21 +0100
Message-ID: <CAKv+Gu_QjVyLCaXDsi_14AVnk0kMN9O6xiF6B7TLbp+weOkPTQ@mail.gmail.com>
Subject: Re: [PATCH v34 05/14] arm64: mm: add set_memory_valid()
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
Cc: Mark Rutland <mark.rutland@arm.com>, Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Sameer Goel <sgoel@codeaurora.org>, Dave Young <dyoung@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 March 2017 at 07:51, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This function validates and invalidates PTE entries, and will be utilized
> in kdump to protect loaded crash dump kernel image.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/cacheflush.h |  1 +
>  arch/arm64/mm/pageattr.c            | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 5a2a6ee65f65..728f933cef8c 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -154,5 +154,6 @@ int set_memory_ro(unsigned long addr, int numpages);
>  int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
> +int set_memory_valid(unsigned long addr, unsigned long size, int enable);
>
>  #endif
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 8def55e7249b..3212ee0558f6 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -125,20 +125,23 @@ int set_memory_x(unsigned long addr, int numpages)
>  }
>  EXPORT_SYMBOL_GPL(set_memory_x);
>
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -void __kernel_map_pages(struct page *page, int numpages, int enable)
> +int set_memory_valid(unsigned long addr, int numpages, int enable)
>  {
> -       unsigned long addr = (unsigned long) page_address(page);
> -
>         if (enable)
> -               __change_memory_common(addr, PAGE_SIZE * numpages,
> +               return __change_memory_common(addr, PAGE_SIZE * numpages,
>                                         __pgprot(PTE_VALID),
>                                         __pgprot(0));
>         else
> -               __change_memory_common(addr, PAGE_SIZE * numpages,
> +               return __change_memory_common(addr, PAGE_SIZE * numpages,
>                                         __pgprot(0),
>                                         __pgprot(PTE_VALID));
>  }
> +
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +void __kernel_map_pages(struct page *page, int numpages, int enable)
> +{
> +       set_memory_valid((unsigned long)page_address(page), numpages, enable);
> +}
>  #ifdef CONFIG_HIBERNATION
>  /*
>   * When built with CONFIG_DEBUG_PAGEALLOC and CONFIG_HIBERNATION, this function
> --
> 2.11.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
