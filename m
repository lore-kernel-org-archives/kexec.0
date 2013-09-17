Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gerard.telenet-ops.be ([195.130.132.48])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqnA-00076v-MH
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:37:53 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/4] cris: is_crashkernel_mem_reserved() should return 0
Date: Tue, 17 Sep 2013 10:37:10 +0200
Message-Id: <1379407031-5466-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
References: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
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

Cris doesn't have support for crash kernels yet.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kexec/arch/cris/kexec-cris.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 67fd156..4ac2f89 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -74,7 +74,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 
 int is_crashkernel_mem_reserved(void)
 {
-	return 1;
+	return 0;
 }
 
 unsigned long virt_to_phys(unsigned long addr)
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
