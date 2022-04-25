From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Mon, 25 Apr 2022 07:16:30 +0000
Subject: [PATCH makedumpfile] Avoid false-positive mem_section validation
 with vmlinux
In-Reply-To: <CAF+s44QKaXBiHr8O4jzvTK3nanVPFEvqQkdC-s5OCDYgMTts-Q@mail.gmail.com>
References: <TYYPR01MB6777DF79FA02B1A563395018DDF59@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <YmUj5qFjaQRdPh8z@piliu.users.ipa.redhat.com>
 <TYYPR01MB6777712B1A1F001624E8033ADDF89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <CAF+s44QKaXBiHr8O4jzvTK3nanVPFEvqQkdC-s5OCDYgMTts-Q@mail.gmail.com>
Message-ID: <TYYPR01MB677796348971D3E23278B3E1DDF89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> On Mon, Apr 25, 2022 at 8:48 AM HAGIO KAZUHITO(?????)
> <k-hagio-ab@nec.com> wrote:
> >
> > Hi Pingfan,
> >
> > -----Original Message-----
> > > On Wed, Apr 20, 2022 at 11:58:29PM +0000, HAGIO KAZUHITO(?? ??) wrote:
> > > > Currently get_mem_section() validates if SYMBOL(mem_section) is the address
> > > > of the mem_section array first.  But there was a report that the first
> > > > validation wrongly returned TRUE with -x vmlinux and SPARSEMEM_EXTREME
> > > > (4.15+) on s390x.  This leads to crash failing statup with the following
> > > > seek error:
> > > >
> > > >   crash: seek error: kernel virtual address: 67fffc2800  type: "memory section root table"
> > > >
> > > > Skip the first validation when satisfying the conditions.
> > > >
> > >
> > > I still prefer to your V1, which is discussed internally. In which, the
> > > logic was made straight forward. And I suggest some slight change to
> > > your V1, which folds "-x vmlinux" logic into is_sparsemem_extreme().
> > >
> > > What about the following: (not tested yet, if it is good, I can test it)
> >
> > Thanks for your review and suggestion.
> >
> > The purpose of my patch is to distinguish between SPARSEMEM_EXTREME
> > v1 and v2, i.e. whether it has 83e3c48729d9 or not.
> >
> 
> Not sure about dwarf, but is it possible to utilize the array length
> info in is_sparsemem_extreme()?
> 
> For SPARSEMEM_EXTREME,
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> extern struct mem_section *mem_section[NR_SECTION_ROOTS];
>  #else
>  extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>  #endif
> 
> And if DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH works, then there is a big
> gap between "NR_SECTION_ROOTS * 8-bytes" and "sizeof(struct
> mem_section) * NR_SECTION_ROOTS * SECTIONS_PER_ROOT"

hmm, sorry, I haven't got your point, the current is_sparsemem_extreme()
already uses that value to determine whether it's SPARSEMEM_EXTREME or not.
and it's doing the same thing with vmlinux, too.

> > >       if ((ARRAY_LENGTH(mem_section)
> > > -          == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME()))
> > > -         || (ARRAY_LENGTH(mem_section) == NOT_FOUND_STRUCTURE))
> > > -             return TRUE;

        if (SYMBOL(mem_section) != NOT_FOUND_SYMBOL)
                SYMBOL_ARRAY_LENGTH_INIT(mem_section, "mem_section");

Thanks,
Kazu

