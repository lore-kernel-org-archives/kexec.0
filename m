Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdXsy-0007S9-6T
 for kexec@lists.infradead.org; Thu, 02 Apr 2015 05:41:49 +0000
Received: by padcy3 with SMTP id cy3so73924267pad.3
 for <kexec@lists.infradead.org>; Wed, 01 Apr 2015 22:41:26 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v3 4/5] arm64: kvm: add cpu reset at module exit
Date: Thu,  2 Apr 2015 14:40:15 +0900
Message-Id: <1427953216-11737-5-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, freddy77@gmail.com

This patch doesn't enable kvm to be built as a module, but is
a prerequisite when kvm is transformed to be module-capable.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4892974..85c142b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1178,6 +1178,12 @@ void kvm_arch_hardware_disable(void)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+
+	unregister_reboot_notifier(&kvm_reboot_nb);
+	/*
+	 * Reset each CPU in EL2 to initial state.
+	 */
+	on_each_cpu(kvm_cpu_reset, NULL, 1);
 }
 
 static int arm_init(void)
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
