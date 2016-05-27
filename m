Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6G3J-0002aX-EX
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:35:42 +0000
Received: by mail-oi0-f45.google.com with SMTP id j1so169172250oih.3
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:35:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXUL-0004jm-W0@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUL-0004jm-W0@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 17:05:20 +0530
Message-ID: <CAHB_Guqj8p07CM9mJTHDYDVC2s+6sLQn30JP8qBxOig8rV_RrQ@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 29/32] arm: add debug of reserved and coredump
 memory ranges
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

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add debug of the reserved and coredump memory ranges for validation.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 25fdbe9..2dc8846 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -158,6 +158,10 @@ static int crash_get_memory_ranges(void)
>                 return -1;
>         }
>
> +       dbgprint_mem_range("Reserved memory ranges",
> +                          crash_reserved_rgns.ranges,
> +                          crash_reserved_rgns.size);
> +
>         /*
>          * Exclude all reserved memory from the usable memory regions.
>          * We want to avoid dumping the crashkernel region itself.  Note
> @@ -179,6 +183,9 @@ static int crash_get_memory_ranges(void)
>          */
>         mem_regions_sort(&usablemem_rgns);
>
> +       dbgprint_mem_range("Coredump memory ranges",
> +                          usablemem_rgns.ranges, usablemem_rgns.size);
> +
>         return 0;
>  }
>
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
