Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxBra-0005vz-4F
 for kexec@lists.infradead.org; Mon, 21 Jan 2013 07:32:14 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EC1B63EE0BC
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:32:11 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D005D45DE5C
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:32:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B7A9245DE5D
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:32:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AB6F81DB804C
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:32:11 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6475A1DB8046
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:32:11 +0900 (JST)
Date: Mon, 21 Jan 2013 16:32:06 +0900 (JST)
Message-Id: <20130121.163206.386362782.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile, sadump: fix warning about unused variable
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Recent gcc does unused variable checking at default of -Wall and
outputs the following warning:

./sadump_info.c: In function 'sadump_initialize_bitmap_memory':
./sadump_info.c:754: warning: variable 'dumpable_bitmap_len' set but not used

Delete it as suggested.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index 69763be..c0775c5 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -751,7 +751,7 @@ sadump_initialize_bitmap_memory(void)
 {
 	struct sadump_header *sh = si->sh_memory;
 	struct dump_bitmap *bmp;
-	unsigned long dumpable_bitmap_offset, dumpable_bitmap_len;
+	unsigned long dumpable_bitmap_offset;
 	unsigned long long section, max_section, pfn;
 	unsigned long long *block_table;
 
@@ -759,8 +759,6 @@ sadump_initialize_bitmap_memory(void)
 		si->sub_hdr_offset +
 		sh->block_size * (sh->sub_hdr_size + sh->bitmap_blocks);
 
-	dumpable_bitmap_len = sh->block_size * sh->dumpable_bitmap_blocks;
-
 	bmp = malloc(sizeof(struct dump_bitmap));
 	if (bmp == NULL) {
 		ERRMSG("Can't allocate memory for the memory-bitmap. %s\n",
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
