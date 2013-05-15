Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ucggd-0007rn-Tn
 for kexec@lists.infradead.org; Wed, 15 May 2013 18:44:29 +0000
Subject: [PATCH] makedumpfile: turn off mmap for free page scan
Message-Id: <E1UcggB-0005hJ-E0@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 15 May 2013 13:43:59 -0500
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

Because addresses of each successive page structure are often descending
it is much faster to use read()'s, so set off info->flag_usemmap
while doing exclude_free_page().

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: makedumpfile.mmap/makedumpfile.c
===================================================================
--- makedumpfile.mmap.orig/makedumpfile.c
+++ makedumpfile.mmap/makedumpfile.c
@@ -3925,9 +3925,18 @@ _exclude_free_page(void)
 	return TRUE;
 }
 
+/*
+ * Note that this is a very lengthy process, even using mmap(2). The
+ * page structures in the free lists are read one-at-a-time, but using
+ * readpage_elf(), which reads an entire page.  And addresses of each
+ * successive page structure are often descending, which means that each
+ * read is another mmap(2) operation.
+ * It is much faster to use read()'s, so set off info->flag_usemmap here.
+ */
 int
 exclude_free_page(void)
 {
+	int save = info->flag_usemmap;
 	/*
 	 * Check having necessary information.
 	 */
@@ -3961,8 +3970,12 @@ exclude_free_page(void)
 	/*
 	 * Detect free pages and update 2nd-bitmap.
 	 */
-	if (!_exclude_free_page())
+	info->flag_usemmap = 0;
+	if (!_exclude_free_page()) {
+		info->flag_usemmap = save;
 		return FALSE;
+	}
+	info->flag_usemmap = save;
 
 	return TRUE;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
