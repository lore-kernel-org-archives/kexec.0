Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1414099246.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
Date: Thu, 23 Oct 2014 23:10:58 +0000
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
Cc: marc.zyngier@arm.com, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  I have tested
with the ARM VE fast model, the ARM Base model and the ARM Foundation
model with various kernel config options for both the first and second stage
kernels.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patches 5 and 6 convert the use of device tree /memreserve/ to device tree
reserved-memory nodes.

Patch 7 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 8-10 add the actual kexec support.

Please consider all patches for inclusion.  Any comments or suggestions on how 
to improve are welcome.

[1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
[2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git

Several things are known to have problems on kexec re-boot:

spin-table
----------

PROBLEM: The spin-table enable method does not implement all the methods needed
for CPU hot-plug, so the first stage kernel cannot be shutdown properly.

WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
on the first stage kernel command line.

FIX: Upgrade system firmware to provide PSCI enable method support.

KVM
---

PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
resources on shutdown, so the first stage kernel cannot be shutdown properly.

WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.

FIX: Fix KVM to support soft_restart().  KVM needs to restore default exception
vectors, etc.

UEFI
----

PROBLEM: UEFI does not manage its runtime services virtual mappings in a way
that is compatible with a kexec re-boot, so the second stage kernel hangs on
boot-up.

WORK-AROUND: Disable UEFI in firmware, OR use EFI uboot emulation if provided
by your firmware.

FIX: Fix kernel to manage UEFI virtual mappings properly.

/memreserve/
----------

PROBLEM: The use of device tree /memreserve/ entries is not compatible with
kexec re-boot.  The second stage kernel will use the reserved regions and the
system will become unstable.

WORK-AROUND: Pass a user specified DTB using the kexec --dtb option.

FIX: Convert device tree source files (.dts) and/or bootloaders to use device
tree reserved-memory nodes to specify reserved memory.

----------------------------------------------------------------

The following changes since commit 0a6479b0ffad8dd236915e271faaf2cbb4cac287:

  arm64: Remove unneeded extern keyword (2014-10-03 14:51:02 +0100)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v5

for you to fetch changes up to ba8c9e4ffea288f15c6843645acd33956204518a:

  arm64/kexec: Add pr_devel output (2014-10-23 13:58:40 -0700)

----------------------------------------------------------------
Geoff Levand (10):
      arm64/kvm: Fix assembler compatibility of macros
      arm64: Convert hcalls to use ISS field
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add EL2 switch to soft_restart
      arm64: Convert dts to use reserved-memory nodes
      arm64: Update booting.txt to reserved-memory nodes
      arm64: Move proc-macros.S to include/asm
      arm64/kexec: Add core kexec support
      arm64/kexec: Enable kexec in the arm64 defconfig
      arm64/kexec: Add pr_devel output

 Documentation/arm64/booting.txt              |   4 +-
 arch/arm64/Kconfig                           |   9 ++
 arch/arm64/boot/dts/foundation-v8.dts        |  13 +-
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts       |  13 +-
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/kexec.h               |  47 ++++++
 arch/arm64/include/asm/kvm_arm.h             |  21 +--
 arch/arm64/include/asm/proc-fns.h            |   4 +-
 arch/arm64/{mm => include/asm}/proc-macros.S |   0
 arch/arm64/include/asm/virt.h                |  33 ++++
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/hyp-stub.S                 |  45 ++++--
 arch/arm64/kernel/machine_kexec.c            | 225 +++++++++++++++++++++++++++
 arch/arm64/kernel/process.c                  |   6 +-
 arch/arm64/kernel/relocate_kernel.S          | 184 ++++++++++++++++++++++
 arch/arm64/kvm/hyp.S                         |  18 ++-
 arch/arm64/mm/cache.S                        |   3 +-
 arch/arm64/mm/proc.S                         |  50 ++++--
 include/uapi/linux/kexec.h                   |   1 +
 19 files changed, 624 insertions(+), 54 deletions(-)
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
