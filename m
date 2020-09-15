Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIAgz-0007kt-Es
 for kexec@lists.infradead.org; Tue, 15 Sep 2020 13:08:19 +0000
From: Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] MIPS: Loongson64: Add kexec/kdump support
Date: Tue, 15 Sep 2020 21:07:43 +0800
Message-Id: <1600175263-7872-1-git-send-email-hejinyang@loongson.cn>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhc@lemote.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org, Youling Tang <tangyouling@loongson.cn>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

Add loongson_kexec_prepare(), loongson_kexec_shutdown() and
loongson_kexec_crashdown() for passing the parameters of kexec_args.

To start loongson64, CPU0 needs 3 parameters:
fw_arg0: the number of cmd.
fw_arg1: cmd structure which seems strange, the cmd array[index]'s
         value is cmd string's address, index >= 1.
fw_arg2: environment.

Secondary CPUs do not need parameter at once. They query their
mailbox to get PC, SP and GP in a loop before CPU0 brings them up
and passes these parameters via mailbox.

loongson_kexec_prepare(): Alloc new memory to save cmd for kexec.
Combine the kexec append option string as cmd structure, and the cmd
struct will be parsed in fw_init_cmdline() of arch/mips/fw/lib/cmdline.c.
image->control_code_page need pointing to a safe memory page. In order to
maintain compatibility for the old firmware the low 2MB is reserverd
and safe for Loongson. So let it points here.

loongson_kexec_shutdown(): Wake up all present CPUs and let them go
to reboot_code_buffer. Pass the kexec parameters to kexec_args.

loongson_crash_shutdown(): Pass the kdump parameters to kexec_args.

The assembly part provide a way like BIOS doing to keep secondary
CPUs in a querying loop.

This patch referenced [1][2][3].

[1] arch/mips/cavium-octeon/setup.c
[2] https://patchwork.kernel.org/patch/10799217/
[3] https://gitee.com/loongsonlab/qemu/blob/master/hw/mips/loongson3a_rom.h

Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/mips/kernel/relocate_kernel.S | 19 ++++++++
 arch/mips/loongson64/reset.c       | 88 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index ac87089..061cbfb 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -133,6 +133,25 @@ LEAF(kexec_smp_wait)
 #else
 	sync
 #endif
+
+#ifdef CONFIG_CPU_LOONGSON64
+#define MAILBOX_BASE 0x900000003ff01000
+	mfc0  t1, CP0_EBASE
+	andi  t1, MIPS_EBASE_CPUNUM
+	dli   t0, MAILBOX_BASE
+	andi  t3, t1, 0x3
+	sll   t3, 8
+	or    t0, t0, t3	/* insert core id */
+	andi  t2, t1, 0xc
+	dsll  t2, 42
+	or    t0, t0, t2	/* insert node id */
+1:	ld    s1, 0x20(t0)	/* get PC via mailbox0 */
+	beqz  s1, 1b
+	ld    sp, 0x28(t0)	/* get SP via mailbox1 */
+	ld    gp, 0x30(t0)	/* get GP via mailbox2 */
+	ld    a1, 0x38(t0)
+	jr    s1
+#endif
 	j		s1
 	END(kexec_smp_wait)
 #endif
diff --git a/arch/mips/loongson64/reset.c b/arch/mips/loongson64/reset.c
index 3bb8a1e..322c326 100644
--- a/arch/mips/loongson64/reset.c
+++ b/arch/mips/loongson64/reset.c
@@ -47,12 +47,100 @@ static void loongson_halt(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC
+#include <linux/cpu.h>
+#include <linux/kexec.h>
+
+#include <asm/bootinfo.h>
+
+#define CONTROL_CODE_PAGE    0xFFFFFFFF80000000UL
+static int kexec_argc;
+static int kdump_argc;
+static void *kexec_argv;
+static void *kdump_argv;
+
+static int loongson_kexec_prepare(struct kimage *image)
+{
+	int i, offt, argc = 0;
+	int *argv;
+	char *str, *ptr, *bootloader = "kexec";
+
+	argv = kmalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
+	if (!argv)
+		return -ENOMEM;
+
+	for (i = 0; i < image->nr_segments; i++) {
+		if (!strncmp(bootloader, (char *)image->segment[i].buf,
+				strlen(bootloader))) {
+			argv[argc++] = fw_arg1 + COMMAND_LINE_SIZE/2;
+			str = (char *)argv + COMMAND_LINE_SIZE/2;
+			memcpy(str, image->segment[i].buf, COMMAND_LINE_SIZE/2);
+			ptr = strchr(str, ' ');
+			while (ptr) {
+				*ptr = '\0';
+				if (ptr[1] != ' ') {
+					offt = (int)(ptr - str + 1);
+					argv[argc++] = fw_arg1 + COMMAND_LINE_SIZE/2 + offt;
+				}
+				ptr = strchr(ptr + 1, ' ');
+			}
+			break;
+		}
+	}
+
+	/* Kexec/kdump needs a safe page to save reboot_code_buffer. */
+	image->control_code_page = virt_to_page((void *)CONTROL_CODE_PAGE);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kfree(kdump_argv);
+		kdump_argc = argc;
+		kdump_argv = argv;
+	} else {
+		kfree(kexec_argv);
+		kexec_argc = argc;
+		kexec_argv = argv;
+	}
+
+	return 0;
+}
+
+static void loongson_kexec_shutdown(void)
+{
+#ifdef CONFIG_SMP
+	bringup_nonboot_cpus(loongson_sysconf.nr_cpus);
+#endif
+	fw_arg0 = kexec_argc;
+	memcpy((void *)fw_arg1, kexec_argv, COMMAND_LINE_SIZE);
+
+	kexec_args[0] = fw_arg0;
+	kexec_args[1] = fw_arg1;
+	kexec_args[2] = fw_arg2;
+}
+
+static void loongson_crash_shutdown(struct pt_regs *regs)
+{
+	default_machine_crash_shutdown(regs);
+	fw_arg0 = kdump_argc;
+	memcpy((void *)fw_arg1, kdump_argv, COMMAND_LINE_SIZE);
+
+	kexec_args[0] = fw_arg0;
+	kexec_args[1] = fw_arg1;
+	kexec_args[2] = fw_arg2;
+}
+#endif
+
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = loongson_restart;
 	_machine_halt = loongson_halt;
 	pm_power_off = loongson_poweroff;
 
+#ifdef CONFIG_KEXEC
+	_machine_kexec_prepare = loongson_kexec_prepare;
+	_machine_kexec_shutdown = loongson_kexec_shutdown;
+	_machine_crash_shutdown = loongson_crash_shutdown;
+#endif
+
 	return 0;
 }
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
