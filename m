Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKCKJ-00062X-TN
 for kexec@lists.infradead.org; Tue, 15 Oct 2019 02:12:46 +0000
Received: by mail-ed1-x541.google.com with SMTP id y91so16441143ede.9
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 19:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-17-pasha.tatashin@soleen.com>
 <45a2f0b8-5bac-8b5d-d595-f92e9acb27ad@arm.com>
In-Reply-To: <45a2f0b8-5bac-8b5d-d595-f92e9acb27ad@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 14 Oct 2019 22:12:30 -0400
Message-ID: <CA+CK2bCBEp8Uvm8oF-LJ6hUpJtSYN0xuK6Esd75czYBAWsA5GQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/17] arm64: kexec: configure trans_pgd page table for
 kexec
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > +/* Body of the vector for escalating to EL2 from relocation routine */
> > +extern const unsigned char kexec_el1_sync[];
> > +extern const unsigned long kexec_el1_sync_size;
>
> > +#define KEXEC_EL2_VECTOR_TABLE_SIZE  2048
>
>
> > +#define KEXEC_EL2_SYNC_OFFSET                (KEXEC_EL2_VECTOR_TABLE_SIZE / 2)
>
> Yuck.
>
> Please don't generate one-off vectors like this. Create _all_ of them, and have the ones
> that should never happen spin round a branch. Someone will hit one eventually, its a lot
> easier to work out what happened if it stops on the first fault, instead of executing junk
> and flying off into the weeds.
>
> git grep invalid_vector
>
> Having the vectors at a known offset in the page that does the relocation means you have a
> fair idea what happened from just the PC.

Sure, I will set invalid_vector of every unused part of the table.

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
> > +                             return rc;
> > +                     break;
>
> > +             case IND_SOURCE:
> > +                     rc = trans_pgd_map_page(info, pgdp, __va(addr),
> > +                                             src_va, PAGE_KERNEL);
> > +                     if (rc)
> > +                             return rc;
> > +                     rc = trans_pgd_map_page(info, pgdp, __va(dest),
> > +                                             dst_va, PAGE_KERNEL);
> > +                     if (rc)
> > +                             return rc;
> > +                     dest += PAGE_SIZE;
> > +                     src_va += PAGE_SIZE;
> > +                     dst_va += PAGE_SIZE;
> > +                     len += PAGE_SIZE;
> > +             }
>
> It looks like you're building a swiss cheese.

The userland provides several segments that need to be loaded at
specific physical locations. Each of those segment is mapped with
virtually contiguous source and destinations. We do not have swiss
cheese, even between the segments the VAs are contiguous.

>
> If you disable RODATA_FULL_DEFAULT_ENABLED, the kernel will use block mappings for the
> linear map. This dramatically reduces the amount of memory in use. On Juno running with
> 39bit/4K, there is typically 6G of contiguous memory with no firmware/uefi holes in it.
> This is mapped by 6 1G block mappings, which take up no additional memory.

Kexec loads segments in the common code, and pages for the segments
are allocated one at a time in a special allocator that checks that
the allocated pages are outside of the destination addresses. The
allocations are done one base page at a time:

kimage_load_normal_segment()
  kimage_alloc_page()

Unlike with control pages, it is not simple to change them to use
large pages. The control pages can be allocated as large pages, as
kimage_alloc_normal_control_pages() accepts an "order" argument.

Without overhaul of the common code I do not see how can we benefit
from having large pages here. But even then, imo it is not a high
priority. Performance wise, I do not think we will win anything by
using large mappings here. The only benefit of using large pages here
is to save space. But, we do not waste any space for crash kernel, as
crash kernel does not require relocation, so the only space that we
will space is only for normal reboot, but that means we are about to
be rebooted, and saving space is probably not a high priority.

