Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SXB1c-0007fT-J3
 for kexec@lists.infradead.org; Wed, 23 May 2012 12:50:51 +0000
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 23 May 2012 12:47:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4NChTEF33030276
 for <kexec@lists.infradead.org>; Wed, 23 May 2012 22:43:29 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4NCoStQ024026
 for <kexec@lists.infradead.org>; Wed, 23 May 2012 22:50:28 +1000
Message-ID: <4FBCDD04.8070104@in.ibm.com>
Date: Wed, 23 May 2012 18:20:12 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [v2 PATCH] ppc: move DEBUG code to --debug
References: <1336977296-30314-1-git-send-email-amwang@redhat.com>
 <20120518025931.GB26916@verge.net.au>
In-Reply-To: <20120518025931.GB26916@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, Cong Wang <amwang@redhat.com>

On 05/18/2012 08:29 AM, Simon Horman wrote:
> On Mon, May 14, 2012 at 02:34:56PM +0800, Cong Wang wrote:
>> From: Cong Wang<xiyou.wangcong@gmail.com>
>>
>>
>> From: Cong Wang<xiyou.wangcong@gmail.com>
>> V2: Fix a compile error
>>
>> Like commit 28d4ab53280853d2aeefdfb7c369331e89ab9ac2
>> ("Add generic debug option"), this one moves code
>> under #if DEBUG to --debug on ppc arch.
>>
>> Sorry that I still can't find a ppc32 machine to test this.
>
> Thank, I don't have any ppc32 (or 64) hardware to test on,
> but I did use a cross-compiler to check that it builds.
>
>> Cc: Simon Horman<horms@verge.net.au>
>> Signed-off-by: Cong Wang<xiyou.wangcong@gmail.com>

It builds and works fine for me on PPC32. Sample output below.



Thanks
Suzuki



--- Sample output ---

