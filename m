Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFRfl-0001mh-DX
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 19:49:23 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LJmhKC017048
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:49:00 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23pe03ys72-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:49:00 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 16:48:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 0BE933520068
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:48:37 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5LJmrlO63111380
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 16:48:53 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5LJmq3R019470
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 16:48:53 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Tue, 21 Jun 2016 16:48:32 -0300
Message-Id: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hello,

This patch series implements the kexec_file_load system call on PowerPC.

This system call moves the reading of the kernel, initrd and the device tree
from the userspace kexec tool to the kernel. This is needed if you want to
do one or both of the following:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

The above are the functions kexec already has built into kexec_file_load.
Yesterday I posted a set of patches which allows a third feature:

3. have IMA pass-on its event log (where integrity measurements are
   registered) accross kexec to the second kernel, so that the event
   history is preserved.

Because OpenPower uses an intermediary Linux instance as a boot loader
(skiroot), feature 1 is needed to implement secure boot for the platform,
while features 2 and 3 are needed to implement trusted boot.

This patch series starts by removing an x86 assumption from kexec_file:
kexec_add_buffer uses iomem to find reserved memory ranges, but PowerPC
uses the memblock subsystem.  A hook is added so that each arch can
specify how memory ranges can be found.

Also, the memory-walking logic in kexec_add_buffer is useful in this
implementation to find a free area for the purgatory's stack, so the
next patch moves that logic to kexec_locate_mem_hole.

The kexec_file_load system call needs to apply relocations to the
purgatory but adding code for that would duplicate functionality with
the module loading mechanism, which also needs to apply relocations to
the kernel modules.  Therefore, this patch series factors out the module
relocation code so that it can be shared.

One thing that is still missing is crashkernel support, which I intend
to submit shortly. For now, arch_kexec_kernel_image_probe rejects crash
kernels.

This code is based on kexec-tools, but with many modifications to adapt
it to the kernel environment and facilities. Except the purgatory,
which only has minimal changes.

Changes for v3:
- Rebased series on today's powerpc/next.
- Patch "kexec_file: Generalize kexec_add_buffer.":
    - Removed most arguments from arch_kexec_walk_mem and pass kbuf
      explicitly.
- Patch "powerpc: Add functions to read ELF files of any endianness.":
    - Fixed whitespace issues found by checkpatch.pl.
- Patch "powerpc: Factor out relocation code from module_64.c to
  elf_util_64.c.":
    - Changed to use the new PPC64_ELF_ABI_v2 macro.
- Patch "powerpc: Add support for loading ELF kernels with
  kexec_file_load.":
    - Adapted arch_kexec_walk_mem implementation to changes in its
      argument list.
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
- Patch "powerpc: Add purgatory for kexec_file_load implementation.":
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
    - Changed to use the new PPC64_ELF_ABI_v2 macro.

Changes for v2:

- All patches: forgot to add Signed-off-by lines in v1, so added them now.
- Patch "kexec_file: Generalize kexec_add_buffer.": broke in two, one
  adding arch_kexec_walk_mem and the other adding kexec_locate_mem_hole.
- Patch "powerpc: Implement kexec_file_load.":
    - Moved relocation changes and the arch_kexec_walk_mem implementation
      to the next patch in the series.
    - Removed pr_fmt from machine_kexec_64.c, since the patch doesn't add
      any call to pr_debug in that file.
    - Changed arch_kexec_kernel_image_probe to reject crash kernels.

Changes for v3:
- Rebased series on today's powerpc/next.
- Patch "kexec_file: Generalize kexec_add_buffer.":
    - Removed most arguments from arch_kexec_walk_mem and pass kbuf
      explicitly.
- Patch "powerpc: Add functions to read ELF files of any endianness.":
    - Fixed whitespace issues found by checkpatch.pl.
- Patch "powerpc: Factor out relocation code from module_64.c to
  elf_util_64.c.":
    - Changed to use the new PPC64_ELF_ABI_v2 macro.
- Patch "powerpc: Add support for loading ELF kernels with
  kexec_file_load.":
    - Adapted arch_kexec_walk_mem implementation to changes in its
      argument list.
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
- Patch "powerpc: Add purgatory for kexec_file_load implementation.":
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
    - Changed to use the new PPC64_ELF_ABI_v2 macro.

Changes for v2:

- All patches: forgot to add Signed-off-by lines in v1, so added them now.
- Patch "kexec_file: Generalize kexec_add_buffer.": broke in two, one
  adding arch_kexec_walk_mem and the other adding kexec_locate_mem_hole.
