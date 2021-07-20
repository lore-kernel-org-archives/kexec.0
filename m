Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5ruM-00DSdV-Bu
 for kexec@lists.infradead.org; Tue, 20 Jul 2021 15:43:49 +0000
Received: by mail-pf1-x431.google.com with SMTP id d9so8712530pfv.4
 for <kexec@lists.infradead.org>; Tue, 20 Jul 2021 08:43:44 -0700 (PDT)
Date: Tue, 20 Jul 2021 08:43:43 -0700 (PDT)
Subject: Re: [PATCH v4 06/10] riscv: Remove non-standard linux,
 elfcorehdr handling
In-Reply-To: <170e7daa55aced148b8e57827f7c8fc65a0a8c7a.1626266516.git.geert+renesas@glider.be>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-8deebbc6-f8aa-40e3-9e00-e99f12eaac92@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
Cc: robh+dt@kernel.org, linux@armlinux.org.uk, nico@fluxnic.net, ardb@kernel.org, linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org, mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, frowand.list@gmail.com, dyoung@redhat.com, rppt@kernel.org, bhe@redhat.com, vgoyal@redhat.com, akpm@linux-foundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, geert+renesas@glider.be

On Wed, 14 Jul 2021 05:50:16 PDT (-0700), geert+renesas@glider.be wrote:
> RISC-V uses platform-specific code to locate the elf core header in
> memory.  However, this does not conform to the standard
> "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
> with the "linux,elfcorehdr" compatible value, instead of on a
> "linux,elfcorehdr" property under the "/chosen" node.
>
> The non-compliant code can just be removed, as the standard behavior is
> already implemented by platform-agnostic handling in the FDT core code.
>
> Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - No changes.
> ---
>  arch/riscv/mm/init.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 269fc648ef3d84b2..4aa4b6a034086df6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -829,26 +829,6 @@ static void __init reserve_crashkernel(void)
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>
> -#ifdef CONFIG_CRASH_DUMP
> -/*
> - * We keep track of the ELF core header of the crashed
> - * kernel with a reserved-memory region with compatible
> - * string "linux,elfcorehdr". Here we register a callback
> - * to populate elfcorehdr_addr/size when this region is
> - * present. Note that this region will be marked as
> - * reserved once we call early_init_fdt_scan_reserved_mem()
> - * later on.
> - */
> -static int __init elfcore_hdr_setup(struct reserved_mem *rmem)
> -{
> -	elfcorehdr_addr = rmem->base;
> -	elfcorehdr_size = rmem->size;
> -	return 0;
> -}
> -
> -RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> -#endif
> -
>  void __init paging_init(void)
>  {
>  	setup_bootmem();

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

LMK if you wanted me to take this series, otherwise I'm going to assume 
it's going in via some other tree.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
