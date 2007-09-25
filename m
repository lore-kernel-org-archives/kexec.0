Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IaF48-0000mR-IR
	for kexec@lists.infradead.org; Tue, 25 Sep 2007 19:23:29 +0100
Message-Id: <20070925182259.856342893@strauss.suse.de>
References: <20070925182257.900701776@strauss.suse.de>
Date: Tue, 25 Sep 2007 20:23:04 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 7/7] Add documentation for extended crashkernel syntax
Content-Disposition: inline; filename=crashkernel-documentation
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
To: kexec@lists.infradead.org, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This adds the documentation for the extended crashkernel syntax into
Documentation/kdump/kdump.txt.

Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kdump/kdump.txt       |   26 ++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |    7 +++++++
 2 files changed, 33 insertions(+)

--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -231,6 +231,32 @@ Dump-capture kernel config options (Arch
   any space below the alignment point will be wasted.
 
 
+Extended crashkernel syntax
+===========================
+
+While the "crashkernel=size[@offset]" syntax is sufficient for most
+configurations, sometimes it's handy to have the reserved memory dependent
+on the value of System RAM -- that's mostly for distributors that pre-setup
+the kernel command line to avoid a unbootable system after some memory has
+been removed from the machine.
+
+The syntax is:
+
+    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+    range=start-[end]
+
+For example:
+
+    crashkernel=512M-2G:64M,2G-:128M
+
+This would mean:
+
+    1) if the RAM is smaller than 512M, then don't reserve anything
+       (this is the "rescue" case)
+    2) if the RAM size is between 512M and 2G, then reserve 64M
+    3) if the RAM size is larger than 2G, then reserve 128M
+
+
 Boot into System Kernel
 =======================
 
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -495,6 +495,13 @@ and is between 256 and 4096 characters. 
 			[KNL] Reserve a chunk of physical memory to
 			hold a kernel to switch to with kexec on panic.
 
+	crashkernel=range1:size1[,range2:size2,...][@offset]
+			[KNL] Same as above, but depends on the memory
+			in the running system. The syntax of range is
+			start-[end] where start and end are both
+			a memory unit (amount[KMG]). See also
+			Documentation/kdump/kdump.txt for a example.
+
 	cs4232=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>
 

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
