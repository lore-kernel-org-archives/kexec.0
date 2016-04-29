Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9H4-0005h8-9n
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:20:07 +0000
Received: by mail-ob0-f180.google.com with SMTP id bg3so55854410obb.1
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:19:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviEp-0000ir-7s@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviEp-0000ir-7s@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 19:49:45 +0530
Message-ID: <CAHB_GuqOvRof94QdHztPy2B2kKuyKzQ-9uxXHY_g+i5WxsexZg@mail.gmail.com>
Subject: Re: [PATCH 03/12] ARM: kexec: remove 512MB restriction on kexec
 crashdump
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

On Thu, Apr 28, 2016 at 2:57 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 77b54c461c52..d9317eec1eba 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -943,7 +943,6 @@ late_initcall(init_machine_late);
>   * zImage relocating below the reserved region.
>   */
>  #define CRASH_ALIGN    (128 << 20)
> -#define CRASH_ADDR_MAX (PHYS_OFFSET + (512 << 20))
>
>  static inline unsigned long long get_total_mem(void)
>  {
> @@ -973,9 +972,7 @@ static void __init reserve_crashkernel(void)
>                 return;
>
>         if (crash_base <= 0) {
> -               unsigned long long crash_max = CRASH_ADDR_MAX;
> -               if (crash_max > (u32)~0)
> -                       crash_max = (u32)~0;
> +               unsigned long long crash_max = idmap_to_phys((u32)~0);
>                 crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
>                                                     crash_size, CRASH_ALIGN);
>                 if (!crash_base) {

Reviewed-by: Pratyush Anand <panand@redhat.com>

Unrelated to these modification:
In function arch/arm/mm/init.c: arm_memblock_steal() may be  following
would be more appropriate?
memblock_alloc_base(size, align, idmap_to_phys(MEMBLOCK_ALLOC_ANYWHERE));

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
