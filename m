From: Li Zhengyu <lizhengyu3@huawei.com>
Date: Wed, 1 Jun 2022 15:02:04 +0800
Subject: [PATCH] RISC-V: kexec: Fix build error without CONFIG_KEXEC
Message-ID: <20220601070204.26882-1-lizhengyu3@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

When CONFIG_KEXEC_FILE=y but CONFIG_KEXEC is not set:

kernel/kexec_core.o: In function `kimage_free':
kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
kernel/kexec_core.o: In function `.L231':
kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
kernel/kexec_core.o: In function `.L312':
kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
kernel/kexec_file.o: In function `.L0 ':
kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
kernel/kexec_file.o: In function `.L177':
kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'
Makefile:1160: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

These symbols should depend on CONFIG_KEXEC_CORE rather than CONFIG_KEXEC
when kexec_file has been implemented on RISC-V, like the other archs have
done.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 arch/riscv/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c71d6591d539..33bb60a354cd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
+obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
 obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
-- 
2.17.1


