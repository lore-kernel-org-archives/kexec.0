From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 25 Apr 2022 11:29:26 +0800
Subject: [PATCH makedumpfile] Avoid false-positive mem_section validation
 with vmlinux
In-Reply-To: <TYYPR01MB6777712B1A1F001624E8033ADDF89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <TYYPR01MB6777DF79FA02B1A563395018DDF59@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <YmUj5qFjaQRdPh8z@piliu.users.ipa.redhat.com>
 <TYYPR01MB6777712B1A1F001624E8033ADDF89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Message-ID: <CAF+s44QKaXBiHr8O4jzvTK3nanVPFEvqQkdC-s5OCDYgMTts-Q@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Apr 25, 2022 at 8:48 AM HAGIO KAZUHITO(?????)
<k-hagio-ab@nec.com> wrote:
>
> Hi Pingfan,
>
> -----Original Message-----
> > On Wed, Apr 20, 2022 at 11:58:29PM +0000, HAGIO KAZUHITO(?? ??) wrote:
> > > Currently get_mem_section() validates if SYMBOL(mem_section) is the address
> > > of the mem_section array first.  But there was a report that the first
> > > validation wrongly returned TRUE with -x vmlinux and SPARSEMEM_EXTREME
> > > (4.15+) on s390x.  This leads to crash failing statup with the following
> > > seek error:
> > >
> > >   crash: seek error: kernel virtual address: 67fffc2800  type: "memory section root table"
> > >
> > > Skip the first validation when satisfying the conditions.
> > >
> >
> > I still prefer to your V1, which is discussed internally. In which, the
> > logic was made straight forward. And I suggest some slight change to
> > your V1, which folds "-x vmlinux" logic into is_sparsemem_extreme().
> >
> > What about the following: (not tested yet, if it is good, I can test it)
>
> Thanks for your review and suggestion.
>
> The purpose of my patch is to distinguish between SPARSEMEM_EXTREME
> v1 and v2, i.e. whether it has 83e3c48729d9 or not.
>

Not sure about dwarf, but is it possible to utilize the array length
info in is_sparsemem_extreme()?

For SPARSEMEM_EXTREME,
 #ifdef CONFIG_SPARSEMEM_EXTREME
extern struct mem_section *mem_section[NR_SECTION_ROOTS];
 #else
 extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif

And if DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH works, then there is a big
gap between "NR_SECTION_ROOTS * 8-bytes" and "sizeof(struct
mem_section) * NR_SECTION_ROOTS * SECTIONS_PER_ROOT"

Thanks,

Pingfan

