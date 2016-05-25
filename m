Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5Tkz-0003fF-Vt
 for kexec@lists.infradead.org; Wed, 25 May 2016 08:01:35 +0000
Received: by mail-oi0-f53.google.com with SMTP id j1so66121321oih.3
 for <kexec@lists.infradead.org>; Wed, 25 May 2016 01:01:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXT5-0004iJ-VX@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXT5-0004iJ-VX@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 13:31:12 +0530
Message-ID: <CAHB_GuqVx4v3o4J=_PqQw=FFJmeXQ_LQPAKGADxL+bgRFor=0w@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 14/32] arm: fix off-by-one on memory end
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
Cc: geoff@infradead.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> The memory range end is inclusive, not exclusive (see x86).  We should
> not be adding one to the value parsed from the /proc/iomem resources.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

I think, this also need to be fixed for ARM64 patches. +Geoff

> ---
>  kexec/arch/arm/kexec-arm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
> index 4e90e69..e47fc00 100644
> --- a/kexec/arch/arm/kexec-arm.c
> +++ b/kexec/arch/arm/kexec-arm.c
> @@ -51,7 +51,6 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>                 if (count != 2)
>                         continue;
>                 str = line + consumed;
> -               end = end + 1;
>
>                 if (memcmp(str, "System RAM\n", 11) == 0) {
>                         type = RANGE_RAM;
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
