Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIgZ-0005O7-59
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:39:19 +0000
Received: by mail-pb0-f49.google.com with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:39:18 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 10/10] Add page_is_buddy for old kernels
Date: Fri, 29 Jun 2012 02:39:15 +0900
Message-ID: <20120628173915.19702.53050.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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

On kernels from v2.6.15 to v2.6.17 buddy page is marked by the
condition that PG_private flag is set and _count == 0.

Unfortunately, I have yet to test this logic on these kernel versions
simply because I've been failing to boot them on my box.

Note that on these kernels, free list can be corrupted due to the bug
that the above two conditions are not checked atomically. The reason
why PG_buddy was introduced is a fix for this bug. Thus, the bug can
also affect the logic based on mem_map array, which we cannot avoid
definitely.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 675b47e..b73cc64 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3518,6 +3518,18 @@ exclude_free_page(void)
 }
 
 static int
+page_is_buddy_v1(unsigned long flags, unsigned int _mapcount,
+		 unsigned long private, unsigned int _count)
+{
+	if ((flags & (1UL << NUMBER(PG_private)))
+	    && _count == 0
+	    && private <= ARRAY_LENGTH(zone.free_area))
+		return TRUE;
+
+	return FALSE;
+}
+
+static int
 page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
 		 unsigned long private, unsigned int _count)
 {
@@ -3544,8 +3556,9 @@ static void
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
