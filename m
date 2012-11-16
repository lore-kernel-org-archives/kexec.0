Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxl-0005ly-Qz
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:44 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 5/8] seperate checking 64bit mem range
Date: Fri, 16 Nov 2012 15:04:24 -0800
Message-Id: <1353107067-14564-6-git-send-email-yinghai@kernel.org>
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

Acccording to start value to use right range.

So could avoid put range too high or too low.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/kexec.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index b8d77bb..aec3b9e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -364,6 +364,7 @@ unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	unsigned long base;
 	int result;
 	int pagesize;
+	unsigned long hole_min, hole_max;
 
 	result = sort_segments(info);
 	if (result < 0) {
@@ -374,11 +375,18 @@ unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	pagesize = getpagesize();
 	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
 
-	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
-	if (base == ULONG_MAX) {
-		die("locate_hole failed\n");
+	if (buf_min < (1ULL<<32)) {
+		hole_min = max(buf_min, (unsigned long)mem_min);
+		hole_max = min(buf_max, (unsigned long)mem_max);
+	} else {
+		hole_min = max(buf_min, (unsigned long)mem64_min);
+		hole_max = min(buf_max, (unsigned long)mem64_max);
 	}
-	
+
+	base = __locate_hole(info, memsz, buf_align, hole_min, hole_max, buf_end);
+	if (base == ULONG_MAX)
+		return 0;
+
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, phys);
 	return base;
 }
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
