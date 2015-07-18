Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com
 ([157.56.110.135] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQT-0007mM-0I
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:38 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 03/17] crypto: caam: Blacklist CAAM when kexec is enabled
Date: Sat, 18 Jul 2015 15:08:40 -0500
Message-ID: <1437250134-307-4-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Cristian Stoica <cristian.stoica@freescale.com>, kexec@lists.infradead.org, linux-crypto@vger.kernel.org, Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, Horia Geanta <horia.geanta@freescale.com>

This driver hangs the kernel on boot when loaded via kexec.

To make this driver kexec-safe, add a suspend or freeze hook, and when
probing, don't make any assumptions about the existing hardware state
(e.g. don't request_irq before quiescing the device).

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Cristian Stoica <cristian.stoica@freescale.com>
Cc: Horia Geanta <horia.geanta@freescale.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
---
 drivers/crypto/caam/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index e286e28..310e9e0 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -1,6 +1,6 @@
 config CRYPTO_DEV_FSL_CAAM
 	tristate "Freescale CAAM-Multicore driver backend"
-	depends on FSL_SOC
+	depends on FSL_SOC && !KEXEC
 	help
 	  Enables the driver module for Freescale's Cryptographic Accelerator
 	  and Assurance Module (CAAM), also known as the SEC version 4 (SEC4).
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
