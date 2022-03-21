From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Mar 2022 13:34:19 +0530
Subject: [RFC v3 PATCH 2/5] powerpc/crash hp: introduce a new config option
 CRASH_HOTPLUG
In-Reply-To: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
Message-ID: <20220321080422.56255-3-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The option CRASH_HOTPLUG enables, in kernel update to kexec segments on
hotplug events.

All the updates needed on the capture kernel load path in the kernel for
both kexec_load and kexec_file_load system will be kept under this config.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..b816339ef8c7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -623,6 +623,17 @@ config FA_DUMP
 	  If unsure, say "y". Only special kernels like petitboot may
 	  need to say "N" here.
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash kexec segments"
+	depends on CRASH_DUMP && (HOTPLUG_CPU) && KEXEC_FILE
+	help
+	  An efficient way to keep the capture kernel up-to-date with CPU
+	  hotplug events. On hotplug event (CPU/memory) the kexec segments
+	  of capture kernel becomes stale and need to be updated with latest
+	  CPU and memory regions. In this method the kernel performs minimal
+	  update to only relevant kexec segments on CPU hotplug event, instead
+	  of triggering full capture reload from userspace using udev rule.
+
 config PRESERVE_FA_DUMP
 	bool "Preserve Firmware-assisted dump"
 	depends on PPC64 && PPC_POWERNV && !FA_DUMP
-- 
2.35.1


