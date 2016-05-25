Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5TkB-0003A5-Ik
 for kexec@lists.infradead.org; Wed, 25 May 2016 08:00:45 +0000
Received: by mail-oi0-f54.google.com with SMTP id b65so66252198oia.1
 for <kexec@lists.infradead.org>; Wed, 25 May 2016 01:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXSq-0004hx-8H@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSq-0004hx-8H@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 13:30:27 +0530
Message-ID: <CAHB_Gur=Lf7-wX+=ddfEwXrC7U0mduSGTbV2hPp4HSG7nx-8yA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 11/32] kexec: add mem_regions sorting
 implementation
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add a mem_regions sorting implementation taken from the arm code.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/mem_regions.c | 27 +++++++++++++++++++++++++++
>  kexec/mem_regions.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index a4952ff..804984a 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -1,6 +1,33 @@
> +#include <stdlib.h>
> +
>  #include "kexec.h"
>  #include "mem_regions.h"
>
> +static int mem_range_cmp(const void *a1, const void *a2)
> +{
> +       const struct memory_range *r1 = a1;
> +       const struct memory_range *r2 = a2;
> +
> +       if (r1->start > r2->start)
> +               return 1;
> +       if (r1->start < r2->start)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +/**
> + * mem_regions_sort() - sort ranges into ascending address order
> + * @ranges: ranges to sort
> + *
> + * Sort the memory regions into ascending address order.
> + */
> +void mem_regions_sort(struct memory_ranges *ranges)
> +{
> +       qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
> +             mem_range_cmp);
> +}
> +
>  /**
>   * mem_regions_add() - add a memory region to a set of ranges
>   * @ranges: ranges to add the memory region to
> diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
> index b9cfba1..da7b5e8 100644
> --- a/kexec/mem_regions.h
> +++ b/kexec/mem_regions.h
> @@ -3,6 +3,8 @@
>
>  struct memory_ranges;
>
> +void mem_regions_sort(struct memory_ranges *ranges);
> +
>  int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
>                      unsigned long long length, int type);
>
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
