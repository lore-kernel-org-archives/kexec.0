Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xtz-0003eg-84
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:01:29 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 22/32] arm: use generic mem_region sorting
 implementation
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xtE-0003tY-W5@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:00:36 +0100
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

Use the generic mem_region sorting implementation.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 85afd9f..d6db566 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -202,19 +202,6 @@ static void crash_exclude_range(void)
 	}
 }
 
-static int range_cmp(const void *a1, const void *a2)
-{
-	const struct memory_range *r1 = a1;
-	const struct memory_range *r2 = a2;
-
-	if (r1->start > r2->start)
-		return 1;
-	if (r1->start < r2->start)
-		return -1;
-
-	return 0;
-}
-
 /**
  * crash_get_memory_ranges() - read system physical memory
  *
@@ -246,8 +233,7 @@ static int crash_get_memory_ranges(void)
 	/*
 	 * Make sure that the memory regions are sorted.
 	 */
-	qsort(usablemem_rgns.ranges, usablemem_rgns.size,
-	      sizeof(*usablemem_rgns.ranges), range_cmp);
+	mem_regions_sort(&usablemem_rgns);
 
 	return 0;
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
