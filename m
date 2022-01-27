From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 27 Jan 2022 17:31:51 +0800
Subject: [RFC PATCH] kdump: Add support for crashkernel=auto
Message-ID: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Set the reserved memory automatically for the crash kernel based on
architecture.

Most code of this patch come from:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/admin-guide/kdump/kdump.rst       | 13 +++++++++++++
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/crash_core.c                             | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3d..8f8a9cc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -335,6 +335,19 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=auto
+
+   You can use crashkernel=auto if you have enough memory. The threshold
+   is 1G on x86_64 and s390x, 2G on arm64, ppc64 and ppc64le. If your system
+   memory is less than the threshold crashkernel=auto will not reserve memory.
+
+   The automatically reserved memory size varies based on architecture.
+   The size changes according to system memory size like below:
+       x86_64: 1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M
+       s390x:  1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M
+       arm64:  2G-:448M
+       ppc64:  2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f0..14f052d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -783,6 +783,11 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	crashkernel=auto
+			[KNL] Set the reserved memory automatically for the crash kernel
+			based on architecture.
+			See Documentation/admin-guide/kdump/kdump.rst for further details.
+
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL] Using kexec, Linux can switch to a 'crash kernel'
 			upon panic. This parameter reserves the physical
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6d..32c51e2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+
+	if (strncmp(ck_cmdline, "auto", 4) == 0) {
+#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
+		ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
+#elif defined(CONFIG_ARM64)
+		ck_cmdline = "2G-:448M";
+#elif defined(CONFIG_PPC64)
+		char *fadump_cmdline;
+
+		fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
+		fadump_cmdline = fadump_cmdline ?
+				fadump_cmdline + strlen("fadump=") : NULL;
+		if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
+			ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
+		else
+			ck_cmdline = "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
+#endif
+		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
+	}
+
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
-- 
2.1.0


