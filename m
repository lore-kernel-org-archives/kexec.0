Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from georges.telenet-ops.be ([195.130.137.68])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqn9-00076u-LH
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:37:52 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/4] .gitignore: Only ignore generated autotools files in the
 top directory
Date: Tue, 17 Sep 2013 10:37:08 +0200
Message-Id: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org

E.g. all other Makefiles are handmade, but git complains when adding a
new kexec/arch/*/Makefile file.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .gitignore |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index f382a0a..81e03ab 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,12 +8,12 @@
 *.ro
 
 # generated files
-Makefile
-autom4te.cache/
-bin/
-build/
-config.log
-config.status
-configure
-include/config.h.in
-include/config.h
+/Makefile
+/autom4te.cache/
+/bin/
+/build/
+/config.log
+/config.status
+/configure
+/include/config.h.in
+/include/config.h
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
