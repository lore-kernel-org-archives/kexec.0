Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 23 Aug 2021 18:20:20 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 1/9] MIPS: Avoid future duplicate elf core header
 reservation
Message-ID: <YSO8tJxbuADEeL7I@kernel.org>
References: <cover.1628670468.git.geert+renesas@glider.be>
 <92b6718f5618d5469f67b48fbea189cca0c12f4b.1628670468.git.geert+renesas@glider.be>
 <YRn9DHlB/pdNPJyP@kernel.org>
 <CAMuHMdVdqR7gw+2O2v=qv_BB=+X2wEXN9jXV=np=jRayadwj7g@mail.gmail.com>
 <YSOeGzowhV/R9QS/@kernel.org>
 <CAL_JsqLMv4fKebJEOv=7UXvy_qqut0N42psS-PSgRMU-qhiFLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLMv4fKebJEOv=7UXvy_qqut0N42psS-PSgRMU-qhiFLQ@mail.gmail.com>
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
To: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, kexec@lists.infradead.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Aug 23, 2021 at 09:44:55AM -0500, Rob Herring wrote:
> On Mon, Aug 23, 2021 at 8:10 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Aug 23, 2021 at 12:17:50PM +0200, Geert Uytterhoeven wrote:
> > > Hi Mike,
> > >
> > > On Mon, Aug 16, 2021 at 7:52 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > On Wed, Aug 11, 2021 at 10:50:59AM +0200, Geert Uytterhoeven wrote:
> > > > > Prepare for early_init_fdt_scan_reserved_mem() reserving the memory
> > > > > occupied by an elf core header described in the device tree.
> > > > > As arch_mem_init() calls early_init_fdt_scan_reserved_mem() before
> > > > > mips_reserve_vmcore(), the latter needs to check if the memory has
> > > > > already been reserved before.
> > > >
> > > > Doing memblock_reserve() for the same region is usually fine, did you
> > > > encounter any issues without this patch?
> > >
> > > Does it also work if the same region is part of an earlier larger
> > > reservation?  I am no memblock expert, so I don't know.
> > > I didn't run into any issues, as my MIPS platform is non-DT, but I
> > > assume arch/arm64/mm/init.c:reserve_elfcorehdr() had the check for
> > > a reason.
> >
> > The memory will be reserved regardless of the earlier reservation, the
> > issue may appear when the reservations are made for different purpose. E.g.
> > if there was crash kernel allocation before the reservation of elfcorehdr.
> >
> > The check in such case will prevent the second reservation, but, at least
> > in arch/arm64/mm/init.c:reserve_elfcorehdr() it does not seem to prevent
> > different users of the overlapping regions to step on each others toes.
> 
> If the kernel has been passed in overlapping regions, is there
> anything you can do other than hope to get a message out?

Nothing really. I've been thinking about adding flags to memblock.reserved
to at least distinguish firmware regions from the kernel allocations, but I
never got to that.
 
> > Moreover, arm64::reserve_elfcorehdr() seems buggy to me, because of there
> > is only a partial overlap of the elfcorehdr with the previous reservation,
> > the non-overlapping part of elfcorehdr won't get reserved at all.
> 
> What do you suggest as the arm64 version is not the common version?

I'm not really familiar with crash dump internals, so I don't know if
resetting elfcorehdr_addr to ELFCORE_ADDR_ERR is a good idea. I think at
least arm64::reserve_elfcorehdr() should reserve the entire elfcorehdr area
regardless of the overlap. Otherwise it might get overwritten by a random
memblock_alloc().

> Rob

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
