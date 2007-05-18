Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hp02K-0001OS-Ad
	for kexec@lists.infradead.org; Fri, 18 May 2007 06:50:21 -0400
Date: Fri, 18 May 2007 12:50:12 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Fix missing last node
Message-ID: <20070518105012.GF16227@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

This patch fixes a typo which results in duplication of the first node (and the
last node was missing then).

Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 makedumpfile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2278,7 +2278,7 @@ get_mm_discontigmem(struct DumpInfo *inf
 			if ((node = next_online_node(node + 1)) < 0) {
 				ERRMSG("Can't get next online node.\n");
 				return FALSE;
-			} else if (!(pgdat = next_online_pgdat(info, node))) {
+			} else if (!(pgdat = next_online_pgdat(info, node + 1))) {
 				ERRMSG("Can't determine pgdat list (node %d).\n",
 				    node);
 				return FALSE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
