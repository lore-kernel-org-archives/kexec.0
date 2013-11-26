Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlP6k-000681-QY
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 20:19:43 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/3] makedumpfile/xen: Move Xen crash dump check
Date: Tue, 26 Nov 2013 21:18:47 +0100
Message-Id: <1385497129-19501-2-git-send-email-daniel.kiper@oracle.com>
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

Commit 92563d7a7a5175ef78c4a94ee269b1b455331b4c (cache: Allocate buffers
at initialization to detect malloc() failure) split cache_alloc() to
cache_init() and cache_alloc(). cache_init() is called in initial().
However, sadly initial_xen() is called before cache_init() and it uses
cache_alloc() indirectly which refers to uninitialized structures.
Hence, makedumfile run on Xen crash dumps finally fails. This patch moves
initial_xen() behind cache_init() call and fixes above mentioned issue.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0c68f32..74376cd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2905,9 +2905,6 @@ initial(void)
 	unsigned long size;
 	int debug_info = FALSE;
 
-	if (is_xen_memory() && !initial_xen())
-		return FALSE;
-
 #ifdef USELZO
 	if (lzo_init() == LZO_E_OK)
 		info->flag_lzo_support = TRUE;
@@ -3172,7 +3169,7 @@ out:
 			return FALSE;
 	}
 
-	if (is_xen_memory() && !get_dom0_mapnr())
+	if (is_xen_memory() && (!initial_xen() || !get_dom0_mapnr()))
 		return FALSE;
 
 	if (!get_value_for_old_linux())
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
