Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihPMr-0002Y6-6a
 for kexec@lists.infradead.org; Wed, 18 Dec 2019 02:47:20 +0000
Received: by mail-pj1-x1041.google.com with SMTP id s94so646579pjc.1
 for <kexec@lists.infradead.org>; Tue, 17 Dec 2019 18:47:16 -0800 (PST)
Date: Wed, 18 Dec 2019 11:48:50 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 2/3] arm64: kexec: allocate memory space avoiding
 reserved regions
Message-ID: <20191218024849.GA7386@linaro.org>
References: <20190111095946.28070-1-takahiro.akashi@linaro.org>
 <20190111095946.28070-3-takahiro.akashi@linaro.org>
 <20191213200430.uxuebdavpq64scfh@gabell>
 <CACi5LpOKCfgjmxo59sT5bVN0qHvYapy1NRXn0F=_By-vp0g=sA@mail.gmail.com>
 <20191216141606.nhosl4v233mtvu4u@gabell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191216141606.nhosl4v233mtvu4u@gabell>
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Bhupesh Sharma <bhsharma@redhat.com>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>

On Mon, Dec 16, 2019 at 09:16:06AM -0500, Masayoshi Mizuma wrote:
> On Mon, Dec 16, 2019 at 11:22:56AM +0530, Bhupesh Sharma wrote:
> > Thanks Masa,

[...]

> > Since this is an old thread, it would be useful for people looking at
> > the same, if you can add some comments/details about why you think
> > this nit is needed.
> 
> Thank you for your follow up and I'm sorry I didn't explain it.
> mem_regions_alloc_and_exclude() may fail in case realloc() or
> mem_region_exclude() fail, so it would be better to add the error
> handling.
> 
> > 
> > Also if Akashi agrees with the same, it would be better if he could
> > send a rebased version of the patchset (with your comments addressed),
> > so that the same can be picked for upstream kexec-tools cleanly.
> 
> Sounds great!

I have almost forgotten the background of this patch.
If you see that it is still useful, please feel free to re-post it.

Thanks,
-Takahiro Akashi

> - Masa
> 
> > 
> > @Akashi- Hi Akashi, Please let us know your views.
> > 
> > Thanks,
> > Bhupesh
> > 
> > > +                     dbgprintf("%s:-      %016llx - %016llx\n",
> > > > +                                     __func__, start, end);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     fclose(fp);
> > > > +
> > > > +     *range = memranges.ranges;
> > > > +     *ranges = memranges.size;
> > > >
> > > >       /* As a fallback option, we can try determining the PHYS_OFFSET
> > > >        * value from the '/proc/iomem' entries as well.
> > > > @@ -976,52 +1041,15 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
> > > >        * between the user-space and kernel space 'PHYS_OFFSET'
> > > >        * value.
> > > >        */
> > > > -     set_phys_offset(r->start, "iomem");
> > > > +     if (memranges.size)
> > > > +             set_phys_offset(memranges.ranges[0].start, "iomem");
> > > >
> > > > -     dbgprintf("%s: %016llx - %016llx : %s", __func__, r->start,
> > > > -             r->end, str);
> > > > +     dbgprint_mem_range("System RAM ranges;",
> > > > +                             memranges.ranges, memranges.size);
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > -/**
> > > > - * get_memory_ranges_iomem - Try to get the memory ranges from
> > > > - * /proc/iomem.
> > > > - */
> > > > -
> > > > -static int get_memory_ranges_iomem(struct memory_range *array,
> > > > -     unsigned int *count)
> > > > -{
> > > > -     *count = kexec_iomem_for_each_line(NULL,
> > > > -             get_memory_ranges_iomem_cb, array);
> > > > -
> > > > -     if (!*count) {
> > > > -             dbgprintf("%s: failed: No RAM found.\n", __func__);
> > > > -             return EFAILED;
> > > > -     }
> > > > -
> > > > -     return 0;
> > > > -}
> > > > -
> > > > -/**
> > > > - * get_memory_ranges - Try to get the memory ranges some how.
> > > > - */
> > > > -
> > > > -int get_memory_ranges(struct memory_range **range, int *ranges,
> > > > -     unsigned long kexec_flags)
> > > > -{
> > > > -     static struct memory_range array[KEXEC_SEGMENT_MAX];
> > > > -     unsigned int count;
> > > > -     int result;
> > > > -
> > > > -     result = get_memory_ranges_iomem(array, &count);
> > > > -
> > > > -     *range = result ? NULL : array;
> > > > -     *ranges = result ? 0 : count;
> > > > -
> > > > -     return result;
> > > > -}
> > > > -
> > > >  int arch_compat_trampoline(struct kexec_info *info)
> > > >  {
> > > >       return 0;
> > > > --
> > > > 2.19.1
> > > >
> > > >
> > >
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
