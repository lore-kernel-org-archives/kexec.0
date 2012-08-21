Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNu-0002pY-0Y
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:50 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 28101A3DD6
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:49 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.48892.ptesarik@suse.cz>
Message-Id: <20120821084452.527450591@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:56 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 5/9] Initialize phys_start during early Xen setup
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=05-x86-phys_start.patch
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
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

With early Xen setup, we can move the initialization of xen_phys_start
to the setup routine. This is cleaner, as we can get rid of ifdef'ed
arch-specific code in makedumpfile.c (which should IMO stay generic).

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86.c     |    9 +++++++++
 arch/x86_64.c  |    9 +++++++++
 makedumpfile.c |   16 ----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

--- a/arch/x86.c
+++ b/arch/x86.c
@@ -296,6 +296,15 @@ int get_xen_basic_info_x86(void)
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
 
+	if (!info->xen_phys_start) {
+		if (info->xen_crash_info_v < 2) {
+			ERRMSG("Can't get Xen physical start address.\n"
+			       "Please use the --xen_phys_start option.");
+			return FALSE;
+		}
+		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
+	}
+
 	if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
 	    SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get pgd.\n");
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -361,6 +361,15 @@ int get_xen_basic_info_x86_64(void)
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
 
+ 	if (!info->xen_phys_start) {
+		if (info->xen_crash_info_v < 2) {
+			ERRMSG("Can't get Xen physical start address.\n"
+			       "Please use the --xen_phys_start option.");
+			return FALSE;
+		}
+		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
+	}
+
 	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get pml4.\n");
 		return FALSE;
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5365,20 +5365,6 @@ init_xen_crash_info(void)
 }
 
 int
-get_xen_phys_start(void)
-{
-	if (info->xen_phys_start)
-		return TRUE;
-
-#if defined(__x86__) || defined(__x86_64__)
-	if (info->xen_crash_info_v >= 2)
-		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
-#endif
-
-	return TRUE;
-}
-
-int
 get_xen_info(void)
 {
 	unsigned long domain;
@@ -5877,8 +5863,6 @@ initial_xen(void)
 		if (!read_vmcoreinfo_from_vmcore(offset, size, TRUE))
 			return FALSE;
 	}
-	if (!get_xen_phys_start())
-		return FALSE;
 	if (!get_xen_info())
 		return FALSE;
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
