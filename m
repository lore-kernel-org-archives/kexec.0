Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj3C-0003Nn-AU
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:48:35 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A7A383EE081
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C23E45DE55
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 732EB45DE67
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 67A8F1DB803E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D31F1DB803F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from ml13.css.fujitsu.com (ml13 [127.0.0.1])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 0B59BFD001C
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:32 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id B8B4EFD001E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:31 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 05/14] Export helpers for bitmap table handling
Date: Fri, 28 Oct 2011 18:48:31 +0900
Message-ID: <20111028094831.20940.46448.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

sadump-related formats and kdump-compressed format is similar in
structure. In particular, both have exactly the same in bitmap. So
reuse two helper functions, is_on() and is_dumpable(), in sadump
module.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   22 ----------------------
 makedumpfile.h |   24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7057009..96faf60 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2543,28 +2543,6 @@ clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
 }
 
 static inline int
-is_on(char *bitmap, int i)
-{
-	return bitmap[i>>3] & (1 << (i & 7));
-}
-
-static inline int
-is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
-{
-	off_t offset;
-	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
-		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
-		lseek(bitmap->fd, offset, SEEK_SET);
-		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
-		if (pfn == 0)
-			bitmap->no_block = 0;
-		else
-			bitmap->no_block = pfn/PFN_BUFBITMAP;
-	}
-	return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
-}
-
-static inline int
 is_in_segs(unsigned long long paddr)
 {
 	if (info->flag_refiltering) {
diff --git a/makedumpfile.h b/makedumpfile.h
index dee0a68..17ec590 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -56,6 +56,8 @@ enum {
 	FLATMEM
 };
 
+int get_mem_type(void);
+
 /*
  * Page flags
  *
@@ -1244,4 +1246,26 @@ int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) FALSE
 #endif	/* s390x */
 
+static inline int
+is_on(char *bitmap, int i)
+{
+	return bitmap[i>>3] & (1 << (i & 7));
+}
+
+static inline int
+is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
+{
+	off_t offset;
+	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
+		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
+		lseek(bitmap->fd, offset, SEEK_SET);
+		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
+		if (pfn == 0)
+			bitmap->no_block = 0;
+		else
+			bitmap->no_block = pfn/PFN_BUFBITMAP;
+	}
+	return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
+}
+
 #endif /* MAKEDUMPFILE_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
