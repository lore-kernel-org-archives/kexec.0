Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yb3Ae-0002uZ-NV
 for kexec@lists.infradead.org; Thu, 26 Mar 2015 08:29:45 +0000
Received: by pdbop1 with SMTP id op1so55864351pdb.2
 for <kexec@lists.infradead.org>; Thu, 26 Mar 2015 01:29:22 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/5] arm64: add kdump support
Date: Thu, 26 Mar 2015 17:28:48 +0900
Message-Id: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org

This patch set enables kdump (crash dump kernel) support on arm64 on top of
Geoff's kexec patchset.

In this version, there are some arm64-specific usage/constraints:
1) "mem=" boot parameter must be specified on crash dump kernel
2) Kvm will not be enabled on crash dump kernel even if configured
See commit messages and Documentation/kdump/kdump.txt for details.

The only concern I have is whether or not we can use the exact same kernel
as both system kernel and crash dump kernel. The current arm64 kernel is
not relocatable in the exact sense but I have no problems in using the same
binary for testing kdump.

I tested the code with
	- ATF v1.1 + EDK2(UEFI) v3.0-rc0
	- kernel v4.0-rc4 + Geoff' kexec v8
on Base fast model, using my yet-to-be-submitted kexec-tools [1].
You may want to start a kernel with the following boot parameter:
	crashkernel=64M@2240M
and try
	$ kexec -p --load <vmlinux> --append ...
	$ echo c > /proc/sysrq-trigger

To examine vmcore (/proc/vmcore), you may use
	- gdb v7.7 or later
	- crash + a small patch (to recognize v4.0 kernel)

[1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git


AKASHI Takahiro (5):
  arm64: kdump: reserve memory for crash dump kernel
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: do not go into EL2 before starting a crash dump kernel
  arm64: add kdump support
  arm64: enable kdump in the arm64 defconfig

 Documentation/kdump/kdump.txt     |   31 ++++++++++++++-
 arch/arm64/Kconfig                |   12 ++++++
 arch/arm64/configs/defconfig      |    1 +
 arch/arm64/include/asm/kexec.h    |   34 +++++++++++++++-
 arch/arm64/kernel/Makefile        |    1 +
 arch/arm64/kernel/crash_dump.c    |   71 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c |   55 +++++++++++++++++++++++++-
 arch/arm64/kernel/process.c       |    7 +++-
 arch/arm64/kernel/setup.c         |   78 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |   10 ++++-
 10 files changed, 294 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
