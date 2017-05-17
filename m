Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArom-0000dP-TU
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:48:18 +0000
Received: by mail-pf0-x22e.google.com with SMTP id 9so1827383pfj.1
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:47:56 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 00/10] (kexec-tools) arm64: add kdump support
Date: Wed, 17 May 2017 14:51:40 +0900
Message-Id: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

My kernel patches of kdump support on arm64 were merged in v4.12-rc1.

This patchset is synced with them and provides necessary changes for
kexec-tools. It can be applied on top of kexec-tools master branch.

Patch #1 to #4 are preparatory patches for succeeding patches,
#5 to #9 are main part of kdump implementation for vmlinux support
and #10 is for Image support.

Changes for v7:
 - rebased on the latest master
 - fix incorrect return values on error (patch #4)
 - implement get_crash_kernel_load_range() (patch #5)
 - rename some variables/functions for better readability (patch #5/#9)
 - add/revise comments

Changes for v6:
 - use get_kernel_sym() from x86, not from arm (patch #2)
 - always take root node's "#address-cells" and "#size-cells" into account
   when adding "linux,usable-memory-range" and "linux,elfcorehdr"
   (patch #8)

Changes for v5:
 - remove "linux,crashkernel-base/size" handling aligned with a change
   on the kernel side

Changes for v4:
 - rebased on the master branch (including Geoff's v6)
 - revive "linux,usable-memory-range" DT property (from v2), dropping
   use of "reserved-memory" nodes introduced in v3 (patch #8)
 - extend the semantics of kexec_iomem_for_each_line() per Pratyush
   (patch #1)

Changes for v3:
 - rebased on Geoff's v5
 - fix a value of estimated PHYS_OFFSET
 - add a kernel code/data segment because they now reside out of linear
   mapping due to KASLR introduction
 - remove "linux,usable-memory-range" dependency, instead using
   "reserved-memory" node
 - add -mem-min/-mem-max support

Changes for v2:
 - trim a temoprary buffer in setup_2nd_dtb()
 - add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
 - update patch#7 from Pratyush
   (re-worked by akashi)

AKASHI Takahiro (8):
  kexec: exntend the semantics of kexec_iomem_for_each_line
  arm64: identify PHYS_OFFSET correctly
  arm64: change return values on error to negative
  arm64: kdump: identify memory regions
  arm64: kdump: add elf core header segment
  arm64: kdump: set up kernel image segment
  arm64: kdump: set up other segments
  arm64: kdump: add DT properties to crash dump kernel's dtb

Pratyush Anand (2):
  kexec: generalize and rename get_kernel_stext_sym()
  arm64: kdump: Add support for binary image files

 kexec/Makefile                       |   1 +
 kexec/arch/arm/crashdump-arm.c       |  40 +-----
 kexec/arch/arm64/Makefile            |   3 +
 kexec/arch/arm64/crashdump-arm64.c   | 229 +++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h   |  18 ++-
 kexec/arch/arm64/iomem.h             |  10 ++
 kexec/arch/arm64/kexec-arm64.c       | 263 +++++++++++++++++++++++++++++++----
 kexec/arch/arm64/kexec-elf-arm64.c   |  31 +++--
 kexec/arch/arm64/kexec-image-arm64.c |  17 ++-
 kexec/arch/i386/crashdump-x86.c      |  29 ----
 kexec/kexec-iomem.c                  |  15 +-
 kexec/kexec.h                        |   2 +
 kexec/symbols.c                      |  34 +++++
 13 files changed, 579 insertions(+), 113 deletions(-)
 create mode 100644 kexec/arch/arm64/iomem.h
 create mode 100644 kexec/symbols.c

-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
