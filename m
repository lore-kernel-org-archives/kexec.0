Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZwQ3-0006im-GV
 for kexec@lists.infradead.org; Thu, 20 Dec 2018 11:23:13 +0000
Received: by mail-pg1-f195.google.com with SMTP id z10so740199pgp.7
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2018 03:22:59 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/2] kexec-tools/arm64: Add support to read PHYS_OFFSET
 from kcore
Date: Thu, 20 Dec 2018 16:52:50 +0530
Message-Id: <1545304972-32333-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Vadim.Lomovtsev@cavium.com, yanjiang.jin@hxt-semitech.com, bhsharma@redhat.com, takahiro.akashi@linaro.org, horms@verge.net.au, bhupesh.linux@gmail.com

Changes from v1:
---------------
 - Added the support for older kernels, where we determine the
   PHYS_OFFSET value from PT_LOAD segments inside 'kcore'.
 - Improved commit logs since v1.

On certain arm64 platforms, it has been noticed that due
to a hole at the start of physical ram exposed to kernel
(i.e. it doesn't start from address 0), the kernel still
calculates the 'memstart_addr' kernel variable as 0.

Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
would carry a first entry whose start address is non-zero
(as the physical ram exposed to the kernel starts from a
non-zero address).

In such cases, if we rely on '/proc/iomem' entries to
calculate the phys_offset, then we will have mismatch
between the user-space and kernel space 'PHYS_OFFSET'
value. The present 'kexec-tools' code does the same
in 'get_memory_ranges_iomem_cb()' function when it makes
a call to 'set_phys_offset()'. This can cause the vmcore
generated via 'kexec-tools' to miss the last few bytes as
the first '/proc/iomem' starts from a non-zero address.

Please see [0] for the original bug-report from Yanjiang Jin.

This patchset tries to fix the same.

Details about the patches in this series:
----------------------------------------
PATCH 1/2 ->

- Tries to move the elf read functionality from 'vmcore-dmesg.c' to
  a new utility library named 'elf_info.c', so that subsequent patches
  can use the same.
- See the patch log for more details.

PATCH 2/2 ->
- Implements the actual functionality of reading the PHYS_OFFSET for arm64
  platforms from the kcore (either VMCOREINFO PT_NOTE inside 'kcore'
  or from the PT_LOAD segments inside 'kcore').
- See the patch log for more details.

[0] https://www.spinics.net/lists/kexec/msg20618.html

Bhupesh Sharma (2):
  util_lib: Add functionality to read elf notes
  arm64: Add support to read PHYS_OFFSET from 'kcore' - pt_note or
    pt_load (if available)

 kexec/arch/arm64/kexec-arm64.c                     | 194 +++++-
 kexec/arch/arm64/kexec-arm64.h                     |  15 +-
 util_lib/Makefile                                  |   4 +-
 vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c | 193 ++++--
 util_lib/include/elf_info.h                        |  35 +
 vmcore-dmesg/Makefile                              |   4 +-
 vmcore-dmesg/vmcore-dmesg.c                        | 742 +--------------------
 7 files changed, 386 insertions(+), 801 deletions(-)
 copy vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c (86%)
 create mode 100644 util_lib/include/elf_info.h

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
