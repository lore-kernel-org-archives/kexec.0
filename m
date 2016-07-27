Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSSy8-0005SR-Np
 for kexec@lists.infradead.org; Wed, 27 Jul 2016 17:50:09 +0000
Received: by mail-qt0-f171.google.com with SMTP id u25so33997986qtb.1
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 10:49:48 -0700 (PDT)
Received: from localhost ([182.64.127.149])
 by smtp.gmail.com with ESMTPSA id z32sm4870570qtz.0.2016.07.27.10.49.45
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Jul 2016 10:49:46 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] kexec: fix mem_regions_sort()
Date: Wed, 27 Jul 2016 23:19:42 +0530
Message-Id: <7514609d50e28f6632e3a265fdd08020c33353b6.1469641659.git.panand@redhat.com>
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
To: kexec@lists.infradead.org

ranges->ranges is  "struct memory_range *", however each element which need
to be sorted is of type "struct memory_range". So, correct "size" argument
of qsort() as sizeof(*ranges->ranges).

Signed-off-by: Pratyush Anand <panand@redhat.com>
Cc:Russell King <rmk@arm.linux.org.uk>
Cc:Simon Horman <horms@verge.net.au>
---
 kexec/mem_regions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index e61c07472f1b..50c8abccb93a 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -24,7 +24,7 @@ static int mem_range_cmp(const void *a1, const void *a2)
  */
 void mem_regions_sort(struct memory_ranges *ranges)
 {
-	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
+	qsort(ranges->ranges, ranges->size, sizeof(*ranges->ranges),
 	      mem_range_cmp);
 }
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
