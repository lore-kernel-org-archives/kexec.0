Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG7Op-0000tN-Gk
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 19:04:01 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH] makedumpfile/x86_64: Fix calculation of page_offset for
 kernel 4.19
Date: Fri, 26 Oct 2018 19:01:51 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355E7D3@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, Baoquan He <bhe@redhat.com>

Hi Bhupesh, Baoquan,

As for x86_64, I'm going to merge the patch below for fixing the
--mem-usage issue with kernel 4.19, if there is no objection.
I think the same approach will also work on arm64 with regard to
page_offset for the time being..

Thanks,
Kazu

--
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Date: Fri, 26 Oct 2018 14:43:22 -0400
Subject: [PATCH] x86_64: Fix calculation of page_offset for kernel 4.19

* Required for kernel 4.19

Kernel commit 6855dc41b24619c3d1de3dbd27dd0546b0e45272 ("x86: Add
entry trampolines to kcore") added program headers for PTI entry
trampoline pages to /proc/kcore.

This caused the failure of makedumpfile --mem-usage due to wrong
calculation of page_offset.

  # makedumpfile --mem-usage /proc/kcore
  [...]
  set_kcore_vmcoreinfo: Can't get the offset of VMCOREINFO(/proc/kcore). Success

  makedumpfile Failed.

Since program headers for linear maps are located after ones for
kernel text and so on in /proc/vmcore and /proc/kcore, with this
patch, we use the last valid one to set page_offset.

Also, this patch adds a few debug messages for better debugging.

Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
---
 arch/x86_64.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 2b3c0bb..ed2a970 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -95,10 +95,17 @@ get_page_offset_x86_64(void)
 			 ERRMSG("Can't read page_offset_base.\n");
 			 return FALSE;
 		}
+		DEBUG_MSG("page_offset  : %lx (from page_offset_base)\n",
+			info->page_offset);
 		return TRUE;
 	}
 
 	if (get_num_pt_loads()) {
+		/*
+		 * Since program headers for linear maps are located after
+		 * ones for kernel text and so on in /proc/vmcore and
+		 * /proc/kcore, we use the last valid one to set page_offset.
+		 */
 		for (i = 0;
 			get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
 			i++) {
@@ -106,9 +113,13 @@ get_page_offset_x86_64(void)
 					&& virt_start < __START_KERNEL_map
 					&& phys_start != NOT_PADDR) {
 				info->page_offset = virt_start - phys_start;
-				return TRUE;
 			}
 		}
+		if (info->page_offset) {
+			DEBUG_MSG("page_offset  : %lx (from pt_load)\n",
+				info->page_offset);
+			return TRUE;
+		}
 	}
 
 	if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
@@ -119,6 +130,7 @@ get_page_offset_x86_64(void)
 		info->page_offset = __PAGE_OFFSET_2_6_27;
 	}
 
+	DEBUG_MSG("page_offset  : %lx (from constant)\n", info->page_offset);
 	return TRUE;
 }
 
-- 
1.8.3.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
