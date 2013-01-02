Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Date: Wed,  2 Jan 2013 14:07:41 -0700
Message-Id: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Eric Biederman <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

On Tegra at least, this change allows kexec to work with SMP enabled.
Without this,  machine_shutdown() simply puts all CPUs into a loop. If
the code of that loop is over-written, the CPUs may hang or crash (which
I do observe in practice), or cause the kexec'd kernel not to be able to
initialize them.

This fix has the added benefit that the kexec always happens on the boot
CPU, and thus kexec mirrors the initial kernel boot as much as possible.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Russell, I assume this should go into the ARM patch tracker if OK?

 arch/arm/kernel/process.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f79dd1e..1893bda 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -239,6 +239,7 @@ __setup("reboot=", reboot_setup);
 
 void machine_shutdown(void)
 {
+	disable_nonboot_cpus();
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
