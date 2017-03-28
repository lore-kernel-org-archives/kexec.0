Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csrlN-0007ky-Dr
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 14:06:25 +0000
Received: by mail-it0-x22f.google.com with SMTP id 190so19675007itm.0
 for <kexec@lists.infradead.org>; Tue, 28 Mar 2017 07:06:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328110733.GB16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-4-takahiro.akashi@linaro.org>
 <CAKv+Gu8MFxQ8Lk2io7ywfe=em0qTm8MgCAfrFkQFtAoOaiNqkw@mail.gmail.com>
 <20170328110733.GB16309@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Mar 2017 15:05:58 +0100
Message-ID: <CAKv+Gu8_+WR3qrbxX4ZNZwnWDa=rpMgR=hsqzhtyC=n5+0zJUQ@mail.gmail.com>
Subject: Re: [PATCH v34 06/14] arm64: kdump: protect crash dump kernel memory
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Geoff Levand <geoff@infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Pratyush Anand <panand@redhat.com>, Sameer Goel <sgoel@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 March 2017 at 12:07, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> Ard,
>
> On Tue, Mar 28, 2017 at 11:07:05AM +0100, Ard Biesheuvel wrote:
>> On 28 March 2017 at 07:51, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>> > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
>> > are meant to be called by kexec_load() in order to protect the memory
>> > allocated for crash dump kernel once the image is loaded.
>> >
>> > The protection is implemented by unmapping the relevant segments in crash
>> > dump kernel memory, rather than making it read-only as other archs do,
>> > to prevent any corruption due to potential cache alias (with different
>> > attributes) problem.
>> >
>>
>> I think it would be more accurate to replace 'corruption' with
>> 'coherency issues', given that this patch does not solve the issue of
>> writable aliases that may be used to modify the contents of the
>> region, but it does prevent issues related to mismatched attributes
>> (which are arguably a bigger concern)
>
> OK
>
>> > Page-level mappings are consistently used here so that we can change
>> > the attributes of segments in page granularity as well as shrink the region
>> > also in page granularity through /sys/kernel/kexec_crash_size, putting
>> > the freed memory back to buddy system.
>> >
>> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> As a head's up, this patch is going to conflict heavily with patches
>> that are queued up in arm64/for-next/core atm.
>
> I'll look into it later, but
>
>> Some questions below.
>>
>> > ---
>> >  arch/arm64/kernel/machine_kexec.c | 32 +++++++++++---
>> >  arch/arm64/mm/mmu.c               | 90 ++++++++++++++++++++-------------------
>> >  2 files changed, 72 insertions(+), 50 deletions(-)
>> >
>> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> > index bc96c8a7fc79..b63baa749609 100644
>> > --- a/arch/arm64/kernel/machine_kexec.c
>> > +++ b/arch/arm64/kernel/machine_kexec.c
>> > @@ -14,7 +14,9 @@
>> >
>> >  #include <asm/cacheflush.h>
>> >  #include <asm/cpu_ops.h>
>> > +#include <asm/mmu.h>
>> >  #include <asm/mmu_context.h>
>> > +#include <asm/page.h>
>> >
>> >  #include "cpu-reset.h"
>> >
>> > @@ -22,8 +24,6 @@
>> >  extern const unsigned char arm64_relocate_new_kernel[];
>> >  extern const unsigned long arm64_relocate_new_kernel_size;
>> >
>> > -static unsigned long kimage_start;
>> > -
>> >  /**
>> >   * kexec_image_info - For debugging output.
>> >   */
>> > @@ -64,8 +64,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
>> >   */
>> >  int machine_kexec_prepare(struct kimage *kimage)
>> >  {
>> > -       kimage_start = kimage->start;
>> > -
>> >         kexec_image_info(kimage);
>> >
>> >         if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
>> > @@ -183,7 +181,7 @@ void machine_kexec(struct kimage *kimage)
>> >         kexec_list_flush(kimage);
>> >
>> >         /* Flush the new image if already in place. */
>> > -       if (kimage->head & IND_DONE)
>> > +       if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
>> >                 kexec_segment_flush(kimage);
>> >
>> >         pr_info("Bye!\n");
>> > @@ -201,7 +199,7 @@ void machine_kexec(struct kimage *kimage)
>> >          */
>> >
>> >         cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
>> > -               kimage_start, 0);
>> > +               kimage->start, 0);
>> >
>> >         BUG(); /* Should never get here. */
>> >  }
>> > @@ -210,3 +208,25 @@ void machine_crash_shutdown(struct pt_regs *regs)
>> >  {
>> >         /* Empty routine needed to avoid build errors. */
>> >  }
>> > +
>> > +void arch_kexec_protect_crashkres(void)
>> > +{
>> > +       int i;
>> > +
>> > +       kexec_segment_flush(kexec_crash_image);
>> > +
>> > +       for (i = 0; i < kexec_crash_image->nr_segments; i++)
>> > +               set_memory_valid(
>> > +                       __phys_to_virt(kexec_crash_image->segment[i].mem),
>> > +                       kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 0);
>> > +}
>> > +
>> > +void arch_kexec_unprotect_crashkres(void)
>> > +{
>> > +       int i;
>> > +
>> > +       for (i = 0; i < kexec_crash_image->nr_segments; i++)
>> > +               set_memory_valid(
>> > +                       __phys_to_virt(kexec_crash_image->segment[i].mem),
>> > +                       kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 1);
>> > +}
>> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> > index d28dbcf596b6..f6a3c0e9d37f 100644
>> > --- a/arch/arm64/mm/mmu.c
>> > +++ b/arch/arm64/mm/mmu.c
>> > @@ -22,6 +22,8 @@
>> >  #include <linux/kernel.h>
>> >  #include <linux/errno.h>
>> >  #include <linux/init.h>
>> > +#include <linux/ioport.h>
>> > +#include <linux/kexec.h>
>> >  #include <linux/libfdt.h>
>> >  #include <linux/mman.h>
>> >  #include <linux/nodemask.h>
>> > @@ -332,56 +334,31 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>> >                              NULL, debug_pagealloc_enabled());
>> >  }
>> >
>> > -static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
>> > +static void __init __map_memblock(pgd_t *pgd, phys_addr_t start,
>> > +                                 phys_addr_t end, pgprot_t prot,
>> > +                                 bool page_mappings_only)
>> > +{
>> > +       __create_pgd_mapping(pgd, start, __phys_to_virt(start), end - start,
>> > +                            prot, early_pgtable_alloc,
>> > +                            page_mappings_only);
>> > +}
>> > +
>> > +static void __init map_mem(pgd_t *pgd)
>> >  {
>> >         phys_addr_t kernel_start = __pa_symbol(_text);
>> >         phys_addr_t kernel_end = __pa_symbol(__init_begin);
>> > +       struct memblock_region *reg;
>> >
>> >         /*
>> > -        * Take care not to create a writable alias for the
>> > -        * read-only text and rodata sections of the kernel image.
>> > +        * Temporarily marked as NOMAP to skip mapping in the next for-loop
>> >          */
>> > +       memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>> >
>>
>> OK, so the trick is to mark a memblock region NOMAP temporarily, so
>> that we can iterate over the regions more easily?
>> Is that the sole reason for using NOMAP in this series?
>
> Yes. (I followed Mark's suggestion.)
>

OK. It is slightly hacky, but it should work without any problems afaict

> So I assume that my change here will be essentially orthogonal
> with the chnages in for-next/core, at least, in its intent.
>

Yes. The changes should not conflict in fundamental ways, but the code
has changed in ways that git will not be able to deal with.
Unfortunately, that does mean another respin :-(

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
