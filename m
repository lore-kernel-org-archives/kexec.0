Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE4K-0006HX-Nk
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:21 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4A4803EE0AE
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:19 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 31EE645DD74
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1CA8F45DD78
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 112141DB8038
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:19 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BEEAC1DB802C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:18 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 09/10] Add page_is_buddy for old kernels
Date: Fri, 16 Nov 2012 14:02:18 +0900
Message-ID: <20121116050218.8280.45605.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

On kernels from v2.6.15 to v2.6.17, buddy page is marked by the
condition that PG_private flag is set and _count == 0.

Since this page_is_buddy needs _count, we use freelist logic if _count
is not available.

Unfortunately, I have yet to test this logic on these kernel versions
simply because I've been failing to boot them on my box.

Note that on these kernels, free list can be corrupted due to the bug
that the above two conditions are not checked atomically. The reason
why PG_buddy was introduced is a fix for this bug.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4e5d4d3..65b9fd7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3669,6 +3669,20 @@ exclude_free_page(void)
 }
 
 /*
+ * For the kernel versions from v2.6.15 to v2.6.17.
+ */
+static int
+page_is_buddy_v1(unsigned long flags, unsigned int _mapcount,
+			unsigned long private, unsigned int _count)
+{
+	if ((flags & (1UL << NUMBER(PG_private)))
+	    && _count == 0)
+		return TRUE;
+
+	return FALSE;
+}
+
+/*
  * For the kernel versions from v2.6.17 to v2.6.37.
  */
 static int
@@ -3707,6 +3721,9 @@ setup_page_is_buddy(void)
 		if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
 			if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
 				info->page_is_buddy = page_is_buddy_v3;
+		} else if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
+			if (OFFSET(page._count) != NOT_FOUND_STRUCTURE)
+				info->page_is_buddy = page_is_buddy_v1;
 		}
 	} else
 		info->page_is_buddy = page_is_buddy_v2;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
