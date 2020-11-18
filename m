Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86 and ARM
Date: Wed, 18 Nov 2020 15:24:28 -0800
Message-Id: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Michael Walle <michael@walle.cc>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, john.p.donnelly@oracle.com, Arnd Bergmann <arnd@arndb.de>, saeed.mirzamohammadi@oracle.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vinod Koul <vkoul@kernel.org>, =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

This adds crashkernel=auto feature to configure reserved memory for
vmcore creation to both x86 and ARM platforms based on the total memory
size.

Cc: stable@vger.kernel.org
Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  5 +++++
 arch/arm64/Kconfig                        | 26 ++++++++++++++++++++++-
 arch/arm64/configs/defconfig              |  1 +
 arch/x86/Kconfig                          | 26 ++++++++++++++++++++++-
 arch/x86/configs/x86_64_defconfig         |  1 +
 kernel/crash_core.c                       | 20 +++++++++++++++--
 6 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..f95a2af64f59 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -285,7 +285,12 @@ This would mean:
     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
     3) if the RAM size is larger than 2G, then reserve 128M
 
+Or you can use crashkernel=auto if you have enough memory. The threshold
+is 1G on x86_64 and arm64. If your system memory is less than the threshold,
+crashkernel=auto will not reserve memory. The size changes according to
+the system memory size like below:
 
+    x86_64/arm64: 1G-64G:128M,64G-1T:256M,1T-:512M
 
 Boot into System Kernel
 =======================
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..d359dcffa80e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1124,7 +1124,7 @@ comment "Support for PE file signature verification disabled"
 	depends on KEXEC_SIG
 	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
 
-config CRASH_DUMP
+menuconfig CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
 	  Generate crash dump after being started by kexec. This should
@@ -1135,6 +1135,30 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+if CRASH_DUMP
+
+config CRASH_AUTO_STR
+        string "Memory reserved for crash kernel"
+	depends on CRASH_DUMP
+        default "1G-64G:128M,64G-1T:256M,1T-:512M"
+	help
+	  This configures the reserved memory dependent
+	  on the value of System RAM. The syntax is:
+	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+	              range=start-[end]
+
+	  For example:
+	      crashkernel=512M-2G:64M,2G-:128M
+
+	  This would mean:
+
+	      1) if the RAM is smaller than 512M, then don't reserve anything
+	         (this is the "rescue" case)
+	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
+	      3) if the RAM size is larger than 2G, then reserve 128M
+
+endif # CRASH_DUMP
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..899ef3b6a78f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -69,6 +69,7 @@ CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
+# CONFIG_CRASH_AUTO_STR is not set
 CONFIG_XEN=y
 CONFIG_COMPAT=y
 CONFIG_RANDOMIZE_BASE=y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..bacd17312bb1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2035,7 +2035,7 @@ config KEXEC_BZIMAGE_VERIFY_SIG
 	help
 	  Enable bzImage signature verification support.
 
-config CRASH_DUMP
+menuconfig CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on X86_64 || (X86_32 && HIGHMEM)
 	help
@@ -2049,6 +2049,30 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+if CRASH_DUMP
+
+config CRASH_AUTO_STR
+        string "Memory reserved for crash kernel" if X86_64
+	depends on CRASH_DUMP
+        default "1G-64G:128M,64G-1T:256M,1T-:512M"
+	help
+	  This configures the reserved memory dependent
+	  on the value of System RAM. The syntax is:
+	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+	              range=start-[end]
+
+	  For example:
+	      crashkernel=512M-2G:64M,2G-:128M
+
+	  This would mean:
+
+	      1) if the RAM is smaller than 512M, then don't reserve anything
+	         (this is the "rescue" case)
+	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
+	      3) if the RAM size is larger than 2G, then reserve 128M
+
+endif # CRASH_DUMP
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 9936528e1939..7a87fbecf40b 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -33,6 +33,7 @@ CONFIG_EFI_MIXED=y
 CONFIG_HZ_1000=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
+# CONFIG_CRASH_AUTO_STR is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..a44cd9cc12c4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -41,6 +42,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for it's own use.
+	 * so we get less than actual system memory size.
+	 * Workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -85,13 +95,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
@@ -250,6 +260,12 @@ static int __init __parse_crashkernel(char *cmdline,
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+#ifdef CONFIG_CRASH_AUTO_STR
+	if (strncmp(ck_cmdline, "auto", 4) == 0) {
+		ck_cmdline = CONFIG_CRASH_AUTO_STR;
+		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
+	}
+#endif
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
-- 
2.18.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
