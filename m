Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <cover.1628670468.git.geert+renesas@glider.be>
 <92b6718f5618d5469f67b48fbea189cca0c12f4b.1628670468.git.geert+renesas@glider.be>
 <YRn9DHlB/pdNPJyP@kernel.org>
In-Reply-To: <YRn9DHlB/pdNPJyP@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Aug 2021 12:17:50 +0200
Message-ID: <CAMuHMdVdqR7gw+2O2v=qv_BB=+X2wEXN9jXV=np=jRayadwj7g@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] MIPS: Avoid future duplicate elf core header
 reservation
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, kexec@lists.infradead.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Mike,

On Mon, Aug 16, 2021 at 7:52 AM Mike Rapoport <rppt@kernel.org> wrote:
> On Wed, Aug 11, 2021 at 10:50:59AM +0200, Geert Uytterhoeven wrote:
> > Prepare for early_init_fdt_scan_reserved_mem() reserving the memory
> > occupied by an elf core header described in the device tree.
> > As arch_mem_init() calls early_init_fdt_scan_reserved_mem() before
> > mips_reserve_vmcore(), the latter needs to check if the memory has
> > already been reserved before.
>
> Doing memblock_reserve() for the same region is usually fine, did you
> encounter any issues without this patch?

Does it also work if the same region is part of an earlier larger
reservation?  I am no memblock expert, so I don't know.
I didn't run into any issues, as my MIPS platform is non-DT, but I
assume arch/arm64/mm/init.c:reserve_elfcorehdr() had the check for
a reason.

Thanks!

>
> > Note that mips_reserve_vmcore() cannot just be removed, as not all MIPS
> > systems use DT.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5:
> >   - New.
> > ---
> >  arch/mips/kernel/setup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 23a140327a0bac1b..4693add05743d78b 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -429,7 +429,8 @@ static void __init mips_reserve_vmcore(void)
> >       pr_info("Reserving %ldKB of memory at %ldKB for kdump\n",
> >               (unsigned long)elfcorehdr_size >> 10, (unsigned long)elfcorehdr_addr >> 10);
> >
> > -     memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
> > +     if (!memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)
> > +             memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
> >  #endif
> >  }

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
