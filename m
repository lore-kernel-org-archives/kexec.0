Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KdvAw-0006d9-Hh
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 23:02:10 +0000
Message-ID: <48C9A2F8.3060308@sgi.com>
Date: Thu, 11 Sep 2008 16:00:08 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: [PATCH]IA64: assign a distinguishable label to uncached memory in
	/proc/iomem
Content-Type: multipart/mixed; boundary="------------020302050802090908040703"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-ia64@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, kexec@lists.infradead.org

This is a multi-part message in MIME format.
--------------020302050802090908040703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently a memory segment in memory map with attribute of EFI_MEMORY_UC
is denoted as "System RAM" in /proc/iomem, while memory of attribute
(EFI_MEMORY_WB|EFI_MEMORY_UC) is also labeled the same.

The kexec utility then includes uncached memory as part of vmcore. The
kdump kernel MCA'ed when it tries to save the vmcore to a disk. A normal
"cached" access may cause MCAs.

This patch would label memory with attribute of EFI_MEMORY_UC only as
"Uncached RAM" so that kexec would know not to include it in the vmcore.
I will submit a separate kexec-tools patch to the kexec list.

Signed-off-by: Jay Lan <jlan@sgi.com>



--------------020302050802090908040703
Content-Type: text/plain;
 name="UC-mem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="UC-mem"

---
 arch/ia64/kernel/efi.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux/arch/ia64/kernel/efi.c
===================================================================
--- linux.orig/arch/ia64/kernel/efi.c
+++ linux/arch/ia64/kernel/efi.c
@@ -1232,9 +1232,10 @@ efi_initialize_iomem_resources(struct re
 				if (md->attribute & EFI_MEMORY_WP) {
 					name = "System ROM";
 					flags |= IORESOURCE_READONLY;
-				} else {
-					name = "System RAM";
-				}
+				} else if (md->attribute == EFI_MEMORY_UC)
+						name = "Uncached RAM";
+					else
+						name = "System RAM";
 				break;
 
 			case EFI_ACPI_MEMORY_NVS:


--------------020302050802090908040703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------020302050802090908040703--

