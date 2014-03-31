Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t1524.atlanta.hp.com ([15.193.200.67])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUX0u-00013m-0I
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 07:52:13 +0000
Subject: [PATCH v2] makedumpfile: Fix a segment fault in dumping not aligned
 ELF segment
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Mon, 31 Mar 2014 15:51:43 +0800
Message-ID: <20140331075142.24848.97938.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, lisa.mitchell@hp.com, chaowang@redhat.com

This patch fixes a bug that will cause segment fault if the starting or ending
address of the ELF segment is not aligned to 8 bytes boundary.

Changelog:
v2:
- Change subject to describe patch correctly.
- Some minor code format changes.

In function create_1st_bitmap_cyclic() and initialize_2nd_bitmap_cyclic(),
there are the same code:

                pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
                pfn_end_round = round(pfn_end, BITPERBYTE);

                for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
                        if (set_bit_on_1st_bitmap(pfn))
                                pfn_bitmap1++;
                }

In case:
pfn_start=0xe762c, pfn_start_roundup=0xe7630
pfn_end=0xe762d, pfn_end_round=0xe7628
This code will set incorrect bits in the bitmap.
In function readpage_elf():

        if (!offset1) {
                phys_start = page_head_to_phys_start(paddr);
                offset1 = paddr_to_offset(phys_start);
                frac_head = phys_start - paddr;
                memset(bufptr, 0, frac_head);
        }

The invalid paddr couldn't be found, so phys_start will be zero, and frac_head
will be negative, then memset will cause a segment fault.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ef08d91..900d553 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4424,8 +4424,9 @@ create_1st_bitmap_cyclic()
 		if (pfn_start >= pfn_end)
 			continue;
 
-		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
-		pfn_end_round = round(pfn_end, BITPERBYTE);
+		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
+					pfn_end);
+		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
 			if (set_bit_on_1st_bitmap(pfn))
@@ -4443,9 +4444,11 @@ create_1st_bitmap_cyclic()
 			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
 		}
 
-		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
-			if (set_bit_on_1st_bitmap(pfn))
-				pfn_bitmap1++;
+		if (pfn_end_round > pfn_start) {
+			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
+				if (set_bit_on_1st_bitmap(pfn))
+					pfn_bitmap1++;
+			}
 		}
 	}
 	pfn_memhole -= pfn_bitmap1;
@@ -4532,8 +4535,9 @@ initialize_2nd_bitmap_cyclic(void)
 		if (pfn_start >= pfn_end)
 			continue;
 
-		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
-		pfn_end_round = round(pfn_end, BITPERBYTE);
+		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
+					pfn_end);
+		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
 			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
@@ -4548,9 +4552,12 @@ initialize_2nd_bitmap_cyclic(void)
 			       pfn_end_byte - pfn_start_byte);
 		}
 
-		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
-			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
-				return FALSE;
+		if (pfn_end_round > pfn_start) {
+			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn) {
+				if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
+					return FALSE;
+			}
+		}
 	}
 
 	return TRUE;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
