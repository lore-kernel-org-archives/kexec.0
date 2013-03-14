Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG30N-00040O-Bx
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 07:55:16 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3FBC73EE081
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 16:55:06 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A56345DE59
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 16:55:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1445845DE58
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 16:55:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 06C9D1DB804E
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 16:55:06 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B52141DB8046
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 16:55:05 +0900 (JST)
Date: Thu, 14 Mar 2013 16:54:15 +0900 (JST)
Message-Id: <20130314.165415.412290566.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile: fix missing count of filtered free pages
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

On the current implementation, __exclude_unnecessary_pages() can refer
to page frames not belonging to current cycle. Thus, pfn_free can be
now counted up even if it doesn't belong to the current cycle.

This patch changes it so pfn_free is counted up only if the
corresponding pfn really belongs to the cycle.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index acb1b21..817da34 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4224,9 +4224,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 				 * See check_cyclic_buffer_overrun()
 				 * for the detail.
 				 */
-				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
+				if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
+					pfn_free++;
 			}
-			pfn_free += i;
 		}
 		/*
 		 * Exclude the cache page without the private page.
-- 
1.7.7.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
