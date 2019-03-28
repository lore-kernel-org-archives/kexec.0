Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9TR1-0001rN-TK
 for kexec@lists.infradead.org; Thu, 28 Mar 2019 11:43:07 +0000
Received: by mail-pl1-f193.google.com with SMTP id m10so4834413plt.10
 for <kexec@lists.infradead.org>; Thu, 28 Mar 2019 04:43:03 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
Date: Thu, 28 Mar 2019 17:12:54 +0530
MIME-Version: 1.0
In-Reply-To: <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Steve Capper <Steve.Capper@arm.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi James,

Thanks for your review. Please see my comments inline:

On 03/26/2019 10:06 PM, James Morse wrote:
> Hi Bhupesh,
> 
> On 20/03/2019 05:09, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>> which supports this extension can support a virtual address-space upto
>> 52-bits.
>>
>> Since at the moment we enable the support of this extension in kernel
>> via CONFIG flags, e.g.
>>   - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
>>
>> so, there is no clear mechanism in the user-space right now to
>> determine these CONFIG flag values and hence determine the maximum
>> virtual address space supported by the underlying kernel.
>>
>> User-space tools like 'makedumpfile' therefore are broken currently
>> as they have no proper method to calculate the 'PTRS_PER_PGD' value
>> which is required to perform a page table walk to determine the
>> physical address of a corresponding virtual address found in
>> kcore/vmcoreinfo.
>>
>> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
>> it can be used in user-space to determine the maximum virtual address
>> supported by underlying kernel.
> 
> I don't think this really solves the problem, it feels fragile.
> 
> I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
> You can use this to work out that the top level page table size isn't consistent with a
> 48bit VA, so 52bit VA must be in use...
> 
> But wasn't your problem walking the kernel page tables? In particular the offset that we
> apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.
> 
> Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
> hard-codes it when it sees 52bit is in use ... somewhere.
> We haven't solved the problem!

But isn't the TTBR1_EL1 offset already appended by the kernel via 
e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD")
in case of kernel configuration where 52-bit userspace VAs are possible.

I copy a snippet from the git log of the above from Steve, which 
explains the above:

"   In other words a 48-bit kernel virtual address will have a different
     pgd_index when using PTRS_PER_PGD = 64 and 1024.

     If, however, we note that:
     kva = 0xFFFF << 48 + lower (where lower[63:48] == 0b)
     and, PGDIR_SHIFT = 42 (as we are dealing with 64KB PAGE_SIZE)

     We can consider:
     (kva >> PGDIR_SHIFT) & (1024 - 1) - (kva >> PGDIR_SHIFT) & (64 - 1)
      = (0xFFFF << 6) & 0x3FF - (0xFFFF << 6) & 0x3F     // "lower" 
cancels out
      = 0x3C0

     In other words, one can switch PTRS_PER_PGD to the 52-bit value 
globally
     provided that they increment ttbr1_el1 by 0x3C0 * 8 = 0x1E00 bytes when
     running with 48-bit kernel VAs (TCR_EL1.T1SZ = 16).

     For kernel configuration where 52-bit userspace VAs are possible, this
     patch offsets ttbr1_el1 and sets PTRS_PER_PGD corresponding to the
     52-bit value.
"

Accordingly we have the following assembler helper in 
'arch/arm64/include/asm/assembler.h':

        .macro  offset_ttbr1, ttbr
#ifdef CONFIG_ARM64_52BIT_VA
        orr     \ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
#endif
        .endm

where:
#ifdef CONFIG_ARM64_52BIT_VA
/* Must be at least 64-byte aligned to prevent corruption of the TTBR */
#define TTBR1_BADDR_4852_OFFSET        (((UL(1) << (52 - PGDIR_SHIFT)) - \
                                 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
#endif

And before any load TTBR1 operation in the kernel we offset ttbr1_el1, 
in case CONFIG_ARM64_52BIT_VA is true, for e.g in 
'arch/arm64/kernel/head.S':

ENTRY(__enable_mmu)
<..snip..>
	offset_ttbr1 x1
         msr     ttbr1_el1, x1                   // load TTBR1
<..snip..>

So, the user-space (makedumpfile, for e.g.), just needs to know the 
PTRS_PER_PGD value and it can calculate the pgd_index for a virtual 
address using the following formula:

pgd_index(vaddr) = (((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1));

Note that the above computation holds true both for PTRS_PER_PGD = 64 
(48-bit kernel with 48-bit User VA) and 1024 (48-bit with 52-bit User 
VA) cases. And these are the configurations for which we are trying to 
fix the user-space regressions reported (on arm64) recently.

> Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
> could set them the same, or different the other-way-round.
> 
> Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
> there would be no ttbr offset.
 >
> If you need another vmcoreinfo flag once that happens, we've done something wrong here.

I am currently experimenting with Steve's patches for 52-bit kernel VA 
(<https://lwn.net/Articles/780093/>) and will comment more on the same 
when I am able to get the user-space utilities like makedumpfile and 
kexec-tools to work with the same on both ARMv8 Fast Simulator model and 
older CPUs which don't support ARMv8.2 extensions.

However, I think we should not hold up fixes for regressions already 
reported, because the 52-bit kernel VA changes probably still need some 
more rework.

> (Not to mention what happens if the TTBR1_EL1 uses 52bit va, but TTBR0_EL1 doesn't)

I am wondering if there are any real users of the above combination.

So far, I have generally come across discussions where the following 
variations of the address spaces have been proposed/requested:
- 48bit kernel VA + 48-bit User VA,
- 48-bit kernel VA + 52-bit User VA,
- 52-bit kernel VA + 52-bit User VA.

Thanks,
Bhupesh

>> Suggested-by: Steve Capper <Steve.Capper@arm.com>
> 
> (CC: +Steve)
> 
> 
> Thanks,
> 
> James
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
