Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwYo-000856-MH
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:34:41 +0000
Received: by mail-pg0-f46.google.com with SMTP id 14so53178653pgg.1
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:34:15 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 0/9] (kexec-tools) arm64: add kdump support
Date: Tue, 24 Jan 2017 17:33:22 +0900
Message-Id: <20170124083331.3468-1-takahiro.akashi@linaro.org>
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

My kernel patches of kdump support on arm64 are currently under review.

This patchset is synced with them (v30 [1]) and provides necessary changes
for kexec-tools. It can be applied on top of kexec-tools master branch.

[1] T.B.D.

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

AKASHI Takahiro (7):
  kexec: exntend the semantics of kexec_iomem_for_each_line
  arm64: identify PHYS_OFFSET correctly
  arm64: kdump: identify memory regions
  arm64: kdump: add elf core header segment
  arm64: kdump: set up kernel image segment
  arm64: kdump: set up other segments
  arm64: kdump: add DT properties to crash dump kernel's dtb

Pratyush Anand (2):
  kexec: generalize and rename get_kernel_stext_sym()
  arm64: kdump: Add support for binary image files

 kexec/Makefile                       |   1 +
 kexec/arch/arm/crashdump-arm.c       |  40 +------
 kexec/arch/arm64/Makefile            |   2 +
 kexec/arch/arm64/crashdump-arm64.c   | 219 ++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h   |  18 ++-
 kexec/arch/arm64/iomem.h             |  10 ++
 kexec/arch/arm64/kexec-arm64.c       | 113 +++++++++++++++---
 kexec/arch/arm64/kexec-elf-arm64.c   |  25 +++-
 kexec/arch/arm64/kexec-image-arm64.c |  12 ++
 kexec/arch/i386/crashdump-x86.c      |  29 -----
 kexec/kexec-iomem.c                  |  15 ++-
 kexec/kexec.h                        |   2 +
 kexec/symbols.c                      |  41 +++++++
 13 files changed, 432 insertions(+), 95 deletions(-)
 create mode 100644 kexec/arch/arm64/iomem.h
 create mode 100644 kexec/symbols.c

-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
