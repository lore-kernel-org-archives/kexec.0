Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WN1ZF-0000OP-3Q
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 14:52:37 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v2] x86, calgary: use 8M TCE table size by default
Date: Mon, 10 Mar 2014 22:52:00 +0800
Message-Id: <1394463120-26999-1-git-send-email-chaowang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Muli Ben-Yehuda <muli@cs.technion.ac.il>, "Jon D. Mason" <jdmason@kudzu.us>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

New kexec-tools wants to pass kdump kernel needed memmap via E820
directly, instead of memmap=exactmap. This makes saved_max_pfn not
be passed down to 2nd kernel. To keep 1st kernel and 2nd kernel using
the same TCE table size, Muli suggest to hard code the size to max (8M).

We can't get rid of saved_max_pfn this time, for backward compatibility
with old first kernel and new second kernel. However new first kernel
and old second kernel can not work unfortunately.

v2->v1:
- retain saved_max_pfn so new 2nd kernel can work with old 1st kernel
  from Vivek

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 arch/x86/kernel/pci-calgary_64.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 299d493..0497f71 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -1207,23 +1207,31 @@ error:
 	return ret;
 }
 
-static inline int __init determine_tce_table_size(u64 ram)
+static inline int __init determine_tce_table_size(void)
 {
 	int ret;
 
 	if (specified_table_size != TCE_TABLE_SIZE_UNSPECIFIED)
 		return specified_table_size;
 
-	/*
-	 * Table sizes are from 0 to 7 (TCE_TABLE_SIZE_64K to
-	 * TCE_TABLE_SIZE_8M). Table size 0 has 8K entries and each
-	 * larger table size has twice as many entries, so shift the
-	 * max ram address by 13 to divide by 8K and then look at the
-	 * order of the result to choose between 0-7.
-	 */
-	ret = get_order(ram >> 13);
-	if (ret > TCE_TABLE_SIZE_8M)
+	if (is_kdump_kernel() && saved_max_pfn) {
+		/*
+		 * Table sizes are from 0 to 7 (TCE_TABLE_SIZE_64K to
+		 * TCE_TABLE_SIZE_8M). Table size 0 has 8K entries and each
+		 * larger table size has twice as many entries, so shift the
+		 * max ram address by 13 to divide by 8K and then look at the
+		 * order of the result to choose between 0-7.
+		 */
+		ret = get_order((saved_max_pfn * PAGE_SIZE) >> 13);
+		if (ret > TCE_TABLE_SIZE_8M)
+			ret = TCE_TABLE_SIZE_8M;
+	} else {
+		/*
+		 * Use 8M by default (suggested by Muli) if it's not
+		 * kdump kernel and saved_max_pfn isn't set.
+		 */
 		ret = TCE_TABLE_SIZE_8M;
+	}
 
 	return ret;
 }
@@ -1418,8 +1426,7 @@ int __init detect_calgary(void)
 		return -ENOMEM;
 	}
 
-	specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
-					saved_max_pfn : max_pfn) * PAGE_SIZE);
+	specified_table_size = determine_tce_table_size();
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
 		struct calgary_bus_info *info = &bus_info[bus];
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
