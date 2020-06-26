Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jotec-0007mQ-25
 for kexec@lists.infradead.org; Fri, 26 Jun 2020 19:04:51 +0000
Subject: [PATCH 00/11] ppc64: enable kdump support for kexec_file_load syscall
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Sat, 27 Jun 2020 00:34:33 +0530
Message-ID: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

This patch series enables kdump support for kexec_file_load system
call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
code but heavily modified for kernel consumption. There is scope to
expand purgatory to verify sha digest but tried to keep purgatory
changes minimal in the interest of this series.

The first patch adds a weak arch_kexec_add_buffer function to override
locate memory hole logic suiting arch needs. There are some special
regions in ppc64 which should be avoided while loading buffer & there
are multiple callers to kexec_add_buffer making it too complicated to
maintain range sanity and using generic lookup at the same time.

The second patch marks ppc64 specific code within arch/powerpc/kexec
and arch/powerpc/purgatory to make the subsequent code changes easy
to understand.

The next patch adds helper function to setup different memory ranges
needed for loading kdump kernel, booting into it and exporting the
crashing kernel's elfcore.

The fourth patch overrides arch_kexec_add_buffer to locate memory
hole for kdump segments by accounting for the special memory regions,
referred to as excluded memory ranges, and calls __kexec_add_buffer
with kbuf->mem set to skip the generic locate memory hole lookup.

The fifth patch moves walk_drmem_lmbs() out of .init section with
a few changes to reuse it for setting up kdump kernel's usable memory
ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
and set linux,drconf-usable-memory & linux,usable-memory properties
in order to restrict kdump kernel's memory usage.

The seventh patch adds relocation support for the purgatory. Patch 8
helps setup the stack for the purgatory. The next patch setups up
backup region as a segment while loading kdump kernel and teaches
purgatory to copy it from source to destination.

Patch 10 builds the elfcore header for the running kernel & passes
the info to kdump kernel via "elfcorehdr=" parameter to export as
/proc/vmcore file. The last patch sets up the memory reserve map
for the kexec kernel and also claims kdump support as all the
necessary changes are added.

Tested the changes successfully on P8, P9 lpars & an OpenPOWER box.

---

Hari Bathini (11):
      kexec_file: allow archs to handle special regions while locating memory hole
      powerpc/kexec_file: mark PPC64 specific code
      powerpc/kexec_file: add helper functions for getting memory ranges
      ppc64/kexec_file: avoid stomping memory used by special regions
      powerpc/drmem: make lmb walk a bit more flexible
      ppc64/kexec_file: restrict memory usage of kdump kernel
      ppc64/kexec_file: add support to relocate purgatory
      ppc64/kexec_file: setup the stack for purgatory
      ppc64/kexec_file: setup backup region for kdump kernel
      ppc64/kexec_file: prepare elfcore header for crashing kernel
      ppc64/kexec_file: add appropriate regions for memory reserve map


 arch/powerpc/include/asm/crashdump-ppc64.h |   15 
 arch/powerpc/include/asm/drmem.h           |    9 
 arch/powerpc/include/asm/kexec.h           |   35 +
 arch/powerpc/include/asm/kexec_ranges.h    |   18 
 arch/powerpc/kernel/prom.c                 |   13 
 arch/powerpc/kexec/Makefile                |    2 
 arch/powerpc/kexec/elf_64.c                |   35 +
 arch/powerpc/kexec/file_load.c             |   78 +
 arch/powerpc/kexec/file_load_64.c          | 1461 ++++++++++++++++++++++++++++
 arch/powerpc/kexec/ranges.c                |  387 +++++++
 arch/powerpc/mm/drmem.c                    |   87 +-
 arch/powerpc/mm/numa.c                     |   13 
 arch/powerpc/purgatory/Makefile            |   28 -
 arch/powerpc/purgatory/purgatory_64.c      |   35 +
 arch/powerpc/purgatory/trampoline.S        |  117 --
 arch/powerpc/purgatory/trampoline_64.S     |  153 +++
 include/linux/kexec.h                      |    5 
 kernel/kexec_file.c                        |   37 +
 18 files changed, 2327 insertions(+), 201 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
 create mode 100644 arch/powerpc/include/asm/kexec_ranges.h
 create mode 100644 arch/powerpc/kexec/file_load_64.c
 create mode 100644 arch/powerpc/kexec/ranges.c
 create mode 100644 arch/powerpc/purgatory/purgatory_64.c
 delete mode 100644 arch/powerpc/purgatory/trampoline.S
 create mode 100644 arch/powerpc/purgatory/trampoline_64.S


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
