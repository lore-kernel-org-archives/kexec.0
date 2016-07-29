Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bT306-0005aC-5v
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 08:18:35 +0000
Received: by mail-pa0-x22b.google.com with SMTP id pp5so29169408pac.3
 for <kexec@lists.infradead.org>; Fri, 29 Jul 2016 01:18:13 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] kexec: (bugfix) mem_regions_sort()
Date: Fri, 29 Jul 2016 17:23:23 +0900
Message-Id: <20160729082323.12253-1-takahiro.akashi@linaro.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, rmk@armlinux.org.uk, kexec@lists.infradead.org

The third argument of qsort() must be the size of each array element.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/mem_regions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index e61c074..a8cb510 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -24,7 +24,7 @@ static int mem_range_cmp(const void *a1, const void *a2)
  */
 void mem_regions_sort(struct memory_ranges *ranges)
 {
-	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
+	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges[0]),
 	      mem_range_cmp);
 }
 
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
