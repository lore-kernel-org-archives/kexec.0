Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=x200.localdomain)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nxs9v-0003r9-8A
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 01:28:24 +0000
Message-Id: <20100403012817.408728532@sous-sol.org>
Date: Fri, 02 Apr 2010 18:27:53 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 2/4] x86/amd-iommu: warn when issuing command to uninitialized
	cmd buffer
References: <20100403012751.834020949@sous-sol.org>
Content-Disposition: inline; filename=amd-warn-on-early-cmd-buffer.patch
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
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com

To catch future potential issues we can add a warning whenever we issue
a command before the command buffer is fully initialized.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Or not...this is just if you think it's useful ;-)

 arch/x86/include/asm/amd_iommu_types.h |    1 +
 arch/x86/kernel/amd_iommu.c            |    1 +
 arch/x86/kernel/amd_iommu_init.c       |    5 +++--
 3 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/amd_iommu_types.h
+++ b/arch/x86/include/asm/amd_iommu_types.h
@@ -140,6 +140,7 @@
 
 /* constants to configure the command buffer */
 #define CMD_BUFFER_SIZE    8192
+#define CMD_BUFFER_UNINITIALIZED 1
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
--- a/arch/x86/kernel/amd_iommu.c
+++ b/arch/x86/kernel/amd_iommu.c
@@ -392,6 +392,7 @@ static int __iommu_queue_command(struct 
 	u32 tail, head;
 	u8 *target;
 
+	WARN_ON(iommu->cmd_buf_size & CMD_BUFFER_UNINITIALIZED);
 	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
 	target = iommu->cmd_buf + tail;
 	memcpy_toio(target, cmd, sizeof(*cmd));
--- a/arch/x86/kernel/amd_iommu_init.c
+++ b/arch/x86/kernel/amd_iommu_init.c
@@ -436,7 +436,7 @@ static u8 * __init alloc_command_buffer(
 	if (cmd_buf == NULL)
 		return NULL;
 
-	iommu->cmd_buf_size = CMD_BUFFER_SIZE;
+	iommu->cmd_buf_size = CMD_BUFFER_SIZE | CMD_BUFFER_UNINITIALIZED;
 
 	return cmd_buf;
 }
@@ -472,12 +472,13 @@ static void iommu_enable_command_buffer(
 		    &entry, sizeof(entry));
 
 	amd_iommu_reset_cmd_buffer(iommu);
+	iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
 }
 
 static void __init free_command_buffer(struct amd_iommu *iommu)
 {
 	free_pages((unsigned long)iommu->cmd_buf,
-		   get_order(iommu->cmd_buf_size));
+		   get_order(iommu->cmd_buf_size & ~(CMD_BUFFER_UNINITIALIZED)));
 }
 
 /* allocates the memory where the IOMMU will log its events to */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
