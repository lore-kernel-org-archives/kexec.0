Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaKy3-0007ht-HM
 for kexec@lists.infradead.org; Wed, 16 Apr 2014 08:13:16 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3G8CoVO009542
 for <kexec@lists.infradead.org>; Wed, 16 Apr 2014 17:12:50 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s3G8CoE28703 for <kexec@lists.infradead.org>;
 Wed, 16 Apr 2014 17:12:50 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3G8Cnn3002674
 for <kexec@lists.infradead.org>; Wed, 16 Apr 2014 17:12:49 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] makedumpfile: Fix a bug found during regression testing for
 v1.5.6
Date: Wed, 16 Apr 2014 08:11:27 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720436D@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

I have to do regression testing again for this issue and the OOM
issue reported by Vivek, so the release of v1.5.6 will be put off
to next week.

Thanks for your patience.

Atsushi Kumagai

--
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Wed, 16 Apr 2014 14:56:01 +0900
Subject: [PATCH] Exclude small cycle regions wrongly.

In bitmap initialization, if a cycle region is smaller than 8 pages
and its start_pfn is aligned to multiple of 8 pages, it will be
excluded wrongly.

  Example case:
    pfn_start=0x103ff80, pfn_start_roundup=0x103ff80
    pfn_end=0x103ff84, pfn_end_round=0x103ff80

This case doesn't meet any conditions to set bits in
create_1st_bitmap_cyclic() and initialize_2nd_bitmap_cyclic().
We should admit the case where pfn_start is equal to pfn_end_round
like above.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index da960ad..dd9373d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4545,7 +4545,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
 		}
 
-		if (pfn_end_round > pfn_start) {
+		if (pfn_end_round >= pfn_start) {
 			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
 				if (set_bit_on_1st_bitmap(pfn, cycle))
 					pfn_bitmap1++;
@@ -4653,7 +4653,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 			       pfn_end_byte - pfn_start_byte);
 		}
 
-		if (pfn_end_round > pfn_start) {
+		if (pfn_end_round >= pfn_start) {
 			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn) {
 				if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 					return FALSE;
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
