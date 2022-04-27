From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:01 -0300
Subject: [PATCH 07/30] mips: ip22: Reword PANICED to PANICKED and remove
 useless header
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-8-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Many other place in the kernel prefer the latter, so let's keep
it consistent in MIPS code as well. Also, removes a useless header.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/mips/sgi-ip22/ip22-reset.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 9028dbbb45dd..8f0861c58080 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/pm.h>
 #include <linux/timer.h>
@@ -41,7 +40,7 @@
 static struct timer_list power_timer, blink_timer, debounce_timer;
 static unsigned long blink_timer_timeout;
 
-#define MACHINE_PANICED		1
+#define MACHINE_PANICKED		1
 #define MACHINE_SHUTTING_DOWN	2
 
 static int machine_state;
@@ -112,7 +111,7 @@ static void debounce(struct timer_list *unused)
 		return;
 	}
 
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		sgimc->cpuctrl0 |= SGIMC_CCTRL0_SYSINIT;
 
 	enable_irq(SGI_PANEL_IRQ);
@@ -120,7 +119,7 @@ static void debounce(struct timer_list *unused)
 
 static inline void power_button(void)
 {
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		return;
 
 	if ((machine_state & MACHINE_SHUTTING_DOWN) ||
@@ -167,9 +166,9 @@ static irqreturn_t panel_int(int irq, void *dev_id)
 static int panic_event(struct notifier_block *this, unsigned long event,
 		      void *ptr)
 {
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		return NOTIFY_DONE;
-	machine_state |= MACHINE_PANICED;
+	machine_state |= MACHINE_PANICKED;
 
 	blink_timer_timeout = PANIC_FREQ;
 	blink_timeout(&blink_timer);
-- 
2.36.0


