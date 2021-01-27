Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4nz7-0006JX-Pi
 for kexec@lists.infradead.org; Wed, 27 Jan 2021 16:48:03 +0000
Received: by mail-ej1-x629.google.com with SMTP id bl23so3601199ejb.5
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2021 08:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <20210125191923.1060122-17-pasha.tatashin@soleen.com>
 <d5b91732-1985-4d90-89a1-4873deaa5592@soleen.com>
 <20210127164230.GA584465@sequoia>
In-Reply-To: <20210127164230.GA584465@sequoia>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 27 Jan 2021 11:47:24 -0500
Message-ID: <CA+CK2bA6k_RMiX7P2ptO-yK8pU2w9tABA+p6QxNKRwvmEemuKw@mail.gmail.com>
Subject: Re: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table
 for kexec
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
To: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, rfontana@redhat.com, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 27, 2021 at 11:42 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> On 2021-01-25 19:21:22, Pavel Tatashin wrote:
> > I forgot to make changes to arch/arm64/Kconfig. The correct patch is
> > below.
> >
> > ---
> >
> > From a2bc374320d7c7efd3c40644ad3d6d59a024b301 Mon Sep 17 00:00:00 2001
> > From: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Date: Mon, 29 Jul 2019 21:24:25 -0400
> > Subject: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table for
> >  kexec
> >
> > Configure a page table located in kexec-safe memory that has
> > the following mappings:
> >
> > 1. identity mapping for text of relocation function with executable
> >    permission.
> > 2. va mappings for all source ranges
> > 3. va mappings for all destination ranges.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/Kconfig                |  2 +-
> >  arch/arm64/include/asm/kexec.h    | 12 ++++
> >  arch/arm64/kernel/asm-offsets.c   |  6 ++
> >  arch/arm64/kernel/machine_kexec.c | 91 ++++++++++++++++++++++++++++++-
> >  4 files changed, 109 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fc0ed9d6e011..440abd0c0ee1 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1134,7 +1134,7 @@ config CRASH_DUMP
> >
> >  config TRANS_TABLE
> >       def_bool y
> > -     depends on HIBERNATION
> > +     depends on HIBERNATION || KEXEC_CORE
> >
> >  config XEN_DOM0
> >       def_bool y
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index b96d8a6aac80..049cde429b1b 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -105,6 +105,12 @@ extern const char arm64_kexec_el2_vectors[];
> >   * el2_vector        If present means that relocation routine will go to EL1
> >   *           from EL2 to do the copy, and then back to EL2 to do the jump
> >   *           to new world.
> > + * trans_ttbr0       idmap for relocation function and its argument
> > + * trans_ttbr1       map for source/destination addresses.
> > + * trans_t0sz        t0sz for idmap page in trans_ttbr0
> > + * src_addr  start address for source pages.
> > + * dst_addr  start address for destination pages.
> > + * copy_len  Number of bytes that need to be copied
> >   */
> >  struct kern_reloc_arg {
> >       phys_addr_t head;
> > @@ -114,6 +120,12 @@ struct kern_reloc_arg {
> >       phys_addr_t kern_arg2;
> >       phys_addr_t kern_arg3;
> >       phys_addr_t el2_vector;
> > +     phys_addr_t trans_ttbr0;
> > +     phys_addr_t trans_ttbr1;
> > +     unsigned long trans_t0sz;
> > +     unsigned long src_addr;
> > +     unsigned long dst_addr;
> > +     unsigned long copy_len;
> >  };
> >
> >  #define ARCH_HAS_KIMAGE_ARCH
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 8a9475be1b62..06278611451d 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -160,6 +160,12 @@ int main(void)
> >    DEFINE(KEXEC_KRELOC_KERN_ARG2,     offsetof(struct kern_reloc_arg, kern_arg2));
> >    DEFINE(KEXEC_KRELOC_KERN_ARG3,     offsetof(struct kern_reloc_arg, kern_arg3));
> >    DEFINE(KEXEC_KRELOC_EL2_VECTOR,    offsetof(struct kern_reloc_arg, el2_vector));
> > +  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,   offsetof(struct kern_reloc_arg, trans_ttbr0));
> > +  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,   offsetof(struct kern_reloc_arg, trans_ttbr1));
> > +  DEFINE(KEXEC_KRELOC_TRANS_T0SZ,    offsetof(struct kern_reloc_arg, trans_t0sz));
> > +  DEFINE(KEXEC_KRELOC_SRC_ADDR,      offsetof(struct kern_reloc_arg, src_addr));
> > +  DEFINE(KEXEC_KRELOC_DST_ADDR,      offsetof(struct kern_reloc_arg, dst_addr));
> > +  DEFINE(KEXEC_KRELOC_COPY_LEN,      offsetof(struct kern_reloc_arg, copy_len));
> >  #endif
> >    return 0;
> >  }
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 41d1e3ca13f8..dc1b7e5a54fb 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -21,6 +21,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/page.h>
> >  #include <asm/sections.h>
> > +#include <asm/trans_pgd.h>
> >
> >  #include "cpu-reset.h"
> >
> > @@ -71,11 +72,91 @@ static void *kexec_page_alloc(void *arg)
> >       return page_address(page);
> >  }
> >
> > +/*
> > + * Map source segments starting from src_va, and map destination
> > + * segments starting from dst_va, and return size of copy in
> > + * *copy_len argument.
> > + * Relocation function essentially needs to do:
> > + * memcpy(dst_va, src_va, copy_len);
> > + */
> > +static int map_segments(struct kimage *kimage, pgd_t *pgdp,
> > +                     struct trans_pgd_info *info,
> > +                     unsigned long src_va,
> > +                     unsigned long dst_va,
> > +                     unsigned long *copy_len)
> > +{
> > +     unsigned long *ptr = 0;
> > +     unsigned long dest = 0;
> > +     unsigned long len = 0;
> > +     unsigned long entry, addr;
> > +     int rc;
> > +
> > +     for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
> > +             addr = entry & PAGE_MASK;
> > +
> > +             switch (entry & IND_FLAGS) {
> > +             case IND_DESTINATION:
> > +                     dest = addr;
> > +                     break;
> > +             case IND_INDIRECTION:
> > +                     ptr = __va(addr);
> > +                     if (rc)
>
> We're checking a potentially uninitialized value here. I think this
> whole "if (rc) return rc;" conditional can go away.

Thank you Tyler. This is indeed not needed.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
