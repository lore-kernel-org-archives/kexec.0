Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKhYs-0005cp-GV
 for kexec@lists.infradead.org; Wed, 06 Jul 2016 07:47:59 +0000
Received: by mail-pf0-x22c.google.com with SMTP id t190so77760716pfb.3
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 00:47:38 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v21 0/8] arm64: kdump support
Date: Wed,  6 Jul 2016 16:52:18 +0900
Message-Id: <20160706075226.27609-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: geoff@infradead.org, kexec@lists.infradead.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch series adds kdump support on arm64.

To load a crash-dump kernel to the systems, a series of patches to
kexec-tools [1], which have not yet been merged upstream, are needed.
Please update to the latest if you have been using an older version.

To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
  - crash utility (coming v7.1.6 or later) [2]
    (Necessary patches have already been queued in the master.)

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
[2]  https://github.com/crash-utility/crash.git

Changes for v21 (July 6, 2016):

  o Remove kexec patches.
  o Rebase to arm64's for-next/core (Linux-4.7-rc4 based).
  o Clarify the description about kvm in kdump.txt.

See the following link [3] for older changes:
[3]  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html

AKASHI Takahiro (7):
  arm64: kdump: reserve memory for crash dump kernel
  arm64: limit memory regions based on DT property, usable-memory
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: add kdump support
  arm64: kdump: add VMCOREINFO's for user-space coredump tools
  arm64: kdump: enable kdump in the arm64 defconfig
  arm64: kdump: update a kernel doc

James Morse (1):
  Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec

 Documentation/devicetree/bindings/chosen.txt |  28 +++++
 Documentation/kdump/kdump.txt                |  16 ++-
 arch/arm64/Kconfig                           |  11 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/hardirq.h             |   2 +-
 arch/arm64/include/asm/kexec.h               |  41 ++++++-
 arch/arm64/include/asm/smp.h                 |   4 +
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/crash_dump.c               |  71 ++++++++++++
 arch/arm64/kernel/machine_kexec.c            |  67 +++++++++++-
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  61 +++++++++++
 arch/arm64/mm/init.c                         | 154 +++++++++++++++++++++++++++
 13 files changed, 457 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
