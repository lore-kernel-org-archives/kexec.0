Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo185.gate.nec.co.jp ([114.179.232.185])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNgSY-0001Tn-Ny
 for kexec@lists.infradead.org; Fri, 16 Nov 2018 15:55:08 +0000
Received: from tyo161.gate.nec.co.jp (tyo161.gate.nec.co.jp [114.179.232.161])
 by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id
 wAGFrkmE013420
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2018 00:53:46 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2 1/2] makedumpfile/arm64: Use VMCOREINFO inside
 '/proc/kcore' (if available)
Date: Fri, 16 Nov 2018 15:50:43 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03560D0D@BPXM09GP.gisp.nec.co.jp>
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355F237@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpNB9HZFfqgRC=sZCoKJ6YMvZkaPwBM=AAT_o3_t-+e5eQ@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355F6E9@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpOUoA4CcqOmtf98bRQ03OgukNf7cf=dW71F23+43_4VEw@mail.gmail.com>
In-Reply-To: <CACi5LpOUoA4CcqOmtf98bRQ03OgukNf7cf=dW71F23+43_4VEw@mail.gmail.com>
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
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Hi Bhupesh,

On 11/15/2018 3:27 PM, Bhupesh Sharma wrote:
>>> Note that PAGE_OFFSET is not constant on KASLR enabled arm64 kernels
>>> as the start of the linear range gets randomized as well (as per the
>>> KASLR seed) which means that PAGE_OFFSET is no longer equal to the
>>> macro:
>>> #define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
>>>            (UL(1) << (VA_BITS - 1)) + 1)
>>
>> The PAGE_OFFSET macro itself is still constant in arm64 kernel and used by
>> p2v/v2p calculation, and also used by the test whether a virtual address is
>> in linear kernel range (as VA_BITS):

> I understand, but for me (and as I understood from other arm64 users
> as well), the kernel
> virtual address layout and the comments we have in place are probably
> broken after KASLR
> was enabled on arm64. This is something I shared with arm64 maintainers as well:
> [1]. https://www.spinics.net/lists/arm-kernel/msg655933.html
> 
> Lets go through some details first.
> Please note that the PAGE_OFFSET is defined as
> ('arch/arm64/include/asm/memory.h'):
> 
> /*
>  * PAGE_OFFSET - the virtual address of the start of the linear map (top
>  *         (VA_BITS - 1))
> 
> So, basically this points to the virtual address which indicates the
> start of linear mapping.
> Now, the linear region takes up exactly half of the kernel virtual
> address space.
> 
> So, with a normal non-KASLR boot (I am sharing the logs below on a
> system booted with 'nokaslr' in bootargs),
> the PAGE_OFFSET macro would normally point to the half mark of the
> kernel virtual address space.
> [I needed to revert the kernel commit
> "071929dbdd865f779a89ba3f1e06ba8d17dd3743: arm64: Stop printing the
> virtual memory layout" to get these logs]
> 
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000
> (   128 MB)
> [    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000
> (126847 GB)
> [    0.000000]       .text : 0x(____ptrval____) - 0x(____ptrval____)
> (  8768 KB)
> [    0.000000]     .rodata : 0x(____ptrval____) - 0x(____ptrval____)
> (  5696 KB)
> [    0.000000]       .init : 0x(____ptrval____) - 0x(____ptrval____)
> (  4224 KB)
> [    0.000000]       .data : 0x(____ptrval____) - 0x(____ptrval____)
> (  1775 KB)
> [    0.000000]        .bss : 0x(____ptrval____) - 0x(____ptrval____)
> (  9193 KB)
> [    0.000000]     fixed   : 0xffff7fdffe790000 - 0xffff7fdffec00000
> (  4544 KB)
> [    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000
> (    16 MB)
> [    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000
> (   128 GB maximum)
> [    0.000000]               0xffff7fe000000000 - 0xffff7fe004000000
> (    64 MB actual)
> [    0.000000]     memory  : 0xffff800000000000 - 0xffff801000000000
> ( 65536 MB)
> 
> This is on a system with 64K page size and VA_BITS=48.
> For such a configuration, PAGE_OFFSET is also calculated as
> 0xffff800000000000, which the
> same as the start address of the memory range (i.e memory  :
> 0xffff800000000000 - 0xffff801000000000)
> which depicts the linear region from where 'kmalloc' allocations take place.
> 
> Now, lets look at the boot logs on the same system with 'nokaslr'
> removed from bootargs (i.e. a KASLR boot case):
> 
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000
> (   128 MB)
> [    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000
> (126847 GB)
> [    0.000000]       .text : 0x(____ptrval____) - 0x(____ptrval____)
> (  8768 KB)
> [    0.000000]     .rodata : 0x(____ptrval____) - 0x(____ptrval____)
> (  5696 KB)
> [    0.000000]       .init : 0x(____ptrval____) - 0x(____ptrval____)
> (  4224 KB)
> [    0.000000]       .data : 0x(____ptrval____) - 0x(____ptrval____)
> (  1775 KB)
> [    0.000000]        .bss : 0x(____ptrval____) - 0x(____ptrval____)
> (  9193 KB)
> [    0.000000]     fixed   : 0xffff7fdffe790000 - 0xffff7fdffec00000
> (  4544 KB)
> [    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000
> (    16 MB)
> [    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000
> (   128 GB maximum)
> [    0.000000]               0xffff7fea5b300000 - 0xffff7fea5f300000
> (    64 MB actual)
> [    0.000000]     memory  : 0xffffa96cc0000000 - 0xffffa97cc0000000
> ( 65536 MB)
> 
> As you will note here, the start of linear range as indicated by the
> 'memory' node is 0xffffa96cc0000000
> (this would be a random value for each KASLR boot), however the
> PAGE_OFFSET macro is still stuck
> at 0xffff800000000000, which is confusing (and probably incorrect), as
> the 'kmalloc' calls return addresses in the range
> '0xffffa96cc0000000 - 0xffffa97cc0000000' and not in the
> '0xffff800000000000 - 0xffff801000000000'  range
> anymore as we saw in the non-KASLR boot case.

Thanks for the details.
Its name may be confusing, but I think that whether it is correct or not is
how it is used. If there is a misuse bug of it, it should be fixed, though.

>> I meant that I just would like to imitate these definitions also in
>> makedumpfile first, for better maintenance and future changes.
> 
> Sure, I think the arm64 kernel ideally requires a standard ABI to
> expose the start of linear address region to the user-space
> as well for both KASLR and non-KASLR cases (something like a
> 'page_offset_base' for x86_64), and I plan to submit a RFC patch for
> arm64 maintainers
> consideration once my x86_64 kernel patch is accepted.

So you might need a use case.
As for makedumpfile, this time we found that we can manage with VA_BITS and
PHYS_OFFSET also with KASLR (as far as we tested), and they are already in
vmcoreinfo. If there is another use case, it would be helpful for the patch
to be applied.	

>> I tested them on two arm64 systems (including KASLR enabled, because its
>> KERNELOFFSET=2eff90ae0000 in vmcoreinfo) and it tested OK,
>> but could you test them on your arm64 boards?
>>
>> If it works correctly, then let's think about using vmcoreinfo in PT_NOTE in
>> /proc/kcore, which kernels >= 4.19 have.
> 
> Yes, these patches work fine on my hp-moonshot machine both for KASLR
> and non-KASLR cases,
> and I agree with you that we need some kind of a solution for <4.19
> kernels as well and probably
> this is a good fix to have for now.
> 
> So, please feel free to add:
> Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thank you for testing them! I really appreciate it.
I'll merge them with your tag.

Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
