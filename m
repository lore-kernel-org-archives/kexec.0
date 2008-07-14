Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIP6i-0005QX-UC
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 14:32:53 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 05289459E6
	for <kexec@lists.infradead.org>; Mon, 14 Jul 2008 16:32:51 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Use CFLAGS for compiling bin2hex
Date: Mon, 14 Jul 2008 16:33:32 +0200
Message-Id: <1216046012-32349-1-git-send-email-bwalle@suse.de>
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

This is a minor correction in the Makefile to use the CFLAGS (from configure)
also for bin2hex.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 util/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/Makefile b/util/Makefile
index 11d82fd..a1a78ac 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -2,10 +2,10 @@ BIN_TO_HEX:= bin/bin-to-hex
 
 $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
 	@$(MKDIR) -p $(@D)
-	$(LINK.o) -o $@ $^
+	$(LINK.o) $(CFLAGS) -o $@ $^
 
 $(BIN_TO_HEX): CC=$(BUILD_CC)
-$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
+$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
 $(BIN_TO_HEX): LDFLAGS=
 
 dist += util/Makefile util/bin-to-hex.c
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
