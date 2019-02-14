Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMiC-0004sA-CU
 for kexec@lists.infradead.org; Thu, 14 Feb 2019 19:30:22 +0000
Received: by mail-pl1-f196.google.com with SMTP id s1so3650025plp.9
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2019 11:30:18 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <7694f082-aa85-714a-b709-ea3414864daf@redhat.com>
Date: Fri, 15 Feb 2019 01:00:09 +0530
MIME-Version: 1.0
In-Reply-To: <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, anderson@redhat.com, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi James,

On 02/13/2019 11:52 PM, James Morse wrote:
> Hi guys,
> 
> On 13/02/2019 11:15, Dave Young wrote:
>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>>> mentioned that the changes look necessary.
>>>>
>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>>
>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>>> calculated as is done by the underlying kernel
> 
> Aha! Nothing to do with which-bits-are-pfn in the tables...
> 
> You need to know if the top level PGD is 512bytes or bigger. As we use a
> kmem-cache the adjacent data could be some else's page tables.
> 
> Is this really a problem though? You can't pull the user-space pgd pointers out
> of no-where, you must have walked some task_struct and struct_mm's to find them.
> In which case you would have the VMAs on hand to tell you if its in the mapped
> user range.
> 
> It would be good to avoid putting something arch-specific in here if we can at
> all help it.
> 
> 
>>>>>> (see
>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>>
>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>>
>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>>
>>> /* to find an entry in a page-table-directory */
>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>>
>> Since Dave mentioned crash tool does not need it, but crash should also
>> travel the pg tables.
>>
>> If this is really necessary it would be good to describe what will
>> happen without the patch, eg. some user visible error from an actual test etc.
> 
> Yes please, it would really help if there was a specific example we could discuss.

Sure. Here are two use-cases/regressions reported and which I have been 
able to reproduce. Note that I tested them both on a CPU which does not 
support ARMv8.2-LPA/LVA and on ARMv8 FVP model (which supports ARMv8.2 
extensions).

Environment:
------------
Latest Upstream kernel: sha-id: 1f947a7a011fcceb14cb912f5481a53b18f1879a 
("Merge branch 'akpm' (patches from Andrew)")

Latest makedumpfile code: (git://git.code.sf.net/p/makedumpfile/code , 
branch: devel)

crash-utility code: (https://github.com/crash-utility/crash.git, sha-id: 
e082c372c7f1a782b058ec359dfbbbee0f0b6aad)

Note that Dave A. has since fixed crash-utility by using a hardcoded 
value of 'MAX_PHYSMEM_BITS' (via sha id: 
ac5a7889d31bb37aa0687110ecea08837f8a66a8) and determining 'vabits_user' 
value via vmlinux (via sha id: 8618ddd817621c40c1f44f0ab6df7c7805234416)

(1). Regression Case 1 (ARMv8.2-LPA enabled kernel):

- Upstream makedumpfile and crash-utility (with sha-id 
e082c372c7f1a782b058ec359dfbbbee0f0b6aad) are broken on following kind 
of platforms:

a. Upstream Kernel 5.0.0-rc6+ with the following kernel configuration:

CONFIG_ARM64_64K_PAGES=y
# CONFIG_ARM64_VA_BITS_42 is not set
CONFIG_ARM64_VA_BITS_48=y
# CONFIG_ARM64_USER_VA_BITS_52 is not set
CONFIG_ARM64_VA_BITS=48
# CONFIG_ARM64_PA_BITS_48 is not set
CONFIG_ARM64_PA_BITS_52=y
CONFIG_ARM64_PA_BITS=52

b. Both on CPUs which don't support ARMv8.2 LPA extension and on ARMv8 
FVP model with ARMv8.2 LPA extensions.

- Error message from makedumpfile:

$ makedumpfile -f --mem-usage /proc/kcore -D
max_mapnr    : a00000
kimage_voffset   : fffeffff80000000
max_physmem_bits : 30
section_size_bits: 1e
vaddr_to_paddr_arm64: pgda=90d70000, pudv.pgd=ffffff80ffffffd0
vaddr_to_paddr_arm64: puda=90d70000, pudv.pgd=9fffff0003
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0003
vaddr_to_paddr_arm64: paddr=911a962c
va_bits      : 48
page_offset  : ffff800000000000
vaddr_to_paddr_arm64: pgda=90d70000, pudv.pgd=41a474
vaddr_to_paddr_arm64: puda=90d70000, pudv.pgd=9fffff0003
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0003
vaddr_to_paddr_arm64: paddr=911a1320
num of NODEs : 1
Memory type  : SPARSEMEM

vaddr_to_paddr_arm64: pgda=90d70100, pudv.pgd=a657470206461
vaddr_to_paddr_arm64: puda=90d70100, pudv.pgd=9ffffd0003
vaddr_to_paddr_arm64: pmda=9ffffd27d8, pmdv.pud=9ffeee0003
vaddr_to_paddr_arm64: paddr=9ffeedc600
vaddr_to_paddr_arm64: pgda=90d70100, pudv.pgd=ffff97d98224
vaddr_to_paddr_arm64: puda=90d70100, pudv.pgd=9ffffd0003
vaddr_to_paddr_arm64: pmda=9ffffd27d8, pmdv.pud=9ffeee0003
vaddr_to_paddr_arm64: paddr=9ffeedc600
get_mm_sparsemem: Can't get the address of mem_section.

c. Root Cause Analysis -

- After the PA_BITS changes in arm64 kernel we set:
#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS

- For SPARSEMEM, this value is used to calculate the bits space required 
to store a section:
#define SECTIONS_SHIFT	(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
#define NR_MEM_SECTIONS		(1UL << SECTIONS_SHIFT)

- User-space tools use a similar mechanism to determine the SPARSEMEM 
type (extreme or not) using the 'NR_MEM_SECTIONS' value (an example from 
makedumpfile code):

int
is_sparsemem_extreme(void)
{
	if ((ARRAY_LENGTH(mem_section)
	     == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME()))
	    || (ARRAY_LENGTH(mem_section) == NOT_FOUND_STRUCTURE))
		return TRUE;
	else
		return FALSE;
}

