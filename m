Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6FxJ-0004E6-L5
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:29:30 +0000
Received: by mail-oi0-f48.google.com with SMTP id k23so169198753oih.0
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:29:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXTb-0004it-43@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTb-0004it-43@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 16:59:08 +0530
Message-ID: <CAHB_GuqshsyCJag7XjQVgufkPosEZzBPEhLuiGRYzcW9C++pXw@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 20/32] arm: add maximum number of memory ranges
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
> Add the maximum number of memory ranges to the list of usable memory
> ranges, so that we don't have to carry this around.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 739c906..195b43f 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -46,8 +46,8 @@
>   */
>  static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
>  struct memory_ranges usablemem_rgns = {
> -    .size = 0,
> -    .ranges = crash_memory_ranges,
> +       .max_size = CRASH_MAX_MEMORY_RANGES,
> +       .ranges = crash_memory_ranges,
>  };
>
>  /* memory range reserved for crashkernel */
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
