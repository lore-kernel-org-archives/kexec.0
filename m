Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <e52b39c76d2a967bdecc376daee07d6edd47b01a.1452884156.git.geoff@infradead.org>
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 19/19] arm64: kdump: relax BUG_ON() if more than one cpus are
 still active
Date: Fri, 15 Jan 2016 19:18:38 +0000
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

We should try best in case of kdump.
So even if not all secondary cpus have shut down, we do kdump anyway.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0ba2ae4..3230551 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -157,7 +157,7 @@ void machine_kexec(struct kimage *kimage)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	BUG_ON((num_online_cpus() > 1) && !WARN_ON(in_crash_kexec));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = kmap(kimage->control_code_page);
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
