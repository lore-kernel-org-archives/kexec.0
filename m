Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bhUSr-0004tW-Hp
 for kexec@lists.infradead.org; Wed, 07 Sep 2016 04:28:03 +0000
Received: by mail-pf0-x22d.google.com with SMTP id w87so2088591pfk.2
 for <kexec@lists.infradead.org>; Tue, 06 Sep 2016 21:27:37 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 0/8] (kexec-tools) arm64: add kdump support
Date: Wed,  7 Sep 2016 13:33:53 +0900
Message-Id: <20160907043401.6403-1-takahiro.akashi@linaro.org>
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

My kernel patches of kdump suport on arm64 are currently under reviews.

This patchset is synced with them (v26 [1]) and provides necessary changes
for kexec-tools. It should be applied on top of Geoff's kexec-tools patches
v5[2] along with a bugfix[3].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/454588.html
[2] http://lists.infradead.org/pipermail/kexec/2016-September/017110.html
[3] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html

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

AKASHI Takahiro (6):
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
 kexec/arch/arm/crashdump-arm.c       |  40 +---
 kexec/arch/arm64/Makefile            |   2 +
 kexec/arch/arm64/crashdump-arm64.c   | 358 ++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h   |  20 +-
 kexec/arch/arm64/iomem.h             |  10 +
 kexec/arch/arm64/kexec-arm64.c       |  86 +++++++--
 kexec/arch/arm64/kexec-elf-arm64.c   |  25 ++-
 kexec/arch/arm64/kexec-image-arm64.c |  12 ++
 kexec/arch/i386/crashdump-x86.c      |  32 +---
 kexec/kexec.h                        |   2 +
 kexec/symbols.c                      |  41 ++++
 12 files changed, 534 insertions(+), 95 deletions(-)
 create mode 100644 kexec/arch/arm64/iomem.h
 create mode 100644 kexec/symbols.c

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
