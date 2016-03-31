Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aleZM-0007hD-5b
 for kexec@lists.infradead.org; Thu, 31 Mar 2016 15:31:37 +0000
From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH 2/3] zImage-arm: Fix a return value check that use the wrong
 variable
Date: Thu, 31 Mar 2016 17:30:59 +0200
Message-Id: <1459438260-8205-2-git-send-email-alban.bedel@avionic-design.de>
In-Reply-To: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
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
To: kexec@lists.infradead.org
Cc: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>, horms@verge.net.au, Alban Bedel <alban.bedel@avionic-design.de>

When looking for a hole to put the initrd in the error check used the
wrong variable.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 78518fd..c436b83 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -530,7 +530,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			unsigned long initrd_base_new = locate_hole(info,
 					hole_size, page_size,
 					initrd_base, ULONG_MAX, INT_MAX);
-			if (base == ULONG_MAX)
+			if (initrd_base_new == ULONG_MAX)
 				return -1;
 			initrd_base = initrd_base_new;
 		}
-- 
2.8.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
