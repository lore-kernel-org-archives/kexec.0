Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6Fz0-0006eA-E3
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:31:15 +0000
Received: by mail-oi0-f52.google.com with SMTP id w184so162337125oiw.2
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXTl-0004j5-II@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTl-0004j5-II@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 17:00:53 +0530
Message-ID: <CAHB_GuowUMo62_AQ2g3FxSW8YZXa4wQgt6oSwJvm_RVtt0+PaQ@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 22/32] arm: use generic mem_region sorting
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
> Use the generic mem_region sorting implementation.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 85afd9f..d6db566 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -202,19 +202,6 @@ static void crash_exclude_range(void)
>         }
>  }
>
> -static int range_cmp(const void *a1, const void *a2)
> -{
> -       const struct memory_range *r1 = a1;
> -       const struct memory_range *r2 = a2;
> -
> -       if (r1->start > r2->start)
> -               return 1;
> -       if (r1->start < r2->start)
> -               return -1;
> -
> -       return 0;
> -}
> -
>  /**
>   * crash_get_memory_ranges() - read system physical memory
>   *
> @@ -246,8 +233,7 @@ static int crash_get_memory_ranges(void)
>         /*
>          * Make sure that the memory regions are sorted.
>          */
> -       qsort(usablemem_rgns.ranges, usablemem_rgns.size,
> -             sizeof(*usablemem_rgns.ranges), range_cmp);
> +       mem_regions_sort(&usablemem_rgns);
>
>         return 0;
>  }
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
