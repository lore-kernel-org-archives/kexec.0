Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSnso-0006oX-8K
 for kexec@lists.infradead.org; Wed, 05 Jul 2017 17:14:36 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [makedumpfile PATCH v2] Prevent data loss in last page of ELF core
 dumpfile
Date: Wed,  5 Jul 2017 12:13:22 -0500
Message-Id: <1499274802-30844-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

When generating an ELF core dump file, if a segment size
is not an exact multiple of PAGE_SIZE, then the corresponding
generated segment is erroneously truncated to a PAGE_SIZE multiple.
Thus a small loss of data up to PAGE_SIZE-1 bytes can occur.

The problem root is in the creation of the first bitmap, which
is the list of pages to dump as calculated from the vmcore
segments' information. (A second bitmap is created which is
a copy of the first bitmap with those bits corresponding to the
exclude/filter pages zero'd, and is the actual list of dumpable
pages).

During creation of the first bitmap, each segment is processed
to determine the first and last page frame numbers corresponding
to the segment. The page dump loops are generally written as:

  for (pfn = pfn_start; pfn < pfn_end; ++pfn)

meaning that the pfn_end needs to be one beyond the actual last
page frame number.

The last page frame number is calculated via the paddr_to_pfn()
macro on the segment end physical address of p_addr + p_memsz.
The paddr_to_pfn() macro essentially performs a right shift of
the address to extract the pfn. Since p_memsz is typically a
multiple of PAGE_SIZE, the computed pfn_end is one beyond the
actual. For example, a segment which describes the first page of
memory would be p_paddr 0 + p_memsz 0x1000 = 0x1000, and when
right shifted yields pfn_end of 1, matching the loop semantics
above and resulting in one iteration of the loop.

However, when the end physical address is not a multiple of
PAGE_SIZE, the paddr_to_pfn() macro truncates the address and
the need for one additional page for the remaining data is
unaccounted. For example, a segment which describes the 4097
bytes (PAGE_SIZE + 1), results in p_addr 0 + p_memsz 0x1001 =
0x1001, and when right shifted yields pfn_end of 1. An additional
page is needed to account for the additional data, so pfn_end
needs to be 2 in this case.

This patch detects this condition and accounts for the additional
needed page.

This problem was observed by the test case described below.

I have an existing ELF vmcore dumpfile and run it through
makedumpfile again, as such:

% makedumpfile -E -x vmlinux vmcore newvmcore
% readelf -a vmcore > vmcore.txt
% readelf -a newvmcore > newvmcore.txt

From crash, here is a description of the original vmcore:

      KERNEL: vmlinux
    DUMPFILE: vmcore
        CPUS: 4
        DATE: Thu Jan  7 07:49:10 2016
      UPTIME: 00:00:22
LOAD AVERAGE: 0.00, 0.00, 0.00
       TASKS: 77
    NODENAME: mini-amd64
     RELEASE: 4.2.0-ns.gen.amd64.1
     VERSION: #1 SMP Wed Oct 28 16:32:12 CET 2015
     MACHINE: x86_64  (2194 Mhz)
      MEMORY: 4 GB
       PANIC: "sysrq: SysRq : Trigger a crash"
         PID: 96
     COMMAND: "bash"
        TASK: ffff88017a4c9e00  [THREAD_INFO: ffff88017a198000]
         CPU: 3
       STATE: TASK_RUNNING (SYSRQ)

In essence, no re-filtering has occured and I expect to see a very similar
ELF dump file to the original.  And for the most part, the files are similar,
but I do observe some differences.

The contents of vmcore.txt are:

=== vmcore.txt ===
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
  NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000
                 0x0000000000000c6c 0x0000000000000c6c         0
  LOAD           0x0000000000002000 0xffffffff81000000 0x0000000001000000
                 0x0000000000829000 0x0000000000829000  RWE    0
  LOAD           0x000000000082b000 0xffff880000001000 0x0000000000001000
                 0x000000000009ec00 0x000000000009ec00  RWE    0
  LOAD           0x00000000008ca000 0xffff880000100000 0x0000000000100000
                 0x0000000003f00000 0x0000000003f00000  RWE    0
  LOAD           0x00000000047ca000 0xffff880014000000 0x0000000014000000
                 0x000000006bfdf000 0x000000006bfdf000  RWE    0
  LOAD           0x00000000707a9000 0xffff880100000000 0x0000000100000000
                 0x0000000080000000 0x0000000080000000  RWE    0

There is no dynamic section in this file.

There are no relocations in this file.

The decoding of unwind sections for machine type Advanced Micro Devices X86-64 is not currently supported.

Dynamic symbol information is not available for displaying symbols.

No version information found in this file.

Displaying notes found at file offset 0x00001000 with length 0x00000c6c:
  Owner                 Data size	Description
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  VMCOREINFO           0x000006c1	Unknown note type: (0x00000000)
=== vmcore.txt ===

And the contents of newvmcore.txt:

=== newvmcore.txt ===
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

The decoding of unwind sections for machine type Advanced Micro Devices X86-64 is not currently supported.

Dynamic symbol information is not available for displaying symbols.

No version information found in this file.

Displaying notes found at file offset 0x00000190 with length 0x00000c6c:
  Owner                 Data size	Description
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  VMCOREINFO           0x000006c1	Unknown note type: (0x00000000)
=== newvmcore.txt ===

Ignoring the file offset differences, one can see that something
changed on the second LOAD segment. The original vmcore has:

  LOAD           0x000000000082b000 0xffff880000001000 0x0000000000001000
                 0x000000000009ec00 0x000000000009ec00  RWE    0

whereas the newvmcore has:

  LOAD           0x0000000000829dfc 0xffff880000001000 0x0000000000001000
                 0x000000000009e000 0x000000000009ec00  RWE    0
                              ^^^^^

Specifically, the file size for this segment in newvmcore is now 0x9e000
rather than the 0x9ec00 of the original, a loss of data. (Since p_memsz
is larger than p_filesz, those 0xc00 bytes become zeros in the handling
of those addresses).

With the patch applied, the file size is again correct.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v2: posted 05jul2017 to kexec-tools list
 - feedback from Atsushi Kumagai pointed to real root of problem,
   and patch changed accordingly

v1: posted 03jul2017 to kexec-tools list
---
 makedumpfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e69b6df..26296f1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5410,7 +5410,8 @@ create_1st_bitmap_file(void)
 		if (pfn_start > info->max_mapnr)
 			continue;
 		pfn_end = MIN(pfn_end, info->max_mapnr);
-
+        /* Account for last page if it has less than page_size data in it */
+        if (phys_end & (info->page_size-1)) ++pfn_end;
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
 			set_bit_on_1st_bitmap(pfn, NULL);
 			pfn_bitmap1++;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
