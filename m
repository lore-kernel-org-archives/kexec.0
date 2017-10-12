Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com
 ([104.47.34.60] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2kdD-0002wx-5q
 for kexec@lists.infradead.org; Thu, 12 Oct 2017 21:03:04 +0000
From: David Daney <david.daney@cavium.com>
Subject: [PATCH 4/4] kexec-tools: mips: Try to include bss in kernel vmcore
 file.
Date: Thu, 12 Oct 2017 14:02:28 -0700
Message-Id: <20171012210228.7353-5-david.daney@cavium.com>
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

The kernel message buffers, as well as a lot of other useful data
reside in the bss section.  Without this vmcore-dmesg cannot work, and
debugging with a core dump is much more difficult.

Try to add the /proc/iomem "Kernel bss" section to vmcore.  If it is
not found, just do what we used to do and use "Kernel data" instead.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e98badf..fc92e64 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -74,7 +74,10 @@ static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
 
 	elf_info->kern_vaddr_start = elf_info->kern_paddr_start |
 					start_offset;
-	if (parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
+	/* If "Kernel bss" exists, the kernel ends there, else fall
+	 *  through and say that it ends at "Kernel data" */
+	if (parse_iomem_single("Kernel bss\n", NULL, &end) == 0 ||
+	    parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
 		elf_info->kern_size = end - elf_info->kern_paddr_start;
 		dbgprintf("kernel_vaddr= 0x%llx paddr %llx\n",
 				elf_info->kern_vaddr_start,
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
