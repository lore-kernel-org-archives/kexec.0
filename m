From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:00 -0300
Subject: [PATCH 06/30] soc: bcm: brcmstb: Document panic notifier action and
 remove useless header
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-7-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The panic notifier of this driver is very simple code-wise, just a memory
write to a special position with some numeric code. But this is not clear
from the semantic point-of-view, and there is no public documentation
about that either.

After discussing this in the mailing-lists [0] and having Florian explained
it very well, this patch just document that in the code for the future
generations asking the same questions. Also, it removes a useless header.

[0] https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a at gmail.com

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Justin Chen <justinpopo6@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..870686ae042b 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -25,7 +25,6 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/panic_notifier.h>
@@ -664,7 +663,20 @@ static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
 
 	return of_io_request_and_map(dn, index, dn->full_name);
 }
-
+/*
+ * The AON is a small domain in the SoC that can retain its state across
+ * various system wide sleep states and specific reset conditions; the
+ * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
+ * persistent information across such events.
+ *
+ * The purpose of the below panic notifier is to help with notifying
+ * the bootloader that a panic occurred and so that it should try its
+ * best to preserve the DRAM contents holding that buffer for recovery
+ * by the kernel as opposed to wiping out DRAM clean again.
+ *
+ * Reference: comment from Florian Fainelli, at
+ * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
+ */
 static int brcmstb_pm_panic_notify(struct notifier_block *nb,
 		unsigned long action, void *data)
 {
-- 
2.36.0


