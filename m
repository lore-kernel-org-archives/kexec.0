Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnUJU-0006Wv-Mx
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 14:17:31 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 4/4] makedumpfile/xen: Move cyclic mode check from
 initial() to initial_xen()
Date: Mon,  2 Dec 2013 15:16:44 +0100
Message-Id: <1385993804-27721-5-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
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

Move cyclic mode check from initial() to initial_xen(). Just small cleanup.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 45f96aa..e173f85 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2928,14 +2928,6 @@ initial(void)
 	}
 #endif
 
-	if (is_xen_memory()) {
-		if(info->flag_cyclic) {
-			info->flag_cyclic = FALSE;
-			MSG("Switched running mode from cyclic to non-cyclic,\n");
-			MSG("because the cyclic mode doesn't support Xen.\n");
-		}
-	}
-
 	if (info->flag_exclude_xen_dom && !is_xen_memory()) {
 		MSG("'-X' option is disable,");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
@@ -7645,6 +7637,12 @@ initial_xen(void)
 		return FALSE;
 	}
 
+	if(info->flag_cyclic) {
+		info->flag_cyclic = FALSE;
+		MSG("Switched running mode from cyclic to non-cyclic,\n");
+		MSG("because the cyclic mode doesn't support Xen.\n");
+	}
+
 	if (!init_xen_crash_info())
 		return FALSE;
 	/*
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
