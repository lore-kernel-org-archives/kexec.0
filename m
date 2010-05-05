Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 8/8] arm: kdump: add CONFIG_CRASH_DUMP Kconfig option
Date: Wed,  5 May 2010 09:54:20 +0300
Message-Id: <90c1d872fad6280907d39e421d10e43d19fffdfe.1273041358.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

Add CONFIG_CRASH_DUMP configuration option which is used by dump capture
kernels. Dump capture kernel must be loaded into different physical address
than the primary kernel. This means that PHYS_OFFSET must be different and
it also should match the 'crashkernel=size@start' value passed to primary
kernel command line.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..bfc7128 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1467,6 +1467,18 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Build a kernel suitable for use as kdump capture kernel. This should
+	  be set only on dump capture kernels. Note that dump capture kernel
+	  must be loaded into different physical address than the primary kernel
+	  (e.g set PHYS_OFFSET and related mach/Makefile.boot parameters
+	  to match value given in 'crashkernel=size@start').
+
+	  For more details see Documentation/kdump/kdump.txt
+
 endmenu
 
 menu "CPU Power Management"
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
