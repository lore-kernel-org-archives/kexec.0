Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailapp01.imgtec.com ([195.59.15.196])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCkTa-0000vV-R3
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 09:49:59 +0000
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 0/6] Kexec fixes and updates for MIPS platforms
Date: Fri, 2 Dec 2016 10:49:05 +0100
Message-ID: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
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
To: kexec@lists.infradead.org
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>

This patch series tries to bring the support for MIPS up to date and make it more
generic (fix little-endian support, simplify code for 32/64 bit handling), as well
as to clean up some existing incorrect code (patches 1-4).

Patches 5 & 6 add new functionality - passing external DTBs and initrd, especially
the DTB support is required for platforms that use a recently introduced generic
kernel infrastructure.

Note that patch 5 (and 6, as it depends on patch 5) require changes in the kernel
that are currently pending review:
https://patchwork.linux-mips.org/patch/14615/

Core dump support is currently broken on all MIPS kernels and is also pending
review:
https://patchwork.linux-mips.org/patch/14587/
https://patchwork.linux-mips.org/patch/14586/

Patches 1-4 can be safely added without waiting for kernel patches to be merged,
but patches 5-6 should be held until the kernel patches are accepted in case changes
are requested.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Marcin Nowakowski (6):
  mips: remove incorrect arch_usage string
  mips: use arch_options for both 32 and 64 bit variants
  mips: move arch option parsing from elf loader to common arch code
  mips: crashdump: add little-endian support
  mips: add dtb loading support
  mips: add option to load initrd from a specified file

 kexec/arch/mips/Makefile               | 13 +++++
 kexec/arch/mips/crashdump-mips.c       | 22 +++++---
 kexec/arch/mips/include/arch/options.h | 11 ++--
 kexec/arch/mips/kexec-elf-mips.c       | 96 +++++++++++++++++++---------------
 kexec/arch/mips/kexec-mips.c           | 46 +++++++++++++---
 kexec/arch/mips/kexec-mips.h           | 13 ++++-
 6 files changed, 142 insertions(+), 59 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
