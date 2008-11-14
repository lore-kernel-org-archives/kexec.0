Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0vHb-0007nN-T3
	for kexec@lists.infradead.org; Fri, 14 Nov 2008 09:48:08 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A3C79429AA
	for <kexec@lists.infradead.org>; Fri, 14 Nov 2008 10:48:04 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix spell error in help output
Date: Fri, 14 Nov 2008 10:48:04 +0100
Message-Id: <1226656084-22844-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Bernhard Walle <bwalle@suse.de>

This patch just fixes a spell error. Found by Dave Plater.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0616091..fc01458 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -917,7 +917,7 @@ void usage(void)
 	       "                      load code into.\n"
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
-	       "     --reuseinird     Reuse initrd from first boot.\n"
+	       "     --reuseinitrd    Reuse initrd from first boot.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
 	       "     --load-jump-back-helper Load a helper image to jump back\n"
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
