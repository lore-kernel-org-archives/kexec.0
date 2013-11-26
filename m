Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlP6k-000682-74
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 20:19:42 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 2/3] makedumpfile/xen: Disable cyclic mode for every Xen crash
 dump
Date: Tue, 26 Nov 2013 21:18:48 +0100
Message-Id: <1385497129-19501-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1385497129-19501-1-git-send-email-daniel.kiper@oracle.com>
References: <1385497129-19501-1-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Disable cyclic mode for every Xen crash dump not only when -X option
is used. This way makedumpfile is much more flexible and different
modes could be used to dump whole system memory (e.g. zero pages
could be striped without requiring -X option).

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 74376cd..b160cea 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2925,20 +2925,20 @@ initial(void)
 	}
 #endif
 
-	if (info->flag_exclude_xen_dom) {
+	if (is_xen_memory()) {
 		if(info->flag_cyclic) {
 			info->flag_cyclic = FALSE;
 			MSG("Switched running mode from cyclic to non-cyclic,\n");
 			MSG("because the cyclic mode doesn't support Xen.\n");
 		}
+	}
 
-		if (!is_xen_memory()) {
-			MSG("'-X' option is disable,");
-			MSG("because %s is not Xen's memory core image.\n", info->name_memory);
-			MSG("Commandline parameter is invalid.\n");
-			MSG("Try `makedumpfile --help' for more information.\n");
-			return FALSE;
-		}
+	if (info->flag_exclude_xen_dom && !is_xen_memory()) {
+		MSG("'-X' option is disable,");
+		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
+		MSG("Commandline parameter is invalid.\n");
+		MSG("Try `makedumpfile --help' for more information.\n");
+		return FALSE;
 	}
 
 	if (info->flag_refiltering) {
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
