Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1411604443.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
Date: Thu, 25 Sep 2014 00:23:26 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: marc.zyngier@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  I have tested
with the ARM VE fast model using various kernel config options for both the
first and second stage kernels.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

This series does not include some re-work of the spin-table CPU enable method
that is needed to support it, nor does it include some re-work of KVM to support
CPU soft reset.  A kernel built with these patches will boot and run correctly,
but will fail to load a kexec kernel if running on a machine with any spin-table
enabled CPUs and will fail the kexec re-boot if the first stage kernel was built
with CONFIG_KVM=y.  Work-in-progress patches to support these are in the master
branch of my linux-kexec repository [1].

Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patch 5 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 11 and 12 add the actual kexec support.

Please consider all patches for inclusion.  Any comments or suggestions on how 
to improve are welcome.

[1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
[2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff

The following changes since commit 1059c6bf8534acda249e7e65c81e7696fb074dc1:

  arm64: debug: don't re-enable debug exceptions on return from el1_dbg (2014-09-23 15:49:34 +0100)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v3

for you to fetch changes up to d0dcec391ae430d2c0aa2ba770c4c21b1414fa68:

  arm64/kexec: Enable kexec in the arm64 defconfig (2014-09-24 17:18:32 -0700)

----------------------------------------------------------------
Geoff Levand (7):
      arm64/kvm: Fix assembler compatibility of macros
      arm64: Convert hcalls to use ISS field
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add EL2 switch to soft_restart
      arm64: Move proc-macros.S to include/asm
      arm64/kexec: Add core kexec support
      arm64/kexec: Enable kexec in the arm64 defconfig

 arch/arm64/Kconfig                           |   9 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/kexec.h               |  47 +++++++
 arch/arm64/include/asm/kvm_arm.h             |   2 +-
 arch/arm64/include/asm/proc-fns.h            |   4 +-
 arch/arm64/{mm => include/asm}/proc-macros.S |   0
 arch/arm64/include/asm/virt.h                |  33 +++++
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/hyp-stub.S                 |  44 +++++--
 arch/arm64/kernel/machine_kexec.c            | 183 +++++++++++++++++++++++++++
 arch/arm64/kernel/process.c                  |   6 +-
 arch/arm64/kernel/relocate_kernel.S          | 183 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp.S                         |  18 ++-
 arch/arm64/mm/cache.S                        |   3 +-
 arch/arm64/mm/proc.S                         |  50 ++++++--
 include/uapi/linux/kexec.h                   |   1 +
 16 files changed, 546 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 rename arch/arm64/{mm => include/asm}/proc-macros.S (100%)
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
