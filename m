Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9vqV-0000Hl-Dv
 for kexec@lists.infradead.org; Tue, 09 Oct 2018 17:31:01 +0000
Received: by mail-wr1-x441.google.com with SMTP id y11-v6so2722000wrd.4
 for <kexec@lists.infradead.org>; Tue, 09 Oct 2018 10:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805812916.1157.177580438135143788.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180928164108.GE21895@zn.tnic>
In-Reply-To: <20180928164108.GE21895@zn.tnic>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Oct 2018 12:30:33 -0500
Message-ID: <CAErSpo7fO-bNCzxRXtREfs82OKjd0h3Yu8y+Ova7bhe3NyMd=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
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
To: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>, brijesh.singh@amd.com, lijiang@redhat.com, Baoquan He <bhe@redhat.com>, thomas.lendacky@amd.com, Takashi Iwai <tiwai@suse.de>, x86@kernel.org, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, baiyaowei@cmss.chinamobile.com, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, dyoung@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Sep 28, 2018 at 11:42 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Sep 27, 2018 at 09:22:09AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Previously find_next_iomem_res() used "*res" as both an input parameter for
> > the range to search and the type of resource to search for, and an output
> > parameter for the resource we found, which makes the interface confusing.
> >
> > The current callers use find_next_iomem_res() incorrectly because they
> > allocate a single struct resource and use it for repeated calls to
> > find_next_iomem_res().  When find_next_iomem_res() returns a resource, it
> > overwrites the start, end, flags, and desc members of the struct.  If we
> > call find_next_iomem_res() again, we must update or restore these fields.
> > The previous code restored res.start and res.end, but not res.flags or
> > res.desc.
>
> ... which is a sure sign that the design of this thing is not the best one.
>
> >
> > Since the callers did not restore res.flags, if they searched for flags
> > IORESOURCE_MEM | IORESOURCE_BUSY and found a resource with flags
> > IORESOURCE_MEM | IORESOURCE_BUSY | IORESOURCE_SYSRAM, the next search would
> > incorrectly skip resources unless they were also marked as
> > IORESOURCE_SYSRAM.
>
> Nice example!
>
> > Fix this by restructuring the interface so it takes explicit "start, end,
> > flags" parameters and uses "*res" only as an output parameter.
> >
> > Original-patch: http://lore.kernel.org/lkml/20180921073211.20097-2-lijiang@redhat.com
> > Based-on-patch-by: Lianbo Jiang <lijiang@redhat.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  kernel/resource.c |   94 +++++++++++++++++++++++------------------------------
> >  1 file changed, 41 insertions(+), 53 deletions(-)
> >
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 155ec873ea4d..9891ea90cc8f 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -319,23 +319,26 @@ int release_resource(struct resource *old)
> >  EXPORT_SYMBOL(release_resource);
> >
> >  /*
>
> I guess this could be made kernel-doc, since you're touching it...
>
> > - * Finds the lowest iomem resource existing within [res->start..res->end].
> > - * The caller must specify res->start, res->end, res->flags, and optionally
> > - * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
> > - * This function walks the whole tree and not just first level children until
> > - * and unless first_level_children_only is true.
> > + * Finds the lowest iomem resource that covers part of [start..end].  The
> > + * caller must specify start, end, flags, and desc (which may be
> > + * IORES_DESC_NONE).
> > + *
> > + * If a resource is found, returns 0 and *res is overwritten with the part
> > + * of the resource that's within [start..end]; if none is found, returns
> > + * -1.
> > + *
> > + * This function walks the whole tree and not just first level children
> > + * unless first_level_children_only is true.
>
> ... and then prepend that with '@' - @first_level_children_only to refer
> to the function parameter.
>
> >   */
> > -static int find_next_iomem_res(struct resource *res, unsigned long desc,
> > -                            bool first_level_children_only)
> > +static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> > +                            unsigned long flags, unsigned long desc,
> > +                            bool first_level_children_only,
> > +                            struct resource *res)
> >  {
> > -     resource_size_t start, end;
> >       struct resource *p;
> >       bool sibling_only = false;
> >
> >       BUG_ON(!res);
> > -
> > -     start = res->start;
> > -     end = res->end;
> >       BUG_ON(start >= end);
>
> And since we're touching this, maybe replace that BUG_ON() fun with
> simply return -EINVAL or some error code...
>
> >
> >       if (first_level_children_only)
>
>         if (first_level_children_only)
>                 sibling_only = true;
>
> So this is just silly - replacing a bool function param with a local bool
> var.
>
> You could kill that, shorten first_level_children_only's name and use it
> directly.
>
> Depending on how much cleanup it amounts to, you could make that a
> separate cleanup patch ontop, to keep the changes from the cleanup
> separate.
>
> > @@ -344,7 +347,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> >       read_lock(&resource_lock);
> >
> >       for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
> > -             if ((p->flags & res->flags) != res->flags)
> > +             if ((p->flags & flags) != flags)
> >                       continue;
> >               if ((desc != IORES_DESC_NONE) && (desc != p->desc))
> >                       continue;
> > @@ -359,32 +362,31 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> >       read_unlock(&resource_lock);
> >       if (!p)
> >               return -1;
> > +
> >       /* copy data */
> > -     if (res->start < p->start)
> > -             res->start = p->start;
> > -     if (res->end > p->end)
> > -             res->end = p->end;
> > +     res->start = max(start, p->start);
> > +     res->end = min(end, p->end);
>
> Should we use the min_t and max_t versions here for typechecking?
>
> >       res->flags = p->flags;
> >       res->desc = p->desc;
> >       return 0;
> >  }
> >
> > -static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
> > -                              bool first_level_children_only,
> > -                              void *arg,
> > +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> > +                              unsigned long flags, unsigned long desc,
> > +                              bool first_level_children_only, void *arg,
> >                                int (*func)(struct resource *, void *))
> >  {
> > -     u64 orig_end = res->end;
> > +     struct resource res;
> >       int ret = -1;
> >
> > -     while ((res->start < res->end) &&
> > -            !find_next_iomem_res(res, desc, first_level_children_only)) {
> > -             ret = (*func)(res, arg);
> > +     while (start < end &&
> > +            !find_next_iomem_res(start, end, flags, desc,
> > +                                 first_level_children_only, &res)) {
> > +             ret = (*func)(&res, arg);
> >               if (ret)
> >                       break;
> >
> > -             res->start = res->end + 1;
> > -             res->end = orig_end;
> > +             start = res.end + 1;
> >       }
> >
> >       return ret;
> > @@ -407,13 +409,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
> >  int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
> >               u64 end, void *arg, int (*func)(struct resource *, void *))
>
> Align that function's parameters on the opening brace, pls, while you're
> at it.
>
> >  {
> > -     struct resource res;
> > -
> > -     res.start = start;
> > -     res.end = end;
> > -     res.flags = flags;
> > -
> > -     return __walk_iomem_res_desc(&res, desc, false, arg, func);
> > +     return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
> >  }
> >  EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
> >
> > @@ -427,13 +423,9 @@ EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
> >  int walk_system_ram_res(u64 start, u64 end, void *arg,
> >                               int (*func)(struct resource *, void *))
>
> Ditto.
>
> >  {
> > -     struct resource res;
> > -
> > -     res.start = start;
> > -     res.end = end;
> > -     res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +     unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >
> > -     return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
> > +     return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> >                                    arg, func);
> >  }
> >
> > @@ -444,13 +436,9 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
> >  int walk_mem_res(u64 start, u64 end, void *arg,
> >                int (*func)(struct resource *, void *))
> >  {
> > -     struct resource res;
> > -
> > -     res.start = start;
> > -     res.end = end;
> > -     res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > +     unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >
> > -     return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
> > +     return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> >                                    arg, func);
> >  }
> >
> > @@ -464,25 +452,25 @@ int walk_mem_res(u64 start, u64 end, void *arg,
> >  int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> >               void *arg, int (*func)(unsigned long, unsigned long, void *))
>
> Ditto.
>
> With that addressed:
>
> Reviewed-by: Borislav Petkov <bp@suse.de>
>
> All good stuff and a charm to review, lemme know if I should take them
> or you can carry them.

Sorry, I don't know what happened here because I didn't see these
comments until today.  I suspect what happened was that my Gmail
filter auto-filed them in my linux-kernel folder, which I don't read.
On my @google.com account, I have another filter that pull out things
addressed directly to me, which I *do* read.  But this thread didn't
cc that account until the tip-bot message, which *did* cc my @google
account because that's how I signed off the patches.  Sigh.

Anyway, it looks like this stuff is on its way; let me know
(bhelgaas@google.com) if I should do anything else.  I would address
your comments above, but since this seems to be applied and I saw a
cleanup patch from you, I assume you already took care of them.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
