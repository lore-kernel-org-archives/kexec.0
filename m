Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E38DC00140
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BZSxvRkvZLc5fksdGXLZjgLfsnjtCK8OxJ7Merndr24=; b=1HLoafjBMsR6tu
	/HvxCEOoYC6aQbSPcFzGYmWkIbEA3ie/uwLH/v9Iw89v5R1rO8eICrmBp9OukJWvo1YgXzey8Sbqa
	i/lefp0afyFTw7+8je2kIthI6cHV/BB5DztA5nJtVbUVt3nEFbeRfY7nEZfOF1UdH/0Sm6mQnvz69
	JRoP/7qglEQfgjlhyxi5myck53r7cwpHkV97OTTfHoDl//+gHpnFqBjPd9G7WatiYK3PNC5PhEAuu
	o/ZSAeXXzKFjqRTgtN227ihltk7MehY++TxiyBTegAHBvs+eSIKqCYz9ODeCLvp8tPahwslJrAiPt
	k89QZVO2jh5vuWymrpWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq56-00D5om-0A; Wed, 24 Aug 2022 13:06:04 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPAKp-00CmpV-Bx; Fri, 19 Aug 2022 22:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=efMK60nr83yuRCx5Ljwx52Fk9k5SHvdIGer1v3Qxdhs=; b=SjQSOrdIC0PRcYZolS77irogck
	Mcx5v/0ZNaHxyEbxFL3onPgr5fMu09Pd2ybtyiuoazQiRcE4q1BCAdwvuZlYFgooxjD3BxoZoH4PK
	E/IlV6B+dBp+jSqRHfRRW0pIXAMZz1tIYerq39GhYuucnq6cSpZZ0C96yp+R/lJeJCEuPn+qomTxx
	BGxXGbnwkISEpDio7Vmfl6/6+0bvNYjEYtE6gc8UcjowEqH3UBtnvIUbDmL7qJyOrM5MVw4W2US5T
	3K1YJX1V/eWgE3S5pK2h+HxIYqHNfmis/7gh2PMnSysILIOzmrBUaMLqgXhAwCFkg2rzBmE/TgWP6
	uuEMeQ0Q==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAKN-00Casf-VT; Sat, 20 Aug 2022 00:18:59 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 01/11] ARM: Disable FIQs (but not IRQs) on CPUs shutdown paths
Date: Fri, 19 Aug 2022 19:17:21 -0300
Message-Id: <20220819221731.480795-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_151925_702305_47B24399 
X-CRM114-Status: GOOD (  14.21  )
X-Mailman-Approved-At: Wed, 24 Aug 2022 06:05:59 -0700
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, Marc Zyngier <maz@kernel.org>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, Russell King <linux@armlinux.org.uk>, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
is responsible for that. IRQs are architecturally masked when we
take an interrupt, but FIQs are high priority than IRQs, hence they
aren't masked. With that said, it makes sense to disable FIQs here,
but there's no need for (re-)disabling IRQs.

More than that: there is an alternative path for disabling CPUs,
in the form of function crash_smp_send_stop(), which is used for
kexec/panic path. This function relies on a SMP call that also
triggers a busy-wait loop [at machine_crash_nonpanic_core()], but
without disabling FIQs. This might lead to odd scenarios, like
early interrupts in the boot of kexec'd kernel or even interrupts
in secondary "disabled" CPUs while the main one still works in the
panic path and assumes all secondary CPUs are (really!) off.

So, let's disable FIQs in both paths and *not* disable IRQs a second
time, since they are already masked in both paths by the architecture.
This way, we keep both CPU quiesce paths consistent and safe.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- No changes.

V2:
- Small wording improvement (thanks Michael Kelley);
- Only disable FIQs, since IRQs are masked by architecture
definition when we take an interrupt. Thanks a lot Russell
and Marc for the discussion [0].

Should we add a Fixes tag here? If so, maybe the proper target is:
b23065313297 ("ARM: 6522/1: kexec: Add call to non-crashing cores through IPI")

[0] https://lore.kernel.org/lkml/Ymxcaqy6DwhoQrZT@shell.armlinux.org.uk/


 arch/arm/kernel/machine_kexec.c | 2 ++
 arch/arm/kernel/smp.c           | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..0b482bcb97f7 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -77,6 +77,8 @@ void machine_crash_nonpanic_core(void *unused)
 {
 	struct pt_regs regs;
 
+	local_fiq_disable();
+
 	crash_setup_regs(&regs, get_irq_regs());
 	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
 	       smp_processor_id());
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 978db2d96b44..36e6efad89f3 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -600,6 +600,8 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
+	local_fiq_disable();
+
 	if (system_state <= SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
@@ -609,9 +611,6 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	set_cpu_online(cpu, false);
 
-	local_fiq_disable();
-	local_irq_disable();
-
 	while (1) {
 		cpu_relax();
 		wfe();
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
