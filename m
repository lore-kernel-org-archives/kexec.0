Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7SlM-0004jp-GI
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 00:44:49 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: [PATCH v2 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
Date: Wed,  3 Feb 2021 16:43:45 -0800
Message-Id: <20210204004347.41918-1-saeed.mirzamohammadi@oracle.com>
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
Cc: john.p.donnelly@oracle.com, Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, saeed.mirzamohammadi@oracle.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Sami Tolvanen <samitolvanen@google.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, YiFei Zhu <yifeifz2@illinois.edu>, Dave Young <dyoung@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Stephen Boyd <sboyd@kernel.org>

This adds crashkernel=auto feature to configure reserved memory for
vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
different kernel distributions and different archs based on their
needs.

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  5 +++++
 arch/Kconfig                              | 24 +++++++++++++++++++++++
 kernel/crash_core.c                       |  7 +++++++
 3 files changed, 36 insertions(+)

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
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..a772eb397d73 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -14,6 +14,30 @@ menu "General architecture-dependent options"
 config CRASH_CORE
 	bool
 
+if CRASH_CORE
+
+config CRASH_AUTO_STR
+	string "Memory reserved for crash kernel"
+	depends on CRASH_CORE
+	default "1G-64G:128M,64G-1T:256M,1T-:512M"
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
+endif # CRASH_CORE
+
 config KEXEC_CORE
 	select CRASH_CORE
 	bool
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..ab0a2b4b1ffa 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
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
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
