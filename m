Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <4cf0c03d6cd1cb4826bb5df679fbcdaf80be0b1c.1445297709.git.geoff@infradead.org>
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 16/16] arm64: kdump: relax BUG_ON() if more than one cpus are
 still active
Date: Mon, 19 Oct 2015 23:38:54 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, kexec@lists.infradead.org, Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

We should try best in case of kdump.
So even if not all secondary cpus have shut down, we do kdump anyway.
---
 arch/arm64/kernel/machine_kexec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f315ee4..157c29b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -139,7 +139,12 @@ void machine_kexec(struct kimage *image)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	if (num_online_cpus() > 1) {
+		if (in_crash_kexec)
+			pr_warn("*\n* kdump might fail because %d cpus are still online\n*\n", num_online_cpus());
+		else
+			BUG();
+	}
 
 	kimage_head = image->head;
 
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
