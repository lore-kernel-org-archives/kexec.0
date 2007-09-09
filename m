Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from agminet01.oracle.com ([141.146.126.228])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IURzo-0005qd-L1
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 14:59:05 -0400
Date: Sun, 9 Sep 2007 11:55:07 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [patch 1/3] Express relocatability of kernel on x86_64 in
	documentation
Message-Id: <20070909115507.3e85a7a1.randy.dunlap@oracle.com>
In-Reply-To: <20070909080620.350255316@strauss.suse.de>
References: <20070909080620.009772613@strauss.suse.de>
	<20070909080620.350255316@strauss.suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, 09 Sep 2007 10:06:21 +0200 Bernhard Walle wrote:

> This patch adapts the Documentation/kdump/kdump.txt file to express the fact
> that the x86_64 kernel is now also relocatable. This makes i386 and x86_64 now
> behave the same, simplifying the documentation.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Hi,
Can we also please reconcile the CRASH_DUMP Kconfig help text?
I.e., it says

  The crash dump kernel must be compiled
  to a memory address not used by the main kernel or BIOS using
  PHYSICAL_START.

but this ignores the use of RELOCATABLE, right?


---
From: Randy Dunlap <randy.dunlap@oracle.com>

Update help text for CONFIG_CRASH_DUMP.
Fix typos in CONFIG_RELOCATABLE.
Use tab + 2 spaces for indentation on all lines.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/Kconfig   |   17 +++++++++--------
 arch/x86_64/Kconfig |   21 +++++++++++----------
 2 files changed, 20 insertions(+), 18 deletions(-)

--- linux-2.6.23-rc5-git1.orig/arch/i386/Kconfig
+++ linux-2.6.23-rc5-git1/arch/i386/Kconfig
@@ -820,12 +820,13 @@ config CRASH_DUMP
 	depends on HIGHMEM
 	help
 	  Generate crash dump after being started by kexec.
-          This should be normally only set in special crash dump kernels
+	  This should be normally only set in special crash dump kernels
 	  which are loaded in the main kernel with kexec-tools into
 	  a specially reserved region and then later executed after
 	  a crash by kdump/kexec. The crash dump kernel must be compiled
-          to a memory address not used by the main kernel or BIOS using
-          PHYSICAL_START.
+	  to a memory address not used by the main kernel or BIOS using
+	  PHYSICAL_START, or it must be built as a relocatable image
+	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/kdump/kdump.txt
 
 config PHYSICAL_START
@@ -871,17 +872,17 @@ config PHYSICAL_START
 	  Don't change this unless you know what you are doing.
 
 config RELOCATABLE
-	bool "Build a relocatable kernel(EXPERIMENTAL)"
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
 	  This builds a kernel image that retains relocation information
-          so it can be loaded someplace besides the default 1MB.
+	  so it can be loaded someplace besides the default 1MB.
 	  The relocations tend to make the kernel binary about 10% larger,
-          but are discarded at runtime.
+	  but are discarded at runtime.
 
 	  One use is for the kexec on panic case where the recovery kernel
-          must live at a different physical address than the primary
-          kernel.
+	  must live at a different physical address than the primary
+	  kernel.
 
 config PHYSICAL_ALIGN
 	hex "Alignment value to which kernel should be aligned"
--- linux-2.6.23-rc5-git1.orig/arch/x86_64/Kconfig
+++ linux-2.6.23-rc5-git1/arch/x86_64/Kconfig
@@ -575,17 +575,18 @@ config CRASH_DUMP
 	bool "kernel crash dumps (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
-          Generate crash dump after being started by kexec.
-          This should be normally only set in special crash dump kernels
-          which are loaded in the main kernel with kexec-tools into
-          a specially reserved region and then later executed after
-          a crash by kdump/kexec. The crash dump kernel must be compiled
+	  Generate crash dump after being started by kexec.
+	  This should be normally only set in special crash dump kernels
+	  which are loaded in the main kernel with kexec-tools into
+	  a specially reserved region and then later executed after
+	  a crash by kdump/kexec. The crash dump kernel must be compiled
 	  to a memory address not used by the main kernel or BIOS using
-	  PHYSICAL_START.
-          For more details see Documentation/kdump/kdump.txt
+	  PHYSICAL_START, or it must be built as a relocatable image
+	  (CONFIG_RELOCATABLE=y).
+	  For more details see Documentation/kdump/kdump.txt
 
 config RELOCATABLE
-	bool "Build a relocatable kernel(EXPERIMENTAL)"
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
 	  Builds a relocatable kernel. This enables loading and running
@@ -596,8 +597,8 @@ config RELOCATABLE
 	  must live at a different physical address than the primary
 	  kernel.
 
-	  Note: If CONFIG_RELOCATABLE=y, then kernel run from the address
-	  it has been loaded at and compile time physical address
+	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+	  it has been loaded at and the compile time physical address
 	  (CONFIG_PHYSICAL_START) is ignored.
 
 config PHYSICAL_START


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
