Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cYGR3-0005Q2-1V
 for kexec@lists.infradead.org; Mon, 30 Jan 2017 18:12:14 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH 1/2] purgatory: Add purgatory.map and purgatory.ro.sym to
 clean recipe
Date: Mon, 30 Jan 2017 12:14:24 -0600
Message-Id: <1485800065-1573-2-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1485800065-1573-1-git-send-email-eric.devolder@oracle.com>
References: <1485800065-1573-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 328904e..49ce80a 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -34,7 +34,7 @@ PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
 PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
 PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
 
-clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
+clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY) $(PURGATORY_MAP) $(PURGATORY).sym
 
 -include $(PURGATORY_DEPS)
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
