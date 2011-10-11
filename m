Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe4H-0003Eo-IY
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:16:34 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 3CA123EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:31 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 26CAE45DEB2
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0D1DE45DE9E
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 014E51DB8037
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:31 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id BC2D41DB803C
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:30 +0900 (JST)
Received: from m107.css.fujitsu.com (m107 [127.0.0.1])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id 93BCB6A0006
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:30 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id 3B5E36A0003
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:30 +0900 (JST)
Date: Wed, 12 Oct 2011 00:16:26 +0900 (   )
Message-Id: <20111012.001626.424251427.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 05/12] Export helpers for bitmap table handling
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
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
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
