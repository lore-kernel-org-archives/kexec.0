Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxhGj-0005CP-Gq
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 21:22:26 +0000
Received: by mail-pf0-x244.google.com with SMTP id r16so9574409pfg.3
 for <kexec@lists.infradead.org>; Fri, 21 Oct 2016 14:22:06 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 2/2] net: dsa: bcm_sf2: Do not rely on kexec_in_progress
Date: Fri, 21 Oct 2016 14:21:56 -0700
Message-Id: <1477084916-26327-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1477084916-26327-1-git-send-email-f.fainelli@gmail.com>
References: <1477084916-26327-1-git-send-email-f.fainelli@gmail.com>
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
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, ebiederm@xmission.com, kexec@lists.infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org

After discussing with Eric, it turns out that, while using
kexec_in_progress is a nice optimization, which prevents us from always
powering on the integrated PHY, let's just turn it on in the shutdown
path.

This removes a dependency on kexec_in_progress which, according to Eric
should not be used by modules

Fixes: 2399d6143f85 ("net: dsa: bcm_sf2: Prevent GPHY shutdown for kexec'd kernels")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 077a24541584..e3ee27ce13dd 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -30,7 +30,6 @@
 #include <linux/etherdevice.h>
 #include <net/switchdev.h>
 #include <linux/platform_data/b53.h>
-#include <linux/kexec.h>
 
 #include "bcm_sf2.h"
 #include "bcm_sf2_regs.h"
@@ -1141,9 +1140,11 @@ static void bcm_sf2_sw_shutdown(struct platform_device *pdev)
 	/* For a kernel about to be kexec'd we want to keep the GPHY on for a
 	 * successful MDIO bus scan to occur. If we did turn off the GPHY
 	 * before (e.g: port_disable), this will also power it back on.
+	 *
+	 * Do not rely on kexec_in_progress, just power the PHY on.
 	 */
 	if (priv->hw_params.num_gphy == 1)
-		bcm_sf2_gphy_enable_set(priv->dev->ds, kexec_in_progress);
+		bcm_sf2_gphy_enable_set(priv->dev->ds, true);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
