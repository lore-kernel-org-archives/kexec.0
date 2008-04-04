Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jhbl7-0001nX-Qh
	for kexec@lists.infradead.org; Fri, 04 Apr 2008 02:34:30 +0000
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: [Patch][RFC] makedumpfile: fix for xen-3.1.2
Date: Fri, 04 Apr 2008 11:31:50 +0900
MIME-Version: 1.0
Message-Id: <D4C895FC097B62takebe_akio@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel <xen-devel@lists.xensource.com>, kexec-ml <kexec@lists.infradead.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Itsuro ODA <oda@valinux.co.jp>

Hi,

This patch fixes makedumpfile for xen-3.1.
xen-3.1.2+ hypervisor doesn't have idle_pg_table_l3,
we need to find a symbole of idle_pg_table.

Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>

Best Regards,

Akio Takebe

--- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
+++ makedumpfile.mod/makedumpfile.c	2008-04-03 14:58:11.000000000 +0900
@@ -5298,7 +5298,12 @@ get_symbol_info_xen()
 	 */
 	SYMBOL_INIT(pgd_l2, "idle_pg_table_l2");	/* x86 */
 	SYMBOL_INIT(pgd_l3, "idle_pg_table_l3");	/* x86-PAE */
+	if (SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(pgd_l3, "idle_pg_table");	/* x86-PAE */
 	SYMBOL_INIT(pgd_l4, "idle_pg_table_4");		/* x86_64 */
+	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(pgd_l4, "idle_pg_table");		/* x86_64 */
+
 	SYMBOL_INIT(xen_heap_start, "xen_heap_start");	/* ia64 */
 	SYMBOL_INIT(xen_pstart, "xen_pstart");		/* ia64 */
 	SYMBOL_INIT(frametable_pg_dir, "frametable_pg_dir");	/* ia64 */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
