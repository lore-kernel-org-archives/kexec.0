Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6NWQ-0003At-TP
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 15:16:07 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 749D8927A5
 for <kexec@lists.infradead.org>; Tue, 28 Aug 2012 17:16:05 +0200 (CEST)
Subject: [PATCH] makedumpfile: add a missing return statement
From: Petr Tesarik <ptesarik@suse.cz>
Date: Tue, 28 Aug 2012 17:16:02 +0200
MIME-Version: 1.0
Message-Id: <201208281716.02572.ptesarik@suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The remap_init() function lacks a return statement when all goes well.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86.c
+++ b/arch/x86.c
@@ -64,6 +64,7 @@ remap_init(void)
 	}
 
 	max_numnodes = n;
+	return TRUE;
 }
 
 int



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
