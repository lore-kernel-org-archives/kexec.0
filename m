Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dS65N-0003IV-0O
 for kexec@lists.infradead.org; Mon, 03 Jul 2017 18:28:39 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v63ISFd4019772
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Jul 2017 18:28:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v63ISEiU001100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Jul 2017 18:28:14 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v63ISCtO010541
 for <kexec@lists.infradead.org>; Mon, 3 Jul 2017 18:28:13 GMT
Subject: Re: Possible makedumpfile ELF issues
References: <2cf9be87-2264-45d4-b273-c91ce36d5315@oracle.com>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <cf5771ce-7139-9aa1-c33c-8156c98b6cbb@oracle.com>
Date: Mon, 3 Jul 2017 13:27:26 -0500
MIME-Version: 1.0
In-Reply-To: <2cf9be87-2264-45d4-b273-c91ce36d5315@oracle.com>
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
To: kexec@lists.infradead.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

I've come to learn that objdump, when there are no sections in the ELF 
file, will on its own craft a list of sections from various information 
in the ELF file, such as segments and NOTES and such.

When examining the core files with readelf, there are no sections, just 
segments, which makes for simpler display.

It also clarifies that makedumpfile is not generating sections, just 
segments (and the weirdness with "load2a" and "load2b" is likely an 
objdump problem, not makedumpfile).

ELF Header:
   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
   Class:                             ELF64
   Data:                              2's complement, little endian
   Version:                           1 (current)
   OS/ABI:                            UNIX - System V
   ABI Version:                       0
   Type:                              CORE (Core file)
   Machine:                           Advanced Micro Devices X86-64
   Version:                           0x1
   Entry point address:               0x0
   Start of program headers:          64 (bytes into file)
   Start of section headers:          0 (bytes into file)
   Flags:                             0x0
   Size of this header:               64 (bytes)
   Size of program headers:           56 (bytes)
   Number of program headers:         6
   Size of section headers:           0 (bytes)
   Number of section headers:         0
   Section header string table index: 0

There are no sections in this file.

There are no sections to group in this file.

Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   NOTE           0x0000000000000190 0x0000000000000000 0x0000000000000000
                  0x0000000000000c6c 0x0000000000000c6c         0
   LOAD           0x0000000000000dfc 0xffffffff81000000 0x0000000001000000
                  0x0000000000829000 0x0000000000829000  RWE    0
   LOAD           0x0000000000829dfc 0xffff880000001000 0x0000000000001000
                  0x000000000009e000 0x000000000009ec00  RWE    0
   LOAD           0x00000000008c7dfc 0xffff880000100000 0x0000000000100000
                  0x0000000003f00000 0x0000000003f00000  RWE    0
   LOAD           0x00000000047c7dfc 0xffff880014000000 0x0000000014000000
                  0x000000006bfdf000 0x000000006bfdf000  RWE    0
   LOAD           0x00000000707a6dfc 0xffff880100000000 0x0000000100000000
                  0x0000000080000000 0x0000000080000000  RWE    0

There is no dynamic section in this file.

There are no relocations in this file.

The decoding of unwind sections for machine type Advanced Micro Devices 
X86-64 is not currently suppo

Dynamic symbol information is not available for displaying symbols.

No version information found in this file.

Displaying notes found at file offset 0x00000190 with length 0x00000c6c:
   Owner                 Data size   Description
   CORE                 0x00000150   NT_PRSTATUS (prstatus structure)
   CORE                 0x00000150   NT_PRSTATUS (prstatus structure)
   CORE                 0x00000150   NT_PRSTATUS (prstatus structure)
   CORE                 0x00000150   NT_PRSTATUS (prstatus structure)
   VMCOREINFO           0x000006c1   Unknown note type: (0x00000000)


