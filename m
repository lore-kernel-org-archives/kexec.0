Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com
 ([157.56.110.118] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfj5-00018p-CZ
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:12 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 17/18] powerpc/book3e-64/kexec: Set "r4 = 0" when entering
 spinloop
Date: Tue, 6 Oct 2015 22:48:21 -0500
Message-ID: <1444189702-17241-18-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

book3e_secondary_core_init will only create a TLB entry if r4 = 0,
so do so.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/misc_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 246ad8c..ddbc535 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -485,6 +485,8 @@ _GLOBAL(kexec_wait)
 	mtsrr1	r11
 	rfid
 #else
+	/* Create TLB entry in book3e_secondary_core_init */
+	li	r4,0
 	ba	0x60
 #endif
 #endif
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
