Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IZ9fz-0001G7-6z
	for kexec@lists.infradead.org; Sat, 22 Sep 2007 14:26:03 -0400
Date: Sat, 22 Sep 2007 20:25:56 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Add extended crashkernel syntax to kernel-parameters.txt
Message-ID: <20070922182556.GA3353@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
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
To: akpm@linux-foundation.org, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

This adds the documentation for the extended crashkernel syntax into
Documentation/kernel-parameters.txt.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kernel-parameters.txt |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -498,6 +498,13 @@ and is between 256 and 4096 characters. 
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
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
