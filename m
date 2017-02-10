Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ccJYW-0003Vg-Ap
 for kexec@lists.infradead.org; Fri, 10 Feb 2017 22:20:42 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH] gitignore: add two generated files in purgatory
Date: Fri, 10 Feb 2017 16:20:05 -0600
Message-Id: <1486765205-14336-1-git-send-email-eric.devolder@oracle.com>
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
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

This patch adds the two generated files below to .gitignore.

purgatory/purgatory.map
purgatory/purgatory.ro.sym

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 81e03ab..1ab52d9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,5 @@
 /configure
 /include/config.h.in
 /include/config.h
+/purgatory/purgatory.map
+/purgatory/purgatory.ro.sym
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
