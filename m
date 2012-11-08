Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOjJ-0006Gn-P1
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:58 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 64E4A3EE0BC
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:56 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4F7DF45DE56
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:56 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 38DDA45DE54
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:56 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A8A81DB8044
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:56 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D58791DB8042
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:55 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 09/10] Add page_is_buddy for old kernels
Date: Thu, 08 Nov 2012 18:48:55 +0900
Message-ID: <20121108094855.30421.19688.stgit@localhost6.localdomain6>
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

On kernels from v2.6.15 to v2.6.17 buddy page is marked by the
condition that PG_private flag is set and _count == 0.

Unfortunately, I have yet to test this logic on these kernel versions
simply because I've been failing to boot them on my box.

Note that on these kernels, free list can be corrupted due to the bug
that the above two conditions are not checked atomically. The reason
why PG_buddy was introduced is a fix for this bug.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 838ef53..d1efc09 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3643,6 +3643,20 @@ exclude_free_page(void)
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
@@ -3675,8 +3689,9 @@ static void
 setup_page_is_buddy(void)
 {
 	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
-		if (SIZE(pageflags) != NOT_FOUND_STRUCTURE
-		    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
+		if (SIZE(pageflags) == NOT_FOUND_STRUCTURE)
+			info->page_is_buddy = page_is_buddy_v1;
+		else if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
 			info->page_is_buddy = page_is_buddy_v3;
 		else {
 			MSG("Can't select page_is_buddy handler; "


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
