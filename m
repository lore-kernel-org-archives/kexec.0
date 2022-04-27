From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:48:54 -0300
Subject: [PATCH 00/30] The panic notifiers refactor
Message-ID: <20220427224924.592546-1-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hey folks, this is an attempt to improve/refactor the dated panic notifiers
infrastructure. This is strongly based in a suggestion made by Pter Mladek [0]
some time ago, and it's finally ready. Below I'll detail the patch ordering,
testing made, etc.
First, a bit about the reason behind this.

The panic notifiers list is an infrastructure that allows callbacks to execute
during panic time. Happens that anybody can add functions there, no ordering
is enforced (by default) and the decision to execute or not such notifiers
before kdump may lead to high risk of failure in crash scenarios - default is
not to execute any of them. There is a parameter acting as a switch for that.
But some architectures require some notifiers, so..it's messy.

The suggestion from Petr came after a patch submission to add a notifiers
filter, allowing the notifiers selection by function name, which was welcomed
by some people, but not by Petr, which claimed the code should indeed have a
refactor - and it made a lot of sense, his suggestion makes code more clear
and reliable.

So, this series might be split in 3 portions:

Part 1: the first 18 patches are mostly fixes (one or two might be considered
improvements), mostly replacing spinlocks/mutexes with safer alternatives for
atomic contexts, like spin_trylock, etc. We also focused on commenting
everything that is possible and clean-up code.

Part 2, the core: patches 19-25 are the main refactor, which splits the panic
notifiers list in three, introduce the concept of panic notifier level and
clean-up and highly comment the code, effectively leading to a more reliable
and clear, yet highly customizable panic path.

Part 3: The remaining 5 patches are fixes that _require the main refactor_
patches, they don't make sense without the core changes - but again, these are
small fixes and not part of the main goal of refactoring the panic code.

I've tried my best to make the patches the more "bisectable" as possible, so
they tend to be self-contained and easy to backport (specially patches from
part 1). Notice that the series is *based on 5.18-rc4* - usually a refactor
like this would be based on linux-next, but since we have many fixes in the
series, I kept it based on mainline tree. Of course I could change that in a
subsequent iteration, if desired.

Since this touches multiple architectures and drivers, it's very difficult to
test it really (by executing all touched code). So, my tests split in two
approaches: build tests and real tests, that involves panic triggering with
and without kdump, changing panic notifiers level, etc.

Build tests (using cross-compilers): alpha, arm, arm64, mips (sgi 22 and 32),
parisc, s390, sparc, um, x86_64 (couldn't get a functional xtensa cross
compiler).

Real/full tests: x86_64 (Hyper-V and QEMU guests) + PowerPC (pseries guest).

Here is the link with the .config files used: https://people.igalia.com/gpiccoli/panic_notifiers_configs/
(tried my best to build all the affected code).

Finally, a bit about my CCing strategy: I've included everybody present in the
original thread [0] plus some maintainers and other interested parties as CC
in the full series. But the patches have individual CC lists, for people that
are definitely related to them but might not care much for the whole series;
nevertheless, _everybody_ mentioned at least once in some patch is CCed in this
cover-letter. Hopefully I didn't forget to include anybody - all the mailing
lists were CCed in the whole series. Apologies in advance if (a) you received
emails you didn't want to or, (b) I forgot to include you but it was something
considered interesting by you.

Thanks in advance for reviews / comments / suggestions!
Cheers,

Guilherme

[0] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp at alley/