> For the first go at supporting this in mainline please keep as close as possible to the
> existing hibernate code. Please use the helpers that copy the linear map.
> (if you cant do pa->va in the relocation assembly you'd need to generate a virtually
> addressed structure, which could then use hibernate's relocation assembly)
>
> If all this extra code turns out to be a significant performance improvement, I'd like to
> see the numbers. We can come back to it after we've got the simplest way of running
> kexec's relocation with the MMU on merged.

I had some RFC version of this project where I had a linear map, but
was asked to create mapping only for segments that are being copied.
Which, I think is the right approach here.  The page table is smaller
(when small mappings are used), faster, because copies are not
sparse), and the assembly code is MUCH simpler because all we need to
do if bcopy(src, dst, len)

+3:     copy_page x1, x2, x3, x4, x5, x6, x7, x8, x9, x10
+       sub     x11, x11, #PAGE_SIZE
+       cbnz    x11, 3b                         /* page copy loop */

These 3 lines copy all segments to the correct locations.

> > +static int mmu_relocate_setup(struct kimage *kimage, unsigned long kern_reloc,
> > +                           struct kern_reloc_arg *kern_reloc_arg)
> > +{
> > +     struct trans_pgd_info info = {
> > +             .trans_alloc_page       = kexec_page_alloc,
> > +             .trans_alloc_arg        = kimage,
> > +     };
> > +
> > +     pgd_t *trans_ttbr0 = kexec_page_alloc(kimage);
> > +     pgd_t *trans_ttbr1 = kexec_page_alloc(kimage);
> > +     int rc;
> > +
> > +     if (!trans_ttbr0 || !trans_ttbr1)
> > +             return -ENOMEM;
> > +
> > +     rc = map_segments(kimage, trans_ttbr1, &info,
> > +                       &kern_reloc_arg->copy_len);
> > +     if (rc)
> > +             return rc;
> > +
> > +     /* Map relocation function va == pa */
> > +     rc = trans_pgd_map_page(&info, trans_ttbr0,  __va(kern_reloc),
> > +                             kern_reloc, PAGE_KERNEL_EXEC);
> > +     if (rc)
> > +             return rc;
>
> You can't do this with the page table helpers. We support platforms with no memory in
> range of TTBR0's VA space. See dd006da21646f
>
> You will need some idmapped memory to turn the MMU off on a system that booted at EL1.
> This will need to be in a set of page tables that the helpers can't easily touch - so it
> should only be a single page. (like the arch code's existing idmap - although that may
> have been overwritten).
>
> (I have a machine where this is a problem, if I get the time I will have a stab at making
> hibernate's safe page idmaped).

To be honest, I am a little lost here. Do you mean machine has
physical addresses above ttbr0 VA-range? If so, seems we need  to
reserve few idmapped pages for trans_pgd... But, what to do if all
physical memory is outside of ttbr0 VA-range? Means, we can't use
idmap at all?
Also, reserving is not good because what if user requested kexec
segments to be loaded into idmaped reserved memory..

>
>
> >  int machine_kexec_post_load(struct kimage *kimage)
> >  {
> > +     unsigned long el2_vector = 0;
> >       unsigned long kern_reloc;
> >       struct kern_reloc_arg *kern_reloc_arg;
> > +     int rc = 0;
> > +
> > +     /*
> > +      * Sanity check that relocation function + el2_vector fit into one
> > +      * page.
> > +      */
> > +     if (arm64_relocate_new_kernel_size > KEXEC_EL2_VECTOR_TABLE_SIZE) {
> > +             pr_err("can't fit relocation function and el2_vector in one page");
> > +             return -ENOMEM;
> > +     }
>
> If you need them to fit in one page, why are the separate?
> hibernate does this as a compile time check.

I checked, arm64_relocate_new_kernel_size is not known at compile
time, so unfortunately BUILD_BUG_ON() cannot be used here. However, if
you think this check is ugly, I can put them into separate pages, and
map these pages independently (or do this conditionally when the above
condition fails, which should never happen, as I cannot imagine
arm64_relocate_new_kernel_size to ever grow that big).

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
