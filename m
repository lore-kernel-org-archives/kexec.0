Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0JHH-0001Dy-Bz
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 06:39:56 +0000
Received: by mail-io1-xd44.google.com with SMTP id w12so6012155iom.4
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2020 23:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <87ft9i1egt.fsf@linux.ibm.com>
In-Reply-To: <87ft9i1egt.fsf@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 28 Jul 2020 14:39:40 +0800
Message-ID: <CAFgQCTt+oOD7Vw=UKzzWrwucyjrKQr=WWsGzAk3JX60cfXrdpQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] powerpc/pseries: group lmb operation and memblock's
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
To: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Kexec Mailing List <kexec@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>

On Thu, Jul 23, 2020 at 10:41 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > This patch prepares for the incoming patch which swaps the order of KOBJ_
> > uevent and dt's updating.
> >
> > It has no functional effect, just groups lmb operation and memblock's in
> > order to insert dt updating operation easily, and makes it easier to
> > review.
>
> ...
>
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > index 5d545b7..1a3ac3b 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > @@ -355,7 +355,8 @@ static int dlpar_add_lmb(struct drmem_lmb *);
> >  static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> >  {
> >       unsigned long block_sz;
> > -     int rc;
> > +     phys_addr_t base_addr;
> > +     int rc, nid;
> >
> >       if (!lmb_is_removable(lmb))
> >               return -EINVAL;
> > @@ -364,17 +365,19 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> >       if (rc)
> >               return rc;
> >
> > +     base_addr = lmb->base_addr;
> > +     nid = lmb->nid;
> >       block_sz = pseries_memory_block_size();
> >
> > -     __remove_memory(lmb->nid, lmb->base_addr, block_sz);
> > -
> > -     /* Update memory regions for memory remove */
> > -     memblock_remove(lmb->base_addr, block_sz);
> > -
> >       invalidate_lmb_associativity_index(lmb);
> >       lmb_clear_nid(lmb);
> >       lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> >
> > +     __remove_memory(nid, base_addr, block_sz);
> > +
> > +     /* Update memory regions for memory remove */
> > +     memblock_remove(base_addr, block_sz);
> > +
> >       return 0;
> >  }
>
> I don't understand; the commit message should not claim this has no
> functional effect when it changes the order of operations like
> this. Maybe this is an improvement over the current behavior, but it's
> not explained why it would be.
One group of functions, which name contains lmb, are powerpc specific,
and used to form dt.

The other group __remove_memory() and memblock_remove() are integrated
with linux mm.

And [2/2] arrange dt-updating just before __remove_memory()

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
