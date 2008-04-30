Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jr1FI-00067v-Dv
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 01:36:33 +0000
Message-Id: <a8d9dc7f83b9c34d9e0165503b323a7f32b00260.1209519344.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Make extended crashkernel= syntax less confusing
Date: Wed, 30 Apr 2008 11:36:27 +1000 (EST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: bwalle@suse.de, kexec@lists.infradead.org

The extended crashkernel syntax is a little confusing in the
way it handles ranges. eg:

 crashkernel=512M-2G:64M,2G-:128M

Means if the machine has between 512M and 2G of memory the
crash region should be 64M, and if the machine has 2G of
memory the region should be 64M. Only if the machine has
more than 2G memory will 128M be allocated.

Although that semantic is correct, it is somewhat baffling.
Instead I propose that the end of the range means the first
address past the end of the range, ie: 512M up to but not
including 2G.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Acked-by: Bernhard Walle <bwalle@suse.de>
---

 kernel/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 6782dce..0ab5e33 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1217,7 +1217,7 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram <= end) {
+		if (system_ram >= start && system_ram < end) {
 			*crash_size = size;
 			break;
 		}
-- 
1.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
