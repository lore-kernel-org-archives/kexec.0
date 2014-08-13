Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHZmH-0006tA-FS
 for kexec@lists.infradead.org; Wed, 13 Aug 2014 14:43:50 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/2] kexec: Remove CONFIG_KEXEC dependency on crypto
Date: Wed, 13 Aug 2014 10:43:00 -0400
Message-Id: <1407940980-7100-3-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1407940980-7100-1-git-send-email-vgoyal@redhat.com>
References: <1407940980-7100-1-git-send-email-vgoyal@redhat.com>
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
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, ebiederm@xmission.com, sruffell@digium.com, hpa@zytor.com

New system call depends on crypto. As it did not have a separate config
option, CONFIG_KEXEC was modified to select CRYPTO and CRYPTO_SHA256.

But now previous patch introduced a new config option for new syscall.
So CONFIG_KEXEC does not require crypto. Remove that dependency.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 arch/arm/Kconfig     | 2 --
 arch/ia64/Kconfig    | 2 --
 arch/m68k/Kconfig    | 2 --
 arch/mips/Kconfig    | 2 --
 arch/powerpc/Kconfig | 2 --
 arch/s390/Kconfig    | 2 --
 arch/sh/Kconfig      | 2 --
 arch/tile/Kconfig    | 2 --
 8 files changed, 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c49a775..32cbbd5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1983,8 +1983,6 @@ config XIP_PHYS_ADDR
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 64aefb7..c84c88b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -549,8 +549,6 @@ source "drivers/sn/Kconfig"
 config KEXEC
 	bool "kexec system call"
 	depends on !IA64_HP_SIM && (!SMP || HOTPLUG_CPU)
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 3ff8c9a..87b7c75 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -91,8 +91,6 @@ config MMU_SUN3
 config KEXEC
 	bool "kexec system call"
 	depends on M68KCLASSIC
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index df51e78..900c7e5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2396,8 +2396,6 @@ source "kernel/Kconfig.preempt"
 
 config KEXEC
 	bool "Kexec system call"
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a577609f..4bc7b62 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -399,8 +399,6 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 config KEXEC
 	bool "kexec system call"
 	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ab39ceb8..05c78bb 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -48,8 +48,6 @@ config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 
 config KEXEC
 	def_bool y
-	select CRYPTO
-	select CRYPTO_SHA256
 
 config AUDIT_ARCH
 	def_bool y
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 453fa5c..aa2df3e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -595,8 +595,6 @@ source kernel/Kconfig.hz
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on SUPERH32 && MMU
-	select CRYPTO
-	select CRYPTO_SHA256
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index a3ffe2d..7fcd492 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -191,8 +191,6 @@ source "kernel/Kconfig.hz"
 
 config KEXEC
 	bool "kexec system call"
-	select CRYPTO
-	select CRYPTO_SHA256
 	---help---
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
