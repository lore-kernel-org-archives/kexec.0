From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:48:58 -0300
Subject: [PATCH 04/30] firmware: google: Convert regular spinlock into trylock
 on panic path
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-5-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently the gsmi driver registers a panic notifier as well as
reboot and die notifiers. The callbacks registered are called in
atomic and very limited context - for instance, panic disables
preemption, local IRQs and all other CPUs that aren't running the
current panic function.

With that said, taking a spinlock in this scenario is a
dangerous invitation for a deadlock scenario. So, we fix
that in this commit by changing the regular spinlock with
a trylock, which is a safer approach.

Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/google/gsmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..b01ed02e4a87 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -629,7 +629,10 @@ static int gsmi_shutdown_reason(int reason)
 	if (saved_reason & (1 << reason))
 		return 0;
 
-	spin_lock_irqsave(&gsmi_dev.lock, flags);
+	if (!spin_trylock_irqsave(&gsmi_dev.lock, flags)) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 	saved_reason |= (1 << reason);
 
@@ -646,6 +649,7 @@ static int gsmi_shutdown_reason(int reason)
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
+out:
 	if (rc < 0)
 		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
 	else
-- 
2.36.0


