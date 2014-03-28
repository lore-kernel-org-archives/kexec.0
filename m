Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTVbl-0003AT-EZ
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 12:10:03 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v2 1/2] Earlier initialization of dom0_mapnr
Date: Fri, 28 Mar 2014 13:09:20 +0100
Message-Id: <1396008561-15186-2-git-send-email-ptesarik@suse.cz>
In-Reply-To: <1396008561-15186-1-git-send-email-ptesarik@suse.cz>
References: <0910DD04CBD6DE4193FCF86B9C00BE971FAC57@BPXM01GP.gisp.nec.co.jp>
 <1396008561-15186-1-git-send-email-ptesarik@suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <petr@tesarici.cz>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

From: Petr Tesarik <petr@tesarici.cz>

Xen dumps fail, because the p2m mapping is initialized too late.
The dependency goes like this:

- Xen uses FLATMEM
- get_mm_flatmem() uses info->dom0_mapnr to initialize mm structures
- get_dom0_mapnr() needs p2m mappings to read from a VADDR
- the p2m list is initialized in get_machdep_info()

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e91583d..1117598 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3181,13 +3181,16 @@ out:
 	if (!is_xen_memory() && !cache_init())
 		return FALSE;
 
+	if (debug_info && !get_machdep_info())
+		return FALSE;
+
+	if (is_xen_memory() && !get_dom0_mapnr())
+		return FALSE;
+
 	if (debug_info) {
 		if (info->flag_sadump)
 			(void) sadump_virt_phys_base();
 
-		if (!get_machdep_info())
-			return FALSE;
-
 		if (info->flag_sadump) {
 			int online_cpus;
 
@@ -3233,9 +3236,6 @@ out:
 			return FALSE;
 	}
 
-	if (is_xen_memory() && !get_dom0_mapnr())
-		return FALSE;
-
 	if (!get_value_for_old_linux())
 		return FALSE;
 
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
