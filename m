Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjB1y-0002H2-Mh
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 15:49:04 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 5/5] fix comment typo in locate_hole
Date: Thu, 13 Dec 2012 16:48:50 +0100
Message-Id: <1355413730-18190-5-git-send-email-olaf@aepfle.de>
In-Reply-To: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
References: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
Cc: Olaf Hering <olaf@aepfle.de>

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 8928be0..22229d8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -202,7 +202,7 @@ unsigned long locate_hole(struct kexec_info *info,
 		die("Invalid hole end argument of 0 specified to locate_hole");
 	}
 
-	/* Set an intial invalid value for the hole base */
+	/* Set an initial invalid value for the hole base */
 	hole_base = ULONG_MAX;
 
 	/* Align everything to at least a page size boundary */
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