On 07/01/2017 12:13 PM, Eric DeVolder wrote:
> I'm in latest makedumpfile.c, looking to add some additional filtering
> capabilities,
> and in order to obtain a sanity/reference point, I simply did the
> following:
>
> % makedumpfile -E -x vmlinux vmcore newvmcore
> % objdump --all-headers vmcore > before.txt
> % objdump --all-headers newvmcore > after.txt
>
> From crash, here is a description of the original vmcore:
>
>       KERNEL: vmlinux
>     DUMPFILE: vmcore
>         CPUS: 4
>         DATE: Thu Jan  7 07:49:10 2016
>       UPTIME: 00:00:22
> LOAD AVERAGE: 0.00, 0.00, 0.00
>        TASKS: 77
>     NODENAME: mini-amd64
>      RELEASE: 4.2.0-ns.gen.amd64.1
>      VERSION: #1 SMP Wed Oct 28 16:32:12 CET 2015
>      MACHINE: x86_64  (2194 Mhz)
>       MEMORY: 4 GB
>        PANIC: "sysrq: SysRq : Trigger a crash"
>          PID: 96
>      COMMAND: "bash"
>         TASK: ffff88017a4c9e00  [THREAD_INFO: ffff88017a198000]
>          CPU: 3
>        STATE: TASK_RUNNING (SYSRQ)
>
> In essence, no re-filtering has occurred and I expect to see a very similar
> ELF dump file to the original.  And for the most part, the files are
> similar,
> but I do observe some differences for which I ask the following questions.
>
> The contents of before.txt are:
>
> == before.txt ========================================================
> vmcore:     file format elf64-x86-64
> vmcore
> architecture: i386:x86-64, flags 0x00000000:
>
> start address 0x0000000000000000
>
> Program Header:
>     NOTE off    0x0000000000001000 vaddr 0x0000000000000000 paddr
> 0x0000000000000000 align 2**0
>          filesz 0x0000000000000c6c memsz 0x0000000000000c6c flags ---
>     LOAD off    0x0000000000002000 vaddr 0xffffffff81000000 paddr
> 0x0000000001000000 align 2**0
>          filesz 0x0000000000829000 memsz 0x0000000000829000 flags rwx
>     LOAD off    0x000000000082b000 vaddr 0xffff880000001000 paddr
> 0x0000000000001000 align 2**0
>          filesz 0x000000000009ec00 memsz 0x000000000009ec00 flags rwx
>     LOAD off    0x00000000008ca000 vaddr 0xffff880000100000 paddr
> 0x0000000000100000 align 2**0
>          filesz 0x0000000003f00000 memsz 0x0000000003f00000 flags rwx
>     LOAD off    0x00000000047ca000 vaddr 0xffff880014000000 paddr
> 0x0000000014000000 align 2**0
>          filesz 0x000000006bfdf000 memsz 0x000000006bfdf000 flags rwx
>     LOAD off    0x00000000707a9000 vaddr 0xffff880100000000 paddr
> 0x0000000100000000 align 2**0
>          filesz 0x0000000080000000 memsz 0x0000000080000000 flags rwx
>
> Sections:
> Idx Name          Size      VMA               LMA               File off
>  Algn
>   0 note0         00000c6c  0000000000000000  0000000000000000 00001000
> 2**0
>                   CONTENTS, READONLY
>   1 .reg/0        000000d8  0000000000000000  0000000000000000 00001084
> 2**2
>                   CONTENTS
>   2 .reg          000000d8  0000000000000000  0000000000000000 00001084
> 2**2
>                   CONTENTS
>   3 .reg/0        000000d8  0000000000000000  0000000000000000 000011e8
> 2**2
>                   CONTENTS
>   4 .reg/0        000000d8  0000000000000000  0000000000000000 0000134c
> 2**2
>                   CONTENTS
>   5 .reg/96       000000d8  0000000000000000  0000000000000000 000014b0
> 2**2
>                   CONTENTS
>   6 load1         00829000  ffffffff81000000  0000000001000000 00002000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   7 load2         0009ec00  ffff880000001000  0000000000001000 0082b000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   8 load3         03f00000  ffff880000100000  0000000000100000 008ca000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   9 load4         6bfdf000  ffff880014000000  0000000014000000 047ca000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>  10 load5         80000000  ffff880100000000  0000000100000000 707a9000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
> SYMBOL TABLE:
> no symbols
>
> == before.txt ========================================================
>
> And the contents of after.txt:
>
> == after.txt =========================================================
> newvmcore:  file format elf64-x86-64
> newvmcore:
> architecture: i386:x86-64, flags 0x00000000:
>
> start address 0x0000000000000000
>
> Program Header:
>     NOTE off    0x0000000000000190 vaddr 0x0000000000000000 paddr
> 0x0000000000000000 align 2**0
>          filesz 0x0000000000000c6c memsz 0x0000000000000c6c flags ---
>     LOAD off    0x0000000000000dfc vaddr 0xffffffff81000000 paddr
> 0x0000000001000000 align 2**0
>          filesz 0x0000000000829000 memsz 0x0000000000829000 flags rwx
>     LOAD off    0x0000000000829dfc vaddr 0xffff880000001000 paddr
> 0x0000000000001000 align 2**0
>          filesz 0x000000000009e000 memsz 0x000000000009ec00 flags rwx
>     LOAD off    0x00000000008c7dfc vaddr 0xffff880000100000 paddr
> 0x0000000000100000 align 2**0
>          filesz 0x0000000003f00000 memsz 0x0000000003f00000 flags rwx
>     LOAD off    0x00000000047c7dfc vaddr 0xffff880014000000 paddr
> 0x0000000014000000 align 2**0
>          filesz 0x000000006bfdf000 memsz 0x000000006bfdf000 flags rwx
>     LOAD off    0x00000000707a6dfc vaddr 0xffff880100000000 paddr
> 0x0000000100000000 align 2**0
>          filesz 0x0000000080000000 memsz 0x0000000080000000 flags rwx
>
> Sections:
> Idx Name          Size      VMA               LMA               File off
>  Algn
>   0 note0         00000c6c  0000000000000000  0000000000000000 00000190
> 2**0
>                   CONTENTS, READONLY
>   1 .reg/0        000000d8  0000000000000000  0000000000000000 00000214
> 2**2
>                   CONTENTS
>   2 .reg          000000d8  0000000000000000  0000000000000000 00000214
> 2**2
>                   CONTENTS
>   3 .reg/0        000000d8  0000000000000000  0000000000000000 00000378
> 2**2
>                   CONTENTS
>   4 .reg/0        000000d8  0000000000000000  0000000000000000 000004dc
> 2**2
>                   CONTENTS
>   5 .reg/96       000000d8  0000000000000000  0000000000000000 00000640
> 2**2
>                   CONTENTS
>   6 load1         00829000  ffffffff81000000  0000000001000000 00000dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   7 load2a        0009e000  ffff880000001000  0000000000001000 00829dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   8 load2b        00000000  ffff88000009f000  000000000009f000 008c7dfc
> 2**0
>                   ALLOC, CODE
>   9 load3         03f00000  ffff880000100000  0000000000100000 008c7dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>  10 load4         6bfdf000  ffff880014000000  0000000014000000 047c7dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>  11 load5         80000000  ffff880100000000  0000000100000000 707a6dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
> == after.txt =========================================================
>
> When I 'diff' these, I see two primary differences:
>
> 1) The file offsets in the newvmcore are 'packed' together.
> 2) Something happened to "load2".
>
> The first question is this: does it make sense for makedumpfile to align
> the
> file offset for LOAD sections onto a PAGE_SIZE boundary? Perhaps this makes
> sense only if the VMA/LMA are already aligned on a PAGE_SIZE boundary. The
> kernel /proc/vmcore appears to do this.
>
> If we ignore the file offset differences, all that is left is what happened
> to "load2".
>
> The original vmcore "load2" looks like:
>
> Program Header:
>     LOAD off    0x000000000082b000 vaddr 0xffff880000001000 paddr
> 0x0000000000001000 align 2**0
>          filesz 0x000000000009ec00 memsz 0x000000000009ec00 flags rwx
> Sections:
>   7 load2         0009ec00  ffff880000001000  0000000000001000 0082b000
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>
> and for reasons I have yet to investigate, it was split into these when
> passed
> through makedumpfile:
>
> Program Header:
>     LOAD off    0x0000000000829dfc vaddr 0xffff880000001000 paddr
> 0x0000000000001000 align 2**0
>          filesz 0x000000000009e000 memsz 0x000000000009ec00 flags rwx
> Sections:
>   7 load2a        0009e000  ffff880000001000  0000000000001000 00829dfc
> 2**0
>                   CONTENTS, ALLOC, LOAD, CODE
>   8 load2b        00000000  ffff88000009f000  000000000009f000 008c7dfc
> 2**0
>                   ALLOC, CODE
>
> In doing so, makedumpfile truncated the size of "load2a" 0009e000 by 0xc00
> bytes compared to original vmcore "load2" 0009ec00. This appears to be a
> loss of data, and likely bug.
>
> In addition, makedumpfile also generated a new zero-length section (and no
> corresponding program header, thankfully) of what would appear to be the
> page
> address following the end of "load2a". This seems to be un-necessary, and
> perhaps a likely bug, though harmless for this example.
>
> Thanks for your feedback/insight,
> Eric
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
