Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxl-0005lx-Iw
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:44 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/8] Move out mem_min/max checking in locate_hole
Date: Fri, 16 Nov 2012 15:04:23 -0800
Message-Id: <1353107067-14564-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

only need to check one time out of the loop.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/kexec.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 00f90f5..b8d77bb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -190,9 +190,9 @@ int sort_segments(struct kexec_info *info)
 	return 0;
 }
 
-unsigned long locate_hole(struct kexec_info *info,
-	unsigned long hole_size, unsigned long hole_align, 
-	unsigned long hole_min, unsigned long hole_max, 
+static unsigned long __locate_hole(struct kexec_info *info,
+	unsigned long hole_size, unsigned long hole_align,
+	unsigned long hole_min, unsigned long hole_max,
 	int hole_end)
 {
 	int i, j;
@@ -253,22 +253,16 @@ unsigned long locate_hole(struct kexec_info *info,
 		/* First filter the range start and end values
 		 * through the lens of mem_min, mem_max and hole_align.
 		 */
-		if (start < mem_min) {
-			start = mem_min;
-		}
 		if (start < hole_min) {
 			start = hole_min;
 		}
 		start = (start + hole_align - 1) &
 			~((unsigned long long)hole_align - 1);
-		if (end > mem_max) {
-			end = mem_max;
-		}
 		if (end > hole_max) {
 			end = hole_max;
 		}
 		/* Is this still a valid memory range? */
-		if ((start >= end) || (start >= mem_max) || (end <= mem_min)) {
+		if (start >= end) {
 			continue;
 		}
 		/* Is there enough space left so we can use it? */
@@ -297,6 +291,19 @@ unsigned long locate_hole(struct kexec_info *info,
 	return hole_base;
 }
 
+unsigned long locate_hole(struct kexec_info *info,
+	unsigned long hole_size, unsigned long hole_align, 
+	unsigned long hole_min, unsigned long hole_max, 
+	int hole_end)
+{
+	hole_min = max(hole_min, (unsigned long)mem_min);
+	hole_max = min(hole_max, (unsigned long)mem_max);
+
+	return __locate_hole(info, hole_size, hole_align,
+				 hole_min, hole_max, hole_end);
+
+}
+
 void add_segment_phys_virt(struct kexec_info *info,
 	const void *buf, size_t bufsz,
 	unsigned long base, size_t memsz, int phys)
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
