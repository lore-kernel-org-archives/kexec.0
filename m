Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g7GaT-0005yQ-S2
 for kexec@lists.infradead.org; Tue, 02 Oct 2018 09:03:41 +0000
Received: by mail-pl1-x641.google.com with SMTP id az3-v6so669282plb.4
 for <kexec@lists.infradead.org>; Tue, 02 Oct 2018 02:03:15 -0700 (PDT)
Date: Tue, 2 Oct 2018 18:04:40 +0900
From: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181002090438.GH32578@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181002044710.GD1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181002044710.GD1886@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, James Morse <james.morse@arm.com>, dyoung@redhat.com, David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Oct 02, 2018 at 02:47:10PM +1000, David Gibson wrote:
> On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> > +David Gibson
> > 
> > On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > These functions will be used later to handle kexec-specific properties
> > > in arm64's kexec_file implementation.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > ---
> > >  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of_fdt.h |  4 +++
> > >  2 files changed, 60 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 800ad252cf9c..c65c31562ccb 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > >
> > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > >  #include <asm/page.h>
> > > @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> > >  #endif
> > >
> > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > > +
> > > +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> > > +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> > > +
> > > +int fdt_prop_len(const char *prop_name, int len)
> > > +{
> > > +       return (strlen(prop_name) + 1) +
> > > +               sizeof(struct fdt_property) +
> > > +               FDT_TAGALIGN(len);
> > 
> > Looks like you are using this to calculate how much space you need to
> > allocate in addition to the current DTB for a couple of new or
> > replaced properties. I'm not sure that this calculation is completely
> > accurate. And it is strange there doesn't seem to be any libfdt
> > function for this already. It would be simpler to just add some fixed
> > additional amount.
> > 
> > Maybe David G has comments on this?
> 
> Hrm.  Yeah, the approach I'd suggest would be to just add a fixed
> amount, and if your functions return -FDT_ERR_NOSPACE, add some more.
> That's pretty much the expected way of working with fdts in write
> mode.

I will try to follow this approach.

Thanks,
-Takahiro Akashi

> If that's really not suitable, we could look at adding a helper to
> estimate this in libfdt.  Or, actually, I suspect taking an existing
> libfdt internal helper, polishing and exporting it.
> 
> > 
> > > +}
> > > +
> > 
> > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > should go into libfdt, but I'm fine with having it in the kernel for
> > now.
> > 
> > > +static void fill_property(void *buf, u64 val64, int cells)
> > > +{
> > > +       __be32 val32;
> > > +
> > > +       while (cells) {
> > > +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> > > +               memcpy(buf, &val32, sizeof(val32));
> > > +               buf += sizeof(val32);
> > 
> > This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> > 
> > BTW, for purposes of moving to libfdt, we'll need the authors'
> > (Masahiro Yamada and Hans de Goede) permission to dual license.
> > 
> > > +       }
> > > +}
> > > +
> > > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > > +                                               u64 addr, u64 size)
> > > +{
> > > +       int addr_cells, size_cells;
> > > +       char buf[sizeof(__be32) * 2 * 2];
> > > +               /* assume dt_root_[addr|size]_cells <= 2 */
> > > +       void *prop;
> > > +       size_t buf_size;
> > > +
> > > +       addr_cells = fdt_address_cells(fdt, 0);
> > > +       if (addr_cells < 0)
> > > +               return addr_cells;
> > > +       size_cells = fdt_size_cells(fdt, 0);
> > > +       if (size_cells < 0)
> > > +               return size_cells;
> > > +
> > > +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
> > > +       if ((addr_cells == 1) && (addr > U32_MAX))
> > > +               return -FDT_ERR_BADVALUE;
> > > +
> > > +       if ((size_cells == 1) && (size > U32_MAX))
> > > +               return -FDT_ERR_BADVALUE;
> > > +
> > > +       buf_size = (addr_cells + size_cells) * sizeof(u32);
> > > +       prop = buf;
> > > +
> > > +       fill_property(prop, addr, addr_cells);
> > > +       prop += addr_cells * sizeof(u32);
> > > +
> > > +       fill_property(prop, size, size_cells);
> > > +
> > > +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> > > +}
> > > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > > index b9cd9ebdf9b9..842af6ea92ea 100644
> > > --- a/include/linux/of_fdt.h
> > > +++ b/include/linux/of_fdt.h
> > > @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
> > >  static inline void unflatten_and_copy_device_tree(void) {}
> > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > >
> > > +int fdt_prop_len(const char *prop_name, int len);
> > > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > > +                                               u64 addr, u64 size);
> > > +
> > >  #endif /* __ASSEMBLY__ */
> > >  #endif /* _LINUX_OF_FDT_H */
> > >
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
