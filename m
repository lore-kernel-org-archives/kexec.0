Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6Fwn-0003yV-JI
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:28:58 +0000
Received: by mail-oi0-f50.google.com with SMTP id k23so169182332oih.0
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:28:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 16:58:36 +0530
Message-ID: <CAHB_GuqhPgA37LoWn48Oj6vNgQP=enCNUUp-bF1sgk8uHvc-pg@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 19/32] arm: add memory ranges debug
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
> Add the call to dbgprint_mem_range() into the ARM version of
> get_memory_ranges().
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
> index e47fc00..eeb27b4 100644
> --- a/kexec/arch/arm/kexec-arm.c
> +++ b/kexec/arch/arm/kexec-arm.c
> @@ -70,6 +70,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>         fclose(fp);
>         *range = memory_range;
>         *ranges = memory_ranges;
> +
> +       dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
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
