Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHc-0001Zk-Le
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:58:53 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 01/14] purgatory: Add purgatory.map and purgatory.ro.sym to
 clean recipe
Date: Tue,  8 Dec 2015 22:57:34 +0100
Message-Id: <1449611867-15672-2-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 purgatory/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 2b5c061..caea7ea 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -33,7 +33,7 @@ PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
 PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
 PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
 
-clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
+clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY) $(PURGATORY_MAP) $(PURGATORY).sym
 
 -include $(PURGATORY_DEPS)
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
