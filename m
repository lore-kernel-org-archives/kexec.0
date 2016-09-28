Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp9br-00054r-QN
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 07:48:58 +0000
Received: by mail-pf0-x231.google.com with SMTP id q2so14796055pfj.3
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 00:48:35 -0700 (PDT)
Date: Wed, 28 Sep 2016 00:48:08 -0700
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 1/8] arm64: identify PHYS_OFFSET correctly
Message-ID: <20160928074806.GA5232@localhost>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
 <20160907043401.6403-2-takahiro.akashi@linaro.org>
 <CAHB_GuqcaGxj48RNW_72Q6tMgoat7oRG0LKg0S7mJs8=_Ft8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GuqcaGxj48RNW_72Q6tMgoat7oRG0LKg0S7mJs8=_Ft8Lw@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Sep 27, 2016 at 09:19:51PM +0530, Pratyush Anand wrote:
> On Wed, Sep 7, 2016 at 10:03 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> > Due to the kernel patch[1], the current code will not be able to identify
> 
> [1] is mentioned in cover letter only, not here.

Oops, thanks.

> > the correct value of PHYS_OFFSET if some "reserved" memory region, which
> > is likely to be UEFI runtime services code/data, exists at an address below
> > the first "System RAM" regions.
> >
> > This patch fixes this issue.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  kexec/arch/arm64/iomem.h       |  7 +++++++
> >  kexec/arch/arm64/kexec-arm64.c | 22 +++++++++++++++++-----
> >  2 files changed, 24 insertions(+), 5 deletions(-)
> >  create mode 100644 kexec/arch/arm64/iomem.h
> >
> > diff --git a/kexec/arch/arm64/iomem.h b/kexec/arch/arm64/iomem.h
> > new file mode 100644
> > index 0000000..7fd66eb
> > --- /dev/null
> > +++ b/kexec/arch/arm64/iomem.h
> > @@ -0,0 +1,7 @@
> > +#ifndef IOMEM_H
> > +#define IOMEM_H
> > +
> > +#define SYSTEM_RAM             "System RAM\n"
> > +#define IOMEM_RESERVED         "reserved\n"
> > +
> > +#endif
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > index 7183dac..bc96c76 100644
> > --- a/kexec/arch/arm64/kexec-arm64.c
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -21,6 +21,7 @@
> >  #include "crashdump-arm64.h"
> >  #include "dt-ops.h"
> >  #include "fs2dt.h"
> > +#include "iomem.h"
> >  #include "kexec-syscall.h"
> >  #include "arch/options.h"
> >
> > @@ -465,18 +466,28 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
> >   * get_memory_ranges_iomem_cb - Helper for get_memory_ranges_iomem.
> >   */
> >
> > +static int count_memory_ranges;
> 
> IMHO improving definition of kexec_iomem_for_each_line() and
> callback() for handling NULL match case would have been a better
> choice than introducing a new static variable. callback() can return
> -ve in case of error, 0 in case of no match and 1 in case of (one)
> match.

Maybe. But we have to be careful not to change other arch's results.
Or follow arm's approach.

-Takahiro AKASHI

> ~Pratyush
> 
> > +
> >  static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
> >         unsigned long long base, unsigned long long length)
> >  {
> >         struct memory_range *r;
> >
> > -       if (nr >= KEXEC_SEGMENT_MAX)
> > +       if (count_memory_ranges >= KEXEC_SEGMENT_MAX)
> >                 return -1;
> >
> > -       r = (struct memory_range *)data + nr;
> > -       r->type = RANGE_RAM;
> > +       r = (struct memory_range *)data + count_memory_ranges;
> > +
> > +       if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)))
> > +               r->type = RANGE_RAM;
> > +       else if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
> > +               r->type = RANGE_RESERVED;
> > +       else
> > +               return 0;
> > +
> >         r->start = base;
> >         r->end = base + length - 1;
> > +       count_memory_ranges++;
> >
> >         set_phys_offset(r->start);
> >
> > @@ -493,9 +504,10 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
> >  static int get_memory_ranges_iomem(struct memory_range *array,
> >         unsigned int *count)
> >  {
> > -       *count = kexec_iomem_for_each_line("System RAM\n",
> > -               get_memory_ranges_iomem_cb, array);
> > +       count_memory_ranges = 0;
> > +       kexec_iomem_for_each_line(NULL, get_memory_ranges_iomem_cb, array);
> >
> > +       *count = count_memory_ranges;
> >         if (!*count) {
> >                 dbgprintf("%s: failed: No RAM found.\n", __func__);
> >                 return -EFAILED;
> > --
> > 2.9.0
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
