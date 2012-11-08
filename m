Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOj9-0006Ca-5x
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:50 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C6CC13EE0BB
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:45 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AD5AD45DE4D
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 97C9145DD78
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8A7C01DB803C
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:45 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 434891DB8038
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:45 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 07/10] Add page_is_buddy for recent kernels
Date: Thu, 08 Nov 2012 18:48:44 +0900
Message-ID: <20121108094844.30421.89650.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

On kernels from v2.6.38 and later kernels, buddy page is marked by
_mapcount == PAGE_BUDDY_MAPCOUNT_VALUE, which varies once as follows:

  kernel version    | PAGE_BUDDY_MAPCOUNT_VALUE
  ------------------+--------------------------
  v2.6.38           | -2
  v2.6.39 and later | -128

One more notice is that _mapcount shares its memory with other fields
for SLAB/SLUB when PG_slab is set. Before looking up _mapcount value,
we need to check if PG_slab is set.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6358fc0..27ad3e6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3642,11 +3642,32 @@ exclude_free_page(void)
 	return TRUE;
 }
 
+/*
+ * For v2.6.38 and later kernel versions.
+ */
+static int
+page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
+			unsigned long private, unsigned int _count)
+{
+	if (flags & (1UL << NUMBER(PG_slab)))
+		return FALSE;
+
+	if (_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
+		return TRUE;
+
+	return FALSE;
+}
+
 static void
 setup_page_is_buddy(void)
 {
-	MSG("Can't select page_is_buddy handler; "
-	    "filtering free pages is disabled.\n");
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
+	    && SIZE(pageflags) != NOT_FOUND_STRUCTURE
+	    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
+		info->page_is_buddy = page_is_buddy_v3;
+	else
+		MSG("Can't select page_is_buddy handler; "
+		    "filtering free pages is disabled.\n");
 }
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
