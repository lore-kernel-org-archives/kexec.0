Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE4A-0006DX-Im
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:11 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1CAFC3EE0AE
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:09 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id EB7AA45DE53
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id AC8BE45DE52
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A09061DB803B
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:08 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 30D3B1DB802F
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:08 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 07/10] Add page_is_buddy for recent kernels
Date: Fri, 16 Nov 2012 14:02:07 +0900
Message-ID: <20121116050207.8280.14374.stgit@localhost6.localdomain6>
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

On kernels from v2.6.38 and later kernels, buddy page is marked by
_mapcount == PAGE_BUDDY_MAPCOUNT_VALUE, which varies once as follows:

  kernel version    | PAGE_BUDDY_MAPCOUNT_VALUE
  ------------------+--------------------------
  v2.6.38           | -2
  v2.6.39 and later | -128

One more notice is that _mapcount shares its memory with other fields
for SLAB/SLUB when PG_slab is set. Before looking up _mapcount value,
we need to check if PG_slab is set.

Since this page_is_buddy needs _mapcount, we use freelist logic if
_mapcount is not available.

Recall that PG_slab has been 7 since v2.6.15. No need to check it.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0e44a8b..7b13dca 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3668,12 +3668,33 @@ exclude_free_page(void)
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
 	if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
 		goto out;
 
+	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
+			info->page_is_buddy = page_is_buddy_v3;
+	}
+
 out:
 	if (!info->page_is_buddy)
 		DEBUG_MSG("Can't select page_is_buddy handler; "


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
