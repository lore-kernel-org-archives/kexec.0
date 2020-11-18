Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfEH2-0008TD-6D
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 03:36:49 +0000
Received: by mail-pl1-x641.google.com with SMTP id d17so247882plr.5
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 19:36:47 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 1/3] x86/irq: account the unused irq
Date: Wed, 18 Nov 2020 11:36:16 +0800
Message-Id: <1605670578-23681-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

Accounting the unused irq in order to count it if irq flood.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/irq.c       | 1 +
 include/linux/kernel_stat.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd503..6f583a7 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -254,6 +254,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
+			__this_cpu_inc(kstat.unused_irqs_sum);
 		} else {
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745..c8d5cb8 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -37,6 +37,7 @@ struct kernel_cpustat {
 
 struct kernel_stat {
 	unsigned long irqs_sum;
+	unsigned long unused_irqs_sum;
 	unsigned int softirqs[NR_SOFTIRQS];
 };
 
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