- Since MAX_PHYSMEM_BITS are 48 bits for normal cases and are 52 bits 
for extended PA address space, the memory type is incorrectly calculated 
as SPARSEMEM rather than SPARSEMEM_EX in above case.

- Exporting correct 'MAX_PHYSMEM_BITS' via vmcoreinfo for 52-bit PA 
case, fixes the above mentioned issue:

$ makedumpfile -f --mem-usage /proc/kcore -D

<..snip..>
  NUMBER(MAX_PHYSMEM_BITS)=52

<..snip..>
max_mapnr    : a00000
kimage_voffset   : fffeffff80000000
max_physmem_bits : 30
section_size_bits: 1e
vaddr_to_paddr_arm64: pgda=90d70000, pudv.pgd=ffffff80ffffffd0
vaddr_to_paddr_arm64: puda=90d70000, pudv.pgd=9fffff0003
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0003
vaddr_to_paddr_arm64: paddr=911a962c
va_bits      : 48
page_offset  : ffff800000000000
vaddr_to_paddr_arm64: pgda=90d70000, pudv.pgd=41a474
vaddr_to_paddr_arm64: puda=90d70000, pudv.pgd=9fffff0003
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0003
vaddr_to_paddr_arm64: paddr=911a1320
num of NODEs : 1
Memory type  : SPARSEMEM_EX
<..snip..>

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		2626            	yes		Pages filled with zero
NON_PRI_CACHE	569             	yes		Cache pages without private flag
PRI_CACHE	5446            	yes		Cache pages with private flag
USER		3213            	yes		User process pages
FREE		2048971         	yes		Free pages
KERN_DATA	19034           	no		Dumpable kernel data

page size:		65536
Total pages on system:	2079859
Total size on system:	136305639424     Byte

(2). Regression Case 2 (ARMv8.2-LPA + LVA [52-bit user-space VA] enabled 
kernel):

- Upstream makedumpfile and crash-utility (with sha-id 
e082c372c7f1a782b058ec359dfbbbee0f0b6aad) are broken on following kind 
of platforms:

a. Upstream Kernel 5.0.0-rc6+ with the following kernel configuration:

CONFIG_ARM64_64K_PAGES=y
# CONFIG_ARM64_VA_BITS_42 is not set
# CONFIG_ARM64_VA_BITS_48 is not set
CONFIG_ARM64_USER_VA_BITS_52=y
CONFIG_ARM64_VA_BITS=48
# CONFIG_ARM64_PA_BITS_48 is not set
CONFIG_ARM64_PA_BITS_52=y
CONFIG_ARM64_PA_BITS=52

b. Both on CPUs which don't support ARMv8.2 extensions and on ARMv8 FVP 
model with  ARMv8.2 extensions.

- Error message from makedumpfile:

