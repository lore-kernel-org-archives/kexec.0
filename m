Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from jacques.telenet-ops.be ([195.130.132.50])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VO1M0-0006zZ-DJ
 for kexec@lists.infradead.org; Mon, 23 Sep 2013 08:18:49 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] [RFC] kexec: Fix off-by-one errors in locate_hole()
Date: Mon, 23 Sep 2013 10:18:12 +0200
Message-Id: <1379924292-1712-1-git-send-email-geert@linux-m68k.org>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org

When calling locate_hole() with "hole_size" equal to the size of an
available memory block, it fails to use that memory block.

"end" and "hole_max" point to the last byte within the range, hence
  - "size = end - start" is one less than "hole_size",
  - "hole_base + hole_size" is one more than "hole_max".

Subtract one from "hole_size" when doing the comparison (adding 1 to "size"
could overflow in case of one big range covering the whole address space).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Question:
    The code no longer handles the case where "hole_size" is zero.
    Should this be rejected (like is done for a zero "hole_end" at the top
    of the function), or accepted?

 kexec/kexec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 2b98ef0..eafd6c2 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -270,7 +270,7 @@ unsigned long locate_hole(struct kexec_info *info,
 		}
 		/* Is there enough space left so we can use it? */
 		size = end - start;
-		if (size >= hole_size) {
+		if (size >= hole_size - 1) {
 			if (hole_end > 0) {
 				hole_base = start;
 				break;
@@ -286,7 +286,7 @@ unsigned long locate_hole(struct kexec_info *info,
 			"0x%lx bytes...\n", hole_size);
 		return ULONG_MAX;
 	}
-	if ((hole_base + hole_size)  > hole_max) {
+	if ((hole_base + hole_size - 1)  > hole_max) {
 		fprintf(stderr, "Could not find a free area of memory below: "
 			"0x%lx...\n", hole_max);
 		return ULONG_MAX;
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
