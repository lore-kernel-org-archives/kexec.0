Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnUJU-0006Wt-My
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 14:17:29 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 1/4] makedumpfile/xen: Add cache_init() call to
 initial_xen()
Date: Mon,  2 Dec 2013 15:16:41 +0100
Message-Id: <1385993804-27721-2-git-send-email-daniel.kiper@oracle.com>
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

Commit 92563d7a7a5175ef78c4a94ee269b1b455331b4c (cache: Allocate buffers
at initialization to detect malloc() failure) split cache_alloc() to
cache_init() and cache_alloc(). cache_init() is called in initial().
However, sadly initial_xen() is called before cache_init() and it uses
cache_alloc() indirectly which refers to uninitialized structures.
Hence, makedumfile run on Xen crash dumps finally fails. This patch adds
cache_init() call to initial_xen() and fixes above mentioned issue.
cache_init() is called in initial() if crash dump is not Xen one.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0c68f32..55e53b7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3117,7 +3117,7 @@ out:
 		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
 	}
 
-	if (!cache_init())
+	if (!is_xen_memory() && !cache_init())
 		return FALSE;
 
 	if (debug_info) {
@@ -7622,6 +7622,7 @@ exclude_xen_user_domain(void)
 int
 initial_xen(void)
 {
+	int xen_info_required = TRUE;
 	off_t offset;
 	unsigned long size;
 
@@ -7673,8 +7674,10 @@ initial_xen(void)
 		 * and get both the offset and the size.
 		 */
 		if (!has_vmcoreinfo_xen()){
-			if (!info->flag_exclude_xen_dom)
+			if (!info->flag_exclude_xen_dom) {
+				xen_info_required = FALSE;
 				goto out;
+			}
 
 			MSG("%s doesn't contain a vmcoreinfo for Xen.\n",
 			    info->name_memory);
@@ -7691,6 +7694,7 @@ initial_xen(void)
 			return FALSE;
 	}
 
+out:
 	if (!info->page_size) {
 		/*
 		 * If we cannot get page_size from a vmcoreinfo file,
@@ -7700,12 +7704,17 @@ initial_xen(void)
 			return FALSE;
 	}
 
-	if (!get_xen_info())
+	if (!cache_init())
 		return FALSE;
 
-	if (message_level & ML_PRINT_DEBUG_MSG)
-		show_data_xen();
-out:
+	if (xen_info_required == TRUE) {
+		if (!get_xen_info())
+			return FALSE;
+
+		if (message_level & ML_PRINT_DEBUG_MSG)
+			show_data_xen();
+	}
+
 	if (!get_max_mapnr())
 		return FALSE;
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