# kexec -p --debug vmlinux.strip
0000000000000000-0000000080000000 : 0
get base memory ranges:1
usable memory rgns size:1 base:8000000 size:8000000
exclude_range sorted exclude_range[0] start:0, end:1617000
setup_memory_ranges memory_range[0] start:1617001, end:30000000
CRASH MEMORY RANGES
0000000000000000-0000000008000000
0000000010000000-0000000080000000
get_crash_notes_per_cpu: crash_notes addr = 305445c
Elf header: p_type = 4, p_offset = 0x305445c p_paddr = 0x305445c p_vaddr 
= 0x0 p_filesz = 0x400 p_memsz = 0x400
vmcoreinfo header: p_type = 4, p_offset = 0x15fa3bc p_paddr = 0x15fa3bc 
p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000
Elf header: p_type = 1, p_offset = 0x0 p_paddr = 0x0 p_vaddr = 
0xc0000000 p_filesz = 0x8000000 p_memsz = 0x8000000
Elf header: p_type = 1, p_offset = 0x10000000 p_paddr = 0x10000000 
p_vaddr = 0xffffffff p_filesz = 0x70000000 p_memsz = 0x70000000
Command line after adding elfcorehdr:  elfcorehdr=141860K
Command line after adding elfcorehdr:  elfcorehdr=141860K savemaxmem=2048M
sym: sha256_starts info: 12 other: 00 shndx: 1 value: 0 size: a1c
sym: sha256_starts value: 8a8aa1c addr: 8a8a024
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fae8 addr: 8a8a02a
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fae8 addr: 8a8a02e
sym: sha256_update info: 12 other: 00 shndx: 1 value: 0 size: 5454
sym: sha256_update value: 8a8f454 addr: 8a8a044
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 0 size: 55dc
sym: sha256_finish value: 8a8f5dc addr: 8a8a05c
sym:     memcmp info: 12 other: 00 shndx: 1 value: 0 size: 6e0
sym: memcmp value: 8a8a6e0 addr: 8a8a06c
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fa7c addr: 8a8a07e
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fa7c addr: 8a8a086
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a088
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fa9c addr: 8a8a08e
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fa9c addr: 8a8a092
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a094
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8faac addr: 8a8a09a
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8faac addr: 8a8a09e
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a0ac
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab2 addr: 8a8a0be
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab2 addr: 8a8a0c2
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a0c4
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab4 addr: 8a8a0ca
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab4 addr: 8a8a0ce
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a0d0
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fae8 addr: 8a8a0d6
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fae8 addr: 8a8a0da
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a0f0
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab2 addr: 8a8a0fe
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fab2 addr: 8a8a102
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a104
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fac4 addr: 8a8a132
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fac4 addr: 8a8a136
sym:     printf info: 12 other: 00 shndx: 1 value: 0 size: 57c
sym: printf value: 8a8a57c addr: 8a8a13c
sym: setup_arch info: 12 other: 00 shndx: 1 value: 0 size: a0c
sym: setup_arch value: 8a8aa0c addr: 8a8a140
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 0
sym: verify_sha256_digest value: 8a8a000 addr: 8a8a144
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: 0 
size: a10
sym: post_verification_setup_arch value: 8a8aa10 addr: 8a8a154
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fad6 addr: 8a8a172
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8a8fad6 addr: 8a8a17a
sym:    putchar info: 12 other: 00 shndx: 1 value: 0 size: a18
sym: putchar value: 8a8aa18 addr: 8a8a1ec
sym:    putchar info: 12 other: 00 shndx: 1 value: 0 size: a18
sym: putchar value: 8a8aa18 addr: 8a8a248
sym:  __lshrdi3 info: 10 other: 00 shndx: 1 value: 0 size: 9e8
sym: __lshrdi3 value: 8a8a9e8 addr: 8a8a370
sym:    putchar info: 12 other: 00 shndx: 1 value: 0 size: a18
sym: putchar value: 8a8aa18 addr: 8a8a508
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 0 size: 168
sym: vsprintf value: 8a8a168 addr: 8a8a5d0
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 0 size: 168
sym: vsprintf value: 8a8a168 addr: 8a8a62c
sym: my_thread_ptr info: 11 other: 00 shndx: 5 value: 0 size: 10
sym: my_thread_ptr value: 8a8fc58 addr: 8a8a836
sym: my_thread_ptr info: 11 other: 00 shndx: 5 value: 0 size: 10
sym: my_thread_ptr value: 8a8fc58 addr: 8a8a83a
sym:      stack info: 11 other: 00 shndx: 5 value: 0 size: 8
sym: stack value: 8a8fc50 addr: 8a8a842
sym:      stack info: 11 other: 00 shndx: 5 value: 0 size: 8
sym: stack value: 8a8fc50 addr: 8a8a846
sym:  purgatory info: 12 other: 00 shndx: 1 value: 0 size: 128
sym: purgatory value: 8a8a128 addr: 8a8a850
sym:  dt_offset info: 11 other: 00 shndx: 5 value: 0 size: c
sym: dt_offset value: 8a8fc54 addr: 8a8a86a
sym:  dt_offset info: 11 other: 00 shndx: 5 value: 0 size: c
sym: dt_offset value: 8a8fc54 addr: 8a8a86e
sym:     kernel info: 11 other: 00 shndx: 5 value: 0 size: 14
sym: kernel value: 8a8fc5c addr: 8a8a886
sym:     kernel info: 11 other: 00 shndx: 5 value: 0 size: 14
sym: kernel value: 8a8fc5c addr: 8a8a88a
sym:     memcpy info: 12 other: 00 shndx: 1 value: 0 size: 6ac
sym: memcpy value: 8a8a6ac addr: 8a8f524
sym: sha256_process info: 12 other: 00 shndx: 1 value: 0 size: ad4
sym: sha256_process value: 8a8aad4 addr: 8a8f538
sym: sha256_process info: 12 other: 00 shndx: 1 value: 0 size: ad4
sym: sha256_process value: 8a8aad4 addr: 8a8f570
sym:     memcpy info: 12 other: 00 shndx: 1 value: 0 size: 6ac
sym: memcpy value: 8a8a6ac addr: 8a8f5c0
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fc08 addr: 8a8f6e6
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8a8fc08 addr: 8a8f6ea
sym: sha256_update info: 12 other: 00 shndx: 1 value: 0 size: 5454
sym: sha256_update value: 8a8f454 addr: 8a8f6f0
sym: sha256_update info: 12 other: 00 shndx: 1 value: 0 size: 5454
sym: sha256_update value: 8a8f454 addr: 8a8f704
Modified cmdline: elfcorehdr=141860K savemaxmem=2048M maxcpus=1
reserve regions: 2
0: offset: 97fe000, size: 2000
1: offset: 8000000, size: a90000
debug.dtb written


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
