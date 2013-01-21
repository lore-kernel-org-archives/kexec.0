Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxAfT-00010q-4I
 for kexec@lists.infradead.org; Mon, 21 Jan 2013 06:15:40 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7AD033EE0AE
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:15:33 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6482545DE52
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:15:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4007145DE4F
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:15:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 34219E18003
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:15:33 +0900 (JST)
Received: from m025.s.css.fujitsu.com (m025.s.css.fujitsu.com [10.0.81.65])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E8175E18001
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:15:32 +0900 (JST)
Date: Mon, 21 Jan 2013 15:15:01 +0900 (JST)
Message-Id: <20130121.151501.404516000.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile, sadump: fix bug in checking a given physical
 address is present on memory
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

Due to lack of checking if sadump flag, interface for ELF had been
used wrongly for sadump format. By this, all the ranges had been
ignored and most kinds of filtering had been failed except for zero
pages.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 314dc46..7ce7138 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3027,7 +3027,7 @@ clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
 static inline int
 is_in_segs(unsigned long long paddr)
 {
-	if (info->flag_refiltering) {
+	if (info->flag_refiltering || info->flag_sadump) {
 		static struct dump_bitmap bitmap1 = {0};
 
 		if (bitmap1.fd == 0)
-- 
1.7.7.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
