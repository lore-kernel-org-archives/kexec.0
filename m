Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqtS-0003oV-Ad
 for kexec@lists.infradead.org; Thu, 21 Feb 2019 16:08:18 +0000
Received: by mail-pg1-f195.google.com with SMTP id i130so13913598pgd.1
 for <kexec@lists.infradead.org>; Thu, 21 Feb 2019 08:08:13 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
 <20190218152651.GA14091@capper-debian.cambridge.arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <b10704d4-3cc1-978f-4dbe-60d399edb67e@redhat.com>
Date: Thu, 21 Feb 2019 21:38:02 +0530
MIME-Version: 1.0
In-Reply-To: <20190218152651.GA14091@capper-debian.cambridge.arm.com>
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
To: Steve Capper <Steve.Capper@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <James.Morse@arm.com>, Kristina Martsenko <Kristina.Martsenko@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, nd <nd@arm.com>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Steve,

On 02/18/2019 08:57 PM, Steve Capper wrote:
> Hi Bhupesh,
> 
> Sorry for joining this thread late...
> 
> On Fri, Feb 15, 2019 at 11:31:56PM +0530, Bhupesh Sharma wrote:
>> Hi James,
>>
>> On Fri, Feb 15, 2019 at 11:04 PM James Morse <james.morse@arm.com> wrote:
>>>
>>> Hi guys,
>>>
>>> (CC: +Steve, +Kristina) "What's the best way of letting user-space know the MMU
>>> config when 52-bit VA and pointer-auth may be in use?"
>>>
>>> On 13/02/2019 19:52, Kazuhito Hagio wrote:
>>>> On 2/13/2019 1:22 PM, James Morse wrote:
>>>>> On 13/02/2019 11:15, Dave Young wrote:
>>>>>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>>>>>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>>>>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>>>>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>>>>>>> mentioned that the changes look necessary.
>>>>>>>>
>>>>>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>>>>>>
>>>>>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>>>>>>> calculated as is done by the underlying kernel
>>>>>
>>>>> Aha! Nothing to do with which-bits-are-pfn in the tables...
>>>>>
>>>>> You need to know if the top level PGD is 512bytes or bigger. As we use a
>>>>> kmem-cache the adjacent data could be some else's page tables.
>>>>>
>>>>> Is this really a problem though? You can't pull the user-space pgd pointers out
>>>>> of no-where, you must have walked some task_struct and struct_mm's to find them.
>>>>> In which case you would have the VMAs on hand to tell you if its in the mapped
>>>>> user range.
>>>>>
>>>>> It would be good to avoid putting something arch-specific in here if we can at
>>>>> all help it.
>>>
>>>>>>>>>> (see
>>>>>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>>>>>>
>>>>>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>>>>>>
>>>>>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>>>>>>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>>>>>>
>>>>>>> /* to find an entry in a page-table-directory */
>>>>>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>>>>>>
>>>>>> Since Dave mentioned crash tool does not need it, but crash should also
>>>>>> travel the pg tables.
>>>>
>>>> The crash utility is always invoked with vmlinux, so it can read the
>>>> vabits_user variable directly from vmcore, but makedumpfile can not.
>>>
>>> (This sounds fragile. That symbol's name may change, it may disappear
>>> completely! ... but I guess crash changes with every kernel release anyway)
>>>
>>>
>>>>>> If this is really necessary it would be good to describe what will
>>>>>> happen without the patch, eg. some user visible error from an actual test etc.
>>>>>
>>>>> Yes please, it would really help if there was a specific example we could discuss.
>>>>
>>>> With 52-bit user space and 48-bit kernel space configuration,
>>>> makedumpfile will not be able to convert a virtual kernel address
>>>> to a physical address, and fail to capture a dumpfile, because the
>>>> pgd_index() will return a wrong index.
>>>
>>> Got it, thanks!
>>> (all this user stuff had me thinking it was user-space you were trying to walk).
>>>
>>> Yes, this is because of commit e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow
>>> 52-bit PTRS_PER_PGD"). The kernel has offset the ttbr1 value, if you try and
>>> walk it without knowing the offset you get junk.
>>>
>>> Ideally we tell you the offset with some 'ttbr1_offset=' in vmcoreinfo, but if
>>> the offsetting code disappears, the kernel would still have to provide
>>> 'ttbr1_offset=0' for user-space to keep working.
>>>
>>> I'd like to find something future-proof that always has an unambiguous meaning,
>>> and isn't a problem if the kernel variable/symbol/kconfig names change.
>>>
>>> With pointer-auth in use too you can't guess which bits are address and which
>>> bits are data.
>>>
>>> Taking arch-specific to its extreme, we could expose TCR_EL1, but this is a
>>> problem if we ever switch that per task (some new bits may turn up with a new
>>> feature). Some of those bits vary per cpu too, so we'd have to mask them out in
>>> case user-space tries to conclude something from them.
>>>
>>>
>>> My current best suggestion is to export:
>>> from core code:
>>> * USER_MMAP_END, the maximum value a user-space can try and mmap().
>>> This would normally be TASK_SIZE, but x86 and powerpc also have support for
>>> larger VA space, and its plumbed into mm slightly differently. We should have
>>> one arch-independent property that covers all these. On arm64 this would be the
>>> runtime va bits for user-space's TTBR. (This assumes the value isn't per-task)
>>>
>>> arch specific:
>>> * ARM64_TCR.T1SZ, the va bits mapped by the kernel's TTBR. (We can assume we'll
>>> never flip user/kernel space). This has to be arch specific, it will always have
>>> a value and its meaning comes from the ARM-ARM (so linux can't change it in the
>>> future). It should be the same on every CPU.
>>> * ARM64_TTBR1.BADDR, the pa of the kernel page tables, which implicitly has the
>>> offset. Again this always has a value, and its meaning comes from the ARM-ARM.
>>> If we ever get clever with different page-tables/TCR values on different CPUs,
>>> these two should come from the same CPU.
>>>
>>>
>>> I think this gives you what you need if user/kernel may both be using
>>> pointer-auth and both may be using 52-bit va. I'm pretty sure the 48:52 bits can
>>> be picked at boot time depending on the kernel kconfig and the hardware support.
>>>
>>> Does anyone have a better idea? (or a corner where this won't work?)
>>
>> I am not sure you got a chance to look at the two regression cases I
>> reported here:
>> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
>>
>> Unfortunately the above suggestion doesn't provide any fix for
>> ARMv8.2-LPA regression (see text under heading '
>> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
>>
>> After going through the regression reports, I think exporting
>> 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
>> for the above regressions (without over-complicating the stuff) as
>> ARM64_TCR.T1SZ and friends seem to arch specific as compared to
>> VA_BITS + 'MAX_USER_VA_BITS' .
>>
> 
> For MAX_USER_VA_BITS, IIUC you are just after a value of PTRS_PER_PGD?
> Why not just add PTRS_PER_PGD to the vmcoreinfo?

That's a good suggestion. I will re-spin the v2 with the same.

> FWIW it is possible in vaddr_to_paddr_arm64 to detect a zero pgd entry
> then try again with another ptrs_per_pgd value (granted this is a little
> hacky).

Right, but having this hack replicated across various user-space tools 
is perhaps not the ideal portable solution, when we can simply add a 
valid hint in the vmcoreinfo itself.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
