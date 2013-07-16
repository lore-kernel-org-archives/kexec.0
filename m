Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz4R6-0002ub-SU
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 12:32:58 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 4/7] xen: Enforce page size only when xen-syms file is used
Date: Tue, 16 Jul 2013 14:32:06 +0200
Message-Id: <1373977929-4253-5-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Enforce page size only when xen-syms file is used.
Otherwise its size could be read from VMCOREINFO
file or /proc/vmcore file.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..b4abbe5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7324,8 +7324,6 @@ initial_xen(void)
 #endif
 	if (!init_xen_crash_info())
 		return FALSE;
-	if (!fallback_to_current_page_size())
-		return FALSE;
 	/*
 	 * Get the debug information for analysis from the vmcoreinfo file
 	 */
@@ -7340,6 +7338,8 @@ initial_xen(void)
 		set_dwarf_debuginfo("xen-syms", NULL,
 				    info->name_xen_syms, info->fd_xen_syms);
 
+		if (!fallback_to_current_page_size())
+			return FALSE;
 		if (!get_symbol_info_xen())
 			return FALSE;
 		if (!get_structure_info_xen())
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
