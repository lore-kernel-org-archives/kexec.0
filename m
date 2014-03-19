Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQGwR-00040k-1G
 for kexec@lists.infradead.org; Wed, 19 Mar 2014 13:53:59 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CDBEE7501D
 for <kexec@lists.infradead.org>; Wed, 19 Mar 2014 13:53:32 +0000 (UTC)
From: Petr Tesarik <ptesarik@suse.cz> (by way of Petr Tesarik
 <ptesarik@suse.cz>)
Date: Wed, 19 Mar 2014 10:27:10 +0100
Message-Id: <20140319093321.27CF36013F@nathan.suse.cz>
Subject: [PATCH] Allow --dump-dmesg for Xen vmcores
Resent-Message-ID: <20140319145331.2acf2320@hananiah.suse.cz>
Resent-To: kexec@lists.infradead.org
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
Cc: kexec@lists.infradead.org

If a Xen dump is detected, makedumpfile checks that the target format is
ELF. The real reason is that compressed formats are not possible with Xen.

But there's a third way initial_xen() can be called: with --dump-dmesg.
This variant works in fact, so it's enough to extend the check so that
it covers this case.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0bd8b55..ea29239 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7660,7 +7660,7 @@ initial_xen(void)
 	MSG("Xen is not supported on powerpc.\n");
 	return FALSE;
 #else
-	if(!info->flag_elf_dumpfile) {
+	if(!info->flag_elf_dumpfile && !info->flag_dmesg) {
 		MSG("Specify '-E' option for Xen.\n");
 		MSG("Commandline parameter is invalid.\n");
 		MSG("Try `makedumpfile --help' for more information.\n");
-- 
1.8.4.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
