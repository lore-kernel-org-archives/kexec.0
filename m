Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9F6-0004ou-VY
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:18:05 +0000
Received: by mail-oi0-f41.google.com with SMTP id x201so119809992oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:17:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviEe-0000if-VZ@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviEe-0000if-VZ@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 19:47:43 +0530
Message-ID: <CAHB_GuqsoZn=i8KXtiuD5oiVAb5vj+gAr_apOtuFiEwiwPREGw@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: kexec: fix crashkernel= handling
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
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Thu, Apr 28, 2016 at 2:57 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

[...]

> +   On arm, the use of "crashkernel=Y@X" is no longer necessary; the
> +   kernel will automatically locate the crash kernel image within the
> +   first 512MB of RAM if X is not given.
>
>
>  Load the Dump-capture Kernel
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 139791ed473d..77b54c461c52 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -938,6 +938,13 @@ static int __init init_machine_late(void)
>  late_initcall(init_machine_late);
>
>  #ifdef CONFIG_KEXEC
> +/*
> + * The crash region must be aligned to 128MB to avoid
> + * zImage relocating below the reserved region.
> + */
> +#define CRASH_ALIGN    (128 << 20)
> +#define CRASH_ADDR_MAX (PHYS_OFFSET + (512 << 20))
> +
>  static inline unsigned long long get_total_mem(void)
>  {
>         unsigned long total;
> @@ -965,6 +972,28 @@ static void __init reserve_crashkernel(void)
>         if (ret)
>                 return;
>
> +       if (crash_base <= 0) {
> +               unsigned long long crash_max = CRASH_ADDR_MAX;
> +               if (crash_max > (u32)~0)
> +                       crash_max = (u32)~0;
> +               crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,

Although it does not matter, memblock_find_in_range would be able to
locate correct free area even when there is no valid RAM at address
CRASH_ALIGN. However passing PHYS_OFFSET as start argument may be more
readable probably.

> +                                                   crash_size, CRASH_ALIGN);
> +               if (!crash_base) {
> +                       pr_err("crashkernel reservation failed - No suitable area found.\n");
> +                       return;
> +               }
> +       } else {
> +               unsigned long long start;
> +
> +               start = memblock_find_in_range(crash_base,
> +                                              crash_base + crash_size,
> +                                              crash_size, SECTION_SIZE);
> +               if (start != crash_base) {
> +                       pr_err("crashkernel reservation failed - memory is in use.\n");
> +                       return;
> +               }
> +       }
> +
>         ret = memblock_reserve(crash_base, crash_size);
>         if (ret < 0) {
>                 pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
> --

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
