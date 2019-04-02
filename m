Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
From: James Morse <james.morse@arm.com>
Message-ID: <54efc2e4-6b3a-792a-16a6-8503c866ea2a@arm.com>
Date: Tue, 2 Apr 2019 18:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-GB
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <Steve.Capper@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Anderson <anderson@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kazu,

On 27/03/2019 16:07, Kazuhito Hagio wrote:
> On 3/26/2019 12:36 PM, James Morse wrote:
>> On 20/03/2019 05:09, Bhupesh Sharma wrote:
>>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>>> which supports this extension can support a virtual address-space upto
>>> 52-bits.
>>>
>>> Since at the moment we enable the support of this extension in kernel
>>> via CONFIG flags, e.g.
>>>  - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
>>>
>>> so, there is no clear mechanism in the user-space right now to
>>> determine these CONFIG flag values and hence determine the maximum
>>> virtual address space supported by the underlying kernel.
>>>
>>> User-space tools like 'makedumpfile' therefore are broken currently
>>> as they have no proper method to calculate the 'PTRS_PER_PGD' value
>>> which is required to perform a page table walk to determine the
>>> physical address of a corresponding virtual address found in
>>> kcore/vmcoreinfo.
>>>
>>> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
>>> it can be used in user-space to determine the maximum virtual address
>>> supported by underlying kernel.
>>
>> I don't think this really solves the problem, it feels fragile.
>>
>> I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
>> You can use this to work out that the top level page table size isn't consistent with a
>> 48bit VA, so 52bit VA must be in use...
>>
>> But wasn't your problem walking the kernel page tables? In particular the offset that we
>> apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.
>>
>> Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
>> hard-codes it when it sees 52bit is in use ... somewhere.

> My understanding is that the TTBR1_EL1 offset comes from a kernel
> virtual address with the exported PTRS_PER_PGD.
> 
> With T1SZ is 48bit and T0SZ is 52bit,

(PTRS_PER_PGD doesn't tell you this, PTRS_PER_PGD lets you spot something odd is
happening, and this just happens to be the only odd combination today.)


> kva = 0xffff000000000000    <--- start of kernel virtual address

Does makedumpfile have this value? If the kernel were using 52bit VA for TTBR1 this value
would be different.


> pgd_index(kva) = (kva >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)
>                = (0xffff000000000000 >> 42) & (1024 - 1)
>                = 0x00000000003fffc0 & 0x3ff
>                = 0x3c0      <--- the offset (0x3c0) is included
> 
> This is what kernel does now, so makedumpfile also wants to do.

Sure, and it would work today. I'm worried about tomorrow, where we support something new,
and need to bundle new information out through vmcoreinfo. This ends up being used to
fingerprint the kernel support, instead of as the value it was intended to be.


>> We haven't solved the problem!
>>
>> Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
>> could set them the same, or different the other-way-round.
>>
>> Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
>> there would be no ttbr offset.
> 
> If T1SZ is 52bit, probably kernel virtual address starts from 0xfff0000000000000,

I didn't think this 'bottom of the ttbr1 mapping range' value was exposed anywhere.
Where can user-space get this from? (I can't see it in the vmcoreinfo list)


> then the offset becomes 0 with the pgd_index() above.
> I think makedumpfile will keep working with that.


Steve mentions a 52/48 combination in his kernel series:
https://lore.kernel.org/linux-arm-kernel/20190218170245.14915-1-steve.capper@arm.com/


I think vmcoreinfo-users will eventually need to spot 52bit used in TTBR1 and/or TTBR0,
and possibly: configured, but not enabled in either. (this is because the bits are also
used for pointer-auth, the kernel may be built for both pointer-auth and 52-bit VA, and
chose which to enabled at boot based on some policy)

I don't see how you can do this with one value.
I'd like to get this right now, so we user-space doesn't need updating again!


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
