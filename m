Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qYo-0003Kj-M6
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:40:07 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 80A2CA3B06
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:40:05 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211740.05270.ptesarik@suse.cz>
Message-Id: <20120821153755.240665681@azariah.suse.cz>
Date: Tue, 21 Aug 2012 17:37:36 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch] Initialize Xen structures from initial()
References: <20120821153735.094856832@azariah.suse.cz>
Content-Disposition: inline; filename=xen-dump-mesg.patch
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
Cc: Petr Tesarik <ptesarik@suse.cz>

Hi all,

one more Xen-related patch. This one is independent of the
other patch set.

There are two functions to initialize the internal variables:
initial() and initial_xen(). Both must be called for Xen dumps,
but only initial() is called when dumping dmesg.

With this patch applied, makedumpfile is capable of extracting
dmesg from Xen dump files.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2514,6 +2514,8 @@ initialize_bitmap_memory(void)
 	return TRUE;
 }
 
+int initial_xen(void);
+
 int
 initial(void)
 {
@@ -2521,6 +2523,9 @@ initial(void)
 	unsigned long size;
 	int debug_info = FALSE;
 
+	if (is_xen_memory() && !initial_xen())
+		return FALSE;
+
 #ifdef USELZO
 	if (lzo_init() == LZO_E_OK)
 		info->flag_lzo_support = TRUE;
@@ -6215,10 +6220,6 @@ create_dumpfile(void)
 		if (!get_elf_info(info->fd_memory, info->name_memory))
 			return FALSE;
 	}
-	if (is_xen_memory()) {
-		if (!initial_xen())
-			return FALSE;
-	}
 	if (!initial())
 		return FALSE;
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