Guilherme G. Piccoli (30):
  x86/crash,reboot: Avoid re-disabling VMX in all CPUs on crash/restart
  ARM: kexec: Disable IRQs/FIQs also on crash CPUs shutdown path
  notifier: Add panic notifiers info and purge trailing whitespaces
  firmware: google: Convert regular spinlock into trylock on panic path
  misc/pvpanic: Convert regular spinlock into trylock on panic path
  soc: bcm: brcmstb: Document panic notifier action and remove useless header
  mips: ip22: Reword PANICED to PANICKED and remove useless header
  powerpc/setup: Refactor/untangle panic notifiers
  coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier
  alpha: Clean-up the panic notifier code
  um: Improve panic notifiers consistency and ordering
  parisc: Replace regular spinlock with spin_trylock on panic path
  s390/consoles: Improve panic notifiers reliability
  panic: Properly identify the panic event to the notifiers' callbacks
  bus: brcmstb_gisb: Clean-up panic/die notifiers
  drivers/hv/vmbus, video/hyperv_fb: Untangle and refactor Hyper-V panic notifiers
  tracing: Improve panic/die notifiers
  notifier: Show function names on notifier routines if DEBUG_NOTIFIERS is set
  panic: Add the panic hypervisor notifier list
  panic: Add the panic informational notifier list
  panic: Introduce the panic pre-reboot notifier list
  panic: Introduce the panic post-reboot notifier list
  printk: kmsg_dump: Introduce helper to inform number of dumpers
  panic: Refactor the panic path
  panic, printk: Add console flush parameter and convert panic_print to a notifier
  Drivers: hv: Do not force all panic notifiers to execute before kdump
  powerpc: Do not force all panic notifiers to execute before kdump
  panic: Unexport crash_kexec_post_notifiers
  powerpc: ps3, pseries: Avoid duplicate call to kmsg_dump() on panic
  um: Avoid duplicate call to kmsg_dump()

 .../admin-guide/kernel-parameters.txt         |  54 ++-
 Documentation/admin-guide/sysctl/kernel.rst   |   5 +-
 arch/alpha/kernel/setup.c                     |  40 +--
 arch/arm/kernel/machine_kexec.c               |   3 +
 arch/arm64/kernel/setup.c                     |   2 +-
 arch/mips/kernel/relocate.c                   |   2 +-
 arch/mips/sgi-ip22/ip22-reset.c               |  13 +-
 arch/mips/sgi-ip32/ip32-reset.c               |   3 +-
 arch/parisc/include/asm/pdc.h                 |   1 +
 arch/parisc/kernel/firmware.c                 |  27 +-
 arch/parisc/kernel/pdc_chassis.c              |   3 +-
 arch/powerpc/include/asm/bug.h                |   2 +-
 arch/powerpc/kernel/fadump.c                  |   8 -
 arch/powerpc/kernel/setup-common.c            |  76 ++--
 arch/powerpc/kernel/traps.c                   |   6 +-
 arch/powerpc/platforms/powernv/opal.c         |   2 +-
 arch/powerpc/platforms/ps3/setup.c            |   2 +-
 arch/powerpc/platforms/pseries/setup.c        |   2 +-
 arch/s390/kernel/ipl.c                        |   4 +-
 arch/s390/kernel/setup.c                      |  19 +-
 arch/sparc/kernel/setup_32.c                  |  27 +-
 arch/sparc/kernel/setup_64.c                  |  29 +-
 arch/sparc/kernel/sstate.c                    |   3 +-
 arch/um/drivers/mconsole_kern.c               |  10 +-
 arch/um/kernel/um_arch.c                      |  11 +-
 arch/x86/include/asm/cpu.h                    |   1 +
 arch/x86/kernel/crash.c                       |   8 +-
 arch/x86/kernel/reboot.c                      |  14 +-
 arch/x86/kernel/setup.c                       |   2 +-
 arch/x86/xen/enlighten.c                      |   2 +-
 arch/xtensa/platforms/iss/setup.c             |   4 +-
 drivers/bus/brcmstb_gisb.c                    |  28 +-
 drivers/char/ipmi/ipmi_msghandler.c           |  12 +-
 drivers/edac/altera_edac.c                    |   3 +-
 drivers/firmware/google/gsmi.c                |  10 +-
 drivers/hv/hv_common.c                        |  12 -
 drivers/hv/vmbus_drv.c                        | 113 +++---
 .../hwtracing/coresight/coresight-cpu-debug.c |  11 +-
 drivers/leds/trigger/ledtrig-activity.c       |   4 +-
 drivers/leds/trigger/ledtrig-heartbeat.c      |   4 +-
 drivers/leds/trigger/ledtrig-panic.c          |   3 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   6 +-
 drivers/misc/ibmasm/heartbeat.c               |  16 +-
 drivers/misc/pvpanic/pvpanic.c                |  14 +-
 drivers/net/ipa/ipa_smp2p.c                   |   5 +-
 drivers/parisc/power.c                        |  21 +-
 drivers/power/reset/ltc2952-poweroff.c        |   4 +-
 drivers/remoteproc/remoteproc_core.c          |   6 +-
 drivers/s390/char/con3215.c                   |  38 +-
 drivers/s390/char/con3270.c                   |  36 +-
 drivers/s390/char/raw3270.c                   |  18 +
 drivers/s390/char/raw3270.h                   |   1 +
 drivers/s390/char/sclp_con.c                  |  30 +-
 drivers/s390/char/sclp_vt220.c                |  44 +--
 drivers/s390/char/zcore.c                     |   5 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c           |  18 +-
 drivers/soc/tegra/ari-tegra186.c              |   3 +-
 drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
 drivers/video/fbdev/hyperv_fb.c               |  12 +-
 include/linux/console.h                       |   2 +
 include/linux/kmsg_dump.h                     |   7 +
 include/linux/notifier.h                      |   8 +-
 include/linux/panic.h                         |   3 -
 include/linux/panic_notifier.h                |  12 +-
 include/linux/printk.h                        |   1 +
 kernel/hung_task.c                            |   3 +-
 kernel/kexec_core.c                           |   8 +-
 kernel/notifier.c                             |  48 ++-
 kernel/panic.c                                | 335 +++++++++++-------
 kernel/printk/printk.c                        |  76 ++++
 kernel/rcu/tree.c                             |   1 -
 kernel/rcu/tree_stall.h                       |   3 +-
 kernel/trace/trace.c                          |  59 +--
 .../selftests/pstore/pstore_crash_test        |   5 +-
 74 files changed, 953 insertions(+), 486 deletions(-)

-- 
2.36.0