$ makedumpfile -f --mem-usage /proc/kcore -D
max_mapnr    : a00000
kimage_voffset   : fffeffff78000000
max_physmem_bits : 30
section_size_bits: 1e
vaddr_to_paddr_arm64: pgda=90f30000, pudv.pgd=ffffff80ffffffd0
vaddr_to_paddr_arm64: puda=90f30000, pudv.pgd=0
readpage_elf: Attempt to read non-existent page at 0x0.
readmem: type_addr: 1, addr:0, size:8
vaddr_to_paddr_arm64: Can't read pmd
readmem: Can't convert a virtual address(ffff0000093c576c) to physical 
address.
readmem: type_addr: 0, addr:ffff0000093c576c, size:390
check_release: Can't get the address of system_utsname.

c. Root Cause Analysis -

- After the 52-bit user-space VA_BIT changes in arm64 kernel we set:
#define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))

- User-space tools like makedumpfile and crash use the 'PTRS_PER_PGD' 
value to calculate the 'pgd_index()' of a vaddr:

#define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))

- Since the kernel now defines 'MAX_USER_VA_BITS' as:
#ifdef CONFIG_ARM64_USER_VA_BITS_52
#define MAX_USER_VA_BITS	52
#else
#define MAX_USER_VA_BITS	VA_BITS
#endif

so, the user-space also needs this value to calculate the 'PTRS_PER_PGD' 
and hence 'pgd_index()' correctly.

- Exporting correct 'MAX_USER_VA_BITS' via vmcoreinfo for the above 
case, fixes the above mentioned issue:

$ makedumpfile -f --mem-usage /proc/kcore -D

<..snip..>
max_mapnr    : a00000
pa_bits    : 52
va_bits    : 48 (vmcoreinfo)
max_user_va_bits : 52 (vmcoreinfo)
kimage_voffset   : fffeffff78000000
max_physmem_bits : 52
section_size_bits: 30
vaddr_to_paddr_arm64: pgda=90f31e00, pudv.pgd=ffffff80ffffffd0
vaddr_to_paddr_arm64: puda=90f31e00, pudv.pgd=9fffff0803
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0803
vaddr_to_paddr_arm64: paddr=913c576c
page_offset  : ffff800000000000
vaddr_to_paddr_arm64: pgda=90f31e00, pudv.pgd=16e28e8bed294900
vaddr_to_paddr_arm64: puda=90f31e00, pudv.pgd=9fffff0803
vaddr_to_paddr_arm64: pmda=9fffff0000, pmdv.pud=9ffffe0803
vaddr_to_paddr_arm64: paddr=913bd2f8
num of NODEs : 1
Memory type  : SPARSEMEM_EX
<..snip..>

Other important notes
---------------------

1. I have quoted only one makedumpfile use-case failure above (i.e. 
calculating --mem-usage on the primary kernel). Other use-cases like 
creating a dumpfile using /proc/vmcore or post-processing a vmcore are 
also broken similarly and get fixed when a kernel which exports 
'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is used along 
with a modified user-space which can read this information from the 
vmcoreinfo.

2. I was also going through some of the suggestions on earlier threads 
about the PTE calculations for the 52-bit LPA case and discussed them 
with some partner arm64 SoC enggs.

The suggestions to convert a page table entry to a physical address 
without awareness of 52-bit (with an assumption of 64k page size) can be 
risky.

With 64k page and older non-52-bit kernels, while it looks like in the 
current checks that bits [15:12] are zero, and we can move the zeros to 
bits [51:48] (because the zeros don't affect the overall PA) to generate 
the overall 52-bit PA. However, this can cause IMPLEMENTATION SPECIFIC 
issues on different platforms while generating a PA and IPA.

Lets see what the ARMv8 architecture reference manual says about the 
Bits [15:12] for a 64KB page size:

"Bits [15:12] of each valid translation table descriptor hold Bits 
[51:48] of the output address, or of the address
of the translation table to be used for the initial lookup at the next 
level of translation. If the implementation
does not support 52-bit physical addresses, then it is IMPLEMENTATION 
DEFINED whether non-zero values for
these bits generate an Address size fault. In this case, not generating 
an Address Size Fault is deprecated."

As per the vendors, we should not assume that hardware (which does not 
support 52-bit physical addresses) would generate an Address size fault 
for non-zero values of Bits[15:12], so extending them to bits [51:48] 
always can lead to PA address which might cause UNDEFINED behavior on 
some SoCs.

Hope the above text clarifies the problem and what I am trying to fix 
via this patch. Please let me know if something is missing here.

Thanks,
Bhupesh






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
