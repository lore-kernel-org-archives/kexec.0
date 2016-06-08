Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Jun 2016 10:22:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH kexec-tools v2 10/32] kexec: add generic helper to add to
 memory_regions
Message-ID: <20160608012257.GA28638@verge.net.au>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xsE-0003sO-FZ@e0050434b2927.dyn.armlinux.org.uk>
 <20160608011344.GA3321@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160608011344.GA3321@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk@arm.linux.org.uk>

On Wed, Jun 08, 2016 at 09:13:44AM +0800, Baoquan He wrote:
> On 06/06/16 at 05:59pm, Russell King wrote:
> > diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> > new file mode 100644
> > index 0000000..a4952ff
> > --- /dev/null
> > +++ b/kexec/mem_regions.c
> > @@ -0,0 +1,30 @@
> > +#include "kexec.h"
> > +#include "mem_regions.h"
> > +
> > +/**
> > + * mem_regions_add() - add a memory region to a set of ranges
> > + * @ranges: ranges to add the memory region to
> > + * @max: maximum number of entries in memory region
> 
> This need be removed. It should be a remnant of intermediate attempt.

Russell,

Please fix this as a follow-up patch as I applied the series earlier
this morning.

> > + * @base: base address of memory region
> > + * @length: length of memory region in bytes
> > + * @type: type of memory region
> > + *
> > + * Add the memory region to the set of ranges, and return %0 if successful,
> > + * or %-1 if we ran out of space.
> > + */
> > +int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
> > +                    unsigned long long length, int type)
> > +{
> > +	struct memory_range *range;
> > +
> > +	if (ranges->size >= ranges->max_size)
> > +		return -1;
> > +
> > +	range = ranges->ranges + ranges->size++;
> > +	range->start = base;
> > +	range->end = base + length - 1;
> > +	range->type = type;
> > +
> > +	return 0;
> > +}
> > +
> > diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
> > new file mode 100644
> > index 0000000..b9cfba1
> > --- /dev/null
> > +++ b/kexec/mem_regions.h
> > @@ -0,0 +1,9 @@
> > +#ifndef MEM_REGIONS_H
> > +#define MEM_REGIONS_H
> > +
> > +struct memory_ranges;
> > +
> > +int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
> > +                    unsigned long long length, int type);
> > +
> > +#endif
> > -- 
> > 1.9.1
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
