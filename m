Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUHoS-0006NG-HO
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 09:06:39 +0100
Message-Id: <20070909080620.350255316@strauss.suse.de>
References: <20070909080620.009772613@strauss.suse.de>
Date: Sun, 09 Sep 2007 10:06:21 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 1/3] Express relocatability of kernel on x86_64 in
	documentation
Content-Disposition: inline; filename=crashkernel-relocatable
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org

This patch adapts the Documentation/kdump/kdump.txt file to express the fact
that the x86_64 kernel is now also relocatable. This makes i386 and x86_64 now
behave the same, simplifying the documentation.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kdump/kdump.txt |   35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -159,16 +159,17 @@ Dump-capture kernel config options (Arch
    CONFIG_PROC_VMCORE=y
    (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
 
-Dump-capture kernel config options (Arch Dependent, i386)
---------------------------------------------------------
-1) On x86, enable high memory support under "Processor type and
+Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
+--------------------------------------------------------------------
+
+1) On i386, enable high memory support under "Processor type and
    features":
 
    CONFIG_HIGHMEM64G=y
    or
    CONFIG_HIGHMEM4G
 
-2) On x86 and x86_64, disable symmetric multi-processing support
+2) On i386 and x86_64, disable symmetric multi-processing support
    under "Processor type and features":
 
    CONFIG_SMP=n
@@ -203,28 +204,6 @@ Dump-capture kernel config options (Arch
 5) Make and install the kernel and its modules. DO NOT add this kernel
    to the boot loader configuration files.
 
-Dump-capture kernel config options (Arch Dependent, x86_64)
-----------------------------------------------------------
-1) On x86 and x86_64, disable symmetric multi-processing support
-   under "Processor type and features":
-
-   CONFIG_SMP=n
-
-   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
-   when loading the dump-capture kernel, see section "Load the Dump-capture
-   Kernel".)
-
-2) Use a suitable value for "Physical address where the kernel is
-   loaded" (under "Processor type and features"). This only appears when
-   "kernel crash dumps" is enabled. By default this value is 0x1000000
-   (16MB). It should be the same as X in the "crashkernel=Y@X" boot
-   parameter.
-
-   For x86_64, normally "CONFIG_PHYSICAL_START=0x1000000".
-
-3) Make and install the kernel and its modules. DO NOT add this kernel
-   to the boot loader configuration files.
-
 Dump-capture kernel config options (Arch Dependent, ppc64)
 ----------------------------------------------------------
 
@@ -282,11 +261,9 @@ Based on the architecture and type of im
 can choose to load the uncompressed vmlinux or compressed bzImage/vmlinuz
 of dump-capture kernel. Following is the summary.
 
-For i386:
+For i386 and x86_64:
 	- Use vmlinux if kernel is not relocatable.
 	- Use bzImage/vmlinuz if kernel is relocatable.
-For x86_64:
-	- Use vmlinux
 For ppc64:
 	- Use vmlinux
 For ia64:

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
