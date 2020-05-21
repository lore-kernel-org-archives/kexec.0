Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbfQN-0008PL-Lr
 for kexec@lists.infradead.org; Thu, 21 May 2020 07:15:29 +0000
From: "saito.kazuya@fujitsu.com" <saito.kazuya@fujitsu.com>
Subject: [PATCH] sadump: Fix failure of reading __per_cpu_load memory
Date: Thu, 21 May 2020 07:15:19 +0000
Message-ID: <TYAPR01MB41279E6F5CDD8350F13BA38F84B70@TYAPR01MB4127.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
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
To: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

Creating vmcore from sadump by makedumpfile fails with the following
error messages since kernel-4.19 with PTI (Page Table Isolation)
enabled:

  __vtop4_x86_64: Can't get a valid pte.
  readmem: Can't convert a virtual address(ffffffffb2986000) to physical address.
  readmem: type_addr: 0, addr:ffffffffb2986000, size:8
  per_cpu_init: Can't read __per_cpu_load memory.

This is caused by the following patch:
https://github.com/torvalds/linux/commit/c40a56a7818cfe735fc93a69e1875f8bba834483

The above patch clears _PAGE_PRESENT bit of __per_cpu_load memory, so
__vtop4_x86_64 fails to convert the virtual address of the
__per_cpu_load.

To fix this issue, this patch changes sanity check of per_cpu_ptr()
to use address of the __per_cpu_load instead of data of the memory.

Signed-off-by: Kazuya Saito <saito.kazuya@fujitsu.com>
Signed-off-by: Kiyotaka Nakamura <kiyo@fujitsu.com>
---
 sadump_info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index 46867ce..72a077b 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1732,11 +1732,11 @@ per_cpu_init(void)
 		return FALSE;
 	}
 
-	if (!readmem(VADDR, SYMBOL(__per_cpu_load), &si->__per_cpu_load,
-		     sizeof(unsigned long))) {
-		ERRMSG("Can't read __per_cpu_load memory.\n");
+	if (SYMBOL(__per_cpu_load) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't find __per_cpu_load symbol.\n");
 		return FALSE;
 	}
+	si->__per_cpu_load = SYMBOL(__per_cpu_load);
 
 	DEBUG_MSG("sadump: __per_cpu_load: %#lx\n", si->__per_cpu_load);
 	DEBUG_MSG("sadump: __per_cpu_offset: LENGTH: %ld\n",
-- 
2.12.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
