Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YlYRc-0006Wk-OX
 for kexec@lists.infradead.org; Fri, 24 Apr 2015 07:54:42 +0000
Received: by pacwv17 with SMTP id wv17so19698195pac.0
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2015 00:54:19 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v2 4/5] arm64: add kdump support
Date: Fri, 24 Apr 2015 16:53:07 +0900
Message-Id: <1429861989-8417-5-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org

Please read the following commits for arm64-specific constraints:
    arm64: kdump: reserve memory for crash dump kernel
    arm64: kdump: do not go into EL2 before starting a crash dump kernel

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/kdump/kdump.txt |   31 ++++++++++++++++++++++++++++++-
 arch/arm64/Kconfig            |   12 ++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index bc4bd5a..f9cf6f5 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,29 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+1) Disable symmetric multi-processing support under "Processor type and
+   features":
+
+   CONFIG_SMP=n
+
+   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
+   when loading the dump-capture kernel, see section "Load the Dump-capture
+   Kernel".)
+
+2) Under uefi, the maximum memory size on the dump-capture kernel must be
+   limited by specifying:
+
+   mem=X[MG]
+
+   where X should be less than or equal to the size in "crashkernel="
+   boot parameter. Kexec-tools will automatically add this.
+
+3) Currently, kvm will not be initialized on the dump-capture kernel even
+   if it is configured.
+
 Extended crashkernel syntax
 ===========================
 
@@ -312,6 +335,7 @@ Boot into System Kernel
    any space below the alignment point may be overwritten by the dump-capture kernel,
    which means it is possible that the vmcore is not that precise as expected.
 
+   On arm64, use "crashkernel=Y@X".
 
 Load the Dump-capture Kernel
 ============================
@@ -334,6 +358,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -377,6 +403,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 maxcpus=1 mem=X[MG] reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5716edf..8e2f545 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -562,6 +562,18 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec. The crash dump kernel must be compiled to a
+	  memory address not used by the main kernel.
+
+	  For more details see Documentation/kdump/kdump.txt
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
