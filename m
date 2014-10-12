Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XdOxe-0005wG-4M
 for kexec@lists.infradead.org; Sun, 12 Oct 2014 19:37:47 +0000
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] kexec: distribute kexec/arch/m68k/bootinfo.h
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <1381859460-13645-4-git-send-email-geert@linux-m68k.org>
Date: Sun, 12 Oct 2014 21:37:17 +0200
In-Reply-To: <1381859460-13645-4-git-send-email-geert@linux-m68k.org> (Geert
 Uytterhoeven's message of "Tue, 15 Oct 2013 19:51:00 +0200")
Message-ID: <87tx39w042.fsf_-_@igel.home>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 kexec/arch/m68k/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/m68k/Makefile b/kexec/arch/m68k/Makefile
index 7b13564..eeaacbd 100644
--- a/kexec/arch/m68k/Makefile
+++ b/kexec/arch/m68k/Makefile
@@ -10,5 +10,6 @@ m68k_ADD_SEGMENT =
 m68k_VIRT_TO_PHYS =
 
 dist += kexec/arch/m68k/Makefile $(m68k_KEXEC_SRCS)			\
+	kexec/arch/m68k/bootinfo.h					\
 	kexec/arch/m68k/kexec-m68k.h					\
 	kexec/arch/m68k/include/arch/options.h
-- 
2.1.2

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
