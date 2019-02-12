Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfTC-0007tN-Gn
 for kexec@lists.infradead.org; Tue, 12 Feb 2019 21:20:00 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit
 PA support)
Date: Tue, 12 Feb 2019 21:15:26 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03568377@BPXM09GP.gisp.nec.co.jp>
References: <1549484034-17027-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567FF6@BPXM09GP.gisp.nec.co.jp>
 <887cb122-0c2e-5fdd-ea54-ecf8adf3cd79@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035682A9@BPXM09GP.gisp.nec.co.jp>
 <0b95bba3-11ab-0bb7-df0a-67ddc0150548@redhat.com>
In-Reply-To: <0b95bba3-11ab-0bb7-df0a-67ddc0150548@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

On 2/12/2019 2:22 PM, Bhupesh Sharma wrote:
> >>>>> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))

> > I agree to sync these macros with the kernel, but currently this one
> > is not used in your patches, and you wrote the path of the source file
> > (pgtable-hwdef.h) above for reference, so we don't need to import this
> > one for now. I'd like to import it when it is needed.
> 
> Ok, now I understand. You mean 'ARM64_HW_PGTABLE_LEVELS' macro here only
> and not 'ARM64_HW_PGTABLE_LEVEL_SHIFT' macro also, right? If yes, I
> agree to removing the former. Will fix this in v2.

Yes, it's the ARM64_HW_PGTABLE_LEVELS macro only.

> > My understanding is that with 64k page, we can convert a page table
> > entry to a physicall address without awareness of 52-bit.
> >
> > According to this patch, the top 4 bits of a 52-bit physical address
> > are positioned at bits 12..15 of a page table entry.
> >
> > commit 75387b92635e7dca410c1ef92cfe510019248f76
> > Author: Kristina Martsenko <kristina.martsenko@arm.com>
> > Date:   Wed Dec 13 17:07:21 2017 +0000
> >
> >      arm64: handle 52-bit physical addresses in page table entries
> >
> >      The top 4 bits of a 52-bit physical address are positioned at bits
> >      12..15 of a page table entry. Introduce macros to convert between a
> >      physical address and its placement in a table entry, and change all
> >      macros/functions that access PTEs to use them.
> >
> > With 64k page and non-52-bit kernel, it looks like the bits 12..15
> > are zero, so we can move the zeros to bits 49..51 because the zeros
> > don't affect the PA, for example:
> >
> >        52-bit              non-52-bit (48-bit)
> >    PTE 0x0000123456789000  0x0000123456780000
> >             v--------^          v--------^   __pte_to_phys() w/52-bit support
> >    PA  0x0009123456780000  0x0000123456780000
> >
> > I think that this was what the upstream maintainers said..
> > But "if (lpa_52_bit_support_available)" is also fine for me.
> 
> Well from my experience on arm32 and arm64 hardware enablement, assuming
> values of implementation defined fields for arm hardware can be risky :)
> 
> Lets see what the ARMv8 architecture reference manual says about the
> Bits [15:12] for a 64KB page size:
> 
> "Bits[15:12] of each valid translation table descriptor hold bits[51:48]
> of the output address, or of the address of the translation table to be
> used for the initial lookup at the next level of translation. If the
> implementation does not support 52-bit physical addresses, then it is
> IMPLEMENTATION DEFINED whether non-zero values for these bits generate
> an Address size fault."
> 
> So, it is unsafe to assume that for a 48-bit physical address
> implementation the Bits[15:12] cannot have non-zero values on certain
> hardware implementations. So assuming that these bits are always 0 and
> can be easily moved to Bits[51:48] for a 64K page and non-52bit kernel,
> can lead to IMPLEMENTATION DEFINED behavior.
> 
> Its better instead to have a predictable behavior in such cases and by
> explicitly calculating the paddress values using the right PTE High and
> Low masks in these cases we can minimize any hardware IMPLEMENTATION
> specific details (just like the handling done in kernel space).

I understood. This is the information I needed, thanks.

> >>>>> @@ -425,14 +628,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
> >>>>>                           ERRMSG("Can't get a valid pte.\n");
> >>>>>                           return NOT_PADDR;
> >>>>>                   } else {
> >>>>> -
> >>>>> -                       paddr = (PAGEBASE(pte_val(ptev)) & PHYS_MASK)
> >>>>> +                       paddr = (PAGEBASE(pte_val(ptev)) & PTE_ADDR_MASK)
> >>>>>                                           + (vaddr & (PAGESIZE() - 1));
> >>>
> >>> I think __pte_to_phys() is needed also here, not PTE_ADDR_MASK.
> >>
> >> I had some issues with the same on ARMv8 simulator, so lets stick with the tested 'PTE_ADDR_MASK' usage
> for now.
> >
> > Did you test this PTE_ADDR_MASK line on a system actually using
> > 52-bit PA? If a 52-bit physical address is actually used, this will
> > return a wrong address, for example:
> >
> >    PTE_ADDR_MASK  0x0000fffffffff000
> >    PTE            0x0000123456789000
> >    PAGEBASE'd     0x0000123456780000
> >     v
> >    paddr          0x0000123456780000 + 64k offset // incorrect
> >
> > With 52-bit PA, the PTE_ADDR_MASK is used for __phys_to_pte_val(),
> > not __pte_to_phys().
> >
> > If I understand correctly, we should need __pte_to_phys() also here.
> >
> >    paddr = __pte_to_phys(ptev)
> >                    + (vaddr & (PAGESIZE() - 1));
> >
> > Could you try this?
> 
> Yes, the ARMv8 simulator can support both ARMv8.2 LPA and LVA features
> and I tested the above suggestion earlier also on the same and landed
> into incorrect paddress calculation issues.
> 
> Since the simulator is slow and its time taking to insert rebuilt
> user-space components in the Linaro initramfs being used on the same, I
> would suggest that we go ahead with the above code for now and later
> when I have more results from the simulator/real hardware, I will send
> out a follow-up patch (if needed) to fix the paddress calculation.

Hmm, it theoretically needs __pte_to_phys(), right?
So if you have an issue with it, there may be a bug somewhere
and need to debug it. Do you have the detailed information?

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
