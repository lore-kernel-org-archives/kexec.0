Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUHoQ-0006NC-K9
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 09:06:37 +0100
Message-Id: <20070909080620.681518633@strauss.suse.de>
References: <20070909080620.009772613@strauss.suse.de>
Date: Sun, 09 Sep 2007 10:06:22 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 2/3] Express new ELF32 mechanisms in documentation
Content-Disposition: inline; filename=crashkernel-elf32
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
Cc: linux-kernel@vger.kernel.org

This patch reflects the
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=commit;h=b9c3648e690ad0dad12389659673206213a09760
change in kexec-tools-testing also now in the kernel documentation.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kdump/kdump.txt |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -301,11 +301,13 @@ For ppc64:
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-  systems with more than 4GB memory. The --elf32-core-headers option can
-  be used to force the generation of ELF32 headers. This is necessary
-  because GDB currently cannot open vmcore files with ELF64 headers on
-  32-bit systems. ELF32 headers can be used on non-PAE systems (that is,
-  less than 4GB of memory).
+  systems with more than 4GB memory. On i386, kexec automatically checks if
+  the physical RAM size exceeds the 4 GB limit and if not, uses ELF32.
+  So, on non-PAE systems, ELF32 is always used.
+
+  The --elf32-core-headers option can be used to force the generation of ELF32
+  headers. This is necessary because GDB currently cannot open vmcore files
+  with ELF64 headers on 32-bit systems.
 
 * The "irqpoll" boot parameter reduces driver initialization failures
   due to shared interrupts in the dump-capture kernel.

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
