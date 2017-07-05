Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSl2w-0002zf-2N
 for kexec@lists.infradead.org; Wed, 05 Jul 2017 14:12:52 +0000
Subject: Re: [makedumpfile PATCH] Prevent data loss in last page of ELF core
 dumpfile
References: <1499102033-24811-1-git-send-email-eric.devolder@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EEDF87@BPXM01GP.gisp.nec.co.jp>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <e8e38421-0636-e04e-a07e-b7c1d696471e@oracle.com>
Date: Wed, 5 Jul 2017 09:11:29 -0500
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EEDF87@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "daniel.kiper@oracle.com" <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

On 07/05/2017 03:34 AM, Atsushi Kumagai wrote:
> Hello Eric,
>
> Good catch, thanks for your investigation.
> Please see the comment below.
>
>> When generating an ELF core dump file, if a segment/section size
>> is not an integral of PAGE_SIZE, then the corresponding generated
>> segment/section is erroneously truncated to a PAGE_SIZE integral.
>> Thus a small loss of data up to PAGE_SIZE-1 bytes can occur.
>>
>> In the function write_elf_pages_cyclic(), two variables memsz and
>> filesz track the sizes. This patch provides the missing update to
>> filesz for one particular condition, in a fashion consistent with
>> the update to memsz in this condition.
>>
>> This patch corrects the test case described here.
>>
>> I have an existing ELF vmcore dumpfile and run it through
>> makedumpfile again, as such:
>>
>> % makedumpfile -E -x vmlinux vmcore newvmcore
>> % objdump --all-headers vmcore > before.txt
>> % objdump --all-headers newvmcore > after.txt
>>
>>From crash, here is a description of the original vmcore:
>>
>>      KERNEL: vmlinux
>>    DUMPFILE: vmcore
>>        CPUS: 4
>>        DATE: Thu Jan  7 07:49:10 2016
>>      UPTIME: 00:00:22
>> LOAD AVERAGE: 0.00, 0.00, 0.00
>>       TASKS: 77
>>    NODENAME: mini-amd64
>>     RELEASE: 4.2.0-ns.gen.amd64.1
>>     VERSION: #1 SMP Wed Oct 28 16:32:12 CET 2015
>>     MACHINE: x86_64  (2194 Mhz)
>>      MEMORY: 4 GB
>>       PANIC: "sysrq: SysRq : Trigger a crash"
>>         PID: 96
>>     COMMAND: "bash"
>>        TASK: ffff88017a4c9e00  [THREAD_INFO: ffff88017a198000]
>>         CPU: 3
>>       STATE: TASK_RUNNING (SYSRQ)
>>
>> In essence, no re-filtering has occured and I expect to see a very similar
>> ELF dump file to the original.  And for the most part, the files are similar,
>> but I do observe some differences.
>>
>> The contents of before.txt are:
>>
>> == before.txt ========================================================
>> vmcore:     file format elf64-x86-64
>> vmcore
>> architecture: i386:x86-64, flags 0x00000000:
>>
>> start address 0x0000000000000000
>>
>> Program Header:
>>    NOTE off    0x0000000000001000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**0
>>         filesz 0x0000000000000c6c memsz 0x0000000000000c6c flags ---
>>    LOAD off    0x0000000000002000 vaddr 0xffffffff81000000 paddr 0x0000000001000000 align 2**0
>>         filesz 0x0000000000829000 memsz 0x0000000000829000 flags rwx
>>    LOAD off    0x000000000082b000 vaddr 0xffff880000001000 paddr 0x0000000000001000 align 2**0
>>         filesz 0x000000000009ec00 memsz 0x000000000009ec00 flags rwx
>>    LOAD off    0x00000000008ca000 vaddr 0xffff880000100000 paddr 0x0000000000100000 align 2**0
>>         filesz 0x0000000003f00000 memsz 0x0000000003f00000 flags rwx
>>    LOAD off    0x00000000047ca000 vaddr 0xffff880014000000 paddr 0x0000000014000000 align 2**0
>>         filesz 0x000000006bfdf000 memsz 0x000000006bfdf000 flags rwx
>>    LOAD off    0x00000000707a9000 vaddr 0xffff880100000000 paddr 0x0000000100000000 align 2**0
>>         filesz 0x0000000080000000 memsz 0x0000000080000000 flags rwx
>>
>> Sections:
>> Idx Name          Size      VMA               LMA               File off  Algn
>>  0 note0         00000c6c  0000000000000000  0000000000000000  00001000  2**0
>>                  CONTENTS, READONLY
>>  1 .reg/0        000000d8  0000000000000000  0000000000000000  00001084  2**2
>>                  CONTENTS
>>  2 .reg          000000d8  0000000000000000  0000000000000000  00001084  2**2
>>                  CONTENTS
>>  3 .reg/0        000000d8  0000000000000000  0000000000000000  000011e8  2**2
>>                  CONTENTS
>>  4 .reg/0        000000d8  0000000000000000  0000000000000000  0000134c  2**2
>>                  CONTENTS
>>  5 .reg/96       000000d8  0000000000000000  0000000000000000  000014b0  2**2
>>                  CONTENTS
>>  6 load1         00829000  ffffffff81000000  0000000001000000  00002000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  7 load2         0009ec00  ffff880000001000  0000000000001000  0082b000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  8 load3         03f00000  ffff880000100000  0000000000100000  008ca000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  9 load4         6bfdf000  ffff880014000000  0000000014000000  047ca000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>> 10 load5         80000000  ffff880100000000  0000000100000000  707a9000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>> SYMBOL TABLE:
>> no symbols
>>
>> == before.txt ========================================================
>>
>> And the contents of after.txt:
>>
>> == after.txt =========================================================
>> newvmcore:  file format elf64-x86-64
>> newvmcore:
>> architecture: i386:x86-64, flags 0x00000000:
>>
>> start address 0x0000000000000000
>>
>> Program Header:
>>    NOTE off    0x0000000000000190 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**0
>>         filesz 0x0000000000000c6c memsz 0x0000000000000c6c flags ---
>>    LOAD off    0x0000000000000dfc vaddr 0xffffffff81000000 paddr 0x0000000001000000 align 2**0
>>         filesz 0x0000000000829000 memsz 0x0000000000829000 flags rwx
>>    LOAD off    0x0000000000829dfc vaddr 0xffff880000001000 paddr 0x0000000000001000 align 2**0
>>         filesz 0x000000000009e000 memsz 0x000000000009ec00 flags rwx
>>    LOAD off    0x00000000008c7dfc vaddr 0xffff880000100000 paddr 0x0000000000100000 align 2**0
>>         filesz 0x0000000003f00000 memsz 0x0000000003f00000 flags rwx
>>    LOAD off    0x00000000047c7dfc vaddr 0xffff880014000000 paddr 0x0000000014000000 align 2**0
>>         filesz 0x000000006bfdf000 memsz 0x000000006bfdf000 flags rwx
>>    LOAD off    0x00000000707a6dfc vaddr 0xffff880100000000 paddr 0x0000000100000000 align 2**0
>>         filesz 0x0000000080000000 memsz 0x0000000080000000 flags rwx
>>
>> Sections:
>> Idx Name          Size      VMA               LMA               File off  Algn
>>  0 note0         00000c6c  0000000000000000  0000000000000000  00000190  2**0
>>                  CONTENTS, READONLY
>>  1 .reg/0        000000d8  0000000000000000  0000000000000000  00000214  2**2
>>                  CONTENTS
>>  2 .reg          000000d8  0000000000000000  0000000000000000  00000214  2**2
>>                  CONTENTS
>>  3 .reg/0        000000d8  0000000000000000  0000000000000000  00000378  2**2
>>                  CONTENTS
>>  4 .reg/0        000000d8  0000000000000000  0000000000000000  000004dc  2**2
>>                  CONTENTS
>>  5 .reg/96       000000d8  0000000000000000  0000000000000000  00000640  2**2
>>                  CONTENTS
>>  6 load1         00829000  ffffffff81000000  0000000001000000  00000dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  7 load2a        0009e000  ffff880000001000  0000000000001000  00829dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  8 load2b        00000000  ffff88000009f000  000000000009f000  008c7dfc  2**0
>>                  ALLOC, CODE
>>  9 load3         03f00000  ffff880000100000  0000000000100000  008c7dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>> 10 load4         6bfdf000  ffff880014000000  0000000014000000  047c7dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>> 11 load5         80000000  ffff880100000000  0000000100000000  707a6dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>> == after.txt =========================================================
>>
>> If we ignore the file offset differences, one can see that something has
>> happened to "load2".
>>
>> The original vmcore "load2" looks like:
>>
>> Program Header:
>>    LOAD off    0x000000000082b000 vaddr 0xffff880000001000 paddr 0x0000000000001000 align 2**0
>>         filesz 0x000000000009ec00 memsz 0x000000000009ec00 flags rwx
>> Sections:
>>  7 load2         0009ec00  ffff880000001000  0000000000001000  0082b000  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>
>> It was split into these when passed through makedumpfile:
>>
>> Program Header:
>>    LOAD off    0x0000000000829dfc vaddr 0xffff880000001000 paddr 0x0000000000001000 align 2**0
>>         filesz 0x000000000009e000 memsz 0x000000000009ec00 flags rwx
>> Sections:
>>  7 load2a        0009e000  ffff880000001000  0000000000001000  00829dfc  2**0
>>                  CONTENTS, ALLOC, LOAD, CODE
>>  8 load2b        00000000  ffff88000009f000  000000000009f000  008c7dfc  2**0
>>                  ALLOC, CODE
>>
>> In doing so, makedumpfile truncated the size of "load2a" 0009e000 by 0xc00
>> bytes compared to original vmcore "load2" 0009ec00. This appears to be a
>> loss of data, and likely bug.
>>
>> In addition, makedumpfile also generated a new zero-length section (and no
>> corresponding program header, thankfully) of what would appear to be the page
>> address following the end of "load2a". This seems to be un-necessary, and
>> perhaps a likely bug, though harmless for this example.
>>
>> With the patch applied, the correct segment and section are generated (and
>> no extraneous section), and the newly generated vmcore loads within 'crash'.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>> ---
>> makedumpfile.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index e69b6df..94359ac 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -7326,10 +7326,13 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>> 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
>> 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
>> 					num_excluded++;
>> -					if ((pfn == pfn_end - 1) && frac_tail)
>> +					if ((pfn == pfn_end - 1) && frac_tail) {
>> 						memsz += frac_tail;
>> -					else
>> +						filesz += frac_tail;
>> +					} else {
>> 						memsz += page_size;
>> +						filesz += page_size;
>> +                    }
>
> As "!is_dumpable()" indicates, this block is for page filtering.
> If a page is excluded, page_size shouldn't be added to filesz since
> the page is not included in the file.
>
> So I don't think this approach is proper, but I don't have a good
> idea for now. It seems that a frac_tail page can be judged as
> "not dumpable" erroneously even without filtering, I suspect it's
> the root cause of your problem.
>
>
> Thanks,
> Atsushi Kumagai
>

Yes, I that does make more sense, I'll look into is_dumpable() more  
closely for the frac_tail case.

Thanks!
eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
