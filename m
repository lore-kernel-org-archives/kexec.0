From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:09 -0300
Subject: [PATCH 15/30] bus: brcmstb_gisb: Clean-up panic/die notifiers
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-16-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This patch improves the panic/die notifiers in this driver by
making use of a passed "id" instead of comparing pointer
address; also, it removes an useless prototype declaration
and unnecessary header inclusion.

This is part of a panic notifiers refactor - this notifier in
the future will be moved to a new list, that encompass the
information notifiers only.

Fixes: 9eb60880d9a9 ("bus: brcmstb_gisb: add notifier handling")
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/bus/brcmstb_gisb.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 183d5cc37d42..1ea7b015e225 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -19,7 +19,6 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/kdebug.h>
-#include <linux/notifier.h>
 
 #ifdef CONFIG_MIPS
 #include <asm/traps.h>
@@ -347,25 +346,14 @@ static irqreturn_t brcmstb_gisb_bp_handler(int irq, void *dev_id)
 /*
  * Dump out gisb errors on die or panic.
  */
-static int dump_gisb_error(struct notifier_block *self, unsigned long v,
-			   void *p);
-
-static struct notifier_block gisb_die_notifier = {
-	.notifier_call = dump_gisb_error,
-};
-
-static struct notifier_block gisb_panic_notifier = {
-	.notifier_call = dump_gisb_error,
-};
-
 static int dump_gisb_error(struct notifier_block *self, unsigned long v,
 			   void *p)
 {
 	struct brcmstb_gisb_arb_device *gdev;
-	const char *reason = "panic";
+	const char *reason = "die";
 
-	if (self == &gisb_die_notifier)
-		reason = "die";
+	if (v == PANIC_NOTIFIER)
+		reason = "panic";
 
 	/* iterate over each GISB arb registered handlers */
 	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
@@ -374,6 +362,14 @@ static int dump_gisb_error(struct notifier_block *self, unsigned long v,
 	return NOTIFY_DONE;
 }
 
+static struct notifier_block gisb_die_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
+static struct notifier_block gisb_panic_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
 static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
 		gisb_arb_get_timeout, gisb_arb_set_timeout);
 
-- 
2.36.0


