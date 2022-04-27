From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:20 -0300
Subject: [PATCH 26/30] Drivers: hv: Do not force all panic notifiers to
 execute before kdump
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-27-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Since commit a11589563e96 ("x86/Hyper-V: Report crash register
data or kmsg before running crash kernel") Hyper-V forcibly sets
the kernel parameter "crash_kexec_post_notifiers"; with that, it
did enforce the execution of *all* panic notifiers before kdump.
The main reason behind that is that Hyper-V has an hypervisor
notification mechanism that has the ability of warning the
hypervisor when the guest panics.

Happens that after the panic notifiers refactor, we now have 3 lists
and a level mechanism that defines the ordering of the notifiers
execution with regards to kdump. And for Hyper-V, the specific
notifier to inform the hypervisor about a panic lies in the first
list, which *by default* is set to execute before kdump. Hence,
this patch removes the hardcoded setting, effectively reverting
the aforementioned commit.

One of the problems with the forced approach was greatly exposed by
commit d57d6fe5bf34 ("drivers: hv: log when enabling crash_kexec_post_notifiers")
which ended-up confusing the user that didn't expect the notifiers
to execute before kdump, since it's a user setting and wasn't
enabled by such user. With the patch hereby proposed, that kind
of issue doesn't happen anymore, the panic notifiers level is
well-documented and users can expect a predictable behavior.

Fixes: a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel")
Fixes: d57d6fe5bf34 ("drivers: hv: log when enabling crash_kexec_post_notifiers"
Cc: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Tested-by: Fabio A M Martins <fabiomirmar@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Special thanks to Michael Kelley for the good information about the Hyper-V
panic path in email threads some months ago, and to Fabio for the testing
performed.

 drivers/hv/hv_common.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..af59793de523 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -73,18 +73,6 @@ int __init hv_common_init(void)
 {
 	int i;
 
-	/*
-	 * Hyper-V expects to get crash register data or kmsg when
-	 * crash enlightment is available and system crashes. Set
-	 * crash_kexec_post_notifiers to be true to make sure that
-	 * calling crash enlightment interface before running kdump
-	 * kernel.
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		crash_kexec_post_notifiers = true;
-		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
-	}
-
 	/*
 	 * Allocate the per-CPU state for the hypercall input arg.
 	 * If this allocation fails, we will not be able to setup
-- 
2.36.0


