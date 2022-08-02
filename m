Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282DDC00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TV/o/9JgtqdBgwlYuMI226xiOhYhRXf98qns9/IGFWw=; b=UM8On611jQUiAX
	aNoIiVpq7k4TCk0jk3X3lEc/55oR1TA2kfh2yKR/dEa2BMHiTeIFwRjKgq4gfWSlY3FZNEJ0tq9cC
	djaNJr47qpKYIeqoCkZC50VJUkHBirYBSfGCbkL0OUVPKGw5Gc17/2v0xml5cMjWcEgoZDd6yAGvg
	aOVOU/1iLTyvuNjLc3Sos00liRNWHysfCHla/x2qptPSDWOFh25Xf4sI+LHqTTBxl/f95qbfoK39p
	i4IOGr4Wgf/n+cQmmNA8s4aJzEWuD4g7pmm8qjbLiPNCtYZHR0zeaTI7hj/rBp8u9zvIEDpXqIP0P
	fjKUk1tLCKO2QJfBw1ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIqrX-00DsZa-Lk; Tue, 02 Aug 2022 12:19:03 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIqr4-00Ds3x-Rz; Tue, 02 Aug 2022 12:18:37 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VLBjY2m_1659442709;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLBjY2m_1659442709)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 20:18:30 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	heiko@sntech.de,
	guoren@kernel.org,
	mick@ics.forth.gr,
	alexandre.ghiti@canonical.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	Conor.Dooley@microchip.com
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	huanyi.xj@alibaba-inc.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	yixun.lan@gmail.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V5 6/6] RISC-V: Fixup schedule out issue in machine_crash_shutdown()
Date: Tue,  2 Aug 2022 20:18:18 +0800
Message-Id: <20220802121818.2201268-7-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_051835_179192_869998F4 
X-CRM114-Status: GOOD (  10.39  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Fixup schedule out issue in machine_crash_shutdown(), which is triggered
by RCU Stall.

[224521.877268] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[224521.883471] rcu: 	0-...0: (3 GPs behind) idle=cfa/0/0x1 softirq=3968793/3968793 fqs=2495
[224521.891742] 	(detected by 2, t=5255 jiffies, g=60855593, q=328)
[224521.897754] Task dump for CPU 0:
[224521.901074] task:swapper/0       state:R  running task     stack:    0 pid:    0 ppid:     0 flags:0x00000008
[224521.911090] Call Trace:
[224521.913638] [<ffffffe000c432de>] __schedule+0x208/0x5ea
[224521.918957] Kernel panic - not syncing: RCU Stall
[224521.923773] bad: scheduling from the idle thread!
[224521.928571] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G           O      5.10.113-yocto-standard #1
[224521.938658] Call Trace:
[224521.941200] [<ffffffe00020395c>] walk_stackframe+0x0/0xaa
[224521.946689] [<ffffffe000c34f8e>] show_stack+0x32/0x3e
[224521.951830] [<ffffffe000c39020>] dump_stack_lvl+0x7e/0xa2
[224521.957317] [<ffffffe000c39058>] dump_stack+0x14/0x1c
[224521.962459] [<ffffffe000243884>] dequeue_task_idle+0x2c/0x40
[224521.968207] [<ffffffe000c434f4>] __schedule+0x41e/0x5ea
[224521.973520] [<ffffffe000c43826>] schedule+0x34/0xe4
[224521.978487] [<ffffffe000c46cae>] schedule_timeout+0xc6/0x170
[224521.984234] [<ffffffe000c4491e>] wait_for_completion+0x98/0xf2
[224521.990157] [<ffffffe00026d9e2>] __wait_rcu_gp+0x148/0x14a
[224521.995733] [<ffffffe0002761c4>] synchronize_rcu+0x5c/0x66
[224522.001307] [<ffffffe00026f1a6>] rcu_sync_enter+0x54/0xe6
[224522.006795] [<ffffffe00025a436>] percpu_down_write+0x32/0x11c
[224522.012629] [<ffffffe000c4266a>] _cpu_down+0x92/0x21a
[224522.017771] [<ffffffe000219a0a>] smp_shutdown_nonboot_cpus+0x90/0x118
[224522.024299] [<ffffffe00020701e>] machine_crash_shutdown+0x30/0x4a
[224522.030483] [<ffffffe00029a3f8>] __crash_kexec+0x62/0xa6
[224522.035884] [<ffffffe000c3515e>] panic+0xfa/0x2b6
[224522.040678] [<ffffffe0002772be>] rcu_sched_clock_irq+0xc26/0xcb8
[224522.046774] [<ffffffe00027fc7a>] update_process_times+0x62/0x8a
[224522.052785] [<ffffffe00028d522>] tick_sched_timer+0x9e/0x102
[224522.058533] [<ffffffe000280c3a>] __hrtimer_run_queues+0x16a/0x318
[224522.064716] [<ffffffe0002812ec>] hrtimer_interrupt+0xd4/0x228
[224522.070551] [<ffffffe0009a69b6>] riscv_timer_interrupt+0x3c/0x48
[224522.076646] [<ffffffe000268f8c>] handle_percpu_devid_irq+0xb0/0x24c
[224522.083004] [<ffffffe00026428e>] __handle_domain_irq+0xa8/0x122
[224522.089014] [<ffffffe00062f954>] riscv_intc_irq+0x38/0x60
[224522.094501] [<ffffffe000201bd4>] ret_from_exception+0x0/0xc
[224522.100161] [<ffffffe000c42146>] rcu_eqs_enter.constprop.0+0x8c/0xb8

With the patch, it can enter crash system when RCU Stall occur.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 86d1b5f9dfb5..ee79e6839b86 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -138,19 +138,37 @@ void machine_shutdown(void)
 #endif
 }
 
+/* Override the weak function in kernel/panic.c */
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	smp_send_stop();
+	cpus_stopped = 1;
+}
+
 /*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
  * This function is called by crash_kexec just before machine_kexec
- * below and its goal is similar to machine_shutdown, but in case of
- * a kernel crash. Since we don't handle such cases yet, this function
- * is empty.
+ * and its goal is to shutdown non-crashing cpus and save registers.
  */
 void
 machine_crash_shutdown(struct pt_regs *regs)
 {
+	local_irq_disable();
+
+	/* shutdown non-crashing cpus */
+	crash_smp_send_stop();
+
 	crash_save_cpu(regs, smp_processor_id());
-	machine_shutdown();
 	pr_info("Starting crashdump kernel...\n");
 }
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
