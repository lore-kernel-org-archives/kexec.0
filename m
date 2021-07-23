Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <170e7daa55aced148b8e57827f7c8fc65a0a8c7a.1626266516.git.geert+renesas@glider.be>
 <mhng-8deebbc6-f8aa-40e3-9e00-e99f12eaac92@palmerdabbelt-glaptop>
In-Reply-To: <mhng-8deebbc6-f8aa-40e3-9e00-e99f12eaac92@palmerdabbelt-glaptop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jul 2021 17:17:08 +0200
Message-ID: <CAMuHMdUaQW_edTRAiLb8u+=UoVNkSsgedMVTt8=qPPQ59hrfmw@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] riscv: Remove non-standard linux,
 elfcorehdr handling
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
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-riscv <linux-riscv@lists.infradead.org>, kexec@lists.infradead.org, Linux MM <linux-mm@kvack.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Palmer,

On Tue, Jul 20, 2021 at 5:43 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Wed, 14 Jul 2021 05:50:16 PDT (-0700), geert+renesas@glider.be wrote:
> > RISC-V uses platform-specific code to locate the elf core header in
> > memory.  However, this does not conform to the standard
> > "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
> > with the "linux,elfcorehdr" compatible value, instead of on a
> > "linux,elfcorehdr" property under the "/chosen" node.
> >
> > The non-compliant code can just be removed, as the standard behavior is
> > already implemented by platform-agnostic handling in the FDT core code.
> >
> > Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> >   - No changes.
> > ---
> >  arch/riscv/mm/init.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 269fc648ef3d84b2..4aa4b6a034086df6 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -829,26 +829,6 @@ static void __init reserve_crashkernel(void)
> >  }
> >  #endif /* CONFIG_KEXEC_CORE */
> >
> > -#ifdef CONFIG_CRASH_DUMP
> > -/*
> > - * We keep track of the ELF core header of the crashed
> > - * kernel with a reserved-memory region with compatible
> > - * string "linux,elfcorehdr". Here we register a callback
> > - * to populate elfcorehdr_addr/size when this region is
> > - * present. Note that this region will be marked as
> > - * reserved once we call early_init_fdt_scan_reserved_mem()
> > - * later on.
> > - */
> > -static int __init elfcore_hdr_setup(struct reserved_mem *rmem)
> > -{
> > -     elfcorehdr_addr = rmem->base;
> > -     elfcorehdr_size = rmem->size;
> > -     return 0;
> > -}
> > -
> > -RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> > -#endif
> > -
> >  void __init paging_init(void)
> >  {
> >       setup_bootmem();
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> LMK if you wanted me to take this series, otherwise I'm going to assume
> it's going in via some other tree.

There will be a v5 of the series in response to the review comments.
But I think this patch can already be applied.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
