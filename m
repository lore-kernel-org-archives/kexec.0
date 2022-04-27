From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:21 -0300
Subject: [PATCH 27/30] powerpc: Do not force all panic notifiers to execute
 before kdump
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-28-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in
vmcore generated with panic") introduced a hardcoded setting of kernel
parameter "crash_kexec_post_notifiers", effectively forcing all the
panic notifiers to execute earlier in the panic path, before kdump.

The reason for that was a fadump issue on collecting data accurately,
due to smp_send_stop() setting all CPUs offline, so the net effect
desired with this change was to avoid calling the regular CPU
shutdown function, and instead rely on crash_smp_send_stop(), which
copes fine with fadump. The collateral effect was to increase the
risk for kdump if fadump is not used, since it forces all panic
notifiers to execute early, before kdump.

Happens that, after a panic refactor, crash_smp_send_stop() is
now used by default in the panic path, so there is no reason to
mess with the notifiers ordering (which was also improved in the
refactor) from within arch code.

Fixes: 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

We'd like to thanks specially the MiniCloud infrastructure [0] maintainers,
that allow us to test PowerPC code in a very complete, functional and FREE
environment.

[0] https://openpower.ic.unicamp.br/minicloud

 arch/powerpc/kernel/fadump.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 65562c4a0a69..35ae8c09af66 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1649,14 +1649,6 @@ int __init setup_fadump(void)
 		register_fadump();
 	}
 
-	/*
-	 * In case of panic, fadump is triggered via ppc_panic_event()
-	 * panic notifier. Setting crash_kexec_post_notifiers to 'true'
-	 * lets panic() function take crash friendly path before panic
-	 * notifiers are invoked.
-	 */
-	crash_kexec_post_notifiers = true;
-
 	return 1;
 }
 /*
-- 
2.36.0


