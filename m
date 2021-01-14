Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l07K1-0003S3-FC
 for kexec@lists.infradead.org; Thu, 14 Jan 2021 18:26:14 +0000
Received: by mail-lf1-x131.google.com with SMTP id o13so9428867lfr.3
 for <kexec@lists.infradead.org>; Thu, 14 Jan 2021 10:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1610612709-18887-1-git-send-email-kazuhito.hagio@gmail.com>
 <1610612709-18887-5-git-send-email-kazuhito.hagio@gmail.com>
 <deecffd0-926a-d7ca-c0b5-87f3b6ad85e5@redhat.com>
In-Reply-To: <deecffd0-926a-d7ca-c0b5-87f3b6ad85e5@redhat.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Thu, 14 Jan 2021 23:55:40 +0530
Message-ID: <CAFTCetR5BsJex=+_aZw60j+haYBThu_KDAOVgVmcwD=zc_UR4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64: support flipped VA and 52-bit kernel VA
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
To: piliu <piliu@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, aadiga@qti.qualcomm.com, Alexander Kamensky <alexander.kamensky42@gmail.com>, Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>, kazuhito.hagio@gmail.com

Hi Kazu,

On Thu, Jan 14, 2021 at 3:33 PM piliu <piliu@redhat.com> wrote:
>
>
>
> On 1/14/21 4:25 PM, kazuhito.hagio@gmail.com wrote:
> > From: Kazuhito Hagio <k-hagio-ab@nec.com>
> >
> > Based on Bhupesh's patch and contains Pingfan's idea.
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> > ---
> >   arch/arm64.c   | 95 ++++++++++++++++++++++++++++++++++++++++++++++++----------
> >   makedumpfile.c |  2 ++
> >   makedumpfile.h |  1 +
> >   3 files changed, 83 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64.c b/arch/arm64.c
> > index 61ec89a..4ece19d 100644
> > --- a/arch/arm64.c
> > +++ b/arch/arm64.c
> > @@ -47,6 +47,8 @@ typedef struct {
> >   static int lpa_52_bit_support_available;
> >   static int pgtable_level;
> >   static int va_bits;
> > +static int vabits_actual;
> > +static int flipped_va;
> >   static unsigned long kimage_voffset;
> >
> >   #define SZ_4K                       4096
> > @@ -58,7 +60,6 @@ static unsigned long kimage_voffset;
> >   #define PAGE_OFFSET_42              ((0xffffffffffffffffUL) << 42)
> >   #define PAGE_OFFSET_47              ((0xffffffffffffffffUL) << 47)
> >   #define PAGE_OFFSET_48              ((0xffffffffffffffffUL) << 48)
> > -#define PAGE_OFFSET_52               ((0xffffffffffffffffUL) << 52)
> >
> >   #define pgd_val(x)          ((x).pgd)
> >   #define pud_val(x)          (pgd_val((x).pgd))
> > @@ -218,12 +219,20 @@ pmd_page_paddr(pmd_t pmd)
> >   #define pte_index(vaddr)            (((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
> >   #define pte_offset(dir, vaddr)              (pmd_page_paddr((*dir)) + pte_index(vaddr) * sizeof(pte_t))
> >
> > +/*
> > + * The linear kernel range starts at the bottom of the virtual address
> > + * space. Testing the top bit for the start of the region is a
> > + * sufficient check and avoids having to worry about the tag.
> > + */
> > +#define is_linear_addr(addr) (flipped_va ?   \
> > +     (!((unsigned long)(addr) & (1UL << (vabits_actual - 1)))) : \
> > +     (!!((unsigned long)(addr) & (1UL << (vabits_actual - 1)))))
> > +
> >   static unsigned long long
> >   __pa(unsigned long vaddr)
> >   {
> > -     if (kimage_voffset == NOT_FOUND_NUMBER ||
> > -                     (vaddr >= PAGE_OFFSET))
> > -             return (vaddr - PAGE_OFFSET + info->phys_base);
> > +     if (kimage_voffset == NOT_FOUND_NUMBER || is_linear_addr(vaddr))
> > +             return ((vaddr & ~PAGE_OFFSET) + info->phys_base);
> >       else
> >               return (vaddr - kimage_voffset);
> >   }
> > @@ -253,6 +262,7 @@ static int calculate_plat_config(void)
> >                       (PAGESIZE() == SZ_64K && va_bits == 42)) {
> >               pgtable_level = 2;
> >       } else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
> > +                     (PAGESIZE() == SZ_64K && va_bits == 52) ||
> >                       (PAGESIZE() == SZ_4K && va_bits == 39) ||
> >                       (PAGESIZE() == SZ_16K && va_bits == 47)) {
> >               pgtable_level = 3;
> > @@ -263,6 +273,7 @@ static int calculate_plat_config(void)
> >                               PAGESIZE(), va_bits);
> >               return FALSE;
> >       }
> > +     DEBUG_MSG("pgtable_level: %d\n", pgtable_level);
> >
> >       return TRUE;
> >   }
> > @@ -383,22 +394,54 @@ get_va_bits_from_stext_arm64(void)
> >       return TRUE;
> >   }
> >
> > +static void
> > +get_page_offset_arm64(void)
> > +{
> > +     ulong page_end;
> > +     int vabits_min;
> > +
> > +     /*
> > +      * See arch/arm64/include/asm/memory.h for more details of
> > +      * the PAGE_OFFSET calculation.
> > +      */
> > +     vabits_min = (va_bits > 48) ? 48 : va_bits;
> > +     page_end = -(1UL << (vabits_min - 1));
> > +
> > +     if (SYMBOL(_stext) > page_end) {
> > +             flipped_va = TRUE;
> > +             info->page_offset = -(1UL << vabits_actual);
> > +     } else {
> > +             flipped_va = FALSE;
> > +             info->page_offset = -(1UL << (vabits_actual - 1));
> > +     }
> > +
> > +     DEBUG_MSG("page_offset   : %lx (from page_end check)\n",
> > +             info->page_offset);
> > +}
> > +
> >   int
> >   get_machdep_info_arm64(void)
> >   {
> > +     /* Check if va_bits is still not initialized. If still 0, call
> > +      * get_versiondep_info() to initialize the same.
> > +      */
> > +     if (!va_bits)
> > +             get_versiondep_info_arm64();
> > +
> >       /* Determine if the PA address range is 52-bits: ARMv8.2-LPA */
> >       if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
> >               info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
> > +             DEBUG_MSG("max_physmem_bits : %ld (vmcoreinfo)\n", info->max_physmem_bits);
> >               if (info->max_physmem_bits == 52)
> >                       lpa_52_bit_support_available = 1;
> > -     } else
> > -             info->max_physmem_bits = 48;
> > +     } else {
> > +             if (va_bits == 52)
> > +                     info->max_physmem_bits = 52; /* just guess */
> > +             else
> > +                     info->max_physmem_bits = 48;
> >
> > -     /* Check if va_bits is still not initialized. If still 0, call
> > -      * get_versiondep_info() to initialize the same.
> > -      */
> > -     if (!va_bits)
> > -             get_versiondep_info_arm64();
> > +             DEBUG_MSG("max_physmem_bits : %ld (guess)\n", info->max_physmem_bits);
> > +     }
> >
> >       if (!calculate_plat_config()) {
> >               ERRMSG("Can't determine platform config values\n");
> > @@ -409,7 +452,6 @@ get_machdep_info_arm64(void)
> >       info->section_size_bits = SECTIONS_SIZE_BITS;
> >
> >       DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
> > -     DEBUG_MSG("max_physmem_bits : %ld\n", info->max_physmem_bits);
> >       DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);
> >
> >       return TRUE;
> > @@ -444,10 +486,33 @@ get_versiondep_info_arm64(void)
> >               return FALSE;
> >       }
> >
> > -     info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +     /*
> > +      * See TCR_EL1, Translation Control Register (EL1) register
> > +      * description in the ARMv8 Architecture Reference Manual.
> > +      * Basically, we can use the TCR_EL1.T1SZ
> > +      * value to determine the virtual addressing range supported
> > +      * in the kernel-space (i.e. vabits_actual) since Linux 5.9.
> > +      */
> > +     if (NUMBER(TCR_EL1_T1SZ) != NOT_FOUND_NUMBER) {
> > +             vabits_actual = 64 - NUMBER(TCR_EL1_T1SZ);
> > +             DEBUG_MSG("vabits_actual : %d (vmcoreinfo)\n", vabits_actual);
> > +     } else if ((va_bits == 52) && (SYMBOL(mem_section) != NOT_FOUND_SYMBOL)) {
> > +             /*
> > +              * Linux 5.4 through 5.10 have the following linear space:
> > +              *  48-bit: 0xffff000000000000 - 0xffff7fffffffffff
> > +              *  58-bit: 0xfff0000000000000 - 0xfff7ffffffffffff
> > +              */
> > +             if (SYMBOL(mem_section) & (1UL << (52 - 1)))
>
> Sorry but I do not think any SYMBOL(x) is inside the range of linear
> mapping address. All of them should be beyond kimage_vaddr.
>
> Having vabits_actual is introduced and precise to resolve
> is_lm_address(), but if it is not available, could we survive?
>
> _PAGE_OFFSET(52) < _PAGE_END(52) < _PAGE_OFFSET(48) < _PAGE_END(48)
> Translating into numbers:
> 0xfff0000000000000 < 0xfff8000000000000 < 0xffff000000000000 <
> 0xffff800000000000
>
> Refer to linux/Documentation/arm64/memory.rst, the line
>      ffffa00010000000      fffff81ffffeffff         ~88TB          vmalloc
>
> It comes to the conclusion that any symbol > SYMBOL(_text) > _PAGE_END(48).
>
> So is_lm_address() can looks like
> if (addr > _PAGE_END(48)), it is kimage
> else, it is linear mapping
>
> So even more aggressive, we can exclude the need of vabits_actual
> totally in this patch.

As Pingfan noted, this approach still has issues and it failed on my
arm64 board in the limited testing I did today.

I will do some more testing tomorrow and come back with an approach
which addresses the same and also takes into account Pingfan's
concerns.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
