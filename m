Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y26-0005R7-KE
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:09:48 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 11/32] kexec: add mem_regions sorting
 implementation
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xsJ-0003sU-LJ@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:59:39 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

Add a mem_regions sorting implementation taken from the arm code.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/mem_regions.c | 27 +++++++++++++++++++++++++++
 kexec/mem_regions.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index a4952ff..804984a 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -1,6 +1,33 @@
+#include <stdlib.h>
+
 #include "kexec.h"
 #include "mem_regions.h"
 
+static int mem_range_cmp(const void *a1, const void *a2)
+{
+	const struct memory_range *r1 = a1;
+	const struct memory_range *r2 = a2;
+
+	if (r1->start > r2->start)
+		return 1;
+	if (r1->start < r2->start)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * mem_regions_sort() - sort ranges into ascending address order
+ * @ranges: ranges to sort
+ *
+ * Sort the memory regions into ascending address order.
+ */
+void mem_regions_sort(struct memory_ranges *ranges)
+{
+	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
+	      mem_range_cmp);
+}
+
 /**
  * mem_regions_add() - add a memory region to a set of ranges
  * @ranges: ranges to add the memory region to
diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
index b9cfba1..da7b5e8 100644
--- a/kexec/mem_regions.h
+++ b/kexec/mem_regions.h
@@ -3,6 +3,8 @@
 
 struct memory_ranges;
 
+void mem_regions_sort(struct memory_ranges *ranges);
+
 int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
                     unsigned long long length, int type);
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