> is_sparsemem_extreme() has to return whether it's SPARSEMEM_EXTREME or
> SPARSEMEM, so unfortunately it's not suitable to use that logic in
> the function.
>
> Thanks,
> Kazu
>
> >
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index a2f45c8..3ebe372 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -2240,11 +2240,18 @@ int
> >  is_sparsemem_extreme(void)
> >  {
> >       if ((ARRAY_LENGTH(mem_section)
> > -          == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME()))
> > -         || (ARRAY_LENGTH(mem_section) == NOT_FOUND_STRUCTURE))
> > -             return TRUE;
> > -     else
> > +          == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME())) {
> > +          return TRUE;
> > +     } else if (info->name_vmlinux) {
> > +             unsigned long flag = 0;
> > +
> > +             if (get_symbol_type_name("mem_section", DWARF_INFO_GET_SYMBOL_TYPE,
> > +                             NULL, &flag)
> > +                 && !(flag & TYPE_ARRAY))
> > +                     return TRUE;
> > +     } else {
> >               return FALSE;
> > +     }
> >  }
> >
> >  int
> > @@ -3704,28 +3711,24 @@ get_mem_section(unsigned int mem_section_size, unsigned long *mem_maps,
> >  {
> >       int ret = FALSE;
> >       unsigned long *mem_sec = NULL;
> > +     unsigned long mem_section_ptr = SYMBOL(mem_section);
> >
> >       if ((mem_sec = malloc(mem_section_size)) == NULL) {
> >               ERRMSG("Can't allocate memory for the mem_section. %s\n",
> >                   strerror(errno));
> >               return FALSE;
> >       }
> > -     ret = validate_mem_section(mem_sec, SYMBOL(mem_section),
> > -                                mem_section_size, mem_maps, num_section);
> > -
> > -     if (!ret && is_sparsemem_extreme()) {
> > -             unsigned long mem_section_ptr;
> >
> > +     if (is_sparsemem_extreme()) {
> >               if (!readmem(VADDR, SYMBOL(mem_section), &mem_section_ptr,
> >                            sizeof(mem_section_ptr)))
> >                       goto out;
> > +     }
> >
> > -             ret = validate_mem_section(mem_sec, mem_section_ptr,
> > -                             mem_section_size, mem_maps, num_section);
> > -
> > -             if (!ret)
> > +     ret = validate_mem_section(mem_sec, mem_section_ptr,
> > +             mem_section_size, mem_maps, num_section);
> > +     if (!ret)
> >                       ERRMSG("Could not validate mem_section.\n");
> > -     }
> >  out:
> >       if (mem_sec != NULL)
> >               free(mem_sec);
> > --
> >
> > Thanks,
> >
> >       Pingfan
> >
> > > Reported-by: Dave Wysochanski <dwysocha@redhat.com>
> > > Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> > > ---
> > >  makedumpfile.c | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > index a2f45c84cee3..65d1c7c2f02c 100644
> > > --- a/makedumpfile.c
> > > +++ b/makedumpfile.c
> > > @@ -3698,6 +3698,22 @@ validate_mem_section(unsigned long *mem_sec,
> > >     return ret;
> > >  }
> > >
> > > +/*
> > > + * SYMBOL(mem_section) varies with the combination of memory model and
> > > + * its source:
> > > + *
> > > + * SPARSEMEM
> > > + *   vmcoreinfo: address of mem_section root array
> > > + *   -x vmlinux: address of mem_section root array
> > > + *
> > > + * SPARSEMEM_EXTREME v1
> > > + *   vmcoreinfo: address of mem_section root array
> > > + *   -x vmlinux: address of mem_section root array
> > > + *
> > > + * SPARSEMEM_EXTREME v2 (with 83e3c48729d9 and a0b1280368d1) 4.15+
> > > + *   vmcoreinfo: address of mem_section root array
> > > + *   -x vmlinux: address of pointer to mem_section root array
> > > + */
> > >  static int
> > >  get_mem_section(unsigned int mem_section_size, unsigned long *mem_maps,
> > >             unsigned int num_section)
> > > @@ -3710,12 +3726,27 @@ get_mem_section(unsigned int mem_section_size, unsigned long *mem_maps,
> > >                 strerror(errno));
> > >             return FALSE;
> > >     }
> > > +
> > > +   /*
> > > +    * There was a report that the first validation wrongly returned TRUE
> > > +    * with -x vmlinux and SPARSEMEM_EXTREME v2 on s390x, so skip it.
> > > +    * Howerver, leave the fallback validation as it is for the -i option.
> > > +    */
> > > +   if (is_sparsemem_extreme() && info->name_vmlinux) {
> > > +           unsigned long flag = 0;
> > > +           if (get_symbol_type_name("mem_section", DWARF_INFO_GET_SYMBOL_TYPE,
> > > +                                   NULL, &flag)
> > > +               && !(flag & TYPE_ARRAY))
> > > +                   goto skip_1st_validation;
> > > +   }
> > > +
> > >     ret = validate_mem_section(mem_sec, SYMBOL(mem_section),
> > >                                mem_section_size, mem_maps, num_section);
> > >
> > >     if (!ret && is_sparsemem_extreme()) {
> > >             unsigned long mem_section_ptr;
> > >
> > > +skip_1st_validation:
> > >             if (!readmem(VADDR, SYMBOL(mem_section), &mem_section_ptr,
> > >                          sizeof(mem_section_ptr)))
> > >                     goto out;
> > > --
> > > 2.27.0
> > >


