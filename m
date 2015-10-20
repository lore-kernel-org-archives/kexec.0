Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoRpx-0005Dw-3r
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 08:00:01 +0000
Received: by padhk11 with SMTP id hk11so13983800pad.1
 for <kexec@lists.infradead.org>; Tue, 20 Oct 2015 00:59:40 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/2] fixup! arm64: kdump: implement machine_crash_shutdown()
Date: Tue, 20 Oct 2015 16:58:26 +0900
Message-Id: <1445327907-23274-2-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, geoff@infradead.org, marc.zyngier@arm.com
Cc: mark.rutland@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Without this patch, crash dump kernel won't be able to boot if a kvm
guest is running at crash. This is because we don't have any chance
to reset EL2 mode at crash and so "switch to EL2" in cpu_reset fails.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0edb7ee..d14dd05 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -271,7 +271,7 @@ static void soft_restart(unsigned long addr)
 {
 	setup_mm_for_reboot();
 	cpu_soft_restart(virt_to_phys(cpu_reset), addr,
-		is_hyp_mode_available());
+		(in_crash_kexec ? 0 : is_hyp_mode_available()));
 
 	BUG(); /* Should never get here. */
 }
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
