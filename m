Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6G5e-0004Gv-Sy
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:38:07 +0000
Received: by mail-oi0-f44.google.com with SMTP id w184so162560913oiw.2
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:37:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXUG-0004jg-PD@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUG-0004jg-PD@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 17:07:46 +0530
Message-ID: <CAHB_GuqYApGpL1v-4mLUJ-iZcs9k-jg8DFedG8_S+Mat4mVoRA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 28/32] arm: add support for boot-time crash
 kernel resource
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
> Add support for detecting and using the boot-time crash kernel
> resource, which is needed for systems which have special boot-time
> memory views, such as Keystone 2.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 9113f5e..25fdbe9 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -52,7 +52,7 @@ struct memory_ranges usablemem_rgns = {
>         .ranges = crash_memory_ranges,
>  };
>
> -/* memory range reserved for crashkernel */
> +/* The boot-time physical memory range reserved for crashkernel region */
>  static struct memory_range crash_kernel_mem;
>
>  /* reserved regions */
> @@ -366,13 +366,22 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
>                                 char *str, unsigned long long base,
>                                 unsigned long long length)
>  {
> -       if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> +       if (strncmp(str, CRASH_KERNEL_BOOT, strlen(CRASH_KERNEL_BOOT)) == 0) {
>                 crash_kernel_mem.start = base;
>                 crash_kernel_mem.end = base + length - 1;
>                 crash_kernel_mem.type = RANGE_RAM;
>                 return mem_regions_add(&crash_reserved_rgns,
>                                        base, length, RANGE_RAM);
>         }
> +       else if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
> +               if (crash_kernel_mem.start == crash_kernel_mem.end) {
> +                       crash_kernel_mem.start = base;
> +                       crash_kernel_mem.end = base + length - 1;
> +                       crash_kernel_mem.type = RANGE_RAM;
> +               }
> +               return mem_regions_add(&crash_reserved_rgns,
> +                                      base, length, RANGE_RAM);
> +       }
>         else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
>                 return mem_regions_add(&usablemem_rgns,
>                                        base, length, RANGE_RAM);
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