- Patch "powerpc: Implement kexec_file_load.":
    - Moved relocation changes and the arch_kexec_walk_mem implementation
      to the next patch in the series.
    - Removed pr_fmt from machine_kexec_64.c, since the patch doesn't add
      any call to pr_debug in that file.
    - Changed arch_kexec_kernel_image_probe to reject crash kernels.

Thiago Jung Bauermann (9):
  kexec_file: Remove unused members from struct kexec_buf.
  kexec_file: Generalize kexec_add_buffer.
  kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.
  powerpc: Factor out relocation code from module_64.c to elf_util_64.c.
  powerpc: Generalize elf64_apply_relocate_add.
  powerpc: Add functions to read ELF files of any endianness.
  powerpc: Implement kexec_file_load.
  powerpc: Add support for loading ELF kernels with kexec_file_load.
  powerpc: Add purgatory for kexec_file_load implementation.

 arch/powerpc/Kconfig                      |  13 +
 arch/powerpc/Makefile                     |   4 +
 arch/powerpc/include/asm/elf_util.h       |  92 +++++
 arch/powerpc/include/asm/kexec_elf_64.h   |  10 +
 arch/powerpc/include/asm/module.h         |  14 +-
 arch/powerpc/include/asm/systbl.h         |   1 +
 arch/powerpc/include/asm/unistd.h         |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h    |   1 +
 arch/powerpc/kernel/Makefile              |   7 +
 arch/powerpc/kernel/elf_util.c            | 476 +++++++++++++++++++++++++
 arch/powerpc/kernel/elf_util_64.c         | 374 ++++++++++++++++++++
 arch/powerpc/kernel/kexec_elf_64.c        | 560 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c    | 134 +++++++
 arch/powerpc/kernel/module_64.c           | 328 +++--------------
 arch/powerpc/purgatory/.gitignore         |   2 +
 arch/powerpc/purgatory/Makefile           |  36 ++
 arch/powerpc/purgatory/console-ppc64.c    |  38 ++
 arch/powerpc/purgatory/crashdump-ppc64.h  |  42 +++
 arch/powerpc/purgatory/crashdump_backup.c |  36 ++
 arch/powerpc/purgatory/crtsavres.S        |   5 +
 arch/powerpc/purgatory/hvCall.S           |  27 ++
 arch/powerpc/purgatory/hvCall.h           |   8 +
 arch/powerpc/purgatory/kexec-sha256.h     |  11 +
 arch/powerpc/purgatory/ppc64_asm.h        |  20 ++
 arch/powerpc/purgatory/printf.c           | 164 +++++++++
 arch/powerpc/purgatory/purgatory-ppc64.c  |  41 +++
 arch/powerpc/purgatory/purgatory-ppc64.h  |   6 +
 arch/powerpc/purgatory/purgatory.c        |  62 ++++
 arch/powerpc/purgatory/purgatory.h        |  11 +
 arch/powerpc/purgatory/sha256.c           |   6 +
 arch/powerpc/purgatory/sha256.h           |   1 +
 arch/powerpc/purgatory/string.S           |   1 +
 arch/powerpc/purgatory/v2wrap.S           | 134 +++++++
 include/linux/kexec.h                     |  23 +-
 kernel/kexec_file.c                       | 100 ++++--
 kernel/kexec_internal.h                   |  16 -
 36 files changed, 2476 insertions(+), 330 deletions(-)
 create mode 100644 arch/powerpc/include/asm/elf_util.h
 create mode 100644 arch/powerpc/include/asm/kexec_elf_64.h
 create mode 100644 arch/powerpc/kernel/elf_util.c
 create mode 100644 arch/powerpc/kernel/elf_util_64.c
 create mode 100644 arch/powerpc/kernel/kexec_elf_64.c
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/console-ppc64.c
 create mode 100644 arch/powerpc/purgatory/crashdump-ppc64.h
 create mode 100644 arch/powerpc/purgatory/crashdump_backup.c
 create mode 100644 arch/powerpc/purgatory/crtsavres.S
 create mode 100644 arch/powerpc/purgatory/hvCall.S
 create mode 100644 arch/powerpc/purgatory/hvCall.h
 create mode 100644 arch/powerpc/purgatory/kexec-sha256.h
 create mode 100644 arch/powerpc/purgatory/ppc64_asm.h
 create mode 100644 arch/powerpc/purgatory/printf.c
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.c
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.h
 create mode 100644 arch/powerpc/purgatory/purgatory.c
 create mode 100644 arch/powerpc/purgatory/purgatory.h
 create mode 100644 arch/powerpc/purgatory/sha256.c
 create mode 100644 arch/powerpc/purgatory/sha256.h
 create mode 100644 arch/powerpc/purgatory/string.S
 create mode 100644 arch/powerpc/purgatory/v2wrap.S

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
