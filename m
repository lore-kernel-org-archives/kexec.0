Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz4nl-0007T7-So
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 21:00:22 +0000
Subject: [PATCH v5 00/11] ppc64: enable kdump support for kexec_file_load
 syscall
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Sat, 25 Jul 2020 02:30:04 +0530
Message-ID: <159562433305.7836.11742488792509689660.stgit@hbathini.in.ibm.com>
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
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

This patch series enables kdump support for kexec_file_load system
call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
code but heavily modified for kernel consumption.

The first patch adds a weak arch_kexec_locate_mem_hole() function to
override locate memory hole logic suiting arch needs. There are some
special regions in ppc64 which should be avoided while loading buffer
& there are multiple callers to kexec_add_buffer making it complicated
to maintain range sanity and using generic lookup at the same time.

The second patch marks ppc64 specific code within arch/powerpc/kexec
and arch/powerpc/purgatory to make the subsequent code changes easy
to understand.

The next patch adds helper function to setup different memory ranges
needed for loading kdump kernel, booting into it and exporting the
crashing kernel's elfcore.

The fourth patch overrides arch_kexec_locate_mem_hole() function to
locate memory hole for kdump segments by accounting for the special
memory regions, referred to as excluded memory ranges, and sets
kbuf->mem when a suitable memory region is found.

The fifth patch moves walk_drmem_lmbs() out of .init section with
a few changes to reuse it for setting up kdump kernel's usable memory
ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
and set linux,drconf-usable-memory & linux,usable-memory properties
in order to restrict kdump kernel's memory usage.

The seventh patch updates purgatory to setup r8 & r9 with opal base
and opal entry addresses respectively to aid kernels built with
CONFIG_PPC_EARLY_DEBUG_OPAL enabled. The next patch setups up backup
region as a kexec segment while loading kdump kernel and teaches
purgatory to copy data from source to destination.

Patch 09 builds the elfcore header for the running kernel & passes
the info to kdump kernel via "elfcorehdr=" parameter to export as
/proc/vmcore file. The next patch sets up the memory reserve map
for the kexec kernel and also claims kdump support for kdump as
all the necessary changes are added.

The last patch fixes a lookup issue for `kexec -l -s` case when
memory is reserved for crashkernel.

Tested the changes successfully on P8, P9 lpars, couple of OpenPOWER
boxes, one with secureboot enabled, KVM guest and a simulator.

v4 -> v5:
* Dropped patches 07/12 & 08/12 and updated purgatory to do everything
  in assembly.
* Added a new patch (which was part of patch 08/12 in v4) to update
  r8 & r9 registers with opal base & opal entry addresses as it is
  expected on kernels built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled.
* Fixed kexec load issue on KVM guest.

v3 -> v4:
* Updated get_node_path() function to be iterative instead of a recursive one.
* Added comment explaining why low memory is added to kdump kernel's usable
  memory ranges though it doesn't fall in crashkernel region.
* Fixed stack_buf to be quadword aligned in accordance with ABI.
* Added missing of_node_put() in setup_purgatory_ppc64().
* Added a FIXME tag to indicate issue in adding opal/rtas regions to
  core image.

v2 -> v3:
* Fixed TOC pointer calculation for purgatory by using section info
  that has relocations applied.
* Fixed arch_kexec_locate_mem_hole() function to fallback to generic
  kexec_locate_mem_hole() lookup if exclude ranges list is empty.
* Dropped check for backup_start in trampoline_64.S as purgatory()
  function takes care of it anyway.

v1 -> v2:
* Introduced arch_kexec_locate_mem_hole() for override and dropped
  weak arch_kexec_add_buffer().
* Addressed warnings reported by lkp.
* Added patch to address kexec load issue when memory is reserved
  for crashkernel.
* Used the appropriate license header for the new files added.
* Added an option to merge ranges to minimize reallocations while
  adding memory ranges.
* Dropped within_crashkernel parameter for add_opal_mem_range() &
  add_rtas_mem_range() functions as it is not really needed.

---

Hari Bathini (11):
      kexec_file: allow archs to handle special regions while locating memory hole
      powerpc/kexec_file: mark PPC64 specific code
      powerpc/kexec_file: add helper functions for getting memory ranges
      ppc64/kexec_file: avoid stomping memory used by special regions
      powerpc/drmem: make lmb walk a bit more flexible
      ppc64/kexec_file: restrict memory usage of kdump kernel
      ppc64/kexec_file: enable early kernel's OPAL calls
      ppc64/kexec_file: setup backup region for kdump kernel
      ppc64/kexec_file: prepare elfcore header for crashing kernel
      ppc64/kexec_file: add appropriate regions for memory reserve map
      ppc64/kexec_file: fix kexec load failure with lack of memory hole


 arch/powerpc/include/asm/crashdump-ppc64.h |   19 
 arch/powerpc/include/asm/drmem.h           |    9 
 arch/powerpc/include/asm/kexec.h           |   29 +
 arch/powerpc/include/asm/kexec_ranges.h    |   25 +
 arch/powerpc/kernel/prom.c                 |   13 
 arch/powerpc/kexec/Makefile                |    2 
 arch/powerpc/kexec/elf_64.c                |   36 +
 arch/powerpc/kexec/file_load.c             |   60 +
 arch/powerpc/kexec/file_load_64.c          | 1209 ++++++++++++++++++++++++++++
 arch/powerpc/kexec/ranges.c                |  417 ++++++++++
 arch/powerpc/mm/drmem.c                    |   87 +-
 arch/powerpc/mm/numa.c                     |   13 
 arch/powerpc/purgatory/Makefile            |    4 
 arch/powerpc/purgatory/trampoline.S        |  117 ---
 arch/powerpc/purgatory/trampoline_64.S     |  162 ++++
 include/linux/kexec.h                      |   29 -
 kernel/kexec_file.c                        |   16 
 17 files changed, 2052 insertions(+), 195 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
 create mode 100644 arch/powerpc/include/asm/kexec_ranges.h
 create mode 100644 arch/powerpc/kexec/file_load_64.c
 create mode 100644 arch/powerpc/kexec/ranges.c
 delete mode 100644 arch/powerpc/purgatory/trampoline.S
 create mode 100644 arch/powerpc/purgatory/trampoline_64.S


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
