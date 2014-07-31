Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XCjdh-0007Ku-Qu
 for kexec@lists.infradead.org; Thu, 31 Jul 2014 06:14:59 +0000
From: HuKeping <hukeping@huawei.com>
Subject: [PATCH] ARM: Add arm description to Documentation/kdump/kdump.txt
Date: Thu, 31 Jul 2014 14:03:31 +0800
Message-ID: <1406786611-57238-1-git-send-email-hukeping@huawei.com>
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
To: vgoyal@redhat.com, hbabu@us.ibm.com
Cc: kexec@lists.infradead.org

Add arm specific parts to kdump kernel documentation.

----------------------------------------
Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 Documentation/kdump/kdump.txt | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88d5a86..5fc98d6 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-and s390x architectures.
+s390x and arm architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -112,7 +112,7 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architectures which support a relocatable kernel. As
-   of today, i386, x86_64, ppc64 and ia64 architectures support relocatable
+   of today, i386, x86_64, ppc64, ia64 and arm architectures support relocatable
    kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
@@ -296,6 +296,12 @@ Boot into System Kernel
    on the memory consumption of the kdump system. In general this is not
    dependent on the memory size of the production system.
 
+   On arm, use "crashkernel=Y@X". Note that the start address of the kernel
+   will be aligned to 128MiB (0x08000000), so if the start address is not then
+   any space blow the alignment point may be overwrited by the dump-caputre kernel,
+   which means it is possible that the vmcore is not that precise as expected.
+
+
 Load the Dump-capture Kernel
 ============================
 
@@ -315,7 +321,8 @@ For ia64:
 	- Use vmlinux or vmlinuz.gz
 For s390x:
 	- Use image or bzImage
-
+For arm:
+	- Use zImage
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -331,6 +338,15 @@ to load dump-capture kernel.
    --initrd=<initrd-for-dump-capture-kernel> \
    --append="root=<root-dev> <arch-specific-options>"
 
+If you are using a compressed zImage, then use following command
+to load dump-capture kernel.
+
+   kexec --type zImage -p <dump-capture-kernel-bzImage> \
+   --initrd=<initrd-for-dump-capture-kernel> \
+   --dtb=<dtb-for-dump-capture-kernel> \
+   --append="root=<root-dev> <arch-specific-options>"
+
+
 Please note, that --args-linux does not need to be specified for ia64.
 It is planned to make this a no-op on that architecture, but for now
 it should be omitted
@@ -347,6 +363,9 @@ For ppc64:
 For s390x:
 	"1 maxcpus=1 cgroup_disable=memory"
 
+For arm:
+	"1 maxcpus=1 reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-- 
1.8.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
