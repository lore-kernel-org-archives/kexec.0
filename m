Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from master.debian.org ([2001:41b8:202:deb:216:36ff:fe40:4001])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdAuM-0006sO-Nt
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 04:05:11 +0000
From: Paul Wise <pabs3@bonedaddy.net>
Subject: [kexec-tools] [PATCH 1/2] Fix rebuilding the purgatory.c file.
Date: Thu, 24 Apr 2014 12:04:31 +0800
Message-Id: <1398312272-15634-1-git-send-email-pabs3@bonedaddy.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Paul Wise <pabs3@bonedaddy.net>

---
 kexec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/Makefile b/kexec/Makefile
index 7d3175b..62fecdb 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -1,7 +1,7 @@
 #
 # kexec (linux booting linux)
 #
-PURGATORY_HEX_C = kexec/purgatory.c
+PURGATORY_HEX_C = purgatory/purgatory.c
 
 $(PURGATORY_HEX_C): $(PURGATORY) $(BIN_TO_HEX)
 	$(MKDIR) -p $(@D)
-- 
1.9.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
